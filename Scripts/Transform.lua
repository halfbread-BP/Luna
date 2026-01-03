Transform = setmetatable({}, {__index = Component})
Transform.__index = Transform

function Transform:new(gameObject)
  local obj = Component.new(self, gameObject)
  obj.position = {x = 0, y = 0}
  obj.scale = {x = 0, y = 0}
  return obj
end

function Transform:translate(x, y)
  self.position.x = self.position.x + x
  self.position.y = self.position.y + y
end
