--=============================================
-- Anti-AFK System 🛡️
--=============================================
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

-- ประกาศคอนฟิกเชื่อมโยงกับ UI หลัก (ถ้ายังไม่มี)
_G.SmoothHubConfig = _G.SmoothHubConfig or { AntiAFK = false }

-- ดักจับเหตุการณ์การขึ้นหน้าจอแจ้งเตือน AFK (Idled) ของ Roblox
LocalPlayer.Idled:Connect(function()
    -- เช็กว่าเปิดสวิตช์ Anti-AFK ใน UI หรือยัง
    if _G.SmoothHubConfig.AntiAFK then
        pcall(function()
            -- จำลองการกดปุ่มเพื่อรีเซ็ตเวลา AFK
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new(0, 0))
            print("SmoothHub: Anti-AFK Prevented Kick Successfully!")
        end)
    end
end)

print("SmoothHub Anti-AFK Script Loaded!")
