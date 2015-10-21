phantom  = require "phantom"
sun  = require "sun"
cloud  = require "cloud"
mountains  = require "mountains"
class sky extends phantom
    new: (global) =>
        super global,0,0
        @\spawn sun @global
        @\spawn mountains @global,0
        @\spawn mountains @global,@global.W/2
        @\spawn mountains @global,@global.W
        @\spawn mountains @global,@global.W*1.5
        --@\spawn cloud @global
    --a cada x spawn nuvem

