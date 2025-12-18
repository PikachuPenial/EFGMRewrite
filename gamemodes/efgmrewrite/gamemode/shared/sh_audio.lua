if SERVER and !game.SinglePlayer() then

    CRF = {}
    CRF[1] = RecipientFilter() -- hideout
    CRF[2] = RecipientFilter() -- in raid

    function UpdateAudioFilter(ply, id)

        if !IsValid(ply) then return end
        RemovePlayerFromAllFilters(ply)

        local f = 1
        if id == 1 or id == 2 then f = 2 end

        CRF[f]:AddPlayer(ply)

    end

    function RemovePlayerFromAllFilters(ply)

        for index, filter in ipairs(CRF) do
            filter:RemovePlayer(ply)
        end

    end

    hook.Add("PlayerInitialSpawn", "AddToDefaultFilterOnConnect", function(ply)

        CRF[1]:AddPlayer(ply)

    end)

    hook.Add("PlayerDisconnected", "RemoveFromFiltersOnDC", function(ply)

        RemovePlayerFromAllFilters(ply)

    end)

end

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

for i = 1, 6 do
    sound.Add( {
        name = "char_crouch_0" .. i,
        channel = CHAN_AUTO,
        volume = 0.15,
        level = 60,
        pitch = 105,
        sound = "crouch/char_crouch_0" .. i .. ".wav"
    } )
end

for i = 1, 6 do
    sound.Add( {
        name = "char_stand_0" .. i,
        channel = CHAN_AUTO,
        volume = 0.15,
        level = 60,
        pitch = 105,
        sound = "standup/char_stand_0" .. i .. ".wav"
    } )
end

for i = 1, 5 do
    sound.Add( {
        name = "rattle_" .. i,
        channel = CHAN_AUTO,
        volume = 0.2,
        level = 80,
        pitch = 100,
        sound = "foley/rattle/longweapon_jam_rattle" .. i .. ".wav"
    } )
end

for i = 1, 7 do
    sound.Add( {
        name = "rotate_" .. i,
        channel = CHAN_AUTO,
        volume = 0.2,
        level = 80,
        pitch = 100,
        sound = "foley/rotate/char_foley_gear_shake_long_0" .. i .. ".wav"
    } )
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

    local vel = ply:GetVelocity()
    local speed = vel:LengthSqr()

    if ply:Crouching() or ply:IsWalking() or speed < 1 then fsVol = 0.25 fsLvl = 73 end

    local soundLevel = math.Clamp(fsLvl, 73, 160)

    ply:EmitSound(sound, soundLevel, 100, math.min(fsVol, 1))
    Raycast26(ply)

    ply:SetNW2Bool("DoStep", false)

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

    local SmallRatio = 10
    local BigRatio = 50
    local RatioDelayCheck = 0.2

    local function SmallTurn(ply)

        if ply.NextSmallTurn <= CurTime() then

            ply.NextSmallTurn = CurTime() + 0.9
            ply:EmitSound("rattle_" .. math.random(1, 5), 80, math.random(95,105), 0.2, CHAN_AUTO)
            ply:EmitSound("rotate_" .. math.random(1, 7), 80, math.random(95,105), 0.2, CHAN_AUTO)

        end

    end

    local function BigTurn(ply)

        if ply.NextBigTurn <= CurTime() then

            ply:SetNW2Bool("DoStep", true)
            ply:PlayStepSound(0.25)

            timer.Simple(0.25,function()

                ply:EmitSound("rattle_" .. math.random(1, 5), 85, math.random(95,105), 0.35, CHAN_AUTO)
                ply:EmitSound("rotate_" .. math.random(1, 7), 85, math.random(95,105), 0.35, CHAN_AUTO)

            end)

            ply.NextBigTurn = CurTime() + 0.35

        end

    end

    -- turning sounds
    hook.Add("PlayerTick", "TurningSounds", function(ply, mv)

        if !ply.TurnReady then

            ply.NextTurn = CurTime()
            ply.OldAng = 0
            ply.CurrentAng = 0
            ply.TurnReady = true
            ply.NextBigTurn = CurTime()
            ply.NextSmallTurn = CurTime()
            return

        end

        if ply:GetMoveType() == MOVETYPE_NOCLIP then return end

        ply.CurrentAng = mv:GetAbsMoveAngles().y

        local vel = ply:GetVelocity():Length()

        if ply.NextTurn <= CurTime() then
            ply.NextTurn = CurTime() + RatioDelayCheck
            if ply.OldAng != ply.CurrentAng then

                local a1 = math.abs(ply.OldAng)
                local a2 = math.abs(ply.CurrentAng)

                if math.abs(a1 - a2) >= SmallRatio and vel < 1 then
                    SmallTurn(ply)
                end

                if math.abs(a1 - a2) >= BigRatio and vel < 1 then
                    BigTurn(ply)
                end

                ply.OldAng = mv:GetAbsMoveAngles().y

            end

        end

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

-- ammunition
shotCaliber["efgm_ammo_300"] =      {75, 6000, "bullet"}
shotCaliber["efgm_ammo_338"] =      {35, 20000, "bullet"}
shotCaliber["efgm_ammo_357"] =      {180, 3000, "bullet"}
shotCaliber["efgm_ammo_366"] =      {75, 6000, "bullet"}
shotCaliber["efgm_ammo_45"] =       {180, 3000, "bullet"}
shotCaliber["efgm_ammo_50ae"] =     {75, 6000, "bullet"}
shotCaliber["efgm_ammo_50bmg"] =    {35, 20000, "bullet"}
shotCaliber["efgm_ammo_127x55"] =   {55, 8000, "bullet"}
shotCaliber["efgm_ammo_12gauge"] =  {140, 3000, "bullet"}
shotCaliber["efgm_ammo_20gauge"] =  {140, 3000, "bullet"}
shotCaliber["efgm_ammo_4gauge"] =   {120, 3000, "bullet"}
shotCaliber["efgm_ammo_26x75"] =    {220, 3000, "bullet"}
shotCaliber["efgm_ammo_46x30"] =    {110, 4500, "bullet"}
shotCaliber["efgm_ammo_545x39"] =   {85, 6000, "bullet"}
shotCaliber["efgm_ammo_556x45"] =   {85, 6000, "bullet"}
shotCaliber["efgm_ammo_57x28"] =    {110, 4500, "bullet"}
shotCaliber["efgm_ammo_68x51"] =    {65, 6000, "bullet"}
shotCaliber["efgm_ammo_762x25"] =   {190, 3000, "bullet"}
shotCaliber["efgm_ammo_762x39"] =   {75, 6000, "bullet"}
shotCaliber["efgm_ammo_762x51"] =   {70, 7000, "bullet"}
shotCaliber["efgm_ammo_308"] =      {70, 7000, "bullet"}
shotCaliber["efgm_ammo_762x54"] =   {60, 7000, "bullet"}
shotCaliber["efgm_ammo_9x18"] =     {180, 3000, "bullet"}
shotCaliber["efgm_ammo_9x19"] =     {180, 3000, "bullet"}
shotCaliber["efgm_ammo_9x21"] =     {150, 4500, "bullet"}
shotCaliber["efgm_ammo_9x39"] =     {150, 2500, "bullet"}
shotCaliber["efgm_ammo_93x64"] =    {30, 25000, "bullet"}

-- entities
shotCaliber["arc9_eft_grenade_f1"] =        {60, 10000, "boom"}
shotCaliber["arc9_eft_grenade_m67"] =       {60, 10000, "boom"}
shotCaliber["arc9_eft_grenade_rgd5"] =      {60, 10000, "boom"}
shotCaliber["arc9_eft_grenade_rgn"] =       {80, 8000, "boom"}
shotCaliber["arc9_eft_grenade_rgo"] =       {80, 8000, "boom"}
shotCaliber["arc9_eft_grenade_v40"] =       {80, 8000, "boom"}
shotCaliber["arc9_eft_grenade_vog17"] =     {70, 9000, "boom"}
shotCaliber["arc9_eft_grenade_vog25"] =     {70, 9000, "boom"}
shotCaliber["arc9_eft_40mm_m381_bang"] =    {60, 10000, "boom"}
shotCaliber["arc9_eft_40mm_m433_bang"] =    {70, 9000, "boom"}
shotCaliber["arc9_eft_grenade_725"] =       {50, 12000, "boom"}

-- manually set
shotCaliber["shrapnel"] =           {190, 3000, "bullet"}

-- code for firearms can be found in sh_arc9_override, the serverside stuff below is for things like explosions or shrapnel

if SERVER then

    util.AddNetworkString("DistantGunAudio")

    function ManualDistantSound(type, num, indoor, ent, cal, ext)

        if type == 1 then -- entity based

            local attacker = ent:GetOwner()
            if !attacker:IsPlayer() then return end
            if attacker:CompareStatus(0) or attacker:CompareStatus(3) then return end

            for k, v in pairs(player.GetHumans()) do

                if v:CompareStatus(0) or v:CompareStatus(3) then return end

                local class = ent:GetClass()
                if shotCaliber[class] == nil then return end

                local shootPos = Vector(attacker:GetPos())

                if ext.pos then

                    shootPos = Vector(ext.pos)

                end

                local plyDistance =  shootPos:Distance(v:GetPos())
                local bulletPitch = shotCaliber[class][1] or 100
                local threshold = shotCaliber[class][2] or 6000
                local style = shotCaliber[class][3] == "bullet" -- returns true if bullet, false if explosive
                local volume = 1

                local dist = 2500
                if ext.dist then dist = ext.dist end

                if indoor then volume = volume * 0.4 end

                for i = 1, num do

                    if plyDistance >= dist then

                        net.Start("DistantGunAudio")
                        net.WriteVector(shootPos)
                        net.WriteFloat(plyDistance)
                        net.WriteInt(bulletPitch, 9)
                        net.WriteInt(threshold, 16)
                        net.WriteFloat(volume)
                        net.WriteBool(style)
                        net.Send(v)

                    end

                end

            end

        else -- ammunition based

            local attacker = ent:GetOwner()
            if attacker == NULL then attacker = ent end -- failsafe
            if !attacker:IsPlayer() then return end
            if cal == nil then return end
            if attacker:CompareStatus(0) or attacker:CompareStatus(3) then return end

            for k, v in pairs(player.GetHumans()) do

                if v:CompareStatus(0) or v:CompareStatus(3) then return end
                if shotCaliber[cal] == nil then return end

                local shootPos = Vector(attacker:GetPos())

                if ext.pos then

                    shootPos = Vector(ext.pos)

                end

                local plyDistance =  shootPos:Distance(v:GetPos())
                local bulletPitch = shotCaliber[cal][1] or 100
                local threshold = shotCaliber[cal][2] or 6000
                local style = shotCaliber[cal][3] == "bullet" -- returns true if bullet, false if explosive
                local volume = 1

                local dist = 2500
                if ext.dist then dist = ext.dist end

                if indoor then volume = volume * 0.4 end

                for i = 1, num do

                    if plyDistance >= dist then

                        net.Start("DistantGunAudio")
                        net.WriteVector(shootPos)
                        net.WriteFloat(plyDistance)
                        net.WriteInt(bulletPitch, 9)
                        net.WriteInt(threshold, 16)
                        net.WriteFloat(volume)
                        net.WriteBool(style)
                        net.Send(v)

                    end

                end

            end

        end

    end

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