DefaultE = Nave:extend()

function DefaultE:new()
    DefaultE.super.new(self,50)
    self.x = math.random(700*wScale,love.graphics.getWidth())
    self.y = 100
    self.shootRate = 6
    self.shootTimer = 0
    self.bullet  = {}
    self.path = Path(self,fx,fy)
    self.speed = math.random(180,320)
    
end

function DefaultE:update(dt)
    self.y = self.y + (self.speed * dt)

end

function DefaultE:draw()
    love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
end