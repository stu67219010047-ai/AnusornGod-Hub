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

-- [[ ระบบล็อคเป้า (Aimbot Logic) ]]
local AimSettings = { Enabled = false, Mode = "คลิกขวา", Smoothness = 0.15, FOV = 200 }
local LP = game.Players.LocalPlayer
local Mouse = LP:GetMouse()
local Camera = workspace.CurrentCamera

local function GetClosestPlayer()
    local Target = nil
    local ShortestDistance = AimSettings.FOV
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("Head") then
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
    return Target
end

game:GetService("RunService").RenderStepped:Connect(function()
    if AimSettings.Enabled then
        local UIS = game:GetService("UserInputService")
        local IsPressed = (AimSettings.Mode == "คลิกขวา" and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)) or (AimSettings.Mode == "กดยิง" and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1))
        
        if IsPressed then
            local Target = GetClosestPlayer()
            if Target then
                Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, Target.Position), AimSettings.Smoothness)
            end
        end
    end
end)

-- [[ หน้าเมนู 3 หน้า ]]
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

local TrollTab = Window:CreateTab("โปรมอง & ออร่า", 4483362458)
TrollTab:CreateButton({ Name = "เปิดโปรมอง (ESP)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/Main.lua"))() end })
TrollTab:CreateToggle({
   Name = "ออร่าฆ่า (Kill Aura)",
   CurrentValue = false,
   Callback = function(v)
      _G.Aura = v
      while _G.Aura do
         pcall(function()
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= LP and (LP.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < 25 then
                  local tool = LP.Character:FindFirstChildOfClass("Tool")
                  if tool then tool:Activate() end
               end
            end
         end)
         task.wait(0.1)
      end
   end,
})

local PlayerTab = Window:CreateTab("ตัวละคร", 4483362458)
PlayerTab:CreateSlider({
   Name = "ความเร็ววิ่ง",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v) LP.Character.Humanoid.WalkSpeed = v end,
})
