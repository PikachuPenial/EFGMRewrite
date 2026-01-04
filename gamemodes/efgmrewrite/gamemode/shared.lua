GM.Name = "EFGM Rewrite"
GM.Author = "Penial, Portanator"
GM.Email = "kind programmer spreads christmas cheer through phone calls :blush:"
GM.Website = "https://github.com/PikachuPenial/EFGMRewrite"

if !ConVarExists("efgm_derivesbox") then CreateConVar("efgm_derivesbox", "0", FCVAR_REPLICATED + FCVAR_NOTIFY, "Hooks the sandbox gamemode into EFGM, allowing for things like the spawn menu to be accessed. Used for development purposes", 0, 1) end
if !ConVarExists("efgm_oneshotheadshot") then CreateConVar("efgm_oneshotheadshot", "1", FCVAR_REPLICATED + FCVAR_NOTIFY, "Self explanitory", 0, 1) end

if CLIENT then

    CreateClientConVar("efgm_music", 1, true, true, "Enable/disable the music", 0, 1)
    CreateClientConVar("efgm_musicvolume", 1, true, true, "Increase or lower the volume of the music", 0, 2)
    CreateClientConVar("efgm_hud_enable", 1, true, true, "Adjust the visibility of the user interface", 0, 1)
    CreateClientConVar("efgm_hud_scale", 1, true, true, "Adjust the scale for all user interface items", 0.5, 2)
    CreateClientConVar("efgm_menu_parallax", 1, true, true, "Adjust the main menu parallax/jiggle when moving your cursor", 0, 1)
    CreateClientConVar("efgm_menu_scalingmethod", 0, true, true, "Adjust the method at which the menu positions itself after scaling", 0, 1)
    CreateClientConVar("efgm_menu_deleteprompt", 1, true, true, "Adjust if a confirmation prompt appears when deleting an item", 0, 1)
    CreateClientConVar("efgm_menu_sellprompt_single", 1, true, true, "Adjust if a confirmation prompt appears when selling a single item", 0, 1)
    CreateClientConVar("efgm_menu_sellprompt_stacked", 1, true, true, "Adjust if a confirmation prompt appears when selling a single item", 0, 1)
    CreateClientConVar("efgm_menu_search_automatic", 1, true, true, "Adjust if inventory search boxes automatically begin searching on text change, or if it requires the enter key to be pressed to search", 0, 1)
    CreateClientConVar("efgm_visuals_highqualimpactfx", 1, true, true, "Adjust the quality of the bullets impact effects", 0, 1)
    CreateClientConVar("efgm_visuals_headbob", 1, true, true, "Adjust the bobbing motion of the players view while moving", 0, 1)
    CreateClientConVar("efgm_visuals_lensflare", 1, true, true, "Adjust the lens flare when looking near or directly at the sun", 0, 1)
    CreateClientConVar("efgm_visuals_selfshadow", 1, true, true, "Adjust if your own players shadow renders", 0, 1)
    CreateClientConVar("efgm_controls_toggleduck", 0, true, true, "Adjust if player crouches are hold or toggle", 0, 1)
    CreateClientConVar("efgm_controls_togglelean", 1, true, true, "Adjust if player leans are hold or toggle", 0, 1)
    CreateClientConVar("efgm_faction_preference", 0, true, true, "Determines the faction that your playermodel is based on (0 = None, 1 = USEC, 2 = BEAR)", 0, 2)
    CreateClientConVar("efgm_privacy_invites_squad", 2, true, true, "Determines who you receive squad invites from (2 = Everyone, 1 = Steam Friends, 0 = Nobody)", 0, 2)
    CreateClientConVar("efgm_privacy_invites_duel", 2, true, true, "Determines who you receive duel invites from (2 = Everyone, 1 = Steam Friends, 0 = Nobody)", 0, 2)
    CreateClientConVar("efgm_privacy_invites_blocked", 0, true, true, "Determines if a player that you have blocked on steam can send you an invite", 0, 1)
    CreateClientConVar("efgm_infil_nearend_block", 1, true, true, "Determines if you are able to enter a raid when it is about to end", 0, 1)
    CreateClientConVar("efgm_infil_nearend_limit", 60, true, true, "Determines the seconds remaining in the raid where you will no longer be able to enter said raid if near end infils are disabled", 30, 180)

end

include("!config.lua")

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

function format_seconds(s)

    local hours = math.floor(s / 3600)
    local minutes = math.floor((s % 3600) / 60)
    local seconds = s % 60

    return string.format("%2d:%02d:%02d", hours, minutes, seconds)

end

function units_to_meters(u)

    return math.Round(u * 0.01905)

end

local charset = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

function generate_rand_string(l)

    local str = ""

    for i = 1, l do

        local randIndex = math.random(1, #charset)
        str = str .. string.sub(charset, randIndex, randIndex)

    end

    return str

end

-- works with raw vectors too
function EntitiesWithinBounds(ent1, ent2, dist)

    local pos1
    local pos2

    if isentity(pos1) then pos1 = ent1:GetPos() else pos1 = ent1 end
    if isentity(pos2) then pos2 = ent2:GetPos() else pos2 = ent2 end

    local distSqr = dist * dist
    return pos1:DistToSqr(pos2:GetPos()) < distSqr

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

function AttTreeToList(tree, tbl)

    if !istable(tree) then return {} end
    local atts = {}

    atts = {tree}

    if tree.SubAttachments then
        for _, sub in ipairs(tree.SubAttachments) do
            table.Add(atts, AttTreeToList(sub, tbl))
        end
    end

    return atts

end

function GetSubSlotList(tbl)

    local atts = {}

    for _, i in ipairs(tbl or {}) do

        table.Add(atts, AttTreeToList(i, tbl))

    end

    return atts

end

function GetAttachmentList(tbl)

    local atts = {}

    for _, i in ipairs(GetSubSlotList(tbl)) do

        if i.Installed then table.insert(atts, i.Installed) end

    end

    return atts

end

function GetAttachmentListFromCode(str)

    local tbl = ImportPresetCode(str)

    if !tbl then return false end

    local cleanAttTbl = GetAttachmentList(tbl)
    local cleanAttStr = ""

    table.sort(cleanAttTbl, function(a, b)

        local a_value = EFGMITEMS["arc9_att_" .. a].value or 0
        local b_value = EFGMITEMS["arc9_att_" .. b].value or 0

        if a_value and b_value then
            return a_value > b_value
        end

    end)

    for i = 0, #cleanAttTbl do
        if !cleanAttTbl[i] then continue end
        cleanAttStr = cleanAttStr .. i .. ": " .. "\t" .. EFGMITEMS["arc9_att_" .. cleanAttTbl[i]].fullName .. ", " .. EFGMITEMS["arc9_att_" .. cleanAttTbl[i]].weight .. "kg, ₽" .. comma_value(EFGMITEMS["arc9_att_" .. cleanAttTbl[i]].value) .. "\n"
    end

    return cleanAttStr

end

function GetPrefixedAttachmentListFromCode(str)

    local tbl = ImportPresetCode(str)

    if !tbl then return false end

    local cleanAttTbl = GetAttachmentList(tbl)
    local prefixAttTbl = {}

    for i = 0, #cleanAttTbl do
        if !cleanAttTbl[i] then continue end
        table.insert(prefixAttTbl, "arc9_att_" .. cleanAttTbl[i])
    end

    return prefixAttTbl

end