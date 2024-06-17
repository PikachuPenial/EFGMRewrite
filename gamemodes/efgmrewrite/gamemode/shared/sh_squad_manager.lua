
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

        net.Start("PlayerCreateSquad")

            net.WriteString(tostring(args[1]))
            net.WriteString(tostring(args[2]))
            net.WriteInt(tonumber(args[3]), 4)
            net.WriteInt(tonumber(args[4]), 9)
            net.WriteInt(tonumber(args[5]), 9)
            net.WriteInt(tonumber(args[6]), 9)

        net.SendToServer()

    end)

end