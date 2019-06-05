function love.load()
    love.graphics.setDefaultFilter('nearest','nearest') --desligar os antialiasing pros pixel ficar crocante
    love.graphics.setBackgroundColor(0.12,0.1,0.185)
    ------===Libraries===------
    Object = require "lib.classic" --lib de poo
    anim   = require "lib.anim8"  --lib de animação
    ---------------------------

    ------------===Gameplay===----------
    require "path.pathLib"
    require "path.path"    
    require "gameplay.nave"
    require "gameplay.bullet"
    require "gameplay.buff"
    require "gameplay.player"
    require "enemies.default"
    require "enemies.cell"
    require "mgmt.uiManager"
    require "mgmt.menu"
    require "mgmt.gameManager"
    require "mgmt.gamePause"
    ------------------------------------


    gm =  UiManager()
end


function love.update(dt)
    gm:update(dt)
end

function love.draw()
    gm:draw()
    
end