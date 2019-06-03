GameManager = Object:extend()

function GameManager:new()
    self.buff = {}
    self.drawBuff = {}
    self.player = {Player()}
    self.enemies = {}
    self.spawnTimerE = 0
    self.spawnTimerB = 0
    self.enemyIndex = 0


    -----===Waves===-----
    self.wave1size = 16
    self.wave1 = {
        Cell(),DefaultE("yellow"),
        DefaultE("green"),DefaultE("yellow"),
        DefaultE("purple"),DefaultE("red"),
        DefaultE("purple"),DefaultE("green"),
        DefaultE("red"),DefaultE("yellow"),
        DefaultE("green"),DefaultE("yellow"),
        DefaultE("purple"),DefaultE("red"),
        DefaultE("purple"),Cell()
    }
    self.wave2 = {}
    self.wave3 = {}
    self.wave4 = {}
    ---------------------
    
    --fonte---
    --font = love.graphics.newImageFont("artwork/fonte/XXX.png",  " !\"#$%&'()*+,-./0123456789:;<=>?@ÁÀÂÃABCÇDEÉÊFGHIÍJKLMNÑOÓÔPQRSTUÚVWXYZ[\\]^_`áàâãabcçdeéêfghiíjklmnñoóôpqrstuúvwxyz{|}")
    --love.graphics.setFont(font)
    --------
    
    --===Imagens da Hud===--------------
    self.bg = love.graphics.newImage("artwork/HUD.png")
    self.logo = love.graphics.newImage("artwork/J-IKARUS.png")
    self.uiHP = love.graphics.newImage("artwork/gfx/UI/inGame/UIHealth.png")
    self.uiShield = {
        love.graphics.newImage("artwork/gfx/UI/inGame/UIShield1.png"),
        love.graphics.newImage("artwork/gfx/UI/inGame/UIShield2.png"),
        love.graphics.newImage("artwork/gfx/UI/inGame/UIShield3.png")
    }
    -------------------------------------
end

function GameManager:update(dt)
    
    self:doWave(dt)
    self.player[1]:update(dt) 
    for n,enem in ipairs(self.enemies) do
        enem:update(dt)
    end
    for n,buffs in ipairs(self.buff) do
        buffs:update(dt)
    end
    
    self.blts =  self.player.bullet
    
    --COLISÕES--
    self:collide(self.player[1].bullet,self.enemies)
    self:collide(self.player,self.enemies)
    self:collide(self.player,self.buff)
   
    
end

function GameManager:collide(a, b)
    --função recebe duas table, e confere se cada elemento de cada table esta colidindo ou não
    for n,blt in ipairs(a) do
        for m, enem in ipairs(b) do
            local a_left = enem.x
            local a_top = enem.y
            if b == self.enemies or a ==  self.player[1].bullet then --caso a colisão seja entre inimigos e balas ou inimigos e player
                local a_right = enem.x + enem.width
                local a_bottom = enem.y + enem.height
                if a_left<blt.x and a_right>blt.x and a_top<blt.y and a_bottom>blt.y then
                    
                    if not (a == self.player[1].bullet) then -- se colidir player com inimigo
                        love.audio.play(sfxHurt)
                        table.remove(self.enemies,m)
                        if self.player[1].shield > 0 then
                           self.player[1].shield = self.player[1].shield - 1
                        else
                            self.player[1].health = self.player[1].health - 1
                        end
                        
                    end
                    if a ==  self.player[1].bullet then -- se colidir o tiro com o inimigo
                        love.audio.play(sfxHurt)
                        enem.health = enem.health - self.player[1].buffDmg
                        enem.onHit = true
                        if enem.health<=0 then
                            if enem.geracao ~= nil then
                                if enem.geracao == 3 then   
                                    table.insert(self.enemies,Cell(2, enem.x+(8*enem.geracao*wScale), enem.y+(3*wScale)))
                                    table.insert(self.enemies,Cell(2, enem.x+(-8*enem.geracao*wScale), enem.y+(3*wScale)))
                                end
                                if enem.geracao == 2 then
                                    table.insert(self.enemies,Cell(1, enem.x+(8*enem.geracao*wScale), enem.y+(3*wScale)))
                                    table.insert(self.enemies,Cell(1, enem.x+(-8*enem.geracao*wScale), enem.y+(3*wScale)))
                                end
                            end
                            
                            table.remove(self.enemies,m)
                            
                            love.audio.play(sfxExpl)


                        end
                        table.remove(self.player[1].bullet,n)
                        
                    end
                end
            elseif b == self.buff then -- caso a colisao seja entre player e buff
                local a_right = enem.x + enem.width
                local a_bottom = enem.y + enem.height
                if a_left<blt.x and a_right>blt.x and a_top<blt.y and a_bottom>blt.y then
                    self.player[1]:updateBuff(enem.tipo)
                    table.remove(self.buff,m)
                end
            end
            
            
        end
    end
    --print(type(b))
end

function GameManager:spawnE(dt,curWave)
    
    if self.spawnTimerE == 0 then
        table.insert(self.enemies,curWave[self.enemyIndex])
        self.spawnTimerE = self.waveTimer
        table.remove(curWave)
        self.enemyIndex = self.enemyIndex - 1
    
    end

    if self.spawnTimerE > 0 then
        self.spawnTimerE = self.spawnTimerE - (10*dt)
        if self.spawnTimerE < 0 then --se o timer for menor que zero, recebe 0 
            self.spawnTimerE = 0
        end
    end
end

function GameManager:spawnB(dt)
    if self.spawnTimerB == 0 then
            whichBuff = love.math.random(0,17)
            if whichBuff <= 2                       then buff = "power" end
            if whichBuff >= 3 and whichBuff <= 5  then buff = "speed" end
            if whichBuff >= 6 and whichBuff <= 8 then buff = "fRate" end              
            if whichBuff >= 9 and whichBuff <= 11 then buff = "3x" end

            if whichBuff >= 12 and whichBuff <= 13 then buff = "shield" end


            if whichBuff == 14 then buff = "gPower" end
            if whichBuff == 15 then buff = "gSpeed" end
            if whichBuff == 16 then buff = "gFRate" end
            if whichBuff == 17 then buff = "5x" end
                
            table.insert(self.buff,Buff("shield"))
            self.spawnTimerB = self.waveTimer
    end

    if self.spawnTimerB > 0 then
        self.spawnTimerB = self.spawnTimerB - (10*dt)
        if self.spawnTimerB < 0 then --se o timer for menor que zero, recebe 0 
            self.spawnTimerB = 0
        end
    end
end

function GameManager:doWave(dt)
    if not (next(self.wave1) == nil)  then
        if self.enemyIndex == 0 then
            self.enemyIndex = self.wave1size
        end
        self.waveTimer = 30
        self:spawnE(dt,self.wave1)
        self:spawnB(dt)
    end
end


function GameManager:draw()
    self.player[1]:draw()
    for n,enem in ipairs(self.enemies) do --Desenha todos os inimigos dentro da table enemies
        enem:draw()
    end
    
    for n,buffs in ipairs(self.buff) do --Desenha todos os buffs presentes na table buff
        buffs:draw()
    end


    love.graphics.draw(self.bg,0,0,0,1*wScale,1*wScale)
    love.graphics.draw(self.logo,10*wScale,13*wScale,0,1*wScale,1*wScale)

    for i=1,self.player[1].health do
        love.graphics.draw(self.uiHP,24*wScale + (28*wScale*(i-1)),116*wScale,0,1*wScale,1*wScale)
    end

    for n,buff in ipairs(self.player[1].buffRot) do --Desenha os buffs da rotação
        buff:draw((57 + 25*(n-1)) *wScale,210*wScale)
    end
    
    for n,buff in ipairs(self.player[1].buffVec) do --Desenha todos os buffs de spread e shield
        if n == 2 then
            buff:draw(141*wScale,211*wScale)
        end
        
        love.graphics.print(self.player[1].shield,0,80*wScale,0,wScale,wScale)
        for i=1,self.player[1].shield do
            buff:draw((55 + 25*(i-1)) * wScale,149*wScale)
            love.graphics.print("aaaaaa",0,80,0,wScale,wScale)
        end
        
    end
    
    --]]
 
end
