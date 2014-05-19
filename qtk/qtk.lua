--
-- v0.1
--
local M = {}

local is_init = false
local debug_level = 0
local label = ""

----
-- init
-- set parameters
----
local function init(opt)
    is_init = true
    label = opt.label
    debug_level = opt.debug_level        
    for i,v in pairs(opt.packages) do
        M[v] = require("qtk."..v)
    end
end
M.init = init

----
-- print debug log
----
local function logger( ... )
    if not is_init then print ("need init first") return false end
    if debug_level == 1 then 
        print(string.format("[%s]",label), ...) 
    end 
end
M.logger = logger

----
-- print error
----
local function error( ... )
    if not is_init then print ("need init first") return false end
    if debug_level <= 2 then 
        print(string.format("[%s]",label), ...) 
    end 
end
M.error = error

return M
