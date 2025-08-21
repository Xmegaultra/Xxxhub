--// Auto Coletar Dinheiro Rápido - KRNL (OFF/ON)
--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoMoneyGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 100)
Frame.Position = UDim2.new(0.5, -125, 0.5, -50)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 100, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -50, 0.5, -20)
ToggleButton.Text = "OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255,255,255)
ToggleButton.Parent = Frame

local Enabled = false
ToggleButton.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    if Enabled then
        ToggleButton.Text = "ON"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        ToggleButton.Text = "OFF"
        ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

--// Função de Teleporte Instantâneo
local function TeleportTo(part)
    if part and part.Position then
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(part.Position + Vector3.new(0,3,0))
        end
    end
end

--// Loop de coleta ultra rápido
spawn(function()
    while true do
        game:GetService("RunService").RenderStepped:Wait() -- Mais rápido que wait()
        if Enabled then
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name:match("Button") and v.BrickColor == BrickColor.new("Bright green") then
                    TeleportTo(v)
                end
            end
        end
    end
end)
