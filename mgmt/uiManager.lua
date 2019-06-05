UiManager = Object:extend()

function UiManager:new()
    self.gameManager = GameManager()
    self.menu = Menu(self)
    self.states = {["onMenu"] = 1, ["onGame"] = 2, ["gameOver"] = 3}
    self.curState = self.states.onMenu
    font = love.graphics.newImageFont("artwork/gfx/font.png",  " !\"#$%&'()*+,-./0123456789:;<=>?@ÁÀÂÃABCÇDEÉÊFGHIÍJKLMNÑOÓÔPQRSTUÚVWXYZ[\\]^_`áàâãabcçdeéêfghiíjklmnñoóôpqrstuúvwxyz{|}")
    love.graphics.setFont(font)
end




function UiManager:update(dt)
    if self.gameManager.menuGameOver == true then
        self.curState = self.states.gameOver
    end
    
    if self.curState == self.states.onGame then
        self.gameManager:update(dt)
    elseif self.curState == self.states.onMenu then
        self.menu:update(dt)
        
    elseif self.curState == self.states.gameOver then
        self.menu:update(dt)
    end

    if self.menu.contagem < 10 and self.menu.contagem > 9.9 then
        self.gameManager = GameManager()
    end

    if self.menu.contagem == 0 then
        self.curState = self.states.onMenu
        self.menu.contagem = 10
    end
end

function UiManager:draw()
    if self.curState == self.states.onGame then
        self.gameManager:draw()
    elseif self.curState == self.states.onMenu then
        self.menu:draw()
    elseif self.curState == self.states.gameOver then
        self.menu:draw()
    end
end