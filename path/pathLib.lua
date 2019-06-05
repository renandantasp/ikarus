PathLib = Object:extend()

function PathLib:new(enemy,func)
    self.enemy = enemy
    
    --valores usado para executar as funções de movimento
    self.taxa = self.enemy.speed
    self.taxaFixa = self.enemy.speed
    ----------------------------------------------------
    
    --inicializa x e y igual ao objeto quando nasce
    self.x = self.enemy.x
    self.y = self.enemy.y
    ----------------------------------------------

    self.xFunc = self.enemy.x
    self.yFunc = self.enemy.y
    
    --auxiliar usado para transladar o objeto no eixo
    self.auxY = 0
    self.auxX = 0
    ----------------------------------------------------
    
    self.sinal = 1
    self.func = func
    if self.func == "senx" then
        self.auxY = 20*wScale
    end
    if self.func == "buff" then
        self.auxX = self.x
    end
end


function PathLib:update(dt)
    if self.func == "senx" then
        --se o x do inimigo estiver a 40 pxls do fim da janela
        if (self.enemy.x>love.graphics.getWidth()-40*wScale) then
            --a taxa irá diminuir até ficar igual ao oposto da taxa fixa
            self.taxa = self.taxa - (0.02)
            if self.taxa < -self.taxaFixa then
                self.taxa = -self.taxaFixa
            end
        end

        --se o x do inimigo estiver a 14 pxls do começo da janela
        if (self.enemy.x < 200*wScale) then
            --a taxa irá diminuir até ficar igual à taxa fixa
            self.taxa = self.taxa + (0.02)
            if self.taxa > self.taxaFixa then
                self.taxa = self.taxaFixa
            end
        end



        self.xFunc = self.xFunc + self.taxa
        self.yFunc = math.sin(self.xFunc)

        
        if self.auxY <= 20*wScale then
            self.sinal = 1
        end
        if self.auxY >= 80*wScale then
            self.sinal = -1
        end
        --if (self.enemy.x > 187*wScale and self.enemy.x < 240*wScale) then
            self.auxY = self.auxY + (20*wScale*self.sinal*dt)
        --end
        


        self.x = self.enemy.x + (self.taxa*400*dt*wScale)
        self.y = (self.yFunc * wScale * 270 * dt) + self.auxY
    end
    
    if self.func == "buff" then
    
        
        self.yFunc = self.yFunc + self.taxa
        self.xFunc = math.sin(self.yFunc)

        self.x = (self.xFunc * wScale * 480 * dt) + self.auxX
        self.y = self.enemy.y + (self.taxa*500*dt*wScale)
        
    end


    if self.func == "static" then 
    end

    if self.func == "log" then


    end
end