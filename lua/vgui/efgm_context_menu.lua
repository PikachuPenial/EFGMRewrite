local PANEL = {}

PANEL.ctxHeight = 0

function PANEL:Paint(w, h)

    BlurPanel(self, EFGM.MenuScale(5))

    surface.SetDrawColor(Colors.contextBackgroundColor)
    surface.DrawRect(0, 0, w, h)

    surface.SetDrawColor(Colors.contextBorder)
    surface.DrawRect(0, 0, w, EFGM.MenuScale(1))
    surface.DrawRect(0, h - 1, w, EFGM.MenuScale(1))
    surface.DrawRect(0, 0, EFGM.MenuScale(1), h)
    surface.DrawRect(w - 1, 0, EFGM.MenuScale(1), h)

end

function PANEL:Think()

    if (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_MIDDLE)) and !self:IsChildHovered() then self:KillFocus() end

end

function PANEL:OnFocusChanged(focus)

    if !focus then self:AlphaTo(0, 0.1, 0, function() self:Remove() end) end

end

function PANEL:SetTallAfterCTX()

    self:SetTall(self:GetTall() + self.ctxHeight)

end

vgui.Register("EFGMContextMenu", PANEL, "DPanel")