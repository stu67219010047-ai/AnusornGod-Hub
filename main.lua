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
      Key = {"112523"} 
   }
})

-- [[ ตั้งค่าระบบ ]]
local AimSettings = {
    Enabled = false,
    Mode = "คลิกขวา", -- ค่าเริ่มต้น
    Smoothness = 0.1,
    FOV = 150,
    ShowFOV = true,
    TargetPart = "Head",
    TeamCheck = true
}

local LP = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LP:GetMouse()

-- [[ วงกลม FOV ]]
local FOVCircle = Drawing.new("Circle")
FOVCircle.Thickness = 1
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Transparency = 0.5
FOVCircle.Visible = false

-- [[ ฟังก์ชันหาศัตรู ]]
local function GetClosestPlayer()
    local Target = nil
    local ShortestDistance = AimSettings.FOV
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild(AimSettings.TargetPart) and v.Character:FindFirstChild("Humanoid") then
            if v.Character.Humanoid.Health > 0 then
                local isTeammate = (v.Team ~= nil and v.Team == LP.Team) or (v.TeamColor == LP.TeamColor)
                if not AimSettings.TeamCheck or not isTeammate then
                    local Pos, OnScreen = Camera:WorldToViewportPoint(v.Character[AimSettings.TargetPart].Position)
                    if OnScreen then
                        local Distance = (Vector2.new(Pos.X, Pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).Magnitude
                        if Distance < ShortestDistance then
                            Target = v.Character[AimSettings.TargetPart]
                            ShortestDistance = Distance
                        end
                    end
                end
            end
        end
    end
    return Target
end

-- [[ ระบบล็อคเป้าทำงาน ]]
game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Visible = AimSettings.ShowFOV
    FOVCircle.Radius = AimSettings.FOV
    FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)

    if AimSettings.Enabled then
        local UIS = game:GetService("UserInputService")
        local IsPressed = false
        
        if AimSettings.Mode == "คลิกขวา" then
            IsPressed = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        else
            IsPressed = UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        end
        
        if IsPressed then
            local Target = GetClosestPlayer()
            if Target then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Target.Position), 1 - AimSettings.Smoothness)
            end
        end
    end
end)

-- [[ หน้าเมนู: ระบบต่อสู้ ]]
local CombatTab = Window:CreateTab("ระบบต่อสู้", 4483362458)

CombatTab:CreateToggle({
   Name = "เปิดใช้งานระบบล็อคเป้า",
   CurrentValue = false,
   Callback = function(v) AimSettings.Enabled = v end,
})

CombatTab:CreateDropdown({
   Name = "เลือกปุ่มล็อคเป้า",
   Options = {"คลิกซ้าย", "คลิกขวา"},
   CurrentOption = "คลิกขวา",
   Callback = function(Option)
      AimSettings.Mode = Option[1]
   end,
})

CombatTab:CreateSlider({
   Name = "ความเนียน (0 = แรงมาก)",
   Range = {0, 0.9},
   Increment = 0.05,
   CurrentValue = 0.1,
   Callback = function(v) AimSettings.Smoothness = v end,
})

CombatTab:CreateSlider({
   Name = "ระยะล็อค (FOV)",
   Range = {0, 1000},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(v) AimSettings.FOV = v end,
})

-- [[ หน้าเมนู: โปรมอง (แก้ใหม่) ]]
local VisualTab = Window:CreateTab("โปรมอง", 4483362458)

VisualTab:CreateButton({
   Name = "เปิดใช้งานโปรมอง (ESP Boxes)",
   Callback = function()
      -- ใช้สคริปต์ ESP ตัวที่เสถียรสำหรับ Solara
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/SimpleESP.lua"))()
   end,
})

-- [[ หน้าเมนู: คำสั่งแอดมิน ]]
local AdminTab = Window:CreateTab("คำสั่งแอดมิน", 4483362458)
AdminTab:CreateButton({
   Name = "เปิด Infinite Yield",
   Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end,
})

-- [[ หน้าเมนู: ตัวละคร ]]
local PlayerTab = Window:CreateTab("ตัวละคร", 4483362458)
PlayerTab:CreateSlider({
   Name = "ความเร็ววิ่ง",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v) if LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.WalkSpeed = v end end,
})
