local FootstepAlias = {
    ["physics/cardboard/cardboard_box_impact_soft"] = "rubber",
    ["physics/plaster/ceiling_tile_step"] = "ceiling",
    ["player/footsteps/chainlink"] = "metal_grate",
    ["player/footsteps/concrete"] = "concrete",
    ["player/footsteps/dirt"] = "dirt",
    ["physics/plaster/drywall_footstep"] = "drywall",
    ["physics/glass/glass_sheet_step"] = "glass",
    ["player/footsteps/grass"] = "grass",
    ["player/footsteps/gravel"] = "gravel",
    ["player/footsteps/metal"] = "metal",
    ["physics/metal/metal_box_footstep"] = "metal_box",
    ["player/footsteps/metalgrate"] = "metal_grate",
    ["player/footsteps/mud"] = "mud",
    ["physics/plastic/plastic_barrel_impact_soft"] = "plastic",
    ["physics/plastic/plastic_box_impact_soft"] = "plastic",
    ["player/footsteps/rubber"] = "rubber",
    ["player/footsteps/sand"] = "sand",
    ["player/footsteps/snow"] = "snow",
    ["player/footsteps/tile"] = "tile",
    ["player/footsteps/duct"] = "vent",
    ["player/footsteps/slosh"] = "water",
    ["player/footsteps/wood"] = "wood",
    ["physics/wood/wood_box_footstep"] = "wood",
    ["player/footsteps/woodpanel"] = "wood_panel"
}

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
            level = 80,
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
                level = 80,
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
                level = 80,
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
    level = 90,
    pitch = 100,
    sound = { "foley/foot/damage/step_land_damage_01.wav",
    "foley/foot/damage/step_land_damage_02.wav" }
} )

sound.Add( {
    name = "Player.FallGib",
    channel = CHAN_AUTO,
    volume = 1.0,
    level = 90,
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

    local material = ""

    for k, v in pairs(FootstepAlias) do

        if (string.StartWith(sound, k)) then

            material = v

        end

    end

    if GetPredictionPlayer() != NULL or !IsFirstTimePredicted() then

        local cmd = ply:GetCurrentCommand()

        if bit.band(cmd:GetButtons(), IN_JUMP) != 0 then

            ply:EmitSound("mfw." .. material .. "_jump_" .. math.random(1,5))
            return true

        end

    end

    if string.StartWith(sound, "player/footsteps/ladder") then

        ply:EmitSound("mfw.ladder_hands_" .. step .. "_0" .. math.random(1,5))
        ply:EmitSound("mfwmvmt.gear_accent" .. math.random(1,20))

        timer.Simple(0.25, function()
            ply:EmitSound("mfw.ladder_foot_" .. step .. "_0" .. math.random(1,5))
        end)

        return true

    end

    if ply:GetNW2Bool("DoStep", false) then

        local fsVol = 1
        if ply:Crouching() or ply:IsWalking() then fsVol = 0.25 end

        local soundLevel = math.Clamp(65 + (fsVol * 15), 65, 160)

        ply:EmitSound(sound, soundLevel, 100, math.min(fsVol, 1))
        Raycast26(ply)

        return true

    end

    return true

end)

if SERVER then

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