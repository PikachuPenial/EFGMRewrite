-- will get to this when prints become an issue
-- prints aren't an issue but im bored and would like to do literally anything that isnt related to ui

DEBUG = {}

function DEBUG.NotImplemented(doHalt, layer)

    doHalt = doHalt or false
    layer = layer or 1

    local switch = {}

    switch[false] = function()
        ErrorNoHaltWithStack("Function not implemented!")
    end

    switch[true] = function()
        error("Function not implemented!", layer)
    end

    switch[doHalt]()

end