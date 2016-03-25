local slider = {}

function slider.new(info)
   local info = info or {}
   info.type = "slider"

   local self = Clue.newFrame(info)

   function self:setSliderX(x) self.sliderX = x end
   function self:setSliderY(y) self.sliderY = y end
   function self:setSliderPos(x, y) self:setSliderX(x) self:setSliderY(y) end
   function self:setSliderCenterX(x) self:setSliderX(x - self:getSliderWidth() / 2) end
   function self:setSliderCenterY(y) self:setSliderY(y - self:getSliderHeight() / 2) end
   function self:setSliderCenterPos(x, y) self:setSliderCenterX(x) self:setSliderCenterY(y) end

   function self:setSliderWidth(width) self.sliderWidth = width end
   function self:setSliderHeight(height) self.sliderHeight = height end
   function self:setSliderSize(width, height) self:setSliderWidth(width) self:setSliderHeight(height) end

   function self:setDragging(state) self.dragging = state end


   function self:getSliderX() return self.sliderX end
   function self:getSliderY() return self.sliderY end
   function self:getSliderPos() return self:getSliderX(), self:getSliderY() end
   function self:getSliderCenterX() return self:getSliderX() + self:getSliderWidth() / 2 end
   function self:getSliderCenterY() return self:getSliderY() + self:getSliderHeight() / 2 end
   function self:getSliderCenterPos() return self:getSliderCenterX(), self:getSliderCenterY() end

   function self:getSliderWidth() return self.sliderWidth end
   function self:getSliderHeight() return self.sliderHeight end
   function self:getSliderSize() return self:getSliderWidth(), self:getSliderHeight() end

   function self:getSliderRect() local x, y = self:getSliderPos() local w, h = self:getSliderSize() return x, y, w, h end

   function self:getPercentageX() return math.floor(self:getSliderX() / (self:getWidth() - self:getSliderWidth()) * 100) / 100 end
   function self:getPercentageY() return math.floor(self:getSliderY() / (self:getHeight() - self:getSliderHeight()) * 100) / 100 end
   function self:getPercentage() return (self:getPercentageX() + self:getPercentageY()) / 2 end
   function self:getDragging() return self.dragging end

   function self:onClick(mx, my, lmx, lmy, button) self:setSliderCenterPos(lmx, lmy) self:setDragging(true) end
   function self:onRelease(mx, my, lmx, lmy) self:setDragging() end
   function self:update(mx, my, lmx, lmy, dt)
      if self:getDragging() then
         self:setSliderCenterPos(lmx, lmy)
         self:setSliderX(math.min(math.max(self:getSliderX(), 0), self:getWidth() - self:getSliderWidth()))
         self:setSliderY(math.min(math.max(self:getSliderY(), 0), self:getHeight() - self:getSliderHeight()))
      end
   end

   function self:draw()
      local x, y, w, h = self:getAbsRect()
      local sx, sy, sw, sh = self:getSliderRect()
      sx, sy = sx + x, sy + y

      love.graphics.setColor(self:getCurrentBg())
      love.graphics.rectangle("fill", x, y, w, h, self:getSmoothness(), self:getSmoothness())

      love.graphics.setColor(self:getCurrentFg())
      love.graphics.rectangle("fill", sx, sy, sw, sh, self:getSmoothness(), self:getSmoothness())
   end

   self:setSliderPos(info.sx or 0, info.sy or 0)
   self:setSliderSize(info.sw or self:getWidth(), info.sh or self:getHeight())

   return self
end

return slider
