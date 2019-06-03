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
    require "nave"
    require "bullet"
    require "buff"
    require "player"
    require "enemies.default"
    require "enemies.cell"
    require "uiManager"
    require "menu"
    require "gameManager"
    ------------------------------------


    gm =  GameManager()
end


function love.update(dt)
    gm:update(dt)
end

function love.draw()
    gm:draw()
    
end