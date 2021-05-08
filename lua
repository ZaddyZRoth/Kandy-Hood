if game.PlaceId == 2788229376 then
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("KANDY HUB                               DA HOOD!  ", "Ocean")

--Player
local Player = Window:NewTab("Player")
local PlayerSection = Player:NewSection("Player")
PlayerSection:NewButton("Fly (X) ", "Press X to enable and disable the fly", function()
    local plr = game.Players.LocalPlayer
    local mouse = plr:GetMouse()
     
            localplayer = plr
     
            if workspace:FindFirstChild("Core") then
                workspace.Core:Destroy()
            end
     
            local Core = Instance.new("Part")
            Core.Name = "Core"
            Core.Size = Vector3.new(0.05, 0.05, 0.05)
     
            spawn(function()
                Core.Parent = workspace
                local Weld = Instance.new("Weld", Core)
                Weld.Part0 = Core
                Weld.Part1 = localplayer.Character.LowerTorso
                Weld.C0 = CFrame.new(0, 0, 0)
            end)
     
            workspace:WaitForChild("Core")
     
            local torso = workspace.Core
            flying = true
            local speed=10
            local keys={a=false,d=false,w=false,s=false}
            local e1
            local e2
            local function start()
                local pos = Instance.new("BodyPosition",torso)
                local gyro = Instance.new("BodyGyro",torso)
                pos.Name="EPIXPOS"
                pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
                pos.position = torso.Position
                gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                gyro.cframe = torso.CFrame
                repeat
                    wait()
                    localplayer.Character.Humanoid.PlatformStand=true
                    local new=gyro.cframe - gyro.cframe.p + pos.position
                    if not keys.w and not keys.s and not keys.a and not keys.d then
                        speed=5
                    end
                    if keys.w then
                        new = new + workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                        speed=speed+0
                    end
                    if keys.s then
                        new = new - workspace.CurrentCamera.CoordinateFrame.lookVector * speed
                        speed=speed+0
                    end
                    if keys.d then
                        new = new * CFrame.new(speed,0,0)
                        speed=speed+0
                    end
                    if keys.a then
                        new = new * CFrame.new(-speed,0,0)
                        speed=speed+0
                    end
                    if speed>10 then
                        speed=5
                    end
                    pos.position=new.p
                    if keys.w then
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(-math.rad(speed*0),0,0)
                    elseif keys.s then
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame*CFrame.Angles(math.rad(speed*0),0,0)
                    else
                        gyro.cframe = workspace.CurrentCamera.CoordinateFrame
                    end
                until flying == false
                if gyro then gyro:Destroy() end
                if pos then pos:Destroy() end
                flying=false
                localplayer.Character.Humanoid.PlatformStand=false
                speed=10
            end
            e1=mouse.KeyDown:connect(function(key)
                if not torso or not torso.Parent then flying=false e1:disconnect() e2:disconnect() return end
                if key=="w" then
                    keys.w=true
                elseif key=="s" then
                    keys.s=true
                elseif key=="a" then
                    keys.a=true
                elseif key=="d" then
                    keys.d=true
                elseif key=="x" then
                    if flying==true then
                        flying=false
                    else
                        flying=true
                        start()
                    end
                end
            end)
            e2=mouse.KeyUp:connect(function(key)
                if key=="w" then
                    keys.w=false
                elseif key=="s" then
                    keys.s=false
                elseif key=="a" then
                    keys.a=false
                elseif key=="d" then
                    keys.d=false
                end
            end)
            start()
end)

PlayerSection:NewButton("Infinite jump", " You Don't know Infinite jump?", function()
    local Player = game:GetService'Players'.LocalPlayer;
	local UIS = game:GetService'UserInputService';
		
	_G.JumpHeight = 50
	
	function Action(Object, Function) if Object ~= nil then Function(Object); end end
	
	UIS.InputBegan:connect(function(UserInput)
	    if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
	        Action(Player.Character.Humanoid, function(self)
	            if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
	                Action(self.Parent.HumanoidRootPart, function(self)
	                    self.Velocity = Vector3.new(0, _G.JumpHeight, 0);
	                end)
	            end
	        end)
	    end
	end)
end)


PlayerSection:NewSlider("SliderText", "SliderInfo", 100, 0, function(v) 
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)












--AutoFarm
local Autofarm = Window:NewTab("AutoFarm")
local AutofarmSection = Autofarm:NewSection("Toggle AutoFarm")

AutofarmSection:NewToggle("", "it's literally autofarm wat do yu expect", function(state)
    if state then
        repeat
            wait()
        until game:IsLoaded()
        local gm = getrawmetatable(game)
        setreadonly(gm, false)
        local namecall = gm.__namecall
        gm.__namecall =
            newcclosure(
            function(self, ...)
                local args = {...}
                if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "MainEvent" then
                    if tostring(getcallingscript()) ~= "Framework" then
                        return
                    end
                end
                if not checkcaller() and getnamecallmethod() == "Kick" then
                    return
                end
                return namecall(self, unpack(args))
            end
        )
        
        local LocalPlayer = game:GetService("Players").LocalPlayer
        
        function gettarget()
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
            local maxdistance = math.huge
            local target
            for i, v in pairs(game:GetService("Workspace").Cashiers:GetChildren()) do
                if v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    local distance = (HumanoidRootPart.Position - v.Head.Position).magnitude
                    if distance < maxdistance then
                        target = v
                        maxdistance = distance
                    end
                end
            end
            return target
        end
        
        for i, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Seat") then
                v:Destroy()
            end
        end
        
        print("KANDY HUB AUTOFARM ON")
        
        shared.MoneyFarm = true 
        
        while shared.MoneyFarm do
            wait()
            local Target = gettarget()
            repeat
                wait()
                pcall(
                    function()
                        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
                        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                        local Combat = LocalPlayer.Backpack:FindFirstChild("Combat") or Character:FindFirstChild("Combat")
                        if not Combat then
                            Character:FindFirstChild("Humanoid").Health = 0
                            return
                        end
                        HumanoidRootPart.CFrame = Target.Head.CFrame * CFrame.new(0, -2.5, 3)
                        Combat.Parent = Character
                        Combat:Activate()
                    end
                )
            until not Target or Target.Humanoid.Health < 0
            for i, v in pairs(game:GetService("Workspace").Ignored.Drop:GetDescendants()) do
                if v:IsA("ClickDetector") and v.Parent and v.Parent.Name:find("Money") then
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
                    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    if (v.Parent.Position - HumanoidRootPart.Position).magnitude <= 18 then
                        repeat
                            wait()
                            fireclickdetector(v)
                        until not v or not v.Parent.Parent
                    end
                end
            end
            wait(1)
        end
    else
        repeat
            wait()
        until game:IsLoaded()
        local gm = getrawmetatable(game)
        setreadonly(gm, false)
        local namecall = gm.__namecall
        gm.__namecall =
            newcclosure(
            function(self, ...)
                local args = {...}
                if not checkcaller() and getnamecallmethod() == "FireServer" and tostring(self) == "MainEvent" then
                    if tostring(getcallingscript()) ~= "Framework" then
                        return
                    end
                end
                if not checkcaller() and getnamecallmethod() == "Kick" then
                    return
                end
                return namecall(self, unpack(args))
            end
        )
        
        local LocalPlayer = game:GetService("Players").LocalPlayer
        
        function gettarget()
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
            local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
            local maxdistance = math.huge
            local target
            for i, v in pairs(game:GetService("Workspace").Cashiers:GetChildren()) do
                if v:FindFirstChild("Head") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    local distance = (HumanoidRootPart.Position - v.Head.Position).magnitude
                    if distance < maxdistance then
                        target = v
                        maxdistance = distance
                    end
                end
            end
            return target
        end
        
        for i, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Seat") then
                v:Destroy()
            end
        end
        
        print("KANDY HUB AUTOFARM OFF")
        
        shared.MoneyFarm = false
        
        while shared.MoneyFarm do
            wait()
            local Target = gettarget()
            repeat
                wait()
                pcall(
                    function()
                        local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
                        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                        local Combat = LocalPlayer.Backpack:FindFirstChild("Combat") or Character:FindFirstChild("Combat")
                        if not Combat then
                            Character:FindFirstChild("Humanoid").Health = 0
                            return
                        end
                        HumanoidRootPart.CFrame = Target.Head.CFrame * CFrame.new(0, -2.5, 3)
                        Combat.Parent = Character
                        Combat:Activate()
                    end
                )
            until not Target or Target.Humanoid.Health < 0
            for i, v in pairs(game:GetService("Workspace").Ignored.Drop:GetDescendants()) do
                if v:IsA("ClickDetector") and v.Parent and v.Parent.Name:find("Money") then
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:wait()
                    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
                    if (v.Parent.Position - HumanoidRootPart.Position).magnitude <= 18 then
                        repeat
                            wait()
                            fireclickdetector(v)
                        until not v or not v.Parent.Parent
                    end
                end
            end
            wait(1)
        end
    end
end)




--AutoBuy

local AutoBuy = Window:NewTab("AutoBuy")
local BuySection = AutoBuy:NewSection("AutoBuys")









--Extra 

local Extra = Window:NewTab("Extra")
local ExtraSection = Extra:NewSection("")

ExtraSection:NewButton("Anti-AFk", "Jump Every 10 mins", function()
    while true do wait(600)
        game.Players.LocalPlayer.Character.Humanoid.Jump = true
        end
end)

-- Setting

local GuiSetting = Window:NewTab("GuiSetting")
local SettingSection = GuiSetting:NewSection("Setting")

SettingSection:NewKeybind("Customize your gui toggle bind", "KeybindInfo", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)




--Credits

local Credits = Window:NewTab("Credits")
local Credit1Section = Credits:NewSection("R 0 T H#0259")
local Credit2Section = Credits:NewSection("Thanks To Kavo Library For Making This Possible")
end




