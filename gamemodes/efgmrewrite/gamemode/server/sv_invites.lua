util.AddNetworkString("PlayerSendInvite")
util.AddNetworkString("PlayerReceiveInvite")

net.Receive("PlayerSendInvite", function(len, ply)

    local invitedPly = net.ReadEntity()
    local inviteType = net.ReadString()

    if !IsValid(invitedPly) then return end
    if string.len(inviteType) == 0 then return end

    print(ply)

    net.Start("PlayerReceiveInvite")
    net.WriteEntity(ply)
    net.WriteString(inviteType)
    net.Send(invitedPly)

end)