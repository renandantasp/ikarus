GameManager = Object:extend()

function GameManager:new()
    self.player = Player()
    self.menu = Menu(self)
    self.states = {["onMenu"] = 1, ["onGame"] = 2, ["pause"] = 3}
    self.curState = self.states.onMenu
end




function GameManager:update(dt)
    
    if self.curState == self.states.onGame then
        self.player:update(dt)
    elseif self.curState == self.states.onMenu then
        self.menu:update()
    elseif self.curState == self.states.pause then

    end
end

function GameManager:draw()
    if self.curState == self.states.onGame then
        self.player:draw()
    elseif self.curState == self.states.onMenu then
        self.menu:draw()
    elseif self.curState == self.states.pause then
        self.player:draw()
    end
end