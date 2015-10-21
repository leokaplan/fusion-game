phantom = require "phantom"
class lamp extends phantom
    new: (global,x,y,angle,dir,power,r,g,b) =>
        super global,x,y
        @light = @global.lightWorld\newLight @x, @y, r,g,b, power
        @light\setGlowStrength 0
        @light\setGlowSize 0
        @light\setAngle angle
        @light\setDirection dir
        

