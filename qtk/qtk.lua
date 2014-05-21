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

----
-- show system.getInfo
----
local function info()
    print("========= display info =========")
    print(string.format("pixel: %dx%d, ratio: %.02f", 
                        display.pixelWidth,
                        display.pixelHeight,
                        display.pixelHeight/display.pixelWidth))
    print(string.format("content: %dx%d, ratio: %.02f", 
                        display.contentWidth,
                        display.contentHeight,
                        display.contentHeight/display.contentWidth))
    print(string.format("actual: %dx%d",
                        display.actualContentWidth,
                        display.actualContentHeight
                        ))
    print(string.format("scale: (%.02f, %.02f)",
                         display.contentScaleX,
                         display.contentScaleY
                        ))
    print(string.format("origin: (%d, %d)",
                         display.screenOriginX,
                         display.screenOriginY
                        ))
    print("-------- system.getInfo --------")
    local prop = {
        "model",
        "platformName",
        "platformVersion",
        "environment",
        "architectureInfo",
        "build",
        "name",
        "appname",
        "appVersionString",
        "deviceID",
        "maxTexturueSize",
        "maxTextureUnits",
        "textureMemoryUsed",
        "targetAppStore",
        "iosAdvertisingIdentifier",
        "iosAdvertisingTrackingEnabled",
        "iosIdentifierForVendor",
        "androidDisplayApproximateDpi",
        "androidDisplayDensityName",
        "androidDisplayXDpi",
        "androidDisplayYDpi",
    }
    for _,v in pairs(prop) do
        print (string.format("%s: %s", v, system.getInfo(v) or "nil"))
    end
    print("--------- language ----------")
    print(string.format("locale.country: %s", 
                        system.getPreference( "locale", "country" )))
    print(string.format("locale.idettifier: %s",
                        system.getPreference( "locale", "identifier" )))
    print(string.format("locale.language: %s",
                        system.getPreference( "locale", "language" )))
    print(string.format("ui.language: %s",
                        system.getPreference( "ui", "language" )))
    print("===============================")
end
M.info = info

return M
