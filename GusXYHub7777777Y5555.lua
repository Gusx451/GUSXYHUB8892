-- GusXY Hub By The_GusX - Flee the Facility (Delta + Never Fail + ESP Otimizado)
repeat task.wait() until game:IsLoaded()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
repeat task.wait() until LocalPlayer and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- GUI
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "GusXYHub"
gui.ResetOnSpawn = false

-- Som de abertura
local sound = Instance.new("Sound", workspace)
sound.SoundId = "rbxassetid://131169447699141"
sound.Volume = 2
sound:Play()
task.delay(5, function() sound:Destroy() end)

-- Botão abrir
local openBtn = Instance.new("ImageButton", gui)
openBtn.Size = UDim2.new(0, 64, 0, 64)
openBtn.Position = UDim2.new(0, 20, 0.5, -32)
openBtn.Image = "rbxassetid://4418711723"
openBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 16)
openBtn.AutoButtonColor = false

-- Frame principal
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 650, 0, 400)
frame.Position = UDim2.new(0.5, -325, 0.5, -200)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.Visible = false
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 20)

-- Botão X
local closeXBtn = Instance.new("TextButton", frame)
closeXBtn.Size = UDim2.new(0, 30, 0, 30)
closeXBtn.Position = UDim2.new(1, -35, 0, 5)
closeXBtn.Text = "X"
closeXBtn.Font = Enum.Font.Gotham
closeXBtn.TextSize = 20
closeXBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
closeXBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
closeXBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    openBtn.Visible = true
end)

-- Menu lateral e páginas
local pages, humData = {}, {WalkSpeed = 16, SpeedEnabled = true}
local menu = Instance.new("Frame", frame)
menu.Size = UDim2.new(0, 150, 1, 0)
menu.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 20)
local function createPage(name)
    local page = Instance.new("Frame", frame)
    page.Name = name
    page.Position = UDim2.new(0, 150, 0, 0)
    page.Size = UDim2.new(1, -150, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    pages[name] = page
    return page
end
for _, name in ipairs({"Main", "Player", "ESP", "TP", "Tools", "Credits"}) do createPage(name) end
local function show(name) for k,v in pairs(pages) do v.Visible = (k == name) end end
show("Main")
for i, name in ipairs({"Main", "Player", "ESP", "TP", "Tools", "Credits"}) do
    local b = Instance.new("TextButton", menu)
    b.Size = UDim2.new(1, 0, 0, 50)
    b.Position = UDim2.new(0, 0, 0, (i - 1) * 50)
    b.Text = name
    b.Font = Enum.Font.Gotham
    b.TextSize = 16
    b.TextColor3 = Color3.fromRGB(100, 200, 255)
    b.BackgroundTransparency = 1
    b.MouseButton1Click:Connect(function() show(name) end)
end

-- Botão padrão
local function createBtn(parent, text, posY, callback)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 180, 0, 40)
    btn.Position = UDim2.new(0.5, -90, posY, 0)
    btn.Text = text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 16
    btn.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.MouseButton1Click:Connect(function() callback(btn) end)
    return btn
end

-- MAIN
createBtn(pages.Main, "Fechar Hub", 0.3, function()
    frame.Visible = false
    openBtn.Visible = true
end)
createBtn(pages.Main, "Shift Lock", 0.45, function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Shift-lock-perm-15576"))()
end)
createBtn(pages.Main, "Fly GUI", 0.6, function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-fly-gui-43717"))()
end)
local noclip = false
createBtn(pages.Main, "Noclip: OFF", 0.75, function(btn)
    noclip = not noclip
    btn.Text = "Noclip: " .. (noclip and "ON" or "OFF")
end)
RunService.Stepped:Connect(function()
    if noclip and LocalPlayer.Character then
        for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

-- PLAYER PAGE
local function toggleValue(label, key, posY)
    local btn = Instance.new("TextButton", pages.Player)
    btn.Size = UDim2.new(0, 280, 0, 30)
    btn.Position = UDim2.new(0.1, 0, posY, 0)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.TextColor3 = Color3.fromRGB(100, 200, 255)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = label .. ": ON"
    btn.MouseButton1Click:Connect(function()
        humData[key] = not humData[key]
        btn.Text = label .. ": " .. (humData[key] and "ON" or "OFF")
    end)
end

local function inputValue(label, key, default, posY)
    local lbl = Instance.new("TextLabel", pages.Player)
    lbl.Size = UDim2.new(0, 280, 0, 25)
    lbl.Position = UDim2.new(0.1, 0, posY, 0)
    lbl.Text = label .. ": " .. default
    lbl.TextColor3 = Color3.fromRGB(100, 200, 255)
    lbl.Font = Enum.Font.Gotham
    lbl.BackgroundTransparency = 1
    lbl.TextSize = 14

    local box = Instance.new("TextBox", pages.Player)
    box.Size = UDim2.new(0, 280, 0, 30)
    box.Position = UDim2.new(0.1, 0, posY + 0.07, 0)
    box.PlaceholderText = "Valor (padrão " .. default .. ")"
    box.TextColor3 = Color3.fromRGB(100, 200, 255)
    box.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    box.Font = Enum.Font.Gotham
    box.TextSize = 14
    box.ClearTextOnFocus = false

    box.FocusLost:Connect(function(enter)
        if enter then
            local v = tonumber(box.Text)
            if v and v > 0 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                humData[key] = v
                lbl.Text = label .. ": " .. v
            end
        end
    end)
end

inputValue("WalkSpeed", "WalkSpeed", 16, 0.05)
toggleValue("Speed", "SpeedEnabled", 0.4)
createBtn(pages.Player, "Resetar Velocidade", 1.0, function()
    humData = {WalkSpeed = 16, SpeedEnabled = true}
end)
LocalPlayer.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid")
    task.wait(0.3)
    char.Humanoid.WalkSpeed = humData.WalkSpeed
end)
RunService.Heartbeat:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if hum and humData.SpeedEnabled and hum.WalkSpeed ~= humData.WalkSpeed then
        hum.WalkSpeed = humData.WalkSpeed
    end
end)

-- ESP PLAYER E PC OTIMIZADO
local espPlayersOn, espPCOn = false, false
local highlights, pcBoxes = {}, {}

createBtn(pages.ESP, "ESP Player: OFF", 0.1, function(btn)
    espPlayersOn = not espPlayersOn
    btn.Text = "ESP Player: " .. (espPlayersOn and "ON" or "OFF")
end)
createBtn(pages.ESP, "ESP PC: OFF", 0.3, function(btn)
    espPCOn = not espPCOn
    btn.Text = "ESP PC: " .. (espPCOn and "ON" or "OFF")
end)
RunService.RenderStepped:Connect(function()
    for _, h in pairs(highlights) do if h then h:Destroy() end end
    highlights = {}
    if espPlayersOn then
        local beast = nil
        for _, p in pairs(Players:GetPlayers()) do
            if p.Team and p.Team.Name == "Beast" then beast = p.Name break end
        end
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local h = Instance.new("Highlight", p.Character)
                h.FillColor = (p.Name == beast) and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 255)
                h.FillTransparency = 0.5
                h.OutlineTransparency = 1
                table.insert(highlights, h)
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if not espPCOn then
        for _, b in pairs(pcBoxes) do for _, bb in pairs(b) do bb:Destroy() end end
        pcBoxes = {}
        return
    end
    for _, m in ipairs(workspace:GetDescendants()) do
        if m:IsA("Model") and m.Name == "ComputerTable" and not pcBoxes[m] then
            pcBoxes[m] = {}
            for _, p in pairs(m:GetDescendants()) do
                if p:IsA("BasePart") then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Adornee = p
                    box.AlwaysOnTop = true
                    box.Size = p.Size
                    box.ZIndex = 10
                    box.Transparency = 0.4
                    box.Color3 = Color3.fromRGB(100, 170, 255)
                    box.Parent = p
                    table.insert(pcBoxes[m], box)
                end
            end
        end
        local col = Color3.fromRGB(100,170,255)
        if m:FindFirstChild("Hacked") and m.Hacked.Value then col = Color3.fromRGB(0,255,0)
        elseif m:FindFirstChild("Spectate") and m.Spectate.Value then col = Color3.fromRGB(255,0,0) end
        if pcBoxes[m] then for _, b in pairs(pcBoxes[m]) do b.Color3 = col end end
    end
end)

-- TP
local tpBtns = {}
local function updateTP()
    for _, btn in pairs(tpBtns) do btn:Destroy() end
    tpBtns = {}
    local y = 10
    for _, p in ipairs(Players:GetPlayers()) do
        local b = Instance.new("TextButton", pages.TP)
        b.Size = UDim2.new(0, 280, 0, 30)
        b.Position = UDim2.new(0.5, -140, 0, y)
        b.Text = p.Name
        b.Font = Enum.Font.Gotham
        b.TextSize = 12
        b.TextColor3 = Color3.fromRGB(100, 200, 255)
        b.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        b.MouseButton1Click:Connect(function()
            local hrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp and myHRP then myHRP.CFrame = hrp.CFrame end
        end)
        table.insert(tpBtns, b)
        y = y + 35
    end
end
Players.PlayerAdded:Connect(updateTP)
Players.PlayerRemoving:Connect(updateTP)
updateTP()

-- TOOLS (Never Fail)
local toolsPage = pages.Tools
local neverFailToggle = false

local neverFailBtn = Instance.new("TextButton", toolsPage)
neverFailBtn.Size = UDim2.new(0, 180, 0, 40)
neverFailBtn.Position = UDim2.new(0, 20, 0, 20)
neverFailBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
neverFailBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
neverFailBtn.Font = Enum.Font.SourceSansBold
neverFailBtn.TextSize = 22
neverFailBtn.Text = "Never Fail: OFF"
neverFailBtn.MouseButton1Click:Connect(function()
    neverFailToggle = not neverFailToggle
    neverFailBtn.Text = "Never Fail: " .. (neverFailToggle and "ON" or "OFF")
end)

local hookSuccess = false
local success, err = pcall(function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local args = {...}
        if getnamecallmethod() == "FireServer" and args[1] == "SetPlayerMinigameResult" and neverFailToggle then
            args[2] = true
        end
        return old(self, unpack(args))
    end)
    setreadonly(mt, true)
    hookSuccess = true
end)
local function sendMinigameResult()
    if not neverFailToggle then return end
    local remoteEvent = ReplicatedStorage:FindFirstChild("SetPlayerMinigameResult")
    if remoteEvent and remoteEvent:IsA("RemoteEvent") then
        remoteEvent:FireServer(true)
    end
end
RunService.Heartbeat:Connect(function()
    if neverFailToggle and not hookSuccess then sendMinigameResult() end
end)

-- CREDITS
local credit = Instance.new("TextLabel", pages.Credits)
credit.Size = UDim2.new(1, 0, 0.5, 0)
credit.Position = UDim2.new(0, 0, 0, 0)
credit.BackgroundTransparency = 1
credit.TextColor3 = Color3.fromRGB(100, 200, 255)
credit.Font = Enum.Font.Gotham
credit.TextSize = 16
credit.Text = "Created by The_GusX\nGusXY Hub\nfor Flee the Facility"
credit.TextWrapped = true
credit.TextYAlignment = Enum.TextYAlignment.Top

local removeBtn = Instance.new("TextButton", pages.Credits)
removeBtn.Size = UDim2.new(0, 200, 0, 40)
removeBtn.Position = UDim2.new(0.5, -100, 0.6, 0)
removeBtn.Text = "REMOVE GUI"
removeBtn.Font = Enum.Font.Gotham
removeBtn.TextSize = 16
removeBtn.TextColor3 = Color3.fromRGB(255, 0, 0)
removeBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
removeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Abrir GUI
openBtn.MouseButton1Click:Connect(function()
    frame.Visible = true
    openBtn.Visible = false
end)