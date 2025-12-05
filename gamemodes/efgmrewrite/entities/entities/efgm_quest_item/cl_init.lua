include("shared.lua")

ENT.ShouldPlayerDraw = true
ENT.HasPickedUp = false
ENT.Model = ""

function ENT:Initialize()

    local item = self:GetNWString("Item", "")

    print("Item = "..item)

    self.Model = item

end

function ENT:Draw()

    -- TODO: Network whether player should draw the item

    if self.ShouldPlayerDraw and !self.HasPickedUp then
	    self:DrawModel()
    end
end