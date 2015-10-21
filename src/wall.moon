
class wall 
    new: (global,x,y,w,h,c) =>
        @global = global
        @x = x
        @y = y
        @w = w
        @h = h
        @c = c
        @light = @global.lightWorld\newRectangle @x+@w/2, @y+@h/2,@w,@h
    draw: =>
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h
    update: (dt) =>
        return false
    collide: (o) => 
        return false
            
    
wall 
