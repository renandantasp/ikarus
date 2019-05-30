UiManager = Object:extend()

function UiManager:new()
    self.player = Player()
    self.menu = Menu(self)
    self.states = {["onMenu"] = 1, ["onGame"] = 2, ["pause"] = 3}
    self.curState = self.states.onMenu
end




function UiManager:update(dt)
    
    if self.curState == self.states.onGame then
        self.player:update(dt)
    elseif self.curState == self.states.onMenu then
        self.menu:update()
    elseif self.curState == self.states.pause then

    end
end

function UiManager:draw()
    if self.curState == self.states.onGame then
        self.player:draw()
        love.graphics.setColor(0.3,0.3,0.3)
        love.graphics.rectangle("fill",0,0,700*wScale,900*wScale)
        love.graphics.setColor(1,1,1)
        love.graphics.print("NAVINHA",120*wScale,100*wScale,0,4,4)
    elseif self.curState == self.states.onMenu then
        self.menu:draw()
    elseif self.curState == self.states.pause then
        self.player:draw()
    end
end