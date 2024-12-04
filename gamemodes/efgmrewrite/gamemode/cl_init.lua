
isInventoryTesting = (GetConVar("efgm_invtesting"):GetInt() == 1) or false

include("shared.lua")

-- client globals
EFGM = {}

-- screen scale function, makes my life (penial) easier because i will most definently be doing most if not all of the user interface
-- all interfaces and fonts are developed on a 1920x1080 monitor
local efgm_hud_scale = GetConVar("efgm_hud_scale")
EFGM.ScreenScale = function(size) return size / 3 * (ScrW() / 640) * efgm_hud_scale:GetFloat() end

-- i can't be asked to support player controlled menu scaling, way too problematic, so we will seperate the HUDs scale and the menus scale
EFGM.MenuScale = function(size) return size / 3 * (ScrW() / 640) end

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/shared/*.lua", "GAME", "nameasc")) do include("shared/" .. v) end
for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/client/*.lua", "GAME", "nameasc")) do include("client/" .. v) end
for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/intel/*.lua", "GAME", "nameasc")) do include("intel/" .. v) end

-- death prespective
local function Calc(ply, pos, angles, fov, target)

    local view = target:GetAttachment(target:LookupAttachment("eyes"))
    if not view then return end

    local playerview = {
        origin = view.Pos,
        angles = view.Ang,
        znear = 1
    }

    return playerview

end

hook.Add("CalcView", "PovDeath", function(ply, pos, angles, fov)

    local ragdoll = ply:GetRagdollEntity()
    local target = ply:GetObserverTarget()

    if IsValid(ragdoll) and (ragdoll == target or not IsValid(target)) then return Calc(ply, pos, angles, fov, ragdoll) end
    if IsValid(target) and target:GetClass() == "prop_ragdoll" then return Calc(ply, pos, angles, fov, target) end

end)

-- free look
local limV = 35
local limH = 55

local freelooking = false

concommand.Add("+freelook", function(ply, cmd, args) freelooking = true end)
concommand.Add("-freelook", function(ply, cmd, args) freelooking = false end)

local LookX, LookY = 0, 0
local InitialAng, CoolAng = Angle(), Angle()
local ZeroAngle = Angle()

local function isinsights(ply)

    local weapon = ply:GetActiveWeapon()
    return true and (weapon.GetInSights and weapon:GetInSights())

end

local function holdingbind(ply)

    return freelooking

end

hook.Add("CalcView", "AltlookView", function(ply, origin, angles, fov)

    CoolAng = LerpAngle(0.3, CoolAng, Angle(LookY, -LookX, 0))

    if not holdingbind(ply) and CoolAng.p < 0.05 and CoolAng.p > -0.05 or isinsights(ply) and CoolAng.p < 0.05 and CoolAng.p > -0.05 or not system.HasFocus() or ply:ShouldDrawLocalPlayer() then

        InitialAng = angles + CoolAng
        LookX, LookY = 0, 0

        CoolAng = ZeroAngle

        return

    end

    angles.p = angles.p + CoolAng.p
    angles.y = angles.y + CoolAng.y

end)

hook.Add("CalcViewModelView", "AltlookVM", function(wep, vm, oPos, oAng, pos, ang)

    local MWBased = wep.m_AimModeDeltaVelocity and -1.5 or 1

    ang.p = ang.p + CoolAng.p / 2.5 * MWBased
    ang.y = ang.y + CoolAng.y / 2.5 * MWBased

end)

hook.Add("InputMouseApply", "AltlookMouse", function(cmd, x, y, ang)

    local lp = LocalPlayer()
    if not holdingbind(lp) or isinsights(lp) or lp:ShouldDrawLocalPlayer() then LookX, LookY = 0, 0 return end

    InitialAng.z = 0
    cmd:SetViewAngles(InitialAng)

    LookX = math.Clamp(LookX + x * 0.02, -limH, limH)
    LookY = math.Clamp(LookY + y * 0.02, -limV, limV)

    return true

end)