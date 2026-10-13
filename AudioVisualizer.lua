-- Sound Visualizer (reacts to any Sound in Workspace)
-- LocalScript in StarterCharacterScripts

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Wait for character
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Root = Character:FindFirstChild("Torso") or Character:FindFirstChild("HumanoidRootPart")
if not Root then
	Root = Character:WaitForChild("HumanoidRootPart", 5) or Character:WaitForChild("Torso", 5)
end

-- Remove old Soundbar if it exists
for _, v in pairs(Character:GetChildren()) do
	if v.Name == "Soundbar" then
		v:Destroy()
	end
end

-- Create Soundbar model
local Soundbar = Instance.new("Model")
Soundbar.Name = "Soundbar"
Soundbar.Parent = Character

local BAR_COUNT = 39
local Bars = {}
local BarByName = {}

for i = 0, BAR_COUNT - 1 do
	local p = Instance.new("Part")
	p.Name = tostring(i)
	p.Anchored = true
	p.CanCollide = false
	p.Size = Vector3.new(0.5, 0.2, 0.5)
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.TopSurface = Enum.SurfaceType.Smooth
	p.Parent = Soundbar

	local m = Instance.new("SpecialMesh")
	m.Name = "Mesh"
	m.MeshId = "rbxassetid://9856898"
	m.Scale = Vector3.new(1, 0.4, 1)
	m.TextureId = "rbxassetid://2114473"
	m.MeshType = Enum.MeshType.FileMesh
	m.Parent = p

	table.insert(Bars, p)
	BarByName[p.Name] = p
end

local nBars = #Bars - 1
local Height = 20

-- Color cycle
local function cycle(num)
	local section = num % 1 * 3
	local secondary = 0.5 * math.pi * (section % 1)
	if section < 1 then
		return 1, 1 - math.cos(secondary), 1 - math.sin(secondary)
	elseif section < 2 then
		return 1 - math.sin(secondary), 1, 1 - math.cos(secondary)
	else
		return 1 - math.cos(secondary), 1 - math.sin(secondary), 1
	end
end

-- Easing
local Tweens = {}
local function quadIn(t, b, c, d)
	t = t / d
	return c * t * t + b
end
local function quadOut(t, b, c, d)
	t = t / d
	return -c * t * (t - 2) + b
end

local function Quad(obj, val, ease, d)
	local t = tick()
	Tweens[obj] = t
	local st = obj.Scale.Y
	local sd = val - st
	local f = ease == "In" and quadIn or quadOut
	local con
	con = RunService.RenderStepped:Connect(function()
		local nt = tick() - t
		if Tweens[obj] ~= t then
			con:Disconnect()
			return
		end
		local nv = math.max(0.2, f(math.min(d, nt), st, sd, d))
		obj.Scale = Vector3.new(0.9, nv, 0.9)
		obj.Offset = Vector3.new(0, nv / 4, 0)
		obj.VertexColor = Vector3.new(cycle(tick()))
		if nt > d then
			con:Disconnect()
			if ease ~= "In" then
				Quad(obj, 0.2, "In", 0.3)
			end
		end
	end)
end

local Set
local function CheckSet(N, S, D)
	local bar = BarByName[tostring(N)]
	if not bar then return end
	local mesh = bar:FindFirstChild("Mesh") or bar:FindFirstChildOfClass("SpecialMesh")
	if not mesh then return end
	local nS = mesh.Scale.Y
	if S > nS then
		Set(N, nS + (S - nS) / 3, D)
	end
end

Set = function(N, S, D)
	local bar = BarByName[tostring(N)]
	if not bar then return end
	local mesh = bar:FindFirstChild("Mesh") or bar:FindFirstChildOfClass("SpecialMesh")
	if not mesh then return end
	Quad(mesh, S, "Out", 0.1)
	if N > 0 and D ~= 1 then
		CheckSet(N - 1, S, -1)
	end
	if N < nBars and D ~= -1 then
		CheckSet(N + 1, S, 1)
	end
end

-- Rotate bars around player
local CRot = 1
local rad = math.rad
spawn(function()
	RunService.RenderStepped:Connect(function()
		if not Root or not Root.Parent then return end
		local pos = Root.Position
		for Index, v in ipairs(Bars) do
			v.CFrame = CFrame.new(pos)
				* CFrame.Angles(0, rad((360 / #Bars * Index + tick() * 60 / (#Bars ~= 0 and #Bars or 1)) % 360), 0)
				* CFrame.new(0, -3, (5 + #Bars) * 0.35 + v.Size.X)
				* CFrame.Angles(0, 90 + CRot, 0)
		end
	end)
end)

-- React to the loudest playing Sound in Workspace
local maxLoudness = 1
spawn(function()
	RunService.RenderStepped:Connect(function()
		local loudest = 0
		for _, obj in ipairs(workspace:GetDescendants()) do
			if obj:IsA("Sound") and obj.IsPlaying then
				local pl = obj.PlaybackLoudness
				if pl and pl > loudest then
					loudest = pl
				end
			end
		end

		if loudest > 0 then
			maxLoudness = math.max(loudest, maxLoudness * 0.999)
			local normalized = loudest / maxLoudness
			Set(math.floor(normalized * nBars), normalized * Height)
		else
			maxLoudness = math.max(1, maxLoudness * 0.95)
		end
	end)
end)
