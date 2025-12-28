-- "formally" initializes a wipe, handling shit like resetting stats

local wipeEnabled = false -- so nobody accidentally starts a wipe

concommand.Add("efgm_unlock_wipe", function(ply, cmd, args)

    wipeEnabled = true

    print("Wiping is now enabled, do efgm_wipe_lock to disable wiping.")

end)

concommand.Add("efgm_lock_wipe", function(ply, cmd, args)

    wipeEnabled = false

    print("Wiping is now disabled, do efgm_wipe_unlock to enable wiping.")

end)

concommand.Add("efgm_wipe_gameplay", function(ply, cmd, args) -- regular wipe, resets xp, level, stuff like that, keeps lifetime stats and unlocks

    if !wipeEnabled then return end

    print("gameplay wipe doesn't do anything yet")

end)

concommand.Add("efgm_wipe_tasks", function(ply, cmd, args)

    if !wipeEnabled then return end

    print("gameplay wipe doesn't do anything yet")

end)

concommand.Add("efgm_wipe_full", function(ply, cmd, args) -- full reset of everything, should only be used in testing environments or MAYBE on a major enough update

    if !wipeEnabled then return end
    
    sql.Query("DROP TABLE EFGMPlayerData64; CREATE TABLE IF NOT EXISTS EFGMPlayerData64 ( SteamID INTEGER, Key TEXT, Value TEXT);")

    print("Did full wipe ig")

end)