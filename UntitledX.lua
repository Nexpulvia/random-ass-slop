
local repo = "https://raw.githubusercontent.com/cloudsense-pub/UELinoriaLib/main/"

local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = getgenv().Options
local Toggles = getgenv().Toggles

Library.ShowToggleFrameInKeybinds = true 
Library.ShowCustomCursor = false 
Library.NotifySide = "Left" 

local Window = Library:CreateWindow({
	Title = "UntitledX",
	Center = true,
	AutoShow = true,
	Resizable = true,
	ShowCustomCursor = false, 
	UnlockMouseWhileOpen = true,
	NotifySide = "Left",
	TabPadding = 8,
	MenuFadeTime = 0.2
})

local Tabs = {
	Main = Window:AddTab("Main"),
	ESP = Window:AddTab("ESP"),
    Combat = Window:AddTab("Combat"),
	["UI Settings"] = Window:AddTab("UI Settings"),
}

local CrosshairGroupBox = Tabs.Main:AddLeftGroupbox("Crosshair Settings")
local ScreenControlsGroupBox = Tabs.Main:AddLeftGroupbox("Screen & FOV Controls")
local MovementGroupBox = Tabs.Main:AddLeftGroupbox("Movement & Utility")
local CombatEffectsGroupBox = Tabs.Main:AddRightGroupbox("Combat Effects")

-- Groupboxes for Combat Aim Settings
local AimMasterGroupBox = Tabs.Combat:AddLeftGroupbox("Aim Assistance Configuration")
local AimVisualsGroupBox = Tabs.Combat:AddRightGroupbox("Target Visuals")

local ESPMainGroupBox = Tabs.ESP:AddLeftGroupbox("Master Configuration")
local ESPSpoofGroupBox = Tabs.ESP:AddLeftGroupbox("Global Client Identity Spoofing")
local ESPVisualsGroupBox = Tabs.ESP:AddRightGroupbox("Visual Appearance")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local localPlayer = Players.LocalPlayer
local camera = Workspace.CurrentCamera
local mouse = localPlayer:GetMouse()

local ControlModule = nil
pcall(function()
    ControlModule = require(localPlayer:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
end)

-------------------------------------------------------------------------------
-- Server Position Ghost Visual Tracking Data
-------------------------------------------------------------------------------
local GhostPartsCache = {}
local PositionHistoryFrames = {}
local GhostActiveParts = {
    "HumanoidRootPart", "Head", "Left Arm", "Right Arm", "Left Leg", "Right Leg",
    "LeftUpperArm", "RightUpperArm", "LeftLowerArm", "RightLowerArm",
    "LeftHand", "RightHand", "LeftUpperLeg", "RightUpperLeg",
    "LeftLowerLeg", "RightLowerLeg", "LeftFoot", "RightFoot"
}

local function ClearGhostCache()
    for _, item in pairs(GhostPartsCache) do
        if item.ghost then item.ghost:Destroy() end
    end
    table.clear(GhostPartsCache)
end

local function ConstructGhostLimb(realPart)
    local ghost = Instance.new("Part")
    ghost.Name = realPart.Name .. "_LocalGhost"
    ghost.Size = realPart.Size
    ghost.Anchored = true
    ghost.CanCollide = false
    ghost.Transparency = 1
    ghost.Parent = Workspace
    
    local box = Instance.new("SelectionBox")
    box.Adornee = ghost
    box.LineThickness = 0.04
    box.Color3 = Color3.fromRGB(255, 255, 255)
    box.Parent = ghost
    
    return { real = realPart, ghost = ghost, box = box }
end

local function SynchronizeGhostRig()
    ClearGhostCache()
    local char = localPlayer.Character
    if not char then return end
    
    for _, limbName in ipairs(GhostActiveParts) do
        local part = char:FindFirstChild(limbName)
        if part and part:IsA("BasePart") then
            GhostPartsCache[limbName] = ConstructGhostLimb(part)
        end
    end
end

-------------------------------------------------------------------------------
-- Drawing API Physics Trajectory Engine Workspace Objects
-------------------------------------------------------------------------------
local DrawCircle = Drawing.new("Circle")
DrawCircle.Radius = 6
DrawCircle.Filled = true
DrawCircle.Color = Color3.fromRGB(0, 255, 255)
DrawCircle.Visible = false
DrawCircle.NumSides = 32

local DrawLandDot = Drawing.new("Circle")
DrawLandDot.Radius = 12
DrawLandDot.Filled = true
DrawLandDot.Color = Color3.fromRGB(255, 100, 100)
DrawLandDot.Visible = false
DrawLandDot.NumSides = 32

local DrawLandOutline = Drawing.new("Circle")
DrawLandOutline.Radius = 18
DrawLandOutline.Filled = false
DrawLandOutline.Color = Color3.fromRGB(255, 150, 150)
DrawLandOutline.Visible = false
DrawLandOutline.Thickness = 2
DrawLandOutline.NumSides = 32

local AimFOVCircle = Drawing.new("Circle")
AimFOVCircle.Filled = false
AimFOVCircle.Color = Color3.fromRGB(255, 255, 255)
AimFOVCircle.Thickness = 1
AimFOVCircle.Visible = false
AimFOVCircle.NumSides = 64

local MainArcLines = {}
for i = 1, 29 do
    local line = Drawing.new("Line")
    line.Color = Color3.fromRGB(255, 240, 140)
    line.Thickness = 2
    line.Visible = false
    MainArcLines[i] = line
end

local PreJumpArcLines = {}
for i = 1, 29 do
    local line = Drawing.new("Line")
    line.Color = Color3.fromRGB(100, 200, 255)
    line.Thickness = 2
    line.Visible = false
    line.Transparency = 0.7
    PreJumpArcLines[i] = line
end

local PreJumpLandDot = Drawing.new("Circle")
PreJumpLandDot.Radius = 10
PreJumpLandDot.Filled = true
PreJumpLandDot.Color = Color3.fromRGB(100, 200, 255)
PreJumpLandDot.Visible = false
PreJumpLandDot.NumSides = 32

local VelocityCurves = {}
for i = 1, 8 do
    local line = Drawing.new("Line")
    line.Color = Color3.fromRGB(0, 255, 0)
    line.Thickness = 3
    line.Visible = false
    VelocityCurves[i] = line
end

local LastTrackedLanding = nil
local AirborneFlag = false
local PreJumpLastMoveInput = Vector3.new(0, 0, 1)
local DynamicCameraTurnSpeed = 0
local LastCameraCFramePosition = camera.CFrame

local function SolveTrajectoryPosition(p0, v0, elapsed)
    local gravityForce = Workspace.Gravity
    return p0 + v0 * elapsed + Vector3.new(0, -gravityForce, 0) * 0.5 * elapsed * elapsed
end

local function GetScreenPoint(worldPosition)
    local viewportPoint, isPointOnscreen = camera:WorldToViewportPoint(worldPosition)
    return Vector2.new(viewportPoint.X, viewportPoint.Y), isPointOnscreen
end

local function ValidateRayVisibility(targetPosition, targetCharacter)
    local parameters = RaycastParams.new()
    local exceptions = { localPlayer.Character }
    if targetCharacter then table.insert(exceptions, targetCharacter) end
    parameters.FilterDescendantsInstances = exceptions
    parameters.FilterType = Enum.RaycastFilterType.Exclude
    
    local origin = camera.CFrame.Position
    local pathVector = targetPosition - origin
    local magnitude = pathVector.Magnitude
    
    if magnitude < 2 then return true end
    local castCheck = Workspace:Raycast(origin, pathVector, parameters)
    if castCheck and (castCheck.Position - origin).Magnitude < magnitude - 2 then
        return false
    end
    return true
end

local function CheckGroundedStatus(rootPart)
    local parameters = RaycastParams.new()
    parameters.FilterDescendantsInstances = { localPlayer.Character }
    parameters.FilterType = Enum.RaycastFilterType.Exclude
    return Workspace:Raycast(rootPart.Position, Vector3.new(0, -3, 0), parameters) ~= nil
end

local function RunTrajectorySimulation(p0, v0)
    local recordedPoints = {}
    local baselinePrevious = p0
    local confirmedImpact = nil
    
    local parameters = RaycastParams.new()
    parameters.FilterDescendantsInstances = { localPlayer.Character }
    parameters.FilterType = Enum.RaycastFilterType.Exclude
    
    for elapsed = 0, 2.5, 0.03 do
        local positionSample = SolveTrajectoryPosition(p0, v0, elapsed)
        table.insert(recordedPoints, positionSample)
        
        local segmentDelta = positionSample - baselinePrevious
        if segmentDelta.Magnitude > 0.01 then
            local segmentImpact = Workspace:Raycast(baselinePrevious, segmentDelta, parameters)
            if segmentImpact then
                confirmedImpact = segmentImpact.Position
                break
            end
        end
        baselinePrevious = positionSample
    end
    
    if not confirmedImpact and #recordedPoints > 0 then
        local ultimateSample = recordedPoints[#recordedPoints]
        local groundCheck = Workspace:Raycast(ultimateSample + Vector3.new(0, 1, 0), Vector3.new(0, -5000, 0), parameters)
        if groundCheck then
            confirmedImpact = groundCheck.Position
        end
    end
    return recordedPoints, confirmedImpact
end

local function ResetDrawingGraphicsVisibility()
    DrawCircle.Visible = false
    DrawLandDot.Visible = false
    DrawLandOutline.Visible = false
    PreJumpLandDot.Visible = false
    for i = 1, 29 do MainArcLines[i].Visible = false PreJumpArcLines[i].Visible = false end
    for i = 1, 8 do VelocityCurves[i].Visible = false end
end

local function TriggerJoinNotification(playerName)
    local customTag = Options.JoinNotifyTag and Options.JoinNotifyTag.Value or "+"
    Library:Notify(string.format("[%s] %s has joined the server.", customTag, playerName), 4)
end

local function NotifyPlayerJoin(player)
    if player == localPlayer then return end
    if Toggles.JoinNotifyToggle and Toggles.JoinNotifyToggle.Value then
        TriggerJoinNotification(player.Name)
    end
end

Players.PlayerAdded:Connect(NotifyPlayerJoin)

-------------------------------------------------------------------------------
-- Dynamic Player ESP Management
-------------------------------------------------------------------------------
local ESP_Highlights = {}
local ESP_Boxes = {}

local function CreateESPForPlayer(targetPlayer)
    if targetPlayer == localPlayer then return end
    
    local function setup(character)
        if not character then return end
        local rootPart = character:WaitForChild("HumanoidRootPart", 7)
        local head = character:WaitForChild("Head", 7)
        local humanoid = character:WaitForChild("Humanoid", 7)
        if not rootPart or not head or not humanoid then return end
        
        if ESP_Highlights[targetPlayer] then ESP_Highlights[targetPlayer]:Destroy() end
        if ESP_Boxes[targetPlayer] then ESP_Boxes[targetPlayer]:Destroy() end

        local highlight = Instance.new("Highlight")
        highlight.Name = "UntitledX_ESP"
        highlight.Adornee = character
        highlight.Parent = character
        ESP_Highlights[targetPlayer] = highlight

        local billboard = Instance.new("BillboardGui")
        billboard.Name = "UntitledX_BoxESP"
        billboard.AlwaysOnTop = true
        billboard.Size = UDim2.new(4.5, 0, 5.5, 0) 
        billboard.ExtentsOffsetWorldSpace = Vector3.new(0, 0, 0)
        
        local boxFrame = Instance.new("Frame")
        boxFrame.Name = "BoxBorder"
        boxFrame.BackgroundTransparency = 1
        boxFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        boxFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
        boxFrame.Size = UDim2.new(1, 0, 1, 0)
        
        local stroke = Instance.new("UIStroke")
        stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        stroke.LineJoinMode = Enum.LineJoinMode.Miter
        stroke.Parent = boxFrame

        local solidFill = Instance.new("Frame")
        solidFill.Name = "SolidFill"
        solidFill.BorderSizePixel = 0
        solidFill.Size = UDim2.new(1, 0, 1, 0)
        solidFill.ZIndex = 1
        solidFill.Parent = boxFrame

        local textureOverlay = Instance.new("ImageLabel")
        textureOverlay.Name = "TextureOverlay"
        textureOverlay.BackgroundTransparency = 1
        textureOverlay.BorderSizePixel = 0
        textureOverlay.Size = UDim2.new(1, 0, 1, 0)
        textureOverlay.ZIndex = 2
        textureOverlay.Parent = boxFrame

        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "ESPNameTag"
        nameLabel.BackgroundTransparency = 1
        nameLabel.Size = UDim2.new(1, 0, 0.2, 0)
        nameLabel.Position = UDim2.new(0, 0, -0.25, 0)
        nameLabel.Font = Enum.Font.SourceSansBold
        nameLabel.TextSize = 14
        nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        nameLabel.TextStrokeTransparency = 0
        nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        nameLabel.Text = targetPlayer.Name
        nameLabel.Parent = boxFrame

        boxFrame.Parent = billboard
        billboard.Adornee = rootPart
        billboard.Parent = rootPart
        ESP_Boxes[targetPlayer] = billboard
    end

    targetPlayer.CharacterAdded:Connect(setup)
    if targetPlayer.Character then setup(targetPlayer.Character) end
end

Players.PlayerRemoving:Connect(function(plr)
    if ESP_Highlights[plr] then ESP_Highlights[plr]:Destroy() ESP_Highlights[plr] = nil end
    if ESP_Boxes[plr] then ESP_Boxes[plr]:Destroy() ESP_Boxes[plr] = nil end
end)

for _, p in ipairs(Players:GetPlayers()) do CreateESPForPlayer(p) end
Players.PlayerAdded:Connect(CreateESPForPlayer)

-- ESP Elements Configuration
ESPMainGroupBox:AddToggle("ESPMaster", { Text = "Master ESP Enable", Default = false })
ESPMainGroupBox:AddDivider()
ESPMainGroupBox:AddToggle("JoinNotifyToggle", { Text = "Enable Join Notifications", Default = true })
ESPMainGroupBox:AddInput("JoinNotifyTag", { Default = "+", Text = "Custom Bracket Tag" })

-- Advanced Identity Spoofing Core Configurations
ESPSpoofGroupBox:AddToggle("IdentitySpoofToggle", { Text = "Enable Master Identity Spoof", Default = false })
ESPSpoofGroupBox:AddInput("SpoofedUsername", { Default = "", Text = "Custom Username Override" })
ESPSpoofGroupBox:AddInput("SpoofedDisplayName", { Default = "", Text = "Custom Display Name Override" })

ESPVisualsGroupBox:AddToggle("ServerPosGhost", { Text = "Server Pos Ghost", Default = false })
ESPVisualsGroupBox:AddToggle("GhostRGB", { Text = "Ghost RGB Rainbow", Default = true })
ESPVisualsGroupBox:AddSlider("GhostMaxLimb", { Text = "Max Extension Boundary", Default = 6, Min = 1, Max = 15, Rounding = 1 })
ESPVisualsGroupBox:AddDivider()

ESPVisualsGroupBox:AddToggle("ESPGlowFill", { Text = "Enable Glow & Fill", Default = false }):AddColorPicker("FillColor", { Default = Color3.fromRGB(255, 0, 0), Title = "Fill Color" }):AddColorPicker("OutlineColor", { Default = Color3.fromRGB(255, 255, 255), Title = "Outline Color" })
ESPVisualsGroupBox:AddSlider("FillTransparency", { Text = "Fill Transparency", Default = 0.5, Min = 0, Max = 1, Rounding = 1 })
ESPVisualsGroupBox:AddSlider("OutlineTransparency", { Text = "Outline Transparency", Default = 0, Min = 0, Max = 1, Rounding = 1 })
ESPVisualsGroupBox:AddDivider()
ESPVisualsGroupBox:AddToggle("ESPBoxes", { Text = "Enable Boxes", Default = false }):AddColorPicker("BoxColor", { Default = Color3.fromRGB(0, 255, 0), Title = "Box Color" })
ESPVisualsGroupBox:AddSlider("BoxThickness", { Text = "Box Border Thickness", Default = 2, Min = 1, Max = 5, Rounding = 0 })
ESPVisualsGroupBox:AddToggle("ESPBoxFill", { Text = "Enable Box Solid Fill", Default = false }):AddColorPicker("BoxFillColor", { Default = Color3.fromRGB(0, 255, 0), Title = "Inner Fill Color" })
ESPVisualsGroupBox:AddSlider("BoxFillTransparency", { Text = "Inner Fill Transparency", Default = 0.5, Min = 0, Max = 1, Rounding = 1 })
ESPVisualsGroupBox:AddToggle("ESPBoxTexture", { Text = "Enable Box Image Texture", Default = false })
ESPVisualsGroupBox:AddInput("BoxImageID", { Default = "", Numeric = true, Finished = false, ClearTextOnFocus = false, Text = "Box Custom Image ID" })
ESPVisualsGroupBox:AddSlider("BoxImageTransparency", { Text = "Image Texture Transparency", Default = 0.5, Min = 0, Max = 1, Rounding = 1 })

-- Screen & FOV Controls Elements Configuration
ScreenControlsGroupBox:AddSlider("CameraFOV", { Text = "Field of View (FOV)", Default = 70, Min = 30, Max = 120, Rounding = 0 })
ScreenControlsGroupBox:AddToggle("EnableStretch", { Text = "Stretched Resolution Layout", Default = false })
ScreenControlsGroupBox:AddSlider("StretchIntensity", { Text = "Stretch Width Intensity", Default = 1, Min = 1, Max = 10, Rounding = 1 })
ScreenControlsGroupBox:AddDivider()
ScreenControlsGroupBox:AddToggle("TrajectoryMaster", { Text = "Show Trajectory Overlay", Default = false })
ScreenControlsGroupBox:AddToggle("PreJumpPrediction", { Text = "Predict Future Pre-Jumps", Default = false }):AddKeyPicker("PreJumpBind", { Default = "H", Mode = "Toggle", Text = "Toggle Pre Jump Draw" })

-------------------------------------------------------------------------------
-- Combat Aim Assistance Module Components
-------------------------------------------------------------------------------
AimMasterGroupBox:AddToggle("AimActive", { Text = "Enable Aim Assist", Default = false }):AddKeyPicker("AimKeybind", { Default = "Clear", Mode = "Toggle", Text = "Aim Assistance Key" })
AimMasterGroupBox:AddSlider("AimSmoothness", { Text = "Aim Smoothness Slider", Default = 0.2, Min = 0.05, Max = 1, Rounding = 2 })
AimMasterGroupBox:AddSlider("AimStrength", { Text = "Aim Pull Strength %", Default = 100, Min = 10, Max = 100, Rounding = 0 })

AimMasterGroupBox:AddDropdown("AimTargetParts", { 
    Values = { "Head", "HumanoidRootPart", "Torso", "UpperTorso", "LowerTorso", "LeftHand", "RightHand", "LeftFoot", "RightFoot" }, 
    Default = 1, 
    Multi = true, 
    Text = "Target Priority Bones (Collective)" 
})

AimMasterGroupBox:AddToggle("AimWallCheck", { Text = "Wall Check Visibility", Default = true })

AimVisualsGroupBox:AddToggle("AimShowFOV", { Text = "Display FOV Ring Overlay", Default = false }):AddColorPicker("AimFOVColor", { Default = Color3.fromRGB(255, 255, 255), Title = "FOV Color" })
AimVisualsGroupBox:AddSlider("AimFOVRadius", { Text = "Target Angle FOV Radius", Default = 90, Min = 20, Max = 400, Rounding = 0 })

local function AcquireOptimalTarget()
    local bestPart = nil
    local shortestDistance = math.huge
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
    local maxRadius = Options.AimFOVRadius and Options.AimFOVRadius.Value or 90
    local targetPartsConfig = Options.AimTargetParts and Options.AimTargetParts.Value or {}

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= localPlayer and p.Character then
            local targetHum = p.Character:FindFirstChildOfClass("Humanoid")
            
            if targetHum and targetHum.Health > 0 then
                for partName, isEnabled in pairs(targetPartsConfig) do
                    if isEnabled then
                        local targetBone = p.Character:FindFirstChild(partName)
                        
                        if targetBone and targetBone:IsA("BasePart") then
                            local screenPos, isVisibleOnscreen = camera:WorldToViewportPoint(targetBone.Position)
                            
                            if isVisibleOnscreen then
                                local positionVector2 = Vector2.new(screenPos.X, screenPos.Y)
                                local comparativeDistance = (positionVector2 - screenCenter).Magnitude
                                
                                if comparativeDistance <= maxRadius and comparativeDistance < shortestDistance then
                                    if Toggles.AimWallCheck and Toggles.AimWallCheck.Value then
                                        if ValidateRayVisibility(targetBone.Position, p.Character) then
                                            shortestDistance = comparativeDistance
                                            bestPart = targetBone
                                        end
                                    else
                                        shortestDistance = comparativeDistance
                                        bestPart = targetBone
                                    end
                                end
                            end
                        end
                    end
                end
                
            end
        end
    end
    return bestPart
end

-------------------------------------------------------------------------------
-- Combat Audio Systems
-------------------------------------------------------------------------------
Toggles.ServerPosGhost:OnChanged(function()
    if not Toggles.ServerPosGhost.Value then ClearGhostCache() else SynchronizeGhostRig() end
end)

localPlayer.CharacterAdded:Connect(function()
    task.wait(0.3)
    if Toggles.ServerPosGhost and Toggles.ServerPosGhost.Value then SynchronizeGhostRig() end
end)

local SoundService = game:GetService("SoundService")
local HitSoundDictionary = { ["kovaaks hit sound"] = "129492816714016", ["Undertale Pan Critical Hit Sound Effect"] = "123635792221812", ["Hit sound Cod"] = "126183397820148", ["Omega hit sound"] = "130121050301913", ["Note hit sound pjsk"] = "133210605223140", ["mambo"] = "128667770293782", ["Outcome Memories Hit Sound 305"] = "127149780686708", ["critical-hit-sounds-effect"] = "122699784909910", ["Minecraft Sound Successful Bow Hit Ding"] = "135478009117226", ["Metal Hit Sound Effect"] = "133535246473802", ["Hit Marker sound effect"] = "133749572213659", ["spear hit sound"] = "135278368445325", ["undertale critical hit sound."] = "140181868959125", ["Synth Hit Sound"] = "136975490339236", ["stray_bow_hit_sound"] = "136310475202823", ["Spit Out and Hit(sound)"] = "140401046993490", ["hit sound (nk cream)"] = "8400935516", ["Bamboo hit Sound effect"] = "3769434519", ["Note Hit Sound (Ping)"] = "8537544526", ["Note Hit Sound"] = "8482765738", ["Value Quaver Hit Sound"] = "8115133131", ["Kill/Hit Sound \"UwU\""] = "8323804973", ["osu hit sound but louder and not delayed"] = "7147454322", ["GameSense Hitmarker Soundeffect [FIX]"] = "4817809188", ["sata andagi :D"] = "135097031120155" }
local DropdownDisplayValues = { "kovaaks hit sound", "Undertale Pan Critical Hit Sound Effect", "Hit sound Cod", "Omega hit sound", "Note hit sound pjsk", "mambo", "Outcome Memories Hit Sound 305", "critical-hit-sounds-effect", "Minecraft Sound Successful Bow Hit Ding", "Metal Hit Sound Effect", "Hit Marker sound effect", "spear hit sound", "undertale critical hit sound.", "Synth Hit Sound", "stray_bow_hit_sound", "Spit Out and Hit(sound)", "hit sound (nk cream)", "Bamboo hit Sound effect", "Note Hit Sound (Ping)", "Note Hit Sound", "Value Quaver Hit Sound", "Kill/Hit Sound \"UwU\"", "osu hit sound but louder and not delayed", "GameSense Hitmarker Soundeffect [FIX]", "sata andagi :D" }

local function playAudio(audioName, defaultId, dbValue)
	local soundIdString = HitSoundDictionary[audioName] or defaultId
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. soundIdString
	sound.Volume = math.pow(10, (dbValue or 1) / 20)
	sound.PlayOnRemove = true
	sound.Parent = SoundService
	sound:Destroy() 
end

local function checkDistance(targetRoot, toggleOption, sliderOption)
	if Toggles[toggleOption] and Toggles[toggleOption].Value then
		local localCharacter = localPlayer.Character
		local localRoot = localCharacter and localCharacter:FindFirstChild("HumanoidRootPart")
		if localRoot and targetRoot then
			return (localRoot.Position - targetRoot.Position).Magnitude <= (Options[sliderOption] and Options[sliderOption].Value or 10000)
		end
	end
	return true 
end

local function trackCombat(targetCharacter)
	local humanoid = targetCharacter:WaitForChild("Humanoid", 7)
	local targetRoot = targetCharacter:WaitForChild("HumanoidRootPart", 7)
	if humanoid and targetRoot then
		local lastHealth = humanoid.Health
		local wasDead = false
		humanoid.HealthChanged:Connect(function(currentHealth)
			if currentHealth < lastHealth then
				if currentHealth <= 0 then
					if not wasDead then
						wasDead = true
						if Toggles.KillsoundToggle and Toggles.KillsoundToggle.Value and checkDistance(targetRoot, "KillDistanceToggle", "MaxKillStudDistance") then
							playAudio(Options.KillSoundList.Value, "129492816714016", Options.KillSoundDB.Value)
						end
					end
				else
					if Toggles.HitsoundToggle and Toggles.HitsoundToggle.Value and checkDistance(targetRoot, "HitDistanceToggle", "MaxHitStudDistance") then
						playAudio(Options.HitSoundList.Value, "129492816714016", Options.HitSoundDB.Value)
					end
				end
			end
			lastHealth = currentHealth
		end)
	end
end

local function monitorPlayer(targetPlayer)
	if targetPlayer == localPlayer then return end
	targetPlayer.CharacterAdded:Connect(trackCombat)
	if targetPlayer.Character then task.spawn(trackCombat, targetPlayer.Character) end
end

for _, p in ipairs(Players:GetPlayers()) do monitorPlayer(p) end
Players.PlayerAdded:Connect(monitorPlayer)

CombatEffectsGroupBox:AddToggle("HitsoundToggle", { Text = "Enable On-Hit Sound", Default = false })
CombatEffectsGroupBox:AddDropdown("HitSoundList", { Values = DropdownDisplayValues, Default = 1, Text = "Hit Audio" })
CombatEffectsGroupBox:AddSlider("HitSoundDB", { Text = "Hit Volume (dB)", Default = 1, Min = 1, Max = 10, Rounding = 0 })
CombatEffectsGroupBox:AddButton("Preview Hit Sound", function()
    playAudio(Options.HitSoundList.Value, "129492816714016", Options.HitSoundDB.Value)
end)
CombatEffectsGroupBox:AddToggle("HitDistanceToggle", { Text = "Limit Hit Max Distance", Default = false })
CombatEffectsGroupBox:AddSlider("MaxHitStudDistance", { Text = "Hit Range Limit", Default = 5000, Min = 1, Max = 10000, Rounding = 0 })
CombatEffectsGroupBox:AddDivider()

CombatEffectsGroupBox:AddToggle("KillsoundToggle", { Text = "Enable On-Kill Sound", Default = false })
CombatEffectsGroupBox:AddDropdown("KillSoundList", { Values = DropdownDisplayValues, Default = 2, Text = "Kill Audio" })
CombatEffectsGroupBox:AddSlider("KillSoundDB", { Text = "Kill Volume (dB)", Default = 1, Min = 1, Max = 10, Rounding = 0 })
CombatEffectsGroupBox:AddButton("Preview Kill Sound", function()
    playAudio(Options.KillSoundList.Value, "129492816714016", Options.KillSoundDB.Value)
end)
CombatEffectsGroupBox:AddToggle("KillDistanceToggle", { Text = "Limit Kill Max Distance", Default = false })
CombatEffectsGroupBox:AddSlider("MaxKillStudDistance", { Text = "Kill Range Limit", Default = 5000, Min = 1, Max = 10000, Rounding = 0 })

-------------------------------------------------------------------------------
-- Crosshair Graphics Module (UPDATED - Always on top)
-------------------------------------------------------------------------------
local screenGui, aimContainer, textLabel
local activeCrosshairLines = {}
local rotationProgress = 0
local smoothedRotation = 0

local function createCrosshairLine()
    local pivot = Instance.new("Frame")
    pivot.BackgroundTransparency = 1
    pivot.Size = UDim2.new(0, 0, 0, 0)
    pivot.Position = UDim2.new(0.5, 0, 0.5, 0)
    pivot.AnchorPoint = Vector2.new(0.5, 0.5)
    pivot.ZIndex = 1000
    
    local visualLine = Instance.new("Frame")
    visualLine.BorderSizePixel = 0
    visualLine.ZIndex = 1001
    visualLine.AnchorPoint = Vector2.new(0.5, 1)
    visualLine.Name = "VisualLine"
    visualLine.Parent = pivot
    
    local stroke = Instance.new("UIStroke", visualLine)
    stroke.Thickness = 1
    stroke.ZIndex = 1002
    
    return pivot
end

local function updateLineCount()
    if not aimContainer then return end
    for _, pivot in ipairs(activeCrosshairLines) do pivot:Destroy() end
    activeCrosshairLines = {}
    local neededLines = Options.LineCount and Options.LineCount.Value or 4
    for i = 1, neededLines do
        local pivotInstance = createCrosshairLine()
        pivotInstance.Parent = aimContainer
        table.insert(activeCrosshairLines, pivotInstance)
    end
end

local function createGui()
    if screenGui then screenGui:Destroy() end
    if not Toggles.CrosshairToggle or not Toggles.CrosshairToggle.Value then return end
    
    screenGui = Instance.new("ScreenGui")
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.DisplayOrder = 999
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = localPlayer:WaitForChild("PlayerGui")
    
    aimContainer = Instance.new("Frame", screenGui)
    aimContainer.BackgroundTransparency = 1
    aimContainer.Size = UDim2.new(0, 1, 0, 1)
    aimContainer.AnchorPoint = Vector2.new(0.5, 0.5)
    aimContainer.ZIndex = 1000
    updateLineCount()
    
    textLabel = Instance.new("TextLabel", screenGui)
    textLabel.BackgroundTransparency = 1
    textLabel.Size = UDim2.new(0, 150, 0, 23)
    textLabel.Font = Enum.Font.Arcade
    textLabel.TextScaled = true
    textLabel.ZIndex = 1000
    textLabel.Text = Options.CrosshairTextString and Options.CrosshairTextString.Value or "UntitledX"
end

CrosshairGroupBox:AddToggle("CrosshairToggle", { Text = "Enable Crosshair", Default = false }):AddColorPicker("CrosshairColor", { Default = Color3.fromRGB(40, 50, 85) })
Toggles.CrosshairToggle:OnChanged(createGui)
CrosshairGroupBox:AddToggle("CenterLockToggle", { Text = "Lock to Center", Default = false })
CrosshairGroupBox:AddToggle("ShowTextToggle", { Text = "Show Text", Default = false })
CrosshairGroupBox:AddInput("CrosshairTextString", { Default = "UntitledX", Text = "Crosshair Text" })
CrosshairGroupBox:AddSlider("LineCount", { Text = "Line Count", Default = 4, Min = 1, Max = 12, Rounding = 0 })
Options.LineCount:OnChanged(updateLineCount)
CrosshairGroupBox:AddSlider("OrientationOffset", { Text = "Orientation Offset", Default = 0, Min = 0, Max = 360, Rounding = 0 })
CrosshairGroupBox:AddSlider("LineThickness", { Text = "Thickness", Default = 3, Min = 1, Max = 10, Rounding = 0 })
CrosshairGroupBox:AddSlider("MinLength", { Text = "Min Extension", Default = 10, Min = 0, Max = 50, Rounding = 0 })
CrosshairGroupBox:AddSlider("MaxLength", { Text = "Max Extension", Default = 30, Min = 10, Max = 100, Rounding = 0 })
CrosshairGroupBox:AddToggle("DisableSlowdown", { Text = "Disable Spin Slowdown", Default = false })
CrosshairGroupBox:AddSlider("RotationSpeed", { Text = "Spin Speed", Default = 0.8, Min = 0, Max = 5, Rounding = 1 })
CrosshairGroupBox:AddToggle("DisablePulse", { Text = "Disable Pulse", Default = false })
CrosshairGroupBox:AddSlider("PulseSpeed", { Text = "Pulse Frequency", Default = 2.5, Min = 0, Max = 10, Rounding = 1 })

-------------------------------------------------------------------------------
-- Movement & Flight System Lifecycle
-------------------------------------------------------------------------------
local bodyVelocity, bodyGyro, lastLookDirection = nil, nil, Vector3.new(0, 0, -1)

MovementGroupBox:AddToggle("SpinBotMaster", { Text = "Enable Character SpinBot", Default = false }):AddKeyPicker("SpinBotKeybind", { Default = "Clear", Mode = "Toggle", Text = "Spin Action Bind" })
MovementGroupBox:AddSlider("SpinBotVelocity", { Text = "Spin Rotation Velocity", Default = 50, Min = 10, Max = 250, Rounding = 0 })
MovementGroupBox:AddDivider()

MovementGroupBox:AddToggle("Fly", { Text = "Enable Fly + Noclip", Default = false }):AddKeyPicker("FlyKeybind", { Default = "Clear", Mode = "Toggle", Text = "Fly Keybind" })
MovementGroupBox:AddSlider("FlySpeed", { Text = "Fly Velocity Speed", Default = 50, Min = 1, Max = 250, Rounding = 0 })
MovementGroupBox:AddDivider()

MovementGroupBox:AddToggle("TPWalkToggle", { Text = "Enable Teleport Walk", Default = false }):AddKeyPicker("TPWalkKeybind", { Default = "Clear", Mode = "Toggle", Text = "TP Walk Bind" })
MovementGroupBox:AddSlider("TPWalkDistance", { Text = "TP Walk Speed", Default = 16, Min = 1, Max = 250, Rounding = 0 })
MovementGroupBox:AddDivider()
MovementGroupBox:AddToggle("ForceJumpToggle", { Text = "Forced Jump Power", Default = false }):AddKeyPicker("ForceJumpKeybind", { Default = "Clear", Mode = "Toggle", Text = "Jump Bind" })
MovementGroupBox:AddSlider("ForceJumpValue", { Text = "Jump Power", Default = 50, Min = 1, Max = 250, Rounding = 0 })

Toggles.Fly:OnChanged(function()
    local char = localPlayer.Character
    local root = char and (char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart)
    local hum = char and char:FindFirstChildOfClass("Humanoid")

    if Toggles.Fly.Value then
        if char and root and hum then
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end

            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Velocity = Vector3.zero
            bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bodyVelocity.Parent = root

            bodyGyro = Instance.new("BodyGyro")
            bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bodyGyro.P = 1e4
            bodyGyro.CFrame = root.CFrame
            bodyGyro.Parent = root

            for _, track in pairs(hum:GetPlayingAnimationTracks()) do
                if track.Animation and track.Animation.AnimationId then track:Stop() end
            end
            task.wait(0.1)
            hum.PlatformStand = true
            lastLookDirection = camera.CFrame.LookVector
        end
    else
        if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
        if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
        if hum then
            hum.PlatformStand = false
            task.wait()
            hum:ChangeState(Enum.HumanoidStateType.Running)
        end
    end
end)

localPlayer.CharacterRemoving:Connect(function()
    if bodyVelocity then bodyVelocity:Destroy() bodyVelocity = nil end
    if bodyGyro then bodyGyro:Destroy() bodyGyro = nil end
end)

-------------------------------------------------------------------------------
-- Local GUI Text Scraper & Replacer Engine
-------------------------------------------------------------------------------
local generatedRandomUser = "Player_" .. tostring(math.random(1000, 9999))
local generatedRandomDisplay = "Guest"

local function ScrapeAndReplaceGuiText(guiInstance, originalUser, originalDisplay, targetUser, targetDisplay)
    if guiInstance:IsA("TextLabel") or guiInstance:IsA("TextButton") or guiInstance:IsA("TextBox") then
        local currentText = guiInstance.Text
        if currentText ~= "" then
            local modifiedText = currentText
            
            if string.find(modifiedText, originalDisplay) then
                modifiedText = string.gsub(modifiedText, originalDisplay, targetDisplay)
            end
            if string.find(modifiedText, originalUser) then
                modifiedText = string.gsub(modifiedText, originalUser, targetUser)
            end
            
            if guiInstance.Text ~= modifiedText then
                guiInstance.Text = modifiedText
            end
        end
    end
    
    for _, child in ipairs(guiInstance:GetChildren()) do
        ScrapeAndReplaceGuiText(child, originalUser, originalDisplay, targetUser, targetDisplay)
    end
end

-------------------------------------------------------------------------------
-- Master Update & Operational Loop
-------------------------------------------------------------------------------
local accumulatedTime = 0
RunService.RenderStepped:Connect(function(deltaTime)
    local currentTime = os.clock()
    accumulatedTime = accumulatedTime + deltaTime
    
    local char = localPlayer.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    local root = char and (char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart)

    ---------------------------------------------------------------------------
    -- Local GUI / Identity Name Spoofing Process Handler
    ---------------------------------------------------------------------------
    local realUser = localPlayer.Name
    local realDisplay = localPlayer.DisplayName
    local spoofActive = Toggles.IdentitySpoofToggle and Toggles.IdentitySpoofToggle.Value

    if spoofActive then
        local targetUser = (Options.SpoofedUsername and Options.SpoofedUsername.Value ~= "") and Options.SpoofedUsername.Value or generatedRandomUser
        local targetDisplay = (Options.SpoofedDisplayName and Options.SpoofedDisplayName.Value ~= "") and Options.SpoofedDisplayName.Value or generatedRandomDisplay
        
        if char and char.Name ~= targetDisplay then
            char.Name = targetDisplay
        end

        pcall(function()
            for _, gui in ipairs(CoreGui:GetChildren()) do
                if gui:IsA("ScreenGui") or gui:IsA("BillboardGui") then
                    ScrapeAndReplaceGuiText(gui, realUser, realDisplay, targetUser, targetDisplay)
                end
            end
        end)

        local pGui = localPlayer:FindFirstChildOfClass("PlayerGui")
        if pGui then
            for _, gui in ipairs(pGui:GetChildren()) do
                if gui ~= screenGui then
                    ScrapeAndReplaceGuiText(gui, realUser, realDisplay, targetUser, targetDisplay)
                end
            end
        end
    else
        if char and char.Name == (Options.SpoofedDisplayName and Options.SpoofedDisplayName.Value or generatedRandomDisplay) then
            char.Name = realDisplay
        end
    end

    if Toggles.TPWalkToggle and Toggles.TPWalkToggle.Value and hum and root and hum.MoveDirection.Magnitude > 0 and (not Toggles.Fly or not Toggles.Fly.Value) then
        local walkDist = Options.TPWalkDistance and Options.TPWalkDistance.Value or 16
        local actualSpeed = walkDist - hum.WalkSpeed
        if actualSpeed > 0 then root.CFrame = root.CFrame + (hum.MoveDirection * (actualSpeed * deltaTime)) end
    end

    if hum and Toggles.ForceJumpToggle and Toggles.ForceJumpToggle.Value then
        hum.UseJumpPower = true
        hum.JumpPower = Options.ForceJumpValue and Options.ForceJumpValue.Value or 50
    end

    if camera then
        local targetFOV = Options.CameraFOV and Options.CameraFOV.Value or 70
        camera.FieldOfView = targetFOV
        
        if Toggles.EnableStretch and Toggles.EnableStretch.Value then
            local intensityValue = Options.StretchIntensity and Options.StretchIntensity.Value or 1
            local stretchValue = 1 - (intensityValue * 0.065)
            camera.CFrame = camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, stretchValue, 0, 0, 0, 1)
        end
    end

    if AimFOVCircle then
        if Toggles.AimShowFOV and Toggles.AimShowFOV.Value and Options.AimFOVRadius then
            AimFOVCircle.Visible = true
            AimFOVCircle.Radius = Options.AimFOVRadius.Value
            AimFOVCircle.Position = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
            if Options.AimFOVColor then AimFOVCircle.Color = Options.AimFOVColor.Value end
        else
            AimFOVCircle.Visible = false
        end
    end

    if Toggles.AimActive and Toggles.AimActive.Value then
        local targetLimb = AcquireOptimalTarget()
        if targetLimb then
            local smoothnessSetting = Options.AimSmoothness and Options.AimSmoothness.Value or 0.2
            local strengthMultiplier = Options.AimStrength and (Options.AimStrength.Value / 100) or 1
            
            local targetedCFrame = CFrame.lookAt(camera.CFrame.Position, targetLimb.Position)
            local finalLerpStep = smoothnessSetting * strengthMultiplier
            
            camera.CFrame = camera.CFrame:Lerp(targetedCFrame, math.clamp(finalLerpStep, 0, 1))
        end
    end

    if root then
        local existingSpinObj = root:FindFirstChild("UntitledX_SpinVelocity")
        if Toggles.SpinBotMaster and Toggles.SpinBotMaster.Value then
            if not existingSpinObj then
                existingSpinObj = Instance.new("BodyAngularVelocity")
                existingSpinObj.Name = "UntitledX_SpinVelocity"
                existingSpinObj.MaxTorque = Vector3.new(0, math.huge, 0)
                existingSpinObj.Parent = root
            end
            local velocitySetting = Options.SpinBotVelocity and Options.SpinBotVelocity.Value or 50
            existingSpinObj.AngularVelocity = Vector3.new(0, velocitySetting, 0)
        else
            if existingSpinObj then existingSpinObj:Destroy() end
        end
    end

    if char and root and hum and Toggles.Fly and Toggles.Fly.Value then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
        if not hum.PlatformStand then hum.PlatformStand = true end

        local targetVelocity = Vector3.zero
        local speedSetting = Options.FlySpeed and Options.FlySpeed.Value or 50
        local moveVec = ControlModule and ControlModule:GetMoveVector() or Vector3.zero

        if moveVec.Magnitude > 0 then targetVelocity = camera.CFrame:VectorToWorldSpace(moveVec) end
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then targetVelocity = targetVelocity + camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then targetVelocity = targetVelocity - camera.CFrame.LookVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then targetVelocity = targetVelocity + camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then targetVelocity = targetVelocity - camera.CFrame.RightVector end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then targetVelocity = targetVelocity + Vector3.new(0, 1, 0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then targetVelocity = targetVelocity - Vector3.new(0, 1, 0) end

        if targetVelocity.Magnitude > 0 then targetVelocity = targetVelocity.Unit * speedSetting end
        if bodyVelocity then bodyVelocity.Velocity = bodyVelocity.Velocity:Lerp(targetVelocity, 0.25) end

        if bodyGyro then
            local currentLookDirection = camera.CFrame.LookVector
            local smoothedLookDirection = lastLookDirection:Lerp(currentLookDirection, 0.03)
            lastLookDirection = smoothedLookDirection
            bodyGyro.CFrame = CFrame.lookAt(root.Position, root.Position + smoothedLookDirection)
        end
        if targetVelocity.Magnitude == 0 and bodyVelocity then bodyVelocity.Velocity = Vector3.zero end
    end

    if Toggles.ServerPosGhost and Toggles.ServerPosGhost.Value and root then
        local currentPing = localPlayer.GetNetworkPing and localPlayer:GetNetworkPing() or 0.07
        local linearVelocity = (root.ReceiveAge == 0) and root.AssemblyLinearVelocity or -root.AssemblyLinearVelocity
        
        local localRelSpace = {}
        for boneName, item in pairs(GhostPartsCache) do
            if item.real and item.real.Parent then localRelSpace[boneName] = root.CFrame:ToObjectSpace(item.real.CFrame) end
        end
        
        table.insert(PositionHistoryFrames, {
            time = currentTime,
            cframe = root.CFrame,
            pos = root.CFrame.Position,
            vel = linearVelocity,
            rel = localRelSpace
        })
        if #PositionHistoryFrames > 180 then table.remove(PositionHistoryFrames, 1) end
        
        local selectedFrame = PositionHistoryFrames[1]
        local targetTime = currentTime - currentPing
        for i = #PositionHistoryFrames, 1, -1 do
            if PositionHistoryFrames[i].time <= targetTime then
                selectedFrame = PositionHistoryFrames[i]
                break
            end
        end
        
        if selectedFrame then
            local clampedTimeOffset = math.min(targetTime - selectedFrame.time, 0.06)
            local predictionPosition = selectedFrame.pos + selectedFrame.vel * clampedTimeOffset
            local predictionCFrame = CFrame.new(predictionPosition) * (selectedFrame.cframe - selectedFrame.cframe.Position)
            local maxLimbCutoff = Options.GhostMaxLimb and Options.GhostMaxLimb.Value or 6
            local ghostColor = (Toggles.GhostRGB and Toggles.GhostRGB.Value) and Color3.fromHSV((currentTime % 5) / 5, 1, 1) or Color3.fromRGB(255, 255, 255)
            
            for boneName, item in pairs(GhostPartsCache) do
                if item.ghost and item.ghost.Parent then
                    local localOffset = selectedFrame.rel[boneName]
                    local targetWorldPosition = localOffset and predictionCFrame * localOffset or (item.real and item.real.CFrame or item.ghost.CFrame)
                    
                    if (targetWorldPosition.Position - predictionCFrame.Position).Magnitude > maxLimbCutoff then
                        local directionalVector = (targetWorldPosition.Position - predictionCFrame.Position).Unit
                        local adjustedPosition = predictionCFrame.Position + directionalVector * maxLimbCutoff
                        local rotX, rotY, rotZ = targetWorldPosition:ToEulerAnglesXYZ()
                        targetWorldPosition = CFrame.new(adjustedPosition) * CFrame.Angles(rotX, rotY, rotZ)
                    end
                    item.ghost.CFrame = item.ghost.CFrame:Lerp(targetWorldPosition, math.min(deltaTime * 18, 1))
                    if item.box then item.box.Color3 = ghostColor end
                end
            end
        end
    end

    if Toggles.TrajectoryMaster and Toggles.TrajectoryMaster.Value and root and hum then
        local basePos = root.Position
        local baseVelocity = root.AssemblyLinearVelocity
        local stateGrounded = CheckGroundedStatus(root)
        local camCF = camera.CFrame
        local cameraRelativeRotation = LastCameraCFramePosition:Inverse() * camCF
        local _, yawAngle, _ = cameraRelativeRotation:ToEulerAnglesXYZ()
        
        DynamicCameraTurnSpeed = DynamicCameraTurnSpeed * 0.7 + (yawAngle / math.max(deltaTime, 0.001)) * 0.3
        LastCameraCFramePosition = camCF
        
        local previouslyAirborne = AirborneFlag
        AirborneFlag = not stateGrounded and baseVelocity.Y < -5
        if (not previouslyAirborne and AirborneFlag) or (AirborneFlag and stateGrounded) then LastTrackedLanding = nil end
        
        local deltaPos3D = SolveTrajectoryPosition(basePos, baseVelocity, 0.25)
        local vectorScreen2D, isPointOnscreen = GetScreenPoint(deltaPos3D)
        DrawCircle.Position = vectorScreen2D
        DrawCircle.Visible = isPointOnscreen and ValidateRayVisibility(deltaPos3D)
        
        if baseVelocity.Magnitude > 1 then
            local appliedCurvature = -DynamicCameraTurnSpeed * 0.8
            local stretchMagnitude = math.min(baseVelocity.Magnitude * 0.5, 20)
            
            for i = 1, 8 do
                local ratio0 = (i - 1) / 8
                local ratio1 = i / 8
                local stepDistance0 = ratio0 * stretchMagnitude
                local stepDistance1 = ratio1 * stretchMagnitude
                local localCurveOffset0 = appliedCurvature * stepDistance0 * stepDistance0 * 0.06
                local localCurveOffset1 = appliedCurvature * stepDistance1 * stepDistance1 * 0.06
                
                local directionalUnit = baseVelocity.Unit
                local orthogonalRight = directionalUnit:Cross(Vector3.new(0, 1, 0)).Unit
                local node0 = basePos + directionalUnit * stepDistance0 + orthogonalRight * localCurveOffset0
                local node1 = basePos + directionalUnit * stepDistance1 + orthogonalRight * localCurveOffset1
                
                local scr0, on0 = GetScreenPoint(node0)
                local scr1, on1 = GetScreenPoint(node1)
                VelocityCurves[i].From = scr0
                VelocityCurves[i].To = scr1
                VelocityCurves[i].Visible = on0 and on1 and ValidateRayVisibility(node0) and ValidateRayVisibility(node1)
            end
        else
            for i = 1, 8 do VelocityCurves[i].Visible = false end
        end
        
        local activeFrames, currentImpactPosition = RunTrajectorySimulation(basePos, baseVelocity)
        if #activeFrames > 1 then
            for i = 1, 29 do
                local pointIndex1 = math.clamp(math.floor((i - 1) * (#activeFrames - 1) / 29) + 1, 1, #activeFrames)
                local pointIndex2 = math.clamp(math.floor(i * (#activeFrames - 1) / 29) + 1, 1, #activeFrames)
                local worldPoint1 = activeFrames[pointIndex1]
                local worldPoint2 = activeFrames[pointIndex2]
                
                local screen2D_A, flagA = GetScreenPoint(worldPoint1)
                local screen2D_B, flagB = GetScreenPoint(worldPoint2)
                MainArcLines[i].From = screen2D_A
                MainArcLines[i].To = screen2D_B
                MainArcLines[i].Visible = flagA and flagB and ValidateRayVisibility((worldPoint1 + worldPoint2) * 0.5)
            end
        else
            for i = 1, 29 do MainArcLines[i].Visible = false end
        end
        
        if AirborneFlag and currentImpactPosition then LastTrackedLanding = currentImpactPosition end
        if LastTrackedLanding and AirborneFlag then
            local impact2D, impactOnscreen = GetScreenPoint(LastTrackedLanding)
            local visibleConstraint = impactOnscreen and ValidateRayVisibility(LastTrackedLanding)
            DrawLandDot.Position = impact2D
            DrawLandDot.Visible = visibleConstraint
            
            local harmonicPulse = math.abs(math.sin(accumulatedTime * 3))
            DrawLandOutline.Position = impact2D
            DrawLandOutline.Radius = 18 + harmonicPulse * 8
            DrawLandOutline.Transparency = 0.3 + harmonicPulse * 0.7
            DrawLandOutline.Visible = visibleConstraint
        else
            DrawLandDot.Visible = false
            DrawLandOutline.Visible = false
        end
        
        if Toggles.PreJumpPrediction and Toggles.PreJumpPrediction.Value and not AirborneFlag then
            local viewVector = camera.CFrame.LookVector
            local crossVector = camera.CFrame.RightVector
            local manualInputDirection = Vector3.zero
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then manualInputDirection = manualInputDirection + Vector3.new(viewVector.X, 0, viewVector.Z).Unit end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then manualInputDirection = manualInputDirection - Vector3.new(viewVector.X, 0, viewVector.Z).Unit end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then manualInputDirection = manualInputDirection - Vector3.new(crossVector.X, 0, crossVector.Z).Unit end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then manualInputDirection = manualInputDirection + Vector3.new(crossVector.X, 0, crossVector.Z).Unit end
            
            if manualInputDirection.Magnitude > 0.1 then PreJumpLastMoveInput = manualInputDirection.Unit end
            local activeWalkspeed = hum.WalkSpeed or 16
            local forecastedVelocity = PreJumpLastMoveInput * activeWalkspeed + Vector3.new(0, 50, 0)
            local jumpPoints, jumpImpact = RunTrajectorySimulation(basePos, forecastedVelocity)
            
            if #jumpPoints > 1 then
                for i = 1, 29 do
                    local nodeIdx1 = math.clamp(math.floor((i - 1) * (#jumpPoints - 1) / 29) + 1, 1, #jumpPoints)
                    local nodeIdx2 = math.clamp(math.floor(i * (#jumpPoints - 1) / 29) + 1, 1, #jumpPoints)
                    local lineCoord1 = jumpPoints[nodeIdx1]
                    local lineCoord2 = jumpPoints[nodeIdx2]
                    
                    local projection2D_A, screenFlagA = GetScreenPoint(lineCoord1)
                    local projection2D_B, screenFlagB = GetScreenPoint(lineCoord2)
                    PreJumpArcLines[i].From = projection2D_A
                    PreJumpArcLines[i].To = projection2D_B
                    PreJumpArcLines[i].Visible = screenFlagA and screenFlagB and ValidateRayVisibility((lineCoord1 + lineCoord2) * 0.5)
                end
            else
                for i = 1, 29 do PreJumpArcLines[i].Visible = false end
            end
            if jumpImpact then
                local landing2D, landingOnscreen = GetScreenPoint(jumpImpact)
                PreJumpLandDot.Position = landing2D
                PreJumpLandDot.Visible = landingOnscreen and ValidateRayVisibility(jumpImpact)
            else PreJumpLandDot.Visible = false end
        else
            for i = 1, 29 do PreJumpArcLines[i].Visible = false end
            PreJumpLandDot.Visible = false
        end
    else
        ResetDrawingGraphicsVisibility()
    end

    local masterOn = Toggles.ESPMaster and Toggles.ESPMaster.Value
    local glowOn = Toggles.ESPGlowFill and Toggles.ESPGlowFill.Value
    local boxesOn = Toggles.ESPBoxes and Toggles.ESPBoxes.Value
    local solidFillOn = Toggles.ESPBoxFill and Toggles.ESPBoxFill.Value
    local textureOn = Toggles.ESPBoxTexture and Toggles.ESPBoxTexture.Value

    for plr, highlight in pairs(ESP_Highlights) do
        if masterOn and glowOn and Options.FillColor and Options.OutlineColor then
            highlight.Enabled = true
            highlight.FillColor = Options.FillColor.Value
            highlight.OutlineColor = Options.OutlineColor.Value
            highlight.FillTransparency = Options.FillTransparency.Value
            highlight.OutlineTransparency = Options.OutlineTransparency.Value
        else highlight.Enabled = false end
    end

    for plr, billboard in pairs(ESP_Boxes) do
        local borderFrame = billboard:FindFirstChild("BoxBorder")
        local stroke = borderFrame and borderFrame:FindFirstChildOfClass("UIStroke")
        local solidFill = borderFrame and borderFrame:FindFirstChild("SolidFill")
        local textureOverlay = borderFrame and borderFrame:FindFirstChild("TextureOverlay")
        local nameTag = borderFrame and borderFrame:FindFirstChild("ESPNameTag")
        
        if nameTag then
            nameTag.Text = plr.Name
        end

        if masterOn and boxesOn and borderFrame and stroke and Options.BoxColor then
            billboard.Enabled = true
            stroke.Color = Options.BoxColor.Value
            stroke.Thickness = Options.BoxThickness.Value

            if solidFill and Options.BoxFillTransparency and Options.BoxFillColor then
                if solidFillOn then
                    solidFill.BackgroundTransparency = Options.BoxFillTransparency.Value
                    solidFill.BackgroundColor3 = Options.BoxFillColor.Value
                else solidFill.BackgroundTransparency = 1 end
            end
            if textureOverlay and Options.BoxImageID and Options.BoxImageTransparency then
                if textureOn then
                    local inputID = Options.BoxImageID.Value or ""
                    textureOverlay.Image = inputID ~= "" and ("rbxassetid://" .. inputID) or ""
                    textureOverlay.ImageTransparency = Options.BoxImageTransparency.Value
                else textureOverlay.Image = "" end
            end
        else billboard.Enabled = false end
    end

    -- Crosshair rendering (ALWAYS ON TOP)
    if screenGui and aimContainer and Toggles.CrosshairToggle and Toggles.CrosshairToggle.Value then
        if Toggles.CenterLockToggle and Toggles.CenterLockToggle.Value then
            aimContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
            if textLabel then textLabel.Position = UDim2.new(0.5, -75, 0.5, 50) end
        else
            aimContainer.Position = UDim2.new(0, mouse.X, 0, mouse.Y)
            if textLabel then textLabel.Position = UDim2.new(0, mouse.X - 75, 0, mouse.Y + 50) end
        end
        if textLabel and Options.CrosshairTextString and Options.CrosshairColor and Toggles.ShowTextToggle then
            textLabel.Visible = Toggles.ShowTextToggle.Value
            textLabel.Text = Options.CrosshairTextString.Value
            textLabel.TextColor3 = Options.CrosshairColor.Value
        end
        
        local baseSpeed = Options.RotationSpeed and Options.RotationSpeed.Value or 0.8
        if baseSpeed > 0 then
            local slToggle = Toggles.DisableSlowdown and Toggles.DisableSlowdown.Value
            rotationProgress = (rotationProgress + (slToggle and baseSpeed or (rotationProgress >= 0.6 and baseSpeed * math.max(1 - (((rotationProgress - 0.6) / 0.35)^2 * 0.7), 0.3) or baseSpeed)) * deltaTime) % 1
            smoothedRotation = rotationProgress * 360
        else smoothedRotation = 0 end
        
        aimContainer.Rotation = smoothedRotation + (Options.OrientationOffset and Options.OrientationOffset.Value or 0)
        local pulseFre = Options.PulseSpeed and Options.PulseSpeed.Value or 2.5
        local minL = Options.MinLength and Options.MinLength.Value or 10
        local maxL = Options.MaxLength and Options.MaxLength.Value or 30
        local gap = minL + (maxL - minL) * (Toggles.DisablePulse and Toggles.DisablePulse.Value and 0 or (math.sin(tick() * pulseFre) * 0.5 + 0.5)^2)
        
        local angleStep = 360 / #activeCrosshairLines
        local thicknessVal = Options.LineThickness and Options.LineThickness.Value or 3
        local crossColor = Options.CrosshairColor and Options.CrosshairColor.Value or Color3.fromRGB(40, 50, 85)
        
        for i, pivot in ipairs(activeCrosshairLines) do
            pivot.Rotation = (i - 1) * angleStep
            local visual = pivot.VisualLine
            if visual then
                visual.Size = UDim2.new(0, thicknessVal, 0, gap)
                visual.Position = UDim2.new(0.5, 0, 0, -gap)
                visual.BackgroundColor3 = crossColor
            end
        end
    end
end)

local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu")
MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", { Default = "RightShift", NoUI = true })
MenuGroup:AddButton("Unload", function() Library:Unload() end)
Library.ToggleKeybind = Options.MenuKeybind

pcall(function()
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    ThemeManager:SetFolder("UntitledXConfigs")
    SaveManager:SetFolder("UntitledXConfigs/game")
    SaveManager:BuildConfigSection(Tabs["UI Settings"])
    ThemeManager:ApplyToTab(Tabs["UI Settings"])
end)
