GameManager = Object:extend()

function GameManager:new()
    self.buff = {}
    self.player = {Player()}
    self.enemies = {}
    self.spawnTimerE = 3
    self.spawnTimerB = 4
    self.enemyIndex = 1

    self.wave1 = {
        DefaultE("red"),DefaultE("yellow"),
        DefaultE("green"),DefaultE("yellow"),
        DefaultE("purple"),DefaultE("red"),
        DefaultE("purple"),DefaultE("green")
    }
    self.wave2 = {}
    self.wave3 = {}
    self.wave4 = {}


    --Imagens da Hud
    self.bg = love.graphics.newImage("artwork/HUD.png")
    self.logo = love.graphics.newImage("artwork/J-IKARUS.png")
    self.uiHP = love.graphics.newImage("artwork/gfx/UI/inGame/UIHealth.png")
    self.uiShield = {
        love.graphics.newImage("artwork/gfx/UI/inGame/UIShield1.png"),
        love.graphics.newImage("artwork/gfx/UI/inGame/UIShield2.png"),
        love.graphics.newImage("artwork/gfx/UI/inGame/UIShield3.png")
    }
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
            local a_left = enem.x-10
            local a_top = enem.y-10
            if b == self.enemies or a ==  self.player[1].bullet then --caso a colisão seja entre inimigos e balas ou inimigos e player
                local a_right = enem.x + enem.width +10
                local a_bottom = enem.y + enem.height + 10
                if a_left<blt.x and a_right>blt.x and a_top<blt.y and a_bottom>blt.y then
                    if not (a == self.player[1].bullet) then
                         table.remove(self.enemies,m)
                         self.player[1].health = self.player[1].health - 1
                    end
                    if a ==  self.player[1].bullet then
                        table.remove(self.player[1].bullet,n)
                        table.remove(self.enemies,m)
                    end
                end
            elseif b == self.buff then -- caso a colisao seja entre player e buff
                if enem.x-10 < blt.x and enem.x+10 > blt.x and enem.y-10 < blt.y and enem.y+10 > blt.y then
                    if enem.tipo == "power" then self.player[1].buffDmg = self.player[1].buffDmg + 0.6              end
                    if enem.tipo == "speed" then self.player[1].buffSpeed = self.player[1].buffSpeed + (0.5*wScale) end
                    if enem.tipo == "fRate" then self.player[1].buffFireRate = self.player[1].buffFireRate - 0.8    end
                    
                    if enem.tipo == "gPower" then self.player[1].buffDmg = self.player[1].buffDmg + 1.3               end
                    if enem.tipo == "gSpeed" then self.player[1].buffSpeed = self.player[1].buffSpeed + (0.01*wScale) end
                    if enem.tipo == "gFRate" then self.player[1].buffFireRate = self.player[1].buffFireRate - 1.6     end
                    
                    if enem.tipo == "3x" then self.spread = 3 end
                    if enem.tipo == "5x" then self.spread = 5 end
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
        table.remove(curWave[self.enemyIndex])
        self.enemyIndex = self.enemyIndex + 1
    
    end

    if self.spawnTimerE > 0 then
        self.spawnTimerE = self.spawnTimerE - (10*dt)
        if self.spawnTimerE < 0 then --se o timer for menor que zero, recebe 0 
            self.spawnTimerE = 0
        end
    end
end

function GameManager:spawnB(dt)
    whichBuff = math.random(0,400)
    if self.spawnTimerB == 0 then
            if whichBuff < 75                       then buff = "power" end
            if whichBuff >= 75 and whichBuff < 150  then buff = "speed" end
            if whichBuff >= 150 and whichBuff < 225 then buff = "fRate" end              
            if whichBuff >= 225 and whichBuff < 300 then buff = "3x" end

            if whichBuff >= 300 and whichBuff < 325 then buff = "gPower" end
            if whichBuff >= 325 and whichBuff < 350 then buff = "gSpeed" end
            if whichBuff >= 350 and whichBuff < 375 then buff = "gFRate" end
            if whichBuff >= 375 and whichBuff < 400 then buff = "5x" end
                
            table.insert(self.buff,Buff(buff))
            self.spawnTimerB = 4
    end

    if self.spawnTimerB > 0 then
        self.spawnTimerB = self.spawnTimerB - (10*dt)
        if self.spawnTimerB < 0 then --se o timer for menor que zero, recebe 0 
            self.spawnTimerB = 0
        end
    end
end

function GameManager:doWave(dt)
    if not (self.wave1[8] == nil)  then
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
    love.graphics.print(self.player[1].health,0,0,0,wScale,wScale)
end
