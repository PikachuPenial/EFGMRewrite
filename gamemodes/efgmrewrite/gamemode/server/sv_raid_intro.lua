-- manages some parts of raid intros, which now that i think about it are really unnecessary but fuck it i ball

IntroSpaces = {}

hook.Add("InitPostEntity", "IntroInit", function()

    local introModels = ents.FindByName("INTRO*")

    if table.IsEmpty(introModels) then return end

    -- copying entities

    for k, v in ipairs(introModels) do

        for i = 1, game.MaxPlayers() do

            local newIntro = ents.Create("prop_dynamic")
            newIntro:SetModel(v:GetModel())
            newIntro:SetRenderMode(RENDERMODE_NONE)
            newIntro:SetName(v:GetName() .. "|" .. i)
            newIntro:SetPos(v:GetPos())
            newIntro:SetAngles(v:GetAngles())
            newIntro:Spawn()
            newIntro:Activate()

        end

    end

    for k, v in ipairs(ents.FindByName("INTRO*")) do

        IntroSpaces[k] = {animName = v:GetName(), occupied = false}

    end

end)

function IntroGetFreeSpace(spawnGroup)

    if #IntroSpaces == 0 then
        return nil
    end

    local shuffledIntroSpaces = IntroSpaces
    table.Shuffle(shuffledIntroSpaces) -- whoever decided this didnt need to return a value needs to be studied

    if spawnGroup != nil then spawnGroup = string.lower(spawnGroup) end

    for k, spaceInfo in ipairs(shuffledIntroSpaces) do

        --local spaceSpawnGroup = string.lower(string.Explode("_", spaceInfo.animName)[2])

        --if !spaceInfo.occupied && spaceSpawnGroup == spawnGroup then
        if !spaceInfo.occupied then
            return spaceInfo.animName, k
        end

    end

    return nil

end