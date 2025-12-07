
util.AddNetworkString("TaskPay")
util.AddNetworkString("TaskGiveItem")
util.AddNetworkString("TaskAccept")
util.AddNetworkString("TaskTryComplete")

util.AddNetworkString("TaskRequestAll")
util.AddNetworkString("TaskSendAll")

util.AddNetworkString("SendNotification")

-- -- Task shit

-- function CheckTaskCompletion(ply, taskName)

--     PrintTable(ply.tasks)

--     local info = EFGMTASKS[taskName or nil]

--     if info == nil or table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.InProgress then return end

--     for objIndex, objType in ipairs(info.objectiveTypes) do

--         -- PrintTable(info)

--         if (objType == OBJECTIVE.Pay) && info.objectives[objIndex] > ply.tasks[taskName].progress[objIndex] then

--             print("progression "..objIndex.." ain't complete yet")

--             return

--         elseif (objType == OBJECTIVE.Extract or objType == OBJECTIVE.GiveItem or objType == OBJECTIVE.Kill) && info.objectives[objIndex][1] > ply.tasks[taskName].progress[objIndex] then

--             print(info.objectives[objIndex][1])
--             print(ply.tasks[taskName].progress[objIndex])

--             print("progression "..objIndex.." ain't complete yet")

--             return

--         elseif (objType == OBJECTIVE.QuestItem && ply.questItems[info.objectives[objIndex]] == nil) then

--             print("progression "..objIndex.." ain't complete yet")

--             return

--         end

--     end

--     hook.Run("efgm_task_"..TASKSTATUS.CompletePending, ply, taskName)

--     ply.tasks[taskName].status = TASKSTATUS.CompletePending
--     print("Completed task "..info.name)

--     UpdateTasks(ply)

--     PrintTable(ply.tasks)

--     net.Start("SendNotification", false)
--     net.WriteString("Task " .. info.name .. " finished, completion pending!")
--     net.WriteString("icons/task_finished_icon.png")
--     net.WriteString("taskfinished.wav")
--     net.Send(ply)

-- end

-- function UpdateTasks(ply)

--     for taskName, taskInfo in pairs(EFGMTASKS) do

--         if taskInfo.requirements == nil then -- no requirements

--             AssignTask(ply, taskName)

--         else

--             local doAssignTask = true

--             for reqIndex, reqType in ipairs(taskInfo.requirementTypes) do

--                 if reqType == REQUIREMENT.QuestCompletion and (table.IsEmpty(ply.tasks) or ply.tasks[taskInfo.requirements[reqIndex]] == nil or ply.tasks[taskInfo.requirements[reqIndex]].status != TASKSTATUS.Complete) then

--                     doAssignTask = false

--                 elseif reqType == REQUIREMENT.PlayerStat and ply:GetNWInt(taskInfo.requirements[reqIndex][2], 1) < taskInfo.requirements[reqIndex][1] then

--                     doAssignTask = false

--                 end

--                 -- TODO: Other requirement types like skill

--             end

--             if doAssignTask then AssignTask(ply, taskName) end

--         end

--     end

-- end

-- function AssignTask(ply, taskName, status, progress)

--     if !table.IsEmpty( ply.tasks ) and ply.tasks[taskName] != nil then return end

--     ply.tasks[taskName] = TASK.Instantiate(taskName, status, progress)

-- end

-- function CompleteTask(ply, taskName)

--     -- already verified that task is pending completion

--     ply.tasks[taskName].status = TASKSTATUS.Complete

--     info = EFGMTASKS[taskName]

--     for rewardIndex, rewardType in ipairs(info.rewardTypes) do

--         if rewardType == REWARD.PlayerStat && info.rewards[rewardIndex][2] == "Experience" then

--             local exp = info.rewards[rewardIndex][1]

--             print(exp)

--             ply:SetNWInt("Experience", ply:GetNWInt("Experience", 0) + exp)

--             local curExp = ply:GetNWInt("Experience")
--             local curLvl = ply:GetNWInt("Level")

--             while (curExp >= ply:GetNWInt("ExperienceToNextLevel")) do

--                 print(ply:GetNWInt("Level"))

--                 curExp = curExp - ply:GetNWInt("ExperienceToNextLevel")
--                 ply:SetNWInt("Level", curLvl + 1)
--                 ply:SetNWInt("Experience", curExp)

--                 for k, v in ipairs(levelArray) do

--                     if (curLvl + 1) == k then ply:SetNWInt("ExperienceToNextLevel", v) end

--                 end

                -- net.Start("SendNotification", false)
                -- net.WriteString("You have leveled up!")
                -- net.WriteString("icons/increase_icon.png")
                -- net.WriteString("achivement_earned.wav")
                -- net.Send(ply)

            -- end

--         elseif rewardType == REWARD.PlayerStat && info.rewards[rewardIndex][2] != "Experience" then

--             ply:SetNWInt(info.rewards[rewardIndex][2], ply:GetNWInt(info.rewards[rewardIndex][2]) + info.rewards[rewardIndex][1])

--         end

--     end

--     net.Start("SendNotification", false)
--     net.WriteString("Completed task " .. info.name .. "!")
--     net.WriteString("icons/task_complete_icon.png")
--     net.WriteString("taskcomplete.wav")
--     net.Send(ply)

--     UpdateTasks(ply)

-- end

-- local function TaskObjectiveComplete(ply, taskName)

--     net.Start("SendNotification", false)
--     net.WriteString("Objective for " .. EFGMTASKS[taskName].name .. " completed!")
--     net.WriteString("icons/task_add_icon.png")
--     net.WriteString("storytask_started.wav")
--     net.Send(ply)

--     CheckTaskCompletion(ply, taskName)

-- end


-- TODO: FINISH THIS
-- function TaskProgressObjective(ply, progressObjType, count, info, subInfo, taskName)

--     if !ply:IsPlayer() or table.IsEmpty(ply.tasks) then return end

--     if progressObjType == OBJECTIVE.Pay or progressObjType == OBJECTIVE.GiveItem && taskName != nil then
        
--         return

--     end

--     for taskName, taskInstance in pairs(ply.tasks) do

--         if taskInstance.status == TASKSTATUS.InProgress then

--             local taskInfo = EFGMTASKS[taskName]

--             for objIndex, objInfo in ipairs(taskInfo.objectives) do

--                 if objInfo.type == progressObjType && (objInfo.info == nil or objInfo.info == info) && (objInfo.subInfo == nil or objInfo.subInfo == subInfo) && taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex] < objInfo.count then

--                     if objInfo.whenToSave == SAVEON.Progress then
                        
--                         if taskInstance.progress[objIndex] + count < objInfo.count then

--                             ply.tasks[taskName].progress[objIndex] = taskInstance.progress[objIndex] + count

--                         elseif taskInstance.progress[objIndex] + count == objInfo.count

--                             ply.tasks[taskName].progress[objIndex] = objInfo.count

--                             TaskObjectiveComplete(ply, taskName)
                            
--                         end

--                     else

--                         if taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex] + count < objInfo.count then

--                             ply.tasks[taskName].tempProgress[objIndex] = taskInstance.tempProgress[objIndex] + count

--                         elseif taskInstance.progress[objIndex] + taskInstance.tempProgress[objIndex] + count == objInfo.count

--                             ply.tasks[taskName].tempProgress[objIndex] = objInfo.count - ply.tasks[taskName].progress[objIndex]

--                         end

--                     end

--                 end

--             end

--         end

--     end

-- end

-- local function TaskWipeTempObjectives(ply)

--     ply:PrintMessage(HUD_PRINTTALK, "TODO: Make wiping temp objectives work")

-- end

-- -- Progression hooks

-- hook.Add("PlayerDeath", "TaskKill", function(victim, inflictor, attacker)

--     if victim:IsPlayer() then

--         TaskWipeTempObjectives(victim)

--     end

--     if victim == attacker or victim:CompareStatus(0) then return end

--     -- TODO: Add support for areas later
--     TaskProgressObjective(ply, OBJECTIVE.Kill, 1, game.GetMap())

-- end)

-- hook.Add("PlayerExtraction", "TaskExtract", function(ply, extractTime, isGuranteed, internalName)

--     if table.IsEmpty(ply.tasks) then return end

--     for taskName, taskInstance in pairs(ply.tasks) do

--         if taskInstance.status == TASKSTATUS.InProgress then

--             local info = EFGMTASKS[taskName]

--             for objIndex, objType in ipairs(info.objectiveTypes) do

--                 if objType == OBJECTIVE.Extract && ply.tasks[taskName].progress[objIndex] < info.objectives[objIndex][1] then

--                     if info.objectives[objIndex][3] != nil then -- extract specified

--                         if info.objectives[objIndex][3] == internalName then
--                             ply.tasks[taskName].progress[objIndex] = taskInstance.progress[objIndex] + 1
--                             TaskObjectiveComplete(ply, taskName)
--                         end

--                     elseif info.objectives[objIndex][2] != nil then -- map specified

--                         if info.objectives[objIndex][2] == game.GetMap() then
--                             ply.tasks[taskName].progress[objIndex] = taskInstance.progress[objIndex] + 1
--                             TaskObjectiveComplete(ply, taskName)
--                         end

--                     else -- extract in general
--                         ply.tasks[taskName].progress[objIndex] = taskInstance.progress[objIndex] + 1
--                         TaskObjectiveComplete(ply, taskName)
--                     end

--                 elseif objType == OBJECTIVE.QuestItem && ply.questItems[info.objectives[objIndex]] == true  && ply.tasks[taskName].progress[objIndex] == 0 then

--                     ply.tasks[taskName].progress[objIndex] = 1

--                     ply.questItems[info.objectives[objIndex]] = nil

--                     TaskObjectiveComplete(ply, taskName)

--                 end

--             end

--         end

--     end

-- end)

-- hook.Add("TaskQuestItemPickup", "TaskAddQuestItem", function(ply, item)

--     net.Start("SendNotification", false)
--     net.WriteString(string.NiceName(item) .. " picked up, proceed to extract.")
--     net.WriteString("icons/inventory_icon.png")
--     net.WriteString("subtaskcomplete.wav")
--     net.Send(ply)

--     ply.questItems[item] = true

-- end)

-- hook.Add("TaskAreaVisited", "TaskAddVisitedArea", function(ply, areaName)

--     if table.IsEmpty(ply.tasks) then return end

--     for taskName, taskInstance in pairs(ply.tasks) do

--         if taskInstance.status == TASKSTATUS.InProgress then

--             local info = EFGMTASKS[taskName]

--             for objIndex, objType in ipairs(info.objectiveTypes) do

--                 if objType == OBJECTIVE.VisitArea && info.objectives[objIndex][2] == areaName && ply.tasks[taskName].progress[objIndex] == 0 then

--                     ply.tasks[taskName].progress[objIndex] = 1

--                     TaskObjectiveComplete(ply, taskName)

--                 end

--             end

--         end

--     end

-- end)

-- -- TODO: Make this accept items and like, yk, check them

-- net.Receive("TaskGiveItem", function(len, ply)

--     if ply:GetNWInt("PlayerRaidStatus", 0) != 0 then return end

--     local taskName = net.ReadString()
--     local itemIndex = net.ReadUInt(32)

--     local info = EFGMTASKS[taskName]

--     if info == nil or table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.InProgress then return end

--     for objIndex, objType in ipairs(info.objectiveTypes) do

--         if objType == OBJECTIVE.GiveItem then

--             if info.objectives[objIndex][3] == true then -- item has to be FIR

--                 ply.tasks[taskName].progress[objIndex] = math.Clamp( ply.tasks[taskName].progress[objIndex] + 1, 0, info.objectives[objIndex][1])

--             else

--                 ply.tasks[taskName].progress[objIndex] = math.Clamp( ply.tasks[taskName].progress[objIndex] + 1, 0, info.objectives[objIndex][1])

--             end

--             print("Task objective 'Give Item' is incomplete!")

--             CheckTaskCompletion(ply, task)

--             return

--         end

--     end

-- end)

-- net.Receive("TaskPay", function(len, ply)

--     if ply:GetNWInt("PlayerRaidStatus", 0) != 0 then return end

--     local taskName = net.ReadString()
--     local amount = net.ReadUInt(32)

--     local info = EFGMTASKS[taskName]

--     if info == nil or table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.InProgress then return end

--     for objIndex, objType in ipairs(info.objectiveTypes) do

--         if objType == OBJECTIVE.Pay && ply.tasks[taskName].progress[objIndex] < info.objectives[objIndex] then

--             local moneyToPay = math.Clamp(amount, 0, ply:GetNWInt("Money", 0))
--             moneyToPay = math.Clamp(amount, 0, info.objectives[objIndex] - ply.tasks[taskName].progress[objIndex])

--             print(moneyToPay)

--             ply:SetNWInt("Money", ply:GetNWInt("Money", 0) - moneyToPay)
--             ply.tasks[taskName].progress[objIndex] = ply.tasks[taskName].progress[objIndex] + moneyToPay

--             if ply.tasks[taskName].progress[objIndex] >= info.objectives[objIndex] then
--                 TaskObjectiveComplete(ply, taskName)
--             end

--             return

--         end

--     end


-- end)

-- net.Receive("TaskAccept", function(len, ply)

--     local taskName = net.ReadString()

--     if table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.AcceptPending then return end

--     ply.tasks[taskName].status = TASKSTATUS.InProgress

--     net.Start("SendNotification", false)
--     net.WriteString("Task " .. EFGMTASKS[taskName].name .. " accepted!")
--     net.WriteString("icons/task_add_icon.png")
--     net.WriteString("storytask_started.wav")
--     net.Send(ply)

-- end)

-- net.Receive("TaskTryComplete", function(len, ply)

--     local taskName = net.ReadString()

--     if table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.CompletePending then return end

--     CompleteTask(ply, taskName)

-- end)

-- net.Receive("TaskRequestAll", function(len, ply)

--     local playerTasks = ply.tasks

--     net.Start("TaskSendAll")
--     net.WriteTable(playerTasks) -- if I add so many tasks that I need to compress them and send them as strings I'm killing myself
--     net.Send(ply)

-- end)

-- -- Debugging

-- if GetConVar("efgm_derivesbox"):GetInt() == 1 then

--     hook.Add("OnNPCKilled", "TaskKill", function(victim, attacker, inflictor)

--         attacker:PrintMessage(HUD_PRINTTALK, "TODO: Update npc kill logic")

--     end)

-- end