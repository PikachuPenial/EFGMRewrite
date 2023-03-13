
-- UI is a global table containing all other UI elements
-- May make functions to modify all elements in the table idk though
-- maybe should rename it from menu manager to cl_ui.lua or something idk
UI = {}

function UI.InitializeFrame(title, x, y, width, height, isVisible, isDraggable, hasCloseButton, shouldPopup, isSizeable)

    -- bigass function that MAY make initializing DFrames easier
    -- just does basic shit
    -- also uses . instead of : because it doesn't use or need "self" (so more of a field than a function)

    local dframe = vgui.Create("DFrame")
    dframe:SetPos( x, y ) 
    dframe:SetSize( width, height ) 
    dframe:SetTitle( title ) 
    dframe:SetVisible( isVisible ) 
    dframe:SetDraggable( isDraggable ) 
    dframe:ShowCloseButton( hasCloseButton ) 
    dframe:SetSizable( isSizeable )
    if shouldPopup == true then dframe:MakePopup() end

    return dframe

end