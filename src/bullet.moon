actor  = require "actor"
class bullet extends actor
    new: (global,x,y,parent,direction=1,color) =>
        @parent = parent
        super global, x,y,1,1
        @speed = 30*@global.Mcw*direction
        @c = color
        @alive = true
    draw: =>
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h


    update: (dt) =>
        @x += @speed*dt
        if not @alive then
            return true
        return false
    collide: (o) => 
        if o.__class.__name == "wall" then
            return true
            
    
bullet 
