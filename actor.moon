entity  = require "entity"
bullet = require "bullet"
class actor extends entity
    walk_right: =>
        @dir = 1
        @\walk_forward!
    walk_left: => 
        @dir = -1
        @\walk_forward!
    walk_forward: => 
        @x += @walk_speed*@dir
    walk_back: => 
        @x -= @walk_speed*@dir
    shoot: => 
        if not @cooldown then 
            @spawn bullet @global, @, @dir,@bulletcolor
            @cooldown = true
            @\oneshot 0.3, -> @cooldown = false
    jump: => 
        if @in_ground then
            @vy = math.sqrt(@jump_power*@global.gravity*2) -- -@x
            @in_ground = false
    guard:  => 
        if not @onguard then 
            @c = {}
            @onguard = true
            @\oneshot 0.5, -> @onguard = false
    checkcol: (o) => 
        left = o.x < @x + @w and @x + @w < o.x +o.w 
        right = o.x < @x and @x < o.x +o.w 
        up = o.y < @y + @h and @y + @h < o.y +o.h 
        down = o.y < @y and @y < o.y +o.h 
        return left, right, up, down
    block: (o,t) =>
        left, right, up, down = @\checkcol o
        for k,v in pairs t do 
            if o.__class.__name == v then
                if right or left then
                    if up and down or not (up or down)then
                        @\walk_back!
                    elseif up then
                        @vy = 0
                        @y = o.y - @h
                        @in_ground = true
                    elseif down then
                        @vy = 0
                        @y = o.y + o.h
    new:(global, x, y, w, h) =>
        super global, x, y
        @w = w*@global.Mcw
        @h = h*@global.Mch
        @dir = 1
        @bulletcolor = {200,100,200}
        @cooldown = false
        @in_ground = false
        @onguard = false
        @alive = true
