local DSCROLLPANEL = {}

DSCROLLPANEL.AllowLayoutUpdate = true

function DSCROLLPANEL:Rebuild()

    if !self.AllowLayoutUpdate then return end
    self.BaseClass.Rebuild(self)

end

function DSCROLLPANEL:PerformLayoutInternal()

    if !self.AllowLayoutUpdate then return end
    self.BaseClass.PerformLayoutInternal(self)

end

function DSCROLLPANEL:PerformLayout(width, height)

    if !self.AllowLayoutUpdate then return end
    self.BaseClass.PerformLayout(self, width, height)

end

function DSCROLLPANEL:InvalidateLayout(layoutNow)

    if !self.AllowLayoutUpdate then return end
    self.BaseClass.InvalidateLayout(self, layoutNow)

end

vgui.Register("EFGMInventoryHolderScroller", DSCROLLPANEL, "DScrollPanel")