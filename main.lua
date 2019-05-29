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
    ------------------------------------

    pl = Player()
end


function love.update(dt)
    pl:update(dt)
end

function love.draw()
    pl:draw()
    
end