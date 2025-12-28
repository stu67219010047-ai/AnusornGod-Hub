local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ANUSORNGOD HUB | SUPREME V4",
   LoadingTitle = "กำลังเปิดระบบโดย AnusornGod...",
   LoadingSubtitle = "ยินดีต้อนรับ AnusornGod",
   ConfigurationSaving = { Enabled = true, FolderName = "AnusornGodConfig" },
   KeySystem = true,
   KeySettings = {
      Title = "ระบบสมาชิก AnusornGod",
      Subtitle = "กรุณาใส่รหัสผ่านเพื่อใช้งาน",
      FileName = "AnusornKey",
      SaveKey = false, 
      Key = {"Anusorn251123"} 
   }
})

-- [[ ระบบล็อคเป้าแบบโหด (Hard Lock Logic) ]]
-- ปรับ Smoothness เป็น 0.01 (ยิ่งน้อยยิ่งแรง) และ FOV เป็น 400 (กว้างขึ้น)
local AimSettings = { Enabled = false, Mode = "คลิกขวา", Smoothness = 0.01, FOV = 400 }
local LP = game.Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera

local function GetClosestPlayer()
    local Target = nil
    local ShortestDistance = AimSettings.FOV
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("Head") then
            -- เช็คทีม (Team Check) ถ้าอยู่ทีมเดียวกันจะไม่ล็อค
            if v.Team ~= LP.Team then
                local Pos, OnScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
                if OnScreen then
                    local Distance = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                    if Distance < ShortestDistance then
                        Target = v.Character.Head
                        ShortestDistance = Distance
                    end
                end
            end
        end
    end
    return Target
end

game:GetService("RunService").RenderStepped:Connect(function()
    if AimSettings.Enabled then
        local UIS = game:GetService("UserInputService")
        local IsPressed = (AimSettings.Mode == "คลิกขวา" and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)) or (AimSettings.Mode == "กดยิง" and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1))
        
        if IsPressed then
            local Target = GetClosestPlayer()
            if Target then
                -- ใช้ CFrame แบบตัดเข้าหัวทันที (ล็อคแรง)
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Target.Position), 1 - AimSettings.Smoothness)
            end
        end
    end
end)

-- [[ หน้าเมนู ]]
local CombatTab = Window:CreateTab("ระบบล็อคเป้า", 4483362458)
CombatTab:CreateToggle({
   Name = "เปิดใช้งานระบบล็อคเป้า",
   CurrentValue = false,
   Callback = function(v) AimSettings.Enabled = v end,
})
CombatTab:CreateDropdown({
   Name = "โหมดล็อค",
   Options = {"คลิกขวา", "กดยิง"},
   CurrentOption = "คลิกขวา",
   Callback = function(o) AimSettings.Mode = o[1] end,
})
-- เพิ่ม Slider ให้คุณปรับความแรงเองได้ในเกม
CombatTab:CreateSlider({
   Name = "ความแรงการล็อค (น้อย = แรง)",
   Range = {0, 1},
   Increment = 0.01,
   CurrentValue = 0.01,
   Callback = function(v) AimSettings.Smoothness = v end,
})

-- (หน้าเมนูอื่นๆ ESP และ ตัวละคร ให้คงไว้เหมือนเดิม)
-- [[ คัดลอกส่วน ESP และ ตัวละคร จากโค้ดก่อนหน้ามาใส่ตรงนี้ได้เลยครับ ]]
