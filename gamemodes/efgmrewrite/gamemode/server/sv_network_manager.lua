-- Eat shit penial i stole your titanmod code save manager code
-- As of 4/25/2025 at 4:08AM CST, porty can eat shit, as I have rewritten this code to match the new titanmod networking manager
hook.Add("Initialize", "InitPlayerNetworking", function() sql.Query("CREATE TABLE IF NOT EXISTS EFGMPlayerData64 ( SteamID INTEGER, Key TEXT, Value TEXT, SteamName TEXT);") end )

local tempCMD = nil
local tempNewCMD = nil

function InitializeNetworkBool(ply, query, key, value)
	if query == "new" then ply:SetNWBool(key, tobool(value)) return end

	for k, v in ipairs(query) do
		if key == v.Key then
			ply:SetNWBool(key, tobool(v.Value))
			return
		end
	end

	ply:SetNWBool(key, tobool(value))
end

function InitializeNetworkInt(ply, query, key, value)
	if query == "new" then ply:SetNWInt(key, tonumber(value)) return end

	for k, v in ipairs(query) do
		if key == v.Key then
			ply:SetNWInt(key, tonumber(v.Value))
			return
		end
	end

	ply:SetNWInt(key, tonumber(value))
end

function InitializeNetworkFloat(ply, query, key, value)
	if query == "new" then ply:SetNWFloat(key, tonumber(value)) return end

	for k, v in ipairs(query) do
		if key == v.Key then
			ply:SetNWFloat(key, tonumber(v.Value))
			return
		end
	end

	ply:SetNWFloat(key, tonumber(value))
end

function InitializeNetworkString(ply, query, key, value)
	if query == "new" then ply:SetNWString(key, tostring(value)) return end

	for k, v in ipairs(query) do
		if key == v.Key then
			ply:SetNWString(key, tostring(v.Value))
			return
		end
	end

	ply:SetNWString(key, tostring(value))
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

function UninitializeNetworkString(ply, query, key)
	local id64 = ply:SteamID64()
	local name = ply:Name()
	local value = tostring(ply:GetNWString(key))

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), " return end

	for k, v in ipairs(query) do
		if key == v.Key then
			tempCMD = tempCMD .. "WHEN " .. SQLStr(key) .. " THEN " .. SQLStr(value) .. " "
			return
		end
	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. ", " .. SQLStr(name) .. "), "
end

function SetupPlayerData(ply)
	local id64 = ply:SteamID64()
	local query = sql.Query("SELECT Key, Value FROM EFGMPlayerData64 WHERE SteamID = " .. id64 .. ";")
	if query == nil then query = "new" end

    -- stats
    InitializeNetworkBool(ply, query, "FreshWipe", true) -- false if player has logged on once this wipe
    InitializeNetworkInt(ply, query, "Level", 0)
    InitializeNetworkInt(ply, query, "Experience", 0)
	InitializeNetworkInt(ply, query, "MoneyEarned", 0) -- all money earned
	InitializeNetworkInt(ply, query, "MoneySpent", 0) -- all money spent (money would just be MoneyEarned - MoneySpent)
	InitializeNetworkInt(ply, query, "Time", 0) -- playtime in minutes
    InitializeNetworkInt(ply, query, "StashValue", 1) -- value of all items in stash

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
    InitializeNetworkInt(ply, query, "CurrentKillStreak", 1)
    InitializeNetworkInt(ply, query, "BestKillStreak", 1)
    InitializeNetworkInt(ply, query, "CurrentExtractionStreak", 1)
    InitializeNetworkInt(ply, query, "BestExtractionStreak", 1)
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

	tempNewCMD = string.sub(tempNewCMD, 1, -3) .. ";"
	tempCMD = tempCMD .. "ELSE Value END WHERE SteamID = " .. id64 .. ";"

	if tempNewCMD != "INSERT INTO EFGMPlayerData64 (SteamID, Key, Value, SteamName) VALU;" then sql.Query(tempNewCMD) end
	if tempCMD != "UPDATE EFGMPlayerData64 SET Value = CASE Key ELSE Value END WHERE SteamID = " .. id64 .. ";" then sql.Query(tempCMD) end

	sql.Commit()

	tempCMD = nil
	tempNewCMD = nil
end