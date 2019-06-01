GameManager = Object:extend()

function GameManager:new()
    self.enemies = {DefaultE()}
    self.player = Player()
end

function GameManager:update(dt)
    self.player:update(dt)
    self.enemies[1]:update(dt)
end

function GameManager:draw()
    self.player:draw()
    self.enemies[1]:draw()
    love.graphics.setColor(0.3,0.3,0.3)
    love.graphics.rectangle("fill",0,0,700*wScale,1200*wScale)
    love.graphics.setColor(1,1,1)
    love.graphics.print("NAVINHA",120*wScale,100*wScale,0,4,4)
end