
util.AddNetworkString("TaskPay")
util.AddNetworkString("TaskGiveItem")
util.AddNetworkString("TaskAccept")
util.AddNetworkString("TaskTryComplete")

util.AddNetworkString("TaskRequestAll")
util.AddNetworkString("TaskSendAll")

util.AddNetworkString("SendNotification")

-- Task shit

function UpdateTaskString(ply)

    local taskStr = util.TableToJSON(ply.tasks)
    taskStr = util.Compress(taskStr)
    taskStr = util.Base64Encode(taskStr, true)
    ply.taskStr = taskStr

end

function CheckTaskCompletion(ply, taskName)

    -- PrintTable(ply.tasks)

    local taskInfo = EFGMTASKS[taskName or nil]

    if taskInfo == nil or table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.InProgress then return end

    for objIndex, objInfo in ipairs(taskInfo.objectives) do

        if ply.tasks[taskName].progress[objIndex] < objInfo.count then return end

    end

    hook.Run("efgm_task_" .. TASKSTATUS.CompletePending, ply, taskName)

    ply.tasks[taskName].status = TASKSTATUS.CompletePending

    UpdateTasks(ply)

    net.Start("SendNotification", false)
    net.WriteString("Task " .. taskInfo.name .. " finished, completion pending!")
    net.WriteString("icons/task_finished_icon.png")
    net.WriteString("taskfinished.wav")
    net.Send(ply)

end

function UpdateTasks(ply)

    for taskName, taskInfo in pairs(EFGMTASKS) do

        if taskInfo.requirements == nil then -- no requirements

            AssignTask(ply, taskName)

        else

            local doAssignTask = true

            for reqIndex, reqInfo in ipairs(taskInfo.requirements) do

                if reqInfo.type == REQUIREMENT.QuestCompletion and (table.IsEmpty(ply.tasks) or ply.tasks[reqInfo.info] == nil or ply.tasks[reqInfo.info].status != TASKSTATUS.Complete) then

                    doAssignTask = false

                elseif reqInfo.type == REQUIREMENT.PlayerStat and ply:GetNWInt(reqInfo.info, 1) < reqInfo.count then

                    doAssignTask = false

                end

                -- TODO: Other requirement types like skill

            end

            if doAssignTask then AssignTask(ply, taskName) end

        end

    end

    net.Start("TaskSendAll")
    net.WriteTable(ply.tasks)
    net.Send(ply)

end

function AssignTask(ply, taskName)

    if !table.IsEmpty( ply.tasks ) and ply.tasks[taskName] != nil then return end

    ply.tasks[taskName] = TASK.Instantiate(taskName)

end

function CompleteTask(ply, taskName)

    ply.tasks[taskName].status = TASKSTATUS.Complete

    taskInfo = EFGMTASKS[taskName]

    for rewardIndex, rewardInfo in ipairs(taskInfo.rewards) do

        if rewardInfo.type == REWARD.PlayerStat && rewardInfo.info == "Experience" then

            local exp = rewardInfo.count

            ply:SetNWInt("Experience", ply:GetNWInt("Experience", 0) + exp)

            local curExp = ply:GetNWInt("Experience")
            local curLvl = ply:GetNWInt("Level")

            while (curExp >= ply:GetNWInt("ExperienceToNextLevel")) do

                curExp = curExp - ply:GetNWInt("ExperienceToNextLevel")
                ply:SetNWInt("Level", curLvl + 1)
                ply:SetNWInt("Experience", curExp)

                for k, v in ipairs(levelArray) do

                    if (curLvl + 1) == k then ply:SetNWInt("ExperienceToNextLevel", v) end

                end

            end

        elseif rewardInfo.type == REWARD.PlayerStat then

            ply:SetNWInt(rewardInfo.info, ply:GetNWInt(rewardInfo.info) + rewardInfo.count)

        end

        -- TODO: Add support for other reward types

    end

    net.Start("SendNotification", false)
    net.WriteString("Completed task " .. taskInfo.name .. "!")
    net.WriteString("icons/task_complete_icon.png")
    net.WriteString("taskcomplete.wav")
    net.Send(ply)

    UpdateTasks(ply)

end

local function TaskObjectiveComplete(ply, taskName)

    net.Start("SendNotification", false)
    net.WriteString("Objective for " .. EFGMTASKS[taskName].name .. " completed!")
    net.WriteString("icons/task_add_icon.png")
    net.WriteString("storytask_started.wav")
    net.Send(ply)

    CheckTaskCompletion(ply, taskName)

end


-- TODO: FINISH THIS
function TaskProgressObjective(ply, progressObjType, count, info, subInfo, taskName)

    if !ply:IsPlayer() or table.IsEmpty(ply.tasks) then return end

    -- handling specific objectives
    if (progressObjType == OBJECTIVE.Pay or progressObjType == OBJECTIVE.GiveItem) && taskName != nil then
        
        return

    end

    for taskName, taskInstance in pairs(ply.tasks) do

        if taskInstance.status == TASKSTATUS.InProgress then

            local taskInfo = EFGMTASKS[taskName]

            for objIndex, objInfo in ipairs(taskInfo.objectives) do

                if objInfo.type == progressObjType && (objInfo.info == nil or objInfo.info == info) && (objInfo.subInfo == nil or objInfo.subInfo == subInfo) && taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex] < objInfo.count then

                    if objInfo.whenToSave == SAVEON.Progress then
                        
                        if taskInstance.progress[objIndex] + count < objInfo.count then

                            ply.tasks[taskName].progress[objIndex] = taskInstance.progress[objIndex] + count

                        elseif taskInstance.progress[objIndex] + count == objInfo.count then

                            ply.tasks[taskName].progress[objIndex] = objInfo.count

                            TaskObjectiveComplete(ply, taskName)
                            
                        end

                    else

                        if taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex] + count < objInfo.count then

                            ply.tasks[taskName].tempProgress[objIndex] = taskInstance.tempProgress[objIndex] + count

                        elseif taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex] + count == objInfo.count then

                            ply.tasks[taskName].tempProgress[objIndex] = objInfo.count - ply.tasks[taskName].progress[objIndex]

                            if progressObjType == OBJECTIVE.QuestItem then

                                net.Start("SendNotification", false)
                                net.WriteString(EFGMQUESTITEM[subInfo].name .. " picked up, and will be lost on death!")
                                net.WriteString("icons/inventory_icon.png")
                                net.WriteString("subtaskcomplete.wav")
                                net.Send(ply)

                            end

                        end

                    end

                end

            end

        end

    end

end

local function TaskWipeTempObjectives(ply)

    for taskName, taskInstance in pairs(ply.tasks) do
        
        for k, v in ipairs(taskInstance.tempProgress) do
            
            ply.tasks[taskName].tempProgress[k] = 0
            
        end

    end

end

local function TaskCountTempObjectives(ply, saveOnType)

    for taskName, taskInstance in pairs(ply.tasks) do

        local taskInfo = EFGMTASKS[taskName]

        for objIndex, objInfo in ipairs(taskInfo.objectives) do
            
            if objInfo.whenToSave == saveOnType && taskInstance.progress[objIndex] < objInfo.count then
                
                ply.tasks[taskName].progress[objIndex] = math.Clamp(taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex], 0, objInfo.count)
                ply.tasks[taskName].tempProgress[objIndex] = 0

                if ply.tasks[taskName].progress[objIndex] >= objInfo.count then

                    TaskObjectiveComplete(ply, taskName)
                    
                end

            end
            
        end

    end

end

-- Progression hooks

hook.Add("PlayerDeath", "TaskKill", function(victim, inflictor, attacker)

    if victim:IsPlayer() and !victim:CompareStatus(0) then

        TaskWipeTempObjectives(victim)

    end

    if victim == attacker or !attacker:IsPlayer() then return end

    -- TODO: Add support for areas later
    TaskProgressObjective(attacker, OBJECTIVE.Kill, 1, game.GetMap())

end)

hook.Add("PlayerExtraction", "TaskExtract", function(ply, extractTime, isGuranteed, internalName)

    TaskProgressObjective(ply, OBJECTIVE.Extract, 1, game.GetMap(), internalName)

    TaskCountTempObjectives(ply, SAVEON.Extract)

end)

hook.Add("TaskQuestItemPickup", "TaskAddQuestItem", function(ply, item)

    TaskProgressObjective(ply, OBJECTIVE.QuestItem, 1, game.GetMap(), item)

    net.Start("TaskSendAll")
    net.WriteTable(ply.tasks)
    net.Send(ply)

end)

hook.Add("TaskAreaVisited", "TaskAddVisitedArea", function(ply, areaName)

    TaskProgressObjective(ply, OBJECTIVE.VisitArea, 1, game.GetMap(), areaName)

end)

-- TODO: Make this accept items and like, yk, check them

net.Receive("TaskGiveItem", function(len, ply)

    local taskName = net.ReadString()
    local itemIndex = net.ReadUInt(32)

    -- logic later

    -- TaskProgressObjective(ply, OBJECTIVE.GiveItem, 1, game.GetMap(), areaName)

end)

net.Receive("TaskPay", function(len, ply)

    local taskName = net.ReadString()
    local amount = net.ReadUInt(32)

    TaskProgressObjective(ply, OBJECTIVE.Pay, amount, nil, nil, taskName)

end)

net.Receive("TaskAccept", function(len, ply)

    local taskName = net.ReadString()

    if table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.AcceptPending then return end

    ply.tasks[taskName].status = TASKSTATUS.InProgress

    net.Start("SendNotification", false)
    net.WriteString("Task " .. EFGMTASKS[taskName].name .. " accepted!")
    net.WriteString("icons/task_add_icon.png")
    net.WriteString("storytask_started.wav")
    net.Send(ply)

end)

net.Receive("TaskTryComplete", function(len, ply)

    local taskName = net.ReadString()

    if table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.CompletePending then return end

    CompleteTask(ply, taskName)

end)

net.Receive("TaskRequestAll", function(len, ply)

    net.Start("TaskSendAll")
    net.WriteTable(ply.tasks)
    net.Send(ply)

end)

-- Debugging

if GetConVar("efgm_derivesbox"):GetInt() == 1 then

    hook.Add("OnNPCKilled", "TaskKill", function(victim, attacker, inflictor)

        if victim:IsPlayer() then

            TaskWipeTempObjectives(victim)

        end

        if victim == attacker or !attacker:IsPlayer() then return end

        -- TODO: Add support for areas later
        TaskProgressObjective(attacker, OBJECTIVE.Kill, 1, game.GetMap())

    end)

    function PrintTaskString(ply)

        UpdateTaskString(ply)
        print(ply.taskStr)

    end
    concommand.Add("efgm_debug_printtaskstring", function(ply, cmd, args) PrintEquippedString(ply) end)

end