
SQUADS = {}
SQUADS["TEST"] = {OWNER = "Portanator", PASSWORD = "", LIMIT = 4, COLOR = {RED = 255, GREEN = 255, BLUE = 255}, MEMBERS = {"Portanator", "Bean", "Zedorfska"}}
SQUADS["WE <3 BALATRO"] = {OWNER = "Computery", PASSWORD = "", LIMIT = 2, COLOR = {RED = 0, GREEN = 255, BLUE = 155}, MEMBERS = {"Computery", "Polskiano"}}
SQUADS["9H ON VISUAL STUDIO CODE"] = {OWNER = "Penial", PASSWORD = "endingitall", LIMIT = 4, COLOR = {RED = 255, GREEN = 255, BLUE = 55}, MEMBERS = {"Penial", "Suomij (narkotica)"}}

if SERVER then

    util.AddNetworkString("PlayerCreateSquad")

    net.Receive("PlayerCreateSquad", function(len, ply)

        local name = net.ReadString()
        local password = net.ReadString()
        local limit = net.ReadInt(4)
        local r, g, b = net.ReadInt(9), net.ReadInt(9), net.ReadInt(9)

        SQUADS[name] = {OWNER = ply, PASSWORD = password, LIMIT = limit, COLOR = {r, g, b}, MEMBERS = {ply}}

    end)

end

if CLIENT then

    concommand.Add("efgm_squad_create", function(ply, cmd, args)

        local name = tostring(args[1])
        local password = tostring(args[2])
        local limit = math.Clamp(tonumber(args[3]), 1, 4)
        local red = math.Clamp(tonumber(args[4]), 0, 255)
        local green = math.Clamp(tonumber(args[5]), 0, 255)
        local blue = math.Clamp(tonumber(args[6]), 0, 255)

        if name == nil then

            name = ply:GetName() .. "'s Squad"

        end

        net.Start("PlayerCreateSquad")

            net.WriteString(name)
            net.WriteString(password)
            net.WriteInt(limit, 4)
            net.WriteInt(red, 9)
            net.WriteInt(green, 9)
            net.WriteInt(blue, 9)

        net.SendToServer()

    end)

end