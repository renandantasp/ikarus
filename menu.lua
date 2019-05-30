Menu = Object:extend()

function Menu:new(gm)
    self.gm = gm -- receve o gameManager, assim tem acesso aos estados do jogo
    self.menus = {["play"] = 1, ["quit"] = 2} -- lista dos menus 
    self.curSelect =  1 -- opção atual

end

function Menu:update()
    
    function love.keypressed(key,scancode,isrepeat)
        if gm.curState == 1 then
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