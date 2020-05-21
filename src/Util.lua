--[[
    Utility file that contains functions 
    to generate quads with regards to our spritesheet
    (main texture)
]]

function GenerateQuads(atlas, tilewidth, tileheight)

    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetcounter = 1  --indexing starts from 1 in lua
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetcounter] = love.graphics.newQuad(
                x * tilewidth, 
                y * tileheight,
                tilewidth, 
                tileheight, 
                atlas:getDimensions())
            sheetcounter = sheetcounter + 1
        end
    end

    return spritesheet
end

function table.slice(tbl, first, last, step)
    sliced = {}
    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced + 1] = tbl[i]
    end
    return sliced
end

--[[
    Another function to generate sprite sheets for paddles since
    they come in different sizes and skins
]]

function GenerateQuadsPaddles(atlas)

    local x = 0
    local y = 64       --since the paddles start from y = 64

    local counter = 1
    local quads = {}

    for i = 0, 3 do
        quads[counter] = love.graphics.newQuad(x, y, 32, 16, atlas:getDimensions())
        counter = counter + 1

        quads[counter] = love.graphics.newQuad(x + 32, y, 64, 16, atlas:getDimensions())
        counter = counter + 1

        quads[counter] = love.graphics.newQuad(x + 96, y, 128, 16, atlas:getDimensions())
        counter = counter + 1

        quads[counter] = love.graphics.newQuad(x, y + 16, 256, 16, atlas:getDimensions())
        counter = counter + 1

        x = 0
        y = y + 32
    end

    return quads;
end