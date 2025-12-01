EFGM.Favorites = {}

function EFGM:LoadFavorites()

    local f = file.Open("efgm_market_favorites.txt", "r", "DATA")
    if !f then return end

    EFGM.Favorites = {}

    while !f:EndOfFile() do

        local line = f:ReadLine()
        line = string.Trim(line, "\n")

        EFGM.Favorites[line] = true

    end

    f:Close()

end

function EFGM:SaveFavorites()

    local f = file.Open("efgm_market_favorites.txt", "w", "DATA")

    for i, k in pairs(EFGM.Favorites) do

        f:Write(i)
        f:Write("\n")

    end

    f:Close()

end

function EFGM:AddAttToFavorites(item)

    EFGM.Favorites[item] = true
    EFGM:SaveFavorites()

end

function EFGM:RemoveAttFromFavorites(item)

    EFGM.Favorites[item] = nil
    EFGM:SaveFavorites()

end

function EFGM:ToggleFavorite(item)

    if EFGM.Favorites[item] then

        EFGM.Favorites[item] = nil
        surface.PlaySound("arc9/newui/ui_part_favourite2.ogg")

    else

        EFGM.Favorites[item] = true
        surface.PlaySound("arc9/newui/ui_part_favourite1.ogg")

    end

    EFGM:SaveFavorites()

end

hook.Add("PreGamemodeLoaded", "LoadShopFavorites", function()

    EFGM:LoadFavorites()

end)

hook.Add("OnReloaded", "ReloadShopFavorites", function()

    EFGM:LoadFavorites()

end)