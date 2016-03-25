local textButton = {}

function textButton.new(info)
   local info = info or {}
   info.type = "textButton"

   local self = Clue.newFrame(info)

   function self:setText(text) self.text = text end
   function self:setFont(font) self.font = font end
   function self:setAlign(align) self.align = align end

   function self:getText() return self.text end
   function self:getFont() return self.font end
   function self:getAlign() return self.align end

   function self:draw()
      local x, y, w, h = self:getAbsRect()
      local smoothness = self:getSmoothness()
      local bg, fg = self:getCurrentBg(), self:getCurrentFg()
      local text, font, align = self:getText(), self:getFont(), self:getAlign()

      love.graphics.setColor(bg)
      love.graphics.rectangle("fill", x, y, w, h, smoothness, smoothness)

      love.graphics.setColor(100, 115, 130)
      love.graphics.rectangle("fill", x, y + (h - 10), w, 10, smoothness, smoothness)

      love.graphics.setColor(fg)
      love.graphics.setFont(self:getFont())
      love.graphics.printf(text, x, y + 15, w, align)
   end

   self:setText(info.text or "")
   self:setFont(info.font or love.graphics.getFont())
   self:setAlign(info.align or "center")

   return self
end

return textButton
