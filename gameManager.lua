GameManager = Object:extend()

function GameManager:new()
    self.buff = Buff('power', 30, 100, 0)
    self.player = Player()
    self.enemies = {}
end

function GameManager:update(dt)
    --print(type(self.enemies))
    self:spawn()
    self.player:update(dt)
    for n,enem in ipairs(self.enemies) do
        enem:update(dt)
    end
    --self.enemies[1]:update(dt)
    self.blts =  self.player.bullet
    self:collide(self.player.bullet,self.enemies)
    --print(type(self.player.bullet))
    
    self.buff:update(dt)
end

function GameManager:draw()
    self.player:draw()
    for n,enem in ipairs(self.enemies) do
        enem:draw()
    end
    --self.enemies[1]:draw()
    self.buff:draw()
    love.graphics.setColor(0.3,0.3,0.3)
    love.graphics.rectangle("fill",0,0,700*wScale,1200*wScale)
    love.graphics.setColor(1,1,1)
    love.graphics.print("NAVINHA",120*wScale,100*wScale,0,4,4)
end

function GameManager:collide(a, b)
    for n,blt in ipairs(a) do
        for m, enem in ipairs(b) do
            local a_left = enem.x-10
            local a_right = enem.x + enem.width +10
            local a_top = enem.y-10
            local a_bottom = enem.y + enem.height + 10
            if a_left<blt.x and a_right>blt.x and a_top<blt.y and a_bottom>blt.y then
                table.remove(self.enemies,m)
                table.remove(self.player.bullet,n)
            end
        end
    end
    --print(type(b))
end

function GameManager:spawn()
    if love.keyboard.isDown('r') then
        table.insert(self.enemies,DefaultE())
    end
end