-- os.loadAPI("apis/panel") returns a global named "panel"

local active_panel

function new(self, x, y, w, h)
  -- set inheritance of global "panel" to term
  -- only do this once
  if getmetatable(self) == nil then
    setmetatable(self, {__index = term.native})
  end
  -- create new object
  local o = {}
  o.x = x
  o.y = y
  o.w = w
  o.h = h
  o.c = 0
  o.r = 0
  o.blink = true
  -- set inheritance of new object to "panel"
  setmetatable(o, self)
  self.__index = self
  return o
end

function activate(self)
  active_panel = self
  term.restore()
  term.redirect(self)
end

function getSize(self)
  return active_panel.w, active_panel.h
end
 --[[
function getCursorPos(self)
  return ac
end

function setCursorPos(self, c, r)
  self.c = c or self.c
  self.r = r or self.r
  term.setCursorPos(self.x + self.c, self.y + self.r)
end

function setCursorBlink(self, blink)
  self.blink = blink ~= nil and blink or self.blink
  term.setCursorBlink(self.blink)
end


Panel:write
Panel:clear
Panel:clearLine
Panel:scroll

Panel:redirect
Panel:restore

Panel:isColor
Panel:isColour
Panel:setTextColor
Panel:setTextColour
Panel:setBackgroundColor
Panel:setBackgroundColour
]]