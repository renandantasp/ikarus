DefaultE = Nave:extend()

function DefaultE:new()
    DefaultE.super.new(self,50)

    self.shootRate = 6
    self.shootTimer = 0
    self.bullet  = {}
    self.path = Path(self,fx,fy)
    
end

function DefaultE:update(dt)

end

function DefaultE:draw()

end