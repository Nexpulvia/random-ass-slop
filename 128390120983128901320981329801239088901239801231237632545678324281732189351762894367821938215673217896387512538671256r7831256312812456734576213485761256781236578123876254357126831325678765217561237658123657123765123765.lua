local p=game.Players.LocalPlayer
local r=game:GetService("RunService")
local w=workspace

local c="Source"
local s=1
local n=true
local S=525200869

local g={}
local k={}
local d=tick()
local t=0
local a=nil

local function q(o,e)
    d=(d*9301+49297)%233280
    return o+(d/233280)*(e-o)
end

local function f(o,e)
    for _,u in pairs(o:GetChildren()) do
        e[#e+1]=u
        f(u,e)
    end
end

local function h()
    local o=p.Character
    if not o then return nil end
    return o:FindFirstChild("Torso")
        or o:FindFirstChild("UpperTorso")
end

local function v(M)
    if not n then return end
    local o=h()
    if not o then return end
    if a then a:Destroy() a=nil end

    local B=Instance.new("BillboardGui")
    B.Name="NOTIFICATION"
    B.Size=UDim2.new(50*s,0,2*s,0)
    B.StudsOffset=Vector3.new(0,5*s,0)
    B.Adornee=o
    B.Parent=o
    a=B

    local T=Instance.new("TextLabel")
    T.BackgroundTransparency=1
    T.BorderSizePixel=0
    T.Text=""
    T.Font=Enum.Font.Arial
    T.TextScaled=true
    T.TextStrokeTransparency=0
    T.TextStrokeColor3=Color3.new(1,1,1)
    T.Size=UDim2.new(1,0,1,0)
    T.TextColor3=Color3.new(0,0,0)
    T.Position=UDim2.new(0,0,0,0)
    T.Parent=B

    spawn(function()
        local I=tick()
        local L=0
        repeat
            wait()
            if not B.Parent then return end
            local N=math.floor((tick()-I)*30)
            if N>L then L=N end
            T.Text=string.sub(M,1,L)
            T.Position=UDim2.new(0,0,0,0)
        until L>=#M

        T.Text=M

        I=tick()
        repeat
            wait()
            if not B.Parent then return end
            T.Position=UDim2.new(0,0,0,0)
        until tick()-I>2

        I=tick()
        repeat
            wait()
            if not B.Parent then return end
            local A=tick()-I
            T.Position=UDim2.new(
                0,math.random(-3,3),
                0,math.random(-3,3)
            )
            T.Rotation=math.random(-20,20)*(1-A)
            local E=math.floor(A*10)/10
            if math.random()<0.4 then
                E=math.floor(A*6)/6
            end
            T.TextTransparency=math.min(E,1)
            T.TextStrokeTransparency=math.min(E,1)
        until tick()-I>1

        if B.Parent then B:Destroy() end
        if a==B then a=nil end
    end)
end

local function x(o)
    local R=o and (
        o:FindFirstChild("HumanoidRootPart")
        or o:FindFirstChild("Torso")
    )
    if not R then return end

    local M=Instance.new("Model")
    M.Name="BlackSpikes"
    M.Parent=w

    local P={}

    for i=1,18 do
        local X=q(-5,5)
        local Z=q(-5,5)
        local H=q(1.5,7)
        local W=q(0.035,0.09)
        local G=R.Position.y-3
        local Y=CFrame.Angles(
            q(-0.12,0.12),
            q(0,math.pi*2),
            q(-0.12,0.12)
        )

        local V=Instance.new("Part")
        V.Name="Spike"
        V.Anchored=true
        V.CanCollide=false
        V.FormFactor=Enum.FormFactor.Custom
        V.Size=Vector3.new(W,0.01,W)
        V.Material=Enum.Material.Plastic
        V.Color=Color3.new(0,0,0)
        V.CFrame=CFrame.new(
            R.Position.x+X,G,R.Position.z+Z
        )*Y
        V.Parent=M

        P[#P+1]={
            p=V,
            x=R.Position.x+X,
            z=R.Position.z+Z,
            y=G,
            h=H,
            w=W,
            r=Y
        }
    end

    k[#k+1]={m=M,p=P,t=0,life=0.65}
end

local function y(o)
    if #g>=5 or not o then return end

    local O=o.Archivable
    o.Archivable=true

    local C
    local U,Q=pcall(function()
        C=o:Clone()
    end)

    o.Archivable=O

    if not U or not C then
        warn("Afterimage clone failed:",Q)
        return
    end

    local D={}
    f(C,D)

    for _,u in pairs(D) do
        if u:IsA("Humanoid")
        or u:IsA("Script")
        or u:IsA("LocalScript") then
            u:Destroy()
        elseif u:IsA("BasePart") then
            u.Anchored=true
            u.CanCollide=false
            u.Material=Enum.Material.Plastic
            u.Color=Color3.new(0,0,0)
            u.Transparency=math.max(u.Transparency,0.4)
        elseif u:IsA("Decal") or u:IsA("Texture") then
            u.Transparency=1
        elseif u:IsA("ParticleEmitter")
        or u:IsA("Trail")
        or u:IsA("Beam") then
            u:Destroy()
        end
    end

    C.Name="Afterimage"
    C.Parent=w

    D={}
    f(C,D)

    local P={}

    for _,u in pairs(D) do
        if u:IsA("BasePart") and u.Name~="HumanoidRootPart" then
            local K=q(0,math.pi*2)
            local J=q(-0.7,0.9)

            P[#P+1]={
                p=u,
                c=u.CFrame,
                o=Vector3.new(
                    math.cos(K),J,math.sin(K)
                ).unit*q(1,3),
                a=Vector3.new(
                    q(-0.5,0.5),
                    q(-0.5,0.5),
                    q(-0.5,0.5)
                ),
                z=math.max(u.Transparency,0.4)
            }
        end
    end

    g[#g+1]={m=C,p=P,t=0,f=0}
end

local function z()
    local o=p.Character
    if not o then return end
    pcall(function() y(o) end)
    pcall(function() x(o) end)
end

r.Heartbeat:Connect(function(dt)
    t=t+dt

    if t>=0.50 then
        t=t%0.50
        z()
    end

    for i=#g,1,-1 do
        local e=g[i]
        e.t=e.t+dt
        e.f=e.f+dt

        if e.t>=0.75 or not e.m.Parent then
            if e.m.Parent then e.m:Destroy() end
            table.remove(g,i)
        elseif e.f>=0.05 then
            e.f=0
            local A=math.min(e.t/0.75,1)

            for _,u in pairs(e.p) do
                if u.p.Parent then
                    u.p.CFrame=u.c
                        *CFrame.new(u.o*A)
                        *CFrame.Angles(
                            u.a.x*A,u.a.y*A,u.a.z*A
                        )
                    u.p.Color=Color3.new(0,0,0)
                    u.p.Transparency=math.min(
                        u.z+(1-u.z)*A,1
                    )
                end
            end
        end
    end

    for i=#k,1,-1 do
        local e=k[i]
        e.t=e.t+dt

        if e.t>=e.life or not e.m.Parent then
            if e.m.Parent then e.m:Destroy() end
            table.remove(k,i)
        else
            local A=math.min(e.t/0.3,1)
            local F=math.max(0,(e.t-0.3)/0.35)

            for _,u in pairs(e.p) do
                if u.p.Parent then
                    local H=math.max(u.h*A,0.01)
                    u.p.Size=Vector3.new(u.w,H,u.w)
                    u.p.CFrame=CFrame.new(
                        u.x,u.y+H/2,u.z
                    )*u.r
                    u.p.Transparency=math.min(F,1)
                end
            end
        end
    end
end)

local function m()
    for _,u in pairs(g) do
        if u.m and u.m.Parent then u.m:Destroy() end
    end
    for _,u in pairs(k) do
        if u.m and u.m.Parent then u.m:Destroy() end
    end
    g={}
    k={}
    t=0
end

p.CharacterRemoving:Connect(function()
    m()
    if a then a:Destroy() a=nil end
end)

p.CharacterAdded:Connect(function()
    wait(1)
    t=0
    z()
end)

p.Chatted:Connect(function(M)
    if M=="" or M==" " then return end
    v(c..": "..M)
    spawn(function()
        local o=Instance.new("Sound")
        o.SoundId="rbxassetid://"..S
        o.Volume=0.5
        o.Parent=w
        o:Play()
        wait(3)
        o:Destroy()
    end)
end)

if p.Character then z() end

print("Source script loaded")
