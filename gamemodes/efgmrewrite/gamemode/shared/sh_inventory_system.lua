
local plyMeta = FindMetaTable( "Player" )
if not plyMeta then Error("Could not find player table") return end

INVG = {}

-- fuck it ima just remake this

function INVG.New( width, height )

    local inv = {}

    inv.contents = {} -- items within

    inv.width = width or math.huge
    inv.height = height or math.huge

    function inv:Add(pos, name, type, count)

        self.contents[pos] = {}
        self.contents[pos].name = name
        self.contents[pos].type = type
        self.contents[pos].count = count or 1

    end

    function inv:Remove(pos, count)

        count = count or self.contents[pos].count

        if count == self.contents[pos].count then
            
            self.contents[pos] = nil

        else
            
            self.contents[pos].count = self.contents[pos].count - count

        end

    end

    function inv:Move( oldPos, newPos, count )

        count = count or self.contents[oldPos].count
            
        self:Add(newPos, self.contents[oldPos].name, self.contents[oldPos].type, count)
        self:Remove(oldPos, count)

    end

    -- More specific utilities

    function inv:GetAll( name, type )

        local returnTable = {}

        for k, v in pairs( self.contents ) do
            
            if v.name == name and v.type == type then
                
                returnTable.Add()

            end

        end

        return returnTable
    
    end

    return inv

end

-- for context, in the location information string, "g" signifies grid coordinates, while "s" signifies a slot name

function INVG.LocationInformationTOPos( locationInformation, width, height )

    width = width or math.huge
    height = height or math.huge

    local locationInformationTable = string.Explode( "_", locationInformation )

    if locationInformationTable[1] != "g" then return nil end -- this only converts grid location strings to position tables

    local pos = {}

    pos.x = tonumber( locationInformationTable[2] )
    pos.y = tonumber( locationInformationTable[3])

    if pos.x > width then return nil end
    if pos.y > height then return nil end

    return pos

end
concommand.Add("efgm_debug_loctopos", function(ply, cmd, args)

    local locationInformation = tostring( args[1] )
    local pos = INVG.LocationInformationTOPos( locationInformation )

    if istable(pos) then

        print(pos.x)
        print(pos.y)
    
    else

        print("nil")

    end

end)

function INVG.PosTOLocationInformation( pos, width, height )

    width = width or math.huge
    height = height or math.huge

    if pos.x > width then return nil end
    if pos.y > height then return nil end

    -- l designates a grid location instead of an active slot, periods are to explode the string easier
    -- if only lua let you use tables as keys to skip this bs
    local locationInformation = "g".."_"..tostring(pos.x).."_"..tostring(pos.y)
    -- example: if pos.x = 4 annd pos.y = 7, then locationInformation = l.4.7

    return locationInformation

end
concommand.Add("efgm_debug_postoloc", function(ply, cmd, args)

    local pos = {}
    pos.x = tonumber( args[1] )
    pos.y = tonumber( args[2] )

    print( INVG.PosTOLocationInformation( pos ) or "nil" )

end)