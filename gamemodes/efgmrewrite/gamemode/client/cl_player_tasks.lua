
concommand.Add("efgm_task_pay", function(ply, cmd, args)

    local task, amount = args[1], tonumber(args[2])

    if amount > ply:GetNWInt("Money") or amount <= 0 then return end

    print("Tried to pay "..amount.." roubles to "..task.." task")

    net.Start("TaskPay")
    net.WriteString(task)
    net.WriteUInt(amount, 32)
    net.SendToServer()

end)