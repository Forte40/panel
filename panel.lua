-- http://pastebin.com/aibwRhj1

function new(x, y, w, h, textColor, backgroundColor, blink)
  -- get term size for relative positioning
  local width, height = term.getSize()
  if type(x) == "table" then
    -- named parameters passed in
    local o = x
    x = o.x or 1
    y = o.y or 1
    w = o.w or width
    h = o.h or height
    textColor = o.textColor or colors.white
    backgroundColor = o.backgroundColor or colors.black
    blink = o.blink ~= nil and o.blink or true
  end
  -- translate negative values to distance from end
  if x < 0 then
    x = width + x + 1
  end
  if y < 0 then
    y = height + y + 1
  end
  if w < 0 then
    w = width + w + 1
  end
  if h < 0 then
    h = height + h + 1
  end
  if textColor == nil then
    textColor = colors.white
  end
  if backgroundColor == nil then
    backgroundColor = colors.black
  end
  if blink == nil then
    blink == true
  end
  local win = window.create(term, x, y, w, h)
  win.setTextColor(textColor)
  win.setBackgroundColor(backgroundColor)
  win.setCursorBlink(blink)
  return win
end