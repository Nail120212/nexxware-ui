
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
            ["Accent"] = FromRGB(181, 116, 16),
            ["Light Accent"] = FromRGB(255, 156, 6),
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

                    StartSize = Vector2New(Gui.AbsoluteSize.X, Gui.AbsoluteSize.Y)
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

                local MaxX = math.max(Minimum.X, math.min(Maximum.X, View.X - Position.X))
                local MaxY = math.max(Minimum.Y, math.min(Maximum.Y, View.Y - Position.Y))

                local Width = MathClamp(StartSize.X + (Input.Position.X - StartMouse.X), Minimum.X, MaxX)
                local Height = MathClamp(StartSize.Y + (Input.Position.Y - StartMouse.Y), Minimum.Y, MaxY)

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
            Items["ColorpickerButton"].Instance.Position = UDim2New(1, -(19 * Column) - (Data.IsToggle and 20 or 0), 0.5, 0)

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

    -- "123456" -> "rbxassetid://123456"; full rbxasset(id):// strings are passed through untouched
    local IconImage = function(Icon)
        Icon = tostring(Icon)

        if StringFind(Icon, "rbxassetid://", 1, true) or StringFind(Icon, "rbxasset://", 1, true) then
            return Icon
        end

        return "rbxassetid://" .. Icon
    end

    Library.Window = function(self, Data)
        Data = Data or { }

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
            SidebarWidth = MathClamp(Data.SidebarWidth or Data.sidebarwidth or 176, 120, MathFloor(Width * 0.45)),
            HeaderHeight = 56,

            Pages = { },
            SubPages = { },
            Items = { },

            IsOpen = false
        }

        local Sidebar = Window.SidebarWidth
        local Header = Window.HeaderHeight

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

            -- only the header strip (logo + title on the left, sub tab bar on the right) drags the window
            Items["MainFrame"]:MakeDraggable(function(Input, Gui)
                return Input.Position.Y - Gui.AbsolutePosition.Y <= Header
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
                Image = IconImage(Window.Logo),
                BackgroundTransparency = 1,
                ZIndex = 3,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Logo"]:AddToTheme({ImageColor3 = "Image"})

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

        local Debounce = false 

        function Window:SetOpen(Bool)
            if Debounce or Window.IsOpen == Bool then 
                return 
            end

            Window.IsOpen = Bool

            Debounce = true 

            if Bool then 
                Items["MainFrame"].Instance.Visible = true
            else
                Library:ClosePopups()
            end

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

            if not NewTween then
                Debounce = false
                Items["MainFrame"].Instance.Visible = Bool
                return
            end

            Library:Connect(NewTween.Tween.Completed, function()
                Debounce = false
                Items["MainFrame"].Instance.Visible = Bool
            end)
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

        Library:Connect(UserInputService.InputBegan, function(Input, Gpe)
            if Gpe then 
                return 
            end

            if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
                Window:SetOpen(not Window.IsOpen)
            end
        end)

        Window.Items = Items

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
                Color = FromRGB(255, 156, 6),
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
                BackgroundColor3 = FromRGB(255, 156, 6)
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
                Image = IconImage(Page.Icon),
                BackgroundTransparency = 1,
                AnchorPoint = Vector2New(0, 0.5),
                Position = UDim2New(0, 14, 0.5, 0),
                Size = UDim2New(0, 18, 0, 18),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Icon"]:AddToTheme({ImageColor3 = "Image"})

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
                Size = UDim2New(1, 0, 1, 0),
                Position = UDim2New(0, 0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                Visible = false,
                GroupTransparency = 1,
                BackgroundColor3 = FromRGB(255, 255, 255)
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
                Size = UDim2New(1, -28, 0, 34),
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
                Content.Instance.Position = UDim2New(0, 0, 0, 0)
                return
            end

            if Bool then 
                if not Content.Instance.Visible or Content.Instance.GroupTransparency >= 0.99 then
                    Content.Instance.Position = UDim2New(0, 0, 0, 12)
                end

                Content.Instance.Visible = true

                ContentTween = Content:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.08), {GroupTransparency = 0, Position = UDim2New(0, 0, 0, 0)})
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
                BackgroundColor3 = FromRGB(181, 116, 16)
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
                Color = FromRGB(255, 156, 6),
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
                BackgroundColor3 = FromRGB(255, 156, 6)
            })  Items["Bar"]:AddToTheme({BackgroundColor3 = "Light Accent"})

            Instances:Create("UICorner", {
                Parent = Items["Bar"].Instance,
                CornerRadius = UDimNew(1, 0)
            }) 

            Items["PageContent"] = Instances:Create("CanvasGroup", {
                Parent = SubPage.Page.Items["Columns"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 1, 0),
                Position = UDim2New(0, 0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                Visible = false,
                GroupTransparency = 1,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Right"] = Instances:Create("ScrollingFrame", {
                Parent = Items["PageContent"].Instance,
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                AnchorPoint = Vector2New(1, 0),
                ZIndex = 2,
                BorderSizePixel = 0,
                CanvasSize = UDim2New(0, 0, 0, 0),
                ScrollBarImageColor3 = FromRGB(181, 116, 16),
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
                ScrollBarImageColor3 = FromRGB(181, 116, 16),
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
                Content.Instance.Position = UDim2New(0, 0, 0, 0)
                return
            end

            if Bool then 
                if not Content.Instance.Visible or Content.Instance.GroupTransparency >= 0.99 then
                    Content.Instance.Position = UDim2New(0, 0, 0, 10)
                end

                Content.Instance.Visible = true

                ContentTween = Content:Tween(TweenInfo.new(0.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out, 0, false, 0.06), {GroupTransparency = 0, Position = UDim2New(0, 0, 0, 0)})
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
                Size = UDim2New(1, 0, 0, 15),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Indicator"] = Instances:Create("Frame", {
                Parent = Items["Toggle"].Instance,
                BorderColor3 = FromRGB(0, 0, 0),
                AnchorPoint = Vector2New(1, 0.5),
                Name = "\0",
                Position = UDim2New(1, 0, 0.5, 0),
                Size = UDim2New(0, 15, 0, 15),
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
                CornerRadius = UDimNew(0, 3)
            }) 

            Items["Check"] = Instances:Create("ImageLabel", {
                Parent = Items["Indicator"].Instance,
                ImageColor3 = FromRGB(0, 0, 0),
                ScaleType = Enum.ScaleType.Fit,
                BorderColor3 = FromRGB(0, 0, 0),
                Name = "\0",
                Size = UDim2New(1, -3, 1, -3),
                Visible = false,
                AnchorPoint = Vector2New(0.5, 0.5),
                Image = "rbxassetid://135757045959142",
                BackgroundTransparency = 1,
                Position = UDim2New(0.5, -1, 0.5, -1),
                ZIndex = 5,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
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
                ImageColor3 = FromRGB(181, 116, 16),
                Size = UDim2New(1, 15, 1, 15),
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
                Size = UDim2New(1, 0, 0, 15),
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})
        end

        function Toggle:Get()
            return Toggle.Value
        end

        function Toggle:Set(Value, IsKeybind)
            if IsKeybind then 
                Value = IsKeybind.Toggled
                Toggle.Value = Value
            else
                Toggle.Value =  Value 
            end

            Library.Flags[Toggle.Flag] = Value 

            if Value then 
                Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Accent"})
                Items["UIStroke"]:ChangeItemTheme({Color = "Light Accent"})

                Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Accent})
                Items["Text"]:Tween(nil, {TextTransparency = 0})
                Items["Check"].Instance.Visible = true 
                Items["Shadow"]:Tween(nil, {ImageTransparency = 0.5})
                Items["UIStroke"]:Tween(nil, {Color = Library.Theme["Light Accent"]})
            else
                Items["Indicator"]:ChangeItemTheme({BackgroundColor3 = "Element"})
                Items["UIStroke"]:ChangeItemTheme({Color = "Border"})

                Items["Indicator"]:Tween(nil, {BackgroundColor3 = Library.Theme.Element})
                Items["Text"]:Tween(nil, {TextTransparency = 0.5})
                Items["Check"].Instance.Visible = false
                Items["Shadow"]:Tween(nil, {ImageTransparency = 1})
                Items["UIStroke"]:Tween(nil, {Color = Library.Theme.Border})
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
                
                    SubItems["KeyButton"].Instance.Position = UDim2New(1, Index == 1 and -XPosition - 24 or -XPosition, 0.5, 0)
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
            BackgroundColor3 = FromRGB(181, 116, 16)
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
            BackgroundColor3 = FromRGB(181, 116, 16)
        })  Items["Drag"]:AddToTheme({BackgroundColor3 = "Accent"})

        Instances:Create("UICorner", {
            Parent = Items["Drag"].Instance,
            CornerRadius = UDimNew(1, 0)
        }) 
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
                ScrollBarImageColor3 = FromRGB(181, 116, 16),
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

    Library.Sections.Textbox = function(self, Data)
        Data = Data or { }

        local Textbox = {
            Window = self.Window,
            Page = self.Page,
            Section = self,

            Name = Data.Name or Data.name or "Textbox",
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or "",
            Callback = Data.Callback or Data.callback or function() end,
            Placeholder = Data.Placeholder or Data.placeholder or "Placeholder",

            Value = ""
        }

        local Items = { } do 
            Items["Textbox"] = Instances:Create("Frame", {
                Parent = Textbox.Section.Items["Content"].Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 0, 42),
                BorderColor3 = FromRGB(0, 0, 0),
                ZIndex = 4,
                BorderSizePixel = 0,
                BackgroundColor3 = FromRGB(255, 255, 255)
            }) 

            Items["Text"] = Instances:Create("TextLabel", {
                Parent = Items["Textbox"].Instance,
                FontFace = Library.Font,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Textbox.Name,
                Name = "\0",
                BorderSizePixel = 0,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left,
                Size = UDim2New(1, 0, 0, 15),
                ZIndex = 4,
                TextSize = 14,
                BackgroundColor3 = FromRGB(255, 255, 255)
            })  Items["Text"]:AddToTheme({TextColor3 = "Text"})

            Items["Input"] = Instances:Create("TextBox", {
                Parent = Items["Textbox"].Instance,
                FontFace = Library.Font,
                BorderSizePixel = 0,
                TextColor3 = FromRGB(255, 255, 255),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                ZIndex = 4,
                Size = UDim2New(1, 0, 0, 21),
                AnchorPoint = Vector2New(0, 1),
                Position = UDim2New(0, 0, 1, 0),
                Name = "\0",
                PlaceholderColor3 = FromRGB(175, 175, 175),
                TextXAlignment = Enum.TextXAlignment.Left,
                PlaceholderText = Textbox.Placeholder,
                TextSize = 14,
                BackgroundColor3 = FromRGB(11, 11, 11)
            })  Items["Input"]:AddToTheme({TextColor3 = "Text", BackgroundColor3 = "Element"})

            Instances:Create("UICorner", {
                Parent = Items["Input"].Instance,
                CornerRadius = UDimNew(0, 3)
            }) 

            Instances:Create("UIStroke", {
                Parent = Items["Input"].Instance,
                Color = FromRGB(24, 24, 24),
                ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            }):AddToTheme({Color = "Border"})

            Instances:Create("UIPadding", {
                Parent = Items["Input"].Instance,
                PaddingTop = UDimNew(0, 1),
                PaddingLeft = UDimNew(0, 4)
            }) 
        end

        function Textbox:Get()
            return Textbox.Value
        end

        function Textbox:Set(Value)
            Items["Input"].Instance.Text = Value

            Textbox.Value = Value

            Library.Flags[Textbox.Flag] = Value

            if Textbox.Callback then
                Library:SafeCall(Textbox.Callback, Textbox.Value)
            end
        end

        function Textbox:SetVisibility(Bool)
            Items["Textbox"].Instance.Visible = Bool
        end

        Items["Input"]:Connect("FocusLost", function()
            Textbox:Set(Items["Input"].Instance.Text)
        end)

        if Textbox.Default then
            Textbox:Set(Textbox.Default)
        end

        Library.SetFlags[Textbox.Flag] = function(Value)
            Textbox:Set(Value)
        end

        return Textbox
    end
end

getgenv().Library = Library
return Library
