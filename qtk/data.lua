local M = {}

local json = require("json")

local qtk = require("qtk.qtk")

----
-- split string in list
----
local split = function(s, sep)
    if s == nil then qtk.error("str|split: no string") return nil end
    if sep == nil then qtk.error("str|split: no seperater") return nil end

    local t = {}
    local _beg = 0
    local _end = 0
    local sep_n = #sep
    -- TODO: 其他的也要處理
    if string.find(sep, "%%") then sep_n = sep_n - 1 end

    _end = string.find(s, sep)
    while _end ~= nil do
        table.insert(t, string.sub(s, _beg, _end-sep_n))
        _beg = _end + sep_n
        _end = string.find(s, sep, _beg+sep_n)
    end
    table.insert(t, string.sub(s, _beg, #s))

    return t
end
M.split = split

----
-- strip blank from beginning and end
----
local function strip(s)
    return s:match( "^%s*(.-)%s*$" )
end
M.strip = strip

----
-- shuffle table values
----
local function shuffle(t, seed)
    if seed ~= nil then
        -- prevent same os.time()
        math.randomseed(os.time() + tonumber(seed))
    else
        math.randomseed(os.time())        
    end

    assert(t, "table.shuffle() expected a table, got nil")
    local iterations = #t
    local j
    for i = iterations, 2, -1 do
        j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end
M.shuffle = shuffle


----
-- print_r
-- via: 
--   https://developer.coronalabs.com/code/printr-implementation-dumps-everything-human-readable-text
----
local function print_r(t)
    print(json.encode(t))
end
M.print_r = print_r


return M