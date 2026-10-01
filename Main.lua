-- 1. แก้ไขตัวเลขไอดีแมพให้ถูกต้อง (เปลี่ยนเป็นเลข 0 ตรงกลาง)
local TargetPlaceId = 71793674075007

-- 2. เช็คว่าไอดีแมพปัจจุบันตรงกับที่ตั้งไว้ไหม
if game.PlaceId == TargetPlaceId then
    
    -- โหลดสคริปต์ UI (ตัดเลขขยะสั้นลงแล้ว)
    local Ui = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Ui.lua"
    loadstring(game:HttpGet(Ui))()
    -- โหลดสคริปต์ Fast Attack (ตัดเลขขยะสั้นลงแล้ว )
    local FastAttack = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Fast%20Attack.lua"
    loadstring(game:HttpGet(FastAttack))()
    -- โหลดสคริปต์ Auto Farm Level CCG (ตัดเลขขยะสั้นลงแล้ว )
    local AutoFarmLevelCCG = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Auto%20Farm%20Level%20CCG.lua"
    loadstring(game:HttpGet(AutoFarmLevelCCG))()
        -- โหลดสคริปต์ Auto Farm Level Ghoul (ตัดเลขขยะสั้นลงแล้ว )
    local AutoFarmLevelGhoul = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Auto%20Farm%20Level%20Ghoul.lua"
    loadstring(game:HttpGet(AutoFarmLevelGhoul))()
            -- โหลดสคริปต์ Anti AFK (ตัดเลขขยะสั้นลงแล้ว )
    local AntiAFK = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Anti%20AFK.lua"
    loadstring(game:HttpGet(AntiAFK))()
    local MonsterFarm = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Monster%20Farm.lua"
    loadstring(game:HttpGet(MonsterFarm))()
    
    
else
    -- ถ้าเปิดผิดแมพ ให้เตะผู้เล่นออกทันที
    game.Players.LocalPlayer:Kick("สคริปต์นี้ใช้ได้เฉพาะ Map | Kanom Tokyo")
end
