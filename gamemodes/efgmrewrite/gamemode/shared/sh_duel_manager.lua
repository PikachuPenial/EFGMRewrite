DUEL = {}

local plyMeta = FindMetaTable("Player")
if !plyMeta then Error("Could not find player table") return end

if SERVER then

    util.AddNetworkString("PlayerDuelTransition")
    util.AddNetworkString("PlayerInventoryReloadForDuel")
    util.AddNetworkString("PlayerReinstantiateInventoryAfterDuel")

    SetGlobalInt("DuelStatus", duelStatus.PENDING)

    DUEL.Players = {}
    DUEL.Allowed = true

    function DUEL:StartDuel(ply1, ply2)

        if GetGlobalInt("DuelStatus") != duelStatus.PENDING or !DUEL.Allowed then return end

        local spawns = RandomDuelSpawns()
        if !spawns then return end -- no duel spawns available on the map

        SetGlobalInt("DuelStatus", duelStatus.ACTIVE)

        hook.Run("StartedDuel")

        DUEL.Players = {ply1, ply2}

        net.Start("PlayerDuelTransition")
        net.Send(DUEL.Players)

        local randLoadoutNum = math.random(1, 9)

        local primaryItem, secondaryItem = DUEL:GenerateLoadout(randLoadoutNum)

        for k, v in ipairs(DUEL.Players) do -- there is literally no reason for this to have more than 2 players, so i will asssume that it is 2 players

            v:Freeze(true)
            v:SetNWBool("RaidReady", false)

            UnequipAll(v)
            UpdateInventoryString(v)
            UpdateEquippedString(v)

            v:SetNWBool("InRange", true)

            timer.Create("Duel" .. v:SteamID64(), 1, 1, function()

                if primaryItem != nil then DUEL:EquipPrimary(v, primaryItem) end
                if secondaryItem != nil then DUEL:EquipHolster(v, secondaryItem) end

                net.Start("PlayerInventoryReloadForDuel")
                net.WriteTable(primaryItem or {})
                net.WriteTable(secondaryItem or {})
                net.Send(v)

                v:SetNWFloat("InventoryWeight", 0)
                v:Teleport(spawns[k]:GetPos(), spawns[k]:GetAngles(), Vector(0, 0, 0))
                v:SetHealth(v:GetMaxHealth())

                timer.Simple(1, function() v:Freeze(false) end)

                DUEL:ReloadLoadoutItems(v)
                v:SetRaidStatus(3, "")
                v:SetNWInt("DuelsPlayed", v:GetNWInt("DuelsPlayed") + 1)
                ResetRaidStats(v) -- because im lazy and won't make a special death overview

            end)

        end

    end

    function DUEL:EndDuel(deadPly)

        if GetGlobalInt("DuelStatus") != duelStatus.ACTIVE then return end

        SetGlobalInt("DuelStatus", duelStatus.PENDING)

        hook.Run("EndedDuel")

        table.RemoveByValue(DUEL.Players, deadPly)

        net.Start("PlayerDuelTransition")
        net.Send(DUEL.Players)

        for k, v in ipairs(DUEL.Players) do -- should only be a single player, the winner of the duel

            local lobbySpawns = ents.FindByClass("efgm_lobby_spawn") or {}

            local possibleSpawns = {}

            if table.IsEmpty(lobbySpawns) then error("no lobby spawns eat shit") return end

            -- all this is done so that players spawn in random spots bc yeah it was really that important
            for key, spawn in ipairs(lobbySpawns) do
                if spawn:CanSpawn(v) then
                    table.insert(possibleSpawns, spawn)
                end
            end

            if #possibleSpawns == 0 then return end

            local randomSpawn = BetterRandom(possibleSpawns)

            v:Lock()

            timer.Create("DuelWin" .. v:SteamID64(), 1, 1, function()

                ReinstantiateInventoryAfterDuel(v)
                net.Start("PlayerReinstantiateInventoryAfterDuel", false)
                net.Send(v)

                v:Teleport(randomSpawn:GetPos(), randomSpawn:GetAngles(), Vector(0, 0, 0))
                v:SetHealth(v:GetMaxHealth())
                v:SendLua("RunConsoleCommand('r_cleardecals')")

                v:SetRaidStatus(0, "")
                v:SetNWInt("DuelsWon", v:GetNWInt("DuelsWon") + 1)

                v:UnLock()

                CalculateInventoryWeight(v)

            end)

        end

    end

    -- in the case that a duel is running right before a map switch
    function DUEL:CancelDuel()

        if GetGlobalInt("DuelStatus") != duelStatus.ACTIVE then return end

        hook.Run("CancelledDuel")

        for k, v in ipairs(DUEL.Players) do

            v:Kill()

            ReinstantiateInventoryAfterDuel(v)
            net.Start("PlayerReinstantiateInventoryAfterDuel", false)
            net.Send(v)

        end

    end

    -- equipping items here to bypass the equip block when in a duel
    function DUEL:EquipPrimary(ply, item)

        ply.weaponSlots[1][1] = item

        equipWeaponName = item.name
        GiveWepWithPresetFromCode(ply, item.name, item.data.att)

    end

    function DUEL:EquipHolster(ply, item)

        ply.weaponSlots[2][1] = item

        equipWeaponName = item.name
        GiveWepWithPresetFromCode(ply, item.name, item.data.att)

    end

    function DUEL:GenerateLoadout(num)

        if !DUEL_PRIMARY[num] then print("invalid loadout number, no loadout being given") return end

        if num < 8 then

            local primaryItemVal, primaryItemKey = table.Random(DUEL_PRIMARY[num])
            local primaryDef = EFGMITEMS[primaryItemKey]

            local primaryData = {}
            primaryData.count = 1
            if primaryDef.defAtts then primaryData.att = primaryDef.defAtts end
            local primaryItem = ITEM.Instantiate(primaryItemKey, primaryDef.equipType, primaryData)

            local secondaryItemVal, secondaryItemKey = table.Random(DUEL_SECONDARY[1])
            local secondaryDef = EFGMITEMS[secondaryItemKey]

            local secondaryData = {}
            secondaryData.count = 1
            if secondaryDef.defAtts then secondaryData.att = secondaryDef.defAtts end
            local secondaryItem = ITEM.Instantiate(secondaryItemKey, secondaryDef.equipType, secondaryData)

            return primaryItem, secondaryItem

        elseif num == 8 then

            local secondaryItemVal, secondaryItemKey = table.Random(DUEL_SECONDARY[1])
            local secondaryDef = EFGMITEMS[secondaryItemKey]

            local secondaryData = {}
            secondaryData.count = 1
            if secondaryDef.defAtts then secondaryData.att = secondaryDef.defAtts end
            local secondaryItem = ITEM.Instantiate(secondaryItemKey, secondaryDef.equipType, secondaryData)

            return nil, secondaryItem

        end

    end

    function DUEL:ReloadLoadoutItems(ply)

        for k, v in ipairs(ply:GetWeapons()) do

            v:SetClip1(v:GetMaxClip1())
            v:SetClip2(v:GetMaxClip2())

        end

    end

    hook.Add("PlayerDeath", "EndDuelOnDeath", function(victim, weapon, attacker)

        if !victim:CompareStatus(3) then return end -- the player wasn't a part of the duel

        DUEL:EndDuel(victim)

        ReinstantiateInventoryAfterDuel(victim)
        net.Start("PlayerReinstantiateInventoryAfterDuel", false)
        net.Send(victim)

    end)

    hook.Add("EndedRaid", "EndDuelOnMapChange", function(time)

        timer.Simple(time / 2, function() DUEL.Allowed = false end) -- disable any new duels
        timer.Simple(time - 3, function() DUEL:CancelDuel() end)    -- force cancel current duel

    end)

end