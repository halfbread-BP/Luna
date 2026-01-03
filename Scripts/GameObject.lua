GameObject = {}
GameObject.__index = GameObject

function GameObject:new(name)
  local gameObject = {
    name = name or "GameObject",
    components = {},
    transform = nil, -- holds transform component
    active = true,
  }
  setmetatable(gameObject, GameObject)

  -- Assign a GameObject the Transform component
  gameObject.transform = gameObject:addComponent(Transform)

  return gameObject
end

function GameObject:addComponent(componentClass)
  local component = componentClass:new(self)
  table.insert(self.components, component)
  return component
end

function GameObject:getComponent(componentClass)
  for _, component in ipairs(self.components) do
    if getmetatable(component) == componentClass then
      return component
    end
  end
  return nil
end
