--// Variáveis principais
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

--// Criando GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoCollectGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Painel principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 260, 0, 150)
MainFrame.Position = UDim2.new(0.5, -130, 0.5, -75)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "💰 Auto Collect"
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = MainFrame

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.TextColor3 = Color3.fromRGB(255,255,255)
CloseBtn.Parent = MainFrame

-- Botão abrir (inicialmente escondido)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 100, 0, 30)
OpenBtn.Position = UDim2.new(0.5, -50, 0.5, -15)
OpenBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
OpenBtn.Text = "Abrir GUI"
OpenBtn.Font = Enum.Font.SourceSansBold
OpenBtn.TextSize = 18
OpenBtn.TextColor3 = Color3.fromRGB(255,255,255)
OpenBtn.Visible = false
OpenBtn.Parent = ScreenGui

-- Indicador de status
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 25)
StatusLabel.Position = UDim2.new(0, 10, 0, 40)
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
StatusLabel.Text = "Auto-Collect: OFF"
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.TextSize = 16
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Parent = MainFrame

-- Botão toggle
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 120, 0, 35)
ToggleBtn.Position = UDim2.new(0.5, -60, 0, 70)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
ToggleBtn.Text = "Ligar Auto-Collect"
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16
ToggleBtn.TextColor3 = Color3.fromRGB(255,255,255)
ToggleBtn.Parent = MainFrame

-- Variável de controle
local autoCollectOn = false

-- Toggle função
ToggleBtn.MouseButton1Click:Connect(function()
    autoCollectOn = not autoCollectOn
    if autoCollectOn then
        StatusLabel.Text = "Auto-Collect: ON"
        ToggleBtn.Text = "Desligar Auto-Collect"
    else
        StatusLabel.Text = "Auto-Collect: OFF"
        ToggleBtn.Text = "Ligar Auto-Collect"
    end
end)

-- Função fechar/abrir GUI
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    OpenBtn.Visible = false
end)

-- Função auto-collect
local function collectMoney()
    for i, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("ClickDetector") then
            local distance = (player.Character.HumanoidRootPart.Position - obj.Parent.Position).Magnitude
            if distance < 15 then -- só pegar perto
                fireclickdetector(obj)
            end
        end
    end
end

-- Loop de coleta
RunService.RenderStepped:Connect(function()
    if autoCollectOn then
        collectMoney()
    end
end)
