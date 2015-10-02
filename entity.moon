class entity 
    new: (global, x, y) =>
        @global = global
        @x = x
        @y = y
    every: (n, f) => @global.every @,n,f
    oneshot: (n, f) => @global.oneshot @,n,f
    spawn: (o) => @global.spawn o
    hud: (f) => @global.hud @,f
