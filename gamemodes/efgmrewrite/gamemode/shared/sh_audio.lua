
-- footsteps
hook.Add("PlayerFootstep", "FootSteps", function(ply)

	if ply:GetMoveType() == MOVETYPE_LADDER then

		return

	end

end)

-- gun sounds
shotSounds = {
    "cracks/distant/dist01.ogg",
    "cracks/distant/dist02.ogg",
    "cracks/distant/dist03.ogg",
    "cracks/distant/dist04.ogg",
    "cracks/distant/dist05.ogg",
    "cracks/distant/dist06.ogg",
    "cracks/distant/dist07.ogg",
    "cracks/distant/dist08.ogg"
}

boomSounds = {
    "weapons/darsu_eft/m203/gren_expl2_indoor_distant.ogg"
}

shotCaliber = {} -- pitch, threshold, style

-- weapons
shotCaliber[3] =  {180, 3000, "bullet"}   -- pistol
shotCaliber[5] =  {35, 20000, "bullet"}   -- .357
shotCaliber[4] =  {110, 4500, "bullet"}   -- smg1
shotCaliber[7] =  {140, 3000, "bullet"}   -- buckshot
shotCaliber[1] =  {75, 6000, "bullet"}    -- ar2
shotCaliber[20] = {75, 6000, "bullet"}    -- airboat gun (should be the mounted guns on customs fortress?)

-- entities
shotCaliber["Grenade"] = {60, 8000, "boom"}      -- grenade (sex for the first person to guess what this is for)
shotCaliber["Pistol"] = {180, 0, "bullet"}       -- grenade shrapnel (no sex this time sorry guys)

-- true gun version has been moved to sh_arc9_override.lua to fix audio playing at bullets destination
if SERVER then

    util.AddNetworkString("DistantGunAudio")

    hook.Add("EntityFireBullets", "ClientDistantGunAudio", function(attacker, data)

        for k, v in pairs(player.GetAll()) do

            -- a hacky way to distinquish an ARC9 weapon and an entity, ARC9 doesn't set an AmmoType, we use this to create the monstrosity you are about to read 
            if data.AmmoType != "" then

                local entAmmo = data.AmmoType

                -- no reason to have distant audio for flashbangs
                if entAmmo == "Flash" then return end

                local shootPos = attacker:GetPos()
                local plyDistance = attacker:GetPos():Distance(v:GetPos())
                local bulletPitch
                local threshold
                local style = shotCaliber[entAmmo][3] == "bullet" -- returns true if bullet, false if explosive

                print(entAmmo)

                if entAmmo != nil then

                    bulletPitch = shotCaliber[entAmmo][1] or 100
                    threshold = shotCaliber[entAmmo][2] or 6000

                else

                    bulletPitch = 100
                    threshold = 6000

                end

                for i = 1, data.Num do

                    net.Start("DistantGunAudio")
                    net.WriteVector(shootPos)
                    net.WriteFloat(plyDistance)
                    net.WriteInt(bulletPitch, 9)
                    net.WriteInt(threshold, 16)
                    net.WriteFloat(1)
                    net.WriteBool(style)
                    net.Send(v)

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
        local volume = net.ReadFloat()
        local style = net.ReadBool()

        if style == true then

            chosenSound = shotSounds[math.random(#shotSounds)]

        else

            chosenSound = boomSounds[math.random(#boomSounds)]

        end

        if receivedVect then

            sound.Play(chosenSound, receivedVect, math.min(150, (150 * threshold) / distance), pitch + math.random(-15, 15), math.Rand(volume - 0.2, volume))

        end

    end)

end