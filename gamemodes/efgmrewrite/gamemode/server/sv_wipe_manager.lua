
-- "formally" initializes a wipe, handling shit like resetting stats

local wipeEnabled = false -- basically so nobody accidentally starts a wipe

local function CheckWipe(ply)

    if !ply:IsSuperAdmin() or ply:IsPlayer() then

        print("Mf aint an admin")
        
        return false
        
    end

    if !wipeEnabled then
        
        print("Wiping is currently disabled, do efgm_wipe_unlock to enable wiping.")

        return false

    end

    return true

end

concommand.Add("efgm_unlock_wipe", function(ply, cmd, args)
    
    if !ply:IsSuperAdmin() or ply:IsPlayer() then return end

    wipeEnabled = true

    print("Wiping is now enabled, do efgm_wipe_lock to disable wiping.")
    
end)

concommand.Add("efgm_lock_wipe", function(ply, cmd, args)
    
    if !ply:IsSuperAdmin() or ply:IsPlayer() then return end

    wipeEnabled = false

    print("Wiping is now disabled, do efgm_wipe_unlock to enable wiping.")
    
end)

concommand.Add("efgm_wipe_gameplay", function(ply, cmd, args) -- regular wipe, resets xp, level, stuff like that, keeps lifetime stats and unlocks
    
    if !CheckWipe(ply) then return end

    DEBUG.NotImplemented()

end)

concommand.Add("efgm_wipe_full", function(ply, cmd, args) -- full reset of everything, should only be used in testing environments or MAYBE on a major enough update
    
    if !CheckWipe(ply) then return end

    DEBUG.NotImplemented()
    
end)