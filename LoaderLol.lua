local LOAD_STRING = [[
    print("Hello from loader!")
]]

local LOAD_DELAY = 2.0

local CONFIG = {
    Title = "Ro-Admin",
    Subtitle = "Made by : Nexpulvia,SigmaLigma49",
    Discord = "Discord : Nexpulvia",
    IntroMusicID = "608600954",
    ClickSoundID = "178104975",
    Sound2ID = "255881176",
    LineSoundID = "151414336",
    TitleColor = Color3.fromRGB(255, 0, 0),
    SubtitleColor = Color3.new(1, 1, 1),
    DiscordColor = Color3.new(1, 1, 1),
    BackgroundColor = Color3.new(0, 0, 0),
    WaitTime1 = 1.0,
    WaitTime2 = 0.8,
    WaitTime3 = 1.5,
    WaitTime4 = 0.2,
    WaitTime5 = 0.5,
    FinalWait = 1.5,
    EnableSounds = true,
}

local playerGui = game.Players.LocalPlayer.PlayerGui

local function createSound(id, volume, parent)
    if CONFIG.EnableSounds and id then
        local s = Instance.new("Sound", parent or playerGui)
        s.SoundId = "rbxassetid://" .. id
        s.Volume = volume or 10
        return s
    end
    return nil
end

local Clicksound = createSound(CONFIG.ClickSoundID, 100)
local IntroSong = createSound(CONFIG.IntroMusicID, 10)
local Sound2 = createSound(CONFIG.Sound2ID, 4)
local LineSound = createSound(CONFIG.LineSoundID, 6)

local Exploit = Instance.new("ScreenGui")
Exploit.Name = "LoaderGui"
Exploit.Parent = playerGui
Exploit.ResetOnSpawn = false

local BG = Instance.new("Frame")
BG.Name = "BG"
BG.BackgroundColor3 = CONFIG.BackgroundColor
BG.BackgroundTransparency = 0.58
BG.BorderSizePixel = 0
BG.ClipsDescendants = true
BG.Parent = Exploit
BG.Size = UDim2.new(0, 460, 0, 0)
BG.Position = UDim2.new(0, 380, 0, 0)
BG.Visible = true

local Intro = Instance.new("Frame")
Intro.Name = "Intro"
Intro.Parent = BG
Intro.BackgroundColor3 = CONFIG.BackgroundColor
Intro.BackgroundTransparency = 1
Intro.BorderColor3 = Color3.new(0, 0, 0)
Intro.BorderSizePixel = 3
Intro.ClipsDescendants = true
Intro.Position = UDim2.new(0, 0, 0, 0)
Intro.Size = UDim2.new(0, 460, 0, 310)

local rowreck = Instance.new("TextLabel")
rowreck.Name = "Title"
rowreck.Parent = Intro
rowreck.BackgroundTransparency = 1
rowreck.Position = UDim2.new(0, 140, 0, 120)
rowreck.Size = UDim2.new(0, 200, 0, 50)
rowreck.Font = Enum.Font.SciFi
rowreck.FontSize = Enum.FontSize.Size42
rowreck.Text = CONFIG.Title
rowreck.TextColor3 = CONFIG.TitleColor
rowreck.TextSize = 42
rowreck.TextTransparency = 1

local me = Instance.new("TextLabel")
me.Name = "Subtitle"
me.Parent = Intro
me.BackgroundTransparency = 1
me.Position = UDim2.new(0, 470, 0, 70)
me.Size = UDim2.new(0, 200, 0, 50)
me.Font = Enum.Font.SciFi
me.FontSize = Enum.FontSize.Size24
me.Text = CONFIG.Subtitle
me.TextColor3 = CONFIG.SubtitleColor
me.TextSize = 24

local discord = Instance.new("TextLabel")
discord.Name = "Discord"
discord.Parent = Intro
discord.BackgroundTransparency = 1
discord.Position = UDim2.new(0, -230, 0, 160)
discord.Size = UDim2.new(0, 200, 0, 50)
discord.Font = Enum.Font.SciFi
discord.FontSize = Enum.FontSize.Size24
discord.Text = CONFIG.Discord
discord.TextColor3 = CONFIG.DiscordColor
discord.TextSize = 24

local function makeLine(name, y)
    local l = Instance.new("TextLabel")
    l.Name = name
    l.Parent = Intro
    l.BackgroundTransparency = 1
    l.Position = UDim2.new(0, 130, 0, y)
    l.Size = UDim2.new(0, 0, 0, 0)
    l.Text = ""
    return l
end

local LineOne = makeLine("LineOne", 120)
local LineTw0 = makeLine("LineTw0", 175)
local LineThree = makeLine("LineThree", 10)
local LineFour = makeLine("LineFour", 45)

local O = Instance.new("TextLabel")
O.Parent = Intro
O.BackgroundTransparency = 1
O.Position = UDim2.new(0, 120, 0, 80)
O.Size = UDim2.new(0, 0, 0, 0)
O.Text = ""

local T = Instance.new("TextLabel")
T.Parent = Intro
T.BackgroundTransparency = 1
T.Position = UDim2.new(0, 100, 0, 200)
T.Size = UDim2.new(0, 0, 0, 0)
T.Text = ""

local W = CONFIG

wait(1)

if IntroSong then
    IntroSong.PlaybackSpeed = 1.3
    IntroSong:Play()
end

BG:TweenSize(UDim2.new(0, 460, 0, 310), "Out")
wait(W.WaitTime1)

if Sound2 then Sound2:Play() end
me:TweenPosition(UDim2.new(0, 140, 0, 70), "Out")
wait(W.WaitTime2)

if Sound2 then Sound2:Play() end
discord:TweenPosition(UDim2.new(0, 140, 0, 160), "Out")
O:TweenSize(UDim2.new(0, 240, 0, 0), "Out")
T:TweenSize(UDim2.new(0, 280, 0, 0), "Out")

for i = 1, 0, -0.1 do
    O.BackgroundTransparency = i
    T.BackgroundTransparency = i
    wait()
end

wait(W.WaitTime3)

if LineSound then LineSound:Play() end
O:TweenSize(UDim2.new(0, 0, 0, 0), "Out")
wait(W.WaitTime4)

if LineSound then LineSound:Play() end
T:TweenSize(UDim2.new(0, 0, 0, 0), "Out")
for i = 0, 1, 0.1 do
    O.BackgroundTransparency = i
    T.BackgroundTransparency = i
    wait()
end

wait(W.WaitTime5)
me:TweenPosition(UDim2.new(0, 140, 0, 70), "Out")
wait(W.WaitTime2)

discord:TweenPosition(UDim2.new(0, 140, 0, 300), "Out")
wait(1)

for i = 1, 0, -0.1 do
    LineOne.BackgroundTransparency = i
    LineTw0.BackgroundTransparency = i
    LineThree.BackgroundTransparency = i
    LineFour.BackgroundTransparency = i
    wait()
end

if LineSound then LineSound:Play() end
LineThree:TweenSize(UDim2.new(0, 220, 0, 0), "Out")
if LineSound then LineSound:Play() end
LineFour:TweenSize(UDim2.new(0, 220, 0, 0), "Out")
wait(W.WaitTime4)

if LineSound then LineSound:Play() end
LineOne:TweenSize(UDim2.new(0, 220, 0, 0), "Out")
if LineSound then LineSound:Play() end
LineTw0:TweenSize(UDim2.new(0, 220, 0, 0), "Out")

if Sound2 then
    Sound2.PlaybackSpeed = 1.2
    wait(W.WaitTime1)
    Sound2:Play()
end

for i = 1, 0, -0.05 do
    rowreck.TextTransparency = i
    wait()
end

for i = 0, 255, 17 do
    rowreck.TextColor3 = Color3.fromRGB(255, i, 0)
    wait()
end
for i = 255, 0, -17 do
    rowreck.TextColor3 = Color3.fromRGB(i, 255, 0)
    wait()
end
for i = 0, 255, 17 do
    rowreck.TextColor3 = Color3.fromRGB(0, 255, i)
    wait()
end
for i = 255, 0, -17 do
    rowreck.TextColor3 = Color3.fromRGB(0, i, 255)
    wait()
end

for i = 0, 1, 0.05 do
    rowreck.TextTransparency = i
    wait()
end
rowreck.TextTransparency = 1

LineTw0:TweenSize(UDim2.new(0, 0, 0, 0), "Out")
if LineSound then LineSound:Play() end
LineOne:TweenSize(UDim2.new(0, 0, 0, 0), "Out")
if LineSound then LineSound:Play() end
wait(W.WaitTime4)

LineFour:TweenSize(UDim2.new(0, 0, 0, 0), "Out")
if LineSound then LineSound:Play() end
LineThree:TweenSize(UDim2.new(0, 0, 0, 0), "Out")
if LineSound then LineSound:Play() end
wait(W.WaitTime1)

for i = 0, 1, 0.1 do
    LineOne.BackgroundTransparency = i
    LineTw0.BackgroundTransparency = i
    LineThree.BackgroundTransparency = i
    LineFour.BackgroundTransparency = i
    wait()
end

wait(W.WaitTime1)

for i = 0, 1, 0.2 do
    me.TextTransparency = i
    wait()
end

me:TweenPosition(UDim2.new(0, 210, 0, 0), "Out")
BG:TweenSize(UDim2.new(0, 550, 0, 0), "Out")
BG:TweenPosition(UDim2.new(0, 380, 0, 0), "Out")

wait(W.FinalWait)
wait(LOAD_DELAY)

local success, err = pcall(function()
    loadstring(LOAD_STRING)()
end)

if not success then
    warn("Loader error: " .. tostring(err))
end

Exploit:Destroy()
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
