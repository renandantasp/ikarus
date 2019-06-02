Player = Nave:extend()


function Player:new()
    Player.super.new(self,50)
    --==GAMEPLAY==--
    --Velocidade e força do tiro
    self.shootRate = 3
    self.shootTimer = 0

    --Buffs da rotação---
    self.buffSpeed    = 1
    self.buffDmg      = 1
    self.buffFireRate = 1
    ---------------------

    --Buffs---------
    self.shield = 0
    self.spread = 0
    ----------------
    
    --Bullet----------
    self.bullet  = {}
    self.buffVec = {}
    ------------------

    self.image = love.graphics.newImage("artwork/gfx/naves/player.png")
    self.g = anim.newGrid(25,32,self.image:getWidth(), self.image:getHeight())
    self.idle = anim.newAnimation(self.g('1-2',1), 0.1)

    --Atributos do player
    

end

function Player:movement(dt)
   --Movimentação
    if love.keyboard.isDown('up') then
        self.y = self.y - (self.speed * dt)*self.buffSpeed
    end
    if love.keyboard.isDown('down') then
        self.y = self.y + (self.speed * dt)*self.buffSpeed
    end
    if love.keyboard.isDown('left') then
        self.x = self.x - (self.speed * dt)*self.buffSpeed
    end
    if love.keyboard.isDown('right') then
        self.x = self.x + (self.speed * dt)*self.buffSpeed
    end
   --

   --Limites
    if self.x + self.width > love.graphics.getWidth() then
        self.x = love.graphics.getWidth() - self.width
    end
    if self.x < 700*wScale then
        self.x = 700*wScale
    end
    if self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end
    if self.y < 0 then
        self.y = 0
    end
   --
end

function Player:shoot()
    self.shootTimer = self.shootRate --reinicia o timer do fire rate
    table.insert(self.bullet,Bullet(self)) -- instancia mais uma bala na table
    
end

function Player:update(dt)
    self:movement(dt)
    

    
    self.idle:update(dt)

    if love.keyboard.isDown('z') then
            if self.shootTimer <= 0 then --se o timer estiver zerado, poderá chamar shoot()
                self:shoot()
            end
    end
    

    
   --Timer da bala
    if self.shootTimer > 0 then
        self.shootTimer = self.shootTimer - (10*dt)
        if self.shootTimer < 0 then --se o timer for menor que zero, recebe 0 
            self.shootTimer = 0
        end
    end
   -------
    --i é o indice, blt é o objeto no indice i da table self.bullet
    --esse for vai até a ultima posição != nil da table self.bullet
    for i, blt in pairs(self.bullet) do 
        blt:update(dt)  --atualizar todas as balas instanciadas
        if blt.y < 0 then   --se a bala passar da tela por cima, a bala da posição i da table self.bullet será removida
            table.remove(self.bullet,i) --do que eu percebi, esse for pula automaticamente as posições que são nil, achei topster
        end
    end
    

end

function Player:draw()  
    --um triangulo mega placeholder
    love.graphics.polygon("line",self.x,    self.y+self.height,  self.x+(self.width/2),  self.y,   self.x+self.width,self.y+self.height)
    self.idle:draw(self.image,self.x,self.y,0,3*wScale,3*wScale,0,5*wScale)
    for i, blt in pairs(self.bullet) do
        blt:draw() --desenhar cada bala instanciada
    end
end
        