
if getgenv().Library then 
    getgenv().Library:Unload()
end

local Library do
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local Workspace = game:GetService("Workspace")
    local HttpService = game:GetService("HttpService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")

    gethui = gethui or function()
        return CoreGui
    end

    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace.CurrentCamera

    local Mouse = LocalPlayer:GetMouse()

    local FromRGB = Color3.fromRGB
    local FromHSV = Color3.fromHSV
    local FromHex = Color3.fromHex

    local RGBSequence = ColorSequence.new
    local RGBSequenceKeypoint = ColorSequenceKeypoint.new

    local NumSequence = NumberSequence.new
    local NumSequenceKeypoint = NumberSequenceKeypoint.new

    local UDim2New = UDim2.new
    local UDimNew = UDim.new
    local Vector2New = Vector2.new

    local InstanceNew = Instance.new

    local MathClamp = math.clamp
    local MathFloor = math.floor
    local MathAbs = math.abs
    local MathSin = math.sin

    local TableInsert = table.insert
    local TableFind = table.find
    local TableRemove = table.remove
    local TableConcat = table.concat
    local TableClone = table.clone
    local TableUnpack = table.unpack

    local StringFormat = string.format
    local StringFind = string.find
    local StringGSub = string.gsub
    local StringLower = string.lower

    local RectNew = Rect.new

    Library = {
        Flags = { },

        MenuKeybind = tostring(Enum.KeyCode.Z), 

        Tween = {
            Time = 0.25,
            Style = Enum.EasingStyle.Quad,
            Direction = Enum.EasingDirection.Out
        },

        Folders = {
            Directory = "zoophack",
            Configs = "zoophack/Configs",
            Assets = "zoophack/Assets",
            Themes = "zoophack/Themes"
        },

        Images = { -- you're welcome to reupload the images and replace it with your own links
            ["Saturation"] = {"Saturation.png", "https://github.com/sametexe001/images/blob/main/saturation.png?raw=true" },
            ["Value"] = { "Value.png", "https://github.com/sametexe001/images/blob/main/value.png?raw=true" },
            ["Hue"] = { "Hue.png", "https://github.com/sametexe001/images/blob/main/horizontalhue.png?raw=true" },
            ["Checkers"] = { "Checkers.png", "https://github.com/sametexe001/images/blob/main/checkers.png?raw=true" },
            ["Scrollbar"] =  { "Scrollbar.png", "https://github.com/sametexe001/images/blob/main/scrollbar.png?raw=true" },
        },

        -- Ignore below
        Pages = { },
        Sections = { },

        Connections = { },
        Threads = { },

        ThemeMap = { },
        ThemeItems = { },

        Themes = { },
        
        CurrentFrames = { },

        ThemeColorpickers = { },

        SetFlags = { },

        UnnamedConnections = 0,
        UnnamedFlags = 0,

        Popups = { },
        CornerScale = 0.2,
        NotificationsEnabled = true,
        ActiveWindow = nil,
        QuickHolder = nil,

        Holder = nil,
        PopupHolder = nil,
        NotifGui = nil,
        UnusedHolder = nil,
        NotifHolder = nil,
        Font = nil,
        BoldFont = nil,
    }

    local Keys = {
        ["Unknown"]           = "Unknown",
        ["Backspace"]         = "Back",
        ["Tab"]               = "Tab",
        ["Clear"]             = "Clear",
        ["Return"]            = "Return",
        ["Pause"]             = "Pause",
        ["Escape"]            = "Escape",
        ["Space"]             = "Space",
        ["QuotedDouble"]      = '"',
        ["Hash"]              = "#",
        ["Dollar"]            = "$",
        ["Percent"]           = "%",
        ["Ampersand"]         = "&",
        ["Quote"]             = "'",
        ["LeftParenthesis"]   = "(",
        ["RightParenthesis"]  = " )",
        ["Asterisk"]          = "*",
        ["Plus"]              = "+",
        ["Comma"]             = ",",
        ["Minus"]             = "-",
        ["Period"]            = ".",
        ["Slash"]             = "`",
        ["Three"]             = "3",
        ["Seven"]             = "7",
        ["Eight"]             = "8",
        ["Colon"]             = ":",
        ["Semicolon"]         = ";",
        ["LessThan"]          = "<",
        ["GreaterThan"]       = ">",
        ["Question"]          = "?",
        ["Equals"]            = "=",
        ["At"]                = "@",
        ["LeftBracket"]       = "LeftBracket",
        ["RightBracket"]      = "RightBracked",
        ["BackSlash"]         = "BackSlash",
        ["Caret"]             = "^",
        ["Underscore"]        = "_",
        ["Backquote"]         = "`",
        ["LeftCurly"]         = "{",
        ["Pipe"]              = "|",
        ["RightCurly"]        = "}",
        ["Tilde"]             = "~",
        ["Delete"]            = "Delete",
        ["End"]               = "End",
        ["KeypadZero"]        = "Keypad0",
        ["KeypadOne"]         = "Keypad1",
        ["KeypadTwo"]         = "Keypad2",
        ["KeypadThree"]       = "Keypad3",
        ["KeypadFour"]        = "Keypad4",
        ["KeypadFive"]        = "Keypad5",
        ["KeypadSix"]         = "Keypad6",
        ["KeypadSeven"]       = "Keypad7",
        ["KeypadEight"]       = "Keypad8",
        ["KeypadNine"]        = "Keypad9",
        ["KeypadPeriod"]      = "KeypadP",
        ["KeypadDivide"]      = "KeypadD",
        ["KeypadMultiply"]    = "KeypadM",
        ["KeypadMinus"]       = "KeypadM",
        ["KeypadPlus"]        = "KeypadP",
        ["KeypadEnter"]       = "KeypadE",
        ["KeypadEquals"]      = "KeypadE",
        ["Insert"]            = "Insert",
        ["Home"]              = "Home",
        ["PageUp"]            = "PageUp",
        ["PageDown"]          = "PageDown",
        ["RightShift"]        = "RightShift",
        ["LeftShift"]         = "LeftShift",
        ["RightControl"]      = "RightControl",
        ["LeftControl"]       = "LeftControl",
        ["LeftAlt"]           = "LeftAlt",
        ["RightAlt"]          = "RightAlt"
    }

    Library.__index = Library

    Library.Pages.__index = Library.Pages
    Library.Sections.__index = Library.Sections

    -- Files
    for Index, Value in Library.Folders do 
        if not isfolder(Value) then
            makefolder(Value)
        end
    end

    for Index, Image in Library.Images do
        if not isfile(Library.Folders.Assets .. "/" .. Image[1]) then
            writefile(Library.Folders.Assets .. "/" .. Image[1], game:HttpGet(Image[2]))
        end
    end

    local Themes = {
        ["Default"] = {
            ["Background"] = FromRGB(14, 14, 14),
            ["Inline"] = FromRGB(11, 11, 11),
            ["Text"] = FromRGB(255, 255, 255),
            ["Element"] =  FromRGB(11, 11, 11),
            ["Image"] =  FromRGB(255, 255, 255),
            ["Accent"] = FromRGB(100, 100, 108),
            ["Light Accent"] = FromRGB(182, 182, 192),
            ["Border"] = FromRGB(24, 24, 24)
        }
    }

    Library.Theme = TableClone(Themes["Default"])
    Library.Themes = Themes

    -- Tweening
    local Tween = { } do
        Tween.__index = Tween

        Tween.Create = function(self, Item, Info, Goal, IsRawItem)
            Item = IsRawItem and Item or Item.Instance
            Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

            local NewTween = {
                Tween = TweenService:Create(Item, Info, Goal),
                Info = Info,
                Goal = Goal,
                Item = Item
            }

            NewTween.Tween:Play()

            setmetatable(NewTween, Tween)

            return NewTween
        end

        Tween.Get = function(self)
            if not self.Tween then 
                return
            end

            return self.Tween, self.Info, self.Goal
        end

        Tween.Pause = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Pause()
        end

        Tween.Play = function(self)
            if not self.Tween then 
                return
            end

            self.Tween:Play()
        end

        Tween.Clean = function(self)
            if not self.Tween then 
                return
            end

            Tween:Pause()
            self = nil
        end
    end

    -- Instances
    local Instances = { } do
        Instances.__index = Instances

        Instances.Create = function(self, Class, Properties)
            local NewItem = {
                Instance = InstanceNew(Class),
                Properties = Properties,
                Class = Class
            }

            setmetatable(NewItem, Instances)

            for Property, Value in NewItem.Properties do
                NewItem.Instance[Property] = Value
            end

            return NewItem
        end

        Instances.AddToTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:AddToTheme(self, Properties)
        end

        Instances.ChangeItemTheme = function(self, Properties)
            if not self.Instance then 
                return
            end

            Library:ChangeItemTheme(self, Properties)
        end

        Instances.Connect = function(self, Event, Callback, Name)
            if not self.Instance then 
                return
            end

            if not self.Instance[Event] then 
                return
            end

            return Library:Connect(self.Instance[Event], Callback, Name)
        end

        Instances.Tween = function(self, Info, Goal)
            if not self.Instance then 
                return
            end

            return Tween:Create(self, Info, Goal)
        end

        Instances.Disconnect = function(self, Name)
            if not self.Instance then 
                return
            end

            return Library:Disconnect(Name)
        end

        Instances.Clean = function(self)
            if not self.Instance then 
                return
            end

            self.Instance:Destroy()
            self = nil
        end

        Instances.MakeDraggable = function(self, Handle)
            if not self.Instance then 
                return
            end

            local RawGui = self
            local Gui = self.Instance

            local Dragging = false 
            local DragStart
            local StartPosition 

            local IsPress = function(Input)
                return Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch
            end

            -- keeps the window reachable: at least 90px horizontally and the header vertically stay on screen
            local Set = function(Input)
                local Delta = Input.Position - DragStart
                local View = Library:GetViewSize()
                local Size = Gui.AbsoluteSize

                local MinX = -(Size.X - 90)
                local MaxX = math.max(MinX, View.X - 90)
                local MaxY = math.max(0, View.Y - 50)

                local X = MathClamp(StartPosition.X.Offset + Delta.X, MinX, MaxX)
                local Y = MathClamp(StartPosition.Y.Offset + Delta.Y, 0, MaxY)

                Gui.Position = UDim2New(StartPosition.X.Scale, X, StartPosition.Y.Scale, Y)
            end

            self:Connect("InputBegan", function(Input)
                if not IsPress(Input) then
                    return
                end

                -- Handle is an optional predicate so only part of the frame (the header) starts a drag
                if Handle and not Handle(Input, Gui) then
                    return
                end

                Dragging = true

                DragStart = Input.Position
                StartPosition = Gui.Position

                RawGui.Debounce = true 
            end)

            -- global InputEnded: releasing the mouse outside the frame must still stop the drag
            Library:Connect(UserInputService.InputEnded, function(Input)
                if Dragging and IsPress(Input) then
                    Dragging = false
                    RawGui.Debounce = false 
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                    Set(Input)
                end
            end)

            return Dragging
        end

        Instances.MakeResizeable = function(self, Minimum, Maximum)
            if not self.Instance then 
                return
            end

            local RawGui = self
            local Gui = self.Instance

            Minimum = Minimum or Vector2New(200, 150)
            Maximum = Maximum or Vector2New(math.huge, math.huge)

            local Resizing = false 
            local StartSize = Vector2New(0, 0)
            local StartMouse = Vector2New(0, 0)

            local IsPress = function(Input)
                return Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch
            end

            local ResizeButton = Instances:Create("TextButton", {
                Parent = Gui,
                AnchorPoint = Vector2New(1, 1),
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(0, 14, 0, 14),
                Position = UDim2New(1, 0, 1, 0),
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                AutoButtonColor = false,
                ZIndex = 100,
                Visible = true,
                Text = ""
            })

            ResizeButton:Connect("InputBegan", function(Input)
                if IsPress(Input) then
                    Resizing = true

                    StartSize = Vector2New(Gui.Size.X.Offset, Gui.Size.Y.Offset)
                    StartMouse = Vector2New(Input.Position.X, Input.Position.Y)
                end
            end)

            Library:Connect(UserInputService.InputEnded, function(Input)
                if Resizing and IsPress(Input) then
                    Resizing = false
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if not Resizing then
                    return
                end

                if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then
                    return
                end

                -- never let the window grow past the screen edge
                local View = Library:GetViewSize()
                local Position = Gui.AbsolutePosition

                -- Size is in unscaled units, the mouse is in screen pixels: convert through the window's UIScale
                local UIScaleObject = Gui:FindFirstChildOfClass("UIScale")
                local Scale = UIScaleObject and UIScaleObject.Scale or 1

                local MaxX = math.max(Minimum.X, math.min(Maximum.X, (View.X - Position.X) / Scale))
                local MaxY = math.max(Minimum.Y, math.min(Maximum.Y, (View.Y - Position.Y) / Scale))

                local Width = MathClamp(StartSize.X + (Input.Position.X - StartMouse.X) / Scale, Minimum.X, MaxX)
                local Height = MathClamp(StartSize.Y + (Input.Position.Y - StartMouse.Y) / Scale, Minimum.Y, MaxY)

                Gui.Size = UDim2New(0, MathFloor(Width), 0, MathFloor(Height))
            end)

            return Resizing
        end

        Instances.OnHover = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseEnter, Function)
        end

        Instances.OnHoverLeave = function(self, Function)
            if not self.Instance then 
                return
            end
            
            return Library:Connect(self.Instance.MouseLeave, Function)
        end
    end

    -- Custom font
    local CustomFont = { } do
        function CustomFont:New(Name, Weight, Style, Data)
            if isfile(Library.Folders.Assets .. "/" .. Name .. ".json") then
                return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
            end

            if not isfile(Library.Folders.Assets .. "/" .. Name .. ".ttf") then 
                writefile(Library.Folders.Assets .. "/" .. Name .. ".ttf", game:HttpGet(Data.Url))
            end

            local FontData = {
                name = Name,
                faces = { {
                    name = "Regular",
                    weight = Weight,
                    style = Style,
                    assetId = getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".ttf")
                } }
            }

            writefile(Library.Folders.Assets .. "/" .. Name .. ".json", HttpService:JSONEncode(FontData))
            return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
        end

        function CustomFont:Get(Name)
            if isfile(Library.Folders.Assets .. "/" .. Name .. ".json") then
                return Font.new(getcustomasset(Library.Folders.Assets .. "/" .. Name .. ".json"))
            end
        end

        CustomFont:New("Inter", 200, "Regular", {
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/Inter.ttf"
        })

        CustomFont:New("InterBold", 200, "Bold", {
            Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/InterBold.ttf"
        })

        Library.Font = CustomFont:Get("Inter")
        Library.BoldFont = CustomFont:Get("InterBold")
    end

    -- Library
    -- Library
    -- Each layer gets its own ScreenGui so DisplayOrder (not hand-tuned ZIndex values) decides what sits on top:
    -- quick action bar < window (panels, dialogs) < popups (color pickers) < notifications
    local CreateGui = function(Order, Enabled)
        return Instances:Create("ScreenGui", {
            Parent = gethui(),
            Name = "\0",
            ZIndexBehavior = Enum.ZIndexBehavior.Global,
            IgnoreGuiInset = true,
            ResetOnSpawn = false,
            DisplayOrder = Order,
            Enabled = Enabled
        })
    end

    Library.Holder = CreateGui(1000, true)
    Library.QuickHolder = CreateGui(999, true)
    Library.PopupHolder = CreateGui(1002, true)
    Library.NotifGui = CreateGui(1003, true)
    Library.UnusedHolder = CreateGui(0, false)

    Library.NotifHolder = Instances:Create("Frame", {
        Parent = Library.NotifGui.Instance,
        BorderColor3 = FromRGB(0, 0, 0),
        Name = "\0",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 15, 0, 55),
        Size = UDim2New(0, 0, 1, -55),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundColor3 = FromRGB(255, 255, 255)
    }) 

    Instances:Create("UIListLayout", {
        Parent = Library.NotifHolder.Instance,
        Padding = UDimNew(0, 14),
        SortOrder = Enum.SortOrder.LayoutOrder
    }) 

    Library.GetImage = function(self, Image)
        local ImageData = self.Images[Image]

        if not ImageData then 
            return
        end

        return getcustomasset(self.Folders.Assets .. "/" .. ImageData[1])
    end

    Library.Round = function(self, Number, Float)
        local Multiplier = 1 / (Float or 1)
        return MathFloor(Number * Multiplier) / Multiplier
    end

    -- Uses GetMouseLocation: Mouse.X/Y ignore the top bar inset, which is off by ~36px
    -- against ScreenGuis that use IgnoreGuiInset = true (made dropdown/colorpicker "click outside" misfire)
    Library.IsMouseOverFrame = function(self, Frame)
        Frame = Frame.Instance or Frame

        local Location = UserInputService:GetMouseLocation()
        local AbsolutePosition = Frame.AbsolutePosition
        local AbsoluteSize = Frame.AbsoluteSize

        return Location.X >= AbsolutePosition.X and Location.X <= AbsolutePosition.X + AbsoluteSize.X and Location.Y >= AbsolutePosition.Y and Location.Y <= AbsolutePosition.Y + AbsoluteSize.Y
    end

    Library.GetViewSize = function(self)
        local Size = Vector2New(0, 0)

        if self.Holder and self.Holder.Instance then
            Size = self.Holder.Instance.AbsoluteSize
        end

        if Size.X <= 0 or Size.Y <= 0 then
            Size = (Workspace.CurrentCamera or Camera).ViewportSize
        end

        return Size
    end

    Library.ClosePopups = function(self, Except)
        for Index, Popup in self.Popups do
            if Popup ~= Except and Popup.IsOpen then
                Popup:SetOpen(false)
            end
        end
    end

    Library.Unload = function(self)
        for Index, Value in self.Connections do 
            if Value.Connection then
                Value.Connection:Disconnect()
            end
        end

        for Index, Value in self.Threads do 
            pcall(coroutine.close, Value)
        end

        for Index, Gui in {self.Holder, self.QuickHolder, self.PopupHolder, self.NotifGui, self.UnusedHolder} do
            Gui:Clean()
        end
        
        getgenv().Library = nil
        Library = nil 
    end

    -- adds a UIScale press animation (e.g. 0.96 = squish, 1.25 = grow) to any button
    Library.AddPress = function(self, Item, Amount)
        local Target = Item.Instance or Item

        local PressScale = Instance.new("UIScale")
        PressScale.Scale = 1
        PressScale.Parent = Target

        local Down = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local Up = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        local IsPress = function(Input)
            return Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch
        end

        Library:Connect(Target.InputBegan, function(Input)
            if IsPress(Input) then
                TweenService:Create(PressScale, Down, {Scale = Amount or 0.96}):Play()
            end
        end)

        Library:Connect(Target.InputEnded, function(Input)
            if IsPress(Input) then
                TweenService:Create(PressScale, Up, {Scale = 1}):Play()
            end
        end)

        Library:Connect(Target.MouseLeave, function()
            TweenService:Create(PressScale, Up, {Scale = 1}):Play()
        end)

        return PressScale
    end

    -- Library:SetAccent(Color3.fromRGB(...)) recolors the whole UI (light accent is derived)
    Library.SetAccent = function(self, Color)
        Library:ChangeTheme("Accent", Color)
        Library:ChangeTheme("Light Accent", Color:Lerp(FromRGB(255, 255, 255), 0.3))
    end

    -- call this after your UI is built: loads the config marked "Autoload" in the config manager
    Library.LoadAutoConfig = function(self)
        local Path = Library.Folders.Directory .. "/autoload.txt"

        local Success, Name = pcall(function()
            if isfile(Path) then
                return readfile(Path)
            end
        end)

        if not Success or type(Name) ~= "string" then
            return false
        end

        Name = string.match(Name, "^%s*(.-)%s*$")

        if Name == "" then
            return false
        end

        local ConfigFile = Library.Folders.Configs .. "/" .. Name .. ".json"

        local Loaded, Content = pcall(function()
            if isfile(ConfigFile) then
                return readfile(ConfigFile)
            end
        end)

        if Loaded and type(Content) == "string" and pcall(Library.LoadConfig, Library, Content) then
            Library:Notification("Config", "Autoloaded " .. Name, 4)
            return true
        end

        return false
    end

    Library.Thread = function(self, Function)
        local NewThread = coroutine.create(Function)
        
        coroutine.wrap(function()
            coroutine.resume(NewThread)
        end)()

        TableInsert(self.Threads, NewThread)

        return NewThread
    end
    
    Library.SafeCall = function(self, Function, ...)
        local Arguements = { ... }
        local Success, Result = pcall(Function, TableUnpack(Arguements))

        if not Success then
            Library:Notification("Error!", "Error caught in function, report this to the devs:\n"..Result, 5)
            return false
        end

        return Success
    end

    Library.Connect = function(self, Event, Callback, Name)
        Name = Name or StringFormat("Connection_%s_%s", self.UnnamedConnections + 1, HttpService:GenerateGUID(false))

        local NewConnection = {
            Event = Event,
            Callback = Callback,
            Name = Name,
            Connection = nil
        }

        Library:Thread(function()
            NewConnection.Connection = Event:Connect(Callback)
        end)

        TableInsert(self.Connections, NewConnection)
        return NewConnection
    end

    Library.Disconnect = function(self, Name)
        for _, Connection in self.Connections do 
            if Connection.Name == Name then
                Connection.Connection:Disconnect()
                break
            end
        end
    end

    Library.NextFlag = function(self)
        local FlagNumber = self.UnnamedFlags + 1
        return StringFormat("Flag Number %s %s", FlagNumber, HttpService:GenerateGUID(false))
    end

    Library.AddToTheme = function(self, Item, Properties)
        Item = Item.Instance or Item 

        local ThemeData = {
            Item = Item,
            Properties = Properties,
        }

        for Property, Value in ThemeData.Properties do
            if type(Value) == "string" then
                Item[Property] = self.Theme[Value]
            else
                Item[Property] = Value
            end
        end

        TableInsert(self.ThemeItems, ThemeData)
        self.ThemeMap[Item] = ThemeData
    end

    Library.GetConfig = function(self)
        local Config = { } 

        local Success, Result = self:SafeCall(function()
            for Index, Value in self.Flags do 
                if type(Value) == "table" and Value.Key then
                    Config[Index] = {Key = tostring(Value.Key), Mode = Value.Mode}
                elseif type(Value) == "table" and Value.Color then
                    Config[Index] = {Color = Value.HexValue, Alpha = Value.Alpha}
                else
                    Config[Index] = Value
                end
            end
        end)

        return HttpService:JSONEncode(Config)
    end

    Library.LoadConfig = function(self, Config)
        local Decoded = HttpService:JSONDecode(Config)

        local Success, Result = self:SafeCall(function()
            for Index, Value in Decoded do 
                local SetFunction = self.SetFlags[Index]

                if not SetFunction then
                    continue
                end

                if type(Value) == "table" and Value.Key then 
                    SetFunction(Value)
                elseif type(Value) == "table" and Value.Color then
                    SetFunction(Value.Color, Value.Alpha)
                else
                    SetFunction(Value)
                end
            end
        end)
    end

    Library.DeleteConfig = function(self, Config)
        if isfile(self.Folders.Configs .. "/" .. Config) then 
            delfile(self.Folders.Configs .. "/" .. Config)
            self:Notification("Success", "Deleted config " .. Config, 5)
        end
    end

    Library.SaveConfig = function(self, Config)
        if isfile(self.Folders.Configs .. "/" .. Config) then
            writefile(self.Folders.Configs .. "/" .. Config, self:GetConfig())
            self:Notification("Success", "Saved config " .. Config, 5)
        end
    end

    Library.RefreshConfigsList = function(self, Element)
        local CurrentList = { }
        local List = { }

        local ConfigFolderName = StringGSub(self.Folders.Configs, self.Folders.Directory .. "/", "")

        for Index, Value in listfiles(self.Folders.Configs) do
            local FileName = StringGSub(Value, self.Folders.Directory .. "\\" .. ConfigFolderName .. "\\", "")
            List[Index] = FileName
        end

        local IsNew = #List ~= CurrentList

        if not IsNew then
            for Index = 1, #List do
                if List[Index] ~= CurrentList[Index] then
                    IsNew = true
                    break
                end
            end
        else
            CurrentList = List
            Element:Refresh(CurrentList)
        end
    end

    Library.ChangeItemTheme = function(self, Item, Properties)
        Item = Item.Instance or Item

        if not self.ThemeMap[Item] then 
            return
        end

        self.ThemeMap[Item].Properties = Properties
        self.ThemeMap[Item] = self.ThemeMap[Item]
    end

    Library.ChangeTheme = function(self, Theme, Color)
        self.Theme[Theme] = Color

        for _, Item in self.ThemeItems do
            for Property, Value in Item.Properties do
                if type(Value) == "string" and Value == Theme then
                    Item.Item[Property] = Color
                end
            end
        end
    end

    Library.GetTransparencyPropertyFromItem = function(self, Item)
        if Item:IsA("Frame") then
            return {"BackgroundTransparency"}
        elseif Item:IsA("TextLabel") or Item:IsA("TextButton") then
            return { "TextTransparency", "BackgroundTransparency" }
        elseif Item:IsA("ImageLabel") or Item:IsA("ImageButton") then
            return { "BackgroundTransparency", "ImageTransparency" }
        elseif Item:IsA("ScrollingFrame") then
            return { "BackgroundTransparency", "ScrollBarImageTransparency" }
        elseif Item:IsA("TextBox") then
            return { "TextTransparency", "BackgroundTransparency" }
        elseif Item:IsA("UIStroke") then 
            return { "Transparency" }
        end
    end

    Library.FadeItem = function(self, Item, Property, Visibility, Speed)
        local OldTransparency = Item[Property]
        Item[Property] = Visibility and 1 or OldTransparency

        local NewTween = Tween:Create(Item, TweenInfo.new(Speed or Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction), {
            [Property] = Visibility and OldTransparency or 1
        }, true)

        Library:Connect(NewTween.Tween.Completed, function()
            if not Visibility then 
                task.wait()
                Item[Property] = OldTransparency
            end
        end)

        return NewTween
    end

    Library.Notification = function(self, Text, Description, Duration)
        if Library.NotificationsEnabled == false then
            return
        end

        local Items = { } do
            Items["Notification"] = Instances:Create("Frame", {
                Parent = Library.NotifHolder.Instance,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.XY,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["Notification"]:AddToTheme({BackgroundColor3 = "Inline"})

            Instances:Create("UICorner", {
                Parent = Items["Notification"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            Items["Title"] = Instances:Create("TextLabel", {
                Parent = Items["Notification"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Text,
                Name = "\0",
                Size = UDim2New(0, 0, 0, 15),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Title"]:AddToTheme({BackgroundColor3 = "Text"})

            Instances:Create("UIPadding", {
                Parent = Items["Notification"].Instance,
                PaddingTop = UDimNew(0, 5),
                PaddingBottom = UDimNew(0, 8),
                PaddingRight = UDimNew(0, 8),
                PaddingLeft = UDimNew(0, 8)
            }) 

            Items["Description"] = Instances:Create("TextLabel", {
                Parent = Items["Notification"].Instance,
                TextWrapped = true,
                Name = "====sa0dSA=DSAJGjmsaM",
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.5,
                Text = Description,
                Size = UDim2New(0, 0, 0, 15),
                Position = UDim2New(0, 0, 0, 18),
                BorderSizePixel = 0,
                BorderColor3 = FromRGB(0, 0, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                FontFace = Library.Font,
                AutomaticSize = Enum.AutomaticSize.XY,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Description"]:AddToTheme({TextColor3 = "Text"})
        end

        Items["Notification"].Instance.BackgroundTransparency = 1
        local OldSize = Items["Notification"].Instance.AbsoluteSize
        Items["Notification"].Instance.Size = UDim2New(0, 0, 0, 0)
        for Index, Value in Items["Notification"].Instance:GetDescendants() do
            if Value:IsA("UIStroke") then 
                Value.Transparency = 1
            elseif Value:IsA("TextLabel") then 
                Value.TextTransparency = 1
            elseif Value:IsA("Frame") then 
                Value.BackgroundTransparency = 1
            end
        end

        Library:Thread(function()
            Items["Notification"]:Tween(nil, {BackgroundTransparency = 0, Size = UDim2New(0, OldSize.X, 0, OldSize.Y)})
            
            task.wait(0.06)

            for Index, Value in Items["Notification"].Instance:GetDescendants() do
                if Value:IsA("UIStroke") then
                    Tween:Create(Value, nil, {Transparency = 0}, true)
                elseif Value:IsA("TextLabel") then
                    if Value.Name ~= "====sa0dSA=DSAJGjmsaM" then 
                        Tween:Create(Value, nil, {TextTransparency = 0}, true)
                    else
                        Tween:Create(Value, nil, {TextTransparency = 0.5}, true)
                    end
                elseif Value:IsA("Frame") then
                    Tween:Create(Value, nil, {BackgroundTransparency = 0}, true)
                end
            end

            task.delay(Duration + 0.1, function()
                for Index, Value in Items["Notification"].Instance:GetDescendants() do
                    if Value:IsA("UIStroke") then
                        Tween:Create(Value, nil, {Transparency = 1}, true)
                    elseif Value:IsA("TextLabel") then
                        Tween:Create(Value, nil, {TextTransparency = 1}, true)
                    elseif Value:IsA("Frame") then
                        Tween:Create(Value, nil, {BackgroundTransparency = 1}, true)
                    end
                end

                task.wait(0.06)

                Items["Notification"]:Tween(nil, {BackgroundTransparency = 1, Size = UDim2New(0, 0, 0, 0)})

                task.wait(0.5)
                Items["Notification"]:Clean()
            end)
        end)
    end

    -- Accepts "#RGB", "RGB", "#RRGGBB" or "RRGGBB"; returns a Color3 or nil
    local ParseHex = function(Text)
        Text = StringGSub(tostring(Text), "[#%s]", "")

        if #Text == 3 then
            Text = StringGSub(Text, "(%x)", "%1%1")
        end

        if #Text ~= 6 or not string.match(Text, "^%x+$") then
            return nil
        end

        return FromHex(Text)
    end

    Library.ParseHex = function(self, Text)
        return ParseHex(Text)
    end

    Library.CreateColorpicker = function(self, Data)
        Data = Data or { }

        local Colorpicker = {
            Window = Data.Window,
            Page = Data.Page,
            Section = Data.Section,
            Flag = Data.Flag,
            Hue = 0,
            Saturation = 0,
            Value = 0,
            Alpha = Data.Alpha or 0,
            Color = FromRGB(0, 0, 0),
            HexValue = "000000",
            IsOpen = false,
        }

        Library.Flags[Colorpicker.Flag] = { }

        local PickerWidth = 232
        local PickerHeight = 228

        local FadeSpeed = Data.Window and Data.Window.FadeSpeed or 0.2
        local Smooth = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local Fade = TweenInfo.new(FadeSpeed, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

        local IsPress = function(Input)
            return Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch
        end

        local Corner = function(Parent, Radius)
            return Instances:Create("UICorner", {
                Parent = Parent.Instance,
                CornerRadius = Radius
            })
        end

        local Stroke = function(Parent)
            local NewStroke = Instances:Create("UIStroke", {
                Parent = Parent.Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  NewStroke:AddToTheme({Color = "Border"})

            return NewStroke
        end

        local Ring = function(Parent)
            Instances:Create("UIStroke", {
                Parent = Parent.Instance,
                Color = FromRGB(255, 255, 255),
                Thickness = 2,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })

            Corner(Parent, UDimNew(Library.CornerScale, 0))
        end

        local Items = { } do
            -- swatch button (sits inside the toggle / label / element row)
            Items["ColorpickerButton"] = Instances:Create("TextButton", {
                Parent = Data.Parent.Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                AnchorPoint = Vector2New(1, 0.5),
                BorderSizePixel = 0,
                Name = "\0",
                Size = UDim2New(0, 15, 0, 15),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Corner(Items["ColorpickerButton"], UDimNew(Library.CornerScale, 0))
            Stroke(Items["ColorpickerButton"])

            -- fixed slot math (independent of AbsoluteSize, which is 0 before the first layout pass)
            local Column = ((Data.Count or 1) - 1) % 5
            Items["ColorpickerButton"].Instance.Position = UDim2New(1, -(19 * Column) - (Data.IsToggle and 42 or 0), 0.5, 0)

            -- popup: container (shadow + stroke) holding a CanvasGroup body that fades as one piece
            Items["ColorpickerWindow"] = Instances:Create("Frame", {
                Parent = Library.PopupHolder.Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                BorderColor3 = FromRGB(0, 0, 0),
                Position = UDim2New(0, 0, 0, 0),
                Size = UDim2New(0, PickerWidth, 0, PickerHeight),
                Visible = false,
                ZIndex = 1,
                BackgroundColor3 = FromRGB(14, 14, 14)
            }) 

            Corner(Items["ColorpickerWindow"], UDimNew(0, 6))

            Items["WindowStroke"] = Stroke(Items["ColorpickerWindow"])
            Items["WindowStroke"].Instance.Transparency = 1

            Items["Shadow"] = Instances:Create("ImageLabel", {
                Parent = Items["ColorpickerWindow"].Instance,
                ImageColor3 = FromRGB(0, 0, 0),
                ImageTransparency = 1,
                AnchorPoint = Vector2New(0.5, 0.5),
                Image = "rbxassetid://112971167999062",
                ZIndex = 0,
                BorderSizePixel = 0,
                SliceCenter = RectNew(Vector2New(112, 112), Vector2New(147, 147)),
                ScaleType = Enum.ScaleType.Slice,
                BorderColor3 = FromRGB(0, 0, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(0.5, 0, 0.5, 0),
                SliceScale = 0.6,
                Name = "\0",
                Size = UDim2New(1, 55, 1, 55),
                BackgroundColor3 = FromRGB(255, 255, 255)
            })

            Items["Body"] = Instances:Create("CanvasGroup", {
                Parent = Items["ColorpickerWindow"].Instance,
                Name = "\0",
                Active = true, -- sinks clicks so nothing underneath (like the window drag) reacts
                BorderSizePixel = 0,
                BorderColor3 = FromRGB(0, 0, 0),
                Position = UDim2New(0, 0, 0, 6),
                Size = UDim2New(1, 0, 1, 0),
                GroupTransparency = 1,
                ZIndex = 1,
                BackgroundColor3 = FromRGB(14, 14, 14)
            })  Items["Body"]:AddToTheme({BackgroundColor3 = "Background"})

            Corner(Items["Body"], UDimNew(0, 6))

            -- saturation / value palette
            Items["Palette"] = Instances:Create("TextButton", {
                Parent = Items["Body"].Instance,
                FontFace = Library.Font,
                Text = "",
                AutoButtonColor = false,
                BorderSizePixel = 0,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Position = UDim2New(0, 10, 0, 10),
                Size = UDim2New(1, -20, 0, 132),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 0, 0)
            }) 

            Corner(Items["Palette"], UDimNew(0, 5))
            Stroke(Items["Palette"])

            Items["Saturation"] = Instances:Create("ImageLabel", {
                Parent = Items["Palette"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Image = Library:GetImage("Saturation"),
                BackgroundTransparency = 1,
                Name = "\0",
                Size = UDim2New(1, 0, 1, 0),
                BorderSizePixel = 0,
                ZIndex = 3,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Corner(Items["Saturation"], UDimNew(0, 5))

            Items["Value"] = Instances:Create("ImageLabel", {
                Parent = Items["Palette"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Image = Library:GetImage("Value"),
                BackgroundTransparency = 1,
                Name = "\0",
                Size = UDim2New(1, 0, 1, 0),
                BorderSizePixel = 0,
                ZIndex = 4,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Corner(Items["Value"], UDimNew(0, 5))

            Items["PaletteDragger"] = Instances:Create("Frame", {
                Parent = Items["Palette"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                AnchorPoint = Vector2New(0.5, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, 0),
                Size = UDim2New(0, 10, 0, 10),
                ZIndex = 6,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Ring(Items["PaletteDragger"])

            -- hue bar
            Items["Hue"] = Instances:Create("ImageButton", {
                Parent = Items["Body"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AutoButtonColor = false,
                Name = "\0",
                Position = UDim2New(0, 10, 0, 150),
                Size = UDim2New(1, -20, 0, 12),
                BorderSizePixel = 0,
                ZIndex = 2,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIGradient", {
                Parent = Items["Hue"].Instance,
                Color = RGBSequence{RGBSequenceKeypoint(0, FromRGB(255, 0, 0)), RGBSequenceKeypoint(0.17, FromRGB(255, 255, 0)), RGBSequenceKeypoint(0.33, FromRGB(0, 255, 0)), RGBSequenceKeypoint(0.5, FromRGB(0, 255, 255)), RGBSequenceKeypoint(0.67, FromRGB(0, 0, 255)), RGBSequenceKeypoint(0.83, FromRGB(255, 0, 255)), RGBSequenceKeypoint(1, FromRGB(255, 0, 0))}
            }) 

            Corner(Items["Hue"], UDimNew(Library.CornerScale, 0))
            Stroke(Items["Hue"])

            Items["HueDragger"] = Instances:Create("Frame", {
                Parent = Items["Hue"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                AnchorPoint = Vector2New(0.5, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0.5, 0),
                Size = UDim2New(0, 10, 0, 10),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Ring(Items["HueDragger"])

            -- alpha bar
            Items["Alpha"] = Instances:Create("TextButton", {
                Parent = Items["Body"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                Name = "\0",
                Position = UDim2New(0, 10, 0, 170),
                AutoButtonColor = false,
                Size = UDim2New(1, -20, 0, 12),
                BorderSizePixel = 0,
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 0, 0)
            }) 

            Corner(Items["Alpha"], UDimNew(Library.CornerScale, 0))
            Stroke(Items["Alpha"])

            Items["Checkers"] = Instances:Create("ImageLabel", {
                Parent = Items["Alpha"].Instance,
                ScaleType = Enum.ScaleType.Tile,
                BorderColor3 = FromRGB(0, 0, 0),
                Image = Library:GetImage("Checkers"),
                TileSize = UDim2New(0, 6, 0, 6),
                Name = "\0",
                Size = UDim2New(1, 0, 1, 0),
                BorderSizePixel = 0,
                ZIndex = 3,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIGradient", {
                Parent = Items["Checkers"].Instance,
                Transparency = NumSequence{NumSequenceKeypoint(0, 1), NumSequenceKeypoint(1, 0)}
            }) 

            Corner(Items["Checkers"], UDimNew(Library.CornerScale, 0))

            Items["AlphaDragger"] = Instances:Create("Frame", {
                Parent = Items["Alpha"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                AnchorPoint = Vector2New(0.5, 0.5),
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0.5, 0),
                Size = UDim2New(0, 10, 0, 10),
                ZIndex = 5,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Ring(Items["AlphaDragger"])

            -- preview swatch + hex input
            Items["Swatch"] = Instances:Create("Frame", {
                Parent = Items["Body"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Position = UDim2New(0, 10, 0, 194),
                Size = UDim2New(0, 24, 0, 24),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Corner(Items["Swatch"], UDimNew(Library.CornerScale, 0))
            Stroke(Items["Swatch"])

            Items["HexBox"] = Instances:Create("TextBox", {
                Parent = Items["Body"].Instance,
                FontFace = Library.Font,
                Text = "#FFFFFF",
                PlaceholderText = "#RRGGBB",
                PlaceholderColor3 = FromRGB(120, 120, 120),
                TextColor3 = FromRGB(255, 255, 255),
                TextSize = 13,
                ClearTextOnFocus = false,
                TextXAlignment = Enum.TextXAlignment.Center,
                BorderSizePixel = 0,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Position = UDim2New(0, 40, 0, 194),
                Size = UDim2New(0, 92, 0, 24),
                ZIndex = 2,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["HexBox"]:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Element"})

            Corner(Items["HexBox"], UDimNew(Library.CornerScale, 0))
            Items["HexStroke"] = Stroke(Items["HexBox"])

            -- rainbow toggle
            Items["RainbowToggle"] = Instances:Create("TextButton", {
                Parent = Items["Body"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                Name = "\0",
                AutoButtonColor = false,
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Position = UDim2New(0, 142, 0, 194),
                Size = UDim2New(1, -152, 0, 24),
                ZIndex = 2,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["RainbowToggle"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.5,
                Text = "Rainbow",
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, -22, 1, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                ZIndex = 3,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Items["Indicator"] = Instances:Create("Frame", {
                Parent = Items["RainbowToggle"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(1, 0.5),
                Name = "\0",
                Position = UDim2New(1, 0, 0.5, 0),
                Size = UDim2New(0, 15, 0, 15),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})

            Items["UIStroke"] = Stroke(Items["Indicator"])
            Corner(Items["Indicator"], UDimNew(Library.CornerScale, 0))

            Items["Check"] = Instances:Create("ImageLabel", {
                Parent = Items["Indicator"].Instance,
                ImageColor3 = FromRGB(0, 0, 0),
                ScaleType = Enum.ScaleType.Fit,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Size = UDim2New(1, -3, 1, -3),
                ImageTransparency = 0,
                Visible = false,
                AnchorPoint = Vector2New(0.5, 0.5),
                Image = "rbxassetid://135757045959142",
                BackgroundTransparency = 1,
                Position = UDim2New(0.5, -1, 0.5, -1),
                ZIndex = 5,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 
        end

        local Slide = nil

        -- instant = direct property writes (used while dragging / rainbow); otherwise tweened
        local Move = function(Item, Goal, Instant)
            if Instant then
                for Property, Goal_Value in Goal do
                    Item.Instance[Property] = Goal_Value
                end
            else
                Item:Tween(Smooth, Goal)
            end
        end

        function Colorpicker:Update(IsFromAlpha, Instant)
            self.Color = FromHSV(self.Hue, self.Saturation, self.Value)
            self.HexValue = self.Color:ToHex()

            Library.Flags[Data.Flag] = {
                Color = self.Color,
                HexValue =  self.HexValue,
                Alpha = self.Alpha
            }

            Move(Items["ColorpickerButton"], {BackgroundColor3 = self.Color}, Instant)
            Move(Items["Swatch"], {BackgroundColor3 = self.Color}, Instant)
            Move(Items["Palette"], {BackgroundColor3 = FromHSV(self.Hue, 1, 1)}, Instant)

            if not IsFromAlpha then 
                Move(Items["Alpha"], {BackgroundColor3 = self.Color}, Instant)
            end

            if not Items["HexBox"].Instance:IsFocused() then
                Items["HexBox"].Instance.Text = "#" .. string.upper(self.HexValue)
            end

            if Data.Callback then 
                Library:SafeCall(Data.Callback, self.Color, self.Alpha)
            end
        end

        -- Color: Color3 | "#RRGGBB" | {r, g, b, a}. Returns false when the value can't be parsed.
        function Colorpicker:Set(Color, Alpha, Instant)
            if type(Color) == "table" then 
                Alpha = Alpha or Color[4]
                Color = FromRGB(Color[1] or 0, Color[2] or 0, Color[3] or 0)
            elseif type(Color) == "string" then 
                Color = ParseHex(Color)
            end

            if typeof(Color) ~= "Color3" then
                return false
            end

            self.Hue, self.Saturation, self.Value = Color:ToHSV()
            self.Alpha = MathClamp(Alpha or self.Alpha or 0, 0, 1)

            Move(Items["PaletteDragger"], {Position = UDim2New(1 - self.Saturation, 0, 1 - self.Value, 0)}, Instant)
            Move(Items["HueDragger"], {Position = UDim2New(self.Hue, 0, 0.5, 0)}, Instant)
            Move(Items["AlphaDragger"], {Position = UDim2New(self.Alpha, 0, 0.5, 0)}, Instant)

            self:Update(false, Instant)

            return true
        end

        function Colorpicker:Get()
            return Colorpicker.Color, Colorpicker.Alpha
        end

        function Colorpicker:GetHex()
            return "#" .. string.upper(Colorpicker.HexValue)
        end

        function Colorpicker:SetVisibility(Bool)
            Items["ColorpickerButton"].Instance.Visible = Bool

            if not Bool then
                Colorpicker:SetOpen(false)
            end
        end

        -- popup placement: right-aligned under the swatch, flipped above if it would leave the screen,
        -- always clamped inside the viewport
        local Reposition = function()
            local Button = Items["ColorpickerButton"].Instance
            local View = Library:GetViewSize()

            local ButtonPosition = Button.AbsolutePosition
            local ButtonSize = Button.AbsoluteSize

            local X = ButtonPosition.X + ButtonSize.X - PickerWidth
            local Y = ButtonPosition.Y + ButtonSize.Y + 6

            if Y + PickerHeight > View.Y - 8 then
                Y = ButtonPosition.Y - PickerHeight - 6
            end

            X = MathClamp(X, 8, math.max(8, View.X - PickerWidth - 8))
            Y = MathClamp(Y, 8, math.max(8, View.Y - PickerHeight - 8))

            Items["ColorpickerWindow"].Instance.Position = UDim2New(0, MathFloor(X), 0, MathFloor(Y))
        end

        local OpenId = 0
        local FollowConnection

        function Colorpicker:SetOpen(Bool)
            if Colorpicker.IsOpen == Bool then 
                return 
            end

            Colorpicker.IsOpen = Bool

            OpenId += 1
            local Current = OpenId

            local Window = Items["ColorpickerWindow"].Instance

            if FollowConnection then
                FollowConnection:Disconnect()
                FollowConnection = nil
            end

            if Bool then 
                Library:ClosePopups(Colorpicker)

                Reposition()
                Window.Visible = true

                Items["Body"]:Tween(Fade, {GroupTransparency = 0, Position = UDim2New(0, 0, 0, 0)})
                Items["Shadow"]:Tween(Fade, {ImageTransparency = 0.58})
                Items["WindowStroke"]:Tween(Fade, {Transparency = 0})

                -- keep the popup glued to its swatch while the window is dragged / scrolled
                FollowConnection = RunService.RenderStepped:Connect(function()
                    if not Window.Parent then
                        if FollowConnection then
                            FollowConnection:Disconnect()
                            FollowConnection = nil
                        end

                        return
                    end

                    Reposition()
                end)
            else
                if Items["HexBox"].Instance:IsFocused() then
                    Items["HexBox"].Instance:ReleaseFocus(true)
                end

                local Hide = Items["Body"]:Tween(Fade, {GroupTransparency = 1, Position = UDim2New(0, 0, 0, 6)})
                Items["Shadow"]:Tween(Fade, {ImageTransparency = 1})
                Items["WindowStroke"]:Tween(Fade, {Transparency = 1})

                Hide.Tween.Completed:Once(function(State)
                    if Current == OpenId then
                        Window.Visible = false
                    end
                end)
            end
        end

        -- sliding (palette / hue / alpha)
        local SlideFrom = function(Name, Input)
            local Frame = Items[Name].Instance
            local Start = Frame.AbsolutePosition
            local Size = Frame.AbsoluteSize

            local X = MathClamp((Input.Position.X - Start.X) / math.max(Size.X, 1), 0, 1)

            if Name == "Palette" then 
                local Y = MathClamp((Input.Position.Y - Start.Y) / math.max(Size.Y, 1), 0, 1)

                Colorpicker.Saturation = 1 - X
                Colorpicker.Value = 1 - Y

                Items["PaletteDragger"].Instance.Position = UDim2New(X, 0, Y, 0)
                Colorpicker:Update(false, true)
            elseif Name == "Hue" then 
                Colorpicker.Hue = X

                Items["HueDragger"].Instance.Position = UDim2New(X, 0, 0.5, 0)
                Colorpicker:Update(false, true)
            else
                Colorpicker.Alpha = X

                Items["AlphaDragger"].Instance.Position = UDim2New(X, 0, 0.5, 0)
                Colorpicker:Update(true, true)
            end
        end

        for Index, Name in {"Palette", "Hue", "Alpha"} do
            Items[Name]:Connect("InputBegan", function(Input)
                if IsPress(Input) then
                    Slide = Name
                    SlideFrom(Name, Input)
                end
            end)
        end

        Library:Connect(UserInputService.InputChanged, function(Input)
            if Slide and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                SlideFrom(Slide, Input)
            end
        end)

        Library:Connect(UserInputService.InputEnded, function(Input)
            if Slide and IsPress(Input) then
                Slide = nil
            end
        end)

        -- hex input
        local HexBox = Items["HexBox"].Instance

        Items["HexBox"]:Connect("Focused", function()
            Items["HexStroke"]:Tween(Smooth, {Color = Library.Theme["Light Accent"]})

            HexBox.SelectionStart = 1
            HexBox.CursorPosition = #HexBox.Text + 1
        end)

        Items["HexBox"]:Connect("FocusLost", function()
            Items["HexStroke"]:Tween(Smooth, {Color = Library.Theme.Border})

            if not Colorpicker:Set(HexBox.Text, Colorpicker.Alpha) then
                HexBox.Text = "#" .. string.upper(Colorpicker.HexValue)
            end
        end)

        Library:Connect(HexBox:GetPropertyChangedSignal("Text"), function()
            if #HexBox.Text > 7 then
                HexBox.Text = string.sub(HexBox.Text, 1, 7)
            end
        end)

        -- rainbow
        local IsRainbow = false
        local RainbowId = 0
        local RainbowRestore = Colorpicker.Color

        local SetRainbow = function(Bool)
            Bool = Bool and true or false

            local Previous = IsRainbow
            IsRainbow = Bool

            Library.Flags[Data.Flag .. "RainbowToggle"] = Bool

            if Bool and not Previous then 
                RainbowRestore = Colorpicker.Color

                RainbowId += 1
                local Current = RainbowId

                Library:Thread(function()
                    while task.wait() and IsRainbow and Current == RainbowId do 
                        Colorpicker:Set(FromHSV((tick() * 0.2) % 1, 1, 1), Colorpicker.Alpha, true)
                    end
                end)
            elseif Previous and not Bool then
                RainbowId += 1
                Colorpicker:Set(RainbowRestore, Colorpicker.Alpha, true)
            end

            if Bool then 
                Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                Items["UIStroke"]:ChangeItemTheme({Color = "Light Accent"})

                Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                Items["Text"]:Tween(nil, {TextTransparency = 0})
                Items["Check"].Instance.Visible = true 
                Items["UIStroke"]:Tween(nil, {Color = Library.Theme["Light Accent"]})
            else
                Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                Items["UIStroke"]:ChangeItemTheme({Color = "Border"})

                Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                Items["Text"]:Tween(nil, {TextTransparency = 0.5})
                Items["Check"].Instance.Visible = false 
                Items["UIStroke"]:Tween(nil, {Color = Library.Theme.Border})
            end
        end

        Items["RainbowToggle"]:Connect("MouseButton1Down", function()
            SetRainbow(not IsRainbow)
        end)

        Library.SetFlags[Data.Flag .. "RainbowToggle"] = SetRainbow

        -- open / close
        Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
            Colorpicker:SetOpen(not Colorpicker.IsOpen)
        end)

        Library:Connect(UserInputService.InputBegan, function(Input)
            if IsPress(Input) and Colorpicker.IsOpen and not Library:IsMouseOverFrame(Items["ColorpickerWindow"]) and not Library:IsMouseOverFrame(Items["ColorpickerButton"]) then 
                Colorpicker:SetOpen(false)
            end
        end)

        TableInsert(Library.Popups, Colorpicker)

        Colorpicker:Set(Data.Default or Color3.new(1, 1, 1), Data.Alpha, true)

        Library.SetFlags[Data.Flag] = function(Color, Alpha)
            Colorpicker:Set(Color, Alpha)
        end

        return Colorpicker
    end

    -- Solar icon pack (7000+ icons). Anywhere an icon is accepted you can pass:
    --   "home"                -> resolves to the pack icon (style from Library.IconStyle, default "bold")
    --   "home-linear"         -> exact pack name
    --   "123456" / 123456     -> asset id
    --   "rbxassetid://123456" -> passed through
    Library.IconUrl = "https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/solar/dist/Icons.lua"
    Library.IconStyle = "bold"
    Library.Icons = nil
    Library.IconQueue = { }
    Library.IconLoading = false

    local FindSolarIcon = function(Name)
        local Icons = Library.Icons

        if not Icons then
            return nil
        end

        Name = StringLower(Name)

        if Icons[Name] then
            return Icons[Name]
        end

        for Index, Style in {Library.IconStyle, "bold", "linear", "outline", "broken", "bold-duotone", "line-duotone"} do
            local Found = Icons[Name .. "-" .. Style]

            if Found then
                return Found
            end
        end

        return nil
    end

    -- returns the image string, or nil when it is a name that isn't loaded / known (yet)
    Library.ResolveIcon = function(self, Icon)
        if Icon == nil or Icon == "" then
            return nil
        end

        Icon = tostring(Icon)

        if StringFind(Icon, "rbxassetid://", 1, true) or StringFind(Icon, "rbxasset://", 1, true) then
            return Icon
        end

        if string.match(Icon, "^%d+$") then
            return "rbxassetid://" .. Icon
        end

        return FindSolarIcon(Icon)
    end

    Library.LoadIcons = function(self)
        if Library.IconLoading or Library.Icons then
            return
        end

        Library.IconLoading = true

        Library:Thread(function()
            local Success, Result = pcall(function()
                return loadstring(game:HttpGet(Library.IconUrl))()
            end)

            Library.IconLoading = false

            if Success and type(Result) == "table" then
                Library.Icons = Result

                -- fill in every icon that was requested while the pack was still downloading
                for Index, Entry in Library.IconQueue do
                    if Entry.Image.Parent then
                        local Resolved = Library:ResolveIcon(Entry.Icon)

                        if Resolved then
                            Entry.Image.Image = Resolved
                        end
                    end
                end

                Library.IconQueue = { }
            end
        end)
    end

    -- Item: an ImageLabel/ImageButton (wrapper or raw instance). Fallback is shown until the name resolves.
    Library.ApplyIcon = function(self, Item, Icon, Fallback)
        local Image = Item.Instance or Item
        local Resolved = Library:ResolveIcon(Icon)

        if Resolved then
            Image.Image = Resolved
            return
        end

        Image.Image = Fallback or ""

        if Icon ~= nil and Icon ~= "" and not Library.Icons then
            TableInsert(Library.IconQueue, {Image = Image, Icon = Icon})
            Library:LoadIcons()
        end
    end

    -- Modal dialog that lives inside the window (so it scales / drags with it).
    -- Library:Dialog({Parent = Window.Items["MainFrame"], Title = "...", Description = "...", Buttons = {{Name = "OK", Style = "primary", Callback = function() end}}})
    -- Button styles: "default" | "primary" | "danger"
    Library.Dialog = function(self, Data)
        Data = Data or { }

        local Host = Data.Parent or (self.Items and self.Items["MainFrame"]) or Library.Holder

        local Dialog = {
            Open = true,
            Dismissable = Data.Dismissable ~= false,
        }

        local OpenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local Quick = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        local Items = { } do
            Items["Overlay"] = Instances:Create("TextButton", {
                Parent = Host.Instance,
                Name = "\0",
                Text = "",
                AutoButtonColor = false,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(0, 0, 0),
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 1, 0),
                ZIndex = 500
            }) 

            Instances:Create("UICorner", {
                Parent = Items["Overlay"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            Items["Card"] = Instances:Create("CanvasGroup", {
                Parent = Items["Overlay"].Instance,
                Name = "\0",
                Active = true,
                AnchorPoint = Vector2New(0.5, 0.5),
                Position = UDim2New(0.5, 0, 0.5, 0),
                Size = UDim2New(0, Data.Width or 320, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BorderSizePixel = 0,
                GroupTransparency = 1,
                ZIndex = 501,
                BackgroundColor3 = FromRGB(14, 14, 14)
            })  Items["Card"]:AddToTheme({BackgroundColor3 = "Background"})

            Items["Scale"] = Instances:Create("UIScale", {
                Parent = Items["Card"].Instance,
                Scale = 0.88
            }) 

            Instances:Create("UICorner", {
                Parent = Items["Card"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["Card"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Instances:Create("UIPadding", {
                Parent = Items["Card"].Instance,
                PaddingTop = UDimNew(0, 16),
                PaddingBottom = UDimNew(0, 16),
                PaddingLeft = UDimNew(0, 16),
                PaddingRight = UDimNew(0, 16)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Card"].Instance,
                Padding = UDimNew(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["Title"] = Instances:Create("TextLabel", {
                Parent = Items["Card"].Instance,
                FontFace = Library.BoldFont,
                TextColor3 = FromRGB(255, 255, 255),
                Text = Data.Title or "Dialog",
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Size = UDim2New(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1,
                ZIndex = 502,
                TextSize = 16,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

            if Data.Description and Data.Description ~= "" then
                Items["Description"] = Instances:Create("TextLabel", {
                    Parent = Items["Card"].Instance,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.4,
                    Text = Data.Description,
                    Name = "\0",
                    BorderSizePixel = 0,
                    BackgroundTransparency = 1,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextWrapped = true,
                    Size = UDim2New(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    LayoutOrder = 2,
                    ZIndex = 502,
                    TextSize = 13,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Description"]:AddToTheme({TextColor3 = "Text"})
            end

            Items["Buttons"] = Instances:Create("Frame", {
                Parent = Items["Card"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2New(1, 0, 0, 32),
                LayoutOrder = 3,
                ZIndex = 502,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIPadding", {
                Parent = Items["Buttons"].Instance,
                PaddingTop = UDimNew(0, 8)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Buttons"].Instance,
                Padding = UDimNew(0, 8),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 
        end

        Items["Buttons"].Instance.Size = UDim2New(1, 0, 0, 40)

        function Dialog:Close(After)
            if not Dialog.Open then
                return
            end

            Dialog.Open = false

            Items["Overlay"]:Tween(Quick, {BackgroundTransparency = 1})
            Items["Card"]:Tween(Quick, {GroupTransparency = 1})
            Items["Scale"]:Tween(Quick, {Scale = 0.92})

            task.delay(0.2, function()
                Items["Overlay"]:Clean()

                if After then
                    Library:SafeCall(After)
                end
            end)
        end

        local Palette = {
            default = {Color = FromRGB(24, 24, 24), Theme = "Border"},
            primary = {Color = FromRGB(100, 100, 108), Theme = "Accent"},
            danger = {Color = FromRGB(201, 62, 62)},
        }

        for Index, Info in Data.Buttons or {{Name = "OK", Style = "primary"}} do
            local Style = Palette[StringLower(Info.Style or "default")] or Palette.default

            local Button = Instances:Create("TextButton", {
                Parent = Items["Buttons"].Instance,
                FontFace = Library.Font,
                Text = Info.Name or "Button",
                TextColor3 = FromRGB(255, 255, 255),
                TextSize = 14,
                AutoButtonColor = false,
                BorderSizePixel = 0,
                Name = "\0",
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 32),
                LayoutOrder = Index,
                ZIndex = 503,
                BackgroundTransparency = 0,
                BackgroundColor3 = Style.Color
            })  Button:AddToTheme({TextColor3 = "Text"})

            if Style.Theme then
                Button:AddToTheme({BackgroundColor3 = Style.Theme})
            end

            Instances:Create("UIPadding", {
                Parent = Button.Instance,
                PaddingLeft = UDimNew(0, 18),
                PaddingRight = UDimNew(0, 18)
            }) 

            Instances:Create("UICorner", {
                Parent = Button.Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Library:AddPress(Button, 0.95)

            Button:OnHover(function()
                Button:Tween(Quick, {BackgroundTransparency = 0.2})
            end)

            Button:OnHoverLeave(function()
                Button:Tween(Quick, {BackgroundTransparency = 0})
            end)

            Button:Connect("MouseButton1Click", function()
                Dialog:Close(Info.Callback)
            end)
        end

        Items["Overlay"]:Connect("MouseButton1Click", function()
            if Dialog.Dismissable and not Library:IsMouseOverFrame(Items["Card"]) then
                Dialog:Close(Data.OnDismiss)
            end
        end)

        Library:Connect(UserInputService.InputBegan, function(Input)
            if Dialog.Open and Dialog.Dismissable and Input.KeyCode == Enum.KeyCode.Escape then
                Dialog:Close(Data.OnDismiss)
            end
        end)

        Items["Overlay"]:Tween(Quick, {BackgroundTransparency = 0.5})
        Items["Card"]:Tween(Quick, {GroupTransparency = 0})
        Items["Scale"]:Tween(OpenInfo, {Scale = 1})

        Dialog.Items = Items
        return Dialog
    end

    -- Window:Tag({Text = "BETA", Icon = "star", Color = Color3.fromRGB(200, 200, 210), TextColor = nil, Radius = 0.2})
    -- A small pill next to the window title. Icon = solar name / asset id (optional), Radius: 0.2 (default) = scale like every other corner, or a pixel number > 1 (e.g. 8).
    Library.Tag = function(self, Data)
        Data = Data or { }

        local Tag = {
            Window = self,

            Text = tostring(Data.Text or Data.text or "TAG"),
            Icon = Data.Icon or Data.icon,
            Color = Data.Color or Data.color or Library.Theme.Accent,
            TextColor = Data.TextColor or Data.textcolor,
            Radius = Data.Radius or Data.radius or 0.2,
        }

        self.TagCount = (self.TagCount or 0) + 1

        -- 0 < r <= 1 = scale corner, r > 1 = pixels
        local RadiusOf = function(Value)
            if type(Value) ~= "number" then
                return UDimNew(Library.CornerScale, 0)
            end

            if Value > 0 and Value <= 1 then
                return UDimNew(Value, 0)
            end

            return UDimNew(0, Value)
        end

        local Items = { } do
            Items["Tag"] = Instances:Create("Frame", {
                Parent = self.Items["Tags"].Instance,
                Name = "\0",
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 16),
                BackgroundColor3 = Tag.Color,
                BackgroundTransparency = 0.82,
                BorderSizePixel = 0,
                BorderColor3 = FromRGB(0, 0, 0),
                LayoutOrder = self.TagCount,
                ZIndex = 4
            }) 

            Items["Corner"] = Instances:Create("UICorner", {
                Parent = Items["Tag"].Instance,
                CornerRadius = RadiusOf(Tag.Radius)
            }) 

            Items["Stroke"] = Instances:Create("UIStroke", {
                Parent = Items["Tag"].Instance,
                Color = Tag.Color,
                Transparency = 0.55,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }) 

            Items["Scale"] = Instances:Create("UIScale", {
                Parent = Items["Tag"].Instance,
                Scale = 0.6
            }) 

            Instances:Create("UIPadding", {
                Parent = Items["Tag"].Instance,
                PaddingLeft = UDimNew(0, 6),
                PaddingRight = UDimNew(0, 6)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Tag"].Instance,
                Padding = UDimNew(0, 3),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Left,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["Icon"] = Instances:Create("ImageLabel", {
                Parent = Items["Tag"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2New(0, 10, 0, 10),
                ScaleType = Enum.ScaleType.Fit,
                ImageColor3 = Tag.TextColor or Tag.Color,
                Visible = Tag.Icon ~= nil and Tag.Icon ~= "",
                LayoutOrder = 1,
                ZIndex = 5
            }) 

            Items["Label"] = Instances:Create("TextLabel", {
                Parent = Items["Tag"].Instance,
                FontFace = Library.BoldFont,
                Text = Tag.Text,
                TextColor3 = Tag.TextColor or Tag.Color,
                TextSize = 10,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Name = "\0",
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 1, 0),
                LayoutOrder = 2,
                ZIndex = 5
            }) 
        end

        if Tag.Icon and Tag.Icon ~= "" then
            Library:ApplyIcon(Items["Icon"], Tag.Icon)
        end

        local Apply = function()
            local TextColor = Tag.TextColor or Tag.Color

            Items["Tag"].Instance.BackgroundColor3 = Tag.Color
            Items["Stroke"].Instance.Color = Tag.Color
            Items["Label"].Instance.TextColor3 = TextColor
            Items["Icon"].Instance.ImageColor3 = TextColor
            Items["Corner"].Instance.CornerRadius = RadiusOf(Tag.Radius)
            Items["Label"].Instance.Text = Tag.Text
            Items["Icon"].Instance.Visible = Tag.Icon ~= nil and Tag.Icon ~= ""
        end

        function Tag:SetText(Text)
            Tag.Text = tostring(Text)
            Apply()
        end

        function Tag:SetColor(Color)
            Tag.Color = Color
            Apply()
        end

        function Tag:SetTextColor(Color)
            Tag.TextColor = Color
            Apply()
        end

        function Tag:SetRadius(Radius)
            Tag.Radius = Radius
            Apply()
        end

        function Tag:SetIcon(Icon)
            Tag.Icon = Icon

            if Icon and Icon ~= "" then
                Library:ApplyIcon(Items["Icon"], Icon)
            end

            Apply()
        end

        function Tag:SetVisibility(Bool)
            Items["Tag"].Instance.Visible = Bool
        end

        function Tag:Destroy()
            Items["Tag"]:Clean()
        end

        Items["Scale"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})

        Tag.Items = Items

        return Tag
    end

    -- ============================================================ Quick action bar
    -- A small draggable panel (default: top right) holding shortcuts to any component.
    --
    -- Owner API:
    --   Window:QuickAction({Name = "Aimbot", Type = "Toggle", Flag = "aim_enabled"})          -- links an existing toggle by flag
    --   Window:QuickAction({Name = "Fly", Type = "Toggle", Callback = function(v) end})        -- own state (flag is created for you)
    --   Window:QuickAction({Name = "Rejoin", Type = "Button", Callback = function() end})
    --   Window:QuickAction({Name = "Speed", Type = "Slider", Min = 16, Max = 100, Default = 16, Callback = function(v) end})
    --   Window:QuickAction({Name = "Mode", Type = "Dropdown", Items = {"A", "B"}, Callback = function(v) end})
    --   Window:QuickAction({Name = "Hint", Type = "Label"})
    -- Every Toggle / Button / Slider / Dropdown you create is also pinnable by the USER in "UI Settings > Quick bar".
    Library.Pinnables = { }
    Library.PinnableKeys = { }

    local Capitalize = function(Text)
        Text = tostring(Text or "")
        return string.upper(string.sub(Text, 1, 1)) .. StringLower(string.sub(Text, 2))
    end

    Library.RegisterPinnable = function(self, Info)
        local Window = Library.ActiveWindow

        if not Window or not Window.QuickBar then
            return Info
        end

        Info.Type = Capitalize(Info.Type or "Button")

        local Base = Info.Type .. ":" .. tostring(Info.Flag or Info.Name)
        local Key = Base
        local Count = 1

        while Library.PinnableKeys[Key] do
            Count += 1
            Key = Base .. "#" .. Count
        end

        Info.Key = Key

        Library.PinnableKeys[Key] = Info
        TableInsert(Library.Pinnables, Info)

        function Info:Get()
            return Info.Flag and Library.Flags[Info.Flag]
        end

        function Info:Set(Value)
            local Setter = Info.Flag and Library.SetFlags[Info.Flag]

            if Setter then
                Setter(Value)
            end
        end

        function Info:Pin()
            Window.QuickBar:SetPinned(Info, true)
        end

        function Info:Unpin()
            Window.QuickBar:SetPinned(Info, false)
        end

        Window.QuickBar:Register(Info)

        return Info
    end

    Library.CreateQuickBar = function(self, Window)
        local Store = Window.Settings.Quick

        local Quick = {
            Window = Window,
            Enabled = Store.Enabled,
            Collapsed = Store.Collapsed,
            Locked = Store.Locked,
            Snap = Store.Snap,
            Transparency = Store.Transparency,
            Scale = Store.Scale,
            Live = { },
            Count = 0,
            Items = { },
        }

        local Items = Quick.Items

        local BarWidth = 184
        local HeaderHeight = 28
        local Margin = 10

        local Smooth = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local Quickly = TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local Switch = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        local IsPress = function(Input)
            return Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch
        end

        local Rounded = function(Parent, Radius)
            return Instances:Create("UICorner", {
                Parent = Parent.Instance,
                CornerRadius = Radius or UDimNew(Library.CornerScale, 0)
            })
        end

        local Outline = function(Parent)
            local NewStroke = Instances:Create("UIStroke", {
                Parent = Parent.Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  NewStroke:AddToTheme({Color = "Border"})

            return NewStroke
        end

        local GetView = function()
            return Library:GetViewSize()
        end

        -- ---------------------------------------------------------------- frame
        Items["Bar"] = Instances:Create("CanvasGroup", {
            Parent = Library.QuickHolder.Instance,
            Name = "\0",
            Active = true,
            Position = UDim2New(0, 0, 0, 0),
            Size = UDim2New(0, BarWidth, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = Quick.Transparency,
            GroupTransparency = 1,
            BorderSizePixel = 0,
            Visible = false,
            ZIndex = 5,
            BackgroundColor3 = FromRGB(14, 14, 14)
        })  Items["Bar"]:AddToTheme({BackgroundColor3 = "Background"})

        Rounded(Items["Bar"], UDimNew(0, 6))

        Items["BarStroke"] = Outline(Items["Bar"])

        Items["BarScale"] = Instances:Create("UIScale", {
            Parent = Items["Bar"].Instance,
            Scale = Quick.Scale
        }) 

        Instances:Create("UIListLayout", {
            Parent = Items["Bar"].Instance,
            Padding = UDimNew(0, 0),
            SortOrder = Enum.SortOrder.LayoutOrder
        }) 

        -- header (drag handle)
        Items["Header"] = Instances:Create("Frame", {
            Parent = Items["Bar"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2New(1, 0, 0, HeaderHeight),
            LayoutOrder = 1,
            ZIndex = 6,
            BackgroundColor3 = FromRGB(255, 255, 255)
        }) 

        -- grip (2 x 3 dots)
        for Column = 0, 1 do
            for Row = 0, 2 do
                local Dot = Instances:Create("Frame", {
                    Parent = Items["Header"].Instance,
                    Name = "\0",
                    Position = UDim2New(0, 9 + Column * 4, 0, HeaderHeight / 2 - 5 + Row * 4),
                    Size = UDim2New(0, 2, 0, 2),
                    BackgroundTransparency = 0.6,
                    BorderSizePixel = 0,
                    ZIndex = 7,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Dot:AddToTheme({BackgroundColor3 = "Text"})

                Rounded(Dot, UDimNew(1, 0))
            end
        end

        Items["Title"] = Instances:Create("TextLabel", {
            Parent = Items["Header"].Instance,
            FontFace = Library.BoldFont,
            Text = "Quick action bar",
            TextColor3 = FromRGB(255, 255, 255),
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = "\0",
            Position = UDim2New(0, 24, 0, 0),
            Size = UDim2New(1, -52, 1, 0),
            ZIndex = 7
        })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

        Items["Collapse"] = Instances:Create("TextButton", {
            Parent = Items["Header"].Instance,
            Text = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            BackgroundColor3 = FromRGB(24, 24, 24),
            BorderSizePixel = 0,
            Name = "\0",
            AnchorPoint = Vector2New(1, 0.5),
            Position = UDim2New(1, -4, 0.5, 0),
            Size = UDim2New(0, 20, 0, 20),
            ZIndex = 8
        })  Items["Collapse"]:AddToTheme({BackgroundColor3 = "Border"})

        Rounded(Items["Collapse"])
        Library:AddPress(Items["Collapse"], 0.88)

        Items["Chevron"] = Instances:Create("Frame", {
            Parent = Items["Collapse"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0.5, 0.5),
            Position = UDim2New(0.5, 0, 0.5, 0),
            Size = UDim2New(0, 10, 0, 10),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Rotation = Quick.Collapsed and 0 or 180,
            ZIndex = 9,
            BackgroundColor3 = FromRGB(255, 255, 255)
        }) 

        for Index, Side in {-1, 1} do
            local Arm = Instances:Create("Frame", {
                Parent = Items["Chevron"].Instance,
                Name = "\0",
                AnchorPoint = Vector2New(0.5, 0.5),
                Position = UDim2New(0.5, Side * 2, 0.5, 0),
                Size = UDim2New(0, 6, 0, 2),
                Rotation = Side * 40,
                BackgroundTransparency = 0.1,
                BorderSizePixel = 0,
                ZIndex = 9,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Arm:AddToTheme({BackgroundColor3 = "Text"})

            Rounded(Arm, UDimNew(1, 0))
        end

        Items["Divider"] = Instances:Create("Frame", {
            Parent = Items["Bar"].Instance,
            Name = "\0",
            BorderSizePixel = 0,
            Size = UDim2New(1, 0, 0, 1),
            LayoutOrder = 2,
            ZIndex = 6,
            BackgroundColor3 = FromRGB(24, 24, 24)
        })  Items["Divider"]:AddToTheme({BackgroundColor3 = "Border"})

        -- body
        Items["Body"] = Instances:Create("CanvasGroup", {
            Parent = Items["Bar"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2New(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 3,
            Visible = not Quick.Collapsed,
            ZIndex = 6,
            BackgroundColor3 = FromRGB(255, 255, 255)
        }) 

        Instances:Create("UIPadding", {
            Parent = Items["Body"].Instance,
            PaddingTop = UDimNew(0, 4),
            PaddingBottom = UDimNew(0, 4),
            PaddingLeft = UDimNew(0, 4),
            PaddingRight = UDimNew(0, 4)
        }) 

        Instances:Create("UIListLayout", {
            Parent = Items["Body"].Instance,
            Padding = UDimNew(0, 1),
            SortOrder = Enum.SortOrder.LayoutOrder
        }) 

        Items["Empty"] = Instances:Create("TextLabel", {
            Parent = Items["Body"].Instance,
            FontFace = Library.Font,
            Text = "Nothing pinned yet.\nAdd actions in UI Settings > Quick bar.",
            TextColor3 = FromRGB(255, 255, 255),
            TextTransparency = 0.55,
            TextSize = 11,
            TextWrapped = true,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = "\0",
            Size = UDim2New(1, 0, 0, 34),
            LayoutOrder = 0,
            ZIndex = 7
        })  Items["Empty"]:AddToTheme({TextColor3 = "Text"})

        -- ---------------------------------------------------------------- placement
        local Clamp = function(X, Y)
            local View = GetView()
            local Size = Items["Bar"].Instance.AbsoluteSize

            X = MathClamp(X, 6, math.max(6, View.X - Size.X - 6))
            Y = MathClamp(Y, 6, math.max(6, View.Y - Size.Y - 6))

            return MathFloor(X), MathFloor(Y)
        end

        local Place = function(X, Y, Animated)
            X, Y = Clamp(X, Y)

            if Animated then
                TweenService:Create(Items["Bar"].Instance, Smooth, {Position = UDim2New(0, X, 0, Y)}):Play()
            else
                Items["Bar"].Instance.Position = UDim2New(0, X, 0, Y)
            end

            return X, Y
        end

        local DefaultPosition = function()
            local View = GetView()
            local Width = BarWidth * Quick.Scale

            return View.X - Width - 16, 64
        end

        function Quick:ResetPosition()
            Store.X, Store.Y = nil, nil

            local X, Y = DefaultPosition()
            Place(X, Y, true)

            Window:SaveSettings()
        end

        -- ---------------------------------------------------------------- drag
        local Dragging = false
        local DragStart
        local StartPosition

        Items["Header"]:Connect("InputBegan", function(Input)
            if not IsPress(Input) or Quick.Locked then
                return
            end

            -- keep the collapse button clickable
            local Button = Items["Collapse"].Instance

            if Library:IsMouseOverFrame(Button) then
                return
            end

            Dragging = true
            DragStart = Input.Position
            StartPosition = Items["Bar"].Instance.Position
        end)

        Library:Connect(UserInputService.InputChanged, function(Input)
            if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                local Delta = Input.Position - DragStart

                Place(StartPosition.X.Offset + Delta.X, StartPosition.Y.Offset + Delta.Y)
            end
        end)

        Library:Connect(UserInputService.InputEnded, function(Input)
            if not Dragging or not IsPress(Input) then
                return
            end

            Dragging = false

            local Gui = Items["Bar"].Instance
            local View = GetView()
            local X, Y = Gui.Position.X.Offset, Gui.Position.Y.Offset

            if Quick.Snap then
                local Width = Gui.AbsoluteSize.X
                local Height = Gui.AbsoluteSize.Y

                if X < 44 then
                    X = Margin
                elseif X + Width > View.X - 44 then
                    X = View.X - Width - Margin
                end

                if Y + Height > View.Y - 44 then
                    Y = View.Y - Height - Margin
                end

                X, Y = Place(X, Y, true)
            end

            Store.X, Store.Y = X, Y
            Window:SaveSettings()
        end)

        Library:Connect(Library.Holder.Instance:GetPropertyChangedSignal("AbsoluteSize"), function()
            local Gui = Items["Bar"].Instance
            Place(Gui.Position.X.Offset, Gui.Position.Y.Offset)
        end)

        -- ---------------------------------------------------------------- state
        local ShowId = 0

        function Quick:SetEnabled(Bool, Silent)
            Bool = Bool and true or false

            if Quick.Enabled == Bool and Items["Bar"].Instance.Visible == Bool then
                return
            end

            Quick.Enabled = Bool
            Store.Enabled = Bool

            ShowId += 1
            local Current = ShowId

            if Bool then
                Items["Bar"].Instance.Visible = true
                Items["BarScale"].Instance.Scale = Quick.Scale * 0.92

                Items["Bar"]:Tween(Smooth, {GroupTransparency = 0})
                Items["BarScale"]:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = Quick.Scale})
            else
                local Hide = Items["Bar"]:Tween(Quickly, {GroupTransparency = 1})
                Items["BarScale"]:Tween(Quickly, {Scale = Quick.Scale * 0.94})

                Hide.Tween.Completed:Once(function()
                    if Current == ShowId then
                        Items["Bar"].Instance.Visible = false
                    end
                end)
            end

            if Window.UIRefs and Window.UIRefs.QuickEnabled and not Silent then
                Window.UIRefs.QuickEnabled:Set(Bool)
            end

            Window:SaveSettings()
        end

        function Quick:Toggle()
            Quick:SetEnabled(not Quick.Enabled)
        end

        local CollapseId = 0

        function Quick:SetCollapsed(Bool, Silent)
            Bool = Bool and true or false

            if Quick.Collapsed == Bool and Items["Body"].Instance.Visible == not Bool then
                return
            end

            Quick.Collapsed = Bool
            Store.Collapsed = Bool

            CollapseId += 1
            local Current = CollapseId

            Items["Chevron"]:Tween(Smooth, {Rotation = Bool and 0 or 180})

            if Bool then
                local Hide = Items["Body"]:Tween(Quickly, {GroupTransparency = 1})

                Hide.Tween.Completed:Once(function()
                    if Current == CollapseId then
                        Items["Body"].Instance.Visible = false
                    end
                end)
            else
                Items["Body"].Instance.Visible = true
                Items["Body"].Instance.GroupTransparency = 1
                Items["Body"]:Tween(Smooth, {GroupTransparency = 0})
            end

            if Window.UIRefs and Window.UIRefs.QuickCollapsed and not Silent then
                Window.UIRefs.QuickCollapsed:Set(Bool)
            end

            Window:SaveSettings()
        end

        function Quick:SetLocked(Bool)
            Quick.Locked = Bool and true or false
            Store.Locked = Quick.Locked
            Window:SaveSettings()
        end

        function Quick:SetSnap(Bool)
            Quick.Snap = Bool and true or false
            Store.Snap = Quick.Snap
            Window:SaveSettings()
        end

        function Quick:SetTransparency(Value)
            Quick.Transparency = MathClamp(Value, 0, 0.9)
            Store.Transparency = Quick.Transparency

            Items["Bar"].Instance.BackgroundTransparency = Quick.Transparency
            Window:SaveSettings()
        end

        function Quick:SetScale(Value)
            Quick.Scale = MathClamp(Value, 0.6, 1.5)
            Store.Scale = Quick.Scale

            Items["BarScale"]:Tween(Smooth, {Scale = Quick.Scale})
            Window:SaveSettings()

            task.delay(0.25, function()
                local Gui = Items["Bar"].Instance
                Place(Gui.Position.X.Offset, Gui.Position.Y.Offset)
            end)
        end

        Items["Collapse"]:Connect("MouseButton1Click", function()
            Quick:SetCollapsed(not Quick.Collapsed)
        end)

        Items["Collapse"]:OnHover(function()
            Items["Collapse"]:Tween(Quickly, {BackgroundTransparency = 0.35})
        end)

        Items["Collapse"]:OnHoverLeave(function()
            Items["Collapse"]:Tween(Quickly, {BackgroundTransparency = 1})
        end)

        -- ---------------------------------------------------------------- rows
        local NewRow = function(Info, Height)
            Quick.Count += 1

            local Row = Instances:Create("TextButton", {
                Parent = Items["Body"].Instance,
                Name = "\0",
                Text = "",
                AutoButtonColor = false,
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, Height),
                LayoutOrder = Quick.Count,
                ZIndex = 7,
                BackgroundColor3 = FromRGB(24, 24, 24)
            })  Row:AddToTheme({BackgroundColor3 = "Border"})

            Rounded(Row)

            Row:OnHover(function()
                Row:Tween(Quickly, {BackgroundTransparency = 0.6})
            end)

            Row:OnHoverLeave(function()
                Row:Tween(Quickly, {BackgroundTransparency = 1})
            end)

            return Row
        end

        local NameLabel = function(Row, Info, Reserved, Top)
            local Label = Instances:Create("TextLabel", {
                Parent = Row.Instance,
                FontFace = Library.Font,
                Text = Info.Name,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.25,
                TextSize = 13,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Name = "\0",
                Position = UDim2New(0, 8, 0, Top and 3 or 0),
                Size = UDim2New(1, -Reserved, Top and 0 or 1, Top and 16 or 0),
                ZIndex = 8
            })  Label:AddToTheme({TextColor3 = "Text"})

            return Label
        end

        local Builders = { }

        Builders.Toggle = function(Info)
            local Row = NewRow(Info, 26)
            local Label = NameLabel(Row, Info, 46)

            local Track = Instances:Create("Frame", {
                Parent = Row.Instance,
                Name = "\0",
                AnchorPoint = Vector2New(1, 0.5),
                Position = UDim2New(1, -6, 0.5, 0),
                Size = UDim2New(0, 28, 0, 16),
                BorderSizePixel = 0,
                ZIndex = 8,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Track:AddToTheme({BackgroundColor3 = "Element"})

            Rounded(Track)

            local TrackStroke = Outline(Track)

            local Knob = Instances:Create("Frame", {
                Parent = Track.Instance,
                Name = "\0",
                AnchorPoint = Vector2New(0, 0.5),
                Position = UDim2New(0, 3, 0.5, 0),
                Size = UDim2New(0, 10, 0, 10),
                BackgroundTransparency = 0.45,
                BorderSizePixel = 0,
                ZIndex = 9,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Knob:AddToTheme({BackgroundColor3 = "Text"})

            Rounded(Knob)

            for Index = 1, 3 do
                Instances:Create("Frame", {
                    Parent = Knob.Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, (Index - 2) * 2),
                    Size = UDim2New(0, 5, 0, 1),
                    BackgroundTransparency = 0.2,
                    BorderSizePixel = 0,
                    ZIndex = 10,
                    BackgroundColor3 = FromRGB(14, 14, 14)
                }):AddToTheme({BackgroundColor3 = "Background"})
            end

            local Entry = { Row = Row }
            local Shown
            local KnobToken = 0

            local Visual = function(On)
                KnobToken += 1
                local Current = KnobToken

                if On then
                    Track:ChangeItemTheme({BackgroundColor3 = "Accent"})
                    TrackStroke:ChangeItemTheme({Color = "Light Accent"})

                    Track:Tween(Switch, {BackgroundColor3 = Library.Theme.Accent})
                    TrackStroke:Tween(Switch, {Color = Library.Theme["Light Accent"]})
                    Label:Tween(Switch, {TextTransparency = 0})
                else
                    Track:ChangeItemTheme({BackgroundColor3 = "Element"})
                    TrackStroke:ChangeItemTheme({Color = "Border"})

                    Track:Tween(Switch, {BackgroundColor3 = Library.Theme.Element})
                    TrackStroke:Tween(Switch, {Color = Library.Theme.Border})
                    Label:Tween(Switch, {TextTransparency = 0.25})
                end

                Knob:Tween(TweenInfo.new(0.22, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                    Position = UDim2New(0, On and 15 or 3, 0.5, 0),
                    BackgroundTransparency = On and 0 or 0.45
                })

                local Stretch = Knob:Tween(TweenInfo.new(0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2New(0, 14, 0, 8)})

                Stretch.Tween.Completed:Once(function()
                    if Current == KnobToken then
                        Knob:Tween(TweenInfo.new(0.11, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {Size = UDim2New(0, 10, 0, 10)})
                    end
                end)
            end

            function Entry:Sync(Force)
                local Value = Library.Flags[Info.Flag] == true

                if Force or Shown ~= Value then
                    Shown = Value
                    Visual(Value)
                end
            end

            Row:Connect("MouseButton1Click", function()
                Info:Set(not (Library.Flags[Info.Flag] == true))
                Entry:Sync()
            end)

            Entry:Sync(true)

            return Entry
        end

        Builders.Button = function(Info)
            local Row = NewRow(Info, 26)
            NameLabel(Row, Info, 52)

            local Pill = Instances:Create("TextLabel", {
                Parent = Row.Instance,
                FontFace = Library.Font,
                Text = "Run",
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.2,
                TextSize = 11,
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Name = "\0",
                AnchorPoint = Vector2New(1, 0.5),
                Position = UDim2New(1, -6, 0.5, 0),
                Size = UDim2New(0, 38, 0, 16),
                ZIndex = 8,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Pill:AddToTheme({BackgroundColor3 = "Element", TextColor3 = "Text"})

            Rounded(Pill)
            Outline(Pill)

            Library:AddPress(Row, 0.97)

            Row:Connect("MouseButton1Click", function()
                Pill:ChangeItemTheme({BackgroundColor3 = "Accent"})
                Pill:Tween(Quickly, {BackgroundColor3 = Library.Theme.Accent})

                task.delay(0.18, function()
                    if Pill.Instance.Parent then
                        Pill:ChangeItemTheme({BackgroundColor3 = "Element"})
                        Pill:Tween(Smooth, {BackgroundColor3 = Library.Theme.Element})
                    end
                end)

                if Info.Callback then
                    Library:SafeCall(Info.Callback)
                end
            end)

            return { Row = Row, Sync = function() end }
        end

        Builders.Label = function(Info)
            local Row = NewRow(Info, 20)
            Row.Instance.Active = false
            NameLabel(Row, Info, 20).Instance.TextTransparency = 0.45

            return { Row = Row, Sync = function() end }
        end

        Builders.Dropdown = function(Info)
            local Row = NewRow(Info, 26)
            NameLabel(Row, Info, 92)

            local Pill = Instances:Create("TextLabel", {
                Parent = Row.Instance,
                FontFace = Library.Font,
                Text = "",
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.1,
                TextSize = 11,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BackgroundTransparency = 0,
                BorderSizePixel = 0,
                Name = "\0",
                AnchorPoint = Vector2New(1, 0.5),
                Position = UDim2New(1, -6, 0.5, 0),
                Size = UDim2New(0, 76, 0, 16),
                ZIndex = 8,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Pill:AddToTheme({BackgroundColor3 = "Element", TextColor3 = "Text"})

            Rounded(Pill)
            Outline(Pill)

            local Entry = { Row = Row }
            local Shown

            function Entry:Sync(Force)
                local Value = Library.Flags[Info.Flag]

                if type(Value) == "table" then
                    Value = Value[1]
                end

                if Force or Shown ~= Value then
                    Shown = Value
                    Pill.Instance.Text = tostring(Value or "-")
                end
            end

            Library:AddPress(Row, 0.97)

            -- click = next option, wraps around
            Row:Connect("MouseButton1Click", function()
                local List = Info.Items or { }

                if #List == 0 then
                    return
                end

                local Current = Library.Flags[Info.Flag]
                local Index = table.find(List, Current) or 0

                Info:Set(List[(Index % #List) + 1])
                Entry:Sync()
            end)

            Entry:Sync(true)

            return Entry
        end

        Builders.Slider = function(Info)
            local Min = Info.Min or 0
            local Max = Info.Max or 100
            local Step = Info.Decimals or 1
            local Suffix = Info.Suffix or ""

            local Row = NewRow(Info, 36)
            Row.Instance.Active = true

            NameLabel(Row, Info, 64, true)

            local Value = Instances:Create("TextLabel", {
                Parent = Row.Instance,
                FontFace = Library.Font,
                Text = "",
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.4,
                TextSize = 11,
                TextXAlignment = Enum.TextXAlignment.Right,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Name = "\0",
                AnchorPoint = Vector2New(1, 0),
                Position = UDim2New(1, -8, 0, 3),
                Size = UDim2New(0, 56, 0, 16),
                ZIndex = 8
            })  Value:AddToTheme({TextColor3 = "Text"})

            local Track = Instances:Create("Frame", {
                Parent = Row.Instance,
                Name = "\0",
                Position = UDim2New(0, 8, 0, 24),
                Size = UDim2New(1, -16, 0, 5),
                BorderSizePixel = 0,
                ZIndex = 8,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Track:AddToTheme({BackgroundColor3 = "Element"})

            Rounded(Track)
            Outline(Track)

            local Fill = Instances:Create("Frame", {
                Parent = Track.Instance,
                Name = "\0",
                Size = UDim2New(0, 0, 1, 0),
                BorderSizePixel = 0,
                ZIndex = 9,
                BackgroundColor3 = FromRGB(100, 100, 108)
            })  Fill:AddToTheme({BackgroundColor3 = "Accent"})

            Rounded(Fill)

            local Thumb = Instances:Create("Frame", {
                Parent = Track.Instance,
                Name = "\0",
                AnchorPoint = Vector2New(0.5, 0.5),
                Position = UDim2New(0, 0, 0.5, 0),
                Size = UDim2New(0, 10, 0, 10),
                BorderSizePixel = 0,
                ZIndex = 10,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Thumb:AddToTheme({BackgroundColor3 = "Text"})

            Rounded(Thumb)

            local Entry = { Row = Row }
            local Shown
            local Sliding = false

            local Show = function(Number, Instant)
                local Fraction = MathClamp((Number - Min) / math.max(Max - Min, 0.0001), 0, 1)

                Value.Instance.Text = StringFormat("%s%s", tostring(Number), Suffix)

                if Instant then
                    Fill.Instance.Size = UDim2New(Fraction, 0, 1, 0)
                    Thumb.Instance.Position = UDim2New(Fraction, 0, 0.5, 0)
                else
                    Fill:Tween(Quickly, {Size = UDim2New(Fraction, 0, 1, 0)})
                    Thumb:Tween(Quickly, {Position = UDim2New(Fraction, 0, 0.5, 0)})
                end
            end

            function Entry:Sync(Force)
                local Number = tonumber(Library.Flags[Info.Flag]) or Min

                if Force or Shown ~= Number then
                    Shown = Number
                    Show(Number, Sliding)
                end
            end

            local Apply = function(Input)
                local Frame = Track.Instance
                local Fraction = MathClamp((Input.Position.X - Frame.AbsolutePosition.X) / math.max(Frame.AbsoluteSize.X, 1), 0, 1)
                local Number = MathClamp(Library:Round(Min + (Max - Min) * Fraction, Step), Min, Max)

                Shown = Number
                Show(Number, true)
                Info:Set(Number)
            end

            Row:Connect("InputBegan", function(Input)
                if IsPress(Input) and Input.Position.Y - Row.Instance.AbsolutePosition.Y > 15 * Items["BarScale"].Instance.Scale then
                    Sliding = true
                    Thumb:Tween(Quickly, {Size = UDim2New(0, 13, 0, 13)})
                    Apply(Input)
                end
            end)

            Library:Connect(UserInputService.InputChanged, function(Input)
                if Sliding and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
                    Apply(Input)
                end
            end)

            Library:Connect(UserInputService.InputEnded, function(Input)
                if Sliding and IsPress(Input) then
                    Sliding = false
                    Thumb:Tween(Quickly, {Size = UDim2New(0, 10, 0, 10)})
                end
            end)

            Entry:Sync(true)

            return Entry
        end

        local RefreshEmpty = function()
            local Any = false

            for Info, Entry in Quick.Live do
                Any = true
                break
            end

            Items["Empty"].Instance.Visible = not Any
        end

        -- ---------------------------------------------------------------- pin / unpin
        function Quick:SetPinned(Info, Bool)
            Bool = Bool and true or false

            Info.Pinned = Bool
            Store.Pinned[Info.Key] = Bool

            if Bool and not Quick.Live[Info] then
                local Builder = Builders[Info.Type] or Builders.Button
                local Entry = Builder(Info)

                Quick.Live[Info] = Entry

                -- pop-in
                Entry.Row.Instance.BackgroundTransparency = 1
            elseif not Bool and Quick.Live[Info] then
                Quick.Live[Info].Row:Clean()
                Quick.Live[Info] = nil
            end

            RefreshEmpty()
            Window:SaveSettings()
        end

        function Quick:UnpinAll()
            for Index, Info in Library.Pinnables do
                if Info.Setting then
                    Info.Setting:Set(false)
                else
                    Quick:SetPinned(Info, false)
                end
            end
        end

        -- called for every registered component: applies the saved/default pin state and adds the toggle in UI Settings
        function Quick:Register(Info)
            local Saved = Store.Pinned[Info.Key]

            if Saved ~= nil then
                Info.Pinned = Saved
            end

            Info.Pinned = Info.Pinned == true

            if Window.PinSection then
                Info.Setting = Window.PinSection:Toggle({
                    Name = Info.Name .. "  (" .. Info.Type .. ")",
                    Flag = "ui_pin_" .. Info.Key,
                    Default = Info.Pinned,
                    NoPin = true,
                    Callback = function(Value)
                        Quick:SetPinned(Info, Value)
                    end
                })
            elseif Info.Pinned then
                Quick:SetPinned(Info, true)
            end
        end

        -- keeps linked rows in sync when the real component changes (toggle in a tab, config load, ...)
        Library:Thread(function()
            while task.wait(0.2) do
                for Info, Entry in Quick.Live do
                    Entry:Sync()
                end
            end
        end)

        -- ---------------------------------------------------------------- startup
        local StartX, StartY = Store.X, Store.Y

        if not StartX or not StartY then
            StartX, StartY = DefaultPosition()
        end

        Place(StartX, StartY)

        if Quick.Enabled then
            Quick.Enabled = false
            Quick:SetEnabled(true, true)
        end

        Quick.Items = Items

        return Quick
    end

    -- ============================================================ UI settings (automatic tab + persistence)
    -- Every window gets a "UI Settings" tab by itself (turn off with UISettings = false, rename with SettingsName = "...",
    -- change the icon with SettingsIcon = "..."). Values are saved to zoophack/ui_settings.json automatically.
    local DefaultSettings = function()
        return {
            Transparency = 0,
            Scale = 1,
            Corner = 0.2,
            FadeSpeed = 0.2,
            Accent = {100, 100, 108},
            ShowTags = true,
            ShowPlayer = true,
            Notifications = true,
            LockWindow = false,
            Keys = {
                Menu = "Enum.KeyCode.Z",
                Minimize = "Enum.KeyCode.Unknown",
                Quick = "Enum.KeyCode.Unknown"
            },
            Quick = {
                Enabled = true,
                Locked = false,
                Collapsed = false,
                Snap = true,
                Transparency = 0.05,
                Scale = 1,
                Pinned = { }
            }
        }
    end

    local MergeSettings
    MergeSettings = function(Into, From)
        for Key, Value in From do
            if type(Value) == "table" and type(Into[Key]) == "table" then
                MergeSettings(Into[Key], Value)
            else
                Into[Key] = Value
            end
        end
    end

    local SettingsPath = Library.Folders.Directory .. "/ui_settings.json"

    -- Overrides = script-provided defaults (Window options); a saved file wins over them
    Library.LoadUISettings = function(self, Overrides)
        local Settings = DefaultSettings()

        if type(Overrides) == "table" then
            MergeSettings(Settings, Overrides)
        end

        local Success, Result = pcall(function()
            if isfile(SettingsPath) then
                return HttpService:JSONDecode(readfile(SettingsPath))
            end
        end)

        if Success and type(Result) == "table" then
            MergeSettings(Settings, Result)
        end

        Settings.Transparency = MathClamp(tonumber(Settings.Transparency) or 0, 0, 0.8)
        Settings.Scale = MathClamp(tonumber(Settings.Scale) or 1, 0.6, 1.5)
        Settings.Corner = MathClamp(tonumber(Settings.Corner) or 0.2, 0.02, 0.5)
        Settings.FadeSpeed = MathClamp(tonumber(Settings.FadeSpeed) or 0.2, 0.05, 0.6)
        Settings.Quick.Transparency = MathClamp(tonumber(Settings.Quick.Transparency) or 0.05, 0, 0.9)
        Settings.Quick.Scale = MathClamp(tonumber(Settings.Quick.Scale) or 1, 0.6, 1.5)

        return Settings
    end

    -- "Enum.KeyCode.Z" -> Enum.KeyCode.Z  (also mouse buttons)
    local KeyFromString = function(Text)
        if type(Text) ~= "string" then
            return nil
        end

        local Name = string.match(Text, "KeyCode%.(%w+)$")

        if Name and Enum.KeyCode[Name] then
            return Enum.KeyCode[Name]
        end

        Name = string.match(Text, "UserInputType%.(%w+)$")

        if Name and Enum.UserInputType[Name] then
            return Enum.UserInputType[Name]
        end

        return nil
    end

    Library.AccentPresets = {
        ["Neutral"] = FromRGB(100, 100, 108),
        ["White"] = FromRGB(225, 225, 230),
        ["Blue"] = FromRGB(66, 120, 245),
        ["Purple"] = FromRGB(140, 92, 246),
        ["Pink"] = FromRGB(232, 90, 160),
        ["Red"] = FromRGB(214, 72, 72),
        ["Orange"] = FromRGB(230, 140, 40),
        ["Green"] = FromRGB(52, 168, 110),
    }

    -- methods every window gets (these are what the settings tab calls; you can call them too)
    Library.AttachWindowSettings = function(self, Window)
        local Items = Window.Items

        function Window:SaveSettings()
            Window.SaveId = (Window.SaveId or 0) + 1
            local Current = Window.SaveId

            task.delay(0.5, function()
                if Current == Window.SaveId then
                    pcall(writefile, SettingsPath, HttpService:JSONEncode(Window.Settings))
                end
            end)
        end

        function Window:SetTransparency(Value)
            Value = MathClamp(tonumber(Value) or 0, 0, 0.8)

            Window.Transparency = Value
            Window.Settings.Transparency = Value

            Items["MainFrame"].Instance.BackgroundTransparency = Value

            for Index, Page in Window.Pages do
                if Page.Items["Columns"] then
                    Page.Items["Columns"].Instance.BackgroundTransparency = Value
                end
            end

            Window:SaveSettings()
        end

        function Window:SetCorner(Value)
            Value = MathClamp(tonumber(Value) or 0.2, 0.02, 0.5)

            Library.CornerScale = Value
            Window.Settings.Corner = Value

            for Index, Gui in {Library.Holder, Library.QuickHolder, Library.PopupHolder, Library.NotifGui} do
                for _, Object in Gui.Instance:GetDescendants() do
                    if Object:IsA("UICorner") and Object.CornerRadius.Scale > 0 and Object.CornerRadius.Scale < 0.9 then
                        Object.CornerRadius = UDimNew(Value, 0)
                    end
                end
            end

            Window:SaveSettings()
        end

        function Window:SetFadeSpeed(Value)
            Window.FadeSpeed = MathClamp(tonumber(Value) or 0.2, 0.05, 0.6)
            Window.Settings.FadeSpeed = Window.FadeSpeed
            Window:SaveSettings()
        end

        function Window:SetTagsVisible(Bool)
            Items["Tags"].Instance.Visible = Bool and true or false
            Window.Settings.ShowTags = Bool and true or false
            Window:SaveSettings()
        end

        function Window:SetPlayerBoxVisible(Bool)
            if not Items["Footer"] then
                return
            end

            Bool = Bool and true or false

            Items["Footer"].Instance.Visible = Bool
            Items["Pages"].Instance.Size = UDim2New(1, 0, 1, -(Window.HeaderHeight + 18 + Window.DockHeight + (Bool and Window.FooterHeight or 0)))

            if Items["Dock"] then
                Items["Dock"].Instance.Position = UDim2New(0, 0, 1, -(Bool and Window.FooterHeight or 0))
            end

            Window.Settings.ShowPlayer = Bool
            Window:SaveSettings()
        end

        function Window:SetLocked(Bool)
            Window.Locked = Bool and true or false
            Window.Settings.LockWindow = Window.Locked
            Window:SaveSettings()
        end

        function Window:SetNotifications(Bool)
            Library.NotificationsEnabled = Bool and true or false
            Window.Settings.Notifications = Library.NotificationsEnabled
            Window:SaveSettings()
        end

        function Window:CenterWindow()
            local Gui = Items["MainFrame"].Instance
            local View = Library:GetViewSize()
            local Size = Gui.AbsoluteSize

            TweenService:Create(Gui, TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2New(0, MathFloor((View.X - Size.X) / 2), 0, math.max(0, MathFloor((View.Y - Size.Y) / 2)))
            }):Play()
        end

        -- Window:QuickAction({Name = "...", Type = "Toggle" | "Button" | "Slider" | "Dropdown" | "Label", ...})
        function Window:QuickAction(Data)
            Data = Data or { }

            local Info = {
                Type = Data.Type or Data.type or "Button",
                Name = Data.Name or Data.name or "Action",
                Flag = Data.Flag or Data.flag,
                Callback = Data.Callback or Data.callback,
                Min = Data.Min or Data.min,
                Max = Data.Max or Data.max,
                Decimals = Data.Decimals or Data.decimals,
                Suffix = Data.Suffix or Data.suffix,
                Items = Data.Items or Data.items,
                Pinned = Data.Pinned ~= false,
            }

            local Kind = StringLower(tostring(Info.Type))

            -- no flag given -> the action owns its value, so we create one (it is saved with configs too)
            if not Info.Flag and (Kind == "toggle" or Kind == "slider" or Kind == "dropdown") then
                Info.Flag = "quick_" .. StringGSub(StringLower(Info.Name), "%W", "_")

                local Default = Data.Default

                if Kind == "toggle" then
                    Default = Default == true
                elseif Kind == "slider" then
                    Default = Default or Info.Min or 0
                else
                    Default = Default or (Info.Items and Info.Items[1])
                end

                Library.Flags[Info.Flag] = Default

                Library.SetFlags[Info.Flag] = function(Value)
                    Library.Flags[Info.Flag] = Value

                    if Info.Callback then
                        Library:SafeCall(Info.Callback, Value)
                    end
                end
            end

            return Library:RegisterPinnable(Info)
        end
    end

    -- sidebar group + the automatic tab
    Library.BuildUISettings = function(self, Window)
        local Store = Window.Settings
        local Quick = Window.QuickBar

        local Refs = { }
        Window.UIRefs = Refs

        local Page = Window:Page({
            Name = Window.SettingsName,
            Icon = Window.SettingsIcon,
            Auto = true
        })

        -- ---------------------------------------------------------------- Interface
        local Interface = Page:SubPage({Name = "Interface"})

        local Appearance = Interface:Section({Name = "Appearance", Side = "Left"})

        Refs.Transparency = Appearance:Slider({
            Name = "Window transparency", Flag = "ui_transparency", NoPin = true,
            Min = 0, Max = 70, Default = MathFloor(Store.Transparency * 100 + 0.5), Decimals = 1, Suffix = "%",
            Callback = function(Value)
                Window:SetTransparency(Value / 100)
            end
        })

        Refs.Scale = Appearance:Slider({
            Name = "UI scale", Flag = "ui_scale", NoPin = true,
            Min = 60, Max = 150, Default = MathFloor(Window.Scale * 100 + 0.5), Decimals = 5, Suffix = "%",
            Callback = function(Value)
                if math.abs(Window.Scale - Value / 100) > 0.001 then
                    Window:SetScale(Value / 100)
                end
            end
        })

        Refs.Corner = Appearance:Slider({
            Name = "Corner roundness", Flag = "ui_corner", NoPin = true,
            Min = 2, Max = 50, Default = MathFloor(Store.Corner * 100 + 0.5), Decimals = 1, Suffix = "%",
            Callback = function(Value)
                Window:SetCorner(Value / 100)
            end
        })

        Refs.Fade = Appearance:Slider({
            Name = "Animation duration", Flag = "ui_fade", NoPin = true,
            Min = 50, Max = 600, Default = MathFloor(Store.FadeSpeed * 1000 + 0.5), Decimals = 50, Suffix = "ms",
            Callback = function(Value)
                Window:SetFadeSpeed(Value / 1000)
            end
        })

        Refs.Accent = Appearance:Colorpicker({
            Name = "Accent color", Flag = "ui_accent",
            Default = FromRGB(Store.Accent[1], Store.Accent[2], Store.Accent[3]),
            Callback = function(Color)
                Library:SetAccent(Color)

                Store.Accent = {MathFloor(Color.R * 255 + 0.5), MathFloor(Color.G * 255 + 0.5), MathFloor(Color.B * 255 + 0.5)}
                Window:SaveSettings()
            end
        })

        local PresetNames = { }

        for Name in Library.AccentPresets do
            TableInsert(PresetNames, Name)
        end

        table.sort(PresetNames)

        Appearance:Dropdown({
            Name = "Accent preset", Flag = "ui_accent_preset", NoPin = true,
            Items = PresetNames, MaxSize = 110,
            Callback = function(Value)
                local Preset = Library.AccentPresets[Value]

                if Preset and Refs.Accent then
                    Refs.Accent:Set(Preset)
                end
            end
        })

        local Behaviour = Interface:Section({Name = "Window", Side = "Right"})

        Refs.Tags = Behaviour:Toggle({
            Name = "Show title tags", Flag = "ui_tags", NoPin = true, Default = Store.ShowTags,
            Callback = function(Value)
                Window:SetTagsVisible(Value)
            end
        })

        if Window.Items["Footer"] then
            Refs.Player = Behaviour:Toggle({
                Name = "Show player box", Flag = "ui_player", NoPin = true, Default = Store.ShowPlayer,
                Callback = function(Value)
                    Window:SetPlayerBoxVisible(Value)
                end
            })
        end

        Refs.Lock = Behaviour:Toggle({
            Name = "Lock window position", Flag = "ui_lock", NoPin = true, Default = Store.LockWindow,
            Callback = function(Value)
                Window:SetLocked(Value)
            end
        })

        Refs.Notifications = Behaviour:Toggle({
            Name = "Notifications", Flag = "ui_notifications", NoPin = true, Default = Store.Notifications,
            Callback = function(Value)
                Window:SetNotifications(Value)
            end
        })

        Behaviour:Button({
            Name = "Center window", NoPin = true,
            Callback = function()
                Window:CenterWindow()
            end
        })

        -- ---------------------------------------------------------------- Keybinds
        local Binds = Page:SubPage({Name = "Keybinds"})
        local WindowKeys = Binds:Section({Name = "Window keys", Side = "Left"})

        local MenuKey, MinimizeKey, QuickKey

        local Watch = function(Field, Getter, Apply)
            return function()
                local Key = Getter()

                if Key and Key ~= Store.Keys[Field] then
                    Store.Keys[Field] = Key
                    Apply(Key)
                    Window:SaveSettings()
                end
            end
        end

        MenuKey = WindowKeys:Keybind({
            Name = "Menu toggle", Flag = "ui_key_menu", NoPin = true,
            Default = KeyFromString(Store.Keys.Menu) or Enum.KeyCode.Z,
            Callback = Watch("Menu", function() return MenuKey and MenuKey.Key end, function(Key)
                Library.MenuKeybind = Key
            end)
        })

        MinimizeKey = WindowKeys:Keybind({
            Name = "Minimize / restore", Flag = "ui_key_minimize", NoPin = true,
            Default = KeyFromString(Store.Keys.Minimize) or Enum.KeyCode.Unknown,
            Callback = Watch("Minimize", function() return MinimizeKey and MinimizeKey.Key end, function(Key)
                Window.MinimizeKey = Key
            end)
        })

        QuickKey = WindowKeys:Keybind({
            Name = "Quick action bar", Flag = "ui_key_quick", NoPin = true,
            Default = KeyFromString(Store.Keys.Quick) or Enum.KeyCode.Unknown,
            Callback = Watch("Quick", function() return QuickKey and QuickKey.Key end, function(Key)
                Window.QuickKey = Key
            end)
        })

        Refs.MenuKey, Refs.MinimizeKey, Refs.QuickKey = MenuKey, MinimizeKey, QuickKey

        local BindInfo = Binds:Section({Name = "How it works", Side = "Right"})
        BindInfo:Label("Click a keybind, then press the key you want.")
        BindInfo:Label("\"Unknown\" means the shortcut is off.")
        BindInfo:Button({
            Name = "Reset keybinds", NoPin = true,
            Callback = function()
                MenuKey:Set(Enum.KeyCode.Z)
                MinimizeKey:Set(Enum.KeyCode.Unknown)
                QuickKey:Set(Enum.KeyCode.Unknown)
            end
        })

        -- ---------------------------------------------------------------- Quick bar
        if Quick then
            local Bar = Page:SubPage({Name = "Quick bar"})
            local BarSettings = Bar:Section({Name = "Bar", Side = "Left"})

            Refs.QuickEnabled = BarSettings:Toggle({
                Name = "Show quick action bar", Flag = "ui_quick_enabled", NoPin = true, Default = Store.Quick.Enabled,
                Callback = function(Value)
                    Quick:SetEnabled(Value, true)
                end
            })

            Refs.QuickCollapsed = BarSettings:Toggle({
                Name = "Collapsed", Flag = "ui_quick_collapsed", NoPin = true, Default = Store.Quick.Collapsed,
                Callback = function(Value)
                    Quick:SetCollapsed(Value, true)
                end
            })

            BarSettings:Toggle({
                Name = "Lock position", Flag = "ui_quick_locked", NoPin = true, Default = Store.Quick.Locked,
                Callback = function(Value)
                    Quick:SetLocked(Value)
                end
            })

            BarSettings:Toggle({
                Name = "Snap to screen edges", Flag = "ui_quick_snap", NoPin = true, Default = Store.Quick.Snap,
                Callback = function(Value)
                    Quick:SetSnap(Value)
                end
            })

            BarSettings:Slider({
                Name = "Bar transparency", Flag = "ui_quick_transparency", NoPin = true,
                Min = 0, Max = 80, Default = MathFloor(Store.Quick.Transparency * 100 + 0.5), Decimals = 1, Suffix = "%",
                Callback = function(Value)
                    Quick:SetTransparency(Value / 100)
                end
            })

            BarSettings:Slider({
                Name = "Bar scale", Flag = "ui_quick_scale", NoPin = true,
                Min = 60, Max = 150, Default = MathFloor(Store.Quick.Scale * 100 + 0.5), Decimals = 5, Suffix = "%",
                Callback = function(Value)
                    if math.abs(Quick.Scale - Value / 100) > 0.001 then
                        Quick:SetScale(Value / 100)
                    end
                end
            })

            BarSettings:Button({
                Name = "Reset position", NoPin = true,
                Callback = function()
                    Quick:ResetPosition()
                end
            })

            -- every Toggle / Button / Slider / Dropdown (and every Window:QuickAction) shows up here as a switch
            local Pins = Bar:Section({Name = "Pinned actions", Side = "Right"})
            Window.PinSection = Pins

            Pins:Label("Switch on what should appear on the bar:")
            Pins:Button({
                Name = "Unpin all", NoPin = true,
                Callback = function()
                    Quick:UnpinAll()
                end
            })
        end

        -- ---------------------------------------------------------------- System
        local System = Page:SubPage({Name = "System"})
        local Tools = System:Section({Name = "Tools", Side = "Left"})

        Tools:Button({
            Name = "Open config manager", NoPin = true,
            Callback = function()
                Window:SetConfigPanel(true)
            end
        })

        Tools:Button({
            Name = "Restore default UI settings", NoPin = true,
            Callback = function()
                Library:Dialog({
                    Parent = Window.Items["MainFrame"],
                    Title = "Restore defaults?",
                    Description = "Transparency, scale, corners, accent, keybinds and the quick bar go back to their defaults.",
                    Buttons = {
                        {Name = "Cancel"},
                        {Name = "Restore", Style = "primary", Callback = function()
                            Refs.Transparency:Set(0)
                            Refs.Corner:Set(20)
                            Refs.Fade:Set(200)
                            Refs.Scale:Set(100)
                            Refs.Accent:Set(Library.AccentPresets["Neutral"])
                            Refs.Tags:Set(true)

                            if Refs.Player then
                                Refs.Player:Set(true)
                            end

                            Refs.Lock:Set(false)
                            Refs.Notifications:Set(true)

                            MenuKey:Set(Enum.KeyCode.Z)
                            MinimizeKey:Set(Enum.KeyCode.Unknown)
                            QuickKey:Set(Enum.KeyCode.Unknown)

                            if Quick then
                                Refs.QuickEnabled:Set(true)
                                Refs.QuickCollapsed:Set(false)
                                Quick:SetLocked(false)
                                Quick:SetSnap(true)
                                Quick:SetTransparency(0.05)
                                Quick:SetScale(1)
                                Quick:ResetPosition()
                            end

                            Library:Notification("UI settings", "Defaults restored", 4)
                        end}
                    }
                })
            end
        })

        local About = System:Section({Name = "Info", Side = "Right"})
        About:Label("UI settings save automatically.")
        About:Label("File: " .. SettingsPath)

        Tools:Button({
            Name = "Unload interface", NoPin = true,
            Callback = function()
                Window:Close()
            end
        })

        Window.SettingsPage = Page

        -- no user tabs at all? then the settings tab is the one that opens
        task.defer(function()
            if not Window.FirstPageShown then
                Window.FirstPageShown = true
                Page:Turn(true)
            end
        end)
    end

    Library.ParseKey = function(self, Text)
        return KeyFromString(Text)
    end

    Library.Window = function(self, Data)
        Data = Data or { }

        -- saved UI settings (zoophack/ui_settings.json). Window options below are only the first-run defaults.
        local Overrides = {
            Scale = Data.Scale or Data.scale,
            FadeSpeed = Data.FadeSpeed or Data.fadespeed,
            Transparency = Data.Transparency or Data.transparency,
        }

        local AccentOption = Data.Accent or Data.accent

        if AccentOption then
            Overrides.Accent = {MathFloor(AccentOption.R * 255 + 0.5), MathFloor(AccentOption.G * 255 + 0.5), MathFloor(AccentOption.B * 255 + 0.5)}
        end

        local Store = Library:LoadUISettings(Overrides)

        Library.CornerScale = Store.Corner
        Library.NotificationsEnabled = Store.Notifications

        if Store.Keys.Menu and not string.find(Store.Keys.Menu, "Unknown", 1, true) then
            Library.MenuKeybind = Store.Keys.Menu
        end

        Library:SetAccent(FromRGB(Store.Accent[1], Store.Accent[2], Store.Accent[3]))

        -- the window is clamped to the screen so it can never spawn (or be resized) out of view
        local View = Library:GetViewSize()
        local RequestedSize = Data.Size or Data.size or UDim2New(0, 720, 0, 500)

        local Width = MathClamp(RequestedSize.X.Offset, 320, math.max(320, View.X - 24))
        local Height = MathClamp(RequestedSize.Y.Offset, 260, math.max(260, View.Y - 24))

        local MinSize = Data.MinSize or Data.minsize or Vector2New(560, 380)
        MinSize = Vector2New(math.min(MinSize.X, Width), math.min(MinSize.Y, Height))

        local Window = {
            Logo = Data.Logo or Data.logo or "123748867365417",
            Title = Data.Title or Data.title or Data.Name or Data.name or "Caesar UI",
            Subtitle = Data.Subtitle or Data.subtitle or Data.Description or Data.description or "Interface Library",
            Size = UDim2New(0, Width, 0, Height),
            FadeSpeed = Store.FadeSpeed,
            PagePadding = Data.PagePadding or Data.pagepadding or 4,
            Scale = Store.Scale,
            Settings = Store,
            Transparency = Store.Transparency,
            Locked = Store.LockWindow,
            MinimizeKey = Store.Keys.Minimize,
            QuickKey = Store.Keys.Quick,
            SettingsName = Data.SettingsName or Data.settingsname or "UI Settings",
            SettingsIcon = Data.SettingsIcon or Data.settingsicon or "settings",
            UISettingsEnabled = Data.UISettings ~= false and Data.uisettings ~= false,
            Minimized = false,
            Closable = Data.Closable ~= false,
            Minimizable = Data.Minimizable ~= false,
            Scalable = Data.Scalable ~= false,
            OnClose = Data.OnClose or Data.onclose,
            ConfigManager = Data.ConfigManager ~= false and Data.configmanager ~= false,
            HasPlayerBox = Data.PlayerBox ~= false and Data.playerbox ~= false,
            SidebarWidth = MathClamp(Data.SidebarWidth or Data.sidebarwidth or 176, 120, MathFloor(Width * 0.45)),
            HeaderHeight = 56,

            Pages = { },
            SubPages = { },
            Items = { },

            IsOpen = false
        }

        local Sidebar = Window.SidebarWidth
        local Header = Window.HeaderHeight

        -- header controls take space from the sub tab bar
        local ControlCount = (Window.Scalable and 1 or 0) + (Window.Minimizable and 1 or 0) + (Window.Closable and 1 or 0) + (Window.ConfigManager and 1 or 0)
        Window.ControlsWidth = ControlCount > 0 and (ControlCount * 26 + (ControlCount - 1) * 4 + 12) or 0
        Window.FooterHeight = Window.HasPlayerBox and 60 or 0
        Window.DockHeight = Window.UISettingsEnabled and 48 or 0

        local ScaleObject

        local Items = { } do
            Items["MainFrame"] = Instances:Create("Frame", {
                Parent = Library.Holder.Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(0, 0),
                Name = "\0",
                Position = UDim2New(0, MathFloor((View.X - Width) / 2), 0, math.max(0, MathFloor((View.Y - Height) / 2))),
                Size = Window.Size,
                Visible = false,
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(14, 14, 14)
            })  Items["MainFrame"]:AddToTheme({BackgroundColor3 = "Background"})

            ScaleObject = Instances:Create("UIScale", {
                Parent = Items["MainFrame"].Instance,
                Scale = Window.Scale
            }).Instance

            -- only the header strip (logo + title on the left, sub tab bar on the right) drags the window
            Items["MainFrame"]:MakeDraggable(function(Input, Gui)
                return not Window.Locked and Input.Position.Y - Gui.AbsolutePosition.Y <= Header * ScaleObject.Scale
            end)

            Items["MainFrame"]:MakeResizeable(MinSize, Vector2New(math.huge, math.huge))

            Items["Shadow"] = Instances:Create("ImageLabel", {
                Parent = Items["MainFrame"].Instance,
                ImageColor3 = FromRGB(0, 0, 0),
                ImageTransparency = 0.5799999833106995,
                AnchorPoint = Vector2New(0.5, 0.5),
                Image = "rbxassetid://112971167999062",
                ZIndex = -1,
                BorderSizePixel = 0,
                SliceCenter = RectNew(Vector2New(112, 112), Vector2New(147, 147)),
                ScaleType = Enum.ScaleType.Slice,
                BorderColor3 = FromRGB(0, 0, 0),
                BackgroundTransparency = 1,
                Position = UDim2New(0.5, 0, 0.5, 0),
                SliceScale = 0.6000000238418579,
                Name = "\0",
                Size = UDim2New(1, 55, 1, 55),
                BackgroundColor3 = FromRGB(255, 255, 255)
            })

            Items["Sidebar"] = Instances:Create("Frame", {
                Parent = Items["MainFrame"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(0, Sidebar, 1, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            -- header: logo | title / subtitle
            Items["Logo"] = Instances:Create("ImageLabel", {
                Parent = Items["Sidebar"].Instance,
                ScaleType = Enum.ScaleType.Fit,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Size = UDim2New(0, 32, 0, 32),
                Position = UDim2New(0, 14, 0, (Header - 32) / 2),
                Image = "",
                BackgroundTransparency = 1,
                ZIndex = 3,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Logo"]:AddToTheme({ImageColor3 = "Image"})

            Library:ApplyIcon(Items["Logo"], Window.Logo, "rbxassetid://123748867365417")

            Instances:Create("UICorner", {
                Parent = Items["Logo"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Items["Shadow2"] = Instances:Create("ImageLabel", {
                Parent = Items["Logo"].Instance,
                ScaleType = Enum.ScaleType.Slice,
                Name = "\0",
                ImageTransparency = 0.7200000286102295,
                BorderColor3 = FromRGB(0, 0, 0),
                BackgroundColor3 = FromRGB(255, 255, 255),
                Size = UDim2New(1, 5, 1, 5),
                AnchorPoint = Vector2New(0.5, 0.5),
                Image = "rbxassetid://112971167999062",
                BackgroundTransparency = 1,
                Position = UDim2New(0.5, 0, 0.5, 0),
                SliceScale = 0.8999999761581421,
                ZIndex = 2,
                BorderSizePixel = 0,
                SliceCenter = RectNew(Vector2New(112, 112), Vector2New(147, 147))
            })  Items["Shadow2"]:AddToTheme({ImageColor3 = "Image"})

            -- header text: one horizontally scrollable strip (title + tags on top, subtitle below).
            -- When it is wider than the sidebar it scrolls back and forth by itself; you can also drag it.
            Items["HeaderScroll"] = Instances:Create("ScrollingFrame", {
                Parent = Items["Sidebar"].Instance,
                Name = "\0",
                Active = false,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                CanvasSize = UDim2New(0, 0, 0, 0),
                ScrollingDirection = Enum.ScrollingDirection.X,
                ElasticBehavior = Enum.ElasticBehavior.Never,
                ScrollBarThickness = 0,
                ScrollBarImageColor3 = Library.Theme.Accent,
                Position = UDim2New(0, 54, 0, (Header - 38) / 2),
                Size = UDim2New(1, -62, 0, 38),
                ZIndex = 3,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["HeaderScroll"]:AddToTheme({ScrollBarImageColor3 = "Accent"})

            Items["HeaderContent"] = Instances:Create("Frame", {
                Parent = Items["HeaderScroll"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 1, 0),
                ZIndex = 3,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["HeaderContent"].Instance,
                Padding = UDimNew(0, 2),
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["TitleRow"] = Instances:Create("Frame", {
                Parent = Items["HeaderContent"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 18),
                LayoutOrder = 1,
                ZIndex = 3,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["TitleRow"].Instance,
                Padding = UDimNew(0, 6),
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["Title"] = Instances:Create("TextLabel", {
                Parent = Items["TitleRow"].Instance,
                FontFace = Library.BoldFont,
                TextColor3 = FromRGB(255, 255, 255),
                Text = Window.Title,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 1, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = 1,
                BorderSizePixel = 0,
                ZIndex = 3,
                TextSize = 15,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

            Items["Tags"] = Instances:Create("Frame", {
                Parent = Items["TitleRow"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 1, 0),
                LayoutOrder = 2,
                ZIndex = 3,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Tags"].Instance,
                Padding = UDimNew(0, 4),
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["Subtitle"] = Instances:Create("TextLabel", {
                Parent = Items["HeaderContent"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.5,
                Text = Window.Subtitle,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 14),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = Window.Subtitle ~= "",
                LayoutOrder = 2,
                BorderSizePixel = 0,
                ZIndex = 3,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Subtitle"]:AddToTheme({TextColor3 = "Text"})

            -- header divider (lines up with the divider of the page content on the right)
            Instances:Create("Frame", {
                Parent = Items["Sidebar"].Instance,
                Size = UDim2New(1, 0, 0, 1),
                Name = "\0",
                Position = UDim2New(0, 0, 0, Header),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(24, 24, 24)
            }):AddToTheme({BackgroundColor3 = "Border"})

            Instances:Create("Frame", {
                Parent = Items["Sidebar"].Instance,
                Size = UDim2New(0, 1, 1, 0),
                Name = "\0",
                Position = UDim2New(1, 0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(24, 24, 24)
            }):AddToTheme({BackgroundColor3 = "Border"})

            Items["Pages"] = Instances:Create("ScrollingFrame", {
                Parent = Items["Sidebar"].Instance,
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 3,
                ScrollBarImageTransparency = 0.2,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                ElasticBehavior = Enum.ElasticBehavior.Never,
                CanvasSize = UDim2New(0, 0, 0, 0),
                ScrollBarImageColor3 = Library.Theme.Accent,
                MidImage = Library:GetImage("Scrollbar"),
                TopImage = Library:GetImage("Scrollbar"),
                BottomImage = Library:GetImage("Scrollbar"),
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, Header + 10),
                Size = UDim2New(1, 0, 1, -(Header + 18 + Window.FooterHeight + Window.DockHeight)),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Pages"]:AddToTheme({ScrollBarImageColor3 = "Accent"})

            Instances:Create("UIListLayout", {
                Parent = Items["Pages"].Instance,
                Padding = UDimNew(0, Window.PagePadding),
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            -- player box (bottom of the sidebar): avatar | display name / @username
            if Window.HasPlayerBox then
                Items["Footer"] = Instances:Create("Frame", {
                    Parent = Items["Sidebar"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, 0),
                    Size = UDim2New(1, 0, 0, Window.FooterHeight),
                    ZIndex = 3,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                }) 

                Instances:Create("Frame", {
                    Parent = Items["Footer"].Instance,
                    Size = UDim2New(1, 0, 0, 1),
                    Name = "\0",
                    BorderSizePixel = 0,
                    ZIndex = 3,
                    BackgroundColor3 = FromRGB(24, 24, 24)
                }):AddToTheme({BackgroundColor3 = "Border"})

                Items["Avatar"] = Instances:Create("ImageLabel", {
                    Parent = Items["Footer"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 12, 0.5, 1),
                    Size = UDim2New(0, 36, 0, 36),
                    ScaleType = Enum.ScaleType.Crop,
                    BorderSizePixel = 0,
                    ZIndex = 4,
                    BackgroundColor3 = FromRGB(11, 11, 11)
                })  Items["Avatar"]:AddToTheme({BackgroundColor3 = "Element"})

                Instances:Create("UICorner", {
                    Parent = Items["Avatar"].Instance,
                    CornerRadius = UDimNew(Library.CornerScale, 0)
                }) 

                Instances:Create("UIStroke", {
                    Parent = Items["Avatar"].Instance,
                    Color = FromRGB(182, 182, 192),
                    Thickness = 1.5,
                    Transparency = 0.45,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Light Accent"})

                Items["StatusDot"] = Instances:Create("Frame", {
                    Parent = Items["Avatar"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(1, 1),
                    Position = UDim2New(1, 1, 1, 1),
                    Size = UDim2New(0, 10, 0, 10),
                    BorderSizePixel = 0,
                    ZIndex = 6,
                    BackgroundColor3 = FromRGB(67, 181, 129)
                }) 

                Instances:Create("UICorner", {
                    Parent = Items["StatusDot"].Instance,
                    CornerRadius = UDimNew(Library.CornerScale, 0)
                }) 

                Instances:Create("UIStroke", {
                    Parent = Items["StatusDot"].Instance,
                    Color = FromRGB(14, 14, 14),
                    Thickness = 2,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Background"})

                Items["PlayerName"] = Instances:Create("TextLabel", {
                    Parent = Items["Footer"].Instance,
                    FontFace = Library.BoldFont,
                    Text = "",
                    TextColor3 = FromRGB(255, 255, 255),
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Name = "\0",
                    Position = UDim2New(0, 58, 0.5, -15),
                    Size = UDim2New(1, -66, 0, 16),
                    ZIndex = 4
                })  Items["PlayerName"]:AddToTheme({TextColor3 = "Text"})

                Items["PlayerUser"] = Instances:Create("TextLabel", {
                    Parent = Items["Footer"].Instance,
                    FontFace = Library.Font,
                    Text = "",
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0.5,
                    TextSize = 12,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Name = "\0",
                    Position = UDim2New(0, 58, 0.5, 2),
                    Size = UDim2New(1, -66, 0, 14),
                    ZIndex = 4
                })  Items["PlayerUser"]:AddToTheme({TextColor3 = "Text"})
            end

            -- docked tab (the automatic UI Settings tab lives here, pinned above the player box)
            if Window.DockHeight > 0 then
                Items["Dock"] = Instances:Create("Frame", {
                    Parent = Items["Sidebar"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2New(0, 1),
                    Position = UDim2New(0, 0, 1, -Window.FooterHeight),
                    Size = UDim2New(1, 0, 0, Window.DockHeight),
                    ZIndex = 3,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                }) 

                Instances:Create("Frame", {
                    Parent = Items["Dock"].Instance,
                    Size = UDim2New(1, -28, 0, 1),
                    Position = UDim2New(0, 14, 0, 0),
                    Name = "\0",
                    BorderSizePixel = 0,
                    ZIndex = 3,
                    BackgroundColor3 = FromRGB(24, 24, 24)
                }):AddToTheme({BackgroundColor3 = "Border"})

                Items["DockList"] = Instances:Create("Frame", {
                    Parent = Items["Dock"].Instance,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Position = UDim2New(0, 0, 0, 6),
                    Size = UDim2New(1, 0, 1, -6),
                    ZIndex = 3,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                }) 

                Instances:Create("UIListLayout", {
                    Parent = Items["DockList"].Instance,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    SortOrder = Enum.SortOrder.LayoutOrder
                }) 
            end

            Instances:Create("UICorner", {
                Parent = Items["MainFrame"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            Items["Inline"] = Instances:Create("Frame", {
                Parent = Items["MainFrame"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(0, Sidebar + 1, 0, 0),
                Size = UDim2New(1, -(Sidebar + 1), 1, 0),
                ZIndex = 2,
                ClipsDescendants = true,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 
        end

        -- header marquee: scrolls overflowing title / tags / subtitle back and forth, pauses on hover or touch
        do
            local Scroll = Items["HeaderScroll"].Instance
            local Tweener
            local Hover = false
            local Pending = false

            local Stop = function()
                if Tweener then
                    Tweener:Cancel()
                    Tweener = nil
                end
            end

            local Restart = function()
                Pending = false

                Stop()
                Scroll.CanvasPosition = Vector2New(0, 0)

                local Overflow = Scroll.AbsoluteCanvasSize.X - Scroll.AbsoluteSize.X
                local Scrollable = Overflow > 1

                Scroll.Active = Scrollable
                Scroll.ScrollBarThickness = Scrollable and 2 or 0

                if Scrollable and not Hover then
                    Tweener = TweenService:Create(Scroll, TweenInfo.new(Overflow / 24 + 0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, true, 1.4), {CanvasPosition = Vector2New(Overflow, 0)})
                    Tweener:Play()
                end
            end

            local Queue = function()
                if not Pending then
                    Pending = true
                    task.defer(Restart)
                end
            end

            Library:Connect(Scroll:GetPropertyChangedSignal("AbsoluteCanvasSize"), Queue)
            Library:Connect(Scroll:GetPropertyChangedSignal("AbsoluteSize"), Queue)

            Library:Connect(Scroll.MouseEnter, function()
                Hover = true
                Stop()
            end)

            Library:Connect(Scroll.MouseLeave, function()
                Hover = false
                Queue()
            end)

            Library:Connect(Scroll.InputBegan, function(Input)
                if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Stop()
                end
            end)

            Queue()
        end

        -- zooms around the window's center so open/close/scale animations never drift
        local ZoomTo = function(Target, Info)
            local Gui = Items["MainFrame"].Instance
            local View = Library:GetViewSize()

            local Size = Gui.Size
            local Position = Gui.Position
            local Current = ScaleObject.Scale

            local NewX = Position.X.Offset + Size.X.Offset * Current / 2 - Size.X.Offset * Target / 2
            local NewY = Position.Y.Offset + Size.Y.Offset * Current / 2 - Size.Y.Offset * Target / 2

            if Target >= Window.Scale then
                -- the finished window always stays fully reachable
                NewX = MathClamp(NewX, 0, math.max(0, View.X - Size.X.Offset * Target))
                NewY = MathClamp(NewY, 0, math.max(0, View.Y - Size.Y.Offset * Target))
            end

            local NewPosition = UDim2New(0, MathFloor(NewX), 0, MathFloor(NewY))

            if Info then
                TweenService:Create(ScaleObject, Info, {Scale = Target}):Play()
                TweenService:Create(Gui, Info, {Position = NewPosition}):Play()
            else
                ScaleObject.Scale = Target
                Gui.Position = NewPosition
            end
        end

        local IsPress = function(Input)
            return Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch
        end

        local Debounce = false 

        function Window:SetOpen(Bool)
            if Debounce or Window.IsOpen == Bool then 
                return 
            end

            Window.IsOpen = Bool

            Debounce = true 

            if Bool then 
                Items["MainFrame"].Instance.Visible = true
                ZoomTo(Window.Scale * 0.92)
            else
                Library:ClosePopups()
                Window:SetScalePopover(false)
                Window:SetConfigPanel(false)
            end

            ZoomTo(Bool and Window.Scale or Window.Scale * 0.92, Bool and TweenInfo.new(Window.FadeSpeed + 0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out) or TweenInfo.new(Window.FadeSpeed + 0.05, Enum.EasingStyle.Quint, Enum.EasingDirection.In))

            local Descendants = Items["MainFrame"].Instance:GetDescendants()
            TableInsert(Descendants, Items["MainFrame"].Instance)

            local NewTween
            for Index, Value in Descendants do 
                local ValueIndex = Library:GetTransparencyPropertyFromItem(Value)

                if not ValueIndex then 
                    continue
                end

                if type(ValueIndex) == "table" then
                    for _, Property in ValueIndex do 
                        NewTween = Library:FadeItem(Value, Property, Bool, Window.FadeSpeed)
                    end
                else
                    NewTween = Library:FadeItem(Value, ValueIndex, Bool, Window.FadeSpeed)
                end
            end

            local Finish = function()
                Debounce = false
                Items["MainFrame"].Instance.Visible = Bool

                if not Bool then
                    ZoomTo(Window.Scale)
                end
            end

            if not NewTween then
                Finish()
                return
            end

            Library:Connect(NewTween.Tween.Completed, Finish)
        end

        function Window:SetTitle(Title, Subtitle)
            Window.Title = Title or Window.Title
            Items["Title"].Instance.Text = Window.Title

            if Subtitle ~= nil then
                Window.Subtitle = Subtitle
                Items["Subtitle"].Instance.Text = Subtitle
                Items["Subtitle"].Instance.Visible = Subtitle ~= ""
            end
        end

        -- UI scale (60% - 150%, 5% steps). The window can never outgrow the screen after scaling.
        function Window:SetScale(Value)
            Value = MathClamp(MathFloor((tonumber(Value) or 1) * 20 + 0.5) / 20, 0.6, 1.5)
            Window.Scale = Value

            local Gui = Items["MainFrame"].Instance
            local View = Library:GetViewSize()
            local Size = Gui.Size

            local Width = math.max(MinSize.X, math.min(Size.X.Offset, (View.X - 16) / Value))
            local Height = math.max(MinSize.Y, math.min(Size.Y.Offset, (View.Y - 16) / Value))
            Gui.Size = UDim2New(0, MathFloor(Width), 0, MathFloor(Height))

            ZoomTo(Value, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out))

            if Window.ScaleLabel then
                Window.ScaleLabel.Text = StringFormat("%d%%", MathFloor(Value * 100 + 0.5))
            end

            Window.Settings.Scale = Value

            if Window.SettingsReady then
                Window:SaveSettings()

                if Window.UIRefs and Window.UIRefs.Scale then
                    Window.UIRefs.Scale:Set(MathFloor(Value * 100 + 0.5))
                end
            end
        end

        -- header controls: [scale] [minimize] [close]
        local ScaleButton
        local ConfigButton

        if Window.ControlsWidth > 0 then
            Items["Controls"] = Instances:Create("Frame", {
                Parent = Items["MainFrame"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                AnchorPoint = Vector2New(1, 0),
                Position = UDim2New(1, -12, 0, (Header - 26) / 2),
                Size = UDim2New(0, Window.ControlsWidth - 12, 0, 26),
                BorderSizePixel = 0,
                ZIndex = 60,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Controls"].Instance,
                Padding = UDimNew(0, 4),
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            local CreateControl = function(Order, HoverColor, Draw)
                local Button = Instances:Create("TextButton", {
                    Parent = Items["Controls"].Instance,
                    Text = "",
                    AutoButtonColor = false,
                    BorderSizePixel = 0,
                    Name = "\0",
                    LayoutOrder = Order,
                    BackgroundTransparency = 1,
                    BackgroundColor3 = HoverColor or FromRGB(24, 24, 24),
                    Size = UDim2New(0, 26, 0, 26),
                    ZIndex = 60
                }) 

                if not HoverColor then
                    Button:AddToTheme({BackgroundColor3 = "Border"})
                end

                Instances:Create("UICorner", {
                    Parent = Button.Instance,
                    CornerRadius = UDimNew(Library.CornerScale, 0)
                }) 

                Draw(Button)

                Library:AddPress(Button, 0.86)

                Button:OnHover(function()
                    Button:Tween(nil, {BackgroundTransparency = HoverColor and 0.2 or 0.3})
                end)

                Button:OnHoverLeave(function()
                    Button:Tween(nil, {BackgroundTransparency = 1})
                end)

                return Button
            end

            -- glyphs are drawn with frames so they never depend on a font or an image download
            local Bar = function(Parent, Size, Rotation)
                local Item = Instances:Create("Frame", {
                    Parent = Parent.Instance,
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, 0),
                    Size = Size,
                    Rotation = Rotation or 0,
                    BorderSizePixel = 0,
                    Name = "\0",
                    ZIndex = 61,
                    BackgroundTransparency = 0.1,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Item:AddToTheme({BackgroundColor3 = "Text"})

                Instances:Create("UICorner", {
                    Parent = Item.Instance,
                    CornerRadius = UDimNew(1, 0)
                }) 
            end

            if Window.ConfigManager then
                -- folder glyph, left of the scale button
                ConfigButton = CreateControl(0, nil, function(Button)
                    local Folder = Instances:Create("Frame", {
                        Parent = Button.Instance,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 2),
                        Size = UDim2New(0, 13, 0, 9),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Name = "\0",
                        ZIndex = 61,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    }) 

                    Instances:Create("UICorner", {
                        Parent = Folder.Instance,
                        CornerRadius = UDimNew(Library.CornerScale, 0)
                    }) 

                    Instances:Create("UIStroke", {
                        Parent = Folder.Instance,
                        Color = FromRGB(255, 255, 255),
                        Thickness = 1.5,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    }):AddToTheme({Color = "Text"})

                    local Tab = Instances:Create("Frame", {
                        Parent = Button.Instance,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, -4, 0.5, -4),
                        Size = UDim2New(0, 5, 0, 2),
                        BorderSizePixel = 0,
                        Name = "\0",
                        ZIndex = 61,
                        BackgroundTransparency = 0.1,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    })  Tab:AddToTheme({BackgroundColor3 = "Text"})
                end)
            end

            if Window.Scalable then
                ScaleButton = CreateControl(1, nil, function(Button)
                    local Glyph = Instances:Create("Frame", {
                        Parent = Button.Instance,
                        AnchorPoint = Vector2New(0.5, 0.5),
                        Position = UDim2New(0.5, 0, 0.5, 0),
                        Size = UDim2New(0, 11, 0, 11),
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Name = "\0",
                        ZIndex = 61,
                        BackgroundColor3 = FromRGB(255, 255, 255)
                    }) 

                    Instances:Create("UICorner", {
                        Parent = Glyph.Instance,
                        CornerRadius = UDimNew(Library.CornerScale, 0)
                    }) 

                    Instances:Create("UIStroke", {
                        Parent = Glyph.Instance,
                        Color = FromRGB(255, 255, 255),
                        Thickness = 1.5,
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    }):AddToTheme({Color = "Text"})

                    Bar(Button, UDim2New(0, 5, 0, 2), 0)
                end)
            end

            if Window.Minimizable then
                CreateControl(2, nil, function(Button)
                    Bar(Button, UDim2New(0, 10, 0, 2), 0)
                end):Connect("MouseButton1Click", function()
                    Window:SetMinimized(true)
                end)
            end

            if Window.Closable then
                CreateControl(3, FromRGB(201, 62, 62), function(Button)
                    Bar(Button, UDim2New(0, 12, 0, 2), 45)
                    Bar(Button, UDim2New(0, 12, 0, 2), -45)
                end):Connect("MouseButton1Click", function()
                    Window:Close()
                end)
            end
        end

        -- scale popover: [-]  100%  [+]
        local PopoverOpen = false
        local PopoverId = 0
        local PopoverInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)

        if ScaleButton then
            Items["Popover"] = Instances:Create("Frame", {
                Parent = Items["MainFrame"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                AnchorPoint = Vector2New(1, 0),
                Position = UDim2New(1, -12, 0, Header - 8),
                Size = UDim2New(0, 164, 0, 92),
                Visible = false,
                BorderSizePixel = 0,
                ZIndex = 70,
                BackgroundColor3 = FromRGB(14, 14, 14)
            }) 

            Instances:Create("UICorner", {
                Parent = Items["Popover"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            Items["PopoverStroke"] = Instances:Create("UIStroke", {
                Parent = Items["Popover"].Instance,
                Color = FromRGB(24, 24, 24),
                Transparency = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  Items["PopoverStroke"]:AddToTheme({Color = "Border"})

            Items["PopoverBody"] = Instances:Create("CanvasGroup", {
                Parent = Items["Popover"].Instance,
                Name = "\0",
                Active = true,
                BorderSizePixel = 0,
                Position = UDim2New(0, 0, 0, -6),
                Size = UDim2New(1, 0, 1, 0),
                GroupTransparency = 1,
                ZIndex = 70,
                BackgroundColor3 = FromRGB(14, 14, 14)
            })  Items["PopoverBody"]:AddToTheme({BackgroundColor3 = "Background"})

            Instances:Create("UICorner", {
                Parent = Items["PopoverBody"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            Instances:Create("TextLabel", {
                Parent = Items["PopoverBody"].Instance,
                FontFace = Library.Font,
                Text = "Interface scale",
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.45,
                TextSize = 12,
                TextXAlignment = Enum.TextXAlignment.Left,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Name = "\0",
                Position = UDim2New(0, 12, 0, 9),
                Size = UDim2New(1, -24, 0, 16),
                ZIndex = 71
            }):AddToTheme({TextColor3 = "Text"})

            local Step = function(Text, X, Delta)
                local Button = Instances:Create("TextButton", {
                    Parent = Items["PopoverBody"].Instance,
                    FontFace = Library.BoldFont,
                    Text = Text,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextSize = 18,
                    AutoButtonColor = false,
                    BorderSizePixel = 0,
                    Name = "\0",
                    Position = UDim2New(0, X, 0, 32),
                    Size = UDim2New(0, 36, 0, 28),
                    ZIndex = 71,
                    BackgroundColor3 = FromRGB(11, 11, 11)
                })  Button:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Element"})

                Instances:Create("UICorner", {
                    Parent = Button.Instance,
                    CornerRadius = UDimNew(Library.CornerScale, 0)
                }) 

                Instances:Create("UIStroke", {
                    Parent = Button.Instance,
                    Color = FromRGB(24, 24, 24),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }):AddToTheme({Color = "Border"})

                Library:AddPress(Button, 0.92)

                Button:OnHover(function()
                    Button:Tween(nil, {BackgroundColor3 = Library.Theme.Border})
                end)

                Button:OnHoverLeave(function()
                    Button:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                end)

                Button:Connect("MouseButton1Click", function()
                    Window:SetScale(Window.Scale + Delta)
                end)
            end

            Step("-", 12, -0.1)
            Step("+", 164 - 12 - 36, 0.1)

            Window.ScaleLabel = Instances:Create("TextLabel", {
                Parent = Items["PopoverBody"].Instance,
                FontFace = Library.Font,
                Text = StringFormat("%d%%", MathFloor(Window.Scale * 100 + 0.5)),
                TextColor3 = FromRGB(255, 255, 255),
                TextSize = 14,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Name = "\0",
                Position = UDim2New(0, 54, 0, 32),
                Size = UDim2New(0, 56, 0, 28),
                ZIndex = 71
            })  Window.ScaleLabel:AddToTheme({TextColor3 = "Text"})
            Window.ScaleLabel = Window.ScaleLabel.Instance

            local Reset = Instances:Create("TextButton", {
                Parent = Items["PopoverBody"].Instance,
                FontFace = Library.Font,
                Text = "Reset to 100%",
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.45,
                TextSize = 12,
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Name = "\0",
                Position = UDim2New(0, 12, 0, 66),
                Size = UDim2New(1, -24, 0, 18),
                ZIndex = 71
            })  Reset:AddToTheme({TextColor3 = "Text"})

            Reset:OnHover(function()
                Reset:Tween(nil, {TextTransparency = 0.1})
            end)

            Reset:OnHoverLeave(function()
                Reset:Tween(nil, {TextTransparency = 0.45})
            end)

            Reset:Connect("MouseButton1Click", function()
                Window:SetScale(1)
            end)

            ScaleButton:Connect("MouseButton1Click", function()
                Window:SetScalePopover(not PopoverOpen)
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if PopoverOpen and IsPress(Input) and not Library:IsMouseOverFrame(Items["Popover"]) and not Library:IsMouseOverFrame(ScaleButton) then
                    Window:SetScalePopover(false)
                end
            end)
        end

        function Window:SetScalePopover(Bool)
            if not Items["Popover"] or PopoverOpen == Bool then
                return
            end

            PopoverOpen = Bool

            PopoverId += 1
            local Current = PopoverId

            if Bool then 
                Window:SetConfigPanel(false)

                Items["Popover"].Instance.Visible = true

                Items["PopoverBody"]:Tween(PopoverInfo, {GroupTransparency = 0, Position = UDim2New(0, 0, 0, 0)})
                Items["PopoverStroke"]:Tween(PopoverInfo, {Transparency = 0})
            else
                local Hide = Items["PopoverBody"]:Tween(PopoverInfo, {GroupTransparency = 1, Position = UDim2New(0, 0, 0, -6)})
                Items["PopoverStroke"]:Tween(PopoverInfo, {Transparency = 1})

                Hide.Tween.Completed:Once(function()
                    if Current == PopoverId then
                        Items["Popover"].Instance.Visible = false
                    end
                end)
            end
        end

        -- config manager: panel under the header controls
        local PanelOpen = false
        local PanelId = 0
        local PanelInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local PanelWidth, PanelHeight = 268, 314

        local ConfigSelected = nil
        local ConfigRows = { }
        local DialogOpen = false

        local AutoloadPath = Library.Folders.Directory .. "/autoload.txt"

        local ConfigPath = function(Name)
            return Library.Folders.Configs .. "/" .. Name .. ".json"
        end

        local Notify = function(Text, Description)
            Library:Notification(Text, Description, 4)
        end

        local ReadAutoload = function()
            local Success, Result = pcall(function()
                if isfile(AutoloadPath) then
                    return readfile(AutoloadPath)
                end
            end)

            if Success and type(Result) == "string" then
                return (string.match(Result, "^%s*(.-)%s*$"))
            end

            return nil
        end

        if ConfigButton then
            Items["ConfigPanel"] = Instances:Create("Frame", {
                Parent = Items["MainFrame"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                AnchorPoint = Vector2New(1, 0),
                Position = UDim2New(1, -12, 0, Header - 8),
                Size = UDim2New(0, PanelWidth, 0, PanelHeight),
                Visible = false,
                BorderSizePixel = 0,
                ZIndex = 70,
                BackgroundColor3 = FromRGB(14, 14, 14)
            }) 

            Instances:Create("UICorner", {
                Parent = Items["ConfigPanel"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            Items["ConfigStroke"] = Instances:Create("UIStroke", {
                Parent = Items["ConfigPanel"].Instance,
                Color = FromRGB(24, 24, 24),
                Transparency = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  Items["ConfigStroke"]:AddToTheme({Color = "Border"})

            Items["ConfigBody"] = Instances:Create("CanvasGroup", {
                Parent = Items["ConfigPanel"].Instance,
                Name = "\0",
                Active = true,
                BorderSizePixel = 0,
                Position = UDim2New(0, 0, 0, -6),
                Size = UDim2New(1, 0, 1, 0),
                GroupTransparency = 1,
                ZIndex = 70,
                BackgroundColor3 = FromRGB(14, 14, 14)
            })  Items["ConfigBody"]:AddToTheme({BackgroundColor3 = "Background"})

            Instances:Create("UICorner", {
                Parent = Items["ConfigBody"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            local Body = Items["ConfigBody"].Instance

            local Label = function(Text, X, Y, Width, Height, Size, Bold, Transparency, Alignment)
                local Item = Instances:Create("TextLabel", {
                    Parent = Body,
                    FontFace = Bold and Library.BoldFont or Library.Font,
                    Text = Text,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = Transparency or 0,
                    TextSize = Size or 13,
                    TextXAlignment = Alignment or Enum.TextXAlignment.Left,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Name = "\0",
                    Position = UDim2New(0, X, 0, Y),
                    Size = UDim2New(0, Width, 0, Height),
                    ZIndex = 71
                })  Item:AddToTheme({TextColor3 = "Text"})

                return Item
            end

            local PanelButton = function(Text, X, Y, Width, Style, Callback)
                local Color = Style == "primary" and FromRGB(100, 100, 108) or (Style == "danger" and FromRGB(201, 62, 62) or FromRGB(11, 11, 11))

                local Button = Instances:Create("TextButton", {
                    Parent = Body,
                    FontFace = Library.Font,
                    Text = Text,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextSize = 13,
                    AutoButtonColor = false,
                    BorderSizePixel = 0,
                    Name = "\0",
                    Position = UDim2New(0, X, 0, Y),
                    Size = UDim2New(0, Width, 0, 28),
                    ZIndex = 71,
                    BackgroundColor3 = Color
                })  Button:AddToTheme({TextColor3 = "Text"})

                if Style == "primary" then
                    Button:AddToTheme({BackgroundColor3 = "Accent"})
                elseif Style ~= "danger" then
                    Button:AddToTheme({BackgroundColor3 = "Element"})
                end

                Instances:Create("UICorner", {
                    Parent = Button.Instance,
                    CornerRadius = UDimNew(Library.CornerScale, 0)
                }) 

                if Style ~= "primary" and Style ~= "danger" then
                    Instances:Create("UIStroke", {
                        Parent = Button.Instance,
                        Color = FromRGB(24, 24, 24),
                        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    }):AddToTheme({Color = "Border"})
                end

                Library:AddPress(Button, 0.95)

                Button:OnHover(function()
                    if Style == "primary" or Style == "danger" then
                        Button:Tween(nil, {BackgroundTransparency = 0.2})
                    else
                        Button:Tween(nil, {BackgroundColor3 = Library.Theme.Border})
                    end
                end)

                Button:OnHoverLeave(function()
                    if Style == "primary" or Style == "danger" then
                        Button:Tween(nil, {BackgroundTransparency = 0})
                    else
                        Button:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                    end
                end)

                Button:Connect("MouseButton1Click", Callback)

                return Button
            end

            Label("Config manager", 12, 10, PanelWidth - 24, 16, 13, true)

            -- name box + create
            Items["ConfigName"] = Instances:Create("TextBox", {
                Parent = Body,
                FontFace = Library.Font,
                Text = "",
                PlaceholderText = "New config name",
                PlaceholderColor3 = FromRGB(140, 140, 140),
                TextColor3 = FromRGB(255, 255, 255),
                TextSize = 13,
                ClearTextOnFocus = false,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                Name = "\0",
                Position = UDim2New(0, 12, 0, 34),
                Size = UDim2New(0, PanelWidth - 24 - 78, 0, 28),
                ZIndex = 71,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["ConfigName"]:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Element"})

            Instances:Create("UICorner", {
                Parent = Items["ConfigName"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Instances:Create("UIPadding", {
                Parent = Items["ConfigName"].Instance,
                PaddingLeft = UDimNew(0, 10),
                PaddingRight = UDimNew(0, 10)
            }) 

            Items["ConfigNameStroke"] = Instances:Create("UIStroke", {
                Parent = Items["ConfigName"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  Items["ConfigNameStroke"]:AddToTheme({Color = "Border"})

            Items["ConfigName"]:Connect("Focused", function()
                Items["ConfigNameStroke"]:Tween(PanelInfo, {Color = Library.Theme["Light Accent"]})
            end)

            Items["ConfigName"]:Connect("FocusLost", function()
                Items["ConfigNameStroke"]:Tween(PanelInfo, {Color = Library.Theme.Border})
            end)

            Library:Connect(Items["ConfigName"].Instance:GetPropertyChangedSignal("Text"), function()
                local Box = Items["ConfigName"].Instance
                local Clean = string.sub(StringGSub(Box.Text, "[^%w%-_ ]", ""), 1, 24)

                if Clean ~= Box.Text then
                    Box.Text = Clean
                end
            end)

            -- list
            Items["ConfigList"] = Instances:Create("ScrollingFrame", {
                Parent = Body,
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                CanvasSize = UDim2New(0, 0, 0, 0),
                ScrollBarThickness = 2,
                ScrollBarImageColor3 = FromRGB(100, 100, 108),
                MidImage = Library:GetImage("Scrollbar"),
                TopImage = Library:GetImage("Scrollbar"),
                BottomImage = Library:GetImage("Scrollbar"),
                BorderSizePixel = 0,
                Name = "\0",
                Position = UDim2New(0, 12, 0, 70),
                Size = UDim2New(0, PanelWidth - 24, 0, 126),
                ZIndex = 71,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["ConfigList"]:AddToTheme({BackgroundColor3 = "Inline", ScrollBarImageColor3 = "Accent"})

            Instances:Create("UICorner", {
                Parent = Items["ConfigList"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["ConfigList"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Instances:Create("UIPadding", {
                Parent = Items["ConfigList"].Instance,
                PaddingTop = UDimNew(0, 4),
                PaddingBottom = UDimNew(0, 4),
                PaddingLeft = UDimNew(0, 4),
                PaddingRight = UDimNew(0, 6)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["ConfigList"].Instance,
                Padding = UDimNew(0, 3),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["ConfigEmpty"] = Label("No configs yet", 12, 120, PanelWidth - 24, 18, 12, false, 0.55, Enum.TextXAlignment.Center)

            -- autoload switch
            Label("Autoload selected on startup", 12, 282, PanelWidth - 24 - 44, 20, 12, false, 0.35)

            Items["AutoTrack"] = Instances:Create("Frame", {
                Parent = Body,
                Name = "\0",
                AnchorPoint = Vector2New(1, 0),
                Position = UDim2New(1, -12, 0, 283),
                Size = UDim2New(0, 32, 0, 18),
                BorderSizePixel = 0,
                ZIndex = 71,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["AutoTrack"]:AddToTheme({BackgroundColor3 = "Element"})

            Instances:Create("UICorner", {
                Parent = Items["AutoTrack"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Items["AutoStroke"] = Instances:Create("UIStroke", {
                Parent = Items["AutoTrack"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  Items["AutoStroke"]:AddToTheme({Color = "Border"})

            Items["AutoKnob"] = Instances:Create("Frame", {
                Parent = Items["AutoTrack"].Instance,
                Name = "\0",
                AnchorPoint = Vector2New(0, 0.5),
                Position = UDim2New(0, 3, 0.5, 0),
                Size = UDim2New(0, 12, 0, 12),
                BackgroundTransparency = 0.45,
                BorderSizePixel = 0,
                ZIndex = 72,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["AutoKnob"]:AddToTheme({BackgroundColor3 = "Text"})

            Instances:Create("UICorner", {
                Parent = Items["AutoKnob"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Items["AutoHit"] = Instances:Create("TextButton", {
                Parent = Body,
                Text = "",
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Name = "\0",
                Position = UDim2New(0, 12, 0, 280),
                Size = UDim2New(0, PanelWidth - 24, 0, 24),
                ZIndex = 73
            }) 

            local UpdateAutoSwitch = function()
                local On = ConfigSelected ~= nil and ReadAutoload() == ConfigSelected

                if On then
                    Items["AutoTrack"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                    Items["AutoStroke"]:ChangeItemTheme({Color = "Light Accent"})

                    Items["AutoTrack"]:Tween(PanelInfo, {BackgroundColor3 = Library.Theme.Accent})
                    Items["AutoStroke"]:Tween(PanelInfo, {Color = Library.Theme["Light Accent"]})
                    Items["AutoKnob"]:Tween(PanelInfo, {Position = UDim2New(0, 17, 0.5, 0), BackgroundTransparency = 0})
                else
                    Items["AutoTrack"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                    Items["AutoStroke"]:ChangeItemTheme({Color = "Border"})

                    Items["AutoTrack"]:Tween(PanelInfo, {BackgroundColor3 = Library.Theme.Element})
                    Items["AutoStroke"]:Tween(PanelInfo, {Color = Library.Theme.Border})
                    Items["AutoKnob"]:Tween(PanelInfo, {Position = UDim2New(0, 3, 0.5, 0), BackgroundTransparency = 0.45})
                end
            end

            local RefreshConfigs

            local BuildRow = function(Name, IsAuto, Index)
                local Selected = Name == ConfigSelected

                local Row = Instances:Create("TextButton", {
                    Parent = Items["ConfigList"].Instance,
                    Text = "",
                    AutoButtonColor = false,
                    BorderSizePixel = 0,
                    Name = "\0",
                    LayoutOrder = Index,
                    Size = UDim2New(1, 0, 0, 28),
                    ZIndex = 72,
                    BackgroundTransparency = Selected and 0.84 or 1,
                    BackgroundColor3 = FromRGB(100, 100, 108)
                })  Row:AddToTheme({BackgroundColor3 = "Accent"})

                Instances:Create("UICorner", {
                    Parent = Row.Instance,
                    CornerRadius = UDimNew(Library.CornerScale, 0)
                }) 

                local RowStroke = Instances:Create("UIStroke", {
                    Parent = Row.Instance,
                    Color = FromRGB(182, 182, 192),
                    Transparency = Selected and 0.6 or 1,
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                })  RowStroke:AddToTheme({Color = "Light Accent"})

                Instances:Create("TextLabel", {
                    Parent = Row.Instance,
                    FontFace = Library.Font,
                    Text = Name,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = Selected and 0 or 0.25,
                    TextSize = 13,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    TextTruncate = Enum.TextTruncate.AtEnd,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Name = "\0",
                    Position = UDim2New(0, 10, 0, 0),
                    Size = UDim2New(1, IsAuto and -58 or -20, 1, 0),
                    ZIndex = 73
                }):AddToTheme({TextColor3 = "Text"})

                if IsAuto then
                    local Badge = Instances:Create("TextLabel", {
                        Parent = Row.Instance,
                        FontFace = Library.BoldFont,
                        Text = "AUTO",
                        TextColor3 = FromRGB(182, 182, 192),
                        TextSize = 9,
                        BackgroundTransparency = 1,
                        BorderSizePixel = 0,
                        Name = "\0",
                        AnchorPoint = Vector2New(1, 0.5),
                        Position = UDim2New(1, -8, 0.5, 0),
                        Size = UDim2New(0, 34, 0, 14),
                        ZIndex = 73
                    })  Badge:AddToTheme({TextColor3 = "Light Accent"})
                end

                Row:OnHover(function()
                    if Name ~= ConfigSelected then
                        Row:Tween(nil, {BackgroundTransparency = 0.93})
                    end
                end)

                Row:OnHoverLeave(function()
                    if Name ~= ConfigSelected then
                        Row:Tween(nil, {BackgroundTransparency = 1})
                    end
                end)

                Row:Connect("MouseButton1Click", function()
                    ConfigSelected = Name
                    RefreshConfigs()
                end)

                TableInsert(ConfigRows, Row)
            end

            RefreshConfigs = function()
                for Index, Row in ConfigRows do
                    Row:Clean()
                end

                ConfigRows = { }

                local Names = { }
                local Success, Files = pcall(listfiles, Library.Folders.Configs)

                if Success and type(Files) == "table" then
                    for Index, Path in Files do
                        local Name = string.match(Path, "([^/\\]+)%.json$")

                        if Name then
                            TableInsert(Names, Name)
                        end
                    end
                end

                table.sort(Names, function(A, B)
                    return StringLower(A) < StringLower(B)
                end)

                if ConfigSelected and not table.find(Names, ConfigSelected) then
                    ConfigSelected = nil
                end

                local Auto = ReadAutoload()

                for Index, Name in Names do
                    BuildRow(Name, Name == Auto, Index)
                end

                Items["ConfigEmpty"].Instance.Visible = #Names == 0

                UpdateAutoSwitch()
            end

            local NeedSelection = function()
                if not ConfigSelected then
                    Notify("Config", "Select a config from the list first")
                    return false
                end

                return true
            end

            -- actions
            local ActionWidth = (PanelWidth - 24 - 10) / 3

            PanelButton("Load", 12, 204, ActionWidth, "primary", function()
                if not NeedSelection() then
                    return
                end

                local Success, Content = pcall(readfile, ConfigPath(ConfigSelected))

                if Success and pcall(Library.LoadConfig, Library, Content) then
                    Notify("Config", "Loaded " .. ConfigSelected)
                else
                    Notify("Config", "Could not load " .. ConfigSelected)
                end
            end)

            PanelButton("Save", 12 + ActionWidth + 5, 204, ActionWidth, "default", function()
                if not NeedSelection() then
                    return
                end

                if pcall(writefile, ConfigPath(ConfigSelected), Library:GetConfig()) then
                    Notify("Config", "Saved " .. ConfigSelected)
                else
                    Notify("Config", "Could not save " .. ConfigSelected)
                end
            end)

            PanelButton("Delete", 12 + (ActionWidth + 5) * 2, 204, ActionWidth, "danger", function()
                if not NeedSelection() or DialogOpen then
                    return
                end

                local Target = ConfigSelected
                DialogOpen = true

                Library:Dialog({
                    Parent = Items["MainFrame"],
                    Title = "Delete config?",
                    Description = "\"" .. Target .. "\" will be permanently deleted.",
                    Buttons = {
                        {Name = "Cancel", Callback = function()
                            DialogOpen = false
                        end},
                        {Name = "Delete", Style = "danger", Callback = function()
                            DialogOpen = false

                            pcall(delfile, ConfigPath(Target))

                            if ReadAutoload() == Target then
                                pcall(delfile, AutoloadPath)
                            end

                            Notify("Config", "Deleted " .. Target)
                            RefreshConfigs()
                        end}
                    },
                    OnDismiss = function()
                        DialogOpen = false
                    end
                })
            end)

            local HalfWidth = (PanelWidth - 24 - 5) / 2

            PanelButton("Export", 12, 238, HalfWidth, "default", function()
                if typeof(setclipboard) == "function" then
                    setclipboard(Library:GetConfig())
                    Notify("Config", "Copied the current config to your clipboard")
                else
                    Notify("Config", "Your executor has no clipboard support")
                end
            end)

            PanelButton("Import", 12 + HalfWidth + 5, 238, HalfWidth, "default", function()
                if typeof(getclipboard) ~= "function" then
                    Notify("Config", "Your executor has no clipboard support")
                    return
                end

                if pcall(Library.LoadConfig, Library, getclipboard()) then
                    Notify("Config", "Imported config from clipboard")
                else
                    Notify("Config", "Clipboard does not hold a valid config")
                end
            end)

            -- create (below the list so the first row of buttons stays the main actions)
            PanelButton("Create", PanelWidth - 12 - 70, 34, 70, "primary", function()
                local Name = string.match(Items["ConfigName"].Instance.Text, "^%s*(.-)%s*$")

                if Name == "" then
                    Notify("Config", "Type a name first")
                    return
                end

                if isfile(ConfigPath(Name)) then
                    Notify("Config", "\"" .. Name .. "\" already exists")
                    return
                end

                if pcall(writefile, ConfigPath(Name), Library:GetConfig()) then
                    ConfigSelected = Name
                    Items["ConfigName"].Instance.Text = ""

                    Notify("Config", "Created " .. Name)
                    RefreshConfigs()
                else
                    Notify("Config", "Could not create " .. Name)
                end
            end)

            Items["AutoHit"]:Connect("MouseButton1Click", function()
                if not NeedSelection() then
                    return
                end

                if ReadAutoload() == ConfigSelected then
                    pcall(delfile, AutoloadPath)
                    Notify("Config", "Autoload disabled")
                else
                    pcall(writefile, AutoloadPath, ConfigSelected)
                    Notify("Config", ConfigSelected .. " will load on startup")
                end

                RefreshConfigs()
            end)

            ConfigButton:Connect("MouseButton1Click", function()
                Window:SetConfigPanel(not PanelOpen)
            end)

            Library:Connect(UserInputService.InputBegan, function(Input)
                if PanelOpen and not DialogOpen and IsPress(Input) and not Library:IsMouseOverFrame(Items["ConfigPanel"]) and not Library:IsMouseOverFrame(ConfigButton) then
                    Window:SetConfigPanel(false)
                end
            end)

            Window.RefreshConfigs = RefreshConfigs
        end

        function Window:SetConfigPanel(Bool)
            if not Items["ConfigPanel"] or PanelOpen == Bool then
                return
            end

            PanelOpen = Bool

            PanelId += 1
            local Current = PanelId

            if Bool then 
                Window:SetScalePopover(false)

                Window.RefreshConfigs()

                Items["ConfigPanel"].Instance.Visible = true

                Items["ConfigBody"]:Tween(PanelInfo, {GroupTransparency = 0, Position = UDim2New(0, 0, 0, 0)})
                Items["ConfigStroke"]:Tween(PanelInfo, {Transparency = 0})
            else
                local Hide = Items["ConfigBody"]:Tween(PanelInfo, {GroupTransparency = 1, Position = UDim2New(0, 0, 0, -6)})
                Items["ConfigStroke"]:Tween(PanelInfo, {Transparency = 1})

                Hide.Tween.Completed:Once(function()
                    if Current == PanelId then
                        Items["ConfigPanel"].Instance.Visible = false
                    end
                end)
            end
        end

        -- close (with confirmation)
        function Window:Close()
            if Window.Closing then
                return
            end

            Window.Closing = true

            Library:Dialog({
                Parent = Items["MainFrame"],
                Title = "Close interface?",
                Description = "The interface will be unloaded. Your current settings stay until you re-execute the script.",
                Buttons = {
                    {Name = "Cancel", Style = "default", Callback = function()
                        Window.Closing = false
                    end},
                    {Name = "Close", Style = "danger", Callback = function()
                        if Window.OnClose then
                            Library:SafeCall(Window.OnClose)
                        end

                        Window:SetOpen(false)

                        task.delay(Window.FadeSpeed + 0.35, function()
                            Library:Unload()
                        end)
                    end}
                },
                OnDismiss = function()
                    Window.Closing = false
                end
            })
        end

        Window.Destroy = Window.Close

        -- floating button (shown while minimized). Design notes: 56px circle, 16px screen margin,
        -- snaps to the nearest side after a drag, fades back when idle, scales in/out (no bouncing).
        local FloatSize = 56
        local FloatMargin = 16
        local FloatShowInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local FloatQuick = TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        Window.FloatPosition = Vector2New(FloatMargin, MathFloor(View.Y * 0.45))

        Items["Float"] = Instances:Create("TextButton", {
            Parent = Library.PopupHolder.Instance,
            Name = "\0",
            Text = "",
            AutoButtonColor = false,
            BorderSizePixel = 0,
            Visible = false,
            AnchorPoint = Vector2New(0.5, 0.5),
            Position = UDim2New(0, Window.FloatPosition.X + FloatSize / 2, 0, Window.FloatPosition.Y + FloatSize / 2),
            Size = UDim2New(0, FloatSize, 0, FloatSize),
            BackgroundTransparency = 1,
            ZIndex = 20,
            BackgroundColor3 = FromRGB(14, 14, 14)
        })  Items["Float"]:AddToTheme({BackgroundColor3 = "Background"})

        Instances:Create("UICorner", {
            Parent = Items["Float"].Instance,
            CornerRadius = UDimNew(Library.CornerScale, 0)
        }) 

        Items["FloatScale"] = Instances:Create("UIScale", {
            Parent = Items["Float"].Instance,
            Scale = 0.5
        }) 

        Items["FloatStroke"] = Instances:Create("UIStroke", {
            Parent = Items["Float"].Instance,
            Color = FromRGB(182, 182, 192),
            Thickness = 1.5,
            Transparency = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })  Items["FloatStroke"]:AddToTheme({Color = "Light Accent"})

        Items["FloatGlow"] = Instances:Create("ImageLabel", {
            Parent = Items["Float"].Instance,
            ImageColor3 = FromRGB(100, 100, 108),
            ImageTransparency = 1,
            AnchorPoint = Vector2New(0.5, 0.5),
            Image = "rbxassetid://112971167999062",
            ZIndex = 19,
            BorderSizePixel = 0,
            SliceCenter = RectNew(Vector2New(112, 112), Vector2New(147, 147)),
            ScaleType = Enum.ScaleType.Slice,
            BackgroundTransparency = 1,
            Position = UDim2New(0.5, 0, 0.5, 0),
            SliceScale = 0.8,
            Name = "\0",
            Size = UDim2New(1, 36, 1, 36),
            BackgroundColor3 = FromRGB(255, 255, 255)
        })  Items["FloatGlow"]:AddToTheme({ImageColor3 = "Accent"})

        Items["FloatLogo"] = Instances:Create("ImageLabel", {
            Parent = Items["Float"].Instance,
            AnchorPoint = Vector2New(0.5, 0.5),
            Position = UDim2New(0.5, 0, 0.5, 0),
            Size = UDim2New(0, 28, 0, 28),
            ScaleType = Enum.ScaleType.Fit,
            ImageTransparency = 1,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Name = "\0",
            ZIndex = 21,
            BackgroundColor3 = FromRGB(255, 255, 255)
        })  Items["FloatLogo"]:AddToTheme({ImageColor3 = "Image"})

        Library:ApplyIcon(Items["FloatLogo"], Window.Logo, "rbxassetid://123748867365417")

        local FloatId = 0
        local IdleId = 0
        local Pressed = false
        local Moved = false
        local PressStart
        local PressPosition

        local Wake = function()
            IdleId += 1

            Items["FloatLogo"]:Tween(FloatQuick, {ImageTransparency = 0})
            Items["FloatStroke"]:Tween(FloatQuick, {Transparency = 0.35})
            Items["FloatGlow"]:Tween(FloatQuick, {ImageTransparency = 0.6})
        end

        local ScheduleIdle = function()
            IdleId += 1
            local Current = IdleId

            task.delay(3, function()
                if Current == IdleId and Window.Minimized and not Pressed then
                    Items["FloatLogo"]:Tween(FloatShowInfo, {ImageTransparency = 0.5})
                    Items["FloatStroke"]:Tween(FloatShowInfo, {Transparency = 0.75})
                    Items["FloatGlow"]:Tween(FloatShowInfo, {ImageTransparency = 0.85})
                end
            end)
        end

        local FloatShow = function()
            local Gui = Items["Float"].Instance
            local View = Library:GetViewSize()

            FloatId += 1

            local X = MathClamp(Window.FloatPosition.X, 0, math.max(0, View.X - FloatSize))
            local Y = MathClamp(Window.FloatPosition.Y, 0, math.max(0, View.Y - FloatSize))

            Gui.Position = UDim2New(0, X + FloatSize / 2, 0, Y + FloatSize / 2)
            Gui.Visible = true

            Items["FloatScale"].Instance.Scale = 0.5

            Items["FloatScale"]:Tween(FloatShowInfo, {Scale = 1})
            Items["Float"]:Tween(FloatShowInfo, {BackgroundTransparency = 0})

            Wake()
            ScheduleIdle()
        end

        local FloatHide = function()
            FloatId += 1
            local Current = FloatId

            IdleId += 1

            Items["FloatScale"]:Tween(FloatQuick, {Scale = 0.5})
            Items["Float"]:Tween(FloatQuick, {BackgroundTransparency = 1})
            Items["FloatLogo"]:Tween(FloatQuick, {ImageTransparency = 1})
            Items["FloatStroke"]:Tween(FloatQuick, {Transparency = 1})
            Items["FloatGlow"]:Tween(FloatQuick, {ImageTransparency = 1})

            task.delay(0.2, function()
                if Current == FloatId then
                    Items["Float"].Instance.Visible = false
                end
            end)
        end

        Items["Float"]:OnHover(function()
            if not Pressed then
                Wake()
                Items["FloatScale"]:Tween(FloatQuick, {Scale = 1.08})
            end
        end)

        Items["Float"]:OnHoverLeave(function()
            if not Pressed then
                Items["FloatScale"]:Tween(FloatQuick, {Scale = 1})
                ScheduleIdle()
            end
        end)

        Items["Float"]:Connect("InputBegan", function(Input)
            if IsPress(Input) then
                Pressed = true
                Moved = false

                PressStart = Input.Position
                PressPosition = Items["Float"].Instance.Position

                Items["FloatScale"]:Tween(FloatQuick, {Scale = 0.94})
                Wake()
            end
        end)

        Library:Connect(UserInputService.InputChanged, function(Input)
            if not Pressed then
                return
            end

            if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then
                return
            end

            local Delta = Input.Position - PressStart

            if not Moved and Delta.Magnitude > 6 then
                Moved = true
            end

            if Moved then
                local View = Library:GetViewSize()

                local Half = FloatSize / 2

                local X = MathClamp(PressPosition.X.Offset + Delta.X, Half, math.max(Half, View.X - Half))
                local Y = MathClamp(PressPosition.Y.Offset + Delta.Y, Half, math.max(Half, View.Y - Half))

                Items["Float"].Instance.Position = UDim2New(0, X, 0, Y)
            end
        end)

        Library:Connect(UserInputService.InputEnded, function(Input)
            if not Pressed or not IsPress(Input) then
                return
            end

            Pressed = false

            Items["FloatScale"]:Tween(FloatQuick, {Scale = 1})

            if not Moved then
                Window:SetMinimized(false)
                return
            end

            -- snap to the nearest side
            local Gui = Items["Float"].Instance
            local View = Library:GetViewSize()

            local X = Gui.Position.X.Offset - FloatSize / 2
            local Y = Gui.Position.Y.Offset - FloatSize / 2

            local SnapX = (X + FloatSize / 2 < View.X / 2) and FloatMargin or (View.X - FloatSize - FloatMargin)
            local SnapY = MathClamp(Y, FloatMargin, math.max(FloatMargin, View.Y - FloatSize - FloatMargin))

            Window.FloatPosition = Vector2New(SnapX, SnapY)

            TweenService:Create(Gui, TweenInfo.new(0.32, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2New(0, SnapX + FloatSize / 2, 0, SnapY + FloatSize / 2)}):Play()

            ScheduleIdle()
        end)

        -- waits out a running open/close animation before doing something
        local WhenReady
        WhenReady = function(Function)
            if Debounce then
                task.delay(0.08, function()
                    WhenReady(Function)
                end)
            else
                Function()
            end
        end

        function Window:SetMinimized(Bool)
            if Window.Minimized == Bool then
                return
            end

            Window.Minimized = Bool

            if Bool then
                WhenReady(function()
                    if not Window.Minimized then
                        return
                    end

                    Window:SetOpen(false)

                    task.delay(Window.FadeSpeed + 0.2, function()
                        if Window.Minimized and Items["Float"].Instance.Parent then
                            FloatShow()
                        end
                    end)
                end)
            else
                FloatHide()

                task.delay(0.12, function()
                    WhenReady(function()
                        if not Window.Minimized then
                            Window:SetOpen(true)
                        end
                    end)
                end)
            end
        end

        Library:Connect(UserInputService.InputBegan, function(Input, Gpe)
            if Gpe then 
                return 
            end

            if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
                if Window.Minimized then
                    Window:SetMinimized(false)
                else
                    Window:SetOpen(not Window.IsOpen)
                end
            end

            local Key = tostring(Input.KeyCode)

            if Key ~= "Enum.KeyCode.Unknown" then
                if Window.Minimizable and Key == Window.MinimizeKey then
                    Window:SetMinimized(not Window.Minimized)
                end

                if Window.QuickBar and Key == Window.QuickKey then
                    Window.QuickBar:Toggle()
                end
            end
        end)

        -- Window:SetPlayerBox({Name = "Display", Username = "user", UserId = 1, Avatar = "rbxassetid://...", Status = Color3 | false})
        function Window:SetPlayerBox(Info)
            if not Items["PlayerName"] then
                return
            end

            Info = type(Info) == "table" and Info or { }

            local Username = StringGSub(tostring(Info.Username or Info.username or LocalPlayer.Name), "^@", "")

            Items["PlayerName"].Instance.Text = tostring(Info.Name or Info.name or Info.DisplayName or LocalPlayer.DisplayName)
            Items["PlayerUser"].Instance.Text = "@" .. Username

            local Avatar = Info.Avatar or Info.avatar

            if Avatar then
                Library:ApplyIcon(Items["Avatar"], Avatar)
            else
                local UserId = Info.UserId or Info.userid or LocalPlayer.UserId

                Library:Thread(function()
                    local Success, Content = pcall(Players.GetUserThumbnailAsync, Players, UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)

                    if Success and Content and Items["Avatar"].Instance.Parent then
                        Items["Avatar"].Instance.Image = Content
                    end
                end)
            end

            local Status = Info.Status

            if Status == nil then
                Status = Info.status
            end

            Items["StatusDot"].Instance.Visible = Status ~= false

            if typeof(Status) == "Color3" then
                Items["StatusDot"].Instance.BackgroundColor3 = Status
            end
        end

        Window.Items = Items

        Library:LoadIcons()

        Window:SetPlayerBox(type(Data.PlayerBox) == "table" and Data.PlayerBox or Data.playerbox)

        setmetatable(Window, Library)

        Library.ActiveWindow = Window
        Library:AttachWindowSettings(Window)

        if Data.QuickBar ~= false and Data.quickbar ~= false then
            Window.QuickBar = Library:CreateQuickBar(Window)
        end

        if Window.UISettingsEnabled then
            Library:BuildUISettings(Window)
        end

        Window.SettingsReady = true

        Window:SetTransparency(Store.Transparency)
        Window:SetTagsVisible(Store.ShowTags)
        Window:SetPlayerBoxVisible(Store.ShowPlayer)

        Window:SetOpen(true)
        return Window
    end

    Library.Seperator = function(self)
        return Instances:Create("Frame", {
            Parent = self.Items["Pages"].Instance,
            Name = "\0",
            Size = UDim2New(1, -28, 0, 1),
            BorderColor3 = FromRGB(0, 0, 0),
            ZIndex = 2,
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(24, 24, 24)
        }):AddToTheme({BackgroundColor3 = "Border"})
    end

    -- small caps group label in the sidebar, e.g. Window:Category("Combat")
    Library.Category = function(self, Name)
        local Label = Instances:Create("TextLabel", {
            Parent = self.Items["Pages"].Instance,
            FontFace = Library.BoldFont,
            Text = string.upper(tostring(Name or "")),
            TextColor3 = FromRGB(255, 255, 255),
            TextTransparency = 0.6,
            TextSize = 11,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            BorderColor3 = FromRGB(0, 0, 0),
            Name = "\0",
            Size = UDim2New(1, -28, 0, 20),
            ZIndex = 2
        })  Label:AddToTheme({TextColor3 = "Text"})

        return Label
    end

    Library.Page = function(self, Data)
        Data = Data or { }

        local Page = {
            Window = self,

            Name = Data.Name or Data.name or "Page",
            Icon = Data.Icon or Data.icon or "109391165290124",

            Items = { },
            SubPages = { },

            Active = false,
        }

        local Header = Page.Window.HeaderHeight

        -- the automatic UI Settings tab is docked at the bottom of the sidebar instead of scrolling with the others
        local IsAuto = Data.Auto == true and Page.Window.Items["DockList"] ~= nil

        local TabInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local HoverInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        local Items = { } do
            -- sidebar tab: [indicator] [icon] | [name]
            Items["Inactive"] = Instances:Create("TextButton", {
                Parent = IsAuto and Page.Window.Items["DockList"].Instance or Page.Window.Items["Pages"].Instance,
                FontFace = Library.Font,
                Text = "",
                AutoButtonColor = false,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, -20, 0, 36),
                ZIndex = 3,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(24, 24, 24)
            })  Items["Inactive"]:AddToTheme({BackgroundColor3 = "Border"})

            Instances:Create("UICorner", {
                Parent = Items["Inactive"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Items["UIStroke"] = Instances:Create("UIStroke", {
                Parent = Items["Inactive"].Instance,
                Color = FromRGB(182, 182, 192),
                Transparency = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  Items["UIStroke"]:AddToTheme({Color = "Border"})

            Items["Indicator"] = Instances:Create("Frame", {
                Parent = Items["Inactive"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(0, 0.5),
                Name = "\0",
                Position = UDim2New(0, 0, 0.5, 0),
                Size = UDim2New(0, 3, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(182, 182, 192)
            })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Light Accent"})

            -- keep-round
            Instances:Create("UICorner", {
                Parent = Items["Indicator"].Instance,
                CornerRadius = UDimNew(1, 0)
            }) 

            Items["Icon"] = Instances:Create("ImageLabel", {
                Parent = Items["Inactive"].Instance,
                ScaleType = Enum.ScaleType.Fit,
                ImageTransparency = 0.45,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Image = "",
                BackgroundTransparency = 1,
                AnchorPoint = Vector2New(0, 0.5),
                Position = UDim2New(0, 14, 0.5, 0),
                Size = UDim2New(0, 18, 0, 18),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Icon"]:AddToTheme({ImageColor3 = "Image"})

            Library:ApplyIcon(Items["Icon"], Page.Icon, "rbxassetid://109391165290124")

            Items["IconScale"] = Instances:Create("UIScale", {
                Parent = Items["Icon"].Instance,
                Scale = 1
            }) 

            Items["Label"] = Instances:Create("TextLabel", {
                Parent = Items["Inactive"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.45,
                Text = Page.Name,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Position = UDim2New(0, 44, 0, 0),
                Size = UDim2New(1, -52, 1, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BorderSizePixel = 0,
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Label"]:AddToTheme({TextColor3 = "Text"})

            -- page body. CanvasGroup = one GroupTransparency tween for the whole page (no per-descendant fading)
            Items["PageContent"] = Instances:Create("CanvasGroup", {
                Parent = Page.Window.Items["Inline"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                AnchorPoint = Vector2New(0.5, 0.5),
                Size = UDim2New(1, 0, 1, 0),
                Position = UDim2New(0.5, 0, 0.5, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                Visible = false,
                GroupTransparency = 1,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["PageScale"] = Instances:Create("UIScale", {
                Parent = Items["PageContent"].Instance,
                Scale = 1
            }) 

            -- sub tab bar (scrolls horizontally if the tabs ever outgrow the window)
            Items["SubPages"] = Instances:Create("ScrollingFrame", {
                Parent = Items["PageContent"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Active = false,
                AutomaticCanvasSize = Enum.AutomaticSize.X,
                CanvasSize = UDim2New(0, 0, 0, 0),
                ScrollBarThickness = 0,
                ScrollingDirection = Enum.ScrollingDirection.X,
                BackgroundTransparency = 1,
                Position = UDim2New(0, 14, 0, (Header - 34) / 2),
                Size = UDim2New(1, -(28 + Page.Window.ControlsWidth), 0, 34),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["SubPages"].Instance,
                Padding = UDimNew(0, 6),
                SortOrder = Enum.SortOrder.LayoutOrder,
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center
            }) 

            Instances:Create("UIPadding", {
                Parent = Items["SubPages"].Instance,
                PaddingLeft = UDimNew(0, 2),
                PaddingRight = UDimNew(0, 2)
            }) 

            Items["Columns"] = Instances:Create("Frame", {
                Parent = Items["PageContent"].Instance,
                Size = UDim2New(1, 0, 1, -(Header + 1)),
                BackgroundTransparency = Page.Window.Transparency or 0,
                Name = "\0",
                Position = UDim2New(0, 0, 0, Header + 1),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["Columns"]:AddToTheme({BackgroundColor3 = "Inline"})

            Instances:Create("Frame", {
                Parent = Items["PageContent"].Instance,
                Size = UDim2New(1, 0, 0, 1),
                Name = "\0",
                Position = UDim2New(0, 0, 0, Header),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(24, 24, 24)
            }):AddToTheme({BackgroundColor3 = "Border"})
        end

        local ContentTween
        local TurnId = 0

        function Page:Turn(Bool, Instant)
            if Page.Active == Bool and not Instant then 
                return
            end

            Page.Active = Bool

            TurnId += 1
            local Current = TurnId

            Library:ClosePopups()

            -- sidebar tab animation
            if Bool then 
                Items["Inactive"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                Items["Icon"]:ChangeItemTheme({ImageColor3 = "Light Accent"})
                Items["UIStroke"]:ChangeItemTheme({Color = "Light Accent"})

                Items["Inactive"]:Tween(TabInfo, {BackgroundColor3 = Library.Theme.Accent, BackgroundTransparency = 0.84})
                Items["Icon"]:Tween(TabInfo, {ImageColor3 = Library.Theme["Light Accent"], ImageTransparency = 0})
                Items["Label"]:Tween(TabInfo, {TextTransparency = 0, Position = UDim2New(0, 48, 0, 0)})
                Items["Indicator"]:Tween(TabInfo, {Size = UDim2New(0, 3, 0, 20)})

                if not Instant then
                    Items["IconScale"].Instance.Scale = 0.7
                    Items["IconScale"]:Tween(TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1})
                end
                Items["UIStroke"]:Tween(TabInfo, {Color = Library.Theme["Light Accent"], Transparency = 0.75})
            else
                Items["Inactive"]:ChangeItemTheme({BackgroundColor3 = "Border"})
                Items["Icon"]:ChangeItemTheme({ImageColor3 = "Image"})
                Items["UIStroke"]:ChangeItemTheme({Color = "Border"})

                Items["Inactive"]:Tween(TabInfo, {BackgroundColor3 = Library.Theme.Border, BackgroundTransparency = 1})
                Items["Icon"]:Tween(TabInfo, {ImageColor3 = Library.Theme.Image, ImageTransparency = 0.45})
                Items["Label"]:Tween(TabInfo, {TextTransparency = 0.45, Position = UDim2New(0, 44, 0, 0)})
                Items["Indicator"]:Tween(TabInfo, {Size = UDim2New(0, 3, 0, 0)})
                Items["UIStroke"]:Tween(TabInfo, {Color = Library.Theme.Border, Transparency = 1})
            end

            -- page body: fade out fast, fade in slightly later with a short upward slide
            local Content = Items["PageContent"]

            if ContentTween then
                ContentTween.Tween:Cancel()
                ContentTween = nil
            end

            if Instant then
                Content.Instance.Visible = Bool
                Content.Instance.GroupTransparency = Bool and 0 or 1
                Content.Instance.Position = UDim2New(0.5, 0, 0.5, 0)
                Items["PageScale"].Instance.Scale = 1
                return
            end

            if Bool then 
                if not Content.Instance.Visible or Content.Instance.GroupTransparency >= 0.99 then
                    Content.Instance.Position = UDim2New(0.5, 0, 0.5, 14)
                    Items["PageScale"].Instance.Scale = 0.97
                end

                Content.Instance.Visible = true

                ContentTween = Content:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.08), {GroupTransparency = 0, Position = UDim2New(0.5, 0, 0.5, 0)})
                Items["PageScale"]:Tween(TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.08), {Scale = 1})
            else
                local HideTween = Content:Tween(TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 1})
                ContentTween = HideTween

                HideTween.Tween.Completed:Once(function(State)
                    if Current == TurnId and State == Enum.PlaybackState.Completed then
                        Content.Instance.Visible = false
                    end
                end)
            end
        end

        Library:AddPress(Items["Inactive"], 0.97)

        Items["Inactive"]:Connect("MouseButton1Down", function()
            for Index, Value in Page.Window.Pages do
                Value:Turn(Value == Page)
            end
        end)

        Items["Inactive"]:OnHover(function()
            if Page.Active then 
                return 
            end

            Items["Inactive"]:Tween(HoverInfo, {BackgroundTransparency = 0.55})
            Items["Icon"]:Tween(HoverInfo, {ImageTransparency = 0.15})
            Items["Label"]:Tween(HoverInfo, {TextTransparency = 0.15, Position = UDim2New(0, 47, 0, 0)})
        end)

        Items["Inactive"]:OnHoverLeave(function()
            if Page.Active then 
                return 
            end

            Items["Inactive"]:Tween(HoverInfo, {BackgroundTransparency = 1})
            Items["Icon"]:Tween(HoverInfo, {ImageTransparency = 0.45})
            Items["Label"]:Tween(HoverInfo, {TextTransparency = 0.45, Position = UDim2New(0, 44, 0, 0)})
        end)

        Page.Items = Items

        if not IsAuto and not Page.Window.FirstPageShown then 
            Page.Window.FirstPageShown = true
            Page:Turn(true, true)
        end

        TableInsert(Page.Window.Pages, Page)
        return setmetatable(Page, Library.Pages)
    end

    Library.Pages.SubPage = function(self, Data)
        Data = Data or { }

        local SubPage = {
            Window = self.Window,
            Page = self,

            Name = Data.Name or Data.name or "SubPage",

            Items = { },

            Active = false,
        }

        local TabInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local HoverInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        local Items = { } do 
            -- pill tab: auto width from its text, tinted fill + outline + growing underline when active
            Items["Inactive"] = Instances:Create("TextButton", {
                Parent = SubPage.Page.Items["SubPages"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.45,
                Text = SubPage.Name,
                AutoButtonColor = false,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 30),
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                ZIndex = 3,
                TextSize = 14,
                BackgroundColor3 = FromRGB(100, 100, 108)
            })  Items["Inactive"]:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Accent"})

            Instances:Create("UIPadding", {
                Parent = Items["Inactive"].Instance,
                PaddingLeft = UDimNew(0, 14),
                PaddingRight = UDimNew(0, 14)
            }) 

            Instances:Create("UICorner", {
                Parent = Items["Inactive"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Items["UIStroke"] = Instances:Create("UIStroke", {
                Parent = Items["Inactive"].Instance,
                Color = FromRGB(182, 182, 192),
                Transparency = 1,
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  Items["UIStroke"]:AddToTheme({Color = "Light Accent"})

            Items["Bar"] = Instances:Create("Frame", {
                Parent = Items["Inactive"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(0.5, 1),
                Name = "\0",
                Position = UDim2New(0.5, 0, 1, -2),
                Size = UDim2New(0, 0, 0, 2),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(182, 182, 192)
            })  Items["Bar"]:AddToTheme({BackgroundColor3 = "Light Accent"})

            Instances:Create("UICorner", {
                Parent = Items["Bar"].Instance,
                CornerRadius = UDimNew(1, 0)
            }) 

            Items["PageContent"] = Instances:Create("CanvasGroup", {
                Parent = SubPage.Page.Items["Columns"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                AnchorPoint = Vector2New(0.5, 0.5),
                Size = UDim2New(1, 0, 1, 0),
                Position = UDim2New(0.5, 0, 0.5, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                Visible = false,
                GroupTransparency = 1,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["PageScale"] = Instances:Create("UIScale", {
                Parent = Items["PageContent"].Instance,
                Scale = 1
            }) 

            Items["Right"] = Instances:Create("ScrollingFrame", {
                Parent = Items["PageContent"].Instance,
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                AnchorPoint = Vector2New(1, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                CanvasSize = UDim2New(0, 0, 0, 0),
                ScrollBarImageColor3 = FromRGB(100, 100, 108),
                MidImage = Library:GetImage("Scrollbar"),
                BorderColor3 = FromRGB(0, 0, 0),
                ScrollBarThickness = 2,
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(1, -2, 0, 2),
                Size = UDim2New(0.5, -4, 1, -6),
                BottomImage = Library:GetImage("Scrollbar"),
                TopImage = Library:GetImage("Scrollbar"),
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Right"]:AddToTheme({ScrollBarImageColor3 = "Accent"})

            Instances:Create("UIPadding", {
                Parent = Items["Right"].Instance,
                PaddingTop = UDimNew(0, 12),
                PaddingBottom = UDimNew(0, 14),
                PaddingRight = UDimNew(0, 14),
                PaddingLeft = UDimNew(0, 7)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Right"].Instance,
                Padding = UDimNew(0, 14),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["Left"] = Instances:Create("ScrollingFrame", {
                Parent = Items["PageContent"].Instance,
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ZIndex = 2,
                BorderSizePixel = 0,
                CanvasSize = UDim2New(0, 0, 0, 0),
                ScrollBarImageColor3 = FromRGB(100, 100, 108),
                MidImage = Library:GetImage("Scrollbar"),
                BorderColor3 = FromRGB(0, 0, 0),
                ScrollBarThickness = 2,
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, 2),
                Size = UDim2New(0.5, -4, 1, -6),
                BottomImage = Library:GetImage("Scrollbar"),
                TopImage = Library:GetImage("Scrollbar"),
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Left"]:AddToTheme({ScrollBarImageColor3 = "Accent"})

            Instances:Create("UIPadding", {
                Parent = Items["Left"].Instance,
                PaddingTop = UDimNew(0, 12),
                PaddingBottom = UDimNew(0, 14),
                PaddingRight = UDimNew(0, 7),
                PaddingLeft = UDimNew(0, 14)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Left"].Instance,
                Padding = UDimNew(0, 14),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 
        end

        local ContentTween
        local TurnId = 0

        function SubPage:Turn(Bool, Instant)
            if SubPage.Active == Bool and not Instant then 
                return
            end

            SubPage.Active = Bool

            TurnId += 1
            local Current = TurnId

            Library:ClosePopups()

            if Bool then 
                Items["Inactive"]:Tween(TabInfo, {TextTransparency = 0, BackgroundTransparency = 0.82})
                Items["UIStroke"]:Tween(TabInfo, {Transparency = 0.6})
                Items["Bar"]:Tween(TabInfo, {Size = UDim2New(1, 0, 0, 2)})
            else
                Items["Inactive"]:Tween(TabInfo, {TextTransparency = 0.45, BackgroundTransparency = 1})
                Items["UIStroke"]:Tween(TabInfo, {Transparency = 1})
                Items["Bar"]:Tween(TabInfo, {Size = UDim2New(0, 0, 0, 2)})
            end

            local Content = Items["PageContent"]

            if ContentTween then
                ContentTween.Tween:Cancel()
                ContentTween = nil
            end

            if Instant then
                Content.Instance.Visible = Bool
                Content.Instance.GroupTransparency = Bool and 0 or 1
                Content.Instance.Position = UDim2New(0.5, 0, 0.5, 0)
                Items["PageScale"].Instance.Scale = 1
                return
            end

            if Bool then 
                if not Content.Instance.Visible or Content.Instance.GroupTransparency >= 0.99 then
                    Content.Instance.Position = UDim2New(0.5, 0, 0.5, 12)
                    Items["PageScale"].Instance.Scale = 0.975
                end

                Content.Instance.Visible = true

                ContentTween = Content:Tween(TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.06), {GroupTransparency = 0, Position = UDim2New(0.5, 0, 0.5, 0)})
                Items["PageScale"]:Tween(TweenInfo.new(0.36, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.06), {Scale = 1})
            else
                local HideTween = Content:Tween(TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 1})
                ContentTween = HideTween

                HideTween.Tween.Completed:Once(function(State)
                    if Current == TurnId and State == Enum.PlaybackState.Completed then
                        Content.Instance.Visible = false
                    end
                end)
            end
        end

        -- every page owns its sub tabs (they used to share one window-wide list and switched each other off)
        Library:AddPress(Items["Inactive"], 0.95)

        Items["Inactive"]:Connect("MouseButton1Down", function()
            for Index, Value in SubPage.Page.SubPages do
                Value:Turn(Value == SubPage)
            end
        end)

        Items["Inactive"]:OnHover(function()
            if SubPage.Active then 
                return 
            end

            Items["Inactive"]:Tween(HoverInfo, {TextTransparency = 0.15, BackgroundTransparency = 0.92})
        end)

        Items["Inactive"]:OnHoverLeave(function()
            if SubPage.Active then 
                return 
            end

            Items["Inactive"]:Tween(HoverInfo, {TextTransparency = 0.45, BackgroundTransparency = 1})
        end)

        SubPage.Items = Items

        if #SubPage.Page.SubPages == 0 then 
            SubPage:Turn(true, true)
        end

        TableInsert(SubPage.Page.SubPages, SubPage)
        return setmetatable(SubPage, Library.Pages)
    end

    Library.Pages.Section = function(self, Data)
        Data = Data or { }

        local Section = { 
            Window = self.Window,
            Page = self,

            Name = Data.Name or Data.name or "Section",
            Side = Data.Side or Data.side or "Left",

            Items = { },
        }

        local Items = { } do
            Items["Section"] = Instances:Create("Frame", {
                Parent = Section.Side:lower() == "left" and Section.Page.Items["Left"].Instance or Section.Page.Items["Right"].Instance,
                BorderSizePixel = 0,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 45),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 4,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = FromRGB(14, 14, 14)
            })  Items["Section"]:AddToTheme({BackgroundColor3 = "Background"})

            Instances:Create("UIStroke", {
                Parent = Items["Section"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Section"].Instance,
                FontFace = Library.BoldFont,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Section.Name,
                Name = "\0",
                BorderSizePixel = 0,
                Size = UDim2New(1, 0, 0, 15),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Position = UDim2New(0, 7, 0, 6),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Instances:Create("Frame", {
                Parent = Items["Section"].Instance,
                Size = UDim2New(1, 0, 0, 1),
                Name = "\0",
                Position = UDim2New(0, 0, 0, 27),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(24, 24, 24)
            }):AddToTheme({BackgroundColor3 = "Border"})

            Items["Content"] = Instances:Create("Frame", {
                Parent = Items["Section"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(0, 10, 0, 38),
                Size = UDim2New(1, -20, 0, 0),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Content"].Instance,
                Padding = UDimNew(0, 7),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Instances:Create("UIPadding", {
                Parent = Items["Section"].Instance,
                PaddingBottom = UDimNew(0, 12)
            }) 

            Instances:Create("UICorner", {
                Parent = Items["Section"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 
        end

        function Section:SetVisibility(Bool)
           Items["Section"].Instance.Visible = Bool 
        end

        Section.Items = Items

        return setmetatable(Section, Library.Sections)
    end

Library.Sections.Paragraph = function(self, Data)
    Data = Data or { }

    local ParagraphElement = {
        Window = self.Window,
        Page = self.Page,
        Section = self,
    }

    local Items = { } do
        Items["Paragraph"] = Instances:Create("Frame", {
            Parent = ParagraphElement.Section.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BorderColor3 = FromRGB(0, 0, 0),
            BorderSizePixel = 0,
            ZIndex = 4,
        })

        Items["Text"] = Instances:Create("TextLabel", {
            Parent = Items["Paragraph"].Instance,
            FontFace = Library.Font,
            TextColor3 = FromRGB(255, 255, 255),
            TextTransparency = Data.TextTransparency or 0.3,
            Text = Data.Text or "Paragraph text here",
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Data.Alignment or Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            BorderSizePixel = 0,
            ZIndex = 4,
            TextSize = Data.TextSize or 13,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = FromRGB(255, 255, 255)
        })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

        Items["Padding"] = Instances:Create("UIPadding", {
            Parent = Items["Paragraph"].Instance,
            PaddingTop = UDimNew(0, Data.PaddingTop or 2),
            PaddingBottom = UDimNew(0, Data.PaddingBottom or 2),
            PaddingLeft = UDimNew(0, Data.PaddingLeft or 0),
            PaddingRight = UDimNew(0, Data.PaddingRight or 0),
        })
    end

    function ParagraphElement:SetText(Text)
        Items["Text"].Instance.Text = Text
    end

    function ParagraphElement:SetVisibility(Bool)
        Items["Paragraph"].Instance.Visible = Bool
    end

    function ParagraphElement:Get()
        return Items["Text"].Instance.Text
    end

    return ParagraphElement
end

    Library.Sections.Toggle = function(self, Data)
        Data = Data or { }

        local Toggle = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Toggle",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or false,
            Callback = Data.Callback or Data.callback or function() end,

            Value = false,

            Count = 0
        }

        if not Data.NoPin then
            Library:RegisterPinnable({Type = "Toggle", Name = Toggle.Name, Flag = Toggle.Flag})
        end

        -- switch geometry: 36x20 track, 14px knob, 3px padding (matches the 14px label and the 20px row)
        local TrackWidth, TrackHeight = 36, 20
        local KnobSize, KnobPadding = 14, 3
        local Slide = TweenInfo.new(0.24, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local KnobMove = TweenInfo.new(0.26, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
        local KnobStretch = TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
        local KnobToken = 0

        local Items = { } do
            Items["Toggle"] = Instances:Create("TextButton", {
                Parent = Toggle.Section.Items["Content"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2New(1, 0, 0, 20),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            -- track
            Items["Indicator"] = Instances:Create("Frame", {
                Parent = Items["Toggle"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(1, 0.5),
                Name = "\0",
                Position = UDim2New(1, 0, 0.5, 0),
                Size = UDim2New(0, TrackWidth, 0, TrackHeight),
                ZIndex = 5,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Element"})

            Items["UIStroke"] = Instances:Create("UIStroke", {
                Parent = Items["Indicator"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  Items["UIStroke"]:AddToTheme({Color = "Border"})

            Instances:Create("UICorner", {
                Parent = Items["Indicator"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            -- knob
            Items["Knob"] = Instances:Create("Frame", {
                Parent = Items["Indicator"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(0, 0.5),
                Name = "\0",
                Position = UDim2New(0, KnobPadding, 0.5, 0),
                Size = UDim2New(0, KnobSize, 0, KnobSize),
                BackgroundTransparency = 0.45,
                ZIndex = 6,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Knob"]:AddToTheme({BackgroundColor3 = "Text"})

            Instances:Create("UICorner", {
                Parent = Items["Knob"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            -- horizontal grip stripes on the knob
            for Index = 1, 3 do
                Instances:Create("Frame", {
                    Parent = Items["Knob"].Instance,
                    Name = "\0",
                    AnchorPoint = Vector2New(0.5, 0.5),
                    Position = UDim2New(0.5, 0, 0.5, (Index - 2) * 3),
                    Size = UDim2New(0, 6, 0, 1),
                    BackgroundTransparency = 0.2,
                    BorderSizePixel = 0,
                    ZIndex = 7,
                    BackgroundColor3 = FromRGB(14, 14, 14)
                }):AddToTheme({BackgroundColor3 = "Background"})
            end

            Items["Shadow"] = Instances:Create("ImageLabel", {
                Parent = Items["Indicator"].Instance,
                Visible = true,
                ImageTransparency = 1,
                AnchorPoint = Vector2New(0.5, 0.5),
                Image = "rbxassetid://112971167999062",
                ZIndex = 4,
                BorderSizePixel = 0,
                SliceCenter = RectNew(Vector2New(112, 112), Vector2New(147, 147)),
                ScaleType = Enum.ScaleType.Slice,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(0.5, 0, 0.5, 0),
                SliceScale = 0.6000000238418579,
                ImageColor3 = FromRGB(100, 100, 108),
                Size = UDim2New(1, 12, 1, 12),
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Shadow"]:AddToTheme({ImageColor3 = "Accent"})

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Toggle"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.5,
                Text = Toggle.Name,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, -(TrackWidth + 8), 1, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BorderSizePixel = 0,
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
        end

        -- the knob glides across while squashing wider/shorter mid-way, then settles back to a circle
        local MoveKnob = function(Value)
            KnobToken += 1
            local Current = KnobToken

            Items["Knob"]:Tween(KnobMove, {
                Position = UDim2New(0, Value and (TrackWidth - KnobSize - KnobPadding) or KnobPadding, 0.5, 0),
                BackgroundTransparency = Value and 0 or 0.45
            })

            local Stretch = Items["Knob"]:Tween(KnobStretch, {Size = UDim2New(0, KnobSize + 5, 0, KnobSize - 2)})

            Stretch.Tween.Completed:Once(function()
                if Current == KnobToken then
                    Items["Knob"]:Tween(KnobStretch, {Size = UDim2New(0, KnobSize, 0, KnobSize)})
                end
            end)
        end

        function Toggle:Get()
            return Toggle.Value
        end

        function Toggle:Set(Value, IsKeybind)
            if IsKeybind then 
                Value = IsKeybind.Toggled
            end

            Value = Value and true or false
            Toggle.Value = Value

            Library.Flags[Toggle.Flag] = Value 

            -- one tween group, one easing: track color, outline, knob slide, glow and label all move together
            if Value then 
                Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                Items["UIStroke"]:ChangeItemTheme({Color = "Light Accent"})

                Items["Indicator"]:Tween(Slide, {BackgroundColor3 = Library.Theme.Accent})
                Items["UIStroke"]:Tween(Slide, {Color = Library.Theme["Light Accent"]})
                MoveKnob(true)
                Items["Shadow"]:Tween(Slide, {ImageTransparency = 0.68})
                Items["Text"]:Tween(Slide, {TextTransparency = 0})
            else
                Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                Items["UIStroke"]:ChangeItemTheme({Color = "Border"})

                Items["Indicator"]:Tween(Slide, {BackgroundColor3 = Library.Theme.Element})
                Items["UIStroke"]:Tween(Slide, {Color = Library.Theme.Border})
                MoveKnob(false)
                Items["Shadow"]:Tween(Slide, {ImageTransparency = 1})
                Items["Text"]:Tween(Slide, {TextTransparency = 0.5})
            end

            if Toggle.Callback then 
                Library:SafeCall(Toggle.Callback, Value)
            end
        end

        function Toggle:SetVisiblity(Bool)
            Items["Toggle"].Instance.Visible = Bool
        end

        function Toggle:Colorpicker(Data)
            Data = Data or { }

            local Colorpicker = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Colorpicker",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or Color3.new(1, 1, 1),
                Callback = Data.Callback or Data.callback or function() end,
                Alpha = Data.Alpha or Data.alpha or 0,

                Parent = Items["Toggle"],
                Count = Toggle.Count,
                IsToggle = true,
            }

            Toggle.Count += 1
            Colorpicker.Count = Toggle.Count

            local Extension = Library:CreateColorpicker(Colorpicker)
            return Extension
        end

        function Toggle:Keybind(Data)
            Data = Data or { }

            local Keybind = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Keybind",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or Enum.KeyCode.RightShift,
                Mode = Data.Mode or Data.mode or "Toggle",
                Callback = Data.Callback or Data.callback or function() end,

                Key = nil,
                Picking = false,
                Value = "",
                Toggled = false,
                Count = Toggle.Count,
            }

            Toggle.Count += 1
            Keybind.Count = Toggle.Count

            local SubItems = { } do 
                SubItems["KeyButton"] = Instances:Create("TextButton", {
                    Parent = Items["Toggle"].Instance,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    TextTransparency = 0,
                    Text = "None",
                    Name = "\0",
                    BorderColor3 = FromRGB(0, 0, 0),
                    Size = UDim2New(0, 0, 0, 15),
                    BackgroundTransparency = 1,
                    AutomaticSize = Enum.AutomaticSize.X,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AnchorPoint = Vector2New(1, 0.5),
                    ZIndex = 4,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  SubItems["KeyButton"]:AddToTheme({TextColor3 = "Text"})

                local CalculateCount = function(Index)
                    local MaxButtonsAdded = 5

                    local Column = Index % MaxButtonsAdded
                
                    local ButtonSize = SubItems["KeyButton"].Instance.AbsoluteSize
                    local Spacing = 4
                
                    local XPosition = (ButtonSize.X + Spacing) * Column - Spacing - ButtonSize.X
                
                    SubItems["KeyButton"].Instance.Position = UDim2New(1, Index == 1 and -XPosition - 46 or -XPosition, 0.5, 0)
                end

                CalculateCount(Keybind.Count)
                
                function Keybind:Get()
                    return Keybind.Toggled, Keybind.Key
                end

                function Keybind:SetVisibility(Bool)
                    SubItems["KeyButton"].Instance.Visible = Bool
                end

                function Keybind:Set(Key)
                    if StringFind(tostring(Key), "Enum") then 
                        Keybind.Key = tostring(Key)

                        Key = Key.Name == "Backspace" and "None" or Key.Name

                        local KeyString = Keys[Keybind.Key] or StringGSub(Key, "Enum.", "") or "None"
                        local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                        Keybind.Value = TextToDisplay
                        SubItems["KeyButton"].Instance.Text = TextToDisplay

                        Library.Flags[Keybind.Flag] = {
                            Mode = Keybind.Mode,
                            Key = Keybind.Key,
                            Toggled = Keybind.Toggled
                        }

                        if Keybind.Callback then 
                            Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                        end

                    elseif TableFind({"Hold", "Toggle", "Always"}, Key) then 
                        Keybind.Mode = Key

                        Keybind:SetMode(Keybind.Mode)

                        if Keybind.Callback then 
                            Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                        end
                    elseif type(Key) == "table" then 
                        local RealKey = Key.Key == "Backspace" and "None" or Key.Key
                        Keybind.Key = tostring(Key.Key)

                        if Key.Mode then
                            Keybind.Mode = Key.Mode
                            Keybind:SetMode(Key.Mode)
                        else
                            Keybind.Mode = "Toggle"
                            Keybind:SetMode("Toggle")
                        end

                        local KeyString = Keys[Keybind.Key] or StringGSub(tostring(RealKey), "Enum.", "") or RealKey
                        local TextToDisplay = KeyString and StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                        TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "")

                        Keybind.Value = TextToDisplay
                        SubItems["KeyButton"].Instance.Text = TextToDisplay

                        if Keybind.Callback then 
                            Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                        end
                    end

                    Keybind.Picking = false 
                    SubItems["KeyButton"]:ChangeItemTheme({TextColor3 = "Text"})
                    SubItems["KeyButton"]:Tween(nil, {TextColor3 = Library.Theme.Text})
                end

                function Keybind:SetMode(Mode)
                    if Keybind.Mode == "Always" then 
                        Keybind.Toggled = true
                    else
                        Keybind.Toggled = false
                    end

                    Library.Flags[Keybind.Flag] = {
                        Mode = Keybind.Mode,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }

                    if Keybind.Callback then 
                        Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                    end
                end

                function Keybind:Press(Bool)
                    if Keybind.Mode == "Toggle" then
                        Keybind.Toggled = not Keybind.Toggled
                    elseif Keybind.Mode == "Hold" then
                        Keybind.Toggled = Bool
                    elseif Keybind.Mode == "Always" then
                        Keybind.Toggled = true
                    end

                    Toggle:Set(nil, Keybind)

                    Library.Flags[Keybind.Flag] = {
                        Mode = Keybind.Mode,
                        Key = Keybind.Key,
                        Toggled = Keybind.Toggled
                    }

                    if Keybind.Callback then 
                        Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                    end 
                end

                SubItems["KeyButton"]:Connect("MouseButton1Click", function()
                    if Keybind.Picking then 
                        return
                    end

                    Keybind.Picking = true

                    SubItems["KeyButton"]:ChangeItemTheme({TextColor3 = "Accent"})
                    SubItems["KeyButton"]:Tween(nil, {TextColor3 = Library.Theme.Accent})

                    local InputBegan 
                    InputBegan = UserInputService.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.Keyboard then 
                            Keybind:Set(Input.KeyCode)
                        else
                            Keybind:Set(Input.UserInputType)
                        end

                        InputBegan:Disconnect()
                        InputBegan = nil
                    end)
                end)

                Library:Connect(UserInputService.InputBegan, function(Input)
                    if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
                        if Keybind.Value == "None" then 
                            return 
                        end
                        
                        if Keybind.Mode == "Toggle" then 
                            Keybind:Press()
                        elseif Keybind.Mode == "Hold" then 
                            Keybind:Press(true)
                        end
                    end
                end)

                Library:Connect(UserInputService.InputEnded, function(Input)
                    if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then 
                        if Keybind.Value == "None" then 
                            return 
                        end

                        if Keybind.Mode == "Hold" then 
                            Keybind:Press(false)
                        end
                    end
                end)

                if Keybind.Default then
                    Keybind:Set({Key = Keybind.Default, Mode = Keybind.Mode or "Toggle"})
                end

                Library.SetFlags[Keybind.Flag] = function(Value)
                    Keybind:Set(Value)
                end

                return Keybind
            end
        end

        Items["Toggle"]:Connect("MouseButton1Down", function()
            Toggle:Set(not Toggle.Value)
        end)

        if Toggle.Default then 
            Toggle:Set(Toggle.Default)
        end

        Library.SetFlags[Toggle.Flag] = function(Value)
            Toggle:Set(Value)
        end

        return Toggle
    end

Library.Sections.Paragraph = function(self, Data)
    Data = Data or { }

    local Items = { } do
        Items["Paragraph"] = Instances:Create("Frame", {
            Parent = self.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            BorderColor3 = FromRGB(0, 0, 0),
            BorderSizePixel = 0,
            ZIndex = 4,
        })

        Items["Title"] = Instances:Create("TextLabel", {
            Parent = Items["Paragraph"].Instance,
            FontFace = Library.BoldFont,
            TextColor3 = FromRGB(255, 255, 255),
            Text = Data.Title or "Title",
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Data.Alignment or Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            BorderSizePixel = 0,
            ZIndex = 4,
            TextSize = Data.TitleSize or 15,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = FromRGB(255, 255, 255)
        })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

        Items["Description"] = Instances:Create("TextLabel", {
            Parent = Items["Paragraph"].Instance,
            FontFace = Library.Font,
            TextColor3 = FromRGB(255, 255, 255),
            TextTransparency = Data.DescriptionTransparency or 0.4,
            Text = Data.Description or "Description text here",
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Data.Alignment or Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
            BorderSizePixel = 0,
            ZIndex = 4,
            TextSize = Data.DescriptionSize or 13,
            AutomaticSize = Enum.AutomaticSize.Y,
            Position = UDim2New(0, 0, 0, 20),
            BackgroundColor3 = FromRGB(255, 255, 255)
        })  Items["Description"]:AddToTheme({TextColor3 = "Text"})

        Items["Padding"] = Instances:Create("UIPadding", {
            Parent = Items["Paragraph"].Instance,
            PaddingTop = UDimNew(0, Data.PaddingTop or 4),
            PaddingBottom = UDimNew(0, Data.PaddingBottom or 4),
            PaddingLeft = UDimNew(0, Data.PaddingLeft or 0),
            PaddingRight = UDimNew(0, Data.PaddingRight or 0),
        })
    end

    local ParagraphElement = { Items = Items }
    
    function ParagraphElement:SetTitle(Text)
        self.Items["Title"].Instance.Text = Text
    end

    function ParagraphElement:SetDescription(Text)
        self.Items["Description"].Instance.Text = Text
    end

    function ParagraphElement:SetVisibility(Bool)
        self.Items["Paragraph"].Instance.Visible = Bool
    end

    function ParagraphElement:Get()
        return {
            Title = self.Items["Title"].Instance.Text,
            Description = self.Items["Description"].Instance.Text
        }
    end

    return ParagraphElement
end

    Library.Sections.Button = function(self, Data)
        Data = Data or { }

        local Button = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Button",
            Callback = Data.Callback or Data.callback or function() end
        }

        local Items = { } do
            Items["Button"] = Instances:Create("TextButton", {
                Parent = Button.Section.Items["Content"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Button.Name,
                AutoButtonColor = false,
                Name = "\0",
                BorderSizePixel = 0,
                Size = UDim2New(1, 0, 0, 20),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["Button"]:AddToTheme({BackgroundColor3 = "Element", TextColor3 = "Text"})

            Instances:Create("UICorner", {
                Parent = Items["Button"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Items["UIStroke"] = Instances:Create("UIStroke", {
                Parent = Items["Button"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  Items["UIStroke"]:AddToTheme({Color = "Border"})
        end

        Library:AddPress(Items["Button"], 0.98)

        if not Data.NoPin then
            Library:RegisterPinnable({Type = "Button", Name = Button.Name, Callback = function()
                Library:SafeCall(Button.Callback)
            end})
        end

        function Button:Press()
            Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
            Items["UIStroke"]:ChangeItemTheme({Color = "Light Accent"})

            Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
            Items["UIStroke"]:Tween(nil, {Color = Library.Theme["Light Accent"]})

            task.wait(0.1)

            Items["Button"]:ChangeItemTheme({BackgroundColor3 = "Element"})
            Items["UIStroke"]:ChangeItemTheme({Color = "Border"})

            Items["Button"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
            Items["UIStroke"]:Tween(nil, {Color = Library.Theme.Border})

            Library:SafeCall(Button.Callback)
        end

        function Button:SetVisibility(Bool)
            Items["Button"].Instance.Visible = Bool
        end

        function Button:SubButton(Data)
            local SubButton = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Button",
                Callback = Data.Callback or Data.callback or function() end
            }

            local ButtonHolder = Instances:Create("Frame", {
                Parent = Button.Section.Items["Content"].Instance,
                BackgroundTransparency = 1,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, 0, 0, 20),
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })

            Items["Button"].Instance.Parent = ButtonHolder.Instance
            Items["Button"].Instance.Size =  UDim2New(0.48, 1, 0, 20)

            local SubItems = { } do
                SubItems["SubButton"] = Instances:Create("TextButton", {
                    Parent = ButtonHolder.Instance,
                    FontFace = Library.Font,
                    TextColor3 = FromRGB(255, 255, 255),
                    BorderColor3 = FromRGB(0, 0, 0),
                    Text = SubButton.Name,
                    AutoButtonColor = false,
                    AnchorPoint = Vector2New(1, 0),
                    BorderSizePixel = 0,
                    Name = "\0",
                    Position = UDim2New(1, 0, 0, 0),
                    Size = UDim2New(0.48, 1, 0, 20),
                    ZIndex = 4,
                    TextSize = 14,
                    BackgroundColor3 = FromRGB(11, 11, 11)
                })  SubItems["SubButton"]:AddToTheme({BackgroundColor3 = "Element", TextColor3 = "Text"})

                Instances:Create("UICorner", {
                    Parent = SubItems["SubButton"].Instance,
                    CornerRadius = UDimNew(Library.CornerScale, 0)
                }) 

                SubItems["UIStroke"] = Instances:Create("UIStroke", {
                    Parent = SubItems["SubButton"].Instance,
                    Color = FromRGB(24, 24, 24),
                    ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                }) 
            end

            function SubButton:Press()
                SubItems["SubButton"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                SubItems["UIStroke"]:ChangeItemTheme({Color = "Light Accent"})

                SubItems["SubButton"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                SubItems["UIStroke"]:Tween(nil, {Color = Library.Theme["Light Accent"]})

                task.wait(0.1)

                SubItems["SubButton"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                SubItems["UIStroke"]:ChangeItemTheme({Color = "Border"})

                SubItems["SubButton"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                SubItems["UIStroke"]:Tween(nil, {Color = Library.Theme.Border})

                Library:SafeCall(SubButton.Callback)
            end

            function SubButton:SetVisibility(Bool)
                SubItems["SubButton"].Instance.Visible = Bool
            end

            SubItems["SubButton"]:Connect("MouseButton1Down", function()
                SubButton:Press()
            end)
            
            return SubButton
        end

        Items["Button"]:Connect("MouseButton1Down", function()
            Button:Press()
        end)

        return Button
    end

    Library.Sections.Slider = function(self, Data)
    Data = Data or { }

    local Slider = { 
        Window = self.Window,
        Page = self.Page,
        Section = self,

        Name = Data.Name or Data.name or "Slider",
        Flag = Data.Flag or Data.flag or Library:NextFlag(),
        Min = Data.Min or Data.min or 0,
        Default = Data.Default or Data.default or 0,
        Max = Data.Max or Data.max or 100,
        Suffix = Data.Suffix or Data.suffix or "",
        Decimals = Data.Decimals or Data.decimals or 1,
        Callback = Data.Callback or Data.callback or function() end,

        Value = 0,
        Sliding = false
    }

    local Items = { } do
        Items["Slider"] = Instances:Create("Frame", {
            Parent = Slider.Section.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 28),
            BorderColor3 = FromRGB(0, 0, 0),
            ZIndex = 4,
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(255, 255, 255)
        }) 

        Items["Text"] = Instances:Create("TextLabel", {
            Parent = Items["Slider"].Instance,
            FontFace = Library.Font,
            TextColor3 = FromRGB(255, 255, 255),
            BorderColor3 = FromRGB(0, 0, 0),
            Text = Slider.Name,
            Name = "\0",
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            Size = UDim2New(1, 0, 0, 15),
            ZIndex = 4,
            TextSize = 14,
            BackgroundColor3 = FromRGB(255, 255, 255)
        })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

        Items["Value"] = Instances:Create("TextLabel", {
            Parent = Items["Slider"].Instance,
            FontFace = Library.Font,
            TextColor3 = FromRGB(255, 255, 255),
            BorderColor3 = FromRGB(0, 0, 0),
            Text = "0",
            Name = "\0",
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Right,
            Size = UDim2New(1, 0, 0, 15),
            ZIndex = 4,
            TextSize = 14,
            BackgroundColor3 = FromRGB(255, 255, 255)
        })  Items["Value"]:AddToTheme({TextColor3 = "Text"})

        Items["RealSlider"] = Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            BorderColor3 = FromRGB(0, 0, 0),
            AnchorPoint = Vector2New(0, 1),
            Name = "\0",
            Position = UDim2New(0, 0, 1, 0),
            Size = UDim2New(1, 0, 0, 2),
            ZIndex = 5,
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(11, 11, 11)
        })  Items["RealSlider"]:AddToTheme({BackgroundColor3 = "Element"})

        Items["Accent"] = Instances:Create("Frame", {
            Parent = Items["RealSlider"].Instance,
            Name = "\0",
            Size = UDim2New(0.5, 0, 1, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            ZIndex = 5,
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(100, 100, 108)
        })  Items["Accent"]:AddToTheme({BackgroundColor3 = "Accent"})

        Items["Drag"] = Instances:Create("TextButton", {
            Parent = Items["Accent"].Instance,
            FontFace = Library.Font,
            TextColor3 = FromRGB(0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            Text = "",
            AutoButtonColor = false,
            AnchorPoint = Vector2New(0, 0.5),
            BorderSizePixel = 0,
            Name = "\0",
            Position = UDim2New(1, -8, 0.5, 0),
            Size = UDim2New(0, 15, 0, 15),
            ZIndex = 5,
            TextSize = 14,
            BackgroundColor3 = FromRGB(100, 100, 108)
        })  Items["Drag"]:AddToTheme({BackgroundColor3 = "Accent"})

        Instances:Create("UICorner", {
            Parent = Items["Drag"].Instance,
            CornerRadius = UDimNew(Library.CornerScale, 0)
        }) 
    end

    Library:AddPress(Items["Drag"], 1.25)

    if not Data.NoPin then
        Library:RegisterPinnable({Type = "Slider", Name = Slider.Name, Flag = Slider.Flag, Min = Slider.Min, Max = Slider.Max, Decimals = Slider.Decimals, Suffix = Slider.Suffix})
    end

    function Slider:Get()
        return Slider.Value
    end

    function Slider:Set(Value)
        Slider.Value = MathClamp(Library:Round(Value, Slider.Decimals), Slider.Min, Slider.Max)
        Library.Flags[Slider.Flag] = Slider.Value
        Items["Accent"]:Tween(TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Size = UDim2New((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
        })
        Items["Value"].Instance.Text = StringFormat("%s%s", tostring(Slider.Value), Slider.Suffix)
        if Slider.Callback then 
            Library:SafeCall(Slider.Callback, Slider.Value)
        end
    end

    function Slider:SetVisibility(Bool)
        Items["Slider"].Instance.Visible = Bool
    end

    local function GetSliderValue(Input)
        local RelativeX = Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X
        local SizeX = MathClamp(RelativeX / Items["RealSlider"].Instance.AbsoluteSize.X, 0, 1)
        return ((Slider.Max - Slider.Min) * SizeX) + Slider.Min
    end

    local function UpdateSlider(Input)
        if not Slider.Sliding then return end
        local Value = GetSliderValue(Input)
        Slider:Set(MathClamp(Library:Round(Value, Slider.Decimals), Slider.Min, Slider.Max))
    end

    local Connection

    Items["Drag"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Slider.Sliding = true
            UpdateSlider(Input)
        end
    end)

    Items["Drag"]:Connect("InputEnded", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Slider.Sliding = false
            if Connection then
                Connection:Disconnect()
                Connection = nil
            end
        end
    end)

    Items["RealSlider"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Slider.Sliding = true
            UpdateSlider(Input)
        end
    end)

    Items["RealSlider"]:Connect("InputEnded", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Slider.Sliding = false
            if Connection then
                Connection:Disconnect()
                Connection = nil
            end
        end
    end)

    Connection = UserInputService.InputChanged:Connect(function(Input)
        if Slider.Sliding then
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                UpdateSlider(Input)
            end
        end
    end)

    if Slider.Default then
        Slider:Set(Slider.Default)
    end

    Library.SetFlags[Slider.Flag] = function(Value)
        Slider:Set(Value)
    end

    return Slider
end

    Library.Sections.Dropdown = function(self, Data)
        Data = Data or { }

        local Dropdown = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Dropdown",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Items = Data.Items or Data.items or { "One", "Two", "Three" },
            Default = Data.Default or Data.default or nil,
            MaxSize = Data.MaxSize or Data.maxsize or 75,
            Callback = Data.Callback or Data.callback or function() end,
            Multi = Data.Multi or Data.multi or false,

            Value = { },
            IsOpen = false,
            Options = { },
        }

        if not Data.NoPin and not Dropdown.Multi then
            Library:RegisterPinnable({Type = "Dropdown", Name = Dropdown.Name, Flag = Dropdown.Flag, Items = Dropdown.Items})
        end

        local Items = { } do
            Items["Dropdown"] = Instances:Create("Frame", {
                Parent = Dropdown.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 42),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Dropdown"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Dropdown.Name,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2New(1, 0, 0, 15),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Items["OptionHolder"] = Instances:Create("TextButton", {
                Parent = Items["Dropdown"].Instance,
                AutoButtonColor = false,
                Visible = false,
                Text = "",
                Size = UDim2New(1, 0, 0, Dropdown.MaxSize),
                Name = "\0",
                Position = UDim2New(0, 0, 0, 45),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 25,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["OptionHolder"]:AddToTheme({BackgroundColor3 = "Inline"})

            Instances:Create("UIStroke", {
                Parent = Items["OptionHolder"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Items["Holder"] = Instances:Create("ScrollingFrame", {
                Parent = Items["OptionHolder"].Instance,
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ZIndex = 25,
                BorderSizePixel = 0,
                CanvasSize = UDim2New(0, 0, 0, 0),
                ScrollBarImageColor3 = FromRGB(100, 100, 108),
                MidImage = Library:GetImage("Scrollbar"),
                BorderColor3 = FromRGB(0, 0, 0),
                ScrollBarThickness = 2,
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(0, 5, 0, 5),
                Size = UDim2New(1, -10, 1, -10),
                BottomImage = Library:GetImage("Scrollbar"),
                TopImage = Library:GetImage("Scrollbar"),
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Holder"]:AddToTheme({ScrollBarImageColor3 = "Accent"})

            Instances:Create("UIListLayout", {
                Parent = Items["Holder"].Instance,
                Padding = UDimNew(0, 3),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["RealDropdown"] = Instances:Create("TextButton", {
                Parent = Items["Dropdown"].Instance,
                AutoButtonColor = false,
                Text = "",
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(0, 0),
                Name = "\0",
                Position = UDim2New(0, 0, 0, 21),
                Size = UDim2New(1, 0, 0, 21),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["RealDropdown"]:AddToTheme({BackgroundColor3 = "Element"})

            Instances:Create("UIStroke", {
                Parent = Items["RealDropdown"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Instances:Create("UICorner", {
                Parent = Items["RealDropdown"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Items["Value"] = Instances:Create("TextLabel", {
                Parent = Items["RealDropdown"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(255, 255, 255),
                Text = "--",
                Name = "\0",
                TextTruncate = Enum.TextTruncate.AtEnd,
                Size = UDim2New(1, -35, 1, 0),
                Position = UDim2New(0, 4, 0, 1),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Value"]:AddToTheme({TextColor3 = "Text"})

            Items["OpenIcon"] = Instances:Create("ImageLabel", {
                Parent = Items["RealDropdown"].Instance,
                ScaleType = Enum.ScaleType.Fit,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Size = UDim2New(0, 10, 0, 10),
                AnchorPoint = Vector2New(1, 0.5),
                Image = "rbxassetid://86523506890491",
                BackgroundTransparency = 1,
                Position = UDim2New(1, -6, 0.5, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["OpenIcon"]:AddToTheme({ImageColor3 = "Image"})
        end

        local Debounce = false

        function Dropdown:Set(Option)
            if Data.Multi then
                if type(Option) ~= "table" then 
                    return
                end

                Dropdown.Value = Option
                Library.Flags[Dropdown.Flag] = Dropdown.Value

                for Index, Value in Option do 
                    local OptionData = Dropdown.Options[Value]
                    
                    if not OptionData then 
                        return
                    end

                    OptionData.Selected = true
                    OptionData:Toggle("Active")
                end

                Items["Value"].Instance.Text = TableConcat(Option, ", ")
            else
                local OptionData = Dropdown.Options[Option]

                if not OptionData then 
                    return 
                end

                OptionData.Selected = true  
                OptionData:Toggle("Active")

                Dropdown.Value = OptionData.Name
                Library.Flags[Dropdown.Flag] = Dropdown.Value

                for Index, Value in Dropdown.Options do 
                    if Value ~= OptionData then 
                        Value.Selected = false
                        Value:Toggle("Inactive")
                    end
                end

                Items["Value"].Instance.Text = Dropdown.Value
            end

            if Data.Callback then 
                Library:SafeCall(Data.Callback, Dropdown.Value)
            end
        end

        function Dropdown:SetOpen(Bool)
            if Debounce then 
                return 
            end

            Dropdown.IsOpen = Bool

            Debounce = true 

            if Bool then 
                Items["OptionHolder"].Instance.Visible = true
            end

            -- grow the row so the list is part of the layout (never clipped by the column)
            Items["Dropdown"]:Tween(nil, {Size = Bool and UDim2New(1, 0, 0, 45 + Dropdown.MaxSize) or UDim2New(1, 0, 0, 42)})

            local Descendants = Items["OptionHolder"].Instance:GetDescendants()
            TableInsert(Descendants, Items["OptionHolder"].Instance)

            local NewTween
            for Index, Value in Descendants do 
                local ValueIndex = Library:GetTransparencyPropertyFromItem(Value)

                if not ValueIndex then 
                    continue
                end

                if type(ValueIndex) == "table" then
                    for _, Property in ValueIndex do 
                        NewTween = Library:FadeItem(Value, Property, Bool, Dropdown.Window.FadeSpeed)
                    end
                else
                    NewTween = Library:FadeItem(Value, ValueIndex, Bool,  Dropdown.Window.FadeSpeed)
                end
            end

            Library:Connect(NewTween.Tween.Completed, function()
                Debounce = false
                Items["OptionHolder"].Instance.Visible = Bool
            end)
        end

        function Dropdown:Remove(Option)
            if Dropdown.Options[Option] then
                Dropdown.Options[Option].Button:Clean()
            end

            Dropdown.Options[Option] = nil
        end

        function Dropdown:Refresh(List)
            for Index, Value in Dropdown.Options do 
                Dropdown:Remove(Value.Name)
            end

            for Index, Value in List do 
                Dropdown:Add(Value)
            end
        end

        function Dropdown:Add(Option)
            local OptionButton = Instances:Create("TextButton", {
                Parent = Items["Holder"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.5,
                Text = Option,
                Name = "\0",
                AutoButtonColor = false,
                BorderColor3 = FromRGB(0, 0, 0),
                Size = UDim2New(1, -5, 0, 20),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                ZIndex = 25,
                TextSize = 14,
                BackgroundColor3 = FromRGB(14, 14, 14)
            })  OptionButton:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Background"})

            Instances:Create("UICorner", {
                Parent = OptionButton.Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            local UIPadding = Instances:Create("UIPadding", {
                Parent = OptionButton.Instance,
                PaddingLeft = UDimNew(0, 7)
            }) 
        
            local OptionData = {
                Name = Option,
                Button = OptionButton,
                Padding = UIPadding,
                Selected = false
            }

            function OptionData:Toggle(Status)
                if Status == "Active" then
                    OptionData.Button:ChangeItemTheme({TextColor3 = "Accent"})
                    OptionData.Button:Tween(nil, {TextColor3 = Library.Theme.Accent, BackgroundTransparency = 0, TextTransparency = 0})
                    UIPadding:Tween(nil, {PaddingLeft = UDimNew(0, 12)})
                else
                    OptionData.Button:ChangeItemTheme({TextColor3 = "Text"})
                    OptionData.Button:Tween(nil, {TextColor3 = Library.Theme.Text, BackgroundTransparency = 1, TextTransparency = 0.5})
                    UIPadding:Tween(nil, {PaddingLeft = UDimNew(0, 7)})
                end
            end

            function OptionData:Set()
                OptionData.Selected = not OptionData.Selected

                if Dropdown.Multi then 
                    local Index = TableFind(Dropdown.Value, OptionData.Name)

                    if Index then 
                        TableRemove(Dropdown.Value, Index)
                    else
                        TableInsert(Dropdown.Value, OptionData.Name)
                    end

                    Library.Flags[Dropdown.Flag] = Dropdown.Value

                    OptionData:Toggle(Index and "Inactive" or "Active")

                    local TextFormat = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "--"

                    Items["Value"].Instance.Text = TextFormat
                else
                    if OptionData.Selected then
                        Dropdown.Value = OptionData.Name

                        OptionData:Toggle("Active")
                        Items["Value"].Instance.Text = OptionData.Name

                        Library.Flags[Dropdown.Flag] = Dropdown.Value

                        for Index, Value in Dropdown.Options do 
                            if Value ~= OptionData then 
                                Value.Selected = false
                                Value:Toggle("Inactive")
                            end
                        end
                    else
                        Dropdown.Value = nil

                        OptionData:Toggle("Inactive")
                        Items["Value"].Instance.Text = "--"

                        Library.Flags[Dropdown.Flag] = Dropdown.Value
                    end
                end

                if Data.Callback then 
                    Library:SafeCall(Data.Callback, Dropdown.Value)
                end
            end

            OptionData.Button:Connect("MouseButton1Down", function()
                OptionData:Set()
            end)

            Dropdown.Options[Option] = OptionData
            return OptionData
        end

        function Dropdown:SetVisibility(Bool)
            Items["Dropdown"].Instance.Visible = Bool
        end
 
        Items["RealDropdown"]:Connect("MouseButton1Down", function()
            Dropdown:SetOpen(not Dropdown.IsOpen)
        end)

        Library:Connect(UserInputService.InputBegan, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 and Dropdown.IsOpen and not Debounce and not Library:IsMouseOverFrame(Items["OptionHolder"]) then
                Dropdown:SetOpen(false)
            end
        end)

        for Index, Value in Dropdown.Items do 
            Dropdown:Add(Value)
        end

        if Dropdown.Default then
            Dropdown:Set(Dropdown.Default)
        end

        Library.SetFlags[Dropdown.Flag] = function(Value)
            Dropdown:Set(Value)
        end

        return Dropdown
    end

    Library.Sections.Label = function(self, Text, Alignment)
        local Label = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Text or "Label",
            Alignment = Alignment or "Left",

            Count = 0
        }
        
        local Items = { } do
            Items["Label"] = Instances:Create("Frame", {
                Parent = Label.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 15),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Label"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Label.Name,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment[Label.Alignment],
                Size = UDim2New(1, 0, 0, 15),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
        end

        function Label:Colorpicker(Data)
            Data = Data or { }

            local Colorpicker = {
                Window = self.Window,
                Page = self.Page,
                Section = self,

                Name = Data.Name or Data.name or "Colorpicker",
                Flag = Data.Flag or Data.flag or Library:NextFlag(),
                Default = Data.Default or Data.default or Color3.new(1, 1, 1),
                Callback = Data.Callback or Data.callback or function() end,
                Alpha = Data.Alpha or Data.alpha or 0,

                Parent = Items["Label"],
                Count = Label.Count
            }

            Label.Count += 1
            Colorpicker.Count = Label.Count

            local Extension = Library:CreateColorpicker(Colorpicker)
            return Extension
        end

        return Label
    end

    -- Standalone color picker row:  Section:Colorpicker({Name = "ESP Color", Default = Color3.fromRGB(255, 0, 0), Flag = "esp_color", Callback = function(Color, Alpha) end})
    Library.Sections.Colorpicker = function(self, Data)
        Data = Data or { }

        local Picker = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Colorpicker",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or Color3.new(1, 1, 1),
            Callback = Data.Callback or Data.callback or function() end,
            Alpha = Data.Alpha or Data.alpha or 0,
        }

        local Items = { } do
            Items["Colorpicker"] = Instances:Create("Frame", {
                Parent = Picker.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 18),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Colorpicker"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Picker.Name,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Size = UDim2New(1, -100, 1, 0),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Items["Hex"] = Instances:Create("TextLabel", {
                Parent = Items["Colorpicker"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.5,
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "#FFFFFF",
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                AnchorPoint = Vector2New(1, 0.5),
                Position = UDim2New(1, -24, 0.5, 0),
                TextXAlignment = Enum.TextXAlignment.Right,
                Size = UDim2New(0, 70, 1, 0),
                ZIndex = 4,
                TextSize = 12,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Hex"]:AddToTheme({TextColor3 = "Text"})
        end

        local Extension = Library:CreateColorpicker({
            Window = Picker.Window,
            Page = Picker.Page,
            Section = Picker.Section,

            Name = Picker.Name,
            Flag = Picker.Flag,
            Default = Picker.Default,
            Alpha = Picker.Alpha,

            Parent = Items["Colorpicker"],
            Count = 1,

            Callback = function(Color, Alpha)
                Items["Hex"].Instance.Text = "#" .. string.upper(Color:ToHex())
                Library:SafeCall(Picker.Callback, Color, Alpha)
            end
        })

        function Picker:Get()
            return Extension:Get()
        end

        function Picker:GetHex()
            return Extension:GetHex()
        end

        function Picker:Set(Color, Alpha)
            return Extension:Set(Color, Alpha)
        end

        function Picker:SetVisibility(Bool)
            Items["Colorpicker"].Instance.Visible = Bool

            if not Bool then
                Extension:SetOpen(false)
            end
        end

        Picker.Colorpicker = Extension
        Picker.Items = Items

        return Picker
    end

    -- Section:Card({
    --     Title = "Auto Farm", Description = "Farms nearby mobs.",
    --     Image = "bolt",                    -- solar icon name, asset id or rbxassetid://
    --     ImagePosition = "Left",            -- "Left" | "Right" | "Top" | "Bottom"
    --     ImageSize = 56,                    -- number or UDim2 (Left/Right: square size, Top/Bottom: height)
    --     ImageColor = Color3.new(1, 1, 1),  -- optional tint (nice for solar icons)
    --     ImageFit = true,                   -- true = fit (icons), false = crop (photos); default depends on position
    --     ButtonPosition = "Bottom",         -- "Bottom" | "Right" | "Inline" (under the description)
    --     ButtonAlignment = "Right",         -- "Left" | "Center" | "Right" (Bottom / Inline)
    --     Buttons = {{Name = "Run", Style = "primary", Callback = function() end}, {Name = "More", Callback = function() end}}
    -- })
    Library.Sections.Card = function(self, Data)
        Data = Data or { }

        local Card = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Title = Data.Title or Data.title or Data.Name or Data.name or "Card",
            Description = Data.Description or Data.description or "",
            Image = Data.Image or Data.image or Data.Icon or Data.icon,
            ImagePosition = StringLower(Data.ImagePosition or Data.imageposition or "Left"),
            ImageColor = Data.ImageColor or Data.imagecolor,
            ButtonPosition = StringLower(Data.ButtonPosition or Data.buttonposition or "Bottom"),
            ButtonAlignment = StringLower(Data.ButtonAlignment or Data.buttonalignment or "Right"),
        }

        local Position = Card.ImagePosition
        local IsSide = Position == "left" or Position == "right"
        local IsEdge = Position == "top" or Position == "bottom"
        local IsBackground = false

        local ImageSize = Data.ImageSize or Data.imagesize or (IsSide and 56 or 96)
        local SideWidth = 0

        if IsSide then
            if typeof(ImageSize) == "UDim2" then
                SideWidth = ImageSize.X.Offset
            elseif typeof(ImageSize) == "Vector2" then
                SideWidth = ImageSize.X
            else
                SideWidth = tonumber(ImageSize) or 56
            end
        end

        local Fit = Data.ImageFit
        if Fit == nil then Fit = Data.imagefit end
        if Fit == nil then Fit = IsSide end

        local Quick = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        local Items = { } do 
            Items["Card"] = Instances:Create("Frame", {
                Parent = Card.Section.Items["Content"].Instance,
                Name = "\0",
                Size = UDim2New(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["Card"]:AddToTheme({BackgroundColor3 = "Element"})

            Instances:Create("UICorner", {
                Parent = Items["Card"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["Card"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Instances:Create("UIPadding", {
                Parent = Items["Card"].Instance,
                PaddingTop = UDimNew(0, 10),
                PaddingBottom = UDimNew(0, 10),
                PaddingLeft = UDimNew(0, 10),
                PaddingRight = UDimNew(0, 10)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Card"].Instance,
                Padding = UDimNew(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            -- the image (one ImageLabel, placed according to ImagePosition)
            if Card.Image ~= nil and Card.Image ~= "" then
                local Parent = Items["Card"].Instance
                local Size = UDim2New(0, 56, 0, 56)
                local Order = 0

                if IsSide then
                    Size = typeof(ImageSize) == "UDim2" and ImageSize or UDim2New(0, SideWidth, 0, typeof(ImageSize) == "Vector2" and ImageSize.Y or SideWidth)
                elseif IsEdge then
                    Size = typeof(ImageSize) == "UDim2" and ImageSize or UDim2New(1, 0, 0, tonumber(ImageSize) or 96)
                    Order = Position == "top" and 0 or 3
                elseif IsBackground then
                    Size = UDim2New(1, 0, 1, 0)
                end

                Items["Image"] = Instances:Create("ImageLabel", {
                    Parent = Parent,
                    Name = "\0",
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Size = Size,
                    ScaleType = Fit and Enum.ScaleType.Fit or Enum.ScaleType.Crop,
                    ImageColor3 = Card.ImageColor or FromRGB(255, 255, 255),
                    ImageTransparency = IsBackground and 0.72 or 0,
                    LayoutOrder = Order,
                    ZIndex = IsBackground and 4 or 5,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                }) 

                if not Card.ImageColor and Fit then
                    Items["Image"]:AddToTheme({ImageColor3 = "Image"})
                end

                Instances:Create("UICorner", {
                    Parent = Items["Image"].Instance,
                    CornerRadius = IsSide and UDimNew(Library.CornerScale, 0) or UDimNew(0, 6)
                }) 

                Library:ApplyIcon(Items["Image"], Card.Image)
            end

            -- body row: [image] [text column] [side buttons]
            Items["Row"] = Instances:Create("Frame", {
                Parent = Items["Card"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2New(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1,
                ZIndex = 5,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Row"].Instance,
                Padding = UDimNew(0, 10),
                FillDirection = Enum.FillDirection.Horizontal,
                VerticalAlignment = Enum.VerticalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            if Items["Image"] and IsSide then
                Items["Image"].Instance.Parent = Items["Row"].Instance
                Items["Image"].Instance.LayoutOrder = Position == "left" and 0 or 2
            end

            local ReservedWidth = (IsSide and Items["Image"] and (SideWidth + 10) or 0) + (Card.ButtonPosition == "right" and 100 or 0)

            Items["TextColumn"] = Instances:Create("Frame", {
                Parent = Items["Row"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2New(1, -ReservedWidth, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1,
                ZIndex = 5,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            -- flex lets the text column take exactly the leftover width (falls back to the fixed width above)
            pcall(function()
                Instances:Create("UIFlexItem", {
                    Parent = Items["TextColumn"].Instance,
                    FlexMode = Enum.UIFlexMode.Fill
                })
            end)

            Instances:Create("UIListLayout", {
                Parent = Items["TextColumn"].Instance,
                Padding = UDimNew(0, 3),
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 

            Items["Title"] = Instances:Create("TextLabel", {
                Parent = Items["TextColumn"].Instance,
                FontFace = Library.BoldFont,
                TextColor3 = FromRGB(255, 255, 255),
                Text = Card.Title,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Size = UDim2New(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 1,
                ZIndex = 6,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

            Items["Description"] = Instances:Create("TextLabel", {
                Parent = Items["TextColumn"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.45,
                Text = Card.Description,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
                Visible = Card.Description ~= "",
                Size = UDim2New(1, 0, 0, 0),
                AutomaticSize = Enum.AutomaticSize.Y,
                LayoutOrder = 2,
                ZIndex = 6,
                TextSize = 13,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Description"]:AddToTheme({TextColor3 = "Text"})

            -- button container, parented according to ButtonPosition
            local ButtonParent = Items["Card"].Instance
            local ButtonOrder = 2
            local Vertical = false

            if Card.ButtonPosition == "right" then
                ButtonParent = Items["Row"].Instance
                ButtonOrder = Position == "right" and 3 or 2
                Vertical = true
            elseif Card.ButtonPosition == "inline" then
                ButtonParent = Items["TextColumn"].Instance
                ButtonOrder = 3
            end

            Items["Buttons"] = Instances:Create("Frame", {
                Parent = ButtonParent,
                Name = "\0",
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = Vertical and UDim2New(0, 0, 0, 0) or UDim2New(1, 0, 0, 0),
                AutomaticSize = Vertical and Enum.AutomaticSize.XY or Enum.AutomaticSize.Y,
                LayoutOrder = ButtonOrder,
                Visible = false,
                ZIndex = 5,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Instances:Create("UIListLayout", {
                Parent = Items["Buttons"].Instance,
                Padding = UDimNew(0, 6),
                FillDirection = Vertical and Enum.FillDirection.Vertical or Enum.FillDirection.Horizontal,
                HorizontalAlignment = (Card.ButtonAlignment == "left" and Enum.HorizontalAlignment.Left) or (Card.ButtonAlignment == "center" and Enum.HorizontalAlignment.Center) or Enum.HorizontalAlignment.Right,
                SortOrder = Enum.SortOrder.LayoutOrder
            }) 
        end

        local Styles = {
            default = {Color = FromRGB(24, 24, 24), Theme = "Border"},
            primary = {Color = FromRGB(100, 100, 108), Theme = "Accent"},
            danger = {Color = FromRGB(201, 62, 62)},
        }

        local ButtonCount = 0

        -- Card:Button({Name = "Open", Style = "primary", Callback = function() end})  (also used for Data.Buttons)
        function Card:Button(Info)
            Info = Info or { }

            ButtonCount += 1

            local Style = Styles[StringLower(Info.Style or Info.style or "default")] or Styles.default

            local Button = Instances:Create("TextButton", {
                Parent = Items["Buttons"].Instance,
                FontFace = Library.Font,
                Text = Info.Name or Info.name or "Button",
                TextColor3 = FromRGB(255, 255, 255),
                TextSize = 13,
                AutoButtonColor = false,
                BorderSizePixel = 0,
                Name = "\0",
                AutomaticSize = Enum.AutomaticSize.X,
                Size = UDim2New(0, 0, 0, 26),
                LayoutOrder = ButtonCount,
                ZIndex = 6,
                BackgroundColor3 = Style.Color
            })  Button:AddToTheme({TextColor3 = "Text"})

            if Style.Theme then
                Button:AddToTheme({BackgroundColor3 = Style.Theme})
            end

            Instances:Create("UIPadding", {
                Parent = Button.Instance,
                PaddingLeft = UDimNew(0, 14),
                PaddingRight = UDimNew(0, 14)
            }) 

            Instances:Create("UICorner", {
                Parent = Button.Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Library:AddPress(Button, 0.95)

            Button:OnHover(function()
                Button:Tween(Quick, {BackgroundTransparency = 0.25})
            end)

            Button:OnHoverLeave(function()
                Button:Tween(Quick, {BackgroundTransparency = 0})
            end)

            Button:Connect("MouseButton1Click", function()
                Library:SafeCall(Info.Callback or Info.callback or function() end)
            end)

            Items["Buttons"].Instance.Visible = true

            return Button
        end

        function Card:SetTitle(Text)
            Card.Title = Text
            Items["Title"].Instance.Text = Text
        end

        function Card:SetDescription(Text)
            Card.Description = Text
            Items["Description"].Instance.Text = Text
            Items["Description"].Instance.Visible = Text ~= ""
        end

        function Card:SetImage(Image)
            if Items["Image"] then
                Card.Image = Image
                Library:ApplyIcon(Items["Image"], Image)
            end
        end

        function Card:SetVisibility(Bool)
            Items["Card"].Instance.Visible = Bool
        end

        for Index, Info in Data.Buttons or Data.buttons or { } do
            Card:Button(Info)
        end

        if Data.Button or Data.button then
            Card:Button(Data.Button or Data.button)
        end

        Card.Items = Items

        return Card
    end

    Library.Sections.Keybind = function(self, Data)
        Data = Data or { }

        local Keybind = { 
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Keybind",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or Enum.KeyCode.RightShift,
            Callback = Data.Callback or Data.callback or function() end,
            Mode = Data.Mode or Data.mode or "Toggle",

            Key = nil,
            Value = "",
            Toggled = false,
            Picking = false
        }

        Library.Flags[Keybind.Flag] = { }

        local Items = { } do
            Items["Keybind"] = Instances:Create("Frame", {
                Parent = Keybind.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 42),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Keybind"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Keybind.Name,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2New(1, 0, 0, 15),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Items["RealKeybind"] = Instances:Create("TextButton", {
                Parent = Items["Keybind"].Instance,
                AutoButtonColor = false,
                Text = "",
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(0, 1),
                Name = "\0",
                Position = UDim2New(0, 0, 1, 0),
                Size = UDim2New(1, 0, 0, 21),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["RealKeybind"]:AddToTheme({BackgroundColor3 = "Element"})

            Instances:Create("UIStroke", {
                Parent = Items["RealKeybind"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Instances:Create("UICorner", {
                Parent = Items["RealKeybind"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Items["Value"] = Instances:Create("TextLabel", {
                Parent = Items["RealKeybind"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(255, 255, 255),
                Text = "None",
                Name = "\0",
                BorderSizePixel = 0,
                Size = UDim2New(1, -16, 1, 0),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Position = UDim2New(0, 4, 0, 1),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Value"]:AddToTheme({TextColor3 = "Text"})
        end

        function Keybind:Get()
            return Keybind.Toggled, Keybind.Key
        end

        function Keybind:SetVisibility(Bool)
            Items["Keybind"].Instance.Visible = Bool
        end

        function Keybind:Set(Key)
            if StringFind(tostring(Key), "Enum") then 
                Keybind.Key = tostring(Key)

                Key = Key.Name == "Backspace" and "None" or Key.Name

                local KeyString = Keys[Keybind.Key] or StringGSub(Key, "Enum.", "") or "None"
                local TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                Keybind.Value = TextToDisplay
                Items["Value"].Instance.Text = TextToDisplay

                Library.Flags[Keybind.Flag] = {
                    Mode = Keybind.Mode,
                    Key = Keybind.Key,
                    Toggled = Keybind.Toggled
                }

                if Keybind.Callback then 
                    Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                end

            elseif TableFind({"Hold", "Toggle", "Always"}, Key) then 
                Keybind.Mode = Key

                Keybind:SetMode(Keybind.Mode)

                if Keybind.Callback then 
                    Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                end
            elseif type(Key) == "table" then 
                 local RealKey = Key.Key == "Backspace" and "None" or Key.Key
                Keybind.Key = tostring(Key.Key)

                if Key.Mode then
                    Keybind.Mode = Key.Mode
                    Keybind:SetMode(Key.Mode)
                else
                    Keybind.Mode = "Toggle"
                    Keybind:SetMode("Toggle")
                end

                local KeyString = Keys[Keybind.Key] or StringGSub(tostring(RealKey), "Enum.", "") or RealKey
                local TextToDisplay = KeyString and StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "") or "None"

                TextToDisplay = StringGSub(StringGSub(KeyString, "KeyCode.", ""), "UserInputType.", "")

                Keybind.Value = TextToDisplay
                Items["Value"].Instance.Text = TextToDisplay

                if Keybind.Callback then 
                    Library:SafeCall(Keybind.Callback, Keybind.Toggled)
                end
            end

            Keybind.Picking = false 
            Items["Value"]:ChangeItemTheme({TextColor3 = "Text"})
            Items["Value"]:Tween(nil, {TextColor3 = Library.Theme.Text})
        end

        function Keybind:SetMode(Mode)
            if Keybind.Mode == "Always" then 
                Keybind.Toggled = true
            else
                Keybind.Toggled = false
            end

            Library.Flags[Keybind.Flag] = {
                Mode = Keybind.Mode,
                Key = Keybind.Key,
                Toggled = Keybind.Toggled
            }

            if Keybind.Callback then 
                Library:SafeCall(Keybind.Callback, Keybind.Toggled)
            end
        end

        function Keybind:Press(Bool)
            if Keybind.Mode == "Toggle" then
                Keybind.Toggled = not Keybind.Toggled
            elseif Keybind.Mode == "Hold" then
                Keybind.Toggled = Bool
            elseif Keybind.Mode == "Always" then
                Keybind.Toggled = true
            end

            Library.Flags[Keybind.Flag] = {
                Mode = Keybind.Mode,
                Key = Keybind.Key,
                Toggled = Keybind.Toggled
            }

            if Keybind.Callback then 
                Library:SafeCall(Keybind.Callback, Keybind.Toggled)
            end 
        end

        Items["RealKeybind"]:Connect("MouseButton1Click", function()
            if Keybind.Picking then 
                return
            end

            Keybind.Picking = true

            Items["Value"]:ChangeItemTheme({TextColor3 = "Accent"})
            Items["Value"]:Tween(nil, {TextColor3 = Library.Theme.Accent})

            local InputBegan 
            InputBegan = UserInputService.InputBegan:Connect(function(Input)
                if Input.UserInputType == Enum.UserInputType.Keyboard then 
                    Keybind:Set(Input.KeyCode)
                else
                    Keybind:Set(Input.UserInputType)
                end

                InputBegan:Disconnect()
                InputBegan = nil
            end)
        end)

        Library:Connect(UserInputService.InputBegan, function(Input)
            if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then
                if Keybind.Value == "None" then 
                    return 
                end
                
                if Keybind.Mode == "Toggle" then 
                    Keybind:Press()
                elseif Keybind.Mode == "Hold" then 
                    Keybind:Press(true)
                end
            end
        end)

        Library:Connect(UserInputService.InputEnded, function(Input)
            if tostring(Input.KeyCode) == Keybind.Key or tostring(Input.UserInputType) == Keybind.Key then 
                if Keybind.Value == "None" then 
                    return 
                end

                if Keybind.Mode == "Hold" then 
                    Keybind:Press(false)
                end
            end
        end)

        if Keybind.Default then
            Keybind:Set({Key = Keybind.Default, Mode = Keybind.Mode or "Toggle"})
        end

        Library.SetFlags[Keybind.Flag] = function(Value)
            Keybind:Set(Value)
        end

        return Keybind
    end

    -- Section:Input({Name = "Webhook", Placeholder = "https://...", Icon = "link", Numeric = false, MaxLength = 100, Live = false, Callback = function(Text) end})
    -- Callback fires when the box loses focus (Enter / click away); set Live = true to fire on every keystroke.
    Library.Sections.Input = function(self, Data)
        Data = Data or { }

        local Input = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Input",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or "",
            Callback = Data.Callback or Data.callback or function() end,
            Placeholder = Data.Placeholder or Data.placeholder or "Type here...",
            Icon = Data.Icon or Data.icon,
            Numeric = Data.Numeric or Data.numeric or false,
            MaxLength = Data.MaxLength or Data.maxlength,
            Live = Data.Live or Data.live or false,
            ClearOnFocus = Data.ClearOnFocus or Data.clearonfocus or false,

            Value = ""
        }

        local Smooth = TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local TextPadding = Input.Icon and 32 or 10

        local Items = { } do 
            Items["Input"] = Instances:Create("Frame", {
                Parent = Input.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 50),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Input"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Input.Name,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2New(1, 0, 0, 15),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            -- the box
            Items["Box"] = Instances:Create("Frame", {
                Parent = Items["Input"].Instance,
                Name = "\0",
                AnchorPoint = Vector2New(0, 1),
                Position = UDim2New(0, 0, 1, 0),
                Size = UDim2New(1, 0, 0, 30),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["Box"]:AddToTheme({BackgroundColor3 = "Element"})

            Instances:Create("UICorner", {
                Parent = Items["Box"].Instance,
                CornerRadius = UDimNew(Library.CornerScale, 0)
            }) 

            Items["BoxStroke"] = Instances:Create("UIStroke", {
                Parent = Items["Box"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  Items["BoxStroke"]:AddToTheme({Color = "Border"})

            if Input.Icon then
                Items["Icon"] = Instances:Create("ImageLabel", {
                    Parent = Items["Box"].Instance,
                    AnchorPoint = Vector2New(0, 0.5),
                    Position = UDim2New(0, 10, 0.5, 0),
                    Size = UDim2New(0, 14, 0, 14),
                    ScaleType = Enum.ScaleType.Fit,
                    ImageTransparency = 0.5,
                    BackgroundTransparency = 1,
                    BorderSizePixel = 0,
                    Name = "\0",
                    ZIndex = 5,
                    BackgroundColor3 = FromRGB(255, 255, 255)
                })  Items["Icon"]:AddToTheme({ImageColor3 = "Image"})

                Library:ApplyIcon(Items["Icon"], Input.Icon)
            end

            Items["Field"] = Instances:Create("TextBox", {
                Parent = Items["Box"].Instance,
                FontFace = Library.Font,
                BorderSizePixel = 0,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                ZIndex = 5,
                BackgroundTransparency = 1,
                ClearTextOnFocus = Input.ClearOnFocus,
                ClipsDescendants = true,
                Size = UDim2New(1, -(TextPadding + 28), 1, 0),
                Position = UDim2New(0, TextPadding, 0, 0),
                Name = "\0",
                PlaceholderColor3 = FromRGB(140, 140, 140),
                TextXAlignment = Enum.TextXAlignment.Left,
                PlaceholderText = Input.Placeholder,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Field"]:AddToTheme({TextColor3 = "Text"})

            -- clear button (only visible while there is text)
            Items["Clear"] = Instances:Create("TextButton", {
                Parent = Items["Box"].Instance,
                FontFace = Library.BoldFont,
                Text = "x",
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 1,
                TextSize = 14,
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Visible = false,
                AnchorPoint = Vector2New(1, 0.5),
                Position = UDim2New(1, -6, 0.5, 0),
                Size = UDim2New(0, 20, 0, 20),
                Name = "\0",
                ZIndex = 6
            })  Items["Clear"]:AddToTheme({TextColor3 = "Text"})
        end

        local Field = Items["Field"].Instance

        local Filter = function(Text)
            Text = tostring(Text)

            if Input.Numeric then
                Text = StringGSub(Text, "[^%d%.%-]", "")
            end

            if Input.MaxLength and #Text > Input.MaxLength then
                Text = string.sub(Text, 1, Input.MaxLength)
            end

            return Text
        end

        local RefreshClear = function()
            local Show = #Field.Text > 0

            if Show then
                Items["Clear"].Instance.Visible = true
            end

            Items["Clear"]:Tween(Smooth, {TextTransparency = Show and 0.5 or 1})

            if not Show then
                task.delay(0.2, function()
                    if #Field.Text == 0 then
                        Items["Clear"].Instance.Visible = false
                    end
                end)
            end
        end

        function Input:Get()
            return Input.Value
        end

        function Input:Set(Value, Silent)
            Value = Filter(Value)

            Field.Text = Value
            Input.Value = Value

            Library.Flags[Input.Flag] = Value

            RefreshClear()

            if not Silent and Input.Callback then
                Library:SafeCall(Input.Callback, Input.Value)
            end
        end

        function Input:SetPlaceholder(Text)
            Field.PlaceholderText = Text
        end

        function Input:SetVisibility(Bool)
            Items["Input"].Instance.Visible = Bool
        end

        Items["Field"]:Connect("Focused", function()
            Items["BoxStroke"]:Tween(Smooth, {Color = Library.Theme["Light Accent"]})

            if Items["Icon"] then
                Items["Icon"]:Tween(Smooth, {ImageTransparency = 0})
            end
        end)

        Items["Field"]:Connect("FocusLost", function()
            Items["BoxStroke"]:Tween(Smooth, {Color = Library.Theme.Border})

            if Items["Icon"] then
                Items["Icon"]:Tween(Smooth, {ImageTransparency = 0.5})
            end

            Input:Set(Field.Text)
        end)

        -- keeps numeric / max-length rules enforced while typing
        Library:Connect(Field:GetPropertyChangedSignal("Text"), function()
            local Filtered = Filter(Field.Text)

            if Filtered ~= Field.Text then
                Field.Text = Filtered
                return
            end

            RefreshClear()

            if Input.Live then
                Input.Value = Filtered
                Library.Flags[Input.Flag] = Filtered

                Library:SafeCall(Input.Callback, Filtered)
            end
        end)

        Items["Clear"]:Connect("MouseButton1Click", function()
            Input:Set("")
            Field:CaptureFocus()
        end)

        Items["Clear"]:OnHover(function()
            Items["Clear"]:Tween(Smooth, {TextTransparency = 0})
        end)

        Items["Clear"]:OnHoverLeave(function()
            Items["Clear"]:Tween(Smooth, {TextTransparency = #Field.Text > 0 and 0.5 or 1})
        end)

        if Input.Default ~= "" then
            Input:Set(Input.Default)
        end

        Library.SetFlags[Input.Flag] = function(Value)
            Input:Set(Value)
        end

        Input.Items = Items

        return Input
    end

    -- old name kept so existing scripts keep working
    Library.Sections.Textbox = Library.Sections.Input
end

getgenv().Library = Library
return Library
