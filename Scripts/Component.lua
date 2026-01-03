Component = {}
Component.__index = Component

function Component:new(gameObject)
  local obj = {
    gameObject = gameObject,
    enabled = true
  }
  setmetatable(obj, self)
  return obj
end
