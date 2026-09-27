
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

_G.SmoothHubConfig = {
    FastAttack = false,
    AntiAFK = true,
    AutoFarmLevelGhoul = false,
	AutoFarmLevelCCG = false 
}


-- 1. สร้าง ScreenGui หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SmoothHub_CoreUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- 2. แถบแท็บแคปซูลใสสูงติดขอบหน้าจอ
local SideTogglePill = Instance.new("TextButton")
SideTogglePill.Name = "SideTogglePill"
SideTogglePill.Size = UDim2.new(0, 260, 0, 7)
SideTogglePill.Position = UDim2.new(0.5, -130, 0, -2)
SideTogglePill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SideTogglePill.BackgroundTransparency = 0.2
SideTogglePill.Text = ""
SideTogglePill.AutoButtonColor = false
SideTogglePill.Active = true
SideTogglePill.ZIndex = 100
SideTogglePill.Parent = ScreenGui

local PillCorner = Instance.new("UICorner")
PillCorner.CornerRadius = UDim.new(1, 0)
PillCorner.Parent = SideTogglePill

local PillStroke = Instance.new("UIStroke")
PillStroke.Color = Color3.fromRGB(0, 122, 255)
PillStroke.Transparency = 0.3
PillStroke.Thickness = 1.5
PillStroke.Parent = SideTogglePill

-- แอนิเมชันตอนเมาส์ชี้
SideTogglePill.MouseEnter:Connect(function()
    TweenService:Create(SideTogglePill, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 300, 0, 11),
        Position = UDim2.new(0.5, -150, 0, -1),
        BackgroundTransparency = 0
    }):Play()
end)

-- แอนิเมชันตอนเมาส์ออก (ใส่ Comma แก้ไขจุด Error เรียบร้อยครับ)
SideTogglePill.MouseLeave:Connect(function()
    TweenService:Create(SideTogglePill, TweenInfo.new(0.2), {
        Size = UDim2.new(0, 260, 0, 7),
        Position = UDim2.new(0.5, -130, 0, -2), -- ใส่เครื่องหมายคอมมาตรงนี้แล้ว
        BackgroundTransparency = 0.2
    }):Play()
end)

-- 3. หน้าต่างหลักสไตล์ MacBook (MainWindow)
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0, 800, 0, 500)
MainWindow.Position = UDim2.new(0.5, -400, 0.5, -250)
MainWindow.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
MainWindow.BorderSizePixel = 0
MainWindow.ClipsDescendants = true
MainWindow.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainWindow

local MainShadow = Instance.new("UIStroke")
MainShadow.Color = Color3.fromRGB(200, 200, 200)
MainShadow.Thickness = 1
MainShadow.Parent = MainWindow

-- 4. แถบเมนูด้านซ้ายสไตล์ macOS (Sidebar - ความกว้าง 160)
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainWindow

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

local SidebarFix = Instance.new("Frame")
SidebarFix.Name = "SidebarFix"
SidebarFix.Size = UDim2.new(0, 20, 1, 0)
SidebarFix.Position = UDim2.new(1, -20, 0, 0)
SidebarFix.BackgroundColor3 = Color3.fromRGB(225, 225, 225)
SidebarFix.BorderSizePixel = 0
SidebarFix.ZIndex = 0
SidebarFix.Parent = Sidebar

-- 5. ปุ่มควบคุม 3 สีสไตล์ Mac
local WindowControls = Instance.new("Frame")
WindowControls.Name = "WindowControls"
WindowControls.Size = UDim2.new(0, 80, 0, 30)
WindowControls.Position = UDim2.new(0, 15, 0, 15)
WindowControls.BackgroundTransparency = 1
WindowControls.Parent = Sidebar

local ControlsLayout = Instance.new("UIListLayout")
ControlsLayout.FillDirection = Enum.FillDirection.Horizontal
ControlsLayout.SortOrder = Enum.SortOrder.LayoutOrder
ControlsLayout.Padding = UDim.new(0, 8)
ControlsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ControlsLayout.Parent = WindowControls

local controlColors = {
	Color3.fromRGB(255, 95, 86),
	Color3.fromRGB(255, 189, 46),
	Color3.fromRGB(39, 201, 63)
}

for i, btnColor in ipairs(controlColors) do
	local Circle = Instance.new("TextButton")
	Circle.Name = "Control_" .. i
	Circle.Size = UDim2.new(0, 14, 0, 14)
	Circle.BackgroundColor3 = btnColor
	Circle.BorderSizePixel = 0
	Circle.Text = ""
	Circle.Parent = WindowControls
	
	local CircleCorner = Instance.new("UICorner")
	CircleCorner.CornerRadius = UDim.new(1, 0)
	CircleCorner.Parent = Circle
	
	if i == 1 then
		Circle.MouseButton1Click:Connect(function()
			ScreenGui:Destroy()
		end)
	end
end

-- 6. พื้นที่เนื้อหาฝั่งขวา (Main Content Area)
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -160, 1, 0)
ContentArea.Position = UDim2.new(0, 160, 0, 0)
ContentArea.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainWindow

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 12)
ContentCorner.Parent = ContentArea

-- 7. แถบหัวข้อด้านบนฝั่งขวา (Top Bar Inside Content)
local TopHeader = Instance.new("Frame")
TopHeader.Name = "TopHeader"
TopHeader.Size = UDim2.new(1, 0, 0, 50)
TopHeader.BackgroundTransparency = 1
TopHeader.Parent = ContentArea

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 5)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
TitleLabel.TextYAlignment = Enum.TextYAlignment.Center
TitleLabel.Text = "SmoothHub"
TitleLabel.Parent = TopHeader

local SubtitleLabel = Instance.new("TextLabel")
SubtitleLabel.Size = UDim2.new(1, 0, 0, 15)
SubtitleLabel.Position = UDim2.new(0, 0, 0, 28)
SubtitleLabel.BackgroundTransparency = 1
SubtitleLabel.Font = Enum.Font.SourceSans
SubtitleLabel.TextSize = 12
SubtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
SubtitleLabel.TextXAlignment = Enum.TextXAlignment.Center
SubtitleLabel.TextYAlignment = Enum.TextYAlignment.Center
SubtitleLabel.Text = "Kanom Tokyo"
SubtitleLabel.Parent = TopHeader

local Divider = Instance.new("Frame")
Divider.Name = "Divider"
Divider.Size = UDim2.new(1, -40, 0, 1)
Divider.Position = UDim2.new(0, 20, 0, 50)
Divider.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
Divider.BorderSizePixel = 0
Divider.Parent = ContentArea

-- 8. พื้นที่เปล่าด้านล่างสำหรับใส่สคริปต์/ปุ่มฟังก์ชัน
local PageContainer = Instance.new("Frame")
PageContainer.Name = "PageContainer"
PageContainer.Size = UDim2.new(1, -40, 1, -70)
PageContainer.Position = UDim2.new(0, 20, 0, 60)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = ContentArea

-- ====================================================================
-- [ท่อนที่ 1] สร้าง ScrollingFrame สำหรับเก็บเมนูใน Sidebar (แถบซ้าย)
-- ====================================================================

local NavigationScroll = Instance.new("ScrollingFrame")
NavigationScroll.Name = "NavigationScroll"
-- ปรับสเกลให้แคบลงตามความกว้างแถบซ้าย 160 และเว้นพื้นที่ด้านบนหลบปุ่ม 3 สี
NavigationScroll.Size = UDim2.new(1, -16, 1, -60)
NavigationScroll.Position = UDim2.new(0, 8, 0, 50)
NavigationScroll.BackgroundTransparency = 1
NavigationScroll.BorderSizePixel = 0
NavigationScroll.ScrollBarThickness = 0
NavigationScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
NavigationScroll.Parent = Sidebar

-- ตัวควบคุมการจัดเรียงไอเทมในเมนูจากบนลงล่างอัตโนมัติ
local NavLayout = Instance.new("UIListLayout")
NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavLayout.Padding = UDim.new(0, 4) -- ระยะห่างระหว่างปุ่มเมนูแต่ละอัน
NavLayout.Parent = NavigationScroll

-- ขยายขอบเขตการขยับ Scroll ด้านซ้ายอัตโนมัติเมื่อมีปุ่มหรือหมวดหมู่เพิ่มขึ้น
NavLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	NavigationScroll.CanvasSize = UDim2.new(0, 0, 0, NavLayout.AbsoluteContentSize.Y + 15)
end)

-- ====================================================================
-- [ท่อนที่ 2] ฟังก์ชันสำหรับสร้างหัวข้อหมวดหมู่ (ตัวหนังสือสีจาง)
-- ====================================================================

local function CreateCategoryHeader(text, order)
	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, 0, 0, 25)
	Label.BackgroundTransparency = 1
	Label.Font = Enum.Font.SourceSansBold
	Label.TextSize = 12
	Label.TextColor3 = Color3.fromRGB(145, 145, 150) -- สีเทาจางสไตล์ Mac
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextYAlignment = Enum.TextYAlignment.Center
	Label.Text = "  " .. text
	Label.LayoutOrder = order
	Label.Parent = NavigationScroll
end

-- ====================================================================
-- [อัปเดตท่อนที่ 3] ฟังก์ชันสร้างหน้าเพจฝั่งขวา และ ปุ่มเมนูสลับหน้าเพจ (รองรับไฟล์ภาพอัปโหลด)
-- ====================================================================

local allMenuButtons = {} 

local function CreateNewPage(pageName)
	local NewPage = Instance.new("ScrollingFrame")
	NewPage.Name = pageName .. "Page"
	NewPage.Size = UDim2.new(1, 0, 1, 0)
	NewPage.BackgroundTransparency = 1
	NewPage.BorderSizePixel = 0
	NewPage.ScrollBarThickness = 0 
	NewPage.Visible = false
	NewPage.Parent = PageContainer
	
	local PageList = Instance.new("UIListLayout")
	PageList.SortOrder = Enum.SortOrder.LayoutOrder
	PageList.Padding = UDim.new(0, 10)
	PageList.Parent = NewPage
	
	PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		NewPage.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 20)
	end)
	
	return NewPage
end

local function SwitchTab(targetBtn, targetPage, subTitleText)
	for _, item in ipairs(allMenuButtons) do
		TweenService:Create(item.Btn, TweenInfo.new(0.15), {BackgroundTransparency = 1}):Play()
		item.Txt.TextColor3 = Color3.fromRGB(60, 60, 65)
		
		-- คืนค่าสีไอคอนเมนูอื่นที่ไม่ได้เลือกให้กลับเป็นสีฟ้าเรืองแสงตามธีมเดิม
		local imgIcon = item.Btn:FindFirstChild("MenuIcon")
		if imgIcon then
			TweenService:Create(imgIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(0, 122, 255)}):Play()
		end
		item.Page.Visible = false
	end
	
	TweenService:Create(targetBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(0, 122, 255)}):Play()
	targetBtn:FindFirstChildOfClass("TextLabel").TextColor3 = Color3.fromRGB(255, 255, 255)
	
	-- เปลี่ยนสีไอคอนที่กำลังเปิดใช้งานอยู่ให้กลายเป็นสีขาวล้วนเด่นชัด
	local activeIcon = targetBtn:FindFirstChild("MenuIcon")
	if activeIcon then
		TweenService:Create(activeIcon, TweenInfo.new(0.15), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
	end
	
	targetPage.Visible = true
	SubtitleLabel.Text = subTitleText
end

local function AddMenuButton(imageAssetId, text, order, targetPage, subTitleText, isDefault)
	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(1, 0, 0, 30)
	Button.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
	Button.BackgroundTransparency = isDefault and 0 or 1
	Button.BorderSizePixel = 0
	Button.Text = ""
	Button.LayoutOrder = order
	Button.Parent = NavigationScroll
	
	local ButtonCorner = Instance.new("UICorner")
	ButtonCorner.CornerRadius = UDim.new(0, 6)
	ButtonCorner.Parent = Button
	
	-- 🛠️ เสกโครงสร้างดึงรูปภาพประแจที่พี่อัปโหลดมาโชว์หน้าชื่อเมนูสไลด์บาร์
	local ImageIcon = Instance.new("ImageLabel")
	ImageIcon.Name = "MenuIcon"
	ImageIcon.Size = UDim2.new(0, 16, 0, 16)
	ImageIcon.Position = UDim2.new(0, 10, 0.5, -8)
	ImageIcon.BackgroundTransparency = 1
	ImageIcon.Image = imageAssetId -- ผูกลิงก์รับเลขอิดเมจไอดีจากสคริปต์ล่างสุด
	ImageIcon.ImageColor3 = isDefault and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(0, 122, 255)
	ImageIcon.Parent = Button
	
	local Label = Instance.new("TextLabel")
	Label.Size = UDim2.new(1, -36, 1, 0)
	Label.Position = UDim2.new(0, 34, 0, 0) -- ดันชื่อหลบไอคอนรูปภาพไปทางขวา
	Label.BackgroundTransparency = 1
	Label.Font = Enum.Font.SourceSansSemibold
	Label.TextSize = 14
	Label.TextColor3 = isDefault and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(60, 60, 65)
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextYAlignment = Enum.TextYAlignment.Center
	Label.Text = text
	Label.Parent = Button
	
	table.insert(allMenuButtons, {Btn = Button, Txt = Label, Page = targetPage})
	
	if isDefault then
		targetPage.Visible = true
		SubtitleLabel.Text = subTitleText
	end
	
	Button.MouseButton1Click:Connect(function()
		SwitchTab(Button, targetPage, subTitleText)
	end)
end

-- ====================================================================
-- [อัปเดตท่อนที่ 4] แพ็กเกจระบบสำเร็จรูปคลาสหลัก (SmoothHub Library)
-- ====================================================================

local SmoothHub = {}

function SmoothHub:CreateCategory(categoryName, layoutOrder)
	CreateCategoryHeader(categoryName, layoutOrder)
end

function SmoothHub:CreatePage(imageAssetId, pageMenuName, layoutOrder, subTitleDescription, isFirstPage)
	local NewCanvas = CreateNewPage(pageMenuName)
	AddMenuButton(imageAssetId, pageMenuName, layoutOrder, NewCanvas, subTitleDescription, isFirstPage)
	return NewPageClass(NewCanvas)
end



-- 3. ระบบโครงสร้างเพื่อทำให้หน้าเพจสามารถเสก Toggle ออกมาข้างในตัวมันเองได้ง่ายๆ
function NewPageClass(targetCanvas)
	local PageObj = {}
		-- ฟังก์ชันสำเร็จรูปสำหรับสั่งสร้าง "หมวดหมู่ย่อยในหน้าเพจฝั่งขวา"
		-- เพิ่มตัวแปร sectionEmoji เข้าไปข้างหน้าสุดในวงเล็บ
	function PageObj:CreateSection(sectionEmoji, sectionTitle, sectionDesc)
		-- 1. กรอบข้อความหัวข้อหมวดหมู่ย่อย
		local HeaderLabel = Instance.new("TextLabel")
		HeaderLabel.Name = sectionTitle .. "_Header"
		HeaderLabel.Size = UDim2.new(1, 0, 0, 22)
		HeaderLabel.BackgroundTransparency = 1
		HeaderLabel.Font = Enum.Font.SourceSansBold
		HeaderLabel.TextSize = 16
		HeaderLabel.TextColor3 = Color3.fromRGB(30, 30, 30)
		HeaderLabel.TextXAlignment = Enum.TextXAlignment.Left
		HeaderLabel.TextYAlignment = Enum.TextYAlignment.Center
		-- 🛠️ เปลี่ยนมาดึงค่าจากตัวแปรอิโมจิที่พี่กรอกเข้ามาตรงๆ แทนการล็อกตายตัวเรียบร้อยครับ
		HeaderLabel.Text = sectionEmoji .. " " .. sectionTitle 
		HeaderLabel.Parent = targetCanvas
		
		-- 2. ข้อความคำอธิบายหมวดหมู่ย่อยด้านล่าง
		local DescLabel = Instance.new("TextLabel")
		DescLabel.Name = sectionTitle .. "_Desc"
		DescLabel.Size = UDim2.new(1, 0, 0, 16)
		DescLabel.BackgroundTransparency = 1
		DescLabel.Font = Enum.Font.SourceSans
		DescLabel.TextSize = 13
		DescLabel.TextColor3 = Color3.fromRGB(130, 130, 135)
		DescLabel.TextXAlignment = Enum.TextXAlignment.Left
		DescLabel.TextYAlignment = Enum.TextYAlignment.Center
		DescLabel.Text = sectionDesc
		DescLabel.Parent = targetCanvas
	end


	-- ฟังก์ชันสำเร็จรูปในหน้าเพจ: ใช้สำหรับสั่งสร้าง "ปุ่มสวิตช์เปิด-ปิด (Toggle)" ยัดลงในเพจนี้
	function PageObj:CreateToggle(toggleName, toggleDesc, callback)
		local callback = callback or function() end
		local isToggled = false
		
		-- กรอบพื้นหลังของวิดเจ็ตสวิตช์ (Widget Container)
		local WidgetFrame = Instance.new("Frame")
		WidgetFrame.Name = toggleName .. "_Widget"
		WidgetFrame.Size = UDim2.new(1, 0, 0, 60)
		WidgetFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 247) -- สีขาวเทาสไตล์ Mac
		WidgetFrame.BorderSizePixel = 0
		WidgetFrame.Parent = targetCanvas -- บังคับยัดลงเฉพาะเพจที่สั่งสร้าง
		
		local WidgetCorner = Instance.new("UICorner")
		WidgetCorner.CornerRadius = UDim.new(0, 8)
		WidgetCorner.Parent = WidgetFrame
		
		-- ข้อความชื่อฟังก์ชัน (Toggle Title)
		local WidgetTitle = Instance.new("TextLabel")
		WidgetTitle.Size = UDim2.new(1, -100, 0, 22)
		WidgetTitle.Position = UDim2.new(0, 14, 0, 10)
		WidgetTitle.BackgroundTransparency = 1
		WidgetTitle.Font = Enum.Font.SourceSansBold
		WidgetTitle.TextSize = 14
		WidgetTitle.TextColor3 = Color3.fromRGB(50, 50, 50)
		WidgetTitle.TextXAlignment = Enum.TextXAlignment.Left
		WidgetTitle.TextYAlignment = Enum.TextYAlignment.Center
		WidgetTitle.Text = toggleName
		WidgetTitle.Parent = WidgetFrame
		
		-- คำอธิบายรายละเอียดฟังก์ชัน (Toggle Description)
		local WidgetDesc = Instance.new("TextLabel")
		WidgetDesc.Size = UDim2.new(1, -100, 0, 16)
		WidgetDesc.Position = UDim2.new(0, 14, 0, 32)
		WidgetDesc.BackgroundTransparency = 1
		WidgetDesc.Font = Enum.Font.SourceSans
		WidgetDesc.TextSize = 12
		WidgetDesc.TextColor3 = Color3.fromRGB(140, 140, 140)
		WidgetDesc.TextXAlignment = Enum.TextXAlignment.Left
		WidgetDesc.TextYAlignment = Enum.TextYAlignment.Center
		WidgetDesc.Text = toggleDesc
		WidgetDesc.Parent = WidgetFrame
		
		-- ปุ่มโครงสร้างสวิตช์ตัวนอก (Toggle Track)
		local ToggleFrame = Instance.new("TextButton")
		ToggleFrame.Name = "ToggleTrack"
-- เดิมกว้าง 42 สูง 24
ToggleFrame.Size = UDim2.new(0, 32, 0, 18) -- ปรับเป็น กว้าง 32 สูง 18 
ToggleFrame.Position = UDim2.new(1, -50, 0.5, -9) -- ขยับ Offset Y เป็น -9 ให้สมดุลกับความสูง 18

		ToggleFrame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
		ToggleFrame.BorderSizePixel = 0
		ToggleFrame.Text = ""
		ToggleFrame.AutoButtonColor = false
		ToggleFrame.Parent = WidgetFrame
		
		local ToggleCorner = Instance.new("UICorner")
		ToggleCorner.CornerRadius = UDim.new(1, 0)
		ToggleCorner.Parent = ToggleFrame
		
		-- ปุ่มวงกลมด้านในที่เลื่อนขยับได้ (Toggle Circle Node)
		local ToggleCircle = Instance.new("Frame")
		ToggleCircle.Name = "ToggleCircle"
ToggleCircle.Size = UDim2.new(0, 14, 0, 14) 
ToggleCircle.Position = UDim2.new(0, 2, 0.5, -7)
		ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ToggleCircle.BorderSizePixel = 0
		ToggleCircle.Parent = ToggleFrame
		
		local CircleCorner = Instance.new("UICorner")
		CircleCorner.CornerRadius = UDim.new(1, 0)
		CircleCorner.Parent = ToggleCircle
		
		-- แอนิเมชันเปิด/ปิดตอนกดคลิกสวิตช์
		ToggleFrame.MouseButton1Click:Connect(function()
			isToggled = not isToggled
			local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			
if isToggled then
    TweenService:Create(ToggleFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(0, 122, 255)}):Play()
    -- เดิมเลื่อนไปพิกัด 20
    TweenService:Create(ToggleCircle, tweenInfo, {Position = UDim2.new(0, 16, 0.5, -7)}):Play() -- เปลี่ยนจาก 20 เป็น 16 และ Y เป็น -7
else
    TweenService:Create(ToggleFrame, tweenInfo, {BackgroundColor3 = Color3.fromRGB(200, 200, 200)}):Play()
    -- เดิมเลื่อนกลับมาพิกัด 2
    TweenService:Create(ToggleCircle, tweenInfo, {Position = UDim2.new(0, 2, 0.5, -7)}):Play() -- เปลี่ยนค่า Y เป็น -7 เหมือนเดิม
end

			
			-- ยิงฟังก์ชัน Callback ออกไปรันสคริปต์แบบเรียลไทม์
			task.spawn(function()
				callback(isToggled)
			end)
		end)
	end
	
	return PageObj
end

-- ====================================================================
-- 9. ระบบลากหน้าต่างขั้นเทพ (Fixed Smooth Drag)
-- ====================================================================
local dragging = false
local dragInput = nil
local dragStart = nil
local startPos = nil

local function update(input)
	local delta = input.Position - dragStart
	local targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	local tweenInfo = TweenInfo.new(0.06, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService:Create(MainWindow, tweenInfo, {Position = targetPos}):Play()
end

MainWindow.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainWindow.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

MainWindow.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- ====================================================================
-- 10. ระบบพับ/กางหน้าต่างจากปุ่มขอบบน
-- ====================================================================
local isOpened = true
local isTweening = false
local savedSize = MainWindow.Size
local savedPosition = MainWindow.Position

SideTogglePill.MouseButton1Click:Connect(function()
    if isTweening then return end
    isTweening = true
    
    if isOpened then
        savedSize = MainWindow.Size
        savedPosition = MainWindow.Position
        isOpened = false
        
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        local tween = TweenService:Create(MainWindow, tweenInfo, {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(savedPosition.X.Scale, savedPosition.X.Offset + (savedSize.X.Offset / 2), savedPosition.Y.Scale, savedPosition.Y.Offset + (savedSize.Y.Offset / 2)),
            BackgroundTransparency = 1
        })
        tween:Play()
        tween.Completed:Wait()
        MainWindow.Visible = false
    else
        MainWindow.Visible = true
        isOpened = true
        
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainWindow, tweenInfo, {
            Size = savedSize,
            Position = savedPosition,
            BackgroundTransparency = 0
        })
        tween:Play()
        tween.Completed:Wait()
    end
    isTweening = false
end)

print("SmoothHub UI Loaded Without Error!")
-- ====================================================================
-- วิธีเรียกใช้เสกหน้าจอ UI แบบสำเร็จรูป (เวอร์ชันเพิ่มหมวดหมู่ย่อยฝั่งขวา)
-- ====================================================================

SmoothHub:CreateCategory("IN GAME", 1)
SmoothHub:CreateCategory("SETTINGS", 3)

local MainFarmPage = SmoothHub:CreatePage("rbxassetid://95299401214721", "Main Farm", 2, "Main | Kanom Tokyo", true)
MainFarmPage:CreateSection("❄", "Automation Control", "Manage all automated systems and tasks.")

MainFarmPage:CreateToggle("Auto Farm Level | Ghoul  👹", "Automatically completes quests and defeats monsters to raise your level. (Recommended for Ghoul)", function(state)
	_G.SmoothHubConfig.AutoFarmLevelGhoul= state
end)

MainFarmPage:CreateToggle("Auto Farm Level | CCG  👔", "Automatically completes quests and defeats monsters to raise your level. (Recommended for CCG)", function(state)
	_G.SmoothHubConfig.AutoFarmLevelCCG= state
end)

MainFarmPage:CreateToggle("Fast Attack ", "An extremely fast attack system that hits much quicker than normal.", function(state)
	_G.SmoothHubConfig.FastAttack = state
end)
	
--
local AdvancedPage = SmoothHub:CreatePage("rbxassetid://79414333090948", "Advanced", 4, "Advanced | Kanom Tokyo", false)

AdvancedPage:CreateToggle("Anti-AFK System", "Prevent getting kicked after being AFK for 20 minutes.", function(state)
	_G.SmoothHubConfig.AntiAFK = state
end)
