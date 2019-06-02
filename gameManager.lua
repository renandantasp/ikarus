GameManager = Object:extend()

function GameManager:new()
    self.buff = {}
    self.player = {Player()}
    self.enemies = {}
    self.spawnTimerE = 3
    self.spawnTimerB = 4
end

function GameManager:update(dt)
    
    self:spawnE(dt) --Função para spawnar um inimigo
    self:spawnB(dt) --Função para spawnar um buff
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

function GameManager:draw()
    self.player[1]:draw()
    for n,enem in ipairs(self.enemies) do --Desenha todos os inimigos dentro da table enemies
        enem:draw()
    end
    
    for n,buffs in ipairs(self.buff) do --Desenha todos os buffs presentes na table buff
        buffs:draw()
    end

    --Desenho do painel lateral--
    love.graphics.setColor(0.3,0.3,0.3)
    love.graphics.rectangle("fill",0,0,700*wScale,1200*wScale)
    love.graphics.setColor(1,1,1)
    love.graphics.print("NAVINHA",120*wScale,100*wScale,0,4,4)
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
                    table.remove(self.enemies,m)
                    if a ==  self.player[1].bullet then
                        table.remove(self.player[1].bullet,n)
                    end
                end
            elseif b == self.buff then -- caso a colisao seja entre player e buff
                if enem.x-10 < blt.x and enem.x+10 > blt.x and enem.y-10 < blt.y and enem.y+10 > blt.y then
                    if enem.tipo == "speed" then
                        self.player[1].buffSpeed = self.player[1].buffSpeed + 1 
                    end
                    table.remove(self.buff,m)
                end
            end
            
            
        end
    end
    --print(type(b))
end

function GameManager:spawnE(dt)
    
    if self.spawnTimerE == 0 then
        if love.keyboard.isDown('r') then
            table.insert(self.enemies,DefaultE())
            self.spawnTimerE = 3
        end
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
        if love.keyboard.isDown('e') then
            table.insert(self.buff,Buff('speed', 30, 100, 0))
            self.spawnTimerB = 3
        end
    end

    if self.spawnTimerB > 0 then
        self.spawnTimerB = self.spawnTimerB - (10*dt)
        if self.spawnTimerB < 0 then --se o timer for menor que zero, recebe 0 
            self.spawnTimerB = 0
        end
    end
end