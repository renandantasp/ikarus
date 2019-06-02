DefaultE = Nave:extend()

function DefaultE:new(cor)
    DefaultE.super.new(self,25)
    self.x = math.random(187*wScale,love.graphics.getWidth()-self.width)
    self.y = 0
    self.shootRate = 6
    self.shootTimer = 0
    self.bullet  = {}
    self.path = Path(self,fx,fy)
    self.speed = math.random(100,200)
    
    if cor == "red"    then self.image = love.graphics.newImage("artwork/gfx/naves/e1.png") end
    if cor == "green"  then self.image = love.graphics.newImage("artwork/gfx/naves/e2.png") end
    if cor == "yellow" then self.image = love.graphics.newImage("artwork/gfx/naves/e3.png") end
    if cor == "purple" then self.image = love.graphics.newImage("artwork/gfx/naves/e4.png") end
    
    self.g = anim.newGrid(25,32,self.image:getWidth(), self.image:getHeight())
    self.idle = anim.newAnimation(self.g('1-2',1), 0.01)
end

function DefaultE:update(dt)
    self.y = self.y + (self.speed * dt)
    self.idle:update(dt)

end

function DefaultE:draw()
    --love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    self.idle:draw(self.image, self.x,self.y,0,wScale,wScale,nil,3*wScale)
end


