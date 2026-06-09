-- Bird wings made by benre666
-- Modified for R15: Press "J" ONCE to fly. Includes mobile skin cycle button, non-draggable-while-flying WASD pad, special barrel roll buttons, and a dynamic 1x/2x SCALE BUTTON.
-- Down Press Q
-- Wings Spin Press A Two Time (Triggered via "Barrel Roll L" button on mobile)
-- Wings Spin Press D Two Time (Triggered via "Barrel Roll R" button on mobile)

local plr = game:GetService("Players").LocalPlayer

local function runWingScript(char)
	-- R15 standard core parts check
	local tor = char:WaitForChild("UpperTorso", 5) or char:WaitForChild("Torso", 5)
	local rootPart = char:WaitForChild("HumanoidRootPart", 5)
	local hum = char:WaitForChild("Humanoid", 5)
	if not tor or not rootPart or not hum then return end
	
	function fly()
		-- Clean up any lingering scripts or UI objects from previous lives
		for i,v in pairs(script:GetChildren()) do
			pcall(function() v.Value = "" end)
			game:GetService("Debris"):AddItem(v,.1)
		end
		
		local oldGui = plr:WaitForChild("PlayerGui"):FindFirstChild("WingControlGui")
		if oldGui then oldGui:Destroy() end

		function weld(p0,p1,c0,c1,par)
			local w = Instance.new("Weld", p0 or par)
			w.Part0 = p0
			w.Part1 = p1
			w.C0 = c0 or CFrame.new()
			w.C1 = c1 or CFrame.new()
			w.Name = "WingWeld"
			return w
		end

		local motors = {}
		function motor(p0,p1,c0,c1,des,vel,par)
			local w = Instance.new("Motor6D", p0 or par)
			w.Part0 = p0
			w.Part1 = p1
			w.C0 = c0 or CFrame.new()
			w.C1 = c1 or CFrame.new()
			w.MaxVelocity = tonumber(vel) or .05
			w.DesiredAngle = tonumber(des) or 0
			w.Name = "WingMotor"
			return w
		end

		function lerp(a,b,c)
			return a+(b-a)*c
		end

		function clerp(c1,c2,al)
			local com1 = {c1.X,c1.Y,c1.Z,c1:toEulerAnglesXYZ()}
			local com2 = {c2.X,c2.Y,c2.Z,c2:toEulerAnglesXYZ()}
			for i,v in pairs(com1) do
				com1[i] = lerp(v,com2[i],al)
			end
			return CFrame.new(com1[1],com1[2],com1[3]) * CFrame.Angles(select(4,unpack(com1)))
		end

		function ccomplerp(c1,c2,al)
			local com1 = {c1:components()}
			local com2 = {c2:components()}
			for i,v in pairs(com1) do
				com1[i] = lerp(v,com2[i],al)
			end
			return CFrame.new(unpack(com1))
		end

		function tickwave(time,length,offset)
			return (math.abs((tick()+(offset or 0))%time-time/2)*2-time/2)/time/2*length
		end

		function invcol(c)
			c = c.Color
			return BrickColor.new(Color3.new(1-c.b,1-c.g,1-c.r))
		end

		local oc = oc or function(...) return ... end
		hum.PlatformStand = false

		pcall(function() char.Wings:Destroy() end)
		pcall(function() char.Angel:Destroy() end)

		local mod = Instance.new("Model",char)
		mod.Name = "Wings"

		local special = {
			["1"] = {"New Yeller",nil,0.4,0.7,true,Color3.new(1,1,.95),Color3.new(1,1,.6)},
			["2"] = {"Royal purple",nil,.4,.4,true},
			["3"] = {"Black",nil,0,0,false},
			["4"] = {"White",nil,0,0,false},
			["5"] = {"Black","Bright red",.5,0,false,Color3.new(1,0,0),Color3.new(0,0,0)},
			["6"] = {"Cyan","Toothpaste",0,0,false,Color3.new(1,0,0),Color3.new(0,0,0)},
			["7"] = {"Reddish brown",1030,0,0,false},
			["8"] = {"Really black","Really black",.2,0,true,Color3.new(0,0,0),Color3.new(0,0,0)},
			["9"] = {"Really black","White",.2,0,false,Color3.new(0,0,0),Color3.new(0,0,0)},
			["10"] = {"Really black",nil,0,0,false},
			["11"] = {"Cyan","Toothpaste",0,0,false,Color3.new(1,0,0),Color3.new(0,0,0)},
		}

		local currentSkin = "0" 
		local currentScale = 1
		local topcolor = invcol(tor.BrickColor)
		local feacolor = tor.BrickColor
		local ptrans = 0
		local pref = 0
		local fire = false
		local fmcol = Color3.new()
		local fscol = Color3.new()

		local part = Instance.new("Part")
		part.FormFactor = "Custom"
		part.Size = Vector3.new(.2,.2,.2)
		part.TopSurface,part.BottomSurface = 0,0
		part.CanCollide = false
		part.BrickColor = topcolor
		part.Transparency = ptrans
		part.Reflectance = pref
		
		local ef = Instance.new("Fire",fire and part or nil)
		ef.Size = .15
		ef.Color = fmcol or Color3.new()
		ef.SecondaryColor = fscol or Color3.new()
		part:BreakJoints()

		function newpart()
			local clone = part:Clone()
			clone.Parent = mod
			clone:BreakJoints()
			return clone
		end

		local feath = newpart()
		feath.BrickColor = feacolor
		feath.Transparency = 0
		Instance.new("SpecialMesh",feath).MeshType = "Sphere"

		function newfeather()
			local clone = feath:Clone()
			clone.Parent = mod
			clone:BreakJoints()
			return clone
		end

		function applySkin(skinKey)
			local tcol, fcol, trans, ref, hasFire, fmc, fsc
			if skinKey == "0" then
				tcol = invcol(tor.BrickColor)
				fcol = tor.BrickColor
				trans, ref, hasFire, fmc, fsc = 0, 0, false, Color3.new(), Color3.new()
			else
				local spec = special[skinKey]
				tcol = spec[1] and BrickColor.new(spec[1]) or invcol(tor.BrickColor)
				fcol = spec[2] and BrickColor.new(spec[2]) or tor.BrickColor
				trans, ref, hasFire, fmc, fsc = spec[3], spec[4], spec[5], spec[6], spec[7]
			end

			for _, v in pairs(mod:GetChildren()) do
				if v:IsA("BasePart") then
					if v.Name == "Part" then
						v.BrickColor = tcol
						v.Transparency = trans
						v.Reflectance = ref
						local fr = v:FindFirstChildOfClass("Fire")
						if fr then fr:Destroy() end
						if hasFire then
							local newFire = Instance.new("Fire", v)
							newFire.Size = .15 * currentScale
							newFire.Color = fmc or Color3.new()
							newFire.SecondaryColor = fsc or Color3.new()
						end
					elseif v.Name == "Part" and v:FindFirstChildOfClass("SpecialMesh") or v.BrickColor == feacolor then
						v.BrickColor = fcol
					end
				end
			end
			feacolor = fcol
		end

		local originalSizes = {}
		local originalJointC0s = {}
		local originalJointC1s = {}

		local function saveOriginalSpecs(partInstance, joint)
			originalSizes[partInstance] = partInstance.Size
			if joint then
				originalJointC0s[joint] = joint.C0
				originalJointC1s[joint] = joint.C1
			end
		end

		---------- RIGHT WING
		local r1 = newpart()
		r1.Size = Vector3.new(.3,1.5,.3)*1.2
		local rm1 = motor(tor,r1,CFrame.new(.35,.6,.4) * CFrame.Angles(0,0,math.rad(-60)) * CFrame.Angles(math.rad(30),math.rad(-25),0),CFrame.new(0,-.8,0),.1)
		saveOriginalSpecs(r1, rm1)

		local r2 = newpart()
		r2.Size = Vector3.new(.4,1.8,.4)*1.2
		local rm2 = motor(r1,r2,CFrame.new(0,.75,0) * CFrame.Angles(0,0,math.rad(50)) * CFrame.Angles(math.rad(-30),math.rad(15),0),CFrame.new(0,-.9,0),.1)
		saveOriginalSpecs(r2, rm2)

		local r3 = newpart()
		r3.Size = Vector3.new(.3,2.2,.3)*1.2
		local rm3 = motor(r2,r3,CFrame.new(.1,.9,0) * CFrame.Angles(0,0,math.rad(-140)) * CFrame.Angles(math.rad(-3),0,0),CFrame.new(0,-1.1,0),.1)
		saveOriginalSpecs(r3, rm3)

		local r4 = newpart()
		r4.Size = Vector3.new(.25,1.2,.25)*1.2
		local rm4 = motor(r3,r4,CFrame.new(0,1.1,0) * CFrame.Angles(0,0,math.rad(-10)) * CFrame.Angles(math.rad(-3),0,0),CFrame.new(0,-.6,0),.1)
		saveOriginalSpecs(r4, rm4)

		local feather
		feather = newfeather() feather.Size = Vector3.new(.4,3,.3) local w = weld(r4,feather,CFrame.new(-.1,-.3,0),CFrame.new(0,-1.5,0)) saveOriginalSpecs(feather, w)
		feather = newfeather() feather.Size = Vector3.new(.4,2.3,.3) local w = weld(r4,feather,CFrame.new(.1,-.1,0) * CFrame.Angles(0,math.random()*.1,0),CFrame.new(0,-1.1,0)) saveOriginalSpecs(feather, w)
		feather = newfeather() feather.Size = Vector3.new(.35,2.2,.25) local w = weld(r4,feather,CFrame.new(.1,-.3,0) * CFrame.Angles(0,math.random()*.1,math.rad(-10)),CFrame.new(0,-1.1,0)) saveOriginalSpecs(feather, w)

		local rf3 = {}
		for i=0,7 do
			feather = newfeather() feather.Size = Vector3.new(.45,2.2,.35)
			local mot = motor(r3,feather,CFrame.new(.05,1-i*.285,0) * CFrame.Angles(0,math.random()*.1,math.rad(-25-i*2)),CFrame.new(0,-feather.Size.Y/2,0))
			table.insert(rf3, mot)
			saveOriginalSpecs(feather, mot)
		end
		local rf2 = {}
		for i=0,6 do
			feather = newfeather() feather.Size = Vector3.new(.45,2.2-i*.08,.3)
			local mot = motor(r2,feather,CFrame.new(.05,.75-i*.26,0) * CFrame.Angles(0,math.random()*.1,math.rad(-75-i*4)),CFrame.new(0,-feather.Size.Y/2,0))
			table.insert(rf2, mot)
			saveOriginalSpecs(feather, mot)
		end
		local rf1 = {}
		for i=0,6 do
			feather = newfeather() feather.Size = Vector3.new(.37,1.65-i*.06,.25)
			local mot = motor(r1,feather,CFrame.new(.05,.63-i*.21,0) * CFrame.Angles(0,math.random()*.05,math.rad(-75)),CFrame.new(0,-feather.Size.Y/2,0))
			table.insert(rf1, mot)
			saveOriginalSpecs(feather, mot)
		end

		---------- LEFT WING
		local l1 = newpart()
		l1.Size = Vector3.new(.3,1.5,.3)*1.2
		local lm1 = motor(tor,l1,CFrame.new(-.35,.6,.4) * CFrame.Angles(0,0,math.rad(60)) * CFrame.Angles(math.rad(30),math.rad(25),0) * CFrame.Angles(0,-math.pi,0),CFrame.new(0,-.8,0) ,.1)
		saveOriginalSpecs(l1, lm1)

		local l2 = newpart()
		l2.Size = Vector3.new(.4,1.8,.4)*1.2
		local lm2 = motor(l1,l2,CFrame.new(0,.75,0) * CFrame.Angles(0,0,math.rad(50)) * CFrame.Angles(math.rad(30),math.rad(-15),0),CFrame.new(0,-.9,0),.1)
		saveOriginalSpecs(l2, lm2)

		local l3 = newpart()
		l3.Size = Vector3.new(.3,2.2,.3)*1.2
		local lm3 = motor(l2,l3,CFrame.new(.1,.9,0) * CFrame.Angles(0,0,math.rad(-140)) * CFrame.Angles(math.rad(3),0,0),CFrame.new(0,-1.1,0),.1)
		saveOriginalSpecs(l3, lm3)

		local l4 = newpart()
		l4.Size = Vector3.new(.25,1.2,.25)*1.2
		local lm4 = motor(l3,l4,CFrame.new(0,1.1,0) * CFrame.Angles(0,0,math.rad(-10)) * CFrame.Angles(math.rad(3),0,0),CFrame.new(0,-.6,0),.1)
		saveOriginalSpecs(l4, lm4)

		feather = newfeather() feather.Size = Vector3.new(.4,3,.3) local w = weld(l4,feather,CFrame.new(-.1,-.3,0),CFrame.new(0,-1.5,0)) saveOriginalSpecs(feather, w)
		feather = newfeather() feather.Size = Vector3.new(.4,2.3,.3) local w = weld(l4,feather,CFrame.new(.1,-.1,0) * CFrame.Angles(0,math.random()*.1,0),CFrame.new(0,-1.1,0)) saveOriginalSpecs(feather, w)
		feather = newfeather() feather.Size = Vector3.new(.35,2.2,.25) local w = weld(l4,feather,CFrame.new(.1,-.3,0) * CFrame.Angles(0,math.random()*.1,math.rad(-10)),CFrame.new(0,-1.1,0)) saveOriginalSpecs(feather, w)

		local lf3 = {}
		for i=0,7 do
			feather = newfeather() feather.Size = Vector3.new(.45,2.2,.35)
			local mot = motor(l3,feather,CFrame.new(.05,1-i*.285,0) * CFrame.Angles(0,math.random()*.1,math.rad(-25-i*2)),CFrame.new(0,-feather.Size.Y/2,0))
			table.insert(lf3, mot)
			saveOriginalSpecs(feather, mot)
		end
		local lf2 = {}
		for i=0,6 do
			feather = newfeather() feather.Size = Vector3.new(.45,2.2-i*.08,.3)
			local mot = motor(l2,feather,CFrame.new(.05,.75-i*.26,0) * CFrame.Angles(0,math.random()*.1,math.rad(-75-i*4)),CFrame.new(0,-feather.Size.Y/2,0))
			table.insert(lf2, mot)
			saveOriginalSpecs(feather, mot)
		end
		local lf1 = {}
		for i=0,6 do
			feather = newfeather() feather.Size = Vector3.new(.37,1.65-i*.06,.25)
			local mot = motor(l1,feather,CFrame.new(.05,.63-i*.21,0) * CFrame.Angles(0,math.random()*.05,math.rad(-75)),CFrame.new(0,-feather.Size.Y/2,0))
			table.insert(lf1, mot)
			saveOriginalSpecs(feather, mot)
		end

		local rwing = {rm1,rm2,rm3,rm4}
		local lwing = {lm1,lm2,lm3,lm4}
		local oc0 = {}
		for i,v in pairs(rwing) do oc0[v] = v.C0 end
		for i,v in pairs(lwing) do oc0[v] = v.C0 end

		function applyScale(scale)
			currentScale = scale
			for partInstance, baseSize in pairs(originalSizes) do
				if partInstance and partInstance.Parent then
					partInstance.Size = baseSize * scale
					local fireEmitter = partInstance:FindFirstChildOfClass("Fire")
					if fireEmitter then
						fireEmitter.Size = 0.15 * scale
					end
				end
			end

			for joint, baseC0 in pairs(originalJointC0s) do
				if joint and joint.Parent then
					local baseC1 = originalJointC1s[joint]
					joint.C0 = CFrame.new(baseC0.Position * scale) * (baseC0 - baseC0.Position)
					joint.C1 = CFrame.new(baseC1.Position * scale) * (baseC1 - baseC1.Position)
					if oc0[joint] then
						oc0[joint] = joint.C0
					end
				end
			end
		end

		function gotResized()
			if lastsize then
				if tor.Size == lastsize then return end
				local scaleVec = tor.Size/lastsize
				for i,v in pairs(oc0) do oc0[i] = v-v.p+scaleVec*v.p end
				lastsize = tor.Size
			end
			lastsize = tor.Size
		end
		tor.Changed:connect(function(p) if p == "Size" then gotResized() end end)
		gotResized()

		local idle = {0,0.5,-.2,0; .05,.05,.1,.05; -.6,-1.5,.1,0;}
		local outlow = {-.7,-.2,1.8,0; .3,.05,.1,.05; .2,0,0,0}
		local outhigh = {.5,-.2,1.8,0; .3,.05,.1,.05; .2,0,0,0}
		local veryhigh = {.9,-.3,1.9,0; .3,.05,.1,.05; .2,0,0,0}
		local flap1 = {-.3,.3,1.1,-.2; .3,.05,.1,.05; .2,-.6,0,0}
		local divebomb = {0,.2,.4,-.7; .3,.05,.1,.05; 0,-.5,-.6,0}

		function setwings(tab,time)
			time = time or 10
			for i=1,4 do
				rwing[i].DesiredAngle = tab[i]
				lwing[i].DesiredAngle = tab[i]
				rwing[i].MaxVelocity = math.abs(tab[i]-rwing[i].CurrentAngle)/time
				lwing[i].MaxVelocity = math.abs(tab[i]-lwing[i].CurrentAngle)/time
			end
			for _,v in pairs(rf1) do v.DesiredAngle = tab[9] v.MaxVelocity = math.abs(v.DesiredAngle-v.CurrentAngle)/time end
			for _,v in pairs(lf1) do v.DesiredAngle = tab[9] v.MaxVelocity = math.abs(v.DesiredAngle-v.CurrentAngle)/time end
			for _,v in pairs(rf2) do v.DesiredAngle = tab[10] v.MaxVelocity = math.abs(v.DesiredAngle-v.CurrentAngle)/time end
			for _,v in pairs(lf2) do v.DesiredAngle = tab[10] v.MaxVelocity = math.abs(v.DesiredAngle-v.CurrentAngle)/time end
			for _,v in pairs(rf3) do v.DesiredAngle = tab[11] v.MaxVelocity = math.abs(v.DesiredAngle-v.CurrentAngle)/time end
			for _,v in pairs(lf3) do v.DesiredAngle = tab[11] v.MaxVelocity = math.abs(v.DesiredAngle-v.CurrentAngle)/time end
		end

		setwings(outhigh,1)
		flying = false
		moving = false

		for i,v in pairs(rootPart:GetChildren()) do
			if v.ClassName:lower():match("body") then v:Destroy() end
		end

		local ctor = Instance.new("Part")
		ctor.Name = "cTorso"
		ctor.Transparency = 1
		ctor.CanCollide = false
		ctor.FormFactor = "Custom"
		ctor.Size = Vector3.new(.2,.2,.2)
		ctor.Parent = mod
		weld(rootPart,ctor) -- Changed weld focus to RootPart for R15 calculation stabilization

		local bg = Instance.new("BodyGyro",ctor)
		bg.maxTorque = Vector3.new()
		bg.P = 15000
		bg.D = 1000
		local bv = Instance.new("BodyVelocity",ctor)
		bv.maxForce = Vector3.new()
		bv.P = 15000
		vel = Vector3.new()
		cf = CFrame.new()
		flspd = 0

		keysdown = {w = false, a = false, s = false, d = false, q = false}
		local mobileSpinHold = {a = false, d = false}
		keypressed = {}
		ktime = {}
		descendtimer = 0
		reqrotx = 0
		cam = workspace.CurrentCamera

		local sg = Instance.new("ScreenGui", plr:WaitForChild("PlayerGui"))
		sg.Name = "WingControlGui"

		local wasdContainer = Instance.new("Frame", sg)
		wasdContainer.Size = UDim2.new(0, 160, 0, 160)
		wasdContainer.Position = UDim2.new(0.1, 0, 0.5, -80)
		wasdContainer.BackgroundTransparency = 1

		local buttons = {}
		local function createWASDButton(name, text, pos)
			local btn = Instance.new("TextButton", wasdContainer)
			btn.Size = UDim2.new(0, 45, 0, 45)
			btn.Position = pos
			btn.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
			btn.TextColor3 = Color3.new(1, 1, 1)
			btn.TextSize = 18
			btn.Font = Enum.Font.SourceSansBold
			btn.Text = text
			btn.Active = true
			btn.Draggable = true

			btn.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					keysdown[name] = true
					keypressed[name] = true
					if name == "q" then descendtimer = tick() end
					if (name == "a" or name == "d") and ktime[name] and tick()-ktime[name] < .3 then
						reqrotx = (name == "a") and math.pi*2 or -math.pi*2
					end
					ktime[name] = tick()
				end
			end)

			btn.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					keysdown[name] = false
				end
			end)

			buttons[name] = btn
		end

		createWASDButton("w", "W", UDim2.new(0, 55, 0, 5))
		createWASDButton("a", "A", UDim2.new(0, 5, 0, 55))
		createWASDButton("s", "S", UDim2.new(0, 55, 0, 55))
		createWASDButton("d", "D", UDim2.new(0, 105, 0, 55))
		createWASDButton("q", "Q", UDim2.new(0, 55, 0, 105))

		local function createSpecialSpinButton(directionName, labelText, position)
			local spinBtn = Instance.new("TextButton", wasdContainer)
			spinBtn.Size = UDim2.new(0, 100, 0, 40)
			spinBtn.Position = position
			spinBtn.BackgroundColor3 = Color3.new(0.4, 0.1, 0.5)
			spinBtn.TextColor3 = Color3.new(1, 1, 1)
			spinBtn.TextSize = 12
			spinBtn.Font = Enum.Font.SourceSansBold
			spinBtn.Text = labelText
			spinBtn.Active = true
			spinBtn.Draggable = true

			spinBtn.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					mobileSpinHold[directionName] = true
				end
			end)

			spinBtn.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					mobileSpinHold[directionName] = false
				end
			end)

			table.insert(buttons, spinBtn)
		end

		createSpecialSpinButton("a", "Barrel Roll L", UDim2.new(0, -110, 0, 55))
		createSpecialSpinButton("d", "Barrel Roll R", UDim2.new(0, 160, 0, 55))

		local function setButtonsDraggable(allowed)
			for _, btn in pairs(buttons) do
				btn.Draggable = allowed
			end
		end

		function toggleFlight()
			if not flying then
				vel = Vector3.new(0,50,0)
				bv.velocity = vel
				idledir = cam.CoordinateFrame.lookVector*Vector3.new(1,0,1)
				cf = rootPart.CFrame * CFrame.Angles(-.01,0,0)
				rootPart.CFrame = cf
				bg.cframe = cf
				flystart = tick()
				flying = true
				setButtonsDraggable(false)
			else
				flying = false
				hum.PlatformStand = false
				rootPart.Velocity = Vector3.new()
				setButtonsDraggable(true)
			end
		end

		kd = plr:GetMouse().KeyDown:connect(oc(function(key) 
			keysdown[key] = true 
			keypressed[key] = true 
			if key == "q" then 
				descendtimer = tick() 
			elseif key == "j" then 
				toggleFlight()
			elseif (key == "a" or key == "d") and ktime[key] and tick()-ktime[key] < .3 then
				reqrotx = key == "a" and math.pi*2 or -math.pi*2
			end
			ktime[key] = tick() 
		end))

		ku = plr:GetMouse().KeyUp:connect(function(key) 
			keysdown[key] = false 
		end)

		local mainButton = Instance.new("TextButton", sg)
		mainButton.Size = UDim2.new(0, 130, 0, 50)
		mainButton.Position = UDim2.new(0.85, -65, 0.5, -85)
		mainButton.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
		mainButton.TextColor3 = Color3.new(1, 1, 1)
		mainButton.TextSize = 14
		mainButton.Font = Enum.Font.SourceSansBold
		mainButton.Text = "Skin: 0 (Default)"
		mainButton.Active = true
		mainButton.Draggable = true

		local scaleButton = Instance.new("TextButton", sg)
		scaleButton.Size = UDim2.new(0, 130, 0, 50)
		scaleButton.Position = UDim2.new(0.85, -65, 0.5, -25)
		scaleButton.BackgroundColor3 = Color3.new(0.1, 0.4, 0.6)
		scaleButton.TextColor3 = Color3.new(1, 1, 1)
		scaleButton.TextSize = 14
		scaleButton.Font = Enum.Font.SourceSansBold
		scaleButton.Text = "Scale: 1x"
		scaleButton.Active = true
		scaleButton.Draggable = true

		local mobileFlyButton = Instance.new("TextButton", sg)
		mobileFlyButton.Size = UDim2.new(0, 130, 0, 50)
		mobileFlyButton.Position = UDim2.new(0.85, -65, 0.5, 35)
		mobileFlyButton.BackgroundColor3 = Color3.new(0.1, 0.6, 0.1)
		mobileFlyButton.TextColor3 = Color3.new(1, 1, 1)
		mobileFlyButton.TextSize = 14
		mobileFlyButton.Font = Enum.Font.SourceSansBold
		mobileFlyButton.Text = "Toggle Fly (J)"
		mobileFlyButton.Active = true
		mobileFlyButton.Draggable = true

		mobileFlyButton.MouseButton1Click:Connect(function()
			toggleFlight()
		end)

		mainButton.MouseButton1Click:Connect(function()
			local num = tonumber(currentSkin)
			if num == 11 then currentSkin = "0" else currentSkin = tostring(num + 1) end
			if currentSkin == "0" then mainButton.Text = "Skin: 0 (Default)" else mainButton.Text = "Skin: " .. currentSkin end
			applySkin(currentSkin)
		end)

		scaleButton.MouseButton1Click:Connect(function()
			local nextScale = currentScale + 1
			if nextScale > 2 then nextScale = 1 end
			scaleButton.Text = "Scale: " .. tostring(nextScale) .. "x"
			applyScale(nextScale)
		end)

		function mid(a,b,c) return math.max(a,math.min(b,c or -a)) end
		function bn(a) return a and 1 or 0 end

		local grav = 196.2
		local con
		con = game:GetService("RunService").Stepped:connect(oc(function()
			if not char or not rootPart or not hum or hum.Health <= 0 then 
				con:Disconnect() 
				return 
			end
			
			local obvel = rootPart.CFrame:vectorToObjectSpace(rootPart.Velocity)
			local sspd, uspd, fspd = obvel.X, obvel.Y, obvel.Z
			if flying then
				if mobileSpinHold.a or (keysdown.a and math.abs(reqrotx) > 0.5) then
					reqrotx = math.pi * 2
				elseif mobileSpinHold.d or (keysdown.d and math.abs(reqrotx) > 0.5) then
					reqrotx = -math.pi * 2
				else
					reqrotx = reqrotx - reqrotx / 10
				end

				local lfldir = fldir
				fldir = cam.CoordinateFrame:vectorToWorldSpace(Vector3.new(bn(keysdown.d)-bn(keysdown.a),0,bn(keysdown.s)-bn(keysdown.w))).unit
				local lmoving = moving
				moving = fldir.magnitude > .1
				if lmoving and not moving then
					idledir = lfldir*Vector3.new(1,0,1)
					descendtimer = tick()
				end
				local dbomb = fldir.Y < -.6 or (moving and keysdown["1"])
				if moving and keysdown["0"] and lmoving then
					fldir = (Vector3.new(lfldir.X,math.min(fldir.Y,lfldir.Y+.01)-.1,lfldir.Z)+(fldir*Vector3.new(1,0,1))*.05).unit
				end
				local down = rootPart.CFrame:vectorToWorldSpace(Vector3.new(0,-1,0))
				local descending = (not moving and keysdown["q"])
				cf = ccomplerp(cf,CFrame.new(rootPart.Position,rootPart.Position+(not moving and idledir or fldir)),keysdown["0"] and .02 or .07)
				local gdown = not dbomb and cf.lookVector.Y < -.2 and rootPart.Velocity.unit.Y < .05
				hum.PlatformStand = true
				bg.maxTorque = Vector3.new(1,1,1)*9e5
				local rotvel = CFrame.new(Vector3.new(),rootPart.Velocity):toObjectSpace(CFrame.new(Vector3.new(),fldir)).lookVector
				bg.cframe = cf * CFrame.Angles(not moving and -.1 or -math.pi/2+.2,moving and mid(-2.5,rotvel.X/1.5) + reqrotx or 0,0)
				
				bv.maxForce = Vector3.new(1,1,1)*9e4*.5
				local anioff = (descending and -0.5 or 0)
				local ani = tickwave(1.5-anioff,1)
				bv.velocity = bv.velocity:Lerp(Vector3.new(0,bn(not moving)*-ani*15+(descending and math.min(20,tick()-descendtimer)*-8 or 0)*15,0)+vel,.6) 
				vel = moving and cf.lookVector*flspd or Vector3.new()
				flspd = math.min(120,lerp(flspd,moving and (fldir.Y<0 and flspd+(-fldir.Y)*grav/60 or math.max(50,flspd-fldir.Y*grav/300)) or 60,.4))
				setwings(moving and (gdown and outlow or dbomb and divebomb) or (descending and veryhigh or flap1),15)
				for i=1,4 do
					rwing[i].C0 = clerp(rwing[i].C0,oc0[rwing[i]] * (gdown and CFrame.new() or dbomb and CFrame.Angles(-.5+bn(i==3)*.4+bn(i==4)*.5,.1+bn(i==2)*.5-bn(i==3)*1.1,bn(i==3)*.1) or descending and CFrame.Angles(.3,0,0) or CFrame.Angles((i*.1+1.5)*ani,ani*-.5,1*ani)),descending and .8 or .2)
					lwing[i].C0 = clerp(lwing[i].C0,oc0[lwing[i]] * (gdown and CFrame.new() or dbomb and CFrame.Angles(-(-.5+bn(i==3)*.4+bn(i==4)*.5),-(.1+bn(i==2)*.5-bn(i==3)*1.1),bn(i==3)*.1) or descending and CFrame.Angles(-.3,0,0) or CFrame.Angles(-(i*.1+1.5)*ani,ani*.5,1*ani)),descending and .8 or .2)
				end
				local hit,ray = workspace:FindPartOnRayWithIgnoreList(Ray.new(rootPart.Position,Vector3.new(0,-3.5+math.min(0,bv.velocity.y)/30,0)),{char})
				if hit and down.Y < -.85 and tick()-flystart > 1 then
					flying = false
					hum.PlatformStand = false
					rootPart.Velocity = Vector3.new()
					setButtonsDraggable(true)
				end
			else
				bg.maxTorque = Vector3.new()
				bv.maxForce = Vector3.new()
				local ani = tickwave(4.5,1)
				setwings(idle,10)
				local x,y,z = fspd/160,uspd/700,sspd/900
				for i=1,4 do
					rwing[i].C0 = clerp(rwing[i].C0,oc0[rwing[i]] * CFrame.Angles(ani*.1 + -mid(-.1,x),0 + -mid(-.1,y) + bn(i==2)*.6,ani*.02 + -mid(-.1,z)),.2)
					lwing[i].C0 = clerp(lwing[i].C0,oc0[lwing[i]] * CFrame.Angles(ani*-.05 + mid(-.1,x),0 + mid(-.1,y) + -bn(i==2)*.6,ani*.02 + mid(-.1,z)),.2)
				end
			end
			keypressed = {}
		end))
	end fly()
end

if plr.Character then
	task.spawn(runWingScript, plr.Character)
end

plr.CharacterAdded:Connect(function(newCharacter)
	task.spawn(runWingScript, newCharacter)
end)
