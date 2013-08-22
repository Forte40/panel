-- os.loadAPI("apis/panel") returns a global named "panel"

local active

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
  active = self
  term.restore()
  term.redirect(active)
end

function getSize(self)
  return active.w, active.h
end

function getCursorPos(self)
  return active.c, active.r
end

function setCursorPos(c, r)
  active.c = c or active.c
  active.r = r or active.r
  term.native.setCursorPos(active.x + active.c, active.y + active.r)
end

function setCursorBlink(blink)
  active.blink = blink ~= nil and blink or active.blink
  term.native.setCursorBlink(active.blink)
end

--[[
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