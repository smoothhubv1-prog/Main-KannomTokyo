local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- กำหนด Font San Francisco Pro ผ่าน Font.fromId
local SFProFont = Font.fromId(12187365364, Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local SFProBoldFont = Font.fromId(12187365364, Enum.FontWeight.Bold, Enum.FontStyle.Normal)
local SFProMediumFont = Font.fromId(12187365364, Enum.FontWeight.Medium, Enum.FontStyle.Normal)

_G.SmoothHubConfig = {
    FastAttack = true,
    AntiAFK = true,
    AutoFarmLevelGhoul = false,
	AutoFarmLevelCCG = false,
    EnableFarmMonster = false, -- เพิ่มตัวแปรสำหรับเปิด/ปิด Farm Monster
    EnableAutoBoss = false, -- เพิ่มตัวแปรสำหรับเปิด/ปิด Auto Boss
    CurrentTheme = "Dark",
    MinimizeKey = Enum.KeyCode.B,
    StreamerMode = true,
    EnableFPSLock = true,
    FPSLock = 240,
    AutoRejoin = true,
    AntiAdmin = true, -- เพิ่มค่าเริ่มต้นของ Anti Admin
    FastMode = false,
    BlackScreen = false,
    WhiteScreen = false,
    EnableWalkSpeed = false,
    WalkSpeed = 16,
    EnableJumpPower = false,
    JumpPower = 50,
    Fly = false,
    FlySpeed = 50,
    Noclip = false,
    EnableRGB = false,
    -- Config สำหรับ Auto Upgrade Stats
    AutoUpgradeStats = false,
    StatSelection = {
        Damage = false,
        Durability = false,
        Stamina = false,
        Speed = false
    },
    DamageLimit = 0,
    DurabilityLimit = 0,
    StaminaLimit = 0,
    SpeedLimit = 0,
    CustomsAmount = 1
}

-- 🎨 ระบบสีธีมระดับพรีเมียม (Redesigned Aesthetic Themes)
local Themes = {
    Amber = {
        MainBg = Color3.fromRGB(22, 17, 13),
        Sidebar = Color3.fromRGB(38, 29, 21),
        Accent = Color3.fromRGB(255, 165, 43),
        Text = Color3.fromRGB(255, 243, 230),
        ContainerBg = Color3.fromRGB(30, 23, 17)
    },
    Crimson = {
        MainBg = Color3.fromRGB(20, 13, 15),
        Sidebar = Color3.fromRGB(38, 22, 26),
        Accent = Color3.fromRGB(255, 65, 88),
        Text = Color3.fromRGB(255, 235, 238),
        ContainerBg = Color3.fromRGB(28, 17, 20)
    },
    Dark = {
        MainBg = Color3.fromRGB(13, 13, 13),
        Sidebar = Color3.fromRGB(22, 22, 22),
        Accent = Color3.fromRGB(10, 132, 255),
        Text = Color3.fromRGB(240, 240, 240),
        HeaderText = Color3.fromRGB(255, 255, 255),
        ContainerBg = Color3.fromRGB(32, 32, 32)
    },
    Dracula = {
        MainBg = Color3.fromRGB(30, 30, 46),
        Sidebar = Color3.fromRGB(36, 36, 56),
        Accent = Color3.fromRGB(189, 147, 249),
        Text = Color3.fromRGB(248, 248, 242),
        ContainerBg = Color3.fromRGB(40, 42, 60)
    },
    Emerald = {
        MainBg = Color3.fromRGB(12, 22, 18),
        Sidebar = Color3.fromRGB(20, 37, 30),
        Accent = Color3.fromRGB(46, 204, 113),
        Text = Color3.fromRGB(230, 255, 240),
        ContainerBg = Color3.fromRGB(16, 29, 23)
    },
    Forest = {
        MainBg = Color3.fromRGB(12, 24, 16),
        Sidebar = Color3.fromRGB(20, 40, 28),
        Accent = Color3.fromRGB(46, 204, 113),
        Text = Color3.fromRGB(230, 245, 235),
        HeaderText = Color3.fromRGB(255, 255, 255),
        ContainerBg = Color3.fromRGB(26, 50, 36)
    },
    Gold = {
        MainBg = Color3.fromRGB(28, 25, 12),
        Sidebar = Color3.fromRGB(45, 40, 18),
        Accent = Color3.fromRGB(255, 215, 0),
        Text = Color3.fromRGB(255, 250, 210),
        HeaderText = Color3.fromRGB(255, 255, 255),
        ContainerBg = Color3.fromRGB(52, 46, 22)
    },
    Graphite = {
        MainBg = Color3.fromRGB(18, 18, 18),
        Sidebar = Color3.fromRGB(28, 28, 28),
        Accent = Color3.fromRGB(220, 220, 220),
        Text = Color3.fromRGB(245, 245, 245),
        ContainerBg = Color3.fromRGB(23, 23, 23)
    },
    Light = {
        MainBg = Color3.fromRGB(244, 246, 249),
        Sidebar = Color3.fromRGB(255, 255, 255),
        Accent = Color3.fromRGB(0, 113, 227),
        Text = Color3.fromRGB(29, 29, 31),
        ContainerBg = Color3.fromRGB(255, 255, 255)
    },
    Matrix = {
        MainBg = Color3.fromRGB(8, 17, 10),
        Sidebar = Color3.fromRGB(13, 28, 17),
        Accent = Color3.fromRGB(0, 255, 100),
        Text = Color3.fromRGB(210, 255, 220),
        ContainerBg = Color3.fromRGB(11, 23, 13)
    },
    Midnight = {
        MainBg = Color3.fromRGB(10, 13, 22),
        Sidebar = Color3.fromRGB(18, 23, 38),
        Accent = Color3.fromRGB(80, 130, 255),
        Text = Color3.fromRGB(235, 242, 255),
        ContainerBg = Color3.fromRGB(14, 18, 30)
    },
    Mocha = {
        MainBg = Color3.fromRGB(24, 19, 17),
        Sidebar = Color3.fromRGB(40, 31, 28),
        Accent = Color3.fromRGB(222, 135, 95),
        Text = Color3.fromRGB(255, 238, 230),
        ContainerBg = Color3.fromRGB(32, 25, 22)
    },
    Nocturne = {
        MainBg = Color3.fromRGB(14, 14, 24),
        Sidebar = Color3.fromRGB(24, 24, 42),
        Accent = Color3.fromRGB(150, 110, 255),
        Text = Color3.fromRGB(240, 235, 255),
        ContainerBg = Color3.fromRGB(19, 19, 33)
    },
    Nord = {
        MainBg = Color3.fromRGB(40, 44, 52),
        Sidebar = Color3.fromRGB(48, 52, 63),
        Accent = Color3.fromRGB(130, 180, 220),
        Text = Color3.fromRGB(236, 239, 244),
        ContainerBg = Color3.fromRGB(44, 48, 58)
    },
    Obsidian = {
        MainBg = Color3.fromRGB(10, 10, 10),
        Sidebar = Color3.fromRGB(18, 18, 18),
        Accent = Color3.fromRGB(10, 132, 255),
        Text = Color3.fromRGB(250, 250, 250),
        HeaderText = Color3.fromRGB(255, 255, 255),
        ContainerBg = Color3.fromRGB(14, 14, 14)
    },
    Rose = {
        MainBg = Color3.fromRGB(24, 17, 21),
        Sidebar = Color3.fromRGB(42, 28, 36),
        Accent = Color3.fromRGB(255, 105, 155),
        Text = Color3.fromRGB(255, 235, 242),
        ContainerBg = Color3.fromRGB(33, 22, 28)
    },
    Sakura = {
        MainBg = Color3.fromRGB(227, 206, 212),
        Sidebar = Color3.fromRGB(214, 184, 192),
        Accent = Color3.fromRGB(201, 98, 132),
        Text = Color3.fromRGB(56, 38, 42),
        HeaderText = Color3.fromRGB(148, 51, 80),
        ContainerBg = Color3.fromRGB(237, 219, 224)
    },
    Solar = {
        MainBg = Color3.fromRGB(20, 55, 100),
        Sidebar = Color3.fromRGB(15, 40, 75),
        Accent = Color3.fromRGB(0, 162, 255),
        Text = Color3.fromRGB(255, 255, 255),
        HeaderText = Color3.fromRGB(56, 182, 255),
        ContainerBg = Color3.fromRGB(28, 70, 125)
    },
    Steel = {
        MainBg = Color3.fromRGB(17, 21, 26),
        Sidebar = Color3.fromRGB(28, 35, 43),
        Accent = Color3.fromRGB(96, 156, 212),
        Text = Color3.fromRGB(235, 242, 250),
        ContainerBg = Color3.fromRGB(22, 28, 35)
    },
    Sunset = {
        MainBg = Color3.fromRGB(26, 15, 20),
        Sidebar = Color3.fromRGB(45, 25, 33),
        Accent = Color3.fromRGB(255, 100, 70),
        Text = Color3.fromRGB(255, 235, 228),
        ContainerBg = Color3.fromRGB(35, 20, 26)
    },
    Tokyo = {
        MainBg = Color3.fromRGB(17, 19, 27),
        Sidebar = Color3.fromRGB(27, 31, 44),
        Accent = Color3.fromRGB(122, 162, 247),
        Text = Color3.fromRGB(192, 202, 245),
        ContainerBg = Color3.fromRGB(22, 25, 35)
    },
    Violet = {
        MainBg = Color3.fromRGB(19, 15, 25),
        Sidebar = Color3.fromRGB(33, 25, 43),
        Accent = Color3.fromRGB(168, 100, 255),
        Text = Color3.fromRGB(245, 235, 255),
        ContainerBg = Color3.fromRGB(26, 20, 34)
    }
}

-- ฟังก์ชันตั้งค่า FPS Lock เริ่มต้นตอนรันสคริปต์
pcall(function()
    if setfpscap then
        if _G.SmoothHubConfig.EnableFPSLock then
            setfpscap(_G.SmoothHubConfig.FPSLock)
        else
            setfpscap(9999)
        end
    end
end)

-- ➕ ระบบทำงานเบื้องหลัง: Auto Upgrade Stats
task.spawn(function()
    while true do
        task.wait(0.2)
        pcall(function()
            if _G.SmoothHubConfig.AutoUpgradeStats then
                local dataEvent = ReplicatedStorage:FindFirstChild("BridgeNet2") and ReplicatedStorage.BridgeNet2:FindFirstChild("dataRemoteEvent")
                if dataEvent then
                    local statsToUpgrade = {"Damage", "Durability", "Stamina", "Speed"}
                    local limits = {
                        Damage = _G.SmoothHubConfig.DamageLimit,
                        Durability = _G.SmoothHubConfig.DurabilityLimit,
                        Stamina = _G.SmoothHubConfig.StaminaLimit,
                        Speed = _G.SmoothHubConfig.SpeedLimit
                    }
                    
                    for _, statName in ipairs(statsToUpgrade) do
                        if _G.SmoothHubConfig.StatSelection and _G.SmoothHubConfig.StatSelection[statName] then
                            local limit = limits[statName] or 0
                            local currentStatVal = 0
                            
                            local success, val = pcall(function()
                                local statFolder = LocalPlayer:FindFirstChild("Stat")
                                if statFolder then
                                    if statName == "Speed" then
                                        local speedValObj = statFolder:FindFirstChild("ความเร็ว") or statFolder:FindFirstChild("Speed")
                                        if speedValObj then return speedValObj.Value end
                                    else
                                        local statObj = statFolder:FindFirstChild(statName)
                                        if statObj then return statObj.Value end
                                    end
                                end
                                return LocalPlayer.PlayerStats[statName].Value
                            end)
                            
                            if success and type(val) == "number" then
                                currentStatVal = val
                            end
                            
                            if limit == 0 or currentStatVal < limit then
                                local amount = tonumber(_G.SmoothHubConfig.CustomsAmount) or 1
                                dataEvent:FireServer({
                                    {
                                        statName,
                                        amount
                                    },
                                    "\v"
                                })
                                task.wait(0.1)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

-- ระบบ Auto Rejoin
task.spawn(function()
    local coreGui = game:GetService("CoreGui")
    local promptError = coreGui:FindFirstChild("RobloxPromptGui")
    
    if promptError then
        local promptOverlay = promptError:FindFirstChild("promptOverlay")
        if promptOverlay then
            promptOverlay.ChildAdded:Connect(function(child)
                if child.Name == "ErrorPrompt" and _G.SmoothHubConfig.AutoRejoin then
                    task.wait(2)
                    pcall(function()
                        TeleportService:Teleport(game.PlaceId, LocalPlayer)
                    end)
                end
            end)
        end
    end

    GuiService.ErrorMessageChanged:Connect(function()
        if _G.SmoothHubConfig.AutoRejoin then
            task.wait(2)
            pcall(function()
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            end)
        end
    end)
end)

-- 🛡️ ระบบ Anti Admin (ตรวจจับแอดมินและย้ายเซิร์ฟเวอร์หนีอัตโนมัติ)
task.spawn(function()
    while true do
        task.wait(3)
        pcall(function()
            if _G.SmoothHubConfig.AntiAdmin then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local nameLower = string.lower(player.Name)
                        local dispLower = string.lower(player.DisplayName)
                        
                        if string.find(nameLower, "admin") or string.find(dispLower, "admin") or 
                           string.find(nameLower, "owner") or string.find(dispLower, "owner") or
                           string.find(nameLower, "mod") or string.find(dispLower, "mod") or
                           player:GetRankInGroup(game.PlaceId) >= 254 then
                            
                            TeleportService:Teleport(game.PlaceId, LocalPlayer)
                        end
                    end
                end
            end
        end)
    end
end)

local flyConnection
local bgConnection
local bvConnection

local function ToggleFly(state)
    _G.SmoothHubConfig.Fly = state
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoidRootPart or not humanoid then return end

        if state then
            local bv = Instance.new("BodyVelocity")
            bv.Name = "SmoothHub_FlyVelocity"
            bv.Parent = humanoidRootPart
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Velocity = Vector3.new(0, 0, 0)
            bvConnection = bv

            local bg = Instance.new("BodyGyro")
            bg.Name = "SmoothHub_FlyGyro"
            bg.Parent = humanoidRootPart
            bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
            bg.CFrame = humanoidRootPart.CFrame
            bgConnection = bg

            flyConnection = RunService.RenderStepped:Connect(function()
                if not _G.SmoothHubConfig.Fly then return end
                local camCFrame = Camera.CFrame
                local moveDir = Vector3.new(0, 0, 0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDir = moveDir + camCFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDir = moveDir - camCFrame.LookVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDir = moveDir - camCFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDir = moveDir + camCFrame.RightVector
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDir = moveDir + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                    moveDir = moveDir - Vector3.new(0, 1, 0)
                end

                bv.Velocity = moveDir * _G.SmoothHubConfig.FlySpeed
                bg.CFrame = camCFrame
            end)
        else
            if flyConnection then flyConnection:Disconnect() end
            if bvConnection then bvConnection:Destroy() end
            if bgConnection then bgConnection:Destroy() end
        end
    end)
end

RunService.Stepped:Connect(function()
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end
        local humanoid = character:FindFirstChild("Humanoid")
        if not humanoid then return end

        if _G.SmoothHubConfig.EnableWalkSpeed then
            humanoid.WalkSpeed = _G.SmoothHubConfig.WalkSpeed
        end
        if _G.SmoothHubConfig.EnableJumpPower then
            humanoid.JumpPower = _G.SmoothHubConfig.JumpPower
        end
    end)
end)

local noclipConnection
local function ToggleNoclip(state)
    _G.SmoothHubConfig.Noclip = state
    pcall(function()
        if state then
            noclipConnection = RunService.Stepped:Connect(function()
                if not _G.SmoothHubConfig.Noclip then return end
                local character = LocalPlayer.Character
                if character then
                    for _, part in ipairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConnection then noclipConnection:Disconnect() end
        end
    end)
end

local rgbConnection
local function ToggleRGB(state)
    _G.SmoothHubConfig.EnableRGB = state
    pcall(function()
        local character = LocalPlayer.Character
        if not character then return end

        if state then
            local highlight = character:FindFirstChild("SmoothHub_RGBHighlight")
            if not highlight then
                highlight = Instance.new("Highlight")
                highlight.Name = "SmoothHub_RGBHighlight"
                highlight.Adornee = character
                highlight.FillTransparency = 1
                highlight.OutlineTransparency = 0
                highlight.Parent = character
            end

            rgbConnection = RunService.RenderStepped:Connect(function()
                if not _G.SmoothHubConfig.EnableRGB then return end
                local hue = (tick() % 5) / 5
                local rainbowColor = Color3.fromHSV(hue, 1, 1)
                if highlight and highlight.Parent then
                    highlight.OutlineColor = rainbowColor
                end
            end)
        else
            if rgbConnection then rgbConnection:Disconnect() end
            local highlight = character:FindFirstChild("SmoothHub_RGBHighlight")
            if highlight then highlight:Destroy() end
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
    task.wait(1)
    if _G.SmoothHubConfig.EnableRGB then
        ToggleRGB(true)
    end
end)

local function ToggleFastMode(state)
    _G.SmoothHubConfig.FastMode = state
    pcall(function()
        if state then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
            Lighting.GlobalShadows = false
            Lighting.Brightness = 2
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
                    v.Enabled = false
                end
            end
            for _, v in ipairs(workspace:GetDescendants()) do
                if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
                    v.Enabled = false
                elseif v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                end
            end
        else
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
            Lighting.GlobalShadows = true
            for _, v in ipairs(Lighting:GetChildren()) do
                if v:IsA("PostEffect") or v:IsA("Sky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
                    v.Enabled = true
                end
            end
        end
    end)
end

local SleepGui = Instance.new("ScreenGui")
SleepGui.Name = "SmoothHub_SleepGui"
SleepGui.Parent = CoreGui
SleepGui.ResetOnSpawn = false
SleepGui.DisplayOrder = 9999999

local SleepFrame = Instance.new("TextButton")
SleepFrame.Name = "SleepFrame"
SleepFrame.Size = UDim2.new(2, 0, 2, 0)
SleepFrame.Position = UDim2.new(-0.5, 0, -0.5, 0)
SleepFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SleepFrame.BackgroundTransparency = 1
SleepFrame.Visible = false
SleepFrame.BorderSizePixel = 0
SleepFrame.AutoButtonColor = false
SleepFrame.Text = ""
SleepFrame.ZIndex = 999999
SleepFrame.Parent = SleepGui

local ProfileContainer = Instance.new("Frame")
ProfileContainer.Name = "ProfileContainer"
ProfileContainer.Size = UDim2.new(0, 300, 0, 50)
ProfileContainer.Position = UDim2.new(0.5, -150, 0.5, -38)
ProfileContainer.BackgroundTransparency = 1
ProfileContainer.Visible = false
ProfileContainer.ZIndex = 1000000
ProfileContainer.Parent = SleepFrame

local successAvatar, thumbUrl = pcall(function()
    return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
end)

local AvatarImage = Instance.new("ImageLabel")
AvatarImage.Name = "AvatarImage"
AvatarImage.Size = UDim2.new(0, 46, 0, 46)
AvatarImage.Position = UDim2.new(0, 0, 0.5, -23)
AvatarImage.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
AvatarImage.BackgroundTransparency = 0.5
AvatarImage.Image = successAvatar and thumbUrl or ""
AvatarImage.ZIndex = 1000000
AvatarImage.Parent = ProfileContainer

local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = AvatarImage

local AvatarStroke = Instance.new("UIStroke")
AvatarStroke.Name = "AvatarStroke"
AvatarStroke.Thickness = 2
AvatarStroke.Color = Color3.fromRGB(255, 255, 255)
AvatarStroke.Transparency = 0.3
AvatarStroke.Parent = AvatarImage

local NameStack = Instance.new("Frame")
NameStack.Name = "NameStack"
NameStack.Size = UDim2.new(1, -56, 1, 0)
NameStack.Position = UDim2.new(0, 56, 0, 0)
NameStack.BackgroundTransparency = 1
NameStack.ZIndex = 1000000
NameStack.Parent = ProfileContainer

local DisplayNameLabel = Instance.new("TextLabel")
DisplayNameLabel.Name = "DisplayNameLabel"
DisplayNameLabel.Size = UDim2.new(1, 0, 0, 24)
DisplayNameLabel.Position = UDim2.new(0, 0, 0, 2)
DisplayNameLabel.BackgroundTransparency = 1
DisplayNameLabel.FontFace = SFProBoldFont
DisplayNameLabel.TextSize = 16
DisplayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
DisplayNameLabel.TextTransparency = 1
DisplayNameLabel.TextXAlignment = Enum.TextXAlignment.Left
DisplayNameLabel.TextYAlignment = Enum.TextYAlignment.Center
DisplayNameLabel.Text = LocalPlayer.DisplayName
DisplayNameLabel.ZIndex = 1000000
DisplayNameLabel.Parent = NameStack

local UsernameLabel = Instance.new("TextLabel")
UsernameLabel.Name = "UsernameLabel"
UsernameLabel.Size = UDim2.new(1, 0, 0, 18)
UsernameLabel.Position = UDim2.new(0, 0, 0, 26)
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.FontFace = SFProMediumFont
UsernameLabel.TextSize = 13
UsernameLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
UsernameLabel.TextTransparency = 1
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.TextYAlignment = Enum.TextYAlignment.Center
UsernameLabel.Text = "@" .. LocalPlayer.Name
UsernameLabel.ZIndex = 1000000
UsernameLabel.Parent = NameStack

local SleepText = Instance.new("TextLabel")
SleepText.Size = UDim2.new(0, 450, 0, 40)
SleepText.Position = UDim2.new(0.5, -225, 0.5, 25)
SleepText.BackgroundTransparency = 1
SleepText.FontFace = SFProBoldFont
SleepText.TextSize = 15
SleepText.TextColor3 = Color3.fromRGB(255, 255, 255)
SleepText.TextTransparency = 1
SleepText.TextXAlignment = Enum.TextXAlignment.Center
SleepText.TextYAlignment = Enum.TextYAlignment.Center
SleepText.Text = "Sleep Mode Active (Double Click to exit)"
SleepText.Visible = false
SleepText.ZIndex = 1000000
SleepText.Parent = SleepFrame

local sleepToggleReferences = {}

local function DisableAllSleepToggles()
    _G.SmoothHubConfig.BlackScreen = false
    _G.SmoothHubConfig.WhiteScreen = false
    for _, tObj in ipairs(sleepToggleReferences) do
        if tObj and tObj.SetState then
            tObj.SetState(false, false)
        end
    end
end

local function UpdateSleepMode()
    local tweenInfo = TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    
    if _G.SmoothHubConfig.BlackScreen then
        SleepFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        SleepText.TextColor3 = Color3.fromRGB(255, 255, 255)
        AvatarStroke.Color = Color3.fromRGB(255, 255, 255)
        DisplayNameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        UsernameLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
        
        SleepFrame.Visible = true
        ProfileContainer.Visible = true
        SleepText.Visible = true
        
        TweenService:Create(SleepFrame, tweenInfo, {BackgroundTransparency = 0.2}):Play()
        TweenService:Create(AvatarImage, tweenInfo, {ImageTransparency = 0}):Play()
        TweenService:Create(AvatarStroke, tweenInfo, {Transparency = 0.2}):Play()
        TweenService:Create(DisplayNameLabel, tweenInfo, {TextTransparency = 0}):Play()
        TweenService:Create(UsernameLabel, tweenInfo, {TextTransparency = 0.1}):Play()
        TweenService:Create(SleepText, tweenInfo, {TextTransparency = 0.1}):Play()
        
    elseif _G.SmoothHubConfig.WhiteScreen then
        SleepFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SleepText.TextColor3 = Color3.fromRGB(0, 0, 0)
        AvatarStroke.Color = Color3.fromRGB(0, 0, 0)
        DisplayNameLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
        UsernameLabel.TextColor3 = Color3.fromRGB(90, 90, 90)
        
        SleepFrame.Visible = true
        ProfileContainer.Visible = true
        SleepText.Visible = true
        
        TweenService:Create(SleepFrame, tweenInfo, {BackgroundTransparency = 0.5}):Play()
        TweenService:Create(AvatarImage, tweenInfo, {ImageTransparency = 0}):Play()
        TweenService:Create(AvatarStroke, tweenInfo, {Transparency = 0.2}):Play()
        TweenService:Create(DisplayNameLabel, tweenInfo, {TextTransparency = 0}):Play()
        TweenService:Create(UsernameLabel, tweenInfo, {TextTransparency = 0.1}):Play()
        TweenService:Create(SleepText, tweenInfo, {TextTransparency = 0.1}):Play()
        
    else
        local outTween = TweenService:Create(SleepFrame, tweenInfo, {BackgroundTransparency = 1})
        TweenService:Create(AvatarImage, tweenInfo, {ImageTransparency = 1}):Play()
        TweenService:Create(AvatarStroke, tweenInfo, {Transparency = 1}):Play()
        TweenService:Create(DisplayNameLabel, tweenInfo, {TextTransparency = 1}):Play()
        TweenService:Create(UsernameLabel, tweenInfo, {TextTransparency = 1}):Play()
        TweenService:Create(SleepText, tweenInfo, {TextTransparency = 1}):Play()
        outTween:Play()
        
        outTween.Completed:Connect(function()
            if not _G.SmoothHubConfig.BlackScreen and not _G.SmoothHubConfig.WhiteScreen then
                SleepFrame.Visible = false
                ProfileContainer.Visible = false
                SleepText.Visible = false
            end
        end)
    end
end

local lastClickTick = 0
SleepFrame.MouseButton1Click:Connect(function()
    local currentTick = tick()
    if currentTick - lastClickTick <= 0.35 then
        DisableAllSleepToggles()
        UpdateSleepMode()
        lastClickTick = 0
    else
        lastClickTick = currentTick
        TweenService:Create(SleepText, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
        task.delay(0.1, function()
            TweenService:Create(SleepText, TweenInfo.new(0.1), {TextTransparency = 0.1}):Play()
        end)
    end
end)

-- 🔔 ระบบแจ้งเตือนข้างจอ
local NotifGui = Instance.new("ScreenGui")
NotifGui.Name = "SmoothHub_NotificationGui"
NotifGui.Parent = CoreGui
NotifGui.ResetOnSpawn = false
NotifGui.DisplayOrder = 99999999

local NotifContainer = Instance.new("ScrollingFrame")
NotifContainer.Name = "NotifContainer"
NotifContainer.Size = UDim2.new(0, 320, 1, -20)
NotifContainer.Position = UDim2.new(1, -335, 0, 10)
NotifContainer.BackgroundTransparency = 1
NotifContainer.BorderSizePixel = 0
NotifContainer.ScrollingEnabled = true
NotifContainer.ElasticBehavior = Enum.ElasticBehavior.Always
NotifContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
NotifContainer.Parent = NotifGui

local NotifLayout = Instance.new("UIListLayout")
NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Top
NotifLayout.Padding = UDim.new(0, 8)
NotifLayout.Parent = NotifContainer

NotifLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    NotifContainer.CanvasSize = UDim2.new(0, 0, 0, NotifLayout.AbsoluteContentSize.Y)
end)

local function ShowRedeemNotification(codeText, statusTitle)
    local Toast = Instance.new("Frame")
    Toast.Size = UDim2.new(1, 0, 0, 65)
    Toast.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Toast.BackgroundTransparency = 0.15
    Toast.BorderSizePixel = 0
    Toast.ClipsDescendants = true
    Toast.Parent = NotifContainer

    local ToastCorner = Instance.new("UICorner")
    ToastCorner.CornerRadius = UDim.new(0, 8)
    ToastCorner.Parent = Toast

    local ToastStroke = Instance.new("UIStroke")
    ToastStroke.Color = Color3.fromRGB(60, 60, 60)
    ToastStroke.Transparency = 0.5
    ToastStroke.Thickness = 1
    ToastStroke.Parent = Toast

    local MacDotsContainer = Instance.new("Frame")
    MacDotsContainer.Size = UDim2.new(0, 50, 0, 12)
    MacDotsContainer.Position = UDim2.new(0, 12, 0, 10)
    MacDotsContainer.BackgroundTransparency = 1
    MacDotsContainer.Parent = Toast

    local DotsLayout = Instance.new("UIListLayout")
    DotsLayout.FillDirection = Enum.FillDirection.Horizontal
    DotsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    DotsLayout.Padding = UDim.new(0, 5)
    DotsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    DotsLayout.Parent = MacDotsContainer

    local dotColors = {
        Color3.fromRGB(255, 95, 86),
        Color3.fromRGB(255, 189, 46),
        Color3.fromRGB(39, 201, 63)
    }

    for _, col in ipairs(dotColors) do
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 10, 0, 10)
        dot.BackgroundColor3 = col
        dot.BorderSizePixel = 0
        dot.Parent = MacDotsContainer

        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
    end

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -75, 0, 18)
    TitleLabel.Position = UDim2.new(0, 70, 0, 7)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.FontFace = SFProBoldFont
    TitleLabel.TextSize = 13
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Text = "Redeeming..."
    TitleLabel.Parent = Toast

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -24, 0, 20)
    DescLabel.Position = UDim2.new(0, 12, 0, 32)
    DescLabel.BackgroundTransparency = 1
    DescLabel.FontFace = SFProMediumFont
    DescLabel.TextSize = 12
    DescLabel.TextColor3 = Color3.fromRGB(180, 195, 200)
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Text = "Code: " .. tostring(codeText)
    DescLabel.Parent = Toast

    local LoadBarBg = Instance.new("Frame")
    LoadBarBg.Size = UDim2.new(1, 0, 0, 3)
    LoadBarBg.Position = UDim2.new(0, 0, 1, -3)
    LoadBarBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    LoadBarBg.BorderSizePixel = 0
    LoadBarBg.Parent = Toast

    local LoadBarFill = Instance.new("Frame")
    LoadBarFill.Size = UDim2.new(0, 0, 1, 0)
    LoadBarFill.BackgroundColor3 = Color3.fromRGB(10, 132, 255)
    LoadBarFill.BorderSizePixel = 0
    LoadBarFill.Parent = LoadBarBg

    Toast.Position = UDim2.new(1, 40, 0, 0)
    TweenService:Create(Toast, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()

    TweenService:Create(LoadBarFill, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 1, 0)
    }):Play()

    task.delay(0.5, function()
        if Toast and Toast.Parent then
            TitleLabel.Text = statusTitle or "Redeemed Code"
            LoadBarFill.BackgroundColor3 = Color3.fromRGB(39, 201, 63)
        end
    end)

    task.delay(10, function()
        if Toast and Toast.Parent then
            local outTween = TweenService:Create(Toast, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
                Position = UDim2.new(1, 40, 0, 0),
                BackgroundTransparency = 1
            })
            outTween:Play()
            outTween.Completed:Wait()
            Toast:Destroy()
        end
    end)
end

local SmoothHub = {}

local function BuildUI()
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SmoothHub_CoreUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local function UpdateStreamerMode(state)
    _G.SmoothHubConfig.StreamerMode = state
    pcall(function()
        if syn and syn.protect_gui then
            if state then
                syn.protect_gui(ScreenGui)
            end
        end
    end)
    if state then
        ScreenGui.DisplayOrder = 999999
    end
end

UpdateStreamerMode(_G.SmoothHubConfig.StreamerMode)

local SideTogglePill = Instance.new("TextButton")
SideTogglePill.Name = "SideTogglePill"
SideTogglePill.Size = UDim2.new(0, 260, 0, 7)
SideTogglePill.Position = UDim2.new(0.5, -130, 0, -45)
SideTogglePill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SideTogglePill.BackgroundTransparency = 0.2
SideTogglePill.Text = ""
SideTogglePill.AutoButtonColor = false
SideTogglePill.Active = true
SideTogglePill.ZIndex = 100
SideTogglePill.Parent = ScreenGui

local PillCorner = Instance.new("UICorner")
PillCorner.CornerRadius = UDim.new(1, 0)
PillCorner.Parent = SideTogglePill

SideTogglePill.MouseEnter:Connect(function()
    TweenService:Create(SideTogglePill, TweenInfo.new(0.15), {
        Size = UDim2.new(0, 300, 0, 11),
        Position = UDim2.new(0.5, -150, 0, -45),
        BackgroundTransparency = 0
    }):Play()
end)

SideTogglePill.MouseLeave:Connect(function()
    TweenService:Create(SideTogglePill, TweenInfo.new(0.15), {
        Size = UDim2.new(0, 260, 0, 7),
        Position = UDim2.new(0.5, -130, 0, -45),
        BackgroundTransparency = 0.2
    }):Play()
end)

local viewportSize = Camera.ViewportSize
local defaultWidth = 950
local defaultHeight = 570

if viewportSize.X < 1000 or viewportSize.Y < 650 then
	defaultWidth = math.clamp(viewportSize.X - 40, 420, 950)
	defaultHeight = math.clamp(viewportSize.Y - 60, 280, 570)
end

local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0, defaultWidth, 0, defaultHeight)
MainWindow.Position = UDim2.new(0.5, -defaultWidth / 2, 0.5, -defaultHeight / 2)
MainWindow.BackgroundColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].MainBg
MainWindow.BorderSizePixel = 0
MainWindow.ClipsDescendants = true 
MainWindow.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainWindow

local ResizeButtonTL = Instance.new("TextButton")
ResizeButtonTL.Name = "ResizeButtonTL"
ResizeButtonTL.Size = UDim2.new(0, 25, 0, 25)
ResizeButtonTL.Position = UDim2.new(0, 3, 0, 3)
ResizeButtonTL.BackgroundTransparency = 1
ResizeButtonTL.Text = ""
ResizeButtonTL.ZIndex = 50
ResizeButtonTL.Parent = MainWindow

for i = 1, 2 do
	local Line = Instance.new("Frame")
	Line.Size = UDim2.new(0, 10, 0, 2)
	Line.Position = UDim2.new(0, 4 + (i * 3), 0, 4 + (i * 3))
	Line.Rotation = 45
	Line.BackgroundColor3 = Color3.fromRGB(180, 180, 185)
	Line.BorderSizePixel = 0
	Line.ZIndex = 51
	Line.Parent = ResizeButtonTL
	
	local LineCorner = Instance.new("UICorner")
	LineCorner.CornerRadius = UDim.new(1, 0)
	LineCorner.Parent = Line
end

local ResizeButtonBR = Instance.new("TextButton")
ResizeButtonBR.Name = "ResizeButtonBR"
ResizeButtonBR.Size = UDim2.new(0, 25, 0, 25)
ResizeButtonBR.Position = UDim2.new(1, -28, 1, -28)
ResizeButtonBR.BackgroundTransparency = 1
ResizeButtonBR.Text = ""
ResizeButtonBR.ZIndex = 50
ResizeButtonBR.Parent = MainWindow

for i = 1, 2 do
	local Line = Instance.new("Frame")
	Line.Size = UDim2.new(0, 10, 0, 2)
	Line.Position = UDim2.new(1, -14 + (i * 3), 1, -10 + (i * 3))
	Line.Rotation = 45
	Line.BackgroundColor3 = Color3.fromRGB(180, 180, 185)
	Line.BorderSizePixel = 0
	Line.ZIndex = 51
	Line.Parent = ResizeButtonBR
	
	local LineCorner = Instance.new("UICorner")
	LineCorner.CornerRadius = UDim.new(1, 0)
	LineCorner.Parent = Line
end

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 180, 1, 0)
Sidebar.BackgroundColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].Sidebar
Sidebar.BackgroundTransparency = 0.75
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainWindow

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local SidebarFix = Instance.new("Frame")
SidebarFix.Name = "SidebarFix"
SidebarFix.Size = UDim2.new(0, 20, 1, 0)
SidebarFix.Position = UDim2.new(1, -20, 0, 0)
SidebarFix.BackgroundColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].Sidebar
SidebarFix.BackgroundTransparency = 0.75
SidebarFix.BorderSizePixel = 0
SidebarFix.ZIndex = 0
SidebarFix.Parent = Sidebar

local WindowControls = Instance.new("Frame")
WindowControls.Name = "WindowControls"
WindowControls.Size = UDim2.new(0, 80, 0, 30)
WindowControls.Position = UDim2.new(0, 15, 0, 15)
WindowControls.BackgroundTransparency = 1
WindowControls.Parent = Sidebar

local ControlsLayout = Instance.new("UIListLayout")
ControlsLayout.FillDirection = Enum.FillDirection.Horizontal
ControlsLayout.SortOrder = Enum.SortOrder.LayoutOrder
ControlsLayout.Padding = UDim.new(0, 8)
ControlsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ControlsLayout.Parent = WindowControls

local controlColors = {
	Color3.fromRGB(255, 95, 86),
	Color3.fromRGB(255, 189, 46),
	Color3.fromRGB(39, 201, 63)
}

local isMaximized = false
local normalSize = MainWindow.Size
local normalPos = MainWindow.Position
local controlSymbols = {}

for i, btnColor in ipairs(controlColors) do
	local Circle = Instance.new("TextButton")
	Circle.Name = "Control_" .. i
	Circle.Size = UDim2.new(0, 14, 0, 14)
	Circle.BackgroundColor3 = btnColor
	Circle.BorderSizePixel = 0
	Circle.Text = ""
	Circle.AutoButtonColor = false
	Circle.Parent = WindowControls
	
	local CircleCorner = Instance.new("UICorner")
	CircleCorner.CornerRadius = UDim.new(1, 0)
	CircleCorner.Parent = Circle
	
	local SymbolLabel = Instance.new("TextLabel")
	SymbolLabel.Name = "Symbol"
	SymbolLabel.Size = UDim2.new(1, 0, 1, 0)
	SymbolLabel.BackgroundTransparency = 1
	SymbolLabel.FontFace = SFProBoldFont
	SymbolLabel.TextSize = 15
	SymbolLabel.TextTransparency = 1
	SymbolLabel.TextXAlignment = Enum.TextXAlignment.Center
	SymbolLabel.TextYAlignment = Enum.TextYAlignment.Center
	SymbolLabel.Parent = Circle
	
	if i == 1 then
		SymbolLabel.Text = "×"
		SymbolLabel.TextColor3 = Color3.fromRGB(90, 0, 0)
	elseif i == 2 then
		SymbolLabel.Text = "↗"
		SymbolLabel.TextColor3 = Color3.fromRGB(90, 60, 0)
	elseif i == 3 then
		SymbolLabel.Text = "*"
		SymbolLabel.TextColor3 = Color3.fromRGB(0, 60, 10)
	end
	
	table.insert(controlSymbols, SymbolLabel)
	
	if i == 1 then
		Circle.MouseButton1Click:Connect(function()
			ScreenGui:Destroy()
			SleepGui:Destroy()
			NotifGui:Destroy()
		end)
	elseif i == 2 then
		Circle.MouseButton1Click:Connect(function()
			local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			if not isMaximized then
				normalSize = MainWindow.Size
				normalPos = MainWindow.Position
				isMaximized = true
				
				TweenService:Create(MainWindow, tweenInfo, {
					Size = UDim2.new(1, -40, 1, -40),
					Position = UDim2.new(0, 20, 0, 20)
				}):Play()
				
				MainCorner.CornerRadius = UDim.new(0, 12)
				SidebarCorner.CornerRadius = UDim.new(0, 12)
				ResizeButtonTL.Visible = false
				ResizeButtonBR.Visible = false
			else
				isMaximized = false
				TweenService:Create(MainWindow, tweenInfo, {
					Size = normalSize,
					Position = normalPos
				}):Play()
				
				MainCorner.CornerRadius = UDim.new(0, 12)
				SidebarCorner.CornerRadius = UDim.new(0, 12)
				ResizeButtonTL.Visible = true
				ResizeButtonBR.Visible = true
			end
		end)
	elseif i == 3 then
		Circle.MouseButton1Click:Connect(function()
			local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			isMaximized = false
			
			MainCorner.CornerRadius = UDim.new(0, 12)
			SidebarCorner.CornerRadius = UDim.new(0, 12)
			ResizeButtonTL.Visible = true
			ResizeButtonBR.Visible = true
			
			local currentVw = Camera.ViewportSize
			local defW = 950
			local defH = 570
			if currentVw.X < 1000 or currentVw.Y < 650 then
				defW = math.clamp(currentVw.X - 40, 420, 950)
				defH = math.clamp(currentVw.Y - 60, 280, 570)
			end
			
			TweenService:Create(MainWindow, tweenInfo, {
				Size = UDim2.new(0, defW, 0, defH),
				Position = UDim2.new(0.5, -defW / 2, 0.5, -defH / 2)
			}):Play()
		end)
	end
end

WindowControls.MouseEnter:Connect(function()
	for _, sym in ipairs(controlSymbols) do
		TweenService:Create(sym, TweenInfo.new(0.1), {TextTransparency = 0}):Play()
	end
end)

WindowControls.MouseLeave:Connect(function()
	for _, sym in ipairs(controlSymbols) do
		TweenService:Create(sym, TweenInfo.new(0.1), {TextTransparency = 1}):Play()
	end
end)

local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -180, 1, 0)
ContentArea.Position = UDim2.new(0, 180, 0, 0)
ContentArea.BackgroundColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].MainBg
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainWindow

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 12)
ContentCorner.Parent = ContentArea

local TopHeader = Instance.new("Frame")
TopHeader.Name = "TopHeader"
TopHeader.Size = UDim2.new(1, 0, 0, 55)
TopHeader.BackgroundTransparency = 1
TopHeader.Parent = ContentArea

local ToggleSidebarBtn = Instance.new("ImageButton")
ToggleSidebarBtn.Name = "ToggleSidebarBtn"
ToggleSidebarBtn.Size = UDim2.new(0, 32, 0, 26)
ToggleSidebarBtn.Position = UDim2.new(0, 12, 0, 14)
ToggleSidebarBtn.BackgroundTransparency = 1 
ToggleSidebarBtn.BorderSizePixel = 0
ToggleSidebarBtn.Image = "rbxassetid://115627370761282" 
ToggleSidebarBtn.Parent = TopHeader

local BackBtn = Instance.new("TextButton")
BackBtn.Name = "BackBtn"
BackBtn.Size = UDim2.new(0, 26, 0, 26)
BackBtn.Position = UDim2.new(0, 50, 0, 14)
BackBtn.BackgroundTransparency = 1
BackBtn.FontFace = SFProBoldFont
BackBtn.TextSize = 15
BackBtn.TextColor3 = Color3.fromRGB(150, 175, 180)
BackBtn.Text = "<"
BackBtn.Parent = TopHeader

local ForwardBtn = Instance.new("TextButton")
ForwardBtn.Name = "ForwardBtn"
ForwardBtn.Size = UDim2.new(0, 26, 0, 26)
ForwardBtn.Position = UDim2.new(0, 78, 0, 14)
ForwardBtn.BackgroundTransparency = 1
ForwardBtn.FontFace = SFProBoldFont
ForwardBtn.TextSize = 15
ForwardBtn.TextColor3 = Color3.fromRGB(120, 140, 145)
ForwardBtn.Text = ">"
ForwardBtn.Parent = TopHeader

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0, 100, 0, 18)
TitleLabel.Position = UDim2.new(0, 115, 0, 4)
TitleLabel.BackgroundTransparency = 1
TitleLabel.FontFace = SFProBoldFont
TitleLabel.TextSize = 13
TitleLabel.TextColor3 = Color3.fromRGB(80, 190, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
TitleLabel.Text = "Smooth Hub"
TitleLabel.Parent = TopHeader

local OnlineContainer = Instance.new("Frame")
OnlineContainer.Name = "OnlineContainer"
OnlineContainer.Size = UDim2.new(0, 100, 0, 18)
OnlineContainer.Position = UDim2.new(0, 222, 0, 4)
OnlineContainer.BackgroundTransparency = 1
OnlineContainer.Parent = TopHeader

local SeparatorLabel = Instance.new("TextLabel")
SeparatorLabel.Name = "SeparatorLabel"
SeparatorLabel.Size = UDim2.new(0, 15, 1, 0)
SeparatorLabel.Position = UDim2.new(0, 0, 0, 0)
SeparatorLabel.BackgroundTransparency = 1
SeparatorLabel.FontFace = SFProBoldFont
SeparatorLabel.TextSize = 11
SeparatorLabel.TextColor3 = Color3.fromRGB(120, 140, 145)
SeparatorLabel.TextXAlignment = Enum.TextXAlignment.Center
SeparatorLabel.TextYAlignment = Enum.TextYAlignment.Center
SeparatorLabel.Text = "|"
SeparatorLabel.Parent = OnlineContainer

local PulseWave = Instance.new("Frame")
PulseWave.Name = "PulseWave"
PulseWave.Size = UDim2.new(0, 6, 0, 6)
PulseWave.Position = UDim2.new(0, 21, 0.5, -3)
PulseWave.BackgroundColor3 = Color3.fromRGB(40, 220, 100)
PulseWave.BackgroundTransparency = 0.5
PulseWave.BorderSizePixel = 0
PulseWave.Parent = OnlineContainer

local PulseCorner = Instance.new("UICorner")
PulseCorner.CornerRadius = UDim.new(1, 0)
PulseCorner.Parent = PulseWave

local OnlineDot = Instance.new("Frame")
OnlineDot.Name = "OnlineDot"
OnlineDot.Size = UDim2.new(0, 6, 0, 6)
OnlineDot.Position = UDim2.new(0, 21, 0.5, -3)
OnlineDot.BackgroundColor3 = Color3.fromRGB(40, 220, 100)
OnlineDot.BorderSizePixel = 0
OnlineDot.ZIndex = 2
OnlineDot.Parent = OnlineContainer

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(1, 0)
DotCorner.Parent = OnlineDot

local OnlineText = Instance.new("TextLabel")
OnlineText.Name = "OnlineText"
OnlineText.Size = UDim2.new(1, -32, 1, 0)
OnlineText.Position = UDim2.new(0, 31, 0, 0)
OnlineText.BackgroundTransparency = 1
OnlineText.FontFace = SFProMediumFont
OnlineText.TextSize = 11
OnlineText.TextColor3 = Color3.fromRGB(40, 220, 100)
OnlineText.TextXAlignment = Enum.TextXAlignment.Left
OnlineText.TextYAlignment = Enum.TextYAlignment.Center
OnlineText.Text = "Online"
OnlineText.Parent = OnlineContainer

task.spawn(function()
	while true do
		PulseWave.Size = UDim2.new(0, 6, 0, 6)
		PulseWave.Position = UDim2.new(0, 21, 0.5, -3)
		PulseWave.BackgroundTransparency = 0.2
		
		TweenService:Create(PulseWave, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 16, 0, 16),
			Position = UDim2.new(0, 16, 0.5, -8),
			BackgroundTransparency = 1
		}):Play()
		
		task.wait(1.2)
	end
end)

local GameLabel = Instance.new("TextLabel")
GameLabel.Size = UDim2.new(0, 250, 0, 15)
GameLabel.Position = UDim2.new(0, 115, 0, 21)
GameLabel.BackgroundTransparency = 1
GameLabel.FontFace = SFProMediumFont
GameLabel.TextSize = 11
GameLabel.TextColor3 = Color3.fromRGB(200, 50, 50)
GameLabel.TextXAlignment = Enum.TextXAlignment.Left
GameLabel.TextYAlignment = Enum.TextYAlignment.Center
GameLabel.Text = "Game : Kanom tokyo"
GameLabel.Parent = TopHeader

local HeaderDetailContainer = Instance.new("Frame")
HeaderDetailContainer.Name = "HeaderDetailContainer"
HeaderDetailContainer.Size = UDim2.new(0, 300, 0, 16)
HeaderDetailContainer.Position = UDim2.new(0, 115, 0, 37)
HeaderDetailContainer.BackgroundTransparency = 1
HeaderDetailContainer.Parent = TopHeader

local HeaderIcon = Instance.new("ImageLabel")
HeaderIcon.Name = "HeaderIcon"
HeaderIcon.Size = UDim2.new(0, 14, 0, 14)
HeaderIcon.Position = UDim2.new(0, 0, 0.5, -7)
HeaderIcon.BackgroundTransparency = 1
HeaderIcon.Image = "rbxassetid://95299401214721"
HeaderIcon.ImageColor3 = Color3.fromRGB(150, 175, 180)
HeaderIcon.Parent = HeaderDetailContainer

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(1, -18, 1, 0)
SubtitleLabel.Position = UDim2.new(0, 18, 0, 0)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.FontFace = SFProMediumFont
SubtitleLabel.TextSize = 11
SubtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
SubtitleLabel.TextYAlignment = Enum.TextYAlignment.Center
SubtitleLabel.Text = "Main | Kanom Tokyo"
SubtitleLabel.Parent = HeaderDetailContainer

local SearchContainer = Instance.new("Frame")
SearchContainer.Name = "SearchContainer"
SearchContainer.Size = UDim2.new(0, 180, 0, 30)
SearchContainer.Position = UDim2.new(1, -200, 0, 12)
SearchContainer.BackgroundColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].ContainerBg
SearchContainer.BackgroundTransparency = 0.5
SearchContainer.BorderSizePixel = 0
SearchContainer.Parent = TopHeader

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchContainer

local SearchStroke = Instance.new("UIStroke")
SearchStroke.Color = Color3.fromRGB(255, 255, 255)
SearchStroke.Transparency = 0.85
SearchStroke.Thickness = 1
SearchStroke.Parent = SearchContainer

local SearchIcon = Instance.new("ImageLabel")
SearchIcon.Name = "SearchIcon"
SearchIcon.Size = UDim2.new(0, 14, 0, 14)
SearchIcon.Position = UDim2.new(0, 10, 0.5, -7)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Image = "rbxassetid://6034818372"
SearchIcon.ImageColor3 = Color3.fromRGB(150, 175, 180)
SearchIcon.Parent = SearchContainer

local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Size = UDim2.new(1, -34, 1, 0)
SearchBox.Position = UDim2.new(0, 30, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.FontFace = SFProMediumFont
SearchBox.TextSize = 13
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderColor3 = Color3.fromRGB(140, 160, 165)
SearchBox.PlaceholderText = "Search..."
SearchBox.Text = ""
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.TextYAlignment = Enum.TextYAlignment.Center
SearchBox.ClearTextOnFocus = true
SearchBox.Parent = SearchContainer

local Divider = Instance.new("Frame")
Divider.Name = "Divider"
Divider.Size = UDim2.new(1, -40, 0, 1)
Divider.Position = UDim2.new(0, 20, 0, 55)
Divider.BackgroundColor3 = Color3.fromRGB(35, 50, 53)
Divider.BorderSizePixel = 0
Divider.Parent = ContentArea

local PageContainer = Instance.new("Frame")
PageContainer.Name = "PageContainer"
PageContainer.Size = UDim2.new(1, -40, 1, -75)
PageContainer.Position = UDim2.new(0, 20, 0, 65)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = ContentArea

local NavigationScroll = Instance.new("ScrollingFrame")
NavigationScroll.Name = "NavigationScroll"
NavigationScroll.Size = UDim2.new(1, -16, 1, -60)
NavigationScroll.Position = UDim2.new(0, 8, 0, 50)
NavigationScroll.BackgroundTransparency = 1
NavigationScroll.BorderSizePixel = 0
NavigationScroll.ScrollBarThickness = 0
NavigationScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
NavigationScroll.Parent = Sidebar

local NavLayout = Instance.new("UIListLayout")
NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavLayout.Padding = UDim.new(0, 4)
NavLayout.Parent = NavigationScroll

NavLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	NavigationScroll.CanvasSize = UDim2.new(0, 0, 0, NavLayout.AbsoluteContentSize.Y + 15)
end)

local isSidebarExpanded = true
ToggleSidebarBtn.MouseButton1Click:Connect(function()
	isSidebarExpanded = not isSidebarExpanded
	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	
	if isSidebarExpanded then
		TweenService:Create(Sidebar, tweenInfo, {Size = UDim2.new(0, 180, 1, 0)}):Play()
		TweenService:Create(ContentArea, tweenInfo, {Size = UDim2.new(1, -180, 1, 0), Position = UDim2.new(0, 180, 0, 0)}):Play()
		Sidebar.Visible = true
	else
		TweenService:Create(Sidebar, tweenInfo, {Size = UDim2.new(0, 0, 1, 0)}):Play()
		TweenService:Create(ContentArea, tweenInfo, {Size = UDim2.new(1, 0, 1, 0), Position = UDim2.new(0, 0, 0, 0)}):Play()
		task.delay(0.2, function()
			if not isSidebarExpanded then Sidebar.Visible = false end
		end)
	end
end)

local allMenuButtons = {} 
local activePageWidgets = {} 
local allContainers = {}
local allToggles = {}
local allDropdownTexts = {}

local function ApplyTheme(themeName)
	local theme = Themes[themeName]
	if not theme then return end
	_G.SmoothHubConfig.CurrentTheme = themeName

	TweenService:Create(MainWindow, TweenInfo.new(0.2), {BackgroundColor3 = theme.MainBg}):Play()
	TweenService:Create(ContentArea, TweenInfo.new(0.2), {BackgroundColor3 = theme.MainBg}):Play()
	TweenService:Create(Sidebar, TweenInfo.new(0.2), {BackgroundColor3 = theme.Sidebar}):Play()
	SidebarFix.BackgroundColor3 = theme.Sidebar
	SearchContainer.BackgroundColor3 = theme.ContainerBg

	for _, container in ipairs(allContainers) do
		if container and container.Parent then
			container.BackgroundColor3 = theme.ContainerBg
		end
	end

	for _, toggleObj in ipairs(allToggles) do
		if toggleObj and toggleObj.Track and toggleObj.Circle then
			if toggleObj.State then
				toggleObj.Track.BackgroundColor3 = theme.Accent
			end
		end
	end

	for _, dt in ipairs(allDropdownTexts) do
		if dt and dt.Parent then
			dt.TextColor3 = theme.Accent
		end
	end
end

local function CreateCategoryHeader(text, order)
	local Label = Instance.new("TextLabel")
	Label.Name = "Category_" .. text
	Label.Size = UDim2.new(1, 0, 0, 25)
	Label.BackgroundTransparency = 1
	Label.FontFace = SFProMediumFont
	Label.TextSize = 12
	Label.TextColor3 = Color3.fromRGB(140, 160, 165)
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextYAlignment = Enum.TextYAlignment.Center
	Label.Text = "  " .. text
	Label.LayoutOrder = order
	Label.Parent = NavigationScroll
end

local function CreateNewPage(pageName)
	local NewPage = Instance.new("ScrollingFrame")
	NewPage.Name = pageName .. "Page"
	NewPage.Size = UDim2.new(1, 0, 1, 0)
	NewPage.BackgroundTransparency = 1
	NewPage.BorderSizePixel = 0
	NewPage.ScrollBarThickness = 0 
	NewPage.Visible = false
	NewPage.Parent = PageContainer
	
	local PageList = Instance.new("UIListLayout")
	PageList.SortOrder = Enum.SortOrder.LayoutOrder
	PageList.Padding = UDim.new(0, 16)
	PageList.Parent = NewPage
	
	PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		NewPage.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 20)
	end)
	
	return NewPage
end

local function SwitchTab(targetBtn, targetPage, subTitleText, imageAssetId)
	for _, item in ipairs(allMenuButtons) do
		TweenService:Create(item.Btn, TweenInfo.new(0.1), {BackgroundTransparency = 1}):Play()
		item.Txt.TextColor3 = Color3.fromRGB(180, 200, 205)
		local imgIcon = item.Btn:FindFirstChild("MenuIcon")
		if imgIcon then
			TweenService:Create(imgIcon, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(80, 190, 180)}):Play()
		end
		item.Page.Visible = false
	end
	
	TweenService:Create(targetBtn, TweenInfo.new(0.1), {BackgroundTransparency = 0.6, BackgroundColor3 = Color3.fromRGB(60, 110, 120)}):Play()
	targetBtn:FindFirstChildOfClass("TextLabel").TextColor3 = Color3.fromRGB(255, 255, 255)
	
	local activeIcon = targetBtn:FindFirstChild("MenuIcon")
	if activeIcon then
		TweenService:Create(activeIcon, TweenInfo.new(0.1), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
	end
	
	targetPage.Visible = true
	SubtitleLabel.Text = subTitleText
	HeaderIcon.Image = imageAssetId
	
	activePageWidgets = {}
	for _, child in ipairs(targetPage:GetChildren()) do
		if child:IsA("Frame") and child.Name:match("_GroupContainer") then
			for _, widget in ipairs(child:GetChildren()) do
				if widget:IsA("Frame") and widget.Name:match("_Widget") then
					table.insert(activePageWidgets, widget)
				end
			end
		end
	end
	
	SearchBox.Text = ""
end

local function AddMenuButton(imageAssetId, text, order, targetPage, subTitleText, isDefault)
	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, 0, 0, 34)
	Button.BackgroundColor3 = Color3.fromRGB(60, 110, 120)
	Button.BackgroundTransparency = isDefault and 0.6 or 1
	Button.BorderSizePixel = 0
	Button.Text = ""
	Button.LayoutOrder = order
	Button.Parent = NavigationScroll
	
	local ButtonCorner = Instance.new("UICorner")
	ButtonCorner.CornerRadius = UDim.new(0, 6)
	ButtonCorner.Parent = Button
	
	local ImageIcon = Instance.new("ImageLabel")
	ImageIcon.Name = "MenuIcon"
	ImageIcon.Size = UDim2.new(0, 18, 0, 18)
	ImageIcon.Position = UDim2.new(0, 10, 0.5, -9)
	ImageIcon.BackgroundTransparency = 1
	ImageIcon.Image = imageAssetId
	ImageIcon.ImageColor3 = isDefault and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(80, 190, 180)
	ImageIcon.Parent = Button
	
	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, -36, 1, 0)
	Label.Position = UDim2.new(0, 36, 0, 0)
	Label.BackgroundTransparency = 1
	Label.FontFace = SFProMediumFont
	Label.TextSize = 13
	Label.TextColor3 = isDefault and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 200, 205)
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextYAlignment = Enum.TextYAlignment.Center
	Label.Text = text
	Label.Parent = Button
	
	table.insert(allMenuButtons, {Btn = Button, Txt = Label, Page = targetPage})
	
	if isDefault then
		targetPage.Visible = true
		SubtitleLabel.Text = subTitleText
		HeaderIcon.Image = imageAssetId
		task.spawn(function()
			task.wait()
			activePageWidgets = {}
			for _, child in ipairs(targetPage:GetChildren()) do
				if child:IsA("Frame") and child.Name:match("_GroupContainer") then
					for _, widget in ipairs(child:GetChildren()) do
						if widget:IsA("Frame") and widget.Name:match("_Widget") then
							table.insert(activePageWidgets, widget)
						end
					end
				end
			end
		end)
	end
	
	Button.MouseButton1Click:Connect(function()
		SwitchTab(Button, targetPage, subTitleText, imageAssetId)
	end)
end

function SmoothHub:CreateCategory(categoryName, layoutOrder)
	CreateCategoryHeader(categoryName, layoutOrder)
end

function SmoothHub:CreatePage(imageAssetId, pageMenuName, layoutOrder, subTitleDescription, isFirstPage)
	local NewCanvas = CreateNewPage(pageMenuName)
	AddMenuButton(imageAssetId, pageMenuName, layoutOrder, NewCanvas, subTitleDescription, isFirstPage)
	return NewPageClass(NewCanvas)
end

local registeredToggles = {}
local sleepToggles = {}

function NewPageClass(targetCanvas)
	local PageObj = {}
	local sectionCounter = 0
	
	function PageObj:CreateSection(sectionEmoji, sectionTitle, sectionDesc)
		sectionCounter = sectionCounter + 1
		local baseOrder = sectionCounter * 10
		
		if sectionTitle and sectionTitle ~= "" then
			local SectionHeaderWrapper = Instance.new("Frame")
			SectionHeaderWrapper.Name = sectionTitle .. "_HeaderWrapper_" .. sectionCounter
			SectionHeaderWrapper.Size = UDim2.new(1, 0, 0, 40)
			SectionHeaderWrapper.LayoutOrder = baseOrder
			SectionHeaderWrapper.BackgroundTransparency = 1
			SectionHeaderWrapper.Parent = targetCanvas
			
			local HeaderLabel = Instance.new("TextLabel")
			HeaderLabel.Name = "HeaderLabel"
			HeaderLabel.Size = UDim2.new(1, 0, 0, 22)
			HeaderLabel.Position = UDim2.new(0, 0, 0, 0)
			HeaderLabel.BackgroundTransparency = 1
			HeaderLabel.FontFace = SFProMediumFont
			HeaderLabel.TextSize = 14
			HeaderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
			HeaderLabel.TextYAlignment = Enum.TextYAlignment.Center
			HeaderLabel.Text = sectionEmoji .. " " .. sectionTitle 
			HeaderLabel.Parent = SectionHeaderWrapper
			
			local DescLabel = Instance.new("TextLabel")
			DescLabel.Name = "DescLabel"
			DescLabel.Size = UDim2.new(1, 0, 0, 18)
			DescLabel.Position = UDim2.new(0, 0, 0, 22)
			DescLabel.BackgroundTransparency = 1
			DescLabel.FontFace = SFProMediumFont
			DescLabel.TextSize = 12
			DescLabel.TextColor3 = Color3.fromRGB(150, 165, 170)
			DescLabel.TextXAlignment = Enum.TextXAlignment.Left
			DescLabel.TextYAlignment = Enum.TextYAlignment.Center
			DescLabel.Text = sectionDesc
			DescLabel.Parent = SectionHeaderWrapper
		end
		
		local newGroupContainer = Instance.new("Frame")
		newGroupContainer.Name = "GroupContainer_" .. sectionCounter
		newGroupContainer.Size = UDim2.new(1, 0, 0, 0)
		newGroupContainer.LayoutOrder = baseOrder + 1
		newGroupContainer.BackgroundColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].ContainerBg
		newGroupContainer.BorderSizePixel = 0
		newGroupContainer.Parent = targetCanvas
		table.insert(allContainers, newGroupContainer)
		
		local GroupCorner = Instance.new("UICorner")
		GroupCorner.CornerRadius = UDim.new(0, 8)
		GroupCorner.Parent = newGroupContainer
		
		local newInnerLayout = Instance.new("UIListLayout")
		newInnerLayout.Name = "InnerLayout"
		newInnerLayout.SortOrder = Enum.SortOrder.LayoutOrder
		newInnerLayout.Parent = newGroupContainer
		
		newInnerLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			newGroupContainer.Size = UDim2.new(1, 0, 0, newInnerLayout.AbsoluteContentSize.Y)
		end)
		
		return newGroupContainer
	end

	local function GetLatestContainer()
		local lastContainer = nil
		for _, child in ipairs(targetCanvas:GetChildren()) do
			if child:IsA("Frame") and child.Name:match("GroupContainer_") then
				lastContainer = child
			end
		end
		if not lastContainer then
			lastContainer = PageObj:CreateSection("", "", "")
		end
		return lastContainer
	end

	function PageObj:CreateButton(buttonName, buttonDesc, callback)
		local callback = callback or function() end
		local targetContainer = GetLatestContainer()
		local widgetIndex = #targetContainer:GetChildren() - 1

		local WidgetFrame = Instance.new("Frame")
		WidgetFrame.Name = buttonName .. "_Widget"
		WidgetFrame.Size = UDim2.new(1, 0, 0, 64)
		WidgetFrame.BackgroundTransparency = 1
		WidgetFrame.BorderSizePixel = 0
		WidgetFrame.LayoutOrder = widgetIndex
		WidgetFrame.Parent = targetContainer

		if widgetIndex > 1 then
			local itemDivider = Instance.new("Frame")
			itemDivider.Name = "ItemDivider"
			itemDivider.Size = UDim2.new(1, -28, 0, 1)
			itemDivider.Position = UDim2.new(0, 14, 0, 0)
			itemDivider.BackgroundColor3 = Color3.fromRGB(35, 52, 56)
			itemDivider.BorderSizePixel = 0
			itemDivider.Parent = WidgetFrame
		end

		local WidgetTitle = Instance.new("TextLabel")
		WidgetTitle.Size = UDim2.new(1, -130, 0, 24)
		WidgetTitle.Position = UDim2.new(0, 14, 0, 11)
		WidgetTitle.BackgroundTransparency = 1
		WidgetTitle.FontFace = SFProMediumFont
		WidgetTitle.TextSize = 13
		WidgetTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
		WidgetTitle.TextXAlignment = Enum.TextXAlignment.Left
		WidgetTitle.TextYAlignment = Enum.TextYAlignment.Center
		WidgetTitle.Text = buttonName
		WidgetTitle.Parent = WidgetFrame

		local WidgetDesc = Instance.new("TextLabel")
		WidgetDesc.Size = UDim2.new(1, -130, 0, 18)
		WidgetDesc.Position = UDim2.new(0, 14, 0, 35)
		WidgetDesc.BackgroundTransparency = 1
		WidgetDesc.FontFace = SFProMediumFont
		WidgetDesc.TextSize = 11
		WidgetDesc.TextColor3 = Color3.fromRGB(140, 155, 160)
		WidgetDesc.TextXAlignment = Enum.TextXAlignment.Left
		WidgetDesc.TextYAlignment = Enum.TextYAlignment.Center
		WidgetDesc.Text = buttonDesc
		WidgetDesc.Parent = WidgetFrame

		local ActionButton = Instance.new("TextButton")
		ActionButton.Name = "ActionButton"
		ActionButton.Size = UDim2.new(0, 110, 0, 32)
		ActionButton.Position = UDim2.new(1, -124, 0.5, -16)
		ActionButton.BackgroundColor3 = Color3.fromRGB(35, 45, 50)
		ActionButton.BackgroundTransparency = 0.5
		ActionButton.BorderSizePixel = 0
		ActionButton.AutoButtonColor = true
		ActionButton.FontFace = SFProBoldFont
		ActionButton.TextSize = 12
		ActionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		ActionButton.Text = "Redeem"
		ActionButton.Parent = WidgetFrame

		local ActionCorner = Instance.new("UICorner")
		ActionCorner.CornerRadius = UDim.new(0, 6)
		ActionCorner.Parent = ActionButton

		ActionButton.MouseButton1Click:Connect(function()
			task.spawn(function()
				callback()
			end)
		end)
	end

	function PageObj:CreateStatus(statusName, defaultText, statusDesc)
		local currentStatus = defaultText or "Off"
		local hasDesc = statusDesc and statusDesc ~= ""
		
		local targetContainer = GetLatestContainer()
		local widgetIndex = #targetContainer:GetChildren() - 1

		local WidgetFrame = Instance.new("Frame")
		WidgetFrame.Name = statusName .. "_Widget"
		WidgetFrame.Size = UDim2.new(1, 0, 0, hasDesc and 64 or 50)
		WidgetFrame.BackgroundTransparency = 1
		WidgetFrame.BorderSizePixel = 0
		WidgetFrame.LayoutOrder = widgetIndex
		WidgetFrame.Parent = targetContainer

		if widgetIndex > 1 then
			local itemDivider = Instance.new("Frame")
			itemDivider.Name = "ItemDivider"
			itemDivider.Size = UDim2.new(1, -28, 0, 1)
			itemDivider.Position = UDim2.new(0, 14, 0, 0)
			itemDivider.BackgroundColor3 = Color3.fromRGB(35, 52, 56)
			itemDivider.BorderSizePixel = 0
			itemDivider.Parent = WidgetFrame
		end

		local WidgetTitle = Instance.new("TextLabel")
		WidgetTitle.Size = UDim2.new(1, -330, 0, hasDesc and 24 or 50)
		WidgetTitle.Position = UDim2.new(0, 14, 0, hasDesc and 11 or 0)
		WidgetTitle.BackgroundTransparency = 1
		WidgetTitle.FontFace = SFProMediumFont
		WidgetTitle.TextSize = 13
		WidgetTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
		WidgetTitle.TextXAlignment = Enum.TextXAlignment.Left
		WidgetTitle.TextYAlignment = Enum.TextYAlignment.Center
		WidgetTitle.Text = statusName
		WidgetTitle.Parent = WidgetFrame

		if hasDesc then
			local WidgetDesc = Instance.new("TextLabel")
			WidgetDesc.Size = UDim2.new(1, -330, 0, 18)
			WidgetDesc.Position = UDim2.new(0, 14, 0, 35)
			WidgetDesc.BackgroundTransparency = 1
			WidgetDesc.FontFace = SFProMediumFont
			WidgetDesc.TextSize = 11
			WidgetDesc.TextColor3 = Color3.fromRGB(140, 155, 160)
			WidgetDesc.TextXAlignment = Enum.TextXAlignment.Left
			WidgetDesc.TextYAlignment = Enum.TextYAlignment.Center
			WidgetDesc.Text = statusDesc
			WidgetDesc.Parent = WidgetFrame
		end

		local StatusText = Instance.new("TextLabel")
		StatusText.Name = "StatusText"
		StatusText.Size = UDim2.new(0, 320, 1, 0)
		StatusText.Position = UDim2.new(1, -334, 0, 0)
		StatusText.BackgroundTransparency = 1
		StatusText.FontFace = SFProMediumFont
		StatusText.TextSize = 12
		StatusText.TextColor3 = Color3.fromRGB(150, 165, 170)
		StatusText.TextXAlignment = Enum.TextXAlignment.Right
		StatusText.TextYAlignment = Enum.TextYAlignment.Center
		StatusText.Text = currentStatus
		StatusText.Parent = WidgetFrame

		local statusObj = {
			SetText = function(newText, color)
				StatusText.Text = newText
				if color then
					StatusText.TextColor3 = color
				end
			end
		}

		return statusObj
	end

	function PageObj:CreateToggle(toggleName, toggleDesc, callback)
		local callback = callback or function() end
		
		local configKey = toggleName:match("Anti%-AFK") and "AntiAFK" 
			or toggleName:match("Anti Admin") and "AntiAdmin"
			or toggleName:match("Ghoul") and "AutoFarmLevelGhoul" 
			or toggleName:match("CCG") and "AutoFarmLevelCCG"
			or toggleName:match("Enable Farm Monster") and "EnableFarmMonster"
			or toggleName:match("Auto Boss") and "EnableAutoBoss"
			or toggleName:match("Fast Attack") and "FastAttack"
			or toggleName:match("Streamer Mode") and "StreamerMode"
			or toggleName:match("Enable FPS Lock") and "EnableFPSLock"
			or toggleName:match("Auto Rejoin") and "AutoRejoin"
			or toggleName:match("Fast Mode") and "FastMode"
			or toggleName:match("Black Screen") and "BlackScreen"
			or toggleName:match("White Screen") and "WhiteScreen"
			or toggleName:match("Enable WalkSpeed") and "EnableWalkSpeed"
			or toggleName:match("Enable JumpPower") and "EnableJumpPower"
			or toggleName:match("Fly") and "Fly"
			or toggleName:match("Noclip") and "Noclip"
			or toggleName:match("Enable RGB") and "EnableRGB"
			or toggleName:match("Auto Upgrade") and "AutoUpgradeStats"
			
		local isToggled = configKey and _G.SmoothHubConfig[configKey] or false
		local targetContainer = GetLatestContainer()
		local widgetIndex = #targetContainer:GetChildren() - 1
		
		local WidgetFrame = Instance.new("Frame")
		WidgetFrame.Name = toggleName .. "_Widget"
		WidgetFrame.Size = UDim2.new(1, 0, 0, 64)
		WidgetFrame.BackgroundTransparency = 1
		WidgetFrame.BorderSizePixel = 0
		WidgetFrame.LayoutOrder = widgetIndex
		WidgetFrame.Parent = targetContainer
		
		if widgetIndex > 1 then
			local itemDivider = Instance.new("Frame")
			itemDivider.Name = "ItemDivider"
			itemDivider.Size = UDim2.new(1, -28, 0, 1)
			itemDivider.Position = UDim2.new(0, 14, 0, 0)
			itemDivider.BackgroundColor3 = Color3.fromRGB(35, 52, 56)
			itemDivider.BorderSizePixel = 0
			itemDivider.Parent = WidgetFrame
		end
		
		local WidgetTitle = Instance.new("TextLabel")
		WidgetTitle.Size = UDim2.new(1, -100, 0, 24)
		WidgetTitle.Position = UDim2.new(0, 14, 0, 11)
		WidgetTitle.BackgroundTransparency = 1
		WidgetTitle.FontFace = SFProMediumFont
		WidgetTitle.TextSize = 13
		WidgetTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
		WidgetTitle.TextXAlignment = Enum.TextXAlignment.Left
		WidgetTitle.TextYAlignment = Enum.TextYAlignment.Center
		WidgetTitle.Text = toggleName
		WidgetTitle.Parent = WidgetFrame
		
		local WidgetDesc = Instance.new("TextLabel")
		WidgetDesc.Size = UDim2.new(1, -100, 0, 18)
		WidgetDesc.Position = UDim2.new(0, 14, 0, 35)
		WidgetDesc.BackgroundTransparency = 1
		WidgetDesc.FontFace = SFProMediumFont
		WidgetDesc.TextSize = 11
		WidgetDesc.TextColor3 = Color3.fromRGB(140, 155, 160)
		WidgetDesc.TextXAlignment = Enum.TextXAlignment.Left
		WidgetDesc.TextYAlignment = Enum.TextYAlignment.Center
		WidgetDesc.Text = toggleDesc
		WidgetDesc.Parent = WidgetFrame
		
		local ToggleFrame = Instance.new("TextButton")
		ToggleFrame.Name = "ToggleTrack"
		ToggleFrame.Size = UDim2.new(0, 27.5, 0, 16)
		ToggleFrame.Position = UDim2.new(1, -44, 0.5, -8)
		ToggleFrame.BackgroundColor3 = isToggled and Themes[_G.SmoothHubConfig.CurrentTheme].Accent or Color3.fromRGB(48, 55, 65)
		ToggleFrame.BorderSizePixel = 0
		ToggleFrame.Text = ""
		ToggleFrame.AutoButtonColor = false
		ToggleFrame.Parent = WidgetFrame
		
		local ToggleCorner = Instance.new("UICorner")
		ToggleCorner.CornerRadius = UDim.new(1, 0)
		ToggleCorner.Parent = ToggleFrame
		
		local ToggleCircle = Instance.new("Frame")
		ToggleCircle.Name = "ToggleCircle"
		ToggleCircle.Size = UDim2.new(0, 12, 0, 12) 
		ToggleCircle.Position = isToggled and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
		ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleCircle.BorderSizePixel = 0
		ToggleCircle.Parent = ToggleFrame
		
		local CircleCorner = Instance.new("UICorner")
		CircleCorner.CornerRadius = UDim.new(1, 0)
		CircleCorner.Parent = ToggleCircle
		
		local toggleObj = {
			Name = toggleName,
			Track = ToggleFrame,
			Circle = ToggleCircle,
			State = isToggled,
			SetState = nil
		}
		table.insert(allToggles, toggleObj)
		
		local function UpdateVisual(state, animate)
			local currentThemeAccent = Themes[_G.SmoothHubConfig.CurrentTheme].Accent
			local tweenInfo = TweenInfo.new(animate and 0.15 or 0, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			if state then
				TweenService:Create(ToggleFrame, tweenInfo, {BackgroundColor3 = currentThemeAccent}):Play()
				TweenService:Create(ToggleCircle, tweenInfo, {Position = UDim2.new(1, -14, 0.5, -6)}):Play()
			else
				TweenService:Create(ToggleFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(48, 55, 65)}):Play()
				TweenService:Create(ToggleCircle, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -6)}):Play()
			end
		end
		
		toggleObj.SetState = function(state, fireCallback)
			if isToggled == state then return end
			isToggled = state
			toggleObj.State = state
			UpdateVisual(state, true)
			if fireCallback then
				task.spawn(function()
					callback(state)
				end)
			end
		end
		
		if toggleName:match("Auto Farm Level") then
			table.insert(registeredToggles, toggleObj)
		end
		
		if toggleName:match("Black Screen") or toggleName:match("White Screen") then
			table.insert(sleepToggles, toggleObj)
			table.insert(sleepToggleReferences, toggleObj)
		end
		
		ToggleFrame.MouseButton1Click:Connect(function()
			local newState = not isToggled
			if newState and toggleName:match("Auto Farm Level") then
				for _, otherToggle in ipairs(registeredToggles) do
					if otherToggle.Name ~= toggleName then
						otherToggle.SetState(false, true)
					end
				end
			elseif newState and (toggleName:match("Black Screen") or toggleName:match("White Screen")) then
				for _, otherToggle in ipairs(sleepToggles) do
					if otherToggle.Name ~= toggleName then
						otherToggle.SetState(false, true)
					end
				end
			end
			toggleObj.SetState(newState, true)
			
			if toggleName:match("Streamer Mode") then
				UpdateStreamerMode(newState)
			end
		end)
	end

	function PageObj:CreateTextbox(boxName, boxDesc, defaultVal, callback)
		local callback = callback or function() end
		local currentValue = tostring(defaultVal or "0")
		
		local targetContainer = GetLatestContainer()
		local widgetIndex = #targetContainer:GetChildren() - 1

		local WidgetFrame = Instance.new("Frame")
		WidgetFrame.Name = boxName .. "_Widget"
		WidgetFrame.Size = UDim2.new(1, 0, 0, 64)
		WidgetFrame.BackgroundTransparency = 1
		WidgetFrame.BorderSizePixel = 0
		WidgetFrame.LayoutOrder = widgetIndex
		WidgetFrame.Parent = targetContainer

		if widgetIndex > 1 then
			local itemDivider = Instance.new("Frame")
			itemDivider.Name = "ItemDivider"
			itemDivider.Size = UDim2.new(1, -28, 0, 1)
			itemDivider.Position = UDim2.new(0, 14, 0, 0)
			itemDivider.BackgroundColor3 = Color3.fromRGB(35, 52, 56)
			itemDivider.BorderSizePixel = 0
			itemDivider.Parent = WidgetFrame
		end

		local WidgetTitle = Instance.new("TextLabel")
		WidgetTitle.Size = UDim2.new(1, -160, 0, 24)
		WidgetTitle.Position = UDim2.new(0, 14, 0, 11)
		WidgetTitle.BackgroundTransparency = 1
		WidgetTitle.FontFace = SFProMediumFont
		WidgetTitle.TextSize = 13
		WidgetTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
		WidgetTitle.TextXAlignment = Enum.TextXAlignment.Left
		WidgetTitle.TextYAlignment = Enum.TextYAlignment.Center
		WidgetTitle.Text = boxName
		WidgetTitle.Parent = WidgetFrame

		local WidgetDesc = Instance.new("TextLabel")
		WidgetDesc.Size = UDim2.new(1, -160, 0, 18)
		WidgetDesc.Position = UDim2.new(0, 14, 0, 35)
		WidgetDesc.BackgroundTransparency = 1
		WidgetDesc.FontFace = SFProMediumFont
		WidgetDesc.TextSize = 11
		WidgetDesc.TextColor3 = Color3.fromRGB(140, 155, 160)
		WidgetDesc.TextXAlignment = Enum.TextXAlignment.Left
		WidgetDesc.TextYAlignment = Enum.TextYAlignment.Center
		WidgetDesc.Text = boxDesc
		WidgetDesc.Parent = WidgetFrame

		local InputBox = Instance.new("TextBox")
		InputBox.Name = "InputBox"
		InputBox.Size = UDim2.new(0, 140, 0, 32)
		InputBox.Position = UDim2.new(1, -150, 0.5, -16)
		InputBox.BackgroundColor3 = Color3.fromRGB(35, 45, 50)
		InputBox.BackgroundTransparency = 0.5
		InputBox.BorderSizePixel = 0
		InputBox.FontFace = SFProMediumFont
		InputBox.TextSize = 13
		InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		InputBox.PlaceholderText = "0"
		InputBox.Text = currentValue
		InputBox.ClearTextOnFocus = false
		InputBox.Parent = WidgetFrame

		local InputCorner = Instance.new("UICorner")
		InputCorner.CornerRadius = UDim.new(0, 6)
		InputCorner.Parent = InputBox

		InputBox.Focused:Connect(function()
			local currentNum = tonumber(InputBox.Text) or 0
			if currentNum == 0 then
				InputBox.Text = ""
			end
		end)

		InputBox.FocusLost:Connect(function(enterPressed)
			local num = tonumber(InputBox.Text) or 0
			
			if boxName == "Damage" or boxName == "Durability" or boxName == "Stamina" or boxName == "Speed" then
				local isSelected = false
				if type(_G.SmoothHubConfig.StatSelection) == "table" then
					isSelected = _G.SmoothHubConfig.StatSelection[boxName] == true
				end
				
				if not isSelected then
					num = 0
				else
					if boxName == "Damage" or boxName == "Durability" then
						num = math.clamp(num, 0, 5000)
					elseif boxName == "Stamina" or boxName == "Speed" then
						num = math.clamp(num, 0, 150)
					end
				end
			elseif boxName == "Damage" or boxName == "Durability" then
				num = math.clamp(num, 0, 5000)
			elseif boxName == "Stamina" or boxName == "Speed" then
				num = math.clamp(num, 0, 150)
			end
			
			InputBox.Text = tostring(num)
			
			if boxName == "Damage" then
				_G.SmoothHubConfig.DamageLimit = num
			elseif boxName == "Durability" then
				_G.SmoothHubConfig.DurabilityLimit = num
			elseif boxName == "Stamina" then
				_G.SmoothHubConfig.StaminaLimit = num
			elseif boxName == "Speed" then
				_G.SmoothHubConfig.SpeedLimit = num
			end

			task.spawn(function()
				callback(num)
			end)
		end)
	end

	function PageObj:CreateSlider(sliderName, sliderDesc, minVal, maxVal, defaultVal, callback)
		local callback = callback or function() end
		local currentValue = defaultVal or minVal
		_G.SmoothHubConfig[sliderName:gsub("%s+", "")] = currentValue

		local targetContainer = GetLatestContainer()
		local widgetIndex = #targetContainer:GetChildren() - 1

		local WidgetFrame = Instance.new("Frame")
		WidgetFrame.Name = sliderName .. "_Widget"
		WidgetFrame.Size = UDim2.new(1, 0, 0, 70)
		WidgetFrame.BackgroundTransparency = 1
		WidgetFrame.BorderSizePixel = 0
		WidgetFrame.LayoutOrder = widgetIndex
		WidgetFrame.Parent = targetContainer

		if widgetIndex > 1 then
			local itemDivider = Instance.new("Frame")
			itemDivider.Name = "ItemDivider"
			itemDivider.Size = UDim2.new(1, -28, 0, 1)
			itemDivider.Position = UDim2.new(0, 14, 0, 0)
			itemDivider.BackgroundColor3 = Color3.fromRGB(35, 52, 56)
			itemDivider.BorderSizePixel = 0
			itemDivider.Parent = WidgetFrame
		end

		local WidgetTitle = Instance.new("TextLabel")
		WidgetTitle.Size = UDim2.new(1, -100, 0, 24)
		WidgetTitle.Position = UDim2.new(0, 14, 0, 8)
		WidgetTitle.BackgroundTransparency = 1
		WidgetTitle.FontFace = SFProMediumFont
		WidgetTitle.TextSize = 13
		WidgetTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
		WidgetTitle.TextXAlignment = Enum.TextXAlignment.Left
		WidgetTitle.TextYAlignment = Enum.TextYAlignment.Center
		WidgetTitle.Text = sliderName
		WidgetTitle.Parent = WidgetFrame

		local ValueLabel = Instance.new("TextLabel")
		ValueLabel.Size = UDim2.new(0, 80, 0, 24)
		ValueLabel.Position = UDim2.new(1, -94, 0, 8)
		ValueLabel.BackgroundTransparency = 1
		ValueLabel.FontFace = SFProBoldFont
		ValueLabel.TextSize = 13
		ValueLabel.TextColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].Accent
		ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
		ValueLabel.TextYAlignment = Enum.TextYAlignment.Center
		ValueLabel.Text = tostring(currentValue)
		ValueLabel.Parent = WidgetFrame
		table.insert(allDropdownTexts, ValueLabel)

		local SliderBar = Instance.new("TextButton")
		SliderBar.Name = "SliderBar"
		SliderBar.Size = UDim2.new(1, -28, 0, 6)
		SliderBar.Position = UDim2.new(0, 14, 0, 48)
		SliderBar.BackgroundColor3 = Color3.fromRGB(48, 55, 65)
		SliderBar.BorderSizePixel = 0
		SliderBar.AutoButtonColor = false
		SliderBar.Text = ""
		SliderBar.Parent = WidgetFrame

		local BarCorner = Instance.new("UICorner")
		BarCorner.CornerRadius = UDim.new(1, 0)
		BarCorner.Parent = SliderBar

		local SliderFill = Instance.new("Frame")
		SliderFill.Name = "SliderFill"
		SliderFill.Size = UDim2.new(math.clamp((currentValue - minVal) / (maxVal - minVal), 0, 1), 0, 1, 0)
		SliderFill.BackgroundColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].Accent
		SliderFill.BorderSizePixel = 0
		SliderFill.Parent = SliderBar

		local FillCorner = Instance.new("UICorner")
		FillCorner.CornerRadius = UDim.new(1, 0)
		FillCorner.Parent = SliderFill

		local SliderKnob = Instance.new("Frame")
		SliderKnob.Name = "SliderKnob"
		SliderKnob.Size = UDim2.new(0, 14, 0, 14)
		SliderKnob.Position = UDim2.new(1, -7, 0.5, -7)
		SliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SliderKnob.BorderSizePixel = 0
		SliderKnob.Parent = SliderFill

		local KnobCorner = Instance.new("UICorner")
		KnobCorner.CornerRadius = UDim.new(1, 0)
		KnobCorner.Parent = SliderKnob

		local draggingSlider = false

		local function updateSlider(input)
			local pos = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
			local val = math.floor(minVal + ((maxVal - minVal) * pos))
			currentValue = val
			ValueLabel.Text = tostring(val)
			SliderFill.Size = UDim2.new(pos, 0, 1, 0)
			_G.SmoothHubConfig[sliderName:gsub("%s+", "")] = val
			task.spawn(function()
				callback(val)
			end)
		end

		SliderBar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				draggingSlider = true
				updateSlider(input)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				draggingSlider = false
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				updateSlider(input)
			end
		end)
	end

	function PageObj:CreateHotkey(hotkeyName, hotkeyDesc, defaultKey, callback)
		local callback = callback or function() end
		local selectedKey = defaultKey or _G.SmoothHubConfig.MinimizeKey or Enum.KeyCode.B
		local targetContainer = GetLatestContainer()
		local widgetIndex = #targetContainer:GetChildren() - 1

		local WidgetFrame = Instance.new("Frame")
		WidgetFrame.Name = hotkeyName .. "_Widget"
		WidgetFrame.Size = UDim2.new(1, 0, 0, 64)
		WidgetFrame.BackgroundTransparency = 1
		WidgetFrame.BorderSizePixel = 0
		WidgetFrame.LayoutOrder = widgetIndex
		WidgetFrame.Parent = targetContainer

		if widgetIndex > 1 then
			local itemDivider = Instance.new("Frame")
			itemDivider.Name = "ItemDivider"
			itemDivider.Size = UDim2.new(1, -28, 0, 1)
			itemDivider.Position = UDim2.new(0, 14, 0, 0)
			itemDivider.BackgroundColor3 = Color3.fromRGB(35, 52, 56)
			itemDivider.BorderSizePixel = 0
			itemDivider.Parent = WidgetFrame
		end

		local WidgetTitle = Instance.new("TextLabel")
		WidgetTitle.Size = UDim2.new(1, -100, 0, 24)
		WidgetTitle.Position = UDim2.new(0, 14, 0, 11)
		WidgetTitle.BackgroundTransparency = 1
		WidgetTitle.FontFace = SFProMediumFont
		WidgetTitle.TextSize = 13
		WidgetTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
		WidgetTitle.TextXAlignment = Enum.TextXAlignment.Left
		WidgetTitle.TextYAlignment = Enum.TextYAlignment.Center
		WidgetTitle.Text = hotkeyName
		WidgetTitle.Parent = WidgetFrame

		local WidgetDesc = Instance.new("TextLabel")
		WidgetDesc.Size = UDim2.new(1, -100, 0, 18)
		WidgetDesc.Position = UDim2.new(0, 14, 0, 35)
		WidgetDesc.BackgroundTransparency = 1
		WidgetDesc.FontFace = SFProMediumFont
		WidgetDesc.TextSize = 11
		WidgetDesc.TextColor3 = Color3.fromRGB(140, 155, 160)
		WidgetDesc.TextXAlignment = Enum.TextXAlignment.Left
		WidgetDesc.TextYAlignment = Enum.TextYAlignment.Center
		WidgetDesc.Text = hotkeyDesc
		WidgetDesc.Parent = WidgetFrame

		local KeyButton = Instance.new("TextButton")
		KeyButton.Name = "KeyButton"
		KeyButton.Size = UDim2.new(0, 36, 0, 26)
		KeyButton.Position = UDim2.new(1, -50, 0.5, -13)
		KeyButton.BackgroundColor3 = Color3.fromRGB(35, 45, 50)
		KeyButton.BorderSizePixel = 0
		KeyButton.AutoButtonColor = false
		KeyButton.FontFace = SFProBoldFont
		KeyButton.TextSize = 12
		KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		KeyButton.Text = selectedKey.Name
		KeyButton.Parent = WidgetFrame

		local KeyCorner = Instance.new("UICorner")
		KeyCorner.CornerRadius = UDim.new(0, 6)
		KeyCorner.Parent = KeyButton

		local isListening = false

		KeyButton.MouseButton1Click:Connect(function()
			if isListening then return end
			isListening = true
			KeyButton.Text = "..."
			KeyButton.TextColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].Accent

			local connection
			connection = UserInputService.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.Keyboard then
					selectedKey = input.KeyCode
					KeyButton.Text = selectedKey.Name
					KeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					_G.SmoothHubConfig.MinimizeKey = selectedKey
					isListening = false
					connection:Disconnect()
					task.spawn(function()
						callback(selectedKey)
					end)
				end
			end)
		end)
	end

	function PageObj:CreateDropdown(dropdownName, dropdownDesc, optionsList, defaultOption, callback)
		local callback = callback or function() end
		local selectedOption = defaultOption or optionsList[1]
		_G.SmoothHubConfig[dropdownName] = selectedOption

		local targetContainer = GetLatestContainer()
		local widgetIndex = #targetContainer:GetChildren() - 1

		local WidgetFrame = Instance.new("Frame")
		WidgetFrame.Name = dropdownName .. "_Widget"
		WidgetFrame.Size = UDim2.new(1, 0, 0, 64)
		WidgetFrame.BackgroundTransparency = 1
		WidgetFrame.BorderSizePixel = 0
		WidgetFrame.LayoutOrder = widgetIndex
		WidgetFrame.Parent = targetContainer

		if widgetIndex > 1 then
			local itemDivider = Instance.new("Frame")
			itemDivider.Name = "ItemDivider"
			itemDivider.Size = UDim2.new(1, -28, 0, 1)
			itemDivider.Position = UDim2.new(0, 14, 0, 0)
			itemDivider.BackgroundColor3 = Color3.fromRGB(35, 52, 56)
			itemDivider.BorderSizePixel = 0
			itemDivider.Parent = WidgetFrame
		end

		local WidgetTitle = Instance.new("TextLabel")
		WidgetTitle.Size = UDim2.new(1, -160, 0, 24)
		WidgetTitle.Position = UDim2.new(0, 14, 0, 11)
		WidgetTitle.BackgroundTransparency = 1
		WidgetTitle.FontFace = SFProMediumFont
		WidgetTitle.TextSize = 13
		WidgetTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
		WidgetTitle.TextXAlignment = Enum.TextXAlignment.Left
		WidgetTitle.TextYAlignment = Enum.TextYAlignment.Center
		WidgetTitle.Text = dropdownName
		WidgetTitle.Parent = WidgetFrame

		local WidgetDesc = Instance.new("TextLabel")
		WidgetDesc.Size = UDim2.new(1, -160, 0, 18)
		WidgetDesc.Position = UDim2.new(0, 14, 0, 35)
		WidgetDesc.BackgroundTransparency = 1
		WidgetDesc.FontFace = SFProMediumFont
		WidgetDesc.TextSize = 11
		WidgetDesc.TextColor3 = Color3.fromRGB(140, 155, 160)
		WidgetDesc.TextXAlignment = Enum.TextXAlignment.Left
		WidgetDesc.TextYAlignment = Enum.TextYAlignment.Center
		WidgetDesc.Text = dropdownDesc
		WidgetDesc.Parent = WidgetFrame

		local DropdownButton = Instance.new("TextButton")
		DropdownButton.Name = "DropdownButton"
		DropdownButton.Size = UDim2.new(0, 140, 0, 32)
		DropdownButton.Position = UDim2.new(1, -150, 0.5, -16)
		DropdownButton.BackgroundTransparency = 1
		DropdownButton.BorderSizePixel = 0
		DropdownButton.AutoButtonColor = false
		DropdownButton.Text = ""
		DropdownButton.Parent = WidgetFrame

		local DropdownText = Instance.new("TextLabel")
		DropdownText.Name = "DropdownText"
		DropdownText.Size = UDim2.new(1, -24, 1, 0)
		DropdownText.Position = UDim2.new(0, 0, 0, 0)
		DropdownText.BackgroundTransparency = 1
		DropdownText.FontFace = SFProMediumFont
		DropdownText.TextSize = 13
		DropdownText.TextColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].Accent
		DropdownText.TextXAlignment = Enum.TextXAlignment.Right
		DropdownText.TextYAlignment = Enum.TextYAlignment.Center
		DropdownText.Text = selectedOption
		DropdownText.Parent = DropdownButton
		table.insert(allDropdownTexts, DropdownText)

		local DropdownArrow = Instance.new("ImageLabel")
		DropdownArrow.Name = "DropdownArrow"
		DropdownArrow.Size = UDim2.new(0, 14, 0, 14)
		DropdownArrow.Position = UDim2.new(1, -16, 0.5, -7)
		DropdownArrow.BackgroundTransparency = 1
		DropdownArrow.Image = "rbxassetid://77844815691418"
		DropdownArrow.ImageColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].Accent
		DropdownArrow.Parent = DropdownButton

		local DropdownListFrame = Instance.new("ScrollingFrame")
		DropdownListFrame.Name = "DropdownListFrame"
		DropdownListFrame.Size = UDim2.new(0, 140, 0, 0)
		DropdownListFrame.Position = UDim2.new(1, -150, 1, -10)
		DropdownListFrame.BackgroundColor3 = Color3.fromRGB(22, 35, 38)
		DropdownListFrame.BackgroundTransparency = 1
		DropdownListFrame.BorderSizePixel = 0
		DropdownListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		DropdownListFrame.ScrollBarThickness = 5
		DropdownListFrame.ScrollingEnabled = true
		DropdownListFrame.ElasticBehavior = Enum.ElasticBehavior.Always
		DropdownListFrame.Visible = false
		DropdownListFrame.ZIndex = 500
		DropdownListFrame.Parent = ScreenGui

		local ListCorner = Instance.new("UICorner")
		ListCorner.CornerRadius = UDim.new(0, 6)
		ListCorner.Parent = DropdownListFrame

		local ListLayout = Instance.new("UIListLayout")
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Parent = DropdownListFrame

		ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			DropdownListFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
		end)

		local optionButtons = {}
		local activeTween = nil

		for _, opt in ipairs(optionsList) do
			local OptionBtn = Instance.new("TextButton")
			OptionBtn.Name = "Option_" .. opt
			OptionBtn.Size = UDim2.new(1, 0, 0, 30)
			OptionBtn.BackgroundTransparency = 1
			OptionBtn.BorderSizePixel = 0
			OptionBtn.AutoButtonColor = false
			OptionBtn.Text = ""
			OptionBtn.ZIndex = 501
			OptionBtn.Parent = DropdownListFrame

			local CheckIcon = Instance.new("ImageLabel")
			CheckIcon.Name = "CheckIcon"
			CheckIcon.Size = UDim2.new(0, 12, 0, 12)
			CheckIcon.Position = UDim2.new(0, 8, 0.5, -6)
			CheckIcon.BackgroundTransparency = 1
			CheckIcon.Image = "rbxassetid://115627370761282"
			CheckIcon.ImageColor3 = Color3.fromRGB(50, 225, 130)
			CheckIcon.Visible = (opt == selectedOption)
			CheckIcon.ZIndex = 502
			CheckIcon.Parent = OptionBtn

			local OptionText = Instance.new("TextLabel")
			OptionText.Name = "OptionText"
			OptionText.Size = UDim2.new(1, -26, 1, 0)
			OptionText.Position = UDim2.new(0, 26, 0, 0)
			OptionText.BackgroundTransparency = 1
			OptionText.FontFace = SFProMediumFont
			OptionText.TextSize = 12
			OptionText.TextColor3 = (opt == selectedOption) and Themes[_G.SmoothHubConfig.CurrentTheme].Accent or Color3.fromRGB(200, 215, 220)
			OptionText.Text = opt
			OptionText.TextXAlignment = Enum.TextXAlignment.Left
			OptionText.TextYAlignment = Enum.TextYAlignment.Center
			OptionText.ZIndex = 502
			OptionText.Parent = OptionBtn

			OptionBtn.MouseEnter:Connect(function()
				TweenService:Create(OptionText, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, 32, 0, 0),
					TextTransparency = 0
				}):Play()
				TweenService:Create(CheckIcon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, 12, 0.5, -6)
				}):Play()
			end)

			OptionBtn.MouseLeave:Connect(function()
				TweenService:Create(OptionText, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, 26, 0, 0)
				}):Play()
				TweenService:Create(CheckIcon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, 8, 0.5, -6)
				}):Play()
			end)

			table.insert(optionButtons, {Btn = OptionBtn, Text = opt, TxtLabel = OptionText, Check = CheckIcon})

			OptionBtn.MouseButton1Click:Connect(function()
				selectedOption = opt
				DropdownText.Text = opt
				_G.SmoothHubConfig[dropdownName] = opt
				
				if activeTween then activeTween:Cancel() end
				local closeTweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				activeTween = TweenService:Create(DropdownListFrame, closeTweenInfo, {
					Size = UDim2.new(0, DropdownButton.AbsoluteSize.X, 0, 0),
					BackgroundTransparency = 1
				})
				activeTween:Play()
				
				task.delay(0.15, function()
					if DropdownListFrame.Size.Y.Offset == 0 then
						DropdownListFrame.Visible = false
					end
				end)
				
				for _, item in ipairs(optionButtons) do
					local isSelected = (item.Text == opt)
					item.Check.Visible = isSelected
					item.TxtLabel.TextColor3 = isSelected and Themes[_G.SmoothHubConfig.CurrentTheme].Accent or Color3.fromRGB(200, 215, 220)
				end

				task.spawn(function()
					callback(opt)
				end)
			end)
		end

		local isOpenDropdown = false
		
		DropdownButton.MouseButton1Click:Connect(function()
			isOpenDropdown = not isOpenDropdown
			
			local absPos = DropdownButton.AbsolutePosition
			local absSize = DropdownButton.AbsoluteSize
			local targetHeight = math.min(#optionsList * 30, 160)
			
			if activeTween then activeTween:Cancel() end
			local animInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			
			if isOpenDropdown then
				DropdownListFrame.Position = UDim2.new(0, absPos.X, 0, absPos.Y + absSize.Y + 4)
				DropdownListFrame.Visible = true
				
				activeTween = TweenService:Create(DropdownListFrame, animInfo, {
					Size = UDim2.new(0, absSize.X, 0, targetHeight),
					BackgroundTransparency = 0.15
				})
				activeTween:Play()
			else
				activeTween = TweenService:Create(DropdownListFrame, animInfo, {
					Size = UDim2.new(0, absSize.X, 0, 0),
					BackgroundTransparency = 1
				})
				activeTween:Play()
				
				task.delay(0.18, function()
					if DropdownListFrame.Size.Y.Offset == 0 then
						DropdownListFrame.Visible = false
					end
				end)
			end
		end)

		UserInputService.InputBegan:Connect(function(input)
			if isOpenDropdown and input.UserInputType == Enum.UserInputType.MouseButton1 then
				local mousePos = input.Position
				local btnPos = DropdownButton.AbsolutePosition
				local btnSize = DropdownButton.AbsoluteSize
				local listPos = DropdownListFrame.AbsolutePosition
				local listSize = DropdownListFrame.AbsoluteSize

				local inBtn = mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X and mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y
				local inList = mousePos.X >= listPos.X and mousePos.X <= listPos.X + listSize.X and mousePos.Y >= listPos.Y and mousePos.Y <= listPos.Y + listSize.Y

				if not inBtn and not inList then
					isOpenDropdown = false
					if activeTween then activeTween:Cancel() end
					local closeAnim = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
					activeTween = TweenService:Create(DropdownListFrame, closeAnim, {
						Size = UDim2.new(0, btnSize.X, 0, 0),
						BackgroundTransparency = 1
					})
					activeTween:Play()
					
					task.delay(0.15, function()
						if DropdownListFrame.Size.Y.Offset == 0 then
							DropdownListFrame.Visible = false
						end
					end)
				end
			end
		end)
	end

	function PageObj:CreateMultiSelectDropdown(dropdownName, dropdownDesc, optionsList, defaultSelected, callback)
		local callback = callback or function() end
		
		local selectedOptions = {}
		if type(_G.SmoothHubConfig[dropdownName]) == "table" then
			for _, opt in ipairs(optionsList) do
				selectedOptions[opt] = _G.SmoothHubConfig[dropdownName][opt] or false
			end
		else
			for _, opt in ipairs(optionsList) do
				selectedOptions[opt] = false
			end
			if type(defaultSelected) == "table" then
				for _, opt in ipairs(defaultSelected) do
					selectedOptions[opt] = true
				end
			end
		end
		_G.SmoothHubConfig[dropdownName] = selectedOptions

		local targetContainer = GetLatestContainer()
		local widgetIndex = #targetContainer:GetChildren() - 1

		local WidgetFrame = Instance.new("Frame")
		WidgetFrame.Name = dropdownName .. "_Widget"
		WidgetFrame.Size = UDim2.new(1, 0, 0, 64)
		WidgetFrame.BackgroundTransparency = 1
		WidgetFrame.BorderSizePixel = 0
		WidgetFrame.LayoutOrder = widgetIndex
		WidgetFrame.Parent = targetContainer

		if widgetIndex > 1 then
			local itemDivider = Instance.new("Frame")
			itemDivider.Name = "ItemDivider"
			itemDivider.Size = UDim2.new(1, -28, 0, 1)
			itemDivider.Position = UDim2.new(0, 14, 0, 0)
			itemDivider.BackgroundColor3 = Color3.fromRGB(35, 52, 56)
			itemDivider.BorderSizePixel = 0
			itemDivider.Parent = WidgetFrame
		end

		local WidgetTitle = Instance.new("TextLabel")
		WidgetTitle.Size = UDim2.new(1, -160, 0, 24)
		WidgetTitle.Position = UDim2.new(0, 14, 0, 11)
		WidgetTitle.BackgroundTransparency = 1
		WidgetTitle.FontFace = SFProMediumFont
		WidgetTitle.TextSize = 13
		WidgetTitle.TextColor3 = Color3.fromRGB(240, 240, 240)
		WidgetTitle.TextXAlignment = Enum.TextXAlignment.Left
		WidgetTitle.TextYAlignment = Enum.TextYAlignment.Center
		WidgetTitle.Text = dropdownName
		WidgetTitle.Parent = WidgetFrame

		local WidgetDesc = Instance.new("TextLabel")
		WidgetDesc.Size = UDim2.new(1, -160, 0, 18)
		WidgetDesc.Position = UDim2.new(0, 14, 0, 35)
		WidgetDesc.BackgroundTransparency = 1
		WidgetDesc.FontFace = SFProMediumFont
		WidgetDesc.TextSize = 11
		WidgetDesc.TextColor3 = Color3.fromRGB(140, 155, 160)
		WidgetDesc.TextXAlignment = Enum.TextXAlignment.Left
		WidgetDesc.TextYAlignment = Enum.TextYAlignment.Center
		WidgetDesc.Text = dropdownDesc
		WidgetDesc.Parent = WidgetFrame

		local DropdownButton = Instance.new("TextButton")
		DropdownButton.Name = "DropdownButton"
		DropdownButton.Size = UDim2.new(0, 140, 0, 32)
		DropdownButton.Position = UDim2.new(1, -150, 0.5, -16)
		DropdownButton.BackgroundTransparency = 1
		DropdownButton.BorderSizePixel = 0
		DropdownButton.AutoButtonColor = false
		DropdownButton.Text = ""
		DropdownButton.Parent = WidgetFrame

		local function getDisplayText()
			local t = {}
			for k, v in pairs(selectedOptions) do
				if v then table.insert(t, k) end
			end
			if #t == 0 then return "None"
			elseif #t == #optionsList then return "All"
			else return table.concat(t, ", ") end
		end

		local DropdownText = Instance.new("TextLabel")
		DropdownText.Name = "DropdownText"
		DropdownText.Size = UDim2.new(1, -24, 1, 0)
		DropdownText.Position = UDim2.new(0, 0, 0, 0)
		DropdownText.BackgroundTransparency = 1
		DropdownText.FontFace = SFProMediumFont
		DropdownText.TextSize = 12
		DropdownText.TextColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].Accent
		DropdownText.TextXAlignment = Enum.TextXAlignment.Right
		DropdownText.TextYAlignment = Enum.TextYAlignment.Center
		DropdownText.Text = getDisplayText()
		DropdownText.Parent = DropdownButton
		table.insert(allDropdownTexts, DropdownText)

		local DropdownArrow = Instance.new("ImageLabel")
		DropdownArrow.Name = "DropdownArrow"
		DropdownArrow.Size = UDim2.new(0, 14, 0, 14)
		DropdownArrow.Position = UDim2.new(1, -16, 0.5, -7)
		DropdownArrow.BackgroundTransparency = 1
		DropdownArrow.Image = "rbxassetid://77844815691418"
		DropdownArrow.ImageColor3 = Themes[_G.SmoothHubConfig.CurrentTheme].Accent
		DropdownArrow.Parent = DropdownButton

		local DropdownListFrame = Instance.new("ScrollingFrame")
		DropdownListFrame.Name = "DropdownListFrame"
		DropdownListFrame.Size = UDim2.new(0, 220, 0, 0)
		DropdownListFrame.Position = UDim2.new(1, -150, 1, -10)
		DropdownListFrame.BackgroundColor3 = Color3.fromRGB(22, 35, 38)
		DropdownListFrame.BackgroundTransparency = 1
		DropdownListFrame.BorderSizePixel = 0
		DropdownListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
		DropdownListFrame.ScrollBarThickness = 5
		DropdownListFrame.ScrollingEnabled = true
		DropdownListFrame.ElasticBehavior = Enum.ElasticBehavior.Always
		DropdownListFrame.Visible = false
		DropdownListFrame.ZIndex = 500
		DropdownListFrame.Parent = ScreenGui

		local ListCorner = Instance.new("UICorner")
		ListCorner.CornerRadius = UDim.new(0, 6)
		ListCorner.Parent = DropdownListFrame

		local ListLayout = Instance.new("UIListLayout")
		ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		ListLayout.Parent = DropdownListFrame

		ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			DropdownListFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
		end)

		local optionItems = {}
		local activeTween = nil
		local isOpenDropdown = false

		for _, opt in ipairs(optionsList) do
			local OptionBtn = Instance.new("TextButton")
			OptionBtn.Name = "Option_" .. opt
			OptionBtn.Size = UDim2.new(1, 0, 0, 30)
			OptionBtn.BackgroundTransparency = 1
			OptionBtn.BorderSizePixel = 0
			OptionBtn.AutoButtonColor = false
			OptionBtn.Text = ""
			OptionBtn.ZIndex = 501
			OptionBtn.Parent = DropdownListFrame

			local CheckIcon = Instance.new("ImageLabel")
			CheckIcon.Name = "CheckIcon"
			CheckIcon.Size = UDim2.new(0, 12, 0, 12)
			CheckIcon.Position = UDim2.new(0, 8, 0.5, -6)
			CheckIcon.BackgroundTransparency = 1
			CheckIcon.Image = "rbxassetid://115627370761282"
			CheckIcon.ImageColor3 = Color3.fromRGB(50, 225, 130)
			CheckIcon.Visible = selectedOptions[opt]
			CheckIcon.ZIndex = 502
			CheckIcon.Parent = OptionBtn

			local OptionText = Instance.new("TextLabel")
			OptionText.Name = "OptionText"
			OptionText.Size = UDim2.new(1, -26, 1, 0)
			OptionText.Position = UDim2.new(0, 26, 0, 0)
			OptionText.BackgroundTransparency = 1
			OptionText.FontFace = SFProMediumFont
            OptionText.TextSize = 12
			OptionText.TextColor3 = selectedOptions[opt] and Themes[_G.SmoothHubConfig.CurrentTheme].Accent or Color3.fromRGB(200, 215, 220)
			OptionText.Text = opt
			OptionText.TextXAlignment = Enum.TextXAlignment.Left
			OptionText.TextYAlignment = Enum.TextYAlignment.Center
			OptionText.ZIndex = 502
			OptionText.Parent = OptionBtn

			OptionBtn.MouseEnter:Connect(function()
				TweenService:Create(OptionText, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, 32, 0, 0),
					TextTransparency = 0
				}):Play()
				TweenService:Create(CheckIcon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, 12, 0.5, -6)
				}):Play()
			end)

			OptionBtn.MouseLeave:Connect(function()
				TweenService:Create(OptionText, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, 26, 0, 0)
				}):Play()
				TweenService:Create(CheckIcon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(0, 8, 0.5, -6)
				}):Play()
			end)

			table.insert(optionItems, {Btn = OptionBtn, Text = opt, TxtLabel = OptionText, Check = CheckIcon})

			OptionBtn.MouseButton1Click:Connect(function()
				selectedOptions[opt] = not selectedOptions[opt]
				CheckIcon.Visible = selectedOptions[opt]
				OptionText.TextColor3 = selectedOptions[opt] and Themes[_G.SmoothHubConfig.CurrentTheme].Accent or Color3.fromRGB(200, 215, 220)
				
				DropdownText.Text = getDisplayText()
				_G.SmoothHubConfig[dropdownName] = selectedOptions

				task.spawn(function()
					callback(selectedOptions)
				end)
			end)
		end

		DropdownButton.MouseButton1Click:Connect(function()
			isOpenDropdown = not isOpenDropdown
			local absPos = DropdownButton.AbsolutePosition
			local absSize = DropdownButton.AbsoluteSize
			local targetWidth = 220
			local targetHeight = math.min(#optionsList * 30, 180)
			
			if activeTween then activeTween:Cancel() end
			local animInfo = TweenInfo.new(0.18, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
			
			if isOpenDropdown then
				local viewportSize = Camera.ViewportSize
				local posY = absPos.Y + absSize.Y + 4
				if posY + targetHeight > viewportSize.Y - 20 then
					posY = absPos.Y - targetHeight - 4
				end
				
				local posX = absPos.X + absSize.X - targetWidth
				
				DropdownListFrame.Position = UDim2.new(0, posX, 0, posY)
				DropdownListFrame.Visible = true
				activeTween = TweenService:Create(DropdownListFrame, animInfo, {
					Size = UDim2.new(0, targetWidth, 0, targetHeight),
					BackgroundTransparency = 0.15
				})
				activeTween:Play()
			else
				activeTween = TweenService:Create(DropdownListFrame, animInfo, {
					Size = UDim2.new(0, targetWidth, 0, 0),
					BackgroundTransparency = 1
				})
				activeTween:Play()
				task.delay(0.18, function()
					if DropdownListFrame.Size.Y.Offset == 0 then
						DropdownListFrame.Visible = false
					end
				end)
			end
		end)

		UserInputService.InputBegan:Connect(function(input)
			if isOpenDropdown and input.UserInputType == Enum.UserInputType.MouseButton1 then
				local mousePos = input.Position
				local btnPos = DropdownButton.AbsolutePosition
				local btnSize = DropdownButton.AbsoluteSize
				local listPos = DropdownListFrame.AbsolutePosition
				local listSize = DropdownListFrame.AbsoluteSize

				local inBtn = mousePos.X >= btnPos.X and mousePos.X <= btnPos.X + btnSize.X and mousePos.Y >= btnPos.Y and mousePos.Y <= btnPos.Y + btnSize.Y
				local inList = mousePos.X >= listPos.X and mousePos.X <= listPos.X + listSize.X and mousePos.Y >= listPos.Y and mousePos.Y <= listPos.Y + listSize.Y

				if not inBtn and not inList then
					isOpenDropdown = false
					if activeTween then activeTween:Cancel() end
					local closeAnim = TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
					activeTween = TweenService:Create(DropdownListFrame, closeAnim, {
						Size = UDim2.new(0, 220, 0, 0),
						BackgroundTransparency = 1
					})
					activeTween:Play()
					
					task.delay(0.15, function()
						if DropdownListFrame.Size.Y.Offset == 0 then
							DropdownListFrame.Visible = false
						end
					end)
				end
			end
		end)
	end
	
	return PageObj
end

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local searchText = string.lower(SearchBox.Text)
	for _, widget in ipairs(activePageWidgets) do
		if widget and widget.Parent then
			local titleLabel = widget:FindFirstChildOfClass("TextLabel")
			if titleLabel then
				local titleText = string.lower(titleLabel.Text)
				if searchText == "" or string.find(titleText, searchText) then
					widget.Visible = true
				else
					widget.Visible = false
				end
			end
		end
	end
end)

local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function update(input)
	local delta = input.Position - dragStart
	MainWindow.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainWindow.InputBegan:Connect(function(input)
	if not isMaximized and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		dragging = true
		dragStart = input.Position
		startPos = MainWindow.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

MainWindow.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

local resizingTL = false
local resizeStartTL = nil
local startSizeTL = nil
local startPosTL = nil

ResizeButtonTL.InputBegan:Connect(function(input)
	if not isMaximized and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		resizingTL = true
		resizeStartTL = input.Position
		startSizeTL = MainWindow.AbsoluteSize
		startPosTL = MainWindow.AbsolutePosition
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				resizingTL = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if resizingTL and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - resizeStartTL
		local newWidth = math.clamp(startSizeTL.X - delta.X, 450, 1920)   
		local newHeight = math.clamp(startSizeTL.Y - delta.Y, 300, 1080) 
		
		local newPosX = startPosTL.X + (startSizeTL.X - newWidth)
		local newPosY = startPosTL.Y + (startSizeTL.Y - newHeight)
		
		MainWindow.Size = UDim2.new(0, newWidth, 0, newHeight)
		MainWindow.Position = UDim2.new(0, newPosX, 0, newPosY)
	end
end)

local resizingBR = false
local resizeStartBR = nil
local startSizeBR = nil

ResizeButtonBR.InputBegan:Connect(function(input)
	if not isMaximized and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
		resizingBR = true
		resizeStartBR = input.Position
		startSizeBR = MainWindow.AbsoluteSize
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				resizingBR = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if resizingBR and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - resizeStartBR
		local newWidth = math.clamp(startSizeBR.X + delta.X, 450, 1920)   
		local newHeight = math.clamp(startSizeBR.Y + delta.Y, 300, 1080) 
		
		MainWindow.Size = UDim2.new(0, newWidth, 0, newHeight)
	end
end)

local isOpened = true
local isTweening = false
local savedSize = MainWindow.Size
local savedPosition = MainWindow.Position

local function ToggleUIWindow()
    if isTweening then return end
    isTweening = true
    
    if isOpened then
        savedSize = MainWindow.Size
        savedPosition = MainWindow.Position
        isOpened = false
        
        local tweenInfo = TweenInfo.new(0.08, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        local tween = TweenService:Create(MainWindow, tweenInfo, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(savedPosition.X.Scale, savedPosition.X.Offset + (savedSize.X.Offset / 2), savedPosition.Y.Scale, savedPosition.Y.Offset + (savedSize.Y.Offset / 2)),
            BackgroundTransparency = 1
        })
        tween:Play()
        tween.Completed:Wait()
        MainWindow.Visible = false
    else
        MainWindow.Visible = true
        isOpened = true
        
        local tweenInfo = TweenInfo.new(0.10, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainWindow, tweenInfo, {
            Size = savedSize,
            Position = savedPosition,
            BackgroundTransparency = 0
        })
        tween:Play()
        tween.Completed:Wait()
    end
    isTweening = false
end

SideTogglePill.MouseButton1Click:Connect(ToggleUIWindow)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == _G.SmoothHubConfig.MinimizeKey then
			ToggleUIWindow()
		end
	end
end)

SmoothHub:CreateCategory("IN GAME", 1)
local MainFarmPage = SmoothHub:CreatePage("rbxassetid://95299401214721", "Main", 2, "Main | Kanom Tokyo", true)
local MultiFarmPage = SmoothHub:CreatePage("rbxassetid://116026669119316", "Monster", 3, "Multi Farm | Kanom Tokyo", false)
local BossPage = SmoothHub:CreatePage("rbxassetid://93134866924688", "Boss", 4, "Boss Farm | Kanom Tokyo", false)

SmoothHub:CreateCategory("SETTINGS", 10)
local AppearancePage = SmoothHub:CreatePage("rbxassetid://111557168477930", "Window | Ui", 11, "Window |Ui | Kanom Tokyo", false)
local PlayerPage = SmoothHub:CreatePage("rbxassetid://6034818372", "Player", 12, "Player | Kanom Tokyo", false)
local AdvancedPage = SmoothHub:CreatePage("rbxassetid://114046757018442", "Advanced System", 13, "Advanced | Kanom Tokyo", false)

-- 🎁 ระบบ Redeem Code
MainFarmPage:CreateSection("🎁", "Redeem Code", "Redeem active promotional codes for rewards.")
MainFarmPage:CreateButton("Redeem All Codes", "Automatically redeem all available codes in the game.", function()
    pcall(function()
        local Event = nil
        pcall(function()
            Event = ReplicatedStorage:FindFirstChild("Modules") 
                and ReplicatedStorage.Modules:FindFirstChild("Network") 
                and ReplicatedStorage.Modules.Network:FindFirstChild("ByteNetMax") 
                and ReplicatedStorage.Modules.Network.ByteNetMax:FindFirstChild("system") 
                and ReplicatedStorage.Modules.Network.ByteNetMax.system:FindFirstChild("ByteNetQuery")
        end)
        
        if not Event then
            for _, v in ipairs(ReplicatedStorage:GetDescendants()) do
                if (v:IsA("RemoteEvent") or v:IsA("RemoteFunction")) and (v.Name:lower():find("code") or v.Name:lower():find("system") or v.Name:lower():find("query")) then
                    Event = v
                    break
                end
            end
        end
            
        if Event then
            local codes = {
                "RELEASE", "LIKE1000", "LIKE2000","RestartAgainSoon...", "Soon...", "JackkeyxTei", "UPDATE1.5", "VALENTINE", "EtoV3!", 
                "5KFAVORITES", "10KLIKES", "2MVISITS", "UPDATE1", "SEWERDOG", "Sorry4Restarts", "QOLUPDATES",
                "15KLikes!", "10KFavorites!", "Ginkui_Update!", "S0rry4D314y...", "15KLikes", "10KFavorites", 
                "TAKIZAWA!", "Update2.5", "FORNEWPLAYER!", "RAIDHASBEENDEFEATED", "UPDATENOW!",
                "FREEGACHA!?", "GACHAAGAIN!!", "LETRAIDTOGETHER!", "PLAYERSISBACK!", "LETFARMING!!", 
                "TRYHARDER!!!", "Tatara", "Updatae2.5", "SorryForLongUpdate", "Release", "NARUKAMI",
                "UPDATE2", "Eugeo", "SorryForDelay", "UPDATE0.5", "WANDEK2026", "1MVISITS", "SorryForShutdown", 
                "THANKFOR10KGROUPMEMBER", "SORRYFORBUG", "EugeoZa", "THANKFOR10KVISITS", "Release!", "COUNTDOWN", 
                "SORRYFORBUGT_T", "THANKFOR10KMEMBER", "MINIUPDATE", "THANKSFOR1KONLINE", "SRYFORDELAY"
            }
            for _, codeText in ipairs(codes) do
                pcall(function()
                    if Event:IsA("RemoteEvent") then
                        Event:FireServer(codeText)
                    elseif Event:IsA("RemoteFunction") then
                        Event:InvokeServer(codeText)
                    else
                        local bytes = {}
                        for i = 1, #codeText do
                            table.insert(bytes, string.byte(codeText, i))
                        end
                        local buf = buffer.create(#bytes)
                        for idx = 1, #bytes do
                            buffer.writeu8(buf, idx - 1, bytes[idx])
                        end
                        Event:InvokeServer(buf, nil, 1)
                    end
                end)
                
                ShowRedeemNotification(codeText, "Redeemed Code Successfully")
                
                task.wait(0.25)
            end
            print("Successfully attempted to redeem all codes!")
        else
            warn("Redeem Remote Event not found!")
            ShowRedeemNotification("Error", "Event Not Found!")
        end
    end)
end)

MainFarmPage:CreateSection("❄", "Auto Farm Level", "Seamlessly grinds and gains experience points without stopping.")
MainFarmPage:CreateDropdown("Position", "Choose farming direction", {"Upper", "Down"}, "Upper", function(selectedOption)
    _G.SmoothHubConfig.FarmPosition = selectedOption
    print("Selected Position:", selectedOption)
end)
MainFarmPage:CreateToggle("Auto Farm Level | Ghoul  👹", "Automatically completes quests and defeats monsters to raise your level. (Recommended for Ghoul)", function(state)
	_G.SmoothHubConfig.AutoFarmLevelGhoul = state
end)
_G.GhoulStatusObj = MainFarmPage:CreateStatus("Ghoul Status", "Idle", "Shows current operational state for Ghoul farm.")

MainFarmPage:CreateToggle("Auto Farm Level | CCG  👔", "Automatically completes quests and defeats monsters to raise your level. (Recommended for CCG)", function(state)
	_G.SmoothHubConfig.AutoFarmLevelCCG = state
end)
_G.CCGStatusObj = MainFarmPage:CreateStatus("CCG Status", "Idle", "Shows current operational state for CCG farm.")

MainFarmPage:CreateToggle("Fast Attack ", "An extremely fast attack system that hits much quicker than normal.", function(state)
	_G.SmoothHubConfig.FastAttack = state
end)

MainFarmPage:CreateSection("📈", "Auto Upgrade Stats", "Automatically invests your available stat points into your chosen category.")

MainFarmPage:CreateMultiSelectDropdown("Stat Selection", "Choose which stats to upgrade automatically", {"Damage", "Durability", "Stamina", "Speed"}, {}, function(selectedTable)
    _G.SmoothHubConfig.StatSelection = selectedTable
end)

MainFarmPage:CreateTextbox("Customs Amount", "Set points amount per loop", 1, function(val) _G.SmoothHubConfig.CustomsAmount = val end)
MainFarmPage:CreateToggle("Auto Upgrade", "Automatically invests your stat points securely based on your selection and limits", function(state)
    _G.SmoothHubConfig.AutoUpgradeStats = state
end)

MainFarmPage:CreateTextbox("Damage", "Set max limit level for Damage (Max: 5000)", 0, function(val) _G.SmoothHubConfig.DamageLimit = val end)
MainFarmPage:CreateTextbox("Durability", "Set max limit level for Durability (Max: 5000)", 0, function(val) _G.SmoothHubConfig.DurabilityLimit = val end)
MainFarmPage:CreateTextbox("Stamina", "Set max limit level for Stamina (Max: 150)", 0, function(val) _G.SmoothHubConfig.StaminaLimit = val end)
MainFarmPage:CreateTextbox("Speed", "Set max limit level for Speed (Max: 150)", 0, function(val) _G.SmoothHubConfig.SpeedLimit = val end)

local StatStatusObj = MainFarmPage:CreateStatus("Stats Status", "Lvl: 0 | Dmg: 0 | Dur: 0 | Sta: 0 | Spd: 0", "Real-time character stats & level tracking.")

task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            local levelVal = 0
            local dataFolder = LocalPlayer:FindFirstChild("Data")
            if dataFolder then
                local levelObj = dataFolder:FindFirstChild("Level")
                if levelObj then levelVal = levelObj.Value end
            end

            local statFolder = LocalPlayer:FindFirstChild("Stat")
            local dmg, dur, sta, spd = 0, 0, 0, 0
            
            if statFolder then
                local dObj = statFolder:FindFirstChild("Damage")
                if dObj then dmg = dObj.Value end
                
                local duObj = statFolder:FindFirstChild("Durability")
                if duObj then dur = duObj.Value end
                
                local sObj = statFolder:FindFirstChild("Stamina")
                if sObj then sta = sObj.Value end
                
                local spObj = statFolder:FindFirstChild("ความเร็ว") or statFolder:FindFirstChild("Speed")
                if spObj then spd = spObj.Value end
            elseif LocalPlayer:FindFirstChild("PlayerStats") then
                local ps = LocalPlayer.PlayerStats
                if ps:FindFirstChild("Damage") then dmg = ps.Damage.Value end
                if ps:FindFirstChild("Durability") then dur = ps.Durability.Value end
                if ps:FindFirstChild("Stamina") then sta = ps.Stamina.Value end
                if ps:FindFirstChild("Speed") then spd = ps.Speed.Value end
            end
            
            if StatStatusObj and StatStatusObj.SetText then
                StatStatusObj.SetText(string.format("Lvl: %d | Dmg: %d | Dur: %d | Sta: %d | Spd: %d", levelVal, dmg, dur, sta, spd))
            end
        end)
    end
end)


local MultiFarmSection = MultiFarmPage:CreateSection("🩸", "Farm Monster", "Configure multiple farming options simultaneously.")

MultiFarmPage:CreateMultiSelectDropdown("Monster Selection","Choose which monsters you want to farm automatically",
  {
      "Human [Lv.1-50]",
      "Athlete [Lv.1-50]",
      "Rank 2 Investigator [Lv.50-Lv.150]",
      "Bulk Ghoul [Lv.150-250]",
      "Rank 1 Investigator [Lv.250-350]",
      "Serpent Ghoul [Lv.350-400]",
      "Rin Ghoul [Lv.400-450]",
      "First class Investigator [Lv.450-500]",
      "Aogiri [Lv.500-550]",
      "Akira [Lv.550-600]",
      "Enforcer [Lv.600-Lv.700]",
      "Phantom [Lv.700-Lv.800]",
      "Fighter Ghoul [Lv.800-900]",
      "Sparkling Wing Ghoul [Lv.900-1000]",
      "Factor [Lv.1000-1100]",
      "Faulty Tatara Ghoul [Lv.1100-1200]"
  }, {}, function(selectedTable)
    _G.SmoothHubConfig.MonsterSelection = selectedTable
end)
MultiFarmPage:CreateToggle("Enable Farm Monster", "Turn on or off automatic monster farming based on your selection.", function(state)
    _G.SmoothHubConfig.EnableFarmMonster = state
end)
_G.MonsterStatusObj = MultiFarmPage:CreateStatus("Monster Status", "Idle", "Shows current operational state for Monster farm.")

MultiFarmPage:CreateDropdown("Position", "Choose farming direction", {"Upper", "Down"}, "Upper", function(selectedOption)
    _G.SmoothHubConfig.MonsterFarmPosition = selectedOption
    print("Selected Monster Position:", selectedOption)
end)
MultiFarmPage:CreateSection("🗡️", "Monster Drop Information", "List of all monsters and their dropped items.")

local monsterDropData = {
    {
        Name = "Human [Lv.1-50]", 
        Desc = "Starter monsters suited for levels 1-50 players. ", 
        Drops = {"rbxassetid://120046812439061","rbxassetid://120046812439061","rbxassetid://120046812439061",}
    },
    {
        Name = "Athlete [Lv.1-50]", 
        Desc = "Frenzied Athlete [Lv.1-50]", 
        Drops = {"rbxassetid://120046812439061","rbxassetid://120046812439061","rbxassetid://120046812439061",}
    },
    {
        Name = "Rank 2 Investigator [Lv.50-Lv.150]", 
        Desc = "Rank 2 Investigator [Lv.X] – Moderate defense and health.", 
        Drops = {"rbxassetid://92283511719944"}
    },
    {
        Name = "Bulk Ghoul [Lv.150-250]", 
        Desc = "Giant Ghoul – High damage output, ideal for mid-game leveling.", 
        Drops = {"rbxassetid://104254551964189","rbxassetid://74190062784992"}
    },
    {
        Name = "Rank 1 Investigator [Lv.250-350]", 
        Desc = "Rank 1 Investigator – Enhanced combat capabilities.", 
        Drops = {"rbxassetid://92283511719944","rbxassetid://96209699024942",}
    },
    {
        Name = "Serpent Ghoul [Lv.350-400]", 
        Desc = "Serpent Ghoul – Features unique item drop rates.", 
        Drops = {"rbxassetid://104254551964189","rbxassetid://114742713136372","rbxassetid://133392082813980",}
    },
    {
        Name = "Rin Ghoul [Lv.400-450]", 
        Desc = "Rinkaku Ghoul – High agility and continuous attacks.", 
        Drops = {"rbxassetid://104254551964189","rbxassetid://72380617677891","rbxassetid://133392082813980",}
    },
    {
        Name = "First class Investigator [Lv.450-500]", 
        Desc = "First-Class Investigator – Highly skilled and extremely dangerous.", 
        Drops = {"rbxassetid://92283511719944","rbxassetid://96209699024942",}
    },
    {
        Name = "Aogiri [Lv.500-550]", 
        Desc = "Aogiri Tree Member – Elite Ghoul Soldier. ", 
        Drops = {"rbxassetid://104254551964189","rbxassetid://107493323425484",}
    },
    {
        Name = "Akira [Lv.550-600]", 
        Desc = "Special Monster: Akira – Strikes with rapid and swift movements.", 
        Drops = {"rbxassetid://107493323425484",}
    },
    {
        Name = "Enforcer [Lv.600-Lv.700]", 
        Desc = "High-Level Area Enforcer ", 
        Drops = {"rbxassetid://92283511719944","rbxassetid://96209699024942",}
    },
    {
        Name = "Phantom [Lv.700-Lv.800]", 
        Desc = "Phantom: A mysterious entity featuring high-speed strikes.", 
        Drops = {"rbxassetid://92283511719944","rbxassetid://96209699024942",}
    },
    {
        Name = "Fighter Ghoul [Lv.800-900]", 
        Desc = "Brawler Ghoul – Melee combatant with heavy damage.", 
        Drops = {"rbxassetid://104254551964189","rbxassetid://107493323425484",}
    },
    {
        Name = "Sparkling Wing Ghoul [Lv.900-1000]", 
        Desc = "Shining Wing Ghoul – High-level near max cap, unleashes wide-area light bursts. ", 
        Drops = {"rbxassetid://104254551964189","rbxassetid://107493323425484",}
    },
    {
        Name = "Factor [Lv.1000-1100]", 
        Desc = "Factor – High-level endgame monster.", 
        Drops = {"rbxassetid://120046812439061","rbxassetid://120046812439061","rbxassetid://120046812439061",}
    },
    {
        Name = "Faulty Tatara Ghoul [Lv.1100-1200]", 
        Desc = "Flawed Tatara: The most formidable max-tier monster currently.", 
        Drops = {"rbxassetid://104254551964189",}
    }
}

for _, monster in ipairs(monsterDropData) do
    local container = MultiFarmPage:CreateSection("", "", "")
    
    local CardFrame = Instance.new("Frame")
    CardFrame.Name = monster.Name .. "_Card"
    CardFrame.Size = UDim2.new(1, 0, 0, 0)
    CardFrame.BackgroundTransparency = 1
    CardFrame.Parent = container

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -28, 0, 24)
    NameLabel.Position = UDim2.new(0, 14, 0, 8)
    NameLabel.BackgroundTransparency = 1
    NameLabel.FontFace = SFProBoldFont
    NameLabel.TextSize = 13
    NameLabel.TextColor3 = Color3.fromRGB(255, 165, 43)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Text = "👹 " .. monster.Name
    NameLabel.Parent = CardFrame

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -28, 0, 18)
    DescLabel.Position = UDim2.new(0, 14, 0, 32)
    DescLabel.BackgroundTransparency = 1
    DescLabel.FontFace = SFProMediumFont
    DescLabel.TextSize = 11
    DescLabel.TextColor3 = Color3.fromRGB(150, 165, 170)
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Text = monster.Desc or ""
    DescLabel.Parent = CardFrame

    local ImageContainer = Instance.new("Frame")
    ImageContainer.Name = "ImageContainer"
    ImageContainer.Size = UDim2.new(1, -28, 0, 0)
    ImageContainer.Position = UDim2.new(0, 14, 0, 56)
    ImageContainer.BackgroundTransparency = 1
    ImageContainer.Parent = CardFrame

    local ItemGrid = Instance.new("UIGridLayout")
    ItemGrid.CellSize = UDim2.new(0, 45, 0, 45)
    ItemGrid.CellPadding = UDim2.new(0, 8, 0, 8)
    ItemGrid.SortOrder = Enum.SortOrder.LayoutOrder
    ItemGrid.Parent = ImageContainer

    ItemGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ImageContainer.Size = UDim2.new(1, -28, 0, ItemGrid.AbsoluteContentSize.Y)
        CardFrame.Size = UDim2.new(1, 0, 0, ItemGrid.AbsoluteContentSize.Y + 66)
    end)

    for _, imgId in ipairs(monster.Drops) do
        local ItemBox = Instance.new("ImageLabel")
        ItemBox.Size = UDim2.new(0, 45, 0, 45)
        ItemBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ItemBox.Image = imgId
        ItemBox.Parent = ImageContainer

        local BoxCorner = Instance.new("UICorner")
        BoxCorner.CornerRadius = UDim.new(0, 6)
        BoxCorner.Parent = ItemBox

        local BoxStroke = Instance.new("UIStroke")
        BoxStroke.Color = Color3.fromRGB(60, 60, 60)
        BoxStroke.Thickness = 1
        BoxStroke.Parent = ItemBox
    end
end

-- 👑 เมนู Boss (สร้างส่วนควบคุมสำหรับบอส)
BossPage:CreateSection("👑", "Boss Normal", "Configure automatic boss farming and tracking options.")
BossPage:CreateMultiSelectDropdown("Boss Selection", "Choose which bosses to target automatically", {
    "Kaneki", "Jason", "Ihei Hairu",
}, {}, function(selectedTable)
    _G.SmoothHubConfig.BossSelection = selectedTable
end)

BossPage:CreateToggle("Enable Farm Boss", "Automatically teleport to and defeat selected bosses.", function(state)
    _G.SmoothHubConfig.EnableAutoBoss = state
end)

_G.BossStatusObj = BossPage:CreateStatus("Boss Status", "Idle", "Shows current operational state for Boss farm.")

-- 📍 เพิ่ม Dropdown Position ไว้ล่างสุดของหมวดหมู่ Boss Normal
BossPage:CreateDropdown("Position", "Choose farming direction", {"Upper", "Down"}, "Upper", function(selectedOption)
    _G.SmoothHubConfig.BossFarmPosition = selectedOption
    print("Selected Boss Farm Position:", selectedOption)
end)
-- ✨ เพิ่มสถานะแยกสำหรับบอสแต่ละตัว เพื่อเช็คว่าเกิดใน Workspace/AI/Player/Boss หรือยัง
BossPage:CreateSection("📍", "Boss Spawn Status", "Real-time tracker for Kaneki, Jason, and Ihei Hairu status.")
local KanekiStatusObj = BossPage:CreateStatus("Kaneki Status", "Checking...", "Checks if Kaneki has spawned.")
local JasonStatusObj = BossPage:CreateStatus("Jason Status", "Checking...", "Checks if Jason has spawned.")
local IheiStatusObj = BossPage:CreateStatus("Ihei Hairu Status", "Checking...", "Checks if Ihei Hairu has spawned.")

-- 🔍 ระบบลูปเช็คสถานะบอสจาก Workspace.AI/Player.Boss ตามโฟลเดอร์ที่คุณต้องการ
task.spawn(function()
    while true do
        task.wait(1)
        pcall(function()
            local bossFolder = workspace:FindFirstChild("AI/Player") and workspace["AI/Player"]:FindFirstChild("Boss")
            
            local kanekiSpawned = false
            local jasonSpawned = false
            local iheiSpawned = false
            
            if bossFolder then
                for _, obj in ipairs(bossFolder:GetChildren()) do
                    local nameLower = string.lower(obj.Name)
                    if string.find(nameLower, "kaneki") then
                        kanekiSpawned = true
                    elseif string.find(nameLower, "jason") then
                        jasonSpawned = true
                    elseif string.find(nameLower, "ihei") or string.find(nameLower, "hairu") then
                        iheiSpawned = true
                    end
                end
            end
            
            if KanekiStatusObj and KanekiStatusObj.SetText then
                if kanekiSpawned then
                    KanekiStatusObj.SetText("Spawned 🟢", Color3.fromRGB(40, 220, 100))
                else
                    KanekiStatusObj.SetText("Not Spawned 🔴", Color3.fromRGB(220, 60, 60))
                end
            end
            
            if JasonStatusObj and JasonStatusObj.SetText then
                if jasonSpawned then
                    JasonStatusObj.SetText("Spawned 🟢", Color3.fromRGB(40, 220, 100))
                else
                    JasonStatusObj.SetText("Not Spawned 🔴", Color3.fromRGB(220, 60, 60))
                end
            end
            
            if IheiStatusObj and IheiStatusObj.SetText then
                if iheiSpawned then
                    IheiStatusObj.SetText("Spawned 🟢", Color3.fromRGB(40, 220, 100))
                else
                    IheiStatusObj.SetText("Not Spawned 🔴", Color3.fromRGB(220, 60, 60))
                end
            end
        end)
    end
end)

BossPage:CreateSection("🗡️", "Boss Normal Drop Information", "List of major bosses and their special rewards.")

local bossDropData = {
    {
        Name = "Kaneki",
        Desc = "Aogiri Tree leader – High health and deadly special attacks.",
        Drops = {"rbxassetid://133413487108852", "rbxassetid://114742713136372","rbxassetid://72380617677891","rbxassetid://127783512312376"}
    },
    {
        Name = "Jason",
        Desc = "One-Eyed Owl – Extremely powerful boss with high mobility.",
        Drops = {"rbxassetid://114742713136372", "rbxassetid://72380617677891","rbxassetid://137471364600083","rbxassetid://127464277300963",}
    },
    {
        Name = "Ihei Hairu",
        Desc = "Jason – Brutal torturer wielding powerful kagune abilities.",
        Drops = {"rbxassetid://107493323425484", "rbxassetid://108935483904389"}
    }
}

for _, boss in ipairs(bossDropData) do
    local container = BossPage:CreateSection("", "", "")
    
    local CardFrame = Instance.new("Frame")
    CardFrame.Name = boss.Name .. "_Card"
    CardFrame.Size = UDim2.new(1, 0, 0, 0)
    CardFrame.BackgroundTransparency = 1
    CardFrame.Parent = container

    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -28, 0, 24)
    NameLabel.Position = UDim2.new(0, 14, 0, 8)
    NameLabel.BackgroundTransparency = 1
    NameLabel.FontFace = SFProBoldFont
    NameLabel.TextSize = 13
    NameLabel.TextColor3 = Color3.fromRGB(255, 65, 88)
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Text = "👑 " .. boss.Name
    NameLabel.Parent = CardFrame

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -28, 0, 18)
    DescLabel.Position = UDim2.new(0, 14, 0, 32)
    DescLabel.BackgroundTransparency = 1
    DescLabel.FontFace = SFProMediumFont
    DescLabel.TextSize = 11
    DescLabel.TextColor3 = Color3.fromRGB(150, 165, 170)
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Text = boss.Desc or ""
    DescLabel.Parent = CardFrame

    local ImageContainer = Instance.new("Frame")
    ImageContainer.Name = "ImageContainer"
    ImageContainer.Size = UDim2.new(1, -28, 0, 0)
    ImageContainer.Position = UDim2.new(0, 14, 0, 56)
    ImageContainer.BackgroundTransparency = 1
    ImageContainer.Parent = CardFrame

    local ItemGrid = Instance.new("UIGridLayout")
    ItemGrid.CellSize = UDim2.new(0, 45, 0, 45)
    ItemGrid.CellPadding = UDim2.new(0, 8, 0, 8)
    ItemGrid.SortOrder = Enum.SortOrder.LayoutOrder
    ItemGrid.Parent = ImageContainer

    ItemGrid:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        ImageContainer.Size = UDim2.new(1, -28, 0, ItemGrid.AbsoluteContentSize.Y)
        CardFrame.Size = UDim2.new(1, 0, 0, ItemGrid.AbsoluteContentSize.Y + 66)
    end)

    for _, imgId in ipairs(boss.Drops) do
        local ItemBox = Instance.new("ImageLabel")
        ItemBox.Size = UDim2.new(0, 45, 0, 45)
        ItemBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ItemBox.Image = imgId
        ItemBox.Parent = ImageContainer

        local BoxCorner = Instance.new("UICorner")
        BoxCorner.CornerRadius = UDim.new(0, 6)
        BoxCorner.Parent = ItemBox

        local BoxStroke = Instance.new("UIStroke")
        BoxStroke.Color = Color3.fromRGB(60, 60, 60)
        BoxStroke.Thickness = 1
        BoxStroke.Parent = ItemBox
    end
end

AppearancePage:CreateSection("🎨", "Customs Color", "Customize the appearance and visual style of the interface.")
AppearancePage:CreateDropdown("Theme", "The whole palette, not just light or dark.", {
    "Amber", "Crimson", "Dark", "Dracula", "Emerald", "Forest", "Gold", "Graphite", "Light", 
    "Matrix", "Midnight", "Mocha", "Nocturne", "Nord", "Obsidian", "Rose", "Sakura", 
    "Solar", "Steel", "Sunset", "Tokyo", "Violet"
}, "Dark", function(selectedTheme)
    ApplyTheme(selectedTheme)
end)

AppearancePage:CreateSection("⌨", "Input", "The shortcut that hides and shows the window.")
AppearancePage:CreateHotkey("Minimize Hotkey", "Press to hide or show the window.", Enum.KeyCode.B, function(key)
	_G.SmoothHubConfig.MinimizeKey = key
end)

AppearancePage:CreateSection("🕶", "Privacy", "Hides other players' real names from the game's own UI.")
AppearancePage:CreateToggle("Streamer Mode", "Swaps real names for random fake ones in the party panel, over heads, and in Roblox's player list and chat.", function(state)
	_G.SmoothHubConfig.StreamerMode = state
end)



PlayerPage:CreateSection("🏃", "Movement", "Customize your character's speed, jump height, and mobility.")

PlayerPage:CreateToggle("Enable WalkSpeed", "Turn on or off custom walk speed modifier.", function(state)
	_G.SmoothHubConfig.EnableWalkSpeed = state
	if not state then
		pcall(function()
			LocalPlayer.Character.Humanoid.WalkSpeed = 16
		end)
	end
end)

PlayerPage:CreateSlider("WalkSpeed", "Adjust your character's movement speed.", 16, 1000, 16, function(value)
	_G.SmoothHubConfig.WalkSpeed = value
end)

PlayerPage:CreateToggle("Enable JumpPower", "Turn on or off custom jump power modifier.", function(state)
	_G.SmoothHubConfig.EnableJumpPower = state
	if not state then
		pcall(function()
			LocalPlayer.Character.Humanoid.JumpPower = 50
		end)
	end
end)

PlayerPage:CreateSlider("JumpPower", "Adjust your character's jump height power.", 50, 1000, 50, function(value)
	_G.SmoothHubConfig.JumpPower = value
end)

PlayerPage:CreateToggle("Fly", "Allows your character to fly around freely.", function(state)
	ToggleFly(state)
end)

PlayerPage:CreateSlider("FlySpeed", "Adjust your flight movement speed.", 10, 1000, 50, function(value)
	_G.SmoothHubConfig.FlySpeed = value
end)

PlayerPage:CreateToggle("Noclip", "Walk through walls and obstacles easily.", function(state)
	ToggleNoclip(state)
end)

PlayerPage:CreateSection("🌈", "(Character) RGB", "Customizes your character with an RGB glowing outline effect.")

PlayerPage:CreateToggle("Enable RGB", "Turns on or off the rainbow RGB glowing outline effect around your character.", function(state)
	ToggleRGB(state)
end)


AdvancedPage:CreateSection("⚙", "System Control", "Advanced settings and anti-afk configuration.")

AdvancedPage:CreateToggle("Anti-AFK System", "Prevent getting kicked after being AFK for 20 minutes.", function(state)
	_G.SmoothHubConfig.AntiAFK = state
end)

AdvancedPage:CreateToggle("Auto Rejoin", "Automatically reconnect to the server if disconnected or kicked.", function(state)
	_G.SmoothHubConfig.AutoRejoin = state
end)

AdvancedPage:CreateToggle("Anti Admin", "Automatically hops to a new server if an admin joins.", function(state)
	_G.SmoothHubConfig.AntiAdmin = state
end)


AdvancedPage:CreateSection("💤", "Sleep mode", "Cover screen to save power or rest display.")

AdvancedPage:CreateToggle("Black Screen", "Covers the screen with a translucent dark overlay.", function(state)
	_G.SmoothHubConfig.BlackScreen = state
	if state then
		_G.SmoothHubConfig.WhiteScreen = false
	end
	UpdateSleepMode()
end)

AdvancedPage:CreateToggle("White Screen", "Covers the screen with a translucent bright overlay.", function(state)
	_G.SmoothHubConfig.WhiteScreen = state
	if state then
		_G.SmoothHubConfig.BlackScreen = false
	end
	UpdateSleepMode()
end)

AdvancedPage:CreateSection("⚡", "Performance", "Frame rate limiting settings and performance boosters.")

AdvancedPage:CreateToggle("Fast Mode", "Lower graphics, remove shadows and particles to boost performance.", function(state)
	ToggleFastMode(state)
end)

AdvancedPage:CreateToggle("Enable FPS Lock", "Turn on or off the custom frame rate restriction.", function(state)
	_G.SmoothHubConfig.EnableFPSLock = state
	pcall(function()
		if setfpscap then
			if state then
				setfpscap(_G.SmoothHubConfig.FPSLock)
			else
				setfpscap(9999)
			end
		end
	end)
end)

AdvancedPage:CreateSlider("FPS Lock", "Limit your maximum frames per second to stabilize performance.", 15, 1000, 240, function(value)
	_G.SmoothHubConfig.FPSLock = value
	pcall(function()
		if setfpscap and _G.SmoothHubConfig.EnableFPSLock then
			setfpscap(value)
		end
	end)
end)

print("SmoothHub UI Loaded Successfully!")
end

local function PlayLoadingLogo(callback)
    local LoadGui = Instance.new("ScreenGui")
    LoadGui.Name = "SmoothHub_LoadGui"
    LoadGui.Parent = CoreGui
    LoadGui.ResetOnSpawn = false
    LoadGui.DisplayOrder = 10000000

    local LoadFrame = Instance.new("Frame")
    LoadFrame.Name = "LoadFrame"
    LoadFrame.Size = UDim2.new(0, 350, 0, 350) 
    LoadFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    LoadFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    LoadFrame.BackgroundTransparency = 1
    LoadFrame.Parent = LoadGui

    local LogoImage = Instance.new("ImageLabel")
    LogoImage.Name = "LogoImage"
    LogoImage.Size = UDim2.new(1, 0, 1, 0)
    LogoImage.AnchorPoint = Vector2.new(0.5, 0.5)
    LogoImage.Position = UDim2.new(0.5, 0, 0.5, 0)
    LogoImage.BackgroundTransparency = 1
    LogoImage.Image = "rbxassetid://119784799552033" 
    LogoImage.ImageTransparency = 1
    LogoImage.ScaleType = Enum.ScaleType.Fit 
    LogoImage.Parent = LoadFrame

    local tweenInfoIn = TweenInfo.new(2.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(LogoImage, tweenInfoIn, {ImageTransparency = 0}):Play()

    task.delay(5.6, function()
        local tweenInfoOut = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
        local fadeOut = TweenService:Create(LogoImage, tweenInfoOut, {ImageTransparency = 1})
        fadeOut:Play()

        fadeOut.Completed:Wait()
        LoadGui:Destroy()

        local MenuLoadGui = Instance.new("ScreenGui")
        MenuLoadGui.Name = "SmoothHub_MenuLoadGui"
        MenuLoadGui.Parent = CoreGui
        MenuLoadGui.ResetOnSpawn = false
        MenuLoadGui.DisplayOrder = 10000000

        local Box = Instance.new("Frame")
        Box.Size = UDim2.new(0, 320, 0, 110)
        Box.AnchorPoint = Vector2.new(0.5, 0.5)
        Box.Position = UDim2.new(0.5, 0, 0.5, 0)
        Box.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
        Box.BackgroundTransparency = 0.2
        Box.BorderSizePixel = 0
        Box.Parent = MenuLoadGui

        local BoxCorner = Instance.new("UICorner")
        BoxCorner.CornerRadius = UDim.new(0, 12)
        BoxCorner.Parent = Box

        local BoxStroke = Instance.new("UIStroke")
        BoxStroke.Color = Color3.fromRGB(10, 132, 255)
        BoxStroke.Transparency = 0.5
        BoxStroke.Thickness = 1.5
        BoxStroke.Parent = Box

        local MenuWindowControls = Instance.new("Frame")
        MenuWindowControls.Name = "WindowControls"
        MenuWindowControls.Size = UDim2.new(0, 80, 0, 20)
        MenuWindowControls.Position = UDim2.new(0, 12, 0, 10)
        MenuWindowControls.BackgroundTransparency = 1
        MenuWindowControls.Parent = Box

        local MenuControlsLayout = Instance.new("UIListLayout")
        MenuControlsLayout.FillDirection = Enum.FillDirection.Horizontal
        MenuControlsLayout.SortOrder = Enum.SortOrder.LayoutOrder
        MenuControlsLayout.Padding = UDim.new(0, 6)
        MenuControlsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        MenuControlsLayout.Parent = MenuWindowControls

        local macColors = {
            Color3.fromRGB(255, 95, 86),
            Color3.fromRGB(255, 189, 46),
            Color3.fromRGB(39, 201, 63)
        }

        for _, col in ipairs(macColors) do
            local dot = Instance.new("Frame")
            dot.Size = UDim2.new(0, 11, 0, 11)
            dot.BackgroundColor3 = col
            dot.BorderSizePixel = 0
            dot.Parent = MenuWindowControls

            local dotCorner = Instance.new("UICorner")
            dotCorner.CornerRadius = UDim.new(1, 0)
            dotCorner.Parent = dot
        end

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, 0, 0, 30)
        Title.Position = UDim2.new(0, 0, 0, 12)
        Title.BackgroundTransparency = 1
        Title.FontFace = SFProBoldFont
        Title.TextSize = 14
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.Text = "Loading..."
        Title.Parent = Box

        local StatusText = Instance.new("TextLabel")
        StatusText.Size = UDim2.new(1, 0, 0, 20)
        StatusText.Position = UDim2.new(0, 0, 0, 42)
        StatusText.BackgroundTransparency = 1
        StatusText.FontFace = SFProMediumFont
        StatusText.TextSize = 12
        StatusText.TextColor3 = Color3.fromRGB(150, 165, 170)
        StatusText.Text = "Initializing settings..."
        StatusText.Parent = Box

        local BarBg = Instance.new("Frame")
        BarBg.Size = UDim2.new(1, -40, 0, 8)
        BarBg.Position = UDim2.new(0, 20, 0, 75)
        BarBg.BackgroundColor3 = Color3.Spacer or Color3.fromRGB(35, 35, 35)
        BarBg.BorderSizePixel = 0
        BarBg.Parent = Box

        local BarBgCorner = Instance.new("UICorner")
        BarBgCorner.CornerRadius = UDim.new(1, 0)
        BarBgCorner.Parent = BarBg

        local BarFill = Instance.new("Frame")
        BarFill.Size = UDim2.new(0, 0, 1, 0)
        BarFill.BackgroundColor3 = Color3.fromRGB(10, 132, 255)
        BarFill.BorderSizePixel = 0
        BarFill.Parent = BarBg

        local BarFillCorner = Instance.new("UICorner")
        BarFillCorner.CornerRadius = UDim.new(1, 0)
        BarFillCorner.Parent = BarFill

        task.spawn(function()
            local tween1 = TweenService:Create(BarFill, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.35, 0, 1, 0)})
            tween1:Play()
            tween1.Completed:Wait()
            StatusText.Text = "Loading themes & variables..."

            local tween2 = TweenService:Create(BarFill, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0.75, 0, 1, 0)})
            tween2:Play()
            tween2.Completed:Wait()
            StatusText.Text = "Building user interface..."

            local tween3 = TweenService:Create(BarFill, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)})
            tween3:Play()
            tween3.Completed:Wait()
            StatusText.TextColor3 = Color3.fromRGB(40, 220, 100) 
            StatusText.Text = "Ready!"
            task.wait(3)

            local fadeInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
            TweenService:Create(Box, fadeInfo, {BackgroundTransparency = 1}):Play()
            TweenService:Create(Title, fadeInfo, {TextTransparency = 1}):Play()
            TweenService:Create(StatusText, fadeInfo, {TextTransparency = 1}):Play()
            TweenService:Create(BarBg, fadeInfo, {BackgroundTransparency = 1}):Play()
            local finalFade = TweenService:Create(BarFill, fadeInfo, {BackgroundTransparency = 1})
            finalFade:Play()

            finalFade.Completed:Wait()
            MenuLoadGui:Destroy()

            if callback then
                callback()
            end
        end)
    end)
end

PlayLoadingLogo(function()
    BuildUI()
end)
