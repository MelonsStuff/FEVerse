local Reanimate_Settings = {
Frequency = 6, -- this is basically how fast the oscillation goes
Amplification = 6, -- this is how far the oscillation goes
FrontOffset = 2.5, -- this is how much youre in front of the player during prediction
}

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
local ConnectDiedSignalBackend = LocalPlayer.ConnectDiedSignalBackend
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
local OptionsPermanentDeath = nil
local OptionsRefit = nil
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

local Refitting = false

local replicatesignal = replicatesignal

local Rig = nil
local RigHumanoid = nil
local RigHumanoidRootPart = nil

local sethiddenproperty = sethiddenproperty
local setscriptable = setscriptable

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
sethiddenproperty(Descendant, "BackendAccoutrementState", 0)
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
local Position = RigHumanoidRootPart.CFrame.Position

CurrentCamera.CameraSubject = RigHumanoid
Wait(PreRender)
CurrentCamera.CFrame = CameraCFrame + RigHumanoidRootPart.CFrame.Position - Position
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

Options.HighlightObject = HighlightObject
tableinsert(Highlights, HighlightObject)
end

Targets[Target] = Options

if not OptionsDefaultFlingOptions.HatFling and OptionsPermanentDeath and replicatesignal then
replicatesignal(ConnectDiedSignalBackend)
end
end
end
end

local OnCharacterAdded = function(NewCharacter)
if NewCharacter ~= Rig then
tableclear(Aligns)
tableclear(Blacklist)

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
local Timeout = osclock() + Options.Timeout or 1

if HumanoidRootPart then
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
end

HumanoidRootPart.AssemblyAngularVelocity = FlingVelocity
HumanoidRootPart.AssemblyLinearVelocity = FlingVelocity

HumanoidRootPart.CFrame = CFrame.new(Target.Position + Offset) * CFrame.Angles(0, Target.Orientation.Y, 0)
LastPosition = Position
end
end
end

local HighlightObject = Options.HighlightObject

if HighlightObject then
Destroy(HighlightObject)
end

Targets[Target] = nil
end

HumanoidRootPart.AssemblyAngularVelocity = Vector3zero
HumanoidRootPart.AssemblyLinearVelocity = Vector3zero

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

if OptionsPermanentDeath and replicatesignal then
replicatesignal(ConnectDiedSignalBackend)

taskwait(Players.RespawnTime + 0.1)

Refitting = false
replicatesignal(Kill)
else
 
taskwait(OptionsBreakJointsDelay)
end

ModelBreakJoints(Character)

if replicatesignal and OptionsUseServerBreakJoints then
replicatesignal(Humanoid.ServerBreakJoints)
end

ChangeState(Humanoid, Dead)
Wait(Humanoid.Died)

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
RigHumanoidRootPart.CFrame = CFramelookAt(Position, Position + CurrentCamera.CFrame.LookVector * Vector3xzAxis)
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
else
local Frames = Table.Frames or - 1
Frames = Frames + 1
Table.Frames = Frames

if Frames > 15 and OptionsPermanentDeath and OptionsRefit and replicatesignal then
Refitting = false
replicatesignal(ConnectDiedSignalBackend)
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

if OptionsDisableRigCollisions then
for Index, Descendant in next, GetChildren(Rig) do
if IsA(Descendant, "BasePart") then
Descendant.CanCollide = false
end
end
end
end

local Register = function()
repeat
IsRegistered = pcall(SetCore, StarterGui, "ResetButtonCallback", BindableEvent)
taskwait()
until IsRegistered
end

Start = function(Options)
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
OptionsPermanentDeath = Options.PermanentDeath
OptionsRefit = Options.Refit
local OptionsRigSize = Options.RigSize
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
tableinsert(RBXScriptConnections, Connect(BindableEvent.Event, Stop))

Rig = Options.R15 and Clone(R15HumanoidModel) or Clone(HumanoidModel)
Rig.Name = "non"
RigHumanoid = Rig.Humanoid
RigHumanoidRootPart = Rig.HumanoidRootPart
Rig.Parent = Workspace

for Index, Descendant in next, GetDescendants(Rig) do
if IsA(Descendant, "Attachment") then
Attachments[Descendant.Name] = Descendant
elseif IsA(Descendant, "BasePart") or IsA(Descendant, "Decal") then
Descendant.Transparency = OptionsRigTransparency
end
end

if OptionsRigSize then
ScaleTo(Rig, OptionsRigSize)

RigHumanoid.JumpPower = 50
RigHumanoid.WalkSpeed = 16
end

OnCurrentCameraChanged()
tableinsert(RBXScriptConnections, Connect(CurrentCameraChanged, OnCurrentCameraChanged))

if OptionsClickFling then
tableinsert(RBXScriptConnections, Connect(InputBegan, OnInputBegan))
end

local Character = LocalPlayer.Character

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

Stop = function()
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
ChangeState(Humanoid, Dead)
end

Destroy(Rig)

if OptionsPermanentDeath and replicatesignal then
replicatesignal(ConnectDiedSignalBackend)
end

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

local Rad = math.rad

Empyrean = Start({
Accessories = {
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
 -- SB Rig
{ MeshId = "125443585075666", Name = "Torso", Offset = CFrame.Angles(0, 3.15, 0), TextureId = "121023324229475" },
{ MeshId = "121342985816617", Name = "Left Arm", Offset = CFrame.Angles(0, 0, 1.57), TextureId = "129264637819824" },
{ MeshId = "121342985816617", Name = "Right Arm", Offset = CFrame.Angles(0, 3.15, 1.57), TextureId = "129264637819824" },
{ MeshId = "83395427313429", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "97148121718581" },--18641142410
-- Prosthetics
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
{ MeshId = "14768666349", Name = "Torso", Offset = CFrame.Angles(0, 0, 0), TextureId = "14768664565" },
{ MeshId = "14768684979", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14768683674" },
},
ApplyDescription = true,
BreakJointsDelay = 0.255,
ClickFling = true,
DefaultFlingOptions = {
HatFling = false,
Highlight = true,
PredictionFling = true,
Timeout = 1,
ToolFling = false,
},
DisableCharacterCollisions = true,
DisableHealthBar = true,
DisableRigCollisions = true,
HatDrop = false,
HideCharacter = Vector3.new(0, -30, 0),
ParentCharacter = true,
PermanentDeath = true,
Refit = true,
RigSize = 1,
RigTransparency = 1,
R15 = false,
SetCameraSubject = true,
SetCameraType = true,
SetCharacter = false,
SetCollisionGroup = true,
SimulationRadius = 2147483647,
TeleportRadius = 12,
UseServerBreakJoints = true,
})

DefaultFlingOptions = {
HatFling = false,
Highlight = true,
PredictionFling = true,
Timeout = 1,
ToolFling = false,
}
-- WILL NOT WORK IF YOU REMOVE THE REANIMATION.
return(function(...)local D={"\065\050\069\087\106\053\070\109";"\084\049\081\065","\105\112\116\115\110\053\071\108\077\097\057\043\068\116\088\110";"\085\100\071\089\085\053\090\050\048\105\057\082","\106\097\116\088\085\053\083\049";"\119\053\070\088\106\112\069\087\048\105\116\088\085\053\082\054\068\120\061\061";"\075\054\043\077\121\077\061\061";"\090\050\083\118\077\107\109\088\103\118\085\110\119\101\078\073\090\051\061\061","\048\050\089\077\078\072\047\074\048\100\106\103\119\097\089\109\090\051\061\061","\047\097\090\107\115\097\090\076\106\114\071\088\068\105\090\118","\068\101\105\073","\115\107\082\121\105\084\071\048\103\084\088\082\048\050\089\082\048\107\111\061","\106\107\055\069\065\089\080\090\050\102\107\061","\119\047\106\065\083\050\057\117\051\107\112\061";"\114\080\048\075\049\052\061\061","\097\067\056\109\107\120\061\061";"\119\097\076\072\106\077\061\061";"\118\109\072\106\065\051\119\122\108\049\109\121\114\073\087\068\066\083\098\065\087\052\061\061","\121\106\097\118\068\065\050\089\088\077\061\061";"\082\099\108\083\087\073\052\074","\072\088\054\072\084\071\114\112","\115\121\085\083\083\082\047\050\115\101\102\107\081\100\069\074\105\082\101\061","\117\070\122\089\072\119\083\053\066\043\111\061","\073\090\102\088";"\065\053\083\088\068\053\051\061";"\118\072\079\057\101\075\117\088\113\066\068\110\065\120\061\061","\105\066\057\117\076\119\099\115\108\090\081\054\105\052\061\061";"\109\118\080\101\071\075\054\056\076\051\061\061";"\065\083\097\078","\100\120\103\104\051\052\061\061","\068\105\069\107\048\052\061\061","\043\120\061\061";"\079\050\076\090\075\089\108\119\090\076\119\070\113\077\061\061";"\119\074\067\066","\089\082\053\112\055\098\109\120\098\065\065\061";"\114\065\072\107\118\073\076\115\074\084\081\061","\066\055\072\109";"\090\078\088\111";"\087\069\120\077\088\051\061\061";"\065\119\071\083\103\101\078\043\048\050\109\089\115\116\106\109\083\072\120\061";"\103\065\054\086";"\047\053\082\118\081\097\070\087\068\050\090\072\085\052\061\061";"\073\115\107\082\103\107\103\055","\109\051\104\085";"\050\086\089\057\068\086\076\057\081\097\106\106\099\077\078\102";"\113\082\111\072\107\054\105\048\043\087\052\061";"\053\077\069\072\077\121\104\105";"\075\098\076\078\083\087\103\106\116\115\111\053\084\105\065\083\051\057\051\121","\079\088\049\081\049\102\077\061","\055\087\110\117";"\054\070\111\072\084\120\061\061";"\117\069\082\100\070\052\061\061","\080\073\099\107\113\106\090\117\072\107\107\061","\105\043\099\055\071\090\097\085\113\120\061\061";"\047\105\116\089\085\052\061\061","\078\052\061\061";"\090\100\087\049\117\118\111\115\056\083\113\070\043\071\108\097\100\077\048\120\111\120\061\061";"\100\120\108\109\097\054\100\099\074\074\118\057","\115\110\049\054\083\072\072\043\109\073\102\061";"\121\116\070\109\106\121\047\088\085\053\069\067\068\053\103\061","\110\067\120\082\106\066\049\089\110\120\061\061";"\114\114\066\078\050\051\116\113\067\112\050\110";"\121\082\068\090";"\065\050\090\109\068\100\106\082","\083\068\113\057";"\066\118\043\082\102\052\061\061";"\083\050\089\108\106\082\098\076\119\082\103\100\078\112\070\076\047\120\061\061";"\109\051\069\052\097\120\061\061","\066\097\071\068\085\043\098\084\071\075\077\105","\048\050\068\057\057\106\076\088\074\080\067\112","\121\119\113\110\103\077\061\061","\052\076\101\053\103\104\115\120\088\057\106\080","\065\054\049\116\118\120\061\061","\043\072\103\083\103\104\116\114\069\086\112\061";"\050\118\054\048","\120\110\105\067\085\068\055\055";"\047\097\090\107\119\097\071\080\106\105\083\107\065\051\061\061","\056\111\083\066\097\112\070\107\099\078\043\089\111\056\100\108\056\051\061\061";"\083\113\077\077\051\109\049\119\057\107\049\061","\077\105\090\114\090\121\085\103\068\074\083\078\119\114\090\043\090\052\061\061","\047\105\116\051\104\121\071\082\081\105\043\061";"\110\083\111\053\117\082\072\115\074\100\113\111\070\051\061\061";"\089\097\057\100";"\110\081\109\083\118\073\098\107\107\057\101\061";"\056\101\108\109\079\113\083\073\090\055\073\085","\103\097\090\107\090\097\069\111\048\116\083\051\106\105\090\101";"\069\067\115\053\072\120\061\061";"\114\122\070\074\069\105\048\119\114\082\081\115","\121\116\070\111\106\105\043\061","\055\053\089\104\089\052\043\067\053\105\067\100\071\048\078\061","\071\077\069\047\079\102\107\061","\120\114\089\070\073\078\054\082\118\072\049\061";"\048\068\053\053\052\122\077\083\113\068\075\051\112\097\043\061","\065\052\069\086\089\117\116\120\120\067\122\061","\069\073\066\072\089\051\061\061","\118\106\109\116\082\106\115\097\050\111\051\043","\067\065\074\067\070\098\068\113\105\101\111\061","\053\051\117\107\074\052\061\061";"\066\121\079\103\068\052\061\061","\078\102\079\110\097\065\067\108\066\110\083\051\116\051\061\061";"\048\050\070\074\048\116\082\086\083\069\083\048\115\116\085\074\104\101\102\061","\087\116\053\078\056\120\061\061";"\105\100\071\120\047\083\100\067\043\081\085\066\117\105\073\086\115\082\051\061";"\083\097\043\118\115\084\047\087\077\121\047\111\106\103\069\056\077\051\061\061","\076\122\102\054\112\075\101\118\117\118\048\051","\055\113\075\043\085\054\075\049\086\118\110\066","\081\074\099\111\088\112\085\104\069\077\061\061","\068\122\066\115\068\051\061\061","\099\079\069\052\079\066\075\087\117\122\114\097";"\053\088\116\120\081\043\085\115","\111\047\070\087\103\104\052\061";"\115\090\077\114\111\053\109\085\053\056\054\120";"\088\067\074\057\121\065\078\061";"\077\107\106\073\081\105\116\082","\081\083\119\102\084\120\102\061","\081\067\118\098\043\052\061\061","\066\117\122\109\076\052\061\061","\054\099\106\113\089\080\100\104\110\057\072\083\103\052\061\061","\105\050\054\052\083\079\052\061";"\068\053\120\100","\056\087\077\069\108\067\112\066";"\106\050\057\054\068\100\122\061","\047\097\090\107\077\097\088\089\068\053\047\073\106\105\043\061","\054\099\085\085\099\108\080\074\113\047\108\116\098\122\099\113";"\086\104\070\074\084\077\061\061";"\081\097\088\088\065\120\061\061","\121\090\097\110\048\089\053\074\097\115\118\084";"\088\050\070\050\099\051\056\078\118\052\117\066\113\073\107\099\078\075\081\107";"\104\105\089\043\078\082\101\076\103\116\090\067\077\116\089\119\115\120\061\061","\109\055\080\090\087\049\111\104\108\089\048\103\075\074\056\097","\075\101\072\043\070\101\100\119\069\077\061\061","\048\112\077\105\107\113\101\119\121\103\069\080\110\084\119\067\053\075\104\076";"\076\078\052\079\054\120\061\061","\115\112\088\121\105\053\071\106\104\119\103\100\078\119\069\115","\077\075\055\101\047\071\071\050\102\087\054\122\118\088\118\051\100\052\061\061","\090\100\106\106\083\116\089\047\081\100\088\082\090\103\081\051\077\051\061\061","\055\068\078\106\057\120\061\061","\107\120\061\061","\043\065\043\102\079\052\061\061";"\050\054\074\085\115\101\081\061","\103\053\057\088\104\103\069\087\048\105\107\061","\086\098\097\102\090\081\112\056\074\050\111\061";"\073\054\098\102\043\113\101\106\120\077\061\061";"\076\116\110\088\084\090\106\053","\085\122\076\111\110\077\061\061";"\068\119\067\110\116\047\049\061","\054\068\087\070\106\072\065\070\069\116\101\072\116\052\061\061";"\057\051\105\081\109\070\106\112\076\072\112\080\076\081\103\075\116\104\114\055","\084\051\107\054\088\116\089\047\055\089\115\078\098\051\061\061","\072\098\054\118\076\052\061\061","\051\054\067\104\072\120\072\052\109\065\071\087\112\118\079\102\071\118\074\074\055\051\061\061","\083\090\106\097\090\116\071\101\068\116\106\073\105\103\090\077\065\121\077\061";"\048\107\069\056\068\084\106\051\048\050\069\089\104\105\088\069\104\103\051\061";"\051\101\047\099\110\119\121\117\105\068\103\061";"\076\083\067\071\054\081\089\100\087\057\112\061";"\104\074\047\083\047\105\112\097\083\072\106\050\105\105\106\090\090\100\081\061","\051\114\090\121\090\051\061\061";"\087\122\072\070\103\051\061\061";"\082\117\043\106\108\077\061\061";"\085\106\069\071\113\120\061\061","\079\047\072\070\074\102\088\099\052\109\078\112\106\051\061\061";"\114\056\050\065\078\104\122\061","\090\119\106\119\115\069\049\043\106\107\088\103\090\114\098\112";"\090\114\100\087\120\084\065\100\073\074\109\114";"\090\097\069\089\085\052\061\061","\051\085\074\097\052\052\061\061";"\104\070\067\071","\107\097\055\077\103\052\083\072\106\088\101\061";"\089\053\100\048\073\104\084\088\080\077\103\061","\113\119\112\102\121\098\085\052\101\115\090\047","\052\076\075\106\079\086\100\052\111\085\081\061";"\112\089\083\080\076\120\061\061";"\056\114\076\057\086\050\077\102";"\056\075\072\104\072\051\099\057\109\067\065\061","\079\113\121\067\089\052\061\061","\106\097\090\107\081\100\090\118\085\053\070\109\081\121\083\118\106\121\077\061";"\121\106\081\109\069\104\101\072\120\107\110\099","\118\086\080\113\080\077\061\061";"\111\081\122\069";"\069\117\115\100";"\111\103\047\068\116\119\102\050\066\070\089\076","\122\099\105\110","\065\053\047\114\083\090\089\072\105\103\116\080\068\072\069\084\065\051\061\061";"\047\105\076\116\068\077\061\061";"\066\117\051\098";"\047\053\090\050\081\121\090\111\085\112\106\111\048\105\076\114\119\100\098\107\048\105\070\087\065\051\061\061","\049\118\054\117","\090\050\090\072\085\053\070\073\078\051\061\061";"\110\079\051\077\048\049\117\048";"\074\083\105\121\051\068\049\120\047\052\061\061";"\049\077\061\061";"\097\101\049\075\043\052\061\061";"\116\104\112\052\101\097\053\105","\079\076\105\075\106\077\119\079";"\065\105\070\122\048\112\069\081\106\103\088\084\085\101\083\053\047\052\061\061","\103\072\081\051\048\076\118\056\111\080\081\104\098\117\070\071\055\107\048\055","\069\103\113\119\121\106\067\110\089\050\102\061";"\083\102\078\110\117\051\061\061";"\051\106\102\080\106\069\103\048\110\087\120\061";"\085\120\085\071\112\097\043\047\054\047\102\061";"\119\084\112\057\106\107\076\069\077\100\083\050\105\103\122\116\110\090\120\061","\119\115\109\086\090\057\109\104\071\051\061\061";"\068\084\112\061","\083\114\047\103\081\121\047\043\083\072\106\084\047\082\089\073\103\052\061\061";"\115\120\061\061","\109\122\120\068\104\084\077\098\065\119\077\100","\055\048\065\079\076\069\077\061","\088\056\111\066";"\052\101\113\057","\048\121\083\050\048\105\057\082","\065\053\069\089\065\114\078\061","\068\084\122\061";"\053\101\079\118","\103\090\047\078\103\053\085\071\047\118\120\100\119\105\083\108\115\120\061\061";"\103\090\101\076\048\112\090\066\106\069\112\057\105\114\098\072\065\120\061\061","\081\087\043\122","\076\110\077\050","\097\121\121\049\084\079\043\111\099\052\107\061";"\055\084\071\065\115\079\073\080\100\108\049\099\083\098\057\079\068\122\113\119\106\102\067\109\078\049\113\065\068\051\113\084\086\084\112\061";"\103\053\070\089\068\114\047\103\068\107\070\067\048\050\090\072\085\069\083\051\081\105\083\082";"\081\113\100\055\084\050\114\111\104\065\106\116\084\088\076\072\065\070\070\071\118\052\061\061","\119\105\085\119\065\082\071\057\078\072\088\106\083\084\069\054","\108\100\080\084","\122\053\049\053\079\105\081\061","\072\084\106\083","\084\112\053\049\122\076\114\065\087\117\078\061";"\116\108\100\112";"\075\056\079\085\107\102\118\080\119\077\043\090\114\072\099\072";"\057\079\072\113\083\052\118\089\047\098\104\088\088\100\089\119\080\069\073\085\084\051\061\061";"\080\108\114\069\048\057\086\098\053\076\116\065\071\090\102\043\101\120\061\061";"\105\087\077\102\080\089\053\107\104\110\114\105","\077\107\070\098\103\100\049\100\115\101\043\061";"\077\105\047\101\115\121\047\082\068\077\061\061";"\073\106\075\104\106\077\061\061";"\065\102\121\082\056\105\074\089\084\120\061\061","\089\049\110\057\052\080\043\050\077\043\112\061";"\090\066\078\106\076\116\056\082\090\049\048\107\089\074\054\112\086\051\061\061","\102\070\047\100\083\085\074\104";"\067\048\081\122\082\050\073\100\051\076\080\119\118\116\107\061","\116\077\098\056\057\057\097\104\081\119\087\043";"\074\082\087\087\052\087\111\061","\082\055\098\098\112\116\070\122\050\047\067\048\119\082\107\051";"\068\051\065\061","\048\121\098\088\048\121\071\118";"\103\053\057\088\104\090\083\054\085\105\076\101";"\090\053\069\109\065\053\090\073\122\112\047\082\085\053\090\072\085\053\090\101\122\077\061\061";"\090\097\069\089\085\112\106\054\065\101\083\049\048\105\057\101";"\102\108\115\080\114\051\066\118\080\066\043\061";"","\043\069\066\072\099\051\061\061","\103\073\047\071\070\112\051\116\053\049\102\061","\053\087\105\050";"\110\111\087\089\108\051\061\061";"\104\050\070\121\085\118\088\084\105\082\047\099\081\072\090\109\065\101\078\061";"\112\056\101\121\077\052\061\061";"\076\075\073\118";"\105\122\109\054\085\052\057\073\057\083\051\061";"\107\119\089\069";"\047\081\055\107\111\116\105\106","\110\081\066\113\090\050\053\077\053\111\078\061","\115\114\090\101\106\097\090\109\106\105\076\107";"\051\104\122\049\103\120\122\100\083\076\048\122";"\077\108\070\066\071\052\076\071\115\109\081\061";"\077\100\071\082\081\121\047\082","\085\097\070\073\048\100\083\051\081\105\083\082";"\081\113\055\081\110\117\084\048\043\069\081\051","\056\070\068\079\090\067\102\082\109\081\120\061";"\085\053\070\087\085\105\116\067\106\121\122\061";"\080\099\055\047","\088\043\056\097\043\051\061\061","\085\111\055\117","\097\047\090\113\122\075\103\112\076\105\073\066\097\074\104\090\113\107\088\081\043\077\061\061","\053\081\107\076\087\100\056\054\043\055\052\086\119\113\066\099\098\084\079\101\090\097\097\120\090\108\084\066\066\112\087\106\050\051\061\061";"\106\101\078\073\119\105\085\043\083\118\047\089\078\101\116\072\065\097\122\061";"\119\103\106\053\103\114\106\117\106\121\088\056\119\114\082\111\115\050\051\061";"\115\105\097\078\119\054\088\107\056\053\053\090","\049\102\103\076\080\086\070\099\051\073\054\072\089\052\061\061","\101\089\113\075\108\112\119\100\120\043\043\061","\101\048\068\089\081\072\090\088\121\055\106\098\082\115\117\120\078\084\052\072\050\116\122\084\118\056\067\121\071\086\101\110\113\080\082\074\054\070\109\085\103\083\100\076\111\075\120\061","\111\100\122\112","\110\103\076\107\104\074\069\069\105\069\085\107\119\100\106\069";"\085\105\076\051\081\105\083\056";"\082\082\116\069\056\107\065\103";"\081\097\070\087\081\097\069\107","\106\100\083\116\081\120\061\061","\068\052\061\061";"\049\065\067\079";"\084\083\056\077","\115\084\106\050\047\072\069\081\090\084\069\119\110\084\120\057";"\118\068\055\069\055\105\098\119\071\107\115\075\103\104\075\049\076\101\051\086\072\121\107\082\074\122\053\077\057\077\103\067\051\053\101\071\118\119\122\047\112\083\083\086\049\101\111\061","\115\074\047\107\065\112\085\082\085\052\061\061","\106\086\076\105\118\076\112\066\070\103\078\061","\081\107\057\088\047\074\069\056\104\082\106\117\048\069\120\051","\089\114\051\086\102\052\061\061","\074\047\112\077\056\085\120\061","\110\052\061\061";"\050\101\050\099\078\052\061\061","\085\074\082\051\106\105\070\050","\110\102\106\102\075\057\122\110\072\119\049\070\118\051\061\061";"\117\100\067\108\087\102\057\100\108\088\118\120\067\069\113\113\054\066\111\098";"\079\074\051\055\117\122\110\082\109\051\061\061","\071\054\057\090\099\052\061\061","\100\116\066\074\113\087\051\081\081\050\053\078\103\114\071\075\066\073\053\069\078\077\116\119\065\074\067\099\047\099\116\049\115\056\053\055\119\117\051\107\097\120\053\050","\078\118\047\080\104\050\106\049\068\101\071\115\105\105\103\118","\080\076\100\068\078\054\107\069\101\104\079\057";"\067\069\114\110\090\098\074\053\088\112\089\110\101\053\113\081\070\112\106\101\106\109\119\051\043\050\120\048\121\107\073\066\089\116\101\097\043\101\109\118\104\110\085\077\106\085\077\061","\090\077\061\061";"\115\121\083\112\106\121\083\072\106\105\076\101\081\105\076\107\119\097\081\061";"\121\108\121\086\101\114\107\106\114\085\049\090\090\120\061\061","\103\100\047\054\065\052\061\061";"\057\102\049\077\077\118\090\082\110\051\061\061","\083\118\084\104\117\071\103\061","\105\114\085\082\081\105\085\110\110\105\078\051\078\105\088\074\106\112\043\061","\047\107\069\074\085\090\069\043\110\121\082\077\106\100\090\114\068\114\103\061","\049\069\047\105\057\051\061\061","\117\112\083\076\068\103\118\099\047\069\107\061";"\101\077\071\108\101\119\086\072";"\119\084\097\119\084\078\102\081\055\077\112\061","\117\120\069\065\115\067\050\066\115\118\085\056\082\120\061\061";"\078\103\109\086\078\114\106\122\105\090\047\119\047\112\082\067\048\112\102\061","\101\108\053\121\090\051\061\061";"\085\077\081\114\097\088\072\053\072\090\121\099","\097\057\053\074\114\067\065\061","\070\098\067\078\082\055\055\099\109\057\107\061";"\099\114\089\108\087\066\107\090\101\101\067\107\050\066\100\117\085\097\055\090\097\052\061\061","\118\079\108\073\076\070\103\066\099\104\070\115\104\069\069\113\086\116\101\043\097\084\121\087\054\050\101\119";"\104\121\103\087\106\052\061\061","\048\105\070\088\110\119\106\090\078\121\112\073\103\114\090\114\048\120\061\061";"\083\055\109\108\052\067\083\086\121\105\051\061";"\077\100\071\116\065\097\120\061","\115\113\122\108\109\108\043\061";"\078\048\067\105\081\068\119\047\101\120\083\122","\102\110\052\053","\108\078\055\051\086\113\080\089\113\071\084\048\088\077\071\055\118\086\076\053";"\086\120\085\116\048\111\072\109\113\102\121\071\114\069\112\069\069\051\061\061","\099\071\075\089\117\069\075\115\079\065\081\061";"\065\116\085\114\083\107\069\081\090\107\057\043\083\082\069\073\078\090\120\061";"\089\099\087\056\097\048\102\118\101\122\113\055","\057\118\109\102\077\070\116\104\109\049\119\075\098\100\087\053\067\121\104\055\048\076\049\053\048\073\081\101\067\120\102\065";"\107\073\113\067\109\104\048\100\049\057\076\119\068\066\106\122\084\101\120\099","\050\120\053\088\048\052\061\061";"\072\109\075\101\047\068\101\066\118\054\077\061";"\077\097\070\087\068\050\090\072\085\052\061\061","\054\122\078\122\081\081\078\118\066\055\102\066\110\104\076\074\101\083\057\070","\088\108\072\079","\079\072\098\099\097\090\078\111\103\077\061\061";"\117\069\085\112\104\087\073\105\109\086\102\061";"\107\116\111\110\098\119\069\111\066\089\068\057\112\047\051\074\053\110\107\067\079\090\078\098\069\050\079\079\043\052\107\061";"\111\104\051\043\116\068\053\114";"\110\118\084\102\101\117\122\053\105\052\061\061";"\077\106\087\112\070\051\061\061","\107\111\049\102\051\052\061\061","\083\122\108\103\066\084\107\113\109\107\107\061";"\081\097\083\056\078\103\070\066\048\118\106\098\083\105\116\115","\089\055\043\057","\076\072\052\083","\099\114\113\069\048\117\107\061","\097\048\072\071\118\052\083\057\106\118\078\061";"\049\090\077\055","\099\075\047\070\043\117\074\079\070\110\101\061";"\105\103\085\087\083\101\076\089\078\069\052\043\103\114\088\087\104\119\081\061";"\053\112\084\043\111\103\100\066\055\122\074\097\120\075\109\119\075\120\061\061";"\119\072\090\067\081\082\101\051\115\082\085\117\105\090\081\076\081\051\061\061";"\079\103\102\083\084\079\113\075";"\117\106\074\086\118\100\073\085\072\069\103\061","\115\101\109\105\068\053\047\078\068\053\082\069\105\105\070\049\077\097\120\061","\104\053\070\057\105\098\097\066\106\120\061\061","\103\053\057\088\104\077\061\061","\121\117\103\077\082\115\065\097\084\077\089\090\067\109\097\084\076\120\061\061","\103\101\047\121\085\097\088\051\106\119\090\077\078\112\109\112","\105\053\090\069\085\101\083\073\106\053\082\111\104\082\090\098\083\118\122\061","\051\050\118\053\071\120\103\080\074\097\088\089\086\054\075\101\118\119\101\085","\083\090\047\086\047\051\081\089\065\048\076\118\085\057\065\061","\085\053\070\118\085\074\071\089\068\050\065\061","\069\052\061\061","\110\065\076\083\076\116\080\097\065\081\098\117\090\101\110\066\117\077\061\061","\075\106\080\079\071\052\061\061";"\048\087\043\114\104\088\100\113\114\052\086\078\052\074\101\121\055\105\100\069","\080\117\103\086\107\081\112\117","\047\050\082\087\106\112\106\089\065\114\083\107\077\097\088\089\068\053\047\108\106\101\083\111\081\121\083\118";"\106\109\101\120\055\107\074\085","\122\118\049\105","\107\083\067\100\107\051\072\075\102\056\098\074\075\120\061\061","\057\103\057\122\115\108\056\051\089\112\084\043","\056\101\109\090\118\104\086\090\097\112\050\102\104\084\075\084\106\115\111\119\106\110\120\069\048\043\082\110\110\099\075\111\101\103\110\051\075\122\086\089\047\118\077\088";"\069\098\052\115","\099\066\121\118\111\112\052\072","\071\111\090\071\102\099\072\107\113\088\081\061";"\111\102\107\104\066\118\113\114\109\054\076\071";"\073\071\121\114\087\108\074\110\118\080\051\061";"\081\103\070\086\119\097\088\106\090\097\088\098\083\118\098\067\078\051\061\061";"\114\071\101\079\116\121\121\110\068\077\072\067","\070\111\102\075\119\120\061\061","\053\050\111\081\073\119\052\067\119\043\101\061";"\043\089\116\109\114\077\107\061";"\070\106\121\088\117\080\054\088\075\117\113\115\119\070\105\069\111\109\050\077";"\078\097\047\099\104\074\052\043\085\069\082\074\047\112\076\077";"\088\116\119\075\056\099\052\061","\071\084\090\043\066\057\117\111\109\077\061\061";"\085\071\047\097\101\085\056\068","\082\085\111\116";"\114\102\076\083\087\073\098\090\104\121\099\071\069\072\115\109\098\047\081\105";"\077\081\101\069\090\052\061\061","\069\101\098\071";"\081\103\088\069\078\090\085\083\115\084\071\122\048\053\089\057","\056\119\120\061";"\106\119\082\109\048\105\112\076\119\116\083\076\090\119\082\057\077\077\061\061","\081\100\082\106\068\101\069\057\115\119\081\100\078\112\047\069";"\065\105\086\053","\055\081\055\118\073\120\061\061","\056\117\068\079\069\052\061\061","\102\107\067\067\051\121\083\114\122\074\077\061";"\057\076\103\112","\101\097\108\088\085\108\070\056\072\111\100\102\099\051\061\061","\102\055\077\067\119\120\061\061";"\075\111\068\065\107\055\107\108\076\048\056\100\114\051\061\061";"\076\121\068\056\051\103\055\089\075\105\110\119";"\047\115\122\117\102\081\089\100\081\120\087\050\086\100\118\084\056\078\053\121","\117\051\057\107\108\114\087\100\122\047\101\061","\089\112\110\100","\047\053\090\118\085\074\071\054\104\077\061\061";"\068\122\116\057\089\067\049\061","\057\048\070\099\107\116\107\050","\066\082\101\057\112\073\082\122\055\051\061\061";"\098\077\099\075\066\082\065\061";"\110\090\071\111\111\048\074\112\107\113\070\104\089\065\051\049\106\090\077\122","\115\121\083\098","\119\097\111\090\099\111\069\088\074\051\061\061","\077\121\101\116\078\100\085\106\077\082\112\076\103\112\071\047";"\053\055\100\079\089\050\101\066\066\074\074\084\104\074\108\086\073\057\102\079\083\077\061\061","\106\084\052\097\078\112\103\107\048\090\106\106\081\090\069\106";"\106\119\083\081\083\051\061\061","\047\097\090\107\103\097\090\073\085\050\082\072\106\077\061\061";"\065\116\071\043\103\116\106\108","\087\107\121\116\110\075\100\076\043\110\120\061","\084\055\109\081\043\116\049\061";"\065\097\090\107\068\105\090\107\081\121\047\088\081\050\057\082","\051\081\076\112\066\108\072\057\055\077\061\061","\108\065\069\098\050\047\068\081";"\110\120\061\061","\076\104\121\047\043\098\073\051\047\048\083\048\071\051\107\071\077\085\057\051","\069\117\088\099\114\120\061\061","\119\089\090\112\068\052\061\061";"\087\085\066\116\087\052\048\119\049\086\076\119\119\077\061\061","\051\085\052\084\054\066\049\061";"\097\073\069\080\051\051\061\061";"\108\101\113\077\052\051\061\061","\053\073\100\043\047\113\049\061","\106\116\088\116\103\116\077\097\065\119\090\048\106\114\069\105\048\053\101\061";"\100\070\048\110\057\106\117\053\122\104\043\061";"\104\066\057\104\065\120\099\075\106\120\112\061","\074\100\100\049\066\113\115\082","\115\069\081\116";"\051\076\120\086\076\090\117\097\051\072\052\089";"\083\049\052\090\102\076\108\053\114\088\051\105\082\076\101\061","\050\049\089\081\097\052\061\061","\121\116\070\114\081\051\061\061","\071\116\090\043\066\066\068\056\111\052\067\071\070\120\061\061";"\119\074\052\073\068\053\071\117\090\114\106\110\068\119\069\098\068\120\061\061";"\047\050\082\087\106\112\106\089\065\114\083\107\077\097\088\089\068\053\077\061","\077\097\057\054\068\050\103\061";"\088\118\110\071","\106\086\082\075\082\050\052\115\051\075\097\118","\050\072\090\103";"\047\107\088\119\115\084\106\081\115\107\116\043\115\116\103\100","\043\112\047\090\120\113\090\106\090\069\121\049\085\090\111\061";"\115\111\113\082\087\120\061\061";"\051\080\076\120\079\111\118\109";"\116\068\086\075\108\090\122\118\098\103\074\056\106\067\107\086\116\080\120\076";"\115\107\057\073\103\105\106\084\119\050\082\118\078\072\047\074","\073\120\053\106\050\051\061\061","\121\057\099\109\105\105\074\052\074\065\102\061";"\069\110\054\098\088\077\118\076\047\101\043\061","\105\074\101\097\048\082\089\086\065\107\082\047\081\121\090\087","\053\074\050\120\115\111\090\072\097\108\102\061","\106\097\090\107\106\097\090\087\085\120\061\061","\049\050\083\080";"\072\120\061\061","\077\056\047\083\120\098\050\120","\071\073\115\082\056\067\090\053\108\103\118\102\106\099\047\099\070\072\071\098\089\052\061\061","\085\120\076\122\117\047\115\043\081\113\102\061";"\111\070\055\109\105\051\061\061";"\052\057\043\083\100\120\061\061";"\080\101\085\113\114\048\073\081\121\111\102\067\104\048\088\090\055\083\084\049","\113\119\069\055\083\043\090\111\047\071\110\080\080\116\083\090\085\113\049\103\122\109\057\112\069\051\074\082\054\071\097\115\057\054\111\118\115\073\115\054\077\117\076\111\077\051\110\053\057\078\048\105\102\116\119\077\085\072\048\110\089\102\083\117\056\105\107\065\068\116\101\067\120\071\080\053\118\106\111\073\052\083\043\102\100\106\118\113\052\114\051\050\114\074\071\120\083\043\103\084\100\102\082\113\090\071\101\118\105\078\119\087\106\072\121\048\107\087\116\087\088\109\043\061";"\107\072\109\077","\106\105\082\049\085\100\082\047\047\121\089\097\106\121\047\110";"\088\054\112\082\115\088\076\090\100\078\078\118\112\115\077\118\054\106\048\074\088\087\107\120\070\077\061\061","\089\076\089\117","\120\072\043\105\087\113\105\078\081\054\080\051\052\052\061\061","\100\047\120\089\077\067\052\061","\067\057\052\057\070\048\104\112\089\113\067\084","\100\102\077\085\102\056\113\103\117\075\120\075","\055\085\075\070\047\122\103\097\073\079\082\115\100\071\117\068\100\074\065\050\121\049\050\116\069\052\061\061";"\088\048\103\102\074\078\119\108\056\051\061\061";"\107\056\072\117\110\088\074\102\068\118\118\047";"\103\086\085\085\066\101\048\079\105\120\055\073\050\052\088\121\077\112\111\061","\085\076\118\055\052\116\071\081\054\113\116\081\050\109\099\081\073\099\068\073\074\055\088\112\048\047\104\101\057\055\084\066\098\050\107\065\097\114\057\074\107\111\057\110\088\086\085\050\072\072\055\073\112\074\056\087\057\079\043\099\068\050\052\079\080\099\115\054\105\088\101\108\074\099\055\076\106\105\048\116\077\117\097\085\075\087\065\107\074\121\090\105\053\081\098\121\100\084\075\078\054\111\067\110\109\079\084\080\114\071\110\117","\055\055\055\116\069\098\074\071\114\081\049\061";"\078\112\109\077\106\050\106\089\068\050\047\119\085\114\120\073\047\118\081\061";"\114\117\070\119\074\079\084\109\079\120\061\061";"\048\102\099\102";"\090\074\085\082\106\105\076\071\068\050\106\054";"\085\082\089\050\077\119\071\119\077\101\103\076\048\121\088\112\106\103\081\061","\047\053\082\082";"\117\053\086\051\080\082\076\080\078\113\051\061";"\103\097\088\054\085\097\047\054\085\097\043\061","\097\106\098\082\086\111\048\103","\067\110\113\086\073\070\077\086\048\090\043\121\113\081\043\081\052\056\112\052\107\120\061\061","\109\103\071\052","\053\121\118\110";"\097\119\071\069","\049\070\105\090\121\084\077\061","\103\107\104\083\066\110\121\097\113\049\073\057";"\085\108\104\105\049\081\083\119\043\081\105\068\115\116\081\087\073\120\061\061";"\116\050\072\099\106\119\099\051\057\054\078\061";"\106\121\071\073\068\100\122\061","\086\104\081\106\072\100\084\072\050\110\043\061","\065\100\047\073\048\105\076\114";"\117\075\103\087","\119\106\072\085\067\080\107\061","\108\109\098\103\086\071\118\108\076\073\049\098\100\070\111\047";"\103\115\102\111\075\118\086\069\043\117\049\061","\114\075\106\047\118\054\118\086\054\097\100\120\112\052\061\061";"\071\110\099\043\048\108\107\061","\119\100\088\087\085\121\082\049\068\107\088\087\083\069\088\086\065\069\077\061","\103\048\068\109\067\106\104\057\080\120\061\061";"\107\121\110\075\088\112\099\056\087\079\085\121\083\112\101\061","\083\057\099\109\083\048\080\049\098\105\090\122\100\097\053\076\107\120\112\072";"\121\116\070\089\068\050\047\082\104\052\061\061","\055\119\066\085\068\102\057\053\103\065\113\055\047\111\072\099","\111\043\108\077\055\076\104\098\080\079\048\081\117\112\120\043\112\114\086\065";"\085\121\088\051\106\107\070\043\065\105\049\073\090\100\069\048\065\051\061\061";"\077\105\047\080\085\121\083\107\103\100\098\082\106\105\077\061";"\078\055\103\084\078\056\089\052\106\121\122\061";"\057\065\116\078\088\050\076\108\079\073\111\061","\103\119\088\066\106\119\085\088\068\100\090\077\103\116\089\119\078\077\061\061";"\067\117\072\056";"\052\047\087\052\043\068\105\068\101\108\049\061";"\085\053\069\067\068\053\103\061";"\101\113\118\083\072\056\069\115\112\056\065\061","\082\076\084\068\072\115\088\104\066\077\061\061","\097\070\076\076\117\101\113\119\108\077\061\061";"\078\099\057\117\112\085\057\114\080\118\121\108\071\105\057\111\098\077\105\113","\086\117\112\120\049\078\047\057\052\051\102\061","\103\112\083\121\077\050\089\114\115\097\120\051\090\082\103\100","\119\050\111\100\106\107\070\101\077\050\116\116\090\107\089\069\083\097\120\061";"\106\097\069\109\106\077\061\061","\065\097\090\107\106\114\098\118\081\097\069\051","\103\097\090\107\077\097\070\073\106\077\061\061";"\102\071\117\053\072\120\061\061","\075\086\054\110\080\099\119\115\113\086\051\061";"\112\073\069\082";"\105\053\047\071\068\084\069\106\106\107\120\057\090\114\081\118";"\081\049\065\052\098\052\061\061";"\073\072\076\120\051\108\104\048\049\118\075\078\051\051\061\061","\119\053\090\073\065\052\061\061","\082\121\109\099\102\074\088\118\067\122\112\061","\104\074\103\073\048\069\083\107\083\100\052\076\048\097\069\112";"\081\050\072\103\076\118\101\076\118\112\089\055\104\114\067\072\114\055\120\104\117\052\061\061","\119\111\065\118\043\072\051\080\066\052\061\061";"\050\116\088\081\079\119\066\066\118\099\119\086\100\109\053\111\043\114\082\107";"\086\088\087\075\089\097\103\061";"\106\105\106\103\065\100\085\097\103\101\106\105\110\090\083\100\090\097\043\061","\084\079\050\115";"\100\090\085\117\111\114\120\102","\113\087\070\097\102\081\120\101";"\085\053\069\118\048\051\061\061","\047\082\052\120\078\052\087\097\089\107\048\098\053\109\105\055\053\076\067\114","\090\107\047\101\055\103\117\085\088\122\049\061","\048\107\088\114\090\103\070\118\110\090\122\043\048\105\089\056\077\077\061\061";"\056\104\113\043\072\066\056\073\118\098\108\047\050\071\099\076","\066\086\069\054\069\050\054\068\097\076\114\080\079\112\068\087\075\086\051\068\106\052\061\061";"\052\074\109\107\067\107\049\061";"\053\108\075\065\056\113\052\080\111\101\103\061","\069\088\112\073\070\053\086\075\054\089\111\050\051\074\043\070\121\080\086\085","\049\086\119\118\104\120\061\061";"\080\112\056\078\051\086\078\051","\066\119\114\057\049\071\074\116\055\120\061\061","\077\114\071\116\085\053\069\111\090\100\071\088\085\053\120\061","\065\069\083\053\104\105\116\069\078\105\111\116\083\119\083\108","\082\085\110\112\111\076\120\061";"\075\102\089\065\114\120\061\061";"\090\069\089\105\083\097\076\116\090\074\106\098\048\118\090\067";"\116\098\075\099";"\070\105\074\078\067\100\110\084\102\070\079\105";"\121\102\109\077\065\056\112\061","\099\067\080\084";"\105\082\077\083";"\114\105\080\056\079\051\061\061";"\115\109\098\078";"\066\108\054\115\082\051\061\061","\115\105\076\118\085\053\069\087\081\097\103\061";"\070\119\122\088\052\084\098\121","\090\053\088\076\047\105\076\101\115\121\083\110\068\100\065\061";"\109\056\122\071\085\119\111\061","\052\047\085\083\084\050\056\105\099\107\106\069\057\086\100\087\108\066\082\068";"\104\112\082\107\048\053\120\061";"\055\083\087\118","\078\052\047\100";"\075\088\089\053\100\122\089\049\072\120\061\061","\077\110\098\074\097\050\053\078\107\102\119\117","\055\081\080\077\086\120\061\061";"\087\098\079\088\099\108\072\067\120\097\102\072\065\122\069\047\057\109\090\083\085\051\061\061","\082\106\089\110\089\107\119\101\099\114\055\054\068\078\111\050\105\048\107\065\079\054\102\097\119\120\061\061";"\107\071\073\106\104\105\043\115\053\088\102\061","\121\088\102\121\043\068\116\107\056\106\102\043","\114\073\100\102\115\053\070\116\043\120\061\061","\114\112\067\043\103\080\078\085\074\081\053\116";"\056\113\100\086","\047\090\088\071\119\103\071\119\047\101\102\051\081\082\088\069";"\047\050\082\073\106\077\061\061";"\105\082\121\105";"\085\083\082\102\085\112\051\104";"\120\097\110\056\122\107\074\055\118\116\053\108";"\082\071\104\076\070\051\061\061";"\069\047\084\097\110\097\100\072\077\115\081\061","\101\108\116\074\112\050\103\049\100\053\068\087";"\053\087\051\111\118\053\049\051\085\089\077\061","\048\084\082\100\077\105\090\118\115\053\082\077\047\121\069\078\083\100\052\061","\074\049\102\070\108\052\061\061","\084\043\086\099\080\076\080\119\065\076\053\078","\053\105\111\073\107\107\097\105","\106\074\065\061","\079\090\052\104\098\080\068\050\110\075\081\061","\049\097\065\113","\103\097\090\107\103\050\070\054\085\069\098\088\065\114\047\098\068\050\083\049\068\100\122\061","\088\053\085\043\080\074\098\088\121\102\055\072\084\051\061\061","\119\119\071\077\105\050\089\051\077\101\070\101\081\101\107\043\119\072\120\061","\054\051\061\061";"\087\049\115\069\073\067\107\067";"\085\097\121\050\083\076\116\081\075\082\081\061","\103\100\047\054\065\112\069\087\048\105\107\061";"\120\110\090\055\099\072\065\115\085\084\107\061";"\087\090\106\114\043\101\054\050\100\085\089\097\113\077\061\061","\065\074\071\089\068\114\077\061";"\120\051\074\099\111\118\087\072\081\052\061\061","\053\069\048\084\057\051\061\061","\105\114\122\116\104\050\070\048\119\121\082\048\068\050\069\067\103\118\122\061";"\103\048\115\086\090\077\061\061";"\111\101\070\066\118\077\061\061";"\073\108\107\076\086\077\061\061";"\104\111\098\049\097\077\061\061","\047\097\090\107\047\053\090\118\081\097\090\087\106\053\069\087\085\074\078\061";"\105\112\083\067\065\112\076\072\103\084\106\090\115\090\047\054\047\114\112\061","\085\088\088\072\067\099\050\098";"\078\065\052\067\088\052\061\061","\068\107\090\088\077\105\065\118\110\112\103\097\090\050\070\105\104\052\061\061","\043\054\099\073\109\116\074\054\057\107\110\043\102\051\120\106\084\087\102\109\114\065\099\087\120\077\061\061";"\101\043\100\067\055\082\085\077\084\052\107\088","\088\048\102\116\115\048\086\111","\086\114\056\121\047\077\075\115\086\077\061\061","\071\104\072\112\068\086\080\057\070\099\075\100";"\072\102\049\103\116\122\053\074\109\099\052\110\043\107\083\106\053\112\077\083\049\051\061\061";"\082\073\074\054\077\115\099\088\068\071\049\061","\076\078\055\086\070\052\061\061","\088\081\047\050\065\119\090\088\057\051\061\061","\117\068\099\100\073\110\056\074\117\107\103\061";"\070\114\120\101\069\068\078\076\065\076\066\067","\084\075\056\122\057\120\061\061","\119\074\090\087\106\097\090\053\068\100\085\088\065\050\077\061","\114\079\084\115\109\090\088\075\077\047\112\061","\111\081\053\077\068\052\061\061","\069\108\048\048\051\102\053\057\110\065\119\047\055\110\120\056","\114\108\117\052\111\066\115\089\120\073\122\061";"\067\104\083\084\099\047\101\061";"\054\086\106\122\104\085\052\061";"\051\078\103\082\109\103\104\083\106\111\077\076\079\052\061\061";"\047\050\082\087\106\069\098\088\065\114\047\108\068\082\071\088\104\077\061\061","\108\108\084\079\065\111\085\067";"\102\047\115\086\076\089\099\118\067\057\110\098\082\113\113\076";"\054\098\054\108\071\069\113\054\085\071\053\068\051\104\055\066\054\066\057\050";"\103\050\069\076","\047\054\065\109\066\114\053\110";"\110\121\121\085";"\072\071\049\072\086\073\103\061";"\066\079\101\108\068\069\115\053\052\080\088\078";"\085\103\100\053\055\080\077\088\076\081\047\077\080\049\120\089\118\106\114\051\047\077\061\061";"\068\053\090\087","\117\051\106\120\074\078\122\043\114\116\052\061";"\081\084\079\077\111\115\043\050","\081\114\082\107\106\077\061\061","\116\072\053\108\068\121\070\117\073\101\101\114\114\052\061\061";"\077\116\100\076";"\047\108\109\057\097\069\067\077\106\051\061\061","\052\067\074\075\056\085\099\054";"\109\117\056\080\088\101\075\066\120\113\076\078\075\052\086\051","\086\070\068\098\076\052\048\071\121\119\065\086\081\120\061\061"}local function v(v)return D[v-(-285451+289323)]end for v,Y in ipairs({{-844183-(-844184),-844536-(-845224)};{390991+-390990,398845+-398793},{-79780-(-79833),-260177+260865}})do while Y[-880766-(-880767)]<Y[-736225+736227]do D[Y[508131-508130]],D[Y[373189-373187]],Y[755485+-755484],Y[300676-300674]=D[Y[-459929+459931]],D[Y[964420-964419]],Y[406354+-406353]+(688708+-688707),Y[-979482+979484]-(-358035+358036)end end do local v=table.concat local Y=type local d=string.len local P=D local t=string.sub local Q=string.char local k={o=-223969-(-224013),["\055"]=-504644+504707,L=964935-964878,U=652340-652311,x=-385156+385188;c=-130082-(-130093),["\048"]=-291801-(-291827),["\047"]=522509+-522492;["\053"]=-250484-(-250490);Y=-974822+974863,["\049"]=-253369-(-253409),j=799348+-799323;y=266650+-266627,a=277608+-277554,N=-882494-(-882506),A=754542+-754514;k=-460171+460223;I=-422144-(-422194),["\051"]=-374568+374616;l=148087+-148072,m=-358352+358397,q=-779365-(-779424);u=671835-671825;F=-242873-(-242934),Q=168557+-168533;W=482750+-482704,["\056"]=-811850-(-811893);z=48544+-48536,n=6676+-6662,["\052"]=-649312-(-649312),H=-109880-(-109915),["\057"]=-159071-(-159120);h=-619314+619344,p=428378+-428374;["\054"]=-123356+123403;d=-548301-(-548356);J=165572+-165565,C=326772+-326738,R=789753+-789716,v=302898+-302847,f=-356168+356228,["\050"]=-434078-(-434116);T=384632+-384629;X=-235144+235177,w=924328+-924309;P=-911965-(-912007),i=-729986+730008;s=313289+-313271;e=-613903-(-613939),b=698456-698455;M=872681-872665;t=752174+-752121,g=812300-812280,O=446493+-446431;["\043"]=-68389+68445;r=-772438+772477;Z=-170446+170467,G=-106401+106410,S=127969+-127956;D=995745+-995718,E=-370742-(-370747);V=229400+-229342,K=841227+-841196,B=559652-559650}local g=table.insert local e=math.floor for D=420688+-420687,#P,-995612-(-995613)do local x=P[D]if Y(x)=="\115\116\114\105\110\103"then local Y=d(x)local h={}local K=-262125-(-262126)local q=-19843-(-19843)local o=955268-955268 while K<=Y do local D=t(x,K,K)local v=k[D]if v then q=q+v*(-226115-(-226179))^((811459+-811456)-o)o=o+(891463-891462)if o==-918164+918168 then o=-392830-(-392830)local D=e(q/(-490353-(-555889)))local v=e((q%(967356+-901820))/(1027122-1026866))local Y=q%(735502-735246)g(h,Q(D,v,Y))q=-688704-(-688704)end elseif D=="\061"then g(h,Q(e(q/(413879+-348343))))if K>=Y or t(x,K+(-110604-(-110605)),K+(-149581-(-149582)))~="\061"then g(h,Q(e((q%(466977-401441))/(158818-158562))))end break end K=K+(451365-451364)end P[D]=v(h)end end end return(function(D,d,P,t,Q,k,g,L,j,y,R,M,o,Y,w,N,V,I,e,q,x,K,h,H)w,y,H,R,Y,j,V,N,h,L,x,K,o,e,M,q,I=function(D,v)local d=q(v)local P=function(P,t,Q,k,g)return Y(D,{P;t;Q,k;g},v,d)end return P end,function(D)x[D]=x[D]-(467038-467037)if-778665+778665==x[D]then x[D],e[D]=nil,nil end end,function(D,v)local d=q(v)local P=function(P,t,Q)return Y(D,{P;t;Q},v,d)end return P end,function(D,v)local d=q(v)local P=function()return Y(D,{},v,d)end return P end,function(Y,P,t,Q)local gq,Lq,C,a,Yq,N,l,U,Dq,hq,tq,Mq,xq,K,Z,i,Pq,z,p,yq,x,W,Hq,X,A,Sq,jq,E,vq,G,eq,kq,Rq,o,g,s,f,Nq,m,F,T,q,O,B,c,Vq,qq,r,Qq,J,Kq,Iq,b,u,S,dq,wq,Tq,n,oq while Y do if Y<619446+7995679 then if Y<3543660-(-598489)then if Y<2685479-589997 then if Y<1007608-(-41411)then if Y<35603-(-474216)then if Y<207961-(-97272)then if Y<-366717-(-563754)then if Y<687082+-601511 then if Y<184966+-114479 then T=-613272+613273 Y=v(388877+-384898)Y=S[Y]Y=Y(S,T)Y=-852480+15778276 else K=e[t[-679528+679529]]S=-372162+19601712730473 N=v(-605272-(-609354))x=P[-742706-(-742707)]q=e[t[476024+-476022]]o=q(N,S)g=K[o]Y=x==g Y=Y and 7975156-900410 or 11958844-(-889146)end else if Y<-394905+547334 then O=v(916472+-911915)g=false e[t[-41292-(-41303)]]=g S=false T=false Z=v(147414-143297)e[t[609776+-609764]]=S e[t[-985610+985623]]=T X=D[O]J=e[t[49553+-49546]]l=23773780057702-(-52440)A=e[t[-605461+605469]]a=e[t[321165-321163]]z=e[t[-557528-(-557531)]]C=z(Z,l)u=a[C]m=A[u]O=X(J,m)O=v(693239-688682)Z=v(596211-592335)l=30163466878974-(-718559)X=D[O]J=e[t[865920+-865913]]A=e[t[-966363-(-966371)]]a=e[t[-357862-(-357864)]]z=e[t[180460+-180457]]C=z(Z,l)u=a[C]m=A[u]O=X(J,m)O=v(191363+-186806)X=D[O]J=e[t[874662+-874655]]A=e[t[-80829+80837]]a=e[t[298030-298028]]l=-141083+11539161119768 Z=v(888913-884373)z=e[t[224016-224013]]C=z(Z,l)Z=v(208942-205003)u=a[C]m=A[u]O=X(J,m)O=v(789325-784768)X=D[O]J=e[t[844183-844176]]l=2471831552935-687912 A=e[t[337429-337421]]a=e[t[-896656-(-896658)]]z=e[t[428808-428805]]C=z(Z,l)Y=-592771+13938754 u=a[C]m=A[u]O=X(J,m)else T=731485+-731480 Y=v(743198+-739219)Y=S[Y]Y=Y(S,T)Y=1384377-386743 end end else if Y<553761-267270 then if Y<709127-454189 then r=e[t[21769-21758]]c=false E=r==c Y=E and 17099331-486790 or 4451463-983801 else N=q Y=v(-774468-(-778819))X=e[t[-761471+761472]]Y=S[Y]O=e[t[75141+-75139]]A=934420+15128913434992 m=v(464605-460112)J=O(m,A)T=X[J]Y=Y(S,T)Y=Y and-270743+14031852 or 1638962-(-613541)end else if Y<153258+143584 then T=508602+1097759031109 S=v(-222724-(-226714))q=e[t[-491651-(-491652)]]o=e[t[572646-572644]]N=o(S,T)K=q[N]Y=x==K Y=Y and 10347710-(-488269)or 9505891-387792 else g=O Y=J Y=O and-835520+15270369 or-189847+6031784 end end end else if Y<1047635+-682727 then if Y<467532-127070 then if Y<140817-(-168180)then K=e[t[131996-131993]]q=701087-701086 x=K~=q Y=x and-500283+13179811 or-529063+11192183 else Y=X X=-926348+926348.5 S=T or X l=v(1004271+-1000155)C=v(-899740+903839)T=e[t[-609593+609600]]J=e[t[-1010597+1010599]]u=e[t[629638-629635]]a=e[t[-531771-(-531775)]]Z=-988188+18037833151723 z=a(C,Z)A=u[z]m=N[A]O=J[m]W=14928823390952-(-378943)A=e[t[-854800-(-854808)]]z=e[t[-857734-(-857737)]]C=e[t[248983-248979]]Z=C(l,W)a=z[Z]u=N[a]m=A[u]a=e[t[-752959-(-752962)]]Z=v(533682+-529335)z=e[t[949344-949340]]l=-602151+29918523958930 C=z(Z,l)u=a[C]A=N[u]Z=21235495543478-(-754666)J=m*A C=v(832788+-828625)u=e[t[911418-911415]]a=e[t[-547425-(-547429)]]z=a(C,Z)l=-1021191+7092516528621 A=u[z]Z=v(1028825-1024325)Y=138286+9138128 m=N[A]a=e[t[926707+-926704]]z=e[t[592101+-592097]]C=z(Z,l)u=a[C]A=N[u]u=e[t[-384078-(-384087)]]X=T(O,J,S,m,A,u)S=nil end else if Y<993279-643976 then Y=true g={}e[t[-412080-(-412082)]]=Y Y=D[v(-455531-(-459677))]else r=Y s=443414-443413 c=o>s E=c Y=c and 14477226-768495 or 11763772-464548 end end else if Y<1101341-622468 then if Y<182398+275101 then u=nil Y=856426+94623 a=nil else Y=-708535+8736328 N=nil S=nil end else if Y<509246-1454 then x=P[259341+-259340]S=22635946563919-(-823261)K=e[t[-77752+77753]]q=e[t[-592114-(-592116)]]N=v(82528-78334)o=q(N,S)g=K[o]Y=x==g Y=Y and-669612+16863237 or 7498788-3298 else x=P[-203705-(-203706)]S=-554111+25056144925202 K=e[t[-657440+657441]]q=e[t[-210728-(-210730)]]N=v(-977533-(-981695))o=q(N,S)g=K[o]Y=x==g Y=Y and 10359916-(-395665)or 336215+11965620 end end end end else if Y<-31106-(-859819)then if Y<269947+326386 then if Y<521223-(-13751)then if Y<317087+203458 then Y=K g=x Y=-393932+8141322 else T=v(-42665-(-46939))o=e[t[-987214-(-987215)]]X=-846918+34679714655067 J=v(-748449-(-752874))N=e[t[800857+-800855]]S=N(T,X)q=o[S]g=x[q]S=v(187231+-183123)N=D[S]T=e[t[367360-367359]]X=e[t[86162+-86160]]m=28082537457877-(-1018431)O=X(J,m)S=T[O]O=v(783171+-779182)o=N[S]S=e[t[317164+-317163]]T=e[t[-50184-(-50186)]]J=-68596+34873305287523 X=T(O,J)N=S[X]q=o[N]Y=g==q Y=Y and 2046354-(-853214)or 7882723-(-81489)end else if Y<1341594-778390 then S=v(-190172-(-194219))g=v(-170998+175167)Y=D[g]K=157935+18694597567 g=Y(K)g=v(143500-139365)Y=D[g]o=e[t[411299+-411296]]S=o[S]N={S(o)}o={Y(d(N))}g=o[-420542-(-420543)]K=o[291319-291317]Y=-335509+9699781 q=o[-989655-(-989658)]o=g else x=nil g={}Y=D[v(478141+-473633)]end end else if Y<1278115-571158 then if Y<618244+66578 then S=nil Y=-927201+10181536 N=nil else N=v(960161+-955710)Y=e[t[-222669-(-222670)]]K=e[t[-813433+813435]]x=P[964359+-964358]S=231884+15341023253019 x=nil q=e[t[235346-235343]]o=q(N,S)g=K[o]K=true Y[g]=K g={}Y=D[v(-1027019+1031408)]end else if Y<62323-(-651552)then m=v(-593362+597551)b=v(-712077+715978)a=v(268281-264372)W=762785+11839763591656 J=D[m]p=-725769+14795952500210 Y=14653661-948823 r=-311375+9778659070488 u=D[a]l=v(537791-533278)m=v(-423413+427318)z=e[t[-885373+885378]]C=e[t[-308093+308099]]E=v(-867008+871336)Z=C(l,W)a=z[Z]A=u[a]z=e[t[-274009+274020]]Z=e[t[560000+-559995]]l=e[t[-330084+330090]]W=l(b,p)C=Z[W]a=z[C]W=v(147972+-143934)s=-597556+19975683293833 l=D[W]b=e[t[715887+-715882]]p=e[t[-783756-(-783762)]]U=p(E,r)W=b[U]Z=l[W]b=e[t[-768433-(-768444)]]U=e[t[-562332-(-562337)]]c=v(-531160+535701)E=e[t[-432893+432899]]r=E(c,s)Dq=v(650254-645795)p=U[r]i=19571792963127-(-736610)W=b[p]U=e[t[-85511+85522]]F=19314331935347-(-557230)r=e[t[-754482-(-754487)]]c=e[t[-873420+873426]]s=c(Dq,i)E=r[s]p=U[E]i=v(116341-112209)r=v(-1039646+1043758)E=D[r]c=e[t[989118-989113]]s=e[t[-785107+785113]]Dq=s(i,F)r=c[Dq]c=-868786+868785 s=-544323-(-544323)U=E[r]r=-107743+107743 E=U(r,c,s)b=p+E l=Z(W,b)m=J[m]E=31199794844571-(-9509)U=v(-827744-(-831977))W=e[t[42632+-42627]]b=e[t[677914+-677908]]p=b(U,E)Z=W[p]C=l[Z]Z=21870+-21866 z=C*Z u=A(a,z)A=e[t[460697+-460694]]m=m(J,u,A)X=m else X=y(X)O=y(O)T=nil N=nil Y=4800967-796066 end end end else if Y<-746201+1736178 then if Y<675833+204935 then if Y<-279400+1117348 then Y=T Y=S and 7950154-513882 or-302342+9210447 else Y=m Y=J and 11756876-(-1041455)or 937480+9952393 end else if Y<-201765+1165015 then m,a=A(J,m)Y=m and 121246+8713350 or 12029349-(-164976)else Y=g and 14761530-(-873735)or 397052+8147141 end end else if Y<1563210-518454 then if Y<555539-(-460339)then S=nil N=nil T=v(566355+-562458)Y=D[T]T=Y()Y=9868143-503871 else T=v(793302+-789255)K=v(-609451+613586)Y=D[K]N=e[t[-674536-(-674539)]]T=N[T]S={T(N)}N={Y(d(S))}o=N[-982108-(-982111)]q=N[-859688+859690]K=N[-93061+93062]Y=3505364-(-568115)end else Y=T X=328976+-328796 x=nil T=606319+-606318 g={}K=nil N=o(S,T,X)Y[q]=N Y=D[v(-802508-(-806499))]end end end end else if Y<-59898+1699999 then if Y<254033+1069068 then if Y<1806214-582014 then if Y<756274+323234 then if Y<405150+664364 then Y=D[v(-839542-(-843426))]g={}else X=false e[t[601728+-601716]]=X O=true A=v(-861083-(-865148))b=v(-41512-(-45763))J=false e[t[-222451+222464]]=O e[t[-497369-(-497383)]]=J m=D[A]u=e[t[364652-364649]]p=3230604127728-714768 z=e[t[350125+-350121]]Z=e[t[-764402-(-764407)]]l=e[t[-526053-(-526059)]]W=l(b,p)C=Z[W]a=z[C]Y=6443157-(-943150)z=-381039+381040 A=m(u,a,z)end else if Y<-350410+1539748 then q=nil Y=D[v(-783789-(-787793))]g={}N=nil K=nil S=nil o=nil else q=18695181900-419508 K=v(916126+-911957)Y=D[K]K=Y(q)Y=1008498+5379689 end end else if Y<1136927-(-129360)then if Y<187242+1048786 then N=e[t[768877+-768876]]X=v(829217-824732)O=2711187245248-(-801838)S=e[t[-483479-(-483481)]]T=S(X,O)o=N[T]T=v(247358+-243250)m=v(484604-480379)q=x[o]S=D[T]A=203500+29722449582884 X=e[t[644369-644368]]O=e[t[-335719+335721]]J=O(m,A)m=19479478196650-226876 T=X[J]N=S[T]T=e[t[1034239-1034238]]J=v(999530+-995190)X=e[t[-144124-(-144126)]]O=X(J,m)S=T[O]Y=5374393-(-924665)o=N[S]K=q==o g=K else Y=v(856021-852042)T=-105352+105357 Y=S[Y]Y=Y(S,T)Y=-275167+9431479 end else if Y<442131+834614 then Y={}e[t[842471-842469]]=Y g=e[t[847225+-847222]]N=-966798+35184373055630 o=g g=K%N X=v(-738184-(-742627))e[t[55787-55783]]=g T=150863+-150608 S=K%T J=-616950+616951 T=-290563+290565 N=S+T e[t[-889184+889189]]=N T=D[X]m=J X=v(-641676+645591)S=T[X]T=S(x)S=v(600066+-595893)q[K]=S S=-864443-(-864632)X=986562-986561 O=T J=-1004432-(-1004432)A=m<J J=X-m Y=11469241-62901 else O=-859199+28292443770805 X=v(-209782+213764)q=e[t[526524+-526523]]N=e[t[230098+-230096]]x=P[-74156-(-74157)]S=e[t[-591999-(-592002)]]T=S(X,O)o=N[T]K=q[o]Y=K and 1279275-(-136513)or 6869841-404572 g=K end end end else if Y<1622349-195149 then if Y<2150386-733829 then if Y<1855286-485834 then T=v(641699+-637193)X=481014+9964110904105 Y=e[t[464514+-464511]]g={}o=e[t[-316367+316368]]J=v(335742+-331678)N=e[t[287491-287489]]S=N(T,X)q=o[S]S=v(683489+-679534)N=D[S]T=e[t[-113315-(-113316)]]m=1022213+6046132154874 X=e[t[-75683+75685]]O=X(J,m)S=T[O]O=190134+3928863432815 T=Y o=N[S]X=-653159+653339 S=K or X T=595909+-595908 X=801341-801161 N=o(S,T,X)Y[q]=N q=e[t[-715204+715207]]X=v(-189492-(-193762))N=e[t[320029+-320028]]S=e[t[523080+-523078]]T=S(X,O)X=v(141345+-137333)o=N[T]N=false q[o]=N O=34911936587701-(-513996)q=e[t[1028274-1028271]]N=e[t[-388754+388755]]S=e[t[-796172-(-796174)]]T=S(X,O)o=N[T]O=v(196164-191653)N=true q[o]=N N=v(1021663-1017171)o=D[N]J=3087264134734-(-1036111)S=e[t[-475214+475215]]T=e[t[518625+-518623]]X=T(O,J)N=S[X]q=o[N]N=H(185856+2147286,{t[963568+-963565];t[687567+-687566],t[-653187+653189],t[814726+-814722]})O=v(68720-64305)o=q(N)J=-46513+26351042373023 N=v(815791-811299)Y=D[v(-902097-(-906392))]o=D[N]S=e[t[-993669-(-993670)]]x=nil T=e[t[3840+-3838]]X=T(O,J)N=S[X]q=o[N]N=w(-283302+16714132,{t[354516+-354513];t[396200+-396199],t[503085-503083],t[-992427-(-992431)];t[739503+-739498];t[-58269+58275],t[203110+-203103];t[459033+-459025],t[-1046148+1046157];t[939226+-939216];t[637829+-637818];t[282065-282053]})o=q(N)K=nil else S=e[t[-314253+314254]]X=e[t[274318-274316]]O=e[t[324530+-324527]]q=Y m=v(274567-270615)A=579650+5685291315733 J=O(m,A)T=X[J]N=S[T]o=not N K=o Y=o and 902925+12497871 or 541313+14465393 end else if Y<45591+1374011 then o,S=K(q,o)Y=o and 10297406-(-555336)or 515448+3580006 else N,X=S(o,N)Y=N and 4728028-468301 or 16307022-(-441270)end end else if Y<1241091-(-354617)then if Y<219420+1253553 then T=-794711+794712 Y=v(-455004-(-458983))Y=S[Y]Y=Y(S,T)Y=14139456-947878 else U=6068710295124-(-558261)p=v(870965+-866525)C=e[t[754042-754030]]l=e[t[-658614+658618]]A=Y W=e[t[743053-743048]]b=W(p,U)Z=l[b]p=-586136+26468119732669 z=C[Z]Z=e[t[-921093-(-921097)]]b=v(76528-72090)l=e[t[295469+-295464]]W=l(b,p)C=Z[W]a=z[C]z=-253021-(-253022)u=a>z Y=u and 13324117-(-128885)or 14915194-889592 m=u end else if Y<-597751+2199611 then q,S=o(K,q)Y=q and 15643248-(-325937)or 9546141-(-723898)else Y=e[t[661434+-661427]]Y=Y and-768555+15876249 or 948268+11933495 end end end end else if Y<811708+1017035 then if Y<2780010-1025424 then if Y<1656379-(-90150)then if Y<1356036-(-343617)then Y=O q=Y J=X K=J Y=828369+2771022 else q,S=o(K,q)Y=q and-57685+11302955 or 13751980-(-318708)end else if Y<747610-(-1006045)then N=24259409310027-967979 Y=e[t[359766+-359765]]x=e[t[7087-7085]]o=v(195524-191014)K=e[t[753643+-753640]]q=K(o,N)g=x[q]x=false Y[g]=x Y=D[v(77504-73210)]g={}else o,S=K(q,o)Y=o and 5452264-(-647324)or-827577+11371753 end end else if Y<1177755-(-609324)then if Y<793518+971474 then g=x Y=K Y=5024393-(-618134)else g=v(976839+-972647)Y=D[g]X=v(656121-652172)o=v(-359602+363900)O=M(334603+7534596,{})x=e[t[-433436-(-433440)]]q=D[o]T=D[X]X={T(O)}S={d(X)}T=-512984+512986 N=S[T]o=q(N)q=v(136607-132622)K=x(o,q)x={K()}g=Y(d(x))K=e[t[-338264-(-338269)]]Y=K and-637884+9696436 or 14129370-965608 x=g g=K end else if Y<-708573+2511505 then Y=e[t[708108+-708107]]g=v(-330863-(-334829))g=Y[g]g=g(Y)Y=nil e[t[-509600-(-509601)]]=Y Y=-700956+11047732 else K=-1022049-(-1022074)g=v(-149059+153069)Y=D[g]g=Y(K)Y=853619+15794480 end end end else if Y<1807834-(-108529)then if Y<-97187+1972915 then if Y<1370227-(-495318)then J=false Y=-243306+5510767 O=e[t[184578+-184572]]X=O==J S=X else g=v(483820-479651)K=159848+8595823407 Y=D[g]g=Y(K)g=v(-290096-(-293993))Y=D[g]g=Y()S=v(-112597+116644)g=v(588571-584436)Y=D[g]o=e[t[946916+-946913]]S=o[S]N={S(o)}o={Y(d(N))}q=o[-232327-(-232330)]g=o[-85595-(-85596)]K=o[633638-633636]o=g Y=6605161-(-315429)end else if Y<851133+1026311 then Y=g and 237301+4632693 or-49526+6834004 else S=g T=v(134907-130952)g=D[T]T=v(-1041062+1044987)X=v(859991+-855527)Y=g[T]T=h()e[T]=Y g=D[X]X=v(-1047466+1051674)A=v(221004+-216540)Y=g[X]X=Y m=D[A]J=Y O=m Y=m and 8612657-(-295523)or 734074+-428980 end end else if Y<2327553-259142 then if Y<1797709-(-127916)then O=Y u=e[t[590696+-590685]]l=v(457138-452656)W=9730624964669-915082 z=e[t[-844023-(-844028)]]C=e[t[569845+-569839]]Z=C(l,W)a=z[Z]A=u[a]a=e[t[331536-331531]]l=5339020196852-(-986562)z=e[t[-307488+307494]]Z=v(-664091-(-668277))C=z(Z,l)u=a[C]m=A[u]A=-769821-(-769822)J=m>A Y=J and 6824490-758105 or-740970+16134206 X=J else C=v(278650+-274201)Y=O W=710790+34844391106267 J=e[t[682147-682146]]u=v(-61438+65536)m=e[t[403710-403708]]b=v(-732676+736841)a=10226078594150-(-171571)l=v(-42785+47131)A=m(u,a)O=J[A]u=e[t[409010-409009]]a=e[t[1040048+-1040046]]Z=1987679595420-698367 E=28588537329105-(-294447)z=a(C,Z)A=u[z]m=K[A]Z=23348236037465-(-834847)u=e[t[526500+-526499]]C=v(-518920-(-523074))a=e[t[1017859+-1017857]]z=a(C,Z)A=u[z]z=v(-147301+151721)J=m[A]A=e[t[-385188+385189]]C=-330182+31432641544946 u=e[t[-838117-(-838119)]]a=u(z,C)m=A[a]z=e[t[922188+-922187]]C=e[t[19566-19564]]Z=C(l,W)a=z[Z]u=K[a]l=v(-145855+150276)z=e[t[635971-635970]]C=e[t[-809072+809074]]W=107441+29545192608269 Z=C(l,W)a=z[Z]Z=v(261496+-257002)A=u[a]l=22971593000216-(-943280)a=e[t[-399335-(-399336)]]z=e[t[-667658-(-667660)]]p=32182986294149-903419 C=z(Z,l)u=a[C]Z=e[t[359681-359680]]l=e[t[-852790+852792]]W=l(b,p)C=Z[W]b=v(-606326+610592)z=K[C]Z=e[t[654969+-654968]]l=e[t[-651869-(-651871)]]p=892744+15307086986383 W=l(b,p)C=Z[W]a=z[C]C=e[t[439771-439770]]Z=e[t[-883240-(-883242)]]b=12661855606872-(-835248)W=v(-160495+164741)l=Z(W,b)z=C[l]U=v(34068-29696)W=e[t[-144577+144578]]b=e[t[-786182+786184]]p=b(U,E)l=W[p]Z=K[l]W=e[t[-521719+521720]]b=e[t[412978-412976]]E=2848469182734-123872 U=v(-517452-(-521839))p=b(U,E)l=W[p]C=Z[l]Y={[g]=S,[T]=X,[O]=J;[m]=A,[u]=a,[z]=C}S=h()e[S]=Y m=v(-884033-(-888314))T=h()Y={}A=11765171048423-(-836991)e[T]=Y Y=e[T]X=e[t[-932570-(-932571)]]O=e[t[-973209-(-973211)]]J=O(m,A)g=X[J]m=v(-257750-(-262226))X=-864596+864597 Y[g]=X a=32225503464611-(-617979)Y=e[T]C=24219926690654-839504 u=v(307551+-303275)X=e[t[190002-190001]]O=e[t[443981+-443979]]A=24947826604592-904399 J=O(m,A)g=X[J]O=v(849363-844899)X=-77116+77116 Y[g]=X Y=v(-763957-(-767891))Y=o[Y]X=h()Y=Y(o)e[X]=Y g=D[O]J=e[t[575352+-575351]]m=e[t[-866015+866017]]z=v(574530+-570203)A=m(u,a)O=J[A]Y=g[O]J=V(17708483-966135,{t[410252+-410251];t[-871-(-873)]})u=186493+17069235570319 O=e[X]g=Y(O,J)Y=e[T]O=e[t[-168714+168715]]J=e[t[-307585-(-307587)]]A=v(-635911-(-640466))m=J(A,u)g=O[m]m=e[X]u=e[X]A=#u J=m[A]A=e[t[-556182+556183]]u=e[t[205596+-205594]]a=u(z,C)m=A[a]O=J[m]Y[g]=O O=h()Y=I(195354+16154545,{t[-416541+416542],t[77587+-77585],T})e[O]=Y g=v(658187-654019)Y=D[g]u=v(943189-939309)u=o[u]A={u(o)}u={Y(d(A))}Y=-861893+1812942 g=u[81903-81902]m=u[877964+-877961]J=u[57661-57659]A=g end else u=v(839550+-835361)B=213115749948-591321 Dq=v(342318-337769)i=1765517811068-(-468410)s=594357+23145608550501 b=v(157131+-152619)C=v(-25229-(-29138))A=D[u]z=D[C]E=24034720394689-(-245239)Z=e[t[-462881+462886]]p=14745957387477-995843 l=e[t[-717257-(-717263)]]U=v(-325609-(-329701))W=l(b,p)C=Z[W]u=v(-408527-(-412432))a=z[C]Z=e[t[-10609+10620]]W=e[t[-254258+254263]]b=e[t[-999226-(-999232)]]p=b(U,E)l=W[p]C=Z[l]p=v(762309+-758271)b=D[p]U=e[t[187993+-187988]]E=e[t[-961748+961754]]F=v(-619756-(-623772))c=v(-506390-(-510816))r=E(c,s)p=U[r]W=b[p]U=e[t[22138-22127]]Y=971738-133779 u=A[u]r=e[t[-72641+72646]]c=e[t[-882967-(-882973)]]s=c(Dq,i)E=r[s]p=U[E]r=e[t[714179+-714168]]s=e[t[-849388+849393]]Dq=e[t[-892128-(-892134)]]i=Dq(F,B)n=7413317189137-585877 B=v(809536-805027)c=s[i]E=r[c]s=v(-270079-(-274191))c=D[s]Dq=e[t[-600791+600796]]i=e[t[-894495+894501]]F=i(B,n)s=Dq[F]r=c[s]Dq=31817-31818 s=37377+-37377 i=-946181-(-946181)c=r(s,Dq,i)U=E+c r=v(-390600+394843)c=14240809863092-667085 b=W(p,U)p=e[t[-40057+40062]]U=e[t[-764332-(-764338)]]E=U(r,c)W=p[E]l=b[W]W=69827-69823 Z=l*W z=a(C,Z)a=e[t[-814570+814573]]u=u(A,z,a)J=u end end end end end else if Y<2924759-(-27748)then if Y<3420447-895565 then if Y<-539249+2818207 then if Y<-370478+2553482 then if Y<903718+1251444 then if Y<1863712-(-266016)then g=v(682862-678608)Y=D[g]g=Y()Y=D[v(-836760-(-840998))]g={}else m=Y z=e[t[-838823-(-838834)]]Z=e[t[-797546+797551]]b=v(3229+1327)l=e[t[937399+-937393]]p=20334156786426-624126 W=l(b,p)C=Z[W]W=v(797165+-792975)a=z[C]C=e[t[85263-85258]]b=213540+22811227613018 Z=e[t[-898649+898655]]l=Z(W,b)z=C[l]u=a[z]a=153419-153418 A=u>a J=A Y=A and 2829813-753212 or-432840+1270799 end else if Y<-483155+2655394 then g=v(703086-698950)Y=D[g]x=v(-812606-(-816733))g=D[x]x=v(-410509+414636)D[x]=Y Y=995094+5994396 x=v(-461207-(-465343))D[x]=g x=e[t[668431-668430]]K=x()else Y=g and 265704+1505478 or 567973+1034678 end end else if Y<788332+1441096 then if Y<1489331-(-719712)then l=e[t[-891981-(-891987)]]W=false Z=l==W z=Z Y=-747714+10608261 else K=v(-758567+762736)Y=D[K]q=1.0798812987597e+14 K=Y(q)Y=-69242+13832196 end else if Y<1404856-(-840728)then K=e[t[-571361+571363]]q=e[t[445366+-445363]]Y=1835289-(-344092)x=K==q g=x else S=nil N=nil Y=6224488-(-696102)end end end else if Y<-12805+2362753 then if Y<91141+2204840 then if Y<-270275+2563261 then g=v(-1030374+1034805)Y=D[g]g=Y()g={}Y=D[v(828053-823698)]else O=v(-1017812+1022087)g=v(988019-983462)Y=D[g]J=27650635636071-(-791780)K=e[t[-610587+610594]]o=e[t[-315774-(-315782)]]S=e[t[-195909-(-195911)]]T=e[t[-1009085-(-1009088)]]X=T(O,J)N=S[X]q=o[N]g=Y(K,q)g=v(816748-812191)Y=D[g]K=e[t[799938+-799931]]O=v(-337217-(-341608))o=e[t[431391-431383]]S=e[t[-341864-(-341866)]]J=25000957371900-(-280445)T=e[t[398660-398657]]X=T(O,J)N=S[X]J=11647218361603-(-798764)q=o[N]g=Y(K,q)g=v(25287-20730)Y=D[g]K=e[t[-670265-(-670272)]]o=e[t[-690313-(-690321)]]S=e[t[980116-980114]]T=e[t[-1011163+1011166]]O=v(854562-850591)X=T(O,J)N=S[X]q=o[N]g=Y(K,q)Y=10792995-889479 end else if Y<55649+2276851 then A=v(414955-410796)J=727578+30743027785169 O=v(-251400+255273)S=e[t[-48185-(-48186)]]T=e[t[-890883-(-890885)]]X=T(O,J)N=S[X]o=x[N]X=v(689205+-685097)T=D[X]O=e[t[-1031100-(-1031101)]]J=e[t[-94813-(-94815)]]u=34297092872437-(-714093)m=J(A,u)A=-416991+21626891125813 X=O[m]S=T[X]m=v(-1036365+1040898)X=e[t[-263944+263945]]O=e[t[333934-333932]]J=O(m,A)T=X[J]N=S[T]q=o==N Y=q and-975155+13849638 or 355078+7554306 g=q else N=v(463627+-459365)g=e[t[-840881-(-840882)]]S=814126+27413993522607 K=e[t[207790-207788]]q=e[t[-317938-(-317941)]]o=q(N,S)x=K[o]Y=g[x]X=680691+16449547401976 g=v(-495488-(-499755))x=R(13159091-(-377696),{t[983461-983460],t[645875+-645873];t[-570608+570611]})g=Y[g]g=g(Y,x)Y=nil K=v(-820210-(-824682))T=v(873354-868972)x=h()e[x]=Y g=D[K]K=v(758692+-754335)o=e[t[701647-701645]]K=g[K]N=e[t[-38960+38963]]S=N(T,X)q=o[S]T=28016014962130-(-214307)K=K(g,q)S=v(-76836+81036)q=e[t[-788514-(-788516)]]o=e[t[455359-455356]]N=o(S,T)g=q[N]Y=K[g]g=v(444350-440083)g=Y[g]K=j(452164-(-825737),{t[918973-918972],t[443161+-443159];t[605262+-605259];t[-780218+780222],x})g=g(Y,K)Y=D[v(306251+-301707)]e[x]=g x=y(x)g={}end end else if Y<883439+1512020 then if Y<2891131-510754 then N=v(-621743-(-626239))Y=e[t[206316+-206315]]K=e[t[296182-296180]]m=v(694561-690239)X=v(368342+-364374)q=e[t[-1044887+1044890]]S=-52835+12876331181519 o=q(N,S)g=K[o]O=1151263853316-575724 o=v(-596995-(-600950))q=D[o]N=e[t[-154313-(-154315)]]S=e[t[-671546+671549]]T=S(X,O)o=N[T]A=27821393588729-573278 K=q[o]S=e[t[524826-524825]]X=e[t[-414671+414673]]O=e[t[-936077+936080]]J=O(m,A)T=X[J]N=S[T]o=x*N N=400154+-400153 q=K(o,N)Y[g]+=q Y=-315161+2862945 else J=v(-949415-(-953480))X=true e[t[1040884-1040870]]=X O=D[J]m=e[t[-935511+935518]]u=e[t[615029-615021]]z=e[t[-436153+436155]]l=v(-704504+708875)W=-519101+4499934786540 C=e[t[724834-724831]]Z=C(l,W)a=z[Z]A=u[a]Y=741113+12044944 u=71425+-71424 J=O(m,A,u)end else if Y<23864+2395047 then g={}Y=D[v(880354+-875893)]else F=344025+-344024 Y=-415266+8917905 i=s[F]Dq=i end end end end else if Y<-282768+3097557 then if Y<3194411-545517 then if Y<1901793-(-678454)then if Y<-367590+2937669 then Y=D[v(660877-656389)]x=nil g={}else X=v(-961673-(-965649))g=e[t[-319030+319031]]Y=g[x]N=e[t[-284382-(-284384)]]S=e[t[522420-522417]]O=-772168+28054483925839 T=S(X,O)o=N[T]N=v(-991075-(-995005))g=K[o]o=e[t[-70707+70708]]N=o[N]N=N(o,x,K)Y[g]=N Y=-90306+10397510 end else if Y<-311726+2957062 then Y=v(-918946-(-922925))T=738542-738541 Y=S[Y]Y=Y(S,T)Y=12137797-(-901331)else C=32856713610431-690427 m=v(-683823+688045)X=Y z=v(-639796+644265)J=D[m]m=J(o)A=e[t[480579-480578]]u=e[t[982056-982054]]a=u(z,C)J=A[a]O=m~=J T=O Y=O and-382580+7785953 or 12252720-(-272266)end end else if Y<-7573+2705360 then if Y<213410+2453129 then q=e[t[64296-64295]]N=e[t[-457282+457284]]X=v(-146731-(-150676))O=4425827412906-(-236642)S=e[t[-381890+381893]]T=S(X,O)o=N[T]K=q[o]x=not K g=x Y=x and 5671516-28989 or 10638882-217758 else m=v(-736135+740324)E=v(-349740+354274)J=D[m]a=v(-175524-(-179433))i=5215251631438-(-670766)l=v(-836958-(-841268))u=D[a]W=18905636877304-(-257643)b=v(-730504+734695)z=e[t[334675+-334670]]p=12315122553017-(-443821)C=e[t[-587384-(-587390)]]Z=C(l,W)a=z[Z]c=v(583483+-579124)A=u[a]r=-818702+32206668265635 s=615017+33285891398178 z=e[t[-501136+501144]]Z=e[t[218787-218782]]Dq=v(1036978-1033080)l=e[t[582139+-582133]]W=l(b,p)C=Z[W]a=z[C]W=v(-220231-(-224269))l=D[W]b=e[t[-2863-(-2868)]]p=e[t[-938957+938963]]U=p(E,r)W=b[U]F=995884+19288532758761 Z=l[W]b=e[t[242964+-242956]]U=e[t[356166-356161]]E=e[t[-145069-(-145075)]]r=E(c,s)p=U[r]W=b[p]U=e[t[173025-173017]]r=e[t[804046+-804041]]c=e[t[329966-329960]]s=c(Dq,i)E=r[s]i=v(-514369-(-518770))r=v(-963251-(-967363))p=U[E]m=v(-754514-(-758419))E=D[r]c=e[t[-690126+690131]]s=e[t[702516+-702510]]Dq=s(i,F)r=c[Dq]m=J[m]U=E[r]c=305023+-305024 Y=12999016-790055 s=-249362-(-249362)r=-300712-(-300712)E=U(r,c,s)b=p+E U=v(213102+-209060)E=-761146+1332124098470 l=Z(W,b)W=e[t[-445009-(-445014)]]b=e[t[-311219-(-311225)]]p=b(U,E)Z=W[p]C=l[Z]Z=728457+-728453 z=C*Z u=A(a,z)A=e[t[300504-300501]]m=m(J,u,A)X=m end else if Y<-925951+3730736 then g=v(-464985+469489)Y=D[g]g=Y()g={}Y=D[v(-861001-(-865429))]else Y=157943+2677737 wq=v(-852432+856904)Hq=D[wq]Vq=e[o]wq=v(59505+-55121)Tq=1023821+32558129961964 Lq=v(664139+-660244)wq=Hq[wq]Iq=e[K]Rq=Iq(Lq,Tq)Mq=Vq[Rq]wq=wq(Hq,Mq)Sq=7025759087186-122251 Mq=e[o]Rq=v(615438+-611175)Vq=e[K]Lq=266714+16025907170124 Iq=Vq(Rq,Lq)Hq=Mq[Iq]jq=wq[Hq]Hq=-332473+332483 Tq=v(856438+-852519)Nq=jq+Hq Hq=w(-746770+7051899,{o;K})jq=h()e[jq]=Nq Nq=h()Mq=v(124496-120024)e[Nq]=Hq wq=D[Mq]Mq=v(-868633+872990)Iq=e[o]Mq=wq[Mq]Rq=e[K]Lq=Rq(Tq,Sq)Vq=Iq[Lq]Lq=v(-913149+917462)Mq=Mq(wq,Vq)Vq=e[o]Iq=e[K]Tq=-983734+11446021707655 Rq=Iq(Lq,Tq)wq=Vq[Rq]Hq=Mq[wq]Mq=R(5647453-(-1044536),{s,o;K,jq;Nq})wq=v(804892+-800625)jq=y(jq)Nq=y(Nq)wq=Hq[wq]wq=wq(Hq,Mq)end end end else if Y<2865089-(-18372)then if Y<2111773-(-716379)then if Y<2844646-29374 then Y=O Y=X and 7400942-(-131598)or 94836+4348589 else T=654572-654571 Y=v(-412085+416064)Y=S[Y]Y=Y(S,T)Y=-968480+4945197 end else if Y<1901982-(-945946)then X=y(X)Hq=v(-491232+495749)jq=D[Hq]c=y(c)q=nil wq=e[o]Mq=e[K]A=y(A)n=nil Rq=24845433728017-(-196896)J=y(J)s=y(s)Iq=v(-408250-(-412533))Vq=Mq(Iq,Rq)N=y(N)Hq=wq[Vq]Nq=jq[Hq]Iq=v(400988-396695)wq=e[o]Rq=11599797315879-(-1027058)Mq=e[K]Vq=Mq(Iq,Rq)Hq=wq[Vq]r=y(r)T=y(T)jq=Nq(Hq)f=y(f)E=y(E)wq=e[o]b=nil Lq=18096952796703-(-654028)Y=D[v(91616+-87326)]Iq=v(984761+-980263)Mq=e[K]Rq=-563608+7551096219476 vq=y(vq)a=y(a)Vq=Mq(Iq,Rq)z=y(z)Hq=wq[Vq]wq=w(-101600+4838602,{yq;Kq,oq;B})qq=nil Nq=jq[Hq]Kq=y(Kq)Hq=v(133590-129649)Qq=y(Qq)F=y(F)Yq=y(Yq)oq=y(oq)eq=y(eq)Hq=Nq[Hq]Hq=Hq(Nq,wq)dq=y(dq)Hq=v(338632+-334160)gq=y(gq)Nq=D[Hq]hq=y(hq)U=y(U)m=y(m)Mq=e[o]Hq=v(-262715+267072)Rq=v(-686241+690689)Vq=e[K]tq=y(tq)Hq=Nq[Hq]Iq=Vq(Rq,Lq)wq=Mq[Iq]g={}u=y(u)kq=nil yq=y(yq)S=nil Lq=5767365901949-(-379904)B=y(B)W=y(W)Rq=v(807493-803075)Hq=Hq(Nq,wq)xq=y(xq)Mq=e[o]Vq=e[K]Iq=Vq(Rq,Lq)O=y(O)K=y(K)o=y(o)Pq=y(Pq)G=y(G)wq=Mq[Iq]Nq=v(-347734-(-352208))Nq=Hq[Nq]Nq=Nq(Hq,wq,jq)jq=nil else Y=V(4583337-448211,{o})Z={Y()}Y=D[v(413760+-409700)]g={d(Z)}end end else if Y<2678446-(-233274)then if Y<2766155-(-131827)then Y=v(216267-212288)T=486563+-486558 Y=S[Y]Y=Y(S,T)Y=669686+13631498 else g=v(-874791+878976)Y=D[g]g=Y()Y=8198079-233867 end else u=e[t[450691+-450690]]C=v(-136469-(-140385))a=e[t[32296-32294]]Z=31589924169226-(-168812)l=v(441810+-437357)W=22725752983973-(-284593)z=a(C,Z)a=v(-663155+667263)A=u[z]m=N[A]u=D[a]z=e[t[-509101+509102]]C=e[t[281269-281267]]Y=-1007898+15958514 Z=C(l,W)a=z[Z]A=u[a]J=m~=A X=J end end end end else if Y<3060667-(-798963)then if Y<397748+3065976 then if Y<3259104-209516 then if Y<3535961-516495 then if Y<-575823+3568154 then Y=-996297+13564129 else o,S=K(q,o)Y=o and 368823+12065779 or-523249+8862608 end else if Y<239717+2793379 then m=28483007547592-(-289543)N=v(-165596-(-169524))q=D[N]a=5516763115492-730588 T=e[o]Y=15551725-(-419902)J=v(705123+-700893)X=e[K]u=v(-912714+917123)O=X(J,m)X=v(1029809-1025337)S=T[O]T=D[X]J=e[o]m=e[K]A=m(u,a)O=J[A]J=v(-544411+548626)J=T[J]X={J(T,O)}N=q(S,d(X))else Y=489900+1389059 S=e[N]g=S end end else if Y<2182845-(-988355)then if Y<4075683-932126 then K=v(-846256+850425)Y=D[K]q=18695803198-1040806 K=Y(q)q=true K=v(27886-23335)Y=D[K]K=Y(q)Y=901279-319374 else Y=true Y=Y and 754306+12144101 or 6559700-(-233439)end else if Y<2887192-(-332804)then X=15945954147380-(-860365)Y=e[t[-895713+895718]]K=e[t[-715288-(-715289)]]T=v(-350663+354554)o=e[t[203301+-203299]]N=e[t[774591-774588]]S=N(T,X)q=o[S]x=K[q]g=Y(x)x=g Y=x and 9449640-(-296741)or-983075+8637699 else Y=14616639-(-840655)end end end else if Y<-1029002+4711859 then if Y<629414+2965115 then if Y<958470+2530424 then r=false Dq=false e[t[-388224+388238]]=r c=false F=v(959559+-955002)e[t[69574-69562]]=c Pq=v(-809418+813340)s=false e[t[-174048+174061]]=s e[t[-208093+208103]]=Dq i=D[F]tq=54991+1643735641134 B=e[t[1014213-1014206]]G=e[t[-268964+268972]]vq=e[t[90837-90835]]Yq=e[t[471534-471531]]dq=Yq(Pq,tq)Pq=v(811717+-807694)f=vq[dq]n=G[f]tq=18066289177274-20958 F=i(B,n)F=v(-416117-(-420674))i=D[F]B=e[t[664921+-664914]]G=e[t[516297-516289]]vq=e[t[184606+-184604]]Yq=e[t[-1033159+1033162]]dq=Yq(Pq,tq)f=vq[dq]n=G[f]F=i(B,n)F=v(456654-452097)i=D[F]B=e[t[512053+-512046]]Pq=v(105445-101219)tq=17831443365597-(-565650)G=e[t[794452-794444]]vq=e[t[738-736]]Yq=e[t[-52329+52332]]dq=Yq(Pq,tq)f=vq[dq]n=G[f]F=i(B,n)F=v(684140-679583)i=D[F]Pq=v(223352+-219250)B=e[t[-250986-(-250993)]]G=e[t[-407601-(-407609)]]tq=-3879+4918864992281 Y=562480+12783503 vq=e[t[419758-419756]]Yq=e[t[108575-108572]]dq=Yq(Pq,tq)f=vq[dq]n=G[f]F=i(B,n)else u=v(-702404-(-706826))N=v(1044575+-1040647)m=14749310947668-(-493952)Y=5360343-196448 q=D[N]T=e[o]J=v(-230048+234275)X=e[K]O=X(J,m)X=v(-609462+613934)S=T[O]a=-2706+33335681877813 T=D[X]J=e[o]m=e[K]A=m(u,a)O=J[A]J=v(201471-197256)J=T[J]X={J(T,O)}N=q(S,d(X))end else if Y<-467222+4112371 then Y=769612+6357060 O=nil else N=true l=-487719+27735603192730 Y=-952606+13081577 e[t[-221425+221437]]=N T=false S=false e[t[787179-787166]]=S O=v(-801536+805601)e[t[407680-407666]]=T X=D[O]J=e[t[933971+-933968]]A=e[t[-737388-(-737392)]]Z=v(265863+-261529)a=e[t[834648-834643]]z=e[t[984783+-984777]]C=z(Z,l)u=a[C]m=A[u]A=817746-817745 O=X(J,m,A)end end else if Y<3423005-(-425880)then if Y<4042375-215523 then m=v(-100656+104906)O=v(-228074+232564)Y=true N=v(-165867-(-169822))g=true e[t[-987574+987575]]=Y e[t[-43387+43389]]=g K=e[t[-428672-(-428675)]]o=D[N]S=e[t[644674+-644670]]T=e[t[608141+-608136]]J=-957047+23203604366508 X=T(O,J)N=S[X]q=o[N]N=788539-788538 T=e[t[898475+-898472]]S=#T o=q(N,S)x=K[o]q=v(-914332+918501)Z=14286551512966-(-8822)K=D[q]q=K(x)q=v(-702309+706374)K=D[q]o=e[t[317350+-317344]]S=e[t[666974+-666967]]X=e[t[-218613-(-218617)]]O=e[t[409655+-409650]]A=7815197575742-1014791 J=O(m,A)T=X[J]N=S[T]S=-739750-(-739751)q=K(o,N,S)X=v(1047685+-1043164)K=e[t[-743492+743500]]o=K()N=e[t[-45525-(-45529)]]O=7395569023345-371710 S=e[t[194414-194409]]T=S(X,O)J=2039886279975-(-921230)o=N[T]N=M(16017780-(-376965),{t[115765-115761];t[-967379+967384],t[-370506+370515],t[-993806-(-993816)]})O=v(625477-621591)K=q[o]o=v(-175295-(-179562))o=K[o]o=o(K,N)S=e[t[517212+-517208]]T=e[t[-725383+725388]]X=T(O,J)N=S[X]K=q[N]N=v(-920368+924457)N=K[N]N=N(K)K=v(259887-255921)X=false K=o[K]N=false K=K(o)K=false e[t[87384+-87383]]=K T=v(-450271+454822)e[t[-526569+526571]]=N S=D[T]T=S(X)S=e[t[-491649-(-491660)]]T=S()T=Y m=e[t[-754047-(-754059)]]C=v(424091-419692)u=e[t[-634210-(-634214)]]a=e[t[-214529-(-214534)]]z=a(C,Z)A=u[z]z=v(-768389-(-772425))J=m[A]C=-681116+34152982127291 A=e[t[647132-647128]]u=e[t[-82867-(-82872)]]a=u(z,C)m=A[a]O=J[m]J=988719-988718 X=O<J Y=X and 11236658-(-702975)or 1623212-785268 S=X else X=31559654812844-(-314556)o=e[t[271108+-271107]]N=e[t[-776009-(-776011)]]T=v(-28930+33433)S=N(T,X)q=o[S]J=v(1011563-1007328)m=5204101890672-(-427783)S=v(53974-49866)g=x[q]N=D[S]T=e[t[-487868-(-487869)]]X=e[t[-184004-(-184006)]]O=X(J,m)S=T[O]o=N[S]O=v(1045806+-1041505)J=5635785412360-148680 S=e[t[-877364-(-877365)]]T=e[t[-1008348+1008350]]X=T(O,J)N=S[X]q=o[N]Y=g==q Y=Y and 17457703-954484 or 855717+7134368 end else N=e[t[268210-268209]]o=N[x]T=e[t[1025762+-1025760]]X=e[t[-863226-(-863229)]]J=v(-600964-(-605299))m=22381194538231-(-457663)O=X(J,m)S=T[O]N=K[S]g=o[N]Y=not g Y=Y and 2918929-338818 or 10828258-521054 end end end else if Y<3062354-(-1021453)then if Y<3071043-(-937002)then if Y<-557965+4532636 then if Y<473888+3480450 then F=false i=e[t[407481-407475]]Y=300856+13496860 Dq=i==F c=Dq else l=e[t[-745144-(-745145)]]C=v(98544+-94193)p=v(-993008-(-997253))U=665980+5297848229927 C=a[C]W=e[t[534396+-534394]]b=W(p,U)Z=l[b]C=C(a,Z)Y=C and 12735450-(-855467)or 36813+12822918 z=C end else if Y<2967499-(-1012686)then Y=6545968-(-256801)S=nil N=nil else N=not o x=x+q g=x<=K g=N and g N=x>=K N=o and N g=N or g N=935304+9361967 Y=g and N g=-971655+11740343 Y=Y or g end end else if Y<3744237-(-316414)then if Y<4958011-914489 then O=nil X=q==O S=X T=Y Y=X and 2473700-611150 or 531584+4735877 else g=v(-706367+710796)Y=D[g]g=Y()Y=D[v(465801+-461573)]g={}end else if Y<-701388+4774892 then o,S=K(q,o)Y=o and-136580+7522401 or-955018+2160907 else T=not S q=q+N K=q<=o K=T and K T=q>=o T=S and T K=T or K T=-1007025+12850096 Y=K and T K=12808806-(-18706)Y=Y or K end end end else if Y<678876+3453886 then if Y<378871+3715486 then if Y<4291204-200705 then o,S=K(q,o)Y=o and 13420040-(-325648)or 7364469-766142 else x=P[671300+-671299]K=e[t[1018465+-1018464]]N=v(267383-263361)S=7471310678885-(-188978)q=e[t[436195+-436193]]o=q(N,S)g=K[o]Y=x==g Y=Y and-263933+824500 or-218180-(-509561)end else if Y<-403529+4502520 then K=v(-318689+322858)q=18695134269-378767 Y=D[K]K=Y(q)K=v(905034+-901137)Y=D[K]K=Y()Y=-758774+7926481 else x=P[890772-890771]K=P[731449-731447]g=K Y=K and-234486+12666900 or 922090+8602353 end end else if Y<156177+3980997 then if Y<3343332-(-791405)then m=e[t[-583699+583700]]C=v(452108-448170)Z=4698261617942-(-1035125)u=e[t[-269875+269877]]a=e[t[-15579+15582]]z=a(C,Z)A=u[z]J=m[A]Y=1682375-(-194555)m=952996+-952996 S=J>m g=S else Y=-586031+7575521 end else q=174484+-174295 K=e[t[-745441+745443]]x=K*q K=98075+1898405889112 g=x+K x=35184372417751-328919 K=-868489-(-868490)Y=g%x e[t[23839-23837]]=Y x=e[t[1013177+-1013174]]g=x~=K Y=726275+9936845 end end end end end end else if Y<406476+6501375 then if Y<790001+5042577 then if Y<1028521+4013397 then if Y<-1033546+5793760 then if Y<453902+3956450 then if Y<652857+3610822 then if Y<-364673+4517434 then g=v(237806+-233249)J=425331+21701203143174 Y=D[g]K=e[t[-914921+914928]]o=e[t[988159+-988151]]O=v(-955355-(-959576))S=e[t[665174+-665172]]T=e[t[-899033+899036]]X=T(O,J)N=S[X]O=v(-672915+676794)q=o[N]g=Y(K,q)J=18433432665273-(-926926)g=v(-346208+350765)Y=D[g]K=e[t[-867397-(-867404)]]o=e[t[-331750-(-331758)]]S=e[t[357005+-357003]]T=e[t[307213-307210]]X=T(O,J)N=S[X]q=o[N]g=Y(K,q)g=v(-698693+703250)Y=D[g]K=e[t[-828169+828176]]o=e[t[-260720+260728]]J=-633020+26565963618574 S=e[t[-692667-(-692669)]]O=v(-842874+846971)T=e[t[64674-64671]]X=T(O,J)N=S[X]q=o[N]O=v(-621683+625764)g=Y(K,q)g=v(188679+-184122)Y=D[g]K=e[t[-346876-(-346883)]]o=e[t[-31860-(-31868)]]S=e[t[647185-647183]]J=-197079+11222950139457 T=e[t[663942-663939]]X=T(O,J)O=v(433695-429325)N=S[X]J=31831526087642-(-810508)q=o[N]g=Y(K,q)g=v(-873860+878417)Y=D[g]K=e[t[712255+-712248]]o=e[t[483996+-483988]]S=e[t[721911+-721909]]T=e[t[752332-752329]]X=T(O,J)N=S[X]q=o[N]g=Y(K,q)Y=641781+14201804 else a=v(754730-750719)z=884296+31981915438052 T=N m=e[t[-115942-(-115944)]]A=e[t[-746055-(-746058)]]u=A(a,z)J=m[u]O=K[J]Y=T~=O Y=Y and 1034880+11514082 or 13470491-(-470049)end else if Y<3957994-(-320140)then Y=-817089+11181099 else g=e[t[-188006+188016]]S=false Y=g==S Y=Y and 579744+5152958 or 336005+-247020 end end else if Y<5176892-631201 then if Y<5458461-989993 then C=-1895+1896 a=Y z=N<C Y=z and 8001890-(-536620)or-464768+8942996 u=z else m=e[t[-51019+51023]]C=v(385141+-380817)Z=-433296+13061659014226 Y=1393097-423844 u=e[t[848271-848269]]a=e[t[-531301-(-531304)]]z=a(C,Z)A=u[z]J=m[A]m=254826+-254826 S=J>m g=S end else if Y<4192785-(-414797)then K=v(514656-510521)Y=D[K]N=e[t[1013753+-1013748]]T=v(-826040-(-829920))T=N[T]S={T(N)}N={Y(d(S))}K=N[-617936-(-617937)]o=N[507442+-507439]Y=156522+6646247 q=N[77953-77951]else g=v(163424+-159190)Y=D[g]g=Y()Y=e[t[469761+-469760]]g=v(-161104-(-165070))g=Y[g]g=g(Y)g=v(-48720+52686)Y=e[t[737665-737663]]g=Y[g]g=g(Y)g=v(876683+-872717)Y=e[t[-179377+179380]]g=Y[g]g=g(Y)Y=e[t[136212+-136208]]g=v(506271-501926)g=Y[g]g=g(Y)Y=D[v(708060+-703525)]g={}end end end else if Y<-961654+5818852 then if Y<5432726-623559 then if Y<533243+4271889 then m=v(-1001917-(-1005895))K=P[490281-490279]u=v(972758+-968702)q=P[160539+-160536]O=764000+734794373366 N=e[t[-933970-(-933971)]]x=P[-340436-(-340437)]A=-283340+23260791160091 o=q S=e[t[-839389-(-839391)]]X=v(667327-663203)T=S(X,O)Y=v(410261-405957)Y=K[Y]a=26251078761862-445894 g=N[T]Y=Y(K,g)N=h()e[N]=Y S=e[N]X=e[t[823137-823136]]O=e[t[-686104-(-686106)]]J=O(m,A)T=X[J]g=S[T]O=v(-467299-(-471407))X=D[O]J=e[t[-465214-(-465215)]]m=e[t[-778110+778112]]A=m(u,a)O=J[A]T=X[O]O=e[t[-597473-(-597474)]]u=203868+200189862913 J=e[t[-829639-(-829641)]]A=v(887860+-883530)m=J(A,u)X=O[m]S=T[X]Y=g~=S Y=Y and-132298+11057262 or 15957990-(-181575)else Y=711058-419677 end else if Y<-924182+5749853 then Y=e[t[34372+-34371]]Y=Y and 7912950-(-441010)or 618672+11489517 else x=P K=h()Y=true q=v(141808-137365)e[K]=Y g=D[q]q=v(877320-873391)N=h()Y=g[q]q=h()o=h()e[q]=Y X=H(402402+7023799,{N})T=v(-892587-(-896536))Y=j(-65408+14049068,{})e[o]=Y Y=false e[N]=Y S=D[T]T=S(X)g=T Y=T and 3792639-743438 or 1422151-(-456808)end end else if Y<-261649+5188509 then if Y<4341194-(-551051)then Y=e[t[-2613-(-2619)]]J=e[t[590305+-590304]]A=e[t[-738135-(-738137)]]z=v(285348-281176)u=e[t[157396+-157393]]C=27281630217328-742096 a=u(z,C)m=A[a]S=J[m]g=Y(S)Y=759500+6024978 else S=v(-426608+431100)g=D[S]J=e[t[979131-979129]]u=v(-373133-(-377035))a=160591+8528002767924 m=e[t[-569284+569287]]A=m(u,a)S=J[A]Y=g[S]S=j(17162268-1004286,{X;t[-117388-(-117395)],t[-272432-(-272434)];t[291146+-291143],O;t[759674+-759673],t[97630-97622];t[734674+-734665],t[696561-696551]})g=Y(S)m=e[t[-600725+600730]]J=#m S=N==J Y=S and 4553625-419135 or 732298+1144632 g=S end else if Y<4391698-(-614373)then N=724910+20156500202748 Y=e[t[102423-102422]]x=e[t[-739112+739114]]o=v(447108-443201)K=e[t[-853697-(-853700)]]q=K(o,N)g=x[q]x=-349597-(-349597)Y[g]=x Y=896022+13590844 else a=z Y=793763+14821962 U=a u[a]=U a=nil end end end end else if Y<7974+5369877 then if Y<812104+4364712 then if Y<5638994-523631 then if Y<5875946-799984 then Y=-543282+3699621 else X=v(17938-13964)x=P[122719-122718]S=v(-335530-(-339478))K=v(848743-844226)g=D[K]T=23462372544752-(-973245)q=e[t[1009984+-1009983]]J=v(895757-891354)o=e[t[-886814+886816]]N=o(S,T)K=q[N]Y=g[K]q=e[t[-201338+201339]]S=v(613728+-609759)T=-254951+23089310600678 o=e[t[777298+-777296]]N=o(S,T)K=q[N]q=e[t[-991350+991353]]S=5736489739879-318456 g=Y(K,q)K=g g=e[t[4051+-4050]]N=v(640602-636362)q=e[t[-977685-(-977687)]]o=q(N,S)Y=g[o]O=28160636908886-737821 o=v(-106447+110559)q=D[o]N=e[t[127960+-127959]]S=e[t[45080+-45078]]T=S(X,O)o=N[T]m=16757868425574-(-126229)N=-682577-(-782577)g=q[o]S=653960-553960 o=916422-816422 q=g(o,N,S)N=v(-207880+212157)K[Y]=q g=e[t[573406-573405]]q=e[t[-857148-(-857150)]]S=15186568309360-577233 o=q(N,S)Y=g[o]N=e[t[-1000462-(-1000465)]]T=e[t[-575633+575634]]X=e[t[-316964-(-316966)]]O=X(J,m)S=T[O]o=N[S]O=v(698432+-694508)S=e[t[-680532+680533]]J=-382592+32586464203206 T=e[t[963743+-963741]]X=T(O,J)N=S[X]q=o[N]o=742534+-742434 g=q*o N=v(641186-637124)K[Y]=g g=e[t[-694902-(-694903)]]S=10371091047801-774812 q=e[t[-591311-(-591313)]]o=q(N,S)Y=g[o]g=-417774+427774 K[Y]=g g=v(-120291+124763)Y=D[g]X=-690687+20008870604388 o=e[t[979945-979944]]T=v(-774189-(-778494))N=e[t[408537+-408535]]S=N(T,X)q=o[S]N=.15 g=v(669518+-665161)o=Y g=Y[g]g=g(Y,q)Y=v(-230593+234750)q=x or N Y=g[Y]x=nil Y=Y(g,K,q)K=nil Y=D[v(778562+-774325)]g={}end else if Y<495815+4666506 then q=e[t[-786155+786156]]g=q[x]N=e[t[147233+-147231]]O=285477+8860248372472 x=nil X=v(-500451+504807)S=e[t[132960+-132957]]T=S(X,O)o=N[T]q=K[o]Y=g[q]g=v(836090-831856)g=Y[g]K=nil g=g(Y)Y=D[v(770232+-766104)]g={}else S=v(-986727-(-991199))c=187276+-187276 u=v(191652-187438)X=v(-390580+394680)N=D[S]S=v(580925-576924)B=878947-878946 a=34251330408578-(-355787)T=D[X]J=e[o]m=e[K]A=m(u,a)tq=670418+-670418 S=N[S]O=J[A]X={T(O)}S=S(N,d(X))N=542919+-542918 q=S[N]b=500928+9413052427359 kq=432308-432307 S=v(-809131-(-813604))T=1038346-1038286 N=D[S]S=N(T)eq=-895295+895296 X=h()N=.45 a=367117+1779485632815 W=v(-909601-(-913710))T=h()F=-935521+935521 e[T]=N n=890963-890963 U=-388269-(-388269)u=v(259664+-255119)N={}e[X]=N J=e[o]m=e[K]A=m(u,a)O=J[A]E=-817266+817266 A=v(-1001104+1005142)m=D[A]u=e[o]a=e[K]s=428303-428302 z=a(W,b)dq=885652-885652 W=-708742+708742 Qq=-409558+409558 A=u[z]z=613697+-613698 J=m[A]a=-489744-(-489744)f=-584070+584070 jq=665829-665829 A=842932+-842932 r=-448726-(-448727)Kq=-786045-(-786045)Yq=44084+-44084 b=229077+-229077 u=-815334+815335 m=J(A,u,a,z,W,b,U,E,r,c,s,F)U=v(-390294-(-394730))z=v(-116785+121202)E=-815256+6651282570417 A=e[o]u=e[K]W=35138107343473-(-605561)a=u(z,W)J=A[a]F=696663-696663 c=995156-995156 a=v(-314247+318285)s=191855+-191854 u=D[a]z=e[o]W=e[K]b=W(U,E)W=-531901+531901 a=z[b]U=781606+-781606 A=u[a]r=665169-665169 E=-204111-(-204111)z=30638-30638 b=133296-133297 a=1046126-1046126 Nq=-757902-(-757902)G=784916-784916 u=A(a,z,W,b,U,E,r,c,s,F,B,n)a=e[o]B=-571415-(-571415)U=12616642377261-(-1007814)z=e[K]b=v(630116+-626089)W=z(b,U)A=a[W]W=v(-917087+921125)c=758591+33983273265809 z=D[W]F=-158158-(-158159)b=e[o]U=e[K]r=v(-912311-(-916246))E=U(r,c)r=-914436+914436 Vq=-970538+30655552308973 W=b[E]a=z[W]E=-494676-(-494676)n=-659309+659308 c=135790+-135789 U=111900-111900 W=120368+-120367 b=-442052+442052.5 s=-377910+377910 z=a(W,b,U,E,r,c,s,F,B,n,G,f)W=e[o]E=v(-695822+700122)r=25835440067924-(-776618)b=e[K]U=b(E,r)a=W[U]U=v(-618820-(-622858))s=v(-452948-(-457217))f=139342-139341 G=561032+-561032 B=-429876+429876 b=D[U]E=e[o]r=e[K]n=977736-977735 F=-525383+24199208939595 c=r(s,F)U=E[c]vq=-811845-(-811845)W=b[U]r=-455502+455502 s=354452+-354452 U=90013+-90014 E=-838777.5-(-838778)F=349782-349783 c=244402-244402 b=W(U,E,r,c,s,F,B,n,G,f,vq,Yq)xq=580441-580441 Pq=763107-763107 c=v(903539+-899509)B=v(-82483-(-86663))gq=700804-700804 U=e[o]s=28102601387446-506520 E=e[K]r=E(c,s)W=U[r]r=v(-161641-(-165679))n=6222974259872-(-276657)E=D[r]G=-556572+556572 vq=294885+-294885 c=e[o]s=e[K]F=s(B,n)r=c[F]s=-865643-(-865643)B=-177646-(-177646)f=-101597-(-101598)U=E[r]F=981383-981383 Yq=-714143+714142 n=-808742-(-808743)c=134320-134321 r=495712+-495711 E=U(r,c,s,F,B,n,G,f,vq,Yq,dq,Pq)r=e[o]F=v(88696-84153)c=e[K]B=-394387+34649767429018 G=v(214043+-209609)f=33433048538989-729757 s=c(F,B)Yq=-464366-(-464367)vq=753916-753916 U=r[s]s=v(753902-749864)c=D[s]F=e[o]B=e[K]n=B(G,f)f=2123-2124 s=F[n]r=c[s]dq=-903984+903984 F=540112+-540113 Pq=-664427+664428 s=620463+-620464 B=-107336-(-107336)n=960631-960631 G=15227+-15227 c=r(s,F,B,n,G,f,vq,Yq,dq,Pq,tq,Qq)s=e[o]F=e[K]Yq=828457+6030036674254 G=-1045743+20565613156951 dq=46178-46178 n=v(737939-733843)vq=v(401658-397333)B=F(n,G)yq=292034-292034 r=s[B]B=v(-588072+592110)F=D[B]n=e[o]G=e[K]Hq=323183-323183 Qq=-802040+802040 f=G(vq,Yq)qq=253614+-253614 B=n[f]hq=964369-964369 s=F[B]f=-785476-(-785475)n=553697+-553696 Pq=515195-515195 B=616962+-616962 vq=-249517-(-249517)tq=-790211+790212 Yq=331579+-331579 G=1003656+-1003656 F=s(B,n,G,f,vq,Yq,dq,Pq,tq,Qq,kq,gq)gq=411846+-411846 f=v(-986826-(-991271))Pq=17258503933562-(-725226)B=e[o]vq=24465225732569-271705 n=e[K]G=n(f,vq)s=B[G]Qq=-560616-(-560616)G=v(-66416-(-70454))n=D[G]f=e[o]dq=v(-4682+8858)vq=e[K]Yq=vq(dq,Pq)G=f[Yq]f=-970821-(-970821)kq=451166+-451165 B=n[G]dq=1024079-1024079 tq=-247340-(-247340)Yq=337087-337088 G=922009-922009 vq=-634699-(-634699)Pq=646382+-646382 n=B(G,f,vq,Yq,dq,Pq,tq,Qq,kq,gq,eq,xq)G=e[o]dq=515652+28404146705766 Qq=231262+4336468590725 xq=110002-110003 f=e[K]Yq=v(-612813+616833)vq=f(Yq,dq)B=G[vq]kq=-929257-(-929257)tq=v(116865-112479)vq=v(-228288+232326)gq=1047384+-1047383 f=D[vq]eq=-380015-(-380015)Yq=e[o]dq=e[K]Pq=dq(tq,Qq)vq=Yq[Pq]G=f[vq]vq=21429+-21428 dq=-617398+617398 Qq=-757729-(-757730)Yq=-593883+593883.5 Pq=684468+-684468 tq=637295+-637295 f=G(vq,Yq,dq,Pq,tq,Qq,kq,gq,eq,xq,hq,Kq)eq=953823-953823 tq=10732471127765-(-722096)vq=e[o]Yq=e[K]Pq=v(354087-349769)oq=849734+-849734 Iq=-137599+7831913277374 xq=1008080+-1008079 kq=v(-840078-(-844184))dq=Yq(Pq,tq)Kq=5610+-5609 G=vq[dq]hq=670812-670812 gq=-452116+10999914543638 dq=v(857697+-853659)Yq=D[dq]Pq=e[o]tq=e[K]Qq=tq(kq,gq)tq=754445+-754445 dq=Pq[Qq]kq=-762280+762280 Qq=54880-54880 vq=Yq[dq]Pq=-371622+371622.5 gq=612421+-612422 dq=833225-833226 Yq=vq(dq,Pq,tq,Qq,kq,gq,eq,xq,hq,Kq,qq,oq)dq=e[o]kq=56790+30283662039359 eq=v(614119+-609731)Qq=v(820294+-816405)Pq=e[K]tq=Pq(Qq,kq)xq=32733128847553-587063 vq=dq[tq]Kq=-887822-(-887823)tq=v(-380956+384994)hq=-452151-(-452151)oq=-669519+669518 Pq=D[tq]Qq=e[o]kq=e[K]gq=kq(eq,xq)xq=-741251+741252 eq=-870281+870281 tq=Qq[gq]dq=Pq[tq]gq=-232467+232467 qq=-580596+580596 Qq=589778+-589779 tq=-167427-(-167428)kq=134491-134491 Pq=dq(tq,Qq,kq,gq,eq,xq,hq,Kq,qq,oq,yq,Nq)Kq=-427021+21206562859680 gq=v(459978+-455666)tq=e[o]Qq=e[K]qq=-466260-(-466260)hq=v(-481812-(-486005))eq=-549948+12898320645042 kq=Qq(gq,eq)dq=tq[kq]kq=v(-660569+664607)Qq=D[kq]gq=e[o]eq=e[K]xq=eq(hq,Kq)kq=gq[xq]gq=219092-219093 Nq=-412360+412361 tq=Qq[kq]yq=832760-832760 oq=-574878-(-574879)eq=-88898-(-88898)hq=-50958+50958 Kq=548444+-548445 kq=-655588-(-655587)xq=811085-811085 Qq=tq(kq,gq,eq,xq,hq,Kq,qq,oq,yq,Nq,jq,Hq)N={[O]=m,[J]=u;[A]=z;[a]=b,[W]=E;[U]=c,[r]=F,[s]=n;[B]=f,[G]=Yq,[vq]=Pq,[dq]=Qq}u=false A=v(134302+-130372)J=I(86398+9434795,{o;K})z=h()a=false tq=v(1048498-1043952)O=h()vq=352990+12492095304667 e[O]=N r=v(465559+-461087)N=h()U=h()e[N]=J m=e[X]J=w(4592668-(-212026),{o,K,N;O;T})m[A]=J m=false J=false A=false e[z]=J J=h()b=false f=-190679+32251616650113 gq=32794357183856-145865 e[J]=m m=h()e[m]=A A=h()e[A]=u u=h()W=false e[u]=a a=false e[U]=a a=h()e[a]=W G=4430223838034-394052 W=h()n=v(298316-293849)e[W]=b E=D[r]hq=v(-102471+106712)Qq=-302825+18899522552137 r=v(853592+-849235)r=E[r]s=e[o]F=e[K]B=F(n,G)n=21325424470087-(-949891)c=s[B]r=r(E,c)B=v(60933-56919)c=e[o]s=e[K]F=s(B,n)E=c[F]G=-402867+26537105020408 c=v(-783428-(-787433))b=r[E]r=D[c]n=v(-924424-(-928947))s=e[o]F=e[K]B=F(n,G)c=s[B]E=r[c]r=h()e[r]=E E=e[r]F=e[o]G=v(704117+-700221)c=v(-595228+599399)Hq=372660+31853452954172 B=e[K]c=E[c]Yq=22604342373119-410082 n=B(G,f)f=v(333475-329126)s=F[n]c=c(E,s)E=h()e[E]=c Nq=579340+6295794742375 c=e[r]B=e[o]n=e[K]G=n(f,vq)F=B[G]s=v(1034438+-1030267)vq=v(430299-426050)s=c[s]s=s(c,F)c=h()e[c]=s dq=310147+10128902641385 s=e[r]n=e[o]G=e[K]f=G(vq,Yq)Yq=v(-655308-(-659489))F=v(-220946-(-225117))B=n[f]F=s[F]F=F(s,B)s=h()Pq=18656906793585-913538 e[s]=F F=e[r]G=e[o]f=e[K]vq=f(Yq,dq)dq=v(298220+-294309)B=v(-1009399-(-1013570))n=G[vq]B=F[B]B=B(F,n)n=v(54206-50257)F=h()e[F]=B G=V(92840+8316592,{r,o;K,F})B=D[n]n=B(G)f=e[o]vq=e[K]Yq=vq(dq,Pq)G=f[Yq]n=q[G]oq=16537042812074-(-205162)Pq=15369644672630-(-87423)f=e[o]vq=e[K]dq=v(603349+-599052)Yq=vq(dq,Pq)Pq=19000353896113-(-93150)G=f[Yq]B=n[G]n=v(538447-534062)n=B[n]n=n(B)B=h()e[B]=n n=e[B]f=e[o]dq=v(630330-626019)vq=e[K]Yq=vq(dq,Pq)G=f[Yq]Yq=e[o]dq=e[K]Pq=dq(tq,Qq)vq=Yq[Pq]f=b[vq]n[G]=f jq=21482363354109-300266 tq=28728223068832-818783 G=e[B]vq=e[o]Pq=v(719343+-715453)Yq=e[K]dq=Yq(Pq,tq)f=vq[dq]n=G[f]G=H(11684644-(-937885),{F,o,K})f=v(963521+-959511)D[f]=G kq=v(-482756-(-486780))f=v(745184+-740633)G=M(8842570-(-865356),{s,o;K})D[f]=G f=v(700964-697067)G=M(-877224+5953481,{o,K,s})D[f]=G f=v(625976-621807)G=M(10659068-99187,{o;K;s})D[f]=G G=nil f=h()e[f]=G G=h()vq=R(5755845-140521,{f})e[G]=vq Yq=V(9169501-(-1030212),{c,o,K;W,r;G;f})vq=h()e[vq]=Yq Pq=e[o]Yq=v(-938826+942997)tq=e[K]Qq=tq(kq,gq)tq=86504399028900-(-603680)Yq=q[Yq]dq=Pq[Qq]Pq=-759679+18554651884 Yq=Yq(q,dq)dq=h()Qq=1.2314036339666e+14 e[dq]=Yq Yq={Pq,tq}Pq=h()tq=1.1012087320608e+14 qq=32721060578649-(-554539)e[Pq]=Yq Kq=-343106+8683591306253 Yq={tq,Qq}wq=9674653323267-48746 tq=h()e[tq]=Yq gq=e[o]eq=e[K]xq=eq(hq,Kq)kq=gq[xq]Kq=15194550298810-167191 Qq=q[kq]hq=v(396894-392531)gq=e[o]eq=e[K]xq=eq(hq,Kq)kq=gq[xq]Yq=Qq[kq]Qq=v(-417287-(-421672))Kq=19182385100256-332540 Qq=Yq[Qq]Qq=Qq(Yq)Yq=h()e[Yq]=Qq Qq=e[Yq]hq=v(95152-91039)gq=e[o]eq=e[K]xq=eq(hq,Kq)kq=gq[xq]gq=e[c]Qq[kq]=gq eq=e[o]xq=e[K]Kq=v(908860+-904342)hq=xq(Kq,qq)gq=eq[hq]qq=526410+33851455485257 Kq=v(-56455+60504)kq=q[gq]eq=e[o]xq=e[K]hq=xq(Kq,qq)gq=eq[hq]Qq=kq[gq]kq=v(-165451-(-169836))hq=v(642758-638640)kq=Qq[kq]kq=kq(Qq)gq=e[o]eq=e[K]Kq=-579400+34552030107169 xq=eq(hq,Kq)qq=v(-452082-(-456116))Qq=gq[xq]gq=e[c]kq[Qq]=gq xq=e[o]hq=e[K]Kq=hq(qq,oq)eq=xq[Kq]gq=q[eq]qq=v(-839407-(-843377))xq=e[o]oq=17566605789349-(-382799)hq=e[K]Kq=hq(qq,oq)eq=xq[Kq]qq=v(-525256+529803)Qq=gq[eq]gq=v(481097+-476712)gq=Qq[gq]gq=gq(Qq)Qq=h()e[Qq]=gq gq=e[Qq]yq=-659008+18390857723827 oq=1024486+28095878664501 xq=e[o]hq=e[K]Kq=hq(qq,oq)eq=xq[Kq]xq=e[c]gq[eq]=xq hq=e[o]oq=v(-920051-(-923938))Kq=e[K]qq=Kq(oq,yq)xq=hq[qq]eq=q[xq]hq=e[o]oq=v(-903932-(-907975))Kq=e[K]yq=16210580935604-849464 qq=Kq(oq,yq)xq=hq[qq]gq=eq[xq]eq=v(692623-688238)eq=gq[eq]eq=eq(gq)gq=h()oq=v(671576-667393)yq=437559+16373880664209 e[gq]=eq eq=e[gq]hq=e[o]Kq=e[K]qq=Kq(oq,yq)xq=hq[qq]yq=v(-717815+721782)hq=e[s]eq[xq]=hq Kq=e[o]qq=e[K]oq=qq(yq,Nq)hq=Kq[oq]xq=q[hq]Kq=e[o]yq=v(377788+-373471)Nq=21947068767629-(-756318)qq=e[K]oq=qq(yq,Nq)hq=Kq[oq]eq=xq[hq]xq=v(357469+-353084)xq=eq[xq]xq=xq(eq)eq=h()e[eq]=xq Nq=9350144303636-(-863982)xq=e[eq]Kq=e[o]yq=v(99574-95301)qq=e[K]oq=qq(yq,Nq)hq=Kq[oq]Kq=e[s]xq[hq]=Kq qq=e[o]oq=e[K]Mq=7842750436744-(-571580)Nq=v(21420-17044)yq=oq(Nq,jq)jq=-301083+3520566271618 Kq=qq[yq]hq=q[Kq]qq=e[o]oq=e[K]Rq=-99874+13882422943586 Nq=v(-1034941-(-1039393))yq=oq(Nq,jq)Kq=qq[yq]xq=hq[Kq]hq=v(-324231-(-328616))hq=xq[hq]hq=hq(xq)Nq=v(-270344-(-274551))xq=h()e[xq]=hq hq=e[xq]qq=e[o]oq=e[K]jq=6752236403193-(-479823)yq=oq(Nq,jq)Kq=qq[yq]qq=e[s]hq[Kq]=qq oq=e[o]jq=v(-305455+309372)yq=e[K]Nq=yq(jq,Hq)qq=oq[Nq]jq=v(-995029+999140)Kq=q[qq]oq=e[o]Hq=-607827+23529436508447 yq=e[K]Nq=yq(jq,Hq)jq=v(-457310-(-461254))Hq=28413736011740-(-928723)qq=oq[Nq]hq=Kq[qq]Kq=v(-709306+713691)Kq=hq[Kq]Kq=Kq(hq)hq=h()e[hq]=Kq Kq=e[hq]oq=e[o]yq=e[K]Nq=yq(jq,Hq)qq=oq[Nq]jq=v(1014141+-1009980)oq=e[s]Kq[qq]=oq Kq=L(-115625+16064400,{X,o;K})qq=v(894940-890875)D[qq]=Kq qq=v(-379790+384347)Kq=L(-627629+6605146,{X,o,K})D[qq]=Kq Kq=H(-566361+10682391,{U;W;Pq;o,K,r,dq,Yq,Qq;gq;G,s;z;J,m})qq=v(-990461+994646)D[qq]=Kq Kq=j(390913+11205800,{U,W;tq,o,K;r,dq,vq;eq,gq;G,s,z;J;m})qq=v(-831141+835660)D[qq]=Kq Kq=j(-794602+8819235,{U,W,r,dq,o;K,vq;Yq;xq;G,s;z,J,m})qq=v(-164649-(-169153))D[qq]=Kq qq=v(-751488+755742)Kq=j(238549+11714192,{U,W;r,dq,o,K,vq;Yq,gq;G;s;z;J;m})D[qq]=Kq Kq=w(15217973-264852,{U;W,r;dq;o;K;vq;s;Yq,hq,gq;Qq;G;z,J,m})qq=v(-677139-(-681570))D[qq]=Kq qq=v(540622+-536193)Kq=H(-451618+5273869,{U,W;r;dq,o;K,vq;Yq;eq,G,s,z,J;m})D[qq]=Kq oq=e[o]Hq=-1024272+32009317702473 yq=e[K]Nq=yq(jq,Hq)qq=oq[Nq]Kq=b[qq]yq=e[o]Nq=e[K]Hq=v(25827+-21661)jq=Nq(Hq,wq)oq=yq[jq]Hq=v(-25260+29412)qq=v(974585+-970414)qq=Kq[qq]qq=qq(Kq,oq)yq=e[o]Kq=v(-699277+703448)wq=16213616727982-(-394704)Nq=e[K]jq=Nq(Hq,wq)Kq=qq[Kq]wq=-588352+11138327334530 oq=yq[jq]Kq=Kq(qq,oq)yq=e[o]Hq=v(145404+-140875)qq=v(618278-614107)Nq=e[K]jq=Nq(Hq,wq)oq=yq[jq]Hq=v(923119-918593)qq=Kq[qq]qq=qq(Kq,oq)wq=-850844+33117768202201 Kq=v(388852+-384468)yq=e[o]Nq=e[K]jq=Nq(Hq,wq)Hq=v(-521724+525943)Kq=qq[Kq]oq=yq[jq]Kq=Kq(qq,oq)yq=e[o]wq=30322287109749-782158 Nq=e[K]jq=Nq(Hq,wq)oq=yq[jq]wq=v(-356859-(-361056))Nq=e[o]jq=e[K]Hq=jq(wq,Mq)yq=Nq[Hq]Kq[oq]=yq yq=v(1016419-1011947)Mq=v(179303+-174899)oq=D[yq]jq=e[o]Hq=e[K]yq=v(-692841+697198)wq=Hq(Mq,Vq)yq=oq[yq]Nq=jq[wq]yq=yq(oq,Nq)Nq=e[o]wq=v(-600538+604906)Mq=-335982+19965617718463 jq=e[K]Hq=jq(wq,Mq)oq=Nq[Hq]Vq=33478933387132-(-419177)Kq=yq[oq]yq=V(5241282-(-568337),{o,K;U,a})Mq=v(575943-571987)oq=v(640316+-636049)oq=Kq[oq]oq=oq(Kq,yq)Kq=h()e[Kq]=oq jq=e[o]Hq=e[K]wq=Hq(Mq,Vq)Nq=jq[wq]yq=n[Nq]Vq=-1042443+7075993859306 jq=e[o]Mq=v(-1005013-(-1009446))Hq=e[K]wq=Hq(Mq,Vq)Nq=jq[wq]oq=yq[Nq]yq=v(738387+-734120)Mq=v(984214-980099)yq=oq[yq]Nq=M(7187127-224258,{})yq=yq(oq,Nq)jq=e[o]Vq=382417+29234938847068 Hq=e[K]wq=Hq(Mq,Vq)Mq=v(972786+-968711)Nq=jq[wq]yq=n[Nq]jq=e[o]Vq=447450+28616847581235 Hq=e[K]wq=Hq(Mq,Vq)Nq=jq[wq]Mq=v(860450-856151)oq=yq[Nq]yq=v(-952709+956976)Nq=H(5362967-(-873446),{})yq=oq[yq]yq=yq(oq,Nq)Vq=14918744402456-577269 jq=e[o]Hq=e[K]wq=Hq(Mq,Vq)Mq=v(-170274+174216)Nq=jq[wq]yq=n[Nq]jq=e[o]Hq=e[K]Vq=24706118960040-480952 wq=Hq(Mq,Vq)Nq=jq[wq]Mq=v(-509207+513427)oq=yq[Nq]yq=v(-962750-(-967017))Vq=13398092352405-(-953545)Nq=w(3008952-240576,{})yq=oq[yq]yq=yq(oq,Nq)jq=e[o]Hq=e[K]wq=Hq(Mq,Vq)Nq=jq[wq]Vq=112418+14414085415702 Mq=v(1032120+-1027924)yq=n[Nq]jq=e[o]Hq=e[K]wq=Hq(Mq,Vq)Nq=jq[wq]Mq=v(-737116+741347)oq=yq[Nq]Nq=H(1226052-(-903159),{})yq=v(-18365-(-22632))yq=oq[yq]yq=yq(oq,Nq)Vq=-322940+17604285173121 jq=e[o]Hq=e[K]wq=Hq(Mq,Vq)Nq=jq[wq]yq=n[Nq]Vq=-331651+13087026767697 jq=e[o]Mq=v(781058-776913)Hq=e[K]wq=Hq(Mq,Vq)Nq=jq[wq]oq=yq[Nq]Mq=v(-837802+842204)yq=v(819423-815156)Nq=M(-972056+3255682,{})yq=oq[yq]yq=yq(oq,Nq)Vq=20690932182927-(-112147)jq=e[o]Hq=e[K]wq=Hq(Mq,Vq)Nq=jq[wq]yq=n[Nq]jq=e[o]Vq=-600538+9632267205471 Hq=e[K]Mq=v(83105-78621)wq=Hq(Mq,Vq)Vq=18802880722431-(-764980)Nq=jq[wq]oq=yq[Nq]Nq=H(-711743+4756751,{})yq=v(-306053+310320)yq=oq[yq]yq=yq(oq,Nq)jq=e[o]Hq=e[K]Mq=v(280296-276167)wq=Hq(Mq,Vq)Nq=jq[wq]yq=n[Nq]jq=e[o]Hq=e[K]Vq=23424450975562-535727 Mq=v(-503680+508177)wq=Hq(Mq,Vq)Nq=jq[wq]oq=yq[Nq]yq=v(561182-556915)Nq=H(741702+10043367,{U,a})yq=oq[yq]yq=yq(oq,Nq)Nq=v(-156934+161406)Vq=v(701663+-697135)yq=D[Nq]Nq=v(276549+-272192)Nq=yq[Nq]Hq=e[o]wq=e[K]Mq=wq(Vq,Iq)jq=Hq[Mq]Nq=Nq(yq,jq)Mq=v(-900490+904563)jq=e[o]Hq=e[K]Vq=20047670808327-(-988528)wq=Hq(Mq,Vq)yq=jq[wq]oq=Nq[yq]jq=v(764075+-759603)yq=v(504085+-499818)yq=oq[yq]Nq=M(-812402+15306554,{o;K,a})Iq=v(552236+-547684)yq=yq(oq,Nq)oq=h()e[oq]=yq Nq=D[jq]wq=e[o]jq=v(-532227-(-536584))Mq=e[K]Vq=Mq(Iq,Rq)jq=Nq[jq]Hq=wq[Vq]Iq=9520838907756-132635 Vq=v(-850022-(-854177))jq=jq(Nq,Hq)Hq=e[o]wq=e[K]Mq=wq(Vq,Iq)Iq=v(471858+-467598)Nq=Hq[Mq]yq=jq[Nq]Nq=v(4243-(-24))Rq=11418979376231-(-391262)Nq=yq[Nq]Hq=v(611071-606671)jq=w(84194+16198902,{F,o;K,s;E;U;r,dq;a;A;J,m,u,z})Nq=Nq(yq,jq)yq=h()e[yq]=Nq jq=D[Hq]Hq=jq()wq=e[o]Mq=e[K]Vq=Mq(Iq,Rq)jq=wq[Vq]Nq=Hq[jq]Y=Nq and 3395405-582565 or 3498171-662491 end end else if Y<507405+4760758 then if Y<-183725+5415771 then N=-322716-(-322718)K=e[t[-907476+907477]]o=-397906-(-397907)q=K(o,N)K=358507-358506 x=q==K g=x Y=x and 912858+1266523 or 2285755-44867 else g=S Y=T Y=7473294-426370 end else if Y<-621822+5948394 then p=Y E=nil U=q~=E b=U Y=U and 457740+4999473 or 592095+6484068 else Y=D[v(-504409+508807)]g={}x=nil end end end else if Y<246073+5389020 then if Y<4758877-(-728573)then if Y<351574+5100399 then Y=z and 12120642-(-2253)or 179742+3782386 else s=false c=e[t[-305995+306001]]E=Y r=c==s Y=r and-629925+10722964 or-517158+10119986 U=r end else if Y<4912306-(-626091)then g={}Y=D[v(95087-90772)]x=nil q=nil o=nil else Y=e[t[-470491-(-470492)]]Y=Y and 1436813-(-350750)or 9862765-(-484011)end end else if Y<5695465-(-112785)then if Y<6455043-803466 then Y=g and 1572050-(-179159)or 6735760-473793 else S=v(-327203+331268)Y=true e[t[-408459+408469]]=Y g=D[S]T=e[t[629575+-629568]]a=v(-408886-(-412883))O=e[t[232577-232569]]m=e[t[-540027+540029]]z=27244054957220-(-156906)A=e[t[712063+-712060]]Y=691653+-602668 u=A(a,z)J=m[u]X=O[J]O=.1 J=654770-654769 S=g(T,X,O,J)end else K=P[-716827+716829]Y=K and-648290+1707173 or 294321+229614 x=P[686591+-686590]end end end end else if Y<502128+5940070 then if Y<-673670+6919794 then if Y<548165+5533016 then if Y<5839240-(-201190)then if Y<-408097+6365793 then J=v(-817694+821900)O=D[J]g=O Y=815893+13618956 else q=e[t[1022897+-1022896]]K=P[-616641-(-616643)]x=P[636716+-636715]g=q[x]Y=not g Y=Y and 1032564+8173666 or 251923+11337067 end else if Y<6472139-405682 then l=v(-533066-(-537065))b=v(-1011749-(-1015815))W=75656+33567151265158 E=v(-673428+677838)Dq=v(-670150-(-674352))m=v(526523-522334)i=-705363+14380255583611 a=v(-937521-(-941430))r=58892+5273273525131 J=D[m]u=D[a]Y=15646620-253384 c=v(-65614-(-69617))z=e[t[-114905+114910]]C=e[t[298335-298329]]Z=C(l,W)p=-537081+29230471358244 a=z[Z]A=u[a]z=e[t[-434+445]]Z=e[t[564057-564052]]l=e[t[-169706-(-169712)]]W=l(b,p)C=Z[W]a=z[C]W=v(-370110+374148)m=v(187940-184035)l=D[W]b=e[t[298165-298160]]p=e[t[108286-108280]]U=p(E,r)W=b[U]Z=l[W]s=7520282742537-737628 b=e[t[106236+-106225]]U=e[t[714187+-714182]]E=e[t[-918133-(-918139)]]r=E(c,s)p=U[r]W=b[p]U=e[t[-278337-(-278348)]]r=e[t[-619104-(-619109)]]c=e[t[158632+-158626]]s=c(Dq,i)E=r[s]p=U[E]r=v(970145+-966033)F=-673336+28084502083917 i=v(297854-293517)m=J[m]E=D[r]c=e[t[-318690+318695]]s=e[t[453845-453839]]Dq=s(i,F)r=c[Dq]c=567405-567406 U=E[r]s=649050-649050 r=55247-55247 E=U(r,c,s)b=p+E l=Z(W,b)U=v(78217-74211)W=e[t[-673649-(-673654)]]E=22266238651164-238236 b=e[t[686993-686987]]p=b(U,E)Z=W[p]C=l[Z]Z=-503645+503649 z=C*Z u=A(a,z)A=e[t[516339+-516336]]m=m(J,u,A)X=m else Y=X Y=T and 15176491-(-597926)or 2620391-489927 end end else if Y<5982821-(-194563)then if Y<5485595-(-648858)then N=o A=-160695+9279042176151 Y=v(-1019775-(-1024126))X=e[t[-115229+115230]]O=e[t[-169642+169644]]m=v(256169+-251701)J=O(m,A)Y=S[Y]T=X[J]Y=Y(S,T)Y=Y and 3385827-488135 or-115625+14416809 else Y=-157228+15511199 Z=m==A C=Z end else if Y<-165188+6391028 then Y=11338969-293164 W=389339+-389339 z=#u a=z==W else g=v(540407+-535888)Y=D[g]g=Y()Y=D[v(-458742-(-463071))]g={}end end end else if Y<-149043+6439882 then if Y<5676194-(-588800)then if Y<5773026-(-483260)then O=Y u=e[t[1003848+-1003837]]z=e[t[-534024+534029]]W=13463827665750-(-771367)C=e[t[631084-631078]]l=v(-430042-(-434541))Z=C(l,W)a=z[Z]A=u[a]Z=v(877419+-873314)a=e[t[-472179+472184]]z=e[t[382664+-382658]]l=-151509+23702040247026 C=z(Z,l)u=a[C]m=A[u]A=-718416-(-718417)J=m>A X=J Y=J and-557317+1270561 or 14215367-510529 else K=e[t[425394-425389]]g=-782736-(-782737)x=#K K=x x=73539+-73538 q=x x=-630246-(-630246)o=q<x x=g-q Y=-457594+4462495 end else if Y<5722713-(-563594)then Y=11158383-(-247957)X=J l=v(1043346-1038903)Z=D[l]l=v(822991-819073)C=Z[l]Z=C(x,X)C=e[t[208071+-208065]]l=C()X=nil z=Z+l a=z+S z=803274-803018 u=a%z S=u l=-41047+41048 z=q[K]Z=S+l C=o[Z]a=z..C q[K]=a else o,S=K(q,o)Y=o and 11303400-(-282664)or-547248+3686795 end end else if Y<6927224-588770 then if Y<5873589-(-426406)then Y=g and-800731+16637993 or 14549443-(-199068)else Y=nil x=P[-761122-(-761123)]X=24819341998578-(-193331)q=v(-93673-(-97628))T=v(875213+-871181)K=Y g=D[q]o=e[t[-820931+820932]]N=e[t[302317+-302315]]S=N(T,X)X=v(693350-689470)q=o[S]T=v(-556041+560230)Y=g[q]q=Y g=v(-613990+618158)Y=D[g]S=D[T]X=S[X]T={X(S)}S={Y(d(T))}Y=11807937-(-630572)N=S[-748893-(-748896)]g=S[249680-249679]o=S[22849-22847]S=g end else if Y<6925968-528193 then g={}Y=D[v(903547-899064)]x=nil else g=true K=v(-26229+30294)m=12475291072012-155483 Y=true e[t[523993-523992]]=Y e[t[323014-323012]]=g x=D[K]q=e[t[-639609-(-639612)]]N=e[t[-54494-(-54498)]]J=v(-335478+339363)T=e[t[-137653-(-137658)]]X=e[t[18624+-18618]]O=X(J,m)S=T[O]o=N[S]N=600707+-600706 K=x(q,o,N)x=e[t[-831852-(-831859)]]X=28886563574961-581670 T=v(-658993+663065)q=x()o=e[t[-613319-(-613324)]]A=v(-66304-(-70457))N=e[t[25032+-25026]]S=N(T,X)q=o[S]x=K[q]o=w(-714843+4808084,{t[590264+-590259];t[738499+-738493],t[342755+-342747]})q=v(1033229-1028962)q=x[q]q=q(x,o)O=18758831252632-(-884103)X=v(537744+-533735)N=e[t[-415486+415491]]S=e[t[981779-981773]]T=S(X,O)o=N[T]x=K[o]o=v(616192-612103)o=x[o]o=o(x)o=v(514138-510073)x=D[o]u=-552788+8001841151458 N=e[t[662037-662034]]T=e[t[383577-383573]]O=e[t[743438-743433]]J=e[t[-894851-(-894857)]]m=J(A,u)X=O[m]S=T[X]T=-178335-(-178336)o=x(N,S,T)J=32216556520834-35560 S=e[t[703740-703735]]m=155410+26299374588100 O=v(169634-165226)T=e[t[-145044+145050]]X=T(O,J)N=S[X]S=M(-544602+11185567,{t[-691493+691498],t[-54223-(-54229)],t[-1034212-(-1034221)]})x=o[N]N=v(88105-83838)N=x[N]J=v(639395-635265)N=N(x,S)T=e[t[-52818+52823]]X=e[t[-554937-(-554943)]]O=X(J,m)S=T[O]x=o[S]S=v(-832250-(-836339))T=v(342126+-338160)S=x[S]S=S(x)x=false e[t[-507348+507349]]=x l=23428002045920-800067 X=v(-665172-(-669723))O=false T=q[T]S=false e[t[-73646-(-73648)]]=S T=T(q)T=v(-659863+663829)T=N[T]Z=v(-27825-(-32107))T=T(N)T=D[X]X=T(O)T=e[t[-404734-(-404744)]]X=T()X=Y A=e[t[-693988-(-693999)]]a=e[t[171010-171005]]z=e[t[695845+-695839]]C=z(Z,l)u=a[C]Z=-30084+7623623623522 m=A[u]C=v(-571164+575706)u=e[t[539311-539306]]a=e[t[-935343-(-935349)]]z=a(C,Z)A=u[z]J=m[A]m=-537981-(-537982)O=J<m T=O Y=O and 882391+10442362 or 6702100-635574 end end end end else if Y<6075756-(-702916)then if Y<-321730+6998466 then if Y<-933009+7475027 then if Y<-572850+7032470 then m=v(554833+-550644)E=v(217718-213385)a=v(488726+-484817)J=D[m]c=v(891242+-887283)u=D[a]z=e[t[527753-527749]]p=81480+9078739784251 b=v(827437-823500)l=v(476038-471934)W=-45702+21119852009712 C=e[t[-233453+233458]]Z=C(l,W)m=v(-245104-(-249009))a=z[Z]F=12839345515088-(-503050)A=u[a]r=6087109055019-(-80103)m=J[m]z=e[t[-286806-(-286818)]]Z=e[t[875784+-875780]]l=e[t[-551784-(-551789)]]Dq=v(394405-390407)W=l(b,p)C=Z[W]s=604688+7417842307950 a=z[C]W=v(-169849+173887)l=D[W]b=e[t[-457227+457231]]p=e[t[-611963-(-611968)]]U=p(E,r)W=b[U]Z=l[W]b=e[t[742131-742119]]U=e[t[148009-148005]]E=e[t[-308426+308431]]r=E(c,s)p=U[r]i=689498+12599305163153 W=b[p]U=e[t[507594+-507582]]r=e[t[-907606-(-907610)]]c=e[t[1030800-1030795]]s=c(Dq,i)E=r[s]r=v(-390040+394152)i=v(676281+-672070)p=U[E]E=D[r]c=e[t[-1021464-(-1021468)]]s=e[t[919148+-919143]]Dq=s(i,F)r=c[Dq]U=E[r]r=1002447-1002447 c=-6034+6033 s=-65643-(-65643)E=U(r,c,s)b=p+E Y=84162+10947882 E=4086923879488-(-271151)l=Z(W,b)W=e[t[246722-246718]]b=e[t[-964693-(-964698)]]U=v(789414+-785076)p=b(U,E)Z=W[p]C=l[Z]Z=742284+-742280 z=C*Z u=A(a,z)A=e[t[-48342-(-48348)]]m=m(J,u,A)X=m else Y=g and 2551588-193827 or-878620+8804725 end else if Y<6406350-(-240909)then K=v(-24600+28769)q=-1041189+18695796691 Y=D[K]K=Y(q)K=v(622626+-618729)Y=D[K]K=Y()Y=-530563+14021723 else Y=D[v(341608-337197)]g={K}end end else if Y<5951536-(-777606)then if Y<-921934+7638996 then K=e[t[676111-676110]]o=e[t[-186909-(-186911)]]X=28418186857878-661989 T=v(209112-204989)N=e[t[614803-614800]]S=N(T,X)q=o[S]x=K[q]q=e[t[-812757-(-812759)]]S=v(370481+-366271)o=e[t[-153663-(-153666)]]T=9497588847124-(-982834)N=o(S,T)K=q[N]g=x[K]x=e[t[1004527-1004523]]Y=g<x Y=Y and 3711315-518527 or 12670170-302257 else K=Y o=e[t[511399-511398]]S=e[t[818216+-818214]]T=e[t[255694-255691]]J=-363867+30368895009944 O=v(321437+-317370)X=T(O,J)N=S[X]q=o[N]x=q Y=q and 47572+462406 or 2963+10667637 end else if Y<5932444-(-815471)then K=v(743444-739309)Y=D[K]N=e[t[422276+-422273]]T=v(-631857-(-635904))T=N[T]S={T(N)}N={Y(d(S))}o=N[223129-223126]Y=1788239-370416 K=N[69183-69182]q=N[-291233+291235]else g=v(190693-186683)Y=D[g]K=-862127-(-862142)g=Y(K)Y=16152093-(-496006)end end end else if Y<6296621-(-531180)then if Y<-104161+6904074 then if Y<7028617-237539 then g=v(1032068-1027532)Y=e[t[-292534+292545]]g=Y[g]J=e[X]C=-345191+11021379475571 A=e[t[165422+-165420]]z=v(502568-498576)u=e[t[336881+-336878]]a=u(z,C)m=A[a]S=J[m]g=g(Y,S)Y=351350+384154 else Y=D[v(482830-478477)]g={}end else if Y<633781+6188853 then o,S=K(q,o)Y=o and-143361+9096786 or-246253+2463313 else Y=D[v(709728+-705397)]g={}end end else if Y<647174+6252622 then if Y<969062+5895051 then m=nil O=y(O)K=y(K)J=y(J)S=nil A=nil z=y(z)o=y(o)o=h()N=y(N)q=y(q)T=y(T)A=h()u=nil K=nil q=nil S=v(280624-276669)e[o]=K K=h()e[K]=q a=nil T=v(312597+-308642)O=v(-274841+279284)X=nil m={}N=D[S]S=v(188696+-184650)X=v(456471+-452007)z=210198-209942 q=N[S]J=h()N=h()e[N]=q S=D[T]T=v(-57912-(-61837))q=S[T]T=D[X]X=v(-739387-(-743375))S=T[X]X=D[O]O=v(202372-198322)T=X[O]X=-709511+709511 O=h()e[O]=X Y=91251+15524474 X=-678525+678527 e[J]=X u={}X={}e[A]=m m=313130-313130 W=z a=979724+-979723 z=-1004481+1004482 b=z z=360773+-360773 p=b<z z=a-b else K=P[6628+-6626]g=-193575-(-193575)x=P[525626-525625]Y=K<g Y=Y and 10522054-(-894641)or 12736064-966354 end else Y=D[v(-421323-(-425601))]g={}end end end end end else if Y<7940897-309468 then if Y<7817516-432092 then if Y<6917256-(-160881)then if Y<7545352-492448 then if Y<475440+6505728 then if Y<-465554+7389991 then q,S=o(K,q)Y=q and 497775+-228659 or 9979517-76322 else g=v(34397+-30212)Y=D[g]g=Y()Y=D[v(320145+-315721)]g={}end else if Y<354190+6684654 then Y=true Y=Y and 1876763-(-286471)or 6609605-(-290541)else Y=g and-1018346+5345852 or-670079+17281141 end end else if Y<273403+6798892 then if Y<-176072+7243999 then g={}Y=D[v(360439+-355934)]else J=false O=false X=true b=v(59579-55648)A=v(-72815-(-76880))e[t[-340590-(-340603)]]=X e[t[691917+-691903]]=O e[t[201765-201750]]=J m=D[A]u=e[t[744308+-744302]]z=e[t[-211442-(-211449)]]Z=e[t[-490702-(-490706)]]l=e[t[980128+-980123]]Y=10170739-(-274890)p=944368975288-(-672767)W=l(b,p)C=Z[W]a=z[C]z=-717175-(-717176)A=m(u,a,z)end else if Y<-1035274+8110965 then g=v(490756+-486587)K=-678155+17373853981 Y=D[g]S=v(-105767-(-109814))g=Y(K)g=v(-93757+98308)K=true Y=D[g]g=Y(K)g=v(484295-480160)Y=D[g]o=e[t[830920-830917]]S=o[S]N={S(o)}o={Y(d(N))}g=o[1003773-1003772]Y=8294413-266620 K=o[879702+-879700]q=o[-295581+295584]o=g else l=b Y=p Y=11880310-(-146361)end end end else if Y<6901631-(-315706)then if Y<6948304-(-215963)then if Y<200775+6913096 then o=e[t[-406278-(-406279)]]X=18095826466795-(-207103)N=e[t[808699-808697]]T=v(-171524+175417)S=N(T,X)q=o[S]g=x[q]m=125592+16686434202562 S=v(1026416+-1022308)N=D[S]T=e[t[789736+-789735]]X=e[t[977012-977010]]J=v(864593+-860538)O=X(J,m)S=T[O]o=N[S]S=e[t[815298+-815297]]J=84785+28980392929670 O=v(-514968+519482)T=e[t[281534-281532]]X=T(O,J)N=S[X]q=o[N]Y=g==q Y=Y and 13515339-(-235151)or 4523351-676854 else Y=-944300+13382809 T=nil X=nil end else if Y<6234633-(-950807)then q=e[t[629180-629179]]S=v(791943-787821)o=e[t[-735356+735358]]T=33923468144146-(-511906)N=o(S,T)K=q[N]Y=x==K Y=Y and-827691+16124649 or 216287+365618 else z=v(-659978+664043)m=false u=false A=true Y=558122-(-549909)e[t[406658+-406644]]=m e[t[759215+-759200]]=A e[t[59800+-59784]]=u a=D[z]C=e[t[149959+-149956]]r=23443113067638-(-1009198)l=e[t[-754981+754985]]b=e[t[-665674-(-665679)]]E=v(-302588+306542)p=e[t[576054+-576048]]U=p(E,r)W=b[U]Z=l[W]l=-131004+131005 z=a(C,Z,l)end end else if Y<154861+7151527 then if Y<7384862-100954 then z=v(207586-203232)A=e[t[438832+-438831]]u=e[t[384648+-384646]]C=853166+4438921888613 a=u(z,C)C=v(1012037-1007952)Z=10449916188770-(-588448)m=A[a]J=K[m]u=e[t[-817324-(-817325)]]Y=1004138-(-1002252)a=e[t[640206-640204]]z=a(C,Z)A=u[z]m=v(171459-167075)m=J[m]m=m(J,A)X=m else X=2733518508500-363740 T=v(-1026390-(-1030516))J=v(-836080-(-840612))o=e[t[848038+-848037]]N=e[t[-289156+289158]]S=N(T,X)q=o[S]S=v(486560+-482452)g=x[q]N=D[S]T=e[t[-906011-(-906012)]]m=33384018323176-(-316881)X=e[t[-138308+138310]]O=X(J,m)J=-301369+1244790610812 S=T[O]o=N[S]O=v(665200+-660763)S=e[t[22669+-22668]]T=e[t[286762+-286760]]X=T(O,J)N=S[X]q=o[N]Y=g==q Y=Y and 10436584-761775 or 6106723-(-977761)end else if Y<6430492-(-923500)then x=P[862109-862108]S=32722155883690-(-208603)K=e[t[-538584-(-538585)]]q=e[t[-254015+254017]]N=v(790332+-786455)o=q(N,S)g=K[o]Y=x==g Y=Y and 7084982-(-363746)or-967947+6329436 else T=932057+-932056 N=q or T S=Y Y=v(-329579+333871)Y=o[Y]Y=Y(o,N)Y=13626858-(-617780)end end end end else if Y<7869686-410986 then if Y<7457789-34256 then if Y<8250007-859857 then if Y<7783231-397269 then X=e[t[-438538+438539]]Y=v(49581-45230)O=e[t[-405485+405487]]Y=S[Y]N=o A=632187+31784479577173 m=v(80890+-76497)J=O(m,A)T=X[J]Y=Y(S,T)Y=Y and-120212+1564796 or 641131+12550447 else q=nil K=nil Y=D[v(561903+-557976)]g={}end else if Y<6945468-(-475801)then Y=X Y=-361830+16818985 g=T else N=o X=e[t[-547032+547033]]O=e[t[309590-309588]]m=v(1003053+-999001)A=91710+33643459532532 J=O(m,A)T=X[J]Y=v(-739718+744069)Y=S[Y]Y=Y(S,T)Y=Y and 1011816-(-241195)or 10155031-998719 end end else if Y<-233736+7668591 then if Y<6787348-(-640290)then g={}Y=true e[t[-29155-(-29156)]]=Y Y=D[v(-3009+7296)]else Y=S Y=N and 15412522-(-721836)or-657761+2574171 end else if Y<7768171-330789 then S=true T=false Y=4919775-(-588282)X=false e[t[-286475-(-286488)]]=S e[t[115850-115836]]=T J=v(-875938+880003)e[t[-424679+424694]]=X O=D[J]m=e[t[-785624+785630]]l=v(311131-306724)u=e[t[735013-735006]]W=29949969960698-(-681856)z=e[t[-497671+497675]]C=e[t[-614225-(-614230)]]Z=C(l,W)a=z[Z]A=u[a]u=-929427-(-929428)J=O(m,A,u)else K=18694716746-(-38756)g=v(497403+-493234)Y=D[g]g=Y(K)g=v(782233+-778336)Y=D[g]g=Y()S=v(593927+-589880)g=v(-309229-(-313364))Y=D[g]o=e[t[866336+-866333]]S=o[S]N={S(o)}o={Y(d(N))}Y=6961593-(-852875)g=o[721899+-721898]K=o[-803587+803589]q=o[630868+-630865]o=g end end end else if Y<8401198-854939 then if Y<6539836-(-954959)then if Y<-573949+8046335 then m=v(-886424-(-890333))X=v(384254+-380065)T=D[X]J=D[m]r=v(-396333+400316)C=34314187957750-485260 z=v(269645-265433)A=e[t[-896349-(-896354)]]c=30713307658290-294996 l=6026921591390-(-329880)u=e[t[187070+-187064]]E=-748217+6171665528306 a=u(z,C)m=A[a]O=J[m]A=e[t[489907-489896]]a=e[t[198677+-198672]]Z=v(-935494+939654)z=e[t[-368497+368503]]C=z(Z,l)u=a[C]Y=-232662+13352380 m=A[u]C=v(178651+-174613)U=v(-762433-(-766808))z=D[C]Z=e[t[-430275-(-430280)]]l=e[t[-843820+843826]]p=-946774+31641044429796 X=v(-732037+735942)b=v(-108451+112864)s=-921650+15362309450787 W=l(b,p)C=Z[W]a=z[C]Z=e[t[331314-331303]]W=e[t[-656252+656257]]b=e[t[311419-311413]]p=b(U,E)l=W[p]C=Z[l]W=e[t[806178-806167]]p=e[t[-679674-(-679679)]]U=e[t[-551996-(-552002)]]E=U(r,c)b=p[E]l=W[b]p=v(717795+-713683)b=D[p]U=e[t[-673238-(-673243)]]E=e[t[-859188+859194]]c=v(426958+-422514)r=E(c,s)p=U[r]E=-26967-(-26967)U=-31079+31078 W=b[p]p=25780-25780 b=W(p,U,E)Z=l+b W=v(-973757-(-978237))z=a(C,Z)b=18486787316371-(-476941)C=e[t[1032479+-1032474]]Z=e[t[-7694+7700]]l=Z(W,b)a=C[l]u=z[a]X=T[X]a=656963+-656959 A=u*a J=O(m,A)O=e[t[-323892-(-323895)]]X=X(T,J,O)N=X else Y=e[t[478843-478837]]Y=Y and-370116+4515731 or 14401258-(-442327)end else if Y<1044834+6472586 then q=e[t[-406787+406788]]o=e[t[-354420+354422]]S=v(882539+-878470)T=-421231+31617572103922 N=o(S,T)K=q[N]Y=x==K Y=Y and-243140+13057880 or 12242519-316588 else O=e[t[365942+-365928]]J=false X=O==J Y=X and 4161+2376221 or 140212+12645845 end end else if Y<6892773-(-716803)then if Y<7301592-(-268044)then U=-225684+225784 b=h()e[b]=C p=v(-529789-(-533744))g=D[p]p=v(-222463+226388)E=-498857+499112 Y=g[p]p=80782-80781 F=v(663282-658984)g=Y(p,U)p=h()s=371265+-371263 e[p]=g U=-752038+752038 f=290618-280618 Y=e[T]g=Y(U,E)U=h()e[U]=g c=894858-894857 E=1004198-1004197 Y=e[T]r=e[p]g=Y(E,r)E=h()e[E]=g g=e[T]r=g(c,s)G=-1031743+1031743 g=-57551-(-57552)Y=r==g r=h()g=v(17272+-13287)e[r]=Y s=v(-134235-(-138599))Y=v(-6864-(-11073))i=D[F]B=e[T]n={B(G,f)}F=i(d(n))i=v(457854-453490)Y=a[Y]Dq=F..i c=s..Dq Y=Y(a,g,c)c=h()s=v(-869457-(-873406))e[c]=Y g=D[s]Dq=V(522466+4678951,{T;b;J,q;K;z;r,c;p,E,U,O})s={g(Dq)}Y={d(s)}s=Y Y=e[r]Y=Y and-755491+15451065 or 8127746-(-85262)else T=34256444295397-608918 S=v(762610+-758584)q=e[t[-783755+783756]]o=e[t[620241+-620239]]N=o(S,T)K=q[N]Y=x==K Y=Y and-429863+1457238 or 5523333-(-864854)end else K=e[t[-700319+700322]]q=e[t[277254+-277250]]N=v(589086-584654)T=20302260906564-(-473769)S=-206300+7998403032168 o=q(N,S)S=v(423234+-418891)g=K[o]Y=x[g]q=e[t[-126125+126128]]K=Y o=e[t[-936259+936263]]N=o(S,T)Y=v(-233108+237412)Y=K[Y]g=q[N]Y=Y(K,g)q=Y Y=q and-951072+14168380 or 9223800-216597 end end end end else if Y<7811719-(-260423)then if Y<7180852-(-783343)then if Y<774604+7085427 then if Y<8184827-450840 then if Y<7219237-(-427382)then u=29377035352122-328395 Z=30342562025173-(-75868)A=v(-512556+517104)O=e[t[-566844-(-566845)]]J=e[t[-880352-(-880354)]]m=J(A,u)X=O[m]T=x[X]a=v(276994-272940)z=600192+11719958228177 O=v(455959+-451487)X=D[O]m=e[t[-521041-(-521042)]]O=v(63141-58784)A=e[t[-616920+616922]]O=X[O]C=v(-836245+840525)u=A(a,z)A=v(-612348-(-616775))J=m[u]O=O(X,J)m=D[A]u=e[t[911314+-911313]]a=e[t[-128056+128058]]z=a(C,Z)C=v(-547336-(-551503))A=u[z]Z=20028104771451-992013 J=m[A]X=v(-501335-(-505523))X=O[X]m=J(q,o,N)u=e[t[400558+-400557]]a=e[t[654024-654022]]z=a(C,Z)A=u[z]u=v(166690-162209)Y=D[v(-915814-(-919939))]u=T[u]u=u(T,K,S)J={[A]=u}X=X(O,x,m,J)O=v(419982+-415690)g={X}O=X[O]O=O(X)else x=nil Y=-670131+13038044 end else if Y<7765740-(-43594)then Y=267973+5993994 else q,S=o(K,q)Y=q and 14025718-385921 or 13124959-754320 end end else if Y<144687+7776650 then if Y<8023711-148556 then g=16600593-947811 q=173790+6455884 K=v(-16376-(-20898))x=K^q Y=g-x x=Y g=v(-555406-(-559562))Y=g/x g={Y}Y=D[v(86662-82585)]else S=e[t[-272620-(-272621)]]A=v(236233-231885)O=v(162932-159011)T=e[t[1019378-1019376]]J=17265316047292-(-636331)X=T(O,J)N=S[X]X=v(743283-739175)o=x[N]T=D[X]O=e[t[-623345+623346]]u=31122038907606-731706 J=e[t[352622-352620]]m=J(A,u)X=O[m]m=v(-825164-(-829387))Y=245635+12628848 S=T[X]X=e[t[-1045543-(-1045544)]]A=31301544522972-539629 O=e[t[1024309-1024307]]J=O(m,A)T=X[J]N=S[T]q=o==N g=q end else if Y<8493643-543443 then o=v(404354+-400388)Y=706460+1841324 K=e[t[-365051+365056]]o=K[o]o=o(K)else q,S=o(K,q)Y=q and 15990218-505507 or 12833051-(-968080)end end end else if Y<705152+7315188 then if Y<8307069-318082 then if Y<7011908-(-963305)then o=e[t[-533461-(-533462)]]T=v(-184074+188017)X=-990433+6276847757387 N=e[t[723386+-723384]]m=1012261+27212352831322 S=N(T,X)q=o[S]g=x[q]J=v(-702797-(-706685))S=v(47764-43656)N=D[S]T=e[t[-304050+304051]]X=e[t[-70500+70502]]O=X(J,m)J=-242344+5715855293709 S=T[O]o=N[S]O=v(-518393-(-522870))S=e[t[913338-913337]]T=e[t[414687-414685]]X=T(O,J)N=S[X]q=o[N]Y=g==q Y=Y and 8635676-(-741544)or 636483+6658485 else a=e[t[-83140+83153]]z=false u=a==z Y=u and 15187148-(-270220)or 12666743-510955 end else if Y<-742396+8734633 then o=e[t[323476-323475]]T=v(559709-555184)X=11171234164048-(-632578)N=e[t[-308116+308118]]S=N(T,X)q=o[S]J=v(-1021934+1026048)S=v(143740+-139632)g=x[q]N=D[S]m=14982761903254-809302 T=e[t[-596088-(-596089)]]X=e[t[829720-829718]]O=X(J,m)S=T[O]o=N[S]J=25611468688905-728947 S=e[t[450886-450885]]O=v(-163877-(-167968))T=e[t[811031-811029]]X=T(O,J)N=S[X]q=o[N]Y=g==q Y=Y and-542846+11238727 or 421147+1879673 else q=e[t[633963+-633962]]S=v(-63784-(-68304))T=-701892+22895725928297 o=e[t[505014+-505012]]N=o(S,T)K=q[N]Y=x==K Y=Y and 10812686-(-311416)or-746270+14237430 end end else if Y<8676437-648451 then if Y<7700685-(-326699)then Y=e[t[348425+-348424]]Y=Y and 930352+11777901 or 526014+5903417 else q,S=o(K,q)Y=q and-252832+12361961 or 13839281-347288 end else U=9535674476298-742834 a=v(17321-13132)u=D[a]Z=v(-295181+299090)a=v(94524-90619)C=D[Z]l=e[t[517266+-517261]]p=v(-980462+984565)r=11224112853444-712026 n=13659231172511-646855 W=e[t[-623309+623315]]b=W(p,U)Z=l[b]i=v(999826-995866)z=C[Z]l=e[t[156355+-156347]]b=e[t[443922+-443917]]p=e[t[804707-804701]]E=v(467681+-463588)G=756015+29691328179411 U=p(E,r)W=b[U]Z=l[W]Dq=2134866804723-228369 U=v(407114+-403076)p=D[U]E=e[t[-694363+694368]]s=v(-112470+116428)r=e[t[875668+-875662]]c=r(s,Dq)F=618643+12694983566980 U=E[c]b=p[U]E=e[t[662987-662979]]c=e[t[-113524-(-113529)]]s=e[t[747426-747420]]Dq=s(i,F)B=v(323728+-319298)r=c[Dq]U=E[r]c=e[t[-937114+937122]]Dq=e[t[-273831+273836]]i=e[t[-24689-(-24695)]]F=i(B,n)s=Dq[F]r=c[s]n=v(682197-678232)Dq=v(-419078+423190)s=D[Dq]i=e[t[-571135-(-571140)]]F=e[t[-647061-(-647067)]]B=F(n,G)Dq=i[B]c=s[Dq]F=348149+-348149 Dq=687051+-687051 i=340717+-340718 a=u[a]s=c(Dq,i,F)c=v(-870330-(-874280))E=r+s p=b(U,E)s=14313381651621-(-505188)Y=12465582-(-472582)U=e[t[-428661+428666]]E=e[t[-490105+490111]]r=E(c,s)b=U[r]W=p[b]b=-1005170-(-1005174)l=W*b C=z(Z,l)z=e[t[-785928+785931]]a=a(u,C,z)m=a end end end else if Y<9016075-610592 then if Y<8218690-(-87538)then if Y<7391836-(-836642)then if Y<7825533-(-304137)then Y=e[t[384210-384204]]C=v(-123712-(-127889))m=e[X]u=e[t[-958585+958587]]Z=-940967+9080305118251 a=e[t[389248+-389245]]z=a(C,Z)A=u[z]J=m[A]u=e[t[224794-224792]]C=v(432207-428315)a=e[t[-1027950-(-1027953)]]Z=12167+1433128178452 z=a(C,Z)A=u[z]m=T[A]S=J-m g=Y(S)Y=4935735-19827 else i=e[K]Y=i and 144352+2327855 or 287481+8215158 Dq=i end else if Y<7623765-(-627887)then T=721833+-721828 Y=v(321958+-317979)Y=S[Y]Y=Y(S,T)Y=863436-402622 else Y=8637592-673648 S=nil N=nil end end else if Y<-430246+8762326 then if Y<-210339+8523643 then l=v(-649537+653888)b=e[t[-146540-(-146541)]]Z=Y l=a[l]E=v(-186880-(-191259))r=19768259844139-(-461770)p=e[t[-986065+986067]]U=p(E,r)W=b[U]l=l(a,W)Y=l and 978551+11327061 or 582425+16064011 C=l else X=v(-258990-(-263098))u=999823+32522964679065 T=D[X]O=e[t[726711+-726710]]J=e[t[263629-263627]]A=v(-614646-(-618663))m=J(A,u)X=O[m]g=T[X]m=v(375681-371778)A=732232+20946266536401 X=e[t[-446407+446408]]O=e[t[304755+-304753]]J=O(m,A)T=X[J]Y=g[T]o=Y Y=666016+11655695 end else if Y<7881251-(-469810)then K=v(-391905-(-396074))q=1.0798813038142e+14-505447 Y=D[K]K=Y(q)Y=10963112-(-962819)else Y=D[v(948278-943993)]g={}end end end else if Y<9504379-1002741 then if Y<-979156+9417172 then if Y<7927661-(-495708)then Y=e[t[185838-185837]]K=e[t[-24983-(-24985)]]S=-846464+21572400681405 q=e[t[714894+-714891]]g=v(259161-254777)N=v(559272+-554806)o=q(N,S)g=Y[g]x=K[o]g=g(Y,x)Y=v(529245+-524900)Y=g[Y]Y=Y(g)N=v(-887638-(-891646))S=-371170+24037470524827 Y=e[t[-580363-(-580367)]]K=e[t[-47750-(-47752)]]q=e[t[334649+-334646]]g=v(-154023+158407)g=Y[g]o=q(N,S)x=K[o]g=g(Y,x)Y=v(268963+-264618)Y=g[Y]Y=Y(g)g={}Y=D[v(713920-710045)]else Y=e[t[-777822-(-777825)]]Y=Y and-894522+9357579 or-487995+14421362 end else if Y<-994178+9471310 then Y=D[v(1011453+-1006958)]g={}else Y=a Y=u and-919861+8903968 or-151884+12239766 end end else if Y<-819871+9358433 then if Y<8234254-(-274675)then e[K]=Dq G=-201590-(-201591)n=e[E]B=n+G F=s[B]i=m+F F=-378526-(-378782)Y=i%F m=Y B=e[U]Y=379312+9956721 F=A+B B=-87040-(-87296)i=F%B A=i else C=Y l=nil Z=q==l Y=Z and-524435+2708800 or-588992+10449539 z=Z end else X=y(X)O=y(O)T=nil Y=217699+10550989 N=nil end end end end end end end else if Y<13276760-657173 then if Y<289604+10319281 then if Y<9915273-218055 then if Y<8470678-(-636524)then if Y<8054478-(-845729)then if Y<8700517-(-72493)then if Y<7761187-(-914463)then if Y<602941+8036196 then O=v(-504121+508229)X=D[O]a=565285+34287686966841 u=v(76087-71863)J=e[t[1042983+-1042982]]m=e[t[416846+-416844]]A=m(u,a)u=118497+31543660063359 O=J[A]T=X[O]O=e[t[-322686-(-322687)]]J=e[t[598271+-598269]]A=v(860786+-856299)m=J(A,u)X=O[m]Y=932831+6700630 g=T[X]N=g else O=Y C=v(653804-649520)A=v(-630887+635109)Z=-130976+24874634734815 m=D[A]A=m(N)u=e[t[-381904+381905]]a=e[t[810813-810811]]z=a(C,Z)m=u[z]J=A~=m X=J Y=J and 14749905-(-200711)or-501835+3446560 end else if Y<-159619+8843830 then o=K A=v(872958+-868431)S=e[t[-114115-(-114117)]]O=e[t[603843+-603840]]J=e[t[-467349-(-467353)]]u=28981616414931-(-615396)m=J(A,u)X=O[m]T=N[X]Y=S[T]Y=Y and 359333+10297368 or-598474+9874888 else K=e[t[-801740-(-801741)]]x=P[-967650+967651]q=e[t[990692-990690]]S=30197437800864-92851 N=v(616021-611984)o=q(N,S)g=K[o]Y=x==g Y=Y and 864285+12612541 or 507306+14949988 end end else if Y<9632770-760046 then if Y<995235+7858804 then C=v(-381843+386194)u=m U=-92365+29691901140687 l=e[t[228924-228923]]p=v(415933-411597)W=e[t[-229948+229950]]b=W(p,U)C=a[C]Z=l[b]C=C(a,Z)Y=C and-163437+5601696 or 8974055-660921 z=C else u=v(617117+-613052)m=false U=-692195+19452080255813 O=false J=true e[t[-853325-(-853338)]]=O e[t[770625+-770611]]=J e[t[733945+-733930]]=m A=D[u]Y=5134713-(-373344)p=v(688120+-683781)a=e[t[271373+-271367]]C=e[t[-513064-(-513071)]]l=e[t[219589+-219585]]W=e[t[701667+-701662]]b=W(p,U)Z=l[b]z=C[Z]C=1006942+-1006941 u=A(a,z,C)end else if Y<8129507-(-761514)then g={}Y=D[v(-861624-(-865868))]else q,S=o(K,q)Y=q and 14580145-(-660482)or 769800+11197888 end end end else if Y<9454360-502828 then if Y<-145005+9066483 then if Y<8266693-(-641466)then a=e[t[152945-152933]]W=v(-682849+687296)J=Y b=31593228695811-311180 C=e[t[-242906-(-242910)]]Z=e[t[329686+-329681]]l=Z(W,b)z=C[l]l=v(138151+-134122)u=a[z]z=e[t[375018-375014]]W=11793973287786-361975 C=e[t[-939421+939426]]Z=C(l,W)a=z[Z]A=u[a]u=-468755+468756 m=A>u O=m Y=m and-974303+13650067 or 16577820-927656 else u=v(-361963+366427)A=D[u]u=v(837499+-833293)m=A[u]Y=-416282+721376 O=m end else if Y<628709+8315018 then l=v(902672+-898374)Y=D[l]b=v(-432266-(-436393))W=D[b]l=Y(W)Y=v(281801+-277665)D[Y]=l Y=347360+13572886 else T=99177-99172 Y=v(1040358+-1036379)Y=S[Y]Y=Y(S,T)Y=10651638-(-230424)end end else if Y<9442971-426721 then if Y<-6703+8994323 then N=o Y=v(154811+-150460)m=v(124183-119857)X=e[t[-630085+630086]]A=-945839+15547455916790 O=e[t[252816-252814]]Y=S[Y]J=O(m,A)T=X[J]Y=Y(S,T)Y=Y and 637246+2186178 or 3580691-(-396026)else Y=D[v(228888-224675)]K=nil g={}x=nil q=nil end else if Y<-927390+9971504 then q,S=o(K,q)Y=q and-80744+13536810 or 12727571-(-602456)else Y=-239100+13402862 q=e[t[476256-476250]]K=q==x g=K end end end end else if Y<574072+8800885 then if Y<586362+8657530 then if Y<8177370-(-970977)then if Y<8797812-(-329191)then x=nil Y=D[v(-767412-(-771358))]g={}else Y=-110416+12678248 T=nil o=nil S=nil end else if Y<9677234-478405 then N=nil Y=-828740+13789098 S=nil else Y=e[t[-199722+199723]]g={}Y[x]=g Y=12352428-763438 end end else if Y<304890+8967778 then if Y<9648130-386348 then o,S=K(q,o)Y=o and 683838+11913621 or 14012668-(-423387)else K=v(-584942-(-589493))Y=true q=true J=v(895932-892020)g=true e[t[504495-504494]]=Y e[t[412780+-412778]]=g x=D[K]K=x(q)K=v(970623+-966454)x=D[K]q=-294763+1.200092529268e+14 K=x(q)K=v(110826-106761)x=D[K]m=54967+14884627432540 z=v(-216336-(-220801))C=-611478+27229622715933 q=e[t[967424+-967421]]N=e[t[244081+-244077]]T=e[t[148743-148738]]X=e[t[-388872+388878]]O=X(J,m)S=T[O]T=v(-607349+611805)o=N[S]X=34531296234700-(-438787)N=-1301-(-1302)K=x(q,o,N)x=e[t[713876+-713869]]q=x()o=e[t[365151+-365146]]N=e[t[-266639-(-266645)]]S=N(T,X)q=o[S]o=j(9057376-354632,{t[-308842+308847];t[868840+-868834],t[330494+-330486],t[-972255-(-972264)]})x=K[q]X=v(-260696+265004)q=v(-68984-(-73251))q=x[q]O=205538+7348764961404 q=q(x,o)N=e[t[753460-753455]]S=e[t[108443+-108437]]T=S(X,O)S=v(360243-355692)o=N[T]T=false x=K[o]o=v(496457+-492368)o=x[o]o=o(x)x=false N=v(52768-48802)o=false e[t[281292-281291]]=x N=q[N]e[t[47350-47348]]=o N=N(q)N=D[S]S=N(T)N=e[t[-948722+948732]]S=N()S=Y J=e[t[163391+-163380]]A=e[t[-1019266+1019271]]u=e[t[629807-629801]]a=u(z,C)m=A[a]O=J[m]m=e[t[1010043+-1010038]]z=15957016912516-689534 A=e[t[-569075-(-569081)]]a=v(984504+-980248)u=A(a,z)J=m[u]X=O[J]O=1018852+-1018851 T=X<O Y=T and 8591856-(-804445)or 8199332-767719 N=T end else if Y<9169906-(-107357)then Y=-761675+15607494 N=nil o=nil else q,S=o(K,q)Y=q and-862922+10412188 or 4083337-(-722079)end end end else if Y<-153552+9678155 then if Y<394938+9052004 then if Y<1045641+8331936 then g=v(661517+-656998)Y=D[g]g=Y()Y=7783942-488974 else X=v(143135-138946)p=131895+12557124195232 Z=v(123136+-118883)T=D[X]m=v(269589+-265680)l=26301692863244-(-822475)r=v(607229-602832)J=D[m]A=e[t[666838-666833]]z=v(-442969+447431)C=34679530099519-(-469973)u=e[t[436559+-436553]]a=u(z,C)m=A[a]E=25794533429551-205380 O=J[m]X=v(95010-91105)A=e[t[-18967-(-18978)]]a=e[t[-250721-(-250726)]]z=e[t[-528331-(-528337)]]C=z(Z,l)c=14545323266833-440476 b=v(485467+-480978)u=a[C]m=A[u]C=v(118733+-114695)z=D[C]Z=e[t[223163-223158]]l=e[t[51129+-51123]]W=l(b,p)C=Z[W]a=z[C]Z=e[t[150283+-150272]]W=e[t[533117-533112]]U=v(537903-533461)b=e[t[-527838+527844]]p=b(U,E)l=W[p]C=Z[l]W=e[t[-592665-(-592676)]]p=e[t[-738420+738425]]U=e[t[229347+-229341]]E=U(r,c)c=v(565918-561956)b=p[E]p=v(115287+-111175)l=W[b]b=D[p]s=20180748677827-740878 X=T[X]U=e[t[-930976-(-930981)]]E=e[t[-220583-(-220589)]]r=E(c,s)p=U[r]U=-786387-(-786386)W=b[p]p=-602801+602801 E=715565-715565 b=W(p,U,E)W=v(726908-722494)Z=l+b z=a(C,Z)C=e[t[-1014148+1014153]]b=1813624056279-(-1022325)Z=e[t[-727437-(-727443)]]l=Z(W,b)a=C[l]u=z[a]a=-391752-(-391756)A=u*a J=O(m,A)O=e[t[-659338+659341]]Y=186095+7245518 X=X(T,J,O)N=X end else if Y<9163312-(-358472)then o=P[-672171-(-672175)]N=P[-995430-(-995435)]T=not o K=P[-493169-(-493171)]q=P[457113+-457110]S=P[60509-60503]g=T Y=T and 989917+15467238 or 2333338-(-314263)x=P[547687-547686]else Y=g and 9468538-(-615011)or 1961293-622932 end end else if Y<561481+9062086 then if Y<10607256-1024617 then X=e[t[-411009-(-411010)]]m=v(367456-363192)O=e[t[-51642-(-51644)]]N=q A=-625056+20290488102536 J=O(m,A)T=X[J]Y=v(741916-737565)Y=S[Y]Y=Y(S,T)Y=Y and 1139194-960681 or 1955703-958069 else Y=E b=U Y=923017+6153146 end else g=v(-186395-(-190899))Y=D[g]g=Y()Y=7229233-144749 end end end end else if Y<9477254-(-747861)then if Y<-834859+10738088 then if Y<10371551-601477 then if Y<-70404+9793407 then if Y<-198878+9906788 then g=v(-676298+680433)S=v(433362+-429315)Y=D[g]o=e[t[-844094+844097]]S=o[S]N={S(o)}o={Y(d(N))}g=o[-1019245+1019246]Y=7292604-(-671340)q=o[540057+-540054]K=o[326797+-326795]o=g else Y=e[t[563704+-563703]]K=e[t[819805-819803]]x=P[357808+-357807]N=v(89118-84931)S=33828345084182-(-935026)q=e[t[634584+-634581]]o=q(N,S)g=K[o]K=x Y[g]=K g={}x=nil Y=D[v(-1021915+1026053)]end else if Y<281525+9474388 then u=32474375383026-(-791328)N=v(719898-715595)Y=e[t[125632-125631]]K=e[t[-863755-(-863757)]]S=195128+14679548715131 A=v(-481439-(-485400))q=e[t[134939-134936]]o=q(N,S)g=K[o]O=21410499053205-(-893021)o=v(55402-51364)X=v(-100388-(-104537))q=D[o]J=v(-88905-(-92926))m=-687672+29079450235677 N=e[t[395294+-395292]]S=e[t[-632202-(-632205)]]T=S(X,O)o=N[T]K=q[o]T=e[t[348853+-348851]]X=e[t[-494805+494808]]O=X(J,m)S=T[O]X=v(-127585+131697)N=x[S]T=D[X]O=e[t[186597-186595]]J=e[t[1012355+-1012352]]m=J(A,u)X=O[m]O=-764765-(-764780)J=172352+-172352 S=T[X]X=-303213-(-303213)T=S(X,O,J)o=N+T q=K(o)Y[g]=q Y=-264979+7919603 else Y=i Y=16776561-943130 g=Dq end end else if Y<-413970+10264769 then if Y<9648670-(-143456)then Y=-216919+1976129 m=3251001078994-(-282903)N=e[t[-72563+72567]]T=e[t[-247095-(-247097)]]X=e[t[655277+-655274]]J=v(-519263-(-523655))O=X(J,m)S=T[O]o=N[S]N=-182369+182369 q=o==N x=q else T=-123184-(-123189)Y=v(-842342+846321)Y=S[Y]Y=Y(S,T)Y=1023541-419080 end else if Y<598519+9279824 then Y=C u=z Y=-867011+9345239 else Y=1036592+8934994 end end end else if Y<92746+9908947 then if Y<9799993-(-152176)then if Y<1013485+8928468 then g=e[t[-799235-(-799241)]]Y=not g Y=Y and 372023+9587926 or-292976+7766237 else J=v(-450424-(-454405))Y=true e[t[-798649-(-798650)]]=Y g=true K=v(-1022814+1026879)e[t[18138-18136]]=g x=D[K]q=e[t[933687+-933684]]N=e[t[-681663-(-681667)]]T=e[t[-106471-(-106476)]]m=677900+16045737772323 X=e[t[-833817+833823]]O=X(J,m)S=T[O]m=862250+3088192937332 o=N[S]N=590844-590843 W=-75056+7041849487871 K=x(q,o,N)o=v(707675-703158)x=e[t[-129533+129540]]q=x()X=v(573621-569634)O=24031756472475-(-219931)q=D[o]N=e[t[-406931+406936]]S=e[t[-411524+411530]]T=S(X,O)X=v(192160+-187714)o=N[T]A=v(-389200+393691)x=q[o]N=e[t[408544-408539]]S=e[t[1037375+-1037369]]O=3443718616674-28703 T=S(X,O)o=N[T]N=e[t[347512+-347504]]X=23459055782479-712612 T=v(531042+-526963)u=3159309912054-(-540105)q=x(o,N)J=v(-513028-(-517463))o=e[t[-373731-(-373736)]]N=e[t[-161590+161596]]S=N(T,X)x=o[S]S=v(421187+-417075)N=D[S]T=e[t[821642+-821637]]X=e[t[-391751-(-391757)]]O=X(J,m)X=1050550-950550 S=T[O]T=280398-180398 o=N[S]S=-753293-(-853293)N=o(S,T,X)q[x]=N o=e[t[-910813+910818]]T=v(-316699+320874)X=32543396099143-(-657131)N=e[t[711632+-711626]]S=N(T,X)x=o[S]T=e[t[-854820+854828]]O=e[t[-327945+327950]]J=e[t[-317961+317967]]m=J(A,u)A=2435119201392-833539 X=O[m]S=T[X]u=v(149501-145242)X=e[t[-144873-(-144878)]]O=e[t[1032134-1032128]]m=v(-1040516-(-1044420))J=O(m,A)T=X[J]N=S[T]S=340224+-340124 o=N*S a=30132538811057-273378 O=v(635961+-631459)q[x]=o T=v(582227+-578247)X=27556462711314-352243 o=e[t[909057+-909052]]N=e[t[-792225-(-792231)]]S=N(T,X)x=o[S]o=-494168-(-504168)J=1618397940065-(-31120)q[x]=o o=v(-283340-(-287812))x=D[o]o=v(385207+-380850)S=e[t[326889-326884]]o=x[o]T=e[t[-764559+764565]]X=T(O,J)N=S[X]o=o(x,N)x=v(-287233+291390)O=-397163+9783883948342 x=o[x]N=551226+-551225.75 x=x(o,q,N)N=e[t[273129-273124]]X=v(-939216-(-943188))S=e[t[926373+-926367]]T=S(X,O)o=N[T]N=M(251874-181308,{t[-263487+263492],t[-273940-(-273946)];t[613795+-613786];t[418140-418130]})x=K[o]o=v(-747579+751846)O=v(-902863+907394)o=x[o]o=o(x,N)J=10719033159683-(-795516)S=e[t[-633034+633039]]T=e[t[-657617-(-657623)]]X=T(O,J)N=S[X]x=K[N]N=v(-811986-(-816075))N=x[N]N=N(x)N=v(-174622-(-178687))x=D[N]S=e[t[-934921+934924]]X=e[t[-228324+228328]]J=e[t[-131587-(-131592)]]m=e[t[-457117-(-457123)]]A=m(u,a)O=J[A]T=X[O]J=v(-1020853+1025155)m=628578+35073574611050 X=369564-369563 N=x(S,T,X)T=e[t[407270-407265]]X=e[t[-714689+714695]]O=X(J,m)S=T[O]T=H(1017843+9831973,{t[-7874+7879],t[586242+-586236];t[-501533+501544],t[-778234-(-778246)]})x=N[S]S=v(-149035-(-153302))m=v(379480+-375494)S=x[S]S=S(x,T)X=e[t[975855+-975850]]O=e[t[-62963+62969]]A=-833511+24859539252511 J=O(m,A)T=X[J]x=N[T]T=v(693304+-689215)X=v(254754-250788)J=false T=x[T]T=T(x)x=false X=S[X]T=false e[t[865055+-865054]]=x l=v(386920+-383026)e[t[-618781-(-618783)]]=T X=X(S)X=v(591888-587922)O=v(-192692+197243)X=o[X]X=X(o)X=D[O]O=X(J)X=e[t[-35883-(-35896)]]O=X()u=e[t[-490823-(-490831)]]O=Y z=e[t[-844706+844711]]C=e[t[1012545-1012539]]Z=C(l,W)l=24686385327329-(-98310)a=z[Z]A=u[a]a=e[t[396091+-396086]]z=e[t[-149684-(-149690)]]Z=v(-983911-(-987999))C=z(Z,l)u=a[C]m=A[u]A=939032-939031 J=m<A Y=J and 2055942-(-641519)or-336831+12545792 X=J end else if Y<9845014-(-126293)then Y=e[t[-640677-(-640686)]]Y=Y and-299122+2104670 or 834675+5942386 else T=1702827854505-(-374895)q=e[t[607780-607779]]o=e[t[-220269-(-220271)]]S=v(195796-191735)N=o(S,T)K=q[N]Y=x==K Y=Y and 10626859-123139 or 9719832-(-644178)end end else if Y<9221183-(-875750)then if Y<-22619+10109847 then q=v(210516-206561)g=D[q]o=e[t[-920743-(-920744)]]X=-930886+27348064773636 N=e[t[-513898+513900]]T=v(-983290-(-987634))S=N(T,X)q=o[S]Y=g[q]g=Y(K)Y=2033359-694998 K=g else s=true c=e[t[-217243-(-217252)]]Y=750952+8851876 r=c==s U=r end else if Y<9672082-(-495147)then Y=e[t[546778-546777]]Y=Y and 12110731-(-629041)or 909191+12076915 else N=v(644404-640081)S=-968038+29910889561038 g=e[t[312406+-312405]]K=e[t[-199012+199014]]q=e[t[168656-168653]]o=q(N,S)x=K[o]Y=g[x]x=j(612327+10215148,{t[842522-842518],t[356331-356326];t[-413228-(-413230)];t[567509-567506],t[244036-244030]})g=v(314492+-310225)g=Y[g]g=g(Y,x)e[t[-775530+775537]]=g Y=D[v(1046852-1042919)]g={}end end end end else if Y<927201+9480440 then if Y<9858876-(-454462)then if Y<483261+9797527 then if Y<586517+9655268 then Y=true Y=658975+2224438 else q=1.0798812987597e+14 K=v(-1009941+1014110)Y=D[K]K=Y(q)K=v(-14541+18710)Y=D[K]q=e[t[-980315+980319]]K=Y(q)Y=6798472-(-697018)end else if Y<-196113+10500651 then g=e[t[740796+-740791]]T=62282-62281 N=x S=N-T Y=g[S]S=e[t[956954-956949]]g=S[N]T=e[t[-335873+335878]]O=396877+-396876 X=N+O Z=31251609791681-340969 O=h()S=T[X]X=h()T=Y e[X]=g C=v(-20728-(-25080))e[O]=S m=e[t[-958074-(-958075)]]u=e[t[451518-451516]]a=e[t[-386730-(-386733)]]z=a(C,Z)A=u[z]J=m[A]S=not J g=S Y=S and 3688854-(-837665)or 1918500-949247 else g=v(-878748+882883)Y=D[g]T=e[t[-889283+889284]]S=T[x]T={Y(S)}Y=1463576-39776 o=T[-545179+545181]N=T[413156-413153]g=T[-576252+576253]S=g end end else if Y<240789+10110234 then if Y<9720135-(-623739)then c=y(c)p=y(p)r=y(r)b=y(b)U=y(U)Y=14258967-(-238068)s=nil E=y(E)else Y=D[v(-1012128-(-1016060))]g={}end else if Y<9358367-(-1009223)then g={}x=nil Y=D[v(-997095-(-1001182))]else Y=v(777393+-773161)g=e[t[-541516+541518]]Y=x[Y]Y=Y(x,g)Y=Y and 7053131-(-10710)or 8599599-988766 end end end else if Y<10285854-(-195180)then if Y<-576534+11015700 then if Y<10625938-205314 then Y=-110622+6943739 else O=v(-790495-(-794562))K=Y o=e[t[410075-410074]]S=e[t[-337462-(-337464)]]T=e[t[548608+-548605]]J=30368894658191-12114 X=T(O,J)N=S[X]q=o[N]x=q Y=q and-406828+2166038 or 8744002-(-1041901)end else if Y<905543+9547670 then N=nil o=nil q=nil Y=D[v(-871114+875571)]K=y(K)S=nil g={}else Z=e[K]Y=Z and 243479+5912131 or 430529+14923442 C=Z end end else if Y<11529762-971169 then if Y<10450477-(-89769)then K=v(-293762+297931)q=8596395839-412584 Y=D[K]K=Y(q)T=v(22095-18048)K=v(667320-663185)Y=D[K]N=e[t[882759+-882755]]T=N[T]S={T(N)}N={Y(d(S))}K=N[561388-561387]Y=-977116+16492276 o=N[799836+-799833]q=N[-1029331-(-1029333)]else Y=13101430-253440 end else x=P[674383+-674382]K=v(-739112+743629)S=v(-1030946-(-1035203))g=D[K]q=e[t[-144455-(-144456)]]T=21661499446227-(-611219)o=e[t[-668043-(-668045)]]N=o(S,T)K=q[N]Y=g[K]q=e[t[-721305-(-721306)]]S=v(-279480-(-283727))o=e[t[-526639-(-526641)]]T=25712114302712-544819 N=o(S,T)K=q[N]q=e[t[-749446+749449]]S=-604098+4525047857149 X=3568179198498-(-183387)g=Y(K,q)N=v(-76008+80370)K=g T=v(489100+-484814)g=e[t[-629609+629610]]q=e[t[940275+-940273]]o=q(N,S)Y=g[o]o=e[t[-647997+647998]]N=e[t[53501+-53499]]S=N(T,X)N=v(531353-527305)q=o[S]S=72395+34161207993176 g=q..x K[Y]=g g=e[t[-107774-(-107775)]]q=e[t[866605+-866603]]o=q(N,S)Y=g[o]g=true K[Y]=g Y=v(539549-535204)Y=K[Y]Y=Y(K)K=nil x=nil g={}Y=D[v(-909437+913915)]end end end end end else if Y<12573752-738174 then if Y<10978218-(-64520)then if Y<10835152-49745 then if Y<10495332-(-199482)then if Y<10580704-(-77083)then if Y<10997294-347645 then S=17497928960269-272697 K=e[t[418877-418876]]x=P[219561+-219560]q=e[t[315346-315344]]N=v(-849403-(-853477))o=q(N,S)g=K[o]Y=x==g Y=Y and 9889439-181549 or-95679+7678607 else O=e[t[-950989+950994]]X=Y T=O Y=O and-352784+12250536 or-22895-(-353484)end else if Y<-551464+11217412 then K=e[t[-814153-(-814156)]]q=79765-79700 Y=595177+-289520 x=K*q K=242353+-242096 g=x%K e[t[1035836-1035833]]=g else Y=809653-299675 m=899588+3251000462309 N=e[t[288338-288334]]T=e[t[-576466+576468]]J=v(-238733+243125)X=e[t[343949+-343946]]O=X(J,m)S=T[O]o=N[S]N=783064-783064 q=o==N x=q end end else if Y<-427411+11193596 then if Y<10744469-7837 then g=v(-922360+926789)Y=D[g]g=Y()Y=779894+1520926 else S=v(-560359-(-564406))g=v(-277934-(-282069))Y=D[g]o=e[t[775207-775204]]S=o[S]N={S(o)}o={Y(d(N))}K=o[856460+-856458]g=o[343817-343816]Y=8293588-(-600491)q=o[513439+-513436]o=g end else if Y<1035495+9746220 then Y=e[t[687910-687898]]g=v(297849-293313)g=Y[g]g=g(Y)Y=-387864+3047952 else Y=e[t[455987+-455986]]Y=Y and 316199+15453461 or 1122584-774203 end end end else if Y<12795+10842231 then if Y<-881651+11720627 then if Y<-861494+11695454 then g=e[t[647891-647890]]x=P[-338192-(-338193)]Y=not g Y=Y and-221413+15374106 or 366002+10015113 else K=v(531867+-527698)q=548888+8595434367 Y=D[K]K=Y(q)q=true K=v(781993+-777442)Y=D[K]K=Y(q)Y=-685827+9803926 end else if Y<470403+10379571 then x=P[599380+-599379]N=v(989403+-984902)K=e[t[1045724-1045723]]S=25264355859016-(-922540)q=e[t[413155+-413153]]o=q(N,S)g=K[o]Y=x==g Y=Y and-445411+2320813 or 9473658-(-497928)else N=o T=127502+-127501 Y=v(828382-824403)N=nil Y=S[Y]Y=Y(S,T)S=nil Y=1615132-197309 end end else if Y<10131818-(-771598)then if Y<636041+10247194 then S=nil Y=8222180-407712 N=nil else g={}K=nil q=nil N=nil o=nil Y=D[v(-362430+366549)]end else if Y<241000+10755240 then g=v(647530-643089)Y=D[g]m=651447+21509465929321 T=e[t[463790+-463789]]X=e[t[575132-575130]]J=v(310506-306234)O=X(J,m)S=T[O]g={Y(S)}g={d(g)}Y=D[v(-883495-(-887523))]else Y=O Y=X and 8044491-974923 or-61+1591060 end end end end else if Y<10587391-(-819686)then if Y<11115758-(-149086)then if Y<-519434+11636342 then if Y<-272896+11345402 then z=-9757-(-9758)U=88962+-88961 Y=11940174-(-166911)W=#u a=q(z,W)z=S(u,a)W=e[A]p=z-U b=T(p)W[z]=b a=nil z=nil else W=e[t[-366443+366455]]b=false l=W==b Y=l and 16898046-514139 or 12025034-559655 end else if Y<984531+10150997 then K=v(-43998+48133)T=v(-120814-(-124861))Y=D[K]N=e[t[31228+-31225]]T=N[T]S={T(N)}N={Y(d(S))}o=N[1023823-1023820]K=N[816141-816140]Y=1013266+3076819 q=N[824887-824885]else Y=v(169122+-165143)Y=S[Y]N=q T=-453808-(-453813)Y=Y(S,T)Y=-175347+1895998 S=nil N=nil end end else if Y<10697142-(-612203)then if Y<364525+10935055 then Y=r Y=E and 288618-33908 or 12988686-(-357297)else Y=v(-910103-(-914448))Y=a[Y]Y=Y(a)Y=986309-562215 end else if Y<-346758+11696278 then l=353420+11203463606229 J=v(396721+-392532)u=v(361260-357351)Z=v(-499690+503969)O=D[J]A=D[u]a=e[t[-662186+662191]]z=e[t[-368172+368178]]i=19499846781240-26048 C=z(Z,l)u=a[C]W=v(465469+-460939)m=A[u]a=e[t[608853+-608842]]C=e[t[-992318-(-992323)]]Z=e[t[459275+-459269]]b=387040+21678298283918 l=Z(W,b)E=-234504+24734248452357 z=C[l]u=a[z]l=v(321469+-317431)s=v(-684574-(-688845))Z=D[l]Dq=609005+32527901339709 W=e[t[-150063+150068]]c=-597533+3525396702342 r=v(836179-832084)Y=5849437-(-217089)U=v(337517-333597)b=e[t[409936+-409930]]p=b(U,E)l=W[p]C=Z[l]W=e[t[360448+-360437]]p=e[t[256772-256767]]U=e[t[-65953-(-65959)]]E=U(r,c)b=p[E]l=W[b]p=e[t[-289473-(-289484)]]E=e[t[815561-815556]]r=e[t[289963-289957]]c=r(s,Dq)U=E[c]b=p[U]E=v(367461-363349)U=D[E]r=e[t[-468594+468599]]Dq=v(-189135-(-193650))c=e[t[918141+-918135]]s=c(Dq,i)c=-438539+438539 E=r[s]p=U[E]J=v(-660408-(-664313))E=-794126+794126 r=-994430+994429 U=p(E,r,c)W=b+U Z=C(l,W)l=e[t[1019520+-1019515]]p=v(-290555-(-295114))W=e[t[201101-201095]]U=35118625349109-859668 b=W(p,U)J=O[J]C=l[b]z=Z[C]C=-981769+981773 a=z*C A=m(u,a)m=e[t[204130-204127]]J=J(O,A,m)T=J else J=J+m u=not A X=J<=O X=u and X u=J>=O u=A and u X=u or X u=175990+6100896 Y=X and u X=9318624-183362 Y=Y or X end end end else if Y<12364421-776710 then if Y<-1035386+12519790 then if Y<10986259-(-475143)then q=v(-94223+98178)g=D[q]o=e[t[20428-20427]]T=v(-864860+868813)X=19700549586212-141647 N=e[t[-869417-(-869419)]]S=N(T,X)q=o[S]Y=g[q]g=Y(K)Y=386927+11382783 K=g else U=false W=false G=v(-146494+150584)p=false e[t[-919154+919168]]=W b=false e[t[-318774+318785]]=b r=v(-465611+470168)e[t[504227+-504214]]=p e[t[745378-745368]]=U E=D[r]c=e[t[514961+-514954]]Dq=e[t[450582-450574]]F=e[t[969960-969958]]f=11684952971085-(-146932)B=e[t[174978-174975]]n=B(G,f)f=970529+20733529953941 i=F[n]s=Dq[i]r=E(c,s)r=v(373539-368982)E=D[r]G=v(-966755-(-970818))c=e[t[1017662+-1017655]]Dq=e[t[-315702-(-315710)]]F=e[t[703435+-703433]]B=e[t[518077-518074]]n=B(G,f)i=F[n]s=Dq[i]r=E(c,s)G=v(162660-158502)f=8000873987377-994980 r=v(-446478-(-451035))E=D[r]c=e[t[-711013+711020]]Dq=e[t[882454+-882446]]F=e[t[955633-955631]]B=e[t[-156364-(-156367)]]n=B(G,f)i=F[n]s=Dq[i]r=E(c,s)G=v(-19368+23409)Y=60208+13285775 r=v(-395205+399762)f=8332107345233-(-565718)E=D[r]c=e[t[201480+-201473]]Dq=e[t[-345672+345680]]F=e[t[-384428-(-384430)]]B=e[t[329664-329661]]n=B(G,f)i=F[n]s=Dq[i]r=E(c,s)end else if Y<11699397-129266 then O=true A=v(-958333+962398)X=false b=v(124402+-120519)J=false e[t[-321520-(-321532)]]=X p=830766+21706659445325 e[t[-201635-(-201648)]]=O e[t[75908-75894]]=J m=D[A]u=e[t[-692465+692468]]Y=13065766-936795 z=e[t[407889-407885]]Z=e[t[-381256+381261]]l=e[t[-418102+418108]]W=l(b,p)C=Z[W]a=z[C]z=-112353+112354 A=m(u,a,z)else N=o Y=v(-5951-(-10302))X=e[t[-981133-(-981134)]]Y=S[Y]m=v(711137+-707017)A=19328924882669-78789 O=e[t[964219+-964217]]J=O(m,A)T=X[J]Y=Y(S,T)Y=Y and 559142-491309 or 802464+14123332 end end else if Y<12696845-968313 then if Y<836526+10758806 then o=e[t[925581+-925580]]q=o[x]J=-547377+4795947590378 S=e[t[248745-248743]]O=v(-448771-(-453177))T=e[t[243370-243367]]X=T(O,J)N=S[X]o=K[N]g=q[o]Y=not g Y=Y and 605449+14832687 or 5407446-258370 else Y=e[t[-807371+807372]]Y=Y and 15077533-946920 or 2743754-(-941280)end else Y=e[t[344604-344601]]o=e[t[501278-501277]]X=17091052404195-990925 N=e[t[-606672-(-606674)]]J=v(-96834+100965)T=v(-677745+681815)S=N(T,X)m=121003+8449094170291 q=o[S]S=v(496125+-492170)N=D[S]T=e[t[-762495-(-762496)]]X=e[t[392249+-392247]]O=X(J,m)S=T[O]o=N[S]T=Y S=K Y=K and-52785+1100152 or-222196+14703164 end end end end else if Y<12618393-434260 then if Y<12528139-446089 then if Y<12405111-454609 then if Y<608265+11309023 then if Y<-192661+12074461 then Y=e[t[-722733-(-722734)]]X=903810+-903810 K=q O=-778636-(-778891)T=Y(X,O)x[K]=T K=nil Y=-477164+4550832 else l=-801221+30147256725659 A=e[t[-237701-(-237706)]]Z=v(-592876-(-596750))a=e[t[-182950-(-182953)]]z=e[t[-388131-(-388135)]]C=z(Z,l)u=a[C]m=A[u]u=e[t[-581843-(-581844)]]l=v(-497417+501783)W=242616877836-508572 z=e[t[638548+-638545]]C=e[t[-998014-(-998018)]]Z=C(l,W)l=-757259+13358578247255 Y=-523667+854256 a=z[Z]Z=v(909291+-905205)A=u[a]J=m-A A=e[t[-939224+939230]]a=e[t[946766+-946763]]z=e[t[839238-839234]]C=z(Z,l)u=a[C]m=A[u]O=J/m T=O end else if Y<12342329-411178 then q=e[t[-244991+244992]]o=e[t[721259+-721257]]S=v(944853-940890)T=6105461812365-(-548494)N=o(S,T)K=q[N]Y=x==K Y=Y and 44263+4507202 or 70314+13692640 else O=v(-736919-(-741108))A=v(988915-985006)Z=24355930502554-854349 W=-975016+11023516464309 X=D[O]U=263362+20088461057992 Dq=66125+27506304167867 m=D[A]C=v(-525278+529802)u=e[t[-38607-(-38611)]]a=e[t[214241-214236]]z=a(C,Z)A=u[z]J=m[A]u=e[t[-570681-(-570693)]]z=e[t[-154662-(-154666)]]l=v(620398+-616451)C=e[t[-339017-(-339022)]]Z=C(l,W)a=z[Z]Z=v(-965696+969734)A=u[a]p=v(-720184-(-724110))C=D[Z]Y=-156700-(-994644)l=e[t[-985319+985323]]W=e[t[-113044-(-113049)]]b=W(p,U)Z=l[b]z=C[Z]l=e[t[951120+-951108]]b=e[t[15191+-15187]]r=33434669486976-(-43345)c=v(-599676+603826)E=v(-264860-(-269174))p=e[t[292227-292222]]U=p(E,r)s=17110623659889-(-964526)W=b[U]Z=l[W]b=e[t[371225-371213]]U=e[t[-107978+107982]]E=e[t[-422498-(-422503)]]r=E(c,s)p=U[r]U=v(-124342+128454)W=b[p]p=D[U]E=e[t[-648652-(-648656)]]r=e[t[882425+-882420]]s=v(112421-108377)c=r(s,Dq)U=E[c]r=832555-832555 b=p[U]E=230385+-230386 U=837974-837974 p=b(U,E,r)O=v(787166-783261)l=W+p b=v(91288-87331)C=z(Z,l)Z=e[t[-413179+413183]]p=10849602950561-(-327195)l=e[t[-745009-(-745014)]]W=l(b,p)z=Z[W]a=C[z]O=X[O]z=17816-17812 u=a*z m=J(A,u)J=e[t[-1000217-(-1000223)]]O=O(X,m,J)S=O end end else if Y<-226601+12198491 then if Y<12627658-667185 then Y=e[t[61199+-61198]]Y=Y and 8983422-97590 or 237068+9032853 else Y=12891090-589255 end else if Y<12873931-844176 then Y=W Y=l and 10885906-(-230540)or 551272+-188525 else z=h()U={}a={}W=M(16060216-(-644948),{z,O,J,N})e[z]=a T=nil a=h()e[a]=W F=nil p=v(993589+-989228)r=v(-189466+193920)W={}X=nil b=h()m=nil s=v(-1018785-(-1022769))m=v(797956-793753)q=nil e[b]=W W=D[p]c=e[b]N=y(N)E={[r]=c,[s]=F}p=W(U,E)W=V(398516+12243256,{b,z;A,O,J;a})u=nil O=y(O)S=nil A=y(A)J=y(J)z=y(z)a=y(a)e[o]=p b=y(b)S=v(-924743-(-928877))e[K]=W N=D[S]X=e[o]A=469834+123584173295 O=e[K]J=O(m,A)T=X[J]S=N(T)q=not S Y=q and 2304952-(-716647)or 14968279-(-1003348)end end end else if Y<11503982-(-617075)then if Y<12572960-465218 then if Y<-785701+12878962 then W=Y p=-570271-(-570272)b=o>p Y=b and 5848791-578177 or 12377492-350821 l=b else z=#u W=257164-257164 a=z==W Y=a and 165601+11909627 or 11025215-(-20590)end else if Y<12448363-339582 then Y=true g=true e[t[-347346-(-347347)]]=Y C=14907687721071-(-115374)e[t[-964297-(-964299)]]=g K=v(41210-37145)m=14108669616910-412005 x=D[K]J=v(-821482+825664)q=e[t[465634-465631]]N=e[t[347171-347167]]T=e[t[-1008511-(-1008516)]]X=e[t[-104528-(-104534)]]O=X(J,m)S=T[O]o=N[S]N=50677-50676 K=x(q,o,N)o=18553356002-(-522116)T=v(-591576-(-595896))x=e[t[-740050-(-740057)]]q=x()q=v(-842178+846347)O=257926+32611358985163 x=D[q]q=x(o)o=e[t[44490-44485]]z=v(814874+-810856)X=19456+31888796347905 N=e[t[93986+-93980]]S=N(T,X)q=o[S]x=K[q]q=v(-383541+387808)o=V(7427655-96706,{t[-1028623-(-1028628)],t[-674813+674819];t[284005+-283997];t[-404127-(-404136)]})q=x[q]q=q(x,o)N=e[t[-781266+781271]]X=v(-54060+58111)S=e[t[181964+-181958]]T=S(X,O)o=N[T]x=K[o]N=v(956641-952675)o=v(265331+-261242)o=x[o]o=o(x)N=q[N]x=false e[t[-296437-(-296438)]]=x o=false e[t[-418470+418472]]=o N=N(q)N=e[t[605528+-605518]]S=N()J=e[t[-536364+536375]]S=Y A=e[t[-177020+177025]]u=e[t[465537-465531]]a=u(z,C)m=A[a]z=6781505933809-869788 O=J[m]m=e[t[524705-524700]]a=v(-684712-(-688625))A=e[t[-548818+548824]]u=A(a,z)J=m[u]X=O[J]O=-730049-(-730050)T=X<O N=T Y=T and 7289623-(-177759)or 13465141-345423 else m=v(427843-423935)X=e[t[188077-188076]]Y=v(1011604+-1007253)O=e[t[-413640+413642]]N=q A=519494+17575413674674 J=O(m,A)T=X[J]Y=S[Y]Y=Y(S,T)Y=Y and 9008258-757041 or 455574-(-5240)end end else if Y<-756316+12902690 then if Y<12705819-578877 then Y=v(308152+-303807)Y=a[Y]Y=Y(a)Y=1025218+-601124 else g={}q=nil Y=D[v(-1045537+1049987)]K=nil end else W=v(-1014285+1018842)Z=false a=false z=false C=false i=17704721789716-905952 e[t[863157+-863146]]=a e[t[-604457+604469]]=z e[t[-460918+460932]]=C e[t[23844-23834]]=Z l=D[W]Dq=v(674903-670365)b=e[t[-890386-(-890393)]]U=e[t[-883610+883618]]r=e[t[218112-218110]]c=e[t[-453746-(-453749)]]s=c(Dq,i)i=10261092223881-637151 E=r[s]p=U[E]W=l(b,p)W=v(900213-895656)l=D[W]b=e[t[361584-361577]]U=e[t[490083-490075]]r=e[t[-837913-(-837915)]]c=e[t[-468770+468773]]Dq=v(146851+-142794)s=c(Dq,i)E=r[s]p=U[E]W=l(b,p)i=28435892134696-503663 W=v(-847290+851847)l=D[W]b=e[t[-687332+687339]]Dq=v(-41847-(-46322))U=e[t[-865735+865743]]r=e[t[713880+-713878]]Y=13850032-504049 c=e[t[-901318-(-901321)]]s=c(Dq,i)E=r[s]i=-959120+29351941003252 p=U[E]Dq=v(349328-345429)W=l(b,p)W=v(-874809-(-879366))l=D[W]b=e[t[636375-636368]]U=e[t[948355+-948347]]r=e[t[1048334+-1048332]]c=e[t[874692-874689]]s=c(Dq,i)E=r[s]p=U[E]W=l(b,p)end end end else if Y<11545251-(-888868)then if Y<659547+11651129 then if Y<13235396-957972 then if Y<-643888+12840288 then a=v(-308043+312074)Y=e[T]m=e[t[-745823-(-745824)]]A=e[t[-32855+32857]]z=767776+30100345405344 u=A(a,z)J=m[u]a=v(-603553+607969)m=true Y[J]=m Y=e[T]z=-256167+20424637926861 Z=-339269+30650716775685 m=e[t[731678-731677]]A=e[t[-78588+78590]]u=A(a,z)J=m[u]m=false a=v(86544+-82644)Y[J]=m z=250637+17913633688968 C=v(-735666-(-740182))Y=e[T]m=e[t[-404114+404115]]A=e[t[-271968-(-271970)]]u=A(a,z)J=m[u]m=487053-487053 Y[J]=m z=-102057+5365890947179 Y=e[T]m=e[t[-837493+837494]]a=v(-335537+339605)A=e[t[-674229-(-674231)]]u=A(a,z)J=m[u]u=e[t[203963-203962]]a=e[t[-705419+705421]]z=a(C,Z)A=u[z]m=o[A]Z=26898984512948-(-1033017)C=19901311899894-(-953149)z=v(-374725+378876)Y[J]=m m=v(-633004+637521)J=D[m]A=e[t[-457337-(-457338)]]u=e[t[1011842+-1011840]]a=u(z,C)m=A[a]C=28714128618446-884627 Y=J[m]z=v(-685001-(-689440))A=e[t[-42700+42701]]u=e[t[-959809+959811]]a=u(z,C)C=v(-999378+1003928)m=A[a]J=Y(m)m=h()e[m]=J A=v(211994+-207477)J=D[A]u=e[t[533587-533586]]b=711099+14686206673147 a=e[t[314407-314405]]z=a(C,Z)A=u[z]C=v(203537-199478)W=v(143010-139037)Z=19561331768113-(-796771)Y=J[A]u=e[t[-865370+865371]]a=e[t[465802+-465800]]z=a(C,Z)A=u[z]C=v(-276828+281144)J=Y(A)A=h()Z=23074949032179-687866 e[A]=J Y=e[T]u=e[t[-19600-(-19601)]]a=e[t[694584+-694582]]z=a(C,Z)J=u[z]a=e[m]C=e[t[-215655-(-215656)]]Z=e[t[-389006-(-389008)]]l=Z(W,b)z=C[l]C=v(134313+-130055)Z=16559946070896-204113 u=a[z]Y[J]=u Y=e[T]u=e[t[-401410+401411]]a=e[t[-770091-(-770093)]]z=a(C,Z)J=u[z]a=e[A]b=3197664777940-659715 C=e[t[857373+-857372]]Z=e[t[576070-576068]]W=v(105554-101539)l=Z(W,b)z=C[l]u=a[z]Y[J]=u u=v(-907617+911909)J=e[T]Y=H(-7286+4135558,{t[-566480+566481],t[291152-291150],T;N;X,O;S,t[-391768-(-391771)],t[-893625-(-893629)],t[86517+-86512],A,m})J[u]=Y u=v(259459-255225)Y=V(1052339-367005,{T;t[736517+-736516];t[-724940+724942]})J=e[T]J[u]=Y J=e[T]u=v(-225384+229842)Y=H(7408182-533415,{t[-154946+154947],t[422579-422577];T})J[u]=Y Y=e[T]g={Y}Y=D[v(-839656+843834)]else Y=O Y=X and 14540266-455902 or 820908+11848139 end else if Y<11398649-(-904602)then x=nil g={}Y=D[v(794743-790544)]else z=C Y=Z Y=5654068-215809 end end else if Y<988613+11379614 then if Y<954128+11378490 then X=not N T=Y Y=X and 15142594-(-132821)or-800415+9474144 g=X else g={}Y=D[v(-11331-(-15704))]end else if Y<-957770+13370518 then K=v(686158-682023)T=v(872212-868165)Y=D[K]N=e[t[-499165+499169]]T=N[T]S={T(N)}N={Y(d(S))}Y=9475886-221551 o=N[16320-16317]K=N[492772-492771]q=N[-392980+392982]else o=-586893-(-586893)Y=10466164-941721 q=K<o g=q end end end else if Y<11774712-(-755619)then if Y<12815466-341763 then if Y<11516012-(-919546)then Y=v(150984-147005)T=-387783+387784 Y=S[Y]N=o N=nil Y=Y(S,T)S=nil Y=-317137+3324510 else N,X=S(o,N)Y=N and 13663502-(-265784)or 719108+5948769 end else if Y<-1022861+13528011 then W=v(-913419+917555)Y=D[W]W=v(656859+-652732)D[W]=Y Y=379331+13540915 else z=v(-468553+472631)A=e[t[-368638+368639]]C=6196956328207-501194 u=e[t[-206358+206360]]a=u(z,C)Z=v(-613576+617966)m=A[a]u=v(196302-192194)J=o[m]l=310854+26723324523094 A=D[u]a=e[t[202320+-202319]]z=e[t[380690-380688]]C=z(Z,l)u=a[C]Y=7138996-(-264377)m=A[u]O=J~=m T=O end end else if Y<12453193-(-128206)then if Y<355626+12194887 then Y=v(-886193+890427)Y=X[Y]Y=Y(X)Y=13700663-(-239877)else Y=D[v(-961500-(-965553))]g={K}end else N=o X=e[t[-21583-(-21584)]]m=v(-809784+814080)O=e[t[-699327-(-699329)]]A=191498+26836962608326 Y=v(718422+-714071)J=O(m,A)T=X[J]Y=S[Y]Y=Y(S,T)Y=Y and 9202281-(-631203)or 1629042-1024581 end end end end end end else if Y<14455204-(-41338)then if Y<12742500-(-719360)then if Y<-514771+13410144 then if Y<-894697+13680930 then if Y<13482598-806426 then if Y<13028151-372443 then if Y<170832+12453164 then x=P[-608462+608463]Y=e[t[194166+-194165]]S=1853814256277-208694 N=v(-1003256-(-1007420))K=e[t[405896+-405894]]q=e[t[-279815+279818]]o=q(N,S)g=K[o]K=x Y[g]=K g={}x=nil Y=D[v(-1009657-(-1014051))]else x=P[1001177-1001176]Y=e[t[-342240+342241]]K=P[928500-928498]q=Y Y=q[K]Y=Y and-882567+3836271 or 634583-(-635773)end else if Y<13210534-538201 then A=Y U=8135918616392-274556 C=e[t[-378501-(-378509)]]p=v(-988070-(-992359))l=e[t[-99260+99265]]W=e[t[1029001-1028995]]b=W(p,U)p=4775841651273-(-274022)Z=l[b]z=C[Z]b=v(393470-389477)Z=e[t[-519805-(-519810)]]l=e[t[-942595+942601]]W=l(b,p)C=Z[W]a=z[C]z=-637511-(-637512)u=a>z Y=u and 567330+7461291 or 583781+12354383 m=u else Y=14789235-(-860929)b=834308397377-(-993347)A=v(796688-792499)m=D[A]z=v(-271398-(-275307))a=D[z]C=e[t[-587299+587303]]p=v(-224986+229228)W=v(-465805+470000)c=5608452852597-(-769726)Z=e[t[420053+-420048]]Dq=381404+3700564096223 U=22876974788475-(-637473)l=Z(W,b)z=C[l]u=a[z]C=e[t[551786-551774]]F=398340+334380919959 l=e[t[177016-177012]]W=e[t[253808+-253803]]i=v(392124+-387719)r=v(-1030402+1034549)b=W(p,U)Z=l[b]z=C[Z]b=v(-358825-(-362863))W=D[b]p=e[t[-236241+236245]]U=e[t[722581-722576]]E=U(r,c)b=p[E]s=v(551567-547425)l=W[b]p=e[t[708163-708151]]E=e[t[653646+-653642]]A=v(-698901+702806)r=e[t[-910428-(-910433)]]c=r(s,Dq)U=E[c]b=p[U]E=e[t[171927+-171915]]c=e[t[-466278+466282]]s=e[t[-116836-(-116841)]]Dq=s(i,F)r=c[Dq]B=-1010723+22203935003782 U=E[r]c=v(-457514-(-461626))r=D[c]s=e[t[872278+-872274]]F=v(792674+-788368)Dq=e[t[751476-751471]]i=Dq(F,B)A=m[A]c=s[i]Dq=18654+-18654 s=678158+-678159 E=r[c]c=-297531+297531 r=E(c,s,Dq)p=U+r W=l(b,p)r=11362767306649-682734 E=v(692094+-687893)b=e[t[1008040+-1008036]]p=e[t[-410960+410965]]U=p(E,r)l=b[U]Z=W[l]l=-996236+996240 C=Z*l a=u(z,C)u=e[t[653107-653101]]A=A(m,a,u)O=A end end else if Y<12901500-174897 then if Y<11826684-(-869892)then K=e[t[867115+-867112]]m=306505-306492 q=-587148-(-587180)O=124127-124125 x=K%q o=e[t[814826+-814822]]T=e[t[612872-612870]]a=e[t[-61228+61231]]u=a-x a=1004417+-1004385 A=u/a J=m-A X=O^J S=T/X N=o(S)X=456067+-456066 o=289427+4294677869 q=N%o N=-413454-(-413456)o=N^x K=q/o o=e[t[-7828-(-7832)]]x=nil T=K%X X=4294104746-(-862550)Y=-819842+13606376 S=T*X N=o(S)o=e[t[53075-53071]]S=o(K)q=N+S m=-835411-(-835667)N=570917+-505381 o=q%N S=q-o T=-893421+958957 N=S/T T=-94500+94756 S=o%T O=-71231-(-71487)X=o-S T=X/O o=nil O=883141+-882885 X=N%O J=N-X O=J/m N=nil J={S,T;X;O}O=nil T=nil q=nil K=nil X=nil S=nil e[t[-186641+186642]]=J else g={}Y=D[v(298950-294892)]end else if Y<13328493-563142 then Y=D[v(175147+-170826)]g={}else J=false m=false a=v(-132331-(-136888))O=false e[t[823355+-823344]]=O e[t[135407+-135395]]=J E=-294993+21445735114579 e[t[-226100+226113]]=m A=false e[t[-581390-(-581400)]]=A u=D[a]z=e[t[-230392+230399]]Z=e[t[-449875-(-449883)]]U=v(-579043-(-583043))W=e[t[-68426+68428]]b=e[t[-629289-(-629292)]]p=b(U,E)U=v(326506-321999)l=W[p]C=Z[l]a=u(z,C)a=v(668719-664162)u=D[a]z=e[t[-70584+70591]]E=11912910713418-597151 Z=e[t[429785+-429777]]W=e[t[368666-368664]]b=e[t[165271-165268]]p=b(U,E)U=v(853813+-849548)l=W[p]C=Z[l]a=u(z,C)a=v(-1041718+1046275)u=D[a]z=e[t[241158+-241151]]Z=e[t[-104259+104267]]W=e[t[-972906+972908]]b=e[t[-601221+601224]]E=13133494649091-108832 p=b(U,E)l=W[p]C=Z[l]a=u(z,C)a=v(-42974+47531)u=D[a]z=e[t[-1044810-(-1044817)]]Z=e[t[845084+-845076]]W=e[t[460907-460905]]b=e[t[-208220-(-208223)]]Y=13473755-127772 E=17794827802493-538399 U=v(-903573+907812)p=b(U,E)l=W[p]C=Z[l]a=u(z,C)end end end else if Y<13042223-205524 then if Y<-259091+13060517 then if Y<12076155-(-720203)then q=v(-28879+33343)K=D[q]Y=D[v(66242-62135)]q=v(306471-302483)x=K[q]q=e[t[1718+-1717]]K={x(q)}g={d(K)}else J=false m=true Y=749843+10140030 A=false e[t[-140381-(-140393)]]=J U=v(-960102-(-964276))a=v(-499573+503638)e[t[-809094-(-809107)]]=m e[t[668581-668567]]=A u=D[a]z=e[t[-675482+675485]]E=29099677489573-(-678729)Z=e[t[-66540+66544]]W=e[t[380545+-380540]]b=e[t[-988266-(-988272)]]p=b(U,E)l=W[p]C=Z[l]Z=237745-237744 a=u(z,C,Z)end else if Y<-614928+13430659 then T=v(-112008+116055)K=v(804164-800029)Y=D[K]N=e[t[716066+-716063]]T=N[T]S={T(N)}N={Y(d(S))}K=N[160184-160183]Y=758131+2249242 q=N[1011204-1011202]o=N[-519028+519031]else Y=e[t[-675487-(-675497)]]K=e[t[-802330-(-802341)]]x[Y]=K Y=e[t[679366-679354]]K={Y(x)}Y=D[v(205627+-201547)]g={d(K)}end end else if Y<344239+12527847 then if Y<12941545-87699 then Y=D[v(839547-835666)]g={}x=nil else Y=z and 671785+10630741 or-271805-(-695899)end else if Y<-1024064+13904783 then Y=g and 520891+7912428 or 17400704-895204 else Y={}K=-989825+989826 x=Y q=e[t[-236646+236655]]o=q q=-486317-(-486318)Y=3787550-(-286118)N=q q=-970865+970865 S=N<q q=K-N end end end end else if Y<13877451-681961 then if Y<14028138-1029527 then if Y<13237232-276911 then if Y<13440239-520883 then Y=e[T]l=621411+-621410 W=302791-302785 Z=Y(l,W)Y=v(31244+-27108)W=v(-917478+921614)D[Y]=Z l=D[W]W=612073-612071 Y=l>W Y=Y and 8401188-(-531169)or 11747977-(-755750)else Y=A Y=m and 6608640-(-601703)or-218663+1326694 end else if Y<503222+12466173 then o,S=K(q,o)Y=o and 8303709-880922 or 1019048+2332600 else N=v(-492690+496645)g=true J=489180+9861593750292 Y=true W=22316042594037-147038 O=v(-111557+115602)e[t[887024+-887023]]=Y K=v(-940196-(-944747))e[t[-107269-(-107271)]]=g q=true x=D[K]K=x(q)K=e[t[130878-130875]]o=D[N]S=e[t[-652936+652940]]T=e[t[-1005208-(-1005213)]]m=v(-749236-(-753379))X=T(O,J)N=S[X]q=o[N]N=-188487-(-188488)A=698794+4085904481732 T=e[t[-886645-(-886648)]]S=#T o=q(N,S)x=K[o]K=h()q=v(-294322-(-298387))e[K]=x x=D[q]o=e[t[-375411+375417]]S=e[t[-533857+533864]]X=e[t[436159+-436155]]O=e[t[-1005126+1005131]]J=O(m,A)O=-342667+17543839980148 T=X[J]N=S[T]S=-355594+355595 q=x(o,N,S)N=e[t[765391-765387]]S=e[t[-438109+438114]]X=v(-144592+148957)T=S(X,O)o=N[T]N=M(-231779+740449,{t[-761973+761977];t[-767972+767977],t[-509983+509991]})x=q[o]o=v(-768047+772314)O=v(222023+-217990)o=x[o]o=o(x,N)J=23268289398982-(-549261)S=e[t[330714-330710]]T=e[t[984703+-984698]]u=v(-742763-(-747175))X=T(O,J)N=S[X]x=q[N]N=v(-838259-(-842348))N=x[N]S=276997+-276992 N=N(x,S)N=v(-1012234+1016299)x=D[N]l=v(50178+-46201)S=e[t[-905413+905419]]X=e[t[-705753+705760]]J=e[t[369993-369989]]a=202287+15080528463167 m=e[t[-850136+850141]]A=m(u,a)O=J[A]T=X[O]X=756042+-756041 N=x(S,T,X)T=e[t[-946255+946259]]m=880152+23723227413774 X=e[t[-542277+542282]]J=v(221057-216571)O=X(J,m)S=T[O]T=M(-208035-(-691640),{t[-354255-(-354259)];t[-980154-(-980159)],t[-745516+745525],K,t[-508865-(-508875)]})A=-410441+14824057052735 x=N[S]S=v(555671+-551404)S=x[S]S=S(x,T)m=v(-758658-(-762752))X=e[t[198175-198171]]O=e[t[625168+-625163]]J=O(m,A)T=X[J]x=N[T]T=v(-724189+728278)T=x[T]T=T(x)x=v(335161-331195)x=o[x]x=x(o)x=v(438214-434248)x=S[x]x=x(S)T=false O=v(560730-556179)x=false J=false e[t[620389-620388]]=x e[t[44434+-44432]]=T X=D[O]O=X(J)X=e[t[218019-218008]]O=X()u=e[t[-689071+689083]]O=Y z=e[t[-108835-(-108839)]]C=e[t[494377-494372]]Z=C(l,W)a=z[Z]Z=v(864316+-860322)A=u[a]l=-388231+31921336460951 a=e[t[773515+-773511]]z=e[t[981260+-981255]]C=z(Z,l)u=a[C]m=A[u]A=-585658-(-585659)J=m<A Y=J and-302163+6744447 or 11860316-828272 X=J end end else if Y<896157+12233883 then if Y<12934796-(-121142)then N=nil S=nil Y=15998619-483459 else Y=S Y=N and 486368+3187083 or 6659702-403592 end else if Y<13901067-721342 then e[t[-828757+828762]]=g x=nil Y=2412357-809706 else S=nil N=nil Y=-876364+4949843 end end end else if Y<13304070-(-84338)then if Y<13115279-(-194201)then if Y<13595949-330486 then o=v(1030270+-1026265)g=D[o]O=21263620186599-(-918726)N=e[t[99681+-99678]]X=v(491398-487250)S=e[t[711275+-711271]]T=S(X,O)o=N[T]Y=g[o]N=v(-889489-(-893599))o=D[N]g=Y(x,o)g=v(597616+-593447)Y=D[g]o=-687073+3749467138 g=Y(o)J=5065646267183-(-912903)g=v(374845-370285)O=v(333761-329381)Y=D[g]S=e[t[-1861-(-1864)]]T=e[t[-896629-(-896633)]]X=T(O,J)N=S[X]o=x[N]g=Y(o)Y=e[t[-424072+424077]]g=Y()Y=9221878-214675 else g=v(297536-293401)Y=D[g]S=v(7731+-3684)o=e[t[77432-77429]]S=o[S]N={S(o)}o={Y(d(N))}K=o[-650839+650841]q=o[736917+-736914]g=o[-622205+622206]Y=487777+8540949 o=g end else if Y<1002360+12331368 then q=18694505071-(-250431)K=v(194048-189879)Y=D[K]K=Y(q)K=v(-772789-(-776686))Y=D[K]K=Y()Y=427602+7590091 else g={}N=nil Y=D[v(930008-925747)]K=nil x=nil q=nil o=nil end end else if Y<14095329-640687 then if Y<12990529-(-434786)then m=v(-680976-(-684858))S=e[t[310342-310338]]X=e[t[134737+-134735]]O=e[t[-239593+239596]]A=131604+22523543987940 J=O(m,A)Y=13958908-(-1047798)T=X[J]N=S[T]S=-230486+230486 o=N>S K=o else r=2866255640162-553260 p=v(398739-394599)a=v(-595227-(-599416))u=D[a]Z=v(983080+-979171)n=-416277+7662202546180 a=v(1028540+-1024635)C=D[Z]l=e[t[860356+-860352]]E=v(607491+-603275)W=e[t[-559685+559690]]U=28998853681936-880209 b=W(p,U)Z=l[b]z=C[Z]l=e[t[-675247-(-675259)]]b=e[t[242729+-242725]]p=e[t[141287+-141282]]U=p(E,r)W=b[U]U=v(630620+-626582)B=v(656787-652413)Z=l[W]Dq=12641777618428-(-379138)p=D[U]F=604222+16595479750129 i=v(-424084+428205)E=e[t[528569+-528565]]s=v(100077+-95540)r=e[t[601679-601674]]c=r(s,Dq)U=E[c]G=19117698989346-760412 b=p[U]E=e[t[-1033311+1033323]]Y=14163388-137786 c=e[t[-932572+932576]]s=e[t[1008767+-1008762]]Dq=s(i,F)r=c[Dq]U=E[r]c=e[t[825594-825582]]Dq=e[t[-555438-(-555442)]]i=e[t[-892678+892683]]F=i(B,n)s=Dq[F]r=c[s]Dq=v(-739080+743192)s=D[Dq]i=e[t[-732866-(-732870)]]F=e[t[-153369-(-153374)]]n=v(735929+-731725)B=F(n,G)Dq=i[B]c=s[Dq]i=-620117-(-620116)Dq=-677511-(-677511)F=-284077+284077 s=c(Dq,i,F)E=r+s p=b(U,E)U=e[t[-220303-(-220307)]]c=v(-831306-(-835377))E=e[t[654327-654322]]s=25455728464004-(-564681)r=E(c,s)b=U[r]W=p[b]b=-101309+101313 l=W*b C=z(Z,l)z=e[t[-244865-(-244871)]]a=u[a]a=a(u,C,z)m=a end else T=-64867-(-64868)N=q Y=v(198123+-194144)Y=S[Y]N=nil Y=Y(S,T)Y=8594644-(-434082)S=nil end end end end else if Y<12966593-(-958273)then if Y<14744807-1038595 then if Y<-797938+14334594 then if Y<-163558+13655234 then if Y<13779057-289848 then g=v(43794+-39625)Y=D[g]K=18694219854-(-542538)g=Y(K)S=v(-797827+801874)g=v(-1044544+1048679)Y=D[g]o=e[t[418137+-418134]]S=o[S]N={S(o)}o={Y(d(N))}q=o[-801544-(-801547)]g=o[-911527+911528]K=o[-526025-(-526027)]o=g Y=-686504+2407155 else q=e[t[-372497-(-372498)]]o=e[t[193260+-193258]]T=31118796825713-(-119849)S=v(-127423-(-131678))N=o(S,T)K=q[N]Y=x==K Y=Y and 286153+6455905 or-670255+7837962 end else if Y<-88422+13620610 then K=v(788158-784023)Y=D[K]N=e[t[386213-386209]]T=v(-815458-(-819505))T=N[T]S={T(N)}N={Y(d(S))}K=N[-572804-(-572805)]Y=1432782-(-321268)o=N[223165-223162]q=N[-788556-(-788558)]else z=v(-910524+915082)A=e[t[596428-596427]]C=16466924233041-(-998563)u=e[t[707327+-707325]]a=u(z,C)m=A[a]z=16879025863423-662604 J=X[m]O=J-x m=e[t[-699220-(-699221)]]A=e[t[336814-336812]]a=v(-10718+14714)u=A(a,z)J=m[u]Y=O[J]O=Y Y=O<q Y=Y and 131616+1517064 or 4560353-960962 end end else if Y<-67663+13663873 then if Y<593786+12967145 then g=e[t[-299248+299249]]K=e[t[519254-519252]]S=-894425+19833581586924 q=e[t[-628794-(-628797)]]N=v(881735+-877829)o=q(N,S)x=K[o]Y=g[x]Y=Y and 4514910-(-489127)or 15459794-972928 else Z=v(176382-171998)r=13474712172921-975095 E=v(-725520-(-729460))Z=K[Z]b=e[t[883004+-883003]]p=e[t[550106-550104]]U=p(E,r)W=b[U]l=a[W]W=true Z=Z(K,l,W)C=not Z z=C Y=12951865-92134 end else if Y<473069+13199724 then N=q X=e[t[-148536-(-148537)]]A=24827702213028-(-947077)m=v(834715+-830447)O=e[t[-212579+212581]]J=O(m,A)T=X[J]Y=v(-814826+819177)Y=S[Y]Y=Y(S,T)Y=Y and 9149565-199313 or 11537993-655931 else Y=O Y=X and 11672471-184551 or 11791352-(-337619)end end end else if Y<13711922-(-50407)then if Y<-930613+14680598 then if Y<445544+13288905 then s=Y i=nil Dq=q~=i Y=Dq and 3212864-(-721333)or 503456+13294260 c=Dq else Y=v(1003331-999352)T=-935551-(-935552)N=o Y=S[Y]Y=Y(S,T)Y=3484912-(-605173)N=nil S=nil end else if Y<13275400-(-480332)then g=v(-927073+931327)Y=D[g]g=Y()Y=862047+2984450 else T=-647309+647310 Y=v(-260748-(-264727))Y=S[Y]Y=Y(S,T)Y=2127265-(-125238)end end else if Y<14233019-431982 then if Y<13939196-157701 then x=nil g={}Y=D[v(88354-84418)]else E=c Y=s Y=12029394-730170 end else if Y<910509+13008820 then q=60252+17373115574 K=v(-381466+385635)Y=D[K]K=Y(q)Y=6987236-(-595692)else Y=3738329-581990 end end end end else if Y<14849574-624467 then if Y<570298+13442109 then if Y<-449106+14384110 then if Y<590269+13342392 then Y=v(85050+-80699)Y=X[Y]J=e[t[136575+-136574]]T=N a=18436350210654-(-732971)m=e[t[-1031808+1031810]]u=v(421014+-417012)A=m(u,a)O=J[A]Y=Y(X,O)Y=Y and 440589+13095388 or 7630427-503755 else Y=true e[t[721143+-721139]]=Y Y=-963637+17469137 end else if Y<14015131-65435 then X=nil Y=1444604-20804 T=nil else g=v(468249-463808)x=v(-597198-(-601368))Y=D[g]g=Y(x)g={}Y=D[v(673353+-669155)]end end else if Y<13363231-(-715377)then if Y<-259238+14287607 then Y=A Y=m and 15277518-(-131409)or 10988678-543049 else K=v(-661881-(-666016))T=v(-374729-(-378776))Y=D[K]N=e[t[177765+-177761]]T=N[T]S={T(N)}N={Y(d(S))}q=N[-338692+338694]K=N[427750-427749]o=N[94429-94426]Y=-106738+13067096 end else if Y<589037+13514794 then Y=772552-(-335479)A=v(289845+-285780)O=false J=false X=true e[t[-296591-(-296605)]]=X e[t[10655-10640]]=O b=v(495214-491219)e[t[76241-76225]]=J m=D[A]p=21260991634186-865374 u=e[t[446532-446529]]z=e[t[916450-916446]]Z=e[t[-368521-(-368526)]]l=e[t[924802+-924796]]W=l(b,p)C=Z[W]a=z[C]z=-108868-(-108869)A=m(u,a,z)else g={}Y=D[v(511012+-506987)]end end end else if Y<-286527+14729453 then if Y<14902616-489777 then if Y<232859+14061199 then g={o}Y=D[v(-430174+434645)]else S=nil Y=-546703+2300753 N=nil end else if Y<15104273-668466 then J=-508754-(-508757)O=h()e[O]=g a=w(16959771-836034,{})m=540985-540920 Y=e[T]g=Y(J,m)u=v(-408031+411980)Y=715442-715442 m=Y J=h()Y=612660-612660 A=Y e[J]=g g=D[u]u={g(a)}g=639855+-639853 Y={d(u)}u=Y Y=u[g]a=Y g=v(-859289+863481)l=v(-98770-(-103068))Y=D[g]z=e[q]Z=D[l]l=Z(a)Z=v(839850-835865)C=z(l,Z)z={C()}g=Y(d(z))z=h()Y=15133316-636281 e[z]=g g=955180+-955179 C=e[J]Z=C C=79889-79888 l=C C=397068+-397068 W=l<C C=g-l else Y=697984+4663505 end end else if Y<14034616-(-452740)then if Y<-618629+15102011 then O=e[t[-906443-(-906446)]]Y=-682692+1730059 m=e[t[463037+-463036]]z=-741275+25385842081224 a=v(-629793+634162)A=e[t[-380107+380109]]u=A(a,z)J=m[u]X=O[J]S=X else g={}Y=D[v(-976872-(-981011))]end else N=e[t[515398-515397]]S=e[t[443458+-443456]]x=P[-870780-(-870781)]A=-786677+24518348254606 X=v(-709613-(-713904))O=-319556+6335905344458 T=S(X,O)o=N[T]q=x[o]T=v(789060+-784952)S=D[T]m=v(-103992+108411)X=e[t[165763+-165762]]O=e[t[889474-889472]]J=O(m,A)T=X[J]N=S[T]m=-674854+13843693380948 T=e[t[290170-290169]]X=e[t[367592-367590]]J=v(-104372+108911)O=X(J,m)S=T[O]o=N[S]K=q==o g=K Y=K and 350585+5948473 or 1860720-633542 end end end end end else if Y<16639289-772653 then if Y<16146054-816130 then if Y<14707113-(-237599)then if Y<1005803+13695119 then if Y<13938774-(-614540)then if Y<14238057-(-281238)then C=C+l b=not W g=C<=Z g=b and g b=C>=Z b=W and b g=b or g b=-586685+8136767 Y=g and b g=10082072-(-391152)Y=Y or g else g={}Y=e[t[980696+-980695]]Y[x]=g Y=-593660+4442805 end else if Y<14049036-(-589397)then i=Y n=-318674+318675 B=s[n]n=false F=B==n Y=F and 16141439-(-79865)or 438994+9330071 Dq=F else Dq=e[K]g=Dq Y=Dq and 15533683-896113 or 437507+15395924 end end else if Y<14124868-(-719400)then if Y<-772784+15528140 then Y=D[v(540538+-536321)]x=nil g={}else J=-717220+5795677125678 z=9734180927286-(-301694)g=v(-1009144+1013333)O=v(-357525+361662)l=v(157380-153196)Y=D[g]m=v(-67161+71409)N=v(-48833-(-52742))o=D[N]S=e[t[98143+-98141]]T=e[t[146318-146315]]X=T(O,J)N=S[X]q=o[N]S=e[t[-526628+526632]]a=v(-853956+858089)X=e[t[371196+-371194]]A=28827235361526-568967 W=-814003+3275130106280 O=e[t[-590006+590009]]J=O(m,A)b=28537062881884-165492 T=X[J]N=S[T]J=v(665174-661136)O=D[J]m=e[t[407328-407326]]A=e[t[216106-216103]]u=A(a,z)J=m[u]X=O[J]m=e[t[813684-813680]]u=e[t[-519312-(-519314)]]Z=-570269+26486609273802 C=v(-111578-(-116001))a=e[t[962575-962572]]z=a(C,Z)A=u[z]J=m[A]u=e[t[-731353-(-731357)]]z=e[t[-38427-(-38429)]]C=e[t[-82240+82243]]Z=C(l,W)a=z[Z]z=v(-219945-(-224057))A=u[a]W=v(622798-618791)a=D[z]C=e[t[647888+-647886]]Z=e[t[724528+-724525]]l=Z(W,b)z=C[l]u=a[z]z=552059-552059 C=-290771+290770 Z=72397+-72397 a=u(z,C,Z)m=A+a O=X(J,m)u=v(82024-77717)J=e[t[-789287+789289]]a=572013+14726686466140 m=e[t[656205+-656202]]A=m(u,a)X=J[A]T=O[X]X=-406376-(-406380)S=T*X o=q(N,S)q=e[t[-78307+78314]]N=v(705074-701169)N=Y[N]N={N(Y,o,q)}J=11107041481925-(-950127)o=e[t[775188-775184]]O=v(-97776-(-102236))g=N[710504+-710503]q=g K=N[963771+-963769]S=e[t[-558083+558085]]T=e[t[320114+-320111]]X=T(O,J)N=S[X]J=v(-118071+122534)g=o[N]O=13400363321214-913182 X=v(950703+-946325)N=e[t[-34736+34738]]S=e[t[358171-358168]]T=S(X,O)o=N[T]Y=g[o]m=21062591785268-(-277788)o=Y N=e[t[726827-726823]]T=e[t[-139578-(-139580)]]X=e[t[-369174+369177]]O=X(J,m)S=T[O]O=v(-674173+678727)g=N[S]S=e[t[-228454+228456]]J=431255+441017363510 T=e[t[219399-219396]]X=T(O,J)T=-434640-(-434641)N=S[X]Y=g[N]N=Y S=N>T g=S Y=S and 3786436-(-253847)or 7885435-838511 end else if Y<763939+14123643 then K,N=q(x,K)Y=K and 7970529-(-707578)or 663747+1742877 else Y=-213693+6503176 S=nil N=nil end end end else if Y<14450319-(-700870)then if Y<-615977+15620895 then if Y<310782+14640381 then g=X Y=O Y=15180270-(-95145)else Y=e[t[-833018+833019]]Y=Y and-306368+7133666 or-100425+10043678 end else if Y<685519+14367658 then Y=q Y=297030+6168239 g=K else x=v(-962832-(-967273))Y=D[x]q=70228-70228 K=e[t[-123757+123765]]x=Y(K,q)Y=-44762+12926525 end end else if Y<14403755-(-869532)then if Y<-594772+15813540 then g={}Y=D[v(56280-52028)]else Y=v(914664-910685)Y=S[Y]N=q N=nil T=567789-567788 Y=Y(S,T)S=nil Y=8674403-(-219676)end else if Y<15754342-469179 then Y=T Y=g and-48329+8667982 or 7468553-(-164908)else K=v(434382-430247)Y=D[K]T=v(-262181-(-266228))N=e[t[189365+-189361]]T=N[T]S={T(N)}N={Y(d(S))}Y=5935286-(-354197)o=N[369127-369124]q=N[-723236-(-723238)]K=N[5298-5297]end end end end else if Y<-481126+16073472 then if Y<16354021-907516 then if Y<15424548-20632 then if Y<14427202-(-950113)then e[K]=C Y=e[K]Y=Y and 10674071-254246 or 10127269-(-102010)else Y=O Y=X and 975439-(-102353)or 7078104-(-308203)end else if Y<14815226-(-612662)then r=204034+17523796165342 m=false e[t[889033+-889020]]=m Y=-509500+10955129 E=v(527578-523399)A=true z=v(995328+-991263)u=false e[t[325838-325824]]=A e[t[-735393-(-735408)]]=u a=D[z]C=e[t[-73284+73290]]l=e[t[-476472-(-476479)]]b=e[t[964668-964664]]p=e[t[580968+-580963]]U=p(E,r)W=b[U]Z=l[W]l=-668748+668749 z=a(C,Z,l)else g=e[t[201444+-201443]]Y=g[x]X=36198+6475920195169 o=e[t[983046+-983044]]N=e[t[863503+-863500]]T=v(-1044005+1048024)S=N(T,X)q=o[S]o=v(-561969+565899)g=K[q]q=e[t[-199619+199620]]o=q[o]o=o(q,x,K)Y[g]=o Y=4793452-(-355624)end end else if Y<404171+15060298 then if Y<750002+14707341 then x=nil Y=D[v(-535389+539465)]g={}else z=v(-899083-(-903148))u=true e[t[-453080-(-453093)]]=u a=D[z]C=e[t[-142398+142405]]l=e[t[-417424-(-417432)]]b=e[t[-563722-(-563724)]]E=v(850735+-846652)p=e[t[950080+-950077]]r=676857+3434933285446 U=p(E,r)W=b[U]Z=l[W]Y=783817+11371971 l=.1 W=-390663-(-390664)z=a(C,Z,l,W)end else if Y<-171569+15658413 then m=v(997870-993528)Y=v(61995+-57644)Y=S[Y]N=q X=e[t[596529-596528]]A=27330765155051-(-247499)O=e[t[360786+-360784]]J=O(m,A)T=X[J]Y=Y(S,T)Y=Y and 15407054-(-638225)or 8803223-547897 else o,S=K(q,o)Y=o and 16151293-(-312305)or 94007+4176672 end end end else if Y<16439420-667796 then if Y<793634+14848950 then if Y<15745615-111444 then z=z+b U=not p a=z<=W a=U and a U=z>=W U=p and U a=U or a U=5735522-728993 Y=a and U a=-158229+6339787 Y=Y or a else Y=T and 696145+7419158 or 409422+4506486 end else if Y<16407387-732556 then Y=J Y=O and 8172843-(-681253)or 803718+4704339 else Y=D[v(268859-264895)]g={}end end else if Y<15662523-(-173048)then if Y<448711+15346551 then X=false m=v(-747776+751841)O=false T=true e[t[-351701+351713]]=T Y=10559219-(-330654)e[t[1047431+-1047418]]=X e[t[600806+-600792]]=O J=D[m]A=e[t[-716551-(-716554)]]a=e[t[-411365+411369]]C=e[t[873596-873591]]W=v(-693232+697627)b=-303478+9137503072788 Z=e[t[-441787+441793]]l=Z(W,b)z=C[l]u=a[z]a=-967669-(-967670)m=J(A,u,a)else Y=-546278+10882311 e[K]=g end else Y=false e[t[-62616+62619]]=Y Y=-178340+14926851 end end end end else if Y<-429424+16760243 then if Y<16482565-347495 then if Y<353729+15625934 then if Y<15654322-(-310451)then if Y<-511161+16463319 then q=P[-1043988-(-1043991)]x=P[-214972-(-214973)]K=P[67250+-67248]o=e[t[538979+-538978]]g=o[x]Y=not g Y=Y and 239305+14293290 or 4734784-885639 else Y=true Y=Y and 4116776-(-959036)or 741250+2142163 end else if Y<14997336-(-973660)then T=579101+-579100 N=q N=nil Y=v(153107-149128)Y=S[Y]Y=Y(S,T)Y=469778+1131874 S=nil else S=v(-83299+87433)A=34850624939392-75292 N=D[S]m=v(894352-890043)X=e[o]O=e[K]J=O(m,A)T=X[J]S=N(T)q=not S Y=q and-682872+4220415 or 331062+4832833 end end else if Y<15419061-(-672174)then if Y<121674+15922173 then a=false u=e[t[337267+-337261]]Y=-831625+17145534 A=u==a J=A else T=430932-430931 Y=v(-620741-(-624720))Y=S[Y]Y=Y(S,T)Y=7354434-(-900892)end else if Y<15262006-(-870369)then K=v(662456+-658124)g=14904213-703093 q=8096011-370794 x=K^q Y=g-x g=v(783734+-779357)x=Y Y=g/x g={Y}Y=D[v(-1040279+1044484)]else S=false N=true e[t[715197+-715185]]=N T=false O=v(-1010615+1014680)Y=6611277-(-775030)e[t[985192-985179]]=S e[t[-44387-(-44401)]]=T l=1039248635322-(-756777)X=D[O]J=e[t[236455+-236452]]A=e[t[977670-977666]]Z=v(-467295+471379)a=e[t[870918-870913]]z=e[t[584165+-584159]]C=z(Z,l)u=a[C]m=A[u]A=-910789-(-910790)O=X(J,m,A)end end end else if Y<15290991-(-936981)then if Y<15423978-(-755612)then if Y<536585+15617344 then u=-82336+6230227651829 S=e[t[102357+-102356]]O=v(-242677+246895)C=-568997+34634375359908 A=v(2444-(-1916))T=e[t[-750562-(-750564)]]J=-175121+11632318497081 z=v(126468+-122554)X=T(O,J)g=S[X]O=e[t[85283-85282]]J=e[t[124702+-124700]]m=J(A,u)X=O[m]A=v(697842+-693363)T=K[X]O=e[t[-632421+632422]]J=e[t[355408-355406]]u=49865+10790319886551 m=J(A,u)X=O[m]S=T[X]X=e[t[836068+-836067]]O=e[t[-217343-(-217345)]]A=28890822392200-(-604933)m=v(-605155-(-609194))J=O(m,A)T=X[J]O=Y A=e[t[-207406-(-207407)]]u=e[t[-511734-(-511736)]]a=u(z,C)m=A[a]Z=707198+15126788067589 J=K[m]u=e[t[760130+-760129]]C=v(-714311+718412)a=e[t[941623+-941621]]z=a(C,Z)A=u[z]m=v(-646672-(-651056))m=J[m]m=m(J,A)X=m Y=m and-63760+2070150 or-310497+7531308 else g=v(-988764+992932)Y=D[g]N=v(399951+-396071)q=e[t[758451+-758450]]N=q[N]o={N(q)}q={Y(d(o))}Y=270331+14575488 x=q[842968+-842966]K=q[289727+-289724]g=q[99116+-99115]q=g end else if Y<15579057-(-623591)then g=v(-887527+891662)Y=D[g]o=e[t[813543-813540]]S=v(786839+-782792)S=o[S]N={S(o)}o={Y(d(N))}q=o[-776776-(-776779)]Y=2017101-415449 g=o[562089+-562088]K=o[-729332+729334]o=g else n=-591249+591251 Y=10746313-977248 B=s[n]n=e[c]F=B==n Dq=F end end else if Y<263038+16047859 then if Y<384770+15918153 then x=P[517318-517317]Y=e[t[-334028-(-334029)]]A=-803034+8633561075854 N=v(-317625+321548)X=v(-911937-(-916392))K=e[t[-142070+142072]]q=e[t[689216-689213]]S=-42136+9906573866653 o=q(N,S)g=K[o]q=e[t[788055-788054]]N=e[t[654650-654648]]u=-283406+31533464833129 S=e[t[-843949-(-843952)]]O=153504+9441079097740 T=S(X,O)m=v(944202+-939844)o=N[T]K=q[o]S=e[t[641845-641841]]X=e[t[-656288+656290]]O=e[t[993592-993589]]J=O(m,A)T=X[J]X=v(671424+-667386)N=S[T]T=D[X]A=v(461179+-457038)q=v(644876+-640395)O=e[t[-707839+707841]]J=e[t[498813+-498810]]m=J(A,u)X=O[m]S=T[X]O=574122+-574120.5 J=-940205+940205 u=26706396565123-613871 X=17968+-17968 T=S(X,O,J)o=N*T T=e[t[114489-114484]]O=e[t[-883828+883830]]A=v(-578142-(-582538))J=e[t[499501-499498]]N=v(485787+-481643)m=J(A,u)X=O[m]S=T[X]N=o[N]m=v(689610-685374)N=N(o,S)T=v(-880828+884783)S=D[T]X=e[t[-620873-(-620875)]]O=e[t[288507+-288504]]A=-200019+4571226543523 J=O(m,A)T=X[J]o=S[T]T=-1007826-(-1036626)O=-795468-(-795469)X=-869109-(-869109)S={o(T,X,O)}q=K[q]q=q(K,N,d(S))Y[g]=q Y=e[t[604990+-604984]]Y=Y and 2768331-473090 or 170456+9733060 else m=Y u=nil A=q~=u J=A Y=A and 16596635-555332 or 17320770-1006861 end else X=J Y=m Y=406975+2407850 end end end else if Y<155724+16357944 then if Y<16685175-240686 then if Y<625164+15764013 then if Y<15414160-(-953226)then T=v(-483255+487206)x=P[-979222-(-979223)]K=v(80743-76271)g=D[K]o=e[t[-167501-(-167502)]]N=e[t[-406761-(-406763)]]J=24420116061130-143199 X=8182433476369-(-991185)O=v(932276-927957)S=N(T,X)K=v(929215-924858)K=g[K]q=o[S]T=8135941234321-(-749627)K=K(g,q)S=v(885858-881629)q=e[t[566940-566939]]o=e[t[276251+-276249]]N=o(S,T)g=q[N]Y=K[g]g=v(919387-915298)o=e[t[-728740+728743]]S=e[t[-566369+566370]]T=e[t[-252298+252300]]X=T(O,J)N=S[X]g=Y[g]q=o[N]K=x/q g=g(Y,K)x=nil Y=D[v(633881-629328)]g={}else l=true e[t[375418+-375406]]=l b=v(-19203-(-23268))W=D[b]p=e[t[538374+-538367]]E=e[t[743999+-743991]]F=31962295553257-398022 c=e[t[-860597+860599]]i=v(-268904-(-273192))s=e[t[689897-689894]]Dq=s(i,F)r=c[Dq]U=E[r]E=757080-757078 Y=10733599-(-731780)b=W(p,U,E)end else if Y<-257970+16659911 then N=v(699052-695017)K=e[t[306015+-306014]]x=P[-21386-(-21387)]q=e[t[-717931+717933]]S=-816408+11287522085280 o=q(N,S)g=K[o]Y=x==g Y=Y and-23541+13315999 or 8369943-352250 else q=e[t[-1023158+1023159]]O=45820+4425827603728 X=v(1016873+-1012928)N=e[t[434428-434426]]S=e[t[-612319-(-612322)]]T=S(X,O)o=N[T]K=q[o]x=not K g=x Y=x and-327657+8075047 or 5833525-(-884136)end end else if Y<16276327-(-190471)then if Y<607798+15850410 then Y=g and 269455+8046147 or-803094+13124805 else N=o m=v(-735805+740155)X=e[t[647002+-647001]]O=e[t[158287+-158285]]A=292231+26303605897809 J=O(m,A)Y=v(78851-74500)Y=S[Y]T=X[J]Y=Y(S,T)Y=Y and 3454594-870520 or 24497+13014631 end else if Y<17404455-900188 then g=v(-157909-(-162340))Y=D[g]g=Y()Y=-148686+8138771 else x=nil Y=D[v(244807+-240424)]g={}K=nil end end end else if Y<17555872-865736 then if Y<15716555-(-903895)then if Y<564823+16047529 then O=Y m=-713639+713640 J=o<m X=J Y=J and 15434891-(-875791)or 2262596-(-552229)else E=true vq=-852404+26529208185333 c=v(-561517-(-565582))e[t[-991687-(-991698)]]=E r=D[c]s=e[t[-845520+845527]]f=v(444073+-440033)i=e[t[956428+-956420]]B=e[t[-420287+420289]]n=e[t[350709+-350706]]G=n(f,vq)F=B[G]Dq=i[F]i=-812686+812687 c=r(s,Dq,i)Y=-259644+3727306 end else if Y<15620400-(-1026415)then b=e[t[625745+-625744]]Y=517606+11788006 E=v(-256901-(-260811))p=e[t[203475+-203473]]r=30650342495661-(-991763)U=p(E,r)l=v(1047984-1043633)W=b[U]l=a[l]l=l(a,W)C=l else Y=7842535-369274 end end else if Y<16524783-(-218620)then if Y<-204289+16912361 then x=e[t[-507536-(-507537)]]g=#x x=556965+-556965 Y=g==x Y=Y and 4539909-401102 or 13573765-787231 else K=P[-288527+288529]x=P[458359-458358]X=23485131345697-631913 o=e[t[-776348-(-776349)]]N=e[t[-411745+411747]]T=v(419077+-415199)S=N(T,X)q=o[S]O=-622427+20106016318445 X=v(530332+-526357)g=x[q]N=e[t[535144-535143]]S=e[t[-811446+811448]]T=S(X,O)o=N[T]q=K[o]Y=g<q g={Y}Y=D[v(386319+-381849)]end else N=e[t[151559+-151558]]m=21358031930084-973835 o=N[x]T=e[t[-429794-(-429796)]]X=e[t[730499+-730496]]J=v(729488+-725121)O=X(J,m)S=T[O]N=K[S]Y=o[N]J=v(-846892+851233)m=22781000586003-928163 o=Y T=e[t[139333-139331]]X=e[t[462104+-462101]]O=X(J,m)S=T[O]N=o[S]Y=not N Y=Y and 8214637-848148 or-179033+14423671 end end end end end end end end end Y=#Q return d(g)end,function(D,v)local d=q(v)local P=function(P,t)return Y(D,{P,t},v,d)end return P end,function(D,v)local d=q(v)local P=function(P,t,Q,k)return Y(D,{P;t,Q,k},v,d)end return P end,function(D,v)local d=q(v)local P=function(...)return Y(D,{...},v,d)end return P end,function()K=(114181+-114180)+K x[K]=130778+-130777 return K end,function(D,v)local d=q(v)local P=function(P,t,Q,k,g,e,x)return Y(D,{P,t;Q;k,g,e,x},v,d)end return P end,{},-140696-(-140696),function(D)local v,Y=-31639-(-31640),D[-477259+477260]while Y do x[Y],v=x[Y]-(71897+-71896),v+(-1023687+1023688)if 37099+-37099==x[Y]then x[Y],e[Y]=nil,nil end Y=D[v]end end,{},function(D,v)local d=q(v)local P=function(P)return Y(D,{P},v,d)end return P end,function(D)for v=827965-827964,#D,-1010248+1010249 do x[D[v]]=(-1043234+1043235)+x[D[v]]end if P then local Y=P(true)local d=Q(Y)d[v(303985-299531)],d[v(179203-174822)],d[v(528000-523987)]=D,o,function()return-1946089-(-600210)end return Y else return t({},{[v(82989+-78608)]=o,[v(-206947+211401)]=D,[v(-162569+166582)]=function()return-1688137-(-342258)end})end end,function(D,v)local d=q(v)local P=function(P,t,Q,k,g,e)return Y(D,{P,t;Q,k;g,e},v,d)end return P end return(N(4543810-(-295678),{}))(d(g))end)(getfenv and getfenv()or _ENV,unpack or table[v(22+4184)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
