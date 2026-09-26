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
   -- สรรสร้าง GUI แจ้งเตือนขึ้นกลางหน้าจอ (ดีไซน์โทนเทาตามสไตล์ SmoothHub)
    local CoreGui = game:GetService("CoreGui")
    
    -- ลบอันเก่าออกก่อนกันบักซ้ำซ้อน
    if CoreGui:FindFirstChild("SmoothHubWarningGui") then
        CoreGui.SmoothHubWarningGui:Destroy()
    end
    
    local sg = Instance.new("ScreenGui")
    sg.Name = "SmoothHubWarningGui"
    sg.Parent = CoreGui
    
    -- สร้างกรอบข้อความกลางจอ (โทนสีเทาเข้มแบบโมเดิร์น)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 180)
    frame.Position = UDim2.new(0.5, -200, 0.5, -90) -- ล็อคพิกัดไว้กึ่งกลางหน้าจอพอดีเป๊ะ
    frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    frame.BorderSizePixel = 0
    frame.Parent = sg
    
    -- ทำขอบมนให้ดูสวยงาม
    local corner = Instance.new("UICorner")
    corner.CornerRadius = URadius.new(0, 8)
    corner.Parent = frame
    
    -- ใส่เส้นขอบไฮไลท์สีฟ้าอ่อนๆ ให้ดูมีมิติ
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(85, 170, 255)
    stroke.Thickness = 2
    stroke.Parent = frame
    
    -- หัวข้อ Title Bar
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    title.Text = "  SmoothHub System"
    title.TextColor3 = Color3.fromRGB(255, 85, 85) -- ตัวอักษรหัวข้อสีแดงเตือน
    title.TextSize = 18
    title.Font = Enum.Font.SourceSansBold
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.Parent = frame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = URadius.new(0, 8)
    titleCorner.Parent = title
    
    -- เนื้อหาแจ้งเตือนหลัก
    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1, -20, 0, 60)
    msg.Position = UDim2.new(0, 10, 0, 50)
    msg.BackgroundTransparency = 1
    msg.Text = "SmoothHub สคริปต์นี้\nใช้ได้เฉพาะแมพ Kanom Tokyo เท่านั้น!"
    msg.TextColor3 = Color3.fromRGB(230, 230, 230)
    msg.TextSize = 16
    msg.Font = Enum.Font.SourceSansSemibold
    msg.Parent = frame
    
    -- ปุ่มกดรับทราบเพื่อปิดหน้าต่าง
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 120, 0, 35)
    btn.Position = UDim2.new(0.5, -60, 1, -45)
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.Text = "รับทราบ"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = frame
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = URadius.new(0, 6)
    btnCorner.Parent = btn
    
    -- เมื่อกดปุ่มให้ลบหน้าต่างนี้ทิ้งทันที
    btn.MouseButton1Click:Connect(function()
        sg:Destroy()
    end)
end

