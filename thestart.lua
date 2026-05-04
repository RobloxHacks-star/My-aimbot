   local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SEAN HUB | RAGE UPDATE",
   LoadingTitle = "Loading Sean Hub Rage...",
   LoadingSubtitle = "by Gemini x Sean",
   ConfigurationSaving = { Enabled = false }
})

-- TAB 1: COMBAT
local CombatTab = Window:CreateTab("Combat", 4483362458)

_G.FOV = 150
local FOVCircle = Drawing.new("Circle")
FOVCircle.Visible = false
FOVCircle.Thickness = 2
FOVCircle.Color = Color3.fromRGB(255, 255, 255)
FOVCircle.Transparency = 1
FOVCircle.Filled = false

CombatTab:CreateToggle({
   Name = "Show FOV Circle",
   CurrentValue = false,
   Callback = function(Value)
       FOVCircle.Visible = Value
       task.spawn(function()
           local UIS = game:GetService("UserInputService")
           while FOVCircle.Visible do
               FOVCircle.Radius = _G.FOV
               FOVCircle.Position = UIS:GetMouseLocation()
               task.wait()
           end
       end)
   end,
})

CombatTab:CreateSlider({
   Name = "FOV Size",
   Range = {50, 500},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(Value) _G.FOV = Value end,
})

-- TAB 2: RAGE
local RageTab = Window:CreateTab("Rage", 4483362458)

RageTab:CreateSection("Movement")

RageTab:CreateToggle({
   Name = "Fly (Bypass Mode)",
   CurrentValue = false,
   Callback = function(Value)
       _G.Fly = Value
       local lp = game.Players.LocalPlayer
       task.spawn(function()
           while _G.Fly do
               if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                   lp.Character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0)
               end
               task.wait(0.1)
           end
       end)
   end,
})

RageTab:CreateSection("Kill Features")

RageTab:CreateButton({
   Name = "TP Behind & Knife (Arsenal)",
   Callback = function()
       local lp = game.Players.LocalPlayer
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
               lp.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
               task.wait(0.1)
           end
       end
       Rayfield:Notify({Title = "Sean Hub Rage", Content = "Backstab TP Executed!", Duration = 3})
   end,
})
                  
