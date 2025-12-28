local BUTTON = {}

BUTTON.Parent = nil
BUTTON.OnClickEvent = nil
BUTTON.OnClickSound = nil

function BUTTON:Init()

    self:Dock(TOP)
    self:SetFont("PuristaBold16")
    self:SetTall(EFGM.MenuScale(25))
    self.Parent = self:GetParent()
    if self.OnClickSound == nil then self.OnClickSound = "ui/element_select.wav" end
    if self.Parent then self.Parent.ctxHeight = self.Parent.ctxHeight + EFGM.MenuScale(25) end

end

function BUTTON:OnCursorEntered()

    surface.PlaySound("ui/element_hover_" .. math.random(1, 3) .. ".wav")

end

function BUTTON:DoClick()

    if !isfunction(self.OnClickEvent) then surface.PlaySound("ui/element_deselect.wav") return end

    if self.OnClickSound != "nil" then surface.PlaySound(self.OnClickSound) end
    if self.Parent then self.Parent:KillFocus() end

    self.OnClickEvent()

end

vgui.Register("EFGMContextButton", BUTTON, "DButton")