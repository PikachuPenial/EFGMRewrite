
SQUADS = {}

if SERVER then

    util.AddNetworkString("GrabSquadData")
    util.AddNetworkString("SendSquadData")
    util.AddNetworkString("PlayerCreateSquad")
    util.AddNetworkString("PlayerPrintSquad")

    -- please dont exploit this
    net.Receive("GrabSquadData", function(len, ply)

        net.Start("SendSquadData", true)

            net.WriteTable(SQUADS)

        net.Send(ply)

    end)

    net.Receive("PlayerCreateSquad", function(len, ply)

        local name = net.ReadString()
        local password = net.ReadString()
        local limit = net.ReadInt(4)
        local r = net.ReadInt(9)
        local g = net.ReadInt(9)
        local b = net.ReadInt(9)

        SQUADS[name] = {OWNER = ply, PASSWORD = password, LIMIT = limit, COLOR = {RED = r, GREEN = g, BLUE = b}, MEMBERS = {ply}}

    end)

    net.Receive("PlayerPrintSquad", function(len, ply)

        PrintTable(SQUADS)

    end)

end

if CLIENT then

    concommand.Add("efgm_squad_create", function(ply, cmd, args)

        local name

        if tostring(args[1]) != ("" or nil) then

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

        net.Start("PlayerPrintSquad")
        net.SendToServer()

    end)

end