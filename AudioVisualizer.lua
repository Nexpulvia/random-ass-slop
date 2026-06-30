wait()
for i,v in pairs(game.Workspace:GetChildren()) do
	if v.Name == "Soundbar" then
		v:Destroy()
	end
end
local runDummyScript = function(f,scri)
local oldenv = getfenv(f)
local newenv = setmetatable({}, {
__index = function(_, k)
if k:lower() == 'script' then
return scri
else
return oldenv[k]
end
end
})
setfenv(f, newenv)
ypcall(function() f() end)
end
function cycle(num)
	local section=num % 1 * 3;
	local secondary=0.5 * math.pi * (section % 1);
	if section < 1 then
		return 1,1 - math.cos(secondary),1 - math.sin(secondary);
	elseif section < 2 then
		return 1 - math.sin(secondary),1,1 - math.cos(secondary);
	else
		return 1 - math.cos(secondary),1 - math.sin(secondary),1;
	end
end
cors = {}
mas = Instance.new("Model",game:GetService("Lighting")) 
mas.Name = "CompiledModel"
o1 = Instance.new("Model")
o1.Name = "Soundbar"
o1.Parent = mas
o2 = Instance.new("Part")
o2.Name = "0"
o2.Parent = o1
o2.Position = Vector3.new(9.5, 0.200000018, 0)
o2.Anchored = true
o2.CFrame = CFrame.new(9.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o2.CanCollide = false
o2.Size = Vector3.new(0.5, 0.200000003, 0.5)
o2.BottomSurface = Enum.SurfaceType.Smooth
o2.TopSurface = Enum.SurfaceType.Smooth
o3 = Instance.new("SpecialMesh")
o3.Parent = o2
o3.MeshId = "rbxassetid://9856898"
o3.Scale = Vector3.new(1, 0.400000006, 1)
o3.TextureId = "rbxassetid://2114473"
o3.MeshType = Enum.MeshType.FileMesh
o4 = Instance.new("Part")
o4.Name = "9"
o4.Parent = o1
o4.Position = Vector3.new(5, 0.200000018, 0)
o4.Anchored = true
o4.CFrame = CFrame.new(5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o4.CanCollide = false
o4.Size = Vector3.new(0.5, 0.200000003, 0.5)
o4.BottomSurface = Enum.SurfaceType.Smooth
o4.TopSurface = Enum.SurfaceType.Smooth
o5 = Instance.new("SpecialMesh")
o5.Parent = o4
o5.MeshId = "rbxassetid://9856898"
o5.Scale = Vector3.new(1, 0.400000006, 1)
o5.TextureId = "rbxassetid://2114473"
o5.MeshType = Enum.MeshType.FileMesh
o6 = Instance.new("Part")
o6.Name = "10"
o6.Parent = o1
o6.Position = Vector3.new(4.5, 0.200000018, 0)
o6.Anchored = true
o6.CFrame = CFrame.new(4.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o6.CanCollide = false
o6.Size = Vector3.new(0.5, 0.200000003, 0.5)
o6.BottomSurface = Enum.SurfaceType.Smooth
o6.TopSurface = Enum.SurfaceType.Smooth
o7 = Instance.new("SpecialMesh")
o7.Parent = o6
o7.MeshId = "rbxassetid://9856898"
o7.Scale = Vector3.new(1, 0.400000006, 1)
o7.TextureId = "rbxassetid://2114473"
o7.MeshType = Enum.MeshType.FileMesh
o8 = Instance.new("Part")
o8.Name = "11"
o8.Parent = o1
o8.Position = Vector3.new(4, 0.200000018, 0)
o8.Anchored = true
o8.CFrame = CFrame.new(4, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o8.CanCollide = false
o8.Size = Vector3.new(0.5, 0.200000003, 0.5)
o8.BottomSurface = Enum.SurfaceType.Smooth
o8.TopSurface = Enum.SurfaceType.Smooth
o9 = Instance.new("SpecialMesh")
o9.Parent = o8
o9.MeshId = "rbxassetid://9856898"
o9.Scale = Vector3.new(1, 0.400000006, 1)
o9.TextureId = "rbxassetid://2114473"
o9.MeshType = Enum.MeshType.FileMesh
o10 = Instance.new("Part")
o10.Name = "12"
o10.Parent = o1
o10.Position = Vector3.new(3.5, 0.200000018, 0)
o10.Anchored = true
o10.CFrame = CFrame.new(3.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o10.CanCollide = false
o10.Size = Vector3.new(0.5, 0.200000003, 0.5)
o10.BottomSurface = Enum.SurfaceType.Smooth
o10.TopSurface = Enum.SurfaceType.Smooth
o11 = Instance.new("SpecialMesh")
o11.Parent = o10
o11.MeshId = "rbxassetid://9856898"
o11.Scale = Vector3.new(1, 0.400000006, 1)
o11.TextureId = "rbxassetid://2114473"
o11.MeshType = Enum.MeshType.FileMesh
o12 = Instance.new("Part")
o12.Name = "13"
o12.Parent = o1
o12.Position = Vector3.new(3, 0.200000018, 0)
o12.Anchored = true
o12.CFrame = CFrame.new(3, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o12.CanCollide = false
o12.Size = Vector3.new(0.5, 0.200000003, 0.5)
o12.BottomSurface = Enum.SurfaceType.Smooth
o12.TopSurface = Enum.SurfaceType.Smooth
o13 = Instance.new("SpecialMesh")
o13.Parent = o12
o13.MeshId = "rbxassetid://9856898"
o13.Scale = Vector3.new(1, 0.400000006, 1)
o13.TextureId = "rbxassetid://2114473"
o13.MeshType = Enum.MeshType.FileMesh
o14 = Instance.new("Part")
o14.Name = "1"
o14.Parent = o1
o14.Position = Vector3.new(9, 0.200000018, 0)
o14.Anchored = true
o14.CFrame = CFrame.new(9, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o14.CanCollide = false
o14.Size = Vector3.new(0.5, 0.200000003, 0.5)
o14.BottomSurface = Enum.SurfaceType.Smooth
o14.TopSurface = Enum.SurfaceType.Smooth
o15 = Instance.new("SpecialMesh")
o15.Parent = o14
o15.MeshId = "rbxassetid://9856898"
o15.Scale = Vector3.new(1, 0.400000006, 1)
o15.TextureId = "rbxassetid://2114473"
o15.MeshType = Enum.MeshType.FileMesh
o16 = Instance.new("Part")
o16.Name = "19"
o16.Parent = o1
o16.Position = Vector3.new(0, 0.200000018, 0)
o16.Anchored = true
o16.CFrame = CFrame.new(0, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o16.CanCollide = false
o16.Size = Vector3.new(0.5, 0.200000003, 0.5)
o16.BottomSurface = Enum.SurfaceType.Smooth
o16.TopSurface = Enum.SurfaceType.Smooth
o17 = Instance.new("SpecialMesh")
o17.Parent = o16
o17.MeshId = "rbxassetid://9856898"
o17.Scale = Vector3.new(1, 0.400000006, 1)
o17.TextureId = "rbxassetid://2114473"
o17.MeshType = Enum.MeshType.FileMesh
o18 = Instance.new("Part")
o18.Name = "20"
o18.Parent = o1
o18.Position = Vector3.new(-0.5, 0.200000018, 0)
o18.Anchored = true
o18.CFrame = CFrame.new(-0.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o18.CanCollide = false
o18.Size = Vector3.new(0.5, 0.200000003, 0.5)
o18.BottomSurface = Enum.SurfaceType.Smooth
o18.TopSurface = Enum.SurfaceType.Smooth
o19 = Instance.new("SpecialMesh")
o19.Parent = o18
o19.MeshId = "rbxassetid://9856898"
o19.Scale = Vector3.new(1, 0.400000006, 1)
o19.TextureId = "rbxassetid://2114473"
o19.MeshType = Enum.MeshType.FileMesh
o20 = Instance.new("Part")
o20.Name = "21"
o20.Parent = o1
o20.Position = Vector3.new(-1, 0.200000018, 0)
o20.Anchored = true
o20.CFrame = CFrame.new(-1, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o20.CanCollide = false
o20.Size = Vector3.new(0.5, 0.200000003, 0.5)
o20.BottomSurface = Enum.SurfaceType.Smooth
o20.TopSurface = Enum.SurfaceType.Smooth
o21 = Instance.new("SpecialMesh")
o21.Parent = o20
o21.MeshId = "rbxassetid://9856898"
o21.Scale = Vector3.new(1, 0.400000006, 1)
o21.TextureId = "rbxassetid://2114473"
o21.MeshType = Enum.MeshType.FileMesh
o22 = Instance.new("Part")
o22.Name = "22"
o22.Parent = o1
o22.Position = Vector3.new(-1.5, 0.200000018, 0)
o22.Anchored = true
o22.CFrame = CFrame.new(-1.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o22.CanCollide = false
o22.Size = Vector3.new(0.5, 0.200000003, 0.5)
o22.BottomSurface = Enum.SurfaceType.Smooth
o22.TopSurface = Enum.SurfaceType.Smooth
o23 = Instance.new("SpecialMesh")
o23.Parent = o22
o23.MeshId = "rbxassetid://9856898"
o23.Scale = Vector3.new(1, 0.400000006, 1)
o23.TextureId = "rbxassetid://2114473"
o23.MeshType = Enum.MeshType.FileMesh
o24 = Instance.new("Part")
o24.Name = "23"
o24.Parent = o1
o24.Position = Vector3.new(-2, 0.200000018, 0)
o24.Anchored = true
o24.CFrame = CFrame.new(-2, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o24.CanCollide = false
o24.Size = Vector3.new(0.5, 0.200000003, 0.5)
o24.BottomSurface = Enum.SurfaceType.Smooth
o24.TopSurface = Enum.SurfaceType.Smooth
o25 = Instance.new("SpecialMesh")
o25.Parent = o24
o25.MeshId = "rbxassetid://9856898"
o25.Scale = Vector3.new(1, 0.400000006, 1)
o25.TextureId = "rbxassetid://2114473"
o25.MeshType = Enum.MeshType.FileMesh
o26 = Instance.new("Part")
o26.Name = "2"
o26.Parent = o1
o26.Position = Vector3.new(8.5, 0.200000018, 0)
o26.Anchored = true
o26.CFrame = CFrame.new(8.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o26.CanCollide = false
o26.Size = Vector3.new(0.5, 0.200000003, 0.5)
o26.BottomSurface = Enum.SurfaceType.Smooth
o26.TopSurface = Enum.SurfaceType.Smooth
o27 = Instance.new("SpecialMesh")
o27.Parent = o26
o27.MeshId = "rbxassetid://9856898"
o27.Scale = Vector3.new(1, 0.400000006, 1)
o27.TextureId = "rbxassetid://2114473"
o27.MeshType = Enum.MeshType.FileMesh
o28 = Instance.new("Part")
o28.Name = "29"
o28.Parent = o1
o28.Position = Vector3.new(-5, 0.200000018, 0)
o28.Anchored = true
o28.CFrame = CFrame.new(-5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o28.CanCollide = false
o28.Size = Vector3.new(0.5, 0.200000003, 0.5)
o28.BottomSurface = Enum.SurfaceType.Smooth
o28.TopSurface = Enum.SurfaceType.Smooth
o29 = Instance.new("SpecialMesh")
o29.Parent = o28
o29.MeshId = "rbxassetid://9856898"
o29.Scale = Vector3.new(1, 0.400000006, 1)
o29.TextureId = "rbxassetid://2114473"
o29.MeshType = Enum.MeshType.FileMesh
o30 = Instance.new("Part")
o30.Name = "30"
o30.Parent = o1
o30.Position = Vector3.new(-5.5, 0.200000018, 0)
o30.Anchored = true
o30.CFrame = CFrame.new(-5.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o30.CanCollide = false
o30.Size = Vector3.new(0.5, 0.200000003, 0.5)
o30.BottomSurface = Enum.SurfaceType.Smooth
o30.TopSurface = Enum.SurfaceType.Smooth
o31 = Instance.new("SpecialMesh")
o31.Parent = o30
o31.MeshId = "rbxassetid://9856898"
o31.Scale = Vector3.new(1, 0.400000006, 1)
o31.TextureId = "rbxassetid://2114473"
o31.MeshType = Enum.MeshType.FileMesh
o32 = Instance.new("Part")
o32.Name = "31"
o32.Parent = o1
o32.Position = Vector3.new(-6, 0.200000018, 0)
o32.Anchored = true
o32.CFrame = CFrame.new(-6, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o32.CanCollide = false
o32.Size = Vector3.new(0.5, 0.200000003, 0.5)
o32.BottomSurface = Enum.SurfaceType.Smooth
o32.TopSurface = Enum.SurfaceType.Smooth
o33 = Instance.new("SpecialMesh")
o33.Parent = o32
o33.MeshId = "rbxassetid://9856898"
o33.Scale = Vector3.new(1, 0.400000006, 1)
o33.TextureId = "rbxassetid://2114473"
o33.MeshType = Enum.MeshType.FileMesh
o34 = Instance.new("Part")
o34.Name = "32"
o34.Parent = o1
o34.Position = Vector3.new(-6.5, 0.200000018, 0)
o34.Anchored = true
o34.CFrame = CFrame.new(-6.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o34.CanCollide = false
o34.Size = Vector3.new(0.5, 0.200000003, 0.5)
o34.BottomSurface = Enum.SurfaceType.Smooth
o34.TopSurface = Enum.SurfaceType.Smooth
o35 = Instance.new("SpecialMesh")
o35.Parent = o34
o35.MeshId = "rbxassetid://9856898"
o35.Scale = Vector3.new(1, 0.400000006, 1)
o35.TextureId = "rbxassetid://2114473"
o35.MeshType = Enum.MeshType.FileMesh
o36 = Instance.new("Part")
o36.Name = "33"
o36.Parent = o1
o36.Position = Vector3.new(-7, 0.200000018, 0)
o36.Anchored = true
o36.CFrame = CFrame.new(-7, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o36.CanCollide = false
o36.Size = Vector3.new(0.5, 0.200000003, 0.5)
o36.BottomSurface = Enum.SurfaceType.Smooth
o36.TopSurface = Enum.SurfaceType.Smooth
o37 = Instance.new("SpecialMesh")
o37.Parent = o36
o37.MeshId = "rbxassetid://9856898"
o37.Scale = Vector3.new(1, 0.400000006, 1)
o37.TextureId = "rbxassetid://2114473"
o37.MeshType = Enum.MeshType.FileMesh
o38 = Instance.new("Part")
o38.Name = "3"
o38.Parent = o1
o38.Position = Vector3.new(8, 0.200000018, 0)
o38.Anchored = true
o38.CFrame = CFrame.new(8, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o38.CanCollide = false
o38.Size = Vector3.new(0.5, 0.200000003, 0.5)
o38.BottomSurface = Enum.SurfaceType.Smooth
o38.TopSurface = Enum.SurfaceType.Smooth
o39 = Instance.new("SpecialMesh")
o39.Parent = o38
o39.MeshId = "rbxassetid://9856898"
o39.Scale = Vector3.new(1, 0.400000006, 1)
o39.TextureId = "rbxassetid://2114473"
o39.MeshType = Enum.MeshType.FileMesh
o40 = Instance.new("Part")
o40.Name = "14"
o40.Parent = o1
o40.Position = Vector3.new(2.5, 0.200000018, 0)
o40.Anchored = true
o40.CFrame = CFrame.new(2.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o40.CanCollide = false
o40.Size = Vector3.new(0.5, 0.200000003, 0.5)
o40.BottomSurface = Enum.SurfaceType.Smooth
o40.TopSurface = Enum.SurfaceType.Smooth
o41 = Instance.new("SpecialMesh")
o41.Parent = o40
o41.MeshId = "rbxassetid://9856898"
o41.Scale = Vector3.new(1, 0.400000006, 1)
o41.TextureId = "rbxassetid://2114473"
o41.MeshType = Enum.MeshType.FileMesh
o42 = Instance.new("Part")
o42.Name = "24"
o42.Parent = o1
o42.Position = Vector3.new(-2.5, 0.200000018, 0)
o42.Anchored = true
o42.CFrame = CFrame.new(-2.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o42.CanCollide = false
o42.Size = Vector3.new(0.5, 0.200000003, 0.5)
o42.BottomSurface = Enum.SurfaceType.Smooth
o42.TopSurface = Enum.SurfaceType.Smooth
o43 = Instance.new("SpecialMesh")
o43.Parent = o42
o43.MeshId = "rbxassetid://9856898"
o43.Scale = Vector3.new(1, 0.400000006, 1)
o43.TextureId = "rbxassetid://2114473"
o43.MeshType = Enum.MeshType.FileMesh
o44 = Instance.new("Part")
o44.Name = "4"
o44.Parent = o1
o44.Position = Vector3.new(7.5, 0.200000018, 0)
o44.Anchored = true
o44.CFrame = CFrame.new(7.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o44.CanCollide = false
o44.Size = Vector3.new(0.5, 0.200000003, 0.5)
o44.BottomSurface = Enum.SurfaceType.Smooth
o44.TopSurface = Enum.SurfaceType.Smooth
o45 = Instance.new("SpecialMesh")
o45.Parent = o44
o45.MeshId = "rbxassetid://9856898"
o45.Scale = Vector3.new(1, 0.400000006, 1)
o45.TextureId = "rbxassetid://2114473"
o45.MeshType = Enum.MeshType.FileMesh
o46 = Instance.new("Part")
o46.Name = "34"
o46.Parent = o1
o46.Position = Vector3.new(-7.5, 0.200000018, 0)
o46.Anchored = true
o46.CFrame = CFrame.new(-7.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o46.CanCollide = false
o46.Size = Vector3.new(0.5, 0.200000003, 0.5)
o46.BottomSurface = Enum.SurfaceType.Smooth
o46.TopSurface = Enum.SurfaceType.Smooth
o47 = Instance.new("SpecialMesh")
o47.Parent = o46
o47.MeshId = "rbxassetid://9856898"
o47.Scale = Vector3.new(1, 0.400000006, 1)
o47.TextureId = "rbxassetid://2114473"
o47.MeshType = Enum.MeshType.FileMesh
o48 = Instance.new("Part")
o48.Name = "15"
o48.Parent = o1
o48.Position = Vector3.new(2, 0.200000018, 0)
o48.Anchored = true
o48.CFrame = CFrame.new(2, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o48.CanCollide = false
o48.Size = Vector3.new(0.5, 0.200000003, 0.5)
o48.BottomSurface = Enum.SurfaceType.Smooth
o48.TopSurface = Enum.SurfaceType.Smooth
o49 = Instance.new("SpecialMesh")
o49.Parent = o48
o49.MeshId = "rbxassetid://9856898"
o49.Scale = Vector3.new(1, 0.400000006, 1)
o49.TextureId = "rbxassetid://2114473"
o49.MeshType = Enum.MeshType.FileMesh
o50 = Instance.new("Part")
o50.Name = "25"
o50.Parent = o1
o50.Position = Vector3.new(-3, 0.200000018, 0)
o50.Anchored = true
o50.CFrame = CFrame.new(-3, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o50.CanCollide = false
o50.Size = Vector3.new(0.5, 0.200000003, 0.5)
o50.BottomSurface = Enum.SurfaceType.Smooth
o50.TopSurface = Enum.SurfaceType.Smooth
o51 = Instance.new("SpecialMesh")
o51.Parent = o50
o51.MeshId = "rbxassetid://9856898"
o51.Scale = Vector3.new(1, 0.400000006, 1)
o51.TextureId = "rbxassetid://2114473"
o51.MeshType = Enum.MeshType.FileMesh
o52 = Instance.new("Part")
o52.Name = "5"
o52.Parent = o1
o52.Position = Vector3.new(7, 0.200000018, 0)
o52.Anchored = true
o52.CFrame = CFrame.new(7, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o52.CanCollide = false
o52.Size = Vector3.new(0.5, 0.200000003, 0.5)
o52.BottomSurface = Enum.SurfaceType.Smooth
o52.TopSurface = Enum.SurfaceType.Smooth
o53 = Instance.new("SpecialMesh")
o53.Parent = o52
o53.MeshId = "rbxassetid://9856898"
o53.Scale = Vector3.new(1, 0.400000006, 1)
o53.TextureId = "rbxassetid://2114473"
o53.MeshType = Enum.MeshType.FileMesh
o54 = Instance.new("Part")
o54.Name = "35"
o54.Parent = o1
o54.Position = Vector3.new(-8, 0.200000018, 0)
o54.Anchored = true
o54.CFrame = CFrame.new(-8, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o54.CanCollide = false
o54.Size = Vector3.new(0.5, 0.200000003, 0.5)
o54.BottomSurface = Enum.SurfaceType.Smooth
o54.TopSurface = Enum.SurfaceType.Smooth
o55 = Instance.new("SpecialMesh")
o55.Parent = o54
o55.MeshId = "rbxassetid://9856898"
o55.Scale = Vector3.new(1, 0.400000006, 1)
o55.TextureId = "rbxassetid://2114473"
o55.MeshType = Enum.MeshType.FileMesh
o56 = Instance.new("Part")
o56.Name = "16"
o56.Parent = o1
o56.Position = Vector3.new(1.5, 0.200000018, 0)
o56.Anchored = true
o56.CFrame = CFrame.new(1.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o56.CanCollide = false
o56.Size = Vector3.new(0.5, 0.200000003, 0.5)
o56.BottomSurface = Enum.SurfaceType.Smooth
o56.TopSurface = Enum.SurfaceType.Smooth
o57 = Instance.new("SpecialMesh")
o57.Parent = o56
o57.MeshId = "rbxassetid://9856898"
o57.Scale = Vector3.new(1, 0.400000006, 1)
o57.TextureId = "rbxassetid://2114473"
o57.MeshType = Enum.MeshType.FileMesh
o58 = Instance.new("Part")
o58.Name = "6"
o58.Parent = o1
o58.Position = Vector3.new(6.5, 0.200000018, 0)
o58.Anchored = true
o58.CFrame = CFrame.new(6.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o58.CanCollide = false
o58.Size = Vector3.new(0.5, 0.200000003, 0.5)
o58.BottomSurface = Enum.SurfaceType.Smooth
o58.TopSurface = Enum.SurfaceType.Smooth
o59 = Instance.new("SpecialMesh")
o59.Parent = o58
o59.MeshId = "rbxassetid://9856898"
o59.Scale = Vector3.new(1, 0.400000006, 1)
o59.TextureId = "rbxassetid://2114473"
o59.MeshType = Enum.MeshType.FileMesh
o60 = Instance.new("Part")
o60.Name = "26"
o60.Parent = o1
o60.Position = Vector3.new(-3.5, 0.200000018, 0)
o60.Anchored = true
o60.CFrame = CFrame.new(-3.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o60.CanCollide = false
o60.Size = Vector3.new(0.5, 0.200000003, 0.5)
o60.BottomSurface = Enum.SurfaceType.Smooth
o60.TopSurface = Enum.SurfaceType.Smooth
o61 = Instance.new("SpecialMesh")
o61.Parent = o60
o61.MeshId = "rbxassetid://9856898"
o61.Scale = Vector3.new(1, 0.400000006, 1)
o61.TextureId = "rbxassetid://2114473"
o61.MeshType = Enum.MeshType.FileMesh
o62 = Instance.new("Part")
o62.Name = "36"
o62.Parent = o1
o62.Position = Vector3.new(-8.5, 0.200000018, 0)
o62.Anchored = true
o62.CFrame = CFrame.new(-8.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o62.CanCollide = false
o62.Size = Vector3.new(0.5, 0.200000003, 0.5)
o62.BottomSurface = Enum.SurfaceType.Smooth
o62.TopSurface = Enum.SurfaceType.Smooth
o63 = Instance.new("SpecialMesh")
o63.Parent = o62
o63.MeshId = "rbxassetid://9856898"
o63.Scale = Vector3.new(1, 0.400000006, 1)
o63.TextureId = "rbxassetid://2114473"
o63.MeshType = Enum.MeshType.FileMesh
o64 = Instance.new("Part")
o64.Name = "17"
o64.Parent = o1
o64.Position = Vector3.new(1, 0.200000018, 0)
o64.Anchored = true
o64.CFrame = CFrame.new(1, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o64.CanCollide = false
o64.Size = Vector3.new(0.5, 0.200000003, 0.5)
o64.BottomSurface = Enum.SurfaceType.Smooth
o64.TopSurface = Enum.SurfaceType.Smooth
o65 = Instance.new("SpecialMesh")
o65.Parent = o64
o65.MeshId = "rbxassetid://9856898"
o65.Scale = Vector3.new(1, 0.400000006, 1)
o65.TextureId = "rbxassetid://2114473"
o65.MeshType = Enum.MeshType.FileMesh
o66 = Instance.new("Part")
o66.Name = "27"
o66.Parent = o1
o66.Position = Vector3.new(-4, 0.200000018, 0)
o66.Anchored = true
o66.CFrame = CFrame.new(-4, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o66.CanCollide = false
o66.Size = Vector3.new(0.5, 0.200000003, 0.5)
o66.BottomSurface = Enum.SurfaceType.Smooth
o66.TopSurface = Enum.SurfaceType.Smooth
o67 = Instance.new("SpecialMesh")
o67.Parent = o66
o67.MeshId = "rbxassetid://9856898"
o67.Scale = Vector3.new(1, 0.400000006, 1)
o67.TextureId = "rbxassetid://2114473"
o67.MeshType = Enum.MeshType.FileMesh
o68 = Instance.new("Part")
o68.Name = "7"
o68.Parent = o1
o68.Position = Vector3.new(6, 0.200000018, 0)
o68.Anchored = true
o68.CFrame = CFrame.new(6, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o68.CanCollide = false
o68.Size = Vector3.new(0.5, 0.200000003, 0.5)
o68.BottomSurface = Enum.SurfaceType.Smooth
o68.TopSurface = Enum.SurfaceType.Smooth
o69 = Instance.new("SpecialMesh")
o69.Parent = o68
o69.MeshId = "rbxassetid://9856898"
o69.Scale = Vector3.new(1, 0.400000006, 1)
o69.TextureId = "rbxassetid://2114473"
o69.MeshType = Enum.MeshType.FileMesh
o70 = Instance.new("Part")
o70.Name = "37"
o70.Parent = o1
o70.Position = Vector3.new(-9, 0.200000018, 0)
o70.Anchored = true
o70.CFrame = CFrame.new(-9, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o70.CanCollide = false
o70.Size = Vector3.new(0.5, 0.200000003, 0.5)
o70.BottomSurface = Enum.SurfaceType.Smooth
o70.TopSurface = Enum.SurfaceType.Smooth
o71 = Instance.new("SpecialMesh")
o71.Parent = o70
o71.MeshId = "rbxassetid://9856898"
o71.Scale = Vector3.new(1, 0.400000006, 1)
o71.TextureId = "rbxassetid://2114473"
o71.MeshType = Enum.MeshType.FileMesh
o72 = Instance.new("Part")
o72.Name = "8"
o72.Parent = o1
o72.Position = Vector3.new(5.5, 0.200000018, 0)
o72.Anchored = true
o72.CFrame = CFrame.new(5.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o72.CanCollide = false
o72.Size = Vector3.new(0.5, 0.200000003, 0.5)
o72.BottomSurface = Enum.SurfaceType.Smooth
o72.TopSurface = Enum.SurfaceType.Smooth
o73 = Instance.new("SpecialMesh")
o73.Parent = o72
o73.MeshId = "rbxassetid://9856898"
o73.Scale = Vector3.new(1, 0.400000006, 1)
o73.TextureId = "rbxassetid://2114473"
o73.MeshType = Enum.MeshType.FileMesh
o74 = Instance.new("Part")
o74.Name = "18"
o74.Parent = o1
o74.Position = Vector3.new(0.5, 0.200000018, 0)
o74.Anchored = true
o74.CFrame = CFrame.new(0.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o74.CanCollide = false
o74.Size = Vector3.new(0.5, 0.200000003, 0.5)
o74.BottomSurface = Enum.SurfaceType.Smooth
o74.TopSurface = Enum.SurfaceType.Smooth
o75 = Instance.new("SpecialMesh")
o75.Parent = o74
o75.MeshId = "rbxassetid://9856898"
o75.Scale = Vector3.new(1, 0.400000006, 1)
o75.TextureId = "rbxassetid://2114473"
o75.MeshType = Enum.MeshType.FileMesh
o76 = Instance.new("Part")
o76.Name = "28"
o76.Parent = o1
o76.Position = Vector3.new(-4.5, 0.200000018, 0)
o76.Anchored = true
o76.CFrame = CFrame.new(-4.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o76.CanCollide = false
o76.Size = Vector3.new(0.5, 0.200000003, 0.5)
o76.BottomSurface = Enum.SurfaceType.Smooth
o76.TopSurface = Enum.SurfaceType.Smooth
o77 = Instance.new("SpecialMesh")
o77.Parent = o76
o77.MeshId = "rbxassetid://9856898"
o77.Scale = Vector3.new(1, 0.400000006, 1)
o77.TextureId = "rbxassetid://2114473"
o77.MeshType = Enum.MeshType.FileMesh
o78 = Instance.new("Part")
o78.Name = "38"
o78.Parent = o1
o78.Position = Vector3.new(-9.5, 0.200000018, 0)
o78.Anchored = true
o78.CFrame = CFrame.new(-9.5, 0.200000018, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
o78.CanCollide = false
o78.Size = Vector3.new(0.5, 0.200000003, 0.5)
o78.BottomSurface = Enum.SurfaceType.Smooth
o78.TopSurface = Enum.SurfaceType.Smooth
o79 = Instance.new("SpecialMesh")
o79.Parent = o78
o79.MeshId = "rbxassetid://9856898"
o79.Scale = Vector3.new(1, 0.400000006, 1)
o79.TextureId = "rbxassetid://2114473"
o79.MeshType = Enum.MeshType.FileMesh
o80 = Instance.new("SpecialMesh")
o80.Parent = o1
o80.MeshId = "rbxassetid://9856898"
o80.Scale = Vector3.new(40, 0.400000006, 2)
o80.TextureId = "rbxassetid://2114473"
o80.VertexColor = Vector3.new(0, 0, 0)
o80.MeshType = Enum.MeshType.FileMesh
mas.Parent = workspace
mas:MakeJoints()
local mas1 = mas:GetChildren()
for i=1,#mas1 do
	mas1[i].Parent = game.Players.LocalPlayer.Character
	ypcall(function() mas1[i]:MakeJoints() end)
end
mas:Destroy()
for i=1,#cors do
coroutine.resume(cors[i])
end

local Height=20 -- Max height of the bars
local plr=game.Players.LocalPlayer

o81 = Instance.new("Sound")
o81.Parent = plr.Character.Torso
o81.SoundId = "rbxassetid://508162596"
o81.Volume = 3
o81.Looped = true

-- Objects
-- Objects

local MusicGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local SongName = Instance.new("TextLabel")
local SavedSongs = Instance.new("TextLabel")
local OpenSaved = Instance.new("TextButton")
local Play = Instance.new("TextButton")
local Searchcat = Instance.new("TextBox")
local ID = Instance.new("TextBox")
local Search = Instance.new("TextButton")
local Pause = Instance.new("TextButton")
local Resume = Instance.new("TextButton")
local Close = Instance.new("TextButton")
local CurrentVolume = Instance.new("TextLabel")
local VolUp = Instance.new("TextButton")
local VolDown = Instance.new("TextButton")
local Playlist = Instance.new("TextLabel")
local check = Instance.new("TextButton")
local skip = Instance.new("TextButton")
local forward = Instance.new("TextButton")
local rewind = Instance.new("TextButton")
local previous = Instance.new("TextButton")
local stime = Instance.new("TextLabel")
local Settings = Instance.new("TextButton")
local SavedList = Instance.new("Frame")
local fav = Instance.new("TextButton")
local close = Instance.new("TextButton")
local song = Instance.new("TextButton")
local Favs = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local close_2 = Instance.new("TextButton")
local Open = Instance.new("TextButton")

-- Properties
MusicGui.Name = "Music Gui"
MusicGui.Parent = game.Players.LocalPlayer.PlayerGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = MusicGui
MainFrame.BackgroundColor3 = Color3.new(0, 0, 0)
MainFrame.BackgroundTransparency = 0.34999999403954
MainFrame.BorderColor3 = Color3.new(0.403922, 0.403922, 0.403922)
MainFrame.BorderSizePixel = 5
MainFrame.Position = UDim2.new(0, 0, 0.349999994, 0)
MainFrame.Size = UDim2.new(0.250000003, 0, 0.349999994, 0)

SongName.Name = "SongName"
SongName.Parent = MainFrame
SongName.BackgroundColor3 = Color3.new(0, 0, 0)
SongName.Position = UDim2.new(0.100000001, 0, 0.100000001, 0)
SongName.Size = UDim2.new(0.699999988, 0, 0.100000001, 0)
SongName.Font = Enum.Font.SourceSans
SongName.FontSize = Enum.FontSize.Size14
SongName.Text = "Song"
SongName.TextColor3 = Color3.new(1, 1, 1)
SongName.TextScaled = true
SongName.TextWrapped = true
SongName.TextXAlignment = Enum.TextXAlignment.Left

SavedSongs.Name = "SavedSongs"
SavedSongs.Parent = MainFrame
SavedSongs.BackgroundColor3 = Color3.new(0, 0, 0)
SavedSongs.Position = UDim2.new(0.100000001, 0, 0.400000006, 0)
SavedSongs.Size = UDim2.new(0.699999988, 0, 0.100000001, 0)
SavedSongs.Font = Enum.Font.SourceSans
SavedSongs.FontSize = Enum.FontSize.Size14
SavedSongs.Text = "Saved"
SavedSongs.TextColor3 = Color3.new(1, 1, 1)
SavedSongs.TextScaled = true
SavedSongs.TextWrapped = true
SavedSongs.TextXAlignment = Enum.TextXAlignment.Left

OpenSaved.Name = "OpenSaved"
OpenSaved.Parent = MainFrame
OpenSaved.BackgroundColor3 = Color3.new(0, 0, 0)
OpenSaved.Position = UDim2.new(0.800000012, 0, 0.400000006, 0)
OpenSaved.Size = UDim2.new(0.100000001, 0, 0.100000001, 0)
OpenSaved.Font = Enum.Font.SourceSans
OpenSaved.FontSize = Enum.FontSize.Size14
OpenSaved.Text = ">"
OpenSaved.TextColor3 = Color3.new(1, 1, 1)
OpenSaved.TextScaled = true
OpenSaved.TextWrapped = true

Play.Name = "Play"
Play.Parent = MainFrame
Play.BackgroundColor3 = Color3.new(0, 0, 0)
Play.Position = UDim2.new(0.819999993, 0, 0.25, 0)
Play.Size = UDim2.new(0.100000001, 0, 0.100000001, 0)
Play.Font = Enum.Font.SourceSans
Play.FontSize = Enum.FontSize.Size14
Play.Text = "Play"
Play.TextColor3 = Color3.new(1, 1, 1)
Play.TextScaled = true
Play.TextWrapped = true

Searchcat.Name = "Searchcat"
Searchcat.Parent = MainFrame
Searchcat.BackgroundColor3 = Color3.new(0, 0, 0)
Searchcat.Position = UDim2.new(0.100000001, 0, 0.550000012, 0)
Searchcat.Selectable = false
Searchcat.Size = UDim2.new(0.699999988, 0, 0.100000001, 0)
Searchcat.Font = Enum.Font.SourceSans
Searchcat.FontSize = Enum.FontSize.Size14
Searchcat.Text = "Search"
Searchcat.TextColor3 = Color3.new(1, 1, 1)
Searchcat.TextScaled = true
Searchcat.TextWrapped = true
Searchcat.TextXAlignment = Enum.TextXAlignment.Left

ID.Name = "ID"
ID.Parent = MainFrame
ID.BackgroundColor3 = Color3.new(0, 0, 0)
ID.Position = UDim2.new(0.100000001, 0, 0.25, 0)
ID.Selectable = false
ID.Size = UDim2.new(0.699999988, 0, 0.100000001, 0)
ID.Font = Enum.Font.SourceSans
ID.FontSize = Enum.FontSize.Size14
ID.Text = "ID"
ID.TextColor3 = Color3.new(1, 1, 1)
ID.TextScaled = true
ID.TextWrapped = true
ID.TextXAlignment = Enum.TextXAlignment.Left

Search.Name = "Search"
Search.Parent = MainFrame
Search.BackgroundColor3 = Color3.new(0, 0, 0)
Search.Position = UDim2.new(0.819999993, 0, 0.550000012, 0)
Search.Size = UDim2.new(0.100000001, 0, 0.100000001, 0)
Search.Font = Enum.Font.SourceSans
Search.FontSize = Enum.FontSize.Size14
Search.Text = "Search"
Search.TextColor3 = Color3.new(1, 1, 1)
Search.TextScaled = true
Search.TextWrapped = true

Pause.Name = "Pause"
Pause.Parent = MainFrame
Pause.BackgroundColor3 = Color3.new(0, 0, 0)
Pause.Position = UDim2.new(0.425000012, 0, 0.699999988, 0)
Pause.Size = UDim2.new(0.100000001, 0, 0.100000001, 0)
Pause.Font = Enum.Font.SourceSans
Pause.FontSize = Enum.FontSize.Size14
Pause.Text = "Pause"
Pause.TextColor3 = Color3.new(1, 1, 1)
Pause.TextScaled = true
Pause.TextWrapped = true

Resume.Name = "Resume"
Resume.Parent = MainFrame
Resume.BackgroundColor3 = Color3.new(0, 0, 0)
Resume.Position = UDim2.new(0.550000012, 0, 0.699999988, 0)
Resume.Size = UDim2.new(0.100000001, 0, 0.100000001, 0)
Resume.Font = Enum.Font.SourceSans
Resume.FontSize = Enum.FontSize.Size14
Resume.Text = "Play"
Resume.TextColor3 = Color3.new(1, 1, 1)
Resume.TextScaled = true
Resume.TextWrapped = true

Close.Name = "Close"
Close.Parent = MainFrame
Close.BackgroundColor3 = Color3.new(0, 0, 0)
Close.Position = UDim2.new(0.949999988, 0, 0, 0)
Close.Size = UDim2.new(0.0500000007, 0, 1, 0)
Close.Font = Enum.Font.SourceSans
Close.FontSize = Enum.FontSize.Size14
Close.Text = "<"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.TextWrapped = true

CurrentVolume.Name = "CurrentVolume"
CurrentVolume.Parent = MainFrame
CurrentVolume.BackgroundColor3 = Color3.new(0, 0, 0)
CurrentVolume.Position = UDim2.new(0.699999988, 0, 0.699999988, 0)
CurrentVolume.Size = UDim2.new(0.100000001, 0, 0.100000001, 0)
CurrentVolume.Font = Enum.Font.SourceSans
CurrentVolume.FontSize = Enum.FontSize.Size14
CurrentVolume.Text = "0"
CurrentVolume.TextColor3 = Color3.new(1, 1, 1)

VolUp.Name = "VolUp"
VolUp.Parent = MainFrame
VolUp.BackgroundColor3 = Color3.new(0, 0, 0)
VolUp.Position = UDim2.new(0.800000012, 0, 0.699999988, 0)
VolUp.Size = UDim2.new(0.0500000007, 0, 0.100000001, 0)
VolUp.Font = Enum.Font.SourceSans
VolUp.FontSize = Enum.FontSize.Size14
VolUp.Text = "+"
VolUp.TextColor3 = Color3.new(1, 1, 1)
VolUp.TextScaled = true
VolUp.TextWrapped = true

VolDown.Name = "VolDown"
VolDown.Parent = MainFrame
VolDown.BackgroundColor3 = Color3.new(0, 0, 0)
VolDown.Position = UDim2.new(0.675000012, 0, 0.699999988, 0)
VolDown.Size = UDim2.new(0.0500000007, 0, 0.100000001, 0)
VolDown.Font = Enum.Font.SourceSans
VolDown.FontSize = Enum.FontSize.Size14
VolDown.Text = "-"
VolDown.TextColor3 = Color3.new(1, 1, 1)
VolDown.TextScaled = true
VolDown.TextWrapped = true

Playlist.Name = "Playlist"
Playlist.Parent = MainFrame
Playlist.BackgroundColor3 = Color3.new(1, 1, 1)
Playlist.BackgroundTransparency = 1
Playlist.Position = UDim2.new(0.350000006, 0, 0.850000024, 0)
Playlist.Size = UDim2.new(0.300000012, 0, 0.100000001, 0)
Playlist.Font = Enum.Font.SourceSans
Playlist.FontSize = Enum.FontSize.Size14
Playlist.Text = "Playlist"
Playlist.TextColor3 = Color3.new(1, 1, 1)
Playlist.TextScaled = true
Playlist.TextWrapped = true

check.Name = "check"
check.Parent = MainFrame
check.BackgroundColor3 = Color3.new(0, 0, 0)
check.Position = UDim2.new(0.649999976, 0, 0.870000005, 0)
check.Size = UDim2.new(0.0500000007, 0, 0.0700000003, 0)
check.Font = Enum.Font.SourceSans
check.FontSize = Enum.FontSize.Size14
check.Text = ""
check.TextColor3 = Color3.new(1, 1, 1)

skip.Name = "skip"
skip.Parent = MainFrame
skip.BackgroundColor3 = Color3.new(0, 0, 0)
skip.BorderColor3 = Color3.new(0, 0, 0)
skip.Position = UDim2.new(0.310000002, 0, 0.699999988, 0)
skip.Size = UDim2.new(0.0500000007, 0, 0.100000001, 0)
skip.Font = Enum.Font.SourceSans
skip.FontSize = Enum.FontSize.Size14
skip.Text = ">>"
skip.TextColor3 = Color3.new(1, 1, 1)
skip.TextScaled = true
skip.TextWrapped = true

forward.Name = "forward"
forward.Parent = MainFrame
forward.BackgroundColor3 = Color3.new(0, 0, 0)
forward.Position = UDim2.new(0.239999995, 0, 0.699999988, 0)
forward.Size = UDim2.new(0.0500000007, 0, 0.100000001, 0)
forward.Font = Enum.Font.SourceSans
forward.FontSize = Enum.FontSize.Size14
forward.Text = ">"
forward.TextColor3 = Color3.new(1, 1, 1)
forward.TextScaled = true
forward.TextWrapped = true

rewind.Name = "rewind"
rewind.Parent = MainFrame
rewind.BackgroundColor3 = Color3.new(0, 0, 0)
rewind.Position = UDim2.new(0.170000002, 0, 0.699999988, 0)
rewind.Size = UDim2.new(0.0500000007, 0, 0.100000001, 0)
rewind.Font = Enum.Font.SourceSans
rewind.FontSize = Enum.FontSize.Size14
rewind.Text = "<"
rewind.TextColor3 = Color3.new(1, 1, 1)
rewind.TextScaled = true
rewind.TextWrapped = true

previous.Name = "previous"
previous.Parent = MainFrame
previous.BackgroundColor3 = Color3.new(0, 0, 0)
previous.Position = UDim2.new(0.100000001, 0, 0.699999988, 0)
previous.Size = UDim2.new(0.0500000007, 0, 0.100000001, 0)
previous.Font = Enum.Font.SourceSans
previous.FontSize = Enum.FontSize.Size14
previous.Text = "<<"
previous.TextColor3 = Color3.new(1, 1, 1)
previous.TextScaled = true
previous.TextWrapped = true

stime.Name = "time"
stime.Parent = MainFrame
stime.BackgroundColor3 = Color3.new(1, 1, 1)
stime.BackgroundTransparency = 1
stime.Position = UDim2.new(0.100000001, 0, 0.850000024, 0)
stime.Size = UDim2.new(0.300000012, 0, 0.100000001, 0)
stime.Font = Enum.Font.SourceSans
stime.FontSize = Enum.FontSize.Size14
stime.Text = "--:--:--/--:--:--"
stime.TextColor3 = Color3.new(1, 1, 1)

Settings.Name = "Settings"
Settings.Parent = MainFrame
Settings.BackgroundColor3 = Color3.new(0, 0, 0)
Settings.Position = UDim2.new(0.720000029, 0, 0.850000024, 0)
Settings.Size = UDim2.new(0.200000003, 0, 0.100000001, 0)
Settings.Font = Enum.Font.SourceSans
Settings.FontSize = Enum.FontSize.Size14
Settings.Text = "Settings"
Settings.TextColor3 = Color3.new(1, 1, 1)
Settings.TextScaled = true
Settings.TextWrapped = true

SavedList.Name = "SavedList"
SavedList.Parent = MusicGui
SavedList.BackgroundColor3 = Color3.new(0, 0, 0)
SavedList.BackgroundTransparency = 0.25
SavedList.Position = UDim2.new(0.2,0,-1.1,0)
SavedList.Size = UDim2.new(0.200000003, 0, 1, 0)

fav.Name = "fav"
fav.Parent = SavedList
fav.BackgroundColor3 = Color3.new(0, 0, 0)
fav.BorderColor3 = Color3.new(0.243137, 0.243137, 0.243137)
fav.Size = UDim2.new(1, 0, 0.0250000004, 0)
fav.Font = Enum.Font.SourceSans
fav.FontSize = Enum.FontSize.Size14
fav.Text = "Favorites"
fav.TextColor3 = Color3.new(1, 1, 1)
fav.TextScaled = true
fav.TextWrapped = true

close.Name = "close"
close.Parent = SavedList
close.BackgroundColor3 = Color3.new(0, 0, 0)
close.BorderColor3 = Color3.new(0.243137, 0.243137, 0.243137)
close.Position = UDim2.new(0, 0, 0.975000024, 0)
close.Size = UDim2.new(1, 0, 0.0250000004, 0)
close.Font = Enum.Font.SourceSans
close.FontSize = Enum.FontSize.Size14
close.Text = "^"
close.TextColor3 = Color3.new(1, 1, 1)
close.TextScaled = true
close.TextWrapped = true

Favs.Name = "Favs"
Favs.Parent = MusicGui
Favs.BackgroundColor3 = Color3.new(0, 0, 0)
Favs.BackgroundTransparency = 0.25
Favs.Position = UDim2.new(0.4,0,-0.5,0)
Favs.Size = UDim2.new(0.150000006, 0, 0.400000006, 0)

Title.Name = "Title"
Title.Parent = Favs
Title.BackgroundColor3 = Color3.new(0, 0, 0)
Title.BorderColor3 = Color3.new(0.407843, 0.407843, 0.407843)
Title.Size = UDim2.new(1, 0, 0.0599999987, 0)
Title.Font = Enum.Font.SourceSans
Title.FontSize = Enum.FontSize.Size14
Title.Text = "Favorites"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextScaled = true
Title.TextWrapped = true

close_2.Name = "close"
close_2.Parent = Favs
close_2.BackgroundColor3 = Color3.new(0, 0, 0)
close_2.BorderColor3 = Color3.new(0.243137, 0.243137, 0.243137)
close_2.Position = UDim2.new(0, 0, 0.939999998, 0)
close_2.Size = UDim2.new(1, 0, 0.0599999987, 0)
close_2.Font = Enum.Font.SourceSans
close_2.FontSize = Enum.FontSize.Size14
close_2.Text = "^"
close_2.TextColor3 = Color3.new(1, 1, 1)
close_2.TextScaled = true
close_2.TextWrapped = true

Open.Name = "Open"
Open.Parent = MusicGui
Open.BackgroundColor3 = Color3.new(0, 0, 0)
Open.Position = UDim2.new(-0.5, 0, 0.349999994, 0)
Open.Size = UDim2.new(0.00999999978, 0, 0.300000012, 0)
Open.Font = Enum.Font.SourceSans
Open.FontSize = Enum.FontSize.Size14
Open.Text = ">"
Open.TextColor3 = Color3.new(1, 1, 1)
Open.TextWrapped = true
wait()

gui = game.Players.LocalPlayer.PlayerGui['Music Gui']
favs = gui.Favs
saved = gui.SavedList
favopen = saved.fav
main = gui.MainFrame
mid = main.ID
search = main.Search
ops = main.OpenSaved
play = main.Play
resume = main.Resume
pause = main.Pause
name = main.SongName
closegui = main.Close
closesave = saved.close
closefav = favs.close
open = gui.Open
vol = main.CurrentVolume
vold = main.VolDown
volu = main.VolUp
check = main.check
list = {}



close = function()
	main:TweenPosition(UDim2.new(-0.4,0,0.35,0),"Out","Back",2,true)
	open:TweenPosition(UDim2.new(0,0,0.35,0),"Out","Back",1,true)
	if saved.Position ~= UDim2.new(0.2,0,-1.1,0) then do
		saved:TweenPosition(UDim2.new(0.2,0,-1.1,0),"Out","Back",2,true)
	end
	if favs.Position ~= UDim2.new(0.4,0,-0.5,0) then do
		favs:TweenPosition(UDim2.new(0.4,0,-0.5,0), "Out","Back",2,true)
	end
	end
	end
end

openmain = function()
	main:TweenPosition(UDim2.new(0,0,0.35,0),"Out","Back",1,true)
	open:TweenPosition(UDim2.new(-0.2,0,0.35,0),'Out',"Back",1,true)
end

closesaved = function()
	saved:TweenPosition(UDim2.new(0.2,0,-1.1,0),"Out","Back",2,true)
	if favs.Position ~= UDim2.new(0.4,0,-0.5,0) then do
		favs:TweenPosition(UDim2.new(0.4,0,-0.5,0),"Out","Back",2,true)
	end
end
end

closefavs = function()
	favs:TweenPosition(UDim2.new(0.4,0,-0.5,0),"Out","Back",2,true)
end

opensaved = function()
	saved:TweenPosition(UDim2.new(0.2,0,0,0),"Out","Back",2,true)
end

favoriteopen = function()
	favs:TweenPosition(UDim2.new(0.4,0,0,0),"Out","Back",2,true)
end

open.MouseButton1Down:Connect(openmain)
favopen.MouseButton1Down:connect(favoriteopen)
ops.MouseButton1Down:Connect(opensaved)
closefav.MouseButton1Down:Connect(closefavs)
closegui.MouseButton1Down:connect(close)
closesave.MouseButton1Down:connect(closesaved)

local Soundbar=game.Players.LocalPlayer.Character.Soundbar
local Sound=plr.Character.Torso.Sound
local Bars={}	for i,v in next,Soundbar:children() do
					if v:IsA'BasePart' then
						table.insert(Bars,v)
					end
				end Height=Height*2
local nBars,Tweens=#Bars-1,{}

-- EASING FUNCTIONS --
local function quadIn(t,b,c,d) t=t/d; return c*t*t+b; end;
local function quadOut(t,b,c,d) t=t/d; return -c*t*(t-2)+b; end;
local function Quad(obj,val,ease,d)
	local t,f,con,nt,st,sd=tick()
	Tweens[obj]=t -- Set identifier
	st=obj.Scale.Y -- Start Value
	sd=val-st -- Change in Value
	f=ease=='In' and quadIn or quadOut -- Choose between Out/In
	con=game:GetService'RunService'.RenderStepped:connect(function() nt=tick()-t
		if Tweens[obj]~=t then -- Check for override
			con:disconnect()
			return
		end
		local nv=math.max(.2,f(math.min(d,nt),st,sd,d)) -- New Value
		obj.Scale=Vector3.new(.9,nv,.9)
		obj.Offset=Vector3.new(0,nv/4,0)
		obj.VertexColor=Vector3.new(cycle(tick()))
		if nt>d then -- Easing done?
			con:disconnect()
			if ease~='In' then
				Quad(obj,.2,'In',.3) -- Drop the bar
			end
		end
	end)
end

-- BAR MANIPULATION --
local function CheckSet(N,S,D) -- Number, Scale, Direction
	local nS=Soundbar[tostring(N)].Mesh.Scale.Y
	if S>nS then
		Set(N,nS+(S-nS)/3,D)
	end
end

function Set(N,S,D) -- Number, Scale, Direction
	Quad(Soundbar[tostring(N)].Mesh,S,'Out',.1) -- Grabs the bar and tweens
	if N>0 and D~=1 then -- Checks left for smaller bars to manipulate
		CheckSet(N-1,S,-1)
	end
	if N<nBars and D~=-1 then -- Checks right...
		CheckSet(N+1,S,1)
	end
end

-- RENDER LOOP --
local MPL,PL,curr=0 curr=Sound.SoundId
spawn(function()
game:service'RunService'.RenderStepped:connect(function()
	PL=Sound.PlaybackLoudness
	if Sound.IsPlaying and PL==PL then -- Sound is playing & PlaybackLoudness is not undefined
		if curr~=Sound.SoundId then MPL=0 -- Reset the relative Max PlaybackLoudness on song change
			curr=Sound.SoundId
		end
		MPL=math.max(PL,MPL) PL=PL/MPL -- Normalize PL based on relative Max PlaybackLoudness
		if PL==PL then
			Set(math.floor(PL*nBars),PL*Height*1) -- Modify bar relative to PlaybackLoudness
		end
	end
end)
end)

local Locked


idinput = function()
	local midcurrent = mid.Text
	Sound:Stop()
	Sound.SoundId='rbxassetid://'..midcurrent..''
	Sound:Play()
end

volup = function()
	Sound.Volume = Sound.Volume + 1
end

voldown = function()
	Sound.Volume = Sound.Volume - 1
end

updateinfo = function()
	vol.Text = ""..Sound.Volume..""
	stime.Text = ""..(math.floor(Sound.TimePosition)).."/"..(math.floor(Sound.TimeLength))..""
end

local function Chat(plr,msg)
	if msg:sub(1,6):lower()=='sound/' and (not Locked or plr.Name=='FangxWulf') then
		local id=tonumber(msg:match'%d+')
		if not id then return end
		Sound:Stop()
		Sound.SoundId='rbxassetid://'..msg:match'%d+'
		Sound:Play()
	elseif msg:lower()=='lock/' and plr.Name=='FangxWulf' then
		Locked=not Locked
	end
end
songs = 0

newsong = function(name,id)
	songs = songs+1
	song = Instance.new('TextButton',saved)
	song.Name = ""..name..""
	song.BackgroundColor3 = Color3.new(0, 0, 0)
	song.Position = UDim2.new(0, 0, ((0.035 * songs)-0.035)+0.03, 0)
	song.Size = UDim2.new(1, 0, 0.0350, 0)
	song.Font = Enum.Font.SourceSans
	song.FontSize = Enum.FontSize.Size14
	song.Text = ""..name..""
	song.TextColor3 = Color3.new(1, 1, 1)
	ID = Instance.new("IntValue",song)
	ID.Name = "ID"
	ID.Value = ""..id..""
	list[""..songs..""] = ""..id..""
end

pauses = function()
	Sound:Pause()
end

plays = function()
	Sound:Resume()
end


local CRot = 1
local rad,sin,ceil=math.rad,math.sin,math.ceil

local p = game.Players.LocalPlayer
	p.Chatted:connect(function(m)
		Chat(p,m)
	end)
	
Sound:Play()

local Parts = {}
for Index,v in pairs(o1:children'') do
	if v:IsA'Part' then
		table.insert(Parts,v)
	end
end

	spawn(function()
game:service'RunService'.RenderStepped:connect(function()
	for Index,v in pairs(o1:children'') do
		if v:IsA'Part' then
v.CFrame = CFrame.new(plr.Character.Torso.Position)
								*CFrame.Angles(0,rad((360/#Parts*Index+(tick())*60/(#Parts ~= 0 and #Parts or 1))%360),0)
								*CFrame.new(0, -3, (5+#Parts)*.35+v.Size.X)
								*CFrame.Angles(0,90+CRot,0)
							end
				end
		end)
	end)
----playlist settings----
pl = false
pls = 1
checkedp = function()
	if pl == false then
		pl = true
		check.Text = "X"
	else
		pl = false
		check.Text = ""
	end
end

plnext = function()
	print'pass'
	if pl == true then
		print'pass2'
		Sound.SoundId = "rbxassetid://"..list[''..pls..'']..""
--		if pls < #list then
			pls = pls +1
--		else
--			pls = 1
		end
	end
--end

skips = function()
	if pl == true then
		Sound:Stop()
		pls = pls + 1
		Sound.SoundId = 'rbxassetid://'..list[''..pls..'']..''
		Sound:Play()
	end
end

previouss = function()
	if pl == true then
		Sound:Stop()
		pls = pls - 1
		Sound.SoundId = 'rbxassetid://'..list[''..pls..'']..''
		Sound:Play()
	end
end

ff = function()
	Sound.TimePosition = Sound.TimePosition + 10
	stime.Text = ""..(math.floor(Sound.TimePosition)).."/"..(math.floor(Sound.TimeLength))..""
end

rw = function()
	Sound.TimePosition = Sound.TimePosition - 10
	stime.Text = ""..(math.floor(Sound.TimePosition)).."/"..(math.floor(Sound.TimeLength))..""
end
---------------------------------------------

skip.MouseButton1Down:connect(skips)
rewind.MouseButton1Down:connect(rw)
forward.MouseButton1Down:connect(ff)
Sound.DidLoop:connect(plnext)
Sound.Changed:connect(updateinfo)
volu.MouseButton1Down:connect(volup)
vold.MouseButton1Down:connect(voldown)
play.MouseButton1Down:connect(idinput)
pause.MouseButton1Down:Connect(pauses)
resume.MouseButton1Down:Connect(plays)
check.MouseButton1Down:connect(checkedp)
------------------------Songs--------------------------------
newsong("Life Goes On", 573853447)
newsong("You'll Be Alright", 574538568)
newsong("About You", 574539049)
newsong("Starlights", 573894805)
newsong("The Deeper Meaning", 574544171)
newsong("The Pursuit", 573934790)
newsong("About You", 574539049)
newsong("Start Again", 574543658)
newsong("All I Know", 573935454)
newsong("God Mode", 539616479)



-------------------------------------------------------------


for i,v in pairs(saved:GetChildren()) do
   if v.Name ~= "close" and v.Name ~= "fav" then
		v.MouseButton1Down:Connect(function()
			mid.Text = v.ID.Value
		end)
	end
end

for i,v in pairs(list)do
	print(v)
end
