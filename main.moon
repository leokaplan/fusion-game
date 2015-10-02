cron = require "cron"
gamera = require "gamera"
player  = require "player"
wall  = require "wall"
enemy  = require "enemy"

createwall = (x,y,w,h) -> print "wall" 
init_enemyspawner = (n,x,y) -> global.every n, -> global.spawn enemy global,x,y

love.load = ->
    W,H = love.window.getDimensions!
    export global = {}
--    global.world = love.physics.newWorld 0, 0, true
    global.Mcw = 10
    global.Mch = 10
    global.objs = {}
    global.timers = {}
    global.ui = {}
    global.gravity = 98*global.Mch
    global.ground = H*7/8
    global.camera = gamera.new 0, 0 , 2*W,H
--    createwall W/2, 0,   W,  10
--    createwall W/2, H,   W,  10
--    createwall W,   H/2, 10, H
--    createwall 0,   H/2, 10, H

    global.every = (o, n, f) -> table.insert global.timers, {o, cron.every n, f}
    global.oneshot = (o, n, f) -> table.insert global.timers, {o, cron.after n, f}
    global.spawn = (o) -> table.insert global.objs, o
    global.restart = -> print "restart"
    global.hud = (o, f) -> table.insert global.ui, {o, f}
    --esquerda
    global.spawn wall global,0,0,global.Mcw*2,H,{100,200,100}
    --direita
    global.spawn wall global,W-global.Mcw,0,global.Mcw*4,H/4,{100,200,100}
    global.spawn wall global,W-global.Mcw,H/2,global.Mcw*4,H/2,{100,200,100}
    --chao
    global.spawn wall global,0,H-global.Mch,W,global.Mch*10,{100,200,100}
    --chao
    global.spawn wall global,W,H-global.Mch,W,global.Mch,{100,200,100}
    --plataforma
    global.spawn wall global,W/2,3*H/4,W/4,global.Mch*2,{100,200,100}
    
    spawnh = H*7/10
    global.spawn player global, 20, spawnh
--    init_enemyspawner 5, W*8/10, spawnh
    global.spawn enemy global,W*8/10,spawnh

love.draw = ->
    for k,v in pairs global.ui do 
        if v[1].alive then
            v[2]!
        else
            global.ui[k] = nil
    global.camera\draw (l,t,w,h)->
        for i,o in pairs global.objs do 
            o\draw!
    
collision = (a,b) -> 
    a.x < b.x + b.w and 
    b.x < a.x + a.w and 
    a.y < b.y + b.h and
    b.y < a.y + a.h 

love.update = (dt) ->
    for k,v in pairs global.timers do 
        if v[1].alive then
            if v[2]\update dt then
                global.timers[k] = nil
        else
            global.timers[k] = nil
    for i,o in pairs global.objs do
        if o\update dt then
            global.objs[i] = nil
           -- o = nil
    for i,o in pairs global.objs do 
        for k,v in next, global.objs, i do
            if o and v and o ~= v then
                if collision(o,v) then
                    ro = o\collide v            
                    rv = v\collide o
                    if ro then 
                        global.objs[i] = nil
                        --o = nil
                    if rv then 
                        global.objs[k] = nil
                        --v = nil
