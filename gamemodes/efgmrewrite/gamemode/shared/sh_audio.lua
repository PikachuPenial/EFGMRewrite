
local fsVol = 1

hook.Add("PlayerFootstep", "CustomFootstepVolume", function(ply, pos, foot, sound, volume)

    if IsValid(ply) and ply:GetNW2Bool("DoStep", false) then

        local soundLevel = math.Clamp(75 + (fsVol * 15), 75, 160)

        ply:EmitSound(sound, soundLevel, 100, math.min(fsVol, 1))

        return true

    end

    return true

end)