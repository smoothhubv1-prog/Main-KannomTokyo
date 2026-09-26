-- 1. ระบุไอดีแมพ (PlaceId) ที่คุณต้องการให้สคริปต์นี้ทำงาน
local TargetPlaceId = 71793674075007 -- **ให้เปลี่ยนเลขนี้เป็นไอดีแมพของคุณ**

-- 2. เช็คว่าไอดีแมพปัจจุบันตรงกับที่เรากำหนดไว้หรือไม่
if game.PlaceId == TargetPlaceId then
    
    -- ถ้าอยู่ในแมพที่ถูกต้อง ให้สั่งโหลดไฟล์และรันทำงานทันที
    local Set = "https://gist.githubusercontent.com/smoothhubv1-prog/8ce64aca1769bd8f60f796319d5f4309/raw/5595e36f9461f61d07500f6a7ce002596409e03f/UiKanom.lua"
    loadstring(game:HttpGet(Set))()
    local Set1 = "https://gist.githubusercontent.com/smoothhubv1-prog/1a95bdafc457df8f6daf3ca3ff01b37f/raw/9d25e154289d5b86cbc293520fb41d6bd74cb928/Fast%2520Attack%2520Kanom%2520tokyo.lua"
    loadstring(game:HttpGet(Set1))()
    
else
    -- ถ้าเปิดในแมพอื่น (แมพไม่ถูกต้อง) ให้เตะผู้เล่นออกทันทีพร้อมขึ้นข้อความแจ้ง
    game.Players.LocalPlayer:Kick("สคริปต์นี้ใช้ได้เฉพาะ Map | Kanom Tokyo ")
end
