local progressBar = {}

function progressBar.new(info)
   local info = info or {}
   info.type = "progressBar"

   local self = Clue.newFrame(info)

   function self:setPercentage(percent) self.percent = math.min(1, math.max(0, percent)) end
   function self:setHorizontal(state) self.horizontal = state end
   function self:setVertical(state) self.vertical = state end

   function self:getPercentage() return self.percent end
   function self:getHorizontal() return self.horizontal end
   function self:getVertical() return self.vertical end

   function self:draw()
      local x, y, w, h = self:getAbsRect()
      local smoothness = self:getSmoothness()

      love.graphics.setColor(self:getCurrentBg())
      love.graphics.rectangle("fill", x, y, w, h, smoothness, smoothness)

      love.graphics.setColor(self:getCurrentFg())
      if self:getHorizontal() then pw = w * self:getPercentage() else pw = w end
      if self:getVertical() then ph = h * self:getPercentage() else ph = h end

      love.graphics.rectangle("fill", x, y, pw, ph, math.min(w, smoothness), math.min(h, smoothness))
   end

   self:setPercentage(info.percent or 0)
   self:getHorizontal(info.horizontal)
   self:getVertical(info.vertical)

   return self
end

return progressBar
