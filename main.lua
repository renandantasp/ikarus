function love.load()
    love.graphics.setDefaultFilter('nearest','nearest') --desligar os antialiasing pros pixel ficar crocante
    ------===Libraries===------
    Object = require "lib.classic" --lib de poo
    anim   = require "lib.anim8"  --lib de animação
    ---------------------------

    ------------===Gameplay===----------
    require "path.pathLib"
    require "path.path"    
    require "nave"
    require "bullet"
    require "player"
    require "enemies.default"
    require "gameManager"
    require "menu"
    ------------------------------------


    gm =  GameManager()
    --gm:load()
end


function love.update(dt)
    gm:update(dt)
end

function love.draw()
    gm:draw()
    
end