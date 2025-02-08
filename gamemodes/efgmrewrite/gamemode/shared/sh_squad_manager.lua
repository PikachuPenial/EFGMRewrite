
hook.Add("PlayerInitialSpawn", "SquadFirstSpawn", function(ply)

    ply:SetNW2String("PlayerInSquad", "nil")
    ply:SetNW2String("TeamChatChannel", "nil")

end)

function GM:OnReloaded()

    for k, v in pairs(player:GetAll()) do

        v:SetNW2String("PlayerInSquad", "nil")
        v:SetNW2String("TeamChatChannel", "nil")

    end

end

if SERVER then

    SQUADS = {}
    NETWORKEDPLAYERS = RecipientFilter()

    util.AddNetworkString("AddPlayerSquadRF")
    util.AddNetworkString("RemovePlayerSquadRF")

    util.AddNetworkString("GrabSquadData")
    util.AddNetworkString("SendSquadData")

    util.AddNetworkString("PlayerCreateSquad")
    util.AddNetworkString("PlayerJoinSquad")
    util.AddNetworkString("PlayerLeaveSquad")
    util.AddNetworkString("PlayerTransferSquad")
    util.AddNetworkString("PlayerKickSquad")
    util.AddNetworkString("PlayerDisbandSquad")

    -- send squad information to every client that will need it
    function NetworkSquadInfoToClients()

        net.Start("SendSquadData", true)

            net.WriteTable(SQUADS)

        net.Send(NETWORKEDPLAYERS:GetPlayers())

    end

    local function PlayerInSquad(ply)

        if ply:GetNW2String("PlayerInSquad", "nil") != "nil" then

            return true

        else

            return false

        end

    end

    local function PasswordCheck(ply, squad, pass)

        if string.len(SQUADS[squad].PASSWORD) != 0 or SQUADS[squad].PASSWORD == nil then

            if pass == SQUADS[squad].PASSWORD then

                return true

            else

                return false

            end

        else

            return true

        end

    end

    local function GetSquadOfPlayer(ply)

        for k, v in pairs(SQUADS) do

            if table.HasValue(v.MEMBERS, ply) then

                return k

            end

        end

    end

    local function ReplaceSquadOwner(newOwner, squad)

        SQUADS[squad].OWNER = newOwner

    end

    local function DisbandSquad(squad)

        for k, v in pairs(SQUADS[squad].MEMBERS) do

            v:SetNW2String("PlayerInSquad", "nil")
            v:SetNW2String("TeamChatChannel", "nil")

        end

        table.removeKey(SQUADS, squad)

    end

    net.Receive("AddPlayerSquadRF", function(len, ply)

        NETWORKEDPLAYERS:AddPlayer(ply)

    end)

    net.Receive("RemovePlayerSquadRF", function(len, ply)

        NETWORKEDPLAYERS:RemovePlayer(ply)

    end)

    -- please dont exploit this
    net.Receive("GrabSquadData", function(len, ply)

        NetworkSquadInfoToClients()

    end)

    net.Receive("PlayerCreateSquad", function(len, ply)

        if PlayerInSquad(ply) then return end
        if !ply:CompareStatus(0) then return end

        local name = net.ReadString()

        -- dont allow ppl to override other squads or to name their squad nil, this will break everything lmao
        local currentSquadNames = table.GetKeys(SQUADS)
        if table.HasValue(currentSquadNames, name) or name == "nil" then return end

        local password = net.ReadString()
        local limit = net.ReadInt(4)
        local r = net.ReadInt(9)
        local g = net.ReadInt(9)
        local b = net.ReadInt(9)

        SQUADS[name] = {OWNER = ply, PASSWORD = password, LIMIT = limit, COLOR = {RED = r, GREEN = g, BLUE = b}, MEMBERS = {ply}}

        ply:SetNW2String("PlayerInSquad", name)
        ply:SetNW2String("TeamChatChannel", name)
        NetworkSquadInfoToClients()

    end)

    net.Receive("PlayerJoinSquad", function(len, ply)

        local squad = net.ReadString()
        local password = net.ReadString()

        if PlayerInSquad(ply) then return end
        if !ply:CompareStatus(0) then return end
        if table.Count(SQUADS[squad].MEMBERS) >= SQUADS[squad].LIMIT then return end
        if !PasswordCheck(ply, squad, password) then return end

        table.insert(SQUADS[squad].MEMBERS, ply)

        ply:SetNW2String("PlayerInSquad", squad)
        ply:SetNW2String("TeamChatChannel", squad)
        NetworkSquadInfoToClients()

        for k, v in pairs(SQUADS[squad].MEMBERS) do

            if v == ply then return end
            v:ChatPrint(ply:GetName() .. " has joined your squad!")

        end

    end)

    net.Receive("PlayerLeaveSquad", function(len, ply)

        if !PlayerInSquad(ply) then return end
        if !ply:CompareStatus(0) then return end

        local squad = GetSquadOfPlayer(ply)

        table.RemoveByValue(SQUADS[squad].MEMBERS, ply)
        ply:SetNW2String("PlayerInSquad", "nil")
        ply:SetNW2String("TeamChatChannel", "nil")

        if table.Count(SQUADS[squad].MEMBERS) == 0 then

            DisbandSquad(squad)
            NetworkSquadInfoToClients()
            return

        end

        if ply == SQUADS[squad].OWNER then

            local newOwner = table.Random(SQUADS[squad].MEMBERS)
            ReplaceSquadOwner(newOwner, squad)

        end

        NetworkSquadInfoToClients()

        for k, v in pairs(SQUADS[squad].MEMBERS) do

            v:ChatPrint(ply:GetName() .. " has left your squad!")

        end

    end)

    net.Receive("PlayerTransferSquad", function(len, ply)

        if !PlayerInSquad(ply) then return end
        if !ply:CompareStatus(0) then return end

        local newOwner = net.ReadString()
        local squad = GetSquadOfPlayer(ply)

        if ply != SQUADS[squad].OWNER then return end

        for k, v in pairs(SQUADS[squad].MEMBERS) do

            if string.lower(v:GetName()) == string.lower(newOwner) then

                ReplaceSquadOwner(v, squad)
                newOwnerEnt = v
                v:ChatPrint("You are now the squad owner!")

            elseif v != ply then

                v:ChatPrint("Squad ownership transfered to " .. newOwner .. "!")

            end

        end

        NetworkSquadInfoToClients()

    end)

    net.Receive("PlayerKickSquad", function(len, ply)

        if !PlayerInSquad(ply) then return end
        if !ply:CompareStatus(0) then return end

        local kickedPly = net.ReadString()
        local squad = GetSquadOfPlayer(ply)

        if ply != SQUADS[squad].OWNER then return end

        for k, v in pairs(SQUADS[squad].MEMBERS) do

            if string.lower(v:GetName()) == string.lower(kickedPly) then

                table.RemoveByValue(SQUADS[squad].MEMBERS, v)
                v:SetNW2String("PlayerInSquad", "nil")
                v:SetNW2String("TeamChatChannel", "nil")
                v:ChatPrint("You have been kicked from your squad!")

            end

        end

        NetworkSquadInfoToClients()

    end)

    net.Receive("PlayerDisbandSquad", function(len, ply)

        if !PlayerInSquad(ply) then return end
        if !ply:CompareStatus(0) then return end

        local squad = GetSquadOfPlayer(ply)

        if ply != SQUADS[squad].OWNER then return end

        for k, v in pairs(SQUADS[squad].MEMBERS) do

            if v != ply then

                v:ChatPrint("Your squad has been disbanded!")

            end

        end

        DisbandSquad(squad)

        NetworkSquadInfoToClients()

    end)

end

if CLIENT then

    concommand.Add("efgm_squad_create", function(ply, cmd, args)

        local name

        if (args[1] == nil or tostring(args[1]) != ("" or "nil")) then

            name = tostring(args[1])

        else

            name = tostring(ply:GetName() .. "'s Squad")

        end

        local password = tostring(args[2] or "") -- the 'or' just sets the value if nil, bc a password of nil will just be "nil" instead of ""
        local limit = math.Clamp(tonumber(args[3] or 1), 1, 4)
        local red = math.Clamp(tonumber(args[4] or 255), 0, 255)
        local green = math.Clamp(tonumber(args[5] or 255), 0, 255)
        local blue = math.Clamp(tonumber(args[6] or 255), 0, 255)

        net.Start("PlayerCreateSquad")

            net.WriteString(name)
            net.WriteString(password)
            net.WriteInt(limit, 4)
            net.WriteInt(red, 9)
            net.WriteInt(green, 9)
            net.WriteInt(blue, 9)

        net.SendToServer()

    end)

    concommand.Add("efgm_squad_join", function(ply, cmd, args)

        local name = tostring(args[1])
        local password = tostring(args[2] or "")

        net.Start("PlayerJoinSquad")

            net.WriteString(name)
            net.WriteString(password)

        net.SendToServer()

    end)

    concommand.Add("efgm_squad_leave", function(ply, cmd, args)

        net.Start("PlayerLeaveSquad")
        net.SendToServer()

    end)

    concommand.Add("efgm_squad_transfer", function(ply, cmd, args)

        local newOwner = tostring(args[1])

        net.Start("PlayerTransferSquad")

            net.WriteString(newOwner)

        net.SendToServer()

    end)

    concommand.Add("efgm_squad_kick", function(ply, cmd, args)

        local kickedPly = tostring(args[1])

        net.Start("PlayerKickSquad")

            net.WriteString(kickedPly)

        net.SendToServer()

    end)

    concommand.Add("efgm_squad_disband", function(ply, cmd, args)

        net.Start("PlayerDisbandSquad")
        net.SendToServer()

    end)

end

-- remove player from team chat channel on death if they were in a raid
hook.Add("PlayerDeath", "ClearEffectOnDeath", function(ply)

    if ply:CompareStatus(0) then return end
    ply:SetNW2String("TeamChatChannel", "nil")

end)

-- remove player from squad if they disconnect
hook.Add("PlayerDisconnected", "KickFromSquadOnDisconnect", function(ply)

    if !PlayerInSquad(ply) then return end

    local squad = GetSquadOfPlayer(ply)

    table.RemoveByValue(SQUADS[squad].MEMBERS, ply)

    if table.Count(SQUADS[squad].MEMBERS) == 0 then

        DisbandSquad(squad)
        NetworkSquadInfoToClients()
        return

    end

    if ply == SQUADS[squad].OWNER then

        local newOwner = table.Random(SQUADS[squad].MEMBERS)
        ReplaceSquadOwner(newOwner, squad)

    end

    NetworkSquadInfoToClients()

end)