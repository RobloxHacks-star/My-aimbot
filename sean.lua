local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "SEAN HUB (UPDATE)",
   LoadingTitle = "Sean Hub",
   LoadingSubtitle = "by Gemini x Sean",
   ConfigurationSaving = { Enabled = false }
})

-- SETTINGS
_G.SilentAim = false
_G.TriggerBot = false
_G.MagicBullets = false
_G.Fly = false
_G.FOV = 200

-- TAB 1: COMBAT
local CombatTab = Window:CreateTab("Combat", 4483362458)

CombatTab:CreateSection("Killer Features")

CombatTab:CreateToggle({
   Name = "Silent Aim",
   CurrentValue = false,
   Callback = function(Value) _G.SilentAim = Value end,
})

CombatTab:CreateToggle({
   Name = "Magic Bullets (Wallbang)",
   CurrentValue = false,
   Callback = function(Value) _G.MagicBullets = Value end,
})

CombatTab:CreateToggle({
   Name = "Trigger Bot",
   CurrentValue = false,
   Callback = function(Value) _G.TriggerBot = Value end,
})

-- TAB 2: MOVEMENT
local MovementTab = Window:CreateTab("Movement", 4483362458)

MovementTab:CreateToggle({
   Name = "Fly Mode",
   CurrentValue = false,
   Callback = function(Value)
       _G.Fly = Value
       local lp = game.Players.LocalPlayer
       task.spawn(function()
           while _G.Fly do
               if lp.Character and lp.Character:FindFirstChild("HumanoidRootPart") then
                   lp.Character.HumanoidRootPart.Velocity = Vector3.new(0, 45, 0)
               end
               task.wait(0.1)
           end
       end)
   end,
})

MovementTab:CreateSlider({
   Name = "Speed Boost",
   Range = {16, 200}, Increment = 1, CurrentValue = 16,
   Callback = function(Value) 
       if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
           game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value 
       end
   end,
})

-- [INTERNAL LOGIC: SILENT AIM & MAGIC BULLETS]
local LP = game.Players.LocalPlayer
local Camera = workspace.CurrentCamera

local function GetTarget()
    local Target = nil
    local Dist = _G.FOV
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= LP and v.Character and v.Character:FindFirstChild("Head") then
            local Pos, OnScreen = Camera:WorldToScreenPoint(v.Character.Head.Position)
            if OnScreen then
                local Mag = (Vector2.new(Pos.X, Pos.Y) - game:GetService("UserInputService"):GetMouseLocation()).Magnitude
                if Mag < Dist then
                    Dist = Mag
                    Target = v
                end
            end
        end
    end
    return Target
end

local OldNC
OldNC = hookmetamethod(game, "__namecall", function(self, ...)
    local Method = getnamecallmethod()
    if (_G.SilentAim or _G.MagicBullets) and Method == "FindPartOnRayWithIgnoreList" then
        local T = GetTarget()
        if T then
            return T.Character.Head, T.Character.Head.Position, Vector3.new(0,1,0), Enum.Material.Plastic
        end
    end
    return OldNC(self, ...)
end)
