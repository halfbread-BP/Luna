require("Scripts/Component")
require("Scripts/Transform")
require("Scripts/GameObject")
ScriptManager = require("Scripts/ScriptManager")

local scriptManager

function love.load()
  print("Luna Framework Test")

  scriptManager = ScriptManager:new()

  local object = GameObject:new("Object")
  object.transform.position.x = 100
  object.transform.position.y = 200
  object.transform:translate(100, 200) -- same thing
end

function love.update(dt)
  scriptManager:update(dt)

  if love.keyboard.isDown("space") then
    if scriptManager.gameObjects[1] then
      scriptManager.gameObjects[1].active = false
    else
      print("what did you do??")
  else
    if scriptManager.gameObjects[1] then
      scriptManager.gameObject[1].active = true
    else
      print("what did you do??")
    end    
  end
end

function love.draw()
  love.graphics.print("Luna Framework", 10, 10)
  love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 30)
  love.graphics.print("Hold down [SPACE] to disable the GameObject", 10, 50)
  love.graphics.print("Press [esc] to Exit", 10, 70)
end
  
function love.keypressed(key)
  if key == "escape" then
    love.event.quit()
  end
end
