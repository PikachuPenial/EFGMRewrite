local footsteps_int =
{
    [MAT_CONCRETE] = "concrete",
    [MAT_METAL] = "metal",
    [MAT_TILE] = "tile",
    [MAT_WOOD] = "wood",
    [MAT_DIRT] = "dirt",
    [MAT_GRASS] = "grass",
    [MAT_GLASS] = "glass",
    [MAT_VENT] = "vent",
    [MAT_SAND] = "sand",
    [MAT_GRATE] = "metal_grate",
    [MAT_SNOW] = "snow",
    [MAT_PLASTIC] = "plastic"
}

local types = {
    "ceiling",
    "chainlink",
    "concrete",
    "dirt",
    "drywall",
    "glass",
    "grass",
    "gravel",
    "ladder",
    "metal",
    "metal_box",
    "metal_grate",
    "mud",
    "plastic",
    "rubber",
    "sand",
    "snow",
    "tile",
    "vent",
    "water",
    "wood",
    "wood_panel"
}

local ways = {
    "jump",
    "land"
}

local ladder_ways = {
    "hands",
    "foot"
}

local volumes_forways =
{
    ["jump"] = 1,
    ["land"] = 1
}

local foot = {
    "l",
    "r"
}

for i = 1, 9 do
    for _, w in pairs(ways) do
        if w == "land" or w == "jump" then continue end
        sound.Add( {
            name = "mfwmvmt.pre_" .. w .. i,
            channel = CHAN_AUTO,
            volume = cloth_layer[w],
            level = 50,
            pitch = 100,
            sound = "foley/mvmt/cloth/" .. w .. "/mvmtstep_cloth_plr_" .. w .. "_pre_0" .. i .. ".wav"
        } )
    end
end

for i = 1, 9 do
    for _, w in pairs(ways) do
        if w == "land" or w == "jump" then continue end
        sound.Add( {
            name = "mfwmvmt.post_" .. w .. i,
            channel = CHAN_AUTO,
            volume = cloth_layer[w],
            level = 84,
            pitch = 100,
            sound = "foley/mvmt/cloth/" .. w .. "/mvmtstep_cloth_plr_" .. w .. "_post_0" .. i .. ".wav"
        } )
    end
end

for i = 1,20 do
    sound.Add({
        name = "mfwmvmt.gear_accent" .. i,
        channel = CHAN_AUTO,
        volume = 1,
        level = 30,
        pitch = {95, 105},
        sound = "foley/mvmt/accents/gear_accent" .. i .. ".wav"
    })
end

for i = 1, 5 do
    for _, t in pairs(types) do
        for _, w in pairs(ways) do
            if (w != "land" and w != "jump") then continue end
            local vlm = volumes_forways[w]

            sound.Add( {
                name = "mfw." .. t .. "_" .. w .."_" .. i,
                channel = CHAN_AUTO,
                volume = vlm,
                level = 84,
                pitch = 100,
                sound = "foley/foot/" .. t .. "/step_" .. w .. "_" .. t .. "_0" .. i .. ".wav"
            } )
        end
    end
end

for i = 1, 5 do
    for _, w in pairs(ladder_ways) do
        for _, f in pairs(foot) do
            sound.Add( {
                name = "mfw.ladder_" .. w .. "_" .. f .. "_0" .. i,
                channel = CHAN_AUTO,
                volume = 1.0,
                level = 84,
                pitch = 100,
                sound = "foley/foot/ladder/step_climb_" .. w .. "_ladder_" .. f .. "_0" .. i .. ".wav"
            } )
        end
    end
end

sound.Add( {
    name = "Player.FallDamage",
    channel = CHAN_AUTO,
    volume = 1.0,
    level = 84,
    pitch = 100,
    sound = { "foley/foot/damage/step_land_damage_01.wav",
    "foley/foot/damage/step_land_damage_02.wav" }
} )

sound.Add( {
    name = "Player.FallGib",
    channel = CHAN_AUTO,
    volume = 1.0,
    level = 84,
    pitch = 100,
    sound = { "foley/foot/damage/step_land_damage_death_01.wav",
    "foley/foot/damage/step_land_damage_death_02.wav" }
} )

for i = 1, 5 do

    for _, t in pairs(types) do

        for _, w in pairs(ways) do

            if (w != "land" and w != "jump") then continue end

            local vlm = volumes_forways[w]

            sound.Add( {
                name = "mfw." .. t .. "_" .. w .."_" .. i,
                channel = CHAN_AUTO,
                volume = vlm,
                level = 80,
                pitch = 100,
                sound = "foley/foot/" .. t .. "/step_" .. w .. "_" .. t .. "_0" .. i .. ".wav"
            } )

        end

    end

end

hook.Add("PlayerFootstep", "CustomFootstepVolume", function(ply, pos, foot, sound, volume)

    if !IsValid(ply) then return true end

    local step = "l"
    if (foot == 1) then step = "r" end

    if string.StartWith(sound, "player/footsteps/ladder") then

        ply:EmitSound("mfw.ladder_hands_" .. step .. "_0" .. math.random(1,5))
        ply:EmitSound("mfwmvmt.gear_accent" .. math.random(1,20))

        timer.Simple(0.25, function()
            ply:EmitSound("mfw.ladder_foot_" .. step .. "_0" .. math.random(1,5))
        end)

        return true

    end

    if !ply:GetNW2Bool("DoStep", false) then return true end

    local fsVol = 1
    local fsLvl = 80
    if ply:Crouching() or ply:IsWalking() then fsVol = 0.25 fsLvl = 73 end

    local soundLevel = math.Clamp(fsLvl, 73, 160)

    ply:EmitSound(sound, soundLevel, 100, math.min(fsVol, 1))
    Raycast26(ply)

    return true

end)

if SERVER then

    hook.Add("OnPlayerJump", "SoundOnJump", function(ply, speed)

        local material = "drywall"

        ply:EmitSound("mfw." .. material .. "_jump_" .. math.random(1,5))

    end)

    hook.Add("OnPlayerHitGround", "SoundOnLanding", function(ply, speed)

        local tr = util.TraceLine( {
            start = ply:GetPos(),
            endpos = ply:GetPos() + ply:GetAngles():Up() * -10
        } )

        if (ply:WaterLevel() == 1) then
            ply:EmitSound("mfw.water_land_" .. math.random(1,5))
        end

        if (footsteps_int[tr.MatType] == nil) then return end

        ply:EmitSound("mfw." .. footsteps_int[tr.MatType] .. "_land_" .. math.random(1,5)) 

    end)

end

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

shotCaliber["efgm_ammo_300"] =  {75, 6000, "bullet"}
shotCaliber["efgm_ammo_338"] =  {35, 20000, "bullet"}
shotCaliber["efgm_ammo_357"] =  {180, 3000, "bullet"}
shotCaliber["efgm_ammo_366"] =  {75, 6000, "bullet"}
shotCaliber["efgm_ammo_45"] =   {180, 3000, "bullet"}
shotCaliber["efgm_ammo_50ae"] = {75, 6000, "bullet"}
shotCaliber["efgm_ammo_50bmg"] = {35, 20000, "bullet"}
shotCaliber["efgm_ammo_127x55"] = {55, 8000, "bullet"}
shotCaliber["efgm_ammo_12gauge"] = {140, 3000, "bullet"}
shotCaliber["efgm_ammo_20gauge"] = {140, 3000, "bullet"}
shotCaliber["efgm_ammo_4gauge"] = {120, 3000, "bullet"}
shotCaliber["efgm_ammo_26x75"] = {220, 3000, "bullet"}
shotCaliber["efgm_ammo_46x30"] = {110, 4500, "bullet"}
shotCaliber["efgm_ammo_545x39"] = {85, 6000, "bullet"}
shotCaliber["efgm_ammo_556x45"] = {85, 6000, "bullet"}
shotCaliber["efgm_ammo_57x28"] = {110, 4500, "bullet"}
shotCaliber["efgm_ammo_68x51"] = {65, 6000, "bullet"}
shotCaliber["efgm_ammo_762x25"] = {190, 3000, "bullet"}
shotCaliber["efgm_ammo_762x39"] = {75, 6000, "bullet"}
shotCaliber["efgm_ammo_762x51"] = {70, 7000, "bullet"}
shotCaliber["efgm_ammo_762x54"] = {60, 7000, "bullet"}
shotCaliber["efgm_ammo_9x18"] = {180, 3000, "bullet"}
shotCaliber["efgm_ammo_9x19"] = {180, 3000, "bullet"}
shotCaliber["efgm_ammo_9x21"] = {150, 4500, "bullet"}
shotCaliber["efgm_ammo_9x39"] = {150, 2500, "bullet"}

if SERVER then

    util.AddNetworkString("DistantGunAudio")

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

            sound.Play(chosenSound, receivedVect, math.min(150, (150 * threshold) / distance), math.Clamp(pitch, 0, 254) + math.random(-15, 15), math.Rand(volume - 0.2, volume))

        end

    end)

end