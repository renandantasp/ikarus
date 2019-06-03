Path = Object:extend()

function Path:new(enemy,fx)
    self.enemy = enemy
    self.x = self.enemy.x
    self.y = self.enemy.y
    --self.pos{self.x,self.y}
    self.fx = PathLib(self.enemy,fx)
end

function Path:update(dt)
    self.fx:update(dt)
    self.x = self.fx.x --alguma coisa envolvendo o self.fx
    self.y = self.fx.y --alguma coisa envolvendo o self.fy
end