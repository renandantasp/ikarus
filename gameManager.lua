GameManager = Object:extend()

function GameManager:new(p1)
    self.player = p1
    self.states = {["onMenu"] = 1, ["onGame"] = 2, ["pause"] = 3}
    self.curState = self.states.onGame
end




function GameManager:update(dt)
    
    if self.curState == self.states.onGame then
        pl:update(dt)
    end
end

function GameManager:draw()
    if self.curState == self.states.onGame then
        pl:draw()
    elseif self.curState == self.states.onMenu then

    elseif self.curState == self.states.pause then

    end
end