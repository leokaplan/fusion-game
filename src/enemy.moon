actor  = require "actor"
bullet = require "bullet"
class enemy extends actor  
    die: =>
        @alive = false 
    
    new: (global,x,y) =>
        super global, x, y, 4, 8
        @vy = 0
        @walk_speed = @global.Mcw
        @jump_power = 4*@global.Mch
        -- distance from feet to ground on the top of the jump parabole
        @dir = -1
        @control = {
            {7,-> @\walk_left!}
            {4,-> @\walk_right!}
            {0,-> @\jump!}
            {3,-> @\shoot!}
            {0,-> @\guard!}
        }
        @controlsum = 0 
        for k,v in pairs @control do 
            @controlsum += v[1]
        @\every 0.1, -> @\action!

    canonx: => @x + @w/2
    canony: => @y + @h/2 
    spawn_bullet: =>
        @\spawn bullet @global, @, @dir,@bulletcolor

    draw: => 
        if not @onguard then
            @c = {150,100,100}
        else
            @c = {200,100,200}
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h
        if @dir == 1 then
            love.graphics.rectangle "fill", @\canonx!, @\canony!, @w, @global.Mch
        else
            love.graphics.rectangle "fill", @\canonx!-@w, @\canony!, @w, @global.Mch



    update: (dt) =>
        if not @alive then
            return true
        @y -= @vy*dt
        @vy -= @global.gravity*dt
        return false
    action: =>
        if not @onguard then
            
            comm = math.random(1,@controlsum)
            count = 1
            for k,v in pairs @control do
                if comm >= count and comm < count + v[1] then
                    @control[k][2]!
                else
                    count += v[1]
    collide: (o) =>
        @\block(o,{"wall","enemy"})
        if o.__class.__name == "bullet" and o.parent.__class.__name == "player" then
            @alive = false
            return true
        --print @@.__name, o.__class.__name
enemy
