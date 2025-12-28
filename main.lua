local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ANUSORNGOD HUB | SUPREME V4",
   LoadingTitle = "กำลังเปิดระบบโดย AnusornGod...",
   LoadingSubtitle = "เมนูภาษาไทยสำหรับสายเกรียน",
   ConfigurationSaving = { Enabled = true, FolderName = "AnusornGodConfig" },
   KeySystem = true,
   KeySettings = {
      Title = "ระบบสมาชิก AnusornGod",
      Subtitle = "ใส่รหัสเพื่อใช้งาน",
      Note = "รหัสคือ: 1234",
      FileName = "AnusornKey",
      SaveKey = false, -- ปิดการจำรหัส เพื่อให้ต้องใส่ใหม่ทุกรอบตามที่คุณต้องการ
      Key = {"1234"}
   }
})

-- [[ ตั้งค่า Aim ]]
local AimSettings = { Enabled = false, Mode = "คลิกขวา", Smoothness = 0.1, FOV = 150, TargetPart = "Head", TeamCheck = true }
local Camera = workspace.CurrentCamera
local LP = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- [[ ระบบคำนวณเป้าหมาย ]]
local function GetClosestTarget()
    local Target = nil
    local MaxDist = AimSettings.FOV
    local Center = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild(AimSettings.TargetPart) then
            if AimSettings.TeamCheck and v.Team == LP.Team then continue end
            local Pos, OnScreen = Camera:WorldToViewportPoint(v.Character[AimSettings.TargetPart].Position)
            if OnScreen then
                local Dist = (Vector2.new(Pos.X, Pos.Y) - Center).Magnitude
                if Dist < MaxDist then Target = v.Character[AimSettings.TargetPart] MaxDist = Dist end
            end
        end
    end
    return Target
end

game:GetService("RunService").RenderStepped:Connect(function()
    if AimSettings.Enabled then
        local ShouldAim = (AimSettings.Mode == "คลิกขวา" and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)) or (AimSettings.Mode == "กดยิง" and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1))
        if ShouldAim then
            local T = GetClosestTarget()
            if T then Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, T.Position), AimSettings.Smoothness) end
        end
    end
end)

-- [[ หน้าเมนู ]]
local CombatTab = Window:CreateTab("ระบบล็อคเป้า", 4483362458)
CombatTab:CreateToggle({ Name = "เปิดใช้งานระบบล็อคเป้า", CurrentValue = false, Callback = function(v) AimSettings.Enabled = v end })
CombatTab:CreateDropdown({ Name = "โหมดล็อค", Options = {"คลิกขวา", "กดยิง"}, CurrentOption = "คลิกขวา", Callback = function(o) AimSettings.Mode = o[1] end })

local TrollTab = Window:CreateTab("โปรมอง & ออร่า", 4483362458)
TrollTab:CreateButton({ Name = "เปิดโปรมอง (ESP)", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/Main.lua"))() end })
TrollTab:CreateToggle({ Name = "ออร่าฆ่า (Kill Aura)", CurrentValue = false, Callback = function(v)
    _G.Aura = v
    while _G.Aura do
        pcall(function()
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= LP and p.Character and (LP.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < 25 then
                    local tool = LP.Character:FindFirstChildOfClass("Tool")
                    if tool then tool:Activate() firetouchinterest(p.Character.HumanoidRootPart, tool.Handle, 0) firetouchinterest(p.Character.HumanoidRootPart, tool.Handle, 1) end
                end
            end
        end)
        task.wait(0.1)
    end
end })

local PlayerTab = Window:CreateTab("ตัวละคร", 4483362458)
PlayerTab:CreateSlider({ Name = "ความเร็ววิ่ง", Range = {16, 500}, Increment = 1, CurrentValue = 16, Callback = function(v) LP.Character.Humanoid.WalkSpeed = v end })
