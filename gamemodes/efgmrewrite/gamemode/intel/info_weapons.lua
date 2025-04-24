-- has to be ran once all SWEPs are created
hook.Add("InitPostEntity", "WeaponIntel", function()
    -- grab all weapons, its 4am let this slide please
    local weaponList = table.Copy(debugPrimWep)
    table.Add(weaponList, debugSecWep)
    table.Add(weaponList, debugNadeWep)
    table.Add(weaponList, debugMeleeWep)

    for k, v in SortedPairsByValue(weaponList) do
        local wep = table.Copy(weapons.Get(v))

        -- weapon stats
        local damageMax = math.Round(wep["DamageMax"]) or ""
        local damageMin = math.Round(wep["DamageMin"]) or ""
        local rpm = math.Round(wep["RPM"]) or ""
        local range = math.Round(wep["RangeMax"] * 0.0254) or ""
        local velocity = math.Round(wep["PhysBulletMuzzleVelocity"] * 0.0254) or ""

        local manufacturer = wep["Trivia"]["Manufacturer1"] or ""
        local caliber = wep["Caliber"] or ""
        local year = wep["Trivia"]["Year5"] or ""

        local wepTable = {

            Name = wep["PrintName"],
            Description = wep["Description"] .. [[


Damage: ]] .. damageMax .. " → " .. damageMin .. [[

RPM: ]] .. rpm .. [[

Range: ]] .. range .. "m" .. [[

Muzzle Velocity: ]] .. velocity .. "m/s" .. [[


Manufacturer: ]] .. manufacturer .. [[

Caliber: ]] .. caliber .. [[

Year: ]] .. year

        }

        table.insert(Intel.WEAPONS, wepTable)
    end
end)
