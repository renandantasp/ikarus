Bullet = Object:extend()

function Bullet:new(pl,spread,pos)
    self.player = pl --qndo crio a bala, ja deixo o player nesse self. pra eu poder usar o player sem chamar em todas funções
    self.x = self.player.x + (self.player.width/2) -- a bala ira nascer no meio do player
    self.y = self.player.y
    self.speed = 750
    self.spread = spread or 0
    self.pos = pos
end

function Bullet:update(dt)
    if self.spread == 0 then
        self.y = self.y - (self.speed * dt)
    end
    if self.spread == 3 then
        if self.pos%3 == 0 then
            self.y = self.y - (self.speed * dt)
        end
        if self.pos%3 == 1 then
            self.x = self.x - (self.speed * 0.8 * dt)
            self.y = self.y - (self.speed * dt)
        end
        if self.pos%3 == 2 then
            self.x = self.x + (self.speed * 0.8 * dt)
            self.y = self.y - (self.speed * dt)
        end
    end
    if self.spread == 5 then
        if self.pos%5 == 0 then
            self.y = self.y - (self.speed * dt)
        end
        if self.pos%5 == 1 then
            self.x = self.x - (self.speed * 0.8 * dt)
            self.y = self.y - (self.speed * dt)
        end
        if self.pos%5 == 2 then
            self.x = self.x + (self.speed * 0.8 * dt)
            self.y = self.y - (self.speed * dt)
        end
        if self.pos%5 == 3 then
            self.x = self.x + (self.speed * 2 * dt)
            self.y = self.y - (self.speed * dt)
        end
        if self.pos%5 == 4 then
            self.x = self.x - (self.speed * 2 * dt)
            self.y = self.y - (self.speed * dt)
        end
    end
    
end

function Bullet:draw()
    love.graphics.circle("line",self.x,self.y-10,2*wScale) --balinha placeholder
end