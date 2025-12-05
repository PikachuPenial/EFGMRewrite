
util.AddNetworkString("TaskPay")
util.AddNetworkString("TaskGiveItem")
util.AddNetworkString("TaskAccept")

-- Task shit

function CheckTaskCompletion(ply, taskName)

    PrintTable(ply.tasks)

    local info = EFGMTASKS[taskName or nil]

    if info == nil or table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.InProgress then return end

    local isProgressionComplete = true

    for objIndex, objType in ipairs(info.objectiveTypes) do

        -- PrintTable(info)

        if (objType == OBJECTIVE.Pay or objType == OBJECTIVE.Kill) && info.objectives[objIndex] > ply.tasks[taskName].progress[objIndex] then
            
            isProgressionComplete = false

            print("progression "..objIndex.." ain't complete yet")

            return

        elseif (objType == OBJECTIVE.Extract or objType == OBJECTIVE.GiveItem) && info.objectives[objIndex][1] > ply.tasks[taskName].progress[objIndex] then
            
            print(info.objectives[objIndex][1])
            print(ply.tasks[taskName].progress[objIndex])

            isProgressionComplete = false

            print("progression "..objIndex.." ain't complete yet")

            return

        end

        -- TODO: Give rewards here
        
    end

    if isProgressionComplete then
        
        hook.Run("efgm_task_completion", ply, taskName)

        ply.tasks[taskName].status = TASKSTATUS.Complete
        print("Completed task "..info.name)

        UpdateTasks(ply)

        PrintTable(ply.tasks)

    end

end

function UpdateTasks(ply)

    for taskName, taskInfo in pairs(EFGMTASKS) do
        
        if taskInfo.requirements == nil then -- no requirements
            
            AssignTask(ply, taskName)

        else

            local doAssignTask = true

            for reqIndex, reqType in ipairs(taskInfo.requirementTypes) do
                
                if reqType == REQUIREMENT.QuestCompletion and (table.IsEmpty(ply.tasks) or ply.tasks[taskInfo.requirements[reqIndex]] == nil or ply.tasks[taskInfo.requirements[reqIndex]].status != TASKSTATUS.Complete) then

                    doAssignTask = false
                    
                end

                -- TODO: Other requirement types like skill

            end

            print("DoAssignTask = "..tostring(doAssignTask))

            if doAssignTask then AssignTask(ply, taskName) end
    
        end

    end

end

function AssignTask(ply, taskName, status, progress)

    if !table.IsEmpty( ply.tasks ) and ply.tasks[taskName] != nil then return end

    ply.tasks[taskName] = TASK.Instantiate(taskName, status, progress)

end

-- Progression hooks



hook.Add("OnNPCKilled", "TaskKill", function(victim, attacker, inflictor)

    -- PrintTable(attacker.tasks)

    if victim:IsPlayer() then

        victim.questItems = {}
        
    end

    if !attacker:IsPlayer() then return end

    for taskName, taskInstance in pairs(attacker.tasks) do

        if taskInstance.status == TASKSTATUS.InProgress then
            
            local info = EFGMTASKS[taskName]

            for objIndex, objType in ipairs(info.objectiveTypes) do

                if objType == OBJECTIVE.Kill then
                    
                    attacker.tasks[taskName].progress[objIndex] = math.Clamp( taskInstance.progress[objIndex] + 1, 0, info.objectives[objIndex])

                    CheckTaskCompletion(attacker, taskName)

                end
                
            end

        end

    end

end)

hook.Add("PlayerExtraction", "TaskExtract", function(ply, extractTime, isGuranteed, internalName)

    -- PrintTable(ply.tasks)

    for taskName, taskInstance in pairs(ply.tasks) do

        if taskInstance.status == TASKSTATUS.InProgress then

            local info = EFGMTASKS[taskName]

            for objIndex, objType in ipairs(info.objectiveTypes) do

                if objType == OBJECTIVE.Extract then

                    if info.objectives[objIndex][3] != nil then -- extract specified

                        if info.objectives[objIndex][3] == internalName then
                            ply.tasks[taskName].progress[objIndex] = math.Clamp( taskInstance.progress[objIndex] + 1, 0, info.objectives[objIndex][1])
                        end

                    elseif info.objectives[objIndex][2] != nil then -- map specified

                        if info.objectives[objIndex][2] == game.GetMap() then
                            ply.tasks[taskName].progress[objIndex] = math.Clamp( taskInstance.progress[objIndex] + 1, 0, info.objectives[objIndex][1])
                        end

                    else -- extract in general
                        ply.tasks[taskName].progress[objIndex] = math.Clamp( taskInstance.progress[objIndex] + 1, 0, info.objectives[objIndex][1])
                    end

                    CheckTaskCompletion(ply, taskName)

                elseif objType == OBJECTIVE.QuestItem && ply.questItems[info.objectives[objIndex]] == true then

                    ply.tasks[taskName].progress[objIndex] = 1

                    ply.questItems[info.objectives[objIndex]] = nil

                    CheckTaskCompletion(ply, taskName)
            
                end

            end

        end
        
    end

end)

hook.Add("TaskQuestItemPickup", "TaskAddQuestItem", function(ply, item)

    ply:PrintMessage(HUD_PRINTTALK, string.NiceName(item).." picked up, proceed to extract.")

    ply.questItems[item] = true

end)

-- TODO: Make this accept items and like, yk, check them

net.Receive("TaskGiveItem", function(len, ply)

    if ply:GetNWInt("PlayerRaidStatus", 0) != 0 then return end

    local taskName = net.ReadString()
    local itemIndex = net.ReadUInt(32)

    local info = EFGMTASKS[taskName]

    if info == nil or table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.InProgress then return end

    for objIndex, objType in ipairs(info.objectiveTypes) do
        
        if objType == OBJECTIVE.GiveItem then

            if info.objectives[objIndex][3] == true then -- item has to be FIR

                ply.tasks[taskName].progress[objIndex] = math.Clamp( ply.tasks[taskName].progress[objIndex] + 1, 0, info.objectives[objIndex][1])
                
            else
            
                ply.tasks[taskName].progress[objIndex] = math.Clamp( ply.tasks[taskName].progress[objIndex] + 1, 0, info.objectives[objIndex][1])
            
            end

            print("Task objective 'Give Item' is incomplete!")

            CheckTaskCompletion(ply, task)

            return

        end

    end

    
end)

net.Receive("TaskPay", function(len, ply)

    if ply:GetNWInt("PlayerRaidStatus", 0) != 0 then return end

    local task = net.ReadString()
    local amount = net.ReadUInt(32)

    local info = EFGMTASKS[task]

    if info == nil or table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.InProgress then return end

    for objIndex, objType in ipairs(info.objectiveTypes) do
        
        if objType == OBJECTIVE.Pay then

            local moneyToPay = math.Clamp(amount, 0, ply:GetNWInt("Money", 0))
            moneyToPay = math.Clamp(amount, 0, info.objectives[objIndex] - ply.tasks[taskName].progress[objIndex])

            ply:SetNWInt("Money", ply:GetNWInt("Money", 0) - moneyToPay)
            ply.tasks[taskName].progress[objIndex] = ply.tasks[taskName].progress[objIndex] + moneyToPay

            CheckTaskCompletion(ply, task)

            return

        end

    end


end)

net.Receive("TaskAccept", function(len, ply)

    local taskName = net.ReadString()

    if table.IsEmpty(ply.tasks) or ply.tasks[taskName] == nil or ply.tasks[taskName].status != TASKSTATUS.AcceptPending then return end

    ply.tasks[taskName].status = TASKSTATUS.InProgress

end)

-- Debugging

concommand.Add("efgm_debug_gettasks", function(ply, cmd, args)
    
    PrintTable(ply.tasks)

end)