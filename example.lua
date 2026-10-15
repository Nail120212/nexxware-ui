-- Caesar UI example (Roblox executor)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nail120212/nexxware-ui/refs/heads/main/Source.lua"))()

local Window = Library:Window({
    Title = "Dash Hub",              -- next to the logo
    Subtitle = "vbl",   -- small text under the title
    Logo = "123748867365417",      -- asset id, rbxassetid://..., or a solar icon name
    Size = UDim2.new(0, 720, 0, 500),
    Scale = 1,                     -- start scale (0.6 - 1.5), changeable with the header scale button
    Accent = Color3.fromRGB(88, 122, 255), -- optional: any color recolors the whole UI (also Library:SetAccent(color))
    OnClose = function() print("UI closed") end,
})

-- Icons: just the Solar name ("home", "bolt", "eye", "settings" ...). Style defaults to bold;
-- change it with Library.IconStyle = "linear" | "outline" | "bold-duotone" before creating pages.
Window:Category("Main")
local Combat = Window:Page({ Name = "Combat", Icon = "bolt" })
local Visuals = Window:Page({ Name = "Visuals", Icon = "eye" })
Window:Seperator()
local Settings = Window:Page({ Name = "Settings", Icon = "settings" })

---------------------------------------------------------------- Combat
local Aimbot = Combat:SubPage({ Name = "Aimbot" })
local Misc = Combat:SubPage({ Name = "Misc" })

local Main = Aimbot:Section({ Name = "Main", Side = "Left" })

-- Toggle is now a sliding knob switch
local Enabled = Main:Toggle({ Name = "Enable", Flag = "aim_enabled", Callback = function(v) print("enabled", v) end })
Enabled:Colorpicker({ Name = "FOV Color", Flag = "fov_color", Default = Color3.fromRGB(255, 156, 6) })

Main:Slider({ Name = "Smoothness", Flag = "aim_smooth", Min = 0, Max = 100, Default = 42, Suffix = "%" })
Main:Dropdown({ Name = "Hitbox", Flag = "aim_hitbox", Items = { "Head", "Torso", "Legs" }, Default = "Head" })

-- Input / textbox (Textbox still works as an alias)
Main:Input({
    Name = "Target name",
    Placeholder = "Search player...",
    Icon = "magnifer",          -- solar name; falls back to the default icon if the name doesn't exist
    Callback = function(Text) print("target:", Text) end,
})
Main:Input({ Name = "FOV size", Placeholder = "100", Numeric = true, MaxLength = 4, Default = "100", Flag = "fov_size" })

local Colors = Aimbot:Section({ Name = "Colors", Side = "Right" })
local Esp = Colors:Colorpicker({ -- standalone picker with hex box + live hex readout
    Name = "ESP Color", Flag = "esp_color", Default = Color3.fromRGB(255, 0, 0),
    Callback = function(Color, Alpha) print("ESP", Color, Alpha) end,
})
Colors:Button({ Name = "Set ESP to #00FF99", Callback = function() Esp:Set("#00FF99") end })

-- Cards: image on any side, buttons at the bottom / right / inline
local Cards = Aimbot:Section({ Name = "Cards", Side = "Right" })

Cards:Card({
    Title = "Auto Farm",
    Description = "Farms nearby mobs and collects drops automatically.",
    Image = "bolt",
    ImagePosition = "Left",
    Buttons = {
        { Name = "Start", Style = "primary", Callback = function() print("start") end },
        { Name = "Config", Callback = function() print("config") end },
    },
})

Cards:Card({
    Title = "Premium",
    Description = "Image on the right, button next to the text.",
    Image = "crown",
    ImagePosition = "Right",
    ButtonPosition = "Right",
    Buttons = { { Name = "Upgrade", Style = "primary", Callback = function() print("upgrade") end } },
})

Cards:Card({
    Title = "News",
    Description = "Banner on top (use a rbxassetid photo here, ImageFit = false crops it).",
    Image = "bell",
    ImagePosition = "Top",
    ImageSize = 70,
    ButtonPosition = "Inline",
    ButtonAlignment = "Left",
    Buttons = { { Name = "Read more", Callback = function() print("read") end } },
})

local MiscSection = Misc:Section({ Name = "Misc", Side = "Left" })
MiscSection:Button({ Name = "Notify", Callback = function() Library:Notification("Caesar", "It works", 3) end })
MiscSection:Button({
    Name = "Show dialog",
    Callback = function()
        Library:Dialog({
            Parent = Window.Items["MainFrame"],
            Title = "Reset settings?",
            Description = "This restores every option to its default.",
            Buttons = {
                { Name = "Cancel" },
                { Name = "Reset", Style = "danger", Callback = function() print("reset") end },
            },
        })
    end,
})

---------------------------------------------------------------- other pages (each needs a sub page)
local VisualsMain = Visuals:SubPage({ Name = "Players" })
VisualsMain:Section({ Name = "ESP", Side = "Left" }):Toggle({ Name = "Boxes", Flag = "esp_boxes" })

local SettingsMain = Settings:SubPage({ Name = "Config" })
SettingsMain:Section({ Name = "Menu", Side = "Left" }):Label("Press Z to toggle the menu")

-- Header buttons: [scale] [minimize -> floating button] [close -> confirm dialog]
-- Window:SetScale(1.1)   Window:SetMinimized(true)   Window:Close()   Window:SetTitle("New", "Subtitle")
