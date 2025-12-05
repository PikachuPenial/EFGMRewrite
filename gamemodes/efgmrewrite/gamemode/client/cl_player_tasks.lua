
concommand.Add("efgm_task_pay", function(ply, cmd, args)

    local task, amount = args[1], tonumber(args[2])

    if amount > ply:GetNWInt("Money") or amount <= 0 then return end

    print("Tried to pay "..amount.." roubles to "..task.." task")

    net.Start("TaskPay")
    net.WriteString(task)
    net.WriteUInt(amount, 32)
    net.SendToServer()

end)

concommand.Add("efgm_task_giveitem", function(ply, cmd, args)

    local task, itemIndex = args[1], tonumber(args[2])

    -- TODO: Item logic

    net.Start("TaskGiveItem")
    net.WriteString(task)
    net.WriteUInt(itemIndex, 32)
    net.SendToServer()

end)

concommand.Add("efgm_task_accept", function(ply, cmd, args)

    local task = args[1]

    net.Start("TaskAccept")
    net.WriteString(task)
    net.SendToServer()

end)

concommand.Add("efgm_task_complete", function(ply, cmd, args)

    local task = args[1]

    net.Start("TaskTryComplete")
    net.WriteString(task)
    net.SendToServer()

end)