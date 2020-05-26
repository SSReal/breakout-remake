Brick = Class{}

-- some of the colors in our palette (to be used with particle systems)
paletteColors = {
    -- blue
    [1] = {
        ['r'] = 99,
        ['g'] = 155,
        ['b'] = 255
    },
    -- green
    [2] = {
        ['r'] = 106,
        ['g'] = 190,
        ['b'] = 47
    },
    -- red
    [3] = {
        ['r'] = 217,
        ['g'] = 87,
        ['b'] = 99
    },
    -- purple
    [4] = {
        ['r'] = 215,
        ['g'] = 123,
        ['b'] = 186
    },
    -- gold
    [5] = {
        ['r'] = 251,
        ['g'] = 242,
        ['b'] = 54
    }
}

function Brick:init(x, y)
    self.tier = 0
    self.color = 1

    self.x = x
    self.y = y
    self.width = 32
    self.height = 16

    self.inPlay = true

    -- initialize a particle system for showing hit effect
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 64)      --(texture, max_number)

    --lasts between 0.5 to 1 seconds
    self.psystem:setParticleLifetime(0.5, 1)

    --set their linear acceleration in downward direction
    self.psystem:setLinearAcceleration(-15,0,15,80)

    --spread of particles, as given as deviation in x and y axis
    --normal spread is more natural than uniform spread
    --self.psystem:setAreaSpread('normal',10,10)      for love2d 10
    self.psystem:setEmissionArea('normal',10,10)      --for love2d 11

end

function Brick:hit()

    self.psystem:setColors(
        paletteColors[self.color].r/255,
        paletteColors[self.color].g/255,                        --changed for love2d 11, as colors are between 0 and 1 now
        paletteColors[self.color].b/255,                        --remove /255 from all for love2d 10
        55*(self.tier + 1)/255,
        paletteColors[self.color].r/255,
        paletteColors[self.color].g/255,
        paletteColors[self.color].b/255,
        0
    )
    self.psystem:emit(64)

    gSounds['brick-hit-2']:stop()
    gSounds['brick-hit-2']:play()
    
    if self.tier > 0 then
        if self.color == 1 then
            self.tier = self.tier - 1
            self.color = 5
        else
            self.color = self.color - 1
        end
    else
        if self.color == 1 then
            self.inPlay = false
        else
            self.color = self.color - 1
        end
    end

    if not self.inPlay then
        gSounds['brick-hit-1']:stop()
        gSounds['brick-hit-1']:play()
    end
end

function Brick:update(dt)
    self.psystem:update(dt)
end

function Brick:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'],gFrames['bricks'][1 + ((self.color - 1)*4) + self.tier],self.x, self.y)
    end
end

function Brick:renderParticles()
    love.graphics.draw(self.psystem, self.x + 16, self.y + 8)
end