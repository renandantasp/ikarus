Menu = Object:extend()

function Menu:new(gm)
    self.gm = gm
    self.menus = {["play"] = 1, ["quit"] = 2}
    self.curSelect =  1

end

function Menu:update()
    --[[if love.keyboard.isDown('up') then 
        self.curSelect = self.curSelect - 1
    elseif love.keyboard.isDown('down') then 
        self.curSelect = self.curSelect + 1
    end]]
    function love.keypressed(key,scancode,isrepeat)
        if key == 'up' then
            self.curSelect = self.curSelect - 1
        elseif key == 'down' then
            self.curSelect = self.curSelect - 1
        end
        if key == 'z' then
            if self.curSelect%2 == 1 then
                gm.curState = 2
            elseif self.curSelect%2 == 0 then
                love.event.quit()
            end
        end
    end
end

function Menu:draw()
    if self.curSelect%2 == 1 then
        love.graphics.rectangle("fill", love.graphics.getWidth()/6, love.graphics.getHeight()/2, 100,25)
        love.graphics.rectangle("line", love.graphics.getWidth()/6, love.graphics.getHeight()/2+50, 100,25)
    elseif self.curSelect%2 == 0 then
        love.graphics.rectangle("line", love.graphics.getWidth()/6, love.graphics.getHeight()/2, 100,25)
        love.graphics.rectangle("fill", love.graphics.getWidth()/6, love.graphics.getHeight()/2+50, 100,25)
    end
end