-- 1. แก้ไขตัวเลขไอดีแมพให้ถูกต้อง (ประกาศเป็น Table หลายไอดี)
local TargetPlaceId = { 71793674075007, 123949707464677 }

-- 2. เช็คว่าไอดีแมพปัจจุบันตรงกับที่ตั้งไว้ใน Table ไหม
if table.find(TargetPlaceId, game.PlaceId) then
    
    -- โหลดสคริปต์ UI
    local Ui = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Ui.lua"
    loadstring(game:HttpGet(Ui))()
    
    -- โหลดสคริปต์ Fast Attack
    local FastAttack = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Fast%20Attack.lua"
    loadstring(game:HttpGet(FastAttack))()
    
    -- โหลดสคริปต์ Auto Farm Level CCG
    local AutoFarmLevelCCG = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Auto%20Farm%20Level%20CCG.lua"
    loadstring(game:HttpGet(AutoFarmLevelCCG))()
    
    -- โหลดสคริปต์ Auto Farm Level Ghoul
    local AutoFarmLevelGhoul = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Auto%20Farm%20Level%20Ghoul.lua"
    loadstring(game:HttpGet(AutoFarmLevelGhoul))()
    
    -- โหลดสคริปต์ Anti AFK
    local AntiAFK = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Anti%20AFK.lua"
    loadstring(game:HttpGet(AntiAFK))()
    
    -- โหลดสคริปต์ Monster Farm
    local MonsterFarm = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Monster%20Farm.lua"
    loadstring(game:HttpGet(MonsterFarm))()
    
    -- โหลดสคริปต์ Boss Farm Normal
    local BossFarmNormal = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Farm%20Boss%20Normal.lua"
    loadstring(game:HttpGet(BossFarmNormal))()
    
else
    -- ถ้าเปิดผิดแมพ ให้เตะผู้เล่นออกทันที
    game.Players.LocalPlayer:Kick("สคริปต์นี้ใช้ได้เฉพาะ Map | Kanom Tokyo")
end
