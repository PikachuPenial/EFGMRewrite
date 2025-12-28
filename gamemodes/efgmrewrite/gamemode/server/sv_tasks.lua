
util.AddNetworkString("TaskPay")
util.AddNetworkString("TaskGiveItem")
util.AddNetworkString("TaskAccept")
util.AddNetworkString("TaskTryComplete")

util.AddNetworkString("TaskRequestAll")
util.AddNetworkString("TaskSendAll")

util.AddNetworkString("SendNotification")

-- Network Utils

    function UpdateTaskString(ply)

        local taskStr = util.TableToJSON(ply.tasks)
        taskStr = util.Compress(taskStr)
        taskStr = util.Base64Encode(taskStr, true)
        ply.taskStr = taskStr

    end

-- Notification functions

    local function NotifyTaskAccept(ply, taskName)

        net.Start("SendNotification", false)
        net.WriteString("Task " .. taskName .. " accepted!")
        net.WriteString("icons/task_add_icon.png")
        net.WriteString("storytask_started.wav")
        net.Send(ply)

    end

    local function NotifyQuestItemPickup(ply, itemName)

        net.Start("SendNotification", false)
        net.WriteString(itemName .. " picked up, and will be lost on death!")
        net.WriteString("icons/inventory_icon.png")
        net.WriteString("subtaskcomplete.wav")
        net.Send(ply)

    end

    local function NotifyObjectiveComplete(ply, taskName)

        net.Start("SendNotification", false)
        net.WriteString("Objective for " .. taskName .. " completed!")
        net.WriteString("icons/task_add_icon.png")
        net.WriteString("subtaskcomplete.wav")
        net.Send(ply)

    end

    local function NotifyTaskPendingComplete(ply, taskName)

        net.Start("SendNotification", false)
        net.WriteString("Task " .. taskName .. " finished, completion pending!")
        net.WriteString("icons/task_finished_icon.png")
        net.WriteString("taskfinished.wav")
        net.Send(ply)

    end

    local function NotifyTaskComplete(ply, taskName)

        net.Start("SendNotification", false)
        net.WriteString("Completed task " .. taskName .. "!")
        net.WriteString("icons/task_complete_icon.png")
        net.WriteString("taskcomplete.wav")
        net.Send(ply)

    end

-- Task Objective Progression

    function TaskProgressObjectivesFromTable(ply, objTable, count)

        if objTable == nil then return end

        -- objTable[taskName] = {objIndex, objIndex, ...}

        for taskName, taskObjectives in pairs(objTable) do

            local taskInfo = EFGMTASKS[taskName]

            for _, objIndex in ipairs(taskObjectives) do

                local objInfo = taskInfo.objectives[objIndex]
                
                if objInfo.whenToSave == SAVEON.Progress then
                        
                    if ply.tasks[taskName].progress[objIndex] + count < (objInfo.count or 1) then

                        ply.tasks[taskName].progress[objIndex] = ply.tasks[taskName].progress[objIndex] + count

                    elseif ply.tasks[taskName].progress[objIndex] + count >= (objInfo.count or 1) then

                        ply.tasks[taskName].progress[objIndex] = (objInfo.count or 1)

                        NotifyObjectiveComplete(ply, taskName)

                        TaskCheckComplete(ply, taskName)
                        
                    end

                else

                    if ply.tasks[taskName].progress[objIndex] + ply.tasks[taskName].tempProgress[objIndex] + count < (objInfo.count or 1) then

                        ply.tasks[taskName].tempProgress[objIndex] = ply.tasks[taskName].tempProgress[objIndex] + count

                    elseif ply.tasks[taskName].progress[objIndex] + ply.tasks[taskName].tempProgress[objIndex] + count >= (objInfo.count or 1) then

                        ply.tasks[taskName].tempProgress[objIndex] = (objInfo.count or 1) - ply.tasks[taskName].progress[objIndex]

                        if objInfo.type == OBJECTIVE.QuestItem then NotifyQuestItemPickup(ply, EFGMQUESTITEM[objInfo.itemName].name) end

                        TaskCheckComplete(ply, taskName)

                    end

                end

            end
            
        end

    end

    function TaskProgressObjectivesSpecific(ply, taskName, objIndex, count)

        local taskInfo = EFGMTASKS[taskName]

        if taskInfo == nil then return end

        local objInfo = taskInfo.objectives[objIndex]

        if objInfo == nil then return end

        local canProgress = false

        if objInfo.type == OBJECTIVE.Pay then

            canProgress = TaskCheckCanProgressPay(ply, taskName, objIndex, count)

        elseif objInfo.type == OBJECTIVE.GiveItem then

            canProgress = TaskCheckCanProgressGiveItem(ply, taskName, objIndex, count)

        else return end

        if !canProgress then return end

    end

-- Task Check Can Progress Objective

    function TaskCheckCanProgressPay(ply, objInfo, count)

        return false

    end

    function TaskCheckCanProgressGiveItem(ply, taskName, objIndex, count)

        return false

    end

-- Task Temporary Progression Helpers

    function TaskTempProgressWipeAll(ply)

    end

    function TaskTempProgressSaveAll(ply, progressType)

    end

-- Task Completion

    function TaskCheckComplete(ply, taskName)

        local taskInfo = EFGMTASKS[taskName or nil]

        if taskInfo == nil or table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.InProgress then return end

        for objIndex, objInfo in ipairs(taskInfo.objectives) do

            if ply.tasks[taskName].progress[objIndex] < (objInfo.count or 1) then return end

        end

        hook.Run("efgm_task_" .. TASKSTATUS.CompletePending, ply, taskName)

        ply.tasks[taskName].status = TASKSTATUS.CompletePending

        NotifyTaskPendingComplete(ply, taskInfo.name)

    end

    function TaskDoComplete(ply, taskName)

        ply.tasks[taskName].status = TASKSTATUS.Complete

        taskInfo = EFGMTASKS[taskName]

        for rewardIndex, rewardInfo in ipairs(taskInfo.rewards) do

            if rewardInfo.type == REWARD.PlayerStat and rewardInfo.info == "Experience" then

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

        end

        NotifyTaskComplete(ply, taskInfo.name)

        TaskUpdate(ply)

    end

-- Task Assignment and Updating

    function TaskUpdate(ply)

        local tasksToAssign = TaskGetNewAvailable(ply)

        if tasksToAssign == nil then return end

        TaskAssignFromTable(ply, tasksToAssign)

        -- removes nonexistent tasks

        for taskName, taskInstance in pairs(ply.tasks) do
            
            local taskInfo = EFGMTASKS[taskName]

            if taskInfo == nil then
                
                ply.tasks[taskName] = nil

            else
                
                TaskCheckComplete(ply, taskName)

            end

        end

    end

    function TaskAssignFromTable(ply, tasksToAssign)

        for k, taskName in ipairs(tasksToAssign) do

            ply.tasks[taskName] = TASK.Instantiate(taskName)
            
        end

    end

    function TaskGetNewAvailable(ply)

        local tasksToAssign = {}

        for taskName, taskInfo in pairs(EFGMTASKS) do

            if taskInfo.requirements == nil then -- no requirements

                table.insert(tasksToAssign, taskName)

            else

                local doAssignTask = true

                if ply.tasks[taskName] == nil then

                    for reqIndex, reqInfo in ipairs(taskInfo.requirements) do

                        if reqInfo.type == REQUIREMENT.QuestCompletion and (table.IsEmpty(ply.tasks) or ply.tasks[reqInfo.info] == nil or ply.tasks[reqInfo.info].status != TASKSTATUS.Complete) then

                            doAssignTask = false

                        elseif reqInfo.type == REQUIREMENT.PlayerStat and ply:GetNWInt(reqInfo.info, 1) < reqInfo.count then

                            doAssignTask = false

                        end

                    end

                else

                    doAssignTask = false

                end

                if doAssignTask then

                    table.insert(tasksToAssign, taskName)

                end

            end

        end

        if table.IsEmpty(tasksToAssign) then return nil end

        return tasksToAssign

    end

-- Task Objective Getters

    -- theres probably a less repetitive way to do this but what even is technical debt anyway

    function TaskGetAllUnfinishedKillObjectives(ply, mapName, areaName, weapon, range, wasHeadshot)

        local objTable = {}

        for taskName, taskInstance in pairs(ply.tasks) do
            
            if taskInstance.status == TASKSTATUS.InProgress then

                print("task "..taskName.. " in progress")

                local taskInfo = EFGMTASKS[taskName]

                for objIndex, obj in ipairs(taskInfo.objectives) do

                    -- im geniunely sorry for this

                    if obj.type == OBJECTIVE.Kill and
                    obj.mapName == mapName and 
                        (obj.weapon == nil or 
                        obj.useCategory == nil and obj.weapon == weapon or 
                        obj.useCategory != nil and EFGMITEMS[weapon].displayType == weapon) and 
                    (obj.minRange == nil or obj.minRange <= range) and 
                    (obj.maxRange == nil or obj.maxRange >= range) and 
                    (obj.reqHeadshot == nil or wasHeadshot) and
                    (obj.count or 1 > taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex]) then

                        print("counting objective")
                        
                        objTable[taskName] = objTable[taskName] or {}
                        table.insert(objTable[taskName], objIndex)

                    end
                    
                end

            end

        end

        if table.IsEmpty(objTable) then return nil end

        return objTable

    end

    function TaskGetAllUnfinishedExtractObjectives(ply, mapName, extractName)

        local objTable = {}

        for taskName, taskInstance in pairs(ply.tasks) do
            
            if taskInstance.status == TASKSTATUS.InProgress then

                print("task "..taskName.. " in progress")

                local taskInfo = EFGMTASKS[taskName]

                for objIndex, obj in ipairs(taskInfo.objectives) do

                    if obj.type == OBJECTIVE.Extract and
                    obj.mapName == mapName and 
                    obj.extractName == extractName and
                    (obj.count or 1 > taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex]) then
                        
                        print("counting objective")
                        
                        objTable[taskName] = objTable[taskName] or {}
                        table.insert(objTable[taskName], objIndex)

                    end
                    
                end

            end

        end

        if table.IsEmpty(objTable) then return nil end

        return objTable

    end

    function TaskGetAllUnfinishedQuestItemObjectives(ply, itemName)

        local objTable = {}

        for taskName, taskInstance in pairs(ply.tasks) do
            
            if taskInstance.status == TASKSTATUS.InProgress then

                print("task "..taskName.. " in progress")

                local taskInfo = EFGMTASKS[taskName]

                for objIndex, obj in ipairs(taskInfo.objectives) do

                    if obj.type == OBJECTIVE.QuestItem and
                    obj.itemName == itemName and
                    (1 > taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex]) then
                        
                        print("counting objective")
                        
                        objTable[taskName] = objTable[taskName] or {}
                        table.insert(objTable[taskName], objIndex)

                    end
                    
                end

            end

        end

        if table.IsEmpty(objTable) then return nil end

        return objTable

    end

    function TaskGetAllUnfinishedVisitAreaObjectives(ply, mapName, areaName)

        local objTable = {}

        for taskName, taskInstance in pairs(ply.tasks) do
            
            if taskInstance.status == TASKSTATUS.InProgress then

                print("task "..taskName.. " in progress")

                local taskInfo = EFGMTASKS[taskName]

                for objIndex, obj in ipairs(taskInfo.objectives) do

                    if obj.type == OBJECTIVE.VisitArea and
                    obj.mapName == mapName and 
                    obj.areaName == areaName and
                    (1 > taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex]) then
                        
                        print("counting objective")
                        
                        objTable[taskName] = objTable[taskName] or {}
                        table.insert(objTable[taskName], objIndex)

                    end
                    
                end

            end

        end

        if table.IsEmpty(objTable) then return nil end

        return objTable

    end

-- Passive Progression hooks

    hook.Add("PlayerDeath", "TaskKill", function(victim, inflictor, attacker)

        if victim:IsPlayer() and !victim:CompareStatus(0) and !victim:CompareStatus(3) then

            TaskTempProgressWipeAll(victim)

        end

        if victim == attacker or !attacker:IsPlayer() then return end

        -- TODO: Add support for areas later
        local objectivesToProgress = TaskGetAllUnfinishedKillObjectives(attacker, game.GetMap(), nil, nil, attacker:GetPos():Distance( victim:GetPos() ), false)
        TaskProgressObjectivesFromTable(attacker, objectivesToProgress, 1)

    end)

    hook.Add("PlayerExtraction", "TaskExtract", function(ply, extractTime, isGuranteed, internalName)

        local objectivesToProgress = TaskGetAllUnfinishedExtractObjectives(ply, game.GetMap(), internalName)
        TaskProgressObjectivesFromTable(ply, objectivesToProgress, 1)

        TaskTempProgressSaveAll(ply, SAVEON.Extract)

        TaskUpdate(ply)

    end)

    hook.Add("TaskQuestItemPickup", "TaskAddQuestItem", function(ply, item)

        local objectivesToProgress = TaskGetAllUnfinishedQuestItemObjectives(ply, item)
        TaskProgressObjectivesFromTable(ply, objectivesToProgress, 1)

    end)

    hook.Add("TaskAreaVisited", "TaskAddVisitedArea", function(ply, areaName)

        local objectivesToProgress = TaskGetAllUnfinishedVisitAreaObjectives(ply, game.GetMap(), areaName)
        TaskProgressObjectivesFromTable(ply, objectivesToProgress, 1)

    end)

-- Task Progression Network Messages

    -- TODO: Make this accept items and like, yk, check them
    net.Receive("TaskGiveItem", function(len, ply)

        local taskName = net.ReadString()
        local itemIndex = net.ReadUInt(32)

        -- logic later

        net.Start("SendNotification", false)
        net.WriteString("Giving items isn't supported yet lmao")
        net.WriteString("icons/skills/charisma.png")
        net.WriteString("extract_failed.wav")
        net.Send(ply)

    end)

    net.Receive("TaskPay", function(len, ply)

        local taskName = net.ReadString()
        local amount = net.ReadUInt(32)

        -- if ply:GetNWInt("Money", 0) < amount then return end

        -- TaskProgressObjective(ply, OBJECTIVE.Pay, amount, nil, nil, taskName)

        net.Start("SendNotification", false)
        net.WriteString("Paying rubles to tasks isn't supported yet lmao")
        net.WriteString("icons/skills/charisma.png")
        net.WriteString("extract_failed.wav")
        net.Send(ply)

    end)

-- Task Status Network Messages

    net.Receive("TaskAccept", function(len, ply)

        local taskName = net.ReadString()

        if table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.AcceptPending then return end

        ply.tasks[taskName].status = TASKSTATUS.InProgress

    end)

    net.Receive("TaskTryComplete", function(len, ply)

        local taskName = net.ReadString()

        if table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.CompletePending then return end

        TaskDoComplete(ply, taskName)

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

                TaskTempProgressWipeAll(victim)

            end

            if victim == attacker or !attacker:IsPlayer() then return end

            -- TODO: Add support for areas later
            local objectivesToProgress = TaskGetAllUnfinishedKillObjectives(attacker, game.GetMap(), nil, nil, attacker:GetPos():Distance( victim:GetPos() ), false)
            TaskProgressObjectivesFromTable(attacker, objectivesToProgress, 1)

        end)

        function PrintTaskString(ply)

            UpdateTaskString(ply)
            print(ply.taskStr)

        end
        concommand.Add("efgm_debug_printtaskstring", function(ply, cmd, args) PrintEquippedString(ply) end)

    end