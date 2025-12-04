
util.AddNetworkString("TaskPay")

-- Task shit

function CheckTaskCompletion(ply, taskName)

    PrintTable(ply.tasks)

    local info = EFGMTASKS[taskName or nil]

    if info == nil then return nil end

    print("made it past info check")


    local taskIndex = nil

    for k, v in pairs(ply.tasks) do

        if v.name == taskName then taskIndex = k break end
        
    end

    print("made it past task check")


    local isProgressionComplete = true


    for objIndex, objType in ipairs(info.objectiveTypes) do

        -- PrintTable(info)

        if (objType == OBJECTIVE.Pay or objType == OBJECTIVE.Kill) && info.objectives[objIndex] > ply.tasks[taskIndex].progress[objIndex] then
            
            isProgressionComplete = false

            print("progression "..objIndex.." ain't complete yet")

            return

        elseif (objType == OBJECTIVE.Extract or objType == OBJECTIVE.GiveItem) && info.objectives[objIndex][1] > ply.tasks[taskIndex].progress[objIndex] then
            
            print(info.objectives[objIndex][1])
            print(ply.tasks[taskIndex].progress[objIndex])

            isProgressionComplete = false

            print("progression "..objIndex.." ain't complete yet")

            return

        end
        
    end

    if isProgressionComplete then
        
        hook.Run("efgm_task_completion", ply, taskName)

        table.remove(ply.tasks, taskIndex)

        print("Completed quest")

        if info.nextTask != nil then

            print("Moving onto "..EFGMTASKS[info.nextTask].name)

            table.insert(ply.tasks, TASK.Instantiate(info.nextTask))

        end

        PrintTable(ply.tasks)

    end

end

-- Progression hooks

-- REPLACE WITH PlayerDeath, also reverse inflictor y attacker
hook.Add("OnNPCKilled", "TaskKill", function(victim, attacker, inflictor)

    -- PrintTable(attacker.tasks)

    for k1, v1 in ipairs(attacker.tasks) do

        local info = EFGMTASKS[v1.name]

        for k2, v2 in ipairs(info.objectiveTypes) do

            if v2 == OBJECTIVE.Kill then
                
                attacker.tasks[k1].progress[k2] = math.Clamp( v1.progress[k2] + 1, 0, info.objectives[k2])

                CheckTaskCompletion(attacker, v1.name)

            end
            
        end
        
    end

end)

hook.Add("PlayerExtraction", "TaskExtract", function(ply, extractTime, isGuranteed, internalName)

    -- PrintTable(ply.tasks)

    for k1, v1 in ipairs(ply.tasks) do

        local info = EFGMTASKS[v1.name]

        for k2, v2 in ipairs(info.objectiveTypes) do

            if v2 == OBJECTIVE.Extract then

                if info.objectives[k2][3] != nil then -- extract specified

                    if info.objectives[k2][3] == internalName then
                        ply.tasks[k1].progress[k2] = math.Clamp( v1.progress[k2] + 1, 0, info.objectives[k2][1])
                    end

                elseif info.objectives[k2][2] != nil then -- map specified

                    if info.objectives[k2][2] == game.GetMap() then
                        ply.tasks[k1].progress[k2] = math.Clamp( v1.progress[k2] + 1, 0, info.objectives[k2][1])
                    end

                else -- extract in general
                    ply.tasks[k1].progress[k2] = math.Clamp( v1.progress[k2] + 1, 0, info.objectives[k2][1])
                end

                CheckTaskCompletion(ply, v1.name)

            end
            
        end
        
    end

end)

net.Receive("taskPay", function(len, ply)

    local task = net.ReadString()
    local amount = net.ReadUInt(32)

    local info = EFGMTASKS[task]

    if info == nil then return end

    -- getting objective

    for taskIndex, taskInstance in ipairs(ply.tasks) do
        
        if taskInstance.name == task then

            for objIndex, objType in ipairs(info.objectiveTypes) do
                
                if objType == OBJECTIVE.Pay then

                    local moneyToPay = math.Clamp(amount, 0, ply:GetNWInt("Money", 0))
                    moneyToPay = math.Clamp(amount, 0, info.objectives[objIndex] - ply.tasks[taskIndex].progress[objIndex])

                    ply:SetNWInt("Money", ply:GetNWInt("Money", 0) - moneyToPay)
                    ply.tasks[taskIndex].progress[objIndex] = ply.tasks[taskIndex].progress[objIndex] + moneyToPay

                    CheckTaskCompletion(ply, task)

                end

            end

        end

    end

    
end)

-- Debugging

concommand.Add("efgm_debug_gettasks", function(ply, cmd, args)
    
    PrintTable(ply.tasks)

end)