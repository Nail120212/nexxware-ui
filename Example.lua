--[[
    Nexxware Full Example
    Raw: https://raw.githubusercontent.com/Nail120212/nexxware-ui/refs/heads/main/Library.lua
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nail120212/nexxware-ui/refs/heads/main/Library.lua"))()

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
    Title = "Nexxware",
    Footer = "Left/Right Groupboxes × WindUI visuals",
    Icon = 95816097006870,
    NotifySide = "Right",
    ShowCustomCursor = true,
    Center = true,
    AutoShow = true,
    Resizable = true,
    ShowMobileButtons = true,
})

local Tabs = {
    Main     = Window:AddTab("Main", "house"),
    Combat   = Window:AddTab("Combat", "swords"),
    Visuals  = Window:AddTab("Visuals", "eye"),
    Player   = Window:AddTab("Player", "user"),
    Settings = Window:AddTab("Settings", "settings"),
}

-- ===================== MAIN =====================
local Left = Tabs.Main:AddLeftGroupbox("General", "boxes")
local Right = Tabs.Main:AddRightGroupbox("Extra", "settings")

Left:AddToggle("Enabled", { Text = "Enable", Default = false, Callback = function(v) print("Enable:", v) end })
Left:AddSlider("Speed", { Text = "Speed", Default = 16, Min = 16, Max = 200, Rounding = 0 })
Left:AddDropdown("Mode", { Values = {"Normal", "Aggressive", "Safe", "Custom"}, Default = 1, Text = "Mode" })
Left:AddInput("Target", { Text = "Target", Default = "", Placeholder = "Name..." })

Left:AddDivider()
Left:AddTag("New", Color3.fromRGB(250, 204, 21))          -- yellow solid
Left:AddTag("Stable", Color3.fromRGB(74, 222, 128))       -- green solid
Left:AddTag("Beta", Color3.fromRGB(167, 139, 250), "tag") -- violet + icon

Left:AddSection("Details", true)
Left:AddParagraph("Info", "Collapsible section + paragraph + solid tags + code.")
Left:AddCode([[print("Nexxware")
local v = 42
print(v * 2)]])

Left:AddButton({
    Text = "Run",
    Func = function()
        Library:Notify({ Title = "Nexxware", Description = "Executed", Time = 3 })
    end
})

Right:AddToggle("Auto", { Text = "Auto Mode", Default = true })
Right:AddSlider("Delay", { Text = "Delay", Default = 1.4, Min = 0.1, Max = 5, Rounding = 1, Suffix = "s" })
Right:AddLabel("Status: Ready")
Right:AddDivider()
Right:AddButton({ Text = "Unload", Func = function() Library:Unload() end })

-- ===================== COMBAT =====================
local CombatLeft = Tabs.Combat:AddLeftGroupbox("Aimbot", "crosshair")
local CombatRight = Tabs.Combat:AddRightGroupbox("Silent Aim", "target")

CombatLeft:AddToggle("Aimbot", { Text = "Aimbot", Default = false })
CombatLeft:AddSlider("Smooth", { Text = "Smoothness", Default = 5, Min = 1, Max = 20, Rounding = 1 })
CombatLeft:AddDropdown("Part", { Values = {"Head", "HumanoidRootPart", "Torso"}, Default = 1, Text = "Target Part" })
CombatLeft:AddToggle("TeamCheck", { Text = "Team Check", Default = true })
CombatLeft:AddToggle("VisibleCheck", { Text = "Visible Check", Default = true })

CombatRight:AddToggle("Silent", { Text = "Silent Aim", Default = false })
CombatRight:AddSlider("HitChance", { Text = "Hit Chance", Default = 100, Min = 0, Max = 100, Rounding = 0, Suffix = "%" })
CombatRight:AddSlider("FOV", { Text = "FOV", Default = 120, Min = 10, Max = 500, Rounding = 0 })
CombatRight:AddToggle("ShowFOV", { Text = "Show FOV", Default = false })

-- ===================== VISUALS =====================
local VisLeft = Tabs.Visuals:AddLeftGroupbox("ESP", "eye")
local VisRight = Tabs.Visuals:AddRightGroupbox("World", "globe")

VisLeft:AddToggle("ESP", { Text = "Enable ESP", Default = false })
VisLeft:AddToggle("Box", { Text = "Box ESP", Default = false })
VisLeft:AddToggle("NameESP", { Text = "Name ESP", Default = false })
VisLeft:AddToggle("Health", { Text = "Health ESP", Default = false })
VisLeft:AddSlider("MaxDist", { Text = "Max Distance", Default = 1000, Min = 100, Max = 5000, Rounding = 0 })

VisRight:AddToggle("Fullbright", { Text = "Fullbright", Default = false })
VisRight:AddToggle("NoFog", { Text = "No Fog", Default = false })
VisRight:AddSlider("Brightness", { Text = "Brightness", Default = 1, Min = 0, Max = 5, Rounding = 1 })

-- ===================== PLAYER =====================
local PlayerLeft = Tabs.Player:AddLeftGroupbox("Movement", "person-standing")
local PlayerRight = Tabs.Player:AddRightGroupbox("Character", "user")

PlayerLeft:AddToggle("SpeedHack", { Text = "Speed Hack", Default = false })
PlayerLeft:AddSlider("WalkSpeed", { Text = "WalkSpeed", Default = 16, Min = 16, Max = 300, Rounding = 0 })
PlayerLeft:AddToggle("JumpHack", { Text = "Jump Power", Default = false })
PlayerLeft:AddSlider("JumpPower", { Text = "JumpPower", Default = 50, Min = 50, Max = 400, Rounding = 0 })
PlayerLeft:AddToggle("Fly", { Text = "Fly", Default = false })

PlayerRight:AddToggle("InfJump", { Text = "Infinite Jump", Default = false })
PlayerRight:AddToggle("NoClip", { Text = "NoClip", Default = false })
PlayerRight:AddButton({ Text = "Reset Character", Func = function() print("Reset") end })
PlayerRight:AddButton({ Text = "Rejoin", Func = function() print("Rejoin") end })

-- ===================== SETTINGS =====================
local SetLeft = Tabs.Settings:AddLeftGroupbox("UI", "settings")
local SetRight = Tabs.Settings:AddRightGroupbox("Misc", "wrench")

SetLeft:AddLabel("Nexxware UI")
SetLeft:AddParagraph("About", "Structure: Obsidian left/right groupboxes\nVisuals: WindUI-inspired\nIcons: Lucide")
SetLeft:AddSection("Advanced", false)
SetLeft:AddToggle("Watermark", { Text = "Show Watermark", Default = true })
SetLeft:AddToggle("Keybinds", { Text = "Show Keybinds", Default = true })

SetRight:AddButton({
    Text = "Notify Test",
    Func = function()
        Library:Notify({ Title = "Nexxware", Description = "Notification OK", Time = 3 })
    end
})
SetRight:AddButton({ Text = "Unload UI", Func = function() Library:Unload() end })

Library:Notify({ Title = "Nexxware", Description = "Full example loaded", Time = 4 })
print("Nexxware full example loaded")
