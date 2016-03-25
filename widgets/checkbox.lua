local checkbox = {}

function checkbox.new(info)
   local info = info or {}
   info.type = info.type or "checkbox"

   local self = Clue.newFrame(info)

   function self:onRelease() self.cstate = not self.cstate end
   function self:setcState(cstate) self.cstate = cstate end
   function self:getcState() return self.cstate end

   function self:draw()
      local x, y, w, h = self:getAbsRect()
      local smoothness = self:getSmoothness()

      if self.cstate then
         love.graphics.setColor(self:getClickBg())
      else
         love.graphics.setColor(self:getCurrentBg())
      end
      love.graphics.rectangle("fill", x, y, w, h, smoothness, smoothness)
   end

   self:setcState(info.cState)

   return self
end

return checkbox
