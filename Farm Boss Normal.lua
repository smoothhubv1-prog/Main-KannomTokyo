-- =========================================================================
-- SmoothHub Custom Boss Farm System (Farm Boss Normal)
-- =========================================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer

-- ประกาศค่าคอนฟิกเริ่มต้นเชื่อมกับ UI (ถ้ายังไม่มี)
_G.SmoothHubConfig = _G.SmoothHubConfig or {
    EnableAutoBoss = false,
    BossSelection = {},
    BossFarmPosition = "Upper"
}

local PlayerFolder = Workspace:WaitForChild("AI/Player", 5)
local BossFolder = PlayerFolder and PlayerFolder:WaitForChild("Boss", 5)
local ZonesFolder = Workspace:WaitForChild("IncludeToGame", 5) and Workspace.IncludeToGame:WaitForChild("Zones", 5)

local FLY_SPEED = 350
local currentBossTarget = nil
local isPlayerReadyToFarm = false

-- ตรวจจับการเกิดใหม่ / ตายของผู้เล่น
local function SetupDeathHandler(character)
    isPlayerReadyToFarm = false
    currentBossTarget = nil
    
    task.delay(2.8, function()
        if LocalPlayer.Character == character then
            isPlayerReadyToFarm = true
        end
    end)
    
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.Died:Connect(function()
            isPlayerReadyToFarm = false
            currentBossTarget = nil
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
    SetupDeathHandler(newChar)
end)

if LocalPlayer.Character then
    SetupDeathHandler(LocalPlayer.Character)
end

-- เช็ก SafeZone ของบอส (ถ้ามี)
local function IsBossInsideSafeZone(bossObj)
    local enemyRoot = bossObj:FindFirstChild("HumanoidRootPart")
    if not enemyRoot or not ZonesFolder then return false end
    
    local bossPos = enemyRoot.Position
    for _, zone in ipairs(ZonesFolder:GetChildren()) do
        if zone.Name == "SafeZone" and zone:IsA("BasePart") then
            local zonePos = zone.Position
            local zoneSize = zone.Size
            local minX, maxX = zonePos.X - (zoneSize.X / 2), zonePos.X + (zoneSize.X / 2)
            local minZ, maxZ = zonePos.Z - (zoneSize.Z / 2), zonePos.Z + (zoneSize.Z / 2)
            
            if (bossPos.X >= minX and bossPos.X <= maxX) and (bossPos.Z >= minZ and bossPos.Z <= maxZ) then
                return true 
            end
        end
    end
    return false
end

-- ดึงรายชื่อบอสที่ผู้เล่นเลือกจาก Dropdown ในหน้า Boss
local function GetSelectedBossNames()
    local selectedList = {}
    if _G.SmoothHubConfig.BossSelection and type(_G.SmoothHubConfig.BossSelection) == "table" then
        for bossFullName, isSelected in pairs(_G.SmoothHubConfig.BossSelection) do
            if isSelected then
                local cleanName = bossFullName:match("^(.-)%s*%[") or bossFullName
                cleanName = cleanName:match("^%s*(.-)%s*$")
                table.insert(selectedList, cleanName)
            end
        end
    end
    return selectedList
end

-- ค้นหาเป้าหมายบอสที่ผู้เล่นเลือกจาก Workspace.AI/Player.Boss
local function GetTargetBoss()
    local closestBoss = nil
    local shortestDistance = math.huge
    local character = LocalPlayer.Character
    local selectedBosses = GetSelectedBossNames()
    
    if #selectedBosses == 0 then return nil end
    
    -- อัปเดตหาโฟลเดอร์ Boss เสมอ
    local currentBossFolder = Workspace:FindFirstChild("AI/Player") and Workspace["AI/Player"]:FindFirstChild("Boss")
    if not currentBossFolder then return nil end
    
    if character and character:FindFirstChild("HumanoidRootPart") then
        local myPos = character.HumanoidRootPart.Position
        
        for _, obj in ipairs(currentBossFolder:GetChildren()) do
            local isMatch = false
            for _, name in ipairs(selectedBosses) do
                if obj.Name == name or obj.Name:find(name) then
                    isMatch = true
                    break
                end
            end
            
            if isMatch and obj:FindFirstChild("HumanoidRootPart") and obj:FindFirstChildOfClass("Humanoid") then
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 and not IsBossInsideSafeZone(obj) then
                    local distance = (obj.HumanoidRootPart.Position - myPos).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestBoss = obj
                    end
                end
            end
        end
    end
    return closestBoss
end

-- ระบบ No Clip สำหรับบอสฟาร์ม
task.spawn(function()
    while true do
        if _G.SmoothHubConfig.EnableAutoBoss then
            local character = LocalPlayer.Character
            if character then
                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then
                        part.CanCollide = false
                    end
                end
            end
        end
        RunService.Stepped:Wait()
    end
end)

-- ระบบบินไปหาบอสเฉพาะตอนที่บอสเกิดแล้ว (ถ้ายังไม่เกิด จะปล่อยตัวเฉยๆ ไม่ทำอะไร)
task.spawn(function()
    while true do
        task.wait()
        if not _G.SmoothHubConfig.EnableAutoBoss then continue end
        if not isPlayerReadyToFarm then continue end
        
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if rootPart then
            if currentBossTarget then
                local currentHumanoid = currentBossTarget:FindFirstChildOfClass("Humanoid")
                if not currentHumanoid or currentHumanoid.Health <= 0 or IsBossInsideSafeZone(currentBossTarget) then
                    currentBossTarget = nil 
                end
            end
            
            if not currentBossTarget then
                currentBossTarget = GetTargetBoss()
            end
            
            if currentBossTarget and currentBossTarget:FindFirstChild("HumanoidRootPart") then
                -- 🟢 เจอบอส: บินเข้าประชิดตามตำแหน่งที่ตั้งค่า (Upper / Down)
                local bossRoot = currentBossTarget.HumanoidRootPart
                local posMode = _G.SmoothHubConfig.BossFarmPosition or "Down"
                local offsetVector = Vector3.new(0, -6, 0) -- Down (อยู่ด้านบนหัวบอส)
                
                if posMode == "Upper" then
                    offsetVector = Vector3.new(0, 6, 0) -- Upper (อยู่ด้านล่าง/เท้าบอส)
                end
                
                local targetPosition = bossRoot.Position + offsetVector
                local distance = (targetPosition - rootPart.Position).Magnitude
                
                if distance > 2 then
                    local direction = (targetPosition - rootPart.Position).Unit
                    local moveStep = math.min(FLY_SPEED * 0.016, distance)
                    rootPart.Velocity = direction * FLY_SPEED
                    rootPart.CFrame = CFrame.new(rootPart.CFrame.Position + (direction * moveStep), bossRoot.Position)
                else
                    rootPart.Velocity = Vector3.new(0, 0, 0)
                    rootPart.CFrame = CFrame.new(targetPosition, bossRoot.Position)
                end
            else
                -- 🛡 ยังไม่เจอบอส / รอบอสเกิด: ปล่อยตัวเฉยๆ ไม่บินไปไหน (ไม่ลอยฟ้า)
                rootPart.Velocity = Vector3.new(0, rootPart.Velocity.Y, 0)
            end
        end
    end
end)

-- ระบบจำลองกดปุ่ม E ซ้ำเพื่อโจมตี/โต้ตอบกับบอส
local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

task.spawn(function()
    while true do
        if not _G.SmoothHubConfig.EnableAutoBoss then
            task.wait(0.5)
            continue
        end

        local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        task.wait(1)
        if _G.SmoothHubConfig.EnableAutoBoss then
            for i = 1, 5 do
                if not _G.SmoothHubConfig.EnableAutoBoss then break end
                pressE()
                task.wait(0.5)
            end
        end
        
        local isAlive = true
        local diedConnection
        diedConnection = humanoid.Died:Connect(function()
            isAlive = false
            if diedConnection then diedConnection:Disconnect() end
        end)
        
        while isAlive and character.Parent and _G.SmoothHubConfig.EnableAutoBoss do
            task.wait(1)
        end
    end
end)

-- ระบบอัปเดตสถานะบอสบน UI (Boss Status)
task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            if not _G.SmoothHubConfig.EnableAutoBoss then
                if _G.BossStatusObj then
                    _G.BossStatusObj.SetText("Off", Color3.fromRGB(150, 165, 170))
                end
                return
            end

            local selectedNames = GetSelectedBossNames()
            if #selectedNames == 0 then
                if _G.BossStatusObj then
                    _G.BossStatusObj.SetText("No Boss Selected", Color3.fromRGB(255, 180, 50))
                end
                return
            end

            if currentBossTarget and currentBossTarget.Name then
                if _G.BossStatusObj then
                    _G.BossStatusObj.SetText("Farming Boss: " .. currentBossTarget.Name, Color3.fromRGB(255, 65, 88))
                end
            else
                if _G.BossStatusObj then
                    _G.BossStatusObj.SetText("Waiting for Boss Spawn...", Color3.fromRGB(100, 200, 255))
                end
            end
        end)
    end
end)

print("SmoothHub Custom Boss Farm Loaded Successfully!")
