UiManager = Object:extend()

function UiManager:new()
    self.gameManager = GameManager()
    self.menu = Menu(self)
    self.states = {["onMenu"] = 1, ["onGame"] = 2, ["pause"] = 3}
    self.curState = self.states.onMenu
end




function UiManager:update(dt)
    
    if self.curState == self.states.onGame then
        self.gameManager:update(dt)
    elseif self.curState == self.states.onMenu then
        self.menu:update()
    elseif self.curState == self.states.pause then

    end
end

function UiManager:draw()
    if self.curState == self.states.onGame then
        self.gameManager:draw()
    elseif self.curState == self.states.onMenu then
        self.menu:draw()
    elseif self.curState == self.states.pause then
        self.player:draw()
    end
end