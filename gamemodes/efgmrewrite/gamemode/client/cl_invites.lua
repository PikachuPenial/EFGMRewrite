local lastInviteSentTime = 0
local lastSquadInviteSentTime = 0

function InvitePlayerToSquad(ply, invitedPly)

    if !IsValid(invitedPly) then return end
    if CurTime() - lastInviteSentTime < 10 then CreateNotification("You can send invites again in " .. 10 - math.Round(CurTime() - lastInviteSentTime, 1) .. " seconds!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if Invites.invitedBy != nil or Invites.invitedType != nil then CreateNotification("Cannot send an invite while pending confirmation!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if invitedPly:GetNW2String("PlayerInSquad", "nil") != "nil" then CreateNotification("This player is already in a squad!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if !invitedPly:CompareStatus(0) then CreateNotification("This player is currently busy!", Mats.inviteErrorIcon, "ui/error.wav") return end

    -- local plySquad = ply:GetNW2String("PlayerInSquad", "nil")

    -- already in a squad
    if ply:GetNW2String("PlayerInSquad", "nil") != "nil" then

        CreateNotification("there IS NOT support for inviting to a already established squad yet dont ask me why", Mats.dontEvenAsk, "ui/boo.wav")

        -- lastInviteSentTime = CurTime()
        -- lastSquadInviteSentTime = 0

        -- CreateNotification("Invite Sent!", Mats.inviteSentIcon, nil)

        -- net.Start("PlayerSendInvite")
        -- net.WriteEntity(invitedPly)
        -- net.WriteString("squad")
        -- net.WriteString(plySquad)
        -- net.SendToServer()

        return

    end

    -- not in a squad, prompt to automatically create one
    if lastSquadInviteSentTime == 0 then CreateNotification("Send another invite to automatically create a squad!", Mats.inviteErrorIcon, "ui/error.wav") lastSquadInviteSentTime = CurTime() return end

    if CurTime() - lastSquadInviteSentTime < 10 then

        RunConsoleCommand("efgm_squad_create", ply:GetName() .. "'s Squad", "", "4", "255", "255", "255")

    end

    lastInviteSentTime = CurTime()
    lastSquadInviteSentTime = 0

    CreateNotification("Invite Sent!", Mats.inviteSentIcon, "squad_disband.wav")

    net.Start("PlayerSendInvite")
    net.WriteEntity(invitedPly)
    net.WriteString("squad")
    net.WriteString(ply:GetName() .. "'s Squad")
    net.SendToServer()

end

function InvitePlayerToDuel(ply, invitedPly)

    if !IsValid(invitedPly) then return end
    if CurTime() - lastInviteSentTime < 10 then CreateNotification("You can send invites again in " .. 10 - math.Round(CurTime() - lastInviteSentTime, 1) .. " seconds!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if GetGlobalInt("DuelStatus") != duelStatus.PENDING then CreateNotification("Another duel is already taking place, please wait for it to end!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if Invites.invitedBy != nil or Invites.invitedType != nil then CreateNotification("Cannot send an invite while pending confirmation!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if !invitedPly:CompareStatus(0) then CreateNotification("This player is currently busy!", Mats.inviteErrorIcon, "ui/error.wav") return end

    lastInviteSentTime = CurTime()

    CreateNotification("Invite Sent!", Mats.inviteSentIcon, nil)

    net.Start("PlayerSendInvite")
    net.WriteEntity(invitedPly)
    net.WriteString("duel")
    net.WriteString("")
    net.SendToServer()

end

Invites = {}

Invites.invitedBy = nil
Invites.invitedType = nil
Invites.inviteData = nil

net.Receive("PlayerReceiveInvite", function(len, ply)

    if IsValid(invite) then return end -- player already has a pending invite

    Invites.invitedBy = net.ReadEntity()
    Invites.invitedType = net.ReadString()
    Invites.inviteData = net.ReadString()

    RenderInvite(LocalPlayer())

    timer.Simple(10, function()

        Invites.invitedBy = nil
        Invites.invitedType = nil
        Invites.inviteData = nil

    end)

end)

function AcceptInvite(ply)

    if !ply:CompareStatus(0) then return end
    if Invites.invitedBy == nil or Invites.invitedType == nil then return end

    net.Start("PlayerAcceptInvite")
    net.WriteEntity(Invites.invitedBy)
    net.WriteString(Invites.invitedType)
    net.WriteString(Invites.inviteData)
    net.SendToServer()

    Invites.invitedBy = nil
    Invites.invitedType = nil
    Invites.inviteData = nil

end

function DeclineInvite(ply)

    if Invites.invitedBy == nil or Invites.invitedType == nil then return end

    Invites.invitedBy = nil
    Invites.invitedType = nil
    Invites.inviteData = nil

end

hook.Add("efgm_raid_enter", "RemovePendingInviteIfRaidEnter", function()

    Invites.invitedBy = nil
    Invites.invitedType = nil
    Invites.inviteData = nil

end)