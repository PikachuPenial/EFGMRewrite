
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