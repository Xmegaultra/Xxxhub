-- XxxHub Auto Collect com GUI e delay
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

-- Estado do auto collect
local autoCollectOn = false

-- Criar GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "XxxHubGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = plr:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 250, 0, 120)
mainFrame.Position = UDim2.new(0.5, -125, 0.5, -60)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
mainFrame.Draggable = true

-- Título
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0, 30)
titleFrame.Position = UDim2.new(0, 0, 0, 0)
titleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
titleFrame.BorderSizePixel = 0
titleFrame.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -30, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "XxxHub"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextScaled = true
titleLabel.Parent = titleFrame

-- Botão fechar GUI
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -30, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextScaled = true
closeButton.Parent = titleFrame

local guiVisible = true
closeButton.MouseButton1Click:Connect(function()
    guiVisible = not guiVisible
    mainFrame.Visible = guiVisible
end)

-- Botão ON/OFF
local statusButton = Instance.new("TextButton")
statusButton.Size = UDim2.new(0, 60, 0, 30)
statusButton.Position = UDim2.new(0.5, -30, 0, 50)
statusButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
statusButton.Text = "OFF"
statusButton.TextColor3 = Color3.fromRGB(255, 255, 255)
statusButton.TextScaled = true
statusButton.Parent = mainFrame

statusButton.MouseButton1Click:Connect(function()
    autoCollectOn = not autoCollectOn
    if autoCollectOn then
        statusButton.Text = "ON"
        statusButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        statusButton.Text = "OFF"
        statusButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end
end)

-- Função para achar a pasta Collectors
local function getCollectors()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Collectors" then
            return obj
        end
    end
    return nil
end

-- Loop do auto collect com delay de 2 segundos
spawn(function()
    while true do
        task.wait(1)
        if autoCollectOn then
            local collectors = getCollectors()
            if collectors then
                for i = 1, 8 do
                    local collector = collectors:FindFirstChild(tostring(i))
                    if collector and collector:FindFirstChild("Hitbox") then
                        task.wait(2) -- espera 2 segundos antes de coletar cada Hitbox
                        local hitbox = collector.Hitbox
                        firetouchinterest(hrp, hitbox, 0)
                        firetouchinterest(hrp, hitbox, 1)
                    end
                end
            end
        end
    end
end)
