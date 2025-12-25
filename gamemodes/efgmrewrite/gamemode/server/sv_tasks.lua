
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

    local function NotifyObjectiveComplete(ply, taskName)

        net.Start("SendNotification", false)
        net.WriteString("Objective for " .. EFGMTASKS[taskName].name .. " completed!")
        net.WriteString("icons/task_add_icon.png")
        net.WriteString("subtaskcomplete.wav")
        net.Send(ply)

    end

    local function NotifyTaskComplete(ply, taskName)

        net.Start("SendNotification", false)
        net.WriteString("Completed task " .. taskInfo.name .. "!")
        net.WriteString("icons/task_complete_icon.png")
        net.WriteString("taskcomplete.wav")
        net.Send(ply)

    end

    local function NotifyTaskAccept(ply, taskName)

        net.Start("SendNotification", false)
        net.WriteString("Task " .. EFGMTASKS[taskName].name .. " accepted!")
        net.WriteString("icons/task_add_icon.png")
        net.WriteString("storytask_started.wav")
        net.Send(ply)

    end

-- Task Objective Progression

    function TaskProgressObjectivesFromTable(ply, objTable, amount)

    end

    function TaskProgressObjectivesSpecific(ply, taskName, objIndex, amount)

    end

-- Task Temporary Progression Helpers

    function TaskTempProgressWipeAll(ply)

    end

    function TaskTempProgressSaveAll(ply, progressType)

    end

-- Task Completion

    function TaskCheckComplete(ply, taskName)

    end

    function TaskDoComplete(ply, taskName)

    end

-- Task Assignment and Updating

    function TaskAssignFromTable(ply, taskTable)

    end

    function TaskGetNewAvailable(ply)

        -- return all tasks to assign

        return nil

    end

-- Task Objective Getters

    function TaskGetAllUnfinishedKillObjectives(ply, mapName, areaName, weapon, range, wasHeadshot)

        local objTable = {}

        for taskName, taskInstance in pairs(ply.tasks) do
            
            local taskInfo = EFGMTASKS[taskName]

            for objIndex, obj in ipairs(taskInfo.objectives) do

                -- im geniunely sorry for this

                if obj.type == OBJECTIVE.Kill and
                obj.mapname == mapName and 
                    (obj.weapon == nil or 
                    obj.useCategory == nil and obj.weapon == weapon or 
                    obj.useCategory != nil and EFGMITEMS[weapon].displayType == weapon) and 
                (obj.minRange == nil or obj.minRange <= range) and 
                (obj.maxRange == nil or obj.maxRange >= range) and 
                (obj.reqHeadshot == nil or wasHeadshot) then
                    
                    objTable[taskName] = objTable[taskName] or {}
                    table.insert(objTable[taskName], objIndex)

                end
                
            end

        end

        print(objTable)

        return objTable

    end

    function TaskGetAllUnfinishedExtractObjectives(ply, mapName, extractName)

        local objTable = {}

        for taskName, taskInstance in pairs(ply.tasks) do
            
            local taskInfo = EFGMTASKS[taskName]

            for objIndex, obj in ipairs(taskInfo.objectives) do

                if obj.type == OBJECTIVE.Extract and
                obj.mapname == mapName and 
                obj.extractName == extractName then
                    
                    objTable[taskName] = objTable[taskName] or {}
                    table.insert(objTable[taskName], objIndex)

                end
                
            end

        end

        print(objTable)

        return objTable

    end

    function TaskGetAllUnfinishedQuestItemObjectives(ply, itemName)

        local objTable = {}

        for taskName, taskInstance in pairs(ply.tasks) do
            
            local taskInfo = EFGMTASKS[taskName]

            for objIndex, obj in ipairs(taskInfo.objectives) do

                if obj.type == OBJECTIVE.QuestItem and
                obj.itemName == itemName then
                    
                    objTable[taskName] = objTable[taskName] or {}
                    table.insert(objTable[taskName], objIndex)

                end
                
            end

        end

        print(objTable)

        return objTable

    end

    function TaskGetAllUnfinishedVisitAreaObjectives(ply, mapName, areaName)

        local objTable = {}

        for taskName, taskInstance in pairs(ply.tasks) do
            
            local taskInfo = EFGMTASKS[taskName]

            for objIndex, obj in ipairs(taskInfo.objectives) do

                if obj.type == OBJECTIVE.VisitArea and
                obj.mapname == mapName and 
                obj.areaName == areaName then
                    
                    objTable[taskName] = objTable[taskName] or {}
                    table.insert(objTable[taskName], objIndex)

                end
                
            end

        end

        print(objTable)

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

        -- TaskProgressObjective(ply, OBJECTIVE.GiveItem, 1, game.GetMap(), areaName)

    end)

    net.Receive("TaskPay", function(len, ply)

        local taskName = net.ReadString()
        local amount = net.ReadUInt(32)

        if ply:GetNWInt("Money", 0) < amount then return end

        TaskProgressObjective(ply, OBJECTIVE.Pay, amount, nil, nil, taskName)

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