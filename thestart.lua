local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "thestart Hub | Universal",
   LoadingTitle = "Loading thestart Hub...",
   LoadingSubtitle = "by thestart",
   ConfigurationSaving = { Enabled = true, FolderName = "thestartHub" }
})

-- VARIABLES
_G.AimbotEnabled = false
_G.ESPEnabled = false
local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- AIMBOT ENGINE (LEGIT/VISIBILITY VERSION)
local Smoothness = 0.15 

local function IsVisible(targetPart)
    local character = LocalPlayer.Character
    if not character then return false end
    
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = {character, targetPart.Parent} -- Ignore yourself and the target
    
    local origin = Camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    local ray = workspace:Raycast(origin, direction, params)
    
    return ray == nil -- If nil, nothing is in the way!
end

game:GetService("RunService").RenderStepped:Connect(function()
    if _G.AimbotEnabled then
        local closestPlayer = nil
        local shortestDistance = math.huge

        for _, v in pairs(Players:GetPlayers()) do
            if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Head") and v.Character.Humanoid.Health > 0 then
                local pos, onScreen = Camera:WorldToViewportPoint(v.Character.Head.Position)
                if onScreen then
                    -- ONLY LOCK IF THEY ARE VISIBLE
                    if IsVisible(v.Character.Head) then
                        local mousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                        local distance = (Vector2.new(pos.X, pos.Y) - mousePos).Magnitude
                        if distance < shortestDistance then
                            closestPlayer = v
                            shortestDistance = distance
                        end
                    end
                end
            end
        end

        if closestPlayer then
            local targetPos = closestPlayer.Character.Head.Position
            Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPos), Smoothness)
        end
    end
end)


-- SIMPLE ESP ENGINE
game:GetService("RunService").RenderStepped:Connect(function()
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
            if _G.ESPEnabled then
                if not v.Character:FindFirstChild("thestart_ESP") then
                    local highlight = Instance.new("Highlight")
                    highlight.Name = "thestart_ESP"
                    highlight.Parent = v.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
            else
                if v.Character:FindFirstChild("thestart_ESP") then
                    v.Character.thestart_ESP:Destroy()
                end
            end
        end
    end
end)

local MainTab = Window:CreateTab("Combat", 4483362458)

MainTab:CreateToggle({
   Name = "Hard Lock Aimbot (Head)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AimbotEnabled = Value
   end,
})

MainTab:CreateToggle({
   Name = "Player Highlight ESP",
   CurrentValue = false,
   Callback = function(Value)
      _G.ESPEnabled = Value
   end,
})

