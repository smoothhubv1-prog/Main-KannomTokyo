-- 1. ระบุไอดีแมพ (PlaceId) ที่คุณต้องการให้สคริปต์นี้ทำงาน
local TargetPlaceId = 71793674075007 -- **ให้เปลี่ยนเลขนี้เป็นไอดีแมพของคุณ**

-- 2. เช็คว่าไอดีแมพปัจจุบันตรงกับที่เรากำหนดไว้หรือไม่
if game.PlaceId == TargetPlaceId then
    
    -- ถ้าอยู่ในแมพที่ถูกต้อง ให้สั่งโหลดไฟล์และรันทำงานทันที
    local Ui = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Ui.lua"
    loadstring(game:HttpGet(Ui))()
    local FastAttack = "https://raw.githubusercontent.com/smoothhubv1-prog/Main-KannomTokyo/refs/heads/main/Fast%20Attack.lua"
    loadstring(game:HttpGet(FastAttack))()
    
else
 -- แสดงกล่องแจ้งเตือนขึ้นที่มุมขวาล่างของหน้าจอเกม
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "SmoothHub Warning!",
        Text = "SmoothHub สคิปนี้ใช้ได้เฉพาะแมพ Kanom Tokyo",
        Duration = 5 -- ให้ข้อความโชว์ค้างไว้ 5 วินาที
    })
end


