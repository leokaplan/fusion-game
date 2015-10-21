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
        @enemies = 0
        --esquerda
        @\create_wall 0, 0, Mcw*2, H
        --direita
        @\create_wall W-Mcw, H/4, Mcw*4, H*3/4
        --chao
        @\create_wall 0,H-Mch,W*3,Mch*10
        --plataforma 1
        @\create_wall 0,H-Mch*12,W*3/4,Mch*2
        @\create_wall W/4,H-Mch*22,W*3/4,Mch*2
        @\create_wall W/2,H-Mch*32,W/2,Mch*2
        @\every 2, ->print "foi"
        if not (@enemies > 3) then
            @\spawn enemy @global,W/4,H-Mch
            @enemies += 1

        spawnh = H-Mch*2
        @\spawn player @global, 20, spawnh
        color_light = {100,100,150}
        @\spawn lamp @global, W/8,0,math.pi/6,math.pi/2,700,unpack color_light
        @\spawn lamp @global, W-Mcw,H-Mch*10,math.pi/2,math.pi,300,unpack color_light
        @\spawn lamp @global, W*3/4,0,math.pi/2,math.pi/2,300,unpack color_light
        @\spawn lamp @global, W/2+Mcw,H-Mch*30,math.pi/2,math.pi/2,300,unpack color_light
        --@\spawn sky @global       
