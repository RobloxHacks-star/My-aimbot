-- SEAN HUB PREMIUM: WHITELIST SYSTEM
local Player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")

-- THE MASTER LIST
local Whitelist = {
    [5176032828] = "Sean (Owner)", -- YOUR ID IS NOW ACTIVE
}

-- THE SECURITY CHECK
if not Whitelist[Player.UserId] then
    Player:Kick("\n\n💎 SEAN HUB PREMIUM 💎\n\nYou are not whitelisted!\nDM Sean to buy access.\nYour ID: " .. Player.UserId)
    return
end

-- UI CREATION (PROJECT REVERSE STYLE)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
local TopBar = Instance.new("Frame", MainFrame)
local Title = Instance.new("TextLabel", TopBar)

-- MAIN FRAME STYLING
MainFrame.Name = "ProjectReverseUI"
MainFrame.Size = UDim2.new(0, 450, 0, 320)
MainFrame.Position = UDim2.new(0.5, -225, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local Border = Instance.new("UIStroke", MainFrame)
Border.Color = Color3.fromRGB(160, 32, 240) -- Neon Purple
Border.Thickness = 2

-- TOP BAR
TopBar.Size = UDim2.new(1, 0, 0, 35)
TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 25)

Title.Size = UDim2.new(1, -10, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "PROJECT REVERSE // AUTH: " .. Whitelist[Player.UserId]
Title.TextColor3 = Color3.fromRGB(160, 32, 240)
Title.Font = Enum.Font.Code
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- BUTTON CREATOR FUNCTION
local function CreateButton(text, pos, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = pos
    btn.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.Code
    btn.TextSize = 14
    
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = Color3.fromRGB(60, 60, 80)
    
    btn.MouseButton1Click:Connect(callback)
end

-- FEATURE 1: LIGHTNING STEAL & AUTO-BASE
local stealing = false
CreateButton("⚡ LIGHTNING STEAL & SECURE", UDim2.new(0.05, 0, 0.2, 0), function()
    stealing = not stealing
    if stealing then
        game.StarterGui:SetCore("SendNotification", {Title = "Sean Hub", Text = "Instant Steal Active!", Duration = 2})
        task.spawn(function()
            while stealing do
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name:find("Dummy") or v.Name:find("Brainrot") then
                        local t = v:FindFirstChildWhichIsA("TouchTransmitter", true)
                        if t then
                            firetouchinterest(Player.Character.PrimaryPart, t.Parent, 0)
                            firetouchinterest(Player.Character.PrimaryPart, t.Parent, 1)
                        end
                    end
                end
                
                -- Check for item and TP to base
                if Player.Character:FindFirstChildOfClass("Tool") or Player.Backpack:FindFirstChildOfClass("Tool") then
                    local base = workspace:FindFirstChild(Player.Name .. "Base") or workspace:FindFirstChild("Bases"):FindFirstChild(Player.Name)
                    if base then
                        Player.Character.HumanoidRootPart.CFrame = base.PrimaryPart.CFrame
                        task.wait(0.5)
                    end
                end
                task.wait(0.01)
            end
        end)
    end
end)

-- FEATURE 2: PREVENT LEAVE (SCAMMER TRAP)
local trapping = false
CreateButton("⛔ PREVENT LEAVE (TRAP)", UDim2.new(0.05, 0, 0.4, 0), function()
    trapping = not trapping
    local msg = trapping and "Trap ON" or "Trap OFF"
    game.StarterGui:SetCore("SendNotification", {Title = "Sean Hub", Text = msg, Duration = 2})
end)

game:GetService("RunService").RenderStepped:Connect(function()
    if trapping and UIS:IsKeyDown(Enum.KeyCode.Escape) then
        Player.Character.HumanoidRootPart.Anchored = true
        task.wait(0.1)
        Player.Character.HumanoidRootPart.Anchored = false
    end
end)

print("Project Reverse Loaded. Welcome, Sean.")
