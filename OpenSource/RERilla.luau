
-- [[ RERIlla - RORilla Revived ]] --

--[[
  Credits:
  // saucekid - Created this script
  // Emper - Created the reanimation used
  // Melon - fixed this script
  // Guardian | TheGuardian - helped update the reanimate, fixed some bugs and more.
  Note: if there's bugs pls let me know so i can fix them

  Free rig:
  // https://www.roblox.com/catalog/3033910400/International-Fedora-Germany
  // https://www.roblox.com/catalog/3409612660/International-Fedora-USA
  // https://www.roblox.com/catalog/3398308134/International-Fedora-Canada
  // https://www.roblox.com/catalog/3033908130/International-Fedora-France
  // https://www.roblox.com/catalog/4819740796/Robox

  Paid hats are found in this game:
  // https://www.roblox.com/games/75212043521343/Melons-Testing-World
]] 

--[[
              ████      ████                
            ████████████████████            
          ████████████████████████          
        ████████████████████████████        
        ████████████████████████████        
      ████████████████████████████████      
      ██▒▒▒▒▒▒▒▒██████████████▒▒▒▒████      
      ██▒▒▒▒▒▒▒▒▒▒▒▒██████▒▒▒▒▒▒▒▒▒▒██      
    ▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▒▒    
    ▒▒██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    
    ████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    
    ████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██    
    ██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████    
    ██████████▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒████████    
      ████████▒▒▒▒░░░░░░░░░░▒▒▒▒████████    
      ██████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒████████      
          ██████████▒▒▒▒▒▒██████████        
        ████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒████████      
        ██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██████      
      ████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒████████    
    ██████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██████████  
  ██████████  ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒  ████████  
  ████████  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  ██████████
██████████  ██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██  ██████████
██████████   ███▒▒▒▒▒▒▒▒▒▒▒▒███   ██████████
▒▒▒▒████▒▒    ████████████████    ▒▒██████▒▒
▒▒▒▒▒▒▒▒▒▒                        ▒▒▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒▒▒                          ▒▒▒▒▒▒▒▒
▒▒▒▒▒▒▒▒                            ▒▒▒▒▒▒▒▒
]]--

local options = {}
options.HeadScale = 2          -- Headscale of camera (Does not change actual head size)
options.FakeHandsTransparency = 1  -- Transparency of Arm Hitboxes
options.Bubblechat = true      -- Force Bubblechat
options.PointerRange = 10      -- Range you can click buttons with your arm
options.TurnDelay = 0.05       -- Delay in sec. for how fast you can turn left and right
options.TurnAngle = 15         -- Change in angle left/right (degrees)

local Reanimator = {}
local Empyrean = nil
local Rad = math.rad
 
local Reanimate_Settings = { -- useless unless you dont have shp
Frequency = 4, -- this is basically how fast the oscillation goes
Amplification = 6, -- this is how far the oscillation goes
FrontOffset = 2.35, -- this is how much youre in front of the player during prediction
}
local Services = {
CoreGui = game:GetService("CoreGui");
InsertService = game:GetService("InsertService");
ReplicatedStorage = game:GetService("ReplicatedStorage");
Players = game:GetService("Players");
UserInputService = game:GetService("UserInputService");
TweenService = game:GetService("TweenService");
RunService = game:GetService("RunService");
Debris = game:GetService("Debris");
StarterGui = game:GetService("StarterGui");
}

--reanim here
do
local Accessories = {}
local Aligns = {}
local Attachments = {}
local BindableEvent = nil
local Blacklist = {}
local CFrame = CFrame
local CFrameidentity = CFrame.identity
local CFramelookAt = CFrame.lookAt
local CFramenew = CFrame.new
local Character = nil
local CurrentCamera = nil
local Enum = Enum
local Custom = Enum.CameraType.Custom
local Health = Enum.CoreGuiType.Health
local HumanoidRigType = Enum.HumanoidRigType
local R6 = HumanoidRigType.R6
local Dead = Enum.HumanoidStateType.Dead
local Physics = Enum.HumanoidStateType.Physics
local Freefall = Enum.HumanoidStateType.Freefall

local LockCenter = Enum.MouseBehavior.LockCenter
local UserInputType = Enum.UserInputType
local MouseButton1 = UserInputType.MouseButton1
local Touch = UserInputType.Touch
local Exceptions = {}
local game = game
local Clone = game.Clone
local Close = game.Close
local Connect = Close.Connect
local Disconnect = Connect(Close, function() end).Disconnect
local Wait = Close.Wait
local Destroy = game.Destroy
local FindFirstAncestorOfClass = game.FindFirstAncestorOfClass
local FindFirstAncestorWhichIsA = game.FindFirstAncestorWhichIsA
local FindFirstChild = game.FindFirstChild
local FindFirstChildOfClass = game.FindFirstChildOfClass
local Players = FindFirstChildOfClass(game, "Players")
local CreateHumanoidModelFromDescription = Players.CreateHumanoidModelFromDescription
local GetPlayers = Players.GetPlayers
local LocalPlayer = Players.LocalPlayer
local CharacterAdded = LocalPlayer.CharacterAdded
local Mouse = LocalPlayer:GetMouse()
local Kill = LocalPlayer.Kill
local RunService = FindFirstChildOfClass(game, "RunService")
local PostSimulation = RunService.PostSimulation
local PreRender = RunService.PreRender
local PreSimulation = RunService.PreSimulation
local StarterGui = FindFirstChildOfClass(game, "StarterGui")
local GetCoreGuiEnabled = StarterGui.GetCoreGuiEnabled
local SetCore = StarterGui.SetCore
local SetCoreGuiEnabled = StarterGui.SetCoreGuiEnabled
local Workspace = FindFirstChildOfClass(game, "Workspace")
local FallenPartsDestroyHeight = Workspace.FallenPartsDestroyHeight
local HatDropY = FallenPartsDestroyHeight - 0.7
local FindFirstChildWhichIsA = game.FindFirstChildWhichIsA
local UserInputService = FindFirstChildOfClass(game, "UserInputService")
local InputBegan = UserInputService.InputBegan
local IsMouseButtonPressed = UserInputService.IsMouseButtonPressed
local GetChildren = game.GetChildren
local GetDescendants = game.GetDescendants
local GetPropertyChangedSignal = game.GetPropertyChangedSignal
local CurrentCameraChanged = GetPropertyChangedSignal(Workspace, "CurrentCamera")
local MouseBehaviorChanged = GetPropertyChangedSignal(UserInputService, "MouseBehavior")
local IsA = game.IsA
local IsDescendantOf = game.IsDescendantOf
local Highlights = {}
local Instancenew = Instance.new
local R15Animation = Instancenew("Animation")
local R6Animation = Instancenew("Animation")
local HumanoidDescription = Instancenew("HumanoidDescription")
local HumanoidModel = CreateHumanoidModelFromDescription(Players, HumanoidDescription, R6)
local R15HumanoidModel = CreateHumanoidModelFromDescription(Players, HumanoidDescription, HumanoidRigType.R15)
local SetAccessories = HumanoidDescription.SetAccessories
local ModelBreakJoints = HumanoidModel.BreakJoints
local Head = HumanoidModel.Head
local BasePartBreakJoints = Head.BreakJoints
local GetJoints = Head.GetJoints
local IsGrounded = Head.IsGrounded
local Humanoid = HumanoidModel.Humanoid
local ApplyDescription = Humanoid.ApplyDescription
local ChangeState = Humanoid.ChangeState
local EquipTool = Humanoid.EquipTool
local GetAppliedDescription = Humanoid.GetAppliedDescription
local GetPlayingAnimationTracks = Humanoid.GetPlayingAnimationTracks
local LoadAnimation = Humanoid.LoadAnimation
local Move = Humanoid.Move
local UnequipTools = Humanoid.UnequipTools
local ScaleTo = HumanoidModel.ScaleTo
local IsFirst = false
local IsHealthEnabled = nil
local IsLockCenter = false
local IsRegistered = false
local IsRunning = false
local LastTime = nil
local math = math
local mathrandom = math.random
local mathsin = math.sin
local mathpi = math.pi
local nan = 0 / 0
local Vector3nan = Vector3.new(nan, nan, nan)
local next = next
local OptionsAccessories = nil
local OptionsApplyDescription = nil
local OptionsBreakJointsDelay = nil
local OptionsClickFling = nil
local OptionsDisableCharacterCollisions = nil
local OptionsDisableHealthBar = nil
local OptionsDisableRigCollisions = nil
local OptionsDefaultFlingOptions = nil
local OptionsHatDrop = nil
local OptionsHideCharacter = nil
local OptionsParentCharacter = nil
local OptionsRigTransparency = nil
local OptionsSetCameraSubject = nil
local OptionsSetCameraType = nil
local OptionsSetCharacter = nil
local OptionsSetCollisionGroup = nil
local OptionsSimulationRadius = nil
local OptionsTeleportRadius = nil
local OptionsUseServerBreakJoints
local osclock = os.clock
local PreRenderConnection = nil
local RBXScriptConnections = {}

local Rig = nil
local RigHumanoid = nil
local RigHumanoidRootPart = nil
local stringfind = string.find
local table = table
local tableclear = table.clear
local tablefind = table.find
local tableinsert = table.insert
local tableremove = table.remove
local Targets = {}
local task = task
local taskdefer = task.defer
local taskspawn = task.spawn
local taskwait = task.wait
local Time = nil
local Tools = {}
local Vector3 = Vector3
local Vector3new = Vector3.new
local FlingVelocity = Vector3new(16384, 16384, 16384)
local HatDropLinearVelocity = Vector3new(0, 27, 0)
local HideCharacterOffset = Vector3new(0, - 30, 0)
local Vector3one = Vector3.one
local Vector3xzAxis = Vector3new(1, 0, 1)
local Vector3zero = Vector3.zero
local AntiSleep = Vector3zero
local Color3fromRGB = Color3.fromRGB

R15Animation.AnimationId = "rbxassetid://507767968"
R6Animation.AnimationId = "rbxassetid://180436148"
Humanoid = nil
Destroy(HumanoidDescription)
HumanoidDescription = nil

local FindFirstChildOfClassAndName = function(Parent, ClassName, Name)
for Index, Child in next, GetChildren(Parent) do
if IsA(Child, ClassName) and Child.Name == Name then
return Child
end
end
end

local GetHandleFromTable = function(Table)
for Index, Child in GetChildren(Character) do
if IsA(Child, "Accoutrement") then
local Handle = FindFirstChildOfClassAndName(Child, "BasePart", "Handle")
if Handle then
local MeshId = nil
local TextureId = nil
if IsA(Handle, "MeshPart") then
MeshId = Handle.MeshId
TextureId = Handle.TextureID
else
local SpecialMesh = FindFirstChildOfClass(Handle, "SpecialMesh")
if SpecialMesh then
MeshId = SpecialMesh.MeshId
TextureId = SpecialMesh.TextureId
end
end
if MeshId then
if stringfind(MeshId, Table.MeshId) and stringfind(TextureId, Table.TextureId) then
return Handle
end
end
end
end
end
end

local NewIndex = function(self, Index, Value)
self[Index] = Value
end

local DescendantAdded = function(Descendant)
if IsA(Descendant, "Accoutrement") and OptionsHatDrop then
if not pcall(NewIndex, Descendant, "BackendAccoutrementState", 0) then
if sethiddenproperty then
pcall(sethiddenproperty, Descendant, "BackendAccoutrementState", 0)
elseif setscriptable then
setscriptable(Descendant, "BackendAccoutrementState", true)
Descendant.BackendAccoutrementState = 0
end
end
elseif IsA(Descendant, "Attachment") then
local Attachment = Attachments[Descendant.Name]
if Attachment then
local Parent = Descendant.Parent
if IsA(Parent, "BasePart") then
local MeshId = nil
local TextureId = nil
if IsA(Parent, "MeshPart") then
MeshId = Parent.MeshId
TextureId = Parent.TextureID
else
local SpecialMesh = FindFirstChildOfClass(Parent, "SpecialMesh")
if SpecialMesh then
MeshId = SpecialMesh.MeshId
TextureId = SpecialMesh.TextureId
end
end
if MeshId then
for Index, Table in next, Accessories do
if Table.MeshId == MeshId and Table.TextureId == TextureId then
local Handle = Table.Handle
tableinsert(Aligns, {
LastPosition = Handle.Position,
Offset = CFrameidentity,
Part0 = Parent,
Part1 = Handle
})
return
end
end
for Index, Table in next, OptionsAccessories do
if stringfind(MeshId, Table.MeshId) and stringfind(TextureId, Table.TextureId) then
local Instance = nil
local TableName = Table.Name
local TableNames = Table.Names
if TableName then
Instance = FindFirstChildOfClassAndName(Rig, "BasePart", TableName)
else
for Index, TableName in next, TableNames do
local Child = FindFirstChildOfClassAndName(Rig, "BasePart", TableName)
if not ( TableNames[Index + 1] and Blacklist[Child] ) then
Instance = Child
break
end
end
end
if Instance then
local Blacklisted = Blacklist[Instance]
if not ( Blacklisted and Blacklisted.MeshId == MeshId and Blacklisted.TextureId == TextureId ) then
tableinsert(Aligns, {
Offset = Table.Offset,
Part0 = Parent,
Part1 = Instance
})
Blacklist[Instance] = { MeshId = MeshId, TextureId = TextureId }
return
end
end
end
end
local Accoutrement = FindFirstAncestorWhichIsA(Parent, "Accoutrement")
if Accoutrement and IsA(Accoutrement, "Accoutrement") then
local AccoutrementClone = Clone(Accoutrement)
local HandleClone = FindFirstChildOfClassAndName(AccoutrementClone, "BasePart", "Handle")
HandleClone.Transparency = OptionsRigTransparency
for Index, Descendant in next, GetDescendants(HandleClone) do
if IsA(Descendant, "JointInstance") then
Destroy(Descendant)
end
end
local AccessoryWeld = Instancenew("Weld")
AccessoryWeld.C0 = Descendant.CFrame
AccessoryWeld.C1 = Attachment.CFrame
AccessoryWeld.Name = "AccessoryWeld"
AccessoryWeld.Part0 = HandleClone
AccessoryWeld.Part1 = Attachment.Parent
AccessoryWeld.Parent = HandleClone
AccoutrementClone.Parent = Rig
tableinsert(Accessories, {
Handle = HandleClone,
MeshId = MeshId,
TextureId = TextureId
})
tableinsert(Aligns, {
Offset = CFrameidentity,
Part0 = Parent,
Part1 = HandleClone
})
end
end
end
end
end
end

local SetCameraSubject = function()
local CameraCFrame = CurrentCamera.CFrame
Wait(PreRender)
if CurrentCamera.CameraSubject ~= RigHumanoid then
CurrentCamera.CameraSubject = RigHumanoid -- yes because one check ISNT ENOUGHT!!!!!!!!!!!!!!!!!!!!!!!
end
CurrentCamera.CFrame = CameraCFrame
end

local OnCameraSubjectChanged = function()
if CurrentCamera.CameraSubject ~= RigHumanoid then
taskdefer(SetCameraSubject)
end
end

local OnCameraTypeChanged = function()
if CurrentCamera.CameraType ~= Custom then
CurrentCamera.CameraType = Custom
end
end

local OnCurrentCameraChanged = function()
local Camera = Workspace.CurrentCamera
if Camera and OptionsSetCameraSubject then
CurrentCamera = Workspace.CurrentCamera
taskspawn(SetCameraSubject)
OnCameraSubjectChanged()
tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(CurrentCamera, "CameraSubject"), OnCameraSubjectChanged))
if OptionsSetCameraType then
OnCameraTypeChanged()
tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(CurrentCamera, "CameraType"), OnCameraTypeChanged))
end
end
end

local SetState = function(Humanoid, State)
Humanoid:SetStateEnabled(State, true)
Humanoid:ChangeState(State)
end

local SetInstanceValue = function(Instance, Property, Value)
Instance[Property] = Value
end

local SetCharacter = function()
LocalPlayer.Character = Rig
end

local SetSimulationRadius = function()
LocalPlayer.SimulationRadius = OptionsSimulationRadius
end

local WaitForChildOfClass = function(Parent, ClassName)
local Child = FindFirstChildOfClass(Parent, ClassName)
while not Child do
Wait(Parent.ChildAdded)
Child = FindFirstChildOfClass(Parent, ClassName)
end
return Child
end

local WaitForChildOfClassAndName = function(Parent, ...)
local Child = FindFirstChildOfClassAndName(Parent, ...)
while not Child do
Wait(Parent.ChildAdded)
Child = FindFirstChildOfClassAndName(Parent, ...)
end
return Child
end

local Fling = function(Target, Options)
if Target then
local Highlight = Options.Highlight
if IsA(Target, "Humanoid") then
Target = Target.Parent
end
if IsA(Target, "Model") then
Target = FindFirstChildOfClassAndName(Target, "BasePart", "HumanoidRootPart") or FindFirstChildWhichIsA(Character, "BasePart")
end
if not tablefind(Targets, Target) and IsA(Target, "BasePart") and not Target.Anchored and not IsDescendantOf(Character, Target) and not IsDescendantOf(Rig, Target) then
local Model = FindFirstAncestorOfClass(Target, "Model")
if Model and FindFirstChildOfClass(Model, "Humanoid") then
Target = FindFirstChildOfClassAndName(Model, "BasePart", "HumanoidRootPart") or FindFirstChildWhichIsA(Character, "BasePart") or Target	
else
Model = Target
end
if Highlight then
local HighlightObject = type(Highlight) == "boolean" and Highlight and Instancenew("Highlight") or Clone(Highlight)
HighlightObject.Adornee = Model
HighlightObject.Parent = Model
HighlightObject.OutlineColor = Color3fromRGB(255, 0, 0)
HighlightObject.FillColor = Color3fromRGB(0, 0, 0)
HighlightObject.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
local FlashIn = Services.TweenService:Create(HighlightObject, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {FillTransparency = 0.3, OutlineTransparency = 0})
local FadeOut = Services.TweenService:Create(HighlightObject, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {FillTransparency = 1, OutlineTransparency = 1})
FlashIn:Play()
FlashIn.Completed:Once(function() FadeOut:Play() end)
FadeOut.Completed:Once(function() HighlightObject:Destroy() end)
Options.HighlightObject = HighlightObject
tableinsert(Highlights, HighlightObject)
end
Targets[Target] = Options
end
end
end

local SetDescendants = function(v)
if v:IsA("Sound") then
v.Volume = 0
elseif v:IsA("Script") or v:IsA("LocalScript") then
v.Disabled = true
end
end

local OnCharacterAdded = function(NewCharacter)
local MuteConnection = NewCharacter.DescendantAdded:Connect(SetDescendants)
table.insert(RBXScriptConnections, MuteConnection)
if NewCharacter ~= Rig then
tableclear(Aligns)
tableclear(Blacklist)
tableclear(Accessories)
for i, v in next, GetChildren(Rig) do
if IsA(v, "Accoutrement") then
Destroy(v)
end
end
Character = NewCharacter
if OptionsSetCameraSubject then
taskspawn(SetCameraSubject)
end
if OptionsSetCharacter then
taskdefer(SetCharacter)
end
if OptionsParentCharacter then
Character.Parent = Rig
end
for Index, Descendant in next, GetDescendants(Character) do
taskspawn(DescendantAdded, Descendant)
end
tableinsert(RBXScriptConnections, Connect(Character.DescendantAdded, DescendantAdded))
Humanoid = WaitForChildOfClass(Character, "Humanoid")
local HumanoidRootPart = WaitForChildOfClassAndName(Character, "BasePart", "HumanoidRootPart")
if IsFirst then
if OptionsApplyDescription and Humanoid then
local AppliedDescription = GetAppliedDescription(Humanoid)
SetAccessories(AppliedDescription, {}, true)
taskspawn(ApplyDescription, RigHumanoid, AppliedDescription)
end
if HumanoidRootPart then
RigHumanoidRootPart.CFrame = HumanoidRootPart.CFrame
if OptionsSetCollisionGroup then
local CollisionGroup = HumanoidRootPart.CollisionGroup
for Index, Descendant in next, GetDescendants(Rig) do
if IsA(Descendant, "BasePart") then
Descendant.CollisionGroup = CollisionGroup
end
end
end
end
IsFirst = false
end
local IsAlive = true
if HumanoidRootPart then
for Target, Options in next, Targets do
if IsDescendantOf(Target, Workspace) then
local FirstPosition = Target.Position
local PredictionFling = Options.PredictionFling
local LastPosition = FirstPosition
local Timeout = osclock() + (Options.Timeout or 1)
if HumanoidRootPart then
if Humanoid then
if sethiddenproperty then -- i am too lazy to add a thing such as OptionsNanFling - guardian
SetState(Humanoid, Freefall)
else
SetState(Humanoid, Physics)
end
end
while IsDescendantOf(Target, Workspace) and osclock() < Timeout do
local DeltaTime = taskwait()
local Position = Target.Position
if ( Position - FirstPosition ).Magnitude > 100 then
break
end
local Offset = Vector3zero
if PredictionFling then
local BaseOffset = (Position - LastPosition) / DeltaTime * 0.13
local Frequency = Reanimate_Settings.Frequency
local Amplification = Reanimate_Settings.Amplification
local Time = tick()
local TargetFace = Target.CFrame.LookVector
local Oscillation = mathsin(Time * mathpi * 2 * Frequency) * Amplification
local OscillatedOffset = TargetFace * Oscillation
local FrontFaceOffset = TargetFace * Reanimate_Settings.FrontOffset
Offset = BaseOffset + OscillatedOffset + FrontFaceOffset
if sethiddenproperty then
pcall(function() Humanoid:Move(Vector3nan) end)
pcall(sethiddenproperty, HumanoidRootPart, "PhysicsRepRootPart", Target)
pcall(sethiddenproperty, Humanoid, "MoveDirectionInternal", Vector3nan)
end
end
HumanoidRootPart.AssemblyAngularVelocity = FlingVelocity
HumanoidRootPart.AssemblyLinearVelocity = FlingVelocity
if sethiddenproperty then -- wtf
HumanoidRootPart.CFrame = CFrame.new(Target.Position) * CFrame.Angles(0, Target.Orientation.Y, 0)
else
HumanoidRootPart.CFrame = CFrame.new(Target.Position + Offset) * CFrame.Angles(0, Target.Orientation.Y, 0)
end
LastPosition = Position
end
end
end
Targets[Target] = nil
end
HumanoidRootPart.AssemblyAngularVelocity = Vector3zero
HumanoidRootPart.AssemblyLinearVelocity = Vector3zero
if sethiddenproperty then
pcall(sethiddenproperty, HumanoidRootPart, "PhysicsRepRootPart", nil)
pcall(sethiddenproperty, Humanoid, "MoveDirectionInternal", Vector3zero)
end
if OptionsHatDrop then
taskspawn(function()
WaitForChildOfClassAndName(Character, "LocalScript", "Animate").Enabled = false
for Index, AnimationTrack in next, GetPlayingAnimationTracks(Humanoid) do
AnimationTrack:Stop()
end
LoadAnimation(Humanoid, Humanoid.RigType == R6 and R6Animation or R15Animation):Play(0)
pcall(NewIndex, Workspace, "FallenPartsDestroyHeight", nan)
local RootPartCFrame = RigHumanoidRootPart.CFrame
RootPartCFrame = CFramenew(RootPartCFrame.X, HatDropY, RootPartCFrame.Z)
while IsAlive do
HumanoidRootPart.AssemblyAngularVelocity = Vector3zero
HumanoidRootPart.AssemblyLinearVelocity = HatDropLinearVelocity
HumanoidRootPart.CFrame = RootPartCFrame
taskwait()
end
end)
elseif OptionsHideCharacter then
local HideCharacterOffset = typeof(OptionsHideCharacter) == "Vector3" and OptionsHideCharacter or HideCharacterOffset
local RootPartCFrame = RigHumanoidRootPart.CFrame + HideCharacterOffset
taskspawn(function()
while IsAlive do
HumanoidRootPart.AssemblyAngularVelocity = Vector3zero
HumanoidRootPart.AssemblyLinearVelocity = Vector3zero
HumanoidRootPart.CFrame = RootPartCFrame
taskwait()
end
end)
elseif OptionsTeleportRadius then
HumanoidRootPart.CFrame = RigHumanoidRootPart.CFrame + Vector3new(mathrandom(- OptionsTeleportRadius, OptionsTeleportRadius), 0, mathrandom(- OptionsTeleportRadius, OptionsTeleportRadius))
end
end
local ToolFling = OptionsDefaultFlingOptions.ToolFling
local Tools2 = {}
if ToolFling then
local Backpack = FindFirstChildOfClass(LocalPlayer, "Backpack")
tableclear(Tools)
if type(ToolFling) == "string" then
local Tool = FindFirstChildOfClassAndName(Backpack, "Tool", ToolFling)
if Tool then
Tool.Parent = Character
tableinsert(Tools2, Tool)
end
else
for Index, Tool in GetChildren(Backpack) do
if IsA(Tool, "Tool") then
Tool.Parent = Character
tableinsert(Tools2, Tool)
end
end
end
UnequipTools(Humanoid)
end
--[[
local Head = game.ReplicatedStorage.LoadHat:FireServer(96026864630989)
local Torso = game.ReplicatedStorage.LoadHat:FireServer(70669494900153)
local UpperRightArm = game.ReplicatedStorage.LoadHat:FireServer(108430890907729)
local UpperLeftArm = game.ReplicatedStorage.LoadHat:FireServer(86824424549357)
local LowerRightArm = game.ReplicatedStorage.LoadHat:FireServer(101778107218906)
local LowerLeftArm = game.ReplicatedStorage.LoadHat:FireServer(111138012932143)
local UpperRightLeg = game.ReplicatedStorage.LoadHat:FireServer(122293866267553)
local UpperLeftLeg = game.ReplicatedStorage.LoadHat:FireServer(138935838350440)
local LowerRightLeg = game.ReplicatedStorage.LoadHat:FireServer(124986753703857)
local LowerLeftLeg = game.ReplicatedStorage.LoadHat:FireServer(107582737127229)
]]
taskwait(OptionsBreakJointsDelay)
if Humanoid then
SetInstanceValue(Humanoid, "BreakJointsOnDeath", true)
SetInstanceValue(Humanoid, "Health", 0)
end
for i, v in pairs(Character:GetDescendants()) do
if v:IsA("JointInstance") or v:IsA("Constraint") then
v:Destroy()
end
end
ModelBreakJoints(Character)
if replicatesignal and OptionsUseServerBreakJoints then
replicatesignal(Kill)
replicatesignal(Humanoid.ServerBreakJoints)
end
SetState(Humanoid, Dead)
Wait(Humanoid.Died)
tableclear(Aligns)
tableclear(Blacklist)
tableclear(Accessories)
for Index, Highlight in Highlights do
Destroy(Highlight)
end
for i, v in next, GetChildren(Rig) do -- pretty much FORCE welds to delete cause games with ragdoll messed ts up and only 3 hats worked (fixed)
if IsA(v, "Accoutrement") then
Destroy(v)
end
end
for Index, Descendant in next, GetDescendants(Character) do
taskspawn(DescendantAdded, Descendant)
end
for Index, Tool in Tools2 do
local Handle = FindFirstChildOfClassAndName(Tool, "BasePart", "Handle")
if Handle then
Tool.Parent = Character
else
tableremove(Tools2, Index)
end
end
Tools = Tools2
UnequipTools(Humanoid)
IsAlive = false
if OptionsHatDrop then
pcall(NewIndex, Workspace, "FallenPartsDestroyHeight", FallenPartsDestroyHeight)
end
end
end

local OnInputBegan = function(InputObject)
 local UserInputType = InputObject.UserInputType
if UserInputType == MouseButton1 or UserInputType == Touch then
local Target = Mouse.Target
local HatFling = OptionsDefaultFlingOptions.HatFling
local ToolFling = OptionsDefaultFlingOptions.ToolFling
if HatFling and OptionsHatDrop then
local Part = type(HatFling) == "table" and GetHandleFromTable(HatFling)
if not Part then
for Index, Child in GetChildren(Character) do
if IsA(Child, "Accoutrement") then
local Handle = FindFirstChildOfClassAndName(Child, "BasePart", "Handle")
if Handle then
Part = Handle
break
end
end
end
end
if Part then
Exceptions[Part] = true
while IsMouseButtonPressed(UserInputService, MouseButton1) do
if Part.ReceiveAge == 0 then
Part.AssemblyAngularVelocity = FlingVelocity
Part.AssemblyLinearVelocity = FlingVelocity
Part.CFrame = Mouse.Hit + AntiSleep
end
taskwait()
end
Exceptions[Part] = nil
end
elseif ToolFling then
local Backpack = FindFirstChildOfClass(LocalPlayer, "Backpack")
local Tool = nil
if type(ToolFling) == "string" then
Tool = FindFirstChild(Backpack, ToolFling) or FindFirstChild(Character, ToolFling)
end
if not Tool then
Tool = FindFirstChildOfClass(Backpack, "Tool") or FindFirstChildOfClass(Character, "Tool")
end
if Tool then
local Handle = FindFirstChildOfClassAndName(Tool, "BasePart", "Handle") or FindFirstChildWhichIsA(Tool, "BasePart")
if Handle then
Tool.Parent = Character
while IsMouseButtonPressed(UserInputService, MouseButton1) do
if Handle.ReceiveAge == 0 then
Handle.AssemblyAngularVelocity = FlingVelocity
Handle.AssemblyLinearVelocity = FlingVelocity
Handle.CFrame = Mouse.Hit + AntiSleep
end
taskwait()
end
UnequipTools(Humanoid)
Handle.AssemblyAngularVelocity = Vector3zero
Handle.AssemblyLinearVelocity = Vector3zero
Handle.CFrame = RigHumanoidRootPart.CFrame
end
end
else
Fling(Target, OptionsDefaultFlingOptions)
end
end
end

local OnPostSimulation = function()
Time = osclock()
local DeltaTime = Time - LastTime
LastTime = Time
if not OptionsSetCharacter and IsLockCenter then
local Position = RigHumanoidRootPart.Position
RigHumanoid.AutoRotate = false
RigHumanoidRootPart.CFrame = CFramelookAt(Position, Position + CurrentCamera.CFrame.LookVector * Vector3xzAxis)
elseif not OptionsSetCharacter and not IsLockCenter then
RigHumanoid.AutoRotate = true
end
if OptionsSimulationRadius then
pcall(SetSimulationRadius)
end
AntiSleep = mathsin(Time * 15) * 0.0015 * Vector3one
local Axis = 27 + mathsin(Time)
for Index, Table in next, Aligns do
local Part0 = Table.Part0
if not Exceptions[Part0] then
if Part0.ReceiveAge == 0 then
if IsDescendantOf(Part0, Workspace) and not GetJoints(Part0)[1] and not IsGrounded(Part0) then
local Part1 = Table.Part1
Part0.AssemblyAngularVelocity = Vector3zero
local LinearVelocity = Part1.AssemblyLinearVelocity * Axis
Part0.AssemblyLinearVelocity = Vector3new(LinearVelocity.X, Axis, LinearVelocity.Z)
Part0.CFrame = Part1.CFrame * Table.Offset + AntiSleep
end
end
end
end
if not OptionsSetCharacter and Humanoid then
Move(RigHumanoid, Humanoid.MoveDirection)
RigHumanoid.Jump = Humanoid.Jump
end
end

local OnPreRender = function()
local Position = RigHumanoidRootPart.Position
RigHumanoidRootPart.CFrame = CFramelookAt(Position, Position + CurrentCamera.CFrame.LookVector * Vector3xzAxis)
for Index, Table in next, Aligns do
local Part0 = Table.Part0
if Part0.ReceiveAge == 0 and IsDescendantOf(Part0, Workspace) and not GetJoints(Part0)[1] and not IsGrounded(Part0) then
Part0.CFrame = Table.Part1.CFrame * Table.Offset
end
end
end

local OnMouseBehaviorChanged = function()
IsLockCenter = UserInputService.MouseBehavior == LockCenter
if IsLockCenter then
PreRenderConnection = Connect(PreRender, OnPreRender)
tableinsert(RBXScriptConnections, PreRenderConnection)
elseif PreRenderConnection then
Disconnect(PreRenderConnection)
tableremove(RBXScriptConnections, tablefind(RBXScriptConnections, PreRenderConnection))
end
end

local OnPreSimulation = function()
if OptionsDisableCharacterCollisions and Character then
for Index, Descendant in next, GetDescendants(Character) do
if IsA(Descendant, "BasePart") then
Descendant.CanCollide = false
end
end
end
for Index, Descendant in next, GetChildren(Rig) do
if IsA(Descendant, "BasePart") then
Descendant.CanCollide = false
end
end
end

local Register = function()
repeat
IsRegistered = pcall(SetCore, StarterGui, "ResetButtonCallback", BindableEvent)
taskwait()
until IsRegistered
end

Reanimator.Start = function(Options)
print("starting up the reanimate")
if not IsRunning then
IsFirst = true
IsRunning = true
Options = Options or {}
OptionsAccessories = Options.Accessories or {}
OptionsApplyDescription = Options.ApplyDescription
OptionsBreakJointsDelay = Options.BreakJointsDelay or 0
OptionsClickFling = Options.ClickFling
OptionsDisableCharacterCollisions = Options.DisableCharacterCollisions
OptionsDisableHealthBar = Options.DisableHealthBar
OptionsDisableRigCollisions = Options.DisableRigCollisions
OptionsDefaultFlingOptions = Options.DefaultFlingOptions or {}
OptionsHatDrop = Options.HatDrop
OptionsHideCharacter = Options.HideCharacter
OptionsParentCharacter = Options.ParentCharacter
OptionsRigTransparency = Options.RigTransparency or 1
OptionsSetCameraSubject = Options.SetCameraSubject
OptionsSetCameraType = Options.SetCameraType
OptionsSetCharacter = Options.SetCharacter
OptionsSetCollisionGroup = Options.SetCollisionGroup
OptionsSimulationRadius = Options.SimulationRadius
OptionsTeleportRadius = Options.TeleportRadius
OptionsUseServerBreakJoints = Options.UseServerBreakJoints
if OptionsDisableHealthBar then
IsHealthEnabled = GetCoreGuiEnabled(StarterGui, Health)
SetCoreGuiEnabled(StarterGui, Health, false)
end
BindableEvent = Instancenew("BindableEvent")
tableinsert(RBXScriptConnections, Connect(BindableEvent.Event, Reanimator.Stop))
			Rig = Options.R15 and Clone(R15HumanoidModel) or Clone(HumanoidModel)
Rig.Name = "non"
RigHumanoid = Rig.Humanoid
RigHumanoidRootPart = Rig.HumanoidRootPart
Rig.Parent = Workspace
local CreateObject = function(Name)
local Part = Instance.new("Part")
Part.Name = Name
Part.Massless = true
Part.CanCollide = true
Part.Transparency = 1
Part.Size = Vector3new(0.1, 0.1, 0.1)
Part.Anchored = true
Part.Parent = Rig
return Part
end
for Index, Descendant in next, GetDescendants(Rig) do
if IsA(Descendant, "Attachment") then
Attachments[Descendant.Name] = Descendant
elseif IsA(Descendant, "BasePart") or IsA(Descendant, "Decal") then
Descendant.Transparency = OptionsRigTransparency
end
end
RigHumanoid.JumpPower = 50
RigHumanoid.WalkSpeed = 16
OnCurrentCameraChanged()
tableinsert(RBXScriptConnections, Connect(CurrentCameraChanged, OnCurrentCameraChanged))
if OptionsClickFling then
tableinsert(RBXScriptConnections, Connect(InputBegan, OnInputBegan))
end
local Character = LocalPlayer.Character
for i, v in next, GetDescendants(Character) do -- i kept messing ts up so im just putting it here
if IsA(v, "Script") or IsA(v, "LocalScript") then
v.Disabled = true
elseif IsA(v, "Sound") then
v.Volume = 0
end
end
if Character then
OnCharacterAdded(Character)
end
tableinsert(RBXScriptConnections, Connect(CharacterAdded, OnCharacterAdded))
LastTime = osclock()
tableinsert(RBXScriptConnections, Connect(PostSimulation, OnPostSimulation))
if not OptionsSetCharacter then
OnMouseBehaviorChanged()
tableinsert(RBXScriptConnections, Connect(MouseBehaviorChanged, OnMouseBehaviorChanged))
end
if OptionsDisableCharacterCollisions or OptionsDisableRigCollisions then
OnPreSimulation()
tableinsert(RBXScriptConnections, Connect(PreSimulation, OnPreSimulation))
end
IsRegistered = pcall(SetCore, StarterGui, "ResetButtonCallback", BindableEvent)
if not IsRegistered then
taskspawn(Register)
end
return {
BindableEvent = BindableEvent,
Fling = Fling,
Rig = Rig
}
end
end

Reanimator.Stop = function()
if IsRunning then
IsFirst = false
IsRunning = false
for Index, Highlight in Highlights do
Destroy(Highlight)
end
tableclear(Highlights)
for Index, RBXScriptConnection in next, RBXScriptConnections do
Disconnect(RBXScriptConnection)
end
tableclear(RBXScriptConnections)
Destroy(BindableEvent)
if Character.Parent == Rig then
Character.Parent = Workspace
end
if Humanoid then
SetState(Humanoid, Dead)
end
Destroy(Rig)
if OptionsDisableHealthBar and not GetCoreGuiEnabled(StarterGui, Health) then
SetCoreGuiEnabled(StarterGui, Health, IsHealthEnabled)
end
if IsRegistered then
pcall(SetCore, StarterGui, "ResetButtonCallback", true)
else
IsRegistered = pcall(SetCore, StarterGui, "ResetButtonCallback", true)
end
end
end
end

Empyrean = Reanimator.Start({
Accessories = {
 -- Immortality Lord Rig
{ Name = "Head", MeshId = "17375312569",  TextureId = "17375312612", Offset = CFrame.new(0, 1, 0) * CFrame.Angles(0, Rad(180), 0) },
{ Name = "Torso", MeshId = "17269636541",  TextureId = "17269636558", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57) },
{ Name = "Right Arm",MeshId = "17269487439",  TextureId = "17269487469", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57) },
{ Name = "Left Arm", MeshId = "17269487439", TextureId = "17269487469", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57) },
{ Name = "Right Leg", MeshId = "17269487439", TextureId = "17269487469", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57) },
{ Name = "Left Leg", MeshId = "17269487439", TextureId = "17269487469", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57)},
-- 7ws 2x Rig
{ Name = "Torso", MeshId = "126825022897778",  TextureId = "136752500636691", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57) },
{ Name = "Right Arm",MeshId = "138744606849121",  TextureId = "83207562332062", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57) },
{ Name = "Left Arm", MeshId = "138744606849121", TextureId = "83207562332062", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57) },
{ Name = "Right Leg", MeshId = "138744606849121", TextureId = "136752500636691", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57) },
{ Name = "Left Leg", MeshId = "138744606849121", TextureId = "136752500636691", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57)},
-- Locust Rig
{ Name = "Torso", MeshId = "17345242336",  TextureId = "17345250641", Offset = CFrame.new(0, 1.5, 0.25) },
{ Name = "Right Arm", MeshId = "106942781700680", TextureId = "90838563977106", Offset = CFrame.new(2, 0, 0) },
{ Name = "Right Arm", MeshId = "17323421898", TextureId = "95461117386269", Offset = CFrame.new(2, -6, 0) },
{ Name = "Left Arm", MeshId = "82433902584666", TextureId = "129625048922193", Offset = CFrame.new(-2, 0, 0) },
{ Name = "Left Arm", MeshId = "17323421898", TextureId = "75930329122564", Offset = CFrame.new(-2, -6, 0) },
{ Name = "Right Leg",MeshId = "98818051326497",  TextureId = "87142331045456", Offset = CFrame.new(0, -1, 0) },
{ Name = "Right Leg",MeshId = "97418736735022",  TextureId = "84047101371984", Offset = CFrame.new(0, 5, 0) },
{ Name = "Left Leg", MeshId = "115322100534609", TextureId = "140198794837319", Offset = CFrame.new(0, 5, 0) },
{ Name = "Left Leg", MeshId = "70807086513216", TextureId = "87564259970629", Offset = CFrame.new(0, -1, 0) },
-- 2x Rig
{ Name = "Head", MeshId = "92572400594624",  TextureId = "117484156735788", Offset = CFrame.identity * CFrame.Angles(0, Rad(180), 0) },
{ Name = "Torso", MeshId = "111946216585470",  TextureId = "85260593368362", Offset = CFrame.identity },
{ Name = "Right Arm", MeshId = "93749227415046", TextureId = "103757531289975", Offset = CFrame.identity },
{ Name = "Left Arm", MeshId = "117649985156221", TextureId = "103757531289975", Offset = CFrame.identity},
{ Name = "Right Leg",MeshId = "76010149115685",  TextureId = "103160995675216", Offset = CFrame.identity },
{ Name = "Left Leg", MeshId = "137156465227879", TextureId = "103160995675216", Offset = CFrame.identity },
-- 3.5x Rig
{ Name = "Head", MeshId = "106352630533813",  TextureId = "117484156735788", Offset = CFrame.identity },
{ Name = "Torso", MeshId = "93262581544348",  TextureId = "83269599235494", Offset = CFrame.identity * CFrame.Angles(0, 0, 0)},
{ Name = "Right Arm", MeshId = "115105775952798", TextureId = "103757531289975", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57)},
{ Name = "Left Arm", MeshId = "115105775952798", TextureId = "103757531289975", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57)},
{ Name = "Right Leg",MeshId = "114570321720060",  TextureId = "83269599235494", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57) },
{ Name = "Left Leg", MeshId = "114570321720060", TextureId = "83269599235494", Offset = CFrame.identity * CFrame.Angles(0, 0, -1.57)},
-- Cannoneer Rig
{ Name = "Torso", MeshId = "131018666998514",  TextureId = "114854030584735", Offset = CFrame.identity },
{ Name = "Right Arm", MeshId = "74241169361466", TextureId = "103596506136222", Offset = CFrame.Angles(Rad(90), 0, 0) },
{ Name = "Left Arm", MeshId = "103399434286698", TextureId = "71393000026580", Offset = CFrame.Angles(Rad(90), 0, 0) },
{ Name = "Right Leg",MeshId = "80852136456671",  TextureId = "114854030584735", Offset = CFrame.Angles(Rad(90), 0, Rad(180))},
{ Name = "Left Leg", MeshId = "80852136456671", TextureId = "114854030584735", Offset = CFrame.Angles(Rad(90), 0, Rad(180)) },
-- Hammer Head Rig
{ Name = "Torso", MeshId = "139792224823925",  TextureId = "89183204903931", Offset = CFrame.Angles(0, 0, Rad(90)) },
{ Name = "Right Arm", MeshId = "105263225400272",  TextureId = "111402858657243", Offset = CFrame.Angles(0, 0, Rad(90)) },
{ Name = "Left Arm", MeshId = "105263225400272",  TextureId = "111402858657243", Offset = CFrame.Angles(0, 0, Rad(90)) },
-- Glitchy Limbs (Monochrome)
{ Name = "Torso", MeshId = "94838871645327",  TextureId = "108681181592495", Offset = CFrame.identity },
{ Name = "Right Arm", MeshId = "18885728798", TextureId = "18885728798", Offset = CFrame.identity },
{ Name = "Left Arm", MeshId = "18885728798", TextureId = "18885728798", Offset = CFrame.identity },
{ Name = "Right Leg",MeshId = "100080236046620",  TextureId = "78703116520529", Offset = CFrame.identity },
{ Name = "Left Leg", MeshId = "91790195871679", TextureId = "108681181592495", Offset = CFrame.identity },
-- Gojo Rig
{ Name = "Torso", MeshId = "113465334594272",  TextureId = "94020114074172", Offset = CFrame.identity },
{ Name = "Right Arm",MeshId = "82030652840870",  TextureId = "137595219926625", Offset = CFrame.identity },
{ Name = "Left Arm", MeshId = "91244322746029", TextureId = "137595219926625", Offset = CFrame.identity },
{ Name = "Right Leg", MeshId = "132187752780278", TextureId = "97394845862368", Offset = CFrame.Angles(3.15, 0, 0) },
{ Name = "Left Leg", MeshId = "131967977780088", TextureId = "97394845862368", Offset =  CFrame.Angles(3.15, 0, 0) },
-- New Free Hair Limbs
{ MeshId = "319354652", Name = "Left Arm", Offset = CFrame.new(0.15, 0, 0) *  CFrame.Angles(0, -1.57, 0), TextureId = "376186990" },
{ MeshId = "319354652", Name = "Right Arm", Offset = CFrame.new(-0.15, 0, 0) * CFrame.Angles(0, 1.57, 0), TextureId = "304117018" },
{ MeshId = "81642452", Name = "Left Leg", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, Rad(180)), TextureId = "6858317942" },
{ MeshId = "81642452", Name = "Right Leg", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, Rad(180)), TextureId = "6858318826" },
-- New Free Rig
{ MeshId = "4819720316", Name = "Torso", Offset = CFrame.Angles(0, 0, -0.25), TextureId = "4819722776" },
{ MeshId = "3030546036", Name = "Left Arm", Offset = CFrame.new(0.15, 0, 0) *  CFrame.Angles(-1.57, 0, 1.57), TextureId = "3033903209" },
{ MeshId = "3030546036", Name = "Right Arm", Offset = CFrame.new(-0.15, 0, 0) * CFrame.Angles(-1.57, 0, -1.57), TextureId = "3360978739" },
{ MeshId = "3030546036", Name = "Left Leg", Offset = CFrame.new(0.15, 0, 0) * CFrame.Angles(-1.57, 0, 1.57), TextureId = "3033898741" },
{ MeshId = "3030546036", Name = "Right Leg", Offset = CFrame.new(0.15, 0, 0) *  CFrame.Angles(-1.57, 0, -1.57), TextureId = "3409604993" },
-- Snake Banisher Rig
{ MeshId = "125443585075666", Name = "Torso", Offset = CFrame.Angles(0, 3.15, 0), TextureId = "121023324229475" },
{ MeshId = "121342985816617", Name = "Left Arm", Offset = CFrame.Angles(0, 0, 1.57), TextureId = "129264637819824" },
{ MeshId = "121342985816617", Name = "Right Arm", Offset = CFrame.Angles(0, 3.15, 1.57), TextureId = "129264637819824" },
{ MeshId = "83395427313429", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "97148121718581" },--18641142410
-- Prosthetics (Furnace Rig)
{ MeshId = "117554824897780", Name = "Right Leg", Offset = CFrame.Angles(0, -1.57, 0), TextureId = "99077561039115" },
{ MeshId = "123388937940630", Name = "Left Leg", Offset = CFrame.Angles(0, 1.57, 0), TextureId = "99077561039115" },
{ MeshId = "117554824897780", Name = "Right Leg", Offset = CFrame.Angles(0, -1.57, 0), TextureId = "84429400539007" },
{ MeshId = "123388937940630", Name = "Left Leg", Offset = CFrame.Angles(0, 1.57, 0), TextureId = "84429400539007" },
-- Classic Cheap Rig
{ MeshId = "12344206657", Name = "Left Arm", Offset = CFrame.new(0.05, 0.05, -0.075) * CFrame.Angles(-2, 0, 0), TextureId = "12344206675" },
{ MeshId = "12344207333", Name = "Right Arm", Offset = CFrame.new(-0.05, 0.05, -0.075) * CFrame.Angles(-1.95, 0, 0), TextureId = "12344207341" },
{ MeshId = "11159370334", Name = "Left Leg", Offset = CFrame.Angles(1.57, 1.57, 0), TextureId = "11159284657" },
{ MeshId = "11263221350", Name = "Right Leg", Offset = CFrame.Angles(1.57, -1.57, 0), TextureId = "11263219250" },
-- Grey Mesh Rig 
{ MeshId = "127552124837034", Names = {"Torso"}, Offset = CFrame.Angles(0, 0, 0), TextureId = "131014325980101" },--14255556501
{ MeshId = "117287001096396", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 0), TextureId = "120169691545791" },--14255556501
{ MeshId = "121304376791439", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 0), TextureId = "131014325980101" },--18641142410
-- Classical Products rig (white/black arms)
{ MeshId = "14241018198", Names = {"Torso"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14251599953" },
{ MeshId = "17374767929", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "17374768001" },
{ MeshId = "17387586286", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "17387586304" },
{ MeshId = "14255522247", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14255543546" },
-- Noob Rig
{ MeshId = "18640899369", Name = "Torso", Offset = CFrame.Angles(0, 0, 0), TextureId = "18640899481" },
{ MeshId = "18640914129", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 0), TextureId = "18640914168" },
{ MeshId = "18640901641", Names = { "Left Leg", "Right Leg"}, Offset = CFrame.Angles(0, 0, 0), TextureId = "18640901676" },
-- Genesis Black Rig
{ MeshId = "110684113028749", Name = "Torso", Offset = CFrame.identity, TextureId = "70661572547971" },
{ MeshId = "125405780718494", Name = "Left Arm", Offset = CFrame.Angles(0, 0,  Rad(90)), TextureId = "136752500636691" },
{ MeshId = "125405780718494", Name = "Right Arm", Offset = CFrame.Angles(0, 0,  Rad(90)), TextureId = "136752500636691" },
{ MeshId = "125405780718494", Name = "Left Leg", Offset = CFrame.Angles(0, 0, Rad(90)), TextureId = "136752500636691" },
{ MeshId = "125405780718494", Name = "Right Leg", Offset = CFrame.Angles(0, 0,  Rad(90)), TextureId = "136752500636691" },
-- Genesis White Rig
{ MeshId = "126825022897778", Name = "Torso", Offset = CFrame.identity, TextureId = "130689541138804" },
{ MeshId = "99608462237958", Name = "Left Arm", Offset = CFrame.Angles(0, 0,  Rad(90)), TextureId = "130809869695496" },
{ MeshId = "139733645770094", Name = "Right Arm", Offset = CFrame.Angles(0, 0,  Rad(90)), TextureId = "130809869695496" },
{ MeshId = "105141400603933", Name = "Left Leg", Offset = CFrame.Angles(0, 0, Rad(90)), TextureId = "71060417496309" },
{ MeshId = "90736849096372", Name = "Right Leg", Offset = CFrame.Angles(0, 0,  Rad(90)), TextureId = "79186624401216" },
-- request
 },
ApplyDescription = true,
BreakJointsDelay = 0.25, -- dont modify
ClickFling = false,
DefaultFlingOptions = {
HatFling = false,
Highlight = true,
PredictionFling = true,
Timeout = 0.95,
ToolFling = false,
},
DisableCharacterCollisions = false, -- dont modify
DisableHealthBar = true, -- dont modify
DisableRigCollisions = false, -- dont modify
HatDrop = false, -- dont use
HideCharacter = Vector3.new(0, -45, 0),
ParentCharacter = true, -- dont modify
RigTransparency = 1,
R15 = false, -- dont use
SetCameraSubject = false, -- dont modify
SetCameraType = false, -- dont modify
SetCharacter = true, -- dont use
SetCollisionGroup = true, -- dont modify
SimulationRadius = 2147483647, -- dont modify
TeleportRadius = 12, 
UseServerBreakJoints = true, -- dont modify
})
--reanim end

local Players = game:GetService("Players");     
local Lighting = game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ScriptContext = game:GetService("ScriptContext");
local VRService = game:GetService("VRService");
local VirtualUser = game:GetService("VirtualUser");
local RunService = game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local HapticService = game:GetService("HapticService");
local UserInputService = game:GetService("UserInputService");
local CurrentCamera = workspace.CurrentCamera
local cacheFolder = Instance.new("Folder", workspace);
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse()
local Character = Empyrean.Rig
local hum = Character:FindFirstChildOfClass("Humanoid");
local root = hum.RootPart;
local startCF = root.CFrame
local VRReady = UserInputService.VREnabled;
local R15 = hum.RigType == Enum.HumanoidRigType.R15 and true or false
local oldCF = Character.HumanoidRootPart.CFrame
local Utils = {}
function Utils:NoCollide(a, b, parent)
	local noCollide = Instance.new("NoCollisionConstraint")
	noCollide.Part0 = a
	noCollide.Part1 = b
	noCollide.Name = ""
	noCollide.Parent = parent or cacheFolder
	return noCollide
end
local function Motor6D(part0, part1, c0, c1, name)
	part1.Transparency = 1;
	part1.Massless = true
	local motor = Instance.new("Motor6D", part1); motor.Name = name; motor.Part0 = part0; motor.Part1 = part1; motor.C0 = c0; motor.C1 = c1;
	return motor, motor.C0
end
local function Lerp(a, b, t)
	return a + (b - a) * t
end
local function solveIK(originCF, targetPos, l1, l2)	
	local localized = originCF:pointToObjectSpace(targetPos)
	local localizedUnit = localized.unit
	local l3 = localized.magnitude
	local axis = Vector3.new(0, 0, -1):Cross(localizedUnit)
	local angle = math.acos(-localizedUnit.Z)
	local planeCF = originCF * CFrame.fromAxisAngle(axis, angle)
	if l3 < math.max(l2, l1) - math.min(l2, l1) then
		return planeCF * CFrame.new(0, 0,  math.max(l2, l1) - math.min(l2, l1) - l3), -math.pi/2, math.pi
	elseif l3 > l1 + l2 then
		return planeCF, math.pi/2, 0
	else
		local a1 = -math.acos((-(l2 * l2) + (l1 * l1) + (l3 * l3)) / (2 * l1 * l3))
		local a2 = math.acos(((l2  * l2) - (l1 * l1) + (l3 * l3)) / (2 * l2 * l3))
		return planeCF, a1 + math.pi/2, a2 - a1
	end
end
local function GetMotorForLimb(Limb)
	for _, Motor in next, Character:GetDescendants() do
		if Motor:IsA("Motor6D") and Motor.Part1 == Limb then
			return Motor
		end
	end
end
local function cframeAlign(a, b, position, rotation)
	local Motor = GetMotorForLimb(a)
	if Motor then Motor:Destroy() end
	position = position or Vector3.new(0, 0, 0)
	rotation = rotation or Vector3.new(0, 0, 0)
	local pos = CFrame.new(position) * CFrame.Angles(math.rad(rotation.X), math.rad(rotation.Y), math.rad(rotation.Z))
	RunService.Stepped:Connect(function()
		a.CFrame = b.CFrame * pos
	end)
end
local function align(a, b, pos, rot, options)
	if typeof(options) ~= 'table' then
		options = {type = "None", resp = 200, length = 5, reactiontorque = false, reactionforce = false}
	end
	local a1
	local att0, att1 do
		att0 = a:IsA("Accessory") and Instance.new("Attachment", a.Handle) or Instance.new("Attachment", a)
		att1 = Instance.new("Attachment", b); 
		att1.Position = pos or Vector3.new(0,0,0); att1.Orientation = rot or Vector3.new(0,0,0);
	end
	local Handle = a:IsA("Accessory") and a.Handle or a;
 	Handle.CanCollide = false;
 	local Motor = GetMotorForLimb(a); if Motor then Motor:Destroy() end
	if options.type == "rope" then 
		att0.Position = rot
		local al = Instance.new("RopeConstraint", Handle);
		al.Attachment0 = att0; al.Attachment1 = att1;
		al.Length = options.length or 0.5
	elseif options.type == "ball" then
		att0.Position = rot
		local al = Instance.new("BallSocketConstraint", Handle)
		al.Attachment0 = att0
		al.Attachment1 = att1
		al.Restitution = 1
		al.LimitsEnabled = true
		al.MaxFrictionTorque = 10
		al.TwistLimitsEnabled = true
		al.UpperAngle = 50
		al.TwistLowerAngle = 10
		al.TwistUpperAngle = -100
	elseif type == "hinge" then
		att0.Position = rot
		local al = Instance.new("HingeConstraint", Handle)
		al.Attachment0 = att0
		al.Attachment1 = att1
	else
		local al = Instance.new("AlignPosition", Handle);
		al.Attachment0 = att0; al.Attachment1 = att1;
		al.RigidityEnabled = true;
		al.ReactionForceEnabled = options.reactionforce or false;
		al.ApplyAtCenterOfMass = true;
		al.MaxForce = 10000000;
		al.MaxVelocity = math.huge/9e110;
		al.Responsiveness = options.resp or 200;
		local ao = Instance.new("AlignOrientation", Handle);    
		ao.Attachment0 = att0; ao.Attachment1 = att1;
		ao.RigidityEnabled = true;
		ao.ReactionTorqueEnabled = options.reactiontorque or true;
		ao.PrimaryAxisOnly = false;
		ao.MaxTorque = 10000000;
		ao.MaxAngularVelocity = math.huge/9e110;
		ao.Responsiveness = 200;
	end
	return att1, a1
end
function alignHand(hand, pospart, rotpart, pos, rot)
	local Motor = GetMotorForLimb(hand); if Motor then Motor:Destroy() end
	local handatt = Instance.new("Attachment", hand)
	local posatt = Instance.new("Attachment", pospart)
	posatt.Position = pos or Vector3.new(0,0,0)
	local rotatt = Instance.new("Attachment", rotpart)
	rotatt.Orientation = rot or Vector3.new(0,0,0)
	local al = Instance.new("AlignPosition", hand);
	al.RigidityEnabled = true;
	al.ReactionForceEnabled = false;
	al.ApplyAtCenterOfMass = true;
	al.MaxForce = 10000000;
	al.MaxVelocity = math.huge/9e110;
	al.Responsiveness = 200;
	local ao = Instance.new("AlignOrientation", hand);    
	ao.RigidityEnabled = true;
	ao.ReactionTorqueEnabled = false;
	ao.PrimaryAxisOnly = false;
	ao.MaxTorque = 10000000;
	ao.MaxAngularVelocity = math.huge/9e110;
	ao.Responsiveness = 200;
	al.Attachment0 = handatt
	al.Attachment1 = posatt
	ao.Attachment0 = handatt
	ao.Attachment1 = rotatt
end
local function holdPart(v, grabAtt, drop)
	if v:IsA("BasePart") and v.Anchored == false then
		for _, x in next, v:GetChildren() do
			if x:IsA("BodyAngularVelocity") or x:IsA("BodyForce") or x:IsA("BodyGyro") or x:IsA("BodyPosition") or x:IsA("BodyThrust") or x:IsA("BodyVelocity") or x:IsA("RocketPropulsion") or x:IsA("Attachment")  or x:IsA("AlignPosition") or x:IsA("NoCollisionConstraint") then
				x:Destroy()
			end
		end
		if drop then return end
		Utils:NoCollide(grabAtt.Parent, v, v)
		grabAtt.WorldPosition = v.Position
		local att0 = Instance.new("Attachment", v)
		local AlignPosition = Instance.new("AlignPosition", v)
		AlignPosition.ReactionForceEnabled = true
		AlignPosition.MaxForce = 9999999999999999
		AlignPosition.MaxVelocity = math.huge
		AlignPosition.Responsiveness = 200
		AlignPosition.RigidityEnabled = true
		AlignPosition.Attachment0 = att0 
		AlignPosition.Attachment1 = grabAtt
	end
end
local vrparts, rhand, lhand, header, ToolTrack, HeadTrack, ratt, latt do
	vrparts = Instance.new("Folder", workspace); vrparts.Name = "VRParts"
	rhand = Instance.new("Part", vrparts); rhand.Anchored = true; rhand.CanCollide = false; rhand.Transparency = 1;
	ratt = Instance.new("Attachment", rhand);
	lhand = Instance.new("Part", vrparts); lhand.Anchored = true; lhand.CanCollide = false; lhand.Transparency = 1;
	latt = Instance.new("Attachment", lhand);
	header = Instance.new("Part", vrparts); header.Anchored = true; header.CanCollide = false; header.Transparency = 1;
	HeadTrack = Instance.new("Part", vrparts); HeadTrack.Anchored = true; HeadTrack.CanCollide = false; HeadTrack.Transparency = 1;
	if VRReady then
		VRService.UserCFrameChanged:Connect(function()
			local LeftHandCFrame = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand)
			local RightHandCFrame = VRService:GetUserCFrame(Enum.UserCFrame.RightHand)
			local HeadCFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head)
			rhand.CFrame = (CurrentCamera.CFrame*CFrame.new(RightHandCFrame.p*options.HeadScale))*CFrame.fromEulerAnglesXYZ(RightHandCFrame:ToEulerAnglesXYZ())*CFrame.Angles(math.rad(90), math.rad(90), math.rad(0))
			lhand.CFrame = (CurrentCamera.CFrame*CFrame.new(LeftHandCFrame.p*options.HeadScale))*CFrame.fromEulerAnglesXYZ(LeftHandCFrame:ToEulerAnglesXYZ())*CFrame.Angles(math.rad(90), math.rad(90), math.rad(0))
			header.CFrame = (CurrentCamera.CFrame*CFrame.new(HeadCFrame.p*options.HeadScale)) *CFrame.fromEulerAnglesXYZ(HeadCFrame:ToEulerAnglesXYZ())
		end)
	else
		RunService.RenderStepped:Connect(function()
			header.CFrame = CurrentCamera.CFrame
		end)
	end
end
if options.BubbleChat then
	Players.PlayerAdded:connect(function(User)
		User.Chatted:connect(function(Chat)
			game:GetService("Chat"):Chat(User.Character.Head,Chat,Enum.ChatColor.White)
		end)
	end)
	for i,v in pairs(Players:GetPlayers()) do
		v.Chatted:connect(function(Chat)
			game:GetService("Chat"):Chat(v.Character.Head,Chat,Enum.ChatColor.White)
		end)
	end
end
if VRReady then
	VRService:RecenterUserHeadCFrame();
	CurrentCamera.CameraType = "Scriptable";
	CurrentCamera.HeadScale = options.HeadScale;
	CurrentCamera.HeadLocked = true
	game:GetService("StarterGui"):SetCore("VRLaserPointerMode", 0);
	game:GetService("StarterGui"):SetCore("VREnableControllerModels", false);
end
hum.PlatformStand =true
wait()
local torso = Character["Torso"]
local rightarm = Character["Right Arm"]
local leftarm = Character["Left Arm"]
local rightleg = Character:FindFirstChild("Right Leg")
local leftleg = Character:FindFirstChild("Left Leg")
local RUA = Instance.new("Part", Character)
local RLA = Instance.new("Part", Character)
local LUA = Instance.new("Part", Character)
local LLA = Instance.new("Part", Character)
local RH  = Instance.new("Part", Character)
local LH  = Instance.new("Part", Character)
do
	RUA.Name = "RUA [Fake]"; RUA.Size = Vector3.new(1, 2, 1); RUA.CanCollide = false;
	RLA.Name = "RLA [Fake]"; RLA.Size = Vector3.new(1, 2, 1); RLA.CanCollide = false;
	LUA.Name = "LUA [Fake]"; LUA.Size = Vector3.new(1, 2, 1); LUA.CanCollide = false;
	LLA.Name = "LLA [Fake]"; LLA.Size = Vector3.new(1, 2, 1); RUA.CanCollide = false; 
	RH.Name = "RH [Fake]"; RH.Size = Vector3.new(.7,.7,.7); RH.CanCollide = false;
	LH.Name = "LH [Fake]"; LH.Size = Vector3.new(.7,.7,.7); LH.CanCollide = false; 
end
local rightShoulder, RSHOULDER_C0_CACHE = Motor6D(torso, RUA, CFrame.new(1.5,1,0), CFrame.new(0,1,0), "RS");
local rightElbow, RELBOW_C0_CACHE = Motor6D(RUA, RLA, CFrame.new(0,-1,0), CFrame.new(0,1,0), "RE");
local rightWrist = Motor6D(RLA, RH, CFrame.new(0,-0.5,0), CFrame.new(0,0.5,0), "RW");
local leftShoulder, LSHOULDER_C0_CACHE = Motor6D(torso, LUA, CFrame.new(-1.5,1,0), CFrame.new(0,1,0), "LS");
local leftElbow, LELBOW_C0_CACHE = Motor6D(LUA, LLA, CFrame.new(0,-1,0), CFrame.new(0,1,0), "LE");
local leftWrist = Motor6D(LLA, LH, CFrame.new(0,-0.5,0), CFrame.new(0,0.5,0), "LW");
local RUPPER_LENGTH			= math.abs(rightShoulder.C1.Y) + math.abs(rightElbow.C0.Y)
local RLOWER_LENGTH			= math.abs(rightElbow.C1.Y) + math.abs(rightWrist.C0.Y) + math.abs(rightWrist.C1.Y)
local LUPPER_LENGTH			= math.abs(leftShoulder.C1.Y) + math.abs(leftElbow.C0.Y)
local LLOWER_LENGTH			= math.abs(leftElbow.C1.Y) + math.abs(leftWrist.C0.Y) + math.abs(leftWrist.C1.Y)
local fakerightarm, fakeleftarm, RHA, LHA, RgrabWeld, LgrabWeld, RgrabAtt, LgrabAtt do
	fakeleftarm, fakerightarm = Instance.new("Part", Character), Instance.new("Part", Character)
	fakeleftarm.CFrame = lhand.CFrame
	fakeleftarm.Name = "Fake Left"
	fakeleftarm.Size = Vector3.new(1,1,.5)
	fakeleftarm.Transparency = options.FakeHandsTransparency
	fakerightarm.CFrame = rhand.CFrame
	fakerightarm.Name = "Fake Right"
	fakerightarm.Size = Vector3.new(1,1,.5)
	fakerightarm.Transparency = options.FakeHandsTransparency
	local nocol = Utils:NoCollide(fakeleftarm, fakerightarm)
	local Rap = Instance.new("AlignPosition", fakerightarm);
	Rap.RigidityEnabled = false; Rap.ReactionForceEnabled = true; Rap.ApplyAtCenterOfMass = false; Rap.MaxForce = 10000000; Rap.MaxVelocity = math.huge/9e110; Rap.Responsiveness = 75;
	local Rao = Instance.new("AlignOrientation", fakerightarm);
	Rao.RigidityEnabled = false; Rao.ReactionTorqueEnabled = false; Rao.PrimaryAxisOnly = false; Rao.MaxTorque = 10000000; Rao.MaxAngularVelocity = math.huge/9e110; Rao.Responsiveness = 75;
	local Lap = Instance.new("AlignPosition", fakeleftarm);
	Lap.RigidityEnabled = false; Lap.ReactionForceEnabled = true; Lap.ApplyAtCenterOfMass = false; Lap.MaxForce = 10000000; Lap.MaxVelocity = math.huge/9e110; Lap.Responsiveness = 75;
	local Lao = Instance.new("AlignOrientation", fakeleftarm); 
	Lao.RigidityEnabled = false; Lao.ReactionTorqueEnabled = false; Lao.PrimaryAxisOnly = false; Lao.MaxTorque = 10000000; Lao.MaxAngularVelocity = math.huge/9e110; Lao.Responsiveness = 75;
	local Ratt = Instance.new("Attachment", fakerightarm)
	RHA = Instance.new("Attachment", root)
	local Latt = Instance.new("Attachment", fakeleftarm)
	LHA = Instance.new("Attachment", root)
	Rap.Attachment0 = Ratt; Rap.Attachment1 = RHA
	Rao.Attachment0 = Ratt; Rao.Attachment1 = RHA
	Lap.Attachment0 = Latt; Lap.Attachment1 = LHA
	Lao.Attachment0 = Latt; Lao.Attachment1 = LHA
	RgrabWeld = Instance.new("WeldConstraint", fakerightarm); RgrabWeld.Part0 = fakerightarm
	LgrabWeld = Instance.new("WeldConstraint", fakeleftarm); LgrabWeld.Part0 = fakeleftarm 
	RgrabAtt = Instance.new("Attachment", fakerightarm)
	LgrabAtt = Instance.new("Attachment", fakeleftarm)
	fakerightarm.Touched:Connect(function(part)
		if part.CanCollide == true and not part:IsDescendantOf(Character) and part.Parent ~= vrparts then
			HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.RightHand, (fakerightarm.Velocity - part.Velocity).Magnitude / 10)
			wait()
			HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.RightHand, 0)
		end
	end)
	fakeleftarm.Touched:Connect(function(part)
		if part.CanCollide == true and not part:IsDescendantOf(Character) and part.Parent ~= vrparts then
			HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.LeftHand, (fakeleftarm.Velocity - part.Velocity).Magnitude / 10)
			wait()
			HapticService:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.LeftHand, 0)
		end
	end)
end
for _,part in pairs(Character:GetDescendants()) do
	if part:IsA("BasePart") then
		if part ~= root and part ~= fakeleftarm and part ~= fakerightarm then
			local bv = Instance.new("BodyVelocity")
			bv.Velocity = Vector3.new(0,0,0)
			bv.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
			bv.P = 9000
			bv.Parent = part
			for i,v in pairs(Character:GetChildren()) do
				if v:IsA("BasePart") then
					Utils:NoCollide(part, v)
				end
			end
			if part.Name:find("Arm") or part.Name:find("Leg") or part.Name:find("tHand") or part.Name:find("Foot") then
				part.Transparency = 1
				RunService.Stepped:connect(function()
					part.CanCollide = false
				end)
			elseif part == RH or part == LH or part == RLA or part == LLA or part == RUA or part == LUA  then
				part.Transparency = 0.85
			end
		elseif part == fakeleftarm or part == fakerightarm then
			part.Transparency = options.FakeHandsTransparency
			part.CustomPhysicalProperties = PhysicalProperties.new(10, 1000, -100, 100,100)
			part.Massless = false
		else
			part.CustomPhysicalProperties = PhysicalProperties.new(20, 100, 0, 100,100)
			game:GetService("RunService").Stepped:connect(function()
				part.CanCollide = true
			end)
		end
		if part == torso or part.Name == "Head" then
			game:GetService("RunService").Stepped:connect(function()
				part.CanCollide = false
			end)
		end
		if part.Name == "LowerTorso" or part.Name:find("Foot") then
			part:Destroy()
		end
	end
end
CurrentCamera.CFrame = CFrame.new((root.Position - VRService:GetUserCFrame(Enum.UserCFrame.Head).Position * options.HeadScale))
wait(.1)
cframeAlign(torso, header, Vector3.new(0,-.8,0))
cframeAlign(rightleg, RUA, Vector3.new(0,0,0), Vector3.new(0,0,0))
cframeAlign(rightarm, RLA, Vector3.new(0,0,0), Vector3.new(0,-90,0))
cframeAlign(leftleg, LUA, Vector3.new(0,0,0), Vector3.new(0,0,0))
cframeAlign(leftarm, LLA, Vector3.new(0,0,0), Vector3.new(0,-90,0))
fakeleftarm.CFrame = root.CFrame
fakerightarm.CFrame = root.CFrame
local bg = Instance.new("BodyGyro", root); bg.MaxTorque = Vector3.new(17000,17000,17000); bg.P = 17000
local Twist = 0
local Height = .5
local SelectionBox = Instance.new("SelectionBox", workspace)
local SelectedPart
local LgrabPart
local RgrabPart
local Lholding
local Rholding
RunService.Heartbeat:Connect(function()
	local RshoulderCFrame = torso.CFrame * RSHOULDER_C0_CACHE
	local RplaneCF, RshoulderAngle, RelbowAngle = solveIK(RshoulderCFrame, fakerightarm.Position, RUPPER_LENGTH, RLOWER_LENGTH)
	local LshoulderCFrame = torso.CFrame * LSHOULDER_C0_CACHE
	local LplaneCF, LshoulderAngle, LelbowAngle = solveIK(LshoulderCFrame, fakeleftarm.Position, LUPPER_LENGTH, LLOWER_LENGTH)
	rightShoulder.C0 = torso.CFrame:toObjectSpace(RplaneCF) * CFrame.Angles(RshoulderAngle, 0, 0)
	rightElbow.C0 = RELBOW_C0_CACHE * CFrame.Angles(RelbowAngle, 0, 0)
	leftShoulder.C0 = torso.CFrame:toObjectSpace(LplaneCF) * CFrame.Angles(LshoulderAngle, 0, 0)
	leftElbow.C0 = LELBOW_C0_CACHE * CFrame.Angles(LelbowAngle, 0, 0)
end)
RunService.Stepped:Connect(function()
	rightShoulder.Transform = CFrame.new()
	rightElbow.Transform = CFrame.new()
	rightWrist.Transform = CFrame.new()
	leftShoulder.Transform = CFrame.new()
	leftElbow.Transform = CFrame.new()
	leftWrist.Transform = CFrame.new()
end)
RunService.RenderStepped:Connect(function()
	RHA.WorldCFrame = rhand.CFrame
	LHA.WorldCFrame = lhand.CFrame
	hum.PlatformStand = true
	workspace.Gravity = 75
	if root.Position.Y <= -100 then
		root.CFrame = oldCF
	end
	if VRReady then
		local HeadCF = VRService:GetUserCFrame(Enum.UserCFrame.Head);
		local u1 = CFrame.new((root.Position - HeadCF.Position * options.HeadScale) + Vector3.new(0,1.5,0)) * CFrame.Angles(0, math.rad(Twist), 0);
		CurrentCamera.CFrame = (u1 * CFrame.new(0, 0, 0) * CFrame.fromEulerAnglesXYZ(CFrame.new(HeadCF.p * options.HeadScale):ToEulerAnglesXYZ())) --+ Vector3.new(0,Height,0)
		for _,hat in pairs(Character:GetChildren()) do
			if hat:IsA("Accessory") and hat:FindFirstChild("Handle") then hat.Handle.Transparency = 0.5 end
		end
		local selectRay = Ray.new(rhand.Position, -rhand.CFrame.upVector.Unit * options.PointerRange)
		local hit, position, normal	= workspace:FindPartOnRayWithIgnoreList(selectRay, {vrparts, Character})
		if hit and (hit:FindFirstChild("TouchInterest") or hit:FindFirstChildOfClass("ClickDetector")) then
			SelectionBox.Adornee = hit
			SelectedPart = hit
		else
			SelectionBox.Adornee = nil
		end
		local RgrabRay = Ray.new(rhand.Position, -rhand.CFrame.upVector.Unit * 1.3)
		local Rpart, Rposition, Rnormal	= workspace:FindPartOnRayWithIgnoreList(RgrabRay, {vrparts, Character})
		local LgrabRay = Ray.new(lhand.Position, -lhand.CFrame.upVector.Unit * 1.3)
		local Lpart, Rposition, Rnormal	= workspace:FindPartOnRayWithIgnoreList(LgrabRay, {vrparts, Character})
		if Rpart then RgrabPart = Rpart else RgrabPart = nil end
		if Lpart then LgrabPart = Lpart else LgrabPart = nil end
	else
		CurrentCamera.CameraType = "Scriptable"
	end
end)
root:GetPropertyChangedSignal("Position"):Connect(function(pos)
	root.Velocity = Vector3.new(0,0,0)
	fakeleftarm.Velocity = Vector3.new(0,0,0)
	fakerightarm.Velocity = Vector3.new(0,0,0)
	root.Anchored = true
	RgrabWeld.Part1 = nil
	LgrabWeld.Part1 = nil
	torso.CFrame = root.CFrame
	fakeleftarm.CFrame = root.CFrame
	fakerightarm.CFrame = root.CFrame
	wait(2)
	root.Anchored = false
	for i = 1,4 do
		root.Velocity = Vector3.new(0,0,0)
		fakeleftarm.Velocity = Vector3.new(0,0,0)
		fakerightarm.Velocity = Vector3.new(0,0,0)
	end
end)
local turnDB = false
UserInputService.InputChanged:connect(function(key)
	if key.KeyCode == Enum.KeyCode.Thumbstick2 then
		if key.Position.Y > 0.8 then
			Height = Height + .1
		elseif key.Position.Y < -0.8 then
			Height = Height - .1
		end
		if key.Position.X > 0.8 and not turnDB then
			turnDB = true
			Twist = Twist - options.TurnAngle
			wait(options.TurnDelay)
			turnDB = false
		elseif key.Position.X < -0.8 and not turnDB then
			turnDB = true
			Twist = Twist + options.TurnAngle
			wait(options.TurnDelay)
			turnDB = false
		end
	end
end)
UserInputService.InputChanged:connect(function(key)
	if key.KeyCode == Enum.KeyCode.Thumbstick1 then
	end
end)
UserInputService.InputBegan:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		if RgrabPart  then
			if not RgrabPart.Parent:IsA("Accessory") and not RgrabPart.Parent:FindFirstChildOfClass("Humanoid") and (RgrabPart:IsGrounded() or RgrabPart.Anchored) then
				RgrabWeld.Part1 = RgrabPart
				root.Velocity = Vector3.new(0,0,0)
				fakerightarm.Velocity = Vector3.new(0,0,0)
				fakeleftarm.Velocity = Vector3.new(0,0,0)
				root.Massless = true
				fakerightarm.Massless =  true
				fakerightarm.CanCollide = false
			else
				Rholding = RgrabPart
				holdPart(RgrabPart, RgrabAtt)
			end
		end
	elseif key.KeyCode == Enum.KeyCode.ButtonL1 then
		if LgrabPart then
			if not LgrabPart.Parent:IsA("Accessory") and not LgrabPart.Parent:FindFirstChildOfClass("Humanoid") and (LgrabPart:IsGrounded() or LgrabPart.Anchored) then
				LgrabWeld.Part1 = LgrabPart
				root.Velocity = Vector3.new(0,0,0)
				fakerightarm.Velocity = Vector3.new(0,0,0)
				fakeleftarm.Velocity = Vector3.new(0,0,0)
				root.Massless = false
				fakeleftarm.Massless =  true
				fakeleftarm.CanCollide = false
			else
				Lholding = LgrabPart
				holdPart(LgrabPart, LgrabAtt)
			end
		end
	end 
end)
UserInputService.InputEnded:connect(function(key)
	if key.KeyCode == Enum.KeyCode.ButtonR1 then
		RgrabWeld.Part1 = nil
		fakerightarm.Massless =  false
		fakerightarm.CanCollide = true
		if Rholding then
			holdPart(Rholding, nil, true)
		end
	elseif key.KeyCode == Enum.KeyCode.ButtonL1 then
		LgrabWeld.Part1 = nil
		fakeleftarm.Massless =  false
		fakeleftarm.CanCollide = true
		if Lholding then
			holdPart(Lholding, nil, true)
		end
	end 
end)


  
