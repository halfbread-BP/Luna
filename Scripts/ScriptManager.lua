require("Reflect")

ScriptManager = {}
ScriptManager.__index = ScriptManager

function ScriptManager:new()
  local obj = {
    scripts = {},
    fixedTimeStep = 1/50, -- change here if u want
    fixedAccumulator = 0
  }
  setmetatable(obj, ScriptManager)
  return obj
end

function ScriptManager:registerScript(script)
    script._awoken = false
    script._started = false
    table.insert(self.scripts, script)
    return script
end

function ScriptManager:removeScript(script)
    for i, s in ipairs(self.scripts) do
        if s == script then
            table.remove(self.scripts, i)
            return true
        end
    end
    return false
end

function ScriptManager:update(dt)
    for _, script in ipairs(self.scripts) do
        if not script._awoken and Reflect.hasMethod(script, "awake") then
            script:awake()
            script._awoken = true
        end
    end

    for _, script in ipairs(self.scripts) do
        if not script._started and Reflect.hasMethod(script, "start") then
            script:start()
            script._started = true
        end
    end

    self.fixedAccumulator = self.fixedAccumulator + dt
    while self.fixedAccumulator >= self.fixedTimeStep do
        for _, script in ipairs(self.scripts) do
            if Reflect.hasMethod(script, "fixedUpdate") then
                script:fixedUpdate(self.fixedTimeStep)
            end
        end
        self.fixedAccumulator = self.fixedAccumulator - self.fixedTimeStep
    end

    for _, script in ipairs(self.scripts) do
        if Reflect.hasMethod(script, "update") then
            script:update(dt)
        end
    end

    for _, script in ipairs(self.scripts) do
        if Reflect.hasMethod(script, "lateUpdate") then
            script:lateUpdate(dt)
        end
    end
end

function ScriptManager:draw()
    for _, script in ipairs(self.scripts) do
        if Reflect.hasMethod(script, "draw") then
            script:draw()
        end
    end
end

return ScriptManager
