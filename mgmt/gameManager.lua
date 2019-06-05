GameManager = Object:extend()

function GameManager:new()
    self.buff = {}
    self.drawBuff = {}

    self.player = {Player()}
    self.gameOverTimer = 50
    self.gameOver = false
    self.menuGameOver = false
    self.enemies = {}

    self.spawnTimerE = 0
    self.spawnTimerB = 0

    self.enemyIndex = 0
    
    
    
    

    -----===Waves===-----
    self.preWave = true
    self.posWave = false
    self.sfxTimer = 7
    
    self.wave1size = 2
    self.wave2size = 2
    self.wave3size = 2
    self.wave4size = 2
    
    self.curWave = 1
    
    self.wave1 = {
        DefaultE("red","senx"),Cell()
    }
    self.wave2 = {
        DefaultE("green","senx"),DefaultE("yellow","senx")
    }
    self.wave3 = {
        DefaultE("yellow","senx"),DefaultE("yellow","senx")
    }
    self.wave4 = {
        DefaultE("purple","senx"),DefaultE("yellow","senx")
    }
    ---------------------
    --===OST===-------------------------
    self.mscWave = love.audio.newSource("artwork/sfx/Wave1n3.wav","stream")
    self.mscWave:setVolume(0.7)

    self.mscWaveClear = love.audio.newSource("artwork/sfx/stageClear.wav","stream")
    
    self.sfxWave1 = love.audio.newSource("artwork/sfx/voicefx/wave1.wav","static")
    self.sfxWave1:setPitch(0.8)
    
    self.sfxWave2 = love.audio.newSource("artwork/sfx/voicefx/wave2.wav","static")
    self.sfxWave2:setPitch(0.8)
    
    self.sfxWave3 = love.audio.newSource("artwork/sfx/voicefx/wave3.wav","static")
    self.sfxWave3:setPitch(0.8)
    
    self.sfxWave4 = love.audio.newSource("artwork/sfx/voicefx/wave4.wav","static")
    self.sfxWave4:setPitch(0.8)

    self.sfxWave4 = love.audio.newSource("artwork/sfx/voicefx/wave4.wav","static")
    self.sfxWave4:setPitch(0.8)

    self.sfxEnter = love.audio.newSource("artwork/sfx/voicefx/enterTheIkarus.wav","static")
    self.sfxEnter:setPitch(0.8)

    self.sfxGameOver = love.audio.newSource("artwork/sfx/voicefx/gameOver.wav","static")
    self.sfxGameOver:setPitch(0.8)

    self.sfxDed = love.audio.newSource("artwork/sfx/ded.wav","static")

    self.splWave1 = love.graphics.newImage("artwork/gfx/wave1.png")
    self.splWave2 = love.graphics.newImage("artwork/gfx/wave2.png")
    self.splWave3 = love.graphics.newImage("artwork/gfx/wave3.png")
    self.splWave4 = love.graphics.newImage("artwork/gfx/wave4.png")


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

    --===Imagens da fase===--------------
    self.star1 = love.graphics.newImage("artwork/gfx/estrela1.png")
    self.star2 = love.graphics.newImage("artwork/gfx/estrela2.png")
    self.parallax1 = 0
    self.parallax2 = 0
    ------------------------------------
end

function GameManager:update(dt)
    if self.parallax1 < 240*wScale then
        self.parallax1 = self.parallax1 + (250*wScale*dt)
    else
        self.parallax1 = 0
    end
    if self.parallax2 < 240*wScale then
        self.parallax2 = self.parallax2 + (150*wScale*dt)
    else
        self.parallax2 = 0
    end

    if self.player[1].health <= 0 then 
        self.gameOver = true
        self:gameOverf(dt)
    else
        self.player[1]:update(dt) 
        self:doWave(dt)
    end
    if love.keyboard.isDown('f') then
        self.player[1].health = 0
    end
    
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
                
            table.insert(self.buff,Buff(buff))
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
    if self.curWave == 1 then
        --Pre Wave 1
        if self.preWave == true then
            if self.sfxTimer == 7 then
                love.audio.play(self.sfxEnter)
            end
            if self.sfxTimer < 3 and self.sfxTimer > 1 then
                love.audio.play(self.sfxWave1)
            end
            self:doTimer(dt)
            if self.sfxTimer == 0 then
                self.timer = 1000*dt 
                self.preWave = false
            end
        end

        --Wave 1
        if not (next(self.wave1) == nil) and self.preWave == false then
            love.audio.play(self.mscWave)
            self.sfxTimer = 1000*dt
            if self.enemyIndex == 0 then
                self.enemyIndex = self.wave1size
            end
            self.waveTimer = 30
            self:spawnE(dt,self.wave1)
            self:spawnB(dt)
        end

        --pos 1st wave
        if (next(self.wave1) == nil) and (next(self.enemies) == nil) then
            self.mscWave:seek(0,"seconds")
            self.mscWave:stop(self.mscWave)
            
            self.curWave = 2
            love.audio.play(self.mscWaveClear)
            self.preWave = true
            self.sfxTimer = 800*dt
        end
    end

    if self.curWave == 2 then
        --Pre Wave 2
        if self.preWave == true then
            self:doTimer(dt)
            if self.sfxTimer < 2 and self.sfxTimer > 1 then
                love.audio.play(self.sfxWave2)
            end
            if self.sfxTimer == 0 then
                love.audio.play(self.mscWave)
                self.timer = 1000*dt
                self.preWave = false
            end
        end

        --Wave 2
        if not (next(self.wave2) == nil) and self.preWave == false then
            love.audio.play(self.mscWave)
            self.sfxTimer = 1000*dt
            if self.enemyIndex == 0 then
                self.enemyIndex = self.wave2size
            end
            self.waveTimer = 30
            self:spawnE(dt,self.wave2)
            self:spawnB(dt)
        end

        --pos Wave 2
        if (next(self.wave2) == nil) and (next(self.enemies) == nil) then
            self.mscWave:seek(0,"seconds")
            self.mscWave:stop(self.mscWave)
            
            self.curWave = 3
            love.audio.play(self.mscWaveClear)
            self.preWave = true
            self.sfxTimer = 1000*dt
        end
    end

    if self.curWave == 3 then
        --Pre Wave 3
        if self.preWave == true then
            self:doTimer(dt)
            if self.sfxTimer < 2 and self.sfxTimer > 1 then
                love.audio.play(self.sfxWave3)
            end
            if self.sfxTimer == 0 then
                love.audio.play(self.mscWave)
                self.timer = 1000*dt
                self.preWave = false
            end
        end

        --Wave 3
        if not (next(self.wave3) == nil) and self.preWave == false then
            love.audio.play(self.mscWave)
            self.sfxTimer = 1000*dt
            if self.enemyIndex == 0 then
                self.enemyIndex = self.wave3size
            end
            self.waveTimer = 30
            self:spawnE(dt,self.wave3)
            self:spawnB(dt)
        end

        --pos Wave 3
        if (next(self.wave3) == nil) and (next(self.enemies) == nil) then
            self.mscWave:seek(0,"seconds")
            self.mscWave:stop(self.mscWave)
            
            self.curWave = 4
            love.audio.play(self.mscWaveClear)
            self.preWave = true
            self.sfxTimer = 1000*dt
        end
    end

    if self.curWave == 4 then
        --Pre Wave 4
        if self.preWave == true then
            self:doTimer(dt)
            if self.sfxTimer < 2 and self.sfxTimer > 1 then
                love.audio.play(self.sfxWave4)
            end
            if self.sfxTimer == 0 then
                love.audio.play(self.mscWave)
                self.timer = 1000*dt
                self.preWave = false
            end
        end

        --Wave 4
        if not (next(self.wave4) == nil) and self.preWave == false then
            love.audio.play(self.mscWave)
            self.sfxTimer = 1000*dt
            if self.enemyIndex == 0 then
                self.enemyIndex = self.wave4size
            end
            self.waveTimer = 30
            self:spawnE(dt,self.wave4)
            self:spawnB(dt)
        end

        --pos Wave 4
        if (next(self.wave4) == nil) and (next(self.enemies) == nil) then
            self.mscWave:seek(0,"seconds")
            self.mscWave:stop(self.mscWave)
            
            self.curWave = 5
            love.audio.play(self.mscWaveClear)
            self.preWave = true
            self.sfxTimer = 1000*dt
        end
    end





end


function GameManager:draw()

   --Parallax
    love.graphics.draw(self.star1,187*wScale,self.parallax1,0,wScale,wScale,0,240)
    love.graphics.draw(self.star2,187*wScale,self.parallax2,0,wScale,wScale,0,240)
   -----

    if self.gameOver == false then
        self.player[1]:draw()
    end

    --love.graphics.print(self.gameOverTimer,200*wScale,20*wScale,0,1,1)
 
   --inimigos
    for n,enem in ipairs(self.enemies) do --Desenha todos os inimigos dentro da table enemies
        enem:draw()
    end
   --
   --buffs 
    for n,buffs in ipairs(self.buff) do --Desenha todos os buffs presentes na table buff
        buffs:draw()
    end
   --

   --ui e logo
    love.graphics.draw(self.bg,0,0,0,1*wScale,1*wScale)
    love.graphics.draw(self.logo,10*wScale,13*wScale,0,1*wScale,1*wScale)
    love.graphics.print("score",76*wScale,69*wScale,0,1*wScale,1*wScale)
    love.graphics.print("00000000000",58*wScale,82*wScale,0,1*wScale,1*wScale)
    love.graphics.print("health",76*wScale,100*wScale,0,1*wScale,1*wScale)
    love.graphics.print("power-up",68*wScale,183*wScale,0,1*wScale,1*wScale)

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
        
        if n == 1 then
            for i=1,self.player[1].shield do
                buff:draw((55 + 25*(i-1)) * wScale,149*wScale)
            end
        end    
    end
   --
  
   if self.curWave == 1 then
        if self.sfxTimer < 3 and self.sfxTimer > 1 then
            love.graphics.draw(self.splWave1,220*wScale,80*wScale,0,wScale,wScale)
        end
   end

    if self.curWave == 2 then
        if self.sfxTimer < 2 and self.sfxTimer > 0.1 then
            love.graphics.draw(self.splWave2,220*wScale,80*wScale,0,wScale,wScale)
        end
    end

    if self.curWave == 3 then
        if self.sfxTimer < 2 and self.sfxTimer > 0.1 then
            love.graphics.draw(self.splWave3,220*wScale,80*wScale,0,wScale,wScale)
        end
    end

    if self.curWave == 4 then
        if self.sfxTimer < 2 and self.sfxTimer > 0.1 then
            love.graphics.draw(self.splWave4,220*wScale,80*wScale,0,wScale,wScale)
        end
    end
 
end

function GameManager:doTimer(dt)
    if self.sfxTimer > 0 then
        self.sfxTimer = self.sfxTimer - 1*dt
    end
    if self.sfxTimer < 0 then
        self.sfxTimer = 0
    end 
end

function GameManager:gameOverf(dt)
    self.mscWave:stop()
    if self.gameOverTimer > 0 then
        self.gameOverTimer = self.gameOverTimer - 10*dt
    else
        self.gameOverTimer =0
    end
    
    if self.gameOverTimer <= 50 and self.gameOverTimer > 30 then
        love.audio.play(self.sfxDed)
    end

    if self.gameOverTimer > 30 and self.gameOverTimer < 40 then
        love.audio.play(self.sfxGameOver)
    end
    if self.gameOverTimer == 0 then
        self.menuGameOver = true
    end
end