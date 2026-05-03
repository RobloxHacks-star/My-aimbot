local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "thestart Hub | Universal",
   LoadingTitle = "Loading thestart Hub...",
   LoadingSubtitle = "by thestart",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "thestartHub"
   }
})

local MainTab = Window:CreateTab("Combat", 4483362458) -- Combat Icon

-- AIMBOT TOGGLE
MainTab:CreateToggle({
   Name = "Aimbot (Lock On)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AimbotEnabled = Value
      -- This is where the logic for the camera lock goes
   end,
})

local VisualsTab = Window:CreateTab("Visuals", 4483362458)

-- ESP TOGGLE
VisualsTab:CreateToggle({
   Name = "Player ESP (Boxes)",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESPEnabled = Value
      -- This is where the ESP box logic goes
   end,
})

Rayfield:Notify({
   Title = "Hub Loaded!",
   Content = "thestart Hub is ready for action.",
   Duration = 5,
   Image = 4483362458,
})
