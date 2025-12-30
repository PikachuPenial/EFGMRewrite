Invites = {}

Invites.inviteCD = 0
Invites.lastInviteSentTime = 0
Invites.lastSquadInviteSentTime = 0

function InvitePlayerToSquad(ply, invitedPly)

    if Invites.invitedBy != nil or Invites.invitedType != nil then return end

    if CurTime() - Invites.inviteCD < 0.5 then return end
    Invites.inviteCD = CurTime()

    if !IsValid(invitedPly) then return end
    if invitedPly:GetNW2String("PlayerInSquad", "nil") != "nil" then CreateNotification("This player is already in a squad!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if !invitedPly:CompareStatus(0) then CreateNotification("This player is currently busy!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if CurTime() - Invites.lastInviteSentTime < 10 then CreateNotification("You can send invites again in " .. 10 - math.Round(CurTime() - Invites.lastInviteSentTime, 1) .. " seconds!", Mats.inviteErrorIcon, "ui/error.wav") return end

    -- local plySquad = ply:GetNW2String("PlayerInSquad", "nil")

    -- already in a squad
    if ply:GetNW2String("PlayerInSquad", "nil") != "nil" then

        CreateNotification("there IS NOT support for inviting to a already established squad yet dont ask me why", Mats.dontEvenAsk, "ui/boo.wav")

        -- Invites.lastInviteSentTime = CurTime()
        -- Invites.lastSquadInviteSentTime = 0

        -- CreateNotification("Invite Sent!", Mats.inviteSentIcon, nil)

        -- net.Start("PlayerSendInvite")
        -- net.WriteEntity(invitedPly)
        -- net.WriteString("squad")
        -- net.WriteString(plySquad)
        -- net.SendToServer()

        return

    end

    -- not in a squad, prompt to automatically create one
    if Invites.lastSquadInviteSentTime == 0 then CreateNotification("Send another invite to automatically create a squad!", Mats.inviteErrorIcon, "ui/error.wav") Invites.lastSquadInviteSentTime = CurTime() return end

    if CurTime() - Invites.lastSquadInviteSentTime < 10 then

        RunConsoleCommand("efgm_squad_create", ply:GetName() .. "'s Squad", "", "4", "255", "255", "255")

    end

    Invites.lastInviteSentTime = CurTime()
    Invites.lastSquadInviteSentTime = 0

    CreateNotification("Invite Sent!", Mats.inviteSentIcon, "ui/squad_disband.wav")

    net.Start("PlayerSendInvite")
    net.WriteEntity(invitedPly)
    net.WriteString("squad")
    net.WriteString(ply:GetName() .. "'s Squad")
    net.SendToServer()

end

function InvitePlayerToDuel(ply, invitedPly)

    if CurTime() - Invites.inviteCD < 0.5 then return end
    Invites.inviteCD = CurTime()

    if !IsValid(invitedPly) then return end
    if GetGlobalInt("DuelStatus") != duelStatus.PENDING then CreateNotification("Another duel is already taking place, please wait for it to end!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if Invites.invitedType == "duel" and Invites.invitedBy == invitedPly then AcceptInvite(ply) return end
    if CurTime() - Invites.lastInviteSentTime < 10 then CreateNotification("You can send invites again in " .. 10 - math.Round(CurTime() - Invites.lastInviteSentTime, 1) .. " seconds!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if !invitedPly:CompareStatus(0) then CreateNotification("This player is currently busy!", Mats.inviteErrorIcon, "ui/error.wav") return end
    if Invites.invitedBy != nil or Invites.invitedType != nil then CreateNotification("Cannot send an invite while pending confirmation!", Mats.inviteErrorIcon, "ui/error.wav") return end

    Invites.lastInviteSentTime = CurTime()

    CreateNotification("Invite Sent!", Mats.inviteSentIcon, "ui/squad_disband.wav")

    net.Start("PlayerSendInvite")
    net.WriteEntity(invitedPly)
    net.WriteString("duel")
    net.WriteString("")
    net.SendToServer()

end

Invites.invitedBy = nil
Invites.invitedType = nil
Invites.inviteData = nil

net.Receive("PlayerReceiveInvite", function(len, ply)

    if IsValid(invite) then return end -- player already has a pending invite

    local invitedBy = net.ReadEntity()
    local invitedType = net.ReadString()
    local invitedData = net.ReadString()

    local friendship = invitedBy:GetFriendStatus() -- aww so cute

    -- disabled
    if invitedType == "squad" and GetConVar("efgm_privacy_invites_squad"):GetInt() == 0 then return end
    if invitedType == "duel" and GetConVar("efgm_privacy_invites_duel"):GetInt() == 0 then return end

    -- blocked
    if GetConVar("efgm_privacy_invites_blocked"):GetInt() == 0 and friendship == "blocked" then return end

    -- friends only
    if invitedType == "squad" and GetConVar("efgm_privacy_invites_squad"):GetInt() == 1 and friendship != "friend" then return end
    if invitedType == "duel" and GetConVar("efgm_privacy_invites_duel"):GetInt() == 1 and friendship != "friend" then return end

    Invites.invitedBy = invitedBy
    Invites.invitedType = invitedType
    Invites.inviteData = invitedData

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

hook.Add("efgm_duel_enter", "RemovePendingInviteIfDuelEnter", function()

    Invites.invitedBy = nil
    Invites.invitedType = nil
    Invites.inviteData = nil

end)