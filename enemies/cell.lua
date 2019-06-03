Cell = Nave:extend()

function Cell:new(ger,x,y)
    self.geracao = ger or 3
    DefaultE.super.new(self,(10*self.geracao))
    self.x = x or (love.math.random(187*wScale,love.graphics.getWidth()-self.width))
    self.y = y or 0
    self.shootRate = 6
    self.shootTimer = 0
    self.bullet  = {}
    self.path = Path(self,fx,fy)
    self.speed = love.math.random(50,100)
    self.onHit = false
    self.health = (2*self.geracao) - 1
    
    

    self.image = love.graphics.newImage("artwork/gfx/naves/e4.png")
    self.imgOnHit = love.graphics.newImage("artwork/gfx/naves/onHit.png")
    
    self.g = anim.newGrid(25,32,self.image:getWidth(), self.image:getHeight())
    self.idle = anim.newAnimation(self.g('1-2',1), 0.01)
end

function Cell:draw()
    --love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
    self.idle:draw(self.image, self.x,self.y,0,wScale*(self.geracao/2.5),wScale*(self.geracao/2.5),nil,3*wScale) --wScale = 25*wScale
    if self.onHit == true then
        love.graphics.draw(self.imgOnHit, self.x,self.y,0,wScale*(self.geracao/2.5),wScale*(self.geracao/2.5),nil,3*wScale)
    end
end

function Cell:destroy()

end

function Cell:update(dt)
    self.y = self.y + (self.speed * dt)
    self.idle:update(dt)
    self.onHit = false

end



