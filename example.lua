-- Caesar UI example (Roblox executor)
-- Load Source.lua however you host it, e.g. loadstring(readfile("Source.lua"))()
local Library = loadstring(readfile("Source.lua"))()

local Window = Library:Window({
    Title = "Caesar",              -- next to the logo
    Subtitle = "v1.0 | Premium",   -- small text under the title
    Logo = "123748867365417",
    Size = UDim2.new(0, 720, 0, 500),
    SidebarWidth = 176,
})

-- Sidebar: Icon | Tab name
Window:Category("Main")
local Combat = Window:Page({ Name = "Combat", Icon = "109391165290124" })
local Visuals = Window:Page({ Name = "Visuals", Icon = "109391165290124" })
Window:Seperator()
local Settings = Window:Page({ Name = "Settings", Icon = "109391165290124" })

-- Sub tabs (each page has its own set now)
local Aimbot = Combat:SubPage({ Name = "Aimbot" })
local Misc = Combat:SubPage({ Name = "Misc" })

local Main = Aimbot:Section({ Name = "Main", Side = "Left" })

local Enabled = Main:Toggle({ Name = "Enable", Flag = "aim_enabled", Callback = function(v) print("enabled", v) end })
-- picker attached to a toggle (swatch + hex box + rainbow in the popup)
Enabled:Colorpicker({ Name = "FOV Color", Flag = "fov_color", Default = Color3.fromRGB(255, 156, 6) })

Main:Slider({ Name = "Smoothness", Flag = "aim_smooth", Min = 0, Max = 100, Default = 42, Suffix = "%" })
Main:Dropdown({ Name = "Hitbox", Flag = "aim_hitbox", Items = { "Head", "Torso", "Legs" }, Default = "Head" })

-- standalone color picker row with live hex readout
local Colors = Aimbot:Section({ Name = "Colors", Side = "Right" })
local Esp = Colors:Colorpicker({
    Name = "ESP Color",
    Flag = "esp_color",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Color, Alpha) print("ESP", Color, Alpha) end,
})
Colors:Button({ Name = "Set ESP to #00FF99", Callback = function() Esp:Set("#00FF99") end })

local MiscSection = Misc:Section({ Name = "Misc", Side = "Left" })
MiscSection:Button({ Name = "Notify", Callback = function() Library:Notification("Caesar", "It works", 3) end })

-- other pages need at least one sub page to host sections
local VisualsMain = Visuals:SubPage({ Name = "Players" })
VisualsMain:Section({ Name = "ESP", Side = "Left" }):Toggle({ Name = "Boxes", Flag = "esp_boxes" })

local SettingsMain = Settings:SubPage({ Name = "Config" })
SettingsMain:Section({ Name = "Menu", Side = "Left" }):Label("Press Z to toggle the menu")
