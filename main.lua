local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "ANUSORNGOD HUB | SUPREME",
   LoadingTitle = "AnusornGod Edition",
   LoadingSubtitle = "by AnusornGod",
   ConfigurationSaving = { Enabled = true, FolderName = "AnusornGodConfig" },
   KeySystem = true,
   KeySettings = {
      Title = "ระบบสมาชิก AnusornGod",
      Subtitle = "กรุณาใส่รหัสผ่านเพื่อใช้งาน",
      Note = "รหัสคือ: 1234",
      FileName = "AnusornKey",
      SaveKey = true,
      Key = {"1234"}
   }
})

local MainTab = Window:CreateTab("เมนูหลัก", 4483362458)

MainTab:CreateButton({
   Name = "เปิดแอดมิน (Infinite Yield)",
   Description = "รวมคำสั่งแอดมินสารพัดประโยชน์ เช่น fly, noclip, view",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})

MainTab:CreateButton({
   Name = "ดีดทุกคน (Fling All)",
   Description = "ทำให้ทุกคนในเซิร์ฟเวอร์กระเด็นออกไป",
   Callback = function()
      loadstring(game:HttpGet("https://raw.githubusercontent.com/Technical-R00T/Simplescripts/main/Fling%20All"))()
   end,
})
