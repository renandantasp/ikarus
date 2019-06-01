Menu = Object:extend()

function Menu:new(gm)
    self.gm = gm -- recebe o uiManager, assim tem acesso aos estados do jogo
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
            if key == 'z' or key == 'return' then
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
        love.graphics.rectangle("fill", love.graphics.getWidth()/6+20, love.graphics.getHeight()/2, 100,25)
        love.graphics.setColor(0,0,0)
        love.graphics.print("PLAY",love.graphics.getWidth()/6+35+20, love.graphics.getHeight()/2+5)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("line", love.graphics.getWidth()/6, love.graphics.getHeight()/2+50, 100,25)
        love.graphics.print("QUIT",love.graphics.getWidth()/6+35, love.graphics.getHeight()/2+55)
    elseif self.curSelect%2 == 0 then
        love.graphics.rectangle("line", love.graphics.getWidth()/6, love.graphics.getHeight()/2, 100,25)
        love.graphics.print("PLAY",love.graphics.getWidth()/6+35, love.graphics.getHeight()/2+5)
        love.graphics.rectangle("fill", love.graphics.getWidth()/6+20, love.graphics.getHeight()/2+50, 100,25)
        love.graphics.setColor(0,0,0)
        love.graphics.print("QUIT",love.graphics.getWidth()/6+35+20, love.graphics.getHeight()/2+55)
        love.graphics.setColor(1,1,1)
    end
end