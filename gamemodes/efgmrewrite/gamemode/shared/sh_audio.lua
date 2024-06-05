
-- sounds
local shotSounds = {
    "cracks/distant/dist01.ogg",
    "cracks/distant/dist02.ogg",
    "cracks/distant/dist03.ogg",
    "cracks/distant/dist04.ogg",
    "cracks/distant/dist05.ogg",
    "cracks/distant/dist06.ogg",
    "cracks/distant/dist07.ogg",
    "cracks/distant/dist08.ogg"
}

local boomSounds = {
    "weapons/darsu_eft/m203/gren_expl2_indoor_distant.ogg"
}

local shotCaliber = {} -- pitch, threshold, style

-- weapons
shotCaliber[3] =  {180, 3000, "bullet"}   -- pistol
shotCaliber[5] =  {35, 25000, "bullet"}   -- .357
shotCaliber[4] =  {110, 4250, "bullet"}   -- smg1
shotCaliber[7] =  {140, 3000, "bullet"}   -- buckshot
shotCaliber[1] =  {75, 5250, "bullet"}    -- ar2
shotCaliber[20] = {75, 5250, "bullet"}    -- airboat gun (should be the mounted guns on customs fortress?)

-- entities
shotCaliber["Grenade"] = {60, 6500, "boom"}  -- grenade (sex for the first person to guess what this is for)
shotCaliber["Pistol"] = {180, 3000, "bullet"}    -- grenade shrapnel (no sex this time sorry guys)

if SERVER then
    util.AddNetworkString("DistantGunAudio")

    hook.Add("EntityFireBullets", "ClientDistantGunAudio", function(attacker, data)
        for k, v in pairs(player.GetAll()) do

            -- a hacky way to distinquish an ARC9 weapon and an entity, ARC9 doesn't set an AmmoType, we use this to create the monstrosity you are about to read 
            if data.AmmoType == "" then
                -- weapon detected
                local wep = attacker:GetActiveWeapon()
                local shootPos = attacker:GetPos()
                local plyDistance = attacker:GetPos():Distance(v:GetPos())
                local bulletPitch
                local threshold
                local style = shotCaliber[wep:GetPrimaryAmmoType()][3] == "bullet" -- returns true if bullet, false if explosive

                if wep != nil then
                    bulletPitch = shotCaliber[wep:GetPrimaryAmmoType()][1] or 100
                    threshold = shotCaliber[wep:GetPrimaryAmmoType()][2] or 6000
                else
                    bulletPitch = 100
                    threshold = 6000
                end

                for i = 1, data.Num do
                    if (plyDistance >= 2500) then
                        if (v != attacker) then
                            net.Start("DistantGunAudio")
                            net.WriteVector(shootPos)
                            net.WriteFloat(plyDistance)
                            net.WriteInt(bulletPitch, 9)
                            net.WriteInt(threshold, 16)
                            net.WriteBool(style)
                            net.Send(v)
                        end
                    end
                end
            else
                -- entity detected
                local entAmmo = data.AmmoType

                -- no reason to have distant audio for flashbangs
                if entAmmo == "Flash" then
                    return
                end

                local shootPos = attacker:GetPos()
                local plyDistance = attacker:GetPos():Distance(v:GetPos())
                local bulletPitch
                local threshold
                local style = shotCaliber[entAmmo][3] == "bullet" -- returns true if bullet, false if explosive

                if entAmmo != nil then
                    bulletPitch = shotCaliber[entAmmo][1] or 100
                    threshold = shotCaliber[entAmmo][2] or 6000
                else
                    bulletPitch = 100
                    threshold = 6000
                end

                for i = 1, data.Num do
                    if (plyDistance >= 2500) then
                        if (v != attacker) then
                            net.Start("DistantGunAudio")
                            net.WriteVector(shootPos)
                            net.WriteFloat(plyDistance)
                            net.WriteInt(bulletPitch, 9)
                            net.WriteInt(threshold, 16)
                            net.WriteBool(style)
                            net.Send(v)
                        end
                    end
                end
            end
		end
	end)
end

if CLIENT then
    net.Receive("DistantGunAudio", function()
        local chosenSound
        local receivedVect = net.ReadVector()
        local distance = net.ReadFloat()
        local pitch = net.ReadInt(9)
        local threshold = net.ReadInt(16)
        local style = net.ReadBool()

        if style == true then
            chosenSound = shotSounds[math.random(#shotSounds)]
        else
            chosenSound = boomSounds[math.random(#boomSounds)]
        end

        if receivedVect then
            sound.Play(chosenSound, receivedVect, math.min(150, (150 * threshold) / distance), pitch + math.random(-15, 15), math.Rand(0.8, 1))
        end
    end)
end