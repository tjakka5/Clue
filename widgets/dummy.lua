local dummy = {}

function dummy.new(info)
   local info = info or {}
   info.type = "dummy"

   local self = Clue.newFrame(info)
   return self
end

return dummy
