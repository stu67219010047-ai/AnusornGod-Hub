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
      -- ลบส่วน Note ออกเรียบร้อยแล้ว
      FileName = "AnusornKey",
      SaveKey = false, 
      Key = {"112523"} 
   }
})

-- [[ แท็บที่ 1: ระบบล็อคเป้า ]]
local CombatTab = Window:CreateTab("ระบบล็อคเป้า", 4483362458)
local AimSettings = { Enabled = false, Mode = "คลิกขวา", Smoothness = 0.1, FOV = 150, TargetPart = "Head" }

CombatTab:CreateToggle({
   Name = "เปิดใช้งานระบบล็อคเป้า",
   CurrentValue = false,
   Callback = function(Value) AimSettings.Enabled = Value end,
})

CombatTab:CreateDropdown({
   Name = "โหมดล็อค",
   Options = {"คลิกขวา", "กดยิง"},
   CurrentOption = "คลิกขวา",
   Callback = function(Option) AimSettings.Mode = Option[1] end,
})

-- [[ แท็บที่ 2: โปรมอง & ออร่า ]]
local TrollTab = Window:CreateTab("โปรมอง & ออร่า", 4483362458)

TrollTab:CreateButton({
   Name = "เปิดโปรมอง (ESP)",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/ic3w0lf22/Unnamed-ESP/master/Main.lua"))()
   end,
})

TrollTab:CreateToggle({
   Name = "ออร่าฆ่า (Kill Aura)",
   CurrentValue = false,
   Callback = function(Value)
      _G.Aura = Value
      while _G.Aura do
         pcall(function()
            for _, v in pairs(game.Players:GetPlayers()) do
               if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                  local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                  if dist < 25 then
                     local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                     if tool then tool:Activate() end
                  end
               end
            end
         end)
         task.wait(0.1)
      end
   end,
})

-- [[ แท็บที่ 3: ตัวละคร ]]
local PlayerTab = Window:CreateTab("ตัวละคร", 4483362458)

PlayerTab:CreateSlider({
   Name = "ความเร็ววิ่ง",
   Range = {16, 500},
   Increment = 1,
   CurrentValue = 16,
   Callback = function(v) 
      if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
         game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v 
      end
   end,
})
