local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RotatingDecal"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local imageLabel = Instance.new("ImageLabel")
imageLabel.Name = "DecalImage"
imageLabel.Size = UDim2.new(0, 150, 0, 150)
imageLabel.BackgroundTransparency = 1
imageLabel.Image = "rbxassetid://124553278896669"
imageLabel.Parent = screenGui

-- Spawn in the middle
imageLabel.Position = UDim2.new(0.5, -75, 0.5, -75)

-- Smooth tween to top right
local tweenInfo = TweenInfo.new(
    1.5,                    -- duration
    Enum.EasingStyle.Quad,  -- smooth easing
    Enum.EasingDirection.Out
)

local goal = { Position = UDim2.new(1, -170, 0, 20) }
local tween = TweenService:Create(imageLabel, tweenInfo, goal)
tween:Play()

-- Slow spin
local rotation = 0
local rotationSpeed = 45  -- degrees per second (nice and slow)

RunService.RenderStepped:Connect(function(deltaTime)
    rotation = rotation + (rotationSpeed * deltaTime)
    imageLabel.Rotation = rotation % 360
end)

--- Text Typewriter and Delete Effect ---

local textLabel = Instance.new("TextLabel")
textLabel.Name = "CreditText"
textLabel.Size = UDim2.new(0, 500, 0, 100)
textLabel.Position = UDim2.new(0.5, -250, 0.5, -50) -- Exactly in the center of the screen
textLabel.BackgroundTransparency = 1
textLabel.TextColor3 = Color3.new(1, 1, 1) -- White text
textLabel.TextSize = 48 -- Made the text size significantly bigger
textLabel.Text = ""
textLabel.Parent = screenGui

local fullText = "Scripted by NEX"
local typeSpeed = 0.1 
local deleteSpeed = 0.08 

-- List of fonts to rapidly cycle through
local fonts = {
    Enum.Font.SourceSansBold,
    Enum.Font.GothamBold,
    Enum.Font.Arcade,
    Enum.Font.Fantasy,
    Enum.Font.SciFi,
    Enum.Font.Cartoon,
    Enum.Font.PermanentMarker,
    Enum.Font.Bodoni,
    Enum.Font.Garamond
}

-- Typewriter effect with rapid font changes
task.spawn(function()
    for i = 1, #fullText do
        textLabel.Font = fonts[math.random(1, #fonts)] -- Pick a random font
        textLabel.Text = string.sub(fullText, 1, i)
        task.wait(typeSpeed)
    end
    
    -- Rapidly change fonts while the text is fully displayed
    local startTime = os.clock()
    while os.clock() - startTime < 1.5 do
        textLabel.Font = fonts[math.random(1, #fonts)]
        task.wait(0.05) -- Changes font every 0.05 seconds
    end
    
    -- Deleting effect with rapid font changes
    for i = #fullText - 1, 0, -1 do
        textLabel.Font = fonts[math.random(1, #fonts)]
        textLabel.Text = string.sub(fullText, 1, i)
        task.wait(deleteSpeed)
    end
    
    -- Completely clean up the text label when finished
    textLabel:Destroy()
    
    -- --- Execution fires right here after the intro text finishes ---
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Nexpulvia/random-ass-slop/refs/heads/main/Wings.lua"))()
    end)
    
    if not success then
        warn("Failed to load script: " .. tostring(err))
    end
end)
