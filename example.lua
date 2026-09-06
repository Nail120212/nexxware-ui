local Syde = loadstring(game:HttpGet("https://your-host.example/library.lua"))()

local Window = Syde:Init({
    Title = "Solar UI",
    SubText = "Red and Black",
    Home = {
        Enabled = true,
        hTitle = "Welcome",
        hSubText = "Solar icon interface"
    },
    Accent = Color3.fromRGB(255, 35, 35),
    HitBox = Color3.fromRGB(255, 35, 35),
    QuickActions = true
})

local MainTab = Window:InitTab({
    Title = "Main",
    Icon = "home-2-linear"
})

MainTab:Paragraph({
    Title = "Solar icons",
    Content = "This tab uses the Solar icon pack and the red-black gradient theme."
})

MainTab:Button({
    Title = "Example button",
    Description = "A simple action using the updated library.",
    CallBack = function()
        Syde:Notify({
            Title = "Solar UI",
            Content = "The floating logo button can toggle the interface.",
            Duration = 3,
            Icon = "check-circle-linear"
        })
    end
})
