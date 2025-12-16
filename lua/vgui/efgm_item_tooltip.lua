
local PANEL = {}

function PANEL:Init()

	self:SetDrawOnTop(true)
	self.DeleteContentsOnClose = false

end

function PANEL:SetContents(panel, bDelete)

	panel:SetParent(self)

	self.Contents = panel
	self.DeleteContentsOnClose = bDelete or false
	self.Contents:SizeToContents()
	self:InvalidateLayout(true)

	self.Contents:SetVisible(false)

end

function PANEL:PositionTooltip()

	if (!IsValid(self.TargetPanel)) then
		self:Close()
		return
	end

	self:InvalidateLayout(true)

	local x, y = input.GetCursorPos()
	local w, h = self:GetSize()

	y = y - h - EFGM.MenuScale(10)

	if (y < 2) then y = EFGM.MenuScale(2) end

	self:SetPos(math.Clamp(x - w * 0.5, 0, ScrW() - self:GetWide()), math.Clamp(y, 0, ScrH() - self:GetTall()))

end

function PANEL:Paint(w, h)

    self:PositionTooltip()
    BlurPanel(self, EFGM.MenuScale(3))
    derma.SkinHook("Paint", "Tooltip", self, w, h)

end

function PANEL:OpenForPanel(panel)

    self.TargetPanel = panel
    self.OpenDelay = 0.4
    self:PositionTooltip()

    -- Use the parent panel's skin
    self:SetSkin(panel:GetSkin().Name)

    if (self.OpenDelay > 0) then

        self:SetVisible( false)
        timer.Simple(self.OpenDelay, function()

            if (!IsValid(self)) then return end
            if (!IsValid(panel)) then return end

            self:PositionTooltip()
            self:SetVisible(true)

        end )

    end

end

function PANEL:Close()

    if (!self.DeleteContentsOnClose and IsValid(self.Contents)) then

        self.Contents:SetVisible(false)
        self.Contents:SetParent(nil)

    end

    self:Remove()

end

vgui.Register("EFGM_ItemTooltip", PANEL, "DTooltip")