local M = {}

local sqlite3 = require( "sqlite3" )
local qtk = require("qtk.qtk")
local qtk_io = require("qtk.io")

local db = nil

----
-- connect database
----
local function connect_db(fname)
    qtk.logger("db| connect_db")

    if fname == "" then qtk.error("db| no db name") return nil end

    local dbpath = system.pathForFile( fname, system.DocumentsDirectory )
    local file, errStr = io.open( dbpath, "r" )

    if not file then
        qtk_io.copyFile_RD(fname, fname)
    end
    
    local path = system.pathForFile(fname, system.DocumentsDirectory)
    db = sqlite3.open( path )

    local function onSystemEvent( event )
        if( event.type == "applicationExit" ) then
            if db ~= nil then
                db:close()
            end
        end
    end

    Runtime:addEventListener( "system", onSystemEvent )
    return db    
end
M.connect_db = connect_db

----
-- execute sql
----
local function query(sql)
    qtk.logger("db| query: ", sql)

    if not db then qtk.error("db| db is not connect yet!") end

    return db:exec(sql)
end
M.query = query

----
-- get result in rows (table)
----
local function rows(sql)
    qtk.logger("db| rows: ", sql)

    if not db then qtk.error("db| db is not connect yet!") end
    local rows = {}
    for i in db:nrows(sql) do
        table.insert(rows, i)
    end
    return rows
    
end
M.rows = rows

----
-- get only one result
----
local function first(sql)
    qtk.logger("db| first: ", sql)

    if not db then qtk.error("db| db is not connect yet!") end
    for i in db:nrows(sql) do
        return i
    end
end
M.first = first

return M