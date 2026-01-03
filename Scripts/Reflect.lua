Reflect = {}

--[[
  awake() - Called upon runtime
  start() - called once before the first update
  update(dt) - runs every frame
  fixedUpdate(fixedDt) - called at fixed intervals (Defaults to 50Hz in 'Config/Config.lua')
  lateUpdate(dt) - called once every frame after an update has been finished
  draw() - use for drawing graphics
]]

Reflect.lifeCycleMethods = {
    {name = "awake", order = 1, phase = "initialization"},
    {name = "start", order = 2, phase = "initialization"},
    {name = "fixedUpdate", order = 3, phase = "update"},
    {name = "update", order = 4, phase = "update"},
    {name = "lateUpdate", order = 5, phase = "update"},
    {name = "draw", order = 6, phase = "render"}
}

function Reflect.hasMethod(script, methodName)
  return type(script[methodName]) == "function"
end

function Reflect.getImplementedMethods(script)
  local methods = {}
  for _, method in ipairs(Reflect.lifeCycleMethods) do
    if Reflect.hasMethod(script, method.name) then
      table.insert(methods, method.name)
    end
  end
  return methods
end

return Reflect
