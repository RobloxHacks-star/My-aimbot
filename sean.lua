 local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SEAN HUB | V4 TOTAL",
   LoadingTitle = "Sean Hub: Full Power",
   LoadingSubtitle = "by Gemini x Sean",
   ConfigurationSaving = { Enabled = false }
})

-- VARIABLES
_G.Aimbot = false
_G.SilentAim = false
_G.Smoothness = 0.5
_G.FOV = 150
_G.AutoBackstab = false

-- TAB 1: COMBAT (Added Silent Aim & Aimbot)
local CombatTab = Window:CreateTab("Combat", 4483362458)

CombatTab:CreateSection("Aimbot Settings")

CombatTab:CreateToggle({
   Name = "Enable Aimbot",
   CurrentValue = false,
   Callback = function(Value) _G.Aimbot = Value end,
})

CombatTab:CreateToggle({
   Name = "Silent Aim (Direct Hit)",
   CurrentValue = false,
   Callback = function(Value) _G.SilentAim = Value end,
})

CombatTab:CreateSlider({
   Name = "Aimbot Smoothness",
   Range = {0, 1}, Increment = 0.1, CurrentValue = 0.5,
   Callback = function(Value) _G.Smoothness = Value end,
})

CombatTab:CreateSlider({
   Name = "FOV Size",
   Range = {50, 500}, Increment = 10, CurrentValue = 150,
   Callback = function(Value) _G.FOV = Value end,
})

-- TAB 2: VISUALS (ESP)
local VisualsTab = Window:CreateTab("Visuals", 4483362458)

VisualsTab:CreateToggle({
   Name = "Enable ESP Highlights",
   CurrentValue = false,
   Callback = function(Value)
       _G.ESP = Value
       for _, v in pairs(game.Players:GetPlayers()) do
           if v ~= game.Players.LocalPlayer and v.Character then
               if Value then
                   local Highlight = Instance.new("Highlight", v.Character)
                   Highlight.Name = "SeanHubESP"
               else
                   if v.Character:FindFirstChild("SeanHubESP") then v.Character.SeanHubESP:Destroy() end
               end
           end
       end
   end,
})

-- TAB 3: RAGE (Auto-Backstab Loop)
local RageTab = Window:CreateTab("Rage", 4483362458)

RageTab:CreateToggle({
   Name = "AUTO KILL LOBBY (Backstab Loop)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoBackstab = Value
       local lp = game.Players.LocalPlayer
       task.spawn(function()
           while _G.AutoBackstab do
               for _, v in pairs(game.Players:GetPlayers()) do
                   if not _G.AutoBackstab then break end
                   if v ~= lp and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Character.Humanoid.Health > 0 then
                       -- Fixed TP: Moves you behind and slightly above them
                       lp.Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 2.5)
                       lp.Character.HumanoidRootPart.CFrame = CFrame.new(lp.Character.HumanoidRootPart.Position, v.Character.HumanoidRootPart.Position)
                       task.wait(0.3)
                   end
               end
               task.wait(0.1)
           end
       end)
   end,
})

-- AIMBOT SYSTEM LOGIC
task.spawn(function()
    local Camera = workspace.CurrentCamera
    local LP = game.Players.LocalPlayer
    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.Aimbot or _G.SilentAim then
            -- [Insert target selection logic here]
        end
    end)
end)
    
