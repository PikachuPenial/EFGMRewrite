
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

local volumes_forways =
{
    ["jump"] = 0.25,
    ["land"] = 0.75
}

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

    if IsValid(ply) and ply:GetNW2Bool("DoStep", false) then

        local fsVol = 1
        if ply:Crouching() or ply:IsWalking() then fsVol = 0.25 end

        local soundLevel = math.Clamp(70 + (fsVol * 15), 70, 160)

        ply:EmitSound(sound, soundLevel, 100, math.min(fsVol, 1))
        Raycast26(ply)

        return true

    end

    return true

end)

hook.Add( "OnPlayerHitGround", "LandingSound", function( ply, speed )

    print("HI")

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