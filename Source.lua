
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
            ["Accent"] = FromRGB(88, 122, 255),
            ["Light Accent"] = FromRGB(138, 166, 255),
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
    -- window < popups (color pickers) < notifications
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
    Library.PopupHolder = CreateGui(1001, true)
    Library.NotifGui = CreateGui(1002, true)
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

        for Index, Gui in {self.Holder, self.PopupHolder, self.NotifGui, self.UnusedHolder} do
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
                CornerRadius = UDimNew(0, 4)
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

            Corner(Parent, UDimNew(1, 0))
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

            Corner(Items["ColorpickerButton"], UDimNew(0, 3))
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

            Corner(Items["Hue"], UDimNew(0, 6))
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

            Corner(Items["Alpha"], UDimNew(0, 6))
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

            Corner(Items["Checkers"], UDimNew(0, 6))

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

            Corner(Items["Swatch"], UDimNew(0, 5))
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

            Corner(Items["HexBox"], UDimNew(0, 5))
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
            Corner(Items["Indicator"], UDimNew(0, 3))

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
                CornerRadius = UDimNew(0, 5)
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
                CornerRadius = UDimNew(0, 8)
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
            primary = {Color = FromRGB(88, 122, 255), Theme = "Accent"},
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
                CornerRadius = UDimNew(0, 6)
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

    Library.Window = function(self, Data)
        Data = Data or { }

        if Data.Accent or Data.accent then
            Library:SetAccent(Data.Accent or Data.accent)
        end

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
            FadeSpeed = Data.FadeSpeed or Data.fadespeed or 0.2,
            PagePadding = Data.PagePadding or Data.pagepadding or 4,
            Scale = MathClamp(Data.Scale or Data.scale or 1, 0.6, 1.5),
            Minimized = false,
            Closable = Data.Closable ~= false,
            Minimizable = Data.Minimizable ~= false,
            Scalable = Data.Scalable ~= false,
            OnClose = Data.OnClose or Data.onclose,
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
        local ControlCount = (Window.Scalable and 1 or 0) + (Window.Minimizable and 1 or 0) + (Window.Closable and 1 or 0)
        Window.ControlsWidth = ControlCount > 0 and (ControlCount * 26 + (ControlCount - 1) * 4 + 12) or 0

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
                return Input.Position.Y - Gui.AbsolutePosition.Y <= Header * ScaleObject.Scale
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
                CornerRadius = UDimNew(0, 8)
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

            Items["Title"] = Instances:Create("TextLabel", {
                Parent = Items["Sidebar"].Instance,
                FontFace = Library.BoldFont,
                TextColor3 = FromRGB(255, 255, 255),
                Text = Window.Title,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Position = UDim2New(0, 54, 0, Window.Subtitle ~= "" and 11 or 19),
                Size = UDim2New(1, -62, 0, 18),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                BorderSizePixel = 0,
                ZIndex = 3,
                TextSize = 15,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Title"]:AddToTheme({TextColor3 = "Text"})

            Items["Subtitle"] = Instances:Create("TextLabel", {
                Parent = Items["Sidebar"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                TextTransparency = 0.5,
                Text = Window.Subtitle,
                Name = "\0",
                BorderColor3 = FromRGB(0, 0, 0),
                Position = UDim2New(0, 54, 0, 29),
                Size = UDim2New(1, -62, 0, 14),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                Visible = Window.Subtitle ~= "",
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
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 2,
                ScrollBarImageTransparency = 0,
                CanvasSize = UDim2New(0, 0, 0, 0),
                ScrollBarImageColor3 = Library.Theme.Accent,
                MidImage = Library:GetImage("Scrollbar"),
                TopImage = Library:GetImage("Scrollbar"),
                BottomImage = Library:GetImage("Scrollbar"),
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                BackgroundTransparency = 1,
                Position = UDim2New(0, 0, 0, Header + 10),
                Size = UDim2New(1, 0, 1, -(Header + 18)),
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

            Instances:Create("UICorner", {
                Parent = Items["MainFrame"].Instance,
                CornerRadius = UDimNew(0, 5)
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
                Items["Title"].Instance.Position = UDim2New(0, 54, 0, Subtitle ~= "" and 11 or 19)
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
        end

        -- header controls: [scale] [minimize] [close]
        local ScaleButton

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
                    CornerRadius = UDimNew(0, 6)
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
                        CornerRadius = UDimNew(0, 2)
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
                CornerRadius = UDimNew(0, 8)
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
                CornerRadius = UDimNew(0, 8)
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
                    CornerRadius = UDimNew(0, 6)
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
            CornerRadius = UDimNew(1, 0)
        }) 

        Items["FloatScale"] = Instances:Create("UIScale", {
            Parent = Items["Float"].Instance,
            Scale = 0.5
        }) 

        Items["FloatStroke"] = Instances:Create("UIStroke", {
            Parent = Items["Float"].Instance,
            Color = FromRGB(138, 166, 255),
            Thickness = 1.5,
            Transparency = 1,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        })  Items["FloatStroke"]:AddToTheme({Color = "Light Accent"})

        Items["FloatGlow"] = Instances:Create("ImageLabel", {
            Parent = Items["Float"].Instance,
            ImageColor3 = FromRGB(88, 122, 255),
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
        end)

        Window.Items = Items

        Library:LoadIcons()

        Window:SetOpen(true)
        return setmetatable(Window, Library)
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

        local TabInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
        local HoverInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

        local Items = { } do
            -- sidebar tab: [indicator] [icon] | [name]
            Items["Inactive"] = Instances:Create("TextButton", {
                Parent = Page.Window.Items["Pages"].Instance,
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
                CornerRadius = UDimNew(0, 6)
            }) 

            Items["UIStroke"] = Instances:Create("UIStroke", {
                Parent = Items["Inactive"].Instance,
                Color = FromRGB(138, 166, 255),
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
                BackgroundColor3 = FromRGB(138, 166, 255)
            })  Items["Indicator"]:AddToTheme({BackgroundColor3 = "Light Accent"})

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

        if #Page.Window.Pages == 0 then 
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
                BackgroundColor3 = FromRGB(88, 122, 255)
            })  Items["Inactive"]:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Accent"})

            Instances:Create("UIPadding", {
                Parent = Items["Inactive"].Instance,
                PaddingLeft = UDimNew(0, 14),
                PaddingRight = UDimNew(0, 14)
            }) 

            Instances:Create("UICorner", {
                Parent = Items["Inactive"].Instance,
                CornerRadius = UDimNew(0, 6)
            }) 

            Items["UIStroke"] = Instances:Create("UIStroke", {
                Parent = Items["Inactive"].Instance,
                Color = FromRGB(138, 166, 255),
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
                BackgroundColor3 = FromRGB(138, 166, 255)
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
                ScrollBarImageColor3 = FromRGB(88, 122, 255),
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
                ScrollBarImageColor3 = FromRGB(88, 122, 255),
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
                CornerRadius = UDimNew(0, 3)
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
                CornerRadius = UDimNew(1, 0)
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
                CornerRadius = UDimNew(1, 0)
            }) 

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
                ImageColor3 = FromRGB(88, 122, 255),
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
                CornerRadius = UDimNew(0, 3)
            }) 

            Items["UIStroke"] = Instances:Create("UIStroke", {
                Parent = Items["Button"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            })  Items["UIStroke"]:AddToTheme({Color = "Border"})
        end

        Library:AddPress(Items["Button"], 0.98)

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
                    CornerRadius = UDimNew(0, 3)
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
            BackgroundColor3 = FromRGB(88, 122, 255)
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
            BackgroundColor3 = FromRGB(88, 122, 255)
        })  Items["Drag"]:AddToTheme({BackgroundColor3 = "Accent"})

        Instances:Create("UICorner", {
            Parent = Items["Drag"].Instance,
            CornerRadius = UDimNew(1, 0)
        }) 
    end

    Library:AddPress(Items["Drag"], 1.25)

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
                ScrollBarImageColor3 = FromRGB(88, 122, 255),
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
                CornerRadius = UDimNew(0, 3)
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
                CornerRadius = UDimNew(0, 4)
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
                CornerRadius = UDimNew(0, 8)
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
                    CornerRadius = UDimNew(0, IsSide and 8 or 6)
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
            primary = {Color = FromRGB(88, 122, 255), Theme = "Accent"},
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
                CornerRadius = UDimNew(0, 6)
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
                CornerRadius = UDimNew(0, 3)
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
                CornerRadius = UDimNew(0, 6)
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
