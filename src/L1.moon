level  = require "level"
player  = require "player"
enemy  = require "enemy"
boss  = require "boss"
sky  = require "sky"
text  = require "text"
button  = require "button"
lamp  = require "lamp"
class L1 extends level
    new: (global) => 
        super global
        W,H,Mcw,Mch = @global.W,@global.H,@global.Mcw,@global.Mch
        @global.init W,H 
        --esquerda
        @\create_wall 0, 0, @global.Mcw*2, @global.H
        --direita
        @\create_wall @global.W-@global.Mcw, 0, @global.Mcw*4, @global.H/4
        @\create_wall @global.W-@global.Mcw, @global.H/2, @global.Mcw*4, @global.H/2
        --chao
        @\create_wall 0,@global.H-@global.Mch,@global.W*3,@global.Mch*10
        --plataforma
        @\create_wall @global.W/2,3*@global.H/4,@global.W/4,@global.Mch*2
        
        spawnh = @global.H*7/10
        @\spawn player @global, 20, spawnh
        @\spawn boss @global,@global.W*8/5,spawnh,
            => 
                @global.camera.locked = nil
        @\spawn button @global,@global.W,0,30,@global.H,
            (o) =>
                if @global.kind(o,"player") then
                    @global.camera.locked = (global,dt) ->
                        cs = global.camera\getScale()
                        cx,cy = global.camera\getPosition()
                        global.camera\setScale(cs + (1-cs)*dt)    
                        global.camera\setPosition(cx+(global.W+20-cx)*dt,cy+(global.H/2-cy)*dt)
                    return true
        text1 = @\spawn text @global,"bla",40,@global.H/2
        @\spawn button @global,100,0,10,@global.H,(o)=> 
            if @global.kind(o,"player") then
                text1.text = "alb"
                @\spawn enemy @global,@global.W*8/10,spawnh
        @\spawn lamp @global, @global.W/2,0,math.pi/2,math.pi/2,700,250,100,150
        --@\spawn sky @global       
