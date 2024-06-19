
hook.Add("PlayerInitialSpawn", "SquadFirstSpawn", function(ply)

    ply:SetNW2Bool("PlayerInSquad", false)

end)

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

    util.AddNetworkString("PrintSquadRF")
    util.AddNetworkString("PrintSquads")

    -- send squad information to every client that will need it
    local function NetworkSquadInfoToClients()

        net.Start("SendSquadData", true)

            net.WriteTable(SQUADS)

        net.Send(NETWORKEDPLAYERS:GetPlayers())

    end

    local function PlayerInSquad(ply)

        if ply:GetNW2Bool("PlayerInSquad", false) then
            return true
        else
            return false
        end

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

        ply:SetNW2Bool("PlayerInSquad", true)
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

    concommand.Add("efgm_squad_printlist", function(ply, cmd, args)

        net.Start("PrintSquads")
        net.SendToServer()

    end)

end