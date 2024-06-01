include("shared.lua")

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/shared/*.lua", "GAME", "nameasc")) do
	include("shared/" .. v)
end

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/client/*.lua", "GAME", "nameasc")) do
    include("client/" .. v)
end

-- Intel shit

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/intel/*.lua", "GAME", "nameasc")) do
    include("intel/" .. v)
end

-- fonts
local function CreateFonts()
    surface.CreateFont("Bender24", {font = "Bender", size = EFGM.ScreenScale(24), weight = 550, blursize = EFGM.ScreenScale(0.3), antialias = true, extended = true})
    surface.CreateFont("BenderAmmoCount", { font = "Bender", size = EFGM.ScreenScale(32), weight = 550, blursize = EFGM.ScreenScale(0.3), antialias = true, extended = true })
    surface.CreateFont("BenderWeaponName", { font = "Bender", size = EFGM.ScreenScale(21), weight = 550, blursize = EFGM.ScreenScale(0.3), antialias = true, extended = true })
end
CreateFonts()

-- reload fonts on resolution change
hook.Add("OnScreenSizeChanged", "ResolutionChange", function()
    CreateFonts()
end)

-- reload fonts on hud scale change
cvars.AddChangeCallback("efgm_hud_scale", function()
    CreateFonts()
end)

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

    if IsValid(ragdoll) and (ragdoll == target or not IsValid(target)) then
        return Calc(ply, pos, angles, fov, ragdoll)
    end

    if IsValid(target) and target:GetClass() == "prop_ragdoll" then
        return Calc(ply, pos, angles, fov, target)
    end
end)

-- free look
local limV = 35
local limH = 55
local smooth = 0.8
local blockshoot = true

local freelooking = false

concommand.Add("+freelook", function(ply, cmd, args) freelooking = true end)
concommand.Add("-freelook", function(ply, cmd, args) freelooking = false end)

local LookX, LookY = 0, 0
local InitialAng, CoolAng = Angle(), Angle()
local ZeroAngle = Angle()

local function isinsights(ply) -- arccw, arc9, tfa, mgbase, fas2 works
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

hook.Add("StartCommand", "AltlookBlockShoot", function(ply, cmd)
    if !ply:IsPlayer() or !ply:Alive() then return end
    if !blockshoot then return end

    if not holdingbind(ply) or isinsights(ply) or ply:ShouldDrawLocalPlayer() then return end
    cmd:RemoveKey(IN_ATTACK)
end)