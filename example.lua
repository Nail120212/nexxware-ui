-- CSoul UI example (Roblox executor)
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nail120212/nexxware-ui/refs/heads/main/Source.lua"))()

local Window = Library:Window({
    Title = "CSoul UI",              -- next to the logo
    Subtitle = "v1.0 | Premium",   -- small text under the title
    Logo = "123748867365417",      -- asset id, rbxassetid://..., or a solar icon name
    Size = UDim2.new(0, 720, 0, 500),
    Scale = 1,                     -- start scale (0.6 - 1.5), changeable with the header scale button
    Accent = Color3.fromRGB(100, 100, 108), -- first-run default (neutral gray). Users change it in Home > Interface and it is remembered
    OnClose = function() print("UI closed") end,
})

-- Tags next to the title: text, icon, color, radius are all optional/customizable
local Beta = Window:Tag({ Text = "BETA", Icon = { "verified-check", "star" }, Color = Color3.fromRGB(200, 200, 210) })
Window:Tag({ Text = "VIP", Color = Color3.fromRGB(255, 190, 60), Radius = 0.2 }) -- Radius: 0.2 = scale (default), or pixels like 4
-- Beta:SetText("NEW")  Beta:SetColor(Color3.fromRGB(255, 80, 80))  Beta:SetIcon("bolt")  Beta:SetRadius(3)

-- Player box (bottom of the sidebar) is automatic: avatar + display name + @username.
-- Override it with  PlayerBox = { Name = "Nail", Username = "nail", Avatar = "rbxassetid://...", Status = Color3.fromRGB(255, 180, 0) }
-- or turn it off with PlayerBox = false in Library:Window{}.
-- Config manager = the folder button in the header (create / load / save / delete / export / import / autoload).

-- Icons: just the Solar name ("home", "bolt", "eye", "settings" ...) or a list of candidates: the first one that exists wins. Style defaults to bold;
-- change it with Library.IconStyle = "linear" | "outline" | "bold-duotone" before creating pages.
Window:Category("Main")
local Combat = Window:Page({ Name = "Combat", Icon = { "target", "crosshair", "bolt" } })
local Visuals = Window:Page({ Name = "Visuals", Icon = { "eye", "eye-scan" } })
Window:Seperator()
local Settings = Window:Page({ Name = "Settings", Icon = { "gamepad", "settings" } })

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
    Icon = { "magnifer", "magnifer-zoom-in" },          -- solar name; falls back to the default icon if the name doesn't exist
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
    Image = { "bolt-circle", "bolt" },
    ImagePosition = "Left",
    Buttons = {
        { Name = "Start", Style = "primary", Callback = function() print("start") end },
        { Name = "Config", Callback = function() print("config") end },
    },
})

Cards:Card({
    Title = "Premium",
    Description = "Image on the right, button next to the text.",
    Image = { "crown-star", "crown" },
    ImagePosition = "Right",
    ButtonPosition = "Right",
    Buttons = { { Name = "Upgrade", Style = "primary", Callback = function() print("upgrade") end } },
})

Cards:Card({
    Title = "News",
    Description = "Banner on top (use a rbxassetid photo here, ImageFit = false crops it).",
    Image = { "bell-bing", "bell" },
    ImagePosition = "Top",
    ImageSize = 70,
    ButtonPosition = "Inline",
    ButtonAlignment = "Left",
    Buttons = { { Name = "Read more", Callback = function() print("read") end } },
})

local MiscSection = Misc:Section({ Name = "Misc", Side = "Left" })
MiscSection:Button({ Name = "Notify", Callback = function() Library:Notification("CSoul UI", "It works", 3) end })
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

-- ============================================================ Quick action bar (top right, draggable)
-- Link components you already made (by Flag), or create standalone ones. Pinned by default.
Window:QuickAction({ Name = "Aimbot", Type = "Toggle", Flag = "aim_enabled" })
Window:QuickAction({ Name = "Smoothness", Type = "Slider", Flag = "aim_smooth", Min = 0, Max = 100, Suffix = "%" })
Window:QuickAction({ Name = "Hitbox", Type = "Dropdown", Flag = "aim_hitbox", Items = { "Head", "Torso", "Legs" } })
Window:QuickAction({ Name = "Fly", Type = "Toggle", Callback = function(v) print("fly", v) end })       -- own state
Window:QuickAction({ Name = "Rejoin", Type = "Button", Callback = function() print("rejoin") end })
-- Every Toggle / Button / Slider / Dropdown you create is ALSO pinnable by the user:
-- Home > Quick bar > "Pinned actions" (switch on what should show on the bar).

-- ============================================================ Home (automatic, always the first tab, happy-face icon)
-- Sub tab "Overview": welcome card with the player avatar + info (name, username, id, account age, membership, executor)
-- and six live cards, each with an image: game (game icon), FPS, ping, server players, session time, memory.
-- The other sub tabs are the settings: Interface (transparency, scale, corners, animation, accent), Keybinds,
-- Quick bar, System. Everything is saved to zoophack/ui_settings.json.
-- Rename it:  SettingsName = "Dashboard"   Icon:  SettingsIcon = "home-smile"   Disable:  UISettings = false   No bar:  QuickBar = false
-- Config manager (folder button in the header): create / load / save / delete, Copy JSON, Paste JSON, "Save .json" file
-- (written to workspace/zoophack/exports/<name>.json), and autoload.

-- Loads the config you marked "Autoload" in the config manager. Call it after the whole UI is built.
Library:LoadAutoConfig()
