class bullet 
    new: (global,parent,direction=1,color) =>
        @global = global
        @parent = parent
        @x = @parent\canonx!
        @y = @parent\canony!
        @w = 1*@global.Mcw
        @h = 1*@global.Mch
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
