-- manages some parts of raid intros, which now that i think about it are really unnecessary but fuck it i ball
-- remove it if you want, nothing will unfuck the efgm codebase

IntroSpaces = {}

hook.Add( "InitPostEntity", "IntroInit", function()
    
    if !table.IsEmpty(ents.FindByName("INTRO*")) then
    
        for k, v in ipairs(ents.FindByName("INTRO*")) do
            
            IntroSpaces[k] = {animName = v:GetName(), occupied = false}

        end

    end

end )

function IntroGetFreeSpace()

    if #IntroSpaces == 0 then
        return nil
    end

    for k, v in ipairs(IntroSpaces) do
        
        if !v.occupied then
            return v.animName, k
        end

    end

    return nil

end