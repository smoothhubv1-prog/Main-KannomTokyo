-- =========================================================================
-- SmoothHub Custom Monster Farm with Auto Quest System & Auto Close UI
-- =========================================================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")

local player = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer

-- ประกาศคอนฟิกพื้นฐานเชื่อมกับ UI
_G.SmoothHubConfig = _G.SmoothHubConfig or { 
    AutoFarmLevelGhoul = false,
    EnableFarmMonster = false,
    MonsterSelection = {},
    MonsterFarmPosition = "Down"
}

task.spawn(function()
    while not _G.MonsterStatusObj and not _G.GhoulStatusObj do
        task.wait(0.1)
    end
end)

local PlayerFolder = Workspace:WaitForChild("AI/Player", 5)
local IncludeToGame = Workspace:WaitForChild("IncludeToGame", 5)
local ZonesFolder = IncludeToGame and IncludeToGame:WaitForChild("Zones", 5)

-- กำหนดข้อมูลพิกัดเควสและชื่อมอนสเตอร์จริงในเกมสำหรับจับคู่รับเควส
local QuestConfig = {
    { Names = {"Human", "Athlete"}, CFrame = CFrame.new(84.4766235, 4.73149872, -26.2268448), QuestPathName = "QuestGiver (Lv.1-Lv.50)" },
    { Names = {"Rank 2 Investigator"}, CFrame = CFrame.new(422.288239, 4.73097706, -362.139801), QuestPathName = "QuestGiver (Lv.50-Lv.150)" },
    { Names = {"Bulk Ghoul"}, CFrame = CFrame.new(404.266632, 4.7305007, 564.892761), QuestPathName = "QuestGiver (Lv.150-Lv.250)" },
    { Names = {"Rank 1 Investigator"}, CFrame = CFrame.new(-210.106567, 4.73097706, -375.544891), QuestPathName = "QuestGiver (Lv.250-Lv.350)" },
    { Names = {"Serpent Ghoul"}, CFrame = CFrame.new(-80.2059937, 4.72720528, 624.273926), QuestPathName = "QuestGiver (Lv.350-Lv.400)" },
    { Names = {"Rin Ghoul"}, CFrame = CFrame.new(503.120239, 4.72720814, 1168.27417), QuestPathName = "QuestGiver (Lv.400-Lv.450)" },
    { Names = {"First class Investigator"}, CFrame = CFrame.new(29.4314117, 4.7277298, 1001.64832), QuestPathName = "QuestGiver (Lv.450-Lv.500)" },
    { Names = {"Aogiri"}, CFrame = CFrame.new(5.03494263, 4.72723007, 1281.78027), QuestPathName = "QuestGiver (Lv.500-Lv.550)" },
    { Names = {"Akira"}, CFrame = CFrame.new(-289.776611, 4.72723007, 1107.37622), QuestPathName = "QuestGiver (Lv.550-Lv.600)" },
    { Names = {"Enforcer"}, CFrame = CFrame.new(917.967651, 4.7309761, 439.671967), QuestPathName = "QuestGiver (Lv.600-Lv.700)" },
    { Names = {"Phantom"}, CFrame = CFrame.new(834.595703, 4.73150063, -409.343506), QuestPathName = "QuestGiver (Lv.700-Lv.800)" },
    { Names = {"Fighter Ghoul"}, CFrame = CFrame.new(524.200989, 4.44271612, -292.036652), QuestPathName = "QuestGiver (Lv.800-Lv.900)" },
    { Names = {"Sparkling Wing Ghoul"}, CFrame = CFrame.new(684.235596, 4.42999983, 690.85791), QuestPathName = "QuestGiver (Lv.900-Lv.1000)" },
    { Names = {"Factor"}, CFrame = CFrame.new(1034.88269, 4.83298349, 651.943848), QuestPathName = "QuestGiver (Lv.1000-Lv.1100)" },
    { Names = {"Faulty Tatara Ghoul"}, CFrame = CFrame.new(708.203613, 4.73383665, 1255.29858), QuestPathName = "QuestGiver (Lv.1100-Lv.1200)" }
}

local FLY_SPEED = 200
local currentTarget = nil 
local isDoingQuest = false
local isPlayerReadyToFarm = false

local function GetPlayerLevel()
    local success, level = pcall(function()
        local dataFolder = LocalPlayer:FindFirstChild("Data")
        if dataFolder then
            local levelStat = dataFolder:FindFirstChild("Level") or dataFolder:FindFirstChild("Lv")
            if levelStat then return levelStat.Value end
        end
    end)
    return success and level or 1
end

-- ดึงรายชื่อมอนสเตอร์ทั้งหมดที่ผู้เล่นติ๊กเลือกไว้ใน UI
local function GetSelectedMonsterNames()
    local selectedList = {}
    if _G.SmoothHubConfig.MonsterSelection and type(_G.SmoothHubConfig.MonsterSelection) == "table" then
        for monsterFullName, isSelected in pairs(_G.SmoothHubConfig.MonsterSelection) do
            if isSelected then
                local cleanName = monsterFullName:match("^(.-)%s*%[") or monsterFullName
                cleanName = cleanName:match("^%s*(.-)%s*$")
                table.insert(selectedList, cleanName)
            end
        end
    end
    return selectedList
end

-- ฟังก์ชันค้นหาเควสที่ตรงกับมอนสเตอร์เป้าหมาย (เรียงจากลำดับขั้นเควสที่สูงกว่า หรือเช็กจากตัวที่กำลังเจอจริง)
local function GetCurrentQuestInfo()
    local selectedMonsters = GetSelectedMonsterNames()
    
    -- ถ้าระบบกำลังเล็งมอนสเตอร์ตัวไหนอยู่ ให้พยายามดึงเควสของมอนสเตอร์ตัวนั้นเป็นหลักทันที
    if currentTarget and currentTarget.Name then
        for _, quest in ipairs(QuestConfig) do
            for _, mName in ipairs(quest.Names) do
                if currentTarget.Name:lower() == mName:lower() or currentTarget.Name:lower():find(mName:lower()) then
                    return quest
                end
            end
        end
    end

    -- ถ้ายังไม่มีเป้าหมาย ให้เช็กจากรายชื่อที่เลือกไว้ (เลือกตัวที่อยู่ในลำดับเควสสูงที่สุดที่คุณติ๊กไว้)
    if #selectedMonsters > 0 then
        for i = #QuestConfig, 1, -1 do
            local quest = QuestConfig[i]
            for _, qName in ipairs(quest.Names) do
                for _, sName in ipairs(selectedMonsters) do
                    if sName:lower() == qName:lower() or sName:lower():find(qName:lower()) then
                        return quest
                    end
                end
            end
        end
    end
    
    -- กรณีสำรอง อิงตามเลเวลผู้เล่น
    local level = GetPlayerLevel()
    for i = #QuestConfig, 1, -1 do
        if level >= (i - 1) * 100 then
            return QuestConfig[i]
        end
    end
    return QuestConfig[1]
end

-- ฟังก์ชันเช็กว่าปัจจุบันมีเควสแสดงอยู่บนหน้าจอ UI หรือไม่
local function HasActiveQuest()
    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        local hud = playerGui:FindFirstChild("HUD")
        local questUi = hud and hud:FindFirstChild("Quest")
        if questUi then
            if questUi.Visible or #questUi:GetChildren() > 0 then
                local hasText = false
                for _, desc in ipairs(questUi:GetDescendants()) do
                    if desc:IsA("TextLabel") and desc.Text ~= "" and not desc.Text:lower():find("quest") then
                        hasText = true
                        break
                    end
                end
                return hasText
            end
        end
    end
    return false
end

-- ฟังก์ชันตรวจสอบว่าเควสปัจจุบันบนหน้าจอตรงกับเป้าหมายหรือไม่
local function IsActiveQuestCorrect()
    local targetQuestInfo = GetCurrentQuestInfo()
    if not targetQuestInfo then return true end

    local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if playerGui then
        local hud = playerGui:FindFirstChild("HUD")
        local questUi = hud and hud:FindFirstChild("Quest")
        if questUi and questUi.Visible then
            for _, desc in ipairs(questUi:GetDescendants()) do
                if desc:IsA("TextLabel") and desc.Text ~= "" then
                    local textLower = desc.Text:lower()
                    for _, mName in ipairs(targetQuestInfo.Names) do
                        if textLower:find(mName:lower()) then
                            return true -- เควสตรงกันแล้ว
                        end
                    end
                end
            end
        end
    end
    return false -- เควสไม่ตรง (เช่น ถือเควส 400 แต่จะไปตีมอน 450)
end

-- ฟังก์ชันยกเลิก/ลบเควสเก่าทิ้งผ่าน RemoteEvent
local function AbandonCurrentQuest()
    pcall(function()
        local networkFolder = ReplicatedStorage:FindFirstChild("Network")
        if networkFolder then
            for _, remote in ipairs(networkFolder:GetChildren()) do
                if remote:IsA("RemoteEvent") then
                    remote:FireServer("AbandonQuest")
                    remote:FireServer("RemoveQuest")
                    remote:FireServer("CancelQuest")
                end
            end
        end
    end)
end

local function SetupDeathHandler(character)
    isPlayerReadyToFarm = false
    currentTarget = nil
    isDoingQuest = false
    
    task.delay(2.8, function()
        if LocalPlayer.Character == character then
            isPlayerReadyToFarm = true
        end
    end)
    
    local humanoid = character:WaitForChild("Humanoid", 5)
    if humanoid then
        humanoid.Died:Connect(function()
            isPlayerReadyToFarm = false
            currentTarget = nil
            isDoingQuest = false
        end)
    end
end

LocalPlayer.CharacterAdded:Connect(function(newChar)
    SetupDeathHandler(newChar)
end)

if LocalPlayer.Character then
    SetupDeathHandler(LocalPlayer.Character)
end

-- เช็ก SafeZone ของมอนสเตอร์
local function IsMonsterInsideSafeZoneFolder(monsterObj)
    local enemyRoot = monsterObj:FindFirstChild("HumanoidRootPart")
    if not enemyRoot or not ZonesFolder then return false end
    
    local monsterPos = enemyRoot.Position
    for _, zone in ipairs(ZonesFolder:GetChildren()) do
        if zone.Name == "SafeZone" and zone:IsA("BasePart") then
            local zonePos = zone.Position
            local zoneSize = zone.Size
            local minX, maxX = zonePos.X - (zoneSize.X / 2), zonePos.X + (zoneSize.X / 2)
            local minZ, maxZ = zonePos.Z - (zoneSize.Z / 2), zonePos.Z + (zoneSize.Z / 2)
            
            if (monsterPos.X >= minX and monsterPos.X <= maxX) and (monsterPos.Z >= minZ and monsterPos.Z <= maxZ) then
                return true 
            end
        end
    end
    return false
end

-- ค้นหามอนสเตอร์เป้าหมายที่ผู้เล่นเลือกฟาร์ม (อิงตามชื่อที่เลือกใน Dropdown)
local function GetTargetMonster()
    local closestMonster = nil
    local shortestDistance = math.huge
    local character = LocalPlayer.Character
    local selectedMonsters = GetSelectedMonsterNames()
    
    if #selectedMonsters == 0 then return nil end
    
    if character and character:FindFirstChild("HumanoidRootPart") and PlayerFolder then
        local myPos = character.HumanoidRootPart.Position
        
        for _, obj in ipairs(PlayerFolder:GetChildren()) do
            local isMatch = false
            for _, name in ipairs(selectedMonsters) do
                if obj.Name == name or obj.Name:find(name) then
                    isMatch = true
                    break
                end
            end
            
            if isMatch and obj:FindFirstChild("HumanoidRootPart") and obj:FindFirstChildOfClass("Humanoid") then
                local humanoid = obj:FindFirstChildOfClass("Humanoid")
                if humanoid and humanoid.Health > 0 and not IsMonsterInsideSafeZoneFolder(obj) then
                    local distance = (obj.HumanoidRootPart.Position - myPos).Magnitude
                    if distance < shortestDistance then
                        shortestDistance = distance
                        closestMonster = obj
                    end
                end
            end
        end
    end
    return closestMonster
end

-- ระบบ No Clip
task.spawn(function()
    while true do
        if _G.SmoothHubConfig.EnableFarmMonster then
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

-- ระบบปิดหน้าต่าง Daily Rewards อัตโนมัติ
task.spawn(function()
    while true do
        task.wait(0.5)
        if _G.SmoothHubConfig.EnableFarmMonster then
            pcall(function()
                local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
                if playerGui then
                    for _, gui in ipairs(playerGui:GetDescendants()) do
                        if gui:IsA("TextLabel") and (gui.Text == "Daily Rewards" or gui.Text:find("Daily Reward")) then
                            local rewardFrame = gui:FindFirstAncestorWhichIsA("Frame") or gui:FindFirstAncestorWhichIsA("ImageLabel")
                            if rewardFrame then
                                rewardFrame.Visible = false
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- ระบบสร้างกรอบ RGB ให้ตัวละคร
local rgbHighlight = nil
task.spawn(function()
    while true do
        task.wait(0.1)
        local character = LocalPlayer.Character
        if _G.SmoothHubConfig.EnableFarmMonster and character then
            if not rgbHighlight or rgbHighlight.Parent ~= character then
                if rgbHighlight then rgbHighlight:Destroy() end
                rgbHighlight = Instance.new("Highlight")
                rgbHighlight.Name = "SmoothHubRGB"
                rgbHighlight.Adornee = character
                rgbHighlight.FillTransparency = 1
                rgbHighlight.OutlineTransparency = 0
                rgbHighlight.Parent = character
            end
            
            local hue = (tick() % 5) / 5
            rgbHighlight.OutlineColor = Color3.fromHSV(hue, 1, 1)
        else
            if rgbHighlight then
                rgbHighlight:Destroy()
                rgbHighlight = nil
            end
        end
    end
end)

-- ระบบบินไปรับเควสอัตโนมัติ (ตรวจสอบความถูกต้องของเควส ถือผิดอันจะทำการสละเควสแล้วไปรับใหม่)
task.spawn(function()
    while true do
        task.wait(0.5)
        if not _G.SmoothHubConfig.EnableFarmMonster then continue end
        if not isPlayerReadyToFarm then continue end
        
        -- ถ้ามีเควสอยู่แล้วแต่ตรวจพบว่าไม่ตรงกับเป้าหมาย ให้ยกเลิกทิ้งทันที
        if HasActiveQuest() and not IsActiveQuestCorrect() then
            AbandonCurrentQuest()
            currentTarget = nil
            task.wait(0.5)
        end
        
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if rootPart and (not HasActiveQuest() or not IsActiveQuestCorrect()) and not isDoingQuest then
            isDoingQuest = true
            
            while (not HasActiveQuest() or not IsActiveQuestCorrect()) and isPlayerReadyToFarm and _G.SmoothHubConfig.EnableFarmMonster do
                local char = LocalPlayer.Character
                local rp = char and char:FindFirstChild("HumanoidRootPart")
                local questInfo = GetCurrentQuestInfo()
                
                if not rp or not questInfo then break end
                
                local targetCFrame = questInfo.CFrame - Vector3.new(0, 7, 0)
                local distance = (targetCFrame.Position - rp.Position).Magnitude
                
                if distance > 3 then
                    local direction = (targetCFrame.Position - rp.Position).Unit
                    local moveStep = math.min(FLY_SPEED * 0.016, distance)
                    rp.Velocity = direction * FLY_SPEED
                    rp.CFrame = rp.CFrame + (direction * moveStep)
                else
                    rp.Velocity = Vector3.new(0, 0, 0)
                    rp.CFrame = targetCFrame
                    
                    pcall(function()
                        local networkFolder = ReplicatedStorage:FindFirstChild("Network")
                        local questTarget = ReplicatedStorage:FindFirstChild("Modules") 
                            and ReplicatedStorage.Modules:FindFirstChild("Client") 
                            and ReplicatedStorage.Modules.Client:FindFirstChild("TalkNpc") 
                            and ReplicatedStorage.Modules.Client.TalkNpc:FindFirstChild("Quests") 
                            and ReplicatedStorage.Modules.Client.TalkNpc.Quests[questInfo.QuestPathName] 
                            and ReplicatedStorage.Modules.Client.TalkNpc.Quests[questInfo.QuestPathName]:FindFirstChild("Quest")

                        if networkFolder and questTarget then
                            for _, remote in ipairs(networkFolder:GetChildren()) do
                                if remote:IsA("RemoteEvent") then
                                    remote:FireServer("RequestQuest", questTarget)
                                end
                            end
                        end
                    end)
                end
                
                task.wait(1)
            end
            
            task.wait(0.5)
            isDoingQuest = false
        end
    end
end)

-- ลูปการบินไปฟาร์มมอนสเตอร์ หรือบินขึ้นไปลอยตัวหลบบนฟ้าตอนรอมอนเกิด
task.spawn(function()
    while true do
        task.wait()
        if not _G.SmoothHubConfig.EnableFarmMonster then continue end
        if not isPlayerReadyToFarm then continue end
        
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        -- ต้องมีเควสและเควสต้องถูกต้องตรงกันเท่านั้น ถึงจะเริ่มบินไปตีมอน
        if rootPart and HasActiveQuest() and IsActiveQuestCorrect() and not isDoingQuest then
            if currentTarget then
                local currentHumanoid = currentTarget:FindFirstChildOfClass("Humanoid")
                if not currentHumanoid or currentHumanoid.Health <= 0 or IsMonsterInsideSafeZoneFolder(currentTarget) then
                    currentTarget = nil 
                end
            end
            
            if not currentTarget then
                currentTarget = GetTargetMonster()
            end
            
            if currentTarget and currentTarget:FindFirstChild("HumanoidRootPart") then
                local enemyRoot = currentTarget.HumanoidRootPart
                
                local posMode = _G.SmoothHubConfig.MonsterFarmPosition or "Down"
                local offsetVector = Vector3.new(0, -6, 0)
                
                if posMode == "Upper" then
                    offsetVector = Vector3.new(0, 6, 0)
                end
                
                local targetPosition = enemyRoot.Position + offsetVector
                
                local distance = (targetPosition - rootPart.Position).Magnitude
                if distance > 2 then
                    local direction = (targetPosition - rootPart.Position).Unit
                    local moveStep = math.min(FLY_SPEED * 0.016, distance)
                    rootPart.Velocity = direction * FLY_SPEED
                    rootPart.CFrame = CFrame.new(rootPart.CFrame.Position + (direction * moveStep), enemyRoot.Position)
                else
                    rootPart.Velocity = Vector3.new(0, 0, 0)
                    rootPart.CFrame = CFrame.new(targetPosition, enemyRoot.Position)
                end
            else
                local currentPos = rootPart.Position
                local skyPosition = Vector3.new(currentPos.X, 400, currentPos.Z)
                
                local skyDistance = (skyPosition - rootPart.Position).Magnitude
                if skyDistance > 5 then
                    local direction = (skyPosition - rootPart.Position).Unit
                    local moveStep = math.min(FLY_SPEED * 0.016, skyDistance)
                    rootPart.Velocity = direction * FLY_SPEED
                    rootPart.CFrame = CFrame.new(rootPart.CFrame.Position + (direction * moveStep))
                else
                    rootPart.Velocity = Vector3.new(0, 0, 0)
                    rootPart.CFrame = CFrame.new(skyPosition)
                end
            end
        end
    end
end)

-- ====================================
-- ระบบกด E (สำหรับโจมตีอัตโนมัติ)
-- ====================================
local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

local function performThreePresses()
    for i = 1, 5 do
        if not _G.SmoothHubConfig.EnableFarmMonster then break end
        pressE()
        if i < 5 then
            task.wait(0.5)
        end
    end
end

task.spawn(function()
    while true do
        if not _G.SmoothHubConfig.EnableFarmMonster then
            task.wait(0.5)
            continue
        end

        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        task.wait(1)
        if _G.SmoothHubConfig.EnableFarmMonster then
            performThreePresses()
        end
        
        local isAlive = true
        local diedConnection
        diedConnection = humanoid.Died:Connect(function()
            isAlive = false
            if diedConnection then
                diedConnection:Disconnect()
            end
        end)
        
        while isAlive and character.Parent and _G.SmoothHubConfig.EnableFarmMonster do
            task.wait(1)
        end
    end
end)

-- ระบบอัปเดต Status บน UI
task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            if not _G.SmoothHubConfig.EnableFarmMonster then
                if _G.MonsterStatusObj then
                    _G.MonsterStatusObj.SetText("Off", Color3.fromRGB(150, 165, 170))
                end
                return
            end

            local selectedNames = GetSelectedMonsterNames()
            if #selectedNames == 0 then
                if _G.MonsterStatusObj then
                    _G.MonsterStatusObj.SetText("No Monster Selected", Color3.fromRGB(255, 180, 50))
                end
                return
            end

            if _G.MonsterStatusObj then
                if not HasActiveQuest() or not IsActiveQuestCorrect() then
                    _G.MonsterStatusObj.SetText("Syncing Right Quest...", Color3.fromRGB(255, 180, 50))
                elseif currentTarget and currentTarget.Name then
                    _G.MonsterStatusObj.SetText("Farming: " + currentTarget.Name, Color3.fromRGB(40, 220, 100))
                else
                    _G.MonsterStatusObj.SetText("Waiting/Hidden in Sky...", Color3.fromRGB(100, 200, 255))
                end
            end
        end)
    end
end)

print("SmoothHub Custom Monster Farm with Auto Quest & Auto Close UI Loaded Successfully!")
