local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ANUSORNGOD HUB | SUPREME V4",
   LoadingTitle = "กำลังเปิดระบบโดย AnusornGod...",
   LoadingSubtitle = "เมนูภาษาไทยสำหรับสายเกรียน",
   ConfigurationSaving = { Enabled = true, FolderName = "AnusornGodConfig" },
   KeySystem = false,
   KeySettings = {
      Title = "ระบบสมาชิก AnusornGod",
      Subtitle = "รหัสคือ: 1234",
      Note = "ใส่รหัสเพื่อใช้งาน",
      FileName = "AnusornKey",
      SaveKey = false,
      Key = {"1234"}
   }
})

-- [[ ฟังก์ชันโปรมอง (ESP) แบบเขียนเอง ]]
local function CreateESP(Player)
    local Box = Drawing.new("Square")
    Box.Visible = false
    Box.Color = Color3.fromRGB(255, 0, 0)
    Box.Thickness = 2
    Box.Transparency = 1
    Box.Filled = false

    game:GetService("RunService").RenderStepped:Connect(function()
        if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") and _G.ESP_Enabled then
            local RootPart = Player.Character.HumanoidRootPart
            local Pos, OnScreen = workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position)
            if OnScreen then
                local Size = (workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position - Vector3.new(0, 3, 0)).Y - workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position + Vector3.new(0, 2.6, 0)).Y)
                Box.Size = Vector2.new(Size / 1.5, Size)
                Box.Position = Vector2.new(Pos.X - Box.Size.X / 2, Pos.Y - Box.Size.Y / 2)
                Box.Visible = true
            else
                Box.Visible = false
            end
        else
            Box.Visible = false
        end
    end)
end

-- [[ หน้าเมนู: โปรมอง ]]
local TrollTab = Window:CreateTab("โปรมอง & ออร่า", 4483362458)

TrollTab:CreateToggle({
   Name = "เปิดโปรมอง (ESP Box)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESP_Enabled = Value
      if Value then
          for _, p in pairs(game.Players:GetPlayers()) do
              if p ~= game.Players.LocalPlayer then CreateESP(p) end
          end
      end
   end,
})

TrollTab:CreateToggle({
   Name = "ออร่าฆ่า (Kill Aura)",
   CurrentValue = false,
   Callback = function(v)
      _G.Aura = v
      while _G.Aura do
         pcall(function()
            for _, p in pairs(game.Players:GetPlayers()) do
               if p ~= game.Players.LocalPlayer and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude < 25 then
                  local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                  if tool then tool:Activate() end
               end
            end
         end)
         task.wait(0.1)
      end
   end,
})

-- (ส่วนของสปีดและล็อคเป้าให้คงไว้ตามเดิมครับ)
