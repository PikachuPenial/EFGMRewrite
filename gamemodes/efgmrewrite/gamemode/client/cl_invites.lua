local lastInviteSentTime = 0

function InvitePlayerToSquad(ply, invitedPly)

    CreateNotification("I do not work yet LOL!", Mats.dontEvenAsk, "ui/boo.wav")

end

function InvitePlayerToDuel(ply, invitedPly)

    if CurTime() - lastInviteSentTime < 10 then CreateNotification("You can send invites again in " .. 10 - math.Round(CurTime() - lastInviteSentTime, 1) .. " seconds!", Mats.inviteErrorIcon, nil) return end
    if !IsValid(invitedPly) then return end
    if Invites.invitedBy != nil or Invites.invitedType != nil then CreateNotification("Cannot send an invite while pending confirmation!", Mats.inviteErrorIcon, nil) return end

    lastInviteSentTime = CurTime()

    CreateNotification("Invite Sent!", Mats.inviteSentIcon, nil)

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

    timer.Simple(10, function()

        Invites.invitedBy = nil
        Invites.invitedType = nil

    end)

end)

function AcceptInvite(ply)

    if Invites.invitedBy == nil or Invites.invitedType == nil then return end

    net.Start("PlayerAcceptInvite")
    net.WriteEntity(Invites.invitedBy)
    net.WriteString(Invites.invitedType)
    net.SendToServer()

    Invites.invitedBy = nil
    Invites.invitedType = nil

end

function DeclineInvite(ply)

    if Invites.invitedBy == nil or Invites.invitedType == nil then return end

    Invites.invitedBy = nil
    Invites.invitedType = nil

end

hook.Add("efgm_raid_enter", "RemovePendingInviteIfRaidEnter", function()

    Invites.invitedBy = nil
    Invites.invitedType = nil

end)