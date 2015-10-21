
phantom  = require "phantom"
class mountains extends phantom
    new: (global,x) =>
        super global, x, global.H
        @sw,@sh = @global.Mcw,@global.Mch
        @ny = math.random(4,50)
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
                @con[i][j] = true
        @c = {250,150,150}
        @vx = math.random(1,4)*@global.Mcw

    update:(dt) =>
    draw: =>
        @\bg ->
            for i=1,#@con do
                    love.graphics.rectangle "fill", @x+i*@sw, @y-#@con[i]*@sh, @sw, @sh*#@con[i]

