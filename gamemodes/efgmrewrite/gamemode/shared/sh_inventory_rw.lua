
local plyMeta = FindMetaTable( "Player" )
if not plyMeta then Error("Could not find player table") return end

INVG = {}

-- fuck it ima just remake this

function INVG.New(width, height)

    local inv = {}

    

    return inv

end

-- TODO: generalize both functions to take into account the height and width of the inventory
function INVG.LocationInformationTOPos( locationInformation )

    -- handles overflows
    if locationInformation > 4294967295 then return nil end

    -- yeah this fuckery actually works im suprised too
    local pos = {}

    pos.y = bit.rshift( bit.band( locationInformation, 4294901760 ), 16 ) + 1 -- evil floating point bit level hacking
    pos.x = bit.band( locationInformation, 32767 ) + 1 -- what the fuck?
    pos.as = bit.rshift( bit.band( locationInformation, 32768 ), 15)

    return pos

end
concommand.Add("efgm_debug_loctopos", function(ply, cmd, args)

    local loadoutInformation = tonumber( args[1] )

    print("Input:")
    print( loadoutInformation )
    print("Output")
    PrintTable( INVG.LocationInformationTOPos( loadoutInformation ) or {"You broke it"} )

end)

function INVG.PosTOLocationInformation( pos )

    -- these handle overflows
    if pos.x > 32767 then return nil end
    if pos.y > 65535 then return nil end
    if pos.as > 1 then return nil end

    local locationInformation = (pos.x - 1) + ((pos.y - 1) * 65536) + (pos.as * 32768)

    return locationInformation

end
concommand.Add("efgm_debug_postoloc", function(ply, cmd, args)

    local pos = {}
    pos.x = tonumber( args[1] )
    pos.y = tonumber( args[2] )
    pos.as = tonumber( args[3] or 0 )

    print("Input:")
    PrintTable( pos )
    print("Output")
    print( INVG.PosTOLocationInformation( pos ) or -1 )

end)