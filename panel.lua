-- http://pastebin.com/aibwRhj1

local active

function redirect(self)
  if active then
    term.restore()
  end
  active = self
  term.redirect(active)
  active.setCursorPos()
  active.setCursorBlink()
end

function restore()
  if active then
    term.restore()
  end
end

local function dump()
  for row = 1, active.h do
    active.setCursorPos(1, row)
    term.native.write(active.lines[row])
  end
  active.setCursorPos(1, 1)
end

local P = {}

P.redirect = redirect

function P.getSize()
  return active.w, active.h
end

function P.getCursorPos()
  return active.c, active.r
end

function P.setCursorPos(c, r)
  active.c = c or active.c
  active.r = r or active.r
  term.native.setCursorPos(active.x + active.c - 1, active.y + active.r - 1)
end

function P.setCursorBlink(blink)
  active.blink = blink ~= nil and blink or active.blink
  term.native.setCursorBlink(active.blink)
end

function P.clear()
  for i = 1, active.h do
    active.lines[i] = string.rep(" ", active.w)
  end
  dump()
end

function P.clearLine()
  active.lines[active.r] = string.rep(" ", active.w)
  term.native.setCursorPos(active.x, active.y + active.r - 1)
  term.native.write(string.rep(" ", active.w))
  active.setCursorPos(1)
end

function P.scroll(count)
  count = count or 1
  for i = 1, count do
    table.remove(active.lines, 1)
    table.insert(active.lines, string.rep(" ", active.w))
  end
  dump()
  active.setCursorPos(1, active.h)
end

function P.write(msg)
  local max = active.w - active.c + 1
  msg = tostring(msg):sub(1, max)
  active.lines[active.r] = active.lines[active.r]:sub(1,active.c - 1)
                         .. msg
                         .. active.lines[active.r]:sub(active.c + #msg, active.w)
  term.native.write(msg)
  c, r = term.native.getCursorPos()
  active.c = c - active.x + 1
  active.r = r - active.y + 1
end

setmetatable(P, {__index = term.native})
P.__index = P

function new(x, y, w, h)
  -- get term size for relative positioning
  local width, height = term.getSize()
  if active then
    term.restore()
    width, height = term.getSize()
    term.redirect(active)
  end
  local o
  if type(x) == "table" then
    -- named parameters passed in
    o = x
    o.x = o.x or 1
    o.y = o.y or 1
    o.w = o.w or width
    o.h = o.h or height
    o.c = o.c or 1
    o.r = o.r or 1
    o.blink = o.blink ~= nil and o.blink or true
    o.lines = o.lines or {}
  else
    -- positional parameters passed in
    o = {
      x = x, y = y, w = w, h = h,
      c = 1, r = 1, blink = true,
      lines = {}
    }
  end
  -- translate negative values to distance from end
  if o.x < 0 then
    o.x = width - o.x + 1
  end
  if o.y < 0 then
    o.y = height - o.y + 1
  end
  for i = 1, o.h do
    o.lines[i] = string.rep(" ", o.w)
  end
  setmetatable(o, P)
  return o
end
