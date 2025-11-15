ENT.Type = "point"
ENT.Base = "base_point"

-- These are defined by the entity in hammer

ENT.KeyName = ""

function ENT:KeyValue(key, value)
	if key == "keyName" then
		self.KeyName = tostring(value)
	end


	if key == "OnHasKey" then
		self:StoreOutput(key, value)
	end

end

function ENT:AcceptInput(name, ply, caller, data)

	if name == "CheckKey" then
        
        if AmountInInventory(ply.inventory, self.KeyName) == 0 then

            self:TriggerOutput( "OnNotHasKey", ply, data )

        else

            self:TriggerOutput( "OnHasKey", ply, data )

        end

    end

end