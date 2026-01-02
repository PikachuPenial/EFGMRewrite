local DICONLAYOUT = {}

DICONLAYOUT.AllowLayoutUpdate = true

function DICONLAYOUT:LayoutIcons_TOP()

    if !self.AllowLayoutUpdate then return end
    self.BaseClass.LayoutIcons_TOP(self)

end

function DICONLAYOUT:LayoutIcons_LEFT()

    if !self.AllowLayoutUpdate then return end
    self.BaseClass.LayoutIcons_LEFT(self)

end


function DICONLAYOUT:PerformLayout(width, height)

    if !self.AllowLayoutUpdate then return end
    self.BaseClass.PerformLayout(self, width, height)

end

function DICONLAYOUT:InvalidateLayout(layoutNow)

    if !self.AllowLayoutUpdate then return end
    self.BaseClass.InvalidateLayout(self, layoutNow)

end

vgui.Register("EFGMInventoryHolder", DICONLAYOUT, "DIconLayout")