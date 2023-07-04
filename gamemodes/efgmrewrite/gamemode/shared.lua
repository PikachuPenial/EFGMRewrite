GM.Name = "EFGM Remastered"
GM.Author = "Penial & Porty"
GM.Email = "piss off"
GM.Website = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/shared/*.lua", "GAME", "nameasc")) do
	AddCSLuaFile("shared/" .. v)
	include("shared/" .. v)
end

if CLIENT then
    CreateClientConVar("efgm_music", 1, true, false, "Enable/disable the music", 0, 1)
    CreateClientConVar("efgm_musicvolume", 1, true, false, "Increase or lower the volume of the music", 0, 2)
end

if GetConVar("efgm_derivesbox"):GetInt() == 1 then DeriveGamemode("sandbox") end -- this will enable the spawn menu as well as countless other things that you do not want users to have access too, please leave this off unless you know what you are doing