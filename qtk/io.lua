local M = {}

local qtk = require("qtk.qtk")

----
-- 將資料由 Resource 夾子 copy 到 Documents 夾子
----
local function copyFile_RD( srcName, dstName )
    qtk.logger("io: copy file from Resource to Documents", srcName, dstName)
    local results = true                -- assume no errors

    -- Copy the source file to the destination file
    --
    local rfilePath = system.pathForFile( srcName, system.ResourceDirectory )
    local wfilePath = system.pathForFile( dstName, system.DocumentsDirectory )

  -- print(rfilePath,wfilePath) -- android 系統時，圖檔會出錯 
    local rfh = io.open( rfilePath, "rb" )
    local wfh = io.open( wfilePath, "wb" )

    if not wfh then
        qtk.logger( "io| copyFile::writeFileName open error!" )
        results = false                 -- error
    else
        -- Read the file from the Resource directory and write it to the destination directory
        local data = rfh:read( "*a" )
    
        if not data then
            qtk.logger( "io| copyFile::read error!" )
            results = false     -- error
        else
            if not wfh:write( data ) then
                qtk.logger( "io| copyFile::write error!" )
                results = false -- error
            end
        end
    end

    -- Clean up our file handles
    rfh:close()
    wfh:close()

    return results
end
M.copyFile_RD = copyFile_RD

return M