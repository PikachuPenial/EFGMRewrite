local lastInviteSentTime = 0

function InvitePlayerToSquad(ply, invitedPly)

    CreateNotification("I do not work yet LOL!", Mats.dontEvenAsk, "ui/boo.wav")

end

function InvitePlayerToDuel(ply, invitedPly)

    if CurTime() - lastInviteSentTime < 10 then CreateNotification("You can send invites again in " .. 10 - math.Round(CurTime() - lastInviteSentTime, 1) .. " seconds", Mats.sendIcon, nil) return end

    lastInviteSentTime = CurTime()

    if !IsValid(invitedPly) then return end

    net.Start("PlayerSendInvite")
    net.WriteEntity(invitedPly)
    net.WriteString("duel")
    net.SendToServer()

end

Invites = {}

Invites.invitedBy = nil
Invites.invitedType = nil

net.Receive("PlayerReceiveInvite", function(len, ply)

    Invites.invitedBy = net.ReadEntity()
    Invites.invitedType = net.ReadString()

    RenderInvite(LocalPlayer())

end )