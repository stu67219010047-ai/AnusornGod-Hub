local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ANUSORNGOD HUB | SUPREME V4 PRO",
   LoadingTitle = "กำลังเปิดระบบโดย AnusornGod...",
   LoadingSubtitle = "ยินดีต้อนรับ AnusornGod | Visual Update",
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

-- [[ ระบบการตั้งค่า ]]
local AimSettings = {
    Enabled = false,
    Mode = "คลิกขวา",
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

-- [[ วนลูปการทำงาน ]]
game:GetService("RunService").RenderStepped:Connect(function()
    FOVCircle.Visible = AimSettings.ShowFOV
    FOVCircle.Radius = AimSettings.FOV
    FOVCircle.Position = Vector2.new(Mouse.X, Mouse.Y + 36)

    if AimSettings.Enabled then
        local UIS = game:GetService("UserInputService")
        local IsPressed = (AimSettings.Mode == "คลิกขวา" and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)) or (AimSettings.Mode == "คลิกซ้าย" and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1))
        
        if IsPressed then
            local Target = GetClosestPlayer()
            if Target then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Target.Position), 1 - AimSettings.Smoothness)
            end
        end
    end
end)

-- [[ 1. แท็บระบบต่อสู้ ]]
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
   Callback = function(Option) AimSettings.Mode = Option[1] end,
})

CombatTab:CreateSlider({
   Name = "ความแรงการล็อค (0 = แรงที่สุด)",
   Range = {0, 0.95},
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

-- [[ 2. แท็บโปรมอง (Premium Visuals) ]]
local VisualTab = Window:CreateTab("โปรมอง (Visuals)", 4483362458)

VisualTab:CreateSection("— ฟังชั่น ESP —")

VisualTab:CreateButton({
   Name = "เปิดเมนูโปรมอง (UI สวย)",
   Callback = function()
      -- Unnamed ESP (หนึ่งใน ESP ที่ดีที่สุดและฟังก์ชันเยอะที่สุด)
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/Main.lua"))()
   end,
})

VisualTab:CreateSection("— ฟังชั่นเสริม —")

VisualTab:CreateButton({
   Name = "ส่องทะลุกำแพง (Highlight)",
   Callback = function()
       local function ApplyHighlight(v)
           if v:IsA("Player") and v ~= LP then
               v.CharacterAdded:Connect(function(char)
                   local h = Instance.new("Highlight", char)
                   h.FillColor = Color3.fromRGB(255, 0, 0)
               end)
               if v.Character then
                   local h = Instance.new("Highlight", v.Character)
                   h.FillColor = Color3.fromRGB(255, 0, 0)
               end
           end
       end
       for _, v in pairs(game.Players:GetPlayers()) do ApplyHighlight(v) end
       game.Players.PlayerAdded:Connect(ApplyHighlight)
   end,
})

-- [[ 3. แท็บคำสั่งแอดมิน ]]
local AdminTab = Window:CreateTab("คำสั่งแอดมิน", 4483362458)
AdminTab:CreateButton({
   Name = "เปิด Infinite Yield",
   Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))() end,
})

-- [[ 4. แท็บตัวละคร ]]
local PlayerTab = Window:CreateTab("ตัวละคร", 4483362458)
PlayerTab:CreateSlider({
   Name = "ความเร็ววิ่ง",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v) if LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.WalkSpeed = v end end,
})
