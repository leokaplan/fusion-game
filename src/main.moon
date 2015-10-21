global = require "global"
--L1 = require "L_tuto1"
L1 = require "L1"
love.load = ->
    math.randomseed os.time!
    global.load!
    global.level = 1
    L1 global 
love.draw = -> global.draw!
love.update = (dt) -> 
    if global.update dt then 
       love.load! 
    

