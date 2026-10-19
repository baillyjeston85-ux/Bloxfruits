
--========================================================
-- FRUIT HUB ULTIMATE | PURPLE EDITION
-- Roblox Studio - LocalScript
-- Emplacement : StarterPlayerScripts
-- Interface + animations + réglages + notifications
--========================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local OLD = PlayerGui:FindFirstChild("FruitHubUltimate")
if OLD then OLD:Destroy() end

local Config = {
    Accent = Color3.fromRGB(145, 75, 255),
    Background = Color3.fromRGB(12, 10, 21),
    Panel = Color3.fromRGB(24, 20, 39),
    Card = Color3.fromRGB(32, 26, 49),
    Text = Color3.fromRGB(248, 243, 255),
    Muted = Color3.fromRGB(165, 151, 187),
    Green = Color3.fromRGB(87, 225, 145),
    Red = Color3.fromRGB(255, 91, 117),
    Animations = true,
    Notifications = true,
    MenuScale = 1,
    Open = true,
}

local State = {
    AutoFarmDemo = false,
    AutoTrainDemo = false,
    ShowStats = true,
    SprintDemo = false,
    FlyDemo = false,
    Notifications = true,
}

local function New(className, props, parent)
    local obj = Instance.new(className)

    for key, value in pairs(props or {}) do
        obj[key] = value
    end

    obj.Parent = parent
    return obj
end

local function Round(obj, radius)
    New("UICorner", {
        CornerRadius = UDim.new(0, radius or 10)
    }, obj)
end

local function Stroke(obj, color, transparency)
    New("UIStroke", {
        Color = color or Config.Accent,
        Transparency = transparency or 0.6,
        Thickness = 1,
    }, obj)
end

local function Animate(obj, props, duration)
    if not Config.Animations then
        for key, value in pairs(props) do
            obj[key] = value
        end
        return
    end

    local info = TweenInfo.new(
        duration or 0.2,
        Enum.EasingStyle.Quart,
        Enum.EasingDirection.Out
    )

    TweenService:Create(obj, info, props):Play()
end

local GUI = New("ScreenGui", {
    Name = "FruitHubUltimate",
    ResetOnSpawn = false,
    IgnoreGuiInset = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, PlayerGui)

--========================================================
-- NOTIFICATIONS
--========================================================

local ToastHolder = New("Frame", {
    Name = "Notifications",
    AnchorPoint = Vector2.new(1, 0),
    Position = UDim2.new(1, -18, 0, 18),
    Size = UDim2.fromOffset(300, 350),
    BackgroundTransparency = 1,
}, GUI)

New("UIListLayout", {
    Padding = UDim.new(0, 8),
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    SortOrder = Enum.SortOrder.LayoutOrder,
}, ToastHolder)

local function Notify(title, message)
    if not Config.Notifications or not State.Notifications then
        return
    end

    local toast = New("Frame", {
        Size = UDim2.fromOffset(290, 66),
        BackgroundColor3 = Config.Panel,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
    }, ToastHolder)

    Round(toast, 12)
    Stroke(toast, Config.Accent, 0.25)

    local bar = New("Frame", {
        Size = UDim2.new(0, 4, 1, -18),
        Position = UDim2.fromOffset(7, 9),
        BackgroundColor3 = Config.Accent,
        BorderSizePixel = 0,
    }, toast)
    Round(bar, 3)

    New("TextLabel", {
        Position = UDim2.fromOffset(20, 9),
        Size = UDim2.new(1, -28, 0, 21),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, toast)

    New("TextLabel", {
        Position = UDim2.fromOffset(20, 32),
        Size = UDim2.new(1, -28, 0, 23),
        BackgroundTransparency = 1,
        Text = message,
        TextColor3 = Config.Muted,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, toast)

    toast.BackgroundTransparency = 1
    Animate(toast, {BackgroundTransparency = 0.05}, 0.2)

    task.delay(3, function()
        if toast and toast.Parent then
            Animate(toast, {
                BackgroundTransparency = 1,
                Position = toast.Position + UDim2.fromOffset(20, 0),
            }, 0.2)
            task.wait(0.25)
            if toast then toast:Destroy() end
        end
    end)
end

--========================================================
-- MAIN WINDOW
--========================================================

local Main = New("Frame", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(780, 510),
    BackgroundColor3 = Config.Background,
    BorderSizePixel = 0,
    ClipsDescendants = true,
}, GUI)

Round(Main, 17)
Stroke(Main, Config.Accent, 0.2)

New("UISizeConstraint", {
    MinSize = Vector2.new(350, 280),
    MaxSize = Vector2.new(1000, 720),
}, Main)

--========================================================
-- HEADER
--========================================================

local Header = New("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 72),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0,
}, Main)

local Logo = New("Frame", {
    Position = UDim2.fromOffset(17, 14),
    Size = UDim2.fromOffset(44, 44),
    BackgroundColor3 = Config.Accent,
    BorderSizePixel = 0,
}, Header)
Round(Logo, 13)

New("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = "F",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBlack,
    TextSize = 28,
}, Logo)

New("TextLabel", {
    Position = UDim2.fromOffset(73, 12),
    Size = UDim2.fromOffset(310, 29),
    BackgroundTransparency = 1,
    Text = "FRUIT HUB",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBlack,
    TextSize = 23,
    TextXAlignment = Enum.TextXAlignment.Left,
}, Header)

New("TextLabel", {
    Position = UDim2.fromOffset(74, 41),
    Size = UDim2.fromOffset(310, 16),
    BackgroundTransparency = 1,
    Text = "ULTIMATE PURPLE EDITION",
    TextColor3 = Config.Accent,
    Font = Enum.Font.GothamBold,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
}, Header)

local StatusDot = New("Frame", {
    Position = UDim2.new(1, -165, 0, 27),
    Size = UDim2.fromOffset(8, 8),
    BackgroundColor3 = Config.Green,
    BorderSizePixel = 0,
}, Header)
Round(StatusDot, 5)

New("TextLabel", {
    Position = UDim2.new(1, -151, 0, 21),
    Size = UDim2.fromOffset(85, 20),
    BackgroundTransparency = 1,
    Text = "INTERFACE",
    TextColor3 = Config.Green,
    Font = Enum.Font.GothamBold,
    TextSize = 10,
}, Header)

local Minimize = New("TextButton", {
    Position = UDim2.new(1, -58, 0, 19),
    Size = UDim2.fromOffset(34, 34),
    BackgroundColor3 = Config.Card,
    Text = "−",
    TextColor3 = Config.Text,
    Font = Enum.Font.GothamBold,
    TextSize = 22,
    AutoButtonColor = false,
}, Header)
Round(Minimize, 9)

local Close = New("TextButton", {
    Position = UDim2.new(1, -100, 0, 19),
    Size = UDim2.fromOffset(34, 34),
    BackgroundColor3 = Color3.fromRGB(68, 28, 48),
    Text = "×",
    TextColor3 = Config.Red,
    Font = Enum.Font.GothamBold,
    TextSize = 21,
    AutoButtonColor = false,
}, Header)
Round(Close, 9)

--========================================================
-- SIDEBAR
--========================================================

local Sidebar = New("Frame", {
    Position = UDim2.fromOffset(0, 72),
    Size = UDim2.new(0, 185, 1, -72),
    BackgroundColor3 = Config.Panel,
    BorderSizePixel = 0,
}, Main)

New("TextLabel", {
    Position = UDim2.fromOffset(17, 15),
    Size = UDim2.new(1, -30, 0, 20),
    BackgroundTransparency = 1,
    Text = "MAIN MENU",
    TextColor3 = Config.Muted,
    Font = Enum.Font.GothamBold,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
}, Sidebar)

local Nav = New("ScrollingFrame", {
    Position = UDim2.fromOffset(9, 43),
    Size = UDim2.new(1, -18, 1, -55),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 2,
    ScrollBarImageColor3 = Config.Accent,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
}, Sidebar)

New("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, Nav)

--========================================================
-- CONTENT AND FOOTER
--========================================================

local Content = New("Frame", {
    Position = UDim2.fromOffset(201, 88),
    Size = UDim2.new(1, -218, 1, -130),
    BackgroundTransparency = 1,
}, Main)

local Footer = New("TextLabel", {
    Position = UDim2.new(0, 201, 1, -30),
    Size = UDim2.new(1, -218, 0, 20),
    BackgroundTransparency = 1,
    Text = "● Ready",
    TextColor3 = Config.Green,
    Font = Enum.Font.Gotham,
    TextSize = 10,
    TextXAlignment = Enum.TextXAlignment.Left,
}, Main)

local function SetStatus(message)
    Footer.Text = "● " .. message
end

local Pages = {}
local NavButtons = {}
local CurrentPage

local function NewPage(name, description)
    local page = New("ScrollingFrame", {
        Name = name,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = Config.Accent,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(),
        Visible = false,
    }, Content)

    New("UIPadding", {
        PaddingRight = UDim.new(0, 8),
        PaddingBottom = UDim.new(0, 12),
    }, page)

    New("UIListLayout", {
        Padding = UDim.new(0, 9),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, page)

    New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 36),
        BackgroundTransparency = 1,
        Text = name,
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBlack,
        TextSize = 24,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, page)

    New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = Config.Muted,
        Font = Enum.Font.Gotham,
        TextSize = 11,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, page)

    Pages[name] = page
    return page
end

local function Section(page, title)
    New("TextLabel", {
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Config.Accent,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, page)
end

local function AddButton(page, title, description, callback)
    local button = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 61),
        BackgroundColor3 = Config.Panel,
        Text = "",
        AutoButtonColor = false,
    }, page)

    Round(button, 11)
    Stroke(button, Config.Card, 0.15)

    New("TextLabel", {
        Position = UDim2.fromOffset(13, 8),
        Size = UDim2.new(1, -26, 0, 22),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, button)

    New("TextLabel", {
        Position = UDim2.fromOffset(13, 32),
        Size = UDim2.new(1, -26, 0, 18),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = Config.Muted,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
    }, button)

    button.MouseEnter:Connect(function()
        Animate(button, {BackgroundColor3 = Config.Card})
    end)

    button.MouseLeave:Connect(function()
        Animate(button, {BackgroundColor3 = Config.Panel})
    end)

    button.Activated:Connect(callback)
    return button
end

local function AddToggle(page, title, description, default, callback)
    local value = default == true

    local row = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 62),
        BackgroundColor3 = Config.Panel,
        Text = "",
        AutoButtonColor = false,
    }, page)

    Round(row, 11)

    New("TextLabel", {
        Position = UDim2.fromOffset(13, 8),
        Size = UDim2.new(1, -90, 0, 22),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = Config.Text,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, row)

    New("TextLabel", {
        Position = UDim2.fromOffset(13, 32),
        Size = UDim2.new(1, -90, 0, 18),
        BackgroundTransparency = 1,
        Text = description,
        TextColor3 = Config.Muted,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
    }, row)

    local track = New("Frame", {
        Position = UDim2.new(1, -61, 0.5, -11),
        Size = UDim2.fromOffset(47, 22),
        BackgroundColor3 = value and Config.Accent or Config.Card,
        BorderSizePixel = 0,
    }, row)

    Round(track, 12)

    local knob = New("Frame", {
        Position = value and UDim2.new(1, -19, 0, 3)
            or UDim2.fromOffset(3, 3),
        Size = UDim2.fromOffset(16, 16),
        BackgroundColor3 = Config.Text,
        BorderSizePixel = 0,
    }, track)

    Round(knob, 10)

    local function Render()
        Animate(track, {
            BackgroundColor3 = value and Config.Accent or Config.Card,
        })

        Animate(knob, {
            Position = value and UDim2.new(1, -19, 0, 3)
                or UDim2.fromOffset(3, 3),
        })

        callback(value)
    end

    row.Activated:Connect(function()
        value = not value
        Render()
    end)

    return function()
        return value
    end
end

local function Category(name, icon, description, build)
    local navButton = New("TextButton", {
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Config.Panel,
        Text = "   " .. icon .. "     " .. name,
        TextColor3 = Config.Muted,
        Font = Enum.Font.GothamMedium,
        TextSize = 11,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false,
    }, Nav)

    Round(navButton, 9)

    NavButtons[name] = navButton
    local page = NewPage(name, description)
    build(page)

    navButton.Activated:Connect(function()
        for pageName, otherPage in pairs(Pages) do
            otherPage.Visible = pageName == name
        end

        for pageName, otherButton in pairs(NavButtons) do
            local active = pageName == name

            Animate(otherButton, {
                BackgroundColor3 = active and Config.Accent or Config.Panel,
                TextColor3 = active and Config.Text or Config.Muted,
            })
        end

        CurrentPage = name
        SetStatus("Page : " .. name)
    end)
end

--========================================================
-- DASHBOARD
--========================================================

Category("Dashboard", "◆", "Vue générale de ton interface.", function(page)
    Section(page, "WELCOME BACK")

    AddButton(page, "Fruit Hub Ultimate", "Purple Edition chargée", function()
        Notify("Fruit Hub", "Ton interface est active.")
        SetStatus("Interface active")
    end)

    AddButton(page, "Informations du joueur", Player.Name, function()
        Notify("Player", "Nom : " .. Player.Name)
    end)

    AddButton(page, "État du personnage", "Vérifier le chargement local", function()
        local character = Player.Character
        Notify("Personnage", character and "Personnage chargé." or "Personnage absent.")
    end)

    Section(page, "QUICK SETTINGS")

    AddToggle(page, "Notifications", "Afficher les notifications", true, function(v)
        State.Notifications = v
        SetStatus("Notifications : " .. (v and "ON" or "OFF"))
    end)

    AddToggle(page, "Animations", "Activer les transitions du menu", true, function(v)
        Config.Animations = v
        SetStatus("Animations : " .. (v and "ON" or "OFF"))
    end)
end)

--========================================================
-- TRAVEL
-- Les destinations sont des exemples d'interface.
--========================================================

Category("Travel", "➤", "Destinations de démonstration.", function(page)
    Section(page, "DESTINATIONS")

    for _, destination in ipairs({
        "Starter Island",
        "Jungle",
        "Desert",
        "Frozen Village",
        "Marine Fortress",
        "Sky Island",
    }) do
        AddButton(page, destination, "Point de destination exemple", function()
            Notify("Travel", destination .. " : mode démonstration")
            SetStatus("Aucun déplacement effectué")
        end)
    end
end)

--========================================================
-- AUTO FARM
-- Les interrupteurs ne lancent aucun combat.
--========================================================

Category("Auto Farm", "✦", "Options d'entraînement de démonstration.", function(page)
    Section(page, "TRAINING CONTROLS")

    AddToggle(page, "Auto Farm (démo)", "Interrupteur de l'interface uniquement", false, function(v)
        State.AutoFarmDemo = v
        SetStatus("Auto Farm démo : " .. (v and "ON" or "OFF"))
        Notify("Auto Farm", v and "Mode démo activé." or "Mode démo arrêté.")
    end)

    AddToggle(page, "Auto Training (démo)", "Aucune attaque automatique", false, function(v)
        State.AutoTrainDemo = v
        SetStatus("Auto Training démo : " .. (v and "ON" or "OFF"))
    end)

    AddButton(page, "Reset demo", "Réinitialiser les interrupteurs", function()
        State.AutoFarmDemo = false
        State.AutoTrainDemo = false
        Notify("Auto Farm", "Utilise les interrupteurs pour les remettre à OFF.")
    end)
end)

--========================================================
-- COMBAT
--========================================================

Category("Combat", "⚔", "Réglages d'entraînement fictifs.", function(page)
    Section(page, "COMBAT SETTINGS")

    AddToggle(page, "Training Mode", "Réglage visuel", false, function(v)
        SetStatus("Training Mode : " .. (v and "ON" or "OFF"))
    end)

    AddButton(page, "Combo Settings", "Exemple de panneau de configuration", function()
        Notify("Combat", "Panneau de démonstration.")
    end)

    AddButton(page, "Reset Combat UI", "Réinitialiser le statut", function()
        SetStatus("Combat UI réinitialisée")
    end)
end)

--========================================================
-- MOVEMENT
--========================================================

Category("Movement", "◇", "Préférences visuelles de mouvement.", function(page)
    Section(page, "MOVEMENT SETTINGS")

    AddToggle(page, "Fly (démo)", "N'active aucun vol réel", false, function(v)
        State.FlyDemo = v
        SetStatus("Fly démo : " .. (v and "ON" or "OFF"))
        Notify("Movement", "Interrupteur visuel modifié.")
    end)

    AddToggle(page, "Sprint (démo)", "Aucun changement de vitesse", false, function(v)
        State.SprintDemo = v
        SetStatus("Sprint démo : " .. (v and "ON" or "OFF"))
    end)

    AddToggle(page, "High Jump (démo)", "Aucun changement de saut", false, function(v)
        SetStatus("High Jump démo : " .. (v and "ON" or "OFF"))
    end)
end)

--========================================================
-- PLAYER
--========================================================

Category("Player", "●", "Informations du joueur local.", function(page)
    Section(page, "PLAYER INFORMATION")

    AddButton(page, "Username", Player.Name, function()
        Notify("Player", Player.Name)
    end)

    AddButton(page, "User ID", tostring(Player.UserId), function()
        Notify("Player", "UserId : " .. Player.UserId)
    end)

    AddButton(page, "Character status", "Vérifier le personnage", function()
        local character = Player.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            Notify("Character", "Santé : " .. math.floor(humanoid.Health))
        else
            Notify("Character", "Personnage non chargé.")
        end
    end)
end)

--========================================================
-- SETTINGS
--========================================================

Category("Settings", "⚙", "Personnalisation de l'interface.", function(page)
    Section(page, "INTERFACE")

    AddToggle(page, "Notifications", "Afficher les messages", true, function(v)
        State.Notifications = v
        SetStatus("Notifications : " .. (v and "ON" or "OFF"))
    end)

    AddToggle(page, "Animations", "Transitions animées", true, function(v)
        Config.Animations = v
        SetStatus("Animations : " .. (v and "ON" or "OFF"))
    end)

    AddButton(page, "Center Window", "Recentrer le hub", function()
        Main.Position = UDim2.fromScale(0.5, 0.5)
        Notify("Settings", "Fenêtre recentrée.")
    end)

    AddButton(page, "Purple Theme", "Réappliquer la couleur violette", function()
        for _, b in pairs(NavButtons) do
            b.BackgroundColor3 = Config.Panel
            b.TextColor3 = Config.Muted
        end

        if CurrentPage and NavButtons[CurrentPage] then
            NavButtons[CurrentPage].BackgroundColor3 = Config.Accent
            NavButtons[CurrentPage].TextColor3 = Config.Text
        end

        Notify("Settings", "Thème violet sélectionné.")
    end)
end)

--========================================================
-- INITIAL PAGE
--========================================================

local function SelectPage(name)
    for pageName, page in pairs(Pages) do
        page.Visible = pageName == name
    end

    for pageName, button in pairs(NavButtons) do
        local active = pageName == name

        button.BackgroundColor3 = active and Config.Accent or Config.Panel
        button.TextColor3 = active and Config.Text or Config.Muted
    end

    CurrentPage = name
    SetStatus("Page : " .. name)
end

SelectPage("Dashboard")

--========================================================
-- MINIMIZE / RESTORE / CLOSE
--========================================================

local fullSize = UDim2.fromOffset(780, 510)
local isMinimized = false

Minimize.Activated:Connect(function()
    isMinimized = not isMinimized

    if isMinimized then
        Animate(Main, {Size = UDim2.fromOffset(780, 72)}, 0.2)
        Minimize.Text = "+"
    else
        Animate(Main, {Size = fullSize}, 0.2)
        Minimize.Text = "−"
    end
end)

Close.Activated:Connect(function()
    Animate(Main, {
        Size = UDim2.fromOffset(20, 20),
        BackgroundTransparency = 1,
    }, 0.15)

    task.wait(0.17)
    GUI:Destroy()
end)

--========================================================
-- DRAG WINDOW (MOUSE + TOUCH)
--========================================================

local dragging = false
local dragStart
local startPosition

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = Main.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("[Fruit Hub Ultimate] Interface chargée.")
Notify("Fruit Hub", "Ultimate Purple Edition chargée.")
