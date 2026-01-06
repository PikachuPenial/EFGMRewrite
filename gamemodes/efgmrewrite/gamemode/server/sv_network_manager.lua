-- Eat shit penial i stole your titanmod code save manager code
-- As of 4/25/2025 at 4:08AM CST, porty can eat shit, as I have rewritten this code to match the new titanmod networking manager
-- As of 11/1/2025 at 2:23PM CDT, ):
hook.Add("Initialize", "InitPlayerNetworking", function() sql.Query("CREATE TABLE IF NOT EXISTS EFGMPlayerData64 (SteamID INTEGER, Key TEXT, Value TEXT);") end )

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

function InitializeTaskString(ply, query, value)

	if query == "new" then ply.taskStr = tostring(value) return tostring(value) end

	for k, v in ipairs(query) do

		if v.Key == "Tasks" then

			ply.taskStr = tostring(v.Value)
			return tostring(v.Value)

		end

	end

	ply.taskStr = tostring(value)
	return tostring(value)

end



function UninitializeNetworkBool(ply, query, key)

	local id64 = ply:SteamID64()
	local value = tobool(ply:GetNWBool(key))

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. "), " return end

	for k, v in ipairs(query) do

		if key == v.Key then

			tempCMD = tempCMD .. "WHEN " .. SQLStr(key) .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. "), "

end

function UninitializeNetworkInt(ply, query, key)

	local id64 = ply:SteamID64()
	local value = tonumber(ply:GetNWInt(key))

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. "), " return end

	for k, v in ipairs(query) do

		if key == v.Key then

			tempCMD = tempCMD .. "WHEN " .. SQLStr(key) .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. "), "

end

function UninitializeNetworkFloat(ply, query, key)

	local id64 = ply:SteamID64()
	local value = tonumber(ply:GetNWFloat(key))

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. "), " return end

	for k, v in ipairs(query) do

		if key == v.Key then

			tempCMD = tempCMD .. "WHEN " .. SQLStr(key) .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. "), "

end

function UninitializeNetworkString(ply, query, key, valueOverride)

	local id64 = ply:SteamID64()
	local value = ""

	if valueOverride == nil then

	    value = tostring(ply:GetNWString(key))

	else

		value = tostring(valueOverride)

	end

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. "), " return end

	for k, v in ipairs(query) do

		if key == v.Key then

			tempCMD = tempCMD .. "WHEN " .. SQLStr(key) .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr(key) .. ", " .. SQLStr(value) .. "), "

end

-- lord please save me
function UninitializeStashString(ply, query, valueOverride)

	local id64 = ply:SteamID64()
	local value = ""

	if valueOverride == nil then

	    value = tostring(ply.stashStr)

	else

	    value = tostring(valueOverride)

	end

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Stash") .. ", " .. SQLStr(value) .. "), " return end

	for k, v in ipairs(query) do

		if v.Key == "Stash" then

			tempCMD = tempCMD .. "WHEN " .. SQLStr("Stash") .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Stash") .. ", " .. SQLStr(value) .. "), "

end

function UninitializeInventoryString(ply, query, valueOverride)

	local id64 = ply:SteamID64()
	local value = ""

	if valueOverride == nil then

	    value = tostring(ply.invStr)

	else

	    value = tostring(valueOverride)

	end

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Inventory") .. ", " .. SQLStr(value) .. "), " return end

	for k, v in ipairs(query) do

		if v.Key == "Inventory" then

			tempCMD = tempCMD .. "WHEN " .. SQLStr("Inventory") .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Inventory") .. ", " .. SQLStr(value) .. "), "

end

function UninitializeEquippedString(ply, query, valueOverride)

	local id64 = ply:SteamID64()
	local value = ""

	if valueOverride == nil then

	    value = tostring(ply.equStr)

	else

	    value = tostring(valueOverride)

	end

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Equipped") .. ", " .. SQLStr(value) .. "), " return end

	for k, v in ipairs(query) do

		if v.Key == "Equipped" then

			tempCMD = tempCMD .. "WHEN " .. SQLStr("Equipped") .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Equipped") .. ", " .. SQLStr(value) .. "), "

end

function UninitializeTaskString(ply, query, valueOverride)

	local id64 = ply:SteamID64()
	local value = ""

	if valueOverride == nil then

	    value = tostring(ply.taskStr)

	else

	    value = tostring(valueOverride)

	end

	if query == "new" then tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Tasks") .. ", " .. SQLStr(value) .. "), " return end

	for k, v in ipairs(query) do

		if v.Key == "Tasks" then

			tempCMD = tempCMD .. "WHEN " .. SQLStr("Tasks") .. " THEN " .. SQLStr(value) .. " "
			return

		end

	end

	tempNewCMD = tempNewCMD .. "(" .. SQLStr(id64) .. ", " .. SQLStr("Tasks") .. ", " .. SQLStr(value) .. "), "

end

util.AddNetworkString("PlayerNetworkStash")
util.AddNetworkString("PlayerNetworkInventory")
util.AddNetworkString("PlayerNetworkEquipped")
util.AddNetworkString("SendLargeTableChunk")
util.AddNetworkString("SendLargeTableComplete")

function SplitNetByChunk(text, chunkSize)

	local chunks = {}

	for i = 1, #text, chunkSize do  chunks[#chunks + 1] = text:sub(i, i + chunkSize - 1) end

	return chunks

end

function SendChunkedNet(ply, str, netStr)

	local chunkSize = 61440 -- 60kb, limit is 64kb, to be safe
	local chunks = SplitNetByChunk(str, chunkSize)
	local chunkCount = #chunks
	local uID = CurTime()

	for i, c in ipairs(chunks) do

		net.Start(netStr)
		net.WriteFloat(uID)
		net.WriteUInt(i, 16)
		net.WriteUInt(chunkCount, 16)
		net.WriteString(c)
		net.Send(ply)

	end

end

function EquippedIsInEnumScope(ply)

	for k, v in pairs(WEAPONSLOTS) do

		local subSlotCount = table.Count(ply.weaponSlots[v.ID])
		local subSlotCountLimit = v.COUNT

		if subSlotCount > subSlotCountLimit then

			for i = subSlotCountLimit, subSlotCount do

				ply.weaponSlots[v.ID][i] = nil

			end

		end

	end

	return UpdateEquippedString(ply)

end

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
	InitializeNetworkInt(ply, query, "ItemsLooted", 0)
	InitializeNetworkInt(ply, query, "ContainersLooted", 0)
	InitializeNetworkInt(ply, query, "KeysUsed", 0)

	-- combat
	InitializeNetworkInt(ply, query, "Kills", 0)
	InitializeNetworkInt(ply, query, "Deaths", 0)
	InitializeNetworkInt(ply, query, "Suicides", 0)
	InitializeNetworkInt(ply, query, "DamageDealt", 0)
	InitializeNetworkInt(ply, query, "DamageRecieved", 0)
	InitializeNetworkInt(ply, query, "HealthHealed", 0)
	InitializeNetworkInt(ply, query, "ShotsFired", 0)
	InitializeNetworkInt(ply, query, "ShotsHit", 0)
	InitializeNetworkInt(ply, query, "Headshots", 0)
	InitializeNetworkInt(ply, query, "FarthestKill", 0)

	-- raids
	InitializeNetworkInt(ply, query, "Extractions", 0)
	InitializeNetworkInt(ply, query, "Quits", 0)
	InitializeNetworkInt(ply, query, "RaidsPlayed", 0) -- the amount of full raids played, counted if you join before the first minute and stay until the raid ends

	-- duels
	InitializeNetworkInt(ply, query, "DuelsPlayed", 0)
	InitializeNetworkInt(ply, query, "DuelsWon", 0)

	-- streaks
	InitializeNetworkInt(ply, query, "CurrentKillStreak", 0)
	InitializeNetworkInt(ply, query, "BestKillStreak", 0)
	InitializeNetworkInt(ply, query, "CurrentExtractionStreak", 0)
	InitializeNetworkInt(ply, query, "BestExtractionStreak", 0)
	InitializeNetworkInt(ply, query, "CurrentDuelWinStreak", 0)
	InitializeNetworkInt(ply, query, "BestDuelWinStreak", 0)

	-- stash/inventory
	InitializeNetworkInt(ply, query, "StashMax", 2000)

	for k, v in ipairs(levelArray) do

		if ply:GetNWInt("Level") == k and v != "max" then ply:SetNWInt("ExperienceToNextLevel", v) end

	end

	-- stash
	local stashString = InitializeStashString(ply, query, "XQAAAQB5EwAAAAAAAAAtnsBHRAlDnI+0YKoytE2yTNKO521sKGQuGNJPYpMWvBCnQ/h3Lcka+bVKJDfhDb2tn/Ggb+eNIqA+lldFfh5j+xEUo43j77yROnvLPm/qzBhal3NSosKSsf2tVnFBM7vxqT0fxBnQiO83hv38gFBHxSqM56ONgnVWjub9OMPNaz7BE7h7CQvLOLtyyjLEEHBL/uQOkvaWStfLJP40NHU6hJDlHL+2X69FHYOQ5wFDkgfgJIeTzveRNs0SICR34TixyGykniPe6DxM4F8Cq/jXpr+tJ0FnHZ3xuHJf7xH4YRo14ivFObewHJVR3JScJLniGU1w3yX7sUx9R2S1nxa7Qjy1DHpNmYyXuwsVkMpn/ZCCFivvBtezcfGsyIOWdyA6WU6C0goIw1vOP0jE+2vTKIPnkVjT0GBtRGgnrsbjRSLfN314E1xZPLSPiL/3RL0YT44uPXNkNdmFpSim3xAMwfyYtTUq7ENtpnl9/zbrdH2lKWlCVqJw+Z6TKEeFUkzdTmY7Q5Xp9Qj1rMXBBmvhTRcDWlzA5nTzEP9ftnAUrHQ1tLhZPzma8hmuGIxKHuuTc7JUon+S6CDUTWGPiRepU7iLs9cRKXaD3bhlHDw/kMYFD6D6ahqGRy+ArleWWVp7qZsKZV+hxAGkddi5iQeBE8VE8PZnWlW+DuLHemimUzpoPyVT/8rWHvtDqyJQmLK4I3vdkVz9CDC8PcVOgZwyNQuxMAU8N/+3F5afkC0O9oxg0nfyPUyjIID3iniShYTdjLUFDSZUjdpiwIyoO60CvqRhElBcbuNznibdYHWdKLUidWmmUEgKjFF9oYc2SIQGrF0BFRNzC1S853hG8lOHqNcC4ypotJi1Y+aJNuyvTCAT2UAAMas9jwbXJzwx6+osgEITzjiCEOnM+d7Kk/6++YL9wnHsjMoEXZpy+gjuVoUsC1dokeYaCCoLovt9gAtK4C87qaF3XhkwCoJHmBiPk72xqROH9yJolPAab7lXAmfK64L1Q4KMPcrSnK1QrmmFJ0On4h90q99T/k5rNM15TAIhwEouBOAinHSpqCP1VQVp77e6BwY+igjFnSK7D1oQOhT+jjCdl8rIZpg8r9KkkGuCrq607WxRjE+C1uZlgO+nmX8LQZaOVaOcOfob5AYVHCGGXTKhdy+FwZcQQbRt/be8UWrhlAbghqflbujxhKqhncsN2Rqxdpo7KipC672d9vn5Fd9p1rs8AfD8oZhqhgn8XDZy1NKHs9cKO57BiI/lcqoUSaUQ14g3PdEgYsPkhHaX5mlcnumiMj/QbZs3DFYW6bjPdrhro9+r/kYcd+9WriMafYe8khUMJdWivprYDhRAJ86sWHwoe1EfDadJqUxM5wA=")
	ply.stash = DecodeStash(ply, stashString)
	if ply.stash == nil then ply.stash = {} end
	ply:SetNWInt("StashCount", #ply.stash)

	-- inventory
	local inventoryString = InitializeInventoryString(ply, query, "XQAAAQDBAgAAAAAAAAAtnsBHRAlDnI+0YTROtE2yTNKO569j8mi1Et/q/uD6XoR8aAKYh4+i0E43RHwCTGGK1Ufk5ZnamNm+qFP2TG/4QauCin2hqeXjQafGUo91uqfd77g8/tUBPE6ntJHIITVBqMYHTEM3luulBGmv0wUzGyxSC3QSo4M7QrajX58FiDKJgao59N2F+uJeZifcnqgxtBJhXpgVGpUbJwgA")
	ply.inventory = DecodeStash(ply, inventoryString) -- yes this works ignore function name
	if ply.inventory == nil then ply.inventory = {} end

	local equippedString = InitializeEquippedString(ply, query, "XQAAAQACBAAAAAAAAAAt4ehEdDypZhc/rwkz9T5cWFAkvV80LpgNDXdx7ZcvkQ48bkdcTutVcWuPY6g9iYL4pId4H/c6huobRq6wio3vn/D6wsHmjv0jX5jFArouQrXAp7Nqcp9jReC2mZi57kUSWOCls/HcNJsu+E4r/MGO2d0iYZu31u1dL6JGl8qKQFul37F2giNouXIR6Bo9Er8glK7bmOM5f0G/93foF8f4Z/80WcWF40H0xGKWimgkoS6BpeZtleGDcMvszg+0RApZr5GbjGmLHzKk7cZrERaVn4AO2hEGwVvLRmirCVvKgNLLJQFHsTljH9sMB0hNqyITlyWxazalOa2IhrGw5IkNyPMcVxJoRwL+eM3HTGcsSdqMYTtDBzV7UuYRRI/hO/YYZuWOkTcGSso+6YMN1BQVs3S+3zpwmwdN42mvPz16aHfhsg6szAqj6v5eS5MKLPK4BNV1lVHI8t5XQApM41MbnDaMjrSIn8MwEUSLHHnyAKJC74NH5g1KvaVO7mlf6y03+swUw1r1B5+/5vsy+XVOfSmR0hmt/yyNIKvc19x51JsnjruWN7OuT8Hn5gJncgSdNL+9nZg+F8a771zUE1NmrYyaC3C1Ju0pAJNWHyaJH1prnfyOXdyPvBvMCzdx8Mk4A2H/uuwBm8TAK1H4tt9vgTLYN4UZDDRirx9sGyXo7HqPq+NfULb1YjR124WYsbCeMkFy6G5fdv0pRJmZhsbOE1WfKpFdHA8p2orsj1mrY9ZPjjEyFVJ7urEOPrB5TLsLUmZFxwAnSOm3//aWYGFZsQEz0sfE0u5OvJn2qP7XbgePkkMNQ3ceM2Ne1kJxfx4GgczKa9lg2OHpMo7OwOLdpV2OTzChb/lPh81A8QDOdbkSoXIXp2wrYf5Pr81sRZU=")
	ply.weaponSlots = DecodeStash(ply, equippedString)
	if ply.weaponSlots == nil then

		ply.weaponSlots = {}
		for k, v in pairs(WEAPONSLOTS) do

			ply.weaponSlots[v.ID] = {}
			for i = 1, v.COUNT, 1 do ply.weaponSlots[v.ID][i] = {} end

		end

	end

	local taskString = InitializeTaskString(ply, query, "")
	ply.tasks = DecodeStash(ply, taskString)
	if ply.tasks == nil then ply.tasks = {} end

	CalculateInventoryWeight(ply)

	SendChunkedNet(ply, stashString, "PlayerNetworkStash")
	SendChunkedNet(ply, inventoryString, "PlayerNetworkInventory")

	equippedString = EquippedIsInEnumScope(ply) -- holy fuck dude

	SendChunkedNet(ply, equippedString, "PlayerNetworkEquipped")

	TaskUpdate(ply)

end

function SavePlayerData(ply)

	if tempNewCMD != nil or tempCMD != nil then return end -- shouldn't be possible but just to be safe
	local id64 = ply:SteamID64()
	local query = sql.Query("SELECT Key, Value FROM EFGMPlayerData64 WHERE SteamID = " .. id64 .. ";")
	if query == nil then query = "new" end

	tempNewCMD = "INSERT INTO EFGMPlayerData64 (SteamID, Key, Value) VALUES"
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
	UninitializeNetworkInt(ply, query, "ItemsLooted")
	UninitializeNetworkInt(ply, query, "ContainersLooted")
	UninitializeNetworkInt(ply, query, "KeysUsed")

	-- combat
	UninitializeNetworkInt(ply, query, "Kills")
	UninitializeNetworkInt(ply, query, "Deaths")
	UninitializeNetworkInt(ply, query, "Suicides")
	UninitializeNetworkInt(ply, query, "DamageDealt")
	UninitializeNetworkInt(ply, query, "DamageRecieved")
	UninitializeNetworkInt(ply, query, "HealthHealed")
	UninitializeNetworkInt(ply, query, "ShotsFired")
	UninitializeNetworkInt(ply, query, "ShotsHit")
	UninitializeNetworkInt(ply, query, "Headshots")
	UninitializeNetworkInt(ply, query, "FarthestKill")

	-- raids
	UninitializeNetworkInt(ply, query, "Extractions")
	UninitializeNetworkInt(ply, query, "Quits")
	UninitializeNetworkInt(ply, query, "RaidsPlayed")

	-- duels
	UninitializeNetworkInt(ply, query, "DuelsPlayed")
	UninitializeNetworkInt(ply, query, "DuelsWon")

	-- streaks
	UninitializeNetworkInt(ply, query, "CurrentKillStreak")
	UninitializeNetworkInt(ply, query, "BestKillStreak")
	UninitializeNetworkInt(ply, query, "CurrentExtractionStreak")
	UninitializeNetworkInt(ply, query, "BestExtractionStreak")
	UninitializeNetworkInt(ply, query, "CurrentDuelWinStreak")
	UninitializeNetworkInt(ply, query, "BestDuelWinStreak")

	-- stash/inventory
	UninitializeNetworkInt(ply, query, "StashMax")

	UninitializeStashString(ply, query)
	UninitializeInventoryString(ply, query)
	UninitializeEquippedString(ply, query)
	UninitializeTaskString(ply, query)

	tempNewCMD = string.sub(tempNewCMD, 1, -3) .. ";"
	tempCMD = tempCMD .. "ELSE Value END WHERE SteamID = " .. id64 .. ";"

	if tempNewCMD != "INSERT INTO EFGMPlayerData64 (SteamID, Key, Value) VALU;" then sql.Query(tempNewCMD) end
	if tempCMD != "UPDATE EFGMPlayerData64 SET Value = CASE Key ELSE Value END WHERE SteamID = " .. id64 .. ";" then

		sql.Query(tempCMD)

	end

	sql.Commit()

	tempCMD = nil
	tempNewCMD = nil

end

hook.Add("PlayerInitialSpawn", "PlayerInitializeStats", function(ply)

	SetupPlayerData(ply)

end)

hook.Add("PlayerDisconnected", "PlayerUninitializeStats", function(ply)

	ply:SetNWBool("FreshWipe", false)

	-- in raid
	if !ply:CompareStatus(0) and !ply:CompareStatus(3) then

		UnequipAll(ply)

		if !table.IsEmpty(ply.inventory) then

			local backpack = ents.Create("efgm_backpack")
			backpack:SetPos(ply:GetPos() + Vector(0, 0, 64))
			backpack:Spawn()
			backpack:Activate()
			backpack:SetBagData(ply.inventory, ply:GetName() .. "'s Corpse")

		end

		ply:SetNWInt("Quits", ply:GetNWInt("Quits", 0) + 1)
		ply:SetNWInt("CurrentExtractionStreak", 0)

		-- wipe inventory and drop backpack if leaving WHILE in a raid
		ReinstantiateInventory(ply)

	end

	-- in duel
	if ply:CompareStatus(3) then -- the player wasn't a part of the duel

		ReinstantiateInventoryAfterDuel(ply)
		DUEL:EndDuel(ply)

	end

	UnequipAllFirearms(ply)

	UpdateStashString(ply)
	UpdateInventoryString(ply)
	UpdateEquippedString(ply)
	UpdateTaskString(ply)

	CalculateStashValue(ply)

	SavePlayerData(ply)

end)

hook.Add("ShutDown", "ServerUninitializeStats", function()

	for _, ply in ipairs(player.GetHumans()) do

		ply:SetNWBool("FreshWipe", false)

		if ply:CompareStatus(3) then

			ReinstantiateInventoryAfterDuel(ply)

		end

		UnequipAllFirearms(ply)

		UpdateStashString(ply)
		UpdateInventoryString(ply)
		UpdateEquippedString(ply)
		UpdateTaskString(ply)

		CalculateStashValue(ply)

		SavePlayerData(ply)

	end

end)

if GetConVar("efgm_derivesbox"):GetInt() == 1 then

	concommand.Add("efgm_debug_forcesave", function(ply, cmd, args) SavePlayerData(ply) end)

end