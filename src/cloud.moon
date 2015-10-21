phantom  = require "phantom"
class sun extends phantom
    new: (global) =>
        super global, math.random(0,global.W), global.H/4
        @sw,@sh = @global.Mcw,@global.Mch
        @ny = math.random(4,10)
        @nx = @ny*2
        @con = {}
        colsize = math.random(1,@ny/2)
        for i=1,@nx do
            @con[i]= {}
            if i<@nx/2 then 
                colsize = math.random(colsize,@ny)
            else
                colsize = math.random(colsize/2,colsize)
            for j=1,colsize do
                @con[i][j] = math.random(1,255)
        @c = {150,150,150}
        @vx = math.random(1,4)*@global.Mcw

    update:(dt) =>
        @x += @vx*dt
        if @x > @global.W then
            @x = 0
    draw: =>
        @\bg ->
            for i=1,#@con do
                for j=1,#@con[i] do
                    love.graphics.setColor 150,150,150,@con[i][j]
                    love.graphics.rectangle "fill", @x+i*@sw, @y-j*@sh, @sw, @sh

