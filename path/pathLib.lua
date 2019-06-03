PathLib = Object:extend()

function PathLib:new(enemy,func)
    self.enemy = enemy
    self.cres = self.enemy.speed
    self.cresOG = self.enemy.speed
    self.xFunc = 0
    self.yFunc = 0
    self.auxY = 0
    self.sinal = 1
    if func == "senx" then
        self.auxY = 100
    end
end


function PathLib:update(dt)
    if (self.enemy.x>love.graphics.getWidth()-40*wScale) then
        self.cres = self.cres - (0.02)
        if self.cres < -self.cresOG then
            self.cres = -self.cresOG
        end
    end

    if (self.enemy.x > 187*wScale and self.enemy.x < 200*wScale) then
        self.cres = self.cres + (0.02)
        if self.cres > self.cresOG then
            self.cres = self.cresOG
        end
    end
    --top
    if self.cres > 187*wScale and self.cres < love.graphics.getWidth()-(20*wScale) then
        self.cres = self.cres + self.enemy.speed
    end


    self.xFunc = self.xFunc + self.cres
    self.yFunc = math.sin(self.xFunc)

    if self.auxY >= 400 then
        self.sinal = -1
    end
    if self.auxY <= 100 then
        self.sinal = 1
    end
    if (self.enemy.x > 187*wScale and self.enemy.x < 240*wScale) then
        self.auxY = self.auxY + (1*self.sinal)
    end


    self.x = (self.xFunc*3*wScale)
    self.y = (self.yFunc*5*wScale) + 10*wScale
end