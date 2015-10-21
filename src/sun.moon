phantom  = require "phantom"
class sun extends phantom
    new: (global) =>
        super global, 0, global.H/4
        @w,@h = 5*@global.Mcw,5*@global.Mch
        @c = {50,150,150}
        @vx = 0.5*@global.Mcw
    update:(dt) =>
        @x += @vx*dt
        if @x > @global.W then
            @x = 0
    draw: =>
        @\bg ->
            love.graphics.setColor @c
            love.graphics.rectangle "fill", @x, @y, @w, @h

