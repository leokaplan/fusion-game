actor  = require "actor"
class player extends actor 
    
    new: (global,x,y) =>
        super global, x, y, 2, 8
        @vy = 0
        @walk_speed = @global.Mcw
        @jump_power = @h*2 
        -- distance from feet to ground on the top of the jump parabole
        @control = {
            a:  -> @\walk_left!
            w:  -> @\jump!
            s:  -> @\shoot!
            f:  -> @\guard!
            d:  -> @\walk_right!
            e:  -> @life += 1
        }
        @\every 0.1, -> @\action!
        @bulletcolor = {250,50,50}
        @in_ground = false
        @cooldown = false
        @onguard = false
        @alive = true
        @life = 5
    
    canonx: => @x + @w/2
    canony: => @y + @h/2 

    draw: =>
        @\hud ->
            love.graphics.setColor 255, 0,0
            love.graphics.rectangle "fill", 0, 0,@life*@global.Mcw , 1*@global.Mch
        if not @onguard then
            @c = {100,100,100}
        else
            @c = {100,200,200}
        love.graphics.setColor @c
        love.graphics.rectangle "fill", @x, @y, @w, @h
        if @dir == 1 then
            love.graphics.rectangle "fill", @\canonx!, @\canony!, @w, @global.Mch
        else
            love.graphics.rectangle "fill", @\canonx!-@w, @\canony!, @w, @global.Mch


    update: (dt) =>
        --print @x,@y
        @global.camera\setScale(1.5-@life/10)
        cx,cy = @global.camera\getPosition()
        @global.camera\setPosition(cx +(@x-cx)*dt,cy +(@y-cy)*dt)
        @y -= @vy*dt
        @vy -= @global.gravity*dt
        if @life <= 0 then
            @global.restart!
        return false
    action: =>
        if not @onguard then
            for k,v in pairs @control do 
                if love.keyboard.isDown k then 
                    v!
    
    collide: (o) =>
        --print @\checkcol o
        @\block(o,{"wall","enemy"})
        if o.__class.__name == "bullet" then
            if not (o.parent.__class.__name == "player") then
                if not @onguard then
                    @life -= 1
                    o.alive = false
        return false
    
player
