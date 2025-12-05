ENT.Type = "point"
ENT.Base = "base_point"

-- These are defined by the entity in hammer

ENT.KeyName = ""
ENT.PlayersUsed = {}

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

        if AmountInInventory(ply.inventory, self.KeyName) == 0 and self.PlayersUsed[ply:SteamID64()] == nil then

            self:TriggerOutput( "OnNotHasKey", ply, data )

        else

            local keyWithLowestDura = 0
            local lowestDura = 0

            for k, v in ipairs(ply.inventory) do

                if !table.IsEmpty(v) and v.name == self.KeyName and v.data.durability > lowestDura then

                    keyWithLowestDura = k
                    lowestDura = v.data.durability

                end

            end

            if keyWithLowestDura == 0 then return end

            self:TriggerOutput( "OnHasKey", ply, data )

            local item = ply.inventory[keyWithLowestDura]
            local durability = item.data.durability

            ply.inventory[keyWithLowestDura].data.durability = durability - 1

            if ply.inventory[keyWithLowestDura].data.durability > 0 then

                net.Start("PlayerInventoryUpdateItem", false)
                net.WriteTable(item.data)
                net.WriteUInt(keyWithLowestDura, 16)
                net.Send(ply)

                UpdateInventory(ply)

            else

                net.Start("PlayerInventoryDeleteItem", false)
                net.WriteUInt(keyWithLowestDura, 16)
                net.Send(ply)

                table.remove(ply.inventory, keyWithLowestDura)

                UpdateInventory(ply)
                RemoveWeightFromPlayer(ply, item.name, item.data.count)

            end

            -- so opening a double door or something doesn't take up two uses
            self.PlayersUsed[ply:SteamID64()] = true

        end

    end

end