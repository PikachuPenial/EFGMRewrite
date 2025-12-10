-- basically makes a bunch of convenience variables for menus and shit
-- will interit mostly from efgm "Constants for easy use" while i figure out what im actually doing
-- also on a sidenote, searching "fuck" in efgmrewrite previously yielded 19 results (now 20) as of 1:40 PM CDT, 3/13/2023 and I may have a problem

MenuAlias = {}

MenuAlias.blackColor =      Color(10, 10, 10, 255)
MenuAlias.pureWhiteColor =  Color(255, 255, 255, 255)
MenuAlias.whiteColor = 		Color(250, 250, 250, 255)
MenuAlias.offWhiteColor = 	Color(200, 200, 200, 255)
MenuAlias.transparent =     Color(0, 0, 0, 0)

MenuAlias.primaryColor =	Color(30, 30, 30, 255)
MenuAlias.secondaryColor =	Color(100, 100, 100, 255)

MenuAlias.inRaidColor = 	Color(50, 255, 50, 255)		-- Red
MenuAlias.outRaidColor = 	Color(255, 255, 255, 255)		-- Green
MenuAlias.deadColor = 		Color(255, 50, 50, 255)	-- Gray what the fuck was i colorblind
MenuAlias.neutralColor = 	Color(255, 255, 50, 255)

MenuAlias.hudBackground =   Color(0, 0, 0, 128)

MenuAlias.transparentWhiteColor = Color(255, 255, 255, 155)
MenuAlias.transparentBlackColor = Color(0, 0, 0, 100)
MenuAlias.whiteBorderColor = Color(255, 255, 255, 25)
MenuAlias.frameColor =      Color(0, 0, 0, 240)
MenuAlias.scrollerColor =   Color(0, 0, 0, 50)
MenuAlias.itemColor =	    Color(5, 5, 5, 20)
MenuAlias.itemBackgroundColor =	Color(255, 255, 255, 2)
MenuAlias.containerBackgroundColor = Color(80, 80, 80, 10)
MenuAlias.containerHeaderColor = Color(155, 155, 155, 10)
MenuAlias.contextBackgroundColor = Color(5, 5, 5, 50)
MenuAlias.contextBorder =   Color(255, 255, 255, 30)
MenuAlias.weaponSilhouetteColor = Color(255, 255, 255, 10)
MenuAlias.marketItemValueColor = Color(80, 80, 80, 50)

MenuAlias.modelLeftColor =  Color(255, 160, 80, 255)
MenuAlias.modelRightColor = Color(80, 160, 255, 255)

MenuAlias.healthGreenColor = Color(25, 255, 25, 255)

MenuAlias.weightUnderColor = Color(255, 255, 255, 225)
MenuAlias.weightWarningColor = Color(255, 255, 0, 225)
MenuAlias.weightMaxColor =  Color(255, 0, 0, 225)

MenuAlias.margin = 		    math.Round( ScrH() * 0.01 )
MenuAlias.margins =         {MenuAlias.margin, MenuAlias.margin, MenuAlias.margin, MenuAlias.margin} -- in DockMargin or DockPadding functions, use unpack( MenuAlias.margins ) which equates to "take these 4 values from this one argument"

Mats = {}

Mats.arrowForwardIcon = Material("icons/arrow_forward_icon.png", "smooth")
Mats.arrowBackIcon = Material("icons/arrow_back_icon.png", "smooth")
Mats.closeButtonIcon = Material("icons/close_icon.png", "smooth")
Mats.roubleIcon = Material("icons/rouble_icon.png", "smooth")
Mats.sellIcon = Material("icons/sell_icon.png", "smooth")
Mats.favoriteIcon = Material("icons/favorite_icon.png", "smooth")
Mats.lockIcon = Material("icons/lock_icon.png", "smooth")
Mats.pinIcon = Material("icons/pin_icon.png", "smooth")
Mats.firIcon = Material("icons/fir_icon.png", "smooth")