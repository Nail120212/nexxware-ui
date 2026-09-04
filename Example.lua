--[[ Nexxware Full Example ]]

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
    Main = Window:AddTab("Main", "house"),
    Combat = Window:AddTab("Combat", "swords"),
    Settings = Window:AddTab("Settings", "settings"),
}

local Left = Tabs.Main:AddLeftGroupbox("General", "boxes")
local Right = Tabs.Main:AddRightGroupbox("Extra", "settings")

Left:AddToggle("Enabled", { Text = "Enable", Default = false })
Left:AddSlider("Speed", { Text = "Speed", Default = 16, Min = 16, Max = 200, Rounding = 0 })
Left:AddDropdown("Mode", { Values = {"Normal","Aggressive","Safe"}, Default = 1, Text = "Mode" })

Left:AddDivider()
Left:AddTag("New")
Left:AddTag("Stable")

Left:AddSection("Details", true)
Left:AddParagraph("Info", "Collapsible section + paragraph + tags + code supported.")
Left:AddCode([[print("Nexxware")
local v = 42]])

Left:AddButton({
    Text = "Run",
    Func = function()
        Library:Notify({ Title = "Nexxware", Description = "Done", Time = 3 })
    end
})

Right:AddToggle("Auto", { Text = "Auto Mode", Default = true })
Right:AddSlider("Delay", { Text = "Delay", Default = 1, Min = 0.1, Max = 5, Rounding = 1, Suffix = "s" })
Right:AddLabel("Status: Ready")
Right:AddButton({ Text = "Unload", Func = function() Library:Unload() end })

local CombatLeft = Tabs.Combat:AddLeftGroupbox("Aimbot", "crosshair")
CombatLeft:AddToggle("Aimbot", { Text = "Aimbot", Default = false })
CombatLeft:AddSlider("Smooth", { Text = "Smoothness", Default = 5, Min = 1, Max = 20, Rounding = 1 })

local SetLeft = Tabs.Settings:AddLeftGroupbox("UI", "settings")
SetLeft:AddLabel("Nexxware")
SetLeft:AddParagraph("About", "Structure: Obsidian groupboxes\nVisuals: WindUI-inspired\nIcons: Lucide")
SetLeft:AddSection("Advanced", false)
SetLeft:AddButton({
    Text = "Notify",
    Func = function()
        Library:Notify({ Title = "Test", Description = "Working", Time = 2 })
    end
})

Library:Notify({ Title = "Nexxware", Description = "All current features loaded", Time = 4 })
print("Nexxware loaded")
