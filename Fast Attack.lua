-- [[ ไฟล์ที่ 2: SmoothHub Logic - Fast Attack Controller (PURE REMOTE ONLY) ]]
-- ระบบโจมตีรัวรันเพียวๆ: ปรับปรุงให้คัดกรองเฉพาะมอนสเตอร์เป้าหมาย ป้องกันบัคเวลาผู้เล่นอื่นเข้ามาใกล้

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- 1. ล็อกประตูสคริปต์ให้หยุดรอจนกว่าตารางคอนฟิกกลางจากไฟล์ UI จะถูกสร้างเสร็จ (ป้องกัน Error โค้ดระเบิด)
repeat task.wait() until _G.SmoothHubConfig

-- 2. ดักจับ RemoteEvent จากระบบ BridgeNet2 ตรงเป้าตามที่ส่องรีโมตสปายมา
local AttackEvent = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")
local PlayerFolder = Workspace:WaitForChild("AI/Player", 5)

-- ฟังก์ชันเช็กว่ามีมอนสเตอร์เป้าหมายอยู่ในระยะใกล้ตัวหรือไม่
local function HasValidEnemyNearby()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") or not PlayerFolder then 
        return false 
    end
    
    local myPos = character.HumanoidRootPart.Position
    for _, obj in ipairs(PlayerFolder:GetChildren()) do
        -- เช็กว่าเป็นตัวละครมอนสเตอร์ที่มีเลือดและไม่ใช่ผู้เล่นจริง
        local humanoid = obj:FindFirstChildOfClass("Humanoid")
        local rootPart = obj:FindFirstChild("HumanoidRootPart")
        if humanoid and rootPart and humanoid.Health > 0 then
            -- เช็กระยะห่างไม่ให้เกิน 35 หน่วย (อยู่ในระยะโจมตีถึง)
            if (rootPart.Position - myPos).Magnitude <= 35 then
                return true
            end
        end
    end
    return false
end

-- ====================================================================
-- 🕹️ ระบบประมวลผลยิงรีโมทโจมตีรัว (Pure Remote Attack Logic)
-- ====================================================================
task.spawn(function()
    while true do
        -- ดักฟังค่าคอนฟิกจาก UI: ถ้าเปิดใช้งาน และมีรีโมทอยู่จริง
        -- เพิ่มเงื่อนไข HasValidEnemyNearby() เพื่อให้ยิงรีโมทก็ต่อเมื่อมีมอนสเตอร์อยู่ใกล้เท่านั้น (ตัดปัญหาบัคเวลาผู้เล่นอื่นเดินเข้ามาใกล้)
        if _G.SmoothHubConfig.FastAttack and AttackEvent then
            if HasValidEnemyNearby() then
                AttackEvent:FireServer({
                    {
                        "NormalAttack",
                        1
                    },
                    "\x13"
                })
            end
        end
        
        -- หน่วงเวลาสั้นๆ เพื่อความเสถียร
        task.wait(0.0001)
    end
end)
