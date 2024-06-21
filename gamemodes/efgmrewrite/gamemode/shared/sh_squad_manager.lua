
hook.Add("PlayerInitialSpawn", "SquadFirstSpawn", function(ply)

    ply:SetNW2String("PlayerInSquad", "nil")

end)

function GM:OnReloaded()

    for k, v in pairs(player:GetAll()) do

        v:SetNW2String("PlayerInSquad", "nil")

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
    util.AddNetworkString("PlayerDisbandSquad")

    -- send squad information to every client that will need it
    local function NetworkSquadInfoToClients()

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

        table.remove(SQUADS[squad], OWNER)
        table.insert(SQUADS[squad], OWNER, newOwner)

    end

    local function DisbandSquad(squad)

        for k, v in pairs(SQUADS[squad].MEMBERS) do

            v:SetNW2String("PlayerInSquad", "nil")

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

        local name = net.ReadString()

        -- dont allow ppl to override other squads lmao
        local currentSquadNames = table.GetKeys(SQUADS)
        if table.HasValue(currentSquadNames, name) then return end

        local password = net.ReadString()
        local limit = net.ReadInt(4)
        local r = net.ReadInt(9)
        local g = net.ReadInt(9)
        local b = net.ReadInt(9)

        SQUADS[name] = {OWNER = ply, PASSWORD = password, LIMIT = limit, COLOR = {RED = r, GREEN = g, BLUE = b}, MEMBERS = {ply}}

        ply:SetNW2String("PlayerInSquad", name)
        NetworkSquadInfoToClients()

    end)

    net.Receive("PlayerJoinSquad", function(len, ply)

        if PlayerInSquad(ply) then return end

        local name = net.ReadString()
        local password = net.ReadString()

        if table.Count(SQUADS[name].MEMBERS) >= SQUADS[name].LIMIT then return end

        if not PasswordCheck(ply, name, password) then return end

        table.insert(SQUADS[name].MEMBERS, ply)

        ply:SetNW2String("PlayerInSquad", name)
        NetworkSquadInfoToClients()

    end)

    net.Receive("PlayerLeaveSquad", function(len, ply)

        if not PlayerInSquad(ply) then return end

        local squad = GetSquadOfPlayer(ply)

        table.RemoveByValue(SQUADS[squad].MEMBERS, ply)
        ply:SetNW2String("PlayerInSquad", "nil")

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

    net.Receive("PlayerTransferSquad", function(len, ply)

        if not PlayerInSquad(ply) then return end

        local newOwner = string.lower(net.ReadString())
        local squad = GetSquadOfPlayer(ply)

        if ply != SQUADS[squad].OWNER then return end

        for k, v in pairs(SQUADS[squad].MEMBERS) do

            if string.lower(v:GetName()) == newOwner then

                ReplaceSquadOwner(newOwner, squad)

            end

        end

        NetworkSquadInfoToClients()

    end)

    net.Receive("PlayerDisbandSquad", function(len, ply)

        if not PlayerInSquad(ply) then return end

        local squad = GetSquadOfPlayer(ply)

        if ply != SQUADS[squad].OWNER then return end

        DisbandSquad(squad)

        NetworkSquadInfoToClients()

    end)

    net.Receive("PrintSquads", function(len, ply)

        PrintTable(SQUADS)

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

    concommand.Add("efgm_squad_disband", function(ply, cmd, args)

        net.Start("PlayerDisbandSquad")
        net.SendToServer()

    end)

end