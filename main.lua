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
      Key = {"250523"} 
   }
})

-- [[ ระบบล็อคเป้า (Hard Lock & Team Check) ]]
local AimSettings = { Enabled = false, Mode = "คลิกขวา", Smoothness = 0.01, FOV = 400 }
local LP = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LP:GetMouse()

local function GetClosestEnemy()
    local Target = nil
    local ShortestDistance = AimSettings.FOV
    
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("Head") and v.Character:FindFirstChild("Humanoid") then
            -- เช็คว่าตายหรือยัง
            if v.Character.Humanoid.Health <= 0 then continue end
            
            -- [[ ระบบเช็คทีมแบบแม่นยำ ]]
            local isTeammate = false
            if v.Team ~= nil and LP.Team ~= nil then
                if v.Team == LP.Team then isTeammate = true end
            elseif v.TeamColor == LP.TeamColor then
                isTeammate = true
            end
            
            if not isTeammate then
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
            local Target = GetClosestEnemy()
            if Target then
                -- ล็อคเข้าหัวแบบรวดเร็ว
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Target.Position), 1 - AimSettings.Smoothness)
            end
        end
    end
end)

-- [[ หน้าเมนู ]]
local CombatTab = Window:CreateTab("ระบบต่อสู้", 4483362458)
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

local TrollTab = Window:CreateTab("โปรมอง & ออร่า", 4483362458)
TrollTab:CreateButton({ Name = "เปิดโปรมอง (ESP)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/Main.lua"))() end })

local PlayerTab = Window:CreateTab("ตัวละคร", 4483362458)
PlayerTab:CreateSlider({
   Name = "ความเร็ววิ่ง",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v) if LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid.WalkSpeed = v end end,
})
