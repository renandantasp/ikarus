Path = Object:extend()

function Path:new(enemy,fx,fy)
    self.x = enemy.x
    self.y = enemy.y
    self.fx = PathLib(fx)
    self.fx = PathLib(fy)
end

function Path:update(dt)
    self.x = 0 --alguma coisa envolvendo o self.fx
    self.y = 0 --alguma coisa envolvendo o self.fy
end