local dropDown = {}

function dropDown.new(info)
   local info = info or {}
   local obj = Clue.widgets.window.new(info)
   obj:setHeight(info.headerHeight or 25)

   obj.target = info.height or 400

   local header = obj:new("textButton", {x = 0, y = 0, width = obj:getWidth(), height = info.headerHeight or 25, bg = info.fg})

   local cx = 0
   if info.checkboxAlign == "left" then cx = 0 else cx = obj:getWidth() - header:getHeight() end
   local checkbox = obj:new("checkbox", {x = cx, y = 0, width = header:getHeight(), height = header:getHeight(),
      bg = {
         normal = {100, 115, 130},
         hover = {120, 140, 150},
         click = {140, 165, 170},
      },
      smoothness = 0,
   })

   function checkbox:onRelease()
      if not obj.moving then
         self.cstate = not self.cstate
         obj.direction = not obj.direction
         obj.moving = true
      end
   end

   function checkbox:update(mx, my, lmx, lmy, dt)
      if obj.moving then
         if obj.direction then
            local pxLeft = obj.target - obj:getHeight()
            obj:setHeight(math.min(obj.target, math.ceil(obj:getHeight() + (pxLeft * 8) * dt)))
         else
            local pxLeft = header:getHeight() - obj:getHeight()
            obj:setHeight(math.max(header:getHeight(), math.floor(obj:getHeight() + (pxLeft * 8) * dt)))
         end

         if obj:getHeight() == header:getHeight() or obj:getHeight() == obj.target then
            obj.moving = false
         end
      end
   end

   local baseFrame = obj:new("window", {
      x = info.buttonOffset or 5,
      y = header:getHeight(),
      width = obj:getWidth() - (info.buttonOffset or 5) * 2,
      height = obj.target - header:getHeight(),
      bg = {
         normal = {0, 0, 0, 0},
         hover = {0, 0, 0, 0},
         click = {0, 0, 0, 0},
      },
   })
   local moveFrame = baseFrame:new("window", {
      x = 0,
      y = 0,
      width = baseFrame:getWidth(),
      height = baseFrame:getHeight(),
      bg = {
         normal = {0, 0, 0, 0},
         hover = {0, 0, 0, 0},
         click = {0, 0, 0, 0},
      },
   })

   local sx = 0
   if info.sliderAlign == "left" then sx = 0 else sx = obj:getWidth() - (info.sliderWidth or 25) end
   local slider = obj:new("slider", {
      x = sx,
      y = header:getHeight(),
      width = info.sliderWidth or 25,
      height = obj.target - header:getHeight(),

      bg = {
         normal = {225, 225, 225},
         hover = {225, 225, 225},
         click = {225, 225, 225},
      },
      fg = {
         normal = {60, 60, 60},
         click = {60, 60, 60},
         hover = {60, 60, 60},
      },

      sw = info.sliderWidth,
      sh = 25,

      smoothness = 0,
   })
   function slider:update(mx, my, lmx, lmy, dt)
      moveFrame:setLocalY((self:getPercentageY() * 100)*-1 - (obj.target - obj:getHeight()) + (info.buttonOffset or 5))

      if self:getDragging() then
         self:setSliderCenterPos(lmx, lmy)
         self:setSliderX(math.min(math.max(self:getSliderX(), 0), self:getWidth() - self:getSliderWidth()))
         self:setSliderY(math.min(math.max(self:getSliderY(), 0), self:getHeight() - self:getSliderHeight()))
      end
   end

   return obj, moveFrame
end

return dropDown
