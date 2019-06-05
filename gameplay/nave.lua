Nave = Object:extend()

function Nave:new(size)
    --Posição e Tamanho--
    self.x = love.graphics.getWidth()/2
    self.y = (love.graphics.getHeight()/3)*2

    self.width = size*wScale
    self.height = size*wScale
    ---------------------

    self.health = 10
    self.speed = 80*wScale
    self.shootDamage = 1

end

function Nave:update(dt)

end

function Nave:draw()

end