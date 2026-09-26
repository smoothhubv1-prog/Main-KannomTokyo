-- [[ ไฟล์ที่ 2: SmoothHub Logic - Fast Attack Controller (PURE REMOTE ONLY) ]]
-- ระบบโจมตีรัวรันเพียวๆ: สับเปลี่ยนสถานะดักจับและยิง RemoteEvent วงรอบเดียวตามพิกัดสปาย BridgeNet2 ของพี่เป๊ะๆ

local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- 1. ล็อกประตูสคริปต์ให้หยุดรอจนกว่าตารางคอนฟิกกลางจากไฟล์ UI จะถูกสร้างเสร็จ (ป้องกัน Error โค้ดระเบิด)
repeat task.wait() until _G.SmoothHubConfig

-- 2. ดักจับ RemoteEvent จากระบบ BridgeNet2 ตรงเป้าตามที่พี่ส่องรีโมตสปายมา
local AttackEvent = ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent")

-- ====================================================================
-- 🕹️ ระบบประมวลผลยิงรีโมทโจมตีรัว (Pure Remote Attack Logic)
-- ====================================================================
task.spawn(function()
    while true do
        -- ดักฟังค่าคอนฟิกจาก UI: ถ้าปุ่มฝั่ง UI ถูกเปิดใช้งาน (state = true) และมีรีโมทอยู่จริง
        if _G.SmoothHubConfig.FastAttack and AttackEvent then
            -- สั่งสแปมยิงคำสั่ง RemoteEvent ออกไปเพียวๆ ทันทีตามอาร์กิวเมนต์ที่พี่ส่งมา
            AttackEvent:FireServer({
                {
                    "NormalAttack",
                    1
                },
                "\x13"
            })
        end
        
        -- หน่วงเวลาพักเบรกระดับเฟรมเรตต่ำสุด (ข้ามไปเช็กและยิงรอบใหม่ในเฟรมถัดไปทันที)
        task.wait()
    end
end)
