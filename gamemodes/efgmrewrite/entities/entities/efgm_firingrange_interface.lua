
ENT.Type = "point"
ENT.Base = "base_point"

function ENT:AcceptInput(name, ply, caller, data)

    if name == "SetPlayerInRange" then

        local enteredRange = tobool(data)

        if !ply:Alive() then return end

        if enteredRange then

            for k, v in ipairs(ply:GetWeapons()) do

                local clip1 = v:Clip1()
                if clip1 != -1 and clip1 != 0 then

                    local itemData = {}
                    itemData.count = v:Clip1()
                    FlowItemToInventory(ply, v.Ammo, EQUIPTYPE.Ammunition, itemData)

                end

                v:SetClip1(v:GetMaxClip1())

            end

            ply:SetNWBool("InRange", true)

        else

            for k, v in ipairs(ply:GetWeapons()) do

                v:SetClip1(0)

            end

            ply:SetNWBool("InRange", false)

        end

    end

end