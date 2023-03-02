-- Create a new font for the compass using the surface.CreateFont function.
-- This font will be used to draw the compass text.

-- Define a function to draw the compass.
local function DrawCompass()

    -- Get a reference to the local player entity.
    local ply = LocalPlayer()

    -- Get the player's current eye angles, which will be used to determine the direction they are facing.
    local ang = ply:EyeAngles()

    surface.SetFont("DermaDefaultBold")
    surface.SetTextPos(100, 100)
    draw.SimpleText(tostring(ang.y), "DermaLarge", 100, 100, Color(0, 0, 0))

    local compassX, compassY = ScrW() * 0.5, ScrH() * 0
    local width, height = ScrW() * 2, ScrH() * 0.05

    local color = Color(255, 255, 255)

    spacing = (width * 1) / 360
    numOfLines = width / spacing
    fadeDistMultiplier = 20
    fadeDistance = (width / 2) / fadeDistMultiplier

	local adv_compass_tbl = {
		[0] = "N",
		[45] = "NE",
		[90] = "E",
		[135] = "SE",
		[180] = "S",
		[225] = "SW",
		[270] = "W",
		[315] = "NW",
		[360] = "N"
	}

    for i = math.Round(-ang.y) % 360, (math.Round(-ang.y) % 360) + numOfLines do

        local x = ((compassX - (width / 2)) + (((i + ang.y) % 360) * spacing))
        local value = math.abs(x - compassX)
        local calc = 1 - ((value + (value - fadeDistance)) / (width / 2))
        local calculation = 255 * math.Clamp(calc, 0.001, 1)

        local i_offset = -(math.Round(i - 0 - (numOfLines / 2))) % 360

        if i_offset % 15 == 0 and i_offset >= 0 then
            local a = i_offset
            local text = adv_compass_tbl[360 - (a % 360)] and adv_compass_tbl[360 - (a % 360)] or 360 - (a % 360)
            local font = "DermaLarge"

            surface.SetDrawColor(Color(color.r, color.g, color.b, calculation))
            surface.DrawLine(x, compassY, x, compassY + height * 0.5)

            draw.SimpleText(text, font, x, compassY + height * 0.6, Color(color.r, color.g, color.b, calculation), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
        end

    end

end

-- Register the DrawCompass function to be called every frame using the HUDPaint hook.
hook.Add("HUDPaint", "DrawCompass", DrawCompass)

function HideHud(name)
	for k, v in pairs({"CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo"}) do
		if name == v then
			return false
		end
	end
end
hook.Add("HUDShouldDraw", "HideDefaultHud", HideHud)