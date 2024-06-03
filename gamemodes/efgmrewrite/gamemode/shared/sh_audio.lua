local shotCaliber = {}
shotCaliber[3] = 180 -- pistol
shotCaliber[5] = 35 -- .357
shotCaliber[4] = 110 -- smg1
shotCaliber[7] = 140 -- buckshot
shotCaliber[1] = 75 -- ar2
shotCaliber[20] = 75 -- airboat gun

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

if SERVER then
    util.AddNetworkString("DistantGunAudio")

    hook.Add("EntityFireBullets", "ClientDistantGunAudio", function(attacker, data)
        for k, v in pairs(player.GetAll()) do

            local shootPos = attacker:GetPos()
            local plyDistance = attacker:GetPos():Distance(v:GetPos())
            local bulletPitch

            if attacker:GetActiveWeapon() != NULL then
                bulletPitch = shotCaliber[attacker:GetActiveWeapon():GetPrimaryAmmoType()] or 100
            else
                bulletPitch = 100
            end

            for i = 1, data.Num do
                if (plyDistance >= 2500) then
                    if (v != attacker) then
                        net.Start("DistantGunAudio")
						net.WriteVector(shootPos)
						net.WriteFloat(plyDistance)
						net.WriteInt(bulletPitch, 9)
						net.Send(v)
					end
				end
			end
		end
	end)
end

if CLIENT then
    net.Receive("DistantGunAudio", function()
        local receivedVect = net.ReadVector()
        local distance = net.ReadFloat()
        local pitch = net.ReadInt(9)

        print(distance)
        print(math.min(169, (169 * 4500) / distance))

        if receivedVect then
            sound.Play(shotSounds[math.random(#shotSounds)], receivedVect, math.min(150, (150 * 4500) / distance), pitch + math.random(-15, 15), 1)
        end
    end)
end