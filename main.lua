function love.load()
    love.graphics.setDefaultFilter('nearest','nearest') --desligar os antialiasing pros pixel ficar crocante
    ------===Libraries===------
    Object = require "lib.classic" --lib de poo
    anim   = require "lib.anim8"  --lib de animação
    ---------------------------

    ------------===Gameplay===----------
    
    require "nave"
    require "bullet"
    require "player"
    require "gameManager"
    ------------------------------------

    pl = Player()
    

    

    gm =  GameManager(p1)
end


function love.update(dt)
    gm:update(dt)
end

function love.draw()
    gm:draw()
    
end