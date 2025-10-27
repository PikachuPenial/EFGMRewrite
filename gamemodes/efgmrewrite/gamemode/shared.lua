GM.Name = "EFGM Rewrite"
GM.Author = "Penial, Portanator"
GM.Email = "kind programmer spreads christmas cheer through phone calls :blush:"
GM.Website = "https://github.com/PikachuPenial/EFGMRewrite"

if !ConVarExists("efgm_derivesbox") then CreateConVar("efgm_derivesbox", "0", FCVAR_REPLICATED + FCVAR_NOTIFY, "Hooks the sandbox gamemode into EFGM, allowing for things like the spawn menu to be accessed. Used for development purposes", 0, 1) end
if !ConVarExists("efgm_arenamode") then CreateConVar("efgm_arenamode", "0", FCVAR_REPLICATED + FCVAR_NOTIFY, "Enables features such as infinite ammo, spawning with loadouts, etc. Keep disabled for the classic EFGM experience", 0, 1) end
if !ConVarExists("efgm_debug_pickupinv") then CreateConVar("efgm_debug_pickupinv", "1", FCVAR_REPLICATED + FCVAR_NOTIFY, "", 0, 1) end

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

function comma_value(amount)
    local formatted = tostring(amount)
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
        if (k == 0) then
            break
        end
    end
    return formatted
end

-- necessary functions to sync attachments cleanly between inventories
function PruneUnnecessaryAttachmentDataRecursive(tbl)

    tbl.t = tbl.ToggleNum
    tbl.i = tbl.Installed
    tbl.s = tbl.SubAttachments

    for i, k in pairs(tbl) do

        if i != "i" and i != "s" and i != "t" and i != "ToggleNum" then

            tbl[i] = nil

        end

    end

    if table.Count(tbl.s or {}) > 0 then

        for i, k in pairs(tbl.s) do

            PruneUnnecessaryAttachmentDataRecursive(k)

        end

    else

        tbl.s = nil

    end

    tbl.BaseClass = nil

end

function DecompressTableRecursive(tbl)

    for i, k in pairs(tbl) do

        if i == "i" then

            tbl["i"] = nil
            tbl["Installed"] = k

        elseif i == "s" then

            tbl["s"] = nil
            tbl["SubAttachments"] = k

        elseif i == "t" then

            tbl["t"] = nil
            tbl["ToggleNum"] = k

        end

    end

    if table.Count(tbl.SubAttachments or {}) > 0 then

        for i, k in pairs(tbl.SubAttachments) do

            DecompressTableRecursive(k)

        end

    end

end

function GenerateAttachString(tbl)

    for i, k in pairs(tbl) do PruneUnnecessaryAttachmentDataRecursive(k) end

    local str = util.TableToJSON(tbl)

    str = util.Compress(str)
    str = util.Base64Encode(str, true)

    return str

end

function ImportPresetCode(str)

    if !str then return end
    str = util.Base64Decode(str)
    str = util.Decompress(str)

    if !str then return end

    local tbl = util.JSONToTable(str)

    if tbl then

        for i, k in pairs(tbl) do

            DecompressTableRecursive(k)

        end

    end

    return tbl

end

function LoadPresetFromTable(wep, tbl)

    wep:SetNoPresets(true)

    wep.Attachments = baseclass.Get(wep:GetClass()).Attachments

    for slot, slottbl in ipairs(wep.Attachments) do

        slottbl.Installed = nil
        slottbl.SubAttachments = nil

    end

    wep:PruneAttachments()

    wep:BuildSubAttachments(tbl)
    wep:PostModify()

end

function LoadPresetFromCode(wep, str)

    local tbl = ImportPresetCode(str)

    if !tbl then return false end

    LoadPresetFromTable(wep, tbl)

end