-- Eat shit penial i stole your titanmod code save manager code
-- As of 4/25/2025 at 4:08AM CST, porty can eat shit, as I have rewritten this code to match the new titanmod networking manager
-- As of 11/1/2025 at 2:23PM CDT, ):
hook.Add("Initialize", "InitPlayerNetworking", function() sql.Query("CREATE TABLE IF NOT EXISTS EFGMPlayerData64 ( SteamID INTEGER, Key TEXT, Value TEXT, SteamName TEXT);") end )

local tempCMD = nil
local tempNewCMD = nil

function InitializeNetworkBool(ply, query, key, value)

	if query == "new" then ply:SetNWBool(key, tobool(value)) return tobool(value) end

	for k, v in ipairs(query) do

		if key == v.Key then

			ply:SetNWBool(key, tobool(v.Value))
			return tobool(v.Value)

		end

	end

	ply:SetNWBool(key, tobool(value))
    return tobool(value)

end

function InitializeNetworkInt(ply, query, key, value)

	if query == "new" then ply:SetNWInt(key, tonumber(value)) return tonumber(value) end

	for k, v in ipairs(query) do

		if key == v.Key then

			ply:SetNWInt(key, tonumber(v.Value))
			return tonumber(v.Value)

		end

	end

	ply:SetNWInt(key, tonumber(value))
    return tonumber(value)

end

function InitializeNetworkFloat(ply, query, key, value)

	if query == "new" then ply:SetNWFloat(key, tonumber(value)) return tonumber(value) end

	for k, v in ipairs(query) do

		if key == v.Key then

			ply:SetNWFloat(key, tonumber(v.Value))
			return tonumber(v.Value)

		end

	end

	ply:SetNWFloat(key, tonumber(value))
	return tonumber(value)

end

function InitializeNetworkString(ply, query, key, value)

	if query == "new" then ply:SetNWString(key, tostring(value)) return tostring(value) end

	for k, v in ipairs(query) do

		if key == v.Key then

			ply:SetNWString(key, tostring(v.Value))
			return tostring(v.Value)

		end

	end

	ply:SetNWString(key, tostring(value))
    return tostring(value)

end

-- an adderall fueled discovery
function InitializeStashString(ply, query, value)

	if query == "new" then ply.stashStr = tostring(value) return tostring(value) end

	for k, v in ipairs(query) do

		if v.Key == "Stash" then

			ply.stashStr = tostring(v.Value)
			return tostring(v.Value)

		end

	end

	ply.stashStr = tostring(value)
    return tostring(value)

end

function InitializeInventoryString(ply, query, value)

	if query == "new" then ply.invStr = tostring(value) return tostring(value) end

	for k, v in ipairs(query) do

		if v.Key == "Inventory" then

			ply.invStr = tostring(v.Value)
			return tostring(v.Value)

		end

	end

	ply.invStr = tostring(value)
    return tostring(value)

end

function InitializeEquippedString(ply, query, value)

	if query == "new" then ply.equStr = tostring(value) return tostring(value) end

	for k, v in ipairs(query) do

		if v.Key == "Equipped" then

			ply.equStr = tostring(v.Value)
			return tostring(v.Value)

		end

	end

	ply.equStr = tostring(value)
    return tostring(value)

end

function UninitializeNetworkBool(ply, query, key)

	local id64 = ply:SteamID64()
	local name = ply:Name()
	local value = tobool(ply:GetNWBool(key))

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), " return end

	for k, v in ipairs(query) do

		if key == v.Key then

			tempCMD = tempCMD .. "WHEN " .. SQLStr(key) .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), "

end

function UninitializeNetworkInt(ply, query, key)

	local id64 = ply:SteamID64()
	local name = ply:Name()
	local value = tonumber(ply:GetNWInt(key))

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), " return end

	for k, v in ipairs(query) do

		if key == v.Key then

			tempCMD = tempCMD .. "WHEN " .. SQLStr(key) .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), "

end

function UninitializeNetworkFloat(ply, query, key)

	local id64 = ply:SteamID64()
	local name = ply:Name()
	local value = tonumber(ply:GetNWFloat(key))

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), " return end

	for k, v in ipairs(query) do

		if key == v.Key then

			tempCMD = tempCMD .. "WHEN " .. SQLStr(key) .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), "

end

function UninitializeNetworkString(ply, query, key, valueOverride)

	local id64 = ply:SteamID64()
	local name = ply:Name()
    local value = ""

    if valueOverride == nil then

	    value = tostring(ply:GetNWString(key))

    else

	    value = tostring(valueOverride)

    end

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), " return end

	for k, v in ipairs(query) do

		if key == v.Key then

			tempCMD = tempCMD .. "WHEN " .. SQLStr(key) .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), "

end

-- lord please save me
function UninitializeStashString(ply, query, valueOverride)

	local id64 = ply:SteamID64()
	local name = ply:Name()
    local value = ""

    if valueOverride == nil then

	    value = tostring(ply.stashStr)

    else

	    value = tostring(valueOverride)

    end

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Stash") .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), " return end

	for k, v in ipairs(query) do

		if v.Key == "Stash" then

			tempCMD = tempCMD .. "WHEN " .. SQLStr("Stash") .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Stash") .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), "

end

function UninitializeInventoryString(ply, query, valueOverride)

	local id64 = ply:SteamID64()
	local name = ply:Name()
    local value = ""

    if valueOverride == nil then

	    value = tostring(ply.invStr)

    else

	    value = tostring(valueOverride)

    end

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Inventory") .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), " return end

	for k, v in ipairs(query) do

		if v.Key == "Inventory" then

			tempCMD = tempCMD .. "WHEN " .. SQLStr("Inventory") .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Inventory") .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), "

end

function UninitializeEquippedString(ply, query, valueOverride)

	local id64 = ply:SteamID64()
	local name = ply:Name()
    local value = ""

    if valueOverride == nil then

	    value = tostring(ply.equStr)

    else

	    value = tostring(valueOverride)

    end

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Equipped") .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), " return end

	for k, v in ipairs(query) do

		if v.Key == "Equipped" then

			tempCMD = tempCMD .. "WHEN " .. SQLStr("Equipped") .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Equipped") .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), "

end

util.AddNetworkString("PlayerNetworkStash")
util.AddNetworkString("PlayerNetworkInventory")
util.AddNetworkString("PlayerNetworkEquipped")

-- Yo the way this shit works is very cool, nice job pene
function SetupPlayerData(ply)

	local id64 = ply:SteamID64()
	local query = sql.Query("SELECT Key, Value FROM EFGMPlayerData64 WHERE SteamID = " .. id64 .. ";")
	if query == nil then query = "new" end

    -- stats
    InitializeNetworkBool(ply, query, "FreshWipe", true) -- false if player has logged on once this wipe
    InitializeNetworkInt(ply, query, "Level", 1)
    InitializeNetworkInt(ply, query, "Experience", 0)
	InitializeNetworkInt(ply, query, "Money", 100000000)
	InitializeNetworkInt(ply, query, "MoneyEarned", 0) -- all money earned
	InitializeNetworkInt(ply, query, "MoneySpent", 0) -- all money spent (money would just be MoneyEarned - MoneySpent)
	InitializeNetworkInt(ply, query, "Time", 0) -- playtime in minutes
    InitializeNetworkInt(ply, query, "StashValue", 0) -- value of all items in stash

    -- combat
	InitializeNetworkInt(ply, query, "Kills", 0)
	InitializeNetworkInt(ply, query, "Deaths", 0)
    InitializeNetworkInt(ply, query, "Suicides", 0)
	InitializeNetworkInt(ply, query, "DamageDealt", 0)
	InitializeNetworkInt(ply, query, "DamageRecieved", 0)
	InitializeNetworkInt(ply, query, "DamageHealed", 0)
    InitializeNetworkInt(ply, query, "Headshots", 0)
    InitializeNetworkInt(ply, query, "FarthestKill", 0)

    -- raids
	InitializeNetworkInt(ply, query, "Extractions", 0)
	InitializeNetworkInt(ply, query, "Quits", 0)
	InitializeNetworkInt(ply, query, "RaidsPlayed", 0) -- the amount of full raids played, counted if you join before the first minute and stay until the raid ends

    -- streaks
    InitializeNetworkInt(ply, query, "CurrentKillStreak", 0)
    InitializeNetworkInt(ply, query, "BestKillStreak", 0)
    InitializeNetworkInt(ply, query, "CurrentExtractionStreak", 0)
    InitializeNetworkInt(ply, query, "BestExtractionStreak", 0)

	-- stash/inventory
	InitializeNetworkFloat(ply, query, "InventoryWeight", 0)
	InitializeNetworkInt(ply, query, "StashMax", 4500)

	for k, v in ipairs(levelArray) do

		if ply:GetNWInt("Level") == k and v != "max" then ply:SetNWInt("ExperienceToNextLevel", v) end

	end

    -- stash
    local stashString = InitializeStashString(ply, query, "XQAAAQCWEQAAAAAAAAAtnsBHRAlDnI+0YKoytE2yTNKO521sKGQuGNJPYpMWvBCnQ/h3Lcka+bVJp8xL1IxMtDoptVcBsxmAqSJYLTnd1DiPQcpf3YBIAJWAiMYkFVI6JGpT8+hGMdGdn/pBvWQ4PcAlvJldZexpOW6t8sRvtNunhG108SlxyCHBDThpN842dInwt9UP0LSYrmPEMfSDE1mIYVWg7HsVon5fm559zA2IP1vqjTk1hhoDxBuWGvP0kMXo4kbBI6PX9Iv6PlXpnQ9eaat6ImmoobrDDXecHQu4qRGW0XLh29B2dZeHBWKDFS+DgigXjuVkYnnK3gpStgoXugKrdITh2le/gCrndxIois9jGYb/XTnxZCyXQKzFxdXjX84TWKsv4WC8wPkzgPBhX6ArvXumjDLX/adTKv1hfkY0KXmBHcJ13I+S0Kc858ls0wrUdWdPsdYBhtgdsCp1cwY5l1VCcVObJZWMxOc/9d4uSQ5ZT9u3NpaGk1a2qXtu5Rf9z3SbKLu64AeaTXLeDQ5PYYq3BqjC1vjVfxysAxRcm7lFGgQeYfm+eUsHkcjFToiyLBgT9R4bNP1sox2iw1iS/lm92Z515n8abHVImNMfWNIjzQBRlq/mVM8tWMubeQjP37c2kDomCPaohzDK8xEduirMrdGRK2gmj1tV+7a9TN324cOEL3ULnnROLHJ3hTni+TouUjBTSMq+d/YG3U2RxrBwBjkkVzmKhkLTLzKcUlX/LxrF35Gm/0WLt1MZxc7c+UyllaBco13M7YA4HYjztLYndnaCJ0sUNDryoqsG2Vtje6KNYzd1MUjrnJiGNBHQNuIUcAoyh+6utj61ubFE7Ps8G9FvqhyYfsQkLFbRwxt61VktCnr/xaGia/0gCKVig1jsTDythhZbD/s4sMWavGmPuSNcmwAPedrfPebRgoMx+WXN+96SPuQFNMfFtt8wBUN4YoK7/1VFtBtzy8mVria7oLDzf96NcJ+omKJNajw9Ij+WMhuASqGbjxJB6THgTqT9MJK4VAs4wuLaoiX9NReLjdSUWmaoov7GE3d8dWuK0DfjlMeAWMEn12QPi46k+kKcXAHuJdDDs4Q5w/6IXwcwYGY9JA6UHYxGmyQqNPeD0evGGND8AjE/O6XMZeKCZJd3O8IxipRzM/qZzBsCR6QAxnOBj5MQJpQwt4NM9OofaEWu9FFR1Wez88BusknOwNaP3DreCnWSXNwXUTA37HwXNabZgjaZJW3lHAO/53qwPcScpePtPTZckrKhF/NF8A73NA2TfIIFIepT59KBRkT9K0MHlp0FPcpypjCpicGUzG+NgbQ11KPkzpDYrI4d+0bYft2v8fSz8YhMOYQ7988=")
	ply.stash = DecodeStash(ply, stashString)
	if ply.stash == nil then ply.stash = {} end
	ply:SetNWInt("StashCount", #ply.stash)

	-- inventory
	local inventoryString = InitializeInventoryString(ply, query, "XQAAAQA6AgAAAAAAAAAtnsBHRAlDnI+0YtKitE2yTNKO569j8mi1Ev2kuUsTXOBzHtWWjqOooI4IN3QW9F9yK4rAvAbQW9Pj2AaRXJuIi0hb24+3zAcaiIU/m/jsfCBCMDHmT6kvKWdNMcQjhdfLcVCJBNFqsC2ew/yCAA==")
	ply.inventory = DecodeStash(ply, inventoryString) -- yes this works ignore function name
	if ply.inventory == nil then ply.inventory = {} end

	local equippedString = InitializeEquippedString(ply, query, "XQAAAQBqBAAAAAAAAAAt4ehEdDypZhc/rwkz9T5cWFAkvV80LpgNDXdx7ZcvkQ48bkdcTutVcWuPY6g9iYL4pId4H/c6huobRq6wio3vn/D6wsHmjv0jX5jFArouQrXAp7Nqcp9jReC2mZi57kUSWOCls/HcNJsu+E4r/MGO2d0iYZu31u1dL6JGl8qKQFul37F2giNouXIR6Bo9Er8glK7bmOM5f0G/93foF8f4Z/80WcWF40H0xGKWimgkoS6BpeZtleGDcMvszg+0RApZr5GbjGmLHzKk7cZrERaVn4AO2hEGwVvLRmirCVvKgNLLJQFHsTljH9sMB0hNqyITlyWxazalOa2IhrGw5IkNyPMcVxJoRwL+eM3HTGcsSdqMYTtDBzV7UuYRRI/hO/YYZuWOkTcGSso+6YMN1BQVs3S+3zpwmwdN42mvPz16aHfhsg6szAqj6v5eS5MKLPK4BNV1lVHI8t5XQApM41MbnDaMjrSIn8MwEUSLHHnyAKJC74NH5g1KvaVO7mlf6y03+swUw1r1B5+/5vsy+XVOfSmR0hmt/yyNIKvc19x51JsnjruWN7PAKBGDg8Q7hD+nq0y1mu3yovOd7byCofH4ta7SMzlz3m1Zpk5cM9sgcU/axnBebzr8PCJuGR0UFXTYImukDT+S/fI+kKBxgbeQij60SoT+H0ZAjeBiR/abnklrUupyzw31gCT34sxodQqifbpNoWes+MRF8AjZo5T/qy82vVrv4Vd4f/n8IhnkDE2h3SjsH+frsXcS/ioR4ivYU/tHRTuZkThDjkOp/rpAtAcEJJNspxos2K/Ek6CvwzS536b7MYanpxS3HwFWgMtmDOAtvnlD35pK5j6jtZg+x4YvKIyd8+qRCohWAWWQDG5IX2YhJVc0OHz+Lh8eRXvUXoSeeo3bBCTiAIGAVVBO5CCkp6LssixBQYQEOXZASiQ1V4PK+XhSV2ScIBqr1d9eQ85R540=")
	ply.weaponSlots = DecodeStash(ply, equippedString)
	if ply.weaponSlots == nil then

		ply.weaponSlots = {}
		for k, v in pairs(WEAPONSLOTS) do

			ply.weaponSlots[v.ID] = {}
			for i = 1, v.COUNT, 1 do ply.weaponSlots[v.ID][i] = {} end

		end

	end

	CalculateInventoryWeight(ply)

    net.Start("PlayerNetworkStash", false)
    net.WriteString(stashString)
    net.Send(ply)

	net.Start("PlayerNetworkInventory", false)
	net.WriteString(inventoryString)
    net.Send(ply)

	net.Start("PlayerNetworkEquipped", false)
	net.WriteString(equippedString)
    net.Send(ply)

end

function SavePlayerData(ply)

	if tempNewCMD != nil or tempCMD != nil then return end -- shouldn't be possible but just to be safe
	local id64 = ply:SteamID64()
	local query = sql.Query("SELECT Key, Value FROM EFGMPlayerData64 WHERE SteamID = " .. id64 .. ";")
	if query == nil then query = "new" end

	tempNewCMD = "INSERT INTO EFGMPlayerData64 (SteamID, Key, Value, SteamName) VALUES"
	tempCMD = "UPDATE EFGMPlayerData64 SET Value = CASE Key "

	sql.Begin()

    -- stats
    UninitializeNetworkBool(ply, query, "FreshWipe")
    UninitializeNetworkInt(ply, query, "Level")
    UninitializeNetworkInt(ply, query, "Experience")
	UninitializeNetworkInt(ply, query, "Money")
	UninitializeNetworkInt(ply, query, "MoneyEarned")
	UninitializeNetworkInt(ply, query, "MoneySpent")
	UninitializeNetworkInt(ply, query, "Time")
    UninitializeNetworkInt(ply, query, "StashValue")

    -- combat
	UninitializeNetworkInt(ply, query, "Kills")
	UninitializeNetworkInt(ply, query, "Deaths")
    UninitializeNetworkInt(ply, query, "Suicides")
	UninitializeNetworkInt(ply, query, "DamageDealt")
	UninitializeNetworkInt(ply, query, "DamageRecieved")
	UninitializeNetworkInt(ply, query, "DamageHealed")
    UninitializeNetworkInt(ply, query, "Headshots")
    UninitializeNetworkInt(ply, query, "FarthestKill")

    -- raids
	UninitializeNetworkInt(ply, query, "Extractions")
	UninitializeNetworkInt(ply, query, "Quits")
	UninitializeNetworkInt(ply, query, "RaidsPlayed")

    -- streaks
    UninitializeNetworkInt(ply, query, "CurrentKillStreak")
    UninitializeNetworkInt(ply, query, "BestKillStreak")
    UninitializeNetworkInt(ply, query, "CurrentExtractionStreak")
    UninitializeNetworkInt(ply, query, "BestExtractionStreak")

    -- stash/inventory
	UninitializeNetworkFloat(ply, query, "InventoryWeight")
	UninitializeNetworkInt(ply, query, "StashMax")

    UninitializeStashString(ply, query)
	UninitializeInventoryString(ply, query)
	UninitializeEquippedString(ply, query)

	tempNewCMD = string.sub(tempNewCMD, 1, -3) .. ";"
	tempCMD = tempCMD .. "ELSE Value END WHERE SteamID = " .. id64 .. ";"

	if tempNewCMD != "INSERT INTO EFGMPlayerData64 (SteamID, Key, Value, SteamName) VALU;" then sql.Query(tempNewCMD) end
	if tempCMD != "UPDATE EFGMPlayerData64 SET Value = CASE Key ELSE Value END WHERE SteamID = " .. id64 .. ";" then sql.Query(tempCMD) end

	sql.Commit()

	tempCMD = nil
	tempNewCMD = nil

end

hook.Add("PlayerInitialSpawn", "PlayerInitializeStats", function(ply)

    SetupPlayerData(ply)

end)

hook.Add("PlayerDisconnected", "PlayerUninitializeStats", function(ply)

    ply:SetNWBool("FreshWipe", false)

    if !ply:CompareStatus(0) then

        ply:SetNWInt("Quits", ply:GetNWInt("Quits", 0) + 1)

		-- wipe inventory if leaving WHILE in a raid
		ReinstantiateInventory(ply)

    end

	UpdateStashString(ply)
	UpdateInventoryString(ply)
	UpdateEquippedString(ply)

	SavePlayerData(ply)

end)

hook.Add("ShutDown", "ServerUninitializeStats", function(ply)

	for k, v in ipairs(player.GetHumans()) do

		v:SetNWBool("FreshWipe", false)

		if !v:CompareStatus(0) then

        v:SetNWInt("Quits", v:GetNWInt("Quits", 0) + 1)

			-- wipe inventory if leaving WHILE in a raid
			ReinstantiateInventory(v)

    	end

		UpdateStashString(v)
		UpdateInventoryString(v)
		UpdateEquippedString(v)

		SavePlayerData(v)

	end

end)