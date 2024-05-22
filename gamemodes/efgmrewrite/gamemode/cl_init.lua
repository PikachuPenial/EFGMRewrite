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
surface.CreateFont("Bender24", {font = "Bender", size = EFGM.ScreenScale(24), weight = 550, blursize = EFGM.ScreenScale(0.3), antialias = true, extended = true})
surface.CreateFont("BenderAmmoCount", { font = "Bender", size = EFGM.ScreenScale(32), weight = 550, blursize = EFGM.ScreenScale(0.3), antialias = true, extended = true })
surface.CreateFont("BenderWeaponName", { font = "Bender", size = EFGM.ScreenScale(21), weight = 550, blursize = EFGM.ScreenScale(0.3), antialias = true, extended = true })

-- why is this box shit here
--[[hook.Add( "PostDrawTranslucentRenderables", "Boxxie", function()

    local origin = Vector(256, 128, 196)
    local start = Vector(-128, -128, -128)

    local outlineOG = (origin * Vector(1, 1, 0)) + Vector(0, 0, start.z + 8)
    local outlineST = (start * Vector(1, 1, 0)) + Vector(0, 0, -8)

    render.SetColorMaterial() -- white material for easy coloring

    cam.IgnoreZ( false )
    render.DrawBox( origin, angle_zero, start, -start, color_white ) -- draws the box 
    cam.IgnoreZ( false )

    local ang = LocalPlayer():EyeAngles()
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)
 
    cam.IgnoreZ( true )
        cam.Start3D2D(origin, ang, 1)
            draw.WordBox(0, 0, 0, math.Round(origin:Distance(LocalPlayer():GetPos()) * 0.01905, 0) .. "m", "DermaLarge", Color(0, 0, 0, 40), Color(0, 0, 0, 255))
        cam.End3D2D() 
    cam.IgnoreZ( false )

end )]]

-- free look
local freelooking = false
concommand.Add("+freelook", function(ply, cmd, args) freelooking = true end)
concommand.Add("-freelook", function(ply, cmd, args) freelooking = false end)

local LookX, LookY = 0, 0
local InitialAng, CoolAng = Angle(), Angle()
local ZeroAngle = Angle()

local function isinsights(ply)
    local weapon = ply:GetActiveWeapon()
    return blockads and (ply:KeyDown(IN_ATTACK2) or (weapon.GetInSights and weapon:GetInSights()) or (weapon.GetIronSights and weapon:GetIronSights()))
end

local function holdingbind(ply)
    if !input.LookupBinding("freelook") then
        return ply:KeyDown(IN_WALK)
    else
        return freelooking
    end
end

hook.Add("CalcView", "AltlookView", function(ply, origin, angles, fov)
    local smoothness = math.Clamp(smooth, 0.1, 2)

    CoolAng = LerpAngle(0.15 * smoothness, CoolAng, Angle(LookY, -LookX, 0))

    if !holdingbind(ply) and CoolAng.p < 0.05 and CoolAng.p > -0.05 or isinsights(ply) and CoolAng.p < 0.05 and CoolAng.p > -0.05 or !system.HasFocus() or ply:ShouldDrawLocalPlayer() then
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
    if !holdingbind(lp) or isinsights(lp) or lp:ShouldDrawLocalPlayer() then LookX, LookY = 0, 0 return end

    InitialAng.z = 0
    cmd:SetViewAngles(InitialAng)

    LookX = math.Clamp(LookX + x * 0.02, -limH, limH)
    LookY = math.Clamp(LookY + y * 0.02, -limV, limV)

    return true
end)

hook.Add("StartCommand", "AltlookBlockShoot", function(ply, cmd)
    if !ply:IsPlayer() or !ply:Alive() then return end
    if !blockshoot then return end

    if !holdingbind(ply) or isinsights(ply) or ply:ShouldDrawLocalPlayer() then return end
    cmd:RemoveKey(IN_ATTACK)
end)