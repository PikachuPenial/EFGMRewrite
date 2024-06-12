GM.Name = "EFGM Remastered"
GM.Author = "Penial & Porty"
GM.Email = "piss off"
GM.Website = "https://www.youtube.com/watch?v=dQw4w9WgXcQ"

if CLIENT then
    CreateClientConVar("efgm_music", 1, true, true, "Enable/disable the music", 0, 1)
    CreateClientConVar("efgm_musicvolume", 1, true, true, "Increase or lower the volume of the music", 0, 2)
    CreateClientConVar("efgm_hud_scale", 1, false, true, "Adjust the scale for all user interface items", 0.5, 1.5)
    CreateClientConVar("efgm_controls_togglelean", 1, true, true, "Adjust if player leans are hold or toggle", 0, 1)
    CreateClientConVar("efgm_privacy_invites", 2, true, true, "Determines who you receive invites from (2 = Everyone, 1 = Steam Friends, 0 = Nobody)", 0, 2)
end

if GetConVar("efgm_derivesbox"):GetInt() == 1 then DeriveGamemode("sandbox") end -- this will enable the spawn menu as well as countless other things that you do not want users to have access too, please leave this off unless you know what you are doing