local window = {}

function window.new(info)
   local info = info or {}
   info.type = "window"

   local self = Clue.newFrame(info)
   self.list = {}

   function self:new(widget, info)
      local info = info or {}
      local obj, obj2 = Clue.widgets[widget].new(info)
      obj:setType(widget)
      self:add(obj)
      return obj, obj2
   end

   function self:add(obj)
      obj:setParent(self)
      table.insert(self.list, obj)
   end

   function self:update(mx, my, lmx, lmy, dt)
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
   function self:draw()
      local x, y, w, h = self:getAbsRect()
      local smoothness = self:getSmoothness()
      local bg = self:getCurrentBg()
      local fg = self:getCurrentFg()

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
      love.graphics.setScissor(self:getParent():getAbsRect())
   end
   function self:onClick(mx, my, lmx, lmy, button)
      for _, obj in ipairs(self.list) do
         if obj:getActive() and obj:collWithPoint(mx, my) then
            obj:onClick(mx, my, mx - obj:getAbsX(), my - obj:getAbsY(), button)
            obj:setClicked(true)
            obj:setState("click")
         end
      end
   end
   function self:onRelease(mx, my, lmx, lmy, button)
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
   function self:onHover() end
   function self:onBlur() end

   function self:onScroll(x, y)
      for _, obj in ipairs(self.list) do
         if obj:getActive() then
            obj:onScroll(x, y)
         end
      end
   end

   return self
end

return window
