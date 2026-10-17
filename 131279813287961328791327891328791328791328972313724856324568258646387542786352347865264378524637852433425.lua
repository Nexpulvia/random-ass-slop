--//====================================================\\--
--||			   CREATED BY SOURCE
--||      Dances integrated from Krystal Dance
--\\====================================================//--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

pcall(function()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
    StarterGui:SetCore("TopbarEnabled", false)
end)

local gui = Instance.new("ScreenGui")
gui.Name = "SourceIntro"
gui.DisplayOrder = 999
gui.Parent = playerGui

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 36)
bg.Position = UDim2.new(0, 0, 0, -36)
bg.BackgroundColor3 = Color3.new(0, 0, 0)
bg.BackgroundTransparency = 1
bg.BorderSizePixel = 0
bg.Parent = gui

local logoContainer = Instance.new("Frame")
logoContainer.Size = UDim2.new(0, 400, 0, 100)
logoContainer.AnchorPoint = Vector2.new(0.5, 0.5)
logoContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
logoContainer.BackgroundTransparency = 1
logoContainer.Parent = bg

local whiteLine = Instance.new("Frame")
whiteLine.Size = UDim2.new(0, 2, 0, 0)
whiteLine.Position = UDim2.new(0, 0, 0, 0)
whiteLine.BackgroundColor3 = Color3.new(1, 1, 1)
whiteLine.BorderSizePixel = 0
whiteLine.Parent = logoContainer

local blueLine = Instance.new("Frame")
blueLine.Size = UDim2.new(0, 0, 0, 2)
blueLine.Position = UDim2.new(0, 0, 1, -2)
blueLine.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
blueLine.BorderSizePixel = 0
blueLine.Parent = logoContainer

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0, 300, 1, 0)
textLabel.Position = UDim2.new(0, 30, 0, -10)
textLabel.BackgroundTransparency = 1

local fontSuccess = pcall(function() textLabel.Font = Enum.Font.SourceSans end)
if not fontSuccess then
    pcall(function() textLabel.Font = Enum.Font.Arial end)
end

textLabel.Text = ""
textLabel.TextColor3 = Color3.new(1, 1, 1)
textLabel.TextSize = 90
textLabel.TextXAlignment = Enum.TextXAlignment.Left
textLabel.Parent = logoContainer

local quoteLabel = Instance.new("TextLabel")
quoteLabel.Size = UDim2.new(0, 300, 0, 30)
quoteLabel.Position = UDim2.new(0, 32, 0, 105)
quoteLabel.BackgroundTransparency = 1

local quoteFontSuccess = pcall(function() quoteLabel.Font = Enum.Font.SourceSans end)
if not quoteFontSuccess then
    pcall(function() quoteLabel.Font = Enum.Font.Arial end)
end

quoteLabel.Text = ""
quoteLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
quoteLabel.TextSize = 24
quoteLabel.TextXAlignment = Enum.TextXAlignment.Left
quoteLabel.TextTransparency = 1
quoteLabel.Parent = logoContainer

local spinnerContainer = Instance.new("Frame")
spinnerContainer.Size = UDim2.new(0, 50, 0, 50)
spinnerContainer.Position = UDim2.new(1, 40, 0.5, -25)
spinnerContainer.BackgroundTransparency = 1
spinnerContainer.Visible = false 
spinnerContainer.Parent = logoContainer

local outerSquare = Instance.new("Frame")
outerSquare.Size = UDim2.new(1, 0, 1, 0)
outerSquare.AnchorPoint = Vector2.new(0.5, 0.5)
outerSquare.Position = UDim2.new(0.5, 0, 0.5, 0)
outerSquare.BackgroundColor3 = Color3.new(1, 1, 1)
outerSquare.BackgroundTransparency = 0
outerSquare.BorderSizePixel = 0
outerSquare.Parent = spinnerContainer

local innerSquare = Instance.new("Frame")
innerSquare.Size = UDim2.new(0.5, 0, 0.5, 0)
innerSquare.AnchorPoint = Vector2.new(0.5, 0.5)
innerSquare.Position = UDim2.new(0.5, 0, 0.5, 0)
innerSquare.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
innerSquare.BackgroundTransparency = 0
innerSquare.BorderSizePixel = 0
innerSquare.Parent = spinnerContainer

local function easeOut(alpha)
    return 1 - (1 - alpha) * (1 - alpha)
end

local function manualFade(instance, property, target, duration)
    local startValue = instance[property]
    local startTime = tick()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        local alpha = math.min(elapsed / duration, 1)
        local easedAlpha = easeOut(alpha)
        instance[property] = startValue + (target - startValue) * easedAlpha
        if alpha >= 1 then connection:Disconnect() end
    end)
end

local function manualTweenSize(instance, target, duration)
    local startValue = instance.Size
    local startTime = tick()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        local alpha = math.min(elapsed / duration, 1)
        local easedAlpha = easeOut(alpha)
        instance.Size = UDim2.new(
            startValue.X.Scale + (target.X.Scale - startValue.X.Scale) * easedAlpha,
            startValue.X.Offset + (target.X.Offset - startValue.X.Offset) * easedAlpha,
            startValue.Y.Scale + (target.Y.Scale - startValue.Y.Scale) * easedAlpha,
            startValue.Y.Offset + (target.Y.Offset - startValue.Y.Offset) * easedAlpha
        )
        if alpha >= 1 then connection:Disconnect() end
    end)
end

local function manualTweenPosition(instance, target, duration)
    local startValue = instance.Position
    local startTime = tick()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        local alpha = math.min(elapsed / duration, 1)
        local easedAlpha = easeOut(alpha)
        instance.Position = UDim2.new(
            startValue.X.Scale + (target.X.Scale - startValue.X.Scale) * easedAlpha,
            startValue.X.Offset + (target.X.Offset - startValue.X.Offset) * easedAlpha,
            startValue.Y.Scale + (target.Y.Scale - startValue.Y.Scale) * easedAlpha,
            startValue.Y.Offset + (target.Y.Offset - startValue.Y.Offset) * easedAlpha
        )
        if alpha >= 1 then connection:Disconnect() end
    end)
end

local function manualTweenRotation(instance, target, duration)
    local startValue = instance.Rotation
    local startTime = tick()
    local connection
    connection = RunService.RenderStepped:Connect(function()
        local elapsed = tick() - startTime
        local alpha = math.min(elapsed / duration, 1)
        local easedAlpha = easeOut(alpha)
        instance.Rotation = startValue + (target - startValue) * easedAlpha
        if alpha >= 1 then connection:Disconnect() end
    end)
end

spawn(function()
    manualFade(bg, "BackgroundTransparency", 0, 1)
    wait(1)

    logoContainer.Position = UDim2.new(0.5, 0, 0.5, -120) 
    logoContainer.Rotation = -15
    manualTweenPosition(logoContainer, UDim2.new(0.5, 0, 0.5, 0), 0.8)
    manualTweenRotation(logoContainer, 0, 0.8) 
    wait(1)

    manualTweenSize(whiteLine, UDim2.new(0, 2, 1, 0), 0.4)
    wait(0.3)

    manualTweenSize(blueLine, UDim2.new(1, 0, 0, 2), 0.5)
    wait(0.2)

    local word = "Source"
    for i = 1, #word do
        textLabel.Text = string.sub(word, 1, i)
        wait(0.06)
    end

    wait(0.4)

    spinnerContainer.Visible = true
    spinnerContainer.Size = UDim2.new(0, 0, 0, 0) 
    manualTweenSize(spinnerContainer, UDim2.new(0, 50, 0, 50), 0.3)
    wait(0.2)

    quoteLabel.TextTransparency = 0
    local quoteText = "Have fun with my script"
    for i = 1, #quoteText do
        quoteLabel.Text = string.sub(quoteText, 1, i)
        wait(0.04)
    end

    local spinConnection
    local floatConnection
    local isLoading = true 
    
    local spinSpeedOuter = 800 
    local spinSpeedInner = -1200
    
    spinConnection = RunService.RenderStepped:Connect(function(dt)
        local targetOuter = isLoading and 800 or 60
        local targetInner = isLoading and -1200 or -90
        
        spinSpeedOuter = spinSpeedOuter + (targetOuter - spinSpeedOuter) * dt * 2
        spinSpeedInner = spinSpeedInner + (targetInner - spinSpeedInner) * dt * 2
        
        outerSquare.Rotation = outerSquare.Rotation + (dt * spinSpeedOuter)
        innerSquare.Rotation = innerSquare.Rotation + (dt * spinSpeedInner)
    end)
    
    wait(1.5)
    isLoading = false 

    floatConnection = RunService.RenderStepped:Connect(function()
        local t = tick()
        
        local textX = math.cos(t * 2.5) * 4
        local textY = math.sin(t * 3.5) * 6
        local textRot = math.sin(t * 2) * 1.5
        textLabel.Position = UDim2.new(0, 30 + textX, 0, -10 + textY)
        textLabel.Rotation = textRot
        
        local quoteX = math.sin(t * 5) * 2
        local quoteY = math.cos(t * 4) * 3
        local quoteRot = math.sin(t * 7) * 1
        quoteLabel.Position = UDim2.new(0, 32 + quoteX, 0, 105 + quoteY)
        quoteLabel.Rotation = quoteRot
    end)

    wait(3)

    spinConnection:Disconnect()
    floatConnection:Disconnect()
    
    manualTweenPosition(logoContainer, UDim2.new(0.5, 0, 0.5, 150), 1)
    manualTweenRotation(logoContainer, 20, 1)
    
    manualFade(bg, "BackgroundTransparency", 1, 1.2)
    manualFade(textLabel, "TextTransparency", 1, 1)
    manualFade(quoteLabel, "TextTransparency", 1, 1)
    manualFade(whiteLine, "BackgroundTransparency", 1, 1)
    manualFade(blueLine, "BackgroundTransparency", 1, 1)
    
    spinnerContainer.Visible = false

    wait(1.5)
    
    pcall(function()
        StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
        StarterGui:SetCore("TopbarEnabled", true)
    end)
    
    gui:Destroy()
end)

wait(10.2)

local player = game:GetService("Players").LocalPlayer
local PlayerGui = player.PlayerGui
local run = game:GetService("RunService")
local world = workspace
local mouse = player:GetMouse()

local Character = player.Character
if not Character then Character = player.CharacterAdded:Wait() end

local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Torso = Character:WaitForChild("Torso")
local Head = Character:WaitForChild("Head")
local RightArm = Character:WaitForChild("Right Arm")
local LeftArm = Character:WaitForChild("Left Arm")
local RightLeg = Character:WaitForChild("Right Leg")
local LeftLeg = Character:WaitForChild("Left Leg")

local RootJoint = RootPart:WaitForChild("RootJoint")
local Neck = Torso:WaitForChild("Neck")
local RightShoulder = Torso:WaitForChild("Right Shoulder")
local LeftShoulder = Torso:WaitForChild("Left Shoulder")
local RightHip = Torso:WaitForChild("Right Hip")
local LeftHip = Torso:WaitForChild("Left Hip")
local ANIMATE = Character:FindFirstChild("Animate")

if ANIMATE then ANIMATE.Parent = nil end

local IT = Instance.new
local CF = CFrame.new
local VT = Vector3.new
local RAD = math.rad
local C3 = Color3.new
local UD2 = UDim2.new
local BRICKC = BrickColor.new
local ANGLES = CFrame.Angles
local COS = math.cos
local ACOS = math.acos
local SIN = math.sin
local MRANDOM = math.random

local Animation_Speed = 3
local SINE = 0
local CHANGE = 2 / Animation_Speed
local Speed = 23
local ATTACK = false
local Rooted = false
local HOLD = false
local WALKINGANIM = false
local WALK = 0
local ANIM = "Idle"

local ROOTC0 = CF(0, 0, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local NECKC0 = CF(0, 1, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))
local RIGHTSHOULDERC0 = CF(-0.5, 0, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
local LEFTSHOULDERC0 = CF(0.5, 0, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))

local possessed = nil
local possessedHum = nil
local possessedRoot = nil
local held = {}

local ghosts = {}
local spikesList = {}
local dummies = {}
local orbitParts = {}
local orbitState = "off"
local orbitTimer = 0
local seed = tick()
local timer = 0
local walkRippleTimer = 0
local INF_HEALTH = math.huge

local taunts = {
    "If i were a god i would kill you all.",
    "Gooby",
    "extra taunt idk",
    "I am the beginning and the end.",
    "You will be erased.",
    "Pathetic.",
    "Kneel before me."
}

local MAX_RANGE = 200
local TELEPORT_COOLDOWN = 2.5
local teleportCooldown = 0

local protectedParts = {
    HumanoidRootPart = true, Torso = true, UpperTorso = true, LowerTorso = true,
}

pcall(function() world.FallenPartsDestroyHeight = -100000 end)

local HUD_FONT
pcall(function() HUD_FONT = Enum.Font.Code end)
if not HUD_FONT then pcall(function() HUD_FONT = Enum.Font.Legacy end) end
if not HUD_FONT then pcall(function() HUD_FONT = Enum.Font.Arial end) end

-- ==== DANCE STATE (from Krystal Dance) ====
local activeDance = nil
local danceMusic = nil
local danceCount = 0
local danceCountspeed = 1
local danceAngle = 0
local danceGlobalWait = 0
local danceBarrel = nil
local danceSax = nil
local danceSandstorm = nil
local tacoSpawnTimer = 0

-- R6 rig defaults needed for Krystal's C1-based dance poses
local R6_LS_C0 = CF(-1, 0.5, 0) * ANGLES(0, -math.pi/2, 0)
local R6_RS_C0 = CF(1, 0.5, 0) * ANGLES(0, math.pi/2, 0)
local R6_LH_C0 = CF(-1, -1, 0) * ANGLES(0, -math.pi/2, 0)
local R6_RH_C0 = CF(1, -1, 0) * ANGLES(0, math.pi/2, 0)
local R6_LS_C1 = CF(0.5, 0.5, 0) * ANGLES(0, -math.pi/2, 0)
local R6_RS_C1 = CF(-0.5, 0.5, 0) * ANGLES(0, math.pi/2, 0)
local R6_LH_C1 = CF(-0.5, 1, 0) * ANGLES(0, -math.pi/2, 0)
local R6_RH_C1 = CF(0.5, 1, 0) * ANGLES(0, math.pi/2, 0)
local R6_NECK_C1 = CF(0, -0.5, 0) * ANGLES(-math.pi/2, 0, math.pi)
local R6_ROOT_C1 = CF(0, 0, 0) * ANGLES(-math.pi/2, 0, math.pi)

local danceDefs = {
    q = {name="canttouch", music=462759155},
    e = {name="party",     music=265803908},
    r = {name="jerk",      music=253539621},
    y = {name="spin",      music=516476380},
    u = {name="thriller",  music=481499264},
    i = {name="happy",     music=531545176},
    o = {name="barrel",    music=514479398},
    p = {name="sax",       music=376001218},
    v = {name="spooky",    music=147533205},
    h = {name="stride",    music=241814102},
    j = {name="shuffle",   music=533874013},
    k = {name="rock",      music=316168561},
    l = {name="gagnam",    music=229373816},
    b = {name="snoop",     music=238438433},
    x = {name="darude",    music=253846450},
    c = {name="taco",      music=249667133},
}

local function stopDance()
    if danceMusic and danceMusic.Parent then danceMusic:Destroy() end
    if danceBarrel and danceBarrel.Parent then danceBarrel:Destroy() end
    if danceSax and danceSax.Parent then danceSax:Destroy() end
    if danceSandstorm and danceSandstorm.Parent then danceSandstorm:Destroy() end
    danceMusic = nil
    danceBarrel = nil
    danceSax = nil
    danceSandstorm = nil
    activeDance = nil
end

local function startDance(key)
    local def = danceDefs[key]
    if not def then return end
    stopDance()
    activeDance = def
    danceCount = 0
    danceCountspeed = 1
    danceAngle = 0
    danceGlobalWait = 0
    tacoSpawnTimer = 0

    danceMusic = IT("Sound")
    danceMusic.SoundId = "rbxassetid://" .. def.music
    danceMusic.Volume = 1
    danceMusic.Looped = true
    danceMusic.Parent = Head
    danceMusic:Play()

    if def.name == "barrel" then
        local b = IT("Part")
        b.Name = "BarrelDance"
        b.Size = VT(2, 2, 1)
        b.BrickColor = BrickColor.new("Black")
        b.Transparency = 0
        b.CanCollide = false
        b.Anchored = false
        b.Material = Enum.Material.Plastic
        b.TopSurface = Enum.SurfaceType.Smooth
        b.BottomSurface = Enum.SurfaceType.Smooth
        local mesh = IT("SpecialMesh")
        mesh.MeshId = "rbxassetid://29873142"
        mesh.TextureId = "rbxassetid://31082268"
        mesh.Scale = VT(1.1, 0.8, 1.1)
        mesh.VertexColor = VT(1, 1, 1)
        mesh.Parent = b
        local w = IT("Motor6D")
        w.Part0 = b
        w.Part1 = Torso
        w.C0 = CF(0, 0, 0)
        w.C1 = CF(0, -0.2, 0)
        w.Parent = b
        b.Parent = Character
        danceBarrel = b
    end

    if def.name == "sax" then
        local s = IT("Part")
        s.Name = "SaxDance"
        s.Size = VT(1, 2, 2)
        s.BrickColor = BrickColor.new("Black")
        s.Transparency = 0
        s.CanCollide = false
        s.Anchored = false
        s.Material = Enum.Material.Plastic
        s.TopSurface = Enum.SurfaceType.Smooth
        s.BottomSurface = Enum.SurfaceType.Smooth
        local mesh = IT("SpecialMesh")
        mesh.MeshId = "rbxassetid://44410178"
        mesh.TextureId = "rbxassetid://44410320"
        mesh.Scale = VT(1.5, 1.5, 1.5)
        mesh.VertexColor = VT(1, 1, 1)
        mesh.Parent = s
        local w = IT("Motor6D")
        w.Part0 = s
        w.Part1 = LeftArm
        w.C0 = CF(0, 0, 0)
        w.C1 = CF(0.5, -0.9, -0.3) * ANGLES(math.pi/1.5, -math.pi/2, -math.pi/8)
        w.Parent = s
        s.Parent = Character
        danceSax = s
    end

    if def.name == "darude" then
        local ss = IT("Part")
        ss.Name = "SandDance"
        ss.Size = VT(1, 1, 1)
        ss.BrickColor = BrickColor.new("Black")
        ss.Transparency = 1
        ss.CanCollide = false
        ss.Anchored = false
        ss.Parent = Character
        local smoke = IT("Smoke")
        smoke.Color = Color3.new(255/255, 255/255, 175/255)
        smoke.Size = 0.4
        smoke.RiseVelocity = 3
        smoke.Opacity = 0.75
        smoke.Parent = ss
        local w = IT("Motor6D")
        w.Part0 = ss
        w.Part1 = Torso
        w.C0 = CF(0, 0, 0)
        w.C1 = CF(0, -2, 0)
        w.Parent = ss
        danceSandstorm = ss
    end
end

local function toggleDance(key)
    local def = danceDefs[key]
    if not def then return end
    if activeDance and activeDance.name == def.name then
        stopDance()
    else
        startDance(key)
    end
end

local function applyDancePoses()
    if not activeDance then return end

    danceCount = (danceCount % 100) + danceCountspeed
    danceAngle = math.pi * math.sin(math.pi*2/100*danceCount)
    danceCountspeed = 1

    LeftShoulder.C0  = R6_LS_C0
    RightShoulder.C0 = R6_RS_C0
    LeftHip.C0       = R6_LH_C0
    RightHip.C0      = R6_RH_C0
    Neck.C0          = NECKC0

    LeftShoulder.C1  = R6_LS_C1
    RightShoulder.C1 = R6_RS_C1
    LeftHip.C1       = R6_LH_C1
    RightHip.C1      = R6_RH_C1
    Neck.C1          = R6_NECK_C1
    RootJoint.C1     = R6_ROOT_C1

    local angle = danceAngle
    local name  = activeDance.name

    if name == "jerk" then
        danceCountspeed = 2
        LeftShoulder.C1  = CF(0, 0.5, -0.5) * ANGLES(angle/5, 0, angle/4)
        RightShoulder.C1 = CF(0, 0.5, -0.5) * ANGLES(angle/5, 0, -angle/4)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(angle/10, 0, angle/5)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(angle/10, 0, angle/5)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2 + angle/5, math.pi, 0)
        RootJoint.C0     = CF(0, 0, 0) * ANGLES(math.pi/2 + angle/5, math.pi, 0)
    elseif name == "party" then
        danceCountspeed = 4
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(angle/15, 0, angle/15)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(angle/15, 0, angle/15)
        LeftShoulder.C1  = CF(0.25, 0.5 + 1*angle/10, 0.5) * ANGLES(math.pi + angle/10, 0, angle/10)
        RightShoulder.C1 = CF(-0.25, 0.5 + 1*angle/10, 0.5) * ANGLES(math.pi + angle/10, 0, angle/10)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2 + angle/10, math.pi, 0)
        RootJoint.C0     = CF(0, 0.5 + angle/5, 0) * ANGLES(math.pi/2, math.pi, 0)
    elseif name == "canttouch" then
        danceCountspeed = 2
        LeftShoulder.C1  = CF(0, 0.5, -0.5) * ANGLES(angle/8, 0, math.pi/12 + angle/12)
        RightShoulder.C1 = CF(0, 0.5, -0.5) * ANGLES(angle/8, 0, -math.pi/12 - angle/12)
        LeftHip.C1       = CF(0.35, 0.7, 0.5) * ANGLES(angle/10, 0, -math.pi/8)
        RightHip.C1      = CF(-0.35, 0.7, 0.5) * ANGLES(angle/10, 0, math.pi/8)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2 + angle/15, math.pi, 0)
        RootJoint.C0     = CF(angle/4, -0.3 + angle/20, 0) * ANGLES(math.pi/2, math.pi, 0)
    elseif name == "happy" then
        danceCountspeed = 4
        LeftShoulder.C1  = CF(0, 0.5, -0.5) * ANGLES(math.pi/4, math.pi/8 + angle/8, math.pi/4 + angle/8)
        RightShoulder.C1 = CF(0, 0.5, -0.5) * ANGLES(math.pi/4, -math.pi/8 + angle/8, -math.pi/4 + angle/8)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(angle/10, 0, angle/10)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(angle/10, 0, angle/10)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2 + angle/15, math.pi + angle/15, angle/15)
        RootJoint.C0     = CF(0, angle/20, 0) * ANGLES(math.pi/2, math.pi, 0)
    elseif name == "spin" then
        danceGlobalWait = (danceGlobalWait % 360) + 4
        danceCountspeed = 4
        LeftShoulder.C1  = CF(0, 1, 0) * ANGLES(math.pi/2, angle/10, angle/10)
        RightShoulder.C1 = CF(0, 1, 0) * ANGLES(math.pi/2, -angle/10, angle/10)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(angle/10, angle/10, angle/10)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(angle/10, angle/10, angle/10)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2, math.pi, 0)
        RootJoint.C0     = CF(angle/25, 0, -angle/25) * ANGLES(math.pi/2, math.pi, math.rad(danceGlobalWait*4))
    elseif name == "thriller" then
        danceCountspeed = 2
        LeftShoulder.C1  = CF(0, 0.5, -0.5) * ANGLES(0, 0, math.pi/2 + angle/15)
        RightShoulder.C1 = CF(0, 0.5, -0.5) * ANGLES(0, 0, -math.pi/2 + angle/15)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(math.pi/60 - angle/45, 0, angle/15)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(math.pi/60 + angle/45, 0, angle/15)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2 + angle/15, math.pi + angle/10, 0)
        RootJoint.C0     = CF(0, 0, 0) * ANGLES(math.pi/2 + angle/50, math.pi + angle/50, angle/50)
    elseif name == "barrel" then
        LeftShoulder.C1  = CF(0, 0.5, -0.5) * ANGLES(0, 0, math.pi)
        RightShoulder.C1 = CF(0, 0.5, -0.5) * ANGLES(0, 0, math.pi)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(0, 0, 0)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(0, 0, 0)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2, math.pi, 0)
        RootJoint.C0     = CF(angle, -1.8, 0) * ANGLES(0, math.pi, angle)
    elseif name == "sax" then
        danceCountspeed = 2
        LeftShoulder.C1  = CF(0, 0.75, -0.25) * ANGLES(-math.pi/5, 0, math.pi/2 - math.abs(angle/30))
        RightShoulder.C1 = CF(0, 0.75, -0.25) * ANGLES(-math.pi/5, 0, -math.pi/2 + math.abs(angle/30))
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(0, 0, -math.abs(angle/30))
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(0, 0, math.abs(angle/30))
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2, math.pi, 0)
        RootJoint.C0     = CF(0, -math.abs(angle*0.05), math.abs(angle*0.025)) * ANGLES(math.pi/2 + math.abs(angle/20), math.pi, 0)
    elseif name == "spooky" then
        danceCountspeed = 3
        LeftShoulder.C1  = CF(0, 0.5, -0.5) * ANGLES(0, 0, math.pi/2 - angle/1.5)
        RightShoulder.C1 = CF(0, 0.5, -0.5) * ANGLES(0, 0, -math.pi/2 + angle/1.5)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(0, 0, -angle/16)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(0, 0, angle/16)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2 + angle/12, math.pi, 0)
        RootJoint.C0     = CF(0, angle/35, 0) * ANGLES(math.pi/2 + angle/25, math.pi, 0)
    elseif name == "stride" then
        danceCountspeed = 2.5
        LeftShoulder.C1  = CF(0, 0.5, -0.5) * ANGLES(angle/16, angle/16, math.pi/3.5 + angle/8)
        RightShoulder.C1 = CF(0, 0.5, -0.5) * ANGLES(angle/16, -angle/16, -math.pi/1.5 - angle/8)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(0, angle/16, angle/16)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(0, angle/16, angle/16)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2, math.pi, 0)
        RootJoint.C0     = CF(0, 0, 0) * ANGLES(math.pi/2 - angle/16, math.pi, 0)
    elseif name == "shuffle" then
        danceCountspeed = 2
        LeftShoulder.C1  = CF(0, 0.75, -0.35) * ANGLES(math.pi/8, 0, math.pi/2 + angle/3.5)
        RightShoulder.C1 = CF(0, 0.75, -0.35) * ANGLES(math.pi/8, 0, -math.pi/2 + angle/3.5)
        LeftHip.C1       = CF(angle/50, 1, 0.5) * ANGLES(0, angle/35, angle/15)
        RightHip.C1      = CF(angle/50, 1, 0.5) * ANGLES(0, angle/35, angle/15)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2 + angle/15, math.pi, 0)
        RootJoint.C0     = CF(0, 0, 0) * ANGLES(math.pi/2 - angle/35, math.pi - angle/35, 0)
    elseif name == "rock" then
        danceCountspeed = 4
        LeftShoulder.C1  = CF(0, 0.5, -0.5) * ANGLES(0, 0, math.pi/2 + angle/2)
        RightShoulder.C1 = CF(0, 0.5, -0.5) * ANGLES(0, 0, -math.pi/2 + angle/2)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(angle/32, 0, angle/32)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(angle/32, 0, -angle/32)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2, math.pi, 0)
        RootJoint.C0     = CF(0, -angle/50, 0) * ANGLES(math.pi/2, math.pi, 0)
    elseif name == "gagnam" then
        danceCountspeed = 4
        LeftShoulder.C1  = CF(0, 0.75, -0.15) * ANGLES(-math.pi/4, 0, (math.pi/2 + angle/14) - math.pi/20)
        RightShoulder.C1 = CF(0, 0.75, -0.15) * ANGLES(-math.pi/4, 0, (-math.pi/2 - angle/14) + math.pi/20)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(angle/16, 0, 0)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(angle/16, 0, 0)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2 + angle/20, math.pi, 0)
        RootJoint.C0     = CF(0, angle/40, 0) * ANGLES(math.pi/2, math.pi, 0)
    elseif name == "snoop" then
        danceCountspeed = 2
        LeftShoulder.C1  = CF(0, 0.5, -0.5) * ANGLES(math.pi/12, 0, math.pi/4 + angle/4)
        RightShoulder.C1 = CF(0, 0.5, -0.5) * ANGLES(math.pi/12, 0, -math.pi/4 + angle/4)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(math.pi/24, 0, angle/4)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(math.pi/24, 0, angle/4)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2 - angle/8, math.pi, 0)
        RootJoint.C0     = CF(0, angle/48, 0) * ANGLES(math.pi/2 + angle/24, math.pi, 0)
    elseif name == "darude" then
        danceCountspeed = 3
        LeftShoulder.C1  = CF(0, 0.5, -0.5) * ANGLES(0, 0, angle/1.5)
        RightShoulder.C1 = CF(0, 0.5, -0.5) * ANGLES(0, 0, angle/3)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(0, 0, -angle/3)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(0, 0, -angle/1.5)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2, math.pi, 0)
        RootJoint.C0     = CF(0, angle/45, 0) * ANGLES(math.pi/2 - angle/6, math.pi, 0)
    elseif name == "taco" then
        danceCountspeed = 4
        danceGlobalWait = (danceGlobalWait % 360) + 4
        LeftShoulder.C1  = CF(0, 1, -0.25) * ANGLES(math.pi/6 + angle/12, 0, math.pi)
        RightShoulder.C1 = CF(0, 1, -0.25) * ANGLES(math.pi/6 + angle/12, 0, math.pi)
        LeftHip.C1       = CF(0, 1, 0.5) * ANGLES(0, 0, math.pi/8 + angle/16)
        RightHip.C1      = CF(0, 1, 0.5) * ANGLES(0, 0, math.pi/8 + angle/16)
        Neck.C1          = CF(0, -0.5, 0) * ANGLES(math.pi/2 - math.pi/8 + angle/16, math.pi, 0)
        RootJoint.C0     = CF(0, 0.25 + angle/12, 0) * ANGLES(math.pi/2, math.pi, math.rad(danceGlobalWait*4))
    end

    if name == "taco" then
        tacoSpawnTimer = tacoSpawnTimer + 1
        if tacoSpawnTimer >= 6 then
            tacoSpawnTimer = 0
            local part = IT("Part")
            part.Size = VT(1, 1, 1)
            part.CanCollide = false
            part.Anchored = false
            part.TopSurface = Enum.SurfaceType.Smooth
            part.BottomSurface = Enum.SurfaceType.Smooth
            local mesh = IT("SpecialMesh")
            mesh.MeshType = Enum.MeshType.FileMesh
            mesh.MeshId = "rbxassetid://14846869"
            mesh.TextureId = "rbxassetid://14846834"
            mesh.Scale = VT(math.random()*20, math.random()*20, math.random()*20)
            mesh.Parent = part
            local base = RootPart.CFrame
            part.CFrame = base * CF(math.random()*500-250, math.random(100,200), math.random()*500-250)
            part.RotVelocity = VT(math.random()*math.pi, math.random()*math.pi, math.random()*math.pi)
            part.Parent = world
            game:GetService("Debris"):AddItem(part, 4)
        end
    end
end
-- ==== END DANCE STATE ====

local function QuaternionFromCFrame(cf)
    local mx,my,mz,m00,m01,m02,m10,m11,m12,m20,m21,m22=cf:components()
    local trace=m00+m11+m22
    if trace>0 then
        local s=math.sqrt(1+trace)
        local recip=0.5/s
        return (m21-m12)*recip,(m02-m20)*recip,(m10-m01)*recip,s*0.5
    else
        local i=0
        if m11>m00 then i=1 end
        if m22>(i==0 and m00 or m11) then i=2 end
        if i==0 then
            local s=math.sqrt(m00-m11-m22+1)
            local recip=0.5/s
            return 0.5*s,(m10+m01)*recip,(m20+m02)*recip,(m21-m12)*recip
        elseif i==1 then
            local s=math.sqrt(m11-m22-m00+1)
            local recip=0.5/s
            return (m01+m10)*recip,0.5*s,(m21+m12)*recip,(m02-m20)*recip
        elseif i==2 then
            local s=math.sqrt(m22-m00-m11+1)
            local recip=0.5/s
            return (m02+m20)*recip,(m12+m21)*recip,0.5*s,(m10-m01)*recip
        end
    end
end

local function QuaternionToCFrame(px,py,pz,x,y,z,w)
    local xs,ys,zs=x+x,y+y,z+z
    local wx,wy,wz=w*xs,w*ys,w*zs
    local xx=x*xs; local xy=x*ys; local xz=x*zs
    local yy=y*ys; local yz=y*zs; local zz=z*zs
    return CFrame.new(px,py,pz,1-(yy+zz),xy-wz,xz+wy,xy+wz,1-(xx+zz),yz-wx,xz-wy,yz+wx,1-(xx+yy))
end

local function QuaternionSlerp(a,b,t)
    local cosTheta=a[1]*b[1]+a[2]*b[2]+a[3]*b[3]+a[4]*b[4]
    local startInterp,finishInterp
    if cosTheta>=0.0001 then
        if (1-cosTheta)>0.0001 then
            local theta=ACOS(cosTheta)
            local invSinTheta=1/SIN(theta)
            startInterp=SIN((1-t)*theta)*invSinTheta
            finishInterp=SIN(t*theta)*invSinTheta
        else
            startInterp=1-t; finishInterp=t
        end
    else
        if (1+cosTheta)>0.0001 then
            local theta=ACOS(-cosTheta)
            local invSinTheta=1/SIN(theta)
            startInterp=SIN((t-1)*theta)*invSinTheta
            finishInterp=SIN(t*theta)*invSinTheta
        else
            startInterp=t-1; finishInterp=t
        end
    end
    return a[1]*startInterp+b[1]*finishInterp, a[2]*startInterp+b[2]*finishInterp, a[3]*startInterp+b[3]*finishInterp, a[4]*startInterp+b[4]*finishInterp
end

local function Clerp(a,b,t)
    local qa={QuaternionFromCFrame(a)}
    local qb={QuaternionFromCFrame(b)}
    local ax,ay,az=a.x,a.y,a.z
    local bx,by,bz=b.x,b.y,b.z
    local _t=1-t
    return QuaternionToCFrame(_t*ax+t*bx,_t*ay+t*by,_t*az+t*bz,QuaternionSlerp(qa,qb,t))
end

local ArtificialHB = IT("BindableEvent", script)
ArtificialHB.Name = "ArtificialHB"
script:WaitForChild("ArtificialHB")
local frame = 1/60
local tf = 0
local lastframe = tick()
script.ArtificialHB:Fire()

run.Heartbeat:Connect(function(s, p)
    tf = tf + s
    if tf >= frame then
        for i = 1, math.floor(tf / frame) do
            script.ArtificialHB:Fire()
        end
        lastframe = tick()
        tf = tf - frame * math.floor(tf / frame)
    end
end)

local function Swait(NUMBER)
    if NUMBER == 0 or NUMBER == nil then
        ArtificialHB.Event:wait()
    else
        for i = 1, NUMBER do
            ArtificialHB.Event:wait()
        end
    end
end

local Effects = IT("Folder", Character)
Effects.Name = "Effects"

local function CreatePart(FORMFACTOR,PARENT,MATERIAL,REFLECTANCE,TRANSPARENCY,BRICKCOLOR,NAME,SIZE,ANCHOR)
    local NEWPART=IT("Part")
    NEWPART.formFactor=FORMFACTOR
    NEWPART.Reflectance=REFLECTANCE
    NEWPART.Transparency=TRANSPARENCY
    NEWPART.CanCollide=false
    NEWPART.Locked=true
    NEWPART.Anchored=true
    if ANCHOR==false then NEWPART.Anchored=false end
    NEWPART.BrickColor=BRICKC(tostring(BRICKCOLOR))
    NEWPART.Name=NAME
    NEWPART.Size=SIZE
    NEWPART.Position=Torso.Position
    NEWPART.Material=MATERIAL
    NEWPART:BreakJoints()
    NEWPART.Parent=PARENT
    return NEWPART
end

local function CreateMesh(MESH,PARENT,MESHTYPE,MESHID,TEXTUREID,SCALE,OFFSET)
    local NEWMESH=IT(MESH)
    if MESH=="SpecialMesh" then
        NEWMESH.MeshType=MESHTYPE
        if MESHID~="nil" and MESHID~="" then NEWMESH.MeshId="http://www.roblox.com/asset/?id="..MESHID end
        if TEXTUREID~="nil" and TEXTUREID~="" then NEWMESH.TextureId="http://www.roblox.com/asset/?id="..TEXTUREID end
    end
    NEWMESH.Offset=OFFSET or VT(0,0,0)
    NEWMESH.Scale=SCALE
    NEWMESH.Parent=PARENT
    return NEWMESH
end

local function CreateWeldOrSnapOrMotor(TYPE,PARENT,PART0,PART1,C0,C1)
    local NEWWELD=IT(TYPE)
    NEWWELD.Part0=PART0
    NEWWELD.Part1=PART1
    NEWWELD.C0=C0
    NEWWELD.C1=C1
    NEWWELD.Parent=PARENT
    return NEWWELD
end

local function Raycast(POSITION,DIRECTION,RANGE,IGNOREDECENDANTS)
    return world:FindPartOnRay(Ray.new(POSITION,DIRECTION.unit*RANGE),IGNOREDECENDANTS)
end

local function CreateSound(ID,PARENT,VOLUME,PITCH)
    local NEWSOUND=IT("Sound",PARENT)
    NEWSOUND.Volume=VOLUME
    NEWSOUND.Pitch=PITCH
    NEWSOUND.SoundId="http://www.roblox.com/asset/?id="..ID
    NEWSOUND:play()
    game:GetService("Debris"):AddItem(NEWSOUND,10)
end

local function CreateWave(SIZE,WAIT,CFRAME,DOESROT,ROT,COLOR,GROW)
    local wave=CreatePart(3,Effects,"Neon",0,0.5,BRICKC(COLOR),"Effect",VT(0,0,0))
    local mesh=IT("SpecialMesh",wave)
    mesh.MeshType="FileMesh"
    mesh.MeshId="http://www.roblox.com/asset/?id=20329976"
    mesh.Scale=SIZE
    mesh.Offset=VT(0,0,-SIZE.X/8)
    wave.CFrame=CFRAME
    coroutine.resume(coroutine.create(function(PART)
        for i=1,WAIT do
            Swait()
            mesh.Scale=mesh.Scale+GROW
            mesh.Offset=VT(0,0,-(mesh.Scale.X/8))
            if DOESROT==true then wave.CFrame=wave.CFrame*CFrame.fromEulerAnglesXYZ(0,ROT,0) end
            wave.Transparency=wave.Transparency+(0.5/WAIT)
            if wave.Transparency>0.99 then wave:Destroy() end
        end
    end))
end

local function CreateDebreeRing(FLOOR,POSITION,SIZE,BLOCKSIZE,SWAIT)
    if FLOOR~=nil then
        coroutine.resume(coroutine.create(function()
            local PART=CreatePart(3,Effects,"Plastic",0,1,"Pearl","DebreeCenter",VT(0,0,0))
            PART.CFrame=CF(POSITION)
            for i=1,45 do
                local RingPiece=CreatePart(3,Effects,"Plastic",0,0,"Pearl","DebreePart",BLOCKSIZE)
                RingPiece.Material=FLOOR.Material
                RingPiece.Color=FLOOR.Color
                RingPiece.CFrame=PART.CFrame*ANGLES(RAD(0),RAD(i*8),RAD(0))*CF(SIZE*4,0,0)*ANGLES(RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)),RAD(MRANDOM(-360,360)))
                game:GetService("Debris"):AddItem(RingPiece,SWAIT/100)
            end
            PART:Destroy()
        end))
    end
end

local Weapon = IT("Model")
Weapon.Name = "Adds"
local HandlePart = CreatePart(3,Weapon,"SmoothPlastic",0,0,"Really black","Handle",VT(0,0,0),false)
CreateMesh("SpecialMesh",HandlePart,"FileMesh","10604848","10605252",VT(1,1,1),VT(0,2.7,0))
local HandleWeld = CreateWeldOrSnapOrMotor("Weld",HandlePart,RightArm,HandlePart,CF(0,-0.8,0)*ANGLES(RAD(-90),RAD(0),RAD(0)),CF(0,0,0))
for _,c in pairs(Weapon:GetChildren()) do
    if c.ClassName=="Part" then c.CustomPhysicalProperties=PhysicalProperties.new(0,0,0,0,0) end
end
Weapon.Parent = Character

local function BAN(CHARACTER)
    local BANFOLDER=IT("Folder",Effects)
    local naeeym2=IT("BillboardGui",BANFOLDER)
    naeeym2.AlwaysOnTop=false
    naeeym2.Size=UDim2.new(5,35,2,35)
    naeeym2.StudsOffset=VT(0,1,0)
    local tecks2=IT("TextLabel",naeeym2)
    tecks2.BackgroundTransparency=1
    tecks2.TextScaled=true
    tecks2.BorderSizePixel=0
    tecks2.Text="BANNED"
    tecks2.Font="Code"
    tecks2.TextSize=30
    tecks2.TextStrokeTransparency=1
    tecks2.TextColor3=C3(0,0,0)
    tecks2.TextStrokeColor3=C3(1,1,1)
    tecks2.Size=UDim2.new(1,0,0.5,0)
    tecks2.Parent=naeeym2
    for i,v in ipairs(CHARACTER:GetChildren()) do
        if v.ClassName=="Part" or v.ClassName=="MeshPart" then
            if v.Name~="HumanoidRootPart" then
                local BOD=v:Clone()
                BOD.CanCollide=false
                BOD.Anchored=true
                BOD.CFrame=v.CFrame
                BOD.Parent=BANFOLDER
                BOD.Material="Neon"
                BOD.Color=C3(0,0,0)
                if BOD:FindFirstChildOfClass("Decal") then BOD:FindFirstChildOfClass("Decal"):Destroy() end
                if BOD.Name=="Head" then naeeym2.Adornee=BOD end
                if BOD.ClassName=="MeshPart" then BOD.TextureID="" end
            end
        end
    end
    CHARACTER:Destroy()
    coroutine.resume(coroutine.create(function()
        for i=1,50 do
            Swait()
            for _,v in ipairs(BANFOLDER:GetChildren()) do
                if v.ClassName=="Part" or v.ClassName=="MeshPart" then v.Transparency=1 end
                naeeym2.Enabled=false
            end
            Swait()
            for _,v in ipairs(BANFOLDER:GetChildren()) do
                if v.ClassName=="Part" or v.ClassName=="MeshPart" then v.Transparency=0 end
                naeeym2.Enabled=true
            end
        end
        BANFOLDER:Destroy()
    end))
end

local function BANNEAREST(POS,RANGE)
    for _,v in ipairs(world:GetChildren()) do
        local body=v:GetChildren()
        for part=1,#body do
            if (body[part].ClassName=="Part" or body[part].ClassName=="MeshPart") and v~=Character then
                if (body[part].Position-POS).Magnitude<RANGE then
                    if v:FindFirstChildOfClass("Humanoid") then
                        BAN(v)
                    end
                end
            end
        end
    end
end

local function BANSLAM()
    ATTACK=true
    Rooted=false
    repeat
        for i=0,0.2,0.1/Animation_Speed do
            Swait()
            HandleWeld.C0=Clerp(HandleWeld.C0,CF(0,-0.8,0)*ANGLES(RAD(-90),RAD(-45),RAD(0)),2/Animation_Speed)
            RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,7)*ANGLES(RAD(0),RAD(0),RAD(0)),2/Animation_Speed)
            Neck.C0=Clerp(Neck.C0,NECKC0*CF(0,0,0+((1)-1))*ANGLES(RAD(25),RAD(0),RAD(0)),2/Animation_Speed)
            RightShoulder.C0=Clerp(RightShoulder.C0,CF(1,0.5,0.5)*ANGLES(RAD(250),RAD(0),RAD(-45))*RIGHTSHOULDERC0,2/Animation_Speed)
            LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1,0.5,0.5)*ANGLES(RAD(250),RAD(0),RAD(45))*LEFTSHOULDERC0,2/Animation_Speed)
            RightHip.C0=Clerp(RightHip.C0,CF(1,-1-0.05*COS(SINE/12),-0.01)*ANGLES(RAD(0),RAD(90),RAD(0))*ANGLES(RAD(-8),RAD(0),RAD(25)),2/Animation_Speed)
            LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1-0.05*COS(SINE/12),-0.01)*ANGLES(RAD(0),RAD(-90),RAD(0))*ANGLES(RAD(-8),RAD(0),RAD(25)),2/Animation_Speed)
        end
        for i=0,0.08,0.1/Animation_Speed do
            Swait()
            HandleWeld.C0=Clerp(HandleWeld.C0,CF(0,-1,0)*ANGLES(RAD(-90),RAD(-45),RAD(0)),2/Animation_Speed)
            RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,2)*ANGLES(RAD(75),RAD(0),RAD(0)),2/Animation_Speed)
            Neck.C0=Clerp(Neck.C0,NECKC0*CF(0,0,0+((1)-1))*ANGLES(RAD(-25),RAD(0),RAD(0)),2/Animation_Speed)
            RightShoulder.C0=Clerp(RightShoulder.C0,CF(1,0.5,-1)*ANGLES(RAD(120),RAD(0),RAD(-45))*RIGHTSHOULDERC0,2/Animation_Speed)
            LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1,0.5,-1)*ANGLES(RAD(120),RAD(0),RAD(45))*LEFTSHOULDERC0,2/Animation_Speed)
            RightHip.C0=Clerp(RightHip.C0,CF(1,-1-0.05*COS(SINE/12),-0.01)*ANGLES(RAD(0),RAD(90),RAD(0))*ANGLES(RAD(-8),RAD(0),RAD(25)),0.5/Animation_Speed)
            LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1-0.05*COS(SINE/12),-0.01)*ANGLES(RAD(0),RAD(-90),RAD(0))*ANGLES(RAD(-8),RAD(0),RAD(25)),0.5/Animation_Speed)
        end
        for i=0,0.08,0.1/Animation_Speed do
            Swait()
            HandleWeld.C0=Clerp(HandleWeld.C0,CF(0,-1,0)*ANGLES(RAD(-70),RAD(-45),RAD(0)),2/Animation_Speed)
            RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,2)*ANGLES(RAD(75),RAD(0),RAD(0)),2/Animation_Speed)
            Neck.C0=Clerp(Neck.C0,NECKC0*CF(0,0,0+((1)-1))*ANGLES(RAD(-25),RAD(0),RAD(0)),2/Animation_Speed)
            RightShoulder.C0=Clerp(RightShoulder.C0,CF(1,0.5,-1)*ANGLES(RAD(60),RAD(0),RAD(-45))*RIGHTSHOULDERC0,2/Animation_Speed)
            LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1,0.5,-1)*ANGLES(RAD(60),RAD(0),RAD(45))*LEFTSHOULDERC0,2/Animation_Speed)
            RightHip.C0=Clerp(RightHip.C0,CF(1,-1-0.05*COS(SINE/12),-0.01)*ANGLES(RAD(0),RAD(90),RAD(0))*ANGLES(RAD(-8),RAD(0),RAD(25)),0.5/Animation_Speed)
            LeftHip.C0=Clerp(LeftHip.C0,CF(-1,-1-0.05*COS(SINE/12),-0.01)*ANGLES(RAD(0),RAD(-90),RAD(0))*ANGLES(RAD(-8),RAD(0),RAD(25)),0.5/Animation_Speed)
        end
        CreateSound("147722910", Effects, 10, 1)
        BANNEAREST(RootPart.CFrame*CF(0,0,-6).p,25)
        local HITFLOOR = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
        if HITFLOOR ~= nil then
            CreateSound("289842971", HandlePart, 10, 1)
            CreateDebreeRing(HITFLOOR,RootPart.CFrame*CF(0,-5,-6).p,5,VT(8,8,8),35)
        end
        CreateWave(VT(25,0,25),45,RootPart.CFrame*CF(0,-5,-6),true,2,"Really black",VT(0,3,0))
        CreateWave(VT(25,0,25),45,RootPart.CFrame*CF(0,-5,-6),true,-2,"Really black",VT(0,3,0))
        for i=0,0.1,0.1/Animation_Speed do
            Swait()
            HandleWeld.C0=Clerp(HandleWeld.C0,CF(0,-1,0)*ANGLES(RAD(-70),RAD(-45),RAD(0)),2/Animation_Speed)
            RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,1.8)*ANGLES(RAD(75),RAD(0),RAD(0)),2/Animation_Speed)
            Neck.C0=Clerp(Neck.C0,NECKC0*CF(0,0,0+((1)-1))*ANGLES(RAD(-25),RAD(0),RAD(0)),2/Animation_Speed)
            RightShoulder.C0=Clerp(RightShoulder.C0,CF(1,0.5,-1)*ANGLES(RAD(60),RAD(0),RAD(-45))*RIGHTSHOULDERC0,2/Animation_Speed)
            LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1,0.5,-1)*ANGLES(RAD(60),RAD(0),RAD(45))*LEFTSHOULDERC0,2/Animation_Speed)
        end
        if HOLD == true then
            for i=0,0.08,0.1/Animation_Speed do
                Swait()
                if HOLD == false then break end
                HandleWeld.C0=Clerp(HandleWeld.C0,CF(0,-1,0)*ANGLES(RAD(-90),RAD(-45),RAD(0)),2/Animation_Speed)
                RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,2)*ANGLES(RAD(75),RAD(0),RAD(0)),2/Animation_Speed)
                Neck.C0=Clerp(Neck.C0,NECKC0*CF(0,0,0+((1)-1))*ANGLES(RAD(-25),RAD(0),RAD(0)),2/Animation_Speed)
                RightShoulder.C0=Clerp(RightShoulder.C0,CF(1,0.5,-1)*ANGLES(RAD(120),RAD(0),RAD(-45))*RIGHTSHOULDERC0,2/Animation_Speed)
                LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1,0.5,-1)*ANGLES(RAD(120),RAD(0),RAD(45))*LEFTSHOULDERC0,2/Animation_Speed)
            end
        end
    until HOLD == false
    for i=0,1,0.1/Animation_Speed do
        Swait()
        HandleWeld.C0=Clerp(HandleWeld.C0,CF(0,-1,0)*ANGLES(RAD(-70),RAD(-45),RAD(0)),2/Animation_Speed)
        RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,1.8)*ANGLES(RAD(75),RAD(0),RAD(0)),2/Animation_Speed)
        Neck.C0=Clerp(Neck.C0,NECKC0*CF(0,0,0+((1)-1))*ANGLES(RAD(-25),RAD(0),RAD(0)),2/Animation_Speed)
        RightShoulder.C0=Clerp(RightShoulder.C0,CF(1,0.5,-1)*ANGLES(RAD(60),RAD(0),RAD(-45))*RIGHTSHOULDERC0,2/Animation_Speed)
        LeftShoulder.C0=Clerp(LeftShoulder.C0,CF(-1,0.5,-1)*ANGLES(RAD(60),RAD(0),RAD(45))*LEFTSHOULDERC0,2/Animation_Speed)
    end
    for i=0,5,0.1/Animation_Speed do
        RightShoulder.C0=Clerp(RightShoulder.C0,CF(1.5,0,0)*ANGLES(RAD(200),RAD(90),RAD(0))*RIGHTSHOULDERC0,0.2/Animation_Speed)
        HandleWeld.C0=Clerp(HandleWeld.C0,CF(0,-0.8,0)*ANGLES(RAD(-90),RAD(0),RAD(0)),0.2/Animation_Speed)
        RootJoint.C0=Clerp(RootJoint.C0,ROOTC0*CF(0,0,0+0.05*COS(SINE/12))*ANGLES(RAD(0),RAD(0),RAD(0)),0.15/Animation_Speed)
    end
    ATTACK=false
    Rooted=false
end

local function getRoot(char)
    char=char or Character
    return char and (char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso"))
end
local function getHumanoid(char)
    char=char or Character
    return char and char:FindFirstChild("Humanoid")
end
local function isProtectedPart(p) return p and protectedParts[p.Name] end
local function rand(a,b)
    seed=(seed*9301+49297)%233280
    return a+(seed/233280)*(b-a)
end
local function children(o,a)
    for _,v in pairs(o:GetChildren()) do a[#a+1]=v; children(v,a) end
end

local function spawnOrbit()
    if orbitState ~= "off" then return end
    orbitState = "on"
    for i = 1, 15 do
        local p = IT("Part")
        p.Name = "OrbitPart"
        p.Size = VT(0.5, rand(10, 20), 0.5)
        p.Color = C3(0, 0, 0)
        p.Material = Enum.Material.Plastic
        p.Anchored = false
        p.CanCollide = false
        p.Parent = world
        
        local angle = rand(0, math.pi * 2)
        local dist = rand(5, 15)
        local yOffset = rand(-5, 5)
        local speed = rand(1, 3)
        local pointChance = rand(0, 1)
        
        orbitParts[#orbitParts+1] = {
            part = p,
            angle = angle,
            dist = dist,
            yOffset = yOffset,
            speed = speed,
            pointChance = pointChance,
            rotX = rand(-math.pi, math.pi),
            rotY = rand(-math.pi, math.pi),
            rotZ = rand(-math.pi, math.pi)
        }
    end
end

local function toggleOrbit()
    if orbitState == "off" then
        spawnOrbit()
    elseif orbitState == "on" then
        orbitState = "dying"
        orbitTimer = 0
    end
end

coroutine.resume(coroutine.create(function()
    while true do
        Swait(math.random(3, 8))
        if Character and Character.Parent and RootPart then
            local p = IT("Part")
            p.Name = "AuraBrick"
            p.Size = VT(rand(2, 6), rand(1, 4), rand(2, 6))
            p.Color = C3(0, 0, 0)
            p.Material = Enum.Material.Plastic
            p.Anchored = true
            p.CanCollide = false
            p.Transparency = 0.2
            
            local spawnX = RootPart.Position.X + rand(-25, 25)
            local spawnY = RootPart.Position.Y + rand(15, 45)
            local spawnZ = RootPart.Position.Z + rand(-25, 25)
            
            p.CFrame = CF(spawnX, spawnY, spawnZ) * ANGLES(rand(0,math.pi*2), rand(0,math.pi*2), rand(0,math.pi*2))
            p.Parent = world
            
            coroutine.resume(coroutine.create(function()
                for i = 1, 30 do
                    Swait()
                    if not p.Parent then return end
                    p.CFrame = p.CFrame * CF(0, -0.15, 0) * ANGLES(RAD(rand(-2,2)), RAD(rand(-2,2)), RAD(rand(-2,2)))
                    p.Transparency = p.Transparency + (0.8/30)
                end
                p:Destroy()
            end))
        end
    end
end))

coroutine.resume(coroutine.create(function()
    while true do
        Swait(math.random(4, 8))
        local center = possessedRoot or RootPart
        if center and center.Parent and Character and Character.Parent then
            local base = center.Position
            local p = IT("Part")
            p.Name = "RainDrop"
            p.Shape = Enum.PartType.Ball
            p.Size = VT(0.4, 0.7, 0.4)
            p.Color = C3(0, 0, 0)
            p.Material = Enum.Material.Neon
            p.Anchored = true
            p.CanCollide = false
            p.Transparency = 0
            p.CFrame = CF(base.X + rand(-30, 30), base.Y + rand(20, 45), base.Z + rand(-30, 30))
            p.Parent = world

            coroutine.resume(coroutine.create(function()
                local speed = 50
                local landed = false
                
                local ignoreRain = {Character, p}
                for _, d in pairs(dummies) do if d.m then table.insert(ignoreRain, d.m) end end
                for _, g in pairs(ghosts) do if g.m then table.insert(ignoreRain, g.m) end end
                for _, v in pairs(world:GetChildren()) do
                    if v.Name == "WalkRipple" or v.Name == "RainDrop" or v.Name == "BlackSpikes" or v.Name == "OrbitPart" then
                        table.insert(ignoreRain, v)
                    end
                end

                while p.Parent do
                    local step = speed / 60
                    local h, pos = world:FindPartOnRayWithIgnoreList(
                        Ray.new(p.Position, VT(0, -step - 0.5, 0)),
                        ignoreRain
                    )
                    if h and pos then
                        p.CFrame = CF(pos + VT(0, 0.35, 0))
                        landed = true
                        break
                    end
                    p.CFrame = p.CFrame * CF(0, -step, 0)
                    speed = speed + 5
                    if p.Position.Y < base.Y - 100 then
                        p:Destroy()
                        return
                    end
                    Swait()
                end
                if landed and p.Parent then
                    local start = tick()
                    while p.Parent and tick() - start < 0.4 do
                        local a = (tick() - start) / 0.4
                        p.Transparency = a
                        p.Size = VT(0.4, 0.7, 0.4) + VT(0.4 * a, 0.4 * a, 0.4 * a)
                        Swait()
                    end
                end
                if p.Parent then p:Destroy() end
            end))
        end
    end
end))

local function makeSpikes(char)
    local root=getRoot(char)
    if not root then return end
    local model=IT("Model"); model.Name="BlackSpikes"; model.Parent=world
    local parts={}
    for i=1,18 do
        local x=rand(-5,5); local z=rand(-5,5)
        local height=rand(1.5,7); local width=rand(0.035,0.09)
        local ground=root.Position.y-3
        local rotation=CFrame.Angles(rand(-0.12,0.12),rand(0,math.pi*2),rand(-0.12,0.12))
        local part=IT("Part")
        part.Name="Spike"; part.Anchored=true; part.CanCollide=false
        part.FormFactor=Enum.FormFactor.Custom
        part.Size=VT(width,0.01,width); part.Material=Enum.Material.Plastic
        part.Color=C3(0,0,0)
        part.CFrame=CF(root.Position.x+x,ground,root.Position.z+z)*rotation
        part.Parent=model
        parts[#parts+1]={p=part,x=root.Position.x+x,z=root.Position.z+z,y=ground,h=height,w=width,r=rotation}
    end
    spikesList[#spikesList+1]={m=model,p=parts,t=0,life=0.65}
end

local function makeGhost(char)
    if #ghosts>=5 or not char then return end
    local old=char.Archivable; char.Archivable=true
    local clone; local ok,err=pcall(function() clone=char:Clone() end)
    char.Archivable=old
    if not ok or not clone then return end
    local all={}; children(clone,all)
    for _,v in pairs(all) do
        if v:IsA("Humanoid") or v:IsA("Script") or v:IsA("LocalScript") then v:Destroy()
        elseif v:IsA("BillboardGui") or v:IsA("SurfaceGui") or v:IsA("GuiBase") then
            v:Destroy()
        elseif v:IsA("BasePart") then
            v.Anchored=true; v.CanCollide=false; v.Material=Enum.Material.Plastic
            v.Color=C3(0,0,0); v.Transparency=math.max(v.Transparency,0.4)
        elseif v:IsA("Decal") or v:IsA("Texture") then v.Transparency=1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then v:Destroy() end
    end
    clone.Name="Afterimage"; clone.Parent=world
    all={}; children(clone,all)
    local parts={}
    for _,v in pairs(all) do
        if v:IsA("BasePart") and not isProtectedPart(v) then
            local angle=rand(0,math.pi*2); local y=rand(-0.7,0.9)
            parts[#parts+1]={
                p=v, c=v.CFrame,
                o=VT(math.cos(angle),y,math.sin(angle)).unit*rand(1,3),
                a=VT(rand(-0.5,0.5),rand(-0.5,0.5),rand(-0.5,0.5)),
                z=math.max(v.Transparency,0.4)
            }
        end
    end
    ghosts[#ghosts+1]={m=clone,p=parts,t=0,f=0}
end

local function activateEffects()
    if not Character then return end
    pcall(function() makeGhost(Character) end)
    pcall(function() makeSpikes(Character) end)
end

local DUMMY_COOLDOWN=0.5
local dummyCooldown=0

local function spawnDummy()
    if tick()<dummyCooldown then return end
    dummyCooldown=tick()+DUMMY_COOLDOWN
    local targetPos = mouse.Hit.p
    targetPos=VT(targetPos.x,RootPart.Position.y,targetPos.z)
    local model=IT("Model"); model.Name="Dummy"
    local base=CF(targetPos)
    local function newPart(name,size,color,cf)
        local p=IT("Part")
        p.Name=name; p.Size=size; p.BrickColor=BrickColor.new(color)
        p.Material=Enum.Material.Plastic; p.CFrame=cf; p.Parent=model
        return p
    end
    local head=newPart("Head",VT(2,1,1),"Bright yellow",base*CF(0,1.5,0))
    local torso=newPart("Torso",VT(2,2,1),"Bright blue",base*CF(0,0,0))
    local lArm=newPart("Left Arm",VT(1,2,1),"Bright yellow",base*CF(-1.5,0,0))
    local rArm=newPart("Right Arm",VT(1,2,1),"Bright yellow",base*CF(1.5,0,0))
    local lLeg=newPart("Left Leg",VT(1,2,1),"Br. yellowish green",base*CF(-0.5,-2,0))
    local rLeg=newPart("Right Leg",VT(1,2,1),"Br. yellowish green",base*CF(0.5,-2,0))
    local face=IT("Decal"); face.Texture="rbxasset://textures/face.png"; face.Face=Enum.NormalId.Front; face.Parent=head
    local rootPart=newPart("HumanoidRootPart",VT(2,2,1),"Medium stone grey",base)
    rootPart.Transparency=1; rootPart.CanCollide=false
    local hum=IT("Humanoid"); hum.Parent=model
    local function motor(name,p0,p1,c0,c1)
        local m=IT("Motor6D"); m.Name=name; m.Part0=p0; m.Part1=p1; m.C0=c0; m.C1=c1; m.Parent=p0; return m
    end
    motor("Neck",torso,head,CF(0,1,0)*ANGLES(-math.pi/2,0,math.pi),CF(0,-0.5,0)*ANGLES(-math.pi/2,0,math.pi))
    motor("Left Shoulder",torso,lArm,CF(-1,0.5,0)*ANGLES(0,-math.pi/2,0),CF(0.5,0.5,0)*ANGLES(0,-math.pi/2,0))
    motor("Right Shoulder",torso,rArm,CF(1,0.5,0)*ANGLES(0,math.pi/2,0),CF(-0.5,0.5,0)*ANGLES(0,math.pi/2,0))
    motor("Left Hip",torso,lLeg,CF(-0.5,-1,0)*ANGLES(0,-math.pi/2,0),CF(-0.5,1,0)*ANGLES(0,-math.pi/2,0))
    motor("Right Hip",torso,rLeg,CF(0.5,-1,0)*ANGLES(0,-math.pi/2,0),CF(0.5,1,0)*ANGLES(0,math.pi/2,0))
    local rootJoint=IT("Motor6D"); rootJoint.Name="RootJoint"; rootJoint.Part0=rootPart; rootJoint.Part1=torso
    rootJoint.C0=CF(0,0,0)*ANGLES(-math.pi/2,0,math.pi); rootJoint.C1=CF(0,0,0)*ANGLES(-math.pi/2,0,math.pi)
    rootJoint.Parent=rootPart
    model.PrimaryPart=rootPart
    model.Parent=world
    local parts={}; for _,v in pairs(model:GetChildren()) do if v:IsA("BasePart") then parts[#parts+1]=v end end
    dummies[#dummies+1]={m=model,parts=parts}
end

local function stopPossession()
    if not possessed then return end
    if possessedHum then
        pcall(function() possessedHum.PlatformStand=false; possessedHum.WalkSpeed=16; possessedHum.JumpPower=50; possessedHum.AutoRotate=true end)
    end
    if possessedRoot then pcall(function() possessedRoot.Velocity=VT(0,0,0) end) end
    possessed=nil; possessedHum=nil; possessedRoot=nil
    if world.CurrentCamera then world.CurrentCamera.CameraSubject=getHumanoid(Character) end
    if Humanoid then Humanoid.WalkSpeed=Speed; Humanoid.JumpPower=50 end
end

local function togglePossession()
    if possessed then stopPossession() return end
    local target
    local ray=Ray.new(world.CurrentCamera.CFrame.p,(mouse.Hit.p-world.CurrentCamera.CFrame.p).unit*1000)
    local hitPart=world:FindPartOnRay(ray,Character)
    if hitPart then
        local m=hitPart
        while m and m~=world do
            if m:IsA("Model") and m:FindFirstChild("Humanoid") then target=m break end
            m=m.Parent
        end
    end
    if not target or target==Character then return end
    local hum=target:FindFirstChild("Humanoid"); local root=target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Torso")
    if not hum or not root then return end
    possessed=target; possessedHum=hum; possessedRoot=root
    for _,v in pairs(target:GetChildren()) do if v:IsA("BasePart") then v.Anchored=false end end
    pcall(function() hum.PlatformStand=true; hum.WalkSpeed=0; hum.JumpPower=0; hum.AutoRotate=false end)
    if world.CurrentCamera then world.CurrentCamera.CameraSubject=hum end
    if Humanoid then Humanoid.WalkSpeed=0; Humanoid.JumpPower=0 end
end

local function teleportForward()
    if tick() < teleportCooldown then return end
    local root = getRoot(Character)
    if not root then return end

    teleportCooldown = tick() + TELEPORT_COOLDOWN
    local origin = root.Position
    local diff
    local ok = pcall(function()
        local hit = mouse.Hit.p
        diff = VT(hit.x - origin.x, 0, hit.z - origin.z)
    end)

    if not ok or not diff then
        diff = root.CFrame:vectorToWorldSpace(VT(0, 0, -1))
        diff = VT(diff.x, 0, diff.z)
    end

    local dist = diff.Magnitude
    if dist < 0.01 then
        diff = VT(0, 0, -1)
        dist = 1
    end

    local dir = diff.unit
    local travel = math.min(dist, MAX_RANGE)

    activateEffects()

    local ignore = {Character}
    for _, g in pairs(ghosts) do if g.m then ignore[#ignore + 1] = g.m end end
    for _, d in pairs(dummies) do if d.m then ignore[#ignore + 1] = d.m end end
    if possessed then ignore[#ignore + 1] = possessed end

    local target = origin + dir * travel
    local finalPos = target

    local hitPart, hitPos = world:FindPartOnRayWithIgnoreList(Ray.new(origin, dir * travel), ignore)
    if hitPart and hitPos then
        finalPos = hitPos - dir * 4
        finalPos = VT(finalPos.x, origin.y, finalPos.z)
    end

    root.CFrame = CF(finalPos)
    root.Velocity = VT(0,0,0)
    root.RotVelocity = VT(0,0,0)
    
    activateEffects()
end

local function notify(message)
    local torso = Torso or Character:FindFirstChild("UpperTorso")
    if not torso then return end

    local old = torso:FindFirstChild("NOTIFICATION")
    if old then old:Destroy() end

    local dialog = IT("BillboardGui")
    dialog.Name = "NOTIFICATION"
    dialog.Size = UD2(50, 0, 2, 0)
    dialog.StudsOffset = VT(0, 5, 0)
    dialog.Adornee = torso
    dialog.Parent = torso

    local text1 = IT("TextLabel")
    text1.BackgroundTransparency = 1
    text1.BorderSizePixel = 0
    text1.Text = ""
    text1.Font = Enum.Font.Arial
    text1.TextScaled = true
    text1.TextStrokeTransparency = 0
    text1.TextStrokeColor3 = C3(1, 1, 1)
    text1.Size = UD2(1, 0, 1, 0)
    text1.TextColor3 = C3(0, 0, 0)
    text1.Parent = dialog

    coroutine.resume(coroutine.create(function()
        local start = tick()
        local length = 0
        repeat
            Swait()
            if not dialog.Parent then return end
            local current = math.floor((tick() - start) * 30)
            if current > length then length = current end
            text1.Text = string.sub(message, 1, length)
        until length >= #message

        text1.Text = message
        start = tick()
        repeat Swait() until tick() - start > 2

        start = tick()
        repeat
            Swait()
            if not dialog.Parent then return end
            local a = tick() - start
            text1.Position = UD2(0, math.random(-3, 3), 0, math.random(-3, 3))
            text1.Rotation = math.random(-20, 20) * (1 - a)
            local stepped = math.floor(a * 10) / 10
            if math.random() < 0.4 then stepped = math.floor(a * 6) / 6 end
            text1.TextTransparency = math.min(stepped, 1)
            text1.TextStrokeTransparency = math.min(stepped, 1)
        until tick() - start > 1
        if dialog.Parent then dialog:Destroy() end
    end))
end

player.Chatted:Connect(function(msg)
    if msg == "" or msg == " " then return end
    notify("Source: " .. msg)
    local sound = IT("Sound")
    sound.SoundId = "rbxassetid://525200869"
    sound.Volume = 0.5
    sound.Parent = world
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 3)
end)

local hoveringResetBtn = false

local function resetCFrames()
    if activeDance then stopDance() end

    ANIM = "Idle"
    SINE = 0

    RootJoint.C0 = ROOTC0 * CF(0, 0, 0.05) * ANGLES(RAD(0), RAD(0), RAD(0))
    RootJoint.C1 = ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0))

    Neck.C0 = NECKC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0))
    Neck.C1 = CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180))

    LeftShoulder.C0 = CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0
    LeftShoulder.C1 = R6_LS_C1
    RightShoulder.C0 = CF(1.5, 0, 0) * ANGLES(RAD(200), RAD(90), RAD(0)) * RIGHTSHOULDERC0
    RightShoulder.C1 = R6_RS_C1

    RightHip.C0 = CF(1, -1 - 0.05, -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0))
    RightHip.C1 = CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0))
    LeftHip.C0 = CF(-1, -1 - 0.05, -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0))
    LeftHip.C1 = CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0))

    HandleWeld.C0 = CF(0, -0.8, 0) * ANGLES(RAD(-90), RAD(0), RAD(0))

    notify("Source: CFrames reset")
end

local function buildKeybindGui()
    local pg = player:FindFirstChild("PlayerGui")
    if not pg then return end
    local old = pg:FindFirstChild("SourceKeybinds")
    if old then old:Destroy() end
    
    local gui = IT("ScreenGui")
    gui.Name = "SourceKeybinds"
    pcall(function() gui.ResetOnSpawn = false end)
    gui.Parent = pg

    local function label(text, pos, anchor)
        local lbl = IT("TextLabel")
        lbl.BackgroundTransparency = 1
        lbl.BorderSizePixel = 0
        if HUD_FONT then pcall(function() lbl.Font = HUD_FONT end) end
        pcall(function() lbl.FontSize = Enum.FontSize.Size18 end)
        lbl.TextColor3 = C3(1, 1, 1)
        lbl.TextStrokeTransparency = 0
        lbl.TextStrokeColor3 = C3(0, 0, 0)
        lbl.TextXAlignment = (anchor and anchor.X == 1) and Enum.TextXAlignment.Right or Enum.TextXAlignment.Left
        lbl.TextYAlignment = Enum.TextYAlignment.Top
        lbl.Text = text
        lbl.Size = UD2(0, 300, 0, 20)
        lbl.Position = pos
        lbl.Parent = gui
        return lbl
    end

    label("[Z] Teleport", UD2(0, 12, 0, 12))
    label("[CLICK+HOLD] Ban Slam", UD2(0, 12, 0, 34))
    label("[F] Toggle Orbit Parts", UD2(0, 12, 0, 56))
    label("[G] Spawn Dummy", UD2(0, 12, 0, 78))
    label("[T] Taunt", UD2(0, 12, 0, 100))
    label("[Q/E/R/Y/U/I/O/P/V/H/J/K/L/B/X/C] Dances", UD2(0, 12, 0, 122))

    local resetBtn = IT("TextButton")
    resetBtn.BackgroundTransparency = 1
    resetBtn.BorderSizePixel = 0
    resetBtn.AutoButtonColor = false
    if HUD_FONT then pcall(function() resetBtn.Font = HUD_FONT end) end
    pcall(function() resetBtn.FontSize = Enum.FontSize.Size18 end)
    resetBtn.TextColor3 = C3(1, 1, 1)
    resetBtn.TextStrokeTransparency = 0
    resetBtn.TextStrokeColor3 = C3(0, 0, 0)
    resetBtn.TextXAlignment = Enum.TextXAlignment.Left
    resetBtn.TextYAlignment = Enum.TextYAlignment.Top
    resetBtn.Text = "[N] Reset CFrames (click)"
    resetBtn.Size = UD2(0, 300, 0, 20)
    resetBtn.Position = UD2(0, 12, 0, 144)
    resetBtn.Parent = gui
    resetBtn.MouseEnter:Connect(function() hoveringResetBtn = true end)
    resetBtn.MouseLeave:Connect(function() hoveringResetBtn = false end)
    resetBtn.MouseButton1Click:Connect(resetCFrames)

    label("[M] Possess / Release", UD2(1, -12, 0, 12), Vector2.new(1, 0))
    label("[WASD] Move", UD2(1, -12, 0, 34), Vector2.new(1, 0))
    label("[Space] Jump", UD2(1, -12, 0, 56), Vector2.new(1, 0))

    local mark = IT("TextLabel")
    mark.BackgroundTransparency = 1
    mark.BorderSizePixel = 0
    if HUD_FONT then pcall(function() mark.Font = HUD_FONT end) end
    pcall(function() mark.FontSize = Enum.FontSize.Size18 end)
    mark.TextColor3 = C3(1, 1, 1)
    mark.TextStrokeTransparency = 0
    mark.TextStrokeColor3 = C3(0, 0, 0)
    mark.TextXAlignment = Enum.TextXAlignment.Center
    mark.TextYAlignment = Enum.TextYAlignment.Center
    mark.Text = "Script by: Source"
    mark.Size = UD2(0, 300, 0, 20)
    mark.Position = UD2(0.5, -150, 0, 30)
    mark.Parent = gui
end

buildKeybindGui()

Humanoid.Died:Connect(function()
    stopDance()
end)

local wmTime = 0
run.RenderStepped:Connect(function(dt)
    local pg = player:FindFirstChild("PlayerGui")
    if pg then
        local sg = pg:FindFirstChild("SourceKeybinds")
        if sg then
            for _, v in pairs(sg:GetChildren()) do
                if v.Text == "Script by: Source" then
                    wmTime = wmTime + dt
                    v.Position = UD2(0.5, -150, 0, 30 + math.sin(wmTime * 1.5) * 6)
                    v.Rotation = math.sin(wmTime * 2.2) * 6
                end
            end
        end
    end
end)

mouse.Button1Down:connect(function()
    if hoveringResetBtn then return end
    HOLD = true
    if ATTACK == false then BANSLAM() end
end)
mouse.Button1Up:connect(function() HOLD = false end)

mouse.KeyDown:connect(function(key)
    local k = key:lower()
    if k == "z" then teleportForward()
    elseif k == "f" then toggleOrbit()
    elseif k == "g" then spawnDummy()
    elseif k == "m" then togglePossession()
    elseif k == "n" then resetCFrames()
    elseif k == "t" then
        local taunt = taunts[math.random(1, #taunts)]
        notify("Source: " .. taunt)
    elseif danceDefs[k] then
        toggleDance(k)
    elseif k == "w" or k == "a" or k == "s" or k == "d" then held[k] = true
    elseif k == " " then held.space = true end
end)

mouse.KeyUp:connect(function(key)
    local k = key:lower()
    if k == "w" or k == "a" or k == "s" or k == "d" then held[k] = false
    elseif k == " " then held.space = false end
end)

local function updatePossession()
    if not possessed or not possessedRoot or not possessedHum then return end
    if not possessedRoot.Parent or not possessedHum.Parent then stopPossession() return end
    local cam = world.CurrentCamera
    local fwd = VT(cam.CFrame.lookVector.x, 0, cam.CFrame.lookVector.z)
    local right = VT(cam.CFrame.rightVector.x, 0, cam.CFrame.rightVector.z)
    if fwd.Magnitude > 0.001 then fwd = fwd.unit end
    if right.Magnitude > 0.001 then right = right.unit end
    local move = VT(0, 0, 0)
    if held.w then move = move + fwd end
    if held.s then move = move - fwd end
    if held.d then move = move + right end
    if held.a then move = move - right end
    local root = possessedRoot
    local v = root.Velocity
    if move.Magnitude > 0.01 then
        move = move.unit
        root.Velocity = VT(move.x * 25, v.y, move.z * 25)
        root.CFrame = CF(root.Position) * ANGLES(0, math.atan2(-move.x, -move.z), 0)
    else
        root.Velocity = VT(0, v.y, 0)
    end
    if held.space then root.Velocity = VT(root.Velocity.x, 50, root.Velocity.z) end
end

while true do
    Swait()
    if ANIMATE then ANIMATE.Parent = nil end
    SINE = SINE + CHANGE
    local TORSOVELOCITY = (RootPart.Velocity * VT(1, 0, 1)).magnitude
    local TORSOVERTICALVELOCITY = RootPart.Velocity.y
    local HITFLOOR = Raycast(RootPart.Position, (CF(RootPart.Position, RootPart.Position + VT(0, -1, 0))).lookVector, 4, Character)
    local WALKSPEEDVALUE = 6 / (Humanoid.WalkSpeed / 16)

    if activeDance and TORSOVELOCITY > 1 then
        stopDance()
    end

    if activeDance and ATTACK == false then
        applyDancePoses()
        HandleWeld.C0 = Clerp(HandleWeld.C0, CF(0, -0.8, 0) * ANGLES(RAD(-90), RAD(0), RAD(0)), 0.2 / Animation_Speed)
    else
        if ATTACK == false then
            RightShoulder.C0 = Clerp(RightShoulder.C0, CF(1.5, 0, 0) * ANGLES(RAD(200), RAD(90), RAD(0)) * RIGHTSHOULDERC0, 0.2 / Animation_Speed)
            HandleWeld.C0 = Clerp(HandleWeld.C0, CF(0, -0.8, 0) * ANGLES(RAD(-90), RAD(0), RAD(0)), 0.2 / Animation_Speed)
        end

        if ANIM == "Walk" and TORSOVELOCITY > 1 and ATTACK == false then
            RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, -0.15 * COS(SINE / (WALKSPEEDVALUE / 2))) * ANGLES(RAD(0), RAD(0) - RootPart.RotVelocity.Y / 75, RAD(0)), 2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
            Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(2.5 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0) - Head.RotVelocity.Y / 30), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
            RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 0.875 - 0.125 * SIN(SINE / WALKSPEEDVALUE), -0.125 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0) - RightLeg.RotVelocity.Y / 75, RAD(0), RAD(76 * COS(SINE / WALKSPEEDVALUE))), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
            LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 0.875 + 0.125 * SIN(SINE / WALKSPEEDVALUE), 0.125 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0) + LeftLeg.RotVelocity.Y / 75, RAD(0), RAD(76 * COS(SINE / WALKSPEEDVALUE))), 0.2 * (Humanoid.WalkSpeed / 16) / Animation_Speed)
        elseif (ANIM ~= "Walk") or (TORSOVELOCITY < 1) or (ATTACK == true) then
            RootJoint.C1 = Clerp(RootJoint.C1, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
            Neck.C1 = Clerp(Neck.C1, CF(0, -0.5, 0) * ANGLES(RAD(-90), RAD(0), RAD(180)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
            RightHip.C1 = Clerp(RightHip.C1, CF(0.5, 1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
            LeftHip.C1 = Clerp(LeftHip.C1, CF(-0.5, 1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
        end

        if TORSOVERTICALVELOCITY > 1 and HITFLOOR == nil then
            ANIM = "Jump"
            if ATTACK == false then
                RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
                Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(-20), RAD(0), RAD(0)), 0.2 / Animation_Speed)
                LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-40), RAD(0), RAD(-20)) * LEFTSHOULDERC0, 0.2 / Animation_Speed)
                RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, -0.3) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(-20)), 0.2 / Animation_Speed)
                LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, -0.3) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-5), RAD(0), RAD(20)), 0.2 / Animation_Speed)
            end
        elseif TORSOVERTICALVELOCITY < -1 and HITFLOOR == nil then
            ANIM = "Fall"
            if ATTACK == false then
                RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.2 / Animation_Speed)
                Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(20), RAD(0), RAD(0)), 0.2 / Animation_Speed)
                LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-60)) * LEFTSHOULDERC0, 0.2 / Animation_Speed)
                RightHip.C0 = Clerp(RightHip.C0, CF(1, -1, 0) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(20)), 0.2 / Animation_Speed)
                LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1, 0) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(10)), 0.2 / Animation_Speed)
            end
        elseif TORSOVELOCITY < 1 and HITFLOOR ~= nil then
            ANIM = "Idle"
            if ATTACK == false then
                RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, 0 + 0.05 * COS(SINE / 12)) * ANGLES(RAD(0), RAD(0), RAD(0)), 0.15 / Animation_Speed)
                Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(0 - 2.5 * SIN(SINE / 12)), RAD(0), RAD(0)), 0.15 / Animation_Speed)
                LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(0), RAD(0), RAD(-12)) * LEFTSHOULDERC0, 0.15 / Animation_Speed)
                RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / Animation_Speed)
                LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.05 * COS(SINE / 12), -0.01) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(-8), RAD(0), RAD(0)), 0.15 / Animation_Speed)
            end
        elseif TORSOVELOCITY > 1 and HITFLOOR ~= nil then
            ANIM = "Walk"
            if ATTACK == false then
                RootJoint.C0 = Clerp(RootJoint.C0, ROOTC0 * CF(0, 0, -0.1) * ANGLES(RAD(5), RAD(0), RAD(0)), 0.15 / Animation_Speed)
                Neck.C0 = Clerp(Neck.C0, NECKC0 * CF(0, 0, 0 + ((1) - 1)) * ANGLES(RAD(5 - 8 * SIN(SINE / (WALKSPEEDVALUE / 2))), RAD(0), RAD(0)), 0.15 / Animation_Speed)
                LeftShoulder.C0 = Clerp(LeftShoulder.C0, CF(-1.5, 0.5, 0) * ANGLES(RAD(-60 * COS(SINE / WALKSPEEDVALUE)), RAD(0), RAD(-5)) * LEFTSHOULDERC0, 0.35 / Animation_Speed)
                RightHip.C0 = Clerp(RightHip.C0, CF(1, -1 - 0.15 * COS(SINE / WALKSPEEDVALUE * 2), -0.2 + 0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(-15)), 2 / Animation_Speed)
                LeftHip.C0 = Clerp(LeftHip.C0, CF(-1, -1 - 0.15 * COS(SINE / WALKSPEEDVALUE * 2), -0.2 + -0.2 * COS(SINE / WALKSPEEDVALUE)) * ANGLES(RAD(0), RAD(-90), RAD(0)) * ANGLES(RAD(0), RAD(0), RAD(15)), 2 / Animation_Speed)
            end
        end
    end

    if RootPart.Position.y < -50 then
        RootPart.CFrame = CF(RootPart.Position.x, 60, RootPart.Position.z)
        RootPart.Velocity = VT(0, 0, 0)
    end
    updatePossession()

    if TORSOVELOCITY > 1 and HITFLOOR ~= nil and ATTACK == false and not possessed then
        walkRippleTimer = walkRippleTimer + 0.033
        if walkRippleTimer >= 0.22 then
            walkRippleTimer = 0
            
            local ignoreRipple = {Character}
            for _, d in pairs(dummies) do if d.m then table.insert(ignoreRipple, d.m) end end
            for _, g in pairs(ghosts) do if g.m then table.insert(ignoreRipple, g.m) end end
            for _, v in pairs(world:GetChildren()) do
                if v.Name == "WalkRipple" or v.Name == "RainDrop" or v.Name == "BlackSpikes" or v.Name == "OrbitPart" then
                    table.insert(ignoreRipple, v)
                end
            end

            local h, pos = world:FindPartOnRayWithIgnoreList(Ray.new(RootPart.Position, VT(0, -8, 0)), ignoreRipple)
            if h and pos then
                local ripple = IT("Part")
                ripple.Name = "WalkRipple"
                ripple.Shape = Enum.PartType.Cylinder
                ripple.Size = VT(0.08, 2.5, 2.5)
                ripple.Color = C3(0, 0, 0)
                ripple.Material = Enum.Material.Neon
                ripple.Anchored = true
                ripple.CanCollide = false
                ripple.Transparency = 0.15
                ripple.CFrame = CF(pos) * ANGLES(0, 0, RAD(90))
                ripple.Parent = world

                coroutine.resume(coroutine.create(function()
                    local start = tick()
                    local dur = 0.5
                    while ripple.Parent and tick() - start < dur do
                        local a = (tick() - start) / dur
                        local dia = 2.5 + a * 8
                        ripple.Size = VT(0.08, dia, dia)
                        ripple.Transparency = 0.15 + a * 0.85
                        Swait()
                    end
                    if ripple.Parent then ripple:Destroy() end
                end))
            end
        end
    else
        walkRippleTimer = 0
    end

    if Humanoid then
        Humanoid.MaxHealth = INF_HEALTH
        Humanoid.Health = INF_HEALTH
        if Rooted then
            Humanoid.WalkSpeed = 0
        else
            Humanoid.WalkSpeed = Speed
        end
    end

    timer = timer + 0.033
    if timer >= 0.50 then
        timer = timer % 0.50
        if not possessed then activateEffects() end
    end

    if orbitState ~= "off" then
        for i = #orbitParts, 1, -1 do
            local data = orbitParts[i]
            local p = data.part
            if p and p.Parent then
                data.angle = data.angle + data.speed * 0.05
                local x = RootPart.Position.X + math.cos(data.angle) * data.dist
                local z = RootPart.Position.Z + math.sin(data.angle) * data.dist
                local y = RootPart.Position.Y + data.yOffset + math.sin(data.angle * 2) * 2
                local targetPos = VT(x, y, z)

                if orbitState == "on" then
                    p.Velocity = VT(0, 0, 0)
                    p.RotVelocity = VT(0, 0, 0)
                    
                    if data.pointChance > 0.6 then
                        p.CFrame = CF(targetPos, RootPart.Position) * ANGLES(math.pi/2, 0, 0)
                    else
                        data.rotX = data.rotX + 0.05
                        data.rotY = data.rotY + 0.05
                        p.CFrame = CF(targetPos) * ANGLES(data.rotX, data.rotY, data.rotZ)
                    end
                elseif orbitState == "dying" then
                    if orbitTimer < 60 then
                        p.Velocity = VT(0, 0, 0)
                        p.RotVelocity = VT(0, 0, 0)
                        local upCF = CF(targetPos)
                        p.CFrame = Clerp(p.CFrame, upCF, 0.1) 
                    else
                        p.Velocity = VT(0, -100, 0)
                        p.RotVelocity = VT(0, 0, 0)
                        p.Transparency = math.min(1, p.Transparency + 0.05)
                        
                        if p.Position.Y < RootPart.Position.Y - 20 or p.Transparency >= 1 then
                            p:Destroy()
                            table.remove(orbitParts, i)
                        end
                    end
                end
            else
                table.remove(orbitParts, i)
            end
        end

        if orbitState == "dying" then
            orbitTimer = orbitTimer + 1
            if #orbitParts == 0 then
                orbitState = "off"
                orbitTimer = 0
            end
        end
    end

    for i = #ghosts, 1, -1 do
        local d = ghosts[i]
        d.t = d.t + 0.033; d.f = d.f + 0.033
        if d.t >= 0.75 or not d.m.Parent then
            if d.m.Parent then d.m:Destroy() end
            table.remove(ghosts, i)
        elseif d.f >= 0.05 then
            d.f = 0
            local a = math.min(d.t / 0.75, 1)
            for _, v in pairs(d.p) do
                if v.p.Parent then
                    v.p.CFrame = v.c * CF(v.o * a) * ANGLES(v.a.x * a, v.a.y * a, v.a.z * a)
                    v.p.Color = C3(0, 0, 0); v.p.Transparency = math.min(v.z + (1 - v.z) * a, 1)
                end
            end
        end
    end

    for i = #spikesList, 1, -1 do
        local d = spikesList[i]
        d.t = d.t + 0.033
        if d.t >= d.life or not d.m.Parent then
            if d.m.Parent then d.m:Destroy() end
            table.remove(spikesList, i)
        else
            local a = math.min(d.t / 0.3, 1)
            local fade = math.max(0, (d.t - 0.3) / 0.35)
            for _, v in pairs(d.p) do
                if v.p.Parent then
                    local height = math.max(v.h * a, 0.01)
                    v.p.Size = VT(v.w, height, v.w); v.p.CFrame = CF(v.x, v.y + height / 2, v.z) * v.r
                    v.p.Transparency = math.min(fade, 1)
                end
            end
        end
    end
end

--//====================================================\\--
--||			  		 END OF SCRIPT
--\\====================================================//--
