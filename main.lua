local qtk = require("qtk.qtk")

local options = {
    label = "test",
    debug_level = 1, -- 0: show nothing, 1: show debug, 2: only error
    packages = {"db", "data"}
}
qtk.init(options)


---- basic

-- debug 
qtk.logger('hello')

-- show info
qtk.info()

---- DB
--local gdb = qtk.db.connect_db("YOURDB.sql")
--local r2 = qtk.db.rows("SQL QUERY")
--for i,v in ipairs(r2) do print (i,v.content ) end


local t = {
    foo="abc",
    bar={
        gamela="ooo",
        gozilla="zzz"
    }
}

print(qtk.data.print_r(t))
