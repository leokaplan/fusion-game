libdir = "../lib/"
cron = require libdir.."cron"
gamera = require libdir.."gamera"
lightWorld = require libdir.."lightworld"
--require "lib/light"

global = {}
global.load = ->
    global.W,global.H = love.window.getDimensions!
    global.Mcw = 10
    global.Mch = 10
    global.level = 0
    global.objs = {}
    global.timers = {}
    global.ui = {}
    global.background = {}
    --global.ground = global.H*7/8
    global.lightWorld = lightWorld!
    global.lightWorld\setAmbientColor 50,50,50
    global.init = (w,h,g) ->
        global.gravity = g or 98*global.Mch
        global.camera = gamera.new 0, 0 , w,h
        global.lightWorld\refreshScreenSize w,h

    global.kind = (o,k) -> 
        if o.__class.__name == k then 
            return true
        else 
            if o.__class.__parent then 
                return global.kind(o.__class.__parent,k)
            else 
                return false
    
    
    
    
    global.every = (o, n, f) -> table.insert global.timers, {o, cron.every n, f}
    global.oneshot = (o, n, f) -> table.insert global.timers, {o, cron.after n, f}
    global.spawn = (o) -> 
        table.insert global.objs, o
        return o
    global.restart = -> 
        print "restart"
        global.level = 0

    global.hud = (o, f) -> table.insert global.ui, {o, f}
    global.bg = (o, f) -> table.insert global.background, {o, f}
    global.draw = ->
        global.camera\draw (l,t,w,h)->
            global.lightWorld\draw ->
                love.graphics.setColor 255, 255, 255
                love.graphics.rectangle "fill", 0, 0, love.window.getWidth!*2, love.window.getHeight!
                --global.lightWorld.update!
                --global.lightWorld.drawShadow!
                for k,v in pairs global.background do 
                        v[2]!
                for i,o in pairs global.objs do 
                    if o.draw then o\draw!
                --global.lightWorld.drawShine!
                --global.lightWorld.drawGlow!
       
        for k,v in pairs global.ui do 
            if v[1].alive then
                v[2]!
            else
                global.ui[k] = nil
    
    
    
    collision = (a,b) -> 
        a.x < b.x + b.w and 
        b.x < a.x + a.w and 
        a.y < b.y + b.h and
        b.y < a.y + a.h 

    global.update = (dt) ->
        if global.level == 0 then
            return true
        if global.camera.locked then
            global.camera.locked global,dt
        global.lightWorld\update dt
        cs = global.camera\getScale!
        cx,cy = global.camera\getPosition!
 --       global.lightWorld\setTranslation (global.lcx-cx)*cs,(global.H-global.lcy-cy)*cs, cs 
   --     global.lcx,global.lcy,global.lcs = cx,cy,cs 
        
        --global.lightWorld\setTranslation cx-global.lx,cy-global.ly, cs-global.ls 
         
        lx = (global.W-2*cs*cx)*(1/cs)
        ly = (global.H-2*cs*cy)*(1/cs)
        global.lightWorld\setTranslation lx,ly,cs 
        for k,v in pairs global.timers do 
            if v[1].alive then
                if v[2]\update dt then
                    global.timers[k] = nil
            else
                global.timers[k] = nil
        
        for i,o in pairs global.objs do
            if o.update and o\update dt then
                global.objs[i] = nil
        for i,o in pairs global.objs do
            for k,v in next,global.objs,i do
                if o and v and o ~= v then
                    if not global.kind(o,"phantom") and not global.kind(v,"phantom") then
                        if collision(o,v) then
                            ro = o\collide v            
                            rv = v\collide o
                            if ro then 
                                global.objs[i] = nil
                                --o = nil
                            if rv then 
                                global.objs[k] = nil
                                --v = nil
global
