Cell = Nave:extend()

function Cell:new(ger,x,y,path,aux)
    self.geracao = ger or 3
    DefaultE.super.new(self,(23))

    if love.math.random(0,1) == 1 then
        self.x = x or 150*wScale
    else
        self.x = x or 450*wScale
    end
    self.y = y or 0

    

    
    self.onHit = false    
    
    if self.geracao == 3 then
        self.health = 10
        self.image = love.graphics.newImage("artwork/gfx/naves/cell/Cell3-sheet.png")
        self.imgOnHit = love.graphics.newImage("artwork/gfx/naves/cell/Cell3-Hit.png")
        self.speed = 0.08
    end
    if self.geracao == 2 then
        self.image = love.graphics.newImage("artwork/gfx/naves/cell/Cell2-sheet.png")
        self.imgOnHit = love.graphics.newImage("artwork/gfx/naves/cell/Cell2-Hit.png")
        self.speed = 0.1
        self.health = 5
        self.width = 17*wScale
        self.height = 15*wScale
    end
    if self.geracao == 1 then
        self.image = love.graphics.newImage("artwork/gfx/naves/cell/Cell1-sheet.png")
        self.imgOnHit = love.graphics.newImage("artwork/gfx/naves/cell/Cell1-Hit.png")
        self.speed = 0.02
        self.health = 3
        self.width = 10*wScale
        self.height = 15*wScale
    end

   

    self.path = Path(self,"senx")
    self.shootRate = 6
    self.shootTimer = 0
    self.bullet  = {}
    
    self.g = anim.newGrid(23,23,self.image:getWidth(), self.image:getHeight())
    self.idle = anim.newAnimation(self.g('1-4',1), 0.12)
end

function Cell:update(dt)
    self.path:update(dt)
    self.x = (self.path.x)
    self.y = (self.path.y)

    self.idle:update(dt)
    self.onHit = false
end

function Cell:draw()
    love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
    if self.geracao == 3 then
        self.idle:draw(self.image, self.x,self.y,0,wScale,wScale)
        if self.onHit == true then
            love.graphics.draw(self.imgOnHit, self.x,self.y,0,wScale,wScale)
        end
    end
    if self.geracao == 2 then
        self.idle:draw(self.image, self.x,self.y,0,wScale,wScale,wScale,2*wScale)
        if self.onHit == true then
            love.graphics.draw(self.imgOnHit,  self.x,self.y,0,wScale,wScale,wScale,2*wScale)
        end
    end
    if self.geracao == 1 then
        self.idle:draw(self.image, self.x,self.y,0,wScale,wScale,2*wScale,wScale)
        if self.onHit == true then
            love.graphics.draw(self.imgOnHit, self.x,self.y,0,wScale,wScale,2*wScale,wScale)
        end
    end

end



