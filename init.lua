Clue = {}
Clue.widgets = {}
Clue.widgetList = {
   "window",
   "dummy",
   "textButton",
   "slider",
   "progressBar",
   "checkbox",
}
Clue.widgetSetList = {
   "dropDown",
}
Clue.default = {
   x = 0,
   y = 0,
   width = 100,
   height = 100,
   smoothness = 5,
   buttons = {true, false, false},
   fg = {
      normal = {30, 30, 30, 255},
      click = {30, 30, 30, 255},
      hover = {30, 30, 30, 255},
   },
   bg = {
      normal = {225, 225, 225, 255},
      click = {225, 225, 225, 255},
      hover = {225, 225, 225, 255},
   },
}

-- Set up widgets
for _, widget in pairs(Clue.widgetList) do
   Clue.widgets[widget] = require (... ..".widgets."..widget)
   Clue.widgets[widget].list = {}
end
for _, widget in pairs(Clue.widgetSetList) do
   Clue.widgets[widget] = require (... ..".widgetSets."..widget)
   Clue.widgets[widget].list = {}
end

function Clue.newFrame(info)
   info.fg = info.fg or {} info.fg.normal = info.fg.normal or {} info.fg.hover = info.fg.hover or {} info.fg.click = info.fg.click or {}
   info.bg = info.bg or {} info.bg.normal = info.bg.normal or {} info.bg.hover = info.bg.hover or {} info.bg.click = info.bg.click or {}

   local self = {}

   -- Setting Variables
   function self:setLocalX(x) self.x = x end
   function self:setLocalY(y) self.y = y end
   function self:setlocalPos(x, y) self:setLocalX(x) self:setLocalY(y) end
   function self:setAbsX(x) self.x = self:getParent():getAbsX() + x end
   function self:setAbsY(y) self.y = self:getParent():getAbsY() + y end
   function self:setAbsPos(x, y) self:setAbsX(x) self:setAbsY(y) end

   function self:setWidth(width) self.width = width end
   function self:setHeight(height) self.height = height end
   function self:setSize(width, height) self:setWidth(width) self:setHeight(height) end

   function self:setAbsRect(x, y, width, height) self:setAbsPos(x, y) self:setSize(width, height) end
   function self:setLocalRect(x, y, width, height) self:setLocalPos(x, y) self:setSize(width, height) end

   function self:setActive(state) self.active = state end
   function self:setVisible(state) self.visible = state end
   function self:setSmoothness(smoothness) self.smoothness = smoothness end

   function self:setButton(button, state) self.buttons[button] = state end
   function self:setButtons(buttons) for i = 1, #buttons do self.buttons[i] = buttons[i] end end

   function self:setParent(parent) self.parent = parent end
   function self:setType(type) self.type = type end

   function self:setState(state) self.state = state end
   function self:setClicked(state) self.wasClicked = state end
   function self:setHovered(state) self.wasHovered = state end

   function self:setNormalFg(colors) local def = self:getNormalFg() for i = 1, 4 do self.fg.normal[i] = colors[i] or def[i] end end
   function self:setHoverFg(colors) local def = self:getHoverFg() for i = 1, 4 do self.fg.hover[i] = colors[i] or def[i] end end
   function self:setClickFg(colors) local def = self:getClickFg() for i = 1, 4 do self.fg.click[i] = colors[i] or def[i] end end
   function self:setFg(colors) self:setNormalFg(colors.normal or {}) self:setHoverFg(colors.hover or {}) self:setClickFg(colors.click or {}) end

   function self:setNormalBg(colors) local def = self:getNormalBg() for i = 1, 4 do self.bg.normal[i] = colors[i] or def[i] end end
   function self:setHoverBg(colors) local def = self:getHoverBg() for i = 1, 4 do self.bg.hover[i] = colors[i] or def[i] end end
   function self:setClickBg(colors) local def = self:getClickBg() for i = 1, 4 do self.bg.click[i] = colors[i] or def[i] end end
   function self:setBg(colors) self:setNormalBg(colors.normal or {}) self:setHoverBg(colors.hover or {}) self:setClickBg(colors.click or {}) end

   -- Getting Variables
   function self:getLocalX() return self.x end
   function self:getLocalY() return self.y end
   function self:getLocalPos() return self:getLocalX(), self:getLocalY() end
   function self:getAbsX() return self.x + self:getParent():getAbsX() end
   function self:getAbsY() return self.y + self:getParent():getAbsY() end
   function self:getAbsPos() return self:getAbsX(), self:getAbsY() end

   function self:getWidth() return self.width end
   function self:getHeight() return self.height end
   function self:getSize() return self:getWidth(), self:getHeight() end

   function self:getLocalRect() local x, y = self:getLocalPos() local w, h = self:getSize() return x, y, w, h end
   function self:getAbsRect() local x, y = self:getAbsPos() local w, h = self:getSize() return x, y, w, h end

   function self:getActive() return self.active end
   function self:getVisible() return self.visible end
   function self:getSmoothness() return self.smoothness end

   function self:getButton(button) return self.buttons[button] end
   function self:getButtons() return self.buttons[1], self.buttons[2], self.buttons[3] end

   function self:getParent() return self.parent end
   function self:getType() return self.type end

   function self:getState() return self.state end
   function self:getClicked() return self.wasClicked end
   function self:getHovered() return self.wasHovered end

   function self:getNormalFg() return self.fg.normal end
   function self:getHoverFg() return self.fg.hover end
   function self:getClickFg() return self.fg.click end
   function self:getFg() return {normal = self:getNormalFg(), hover = self:getHoverFg(), click = self:getClickFg()} end
   function self:getCurrentFg() return self.fg[self:getState()] end

   function self:getNormalBg() return self.bg.normal end
   function self:getHoverBg() return self.bg.hover end
   function self:getClickBg() return self.bg.click end
   function self:getBg() return {normal = self:getNormalBg(), hover = self:getHoverBg(), click = self:getClickBg()} end
   function self:getCurrentBg() return self.bg[self:getState()] end

   -- Utils
   function self:collWithPoint(x, y) local x1, y1, w1, h1 = self:getAbsRect() return Clue.collWithPoint(x1, y1, w1, h1, x, y) end
   function self:collWithRect(x, y, w, h) local x1, y1, w1, h1 = self:getAbsRect() return Clue.collWithRect(x1, y1, w1, h1, x, y, w, h) end
   function self:getCollOverlap(x, y, w, h) local x1, y1, w1, h1 = self:getAbsRect() return Clue.getCollOverlap(x, y, w, h, x1, y1, w1, h1) end

   -- Callbacks
   function self:update(mx, my, lxm, lmy, dt) end
   function self:draw() end
   function self:onClick(x, y, lxm, lmy, button) end
   function self:onRelease(x, y, lmx, lmy, button) end
   function self:onHover() end
   function self:onBlur() end
   function self:onScroll(x, y) end

   -- Setting up defaults
   self:setLocalX(info.x or Clue.getDefaultX())
   self:setLocalY(info.y or Clue.getDefaultY())
   self:setWidth(info.width or Clue.getDefaultWidth())
   self:setHeight(info.height or Clue.getDefaultHeight())
   self:setActive(not info.inactive)
   self:setVisible(not info.invisible)
   self:setSmoothness(info.smoothness or Clue.getDefaultSmoothness())
   self.buttons = {}
   self:setButtons(info.buttons or Clue.getDefaultButtons())
   self:setParent(info.parent)
   self:setType(info.type)
   self:setState("normal")
   self:setClicked()
   self:setHovered()

   local defFg = Clue.getDefaultFg()
   self.fg = {}
   self.fg.normal = {info.fg.normal[1] or defFg.normal[1], info.fg.normal[2] or defFg.normal[2], info.fg.normal[3] or defFg.normal[3], info.fg.normal[4] or defFg.normal[4]}
   self.fg.click = {info.fg.click[1] or defFg.click[1], info.fg.click[2] or defFg.click[2], info.fg.click[3] or defFg.click[3], info.fg.click[4] or defFg.click[4]}
   self.fg.hover = {info.fg.hover[1] or defFg.hover[1], info.fg.hover[2] or defFg.hover[2], info.fg.hover[3] or defFg.hover[3], info.fg.hover[4] or defFg.hover[4]}

   local defBg = Clue.getDefaultBg()
   self.bg = {}
   self.bg.normal = {info.bg.normal[1] or defBg.normal[1], info.bg.normal[2] or defBg.normal[2], info.bg.normal[3] or defBg.normal[3], info.bg.normal[4] or defBg.normal[4]}
   self.bg.click = {info.bg.click[1] or defBg.click[1], info.bg.click[2] or defBg.click[2], info.bg.click[3] or defBg.click[3], info.bg.click[4] or defBg.click[4]}
   self.bg.hover = {info.bg.hover[1] or defBg.hover[1], info.bg.hover[2] or defBg.hover[2], info.bg.hover[3] or defBg.hover[3], info.bg.hover[4] or defBg.hover[4]}

   table.insert(Clue.widgets[self:getType()].list, self)
   return self
end

-- Setting Default Variables
function Clue.setDefaultX(x) Clue.default.x = x end
function Clue.setDefaultY(y) Clue.default.y = y end
function Clue.setDefaultPos(x, y) Clue.setDefaultX(x) Clue.setDefaultY(y) end

function Clue.setDefaultWidth(width) Clue.default.width = width end
function Clue.setDefaultHeight(height) Clue.default.height = height end
function Clue.setDefaultSize(width, height) Clue.setDefaultSize(width, height) end

function Clue.setDefaultRect(x, y, width, height) Clue.setDefaultPos(x, y) Clue.setDefaultSize(width, height) end
function Clue.setDefaultSmoothness(smoothness) Clue.default.smoothness = smoothness end
function Clue.setDefaultButtons(buttons) Clue.default.buttons = buttons end

function Clue.setDefaultNormalFg(colors) local def = Clue.getDefaultNormalFg() for i = 1, 4 do Clue.default.fg.normal[i] = colors[i] or def[i] end end
function Clue.setDefaultHoverFg(colors) local def = Clue.getDefaultHoverFg() for i = 1, 4 do Clue.default.fg.hover[i] = colors[i] or def[i] end end
function Clue.setDefaultClickFg(colors) local def = Clue.getDefaultClickFg() for i = 1, 4 do Clue.default.fg.click[i] = colors[i] or def[i] end end
function Clue.setDefaultFg(colors) Clue.setDefaultNormalFg(colors.normal or {}) Clue.setDefaultHoverFg(colors.hover or {}) Clue.setDefaultClickFg(colors.click or {}) end

function Clue.setDefaultNormalBg(colors) local def = Clue.getDefaultNormalBg() for i = 1, 4 do Clue.default.bg.normal[i] = colors[i] or def[i] end end
function Clue.setDefaultHoverBg(colors) local def = Clue.getDefaultHoverBg() for i = 1, 4 do Clue.default.bg.hover[i] = colors[i] or def[i] end end
function Clue.setDefaultClickBg(colors) local def = Clue.getDefaultClickBg() for i = 1, 4 do Clue.default.bg.click[i] = colors[i] or def[i] end end
function Clue.setDefaultBg(colors) Clue.setDefaultNormalBg(colors.normal or {}) Clue.setDefaultHoverBg(colors.hover or {}) Clue.setDefaultClickBg(colors.click or {}) end

-- Getting Default Variables
function Clue.getDefaultX() return Clue.default.x end
function Clue.getDefaultY() return Clue.default.y end
function Clue.getDefaultPos() return Clue.getDefaultX(), Clue.getDefaultY() end

function Clue.getDefaultWidth() return Clue.default.width end
function Clue.getDefaultHeight() return Clue.default.height end
function Clue.getDefaultSize() return Clue.getDefaultWidth(), Clue.getDefaultHeight() end

function Clue.getDefaultRect() return Clue.getDefaultPos(), Clue.getDefaultSize() end
function Clue.getDefaultSmoothness() return Clue.default.smoothness end
function Clue.getDefaultButtons() return Clue.default.buttons end

function Clue.getDefaultNormalFg() return Clue.default.fg.normal end
function Clue.getDefaultHoverFg() return Clue.default.fg.hover end
function Clue.getDefaultClickFg() return Clue.default.fg.click end
function Clue.getDefaultFg() return {normal = Clue.getDefaultNormalFg(), hover = Clue.getDefaultHoverFg(), click = Clue.getDefaultClickFg()} end

function Clue.getDefaultNormalBg() return Clue.default.bg.normal end
function Clue.getDefaultHoverBg() return Clue.default.bg.hover end
function Clue.getDefaultClickBg() return Clue.default.bg.click end
function Clue.getDefaultBg() return {normal = Clue.getDefaultNormalBg(), hover = Clue.getDefaultHoverBg(), click = Clue.getDefaultClickBg()} end

-- Utils
function Clue.collWithPoint(x1, y1, w1, h1, x2, y2) return x1 < x2 and x1 + w1 > x2 and y1 < y2 and y1 + h1 > y2 end
function Clue.collWithRect(x1, y1, w1, h1, x2, y2, w2, h2) return x1 < x2 + w2 and x1 + w1 > x2 and y1 < y2 + h2 and y1 + h1 > y2  end
function Clue.getCollOverlap(x1, y1, w1, h1, x2, y2, w2, h2)
   local x3 = math.max(x1, x2)
   local y3 = math.max(y1, y2)
   local x4 = math.min(x1 + w1, x2 + w2)
   local y4 = math.min(y1 + h1, y2 + h2)
   return x3, y3, x4-x3, y4-y3
end

-- Setting up Frame
Frame = Clue.widgets["window"].new({
   width = love.graphics.getWidth(),
   height = love.graphics.getHeight(),
   smoothness = 0,
   bg = {
      normal = {225, 225, 225},
      hover = {225, 225, 225},
      click = {225, 225, 225},
   }
})
function Frame:getAbsX() return self:getLocalX() end
function Frame:getAbsY() return self:getLocalY() end
function Frame:getParent() return "Clue" end
function Frame:draw()
   if self:getVisible() then
      local x, y, w, h = self:getAbsRect()
      local smoothness = self:getSmoothness()
      local bg = self:getCurrentBg()
      local fg = self:getCurrentFg()

      love.graphics.setScissor(x, y, w, h)

      love.graphics.setColor(self:getCurrentBg())
      love.graphics.rectangle("fill", x, y, w, h, smoothness, smoothness)

      for _, obj in ipairs(self.list) do
         if obj:getVisible() then
            local sx, sy, sw, sh = love.graphics.getScissor()
            local px, py, pw, ph = Clue.getCollOverlap(sx, sy, sw, sh, x, y, w, h)
            love.graphics.setScissor(px, py, math.max(0, pw), math.max(0, ph))

            obj:draw()
         end
      end
      love.graphics.setScissor()
   end
end

function Frame:update(mx, my, dt)
   if self:getActive() then
      if self:collWithPoint(mx, my) then
         if not self:getHovered() then
            self:onHover()
            self:setHovered(true)
            self:setState("hover")
         end
      elseif self:getHovered() then
         self:onBlur()
         self:setHovered()
         self:setState("normal")
      end
   end

   for _, obj in ipairs(self.list) do
      if obj:getActive() then
         obj:update(mx, my, mx - obj:getAbsX(), my - obj:getAbsY(), dt)
         if self:collWithPoint(mx, my) and obj:collWithPoint(mx, my) then
            if not obj:getHovered() then
               obj:onHover()
               obj:setHovered(true)
               obj:setState("hover")
            end
         elseif obj:getHovered() then
            obj:onBlur()
            obj:setHovered()
            if obj:getClicked() then
               obj:setState("click")
            else
               obj:setState("normal")
            end
         end
      end
   end
end

function Frame:onClick(mx, my, button)
   if self:getActive() and self:getButton(button) and self:collWithPoint(mx, my) then
      for _, obj in ipairs(self.list) do
         if obj:getActive() and obj:getButton(button) and obj:collWithPoint(mx, my) then
            obj:onClick(mx, my, mx - obj:getAbsX(), my - obj:getAbsY(), button)
            obj:setClicked(true)
            obj:setState("click")
         end
      end
   end
end

function Frame:onRelease(mx, my, button)
   for _, obj in ipairs(self.list) do
      if obj:getActive() and obj:getClicked() then
         obj:onRelease(mx, my, mx - obj:getAbsX(), my - obj:getAbsY(), button)
         obj:setClicked()
         if obj:getHovered() then
            obj:setState("hover")
         else
            obj:setState("normal")
         end
      end
   end
end

function Frame:onHover() end
function Frame:onBlur() end

function Frame:onScroll(x, y)
   for _, obj in ipairs(self.list) do
      if obj:getActive() then
         obj:onScroll(x, y)
      end
   end
end

return Frame
