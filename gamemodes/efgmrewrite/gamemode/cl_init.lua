include("shared.lua")

-- client globals
EFGM = {}

local function DeepSkinOverride(children, skin)

	for k,v in pairs(children) do

		v:SetSkin(skin)
		if #v:GetChildren() != 0 then DeepSkinOverride(v:GetChildren(), skin) end

	end

end

concommand.Add("efgm_dermarefresh", function()

    DeepSkinOverride(vgui.GetWorldPanel():GetChildren(), "efgm")

    for k,v in pairs(derma.GetSkinTable()) do

		if v.GwenTexture then

			local tex = v.GwenTexture:GetTexture("$basetexture")
			if tex then tex:Download() end

		end

	end

	derma.RefreshSkins()

end)

-- disable ARC9 settings menu when needed
if GetConVar("efgm_derivesbox"):GetInt() == 0 then

    function ARC9_OpenSettings(page) return end
    concommand.Remove("arc9_settings_open")

end

EFGM.ScrW = ScrW()
EFGM.ScrH = ScrH()

-- screen scale function, makes my life (penial) easier because i will most definently be doing most if not all of the user interface
-- all interfaces and fonts are developed on a 1920x1080 monitor
local screenScaleCache = {}
local efgm_hud_scale = GetConVar("efgm_hud_scale"):GetFloat()
cvars.AddChangeCallback("efgm_hud_scale", function(convar_name, value_old, value_new)
	screenScaleCache = {}
    efgm_hud_scale = math.Round(tonumber(value_new), 2)
end)

EFGM.ScreenScale = function(size)

	if screenScaleCache[size] then return screenScaleCache[size] end

	local ratio = (EFGM.ScrW / EFGM.ScrH <= 1.8) and (EFGM.ScrW / 1920.0) or (EFGM.ScrH / 1080.0)
	local scaled = size * ratio * efgm_hud_scale
	local result = size > 0 and math.max(1, scaled) or math.min(-1, scaled)

	screenScaleCache[size] = result
	return result

end

-- i can't be asked to support player controlled menu scaling, way too problematic, so we will seperate the HUDs scale and the menus scale
local menuScaleCache = {}
EFGM.MenuScale = function(size)

	if menuScaleCache[size] then return menuScaleCache[size] end

	local ratio = (EFGM.ScrW / EFGM.ScrH <= 1.8) and (EFGM.ScrW / 1920.0) or (EFGM.ScrH / 1080.0)
	local scaled = size * ratio
	local result = size > 0 and math.max(1, scaled) or math.min(-1, scaled)

	menuScaleCache[size] = result
	return result

end

hook.Add("OnScreenSizeChanged", "ClearScalingCache", function()

	EFGM.ScrW = ScrW()
	EFGM.ScrH = ScrH()

	screenScaleCache = {}
	menuScaleCache = {}

	CreateFonts()

end)

EFGM.SteamNameCache = {}

include("!config.lua")

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/shared/*.lua", "GAME", "nameasc")) do

	include("shared/" .. v)

end

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/client/*.lua", "GAME", "nameasc")) do

	include("client/" .. v)

end

for _, v in ipairs(file.Find("gamemodes/efgmrewrite/gamemode/intel/*.lua", "GAME", "nameasc")) do

	include("intel/" .. v)

end

-- panel/frame blur
-- TODO: create similar function for segments of the screen instead of blurring a specific function, would let us blur HUD elements that are not held in a panel/frame
local blurMat = Material("pp/blurscreen")
function BlurPanel(panel, strength)

    surface.SetMaterial(blurMat)
    surface.SetDrawColor(255, 255, 255, 255)

    if panel == nil then return end

    local blurX, blurY = panel:LocalToScreen(0, 0)

    for i = 0.33, 1, 0.33 do

        blurMat:SetFloat("$blur", strength * i)
        blurMat:Recompute()
        if (render) then render.UpdateScreenEffectTexture() end
        surface.DrawTexturedRect(blurX * -1, blurY * -1, ScrW(), ScrH())

    end

end

-- death perspective
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

function GetEntityBodygroups(ent, override)

    local bg = {}

    for i = 0, ent:GetNumBodyGroups() - 1 do

		if override and override[i] then

			bg[i] = override[i]

		else

			if ent:GetBodygroupCount(i) <= 1 then continue end
			bg[i] = ent:GetBodygroup(i)

		end

	end

	if next(bg) then

		return bg

	end

end

function GetEntitySkin(ent, override)

	if override then return override end
	if ent:SkinCount() > 1 then return ent:GetSkin() end

end

function GetEntityGroups(ent, override)

	local groups = {}

	groups.Bodygroups = GetEntityBodygroups(ent, override and override.Bodygroups)
	groups.Skin = GetEntitySkin(ent, override and override.Skin)

	if next(groups) then

		return groups

	end

end

hook.Add("CalcView", "PovDeath", function(ply, pos, angles, fov)

    local ragdoll = ply:GetRagdollEntity()
    local target = ply:GetObserverTarget()

    if IsValid(ragdoll) and (ragdoll == target or not IsValid(target)) then return Calc(ply, pos, angles, fov, ragdoll) end
    if IsValid(target) and target:GetClass() == "prop_ragdoll" then return Calc(ply, pos, angles, fov, target) end

end)

-- smooth derma scrolling
local length = 0.4
local ease = 0.25
local amount = 60

hook.Add("PreGamemodeLoaded", "SmoothScrolling", function()

	local function sign(num) return num > 0 end

	local function getBiggerPos(signOld, signNew, old, new)

		if signOld != signNew then return new end

		if signNew then return math.max(old, new) else return math.min(old, new) end

	end

	local dermaCtrs = vgui.GetControlTable("DVScrollBar")
	local tScroll = 0
	local newerT = 0

	function dermaCtrs:AddScroll(dlta)

		self.Old_Pos = nil
		self.Old_Sign = nil

		local OldScroll = self:GetScroll()
		dlta = dlta * amount

		local anim = self:NewAnimation(length, 0, ease)
		anim.StartPos = OldScroll
		anim.TargetPos = OldScroll + dlta + tScroll
		tScroll = tScroll + dlta

		local ctime = RealTime()
		local doing_scroll = true
		newerT = ctime

		anim.Think = function(anim, pnl, fraction)

			local nowpos = Lerp(fraction, anim.StartPos, anim.TargetPos)
			if ctime == newerT then

				self:SetScroll(getBiggerPos(self.Old_Sign, sign(dlta), self.Old_Pos, nowpos))
				tScroll = tScroll - (tScroll * fraction)

			end

			if doing_scroll then

				self.Old_Sign = sign(dlta)
				self.Old_Pos = nowpos

			end

			if ctime != newerT then doing_scroll = false end

		end

		return math.Clamp(self:GetScroll() + tScroll, 0, self.CanvasSize) != self:GetScroll()

	end

	derma.DefineControl("DVScrollBar", "Smooth Scrollbar", dermaCtrs, "Panel")

end)

-- free look
local limV = 35
local limH = 80

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

local function holdingbind(ply) return freelooking end

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

    ang.p = ang.p + CoolAng.p / 2.5
    ang.y = ang.y + CoolAng.y / 2.5

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