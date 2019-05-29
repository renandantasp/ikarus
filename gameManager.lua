GameManager = Object:extend()

function GameManager:New(p1)
    self.player = p1
end

function love.load()
end


function love.update(dt)
    pl:update(dt)
end

function love.draw()
    pl:draw()
    
end