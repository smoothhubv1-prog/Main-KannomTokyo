--=============================================
-- Auto Farm Level | Ghoul 👹 (Full Fly & Sky Hide Version)
--=============================================
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local LocalPlayer = Players.LocalPlayer

-- ประกาศคอนฟิกพื้นฐานเชื่อมกับ UI (ถ้ายังไม่มี)
_G.SmoothHubConfig = _G.SmoothHubConfig or { AutoFarmLevelGhoul = false, FarmPosition = "Upper" }

task.spawn(function()
    while not _G.GhoulStatusObj do
        task.wait(0.1)
    end
end)

local PlayerFolder = Workspace:WaitForChild("AI/Player", 5)
local IncludeToGame = Workspace:WaitForChild("IncludeToGame", 5)
local ZonesFolder = IncludeToGame and IncludeToGame:WaitForChild("Zones", 5)

-- 3. กำหนดค่าพิกัด เควส และรายชื่อมอนสเตอร์เป้าหมายตามช่วงเลเวล
local QuestConfig = {
    new1 = {
        CFrame = CFrame.new(84.4766235, 4.73149872, -26.2268448, -0.991879344, 0, 0.127182722, 0, 1, 0, -0.127182722, 0, -0.991879344),
        QuestPathName = "QuestGiver (Lv.1-Lv.50)",
        TargetMonsterNames = {"Human", "Athlete"}
    },
    Lv50 = {
        CFrame = CFrame.new(422.288239, 4.73097706, -362.139801, 0, 0, 1, 0, 1, -0, -1, 0, 0),
        QuestPathName = "QuestGiver (Lv.50-Lv.150)",
        TargetMonsterNames = {"Rank 2 Investigator"}
    },
    Lv150 = { 
        CFrame = CFrame.new(404.266632, 4.7305007, 564.892761, 0, 0, 1, 0, 1, -0, -1, 0, 0),
        QuestPathName = "QuestGiver (Lv.150-Lv.250)",
        TargetMonsterNames = {"Bulk Ghoul"}
    },
    Lv250 = { 
        CFrame = CFrame.new(-210.106567, 4.73097706, -375.544891, 0.149021685, -0, -0.988834023, 0, 1, -0, 0.988834023, 0, 0.149021685),
        QuestPathName = "QuestGiver (Lv.250-Lv.350)",
        TargetMonsterNames = {"Rank 1 Investigator"}
    },
    Lv350 = { 
        CFrame = CFrame.new(-80.2059937, 4.72720528, 624.273926, 0, 0, -1, 0, 1, 0, 1, 0, 0),
        QuestPathName = "QuestGiver (Lv.350-Lv.400)",
        TargetMonsterNames = {"Serpent Ghoul"}
    },
    Lv400 = { 
        CFrame = CFrame.new(503.120239, 4.72720814, 1168.27417, -1, 0, 0, 0, 1, 0, 0, 0, -1),
        QuestPathName = "QuestGiver (Lv.400-Lv.450)",
        TargetMonsterNames = {"Rin Ghoul"}
    },
    Lv450 = { 
        CFrame = CFrame.new(29.4314117, 4.7277298, 1001.64832, 0, 0, -1, 0, 1, 0, 1, 0, 0),
        QuestPathName = "QuestGiver (Lv.450-Lv.500)",
        TargetMonsterNames = {"First class Investigator"}
    },
    Lv500 = { 
        CFrame = CFrame.new(5.03494263, 4.72723007, 1281.78027, 0, 0, -1, 0, 1, 0, 1, 0, 0),
        QuestPathName = "QuestGiver (Lv.500-Lv.550)",
        TargetMonsterNames = {"Aogiri"}
    },
    Lv550 = { 
        CFrame = CFrame.new(-289.776611, 4.72723007, 1107.37622, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        QuestPathName = "QuestGiver (Lv.550-Lv.600)",
        TargetMonsterNames = {"Akira"}
    },
    Lv600 = { 
        CFrame = CFrame.new(917.967651, 4.7309761, 439.671967, 0, 0, 1, 0, 1, -0, -1, 0, 0),
        QuestPathName = "QuestGiver (Lv.600-Lv.700)",
        TargetMonsterNames = {"Enforcer"}
    },
    Lv700 = { 
        CFrame = CFrame.new(834.595703, 4.73150063, -409.343506, 0, 0, 1, 0, 1, -0, -1, 0, 0),
        QuestPathName = "QuestGiver (Lv.700-Lv.800)",
        TargetMonsterNames = {"Phantom"}
    },
    Lv800 = { 
        CFrame = CFrame.new(524.200989, 4.44271612, -292.036652, -1, 0, 0, 0, 1, 0, 0, 0, -1),
        QuestPathName = "QuestGiver (Lv.800-Lv.900)",
        TargetMonsterNames = {"Fighter Ghoul"}
    },
    Lv900 = { 
        CFrame = CFrame.new(684.235596, 4.42999983, 690.85791, 0, 0, -1, 0, 1, 0, 1, 0, 0),
        QuestPathName = "QuestGiver (Lv.900-Lv.1000)",
        TargetMonsterNames = {"Sparkling Wing Ghoul"}
    },
    Lv1000 = { 
        CFrame = CFrame.new(1034.88269, 4.83298349, 651.943848, -1, 0, 0, 0, 1, 0, 0, 0, -1),
        QuestPathName = "QuestGiver (Lv.1000-Lv.1100)",
        TargetMonsterNames = {"Factor"}
    },
    Lv1100 = { 
        CFrame = CFrame.new(708.203613, 4.73383665, 1255.29858, 1, 0, 0, 0, 1, 0, 0, 0, 1),
        QuestPathName = "QuestGiver (Lv.1100-Lv.1200)",
        TargetMonsterNames = {"Faulty Tatara Ghoul"}
    }
}

local FLY_SPEED = 200
local currentTarget = nil 
local isDoingQuest = false
local isPlayerReadyToFarm = false

-- ฟังก์ชันเช็กเลเวลผู้เล่นจากโฟลเดอร์ Data โดยตรง
local function GetPlayerLevel()
    local success, level = pcall(function()
        local dataFolder = LocalPlayer:FindFirstChild("Data")
        if dataFolder then
            local levelStat = dataFolder:FindFirstChild("Level") or dataFolder:FindFirstChild("Lv")
            if levelStat and (levelStat:IsA("IntValue") or levelStat:IsA("NumberValue")) then
                return levelStat.Value
            end
        end
        
        local leaderstats = LocalPlayer:FindFirstChild("leaderstats")
        if leaderstats then
            for _, stat in ipairs(leaderstats:GetChildren()) do
                if stat.Name:lower():find("level") or stat.Name:lower():find("lv") then
                    if stat:IsA("IntValue") or stat:IsA("NumberValue") then
                        return stat.Value
                    end
                end
            end
        end
        
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
        if playerGui then
            for _, gui in ipairs(playerGui:GetDescendants()) do
                if gui:IsA("TextLabel") and gui.Text:lower():find("level") then
                    local num = tonumber(gui.Text:match("%d+"))
                    if num then return num end
                end
            end
        end
    end)
    
    if success and level then
        return level
    end
    return 1
end

-- ฟังก์ชันเช็กว่ามีเควสอยู่หรือไม่
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

-- ฟังก์ชันเลือกข้อมูลเควสตามเลเวลปัจจุบัน (ให้สอดคล้องกับเลเวลผู้เล่นจริง ป้องกันการดึงเควสมั่ว)
local function GetCurrentQuestInfo()
    -- ถ้าระบบกำลังเล็งมอนสเตอร์ตัวไหนอยู่ ให้พยายามดึงเควสของมอนสเตอร์ตัวนั้นเป็นหลักทันที
    if currentTarget and currentTarget.Name then
        for _, qData in pairs(QuestConfig) do
            for _, mName in ipairs(qData.TargetMonsterNames) do
                if currentTarget.Name:lower() == mName:lower() or currentTarget.Name:lower():find(mName:lower()) then
                    return qData
                end
            end
        end
    end

    local level = GetPlayerLevel()
    
    if level >= 1100 then return QuestConfig.Lv1100
    elseif level >= 1000 then return QuestConfig.Lv1000
    elseif level >= 900 then return QuestConfig.Lv900
    elseif level >= 800 then return QuestConfig.Lv800
    elseif level >= 700 then return QuestConfig.Lv700
    elseif level >= 600 then return QuestConfig.Lv600
    elseif level >= 550 then return QuestConfig.Lv550
    elseif level >= 500 then return QuestConfig.Lv500
    elseif level >= 450 then return QuestConfig.Lv450
    elseif level >= 400 then return QuestConfig.Lv400
    elseif level >= 350 then return QuestConfig.Lv350
    elseif level >= 250 then return QuestConfig.Lv250
    elseif level >= 150 then return QuestConfig.Lv150
    elseif level >= 50 then return QuestConfig.Lv50
    else return QuestConfig.new1
    end
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
                    for _, mName in ipairs(targetQuestInfo.TargetMonsterNames) do
                        if textLower:find(mName:lower()) then
                            return true -- เควสตรงกันแล้ว
                        end
                    end
                end
            end
        end
    end
    return false -- เควสไม่ตรง
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

-- จัดการการตายและจับเวลาเกิดใหม่
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

-- ====================================================================
-- 🌈 ระบบกรอบเรืองแสงเฉพาะเส้นขอบ (RGB Outline)
-- ====================================================================
task.spawn(function()
    local success, parentFolder = pcall(function()
        return CoreGui
    end)
    if not success or not parentFolder then
        parentFolder = LocalPlayer:WaitForChild("PlayerGui")
    end

    local highlight = Instance.new("Highlight")
    highlight.Name = "SmoothHubRGBOutline"
    highlight.FillTransparency = 1 
    highlight.OutlineTransparency = 0 
    highlight.Adornee = nil
    highlight.Parent = parentFolder

    LocalPlayer.CharacterAdded:Connect(function(newCharacter)
        highlight.Adornee = newCharacter
    end)

    if LocalPlayer.Character then
        highlight.Adornee = LocalPlayer.Character
    end

    RunService.RenderStepped:Connect(function()
        if not _G.SmoothHubConfig.AutoFarmLevelGhoul then
            highlight.Adornee = nil
            return
        end

        local character = LocalPlayer.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if highlight.Adornee ~= character then
                highlight.Adornee = character
            end
            local hue = tick() % 5 / 5
            local rgbColor = Color3.fromHSV(hue, 1, 1)
            highlight.OutlineColor = rgbColor
        else
            highlight.Adornee = nil
        end
    end)
end)

-- ====================================================================
-- 🎁 ปิดเฉพาะหน้าต่าง Daily Rewards
-- ====================================================================
task.spawn(function()
    while true do
        task.wait(0.5)
        if _G.SmoothHubConfig.AutoFarmLevelGhoul then
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

-- เช็ก SafeZone
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

-- ค้นหามอนสเตอร์ตามเป้าหมายปัจจุบัน
local function GetTargetMonster()
    local closestMonster = nil
    local shortestDistance = math.huge
    local character = LocalPlayer.Character
    local questInfo = GetCurrentQuestInfo()
    local targetNames = questInfo.TargetMonsterNames
    
    if character and character:FindFirstChild("HumanoidRootPart") and PlayerFolder then
        local myPos = character.HumanoidRootPart.Position
        
        for _, obj in ipairs(PlayerFolder:GetChildren()) do
            local isMatch = false
            for _, name in ipairs(targetNames) do
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

-- ====================================================================
-- 🌀 No Clip
-- ====================================================================
task.spawn(function()
    while true do
        if _G.SmoothHubConfig.AutoFarmLevelGhoul then
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

-- ====================================================================
-- 📜 ลูปจัดการเควส (ตรวจสอบความถูกต้อง และบินไปรับเควสใหม่หากไม่ตรง)
-- ====================================================================
task.spawn(function()
    while true do
        task.wait(0.5)
        if not _G.SmoothHubConfig.AutoFarmLevelGhoul then continue end
        if not isPlayerReadyToFarm then continue end
        
        -- ถ้ามีเควสอยู่แล้วแต่ตรวจสอบพบว่าไม่ตรงกับเลเวล/เป้าหมาย ให้สละเควสทิ้งทันที
        if HasActiveQuest() and not IsActiveQuestCorrect() then
            AbandonCurrentQuest()
            currentTarget = nil
            task.wait(0.5)
        end
        
        local character = LocalPlayer.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")
        
        if rootPart and (not HasActiveQuest() or not IsActiveQuestCorrect()) and not isDoingQuest then
            isDoingQuest = true
            
            while (not HasActiveQuest() or not IsActiveQuestCorrect()) and isPlayerReadyToFarm and _G.SmoothHubConfig.AutoFarmLevelGhoul do
                local char = LocalPlayer.Character
                local rp = char and char:FindFirstChild("HumanoidRootPart")
                local questInfo = GetCurrentQuestInfo()
                
                if not rp or not questInfo then break end
                
                -- อยู่ต่ำกว่าจุดเควส 7 หน่วย ป้องกันตัวละครชนกันจนกระเด็น
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

-- ====================================================================
-- 🕹️ ลูปฟาร์มมอนสเตอร์ + ระบบรองรับเลือก Position & บินหลบบนฟ้าตอนรอมอนเกิด
-- ====================================================================
task.spawn(function()
    while true do
        task.wait()
        if not _G.SmoothHubConfig.AutoFarmLevelGhoul then continue end
        
        if not isPlayerReadyToFarm then
            continue
        end
        
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
                -- 🟢 กรณีเจอมอนสเตอร์: บินเข้าหาตามตำแหน่งที่เลือก (Upper / Down)
                local enemyRoot = currentTarget.HumanoidRootPart
                
                local farmPosType = _G.SmoothHubConfig.FarmPosition or "Upper"
                local offsetHeight = 6
                
                local targetPosition
                if farmPosType == "Upper" then
                    targetPosition = enemyRoot.Position + Vector3.new(0, offsetHeight, 0)
                else
                    targetPosition = enemyRoot.Position - Vector3.new(0, offsetHeight, 0)
                end
                
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
                -- 🛡️ กรณีรอมอนสเตอร์เกิด: บินขึ้นไปลอยตัวหลบบนฟ้าสูงๆ (Y + 400)
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
        else
            rootPart.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

print("SmoothHub Full Fly & Sky Hide Support Version Loaded Successfully!")

-- ====================================
-- ระบบกด E (ทำงานแยกตามปกติ)
-- ====================================
local function pressE()
    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

local function performThreePresses()
    print("--- เริ่มกด E จำนวน 5 ครั้ง ---")
    for i = 1, 5 do
        if not _G.SmoothHubConfig.AutoFarmLevelGhoul then break end
        print("กด E ครั้งที่ " .. i)
        pressE()
        if i < 5 then
            task.wait(0.5)
        end
    end
    print("--- กดครบแล้ว ---")
end

task.spawn(function()
    while true do
        if not _G.SmoothHubConfig.AutoFarmLevelGhoul then
            task.wait(0.5)
            continue
        end

        local character = player.Character or player.CharacterAdded:Wait()
        local humanoid = character:WaitForChild("Humanoid")
        
        task.wait(1)
        if _G.SmoothHubConfig.AutoFarmLevelGhoul then
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
        
        while isAlive and character.Parent and _G.SmoothHubConfig.AutoFarmLevelGhoul do
            task.wait(1)
        end
    end
end)

-- ====================================================================
-- 📊 ระบบอัปเดต Status บน UI
-- ====================================================================
task.spawn(function()
    while true do
        task.wait(0.5)
        pcall(function()
            if not _G.SmoothHubConfig.AutoFarmLevelGhoul then
                if _G.GhoulStatusObj then
                    _G.GhoulStatusObj.SetText("Off", Color3.fromRGB(150, 165, 170))
                end
                return
            end

            local questInfo = GetCurrentQuestInfo()
            local spotRange = "Unknown"
            
            if questInfo == QuestConfig.new1 then spotRange = "lvl 1-50"
            elseif questInfo == QuestConfig.Lv50 then spotRange = "lvl 50-150"
            elseif questInfo == QuestConfig.Lv150 then spotRange = "lvl 150-250"
            elseif questInfo == QuestConfig.Lv250 then spotRange = "lvl 250-350"
            elseif questInfo == QuestConfig.Lv350 then spotRange = "lvl 350-400"
            elseif questInfo == QuestConfig.Lv400 then spotRange = "lvl 400-450"
            elseif questInfo == QuestConfig.Lv450 then spotRange = "lvl 450-500"
            elseif questInfo == QuestConfig.Lv500 then spotRange = "lvl 500-550"
            elseif questInfo == QuestConfig.Lv550 then spotRange = "lvl 550-600"
            elseif questInfo == QuestConfig.Lv600 then spotRange = "lvl 600-700"
            elseif questInfo == QuestConfig.Lv700 then spotRange = "lvl 700-800"
            elseif questInfo == QuestConfig.Lv800 then spotRange = "lvl 800-900"
            elseif questInfo == QuestConfig.Lv900 then spotRange = "lvl 900-1000"
            elseif questInfo == QuestConfig.Lv1000 then spotRange = "lvl 1000-1100"
            elseif questInfo == QuestConfig.Lv1100 then spotRange = "lvl 1100-1200"
            end

            local targetName = "Unknown"
            if currentTarget and currentTarget.Name then
                targetName = currentTarget.Name
            else
                if questInfo and questInfo.TargetMonsterNames and #questInfo.TargetMonsterNames > 0 then
                    targetName = questInfo.TargetMonsterNames[1]
                end
            end

            local countText = "0/6"
            local playerGui = LocalPlayer:FindFirstChild("PlayerGui")
            if playerGui then
                local hud = playerGui:FindFirstChild("HUD")
                local questUi = hud and hud:FindFirstChild("Quest")
                if questUi and questUi.Visible then
                    for _, desc in ipairs(questUi:GetDescendants()) do
                        if desc:IsA("TextLabel") and desc.Text ~= "" then
                            local txt = desc.Text
                            if txt:match("%d+/%d+") then
                                countText = txt:match("%d+/%d+")
                                break
                            end
                        end
                    end
                end
            end

            if _G.GhoulStatusObj then
                if not HasActiveQuest() or not IsActiveQuestCorrect() then
                    _G.GhoulStatusObj.SetText("Syncing Right Quest...", Color3.fromRGB(255, 180, 50))
                elseif not currentTarget then
                    _G.GhoulStatusObj.SetText("Waiting/Hidden in Sky...", Color3.fromRGB(100, 200, 255))
                else
                    local displayText = "[" .. targetName .. "] " .. countText .. " (" .. spotRange .. ")"
                    _G.GhoulStatusObj.SetText(displayText, Color3.fromRGB(40, 220, 100))
                end
            end
        end)
    end
end)
