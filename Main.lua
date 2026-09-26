-- 1. ระบุไอดีแมพ (PlaceId) ที่คุณต้องการให้สคริปต์นี้ทำงาน
local TargetPlaceId = 71793674875007 

-- 2. เช็คว่าไอดีแมพปัจจุบันตรงกับที่ตั้งไว้ไหม
if game.PlaceId == TargetPlaceId then
    
    -- โหลดสคริปต์ UI (ตัดเลขขยะสั้นลงแล้ว)
    local Ui = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Ui.lua"
    loadstring(game:HttpGet(Ui))()
    
    -- โหลดสคริปต์ Fast Attack (ตัดเลขขยะสั้นลงแล้ว และแก้เรียกตัวแปร rawUrl1)
    local FastAttack = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Fast%20Attack.lua"
    loadstring(game:HttpGet(FastAttack))()
    
else
    -- ถ้าเปิดผิดแมพ ให้เตะผู้เล่นออกทันที
    game.Players.LocalPlayer:Kick("สคริปต์นี้ใช้ได้เฉพาะ Map | Kanom Tokyo")
end
