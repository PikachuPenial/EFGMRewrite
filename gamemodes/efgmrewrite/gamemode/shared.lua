GM.Name = "EFGM Rewrite"
GM.Author = "Penial, Portanator"
GM.Email = "kind programmer spreads christmas cheer through phone calls :blush:"
GM.Website = "https://github.com/PikachuPenial/EFGMRewrite"

if !ConVarExists("efgm_derivesbox") then CreateConVar("efgm_derivesbox", "0", FCVAR_REPLICATED + FCVAR_NOTIFY, "Hooks the sandbox gamemode into EFGM, allowing for things like the spawn menu to be accessed. Used for development purposes", 0, 1) end
if !ConVarExists("efgm_arenamode") then CreateConVar("efgm_arenamode", "0", FCVAR_REPLICATED + FCVAR_NOTIFY, "Enables features such as infinite ammo, spawning with loadouts, etc. Keep disabled for the classic EFGM experience", 0, 1) end

if CLIENT then
    CreateClientConVar("efgm_music", 1, false, true, "Enable/disable the music", 0, 1)
    CreateClientConVar("efgm_musicvolume", 1, false, true, "Increase or lower the volume of the music", 0, 2)
    CreateClientConVar("efgm_hud_enable", 1, false, true, "Adjust the visibility of the user interface", 0, 1)
    CreateClientConVar("efgm_hud_scale", 1, false, true, "Adjust the scale for all user interface items", 0.5, 2)
    CreateClientConVar("efgm_hud_compass_always", 0, false, true, "Adjust the behaviour of displaying the compass", 0, 1)
    CreateClientConVar("efgm_menu_parallax", 1, false, true, "Adjust the main menu parallax/jiggle when moving your cursor", 0, 1)
    CreateClientConVar("efgm_visuals_highqualimpactfx", 1, false, true, "Adjust the quality of the bullets impact effects", 0, 1)
    CreateClientConVar("efgm_visuals_headbob", 1, true, true, "Adjust the bobbing motion of the players view while moving", 0, 1)
    CreateClientConVar("efgm_visuals_lensflare", 1, false, true, "Adjust the lens flare when looking near or directly at the sun", 0, 1)
    CreateClientConVar("efgm_controls_togglecrouch", 1, true, true, "Adjust if player crouches are hold or toggle", 0, 1)
    CreateClientConVar("efgm_controls_togglelean", 1, true, true, "Adjust if player leans are hold or toggle", 0, 1)
    CreateClientConVar("efgm_faction_preference", 0, true, true, "Determines the faction that your playermodel is based on (0 = None, 1 = USEC, 2 = BEAR)", 0, 2)
    CreateClientConVar("efgm_privacy_invites", 2, true, true, "Determines who you receive invites from (2 = Everyone, 1 = Steam Friends, 0 = Nobody)", 0, 2)
end

if GetConVar("efgm_derivesbox"):GetInt() == 1 then DeriveGamemode("sandbox") end -- this will enable the spawn menu as well as countless other things that you do not want users to have access too, please leave this off unless you know what you are doing

-- include derma skin
if SERVER then
    AddCSLuaFile("skins/efgm.lua")
elseif CLIENT then
    include("skins/efgm.lua")
    hook.Add("ForceDermaSkin", "EFGMDermaSkin", function()
        return "Escape From Garry's Mod Derma Skin"
    end)
end

-- misc. functions
function table.removeKey(tbl, key)
    local element = tbl[key]
    tbl[key] = nil
    return element
end