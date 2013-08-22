Panel = {}
setmetatable(Panel, Panel)
Panel.__index = term

function Panel:new(x, y, w, h)
  local o = {}
  o.x = x
  o.y = y
  o.w = w
  o.h = h
  o.c = 0
  o.r = 0
  o.blink = true
  setmetatable(o, self)
  self.__index = self
  return o
end

function Panel:activate()
  term.restore()
  term.redirect(self)
  self.setCursorPos()
  self.setCursorBlink()
end

function Panel:getSize()
  return w, h
end

function Panel:getCursorPos()
  return c, r
end

function Panel:setCursorPos(c, r)
  self.c = c or self.c
  self.r = r or self.r
  term.setCursorPos(self.x + self.c, self.y + self.r)
end

function Panel:setCursorBlink(blink)
  self.blink = blink != nil and blink or self.blink
  term.setCursorBlink(self.blink)
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