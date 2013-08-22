function new(self, x, y, w, h)
  local o = {}
  o.x = x
  o.y = y
  o.w = w
  o.h = h
  o.c = 0
  o.r = 0
  o.blink = true
  setmetatable(o, self)
  return o
end

function activate(self)
  term.restore()
  term.redirect(self)
  self.setCursorPos()
  self.setCursorBlink()
end

function getSize(self)
  return self.w, self.h
end

function getCursorPos(self)
  return self.c, self.r
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

local env = getfenv()
for k,v in pairs(term) do
  if not env[k] then
    env[k] = v
  end
end