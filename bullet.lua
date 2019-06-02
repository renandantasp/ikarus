Bullet = Object:extend()

function Bullet:new(pl)
    self.player = pl --qndo crio a bala, ja deixo o player nesse self. pra eu poder usar o player sem chamar em todas funções
    self.x = self.player.x + (self.player.width/2) -- a bala ira nascer no meio do player
    self.y = self.player.y
    self.speed = 750
end

function Bullet:update(dt)
    self.y = self.y - (self.speed * dt)
    
    
end

function Bullet:draw()
    love.graphics.circle("line",self.x,self.y-10,2*wScale) --balinha placeholder
end