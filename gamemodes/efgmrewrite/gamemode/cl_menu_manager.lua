

-- todo

-- create ui element class
-- other stuff idk

UIElement = {
    x = 0,
    y = 0,
    width = 0,
    height = 0,
    title = "",
    isVisible = true,
    isDraggable = true,
    showCloseButton = true
}

function UIElement:CreateNewElement(object)
  object = object or {}
  setmetatable(object, self)
  self.__index = self
  return object
end