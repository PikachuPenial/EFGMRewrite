-- basically makes a bunch of convenience variables for menus and shit
-- will interit mostly from efgm "Constants for easy use" while i figure out what im actually doing
-- also on a sidenote, searching "fuck" in efgmrewrite previously yielded 19 results (now 20) as of 1:40 PM CDT, 3/13/2023 and I may have a problem

MenuAlias = {}

MenuAlias.blackColor =      Color(10, 10, 10, 255)
MenuAlias.whiteColor = 		Color(250, 250, 250, 255)
MenuAlias.offWhiteColor = 	Color(200, 200, 200, 255)
MenuAlias.transparent =     Color(0, 0, 0, 0)

MenuAlias.primaryColor =	Color(30, 30, 30, 255)
MenuAlias.secondaryColor =	Color(100, 100, 100, 255)

MenuAlias.inRaidColor = 	Color(50, 255, 50, 255)		-- Red
MenuAlias.outRaidColor = 	Color(255, 255, 255, 255)		-- Green
MenuAlias.deadColor = 		Color(255, 50, 50, 255)	-- Gray what the fuck was i colorblind

MenuAlias.margin = 		    math.Round( ScrH() * 0.01 )
MenuAlias.margins =         {MenuAlias.margin, MenuAlias.margin, MenuAlias.margin, MenuAlias.margin} -- in DockMargin or DockPadding functions, use unpack( MenuAlias.margins ) which equates to "take these 4 values from this one argument"