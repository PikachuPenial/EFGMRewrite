util.AddNetworkString("PlayerSendInvite")
util.AddNetworkString("PlayerReceiveInvite")
util.AddNetworkString("PlayerAcceptInvite")

net.Receive("PlayerSendInvite", function(len, ply)

    local invitedPly = net.ReadEntity()
    local inviteType = net.ReadString()

    if !IsValid(invitedPly) then return end
    if string.len(inviteType) == 0 then return end

    net.Start("PlayerReceiveInvite")
    net.WriteEntity(ply)
    net.WriteString(inviteType)
    net.Send(invitedPly)

end)

net.Receive("PlayerAcceptInvite", function(len, ply)

    local invitedPly = net.ReadEntity()
    local inviteType = net.ReadString()

    if !IsValid(invitedPly) then return end
    if string.len(inviteType) == 0 then return end

    if inviteType == "duel" then

        DUEL:StartDuel(ply, invitedPly)

    end

end)