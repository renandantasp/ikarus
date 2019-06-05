Player = Nave:extend()


function Player:new()
    Player.super.new(self,25)
    --==GAMEPLAY==--
    self.health = 5
    
    --Velocidade e força do tiro
    self.fireRate = 3
    self.shootTimer = 0

    --Buffs---------
    self.buffIndex = 0
    self.shield = 0
    self.spread = 0
    ----------------

    --Buffs da rotação---
    self.buffSpeed    = self.speed
    self.buffDmg      = 1
    self.buffFireRate = 3
    ---------------------

    -----===SFX-----
    sfxHurt = love.audio.newSource("artwork/sfx/hurt.wav","static")
    sfxPowerUp = love.audio.newSource("artwork/sfx/powerup.wav","static")
    sfxExpl = love.audio.newSource("artwork/sfx/explosion.wav","static")
    sfxShoot = love.audio.newSource("artwork/sfx/shoot.wav","static")

    
    
    --Tables----------
    self.bullet  = {}
    self.buffRot = {}
    self.buffVec = {Buff("shield",true),nil}
    ------------------

    self.image = love.graphics.newImage("artwork/gfx/naves/player.png")
    self.g = anim.newGrid(25,32,self.image:getWidth(), self.image:getHeight())
    self.idle = anim.newAnimation(self.g('1-2',1), 0.01)

    --Atributos do player
    

end

function Player:movement(dt)
   --Movimentação
    if love.keyboard.isDown('up') then
        self.y = self.y - (self.buffSpeed * dt)
    end
    if love.keyboard.isDown('down') then
        self.y = self.y + (self.buffSpeed * dt)
    end
    if love.keyboard.isDown('left') then
        self.x = self.x - (self.buffSpeed * dt)
    end
    if love.keyboard.isDown('right') then
        self.x = self.x + (self.buffSpeed * dt)
    end
   --

   --Limites
    if self.x + self.width > love.graphics.getWidth() then
        self.x = love.graphics.getWidth() - self.width
    end
    if self.x < 187*wScale then
        self.x = 187*wScale
    end
    if self.y + self.height > love.graphics.getHeight() then
        self.y = love.graphics.getHeight() - self.height
    end
    if self.y < 0 then
        self.y = 0
    end
   --
end

function Player:updateBuff(tipo)
    love.audio.play(sfxPowerUp)
    if tipo ~= "3x" and tipo ~= "5x" and tipo ~= "shield" then
        self.buffRot[(self.buffIndex%3)+1] = Buff(tipo,true)

        self.buffIndex = self.buffIndex + 1
        local i=1
        auxBuffPw=0
        auxBuffSp=0
        auxBuffFr=0
        for i, buff in ipairs(self.buffRot) do
            --Buff normais
            if buff.tipo == "power"  then 
                auxBuffPw = auxBuffPw + 0.6       
             end
            if buff.tipo == "speed"  then 
                auxBuffSp = auxBuffSp + (0.5*wScale)  
            end
            if buff.tipo == "fRate"  then 
                auxBuffFr = auxBuffFr + 0.8  
            end

            --Buffs Dourados
            if buff.tipo == "gPower" then 
                auxBuffPw = auxBuffPw + 1.3           
            end
            if buff.tipo == "gSpeed" then 
                auxBuffSp = auxBuffSp + (0.01*wScale) 
            end
            if buff.tipo == "gFRate" then 
                auxBuffFr = auxBuffFr + 1             
            end
        end

        self.buffDmg = self.shootDamage + auxBuffPw
        self.buffSpeed = self.speed + auxBuffSp
        self.buffFireRate = self.fireRate - auxBuffFr    
    end
    --Buffs de spread 
    if tipo == "3x" then 
        self.buffVec[2] = Buff(tipo,true)
        self.spread = 3 
    end
    if tipo == "5x" then 
        self.buffVec[2] = Buff(tipo,true)
        self.spread = 5 
    end
    -------------------
    --Shield
    if tipo == "shield" then 
        self.buffVec[1] = Buff(tipo,true)
        self.shield = self.shield + 1
        if self.shield > 3 then self.shield = 3 end
    end
end
    

function Player:shoot()
    self.shootTimer = self.buffFireRate --reinicia o timer do fire rate
    if self.spread == 0 then
        table.insert(self.bullet,Bullet(self,self.spread)) -- instancia mais uma bala na table
    end
    if self.spread == 3 then
        for i=1,4 do
            table.insert(self.bullet,Bullet(self,self.spread,i)) -- instancia as 3 balas na table
        end
    end
    if self.spread == 5 then
        for i=1,6 do
            table.insert(self.bullet,Bullet(self,self.spread,i)) -- instancia as 5 balasz na table
        end
    end
    
end

function Player:update(dt)
    self:movement(dt)
    self.idle:update(dt)

    if love.keyboard.isDown('z') then
            if self.shootTimer <= 0 then --se o timer estiver zerado, poderá chamar shoot()
                self:shoot()
                love.audio.play(sfxShoot)
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
    --quadrado da colisao
    love.graphics.rectangle('line',self.x,self.y,self.width,self.height)
    -------------------------------
    self.idle:draw(self.image,self.x,self.y,0,wScale,wScale)

    for i, blt in pairs(self.bullet) do
        blt:draw() --desenhar cada bala instanciada
    end
end
        