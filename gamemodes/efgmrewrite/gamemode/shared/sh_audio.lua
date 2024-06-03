local shotCaliber = {}
shotCaliber[3] = 200 -- pistol
shotCaliber[5] = 50 -- .357
shotCaliber[4] = 120 -- smg1
shotCaliber[7] = 100 -- buckshot
shotCaliber[1] = 75 -- ar2
shotCaliber[13] = 50 -- sniper
shotCaliber[14] = 50 -- sniper alt.
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
						net.WriteInt(bulletPitch)
						net.Send(v)
					end
				end
			end
		end
	end)
end

net.Receive("DistantGunAudio", function()
	local receivedVect = net.ReadVector()
	local distance = net.ReadFloat()
	local pitch = net.ReadInt()

	if receivedVect then
		sound.Play(shotSounds[math.random(#shotSounds)], receivedVect, math.min(169, (169 * 4500) / distance), pitch + math.random(-20, 20), 1)
	end
end)