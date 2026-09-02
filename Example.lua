--[[
    Nexxware UI - Full Example
    Structure : Obsidian (Left / Right Groupboxes + Tabs + Search)
    Visuals   : WindUI-inspired (colors, radius, font)
]]

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nail120212/nexxware-ui/refs/heads/main/Library.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true

local Window = Library:CreateWindow({
    Title = "Nexxware",
    Footer = "Obsidian Structure × WindUI Visuals",
    Icon = 95816097006870,
    NotifySide = "Right",
    ShowCustomCursor = true,
    Center = true,
    AutoShow = true,
    Resizable = true,
})

-- =====================================================
-- TABS
-- =====================================================
local Tabs = {
    Main     = Window:AddTab("Main", "house"),
    Combat   = Window:AddTab("Combat", "swords"),
    Visuals  = Window:AddTab("Visuals", "eye"),
    Player   = Window:AddTab("Player", "user"),
    Settings = Window:AddTab("Settings", "settings"),
}

-- =====================================================
-- MAIN TAB
-- =====================================================
local MainLeft = Tabs.Main:AddLeftGroupbox("General", "boxes")
local MainRight = Tabs.Main:AddRightGroupbox("Extra", "settings")

MainLeft:AddToggle("Enabled", {
    Text = "Enable Feature",
    Default = false,
    Tooltip = "Main toggle",
    Callback = function(Value)
        print("Enabled:", Value)
    end
})

MainLeft:AddSlider("Intensity", {
    Text = "Intensity",
    Default = 50,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
    Callback = function(Value)
        print("Intensity:", Value)
    end
})

MainLeft:AddDropdown("Mode", {
    Values = {"Normal", "Aggressive", "Safe", "Custom"},
    Default = 1,
    Multi = false,
    Text = "Mode",
    Callback = function(Value)
        print("Mode:", Value)
    end
})

MainLeft:AddInput("CustomText", {
    Default = "",
    Numeric = false,
    Text = "Custom Input",
    Placeholder = "Type here...",
    Callback = function(Value)
        print("Input:", Value)
    end
})

MainLeft:AddDivider()

MainLeft:AddButton({
    Text = "Execute",
    Func = function()
        print("Execute pressed")
        Library:Notify({
            Title = "Nexxware",
            Description = "Action executed",
            Time = 3
        })
    end
})

MainLeft:AddButton({
    Text = "Second Button",
    Func = function()
        print("Second button")
    end
})

MainRight:AddToggle("AutoMode", {
    Text = "Auto Mode",
    Default = true,
})

MainRight:AddSlider("Delay", {
    Text = "Delay",
    Default = 1,
    Min = 0.1,
    Max = 5,
    Rounding = 1,
    Suffix = "s",
})

MainRight:AddDropdown("Priority", {
    Values = {"Low", "Medium", "High", "Critical"},
    Default = 2,
    Text = "Priority",
})

MainRight:AddLabel("Status: Ready")
MainRight:AddLabel("Version: 1.0")

MainRight:AddDivider()

MainRight:AddButton({
    Text = "Unload UI",
    Func = function()
        Library:Unload()
    end
})

-- =====================================================
-- COMBAT TAB
-- =====================================================
local CombatLeft = Tabs.Combat:AddLeftGroupbox("Aimbot", "crosshair")
local CombatRight = Tabs.Combat:AddRightGroupbox("Silent", "target")

CombatLeft:AddToggle("AimbotEnabled", {
    Text = "Aimbot",
    Default = false,
})

CombatLeft:AddSlider("Smoothness", {
    Text = "Smoothness",
    Default = 5,
    Min = 1,
    Max = 20,
    Rounding = 1,
})

CombatLeft:AddDropdown("TargetPart", {
    Values = {"Head", "HumanoidRootPart", "UpperTorso", "LowerTorso"},
    Default = 1,
    Text = "Target Part",
})

CombatLeft:AddToggle("TeamCheck", {
    Text = "Team Check",
    Default = true,
})

CombatLeft:AddToggle("VisibleCheck", {
    Text = "Visible Check",
    Default = true,
})

CombatRight:AddToggle("SilentAim", {
    Text = "Silent Aim",
    Default = false,
})

CombatRight:AddSlider("HitChance", {
    Text = "Hit Chance",
    Default = 100,
    Min = 0,
    Max = 100,
    Rounding = 0,
    Suffix = "%",
})

CombatRight:AddSlider("FOV", {
    Text = "FOV",
    Default = 100,
    Min = 10,
    Max = 500,
    Rounding = 0,
})

CombatRight:AddToggle("ShowFOV", {
    Text = "Show FOV",
    Default = false,
})

-- =====================================================
-- VISUALS TAB
-- =====================================================
local VisualsLeft = Tabs.Visuals:AddLeftGroupbox("ESP", "eye")
local VisualsRight = Tabs.Visuals:AddRightGroupbox("World", "globe")

VisualsLeft:AddToggle("ESPEnabled", {
    Text = "Enable ESP",
    Default = false,
})

VisualsLeft:AddToggle("BoxESP", {
    Text = "Box ESP",
    Default = false,
})

VisualsLeft:AddToggle("NameESP", {
    Text = "Name ESP",
    Default = false,
})

VisualsLeft:AddToggle("HealthESP", {
    Text = "Health ESP",
    Default = false,
})

VisualsLeft:AddToggle("DistanceESP", {
    Text = "Distance ESP",
    Default = false,
})

VisualsLeft:AddSlider("ESPDistance", {
    Text = "Max Distance",
    Default = 1000,
    Min = 100,
    Max = 5000,
    Rounding = 0,
})

VisualsRight:AddToggle("Fullbright", {
    Text = "Fullbright",
    Default = false,
})

VisualsRight:AddToggle("NoFog", {
    Text = "No Fog",
    Default = false,
})

VisualsRight:AddSlider("Brightness", {
    Text = "Brightness",
    Default = 1,
    Min = 0,
    Max = 5,
    Rounding = 1,
})

VisualsRight:AddDropdown("TimeOfDay", {
    Values = {"Day", "Night", "Morning", "Evening"},
    Default = 1,
    Text = "Time of Day",
})

-- =====================================================
-- PLAYER TAB
-- =====================================================
local PlayerLeft = Tabs.Player:AddLeftGroupbox("Movement", "person-standing")
local PlayerRight = Tabs.Player:AddRightGroupbox("Character", "user")

PlayerLeft:AddToggle("SpeedHack", {
    Text = "Speed Hack",
    Default = false,
})

PlayerLeft:AddSlider("WalkSpeed", {
    Text = "WalkSpeed",
    Default = 16,
    Min = 16,
    Max = 300,
    Rounding = 0,
})

PlayerLeft:AddToggle("JumpHack", {
    Text = "Jump Power",
    Default = false,
})

PlayerLeft:AddSlider("JumpPower", {
    Text = "JumpPower",
    Default = 50,
    Min = 50,
    Max = 400,
    Rounding = 0,
})

PlayerLeft:AddToggle("Fly", {
    Text = "Fly",
    Default = false,
})

PlayerRight:AddToggle("InfiniteJump", {
    Text = "Infinite Jump",
    Default = false,
})

PlayerRight:AddToggle("NoClip", {
    Text = "NoClip",
    Default = false,
})

PlayerRight:AddButton({
    Text = "Reset Character",
    Func = function()
        print("Reset Character")
    end
})

PlayerRight:AddButton({
    Text = "Rejoin Server",
    Func = function()
        print("Rejoin")
    end
})

-- =====================================================
-- SETTINGS TAB
-- =====================================================
local SettingsLeft = Tabs.Settings:AddLeftGroupbox("UI", "settings")
local SettingsRight = Tabs.Settings:AddRightGroupbox("Config", "save")

SettingsLeft:AddLabel("Nexxware UI")
SettingsLeft:AddLabel("Structure: Obsidian")
SettingsLeft:AddLabel("Visuals: WindUI style")

SettingsLeft:AddDivider()

SettingsLeft:AddToggle("ShowWatermark", {
    Text = "Show Watermark",
    Default = true,
})

SettingsLeft:AddToggle("ShowKeybinds", {
    Text = "Show Keybinds",
    Default = true,
})

SettingsRight:AddButton({
    Text = "Notify Test",
    Func = function()
        Library:Notify({
            Title = "Nexxware",
            Description = "Notification system working",
            Time = 4
        })
    end
})

SettingsRight:AddButton({
    Text = "Unload Nexxware",
    Func = function()
        Library:Unload()
    end
})

-- =====================================================
-- LOAD NOTIFY
-- =====================================================
Library:Notify({
    Title = "Nexxware Loaded",
    Description = "Left/Right Groupboxes + WindUI visuals",
    Time = 5
})

print("Nexxware full example loaded")
