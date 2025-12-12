-- basically makes a bunch of convenience variables for menus and shit
-- will interit mostly from efgm "Constants for easy use" while i figure out what im actually doing
-- also on a sidenote, searching "fuck" in efgmrewrite previously yielded 19 results (now 20) as of 1:40 PM CDT, 3/13/2023 and I may have a problem

Colors = {}

Colors.blackColor =      Color(10, 10, 10, 255)
Colors.pureWhiteColor =  Color(255, 255, 255, 255)
Colors.whiteColor = 		Color(250, 250, 250, 255)
Colors.offWhiteColor = 	Color(200, 200, 200, 255)
Colors.transparent =     Color(0, 0, 0, 0)

Colors.primaryColor =	Color(30, 30, 30, 255)
Colors.secondaryColor =	Color(100, 100, 100, 255)

Colors.inRaidColor = 	Color(50, 255, 50, 255)		-- Red
Colors.outRaidColor = 	Color(255, 255, 255, 255)		-- Green
Colors.deadColor = 		Color(255, 50, 50, 255)	-- Gray what the fuck was i colorblind
Colors.neutralColor = 	Color(255, 255, 50, 255)

Colors.hudBackground =   Color(0, 0, 0, 128)

Colors.transparentWhiteColor = Color(255, 255, 255, 155)
Colors.transparentBlackColor = Color(0, 0, 0, 100)
Colors.whiteBorderColor = Color(255, 255, 255, 25)
Colors.frameColor =      Color(0, 0, 0, 240)
Colors.scrollerColor =   Color(0, 0, 0, 50)
Colors.itemColor =	    Color(5, 5, 5, 20)
Colors.itemBackgroundColor =	Color(255, 255, 255, 2)
Colors.itemBackgroundColorHovered =	Color(255, 255, 255, 30)
Colors.containerBackgroundColor = Color(80, 80, 80, 10)
Colors.containerHeaderColor = Color(155, 155, 155, 10)
Colors.contextBackgroundColor = Color(5, 5, 5, 50)
Colors.contextBorder =   Color(255, 255, 255, 30)
Colors.weaponSilhouetteColor = Color(255, 255, 255, 10)
Colors.marketItemValueColor = Color(80, 80, 80, 50)

Colors.modelLeftColor =  Color(255, 160, 80, 255)
Colors.modelRightColor = Color(80, 160, 255, 255)

Colors.healthGreenColor = Color(25, 255, 25, 255)

Colors.weightUnderColor = Color(255, 255, 255, 225)
Colors.weightWarningColor = Color(255, 255, 0, 225)
Colors.weightMaxColor =  Color(255, 0, 0, 225)

Colors.mapWhite =       Color(255, 255, 255, 240)
Colors.mapSpawn =       Color(52, 124, 218, 240)
Colors.mapExtract =     Color(19, 196, 34, 240)
Colors.mapLocation =    Color(202, 20, 20, 240)
Colors.mapKey =         Color(252, 152, 2, 240)
Colors.mapOverviewLine = Color(202, 20, 20, 255)
Colors.mapOverviewLoadedLine = Color(71, 5, 5, 255)
Colors.mapOverviewUnloadedKill = Color(125, 125, 125, 240)

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
Mats.voipIcon = Material("icons/voip_icon.png", "smooth")
Mats.sendIcon = Material("icons/send_icon.png", "smooth")
Mats.inviteSentIcon = Material("icons/invite_sent_icon.png", "smooth")
Mats.inviteErrorIcon = Material("icons/invite_error_icon.png", "smooth")
Mats.dontEvenAsk = Material("icons/steamhappy_icon.png", "smooth")
Mats.curMapOverhad = Material("maps/" .. game.GetMap() .. ".png", "smooth")
Mats.mapSpawn = Material("icons/map/pmc_spawn_alt.png", "mips", "smooth")
Mats.mapExtract = Material("icons/map/extract_full.png", "mips", "smooth")
Mats.mapLocation = Material("icons/map/location_alt.png", "mips", "smooth")
Mats.mapKey = Material("icons/map/key.png", "mips", "smooth")
Mats.mapOverviewDeath = Material("icons/map/overview/death.png", "mips", "smooth")
Mats.mapOverviewExtract = Material("icons/map/overview/extract.png", "mips", "smooth")
Mats.mapOverviewKill = Material("icons/map/overview/kill.png", "mips", "smooth")
Mats.mapOverviewSpawn = Material("icons/map/overview/spawn.png", "mips", "smooth")