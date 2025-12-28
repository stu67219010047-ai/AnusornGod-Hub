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
    Smoothness = 0.2, -- ยิ่งน้อยยิ่งล็อคแรง (0.1 = แรง, 0.9 = เนียนมาก)
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
FOVCircle.Filled = false
FOVCircle.Transparency = 0.5
FOVCircle.Visible = false

-- [[ ฟังก์ชันหาศัตรูที่ใกล้ที่สุด ]]
local function GetClosestPlayer()
    local Target = nil
    local ShortestDistance = AimSettings.FOV
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild(AimSettings.TargetPart) and v.Character:FindFirstChild("Humanoid") then
            if v.Character.Humanoid.Health > 0 then
                -- เช็คทีม
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
        if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then -- ล็อคเมื่อคลิกขวา
            local Target = GetClosestPlayer()
            if Target then
                local TargetPos = Camera:WorldToViewportPoint(Target.Position)
                local MousePos = Vector2.new(Mouse.X, Mouse.Y + 36)
                local LookAt = (Vector2.new(TargetPos.X, TargetPos.Y) - MousePos) * (1 - AimSettings.Smoothness)
                
                -- ล็อคแบบขยับกล้อง
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

CombatTab:CreateSlider({
   Name = "ความเนียน (น้อย = ล็อคแรง)",
   Range = {0.01, 0.9},
   Increment = 0.01,
   CurrentValue = 0.2,
   Callback = function(v) AimSettings.Smoothness = v end,
})

CombatTab:CreateSlider({
   Name = "ระยะล็อค (FOV)",
   Range = {0, 800},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(v) AimSettings.FOV = v end,
})

CombatTab:CreateToggle({
   Name = "แสดงวงกลม FOV",
   CurrentValue = true,
   Callback = function(v) AimSettings.ShowFOV = v end,
})

-- [[ หน้าเมนู: คำสั่งแอดมิน ]]
local AdminTab = Window:CreateTab("คำสั่งแอดมิน", 4483362458)
AdminTab:CreateButton({
   Name = "เปิดใช้งาน Infinite Yield",
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
