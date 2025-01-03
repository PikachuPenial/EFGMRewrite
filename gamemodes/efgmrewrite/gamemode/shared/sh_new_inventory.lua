
-- ill fill this out later but rn its more or less an outline so i can cross off "work on efgm inventory system" from my calender for once
-- (i have written it every weekday for the past 2 weeks) without actually being productive

-- just so i keep in mind what went wrong with the old system, it got way too cluttered with helper functions, and i kept swinging back
-- and forth between different ideas that were all technically supported by the system, even though any of them wouldve been
-- too much of a pain in the ass to implement

-- i also really liked how terraria did it from what i remember from my days with tmodloader, and being that there's jack shit on the internet about
-- how to actually code an inventory system, i want to stick to what i know is probably gonna work

-- i think it'd be cool to have each item's stats defined somewhere (like weight, equip type, display price, etc), but idk where
-- i could either have them defined in the entity file, which would be neat, but that would then require probably multiple functions to grab that data
-- as opposed to just going to some json file to grab it, but then if it's all stored in a json file that would all have to be manually kept up to date

-- as for how items would be stored in an inventory, i'm thinking about just having like inv.itemname = {count, metadata}, which would be simple, but
-- then the stack logic might get complex

-- on the other hand, i could just give each inventory slot a string / integer identifier, and have it like inv.slot = {itemname, count, metadata}

-- shit so lua doesn't get mad at me for having an empty .lua file
-- https://www.youtube.com/watch?v=Iv3F5ARdu58

-- code below is deprecated but is needed for the meantime to make deaths function

local plyMeta = FindMetaTable( "Player" )
if not plyMeta then Error("Could not find player table") return end

INV = {}

-- fuck it ima just remake this

function INV.New()

    local inv = {}

    inv.contents = {} -- items within

    function inv:Add( name, type, count )

        local key = table.insert(self.contents, {})

        self.contents[key].name = name
        self.contents[key].type = type
        self.contents[key].count = count or 1

    end

    function inv:Remove(name, count)

        -- todo

        return false

    end

    return inv

end

GiveItem = {}

GiveItem[1] = function(ply, item, count, noReserveAmmo) -- weapons
    ply:Give( item, noReserveAmmo )
end

GiveItem[2] = function(ply, item, count, noReserveAmmo) -- ammo
    ply:GiveAmmo(count or 1, item, true)
end

GiveItem[3] = function(ply, item, count, noReserveAmmo) -- attatchment
    ARC9:PlayerGiveAtt(ply, item, count or 1)
end

-- onto the actual new stuff

function ReadJSON( fileName )

    return file.Read( "addons/EFGMRewrite/gamemodes/efgmrewrite/gamemode/json/" .. fileName .. ".json", "GAME" )

end

concommand.Add("efgm_print_json", function(ply, cmd, args)

    PrintTable( ReadJSON( tostring( args[1] ) ) )

end)

concommand.Add("efgm_debug_testitems", function(ply, cmd, args)
    
    local inventory = CONTAINER.NewContainer( 5, 10, 600 )
    local weapon = ITEM.CreateItem( "arc9_eft_akm", 1, {} )

    inventory:AddItem(weapon, 2, 2)

    PrintTable(inventory)
    PrintTable(weapon)

    local id = CONTAINER.GetSlotID( 2, 2, 5 )
    local x, y = CONTAINER.GetCoords( id, 5 )

    print( "Slot ID - " .. id )
    print( "Slot x - " .. x )
    print( "Slot y - " .. y )


end)