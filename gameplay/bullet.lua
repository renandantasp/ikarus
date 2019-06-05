Bullet = Object:extend()

function Bullet:new(pl,spread,pos)
    self.player = pl --qndo crio a bala, ja deixo o player nesse self. pra eu poder usar o player sem chamar em todas funções
    self.x = self.player.x + (self.player.width/2) -- a bala ira nascer no meio do player
    self.y = self.player.y
    self.speed = 500*wScale
    self.spread = spread or 0
    self.pos = pos
    self.rot = 0
    self.blt = love.graphics.newImage("artwork/gfx/naves/blt.png")
end

function Bullet:update(dt)
    if self.spread == 0 then
        self.y = self.y - (self.speed * dt)
        self.rot = 0
    end

    if self.spread == 3 then
        if self.pos%3 == 0 then --bala do meio
            self.y = self.y - (self.speed * dt)
            self.rot = 0
        end

        if self.pos%3 == 1 then -- bala da esquerda
            self.x = self.x - (self.speed * 0.8 * dt)
            self.y = self.y - (self.speed * dt)
            self.rot = -1
        end
        if self.pos%3 == 2 then -- bala da direita
            self.x = self.x + (self.speed * 0.8 * dt)
            self.y = self.y - (self.speed * dt)
            self.rot = 1
        end
    end

    
    if self.spread == 5 then
        if self.pos%5 == 0 then -- meio
            self.y = self.y - (self.speed * dt)
            self.rot = 0
        end
        if self.pos%5 == 1 then -- esquerda
            self.x = self.x - (self.speed * 0.8 * dt)
            self.y = self.y - (self.speed * dt)
            self.rot = -1
        end
        if self.pos%5 == 2 then -- direita
            self.x = self.x + (self.speed * 0.8 * dt)
            self.y = self.y - (self.speed * dt)
            self.rot = 1
        end
        if self.pos%5 == 3 then -- far left
            self.x = self.x - (self.speed * 1.5 * dt)
            self.y = self.y - (self.speed * 0.9 * dt)
            self.rot = -1.3
        end
        if self.pos%5 == 4 then --nazismo é de esquerda
            self.x = self.x + (self.speed * 1.5 * dt)
            self.y = self.y - (self.speed * 0.9 * dt)
            self.rot = 1.3
        end
    end
    
end

function Bullet:draw()
    --love.graphics.circle("line",self.x,self.y-10,2*wScale) --balinha placeholder
    if self.rot < 1.3 and self.rot > -1.3 then love.graphics.draw(self.blt,self.x,self.y,self.rot,wScale,wScale,wScale,4*wScale) end
    if self.rot == 1.3 or self.rot == -1.3  then love.graphics.draw(self.blt,self.x,self.y-2*wScale,self.rot,wScale,wScale,wScale,4*wScale) end
end