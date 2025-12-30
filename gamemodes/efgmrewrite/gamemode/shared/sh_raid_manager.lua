RAID = {}

local plyMeta = FindMetaTable("Player")
if not plyMeta then Error("Could not find player table") return end

local function DecrementTimer()
    SetGlobalInt("RaidTimeLeft", GetGlobalInt("RaidTimeLeft") - 1)

    if GetGlobalInt("RaidTimeLeft") <= 0 && GetGlobalInt("RaidStatus") == raidStatus.ACTIVE then RAID:EndRaid() return end
    if GetGlobalInt("RaidTimeLeft") <= 0 && GetGlobalInt("RaidStatus") == raidStatus.ENDED then RAID:EndVote() return end

    hook.Run("RaidTimerTick", GetGlobalInt("RaidTimeLeft"))
end

if SERVER then
    util.AddNetworkString("VoteableMaps")
    util.AddNetworkString("SendVote")
    util.AddNetworkString("RequestExtracts")

    util.AddNetworkString("SendExtractionStatus")
    util.AddNetworkString("PlayerRaidTransition")
    util.AddNetworkString("PlayerSwitchFactions")

    util.AddNetworkString("GrabExtractList")
    util.AddNetworkString("SendExtractList")

    RAID.VoteTime = 60

    RAID.MapPool = {["efgm_belmont"] = 0, ["efgm_concrete"] = 0, ["efgm_factory"] = 0} -- map, number of votes

    if GetGlobalInt("RaidStatus") != raidStatus.ACTIVE then -- fuck you fuck you fuck you fuck you
        SetGlobalInt("RaidTimeLeft", -1)
        SetGlobalInt("RaidStatus", raidStatus.PENDING)
        timer.Remove("RaidTimerDecrement")
    end

    --{ RAID FUNCTIONS

        function RAID:StartRaid(raidTime)
            if GetGlobalInt("RaidStatus") != raidStatus.PENDING then return end
            if #player.GetHumans() < 3 and GetConVar("efgm_derivesbox"):GetInt() == 0 and !game.SinglePlayer() then return end

            SetGlobalInt("RaidStatus", raidStatus.ACTIVE)
            SetGlobalInt("RaidTimeLeft", raidTime)

            timer.Create("RaidTimerDecrement", 1, 0, DecrementTimer)

            hook.Run("StartedRaid")
            SpawnAllLoot()

            net.Start("SendNotification")
            net.WriteString("The raid has begun!")
            net.WriteString("icons/door_icon.png")
            net.WriteString("round_start.wav")
            net.Broadcast()
        end

        function RAID:EndRaid()
            if GetGlobalInt("RaidStatus") != raidStatus.ACTIVE then return end

            SetGlobalInt("RaidStatus", raidStatus.ENDED)
            SetGlobalInt("RaidTimeLeft", self.VoteTime)

            -- kill players in raid, idk what else
            hook.Run("EndedRaid", RAID.VoteTime)

            -- thanks penal code
            if #player.GetHumans() == 0 then
                local tbl = {}

                for k, v in pairs(self.MapPool) do table.insert(tbl, k) end

                RunConsoleCommand("changelevel", tbl[math.random(#tbl)])

                return
            end

            timer.Adjust("RaidTimerDecrement", 1, self.VoteTime) -- fuck you timer.Adjust

            net.Start("VoteableMaps")
            net.Broadcast()

            net.Start("SendNotification")
            net.WriteString("The raid has ended!")
            net.WriteString("icons/door_icon.png")
            net.WriteString("round_warning.wav")
            net.Broadcast()

            for k, v in ipairs(player.GetHumans()) do
                if !v:CompareStatus(0) and !v:CompareStatus(3) and !v:HasGodMode() then v:Kill() end
            end
        end

        function RAID:GenerateSpawn(status)

            local spawn = GetValidRaidSpawn(status)
            local allSpawns = spawn.Spawns
            return allSpawns, spawn.SpawnGroup

        end

        function RAID:SpawnPlayers(plys, status, squad)
            if GetGlobalInt("RaidStatus") != raidStatus.ACTIVE then return end
            if #plys > 4 then print("too many fucking people in your team dumbass") return end

            local spawns = {}
            local spawnGroup = nil

            local faction
            if #plys <= 1 then
                status = (plys[1]:CompareFaction(true) and playerStatus.PMC) or (plys[1]:CompareFaction(false) and playerStatus.SCAV)
            else
                status = SQUADS[squad].FACTION
            end

            SQUADS[squad] = nil
            NetworkSquadInfoToClients()

            for k, v in ipairs(plys) do
                if !v:IsPlayer() then return end

                if !v:CompareStatus(0) and !v:CompareStatus(3) then
                    local curStatus, curSpawnGroup = v:GetRaidStatus()
                    print("Player " .. v:GetName() .. " tried to enter the raid with status " .. curStatus .. ", but they're probably fine to join anyway?")
                end

                if v:CompareStatus(3) then
                    local curStatus, curSpawnGroup = v:GetRaidStatus()
                    print("Player " .. v:GetName() .. " tried to enter the raid with status " .. curStatus .. ", this means they are in a duel, this shouldn't be possible at all, let's not let them join!")
                    return
                end

                if status == "nil" then status = faction end -- automatically set status depending on players faction

                net.Start("PlayerRaidTransition")
                net.Send(v)

                v:Freeze(true)
                v:SetMoveType(MOVETYPE_NOCLIP)

                if status == playerStatus.SCAV then
                    timer.Create("ScavLoadout" .. v:SteamID64(), 0.5, 1, function() RAID:GenerateScavLoadout(v) end)
                end

                timer.Create("Spawn" .. v:SteamID64(), 1, 1, function()
                    if #spawns == 0 then spawns, spawnGroup = RAID:GenerateSpawn(status) end

                    if #spawns == 0 then print("not enough spawn points for every squad member, this shouldn't be possible") return end
                    if spawnGroup == nil then print("spawn group not set for chosen spawn, this shouldn't be possible") return end

                    v:Freeze(false)
                    v:Teleport(spawns[k]:GetPos(), spawns[k]:GetAngles(), Vector(0, 0, 0))

                    local curTime = math.Round(CurTime(), 0) -- once players spawn, we make their team chat channel more specific, this is so others can create squads of the same name and not conflict with anything
                    v:SetRaidStatus(status, spawnGroup or "")
                    v:SetNWBool("PlayerIsPMC", true)
                    v:SetNW2String("PlayerInSquad", "nil")
                    v:SetNW2String("TeamChatChannel", squad .. "_" .. curTime)
                    v:SetNWInt("RaidsPlayed", v:GetNWInt("RaidsPlayed") + 1)
                    RemoveFIRFromInventory(v)
                    ResetRaidStats(v)
                end)
            end
        end

        function RAID:EndVote()
            local maxVote = 0
            local mapTable = {}

            for k, v in pairs(self.MapPool) do -- getting the max vote
                if v > maxVote then
                    maxVote = v
                end
            end

            for k, v in pairs(self.MapPool) do -- getting every map with the max vote into a table
                if v == maxVote then
                    table.insert(mapTable, k)
                end
            end

            RunConsoleCommand("changelevel", mapTable[math.random(#mapTable)])
        end

        function RAID:SubmitVote(ply, vote)
            if ply:GetNWBool("HasVoted", false) then ply:PrintMessage(HUD_PRINTTALK, "You have already voted!") return end
            if GetGlobalInt("RaidStatus") != raidStatus.ENDED then ply:PrintMessage(HUD_PRINTTALK, "The raid is still ongoing, your vote has not been counted.") return end
            if self.MapPool[vote] == nil then return end

            self.MapPool[vote] = self.MapPool[vote] + 1

            ply:SetNWBool("HasVoted", true)
            ply:PrintMessage(HUD_PRINTTALK, "Your vote of ".. vote .." has been counted!")
        end

        function RAID.GetCurrentExtracts(ply)
            if ply:CompareStatus(0) or ply:CompareStatus(3) then return nil end

            local extracts = {}

            for k, v in pairs(ents.FindByClass("efgm_extract")) do

                if ply:CompareSpawnGroup(v.ExtractGroup) then
                    local tbl = {}
                    tbl.ExtractName = v.ExtractName
                    tbl.ExtractTime = v.ExtractTime
                    tbl.IsGuranteed = v.IsGuranteed
                    tbl.IsDisabled = v.IsDisabled
                    tbl.ShowOnMap = v.ShowOnMap

                    if !tbl.ShowOnMap then tbl.ExtractName = string.gsub(tbl.ExtractName, "[^ ]", "?") end

                    table.insert(extracts, tbl)
                end
            end

            return extracts
        end

        function RAID:GenerateScavLoadout(ply)

            local _, weapon = table.Random(SCAV_WEAPONS)
            local weaponDef = EFGMITEMS[weapon]

            local weaponData = {}
            weaponData.att = SCAV_WEAPONS[weapon].scavAtts[math.random(#SCAV_WEAPONS[weapon].scavAtts)]
            weaponData.count = 1
            weaponData.owner = ply:SteamID64()
            weaponData.timestamp = os.time()

            local weaponItem = ITEM.Instantiate(weapon, weaponDef.equipType, weaponData)
            local weaponIndex = table.insert(ply.inventory, weaponItem)

            net.Start("PlayerInventoryAddItem", false)
            net.WriteString(weapon)
            net.WriteUInt(weaponDef.equipType, 4)
            net.WriteTable(weaponData)
            net.WriteUInt(weaponIndex, 16)
            net.Send(ply)

            local _, med = table.Random(SCAV_MEDS)
            local medDef = EFGMITEMS[med]

            local medData = {}
            medData.count = 1
            medData.durability = math.random(SCAV_MEDS[med].duraMin, SCAV_MEDS[med].duraMax)

            local medItem = ITEM.Instantiate(med, medDef.equipType, medData)
            local medIndex = table.insert(ply.inventory, medItem)

            net.Start("PlayerInventoryAddItem", false)
            net.WriteString(med)
            net.WriteUInt(medDef.equipType, 4)
            net.WriteTable(medData)
            net.WriteUInt(medIndex, 16)
            net.Send(ply)

            local nade = SCAV_NADES[math.random(#SCAV_NADES)]
            local nadeDef = EFGMITEMS[nade]

            local nadeData = {}
            nadeData.count = 1
            nadeData.owner = ply:SteamID64()
            nadeData.timestamp = os.time()

            local nadeItem = ITEM.Instantiate(nade, nadeDef.equipType, nadeData)
            local nadeIndex = table.insert(ply.inventory, nadeItem)

            net.Start("PlayerInventoryAddItem", false)
            net.WriteString(nade)
            net.WriteUInt(nadeDef.equipType, 4)
            net.WriteTable(nadeData)
            net.WriteUInt(nadeIndex, 16)
            net.Send(ply)

            local ammo = SCAV_WEAPONS[weapon].ammoID
            local ammoDef = EFGMITEMS[ammo]

            local ammoData = {}
            ammoData.count = math.random(SCAV_WEAPONS[weapon].ammoMin, SCAV_WEAPONS[weapon].ammoMax)

            local amount = tonumber(ammoData.count) or 1
            local ammoStackSize = ammoDef.stackSize

            local inv = {}

            for k, v in ipairs(ply.inventory) do

                inv[k] = {}
                inv[k].name = v.name
                inv[k].data = v.data
                inv[k].id = k

            end

            table.sort(inv, function(a, b) return a.data.count > b.data.count end)

            for k, v in ipairs(inv) do

                if v.name == ammo and v.data.count != ammoStackSize and amount > 0 then

                    local countToMax = ammoStackSize - v.data.count

                    if amount >= countToMax then

                        local newData = {}
                        newData.count = ammoStackSize
                        UpdateItemFromInventory(ply, v.id, newData)
                        amount = amount - countToMax

                    elseif amount < countToMax then

                        local newData = {}
                        newData.count = ply.inventory[v.id].data.count + amount
                        UpdateItemFromInventory(ply, v.id, newData)
                        amount = 0
                        break

                    end

                end

            end

            -- if leftover after checking every similar item type
            while amount > 0 do

                if amount >= ammoStackSize then

                    local newData = {}
                    newData.count = ammoStackSize

                    local ammoItem = ITEM.Instantiate(ammo, ammoDef.equipType, newData)
                    local ammoIndex = table.insert(ply.inventory, ammoItem)

                    net.Start("PlayerInventoryAddItem", false)
                    net.WriteString(ammo)
                    net.WriteUInt(ammoDef.equipType, 4)
                    net.WriteTable(newData)
                    net.WriteUInt(ammoIndex, 16)
                    net.Send(ply)

                    amount = amount - ammoStackSize

                else

                    local newData = {}
                    newData.count = amount

                    local ammoItem = ITEM.Instantiate(ammo, ammoDef.equipType, newData)
                    local ammoIndex = table.insert(ply.inventory, ammoItem)

                    net.Start("PlayerInventoryAddItem", false)
                    net.WriteString(ammo)
                    net.WriteUInt(ammoDef.equipType, 4)
                    net.WriteTable(newData)
                    net.WriteUInt(ammoIndex, 16)
                    net.Send(ply)

                    break

                end

            end

            CalculateInventoryWeight(ply)

        end
    --}

    --{ PLAYER FUNCTIONS
        function plyMeta:SetRaidStatus(status, spawnGroup)
            status = status or self:GetNWString("PlayerRaidStatus", 0)
            spawnGroup = spawnGroup or self:GetNWString("PlayerSpawnGroup", "")

            self:SetNWInt("PlayerRaidStatus", status)
            self:SetNWString("PlayerSpawnGroup", spawnGroup)

            if game.SinglePlayer() then return end -- no audio filters in SP
            UpdateAudioFilter(self, status)
        end

        function plyMeta:SetFaction(fac)
            if !self:CompareStatus(0) then return end
            if self:GetNW2String("PlayerInSquad", "nil") != "nil" then
                net.Start("SendNotification", false)
                net.WriteString("Can not change factions while in a squad!")
                net.WriteString("icons/exclamation_icon.png")
                net.WriteString("ui/squad_joined.wav")
                net.Send(self)
                return
            end

            if fac == self:GetNWBool("PlayerIsPMC", true) then return end

            fac = fac or !self:GetNWBool("PlayerIsPMC", true) -- switches if faction isn't specified

            if fac == false then -- scav

                UnequipAll(self)
                StashAllFromInventory(self)

            end

            -- nothing PMC specific for now

            self:SetNWBool("PlayerIsPMC", fac)
        end

        net.Receive("PlayerSwitchFactions", function(len, ply) ply:SetFaction() end)

        function plyMeta:Teleport(position, angles, velocity)
            self:SetPos(position)
            self:SetEyeAngles(angles)
            self:SetLocalVelocity(velocity)
            self:SetMoveType(MOVETYPE_WALK)
        end

        function plyMeta:GetRaidStatus()
            local status = self:GetNWInt("PlayerRaidStatus", 0)
            local spawnGroup = self:GetNWString("PlayerSpawnGroup", "")

            return status, spawnGroup
        end
    --}

    --{ HOOKS
        util.AddNetworkString("CreateExtractionInformation")
        hook.Add("PlayerExtraction", "RaidExtract", function(ply, extractTime, isExtractGuranteed)
            local lobbySpawns = ents.FindByClass("efgm_lobby_spawn") or {}

            local possibleSpawns = {}

            if table.IsEmpty(lobbySpawns) then error("no lobby spawns eat shit") return end

            -- all this is done so that players spawn in random spots bc yeah it was really that important
            for k, v in ipairs(lobbySpawns) do
                if v:CanSpawn(ply) then
                    table.insert(possibleSpawns, v)
                end
            end

            if #possibleSpawns == 0 then return end

            local randomSpawn = BetterRandom(possibleSpawns)

            net.Start("PlayerRaidTransition")
            net.Send(ply)

            ply:Lock()
            ply:SetMoveType(MOVETYPE_NOCLIP)

            timer.Create("Extract" .. ply:SteamID64(), 1, 1, function()
                ply:Teleport(randomSpawn:GetPos(), randomSpawn:GetAngles(), Vector(0, 0, 0))
                ply:SetHealth(ply:GetMaxHealth()) -- heals the player to full so dumb shit like quitting and rejoining to get max hp doesn't happen
                ply:SendLua("RunConsoleCommand('r_cleardecals')") -- clear decals for that extra 2 fps

                ply:SetNWBool("RaidReady", false)

                ply:UnLock()

                ply:SetNWInt("ExperienceBonus", ply:GetNWInt("ExperienceBonus") + 200)

                local xpMult = (ply:CompareStatus(2) and 0.5) or 1

                net.Start("CreateExtractionInformation")
                net.WriteFloat(xpMult)
                net.WriteInt(ply:GetNWInt("RaidTime", 0), 16)
                net.WriteInt(math.Round(ply:GetNWFloat("ExperienceTime", 0)), 16)
                net.WriteInt(ply:GetNWInt("ExperienceCombat", 0), 16)
                net.WriteInt(ply:GetNWInt("ExperienceExploration", 0), 16)
                net.WriteInt(ply:GetNWInt("ExperienceLooting", 0), 16)
                net.WriteInt(ply:GetNWInt("ExperienceBonus", 0), 16)
                net.Send(ply)

                ply:SetNWInt("RaidTime", 0)
                ApplyPlayerExperience(ply, xpMult)

                ply:SetRaidStatus(0, "")
            end)
        end)

        hook.Add("CheckRaidAddPlayers", "MaybeAddPeople", function(ply)
            local plySquad = ply:GetNW2String("PlayerInSquad", "nil")

            if #ply:GetWeapons() == 0 and ply:CompareFaction(true) then

                net.Start("SendNotification", false)
                net.WriteString("Can not enter a raid while having no equipped weapons!")
                net.WriteString("icons/exclamation_icon.png")
                net.WriteString("ui/squad_joined.wav")
                net.Send(ply)
                return

            end

            if ply:GetActiveWeapon() != NULL and ply:GetActiveWeapon():Clip1() == 0 and ply:GetActiveWeapon():GetMaxClip1() != -1 and ply:CompareFaction(true) then

                net.Start("SendNotification", false)
                net.WriteString("Can not enter a raid while your held weapon is not loaded!")
                net.WriteString("icons/renew_icon.png")
                net.WriteString("ui/squad_joined.wav")
                net.Send(ply)
                return

            end

            if ply:GetInfoNum("efgm_infil_nearend_block", 1) == 1 and ply:GetInfoNum("efgm_infil_nearend_limit", 60) >= GetGlobalInt("RaidTimeLeft") then

                net.Start("SendNotification", false)
                net.WriteString("Can not enter a raid that is about to end, you can change this in your settings!")
                net.WriteString("icons/time_icon.png")
                net.WriteString("ui/squad_joined.wav")
                net.Send(ply)
                return

            end

            if plySquad == "nil" then RAID:SpawnPlayers({ply}, "nil", "nil") return end
            if table.Count(SQUADS[plySquad].MEMBERS) <= 1 then RAID:SpawnPlayers({ply}, "nil", plySquad) return end

            local plys = {}
            local spawnBool = true

            for k, v in pairs(SQUADS[plySquad].MEMBERS) do
                table.insert(plys, v)
                if v:GetNWBool("RaidReady", false) == false then spawnBool = false end
            end

            if tobool(spawnBool) == true then
                RAID:SpawnPlayers(plys, "nil", plySquad)
            end
        end)

        hook.Add("RaidTimerTick", "RaidTimeNotifications", function(time)

            if time == 600 then

                net.Start("SendNotification")
                net.WriteString("Exfils close in 10 minutes!")
                net.WriteString("icons/door_icon.png")
                net.WriteString("round_warning.wav")
                net.Broadcast()

            end

            if time == 300 then

                net.Start("SendNotification")
                net.WriteString("Exfils close in 5 minutes!")
                net.WriteString("icons/door_icon.png")
                net.WriteString("round_warning.wav")
                net.Broadcast()

            end

            if time == 60 then

                net.Start("SendNotification")
                net.WriteString("Exfils close in 60 seconds!")
                net.WriteString("icons/door_icon.png")
                net.WriteString("round_warning.wav")
                net.Broadcast()

            end

        end)

        hook.Add("PlayerInitialSpawn", "SetToPMC", function(ply)
            ply:SetNWBool("PlayerIsPMC", true)
        end)
    --}

    net.Receive("GrabExtractList", function(len, ply)
        local extracts = RAID.GetCurrentExtracts(ply)

        if not istable(extracts) then return end

        net.Start("SendExtractList")
        net.WriteTable(extracts)
        net.Send(ply)
    end)

    net.Receive("SendVote", function(len, ply)
        RAID:SubmitVote(ply, net.ReadString())
    end)
end

if CLIENT then
    concommand.Add("efgm_vote", function(ply, cmd, args)
        net.Start("SendVote")
            net.WriteString(args[1])
        net.SendToServer()
    end)
end

function plyMeta:CompareSpawnGroup(group)
    -- fuck off with your "addons/efgmrewrite/gamemodes/efgmrewrite/entities/entities/efgm_extract.lua:114: unexpected symbol near ')'" bullshit there's fixing to be an unexpected hole in my goddamn monitor
    -- oh i forgot an end

    group = group or ""

    if group == "" then return true end

    return self:GetNWString("PlayerSpawnGroup", "") == group
end

function plyMeta:CompareStatus(status) -- if player is in raid then status of 0 will return false
    return self:GetNWInt("PlayerRaidStatus", 0) == status
end

function plyMeta:CompareFaction(status) -- if player is a PMC then status of true will return true
    return self:GetNWBool("PlayerIsPMC", true) == status
end

-- i love debugging commands omg
if GetConVar("efgm_derivesbox"):GetInt() == 1 then

    function ForceSpawnPlayer(ply)

        ply:SetNWBool("RaidReady", true)
        hook.Run("CheckRaidAddPlayers", ply)

    end
    concommand.Add("efgm_debug_spawn", function(ply, cmd, args) ForceSpawnPlayer(ply) end)

    function ForceExtractPlayer(ply)

        if ply:CompareStatus(0) then return end
        hook.Run("PlayerExtraction", ply, 67, true, "imgonnaendit")

    end
    concommand.Add("efgm_debug_extract", function(ply, cmd, args) ForceExtractPlayer(ply) end)

end