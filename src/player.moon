actor  = require "actor"
bullet = require "bullet"
anim8 = require "lib/anim8"
class player extends actor 
    
    new: (global,x,y) =>
        super global, x, y, 2, 8
        @vy = 0
        @walk_speed = @global.Mcw
        @jump_power = @h 
        -- distance from feet to ground on the top of the jump parabole
        @control = {
            a:  {hold:->@\walk_left!}
            d:  {hold:->@\walk_right!}
            w:  {press:-> @\jump!}
            s:  {press:-> @\shoot!}
            f:  {press:-> @\guard!}
            e:  {press:-> @life += 1}
            z:  {press:-> print @x,@y}
        }
        @\every 0.1, -> @\action!
        @bulletcolor = {250,50,50}
        @in_ground = false
        @cooldown = false
        @onguard = false
        @impulse = false
        @alive = true
        @life = 5
        @key = {}
        @light = @global.lightWorld\newRectangle @x+@w/2, @y+@h/2,@w,@h
        
        @image = love.graphics.newImage "assets/samus.gif"
        @framew, @frameh = 26, 32
        grid = anim8.newGrid @framew, @frameh, @image\getWidth!, @image\getHeight!,@image\getWidth!/2
        walk = grid "1-8",1
        @anim = anim8.newAnimation walk, 0.1
    canonx: => @x + @w/2
    canony: => @y + @h/2 
    spawn_bullet: =>
        @\spawn bullet @global, @, @dir,@bulletcolor

    draw: =>
        --@anim\draw @image, @x, @y,0,@w/@framew, @h/@frameh
        @\hud ->
            love.graphics.setColor 255, 0,0
            love.graphics.rectangle "fill", 0, 0,@life*@global.Mcw , 1*@global.Mch
        if not @onguard then
            @c = {100,100,100}
        else
            @c = {100,200,200}
        love.graphics.setColor @c
        --love.graphics.rectangle "fill", @x, @y, @w, @h
        if @dir == 1 then
            love.graphics.rectangle "fill", @\canonx!, @\canony!, @w, @global.Mch
        else
            love.graphics.rectangle "fill", @\canonx!-@w, @\canony!, @w, @global.Mch


    update: (dt) =>
        --print @x,@y
        --@anim\update dt
        if not @global.camera.locked then
            if @onguard then
                cs = @global.camera\getScale()
                @global.camera\setScale(cs +(1.8-cs)*dt*3)
                cx,cy = @global.camera\getPosition()
                @global.camera\setPosition(cx +(@x-cx)*dt*10,cy +(@y-cy)*dt*10)
                --@global.camera\setPosition(@x,@y)
            else
                cs = @global.camera\getScale()
                @global.camera\setScale(cs + (1.5-@life/10-cs)*dt*3)
                cx,cy = @global.camera\getPosition()
                @global.camera\setPosition(cx +(@x-cx)*dt,cy +(@y-cy)*dt)
        @y -= @vy*dt
        @vy -= @global.gravity*dt
        @light\setPosition @x+@w/2,@y+@h/2
        if @life <= 0 then
            @global.restart!
        return false
    action: =>
        if not @onguard then
            for k,v in pairs @control do 
                if (love.keyboard.isDown k) then
                    if v.hold then v.hold!
                    if not @key[k] then 
                        @key[k] = true
                        if v.press then v.press!
                else
                    if @key[k] then
                        if v.release then v.release!
                        @key[k] = false
    
    collide: (o) =>
        --print @\checkcol o
        @\block(o,{"wall","enemy","boss"})
        if o.__class.__name == "bullet" then
            if not (o.parent.__class.__name == "player") then
                if not @onguard then
                    
                    @life -= 1
                    o.alive = false
        return false
    
player
