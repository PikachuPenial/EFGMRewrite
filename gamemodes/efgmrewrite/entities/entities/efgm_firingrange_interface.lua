
ENT.Type = "point"
ENT.Base = "base_point"

function ENT:AcceptInput(name, ply, caller, data)

    if name == "SetPlayerInRange" then

        local enteredRange = tobool(data)

        if !IsValid(ply) then return end
        if !ply:Alive() then return end

        if enteredRange then

            for _, wep in ipairs(ply:GetWeapons()) do

                local def = EFGMITEMS[wep:GetClass()]

                if !def then continue end
                if def.equipType != EQUIPTYPE.Weapon then continue end

                local clip1 = wep:Clip1()
                local clip2 = wep:Clip2()
                local maxClip1 = wep:GetMaxClip1()
                local maxClip2 = wep:GetMaxClip2()

                if clip1 > 0 and maxClip1 > 0 then

                    local itemData = {}
                    itemData.count = wep:Clip1()
                    FlowItemToInventory(ply, wep.Ammo, EQUIPTYPE.Ammunition, itemData)

                end

                if clip2 > 0 and maxClip2 > 0 then

                    local itemData = {}
                    itemData.count = wep:Clip2()
                    FlowItemToInventory(ply, wep.UBGLAmmo, EQUIPTYPE.Ammunition, itemData)

                end

                if maxClip1 > 0 then wep:SetClip1(wep:GetMaxClip1()) end
                if maxClip2 > 0 then wep:SetClip2(wep:GetMaxClip2()) end

            end

            ReloadInventory(ply)
            ply:SetNWBool("InRange", true)

            net.Start("SendNotification", false)
            net.WriteString("Entered Firing Range")
            net.WriteString("icons/range_icon.png")
            net.WriteString("range_enter.wav")
            net.Send(ply)

        else

            if ply:CompareStatus(3) then return end

            for _, wep in ipairs(ply:GetWeapons()) do

                local def = EFGMITEMS[wep:GetClass()]

                if !def then continue end
                if def.equipType != EQUIPTYPE.Weapon then continue end

                local maxClip1 = wep:GetMaxClip1()
                local maxClip2 = wep:GetMaxClip2()

                if maxClip1 > 0 then wep:SetClip1(0) end
                if maxClip2 > 0 then wep:SetClip2(0) end

            end

            ply:SetNWBool("InRange", false)

            net.Start("SendNotification", false)
            net.WriteString("Left Firing Range")
            net.WriteString("icons/range_icon.png")
            net.WriteString("range_leave.wav")
            net.Send(ply)

        end

    end

end