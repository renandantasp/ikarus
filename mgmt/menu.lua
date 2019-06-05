Menu = Object:extend()

function Menu:new(gm)
    self.gm = gm -- recebe o uiManager, assim tem acesso aos estados do jogo
    self.menus = {["play"] = 1, ["quit"] = 2, ["gameOver"] = 3} -- lista dos menus 
    self.curSelect =  1 -- opção atual
    self.logo = love.graphics.newImage("artwork/J-IKARUS.png")

    self.sfxSelect = love.audio.newSource("artwork/sfx/select.wav", "static")
    self.sfxMainMenu = love.audio.newSource("artwork/sfx/mainMenu.wav", "stream")
    self.mscContinue = love.audio.newSource("artwork/sfx/songGameOver.wav", "stream")
    self.contagem = 10

    self.mainMenuArt = love.graphics.newImage("artwork/menuArt/mainMenu.png")
    self.gameOverArt = love.graphics.newImage("artwork/menuArt/gameOver.png")
    self.seta = love.graphics.newImage("artwork/menuArt/seta.png")

    self.star1 =love.graphics.newImage("artwork/menuArt/menuStar1.png")
    self.star2 =love.graphics.newImage("artwork/menuArt/menuStar2.png")
    self.prlx1 = 0
    self.prlx2 = 0
    

end

function Menu:update(dt)
    if self.prlx1 < 240*wScale then
        self.prlx1 = self.prlx1 + 200*dt*wScale
    else
        self.prlx1 = 0
    end
    if self.prlx2 < 240*wScale then
        self.prlx2 = self.prlx2 + 100*dt*wScale
    else
        self.prlx2 = 0
    end
    
    if gm.curState == 1 then
        love.audio.play(self.sfxMainMenu)
    end
    function love.keypressed(key,scancode,isrepeat)
        if gm.curState == 1 then
            if key == 'up' then
                love.audio.play(self.sfxSelect)
                self.curSelect = self.curSelect - 1
            elseif key == 'down' then
                love.audio.play(self.sfxSelect)
                self.curSelect = self.curSelect - 1
            end
            if key == 'return' then
                self.sfxMainMenu:seek(0,"seconds")
                self.sfxMainMenu:stop()
                if self.curSelect%2 == 1 then
                    gm.curState = 2
                elseif self.curSelect%2 == 0 then
                    love.event.quit()
                end
            end
        end
    end

    if gm.curState == 3 then
        if self.contagem==10 then
            love.audio.play(self.mscContinue)
        end

        if self.contagem > 0 then
            self.contagem = self.contagem - (dt/2)
        else
            self.contagem = 0
            self.mscContinue:seek(0,"seconds")
            self.mscContinue:stop()
        end
 
    end

end

function Menu:draw()
    love.graphics.draw(self.star1,0,self.prlx1,0,wScale,wScale,nil,80*wScale)
    love.graphics.draw(self.star2,0,self.prlx2,0,wScale,wScale,nil,80*wScale)
    if gm.curState == 1 then
            love.graphics.draw(self.logo,129*wScale,30*wScale,0,wScale,wScale)
            love.graphics.draw(self.mainMenuArt,0,0,0,wScale,wScale)
        if self.curSelect%2 == 1 then
            love.graphics.draw(self.seta,176*wScale,139*wScale,0,wScale,wScale)
        elseif self.curSelect%2 == 0 then
            love.graphics.draw(self.seta,195*wScale,161*wScale,0,wScale,wScale)
        end
    end
    if gm.curState == 3 then
        love.graphics.draw(self.gameOverArt,0,0,0,wScale,wScale)
    end
end