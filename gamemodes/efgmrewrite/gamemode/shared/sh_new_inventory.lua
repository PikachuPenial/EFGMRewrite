
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