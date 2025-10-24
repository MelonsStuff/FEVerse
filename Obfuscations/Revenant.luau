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

local function CreateObject(Name)
    local Part = Instance.new("Part")
    Part.Name = Name
    Part.Massless = true
    Part.CanCollide = true
    Part.CanTouch = false
    Part.Transparency = 1
    Part.Size = Vector3new(0.1, 0.1, 0.1)
    Part.Anchored = true
    Part.Parent = Rig
    return Part
end

local Dummy = CreateObject("Reanimate_Dummy")
local Machete = CreateObject("Reanimate_Machete")
local Chainsaw = CreateObject("Reanimate_Chainsaw")

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
  Chainsaw.Anchored   = false
  Dummy.Anchored = false
  Machete.Anchored = false
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
-- Revenant
{ Name = "Reanimate_Machete",  MeshId = "18355837051", TextureId = "18355837122", Offset = CFrame.Angles(Rad(135), Rad(0), Rad(0)) },
{ Name = "Reanimate_Chainsaw",  MeshId = "10670453071", TextureId = "10670458678", Offset = CFrame.new(-0.1, 0.1, -0.5) * CFrame.Angles(Rad(90),  Rad(0), Rad(-45)) },
{ Name = "Reanimate_Dummy",  MeshId = "104517187424526", TextureId = "133044964286932", Offset = CFrame.Angles(0, Rad(180), 0) },
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
return(function(...)local P={"\053\047\071\085\112\097\061\061","\068\079\080\118\070\071\106\101\114\085\075\106\113\115\048\070\053\051\061\061";"\101\077\080\112";"\089\053\098\073\066\099\108\061","\073\115\110\105\068\122\068\106\114\099\121\108\076\056\117\106\077\047\073\107\068\079\121\090\057\043\121\085";"\107\118\071\078\066\048\052\086\118\113\051\061";"\081\056\049\119\068\076\061\061";"\087\074\049\053\073\115\082\047","\113\067\085\051\082\047\066\049\055\056\055\061";"\087\082\102\086\056\108\079\061";"\057\056\117\117\114\083\061\061";"\122\117\084\043","\111\122\085\097\054\089\116\089\100\112\048\052\120\076\061\061";"\051\080\121\052\078\076\061\061";"\071\073\100\083\104\117\085\069\056\106\071\089\067\109\047\048\067\105\119\114\057\076\061\061","\097\110\080\109\100\053\074\098\107\089\114\072\079\082\111\108","\043\120\099\084\082\048\056\087\076\097\061\061";"\106\109\107\043\089\086\110\088\049\104\082\061","\070\054\113\119\066\076\061\061";"\073\110\110\066\053\122\071\068\070\072\071\068\070\084\066\075\102\076\061\061";"\108\043\071\116\089\112\089\079","\113\069\049\085\053\047\071\105\057\056\084\061","\107\065\100\100\089\113\106\073\122\107\103\074","\080\056\071\106\053\051\061\061";"\109\102\056\112\119\105\053\105\107\115\055\061";"\080\120\107\087\109\107\084\121\118\112\103\113\106\084\105\080\050\067\122\061","\082\117\065\054\119\076\080\119\076\078\052\122\099\068\069\053\090\090\112\051\086\051\061\061";"\085\113\069\082\116\120\106\048\086\102\076\061","\073\056\080\108\084\056\080\103\053\115\110\119\068\076\061\061";"\089\069\089\090\090\075\120\047\065\082\121\055\112\070\099\120\122\068\107\053";"\069\108\116\048\081\067\081\109\120\051\061\061";"\105\051\118\087\113\115\054\108\076\051\061\061";"\050\121\073\114\080\097\118\069\122\106\103\100","\117\097\043\116\074\109\115\104\117\111\104\086\065\085\109\074\088\067\107\090";"\114\056\080\108\077\069\080\108\057\043\073\117\057\115\052\110","\100\067\102\109\065\102\111\052\110\066\077\116\055\115\084\061","\080\085\067\111\080\067\057\098","\081\047\118\122\098\069\079\117\118\055\048\104","\106\079\052\079","\082\052\116\077\067\068\043\053\072\113\083\061","\108\087\047\109";"\122\077\055\061";"\081\075\080\116\084\101\106\057\066\069\082\061","\068\115\081\071";"\080\115\080\119\053\047\065\103\070\097\061\061";"\114\115\073\097\069\047\073\097\068\101\048\082\068\081\075\111";"\097\043\048\106\113\081\050\052";"\114\103\043\084","\099\078\115\089\117\105\085\049\088\115\057\081\100\083\061\061";"\048\050\051\097\065\084\050\052\114\047\090\061";"\112\053\069\089\089\083\061\061","\043\074\080\057\067\072\055\078\111\071\113\116","\098\118\090\080\047\076\061\061","\100\080\101\085\112\109\065\098\076\100\083\073","\090\081\056\050";"\056\107\053\098\087\119\073\076";"\073\119\076\122";"\113\113\119\106\099\051\061\061";"\109\074\103\115\072\110\111\102\088\090\072\111\066\082\099\099\105\067\108\048\086\097\061\061","\081\047\080\103\114\051\061\061","\105\107\088\056\087\114\067\097\068\074\080\076\071\043\119\120";"\053\043\100\103\109\099\112\086\057\043\055\061";"\066\105\056\107\116\085\076\121\048\090\100\061","\080\120\053\110\068\069\049\048\077\115\068\111";"\073\102\074\121\077\081\049\069\057\069\055\061","\107\111\077\086";"\113\043\121\122\068\043\121\119\068\069\049\079\057\069\049\108\081\056\057\061";"\116\122\090\061";"\075\100\079\066\073\108\122\061";"\104\050\106\113\098\121\106\108";"\069\069\108\103\054\100\117\115\051\118\106\106";"\071\076\057\051\119\075\122\061";"\065\097\061\061";"\066\122\109\081\072\100\108\077\054\051\061\061","\078\105\102\043\054\076\061\061";"\085\084\084\111\111\075\106\109\081\073\104\105\113\097\122\048";"\114\047\071\106\114\099\070\061";"\056\071\065\122\103\112\050\106\052\101\106\075\084\120\066\098\057\075\084\097\087\120\048\047\114\067\085\120\076\043\112\043","\107\110\087\112","\104\105\083\113\106\097\061\061";"\101\119\087\100\073\052\081\079\074\105\097\061";"\080\069\117\074\053\084\084\052\102\072\075\056\068\085\071\088","\106\117\056\082\106\083\090\048\110\113\055\086\085\083\061\061";"\077\122\068\071\049\065\114\061","\075\102\121\087\108\104\105\121\048\097\112\068\088\073\047\068\052\080\090\053\103\071\056\086\055\097\061\061";"\065\088\075\055\108\076\061\061";"\065\100\118\103\072\086\103\066\054\053\090\122\065\076\061\061","\119\073\103\100\122\098\075\111\104\097\090\061","\084\087\085\112\120\050\109\081\105\086\084\061";"\122\114\053\119\077\098\088\061","\111\103\077\097\105\074\078\110\055\100\084\061";"\070\110\113\083","\088\110\111\100\069\098\120\071\107\105\055\061","\119\047\077\116\053\078\051\079\043\051\061\061";"\102\097\115\087\054\074\079\076\108\097\117\114";"\068\056\080\108\057\101\080\085\053\047\065\118\057\043\121\085\068\043\076\061","\104\069\071\108\081\084\073\052\121\043\071\082\081\056\106\070\077\047\076\061","\073\056\080\108\113\056\080\049\068\099\048\117\077\069\080\085";"\118\067\108\082\073\110\089\079\077\102\109\066","\049\083\061\061","\057\108\057\056\077\120\073\122\080\085\068\043\053\081\053\116";"\049\101\055\098\084\076\122\080";"\117\113\069\090\102\082\098\054","\079\109\114\084\076\097\052\088\087\121\111\079","\090\065\073\100\086\075\083\061";"\075\118\080\084";"\081\114\071\043\104\083\082\087\068\048\076\061","\115\067\116\098\075\113\076\073\056\111\114\061";"\112\043\080\076\077\115\097\052\121\080\053\052\113\072\075\116\114\097\061\061";"\120\116\119\108\111\121\122\052\086\100\070\097\084\055\050\098\050\090\077\086\052\120\083\120","\105\057\068\052\076\067\097\115\066\078\108\108\084\089\106\114\072\048\109\109\053\076\061\061","\112\072\068\106\053\110\080\112\080\099\110\085\076\081\080\113\076\085\084\061";"\080\047\071\118\114\047\080\103\082\122\073\110\053\047\080\119\053\047\080\079\082\076\061\061","\057\056\118\069\054\065\057\077\111\110\102\084\121\112\085\100\099\108\051\084\079\068\122\107\078\051\061\061","\121\118\085\103\110\100\108\061","\077\100\116\073\107\121\079\071\078\079\072\065","\102\083\061\061";"\112\072\049\087\082\076\101\120\103\107\118\097","\107\057\100\118\082\083\061\061";"\076\069\114\068\057\076\061\061";"\068\122\117\043\104\069\108\066\112\072\051\103\070\120\110\106","\077\104\113\053","\120\083\110\084\101\054\076\061";"\101\073\116\079","\098\098\110\079\074\105\079\111\084\069\108\081";"\086\066\104\119\052\069\100\061";"\065\097\082\073\054\082\082\061";"\086\109\072\122\121\051\061\061","\078\114\119\065\081\099\114\053","\057\068\076\104\052\113\086\086\065\109\052\106\099\050\097\049\099\120\049\073\069\076\061\061";"\104\120\053\090\104\110\083\049\121\108\110\047\080\071\114\056\070\051\061\061","\119\114\106\053\106\077\118\077\088\097\055\061";"\113\057\076\076\106\121\110\055\049\052\113\119\072\097\061\061";"\078\089\106\089\078\057\121\121\109\076\061\061","\083\080\051\052\073\074\122\061","\108\102\113\048\078\051\085\108\079\116\113\108\109\051\061\061";"\088\080\113\054\101\120\048\088\109\083\061\061";"\050\054\047\084","\090\108\097\103\090\101\080\051\088\047\102\118","\110\106\047\121";"\085\102\089\078\078\118\057\098\084\067\108\061";"\048\115\101\066\065\110\089\108\101\065\087\055\070\083\061\061";"\048\065\078\101\102\100\075\055\088\051\077\090";"\109\122\065\069","\089\072\116\065\106\071\076\070\113\057\083\084\116\076\061\061";"\048\090\122\101";"\104\090\107\113\102\043\099\097\081\083\061\061","\110\070\105\050\049\072\043\065\051\083\061\061";"\099\068\121\077\111\097\061\061","\070\052\114\085","\077\108\071\049\077\119\121\071\053\056\066\089\102\080\110\115\057\056\114\061","\057\069\065\075\080\085\117\113\070\079\071\084\070\066\110\086\081\083\061\061","\067\088\117\104\098\081\076\110\121\121\079\061","\043\066\065\099\057\097\061\061";"\115\047\043\112\080\102\114\111\071\103\102\114\056\051\073\111\077\087\053\050";"\109\056\080\112\104\081\115\087\122\122\090\111","\047\084\121\076";"\084\115\071\049";"\102\102\083\122\111\113\119\066\102\112\088\061","\057\075\081\097\101\051\061\061","\084\071\122\088\069\122\106\108\112\108\121\103\076\080\114\052\073\076\061\061";"\076\069\073\109\053\043\121\108\084\101\075\110\068\069\076\061";"\102\087\119\084\099\066\052\118\121\100\102\108\043\082\073\078","\073\115\110\103\068\076\061\061","\053\056\065\103\112\101\121\097\057\069\121\110";"\118\076\108\103","\082\055\047\049\087\054\087\112\053\083\061\061","\121\109\108\078\115\118\078\049\118\048\099\102";"\107\111\066\085\081\065\086\085\047\054\108\061";"\054\048\047\072\077\050\079\073\081\051\061\061","\119\056\109\070\068\056\109\107\075\100\079\061";"\122\065\109\112";"\073\100\117\052\082\115\056\072\112\099\049\065\057\066\097\061","\066\088\067\053";"\050\049\065\102\115\103\079\088";"\075\082\053\056\043\075\070\061";"\119\118\074\110\105\084\114\100\090\057\051\061";"\105\083\051\077\083\055\089\121\047\048\102\084\048\097\061\061";"\054\043\048\097\071\051\061\061","\105\082\047\100\112\090\099\114\116\120\057\061";"\078\106\086\118\056\051\061\061","\120\077\082\055\080\055\076\061","\118\069\097\086\109\109\090\061","\115\098\050\089","\115\101\083\072\077\073\107\056\083\101\102\104\055\110\119\106\116\055\122\061","\097\086\088\080\113\111\048\122\047\084\108\061";"\055\071\102\065\067\068\109\103","\111\069\089\052\065\078\098\072\066\053\115\070\080\057\116\110";"\103\085\099\081\102\122\052\089";"\077\122\053\043\080\079\052\106\069\115\053\074\121\079\048\103";"\069\106\052\056\104\115\115\043";"\105\080\108\061","\100\121\057\106\114\075\087\116\076\083\061\061","\053\047\071\054\077\047\084\061";"\053\047\065\105\053\069\066\054\068\043\082\061";"\097\083\086\054\049\107\099\116\082\100\107\118\057\104\084\061","\073\115\110\105\068\122\068\106\114\099\121\108\076\056\117\106\077\047\076\061","\105\113\106\054\087\080\090\107\082\057\090\061";"\051\054\106\099\114\079\043\121\055\111\068\082","\085\109\076\052\056\081\115\121\070\116\115\047\052\117\054\048\105\043\055\102\090\066\081\066\103\074\053\055\116\076\061\061","\056\075\076\053\098\097\061\061","\111\103\065\050\056\078\086\081\082\086\051\061";"\114\043\121\056\112\085\121\086\068\085\083\108\112\047\049\080\076\097\061\061";"\088\102\083\054\122\080\097\076\121\077\057\061","\065\122\070\120\101\106\086\076\112\105\120\071\109\108\053\086\115\049\068\107\083\071\080\075\115\117\114\084\121\107\055\102\121\077\082\107\078\106\117\102\108\086\083\122";"\069\066\070\108","\056\083\049\081\079\057\122\109";"\070\074\066\073\115\078\097\061","\078\116\078\083\070\074\105\087\103\055\051\061","\081\098\075\070\081\122\078\119\071\055\085\054\121\090\088\089\043\076\061\061","\102\047\078\071","\116\083\083\051\052\068\049\048","\066\120\098\079\073\053\089\049\118\101\043\054\087\051\071\098";"\102\116\053\117\056\106\066\105\066\077\074\120\074\113\055\061","\050\050\109\115\074\106\066\055\056\083\061\061";"\051\068\103\090\110\076\061\061";"\049\088\056\051\047\053\070\088","\079\071\082\053\097\043\102\071\121\106\114\061","\120\078\083\075\081\069\070\104";"\043\066\065\118\068\043\073\117\053\047\071\054\077\047\084\061";"\077\047\080\105";"\067\076\109\121\051\109\080\077";"\099\106\105\103\116\111\065\117\084\049\076\048","\109\075\090\115\057\102\051\111\089\113\115\101\112\104\112\105";"\085\109\074\119\068\071\118\081\120\051\061\061";"\099\051\088\099\053\065\049\099\087\051\101\056\103\120\108\061";"\103\121\081\071","\068\115\052\111\077\101\082\061";"\074\099\057\057\106\053\108\061","\111\043\097\078\074\109\100\098\113\084\103\097","\047\085\074\074\071\072\067\101\104\097\061\061","\043\066\065\090\068\069\088\061","\114\101\073\103\112\069\049\099","\053\057\070\089\076\097\061\061","\052\111\079\074\069\084\097\061";"\066\049\087\076\066\116\069\051\067\065\108\084","\068\109\052\099\048\109\099\097\057\111\115\073\115\087\067\054\109\102\099\070\053\097\061\061";"\065\081\056\102\053\121\100\061";"\120\066\074\119\083\107\056\090\070\108\113\076\105\057\051\068\120\083\120\083\079\119\118\072\110\113\089\085\068\075\081\100\103\051\061\061","\077\079\052\082\068\047\065\106\084\047\065\080\114\072\048\115";"\106\115\089\100\068\110\084\043\076\121\083\061";"\115\102\051\050\053\110\067\122\069\055\097\061";"\104\112\119\086\080\053\047\107\073\085\105\099\055\097\061\061","\056\083\072\056","\054\120\110\087\088\078\050\055\052\071\113\049";"\053\068\047\097\073\055\051\061";"\070\108\080\117\081\119\080\085\077\069\065\080\057\080\071\048","\119\050\057\079\080\072\088\061","\043\081\083\099\116\088\098\056\106\072\084\085\066\109\119\085\118\051\061\061","\049\067\057\072\050\090\090\061";"\080\053\080\112","\085\089\069\097\071\074\109\066\047\048\083\061";"\115\070\081\055\114\051\061\061","\073\115\110\105\068\071\075\117\114\099\073\107\077\110\048\117\104\076\061\061","\075\083\071\085\081\115\080\119";"\111\086\057\087\085\083\061\061","\071\065\055\105\050\071\054\104\049\076\100\075\086\115\090\061";"\043\066\065\106\077\115\073\110\104\051\061\061";"\073\056\080\108\081\056\048\109\068\069\121\108\114\097\061\061";"\111\084\065\115\055\083\061\061","\098\108\110\112\067\048\054\075","\118\079\066\103\112\101\054\107\098\103\076\061","\052\086\115\048\120\106\111\068";"\103\069\052\114\054\056\052\087\100\053\050\097\075\067\114\061";"\089\122\100\087\090\117\113\055\120\118\100\061","\116\070\085\109\081\120\077\121\069\087\082\061","\053\120\110\097\068\069\065\115";"\100\117\072\103";"\072\056\049\075\057\097\111\113\122\077\082\098\117\090\055\061";"\114\047\121\117\077\047\097\061","\101\089\084\052\085\110\057\081\119\051\061\061";"\052\099\080\104\078\083\061\061","\077\108\049\086\105\083\051\122\043\119\055\061";"\102\047\069\097","\078\068\043\085\075\121\104\122\098\055\090\108\073\083\061\061";"\084\047\065\106\077\099\073\084\077\108\065\054\112\115\080\119\053\071\121\097\057\069\121\110";"\074\090\043\074\119\083\077\079\109\112\082\082\052\118\104\065\090\083\043\067\054\054\100\072\106\083\061\061","\108\054\103\043\117\114\074\117\109\078\080\098\079\053\082\061";"\112\103\051\084","\115\076\051\083","\080\047\104\112\066\076\083\061";"\107\109\113\049","\113\043\121\075";"\048\090\048\122\083\071\079\075\090\109\050\120\075\088\115\048\113\109\066\075","\087\069\103\105\100\088\118\100\049\082\088\061";"\119\083\103\090\116\056\074\112\085\102\108\061";"\077\107\055\100\105\071\104\055\099\104\083\061","\053\053\086\105\057\071\054\053\056\112\102\106\069\053\116\072\098\102\108\087\081\065\049\077\078\105\070\085\105\076\112\056\072\100\114\049\048\055\066\067\115\117\105\065";"\085\048\111\080\079\111\113\115\106\109\080\117";"\102\104\103\072\115\081\113\066\100\076\043\099\109\076\061\061","\073\047\080\085\053\120\048\111\104\076\061\061";"\050\099\050\050\068\065\090\054\067\065\120\068";"\118\052\121\121\090\114\056\083\052\068\079\108\103\076\061\061","\084\071\080\071\081\066\048\052\114\085\117\071\112\081\083\066\077\101\122\061","\119\084\080\122\088\116\118\114\117\117\048\075\071\121\070\061";"\051\078\088\066";"\097\082\104\122\116\097\071\109\054\057\084\061";"\057\056\065\105\057\056\071\108","\076\043\047\074\120\067\067\113\087\110\090\061";"\122\073\105\112","\084\047\052\117\104\076\061\061";"\084\071\106\089\102\122\048\082\113\110\073\122\070\066\117\085\077\097\061\061","\071\112\066\120\100\048\102\081\067\079\109\114\053\072\067\053\055\106\111\103\097\097\061\061";"\076\056\065\105\077\115\080\119\053\051\061\061","\073\069\049\066\077\076\061\061","\081\100\100\105\081\082\071\103\106\089\109\057\120\088\070\080","\065\114\118\076\100\056\073\048\086\119\083\061","\068\101\081\120","\067\069\098\083\075\098\081\074\122\106\119\069\110\098\121\115\079\105\081\076\048\100\118\048\088\078\120\097\079\106\050\103\043\111\105\084\114\084\043\085\070\103\066\052\083\076\061\061","\087\079\057\113\090\048\108\074\057\050\068\073\087\076\061\061","\077\112\103\120\067\075\048\072\100\066\117\065\074\105\110\080\118\122\072\074\069\100\113\089\118\088\043\108\055\101\080\075\083\079\080\043\114\067\112\080\109\083\061\061","\089\055\080\085\108\051\061\061","\122\052\069\113\048\104\078\101\089\084\111\050\074\083\090\061","\053\043\121\116\069\115\073\122\069\119\048\117\114\084\071\071\068\120\051\061","\067\115\103\122\086\047\122\120\049\068\086\067\047\065\052\073\057\118\057\071\087\076\061\061","\073\111\113\097\047\071\072\072\104\104\088\072\119\109\088\090\105\104\115\083\117\088\116\083\052\106\053\071\043\068\076\056\083\055\106\107\056\100\079\116\103\097\061\061","\088\074\043\082\088\121\055\090\071\067\111\120\070\049\057\107\084\051\061\061";"\099\075\108\081\047\121\121\079\099\051\061\061";"\080\056\071\106\053\122\068\111\114\079\121\055\112\069\052\079";"\071\097\089\107\052\116\100\061","\074\112\109\083\080\115\099\098\084\072\106\056\084\108\107\067\085\076\061\061","\105\074\071\101\074\081\069\117\103\048\114\061","\076\108\068\103\057\069\066\110","\099\067\110\087\097\043\087\047\078\057\097\061","\084\051\061\061";"\049\081\080\086\048\065\099\105";"\098\122\057\049\104\119\120\048\079\102\082\061","\076\052\055\061","\054\080\077\050\086\106\050\067\103\051\097\061","\069\072\057\052\077\056\118\073\104\099\053\111\080\101\121\052";"\088\101\109\097","\119\066\119\083\047\119\048\069\097\100\088\061";"\066\056\089\076\118\099\085\049\100\108\108\061";"\068\056\080\108\068\056\080\105\053\083\061\061","\053\049\070\118\053\067\048\087\121\076\105\043\043\083\061\061","\065\090\072\111\047\055\097\061","\089\078\084\114\115\078\082\109\066\101\103\105";"\078\098\102\084\085\051\061\061","\080\076\077\110\077\083\061\061";"\121\072\076\106";"\109\051\085\078\088\051\061\061","\081\047\065\117\068\122\071\105\112\069\066\117\053\047\110\111\077\083\061\061";"\049\051\054\085\072\074\122\089\069\083\061\061","\043\053\057\061";"\085\100\083\067\043\114\105\099\109\072\082\069","\080\085\122\061","\050\048\101\097\087\099\057\119\089\070\082\061";"\073\083\048\099\121\101\087\049","\057\055\066\047","\105\073\052\119","\043\101\098\078\113\050\079\097\090\080\085\098","\077\112\076\107\103\103\079\061","\068\056\121\072\084\081\110\084\077\047\065\084\070\066\121\116";"\068\054\122\108\079\073\051\061";"\110\054\077\082\055\073\109\119";"\080\081\048\120\073\085\084\103\081\079\117\103\102\081\073\066","\065\102\081\067\051\067\113\052\057\088\051\061";"\099\072\086\047\053\074\069\043\085\053\067\105\101\051\061\061";"\049\088\054\074\097\106\074\106";"\116\089\068\049\113\075\112\067\102\111\098\101\082\097\061\061","\112\072\097\121\083\098\047\085\087\115\054\115\121\070\083\061";"\069\052\111\080\109\100\083\116\085\084\086\102\109\112\053\076\087\076\061\061","\108\118\114\067\118\089\084\061";"\090\065\101\073\056\107\068\087\087\083\118\075\100\051\061\061";"\083\119\110\055\079\120\079\075\098\057\084\077","\071\122\053\084\101\112\069\068\075\080\056\098","\057\115\079\088\084\043\121\101\053\080\075\112\102\047\049\118\068\099\114\061";"\122\100\087\054\108\082\056\120\109\082\065\053\099\076\061\061";"\073\069\066\086\070\043\121\084\070\081\110\086\076\080\053\080\070\083\061\061","\071\083\106\111\070\076\061\061","\105\108\116\098";"\048\051\102\103\077\107\075\097\055\068\076\061";"\098\072\084\050\098\072\079\090\080\101\088\061","\119\121\097\083\047\107\107\078";"\056\118\114\065\070\120\072\086","\065\101\056\071\077\079\076\061";"\076\083\121\086\043\113\057\076\079\087\090\117","\102\069\110\110\069\099\071\079\102\084\070\103\069\069\121\049\102\051\061\061","\077\112\090\103";"\107\065\083\120\051\071\074\082\048\097\061\061","\118\050\098\119\111\119\098\121\051\067\075\104\118\108\114\089","\089\107\072\076\097\097\061\061","\082\057\086\074";"\081\115\068\103\084\122\122\088\114\108\097\061";"\082\069\099\117\104\070\098\053\097\097\061\061";"\077\121\076\052\104\084\087\052\078\081\076\061","\090\066\102\097\054\051\061\061","\068\099\083\052\054\089\089\099\117\112\100\078\065\087\109\108\106\066\074\069\111\104\057\105\043\053\082\100\074\115\054\077\078\102\055\112\103\105\054\099\084\067\120\107";"\043\106\104\049\083\108\085\089\070\116\084\097","\101\097\081\084\068\097\108\061","\105\101\101\054\106\097\069\101\052\051\073\089\067\097\061\061";"\103\078\054\076\087\097\083\098\107\117\070\089\112\112\055\119\054\116\072\083\055\119\101\115\113\112\120\053\074\076\061\061";"\050\066\076\113\080\054\090\061","\070\110\080\043\070\047\049\099\080\085\070\088\068\122\080\086\077\119\114\061";"\057\102\104\116\056\076\061\061";"\099\100\098\114\106\083\061\061","\077\122\083\068\076\067\102\049\097\117\051\043";"\081\080\056\076\049\107\106\052\122\103\108\061";"\100\117\119\088\106\099\121\105\086\076\061\061","\070\110\117\075\081\110\051\052\073\115\079\103\080\079\080\084\081\071\083\061","\122\110\086\089\049\076\061\061","\114\078\051\100\076\048\082\061";"\043\056\121\049\105\065\082\061";"\082\048\070\055","\112\115\107\080\074\104\089\110\113\083\107\119\104\076\080\108\081\056\118\080\071\122\084\049\108\049\067\066\071\090\107\079\070\117\107\105\104\080\070\089\043\051\061\061","\121\076\061\061","\066\088\110\049\068\086\090\061","\113\118\119\086\099\076\061\061","\114\106\052\106\122\051\061\061","\080\055\082\113\087\078\083\071\108\119\121\104\071\072\077\107\121\101\084\047\080\097\056\113\109\071\077\115\107\083\049\066\090\110\080\098\043\081\049\056\115\119\085\099\056\083\069\109\076\083\057\102\113\054\084\043\116\107\099\084\081\086\101\098\111\119\055\054\070\101\068\116\119\098\106\076\074\111\070\069\050\107\122\105\105\113\109\051\050\069\066\051\069\106\078\113\103\112\122\052\049\084\083\101\087\116\051\098\099\078\072\114\089\083\110\114\068\099\069\090";"\072\120\068\068";"\066\084\120\079\070\068\080\068\108\108\071\112\066\057\082\061";"\100\098\074\056\119\080\120\070\076\110\051\061";"\071\116\055\089","\065\086\097\061";"\111\074\112\057\070\083\113\048\085\109\088\105\108\097\061\061";"\088\076\068\071\115\052\081\055";"\113\085\084\101\053\122\073\101\080\108\073\068\112\101\106\075";"\069\085\106\113\084\057\112\051\050\105\053\050\102\103\070\061","\112\043\121\115\112\069\052\110","\043\056\085\112";"\090\118\112\122\066\119\068\111\066\052\051\061","\065\069\109\071\052\072\048\077\076\108\082\061","\088\089\055\049\098\117\071\069\067\104\065\043","\084\069\110\119\053\084\049\049\068\119\121\119\068\099\075\066\077\047\100\061","\078\101\087\085\053\081\105\098";"\105\075\068\103\099\051\061\061","\052\065\090\085\102\066\117\080\051\069\070\048\112\078\083\061";"\081\071\106\076\053\119\121\057\084\115\071\076\121\066\106\049","\119\048\106\097\082\066\056\106","\114\115\080\118\077\101\068\110","\082\099\050\051\103\068\090\061","\057\115\049\102\112\066\048\108\113\072\053\080\114\056\073\107\069\051\061\061","\073\122\102\100\049\071\108\119","\081\115\084\108\076\119\071\054\077\071\073\089\077\115\110\116";"\071\072\082\102","\114\043\073\108\112\043\121\047\069\080\048\084\084\081\068\084\104\076\061\061","\078\109\087\082\052\083\061\061";"\088\087\050\098\066\101\083\047\071\066\108\061";"\107\050\102\088\074\107\073\109\118\051\061\061";"\043\087\086\065\103\083\061\061";"\089\102\082\083\067\067\099\083\052\055\055\061";"\082\073\071\076\103\115\082\061","\120\110\071\048","\051\051\086\078","\079\121\050\101\111\088\113\077\076\109\057\061";"\119\085\109\076\109\099\088\089\111\054\055\061","\087\080\048\078\066\053\049\111\119\105\090\120\120\120\074\067\051\048\055\118\111\076\061\061","\048\072\113\070\083\056\117\075\084\085\120\087\084\106\086\078\080\103\067\117\090\084\086\085\066\116\067\081\081\066\079\061","\090\080\097\061","\066\097\043\122\112\097\061\061","\112\051\097\113\090\082\086\076\117\098\074\076\049\099\114\085\117\102\100\110\118\114\084\061","\079\048\065\056\087\084\079\061";"\068\101\121\066\057\083\061\061","\055\084\073\101","\087\097\056\069\086\086\070\072\110\108\047\118";"\070\109\116\113","\121\088\056\084\114\079\090\061";"\084\055\106\087\118\074\069\070\082\072\085\067\116\051\061\061";"\076\108\102\051\109\068\071\111\043\102\114\048\078\104\051\070\118\083\050\048\043\076\061\061";"\108\111\075\053\106\051\061\061","\057\099\110\108\068\076\061\061";"\079\076\086\114\051\107\099\085\115\087\097\061","\114\071\099\051","\097\066\071\081\121\106\076\061";"\056\077\090\100";"\114\056\080\108\068\099\075\085\057\056\071\097";"\055\067\115\108\119\117\090\061","\119\111\107\077\118\099\075\072\107\120\075\071\109\083\061\061";"\076\077\068\106";"\088\088\077\056\098\076\108\047\053\083\061\061";"\081\101\118\120\115\070\116\098","\086\055\072\085\118\082\122\121\114\051\084\061";"\108\086\081\118\115\082\054\084\117\072\087\098";"\116\089\105\070\047\114\079\048\057\114\108\061";"\121\101\120\121\084\085\101\081\118\111\047\099\103\088\089\089";"\070\049\073\087\082\071\084\056\114\115\052\076\090\101\078\051","\114\102\050\111\049\080\116\090\056\097\061\061";"\116\076\061\061";"\052\119\097\052";"\053\047\065\085\053\120\048\106\077\115\114\061";"\119\072\076\066\053\070\119\078\103\101\121\089\120\107\080\099","\078\088\108\108\106\051\061\061","\054\053\055\120";"\084\115\121\080\113\084\068\086\076\069\068\112\080\108\117\116\069\115\079\061";"\118\048\075\055";"\087\086\116\100\104\048\057\061","\112\084\053\081\053\115\097\097\081\069\049\099\070\115\048\085\114\083\061\061","\068\085\068\118\104\047\049\055\077\047\048\122\080\069\114\088","\068\083\083\071";"\110\053\075\048";"\078\054\087\103\067\056\075\056\099\098\050\051\069\085\043\120\119\047\099\067\069\051\061\061";"\112\043\075\117\112\043\048\085";"\043\122\116\087";"\052\087\065\090\120\106\051\100\116\074\057\061","\113\120\073\108\114\122\053\110\053\051\061\061";"\122\109\074\083\105\089\055\080\119\089\105\090\118\108\073\048\119\097\061\061";"\069\043\048\069\113\119\048\097\121\085\075\079\077\079\049\073\073\076\061\061","\106\099\109\065\088\117\098\117\050\053\065\073\098\075\110\102\081\068\113\115";"\075\056\121\066\054\054\051\066\097\051\061\061","\107\116\085\081";"\048\047\079\115\122\084\055\081","\073\056\080\108\073\047\080\085\057\056\080\105\068\047\071\105\053\120\070\061";"\073\056\080\108\113\120\080\118\057\069\049\111\112\069\073\122\068\043\121\119\114\115\110\097\053\047\110\111\077\079\068\103\077\056\066\080\114\056\080\103\113\069\076\061";"\104\065\049\098\118\104\048\084\102\057\100\114\051\109\052\087","\073\079\068\054\076\110\117\089\121\099\068\048\113\120\117\117","\074\090\097\050\069\071\086\070\048\122\043\116\098\085\104\122","\121\120\073\081\084\122\117\111\080\108\110\102\081\071\117\080\112\056\090\061","\086\122\076\089\106\111\055\089\084\068\097\082\080\083\079\061";"\105\089\090\119\112\047\068\089\112\106\104\097\068\097\105\111\085\083\108\075\082\076\088\104\075\097\061\061","\053\072\110\112\113\119\053\085\112\083\061\061","\065\049\078\048\048\068\107\090\118\065\070\061";"\118\114\121\118\089\043\082\102";"\050\113\106\089\110\051\121\117\106\086\122\119\087\097\061\061","\073\069\066\097\104\043\048\110\057\069\088\061","\107\112\057\071\122\102\100\083\053\098\066\110\074\057\121\077\121\065\055\115\057\097\061\061","\115\120\099\066\090\105\084\061";"\117\051\061\061";"\109\110\051\104\116\088\049\116";"\119\072\048\075\100\110\073\057\111\072\122\102\105\074\099\054\055\103\074\073\053\076\061\061","\104\111\065\089\106\067\048\072\048\083\061\061","\122\043\103\069\043\082\076\055\113\071\098\086\102\051\061\061","\080\081\121\099\084\099\110\089\076\066\048\047\070\043\121\101\077\083\061\061","\110\072\087\104\076\051\061\061","\077\069\071\108\112\051\061\061","\105\056\101\089\107\078\054\049","\053\101\048\106\053\047\080\115\112\069\052\110";"\104\050\056\119";"\081\073\086\084\075\084\057\061","\084\101\073\111\114\051\061\061";"\054\076\078\115\101\050\117\112\120\110\120\108\118\083\061\061","\072\113\053\100\055\050\109\079\082\051\061\061","\117\071\122\057\087\052\115\122\067\047\097\061","\073\101\121\073\102\047\049\102\070\079\108\101\068\072\053\072";"\077\072\082\061";"\066\090\080\056\065\111\076\103\052\117\114\061","\048\117\108\080\082\111\105\078\106\111\100\061";"\051\115\054\050\073\047\102\097\069\056\114\061","\110\097\057\049\114\110\077\097\090\049\090\054";"\104\116\109\071\111\067\088\047","\068\056\071\118\068\076\061\061";"\087\107\080\056\067\080\073\068\085\116\107\110\047\120\069\074";"\111\113\087\057\122\074\113\089\047\051\061\061","\069\115\080\113\081\079\057\097\076\110\048\084\073\101\106\049\073\051\061\061","\073\047\110\085\057\056\065\105\077\115\080\119\053\051\061\061","\101\117\071\108\055\068\073\122\109\053\104\086","\113\081\053\054\077\069\049\105\081\099\110\056\104\099\106\116\081\108\122\061";"\065\119\108\082\084\100\048\120\098\076\105\076","\077\116\109\069";"\105\089\081\110","\066\069\069\043\079\103\073\116\056\113\120\090\122\097\061\061","\084\056\080\108\076\056\065\103\068\076\061\061","\122\081\071\116\111\097\061\061","\081\078\106\119\086\104\049\075","\122\080\084\110","\101\050\075\103\083\082\122\061","\098\067\082\097";"\119\105\084\072","\073\047\080\115\057\043\080\090\053\122\068\090\112\069\049\099\081\101\075\108\112\069\065\105\114\097\061\061","\105\116\084\099\111\114\108\061";"\104\089\113\070\048\054\101\055\074\089\108\061";"\099\078\116\047\055\078\097\061","\119\078\083\119","\052\081\057\061";"\088\118\055\054\105\103\052\106\048\114\108\061";"\083\105\073\075\068\114\087\103\043\097\061\061","\111\088\054\103\054\083\111\051\072\049\051\061","\117\078\071\056\116\114\079\088\052\051\061\061","\057\075\083\100\049\053\121\074\084\050\118\106","\070\115\116\077\110\108\055\082\111\120\079\116\070\068\090\061";"\053\115\104\074\119\085\051\061";"\115\100\088\104\101\069\102\084\043\102\048\120\112\071\111\066\098\097\061\061";"\105\116\069\119";"\049\104\075\084\115\066\070\111\105\097\061\061";"\116\100\048\087\068\103\049\043\109\105\088\061","\072\055\070\116\049\119\122\099\112\098\074\101","\112\108\084\066\073\066\068\090\114\120\048\089\070\108\097\108\114\076\061\061","\068\120\066\080\067\116\055\105\072\051\061\061";"\073\103\087\087\055\069\084\115","\113\071\078\097\116\070\054\073\075\057\097\061";"\051\070\114\075\108\083\061\061";"\121\047\057\052\104\110\122\103\112\071\117\071\121\101\110\054\073\097\061\061","\054\114\104\069\075\056\075\078\067\082\083\066\100\049\122\061","\078\076\119\114\103\109\087\050\111\098\112\112\108\043\086\052\072\085\082\106","\068\056\066\117\053\047\121\055";"\073\115\073\109\081\081\121\118\073\120\071\101\121\110\057\101";"\069\074\107\115\050\080\047\098\074\083\061\061","\076\056\052\111\077\115\084\061";"\053\122\082\116\052\118\099\097\122\112\082\048\078\073\114\103\109\053\117\074\073\051\061\061";"\043\052\105\099\081\081\072\115\075\120\122\061","\103\113\103\119\050\051\061\061";"\047\054\116\057\077\090\119\100\068\097\061\061","\070\047\072\102\065\048\043\111\122\065\114\072\049\053\115\104\116\114\117\119\121\051\061\061";"\050\108\069\083\056\107\086\104\069\086\103\115\088\081\089\051\106\108\121\090\065\043\109\077\078\083\120\081\081\073\078\048\057\084\122\074\122\086\081\105\053\075\077\053\103\108\118\051\112\103\069\117\084\121\068\056\114\086\117\089\066\074\073\106\052\107\073\101\055\110\072\050\097\055\114\068\080\113\116\114\087\110\117\098\048\121\119\104\073\070\065\117\067\122\068\101\073\086\116\120\067\105\089\073\116\068\085\105\070\074\080\109\051\090\080\104\071\097\052\089\114\105\100\120";"\087\082\097\115\115\051\122\061","\118\088\108\112\086\076\055\061","\114\043\104\116";"\103\103\117\112\053\043\100\061","\050\050\097\118\105\083\061\061","\104\047\081\105\079\055\079\074\075\069\121\082\074\051\102\086\117\097\100\084","\114\076\122\068\076\067\048\057\114\081\054\113","\088\083\055\068\053\097\061\061","\068\043\048\103\077\101\082\061","\108\085\103\106";"\112\047\065\054\073\119\117\113\070\047\118\069\113\085\071\054\068\066\114\061";"\112\073\122\098\086\055\078\088\081\048\052\054","\073\080\080\121\102\043\121\057\073\085\075\106\121\066\053\101\076\069\114\061";"\055\069\068\057\121\098\078\070\067\070\073\110\101\083\114\061","\083\116\056\122\071\053\115\122\085\109\070\085\097\069\052\099\116\083\061\061";"\054\047\048\076\079\119\055\049\119\085\051\061";"\053\069\049\097\057\069\121\086";"\080\072\075\112\069\069\110\085\113\115\065\078\112\080\121\090\080\083\061\061";"\118\069\106\052\047\076\061\061","\065\086\099\052\076\114\070\061","\112\084\053\078\057\099\068\075\057\080\106\116\077\056\122\085\114\051\061\061";"\054\086\107\056\050\077\105\086","\074\080\108\101\066\097\066\083";"\054\102\114\069","\102\054\083\110\068\078\055\106\102\083\061\061";"\099\065\121\116\051\066\086\050\110\077\103\102\043\072\052\111\057\104\106\106\104\083\061\061","\114\069\057\080\085\053\114\061","\080\108\053\097\057\043\080\086\081\080\048\107\069\043\106\097","\114\115\071\105\068\047\065\118";"\111\116\103\104\068\118\088\104\102\048\078\067\098\112\121\082\079\097\061\061";"\121\090\070\120\111\085\070\121\107\088\066\086\072\069\100\061","\049\089\088\078\072\055\108\118\050\110\113\068\089\076\061\061","\103\078\056\084\081\090\086\086\078\082\052\081\070\083\061\061","\048\086\071\077\120\106\097\061","\065\057\107\049\087\081\057\069\077\070\107\056\065\097\061\061","\066\090\079\066\080\113\087\066\072\047\083\061";"\114\068\077\067","\047\053\070\088","\076\101\048\110\057\043\073\110\113\120\080\118\057\069\049\111\112\069\073\121\077\056\073\110\077\122\068\103\077\056\066\122\068\043\121\119\114\115\110\097\053\047\110\111\077\083\061\061";"\076\101\048\110\057\043\073\110";"\098\088\098\050","\076\101\100\079\073\083\061\061";"\053\115\071\078\057\115\106\106";"\086\111\078\071\082\109\088\118\080\051\061\061";"\077\084\071\086\084\099\070\052\077\101\117\086\113\047\065\052\084\076\061\061";"\102\072\113\053\112\078\108\061";"\072\077\108\116";"\115\117\048\073\109\108\079\099";"\048\053\120\069\052\085\108\107\114\051\061\061";"\051\111\101\114\081\113\120\089\084\078\078\070","\121\072\051\097\073\115\071\085\076\069\073\080\070\110\080\080";"\087\066\078\067\074\078\110\089\043\107\089\106\120\083\061\061","\108\052\050\078\077\072\068\083\056\112\057\061","\069\105\050\105";"\088\089\076\055\071\088\070\099\049\075\051\051","\097\075\112\067\075\069\083\061";"\120\088\106\119\090\053\052\112\075\076\061\061";"\084\111\072\111\099\050\049\120\103\116\051\061";"\052\117\055\070\049\097\061\061","\051\065\084\061";"\081\108\071\105\077\108\084\049\112\120\080\075\084\056\066\076";"\080\108\106\097\070\084\066\082\053\056\117\115\081\079\106\082\068\119\079\061","";"\117\111\069\072\088\069\119\068\073\110\070\061";"\076\056\065\090\077\101\082\085","\043\082\108\079\114\047\078\043\090\083\083\061","\098\098\074\051\098\072\075\099\049\117\057\061","\049\086\083\088\075\082\084\061";"\055\068\065\081\077\076\118\051\110\083\061\061";"\077\072\122\061","\109\068\116\115\084\121\080\083\121\051\061\061","\098\053\106\105\099\104\107\121\053\097\061\061";"\048\048\086\053\050\099\074\082\051\053\090\061";"\088\079\087\112\102\105\090\075\118\051\061\061","\114\050\105\053\108\107\090\080\119\085\118\067";"\118\106\051\102\117\053\072\087\109\074\122\061";"\085\110\066\104\073\054\068\105\079\106\114\061";"\081\115\071\097\048\076\052\115\079\079\084\061","\057\076\068\107\090\099\088\087\073\077\103\049","\104\071\114\103\073\072\053\048\053\101\048\099\114\085\073\085\068\076\061\061","\099\077\101\051"}for q,w in ipairs({{-779647-(-779648);930677-930002},{-812818-(-812819);652316-652114},{-387759-(-387962),710064+-709389}})do while w[1412-1411]<w[533572-533570]do P[w[-548822-(-548823)]],P[w[420696-420694]],w[65635+-65634],w[-151069-(-151071)]=P[w[-134626+134628]],P[w[-331319+331320]],w[308923-308922]+(-632402+632403),w[780162+-780160]-(-40194+40195)end end local function q(q)return P[q-(-280356+327366)]end do local q=string.char local w=P local x=table.insert local W=math.floor local J=table.concat local R={["\050"]=-272459+272522;e=127728-127673;k=583371-583356;g=372718-372668;S=-124578-(-124610);["\053"]=-393636+393665;W=150199+-150168;V=559238+-559195;p=-109107-(-109133),c=-215435-(-215474);t=-509971+509982;L=-642735-(-642751),X=125835-125779,Z=235330-235286;w=982369+-982334;y=-849172+849185;["\051"]=116422-116422,N=1040593-1040591;l=-122862-(-122914),["\057"]=-764168-(-764192);F=771122+-771110;I=-120033+120050,C=-9811+9870;n=-932746-(-932783);E=259426+-259404;q=247837+-247819;["\049"]=986629-986572,h=-330665+330695,D=-410802-(-410827),T=-120231-(-120251);j=-700006+700047;K=-718889+718890;m=629326+-629284,d=-264678-(-264738),["\048"]=840756-840747,P=-149069-(-149090);R=-36380-(-36388),Y=638258-638248,u=-802119+802152;["\054"]=144353-144319;["\056"]=867554-867500;i=552965+-552919;s=-41643-(-41681),["\055"]=-106470+106510,A=157655-157594,v=-61482+61527;["\043"]=-1047043+1047066;U=-43485-(-43536);M=-671725+671752,r=364349+-364321,J=-970567-(-970625),["\047"]=799336+-799330,b=705369-705307;G=-96074-(-96079),x=541891+-541884;H=-509927+509930,a=-593486+593534;O=992485-992449;z=-758241-(-758245);["\052"]=902881+-902832,f=1035342-1035328;Q=-54368-(-54387),o=-527691+527738;B=-495223+495276}local D=string.len local F=type local f=string.sub for P=-338449+338450,#w,-635349+635350 do local a=w[P]if F(a)=="\115\116\114\105\110\103"then local F=D(a)local H={}local o=326952-326951 local l=-491012-(-491012)local O=-515826+515826 while o<=F do local P=f(a,o,o)local w=R[P]if w then l=l+w*(-568737-(-568801))^((928524+-928521)-O)O=O+(-672782-(-672783))if O==-339399-(-339403)then O=-258990+258990 local P=W(l/(-399472-(-465008)))local w=W((l%(33098-(-32438)))/(-132579-(-132835)))local J=l%(-805158-(-805414))x(H,q(P,w,J))l=341326+-341326 end elseif P=="\061"then x(H,q(W(l/(612011+-546475))))if o>=F or f(a,o+(649746+-649745),o+(739502-739501))~="\061"then x(H,q(W((l%(-546431-(-611967)))/(592598+-592342))))end break end o=o+(-238937+238938)end w[P]=J(H)end end end return(function(P,x,W,J,R,D,F,O,Z,h,u,N,b,z,l,o,d,w,Y,r,e,H,a,f)l,f,u,o,w,Z,r,N,d,H,b,O,z,h,e,Y,a=function(P)for q=-551277-(-551278),#P,-554227-(-554228)do a[P[q]]=(951169+-951168)+a[P[q]]end if W then local w=W(true)local x=R(w)x[q(429449-381979)],x[q(719647-672281)],x[q(10028+37416)]=P,O,function()return 1362195-844044 end return w else return J({},{[q(-662463+709829)]=O;[q(1023254+-975784)]=P,[q(226611+-179167)]=function()return-353473+871624 end})end end,{},function(P,q)local x=l(q)local W=function(W,J)return w(P,{W,J},q,x)end return W end,17909-17909,function(w,W,J,R)local I,K,M,t,i,Q,p,c,m,a_,Z_,V,X,D_,T,r_,d_,A_,b_,f_,S_,N_,P_,j,k_,k,g,n,y,a,U,L,h_,u_,F_,O_,W_,J_,R_,x_,V_,F,Y_,C,m_,l_,X_,B,A,h,z_,o,s,G,w_,t_,Q_,S,E,o_,e_,i_,U_,H_,v,l,q_,O while w do if w<8497255-(-425447)then if w<4412869-(-405004)then if w<2948352-(-97411)then if w<-599291+1822443 then if w<579546-209650 then if w<578537+-395884 then if w<489810+-357924 then if w<-982456+1068348 then if w<-60841-(-83137)then w=f[J[402894-402893]]A=6722038850319-579285 o=f[J[-409486-(-409488)]]Q=q(833437+-786339)h=q(908172+-861133)l=f[J[-384285+384288]]i=4208618071240-(-680671)O=l(h,i)U=q(77455-29798)F=o[O]t=11703591960248-125295 O=q(-325843-(-373378))l=P[O]X=q(975920-928708)h=f[J[-125452-(-125454)]]i=f[J[-539916+539919]]V=i(U,t)O=h[V]o=l[O]V=f[J[355150-355148]]U=f[J[-1008675-(-1008678)]]k=12687721580899-717391 t=U(Q,A)i=V[t]h=a[i]U=q(749970+-702713)V=P[U]t=f[J[-45747-(-45749)]]Q=f[J[-780126+780129]]A=Q(X,k)U=t[A]i=V[U]Q=91689-91689 t=195933-195918 U=591426+-591426 V=i(U,t,Q)O=h+V l=o(O)w[F]=l w=3232234-95999 else o=W[681373-681371]l=f[J[470868+-470867]]a=W[-285886-(-285887)]F=l[a]w=not F w=w and-185288+14338684 or-389809+8564103 end else if w<-382509-(-472414)then B=q(343799-296353)V=f[J[826885-826881]]t=f[J[485290-485285]]A=f[J[542698-542692]]k=f[J[1016130-1016123]]S=f[J[203691-203683]]G=1030389+4956310720526 m=S(B,G)X=k[m]Q=A[X]A=628051+-628050 U=V(t,Q,A)w=12057099-213389 else t=q(666463-619426)k=17141805580612-(-892394)i=f[J[-444152+444153]]Q=32309133022589-(-976200)V=f[J[433759-433757]]U=V(t,Q)h=i[U]w=962248+5950706 U=q(-297249+344766)O=a[h]X=q(59754+-12157)V=P[U]t=f[J[420199-420198]]Q=f[J[154893+-154891]]A=Q(X,k)U=t[A]i=V[U]A=q(-200536+248217)X=29065573541668-1045062 U=f[J[336581+-336580]]t=f[J[563721-563719]]Q=t(A,X)V=U[Q]h=i[V]l=O==h F=l end end else if w<931152+-769734 then if w<-440832+596218 then f[o]=F w=-486339+13112376 else w=h w=O and-897611+5674078 or 16637882-(-63888)end else k=nil Q=z(Q)O=z(O)X=nil S=nil X=H()O=H()V=z(V)t=z(t)Q=H()t=q(-30848-(-78293))A=nil k={}m=z(m)l=z(l)o=z(o)o=nil V=q(-354324+401386)h=z(h)U=nil f[O]=o l=nil o=H()U=q(-812192-(-859598))f[o]=l i=nil i=q(452465-405403)h=P[i]i=q(458888-411448)l=h[i]h=H()f[h]=l i=P[V]V=q(-679268-(-726428))l=i[V]V=P[U]m=-808483+808739 S=780998+-780997 U=q(595817+-548174)i=V[U]U=P[t]t=q(-608141+655364)V=U[t]t=H()U=-77753-(-77753)n=m f[t]=U U=-603259-(-603261)m=700511-700510 f[Q]=U A={}f[X]=A U={}I=m m=249127+-249127 A=478591+-478591 y=I<m m=S-I w=379886+8177551 end end else if w<682110-446101 then if w<-393079-(-591201)then if w<-792540+983186 then n=q(834683-787174)o=false I=-103499+25645513573105 f[J[441345-441344]]=o Q=w S=f[J[987467+-987459]]B=f[J[-693494-(-693500)]]G=f[J[1040703+-1040696]]K=G(n,I)n=7072245370656-(-1047997)m=B[K]K=q(666317+-619053)k=S[m]m=f[J[-411335-(-411341)]]B=f[J[896179+-896172]]G=B(K,n)S=m[G]X=k[S]k=-1036949-(-1036950)A=X<k t=A w=A and 457525+10906515 or 10743576-727720 else l=408076-408075 o=f[J[-916665-(-916668)]]a=o~=l w=a and 8608669-(-668605)or 14354167-554424 end else w=true f[J[418874+-418873]]=w w=P[q(-362228-(-409742))]F={}end else if w<-244295-(-568363)then if w<644843+-371866 then V=not i l=l+h o=l<=O o=V and o V=l>=O V=i and V o=V or o V=9679240-14366 w=o and V o=12586734-300017 w=w or o else w=t w=U and 951001+590467 or 531736+3541668 end else P_=f[o]F=P_ w=P_ and 1039233+9425500 or 372679+-228182 end end end else if w<826506+-221517 then if w<854396-317950 then if w<-520304+913466 then if w<482691+-104535 then i=true f[J[665697-665685]]=i U=false V=false f[J[241655-241642]]=V f[J[-92759-(-92773)]]=U Q=f[J[442645+-442630]]t=not Q w=t and 2320409-(-62125)or 7634471-(-47353)else w=500385+16045360 A=f[J[873776+-873763]]X=false Q=A==X U=Q end else if w<-509757+944585 then O=true f[J[-602730+602740]]=O h=false f[J[-85855-(-85866)]]=h i=false f[J[608046+-608034]]=i U=f[J[-917897-(-917910)]]V=not U w=V and 268140+-181523 or 16802655-255787 else k=q(-827230+874650)i=q(-514361-(-561574))F=P[i]S=1001014186946-496112 Q=f[J[-854491-(-854493)]]A=f[J[-830663+830666]]X=A(k,S)i=Q[X]w=F[i]i=b(16149964-(-128292),{U;J[-999629-(-999636)];J[880367-880365],J[-597042-(-597045)],t;J[813035-813034],J[859186+-859178];J[-10393-(-10402)],J[-186254-(-186264)]})F=w(i)A=f[J[-454745+454750]]Q=#A i=h==Q w=i and-996724+6195092 or-161220+10045533 F=i end end else if w<293286+306764 then if w<205352+368151 then U=4797657164761-254751 O=f[J[928622-928621]]A=16856005165772-468003 h=f[J[191331+-191329]]V=q(-538020+585195)i=h(V,U)l=O[i]F=a[l]i=q(-411272+458789)h=P[i]V=f[J[47418+-47417]]U=f[J[3265+-3263]]Q=q(-448532+496124)t=U(Q,A)i=V[t]O=h[i]t=q(-686009-(-733627))Q=7184666640404-(-429309)i=f[J[-903036-(-903037)]]V=f[J[1004549+-1004547]]U=V(t,Q)h=i[U]l=O[h]w=F==l w=w and-990570+6362766 or 4805019-269856 else G=false S=w B=f[J[711287-711272]]m=B==G k=m w=m and 14659+5930793 or 10087948-420993 end else w=8483505-(-474194)U=z(U)t=z(t)h=nil V=nil end end else if w<-20189+999922 then if w<-59545-(-999604)then if w<-294964-(-926718)then F=q(-477434+524723)w=P[F]V=f[J[220825+-220824]]i=V[a]V={w(i)}F=V[-136126-(-136127)]h=V[-876023+876026]w=-217705+12973493 O=V[-933090+933092]i=F else a=f[J[666832-666829]]l=f[J[758170+-758166]]h=f[J[38635+-38630]]V=f[J[703319-703313]]A=2832412890404-(-143362)U=f[J[565700-565693]]k=q(415415+-368341)Q=q(-393965+441253)t=U(Q,A)U=12477826460385-(-650193)i=V[t]O=h[i]h=427319+-427319 i=665247-665246 o=a(l,O,h,i)O=f[J[280745-280739]]V=q(-445689+492832)h=f[J[-941489+941496]]i=h(V,U)l=O[i]a=o[l]l=q(2743+44493)l=a[l]O=w l=l(a)a=false f[J[-169213+169214]]=a U=f[J[-617885+617893]]Q=f[J[643803+-643797]]S=6568080079649-(-643281)A=f[J[-268188+268195]]X=A(k,S)t=Q[X]k=10008792973844-12256 V=U[t]t=f[J[361303+-361297]]Q=f[J[813360-813353]]X=q(444240+-397229)A=Q(X,k)U=t[A]i=V[U]V=894582+-894581 h=i<V w=h and 277914+9240487 or 81251+3145475 l=h end else a=nil l=nil w=P[q(527452-479803)]O=nil F={}o=nil h=nil end else if w<-334316+1533726 then if w<668833-(-370790)then F=-507539-(-507540)o=f[J[385884+-385879]]a=#o o=a a=373617-373616 l=a w=-66632+4421302 a=156235+-156235 O=l<a a=F-l else t=5244030006762-(-643999)U=q(106+46971)l=f[J[44880+-44879]]h=f[J[959635-959633]]i=f[J[637011+-637008]]V=i(U,t)O=h[V]o=l[O]a=not o F=a w=a and 13891123-(-503586)or 668716+11332652 end else w=f[J[893553-893552]]w=w and 633063+12560307 or 608601+11201259 end end end end else if w<-156953+2041742 then if w<1226282-(-314025)then if w<2186433-811216 then if w<-8191+1313681 then if w<-758928+2037967 then w=true f[J[-7696+7705]]=w w=6045924-627512 else F=f[J[587554-587553]]w=F[a]U=648692+11937412788162 V=q(-253376-(-300526))O=f[J[568787-568785]]h=f[J[905235+-905232]]i=h(V,U)l=O[i]F=o[l]l=f[J[77670-77669]]O=q(-775680-(-823234))O=l[O]O=O(l,a,o)w[F]=O w=10598236-(-1007379)end else if w<-639312+1959832 then w=f[J[823151+-823150]]F=w()F={}w=P[q(-675879+723173)]else w=m and 5413714-(-605977)or 9229358-(-1016937)end end else if w<-339264+1811883 then if w<1023043+353200 then G=-216318+26987599150613 A=f[J[401566-401558]]k=f[J[-909737+909743]]S=f[J[575372+-575365]]B=q(91956+-44852)V=w m=S(B,G)B=-925410+11477553361858 X=k[m]Q=A[X]X=f[J[-278222-(-278228)]]k=f[J[518807-518800]]m=q(465092+-417514)S=k(m,B)A=X[S]t=Q[A]Q=-408697+408698 U=t>Q i=U w=U and 3086376-8596 or 7787702-(-688885)else n=-84774+27198441077919 k=f[J[881066-881065]]B=q(968650+-921523)S=f[J[-363368-(-363370)]]G=-669100+28522111543693 m=S(B,G)w=15411094-(-1014938)S=q(42431-(-5086))X=k[m]A=h[X]K=q(307006+-259869)k=P[S]m=f[J[1011850-1011849]]B=f[J[-536668-(-536670)]]G=B(K,n)S=m[G]X=k[S]Q=A~=X U=Q end else h,U=i(O,h)w=h and 3291221-(-862188)or 5734012-(-720824)end end else if w<-625872+2248547 then if w<-294714+1866748 then if w<1383581-(-162537)then A=f[J[-96432-(-96448)]]X=false t=w Q=A==X U=Q w=Q and 1274069-882170 or 17355128-809383 else w=false f[J[978161-978158]]=w w=7963492-182031 end else B=q(665190+-617875)A=f[J[508370+-508366]]k=f[J[407099+-407097]]w=8692117-(-890300)G=10736591144380-(-658891)S=f[J[-2150+2153]]m=S(B,G)X=k[m]Q=A[X]A=-100009-(-100009)i=Q>A F=i end else if w<952247+792732 then if w<995583-(-712861)then Q_=q(-478752+525806)e_=w V_=f[o]X_=33977044570613-(-994264)i_=f[O]U_=i_(Q_,X_)N_=V_[U_]Z_=q(737725-690230)Z_=O_[Z_]Z_=Z_(O_,N_)w=Z_ and-933413+10859202 or 143861+6318432 Y_=Z_ else w=true f[J[-777065+777066]]=w o=true V=-48667+18316395323244 F=f[J[550304+-550302]]a=F(o)F=f[J[869671-869668]]U=7307372214586-519152 a=q(-682500-(-729625))h=q(-621409+668843)a=F[a]a=a(F)o=f[J[-42306-(-42310)]]l=f[J[-389499+389504]]B=878098+30455592898899 i=20192299820390-622764 O=l(h,i)F=o[O]i=q(225139-177816)l=q(998360-950983)o=P[l]a[F]=o l=f[J[-785629-(-785633)]]O=f[J[782553-782548]]h=O(i,V)F=q(-773771+821302)F=a[F]o=l[h]F=F(a,o)o=F O=f[J[748673-748669]]h=f[J[-1003197-(-1003202)]]V=q(248871+-201378)i=h(V,U)X=q(-13619+60852)l=O[i]k=8603271790248-(-495870)F=q(-1042796+1090327)F=a[F]F=F(a,l)l=F O=f[J[947429-947425]]h=f[J[-302332-(-302337)]]V=q(-653442-(-701002))K=q(1069471-1022042)U=5573780384612-(-319167)i=h(V,U)F=O[i]m=q(-996351+1043518)U=q(654488-606953)V=P[U]t=f[J[422519+-422515]]Q=f[J[-82799+82804]]n=24118527000352-611137 A=Q(X,k)U=t[A]i=V[U]Q=f[J[-53522+53528]]X=f[J[-47362+47366]]k=f[J[-86124+86129]]S=k(m,B)A=X[S]t=Q[A]k=f[J[-827568-(-827574)]]m=f[J[-302479-(-302483)]]B=f[J[1045782+-1045777]]G=B(K,n)S=m[G]X=k[S]K=31912095800485-680601 S=f[J[-280706+280710]]m=f[J[-179753+179758]]G=q(955589+-908423)B=m(G,K)k=S[B]A=X[k]B=530508+21123899985440 X=-634907+634909.5 Q=A*X m=q(664650+-617234)U=t+Q Q=f[J[1031477+-1031471]]X=f[J[708943+-708939]]k=f[J[627744+-627739]]S=k(m,B)A=X[S]m=q(234523+-187368)t=Q[A]V=i(U,t)t=q(-972002-(-1019537))U=P[t]Q=f[J[-941611+941615]]S=1015703+20623638930924 k=q(905960+-858504)A=f[J[-978441-(-978446)]]X=A(k,S)k=-401159+16674070166875 t=Q[X]i=U[t]A=753338+-753340.25 X=q(-862344-(-909747))Q=650967+-650967 t=-842257-(-842257)U=i(t,Q,A)h=V*U U=q(980400+-932865)V=P[U]t=f[J[-695178-(-695182)]]Q=f[J[598213+-598208]]A=Q(X,k)U=t[A]A=q(-221998-(-269060))i=V[U]Q=P[A]X=f[J[-641488-(-641492)]]B=32053+30479450841 k=f[J[89417+-89412]]U=961762+-961762 S=k(m,B)A=X[S]t=Q[A]A=-519954+520134 Q=t(A)t=377400+-377400 V=i(U,Q,t)O=h*V o[F]=O F=f[J[-963885+963892]]h=f[J[60302+-60298]]t=29066167043446-118936 i=f[J[-188911+188916]]U=q(755049-707714)V=i(U,t)O=h[V]U=q(-56136+103577)h=l t=33510250319077-(-323599)F[O]=h F=f[J[-629846+629853]]h=f[J[-860620-(-860624)]]i=f[J[4168-4163]]V=i(U,t)X=5882770486739-(-234720)O=h[V]h=f[J[-181601+181609]]A=q(-754760+802355)B=q(923756+-876217)k=28854762695549-456449 F[O]=h t=1128356680962-955125 U=q(565347-517807)F=f[J[-473711+473718]]h=f[J[-360328+360332]]i=f[J[-308648-(-308653)]]V=i(U,t)O=h[V]V=q(-851427-(-898962))i=P[V]U=f[J[-112838-(-112842)]]t=f[J[250654-250649]]Q=t(A,X)V=U[Q]U=155546-155546 t=250548+-250548 h=i[V]V=806838+-806838 i=h(V,U,t)F[O]=i X=q(-93577-(-140989))F=f[J[30367+-30358]]h=f[J[1000840+-1000830]]V=f[J[315302+-315291]]t=f[J[341036-341032]]Q=f[J[61626-61621]]A=Q(X,k)X=q(-915894-(-963498))U=t[A]i=V[U]k=1047925+7176378879896 V=-347871+347872 O=F(h,i,V)F=f[J[100716+-100707]]V=f[J[-566316+566327]]t=f[J[-987952+987956]]Q=f[J[-32658-(-32663)]]A=Q(X,k)U=t[A]i=V[U]V=-775205+775206 k=q(-359044-(-406564))Q=q(539254+-492004)A=1386769919204-(-71073)h=F(a,i,V)V=f[J[-1159+1163]]U=f[J[-11885-(-11890)]]t=U(Q,A)i=V[t]F=O[i]A=65312+27098111717930 i=q(787392+-740156)i=F[i]i=i(F)Q=q(133423+-86330)F=f[J[-889054-(-889061)]]V=f[J[-756824+756828]]U=f[J[-227466-(-227471)]]t=U(Q,A)i=V[t]S=-908559+20172021924288 Q=q(437742+-390087)V=f[J[-634498-(-634504)]]F[i]=V A=1136338484135-637334 F=f[J[-48534+48541]]V=f[J[964113+-964109]]U=f[J[-201493-(-201498)]]t=U(Q,A)i=V[t]V=f[J[219615+-219607]]F[i]=V F=f[J[310550-310543]]Q=q(-128905-(-176096))V=f[J[282855+-282851]]U=f[J[823294-823289]]A=626109+25262418485302 t=U(Q,A)i=V[t]t=q(607509-559974)U=P[t]Q=f[J[608069-608065]]A=f[J[-299045+299050]]X=A(k,S)t=Q[X]V=U[t]Q=-509839+509824 A=-454461+454461 t=660249+-660249 U=V(t,Q,A)F[i]=U F=q(822838-775335)F=a[F]F=F(a)U=false F=false f[J[221864+-221863]]=F i=f[J[309207-309205]]V=i(U)V=w A=f[J[-281625+281631]]k=f[J[-908823+908827]]G=29374680164577-815987 S=f[J[-406651+406656]]m=S(B,G)X=k[m]B=736803+18613317804984 Q=A[X]X=f[J[526378-526374]]k=f[J[-633042+633047]]m=q(72934-25385)S=k(m,B)A=X[S]t=Q[A]Q=-235799+235800 U=t<Q i=U w=U and 4093767-361260 or-1017448+4748047 end else h=q(-745662+793271)i=985750+31695955341073 F=f[J[-890814+890815]]o=f[J[-150839+150841]]l=f[J[-251770+251773]]O=l(h,i)a=o[O]w=F[a]F=q(-690204-(-737720))a=Z(5509136-407133,{J[262492+-262491];J[-8352+8354],J[1043218-1043215]})V=q(498416+-450840)F=w[F]F=F(w,a)o=q(555149+-508071)a=H()w=nil f[a]=w F=P[o]U=548070+15295372197612 O=f[J[122497-122495]]h=f[J[-330309+330312]]o=q(97729+-50488)i=h(V,U)l=O[i]o=F[o]i=q(1035366+-987862)o=o(F,l)l=f[J[-840633+840635]]V=32915375725150-171647 O=f[J[913096+-913093]]h=O(i,V)F=l[h]w=o[F]F=q(-167659-(-215175))o=u(15383417-882120,{J[50728-50727];J[-786832+786834];J[134306+-134303];J[162870-162866],a})F=w[F]F=F(w,o)f[a]=F F={}w=P[q(-950693-(-997736))]a=z(a)end end end else if w<2447757-(-72108)then if w<2672099-388414 then if w<-486237+2686327 then if w<203796+1757826 then F=q(-240031-(-287440))w=f[J[493640-493639]]o=f[J[100020-100018]]l=f[J[32213+-32210]]i=-913616+7232783400440 h=q(515939+-468557)O=l(h,i)F=w[F]a=o[O]F=F(w,a)w=q(-224231-(-271734))w=F[w]h=q(133614+-86340)i=15468443028943-(-675412)w=w(F)w=f[J[-266591-(-266595)]]o=f[J[-71542+71544]]l=f[J[755344+-755341]]O=l(h,i)a=o[O]F=q(-74482-(-121891))F=w[F]F=F(w,a)w=q(144873+-97370)w=F[w]w=w(F)F={}w=P[q(485983+-438457)]else B=q(142624-95417)X=q(-987179+1034658)t=w A=P[X]X=A(h)k=f[J[-1012818-(-1012819)]]G=-656678+29901998488458 S=f[J[-801762-(-801764)]]m=S(B,G)A=k[m]Q=X~=A w=Q and 16305226-(-120806)or 718475+750309 U=Q end else B=false m=f[J[-702675+702688]]S=m==B X=S w=13491189-260314 end else if w<742183+1742544 then if w<-970477+3370018 then t=f[J[-150722+150731]]A=f[J[139744+-139734]]K=q(339567+-291960)n=-931902+781907212714 k=f[J[-893892+893903]]m=f[J[-881119+881123]]B=f[J[312412-312407]]G=B(K,n)S=m[G]w=-1007407+13008315 X=k[S]k=941284-941283 Q=t(A,X,k)else w=-270134+15508368 f[J[-637790-(-637795)]]=F a=nil end else F={}w=P[q(816870-769527)]end end else if w<2712621-(-21177)then if w<3452171-867622 then if w<-382045+2926791 then Q=q(-286192+333569)v=621293+28535270914298 t=P[Q]j=q(1062992-1015971)k=q(-395856+443226)K=28258280498228-(-823090)M=q(-838511-(-885804))I=28238341823246-321457 G=q(146081+-98723)X=P[k]S=f[J[-919533+919540]]m=f[J[-866233-(-866241)]]B=m(G,K)n=q(-243638+291248)k=S[B]A=X[k]S=f[J[-987945-(-987954)]]E=q(-207009-(-254553))B=f[J[-600420+600427]]p=-774904+33214593863522 G=f[J[-657643-(-657651)]]K=G(n,I)m=B[K]k=S[m]K=q(11951+35584)G=P[K]n=f[J[355381-355374]]I=f[J[-722404-(-722412)]]w=3770025-990445 y=I(j,v)K=n[y]B=G[K]n=f[J[-32299+32308]]P_=233893+27461853388878 y=f[J[437163+-437156]]j=f[J[-303262-(-303270)]]v=j(E,p)I=y[v]K=n[I]y=f[J[-559103-(-559112)]]v=f[J[-377439+377446]]E=f[J[-215179-(-215187)]]s=239546+5492643095107 p=E(M,P_)j=v[p]v=q(-702638+749895)I=y[j]j=P[v]E=f[J[833082-833075]]p=f[J[674460+-674452]]P_=q(-826805-(-874357))M=p(P_,s)v=E[M]Q=q(512772-465306)y=j[v]v=690317-690317 E=-128108-(-128107)p=-119968+119968 j=y(v,E,p)n=I+j G=B(K,n)K=f[J[17852+-17845]]n=f[J[514590+-514582]]y=q(462641+-415573)j=29555890606956-990633 I=n(y,j)B=K[I]m=G[B]B=26876+-26872 Q=t[Q]S=m*B X=A(k,S)A=f[J[-891176-(-891181)]]Q=Q(t,X,A)V=Q else O=381792-381791 o=f[J[-600946+600947]]h=-531245-(-531247)l=o(O,h)o=-736517+736518 a=l==o w=a and-736691+11958462 or 647605+7868659 F=a end else h=f[J[201976-201975]]O=h[a]A=-582867+13144740543675 V=f[J[877074+-877072]]Q=q(573747-526727)U=f[J[899383-899380]]t=U(Q,A)i=V[t]h=o[i]w=O[h]Q=q(911766+-864309)V=f[J[-575866-(-575868)]]U=f[J[244366+-244363]]A=-411953+31821896418067 O=w t=U(Q,A)i=V[t]h=O[i]w=not h w=w and 9778514-978412 or 11360172-138123 end else if w<981319+1859929 then if w<109223+2668452 then U=not h F=U V=w w=U and-958747+10096744 or 1517974-(-443831)else w=U w=V and 13687547-938846 or 4640410-(-743136)end else t=q(-573136-(-620167))S=q(873086-825438)h=q(300763-253393)F=q(661168-613791)w=P[F]m=-322537+10110939004493 O=P[h]A=q(771201+-723898)Q=2253295514942-782629 n=1025774+26388964690194 i=f[J[-353150-(-353152)]]V=f[J[563715+-563712]]G=30530419194825-590913 B=q(-666520+713891)U=V(t,Q)X=-258457+6906948238889 h=i[U]l=O[h]i=f[J[945115-945111]]U=f[J[235757+-235755]]t=f[J[311630+-311627]]I=-20353+15402277055365 Q=t(A,X)V=U[Q]Q=q(967333-919798)h=i[V]t=P[Q]A=f[J[681543+-681541]]X=f[J[423383+-423380]]k=X(S,m)Q=A[k]U=t[Q]A=f[J[1034788+-1034784]]k=f[J[739974+-739972]]S=f[J[863065-863062]]K=q(-814122+861397)m=S(B,G)X=k[m]Q=A[X]k=f[J[589467-589463]]m=f[J[-91794-(-91796)]]B=f[J[88334+-88331]]G=B(K,n)S=m[G]m=q(-219313+266570)X=k[S]S=P[m]B=f[J[953581+-953579]]G=f[J[-617595-(-617598)]]n=q(611816+-564751)K=G(n,I)m=B[K]k=S[m]m=719096-719096 B=29187-29188 G=337290+-337290 S=k(m,B,G)k=q(231543+-184198)A=X+S t=U(Q,A)Q=f[J[-220329-(-220331)]]S=20049730957908-757212 A=f[J[-175076-(-175079)]]X=A(k,S)U=Q[X]V=t[U]U=259818-259814 A=-801670+5471915459962 i=V*U O=l(h,i)l=f[J[486596-486588]]h=q(-34955+82421)h=w[h]t=q(-252733+299808)h={h(w,O,l)}F=h[-960175-(-960176)]o=h[951664-951662]l=F O=f[J[302146+-302142]]i=f[J[-808755+808757]]Q=8479101240848-(-870748)V=f[J[-592501+592504]]U=V(t,Q)h=i[U]F=O[h]h=f[J[338348-338346]]t=559308+12727998221914 U=q(86212+-38884)i=f[J[779707-779704]]V=i(U,t)O=h[V]w=F[O]O=w Q=q(123159+-75882)h=f[J[296429-296425]]V=f[J[994645+-994643]]U=f[J[-391978-(-391981)]]t=U(Q,A)i=V[t]Q=-505234+8847864890794 t=q(-113266-(-160282))F=h[i]i=f[J[94613+-94611]]V=f[J[-529476-(-529479)]]U=V(t,Q)h=i[U]w=F[h]h=w V=-846595-(-846596)i=O<V F=i w=i and 9088343-841833 or 6338127-(-70566)end end end end end else if w<3123183-(-989579)then if w<2698056-(-700004)then if w<572065+2729309 then if w<3886107-674244 then if w<402170+2716742 then if w<-118125+3193845 then w=f[J[506995+-506991]]F=w()w=13373413-783093 else t=q(614971+-567594)v=q(-602905-(-650270))w=-501159+8977746 X=q(-242798-(-290168))U=P[t]M=28989069963649-261318 A=P[X]n=491603+1237950136813 K=q(1019768+-972651)k=f[J[-895419-(-895425)]]G=-64011+14245470901236 B=q(-662619-(-710003))S=f[J[-759893-(-759900)]]m=S(B,G)X=k[m]Q=A[X]k=f[J[751258-751250]]m=f[J[-607664-(-607670)]]E=11827157282774-(-173485)B=f[J[447654+-447647]]G=B(K,n)S=m[G]y=q(-594850-(-642532))X=k[S]j=696116+24633007754650 G=q(-859940-(-907475))B=P[G]K=f[J[-840828+840834]]n=f[J[-415462+415469]]I=n(y,j)G=K[I]m=B[G]K=f[J[167644+-167636]]I=f[J[-137898+137904]]y=f[J[-749187-(-749194)]]j=y(v,E)p=q(-494063+541300)n=I[j]G=K[n]I=f[J[-941108+941116]]j=f[J[-412813-(-412819)]]v=f[J[351495+-351488]]E=v(p,M)y=j[E]n=I[y]j=q(670599+-623342)t=q(287810-240344)y=P[j]v=f[J[503855-503849]]E=f[J[510383+-510376]]P_=9911463495427-(-576260)M=q(410767+-363089)p=E(M,P_)j=v[p]v=-168073+168072 I=y[j]j=-847018+847018 E=-769464-(-769464)y=I(j,v,E)K=n+y B=m(G,K)t=U[t]G=f[J[103511+-103505]]K=f[J[-964960-(-964967)]]I=q(-128493+175544)y=14982624759710-(-35746)n=K(I,y)m=G[n]S=B[m]m=586135+-586131 k=S*m A=Q(X,k)Q=f[J[521537+-521533]]t=t(U,A,Q)i=t end else if w<3228570-48237 then w=13352170-(-268364)a=nil else w=f[J[-967116-(-967117)]]w=w and 870625+1648937 or 752005+3948225 end end else if w<3810744-558062 then if w<3320119-95081 then w=F and 4078160-(-109315)or 3577778-801836 else w=O w=l and 10620669-(-672980)or 1356879-(-18646)end else w=5379951-(-3595)end end else if w<-42217+3400115 then if w<4345196-1023168 then if w<-234249+3549890 then h=q(217063-169999)k=q(618884+-571262)l=P[h]Q=q(-599856-(-647356))A=10232426775115-225199 S=538122+1886674816356 V=f[o]U=f[O]t=U(Q,A)U=q(-932698+979776)i=V[t]V=P[U]Q=f[o]w=5959605-323798 A=f[O]X=A(k,S)t=Q[X]Q=q(-973331-(-1020364))Q=V[Q]U={Q(V,t)}h=l(i,x(U))else Q=q(25624+21579)O=f[J[-514950-(-514951)]]U=3538917321924-878165 V=q(59608+-12479)h=f[J[-172653+172655]]A=174654+6295058260277 i=h(V,U)l=O[i]i=q(116271+-68754)F=a[l]h=P[i]V=f[J[-649679-(-649680)]]U=f[J[428431+-428429]]t=U(Q,A)Q=1012341+24386223438310 i=V[t]O=h[i]i=f[J[-840883+840884]]V=f[J[70361-70359]]t=q(1042142+-994830)U=V(t,Q)h=i[U]l=O[h]w=F==l w=w and-330004+5900772 or-779382+1338225 end else w=f[J[1026677+-1026671]]G=4100867847822-(-233703)A=f[U]k=f[J[-399650-(-399652)]]S=f[J[822616+-822613]]B=q(-305586-(-352725))m=S(B,G)X=k[m]Q=A[X]k=f[J[471866+-471864]]B=q(-760350-(-807815))S=f[J[-470751-(-470754)]]G=11804619918730-522258 m=S(B,G)X=k[m]A=V[X]i=Q-A F=w(i)w=551259-42926 end else if w<1045764+2347017 then if w<3439686-64788 then o=163396+-163371 w=f[J[265746+-265735]]F=w(o)w=423883+3776969 else Z_=f[o]U_=33883+20718187536724 r_=w i_=q(-276786-(-324291))N_=f[O]V_=N_(i_,U_)e_=Z_[V_]Y_=q(-543993-(-591488))Y_=O_[Y_]Y_=Y_(O_,e_)w=Y_ and 7462380-(-936993)or 792994-(-834085)b_=Y_ end else B=false m=f[J[844811-844796]]S=m==B X=S k=w w=S and 31953+2231015 or 13798528-567653 end end end else if w<350466+3321627 then if w<3755506-211447 then if w<488107+3013528 then if w<-700924+4111864 then Q=w k=false X=f[J[-720628+720644]]A=X==k w=A and 680761+2740846 or 7419896-653111 t=A else k=true X=f[J[-570609+570622]]A=X==k w=-176621+6943406 t=A end else f[o]=B w=f[o]w=w and 13622604-451949 or 451371+12717865 end else if w<4055866-446869 then if w<3951462-382925 then F={}w=P[q(836486+-788849)]else X=false k=true E=q(863755-816116)p=8852851715497-548239 f[J[116758-116749]]=X f[J[564221+-564211]]=k S=false f[J[-85365-(-85376)]]=S m=f[J[438555+-438552]]G=f[J[837780-837776]]n=f[J[333967+-333962]]y=f[J[-137275+137281]]j=f[J[626827+-626820]]v=j(E,p)I=y[v]K=n[I]n=-317964-(-317964)I=861237+-861236 B=m(G,K,n,I)w=9227452-299655 end else F={}w=P[q(-121576+169035)]end end else if w<-801077+4698254 then if w<-560540+4383706 then if w<-564925+4296353 then w=V w=i and-889085+15631397 or-794714+15452025 else X=q(-971569-(-1018939))t=q(529526+-482149)U=P[t]A=P[X]K=q(336133+-288871)k=f[J[-160853+160857]]n=21652160818374-(-64156)w=3929109-198510 S=f[J[-138895+138900]]B=q(-1047925+1095277)M=9434724786322-986985 j=-895674+24105962772115 G=-760381+18202242759513 m=S(B,G)X=k[m]Q=A[X]k=f[J[-280492+280498]]P_=13155456883293-868976 m=f[J[928600-928596]]y=q(740835+-693439)B=f[J[1019968+-1019963]]v=q(-269003+316395)p=q(-474029+521507)G=B(K,n)S=m[G]X=k[S]G=q(96969+-49434)B=P[G]K=f[J[-983393-(-983397)]]n=f[J[-457473+457478]]t=q(911981-864515)I=n(y,j)G=K[I]m=B[G]E=12573758483259-(-1026980)K=f[J[653124+-653118]]I=f[J[-534728-(-534732)]]y=f[J[-222394-(-222399)]]j=y(v,E)n=I[j]G=K[n]I=f[J[-263002-(-263008)]]j=f[J[837646+-837642]]v=f[J[976579-976574]]E=v(p,M)y=j[E]n=I[y]t=U[t]j=q(776887+-729630)y=P[j]v=f[J[-122077+122081]]M=q(562372+-515355)E=f[J[-1041352+1041357]]p=E(M,P_)j=v[p]v=-39575-(-39574)I=y[j]j=263324+-263324 E=-1003601-(-1003601)y=I(j,v,E)I=q(1014847-967392)K=n+y B=m(G,K)G=f[J[286628+-286624]]y=-628176+32766059352425 K=f[J[305468+-305463]]n=K(I,y)m=G[n]S=B[m]m=-578998+579002 k=S*m A=Q(X,k)Q=f[J[150716+-150706]]t=t(U,A,Q)i=t end else w=i w=F and 9049107-(-16847)or 9169630-(-95530)end else if w<3397142-(-709059)then if w<4042288-96099 then O=731421-731421 w=10672685-817324 l=o<O F=l else k=w m=-950884-(-950885)S=O>m X=S w=S and 10747008-(-921109)or 13309731-134253 end else m=f[J[216003-215997]]k=w B=false S=m==B X=S w=S and-1025971+7551714 or 7744948-(-161490)end end end end else if w<4546499-36921 then if w<-704052+4986770 then if w<3808438-(-373081)then if w<3119739-(-1036889)then if w<236779+3914255 then w=true w=w and 97699+7752310 or 12210595-(-254660)else k=q(-204294+251328)S=-615137+6701898854161 Q=f[J[-999277+999278]]w=q(66783-19288)w=U[w]A=f[J[868234-868232]]X=A(k,S)t=Q[X]w=w(U,t)w=w and-577858+8124273 or 611205+7220846 V=h end else if w<-492968+4668977 then w=11808608-(-947180)U=nil V=nil else F={}w=P[q(43941-(-3422))]end end else if w<358427+3857035 then if w<5035563-837049 then X=q(-98135+145708)U=q(-502135+549652)V=P[U]t=f[J[-940249-(-940250)]]Q=f[J[-123225+123227]]k=31852021575350-832710 A=Q(X,k)X=18059076483964-(-1041757)U=t[A]F=V[U]A=q(974463+-927330)U=f[J[-187167+187168]]t=f[J[-717291+717293]]Q=t(A,X)V=U[Q]w=F[V]O=w w=1962710-(-813232)else w=-688615+3697748 end else w=d_ w=-751346+10914699 z_=u_ end end else if w<4583593-232449 then if w<4552447-247910 then if w<4482902-188640 then w=t l=w Q=U o=Q w=9616314-898509 else U=w t=f[J[-572153-(-572158)]]w=t and-664846+12361530 or-667975+13708594 V=t end else V=q(-709444+756926)w=true l=q(42445-(-5000))O=H()o=H()f[o]=w F=P[l]a=W l=q(-868424+915546)w=F[l]l=H()f[l]=w w=u(-667385+12605772,{})f[O]=w w=false h=H()f[h]=w U=u(1086993-864126,{h})i=P[V]V=i(U)F=V w=V and-723770+10650778 or 927564+9953910 end else if w<-680592+5163557 then if w<967910+3388185 then a=a+l F=a<=o h=not O F=h and F h=a>=o h=O and h F=h or F h=10718491-148808 w=F and h F=8772660-(-185039)w=w or F else A,S=X(Q,A)w=A and 17112014-386689 or 4800204-(-17152)end else w=7214317-(-513208)end end end else if w<913532+3771842 then if w<3987735-(-545418)then if w<773550+3757330 then if w<-306439+4829949 then w=f[J[-969268-(-969269)]]i=23277046145508-(-182387)o=f[J[730435+-730433]]a=W[-557567-(-557568)]l=f[J[-802182-(-802185)]]h=q(-480366-(-527469))O=l(h,i)F=o[O]o=true a=nil w[F]=o F={}w=P[q(233193+-185651)]else l=973499+-973270 o=f[J[-411181+411183]]a=o*l o=-455457+25735462101488 F=a+o a=35184372366681-277849 w=F%a f[J[-1044689-(-1044691)]]=w o=673479+-673478 a=f[J[-575252+575255]]w=14052654-252911 F=a~=o end else V=f[J[984690+-984686]]t=f[J[-843497+843502]]A=f[J[71712-71706]]G=61398+33427721587959 k=f[J[-827698+827705]]B=q(333395-285969)S=f[J[-757119-(-757127)]]m=S(B,G)X=k[m]Q=A[X]A=-643044-(-643045)w=-926407+4227539 U=V(t,Q,A)end else if w<-374194+5015393 then if w<-79999+4650196 then i=f[J[-863156+863157]]V=f[J[811134-811132]]t=q(484996+-437385)Q=16062823063810-(-752693)U=V(t,Q)k=11923083670062-793726 X=q(433567+-386261)h=i[U]O=a[h]U=q(395495+-347978)V=P[U]t=f[J[-591716-(-591717)]]Q=f[J[-885380-(-885382)]]A=Q(X,k)U=t[A]i=V[U]A=q(-614833+662188)U=f[J[-180509-(-180510)]]t=f[J[-1043741-(-1043743)]]X=781573+6387033497241 Q=t(A,X)V=U[Q]h=i[V]l=O==h w=l and 406093+6506861 or-708947+800642 F=l else A=false t=false f[J[-522748-(-522760)]]=t Q=true f[J[608216+-608203]]=Q f[J[-189566-(-189580)]]=A k=f[J[-881304+881319]]X=not k w=X and 10768071-765617 or 695814+13507061 end else a=W[-975514+975515]o=W[-538695+538697]w=o and 4300171-386595 or-835119+10690480 F=o end end else if w<-438487+5178296 then if w<399144+4315255 then if w<-146236+4841725 then w=k w=X and 4128227-548957 or-762965+9690762 else w=true f[J[-721876-(-721877)]]=w a=f[J[357985+-357983]]F=not a f[J[749236-749234]]=F a=f[J[1180+-1178]]w=a and-130827+1070627 or-644899-(-833115)end else F={}w=f[J[-130380+130381]]w[a]=F w=9958452-(-385715)end else if w<113385+4680307 then if w<-375846+5154127 then O=true i=false h=false f[J[965868+-965858]]=O f[J[-462159-(-462170)]]=h f[J[-645654-(-645666)]]=i U=f[J[-784636+784649]]V=not U w=V and 8599002-33371 or 3946728-(-585594)else d_=w N_=q(361165-314007)V_=33984321462285-(-843204)Y_=f[o]e_=f[O]b_=q(937168+-889673)Z_=e_(N_,V_)r_=Y_[Z_]b_=O_[b_]b_=b_(O_,r_)w=b_ and 3860486-(-384314)or 8387+3377476 u_=b_ end else w=f[V]n=q(-674697+722091)S=q(73526+-26297)A=f[J[322490-322489]]m=29848407147288-19661 X=f[J[-865906-(-865908)]]k=X(S,m)m=-401913+24442951650927 Q=A[k]A=true w[Q]=A w=f[V]A=f[J[-287330+287331]]X=f[J[-752445-(-752447)]]S=q(-607828+655111)k=X(S,m)m=344200+28161986146993 Q=A[k]A=false w[Q]=A w=f[V]A=f[J[-418920+418921]]X=f[J[-1024529+1024531]]S=q(-1427-(-48441))k=X(S,m)Q=A[k]m=-557903+1531614791192 A=921356+-921356 w[Q]=A w=f[V]S=q(114384+-66755)A=f[J[-483389+483390]]X=f[J[-1024327+1024329]]G=25448793245731-(-730663)k=X(S,m)B=q(-78493+125977)Q=A[k]k=f[J[-917167-(-917168)]]S=f[J[318544+-318542]]m=S(B,G)X=k[m]m=q(408226-360734)B=-78752+16229627580709 A=O[X]w[Q]=A A=q(199596-152362)Q=P[A]X=f[J[-345816-(-345817)]]k=f[J[-964693-(-964695)]]S=k(m,B)m=q(377742+-330281)A=X[S]w=Q[A]X=f[J[-276838+276839]]B=26458271942387-972499 k=f[J[213894+-213892]]G=21172262690995-244272 S=k(m,B)A=X[S]Q=w(A)A=H()B=q(414421-366795)X=q(-488428-(-535662))f[A]=Q Q=P[X]k=f[J[178911+-178910]]S=f[J[47537-47535]]m=S(B,G)X=k[m]w=Q[X]B=q(477366-430205)k=f[J[273005-273004]]G=-315952+32819379703266 S=f[J[-634005-(-634007)]]m=S(B,G)I=-902993+21896990977829 X=k[m]Q=w(X)B=q(492596-445513)X=H()f[X]=Q w=f[V]k=f[J[952784+-952783]]S=f[J[-692863-(-692865)]]G=114265+8214624374936 m=S(B,G)Q=k[m]S=f[A]B=f[J[-169743-(-169744)]]G=f[J[406336+-406334]]K=G(n,I)m=B[K]k=S[m]I=24097325044060-501127 G=5435818003814-(-228477)B=q(908531+-861410)w[Q]=k w=f[V]k=f[J[-788461-(-788462)]]S=f[J[-946845+946847]]m=S(B,G)Q=k[m]S=f[X]B=f[J[-323057+323058]]G=f[J[-548530-(-548532)]]n=q(135013-87916)K=G(n,I)m=B[K]k=S[m]w[Q]=k k=q(-241179+288692)w=b(-258177+4942737,{J[-1005680-(-1005681)];J[588417-588415];V,h;U;t,i;J[-91832+91835];J[-191408-(-191412)],J[62996-62991],X,A})Q=f[V]Q[k]=w k=q(-61141-(-108208))w=Y(4787271-270064,{V,J[842256-842255],J[767048+-767046]})Q=f[V]Q[k]=w Q=f[V]w=b(6836449-(-531562),{J[204303+-204302];J[-74323-(-74325)];V})k=q(-727491-(-774865))Q[k]=w w=f[V]F={w}w=P[q(-709117-(-756266))]end end end end end end else if w<169348+6456461 then if w<6075348-277036 then if w<-71032+5327173 then if w<279363+4735139 then if w<-176803+5086486 then if w<4557655-(-310658)then if w<-25927+4869067 then s=f[o]P_=s w=s and 13544841-(-670340)or 7269508-795528 else o=W[143570-143568]a=W[960141+-960140]w=o and 11400579-516899 or 398051+11356577 end else if w<753636+4126180 then w=h w=O and 811782+-413300 or 12752977-(-404258)else z_=q(674531-627028)w=688503+5744301 z_=O_[z_]z_=z_(O_)end end else if w<5284194-285844 then if w<4780336-(-155675)then G=q(184224+-136826)I=q(754621+-707282)w=k S=f[J[-730017+730018]]K=1005842815354-87974 m=f[J[-23521-(-23523)]]B=m(G,K)k=S[B]v=16589752112277-226920 G=f[J[-489068-(-489069)]]M=q(315585+-268053)K=f[J[100997+-100995]]E=q(448746-401429)y=400328+23252012715651 n=K(I,y)y=24926655730303-(-1006296)B=G[n]m=o[B]G=f[J[831056-831055]]I=q(-760718+807864)j=q(-400290-(-447752))K=f[J[-369326-(-369328)]]n=K(I,y)I=30907841497600-922056 B=G[n]S=m[B]B=f[J[367278+-367277]]n=q(1095555-1047992)p=7800810433830-(-516362)G=f[J[1001164+-1001162]]K=G(n,I)m=B[K]n=f[J[-241892+241893]]I=f[J[817501-817499]]y=I(j,v)K=n[y]G=o[K]n=f[J[505636-505635]]I=f[J[-958032-(-958034)]]v=280908+16940725343620 j=q(489171+-441774)y=I(j,v)K=n[y]B=G[K]j=724727719419-91306 y=q(1030518-982859)K=f[J[1030108-1030107]]n=f[J[616635-616633]]I=n(y,j)G=K[I]y=f[J[-501969+501970]]j=f[J[-344369-(-344371)]]v=j(E,p)p=15882698994286-(-1043061)I=y[v]n=o[I]y=f[J[-226174+226175]]E=q(1030402+-983181)j=f[J[-713702-(-713704)]]v=j(E,p)E=693697+30278096822610 I=y[v]v=q(638013-590807)K=n[I]I=f[J[371881+-371880]]y=f[J[878380-878378]]P_=-358449+17420540254177 j=y(v,E)n=I[j]v=f[J[239522+-239521]]E=f[J[507419-507417]]p=E(M,P_)M=q(189740-142505)j=v[p]P_=30184812310598-489823 y=o[j]v=f[J[1022551+-1022550]]E=f[J[744523-744521]]p=E(M,P_)j=v[p]I=y[j]w={[F]=V,[i]=t,[U]=Q,[A]=X;[k]=S;[m]=B,[G]=K;[n]=I}A=q(963810+-916350)i=H()X=-144491+10973743138913 f[i]=w V=H()w={}f[V]=w w=f[V]U=f[J[-348625-(-348626)]]m=q(163187-116059)B=18783787563892-(-960182)k=q(17183-(-30157))t=f[J[796473+-796471]]Q=t(A,X)F=U[Q]U=-143730+143731 w[F]=U S=13059639355940-266851 w=f[V]U=f[J[227139-227138]]t=f[J[-395013+395015]]X=6498737077237-(-397277)A=q(-822319-(-869639))Q=t(A,X)F=U[Q]U=-352998+352998 w[F]=U U=H()w=q(-785064+832374)w=O[w]w=w(O)f[U]=w t=q(-482654-(-530060))F=P[t]Q=f[J[-530085+530086]]A=f[J[566424-566422]]X=A(k,S)t=Q[X]w=F[t]k=10027123770518-(-576935)Q=b(7059027-(-296381),{J[-660993-(-660994)];J[631714+-631712]})t=f[U]F=w(t,Q)w=f[V]t=f[J[431600+-431599]]Q=f[J[834899+-834897]]X=q(926493-879340)A=Q(X,k)F=t[A]A=f[U]k=f[U]X=#k Q=A[X]X=f[J[203618-203617]]k=f[J[-161617-(-161619)]]S=k(m,B)k=q(904543-857503)A=X[S]t=Q[A]k=O[k]w[F]=t w=r(10057574-(-18946),{J[320501+-320500];J[-747901+747903];V})t=H()F=q(-911044+958074)f[t]=w w=P[F]X={k(O)}k={w(x(X))}w=4424555-(-54926)A=k[-237680+237683]F=k[506914-506913]X=F Q=k[187523+-187521]else y=q(713534-666202)j=6595056351673-(-37446)X=f[J[468112-468103]]S=f[J[812629-812619]]B=f[J[-1040294-(-1040305)]]K=f[J[-161461+161465]]n=f[J[-690473+690478]]I=n(y,j)G=K[I]m=B[G]w=531048+8584535 B=-690095+690096 k=X(S,m,B)end else w=f[J[-888817+888822]]U=104527+21856680071026 o=f[J[134596+-134595]]O=f[J[656579+-656577]]V=q(1050303-1002718)h=f[J[-655646-(-655649)]]i=h(V,U)l=O[i]a=o[l]F=w(a)a=F w=a and-242226-(-251541)or-898678+4034913 end end else if w<4696588-(-432470)then if w<-749887+5850650 then if w<5371107-347006 then t=f[J[466401-466400]]k=34126346121067-(-396968)Q=f[J[822215-822213]]X=q(760963+-713407)B=q(-703780-(-751149))A=Q(X,k)m=29553370034474-146281 G=9619729011030-65495 U=t[A]V=a[U]t=q(796440+-749362)S=q(-65681+112954)U=P[t]A=f[J[-662940-(-662941)]]X=f[J[-213048+213050]]t=q(-345436-(-392677))k=X(S,m)X=q(471906-424630)t=U[t]Q=A[k]t=t(U,Q)A=P[X]k=f[J[172729+-172728]]S=f[J[-188847-(-188849)]]m=S(B,G)X=k[m]Q=A[X]A=Q(l,O,h)B=q(184835-137555)G=14302112125374-341947 k=f[J[-609735+609736]]S=f[J[-713809+713811]]m=S(B,G)X=k[m]k=q(-935482+982754)w=P[q(-588478-(-636084))]k=V[k]k=k(V,o,i)Q={[X]=k}U=q(1021705-974534)U=t[U]U=U(t,a,A,Q)F={U}t=q(183048+-135535)t=U[t]t=t(U)else a=q(738807-691606)F=q(722097-675025)w=P[F]F=P[a]a=q(-349547+396748)P[a]=w a=q(880397+-833325)w=-602422+8329947 P[a]=F a=f[J[-128933+128934]]o=a()end else F=f[J[-627121+627122]]h=q(804521-756879)i=3904134986672-(-822122)o=f[J[819359-819357]]l=f[J[-203333-(-203336)]]O=l(h,i)a=o[O]w=F[a]w=w and-223694+6815423 or-980086+4529286 end else if w<-389416+5580447 then if w<-967253+6130233 then U=q(851744-804436)i=q(884852+-837774)n=q(503058+-455889)h=P[i]i=q(-21378+68849)k=q(-616170+663770)V=P[U]i=h[i]Q=f[o]A=f[O]S=29397966771646-860229 L=31854461573711-(-663458)X=A(k,S)k=q(-448466-(-495919))t=Q[X]I=857556+24410972182163 U={V(t)}i=i(h,x(U))S=22107606167945-(-161453)h=-345067+345068 l=i[h]U=H()i=q(-813968-(-861647))h=P[i]V=423140+-423080 i=h(V)E=4995515699569-2139 V=H()h=171280+-171279.5 v=q(-406695+454186)f[V]=h g=-368245+34183460543650 h={}f[U]=h Q=f[o]A=f[O]X=A(k,S)t=Q[X]c=103919+20482416480082 X=q(818526-770991)A=P[X]k=f[o]S=f[O]m=S(n,I)S=226664+-226664 X=k[m]n=29087123229737-186177 k=-302347+302347 Q=A[X]X=697252+-697252 m=q(377658-329975)A=Q(X,k,S)X=f[o]k=f[O]S=k(m,n)Q=X[S]m=q(66107+-18572)S=P[m]n=f[o]I=f[O]j=I(v,E)m=n[j]k=S[m]m=1006177+-1006177 p=14759539983800-846560 I=783553+-783553 n=-27924+27924 E=q(297346-249915)S=k(m,n,I)n=q(676428+-628893)m=P[n]I=f[o]j=f[O]v=j(E,p)F_=1038461+-1038461 n=I[v]j=q(-500045-(-547107))k=m[n]M=q(-151596-(-198781))I=P[j]v=f[o]E=f[O]p=E(M,c)C=592423+-592422 j=v[p]n=I[j]j=997774-997864 d_=-974027+974027 v=q(507563-460501)I=n(j)j=P[v]c=q(-522219+569888)T=-128551+128551 E=f[o]p=f[O]M=p(c,g)v=E[M]n=j[v]v=432878-432698 j=n(v)E=q(-905175-(-952237))w_=75761-75761 v=P[E]H_=-209888+209889 p=f[o]M=f[O]g=q(467737-420650)c=M(g,L)E=p[c]n=v[E]e_=862586+-862586 E=1021300+-1021300 g=-773967-(-773968)v={n(E)}m=k(I,j,x(v))I=q(826373-779283)X=S*m S=f[o]j=9139362968430-(-498993)m=f[O]a_=-1011722-(-1011722)n=m(I,j)k=S[n]E=q(450657+-403401)n=q(-341887-(-389422))m=P[n]x_=919067-919067 I=f[o]p=10283633492206-77370 j=f[O]D_=-668617-(-668617)v=j(E,p)p=-470664+470664 o_=-516361-(-516361)M=417830+-417830 L=-478843-(-478843)n=I[v]c=-840514+840514 v=148814-148815 q_=-499919-(-499920)u_=-352129-(-352129)S=m[n]I=898572+-898571 j=806466-806466 E=-9820+9820 n=-1034244+1034244 m=S(n,I,j,v,E,p,M,c,g,L,C,T)L=-1035808+1035808 v=q(1004445+-957369)T=-1001320-(-1001320)E=33057693174643-773970 n=f[o]I=f[O]j=I(v,E)S=n[j]j=q(-947340-(-994875))f_=-47224+47224 c=6927905718988-210482 g=-905008-(-905008)I=P[j]C=-881442+881443 v=f[o]E=f[O]J_=-787475-(-787475)M=q(539513-492485)p=E(M,c)j=v[p]M=572861-572861 O_=102281-102281 n=I[j]c=-691515-(-691515)p=-241885+241884 j=-381592+381592 R_=738766+-738766 E=360925-360925 v=127522-127522 I=n(j,v,E,p,M,c,g,L,C,T,q_,w_)w_=1039088-1039089 g=q(-976246-(-1023340))L=18408669884920-20604 p=q(703568-656330)j=f[o]v=f[O]M=24552110469596-(-260812)b_=-612478+612478 E=v(p,M)n=j[E]E=q(-625751-(-673286))v=P[E]q_=-287172-(-287172)W_=-970766+970766 p=f[o]M=f[O]c=M(g,L)T=448553+-448552 E=p[c]C=354131+-354131 M=-64464+64464 g=-205128-(-205128)c=345904-345904 j=v[E]p=-111729+111729.5 E=284579-284578 L=924578-924577 v=j(E,p,M,c,g,L,C,T,q_,w_,x_,W_)q_=-268827-(-268827)C=q(251902+-204394)w_=-523453-(-523454)h_=-466040+466040 T=21511019269815-(-514153)E=f[o]p=f[O]c=q(652101-604572)x_=154636+-154636 g=15360138113571-742963 M=p(c,g)j=E[M]M=q(736545-689010)p=P[M]c=f[o]g=f[O]L=g(C,T)W_=-243946-(-243947)g=331186-331186 M=c[L]T=-528111+528110 c=-976632.5-(-976633)E=p[M]C=-1008300+1008300 L=-602059-(-602059)M=146150-146151 z_=-921421+921421 p=E(M,c,g,L,C,T,q_,w_,x_,W_,J_,R_)M=f[o]c=f[O]w_=-590499+3757088180600 L=q(-678758+725939)C=-255543+14642840977625 w=713593+14922286 q_=q(630769-583351)g=c(L,C)E=M[g]g=q(-213455+260990)W_=403098+-403097 c=P[g]L=f[o]C=f[O]T=C(q_,w_)g=L[T]T=1029859-1029859 M=c[g]x_=-773546+773546 L=-897284-(-897283)R_=233485+-233486 q_=267713-267713 w_=842679-842678 C=284019+-284019 g=-330835+330836 J_=-276720-(-276720)c=M(g,L,C,T,q_,w_,x_,W_,J_,R_,D_,F_)x_=q(556920-509377)T=q(826783-779199)g=f[o]R_=357853-357852 q_=-774876+12062110116044 L=f[O]C=L(T,q_)M=g[C]W_=859332+14156476398844 F_=-298240-(-298241)l_=-983569+983570 C=q(-601830-(-649365))D_=772668-772668 L=P[C]T=f[o]q_=f[O]w_=q_(x_,W_)J_=-742329-(-742329)q_=534784-534784 C=T[w_]g=L[C]x_=-521305+521305 C=520099+-520100 w_=688040+-688040 W_=681154-681155 T=-479390-(-479389)L=g(C,T,q_,w_,x_,W_,J_,R_,D_,F_,f_,a_)f_=1046820-1046819 a_=-37946+37946 C=f[o]x_=14092658342009-368343 w_=q(-651318+698991)T=f[O]F_=150844-150844 q_=T(w_,x_)J_=q(782370-734947)R_=22294534915180-(-975905)g=C[q_]q_=q(702849+-655314)D_=-680495+680495 T=P[q_]w_=f[o]x_=f[O]Y_=619771+-619771 W_=x_(J_,R_)x_=1009592-1009592 R_=-737208+737208 q_=w_[W_]C=T[q_]q_=309643-309643 w_=150397-150396 J_=-840299-(-840299)W_=932094-932095 T=C(q_,w_,x_,W_,J_,R_,D_,F_,f_,a_,H_,o_)q_=f[o]W_=q(-439008-(-486583))w_=f[O]J_=16043152837556-224902 x_=w_(W_,J_)C=q_[x_]F_=-557276+3465127888681 x_=q(-805247-(-852782))w_=P[x_]W_=f[o]J_=f[O]D_=q(-206323-(-253762))H_=-1045608+1045609 f_=540942-540942 a_=790155-790155 R_=J_(D_,F_)x_=W_[R_]J_=-566858+566858 F_=602720-602720 q_=w_[x_]x_=-716970+716970 R_=925023+-925024 D_=-560457+560457 W_=-356735-(-356735)o_=-968030-(-968030)w_=q_(x_,W_,J_,R_,D_,F_,f_,a_,H_,o_,l_,O_)o_=602181+-602180 l_=-152845+152845 D_=96527+16288773366930 x_=f[o]R_=q(622606-575164)W_=f[O]J_=W_(R_,D_)H_=-12210+12210 q_=x_[J_]J_=q(931387+-883852)W_=P[J_]R_=f[o]f_=q(271665-224179)D_=f[O]a_=-87335+26671040153002 F_=D_(f_,a_)J_=R_[F_]f_=725525+-725525 R_=-538043+538043.5 D_=-348814-(-348814)O_=31888-31889 F_=113279-113279 x_=W_[J_]a_=129389-129388 J_=596835-596834 W_=x_(J_,R_,D_,F_,f_,a_,H_,o_,l_,O_,z_,h_)J_=f[o]R_=f[O]H_=q(89867-42757)z_=903370+-903370 f_=16377760836752-(-880954)o_=9460315433408-(-747381)F_=q(282349+-235141)D_=R_(F_,f_)O_=43576+-43575 x_=J_[D_]D_=q(-664152+711687)R_=P[D_]F_=f[o]f_=f[O]a_=f_(H_,o_)H_=68671+-68671 l_=352026-352026 D_=F_[a_]o_=299555+-299556 a_=-21256-(-21256)J_=R_[D_]D_=-309183-(-309182)F_=377612.5-377612 h_=898533-898532 f_=-518400-(-518400)R_=J_(D_,F_,f_,a_,H_,o_,l_,O_,z_,h_,u_,d_)D_=f[o]H_=3799788309428-591051 h_=572515-572514 r_=-907452+907452 d_=-249400-(-249399)a_=q(-525683-(-573260))F_=f[O]f_=F_(a_,H_)J_=D_[f_]f_=q(310714-263179)F_=P[f_]l_=q(-357624-(-405257))a_=f[o]z_=-394729+394729 O_=-120915+27865880791811 H_=f[O]o_=H_(l_,O_)f_=a_[o_]a_=588353-588354 o_=-436243+436243 u_=-369791-(-369791)O_=404824+-404823 H_=802454+-802454 D_=F_[f_]f_=-452693-(-452694)l_=-266366+266366 F_=D_(f_,a_,H_,o_,l_,O_,z_,h_,u_,d_,b_,r_)r_=42221-42220 f_=f[o]a_=f[O]o_=q(-474896-(-522430))h_=25907393083712-(-964064)l_=662481+3673909324509 H_=a_(o_,l_)D_=f_[H_]H_=q(858972+-811437)a_=P[H_]z_=q(-611244-(-658522))o_=f[o]b_=-371947+371947 l_=f[O]d_=560329-560328 u_=-895774+895774 O_=l_(z_,h_)h_=388155-388156 H_=o_[O_]O_=779599-779599 f_=a_[H_]l_=892556-892556 z_=583069+-583069 o_=-354799+354798 H_=-951999-(-951998)a_=f_(H_,o_,l_,O_,z_,h_,u_,d_,b_,r_,Y_,e_)h={[t]=A;[Q]=X,[k]=m;[S]=I,[n]=v,[j]=p;[E]=c;[M]=L,[g]=T;[C]=w_,[q_]=W_;[x_]=R_,[J_]=F_;[D_]=a_}t=H()d_=2910128464445-204018 Q=e(8230932-99823,{o;O})m=q(-819531-(-866694))X=q(-441019-(-488573))f[t]=h h=H()f[h]=Q C=q(-968590-(-1016120))j=H()A=f[U]Q=N(-129412+11975964,{o;O,h,t,V})I=false A[X]=Q X=f[o]L=193338+15098198255676 k=f[O]Q=q(1060357-1012826)n=-575128+9201536997204 Q=l[Q]S=k(m,n)m=H()v=q(500705+-453627)l_=207033+28012733893179 w_=6231768877091-81102 A=X[S]Q=Q(l,A)O_=202935626190-502128 A=H()X=false f[A]=Q Q=false k=false q_=16212737783280-333939 f[m]=Q S=false Q=H()f[Q]=X X=H()f[X]=k T=5939732331796-45639 k=H()n=false f[k]=S S=false f[j]=S g=q(-82154+129393)S=H()f[S]=n a_=26714600720016-300537 n=H()f[n]=I I=P[v]p=f[o]v=q(139103-91862)v=I[v]M=f[O]c=M(g,L)E=p[c]p=q(437541-390463)v=v(I,E)E=P[p]f_=-810512+32724203526550 c=f[o]p=q(-864343-(-911584))p=E[p]g=f[O]L=g(C,T)M=c[L]p=p(E,M)M=f[o]L=q(-425429+473060)c=f[O]C=30679549598617-500683 g=c(L,C)C=q(-728187-(-775440))E=M[g]I=p[E]M=q(-461583+508635)W_=713059+28017356132755 p=P[M]o_=18811198158571-480436 c=f[o]g=f[O]T=-247663+26221452392225 L=g(C,T)M=c[L]E=p[M]p=H()f[p]=E H_=-526837+2783861788421 E=f[p]g=f[o]T=q(549754+-502491)M=q(714484+-666953)L=f[O]r_=898025+30277409112874 C=L(T,q_)c=g[C]q_=q(-468012+515293)M=E[M]M=M(E,c)c=q(-48730-(-96261))E=H()f[E]=M M=f[p]L=f[o]C=f[O]T=C(q_,w_)c=M[c]g=L[T]x_=30322319861997-(-364090)c=c(M,g)w_=q(829543+-782028)g=q(650511-602980)M=f[p]C=f[o]T=f[O]q_=T(w_,x_)z_=-778473+18194031116801 D_=q(-409738-(-457105))L=C[q_]g=M[g]g=g(M,L)M=H()f[M]=g g=f[p]T=f[o]x_=q(-372577-(-419877))q_=f[O]w_=q_(x_,W_)C=T[w_]L=q(-710414+757945)L=g[L]L=L(g,C)g=H()w_=q(-172300-(-219831))T=b(1502479-(-459034),{p;o;O,g})f[g]=L C=q(219294-171812)L=P[C]C=L(T)F_=279099+28984190005885 L=H()C=r(12340092-694213,{g,o;O})f[L]=C T=r(11469398-468556,{M,o,O})C=H()f[C]=T T=e(8143435-(-194470),{o,O})q_=f[p]u_=q(380517-333139)W_=f[o]J_=f[O]R_=J_(D_,F_)w_=q_[w_]F_=q(-323644-(-370966))x_=W_[R_]w_=w_(q_,x_)q_=H()f[q_]=w_ x_=q(195050-147519)w_=f[p]J_=f[o]R_=f[O]D_=R_(F_,f_)W_=J_[D_]x_=w_[x_]x_=x_(w_,W_)w_=f[p]R_=f[o]f_=q(-908669-(-956333))D_=f[O]F_=D_(f_,a_)J_=R_[F_]W_=q(-404180-(-451711))a_=-481382+12456514678542 W_=w_[W_]W_=W_(w_,J_)R_=f[o]D_=f[O]f_=q(607633-560428)F_=D_(f_,a_)J_=R_[F_]w_=l[J_]D_=f[o]F_=f[O]a_=q(-1035084+1082639)f_=F_(a_,H_)R_=D_[f_]a_=q(-389295+436738)J_=q(-419519-(-467050))J_=w_[J_]J_=J_(w_,R_)w_=q(-219819+266944)H_=7807118826670-(-209285)w_=J_[w_]w_=w_(J_)J_=q(-2474+49883)J_=w_[J_]D_=f[o]F_=f[O]f_=F_(a_,H_)R_=D_[f_]J_=J_(w_,R_)D_=f[o]F_=f[O]H_=802025+27624793650518 a_=q(634870-587470)f_=F_(a_,H_)R_=D_[f_]H_=22904075682961-334568 a_=-779491+11932028517015 D_=872456+-872455 J_[R_]=D_ R_=f[o]f_=q(851083-803834)D_=f[O]F_=D_(f_,a_)J_=R_[F_]a_=31084165894474-530624 R_=f[p]w_[J_]=R_ R_=f[o]D_=f[O]f_=q(149074+-101879)F_=D_(f_,a_)J_=R_[F_]R_=true a_=q(-688160-(-735348))w_[J_]=R_ D_=f[o]F_=f[O]f_=F_(a_,H_)H_=q(-288170-(-335729))R_=D_[f_]J_=l[R_]F_=f[o]f_=f[O]a_=f_(H_,o_)D_=F_[a_]a_=q(-988770-(-1036169))R_=q(-656179+703710)R_=J_[R_]o_=q(456484-409418)R_=R_(J_,D_)J_=q(-175095+222220)J_=R_[J_]J_=J_(R_)H_=-29490+1452360054230 D_=f[o]F_=f[O]f_=F_(a_,H_)R_=D_[f_]D_=f[p]J_[R_]=D_ H_=376113+13234837117665 D_=f[o]a_=q(106673-59298)F_=f[O]f_=F_(a_,H_)R_=D_[f_]D_=-686052-(-686053)J_[R_]=D_ f_=f[o]a_=f[O]H_=a_(o_,l_)l_=596154+16550557877600 o_=q(109132+-61658)F_=f_[H_]D_=l[F_]f_=f[o]a_=f[O]H_=a_(o_,l_)F_=f_[H_]o_=19174568888132-(-891804)H_=q(377541-330485)R_=D_[F_]D_=q(1024183-977058)D_=R_[D_]D_=D_(R_)F_=f[o]f_=f[O]a_=f_(H_,o_)o_=23507911662345-569415 R_=F_[a_]l_=q(-997589-(-1044916))F_=f[M]H_=q(-392624+440229)D_[R_]=F_ F_=f[o]f_=f[O]a_=f_(H_,o_)R_=F_[a_]F_=f[M]D_[R_]=F_ F_=f[o]f_=f[O]o_=7587637652785-(-860316)H_=q(-18001-(-65178))a_=f_(H_,o_)R_=F_[a_]F_=J_ D_[R_]=F_ a_=f[o]H_=f[O]o_=H_(l_,O_)f_=a_[o_]l_=q(-45169+92515)F_=l[f_]a_=f[o]O_=29739679736045-(-169259)H_=f[O]o_=H_(l_,O_)f_=a_[o_]R_=F_[f_]F_=q(385920-338795)l_=2725585878638-(-755335)o_=q(1029491-982177)F_=R_[F_]F_=F_(R_)f_=f[o]a_=f[O]H_=a_(o_,l_)R_=f_[H_]f_=f[M]o_=q(-505893+553001)F_[R_]=f_ f_=f[o]l_=-1038251+28220293008128 a_=f[O]H_=a_(o_,l_)o_=q(-926007+973672)R_=f_[H_]O_=q(-179223-(-226557))f_=f[M]F_[R_]=f_ l_=761535+1788089525377 f_=f[o]a_=f[O]H_=a_(o_,l_)R_=f_[H_]a_=q(2503+44731)f_=w_ F_[R_]=f_ f_=P[a_]H_=f[o]o_=f[O]l_=o_(O_,z_)z_=397027+24131794574594 O_=q(-184945-(-232081))a_=H_[l_]R_=f_[a_]H_=f[o]o_=f[O]l_=o_(O_,z_)a_=H_[l_]f_=R_(a_)R_=H()b_=449958228004-(-643245)O_=q(1043331+-995944)f[R_]=f_ f_=f[R_]H_=f[o]o_=f[O]z_=387010+31194148540667 l_=o_(O_,z_)O_=q(-437239-(-484916))z_=295215+16443604507834 a_=H_[l_]H_=f[M]f_[a_]=H_ f_=f[R_]H_=f[o]o_=f[O]l_=o_(O_,z_)a_=H_[l_]H_=f[M]f_[a_]=H_ O_=q(-705248+752435)f_=f[R_]H_=f[o]z_=-486010+31336441226106 o_=f[O]l_=o_(O_,z_)a_=H_[l_]H_=f[q_]O_=q(-890765-(-938392))f_[a_]=H_ f_=f[R_]H_=f[o]z_=784777+34301728802011 o_=f[O]l_=o_(O_,z_)a_=H_[l_]l_=q(-789735+837270)o_=P[l_]O_=f[o]z_=f[O]h_=z_(u_,d_)l_=O_[h_]H_=o_[l_]z_=-931205+931205 O_=-372760+372745 l_=-545582+545582 h_=235780+3562809355639 u_=q(320352+-273228)o_=H_(l_,O_,z_)f_[a_]=o_ a_=f[p]f_=T(a_,J_,x_)z_=q(-501957-(-549384))a_=f[p]f_=T(a_,w_,W_)a_=q(-173808+220886)f_=P[a_]a_=q(975544-928303)a_=f_[a_]o_=f[o]l_=f[O]O_=l_(z_,h_)H_=o_[O_]l_=q(707451-660373)a_=a_(f_,H_)o_=P[l_]O_=f[o]z_=f[O]d_=605965+28101547160592 h_=z_(u_,d_)l_=O_[h_]H_=o_[l_]o_=q(-909888+956929)z_=f[o]d_=q(-187787-(-235055))o_=H_[o_]h_=f[O]u_=h_(d_,b_)O_=z_[u_]l_=I[O_]z_=q(337319-289802)o_=o_(H_,l_)f_=q(665634-618464)O_=P[z_]f_=a_[f_]h_=f[o]u_=f[O]b_=q(-813173-(-860415))d_=u_(b_,r_)b_=228827+5373689646059 z_=h_[d_]l_=O_[z_]z_=f[o]d_=q(-370207+417308)h_=f[O]u_=h_(d_,b_)O_=z_[u_]H_=l_[O_]f_=f_(a_,o_,H_)H_=q(-710177+757708)a_=H()h_=q(322234-275007)f[a_]=f_ f_=f[a_]l_=f[o]O_=f[O]u_=-968918+3233821118135 z_=O_(h_,u_)H_=f_[H_]o_=l_[z_]H_=H_(f_,o_)z_=q(-47424-(-94613))o_=f[o]h_=783064+2900156158574 l_=f[O]O_=l_(z_,h_)f_=o_[O_]o_=true H_[f_]=o_ f_=f[a_]o_=f[o]z_=q(-149263+196442)l_=f[O]h_=32825+32998484294605 O_=l_(z_,h_)H_=o_[O_]o_=nil f_[H_]=o_ h_=q(417566+-370526)H_=q(-907344+954374)f_=P[H_]O_=f[a_]h_=O_[h_]z_={h_(O_)}O_={f_(x(z_))}l_=O_[649203-649200]H_=O_[222076+-222075]o_=O_[-126086-(-126088)]else w=f[J[352536-352535]]F=w()F={}w=P[q(378024+-330792)]end else B=q(-519170-(-566711))G=368742+11073306768318 A=f[J[65542+-65541]]k=f[J[-509641-(-509643)]]w=4581+9879732 S=f[J[98424-98421]]m=S(B,G)X=k[m]Q=A[X]A=21324-21324 i=Q>A F=i end end end else if w<4871296-(-665139)then if w<5536807-122664 then if w<5810661-435647 then if w<4492887-(-829179)then w=V V=150643+-150642 U=-507076-(-507256)h=O(i,V,U)o=nil F={}a=nil w[l]=h w=P[q(640874-593565)]else w=f[J[191979+-191972]]F=w()w=4404477-(-130686)end else F={}o=nil w=P[q(-662962+710530)]end else if w<634367+4799845 then if w<-363741+5782772 then o=nil F={}a=nil w=P[q(276531+-229349)]else w=f[J[-79338+79339]]w=w and 10249991-854740 or 12008802-119670 end else w=true w=w and 12823080-397043 or 12207985-(-240712)end end else if w<896461+4734888 then if w<4648083-(-950364)then if w<-821816+6364303 then w=768827+5882571 Q=q(-640369-(-687517))t=P[Q]F=t else w=f[J[180670-180664]]F=w()w=-679951+1238794 end else w=V and 4231776-908894 or-911065+1419398 end else if w<-619139+6352252 then if w<6226944-548473 then i=q(-226180+273812)h=P[i]A=q(3920+43608)U=f[o]t=f[O]X=26073+24556841436882 Q=t(A,X)V=U[Q]i=h(V)l=not i w=l and-915059+14037550 or-173622+8477800 else X=true v=-465721+32091718653336 f[J[42355-42340]]=X k=f[J[-180912-(-180926)]]w=10757470-840070 m=f[J[-444488-(-444496)]]G=f[J[506313+-506304]]j=q(-106232-(-153845))n=f[J[1015552-1015550]]I=f[J[-171200-(-171203)]]y=I(j,v)K=n[y]B=G[K]G=-694591+694592 S=k(m,B,G)end else w=F and-886626+2454305 or-739985+8521446 end end end end else if w<-519779+6903132 then if w<6914572-761954 then if w<5539303-(-489645)then if w<-693076+6616190 then if w<5833004-10195 then w=f[J[333145-333139]]B=-777237+19303860240178 m=q(144070-96412)Q=f[J[-153068-(-153069)]]X=f[J[447992-447990]]k=f[J[327011-327008]]S=k(m,B)A=X[S]i=Q[A]F=w(i)w=474548+11021029 else F=true w=true f[J[-674369+674370]]=w f[J[990859-990857]]=F Q=q(-876625+924271)l=509117+-509114 a=f[J[-68064+68067]]A=-549338+23308823383104 o=a(l)a=f[J[490501+-490497]]S=q(-951457-(-998654))l=f[J[-251053+251058]]h=f[J[-744366+744372]]V=f[J[843977-843970]]U=f[J[339347+-339339]]t=U(Q,A)i=V[t]V=q(792874-745789)O=h[i]h=-185525+185526 o=a(l,O,h)U=-675500+25852679519666 O=f[J[635380+-635373]]h=f[J[-638372+638380]]i=h(V,U)m=31689485264852-(-381392)l=O[i]a=o[l]l=q(367219-319983)l=a[l]h=w l=l(a)l=false a=false f[J[-154638-(-154639)]]=a f[J[164812+-164810]]=l t=f[J[793182+-793173]]A=f[J[-607012+607019]]X=f[J[231724+-231716]]k=X(S,m)Q=A[k]U=t[Q]Q=f[J[679775+-679768]]A=f[J[-610832-(-610840)]]k=q(-48147+95595)S=-478263+19946347212927 X=A(k,S)t=Q[X]V=U[t]U=692382+-692381 i=V<U w=i and 4339+10543197 or 454383-297148 O=i end else if w<5599492-(-369179)then B=f[J[475159-475146]]G=true w=10003068-336113 m=B==G k=m else w=q(719384+-671881)w=S[w]w=w(S)w=223591+9258775 end end else if w<5293161-(-835574)then if w<-612428+6694125 then l=f[J[802213-802204]]w={}O=l o=-27527-(-27528)l=-323805+323806 a=w w=-307073-(-551384)h=l l=784703-784703 i=h<l l=o-h else m=-120052+120053 n=#k S=l(m,n)j=579363-579362 m=i(k,S)w=471366+12027602 n=f[X]y=m-j I=V(y)n[m]=I m=nil S=nil end else F=t w=Q w=t and 964031+5687367 or 254539+5286016 end end else if w<6933119-637481 then if w<-407895+6636068 then if w<-87303+6280221 then w=Q w=t and 3549303-(-1029828)or 12540849-(-1277)else Q=Q+A k=not X U=Q<=t U=k and U k=Q>=t k=X and k U=k or U k=-1005082+9377368 w=U and k U=216551+6145503 w=w or U end else y=q(631828+-584581)c=nil m=H()S={}f[m]=S n=r(-77352+16169049,{m;t;Q;h})I=H()M=q(24590-(-22842))S=H()f[S]=n V=nil n={}f[I]=n j={}A=nil n=P[y]l=nil h=z(h)E=q(1072775-1025305)i=nil p=f[I]A=q(-715117-(-762534))k=nil v={[E]=p;[M]=c}y=n(j,v)U=nil f[o]=y n=b(199234+12419895,{I;m;X,t;Q;S})i=q(533025+-485393)X=z(X)m=z(m)I=z(I)f[O]=n t=z(t)Q=z(Q)h=P[i]X=10335569343703-(-1039861)S=z(S)U=f[o]t=f[O]Q=t(A,X)V=U[Q]i=h(V)l=not i w=l and 3564247-251275 or 576119+5059688 end else if w<607506+5754456 then if w<-472596+6826416 then w=m w=156356+13019122 X=S else F=o w=l w=17391328-1004659 end else O=nil w=-537757+7160063 V=nil i=nil end end end else if w<6547598-58194 then if w<-276280+6733184 then if w<5478757-(-972643)then if w<-366283+6797648 then w=F and 7831720-954391 or 432076+10515164 else O_=nil w=14680599-(-955280)f_=nil end else w=P[q(-1035501+1082693)]F={o}end else if w<7348754-869389 then if w<5553243-(-916445)then Z_=q(-234455-(-281950))Q_=q(828240+-780845)X_=252309313332-(-911681)V_=f[o]i_=f[O]w=8948186-(-977603)Z_=O_[Z_]U_=i_(Q_,X_)N_=V_[U_]Z_=Z_(O_,N_)Y_=Z_ else C=1005397-1005396 f[o]=P_ L=f[v]g=L+C c=M[g]s=A+c c=798745-798489 w=s%c g=f[j]c=X+g g=-975719-(-975975)A=w w=69197+12556840 s=c%g X=s end else Q=477703+32151856869492 X=462708+15052290247661 k=-992057+19277828425289 t=q(-912709+959995)i=f[J[391911+-391910]]V=f[J[-497797-(-497799)]]U=V(t,Q)I=9290917901243-(-351531)F=i[U]A=q(-51527-(-98657))U=f[J[755938+-755937]]t=f[J[-823640+823642]]Q=t(A,X)V=U[Q]X=q(138437+-91322)i=o[V]t=f[J[-342788+342789]]Q=f[J[-104430-(-104432)]]A=Q(X,k)n=q(-952427+999876)m=985396+10764494408288 y=5287305880397-809391 V=q(1043161+-995752)V=i[V]U=t[A]B=q(877331-829716)V=V(i,U)U=f[J[493235-493234]]A=q(-237983+285213)S=-172654+31341064346480 X=-668399+432613258168 t=f[J[702923+-702921]]k=q(-911188-(-958345))Q=t(A,X)i=U[Q]Q=f[J[515977+-515976]]A=f[J[271934+-271932]]X=A(k,S)G=5617009276754-1010971 t=Q[X]S=q(15553+31752)U=o[t]t=q(-941362-(-988771))t=U[t]A=f[J[860229-860228]]X=f[J[407913+-407911]]k=X(S,m)Q=A[k]S=16810374616581-309106 t=t(U,Q)Q=f[J[-432821-(-432822)]]k=q(960836+-913312)A=f[J[60679-60677]]X=A(k,S)U=Q[X]k=f[J[405740-405739]]S=f[J[164645+-164643]]m=S(B,G)X=k[m]B=q(-702490-(-749862))A=o[X]G=560589+14564282567857 k=f[J[180930+-180929]]S=f[J[-514120+514122]]m=S(B,G)X=k[m]m=q(-441925-(-489227))Q=A[X]X=f[J[-800213-(-800214)]]B=9491883177134-303978 k=f[J[-121474-(-121476)]]S=k(m,B)k=w A=X[S]B=f[J[-485355+485356]]G=f[J[-716694-(-716696)]]K=G(n,I)m=B[K]I=q(-968573-(-1016008))S=o[m]G=f[J[851033+-851032]]K=f[J[-797796+797798]]n=K(I,y)B=G[n]m=q(480226-432817)m=S[m]m=m(S,B)X=m w=m and 4681535-(-241671)or 16084089-(-120350)end end else if w<5854632-(-715905)then if w<110402+6419470 then if w<7276785-751702 then w=15201895-88198 U=false V=f[J[-329248-(-329261)]]i=V==U F=i else B=true m=f[J[-544003-(-544013)]]w=-449529+8355967 S=m==B X=S end else t=5244030742818-92057 l=f[J[-509036+509037]]U=q(-384589-(-431666))h=f[J[338946+-338944]]i=f[J[733014-733011]]V=i(U,t)O=h[V]o=l[O]a=not o w=a and 12530596-526685 or 15181656-(-312021)F=a end else if w<6870091-250598 then if w<7441172-849888 then i_=q(-807045+854279)V_=P[i_]A_=q(-227377+274644)l=nil t_=24431590975184-359008 L=z(L)X=z(X)U_=f[o]Q_=f[O]X_=Q_(A_,t_)S=z(S)z_=z(z_)A=z(A)i_=U_[X_]N_=V_[i_]j=z(j)D_=nil A_=q(-927438+974971)q_=z(q_)t_=1017541+12193951911785 x_=nil U_=f[o]H_=nil k_=34092690962312-(-296571)Q_=f[O]C=z(C)X_=Q_(A_,t_)i_=U_[X_]V_=N_(i_)l_=nil w=P[q(-905680+953082)]A_=q(-816480-(-863679))J_=nil c=nil E=z(E)U_=f[o]t_=21535584930589-(-334863)O_=z(O_)Q_=f[O]R_=z(R_)h=z(h)X_=Q_(A_,t_)i=nil i_=U_[X_]U_=b(16619851-623428,{Z_;r_;e_;f_})u_=z(u_)N_=V_[i_]I=nil v=nil F={}i_=q(-779069-(-826288))V=z(V)t_=q(773369-726021)n=z(n)i_=N_[i_]Z_=z(Z_)i_=i_(N_,U_)i_=q(1003279-956201)N_=P[i_]t=z(t)h_=z(h_)Q_=f[o]X_=f[O]Y_=nil a_=z(a_)A_=X_(t_,k_)e_=z(e_)U_=Q_[A_]f_=z(f_)g=z(g)t_=q(753992+-706695)i_=q(230511-183270)r_=z(r_)k=z(k)Q=z(Q)m=z(m)i_=N_[i_]U=z(U)i_=i_(N_,U_)M=z(M)N_=q(909760-862671)F_=nil o_=z(o_)W_=nil b_=z(b_)Q_=f[o]N_=i_[N_]d_=z(d_)w_=nil X_=f[O]k_=16292351049692-(-204230)A_=X_(t_,k_)p=z(p)o=z(o)U_=Q_[A_]T=nil N_=N_(i_,U_,V_)O=z(O)V_=nil else h=-297371+7000155903574 w=f[J[579453-579452]]a=f[J[-383207+383209]]o=f[J[669801+-669798]]O=q(-873147-(-920160))l=o(O,h)F=a[l]a=596612+-596612 w[F]=a w=-705901+4255101 end else F={o}w=P[q(208553+-160941)]end end end end end else if w<6918727-(-1013176)then if w<6738888-(-645705)then if w<784131+6207762 then if w<-1002873+7884350 then if w<-774176+7544890 then if w<6652440-(-15507)then t=H()f[t]=F w=f[V]A=703631-703566 Q=-826240-(-826243)F=w(Q,A)Q=H()S=d(-324794+8930095,{})f[Q]=F w=-713164-(-713164)A=w w=-245024+245024 X=w k=q(319436-271954)F=P[k]k={F(S)}F=795930-795928 w={x(k)}k=w w=k[F]F=q(-961828-(-1009235))S=w K=q(-822182+869200)w=P[F]m=f[l]G=P[K]K=G(S)G=q(207374-160218)B=m(K,G)m={B()}F=w(x(m))m=H()f[m]=F F=963330-963329 B=f[Q]G=B B=-192822+192823 w=12076018-862339 K=B B=-745116-(-745116)n=K<B B=F-K else w=Q w=t and 12692986-887450 or 297746+15700225 end else if w<811115+6040196 then S=m j=S k[S]=j w=7674908-(-882529)S=nil else V=f[J[-286413-(-286425)]]U=false i=V==U w=i and 6822108-297713 or 15215065-101368 F=i end end else if w<7363355-394114 then if w<7819791-889783 then w=F and 7699200-457957 or 548404+4870008 else r_=f[o]N_=824234+26805406752024 Y_=f[O]Z_=q(-54909-(-102572))e_=Y_(Z_,N_)b_=r_[e_]d_=O_[b_]Z_=q(-34658-(-81687))N_=16802869467122-768354 r_=f[o]Y_=f[O]e_=Y_(Z_,N_)b_=r_[e_]u_=d_~=b_ w=-93486+8154160 z_=u_ end else O=nil w=12282899-987655 h=nil end end else if w<-816153+8151322 then if w<7336038-165126 then if w<7062498-47991 then o=nil l=nil O=nil F={}a=nil w=P[q(976970+-929945)]h=nil else w=P[q(814852+-767594)]F={}end else w=f[J[-888540+888548]]w=w and 11164467-901761 or-572126+1833890 end else if w<1035689+6333799 then if w<7787785-430595 then a=W[-769957+769958]O=f[J[17407+-17406]]o=W[868277+-868275]h=f[J[-601350+601352]]V=q(1044002-996408)U=3731497407626-(-406079)i=h(V,U)l=O[i]F=a[l]t=9733413130963-835871 h=f[J[-998922+998923]]i=f[J[452201-452199]]U=q(533659-486541)V=i(U,t)O=h[V]l=o[O]w=F<l F={w}w=P[q(-418316-(-465376))]else o=W[-127720-(-127722)]F=-925848-(-925848)a=W[-644718+644719]w=o<F w=w and-555810+9044682 or 293740+7572643 end else i=q(-397387-(-444465))h=P[i]V=f[o]A=12313119195136-(-562789)U=f[O]Q=q(-102393-(-149451))t=U(Q,A)i=V[t]l=h[i]h=q(-95525-(-142934))V=f[o]w=5399496-238204 Q=q(-879620+927028)h=l[h]U=f[O]A=11488119677609-724420 t=U(Q,A)i=V[t]h=h(l,i)l=q(476588+-429085)l=h[l]l=l(h)end end end else if w<8199986-382143 then if w<-661032+8351261 then if w<8464138-860088 then if w<935913+6611562 then B=24257339306140-377981 m=q(518231+-470606)X=f[J[-971066+971067]]k=f[J[195135-195133]]S=k(m,B)A=X[S]m=683107+6097076461236 Q=U[A]S=q(976148-928797)t=Q-a A=f[J[544700+-544699]]X=f[J[543991+-543989]]k=X(S,m)Q=A[k]w=t[Q]t=w w=t<l w=w and-447317+4733026 or 639558+8078247 else w=P[q(821764+-774258)]F={}end else K=q(85730-38106)t=f[J[-215982-(-215991)]]A=f[J[-449748-(-449758)]]w=-17845+12018753 n=16561514781823-(-131489)k=f[J[790345-790334]]m=f[J[796785+-796781]]B=f[J[-522135+522140]]G=B(K,n)S=m[G]X=k[S]k=114169+-114168 Q=t(A,X,k)end else if w<825417+6934259 then if w<7833792-85919 then w=true w=w and 5024343-(-65931)or 2918633-(-727889)else U_=q(202771+-155693)k_=q(416731+-369521)i_=P[U_]U_=q(132116+-84707)X_=f[o]A_=f[O]S_=3253722827792-17957 U_=i_[U_]t_=A_(k_,S_)k_=79610+11466566655457 Q_=X_[t_]U_=U_(i_,Q_)Q_=f[o]m_=21374748337402-130585 t_=q(-587451-(-634741))X_=f[O]w=6037959-(-549646)A_=X_(t_,k_)S_=q(-912213+959735)i_=Q_[A_]V_=U_[i_]i_=-637930-(-637950)N_=V_+i_ V_=H()f[V_]=N_ i_=Z(-312915+15452022,{o;O})Q_=q(626676-579598)N_=H()f[N_]=i_ U_=P[Q_]A_=f[o]Q_=q(195181+-147940)t_=f[O]k_=t_(S_,m_)X_=A_[k_]Q_=U_[Q_]S_=849988+26510632810484 Q_=Q_(U_,X_)k_=q(-967439-(-1015040))X_=f[o]A_=f[O]t_=A_(k_,S_)U_=X_[t_]i_=Q_[U_]U_=q(805945+-758429)U_=i_[U_]Q_=Y(163994+13368554,{M;o;O,V_,N_})N_=z(N_)U_=U_(i_,Q_)V_=z(V_)end else F={}a=nil w=P[q(208085-160752)]end end else if w<8832827-980976 then if w<720863+7127627 then if w<6828124-(-1012753)then U=nil V=nil w=1081934-(-396571)else m=#k n=-335542+335542 w=5188937-(-903002)S=m==n end else w=6408018-972447 end else if w<7780745-(-126590)then if w<8926035-1025952 then w=f[J[-721598+721601]]U=-26138+6879169950365 V=q(893104-845716)O=f[J[822291+-822290]]h=f[J[-482071-(-482073)]]i=h(V,U)l=O[i]i=q(338874-291812)h=P[i]V=f[J[500573+-500572]]U=f[J[-462937-(-462939)]]Q=q(375736-328604)A=-868814+5552567634919 t=U(Q,A)i=V[t]V=w O=h[i]i=o w=o and 653101+4610319 or 111731+10886599 else w=k w=10706572-(-110210)Q=X end else w=3446801-1011949 l=f[J[-974733-(-974739)]]o=l==a F=o end end end end else if w<7732263-(-762455)then if w<-378435+8666031 then if w<460847+7639506 then if w<7837877-(-198662)then if w<343302+7619135 then Q=f[J[904828+-904824]]X=f[J[-675180-(-675185)]]S=f[J[-553447-(-553453)]]B=f[J[30352-30345]]n=q(124273+-77083)G=f[J[-245404-(-245412)]]w=14347733-615506 I=23148221291376-(-790187)K=G(n,I)m=B[K]k=S[m]S=390326-390325 A=Q(X,k,S)else Q=q(511075-463698)k=q(821314+-773944)K=30689453363799-(-124283)t=P[Q]G=q(-322735-(-370297))X=P[k]S=f[J[-278762-(-278769)]]m=f[J[-648954-(-648962)]]M=q(-183325-(-230534))B=m(G,K)k=S[B]A=X[k]S=f[J[-1029329-(-1029338)]]I=18741222537789-(-354266)p=30533831398077-(-959693)B=f[J[706814-706807]]G=f[J[314546-314538]]n=q(-749956-(-797386))K=G(n,I)v=940793+25820780745726 m=B[K]j=q(59721-12497)K=q(-310657+358192)k=S[m]G=P[K]n=f[J[-511028+511035]]I=f[J[397770+-397762]]y=I(j,v)K=n[y]B=G[K]n=f[J[648718-648709]]y=f[J[-678730-(-678737)]]E=q(549933-502678)j=f[J[778918+-778910]]v=j(E,p)I=y[v]P_=18257878290551-732994 s=20565854371037-759669 K=n[I]y=f[J[291591+-291582]]v=f[J[-186166+186173]]E=f[J[-605736+605744]]p=E(M,P_)j=v[p]v=q(-92037-(-139294))P_=q(340867+-293549)I=y[j]Q=q(992105+-944639)j=P[v]Q=t[Q]E=f[J[661976-661969]]p=f[J[506429-506421]]M=p(P_,s)v=E[M]y=j[v]v=926261-926261 E=-1025487+1025486 p=-46539+46539 j=y(v,E,p)n=I+j G=B(K,n)w=470264+13911070 j=682502+25471248434254 K=f[J[898529-898522]]y=q(819036-771365)n=f[J[880238+-880230]]I=n(y,j)B=K[I]m=G[B]B=727939-727935 S=m*B X=A(k,S)A=f[J[-896349+896354]]Q=Q(t,X,A)V=Q end else if w<679723+7383726 then w=h_ w=z_ and 348833+11170971 or 746173+5686631 else K=false G=f[J[378946+-378940]]w=6169688-(-183857)B=G==K S=B end end else if w<-839240+9022414 then if w<7587040-(-572327)then i=W[444193+-444187]O=W[-966789+966793]o=W[288460-288458]h=W[-82014-(-82019)]l=W[57727+-57724]a=W[889983-889982]V=not O w=V and 3681388-460562 or-197332+10749217 F=V else O=f[J[993194+-993193]]l=O[a]i=f[J[527784+-527782]]t=q(-382032+429500)Q=23422644841557-524730 V=f[J[-334670+334673]]U=V(t,Q)h=i[U]O=o[h]F=l[O]w=not F w=w and-544771+1836188 or-31566+11637181 end else t=nil U=l~=t V=w w=U and 13208679-144053 or 12281480-818836 i=U end end else if w<8614730-220523 then if w<8566713-220577 then if w<7633328-(-696219)then i=q(-572465-(-619543))Q=q(244401-197201)h=P[i]V=f[o]A=12912633736994-(-632922)U=f[O]t=U(Q,A)A=28355915262490-439942 i=V[t]l=h[i]V=f[o]h=q(302124-254715)Q=q(241395-193755)U=f[O]t=U(Q,A)h=l[h]i=V[t]h=h(l,i)w=h and 7992632-613719 or 5301758-140466 else a=W[778177-778176]l=W[-388220-(-388223)]o=W[651875+-651873]O=q(-717920+765154)F=P[O]h=f[J[-416804+416805]]t=-140031+33433946709967 i=f[J[108930+-108928]]U=q(371865-324371)V=i(U,t)O=h[V]w=F[O]t=-499496+7204646251586 U=q(997790-950525)h=f[J[-887691-(-887692)]]i=f[J[1021272-1021270]]V=i(U,t)O=h[V]F=w(O)O=F F=f[J[-951960+951961]]U=3107581531536-872425 h=f[J[-899042-(-899044)]]V=q(448870+-401611)i=h(V,U)w=F[i]U=21650895046048-(-516545)F=a V=q(737005-689417)O[w]=F F=f[J[697192+-697191]]h=f[J[710408+-710406]]i=h(V,U)w=F[i]F=o O[w]=F F=f[J[917726+-917725]]h=f[J[-363317+363319]]V=q(-776981+824439)U=-847350+7410741803888 i=h(V,U)o=nil a=nil w=F[i]F=l O[w]=F l=nil F={}w=P[q(-788223+835587)]O=nil end else K=q(470558-423113)G=P[K]K=q(100640+-52966)U=Q B=G[K]G=B(a,U)B=f[J[-428108+428114]]K=B()m=G+K S=m+i m=109813+-109557 K=-539224-(-539225)k=S%m i=k m=l[o]w=323115+5888161 G=i+K B=O[G]S=m..B l[o]=S U=nil end else if w<7576913-(-911378)then if w<-267942+8734473 then u_=b_ w=r_ w=4583951-339151 else w=V w=i and 203045+9937697 or 12344213-629842 end else l=q(-295773-(-342835))F=P[l]O=f[J[1014772+-1014771]]U=-557529+30463653558594 V=q(394167-346863)h=f[J[-466378-(-466380)]]i=h(V,U)l=O[i]w=F[l]F=w(o)o=F w=7617407-(-248976)end end end else if w<9396616-735808 then if w<8770120-200716 then if w<8158380-(-404732)then if w<425183+8118311 then o=f[J[606269+-606267]]w=779686+10442085 l=f[J[883340-883337]]a=o==l F=a else m=m+I S=m<=n j=not y S=j and S j=m>=n j=y and j S=j or S j=6199919-(-607018)w=S and j S=8653057-805807 w=w or S end else w=-1031582+4332714 V=f[J[-211102-(-211106)]]B=q(918717-871419)t=f[J[956108+-956103]]G=-761893+30688372135927 A=f[J[-625239+625245]]k=f[J[-856276+856283]]S=f[J[-277927-(-277935)]]m=S(B,G)X=k[m]Q=A[X]A=503741-503740 U=V(t,Q,A)end else if w<398824+8230641 then if w<7981835-(-618228)then U=true t=false V=false f[J[289234+-289224]]=V f[J[-698115-(-698126)]]=U f[J[874019-874007]]=t A=f[J[398251+-398238]]Q=not A w=Q and 7698047-(-246593)or 16298312-490376 else F=10919342-646252 l=318578+3965559 o=q(-901839-(-949397))a=o^l w=F-a a=w F=q(542453+-495279)w=F/a F={w}w=P[q(-381699+429151)]end else t=true w=4505907-626055 U=f[J[-435210+435223]]V=U==t F=V end end else if w<-34112+8779833 then if w<-256706+8975857 then if w<891103+7796732 then m=B w=G w=411026-(-961581)else w=6792249-(-1039802)t=nil end else Q=f[J[-221104-(-221108)]]X=f[J[962882-962877]]I=22966935513208-491186 S=f[J[-106879+106885]]n=q(117298+-69748)B=f[J[848590-848583]]G=f[J[599333-599325]]K=G(n,I)m=B[K]k=S[m]w=8616825-(-542965)S=-235220+235221 A=Q(X,k,S)end else if w<706516+8110111 then if w<-467815+9235672 then h=q(111405-64185)i=718649+20799519747740 o=f[J[-186938+186941]]l=f[J[-162957-(-162961)]]O=l(h,i)F=o[O]w=a[F]l=f[J[285183+-285180]]O=f[J[-450606+450610]]o=w w=q(563785+-516568)V=20647304431602-(-466332)i=q(367470+-320169)w=o[w]h=O(i,V)F=l[h]w=w(o,F)l=w w=l and 12904107-712206 or 14279040-(-380790)else V=481968+-481967 i=w w=q(465921+-418408)w=O[w]h=l or V w=w(O,h)w=10583786-(-638263)end else k=q(-881105+928511)X=P[k]k=q(358337-311189)A=X[k]w=5217706-(-921004)t=A end end end end end end end else if w<12205801-(-245942)then if w<11318942-435508 then if w<122229+9798954 then if w<9948624-579473 then if w<-1004158+10133561 then if w<817492+8249244 then if w<-923992+9879191 then if w<63685+8881267 then w=7182610-(-379758)else w=f[J[-289865-(-289866)]]F=w()w=P[q(1016302-969221)]F={}end else if w<9673685-692599 then w=f[J[228027+-228015]]F=q(260803-213427)F=w[F]F=F(w)w=5900388-(-637059)else F=true w=10092831-827671 f[J[-23501-(-23513)]]=F i=f[J[69907-69893]]B=4098398933827-609231 U=f[J[-582499-(-582507)]]Q=f[J[1043660+-1043651]]X=f[J[359824+-359822]]k=f[J[393220+-393217]]m=q(-794015+841177)S=k(m,B)A=X[S]t=Q[A]Q=178736-178735 V=i(U,t,Q)end end else if w<-780945+9900695 then if w<9726496-639470 then w=true f[J[782690-782678]]=w F=f[J[354569+-354555]]V=f[J[-513509-(-513517)]]t=f[J[-968482-(-968491)]]m=233283+9661100393039 A=f[J[-1048293-(-1048295)]]X=f[J[-581264+581267]]S=q(613401-566340)w=9946470-681310 k=X(S,m)Q=A[k]U=t[Q]t=-912430+912431 i=F(V,U,t)else w=-982988+1923157 end else h=f[J[-662145-(-662149)]]V=f[J[-74149-(-74151)]]U=f[J[544794-544791]]A=15168280461170-222171 w=-166013+15160729 Q=q(385489+-337922)t=U(Q,A)i=V[t]O=h[i]h=185597+-185597 l=O==h a=l end end else if w<9839609-574854 then if w<9476413-238978 then if w<8626824-(-522701)then w=V w=F and-564787+11813849 or 542647+4472878 else w=489820+4893726 end else a=W[144149+-144148]w=f[J[411121-411120]]A=q(-811722-(-858772))U=q(607302+-560074)X=292010+6323413227222 o=f[J[609521+-609519]]i=-354892+18910255287473 l=f[J[-941978+941981]]h=q(-218582-(-266007))k=30833337447562-(-377739)O=l(h,i)F=o[O]t=17186040290466-408928 l=f[J[474138+-474137]]h=f[J[-662612-(-662614)]]i=f[J[450288-450285]]V=i(U,t)O=h[V]o=l[O]i=f[J[273045-273041]]U=f[J[452140-452138]]t=f[J[195751+-195748]]Q=t(A,X)V=U[Q]h=i[V]U=q(-42483-(-90018))V=P[U]t=f[J[-360645-(-360647)]]Q=f[J[-330743-(-330746)]]X=q(-228149+275327)A=Q(X,k)Q=-265664-(-265664)U=t[A]i=V[U]U=28324-28324 t=-780214+780215.5 V=i(U,t,Q)X=q(171286-123652)O=h*V V=f[J[-14246-(-14251)]]l=q(1002801-955529)h=q(360999+-313511)h=O[h]t=f[J[-507668-(-507670)]]k=23573074260391-100038 Q=f[J[-506222-(-506225)]]A=Q(X,k)U=t[A]A=q(-824944+872282)i=V[U]h=h(O,i)V=q(524263+-477201)X=3448175997919-568730 i=P[V]U=f[J[85956-85954]]t=f[J[-382837-(-382840)]]Q=t(A,X)V=U[Q]O=i[V]V=10516-(-18284)t=-199065-(-199066)U=-781470+781470 i={O(V,U,t)}l=o[l]l=l(o,h,x(i))w[F]=l w=f[J[-679943+679949]]w=w and 703774+11220793 or 15985611-981334 end else if w<8975827-(-324421)then if w<10110711-838719 then V=false i=false f[J[361224-361209]]=i f[J[526041-526025]]=V U=f[J[-821412-(-821419)]]Q=f[J[732755-732747]]X=f[J[992110-992101]]S=f[J[487456-487454]]K=930292+34278275206246 G=q(1619+45952)m=f[J[-323301-(-323304)]]B=m(G,K)K=-232424+22635911787796 G=q(-1027596+1074989)k=S[B]A=X[k]t=U(Q,A)w=793401+6201342 U=f[J[-529764+529771]]Q=f[J[1025523-1025515]]X=f[J[-1001202+1001211]]S=f[J[106451-106449]]m=f[J[27041+-27038]]B=m(G,K)k=S[B]A=X[k]t=U(Q,A)else t=-854765-(-854767)A=-273478+273491 l=-267388-(-267420)o=f[J[218973-218970]]a=o%l w=177805+13450648 O=f[J[521652-521648]]V=f[J[837836-837834]]S=f[J[935219+-935216]]k=S-a S=157591-157559 X=k/S Q=A-X U=t^Q i=V/U A=772350+-772094 h=O(i)O=4295506062-538766 l=h%O h=-379736-(-379738)O=h^a o=l/O U=423580+-423579 a=nil O=f[J[760468-760464]]V=o%U U=-342478+4295309774 i=V*U h=O(i)O=f[J[-954279-(-954283)]]i=O(o)V=838650-773114 l=h+i o=nil t=-101843+102099 h=162540-97004 O=l%h i=l-O h=i/V V=405317+-405061 i=O%V U=O-i V=U/t t=282406+-282150 U=h%t O=nil Q=h-U t=Q/A Q={i;V,U;t}t=nil l=nil U=nil i=nil V=nil f[J[-554145-(-554146)]]=Q h=nil end else F=q(-867217-(-914357))w=P[F]A=-979028+3234675799606 V=f[J[-663437-(-663438)]]Q=q(439154+-391493)U=f[J[-367180-(-367182)]]t=U(Q,A)i=V[t]F={w(i)}w=P[q(-372302+419675)]F={x(F)}end end end else if w<8920308-(-775704)then if w<9387982-(-214468)then if w<-183374+9684357 then if w<-797708+10248547 then F={}w=P[q(-729972+777017)]else w=4490760-11279 k=nil S=nil end else if w<57505+9496081 then y=354577+3942643752474 B=-900700+33666193423257 i=q(-348459+395836)t=q(-577035+624405)h=P[i]S=772445+13864596328411 U=P[t]Q=f[J[155407+-155401]]k=q(-667568-(-714668))A=f[J[656476-656469]]X=A(k,S)w=386422+2840304 K=q(1038118-990946)m=q(212216-164719)t=Q[X]V=U[t]Q=f[J[-250915+250923]]X=f[J[670929+-670923]]k=f[J[-532929-(-532936)]]S=k(m,B)n=-890712+11145131699101 I=q(-481868-(-529437))A=X[S]t=Q[A]S=q(-155022+202557)k=P[S]m=f[J[32062+-32056]]B=f[J[-891736-(-891743)]]G=B(K,n)S=m[G]X=k[S]m=f[J[-719083+719091]]G=f[J[762730+-762724]]j=q(-136584+183802)v=18653841896549-463479 K=f[J[-384585+384592]]n=K(I,y)B=G[n]S=m[B]G=f[J[203764-203756]]n=f[J[618241-618235]]I=f[J[-351310-(-351317)]]y=I(j,v)K=n[y]B=G[K]n=q(794260+-747003)v=q(53635-6155)E=-749491+5335438801255 K=P[n]I=f[J[183744-183738]]y=f[J[-778025+778032]]j=y(v,E)n=I[j]G=K[n]n=1016056-1016056 I=-599931-(-599930)y=-648836+648836 K=G(n,I,y)m=B+K k=X(S,m)K=22555963386001-737162 G=q(856353-809054)S=f[J[-946451+946457]]m=f[J[160613+-160606]]B=m(G,K)X=S[B]i=q(791646+-744180)A=k[X]X=-341111+341115 Q=A*X i=h[i]U=V(t,Q)V=f[J[502188-502184]]i=i(h,U,V)l=i else w=F and 889130+4720233 or 292000-(-308563)end end else if w<-924185+10613885 then if w<-702135+10367697 then t=111397-111142 o=l w=f[J[683419+-683418]]U=261606-261606 V=w(U,t)a[o]=V o=nil w=532709+-288398 else w=S w=k and 15094136-726305 or-763993+10681393 end else O=o X=q(829398-782007)i=f[J[-880717+880719]]t=f[J[869480+-869477]]Q=f[J[-588685+588689]]k=20330496134790-551307 A=Q(X,k)U=t[A]V=h[U]w=i[V]w=w and 3911241-(-390641)or 6262291-(-722151)end end else if w<438938+9422531 then if w<944112+8837844 then if w<-488237+10188334 then l=q(-668177+715239)F=P[l]U=-497461+16990715999772 O=f[J[994131+-994130]]h=f[J[-408761+408763]]V=q(-434600+482183)i=h(V,U)l=O[i]w=F[l]F=w(o)o=F w=1005241+11690376 else F=f[J[-626651+626652]]t=-1007216+33021946813057 U=q(-303920-(-351473))w=F[a]h=f[J[274216+-274214]]i=f[J[-679715-(-679718)]]V=i(U,t)O=h[V]F=o[O]h=q(116238-68684)O=f[J[594348-594347]]h=O[h]h=h(O,a,o)w[F]=h w=-360024-(-967162)end else w=F and-1011127+10708491 or-408509+13104126 end else if w<-939182+10833838 then if w<9388974-(-502864)then w=F and 6502168-703237 or 11638593-143016 else O=f[J[-185472+185473]]o=W[134954+-134952]a=W[820627+-820626]l=W[485759-485756]F=O[a]w=not F w=w and 436664+4279435 or 11124938-780771 end else p=q(-175932+223356)S=false m=false f[J[616838+-616826]]=S f[J[-701601-(-701617)]]=m B=f[J[-107228+107235]]K=f[J[668838+-668830]]I=f[J[-667711+667720]]j=f[J[-852020+852022]]M=32114680776016-(-603418)v=f[J[-232785+232788]]E=v(p,M)y=j[E]n=I[y]G=B(K,n)B=f[J[657831-657824]]K=f[J[371103-371095]]I=f[J[-260825-(-260834)]]j=f[J[-441381-(-441383)]]p=q(1044288+-997115)v=f[J[-113946-(-113949)]]w=6688503-(-306240)M=15817601476466-461485 E=v(p,M)y=j[E]n=I[y]G=B(K,n)end end end end else if w<10143614-(-226325)then if w<10533728-389247 then if w<-871029+10892274 then if w<-615956+10569693 then if w<10287705-361850 then b_=Y_ w=e_ w=296906+8102467 else i=f[h]w=10244453-(-637021)F=i end else if w<10469231-459544 then X=f[J[-81366-(-81375)]]S=f[J[-674429+674439]]B=f[J[-498989+499000]]K=f[J[1036286-1036282]]n=f[J[733182-733177]]j=14099912214757-(-413888)y=q(670057+-622404)I=n(y,j)G=K[I]w=341169+11069461 m=B[G]B=640722-640721 k=X(S,m,B)else w=Q w=t and 48508+14667579 or 1048170+13499902 end end else if w<920740+9219817 then if w<10019504-(-82791)then t=q(-982990+1030556)U=-382484+29011240127193 a=W[834509+-834508]Q=433086+14940480175983 o=q(119374+-72296)F=P[o]o=q(418805+-371564)O=f[J[-5830-(-5831)]]V=q(296368-248740)h=f[J[-550203+550205]]i=h(V,U)o=F[o]l=O[i]V=-165652+10459737102874 o=o(F,l)i=q(46290-(-1378))l=f[J[-731860+731861]]O=f[J[194814+-194812]]h=O(i,V)F=l[h]w=o[F]O=f[J[-292528-(-292531)]]i=f[J[834145-834144]]V=f[J[665087-665085]]F=q(-466561+513797)U=V(t,Q)h=i[U]F=w[F]l=O[h]o=a/l a=nil F=F(w,o)F={}w=P[q(13722+33300)]else w=P[q(-474887+522098)]F={}end else i=false n=30159089386968-413437 V=true f[J[683936-683927]]=i f[J[-506536-(-506546)]]=V U=false f[J[-753796-(-753807)]]=U t=f[J[442846-442843]]A=f[J[-585710-(-585714)]]w=-418533+12132904 k=f[J[392211-392206]]m=f[J[457820+-457814]]K=q(81778-34658)B=f[J[-406861+406868]]G=B(K,n)S=m[G]X=k[S]S=-179664-(-179665)k=-59973-(-59973)Q=t(A,X,k,S)end end else if w<-602151+10865079 then if w<11187114-933235 then if w<11030332-849989 then w=h_ w=z_ and 3985720-(-914137)or 593815+15906171 else y=q(-972986+1020217)j=-510658+19155646672282 K=f[J[656201+-656200]]B=q(-811718+859213)n=f[J[-915451-(-915453)]]I=n(y,j)B=S[B]G=K[I]B=B(S,G)w=B and-1005749+13667210 or-843032+11457305 m=B end else w=P[q(460290-412649)]F={}end else if w<-707254+11057273 then if w<11164174-886360 then w=f[J[137002+-137001]]o=f[J[114386-114384]]l=f[J[-148138-(-148141)]]i=93956+9545631588953 h=q(-680178-(-727257))A=q(-505640-(-553320))O=l(h,i)X=-914673+21478013574146 F=o[O]t=15608970743086-618698 O=q(-192824-(-239886))U=q(314054-266438)l=P[O]h=f[J[-812282-(-812284)]]i=f[J[297173+-297170]]V=i(U,t)O=h[V]o=l[O]i=f[J[48035-48034]]U=f[J[-155005-(-155007)]]t=f[J[-738203-(-738206)]]Q=t(A,X)V=U[Q]h=i[V]O=a*h h=-804883-(-804884)l=o(O,h)w[F]+=l w=11847210-(-438235)else h=f[J[1036663-1036662]]Q=q(604770-557120)O=h[a]A=33163264982295-803013 V=f[J[-278743+278745]]U=f[J[755400-755397]]t=U(Q,A)i=V[t]h=o[i]F=O[h]w=not F w=w and-1017909+10732513 or-368348+975486 end else w=U w=3507774-286948 F=V end end end else if w<344393+10205800 then if w<-412110+10878475 then if w<816526+9641037 then if w<581788+9806075 then X=2322365915723-(-582126)A=q(795545-748078)w=6968323-614069 i=f[J[-260821+260825]]U=f[J[-120391-(-120393)]]t=f[J[-721268+721271]]Q=t(A,X)V=U[Q]h=i[V]i=-946419-(-946419)O=h>i o=O else n=q(-608021-(-655093))w=P[n]n=q(33898+13303)P[n]=w w=13109342-(-108251)end else s=w L=-933761+933762 g=M[L]L=false c=g==L P_=c w=c and 15260888-(-66873)or 337864+10152208 end else if w<10710251-186476 then if w<10523536-38033 then a=q(1073456-1026316)w=P[a]o=f[J[-637763-(-637771)]]l=-861491+861491 a=w(o,l)w=5720788-(-347027)else F=P_ w=s w=719815-575318 end else V=q(-794559-(-841936))Q=q(556649-509279)p=994061+30528882707579 S=q(-624983-(-672339))i=P[V]G=-886118+8442527864001 m=-943845+14090951999622 t=P[Q]A=f[J[-139564-(-139571)]]j=1097875622243-(-620700)E=12000976500299-614519 B=q(-1014082+1061465)X=f[J[-424640+424648]]V=q(178446+-130980)V=i[V]k=X(S,m)Q=A[k]I=16836180105534-(-771425)U=t[Q]A=f[J[697719-697710]]k=f[J[717596-717589]]S=f[J[-73590+73598]]m=S(B,G)X=k[m]m=q(783457-735922)Q=A[X]S=P[m]B=f[J[-292637+292644]]n=q(-183811-(-231071))G=f[J[-84382+84390]]v=q(-21478+69014)y=q(153434+-106364)K=G(n,I)m=B[K]k=S[m]B=f[J[-585142+585151]]K=f[J[970976-970969]]n=f[J[-331134+331142]]I=n(y,j)G=K[I]m=B[G]K=f[J[-624529-(-624538)]]I=f[J[-912395-(-912402)]]y=f[J[-948599+948607]]j=y(v,E)E=q(-912789+960175)n=I[j]G=K[n]I=q(88880-41623)n=P[I]y=f[J[480713-480706]]j=f[J[896188+-896180]]v=j(E,p)I=y[v]K=n[I]y=-478103+478102 I=-706733+706733 j=-425259+425259 w=404263+-247028 n=K(I,y,j)B=G+n S=k(m,B)K=q(-263597-(-311099))n=6048023221788-(-963812)m=f[J[112983+-112976]]B=f[J[-826224+826232]]G=B(K,n)k=m[G]X=S[k]k=325782+-325778 A=X*k t=U(Q,A)U=f[J[1027929-1027924]]V=V(i,t,U)O=V end end else if w<11350159-579770 then if w<11440142-833473 then if w<9977275-(-591803)then B=17092480936062-(-669337)A=q(936864+-889385)Q=P[A]m=q(-870413+917757)U=w A=Q(O)X=f[J[-457478-(-457479)]]k=f[J[-952965+952967]]S=k(m,B)Q=X[S]t=A~=Q V=t w=t and 10637459-270724 or-989560+15742975 else G=-549631+10273005712814 V=-983614-(-983615)F=f[J[368163+-368158]]h=a i=h-V w=F[i]B=q(858930-811750)i=f[J[-776760+776765]]F=i[h]t=-928041+928042 V=f[J[1015819-1015814]]U=h+t i=V[U]t=H()V=w U=H()f[U]=F f[t]=i A=f[J[-904453+904454]]k=f[J[-646601+646603]]S=f[J[-466066+466069]]m=S(B,G)X=k[m]Q=A[X]i=not Q w=i and 213457+1363001 or 8627198-(-955219)F=i end else w=m and 12108779-(-567213)or-260124+9742490 end else if w<658619+10193500 then if w<-414031+11211811 then j=27273994378796-650384 s=q(-199645+247299)E=q(429709+-382623)m=q(277935-230565)X=q(809988+-762611)n=q(-331391-(-378418))A=P[X]I=15734050376144-978226 S=P[m]B=f[J[263895+-263891]]p=33082114964883-573798 G=f[J[-870615-(-870620)]]K=G(n,I)m=B[K]k=S[m]y=q(-759817-(-807170))B=f[J[-680647+680653]]K=f[J[-892372-(-892376)]]n=f[J[-225188-(-225193)]]I=n(y,j)M=q(-923029+970233)G=K[I]I=q(977438+-929903)m=B[G]n=P[I]P_=1673577475928-(-332723)y=f[J[190551-190547]]j=f[J[-993019-(-993024)]]v=j(E,p)I=y[v]K=n[I]y=f[J[-670163+670169]]v=f[J[-734166-(-734170)]]c=717242+12713260852582 g=14571813043065-991480 E=f[J[519148-519143]]p=E(M,P_)j=v[p]I=y[j]v=f[J[427208+-427202]]p=f[J[841523+-841519]]M=f[J[812879-812874]]P_=M(s,c)X=q(-718463-(-765929))E=p[P_]c=q(749162+-701699)j=v[E]p=q(295614-248357)E=P[p]w=12746261-(-512707)M=f[J[78714+-78710]]P_=f[J[-117487+117492]]s=P_(c,g)p=M[s]v=E[p]P_=-594809-(-594809)p=619821+-619821 M=771676-771677 X=A[X]E=v(p,M,P_)y=j+E E=125416+1704057166129 n=K(I,y)v=q(-219827-(-267010))I=f[J[-466073-(-466077)]]y=f[J[-85729+85734]]j=y(v,E)K=I[j]G=n[K]K=-311827+311831 B=G*K S=k(m,B)k=f[J[547107-547097]]X=X(A,S,k)t=X else U=Q w=A w=726791-428784 end else V=q(-957925+1004987)i=F F=P[V]V=q(293976+-246816)w=F[V]U=q(776409-729003)V=H()f[V]=w F=P[U]U=q(-42032+89542)X=q(-514017+561423)w=F[U]U=w Q=w A=P[X]w=A and 73074+8835990 or 5320486-(-818224)t=A end end end end end else if w<12314785-673267 then if w<10858460-(-441068)then if w<11110132-(-108322)then if w<604897+10406748 then if w<-542330+11491375 then if w<11863348-941297 then F={}w=P[q(215052-167893)]else t=w A=795035+-795034 Q=O>A w=Q and 13287408-(-153318)or-151858-(-449865)U=Q end else if w<9978907-(-1019727)then w=-421899+5685319 S=q(166116+-118552)t=f[J[-404428+404431]]A=f[J[763150+-763149]]X=f[J[-1023382-(-1023384)]]m=-520583+25515134771184 k=X(S,m)Q=A[k]U=t[Q]i=U else i=-926676+29406059567441 h=q(-633966+681164)a=W[889040-889039]w=f[J[647621+-647620]]o=f[J[-588790-(-588792)]]l=f[J[-143169+143172]]O=l(h,i)F=o[O]o=a a=nil w[F]=o w=P[q(298038+-250473)]F={}end end else if w<10191914-(-1016247)then if w<10659655-(-506262)then Q=true t=false f[J[-1019197+1019209]]=t f[J[-137371+137384]]=Q A=false f[J[246637+-246623]]=A k=f[J[847037+-847022]]X=not k w=X and 6002710-1035216 or 15375650-288843 else w=f[J[818508+-818507]]a=f[J[585112+-585110]]O=q(193831+-146451)h=-77945+9148166553884 o=f[J[-993095-(-993098)]]l=o(O,h)F=a[l]a=false w[F]=a w=P[q(611406-564254)]F={}end else B=B+K I=not n F=B<=G F=I and F I=B>=G I=n and I F=I or F I=15085492-216132 w=F and I F=13732660-444695 w=w or F end end else if w<11612975-374342 then if w<209419+11020369 then if w<11206253-(-15747)then w=F and 11672009-83932 or-570555+15808789 else w=P[q(321175+-273961)]F={O}end else I=17982814628930-(-78963)X=q(-996863-(-1044240))j=11265166718016-(-172093)A=P[X]m=q(611561+-564191)S=P[m]y=q(-510710-(-558395))w=7110419-927270 B=f[J[442044+-442040]]n=q(-369709+416978)p=30251451112797-829015 G=f[J[-631254+631259]]K=G(n,I)E=q(-220606-(-268197))g=-1033729+5218724614015 X=q(-906150+953616)m=B[K]k=S[m]B=f[J[-1022897-(-1022903)]]K=f[J[-51942+51946]]n=f[J[565793-565788]]I=n(y,j)G=K[I]I=q(-871215+918750)m=B[G]X=A[X]n=P[I]y=f[J[61201+-61197]]j=f[J[-796609-(-796614)]]P_=-490078+34386739804394 v=j(E,p)I=y[v]M=q(943996+-896582)K=n[I]y=f[J[386579+-386573]]v=f[J[-196071-(-196075)]]E=f[J[-497640-(-497645)]]p=E(M,P_)j=v[p]s=q(791243-743745)I=y[j]v=f[J[-900743-(-900749)]]p=f[J[51378+-51374]]c=16246309248759-(-933526)M=f[J[-607927-(-607932)]]P_=M(s,c)E=p[P_]c=q(250587-203372)p=q(-238142+285399)j=v[E]E=P[p]M=f[J[181852-181848]]P_=f[J[-621109+621114]]s=P_(c,g)p=M[s]v=E[p]p=854577+-854577 M=-162536-(-162535)P_=512528+-512528 E=v(p,M,P_)v=q(-600307+647602)y=j+E n=K(I,y)I=f[J[-227787+227791]]y=f[J[-308749-(-308754)]]E=346266+22678537871526 j=y(v,E)K=I[j]G=n[K]K=804976+-804972 B=G*K S=k(m,B)k=f[J[-392293-(-392303)]]X=X(A,S,k)t=X end else if w<565303+10729541 then if w<222180+11051293 then t=q(-314252-(-361769))U=P[t]k=q(-585386+632422)S=5001259529139-371355 Q=f[J[734250+-734249]]A=f[J[820456+-820454]]X=A(k,S)t=Q[X]V=U[t]k=26395431024625-(-145426)w=5898703-883178 t=f[J[283011-283010]]Q=f[J[-884938-(-884940)]]X=q(736476+-689325)A=Q(X,k)U=t[A]F=V[U]h=F else l=true m=q(776307-729200)O=false h=false f[J[-983465+983474]]=l f[J[-193961-(-193971)]]=O f[J[-706822+706833]]=h i=f[J[620545-620542]]w=-675808+12390179 U=f[J[-208317-(-208321)]]Q=f[J[827028+-827023]]X=f[J[-720818+720824]]B=-282289+1671711609275 k=f[J[-1018929+1018936]]S=k(m,B)A=X[S]t=Q[A]Q=595025-595025 A=-324703-(-324704)V=i(U,t,Q,A)end else o,h=l(a,o)w=o and 9387829-(-303696)or 12503212-(-348807)end end end else if w<-613903+12087915 then if w<244401+11156555 then if w<10316835-(-998296)then if w<11265420-(-42700)then w=f[J[-402505+402506]]F=w()F={}w=P[q(686926+-639900)]else w=o w=-284161+14678870 F=a end else m=q(-950275-(-997645))X=q(234161+-186784)n=q(-595661+643173)A=P[X]X=q(595312-547846)S=P[m]B=f[J[-594664-(-594670)]]I=28056830936086-(-323314)g=147398+26380564230198 G=f[J[-629823-(-629830)]]s=q(-81871-(-129356))K=G(n,I)m=B[K]y=q(832512-785328)k=S[m]B=f[J[735919-735911]]K=f[J[607653+-607647]]n=f[J[927237+-927230]]j=27319091272795-(-5462)E=q(791061+-743770)I=n(y,j)G=K[I]m=B[G]I=q(-118123-(-165658))n=P[I]p=-231710+19785508220187 y=f[J[-25034-(-25040)]]j=f[J[566467-566460]]v=j(E,p)c=29023147965071-(-621115)I=y[v]K=n[I]y=f[J[1008445+-1008437]]M=q(663392-616245)P_=-382899+7444271588669 v=f[J[365171+-365165]]E=f[J[833487-833480]]X=A[X]p=E(M,P_)j=v[p]I=y[j]v=f[J[-870387-(-870395)]]p=f[J[-973862+973868]]M=f[J[591943-591936]]P_=M(s,c)E=p[P_]p=q(-157439-(-204696))j=v[E]E=P[p]M=f[J[587161+-587155]]c=q(-636092-(-683343))P_=f[J[310086+-310079]]s=P_(c,g)p=M[s]M=834568-834569 v=E[p]P_=459821+-459821 w=118425+9897431 p=236511+-236511 E=v(p,M,P_)v=q(-62470-(-109695))y=j+E E=28990+20341961765826 n=K(I,y)I=f[J[-821968-(-821974)]]y=f[J[-412202+412209]]j=y(v,E)K=I[j]G=n[K]K=606810+-606806 B=G*K S=k(m,B)k=f[J[140986-140982]]X=X(A,S,k)t=X end else if w<12025803-577654 then if w<11764247-348461 then w=12631021-88895 else j=q(491189-443628)m=q(-532011-(-579388))s=-563120+25391863498208 E=q(-607694+655148)K=q(-905073+952443)P_=q(847770-800408)S=P[m]v=6679981558088-(-918238)G=P[K]n=f[J[-856776-(-856782)]]I=f[J[426815+-426808]]y=I(j,v)K=n[y]B=G[K]n=f[J[400633+-400625]]y=f[J[-999202-(-999208)]]j=f[J[-691162-(-691169)]]p=17538617088965-588766 c=q(570026+-522616)g=-1043959+17825114328675 L=q(-633222-(-680699))v=j(E,p)w=30864+4654623 I=y[v]T=8861332152599-(-110343)v=q(208446+-160911)K=n[I]j=P[v]C=21481260407318-(-216316)E=f[J[-283421+283427]]p=f[J[186281+-186274]]M=p(P_,s)v=E[M]y=j[v]E=f[J[-396902-(-396910)]]M=f[J[783223+-783217]]P_=f[J[-791491+791498]]s=P_(c,g)p=M[s]v=E[p]M=f[J[534436-534428]]s=f[J[39518-39512]]c=f[J[388161-388154]]g=c(L,C)P_=s[g]p=M[P_]s=q(-515528-(-562785))P_=P[s]C=q(472155-425117)c=f[J[-1010631-(-1010637)]]m=q(-356231-(-403697))g=f[J[49587-49580]]L=g(C,T)s=c[L]c=729858-729859 M=P_[s]s=-931005-(-931005)g=149307-149307 P_=M(s,c,g)E=p+P_ P_=-513276+23160551849756 j=y(v,E)v=f[J[-535374-(-535380)]]E=f[J[57214+-57207]]M=q(-858809+906379)p=E(M,P_)y=v[p]I=j[y]y=1005350+-1005346 n=I*y G=B(K,n)B=f[J[941951+-941947]]m=S[m]m=m(S,G,B)X=m end else w=V F=i w=-933685+7342378 end end else if w<433200+11100147 then if w<11594054-72842 then if w<836243+10659959 then w=f[J[542146-542135]]Q=f[U]B=591825+18656695425566 m=q(-840849+888431)X=f[J[-251770-(-251772)]]F=q(417598-370222)k=f[J[279220+-279217]]S=k(m,B)A=X[S]F=w[F]i=Q[A]F=F(w,i)w=11557525-(-849597)else h_=f[o]b_=q(-255913+303431)w=5478491-(-954313)r_=-204659+17943222960150 u_=f[O]d_=u_(b_,r_)z_=h_[d_]e_=q(-664075-(-711155))b_=q(-760873+808421)h_=972935-972934 O_[z_]=h_ h_=f[o]u_=f[O]r_=15128946251078-(-312894)d_=u_(b_,r_)z_=h_[d_]d_=q(-576038+623234)u_=P[d_]Z_=-278631+24390507490500 b_=f[o]r_=f[O]Y_=r_(e_,Z_)d_=b_[Y_]b_=593018+-592848 h_=u_[d_]d_=-747049-(-747219)r_=-659703-(-659873)u_=h_(d_,b_,r_)O_[z_]=u_ end else w=10206642-1046852 Q=f[J[-158537+158541]]X=f[J[-169150+169155]]n=q(-246280+293805)S=f[J[192632-192626]]B=f[J[-818658+818665]]I=24233867082161-839069 G=f[J[-583521-(-583529)]]K=G(n,I)m=B[K]k=S[m]S=-446846-(-446847)A=Q(X,k,S)end else if w<135005+11458345 then if w<12139133-560078 then t=f[J[664780+-664771]]K=q(-562897-(-610517))A=f[J[-852852+852862]]k=f[J[80862+-80851]]n=617196+27751118456718 m=f[J[-802536+802540]]B=f[J[949663-949658]]G=B(K,n)S=m[G]w=15834498-(-476724)X=k[S]k=-879240+879241 Q=t(A,X,k)else U=q(-732005+779487)F=q(207564-160157)O=q(584530-537512)t=b(-849394+14336737,{})w=P[F]a=f[J[-604260-(-604264)]]l=P[O]V=P[U]U={V(t)}i={x(U)}V=871745+-871743 h=i[V]O=l(h)l=q(-686124-(-733280))o=a(O,l)a={o()}F=w(x(a))a=F o=f[J[368093+-368088]]F=o w=o and 7765577-(-157859)or 2985341-550489 end else l=f[J[-195962-(-195963)]]F=l[a]h=f[J[-498714+498716]]U=q(314464+-267238)i=f[J[-714989+714992]]t=-464876+32074206696003 a=nil V=i(U,t)O=h[V]l=o[O]w=F[l]F=q(-207765+254832)o=nil F=w[F]F=F(w)F={}w=P[q(770124+-722534)]end end end end else if w<-943260+12911355 then if w<11248326-(-558113)then if w<11143240-(-593808)then if w<-541196+12221916 then if w<880607+10782063 then w=f[J[-549538-(-549539)]]h=q(-24623+72212)a=W[336228-336227]i=-466927+31095875573887 o=f[J[-530052+530054]]l=f[J[-516849+516852]]O=l(h,i)F=o[O]o=a a=nil w[F]=o w=P[q(-69217-(-116340))]F={}else G=nil B=l~=G m=w w=B and-93160+8186105 or 577104+5776441 S=B end else if w<-616292+12329644 then X=f[J[-172329-(-172334)]]S=f[J[-780264-(-780267)]]G=q(-713893-(-761492))K=3078517395492-(-865653)n=22173276572798-435241 m=f[J[769145-769141]]B=m(G,K)k=S[B]A=X[k]K=q(-947700-(-995251))k=f[J[-211459+211460]]m=f[J[1019450-1019447]]B=f[J[-431363-(-431367)]]G=B(K,n)S=m[G]w=13300071-259452 X=k[S]Q=A-X X=f[J[939746-939740]]K=-1003038+17965503868619 S=f[J[-367115-(-367118)]]m=f[J[-805578+805582]]G=q(192437-145215)B=m(G,K)k=S[B]A=X[k]t=Q/A V=t else w=507168+7055200 o=nil end end else if w<11478191-(-295748)then if w<-548513+12305382 then O=f[J[736995-736994]]h=f[J[-244740-(-244742)]]V=q(-934711-(-982133))U=31087244736554-(-229474)i=h(V,U)l=O[i]F=a[l]Q=q(-1030912+1078486)i=q(542599+-495082)h=P[i]V=f[J[86581+-86580]]U=f[J[-883028-(-883030)]]A=18278624896710-(-965241)t=U(Q,A)i=V[t]O=h[i]i=f[J[544363-544362]]V=f[J[464980-464978]]Q=34791753239344-1035239 t=q(-185059+232652)U=V(t,Q)h=i[U]l=O[h]w=F==l w=w and 839790+11343867 or 531519+14603538 else F={}o=nil w=P[q(-891924-(-939339))]end else t=true f[J[544335+-544319]]=t Q=f[J[-83501-(-83515)]]I=30037467893983-(-42436)X=f[J[699094+-699086]]n=q(885726-838372)S=f[J[-52476-(-52485)]]w=-1002088+17000059 B=f[J[454888-454886]]G=f[J[-497685-(-497688)]]K=G(n,I)m=B[K]k=S[m]S=433658-433657 A=Q(X,k,S)end end else if w<12359565-490344 then if w<12403418-557710 then if w<11219860-(-612584)then Q=q(-444281-(-491883))w=true f[J[-175934+175935]]=w F=true f[J[-959074+959076]]=F a=f[J[-778169+778172]]l=-40801-(-40804)o=a(l)a=f[J[-47825-(-47829)]]m=-885242+13692703709922 l=f[J[761886-761881]]h=f[J[333787-333781]]V=f[J[568928-568921]]A=22191297891100-598719 U=f[J[824424+-824416]]t=U(Q,A)U=912692+3558447995205 i=V[t]O=h[i]V=q(-16025+63436)h=576370-576369 o=a(l,O,h)O=f[J[-282056-(-282063)]]h=f[J[-657867+657875]]i=h(V,U)l=O[i]a=o[l]S=q(-868111+915532)l=q(-81772-(-129008))l=a[l]l=l(a)l=false a=false f[J[3106-3105]]=a f[J[122280+-122278]]=l t=f[J[-986863+986872]]A=f[J[-772101-(-772108)]]X=f[J[604500+-604492]]h=w k=X(S,m)Q=A[k]k=q(-107588+154694)U=t[Q]Q=f[J[954257+-954250]]A=f[J[430222+-430214]]S=4950148020364-77707 X=A(k,S)t=Q[X]V=U[t]U=-402887-(-402888)i=V<U O=i w=i and 104318+12395183 or 5576626-701214 else w=12192287-434113 end else U=q(454543+-406945)X=-118055+24262569785673 t=18472+15880017564858 o=W[87466-87464]a=W[-206401+206402]l=W[165459-165456]k=q(-310487+357733)w=q(-793822+841039)O=l w=o[w]h=f[J[249898+-249897]]i=f[J[829247+-829245]]V=i(U,t)F=h[V]w=w(o,F)h=H()f[h]=w A=q(-404027+451270)S=-136901+18059199510430 i=f[h]U=f[J[903207+-903206]]t=f[J[126608-126606]]Q=t(A,X)V=U[Q]F=i[V]t=q(584058+-536541)U=P[t]Q=f[J[-485684-(-485685)]]A=f[J[-103268-(-103270)]]X=A(k,S)t=Q[X]V=U[t]t=f[J[423550+-423549]]Q=f[J[-626857-(-626859)]]X=q(927801+-880139)k=1032186+27942125892313 A=Q(X,k)U=t[A]i=V[U]w=F~=i w=w and 8759060-(-565025)or-838363+7326078 end else if w<11548219-(-378229)then if w<12155273-236955 then i=10533044572690-982762 h=q(391415-343940)w=true V=53328+14963778128616 f[J[673858+-673857]]=w F=f[J[849412-849410]]o=true a=F(o)a=q(-538047+585172)B=9779039214332-(-751309)F=f[J[-784900+784903]]U=20330403721682-117975 m=q(-673195-(-720694))a=F[a]a=a(F)o=f[J[326409-326405]]l=f[J[713007-713002]]O=l(h,i)l=q(-794863-(-842240))X=q(707577+-660423)F=o[O]i=q(22289-(-25371))o=P[l]a[F]=o l=f[J[-525120-(-525124)]]O=f[J[-980161-(-980166)]]k=-567269+16201729377629 n=368449+1421299426132 h=O(i,V)F=q(3478+44053)F=a[F]o=l[h]V=q(-778875+826519)F=F(a,o)O=f[J[864795+-864791]]h=f[J[-684380-(-684385)]]i=h(V,U)l=O[i]o=F F=q(-300341+347872)V=q(-49311+96995)U=535906+24778513907632 F=a[F]F=F(a,l)O=f[J[869094+-869090]]h=f[J[324781-324776]]i=h(V,U)l=F K=q(565171-517584)U=q(1010121-962586)F=O[i]V=P[U]t=f[J[-453655+453659]]Q=f[J[792314-792309]]A=Q(X,k)U=t[A]i=V[U]Q=f[J[28791-28785]]X=f[J[-566596+566600]]k=f[J[698424+-698419]]S=k(m,B)A=X[S]t=Q[A]k=f[J[128727+-128721]]m=f[J[1030150+-1030146]]B=f[J[-729389+729394]]G=B(K,n)S=m[G]X=k[S]G=q(850747-803659)K=10006426441810-17951 S=f[J[-730848-(-730852)]]m=f[J[-163573+163578]]B=m(G,K)k=S[B]A=X[k]X=-401182.5-(-401185)Q=A*X m=q(-4990-(-52002))U=t+Q Q=f[J[219118-219112]]X=f[J[-783846+783850]]k=f[J[-440391+440396]]B=19690503712422-(-324907)S=k(m,B)A=X[S]t=Q[A]S=16403925471184-881146 V=i(U,t)t=q(-934403-(-981938))k=q(-684249-(-731417))U=P[t]Q=f[J[714829-714825]]A=f[J[19596+-19591]]X=A(k,S)t=Q[X]k=4981143740075-447900 i=U[t]Q=540397-540397 A=-514445+514442.75 m=q(-113355+160691)t=741090-741090 U=i(t,Q,A)h=V*U X=q(-378546-(-425947))U=q(775358-727823)V=P[U]t=f[J[-871459+871463]]Q=f[J[522745+-522740]]A=Q(X,k)U=t[A]A=q(408067-361005)i=V[U]Q=P[A]U=268051+-268051 G=-182234+20486135262493 X=f[J[-380022-(-380026)]]k=f[J[-542031-(-542036)]]B=-151021+10151645552740 S=k(m,B)A=X[S]t=Q[A]A=-698900+699080 Q=t(A)t=-837158-(-837158)V=i(U,Q,t)k=5297873786653-134522 t=926497+23476170082194 O=h*V S=678635+34660684473377 X=815950+8077306076003 o[F]=O F=f[J[-270536+270543]]h=f[J[899089+-899085]]U=q(1023588+-976138)i=f[J[-565004+565009]]V=i(U,t)O=h[V]h=l F[O]=h U=q(442587-395240)t=681308+33037973870268 F=f[J[42556-42549]]h=f[J[-799501-(-799505)]]i=f[J[-996607+996612]]V=i(U,t)O=h[V]U=q(-12680+59934)h=f[J[-38370+38378]]F[O]=h F=f[J[-936634+936641]]t=285943+2286364288817 h=f[J[853561-853557]]A=q(-682570-(-730237))i=f[J[-68168+68173]]V=i(U,t)O=h[V]V=q(-983796+1031331)i=P[V]U=f[J[-737471+737475]]t=f[J[523537+-523532]]Q=t(A,X)V=U[Q]h=i[V]X=q(196990-149664)t=108496-108496 V=674628-674628 U=-799220+799220 i=h(V,U,t)F[O]=i F=f[J[82353-82344]]h=f[J[358651-358641]]V=f[J[-610033+610044]]t=f[J[887778-887774]]Q=f[J[736027+-736022]]A=Q(X,k)U=t[A]i=V[U]V=-530474-(-530475)O=F(h,i,V)F=f[J[-1028001-(-1028010)]]X=q(-841105-(-888594))V=f[J[-917325-(-917336)]]k=31309512427824-(-733123)t=f[J[773036+-773032]]Q=f[J[-1010360-(-1010365)]]A=Q(X,k)U=t[A]i=V[U]Q=q(394733+-347426)B=q(309584-262265)V=928226+-928225 h=F(a,i,V)V=f[J[-557874+557878]]U=f[J[166424+-166419]]A=-118507+34457871404440 t=U(Q,A)i=V[t]F=h[i]i=q(-432017+479253)A=25639836019207-572260 i=F[i]i=i(F)F=q(891361-843858)F=o[F]Q=q(339248-291911)F=F(o)V=f[J[-231036+231040]]U=f[J[802928-802923]]t=U(Q,A)i=V[t]k=q(378316-331293)F=O[i]i=q(-588718-(-635954))i=F[i]i=i(F)A=27980702104806-(-570879)F=f[J[643358-643351]]V=f[J[-146113+146117]]Q=q(-750307+797926)U=f[J[-855006+855011]]t=U(Q,A)i=V[t]V=f[J[742186+-742180]]F[i]=V Q=q(1027815-980368)F=f[J[623059+-623052]]V=f[J[-813454-(-813458)]]A=2947519212300-632240 U=f[J[230908+-230903]]t=U(Q,A)i=V[t]A=-790808+17365506650286 V=f[J[-371118+371126]]F[i]=V F=f[J[-878464-(-878471)]]Q=q(-697969-(-745373))V=f[J[-359075-(-359079)]]U=f[J[-270472+270477]]t=U(Q,A)i=V[t]t=q(-415895+463430)U=P[t]Q=f[J[-474228+474232]]A=f[J[556984-556979]]X=A(k,S)t=Q[X]V=U[t]A=-762638-(-762638)t=669738-669738 Q=921383+-921398 U=V(t,Q,A)F[i]=U U=false F=q(-739428-(-786931))F=a[F]F=F(a)F=false f[J[-918668-(-918669)]]=F i=f[J[975906+-975904]]V=i(U)V=w A=f[J[81520+-81514]]k=f[J[-1043093-(-1043097)]]S=f[J[-684020-(-684025)]]m=S(B,G)X=k[m]B=-736584+7572997442318 m=q(-152943-(-200188))Q=A[X]X=f[J[-220659-(-220663)]]k=f[J[-853104+853109]]S=k(m,B)A=X[S]t=Q[A]Q=-328539-(-328540)U=t<Q i=U w=U and 16174460-(-360409)or 829050+13190927 else w=f[J[398900+-398893]]o=f[J[-316268+316276]]O=f[J[87816+-87807]]Q=-61697+12790772254789 t=q(272157+-224865)i=f[J[498786-498784]]V=f[J[1002571-1002568]]U=V(t,Q)t=q(-100380+147852)h=i[U]l=O[h]F=w(o,l)w=f[J[-537071-(-537078)]]Q=17454274221347-(-346780)o=f[J[-614492-(-614500)]]O=f[J[227660-227651]]i=f[J[-499520-(-499522)]]V=f[J[253967-253964]]U=V(t,Q)Q=-1026750+14672850994542 h=i[U]l=O[h]F=w(o,l)w=f[J[-276402+276409]]t=q(-1021596+1068712)o=f[J[570102-570094]]O=f[J[-593329-(-593338)]]i=f[J[-1032050-(-1032052)]]V=f[J[-404932+404935]]U=V(t,Q)h=i[U]l=O[h]F=w(o,l)w=-878812+15883089 end else F=q(541526-494386)a=q(-253260-(-300585))w=P[F]F=w(a)F={}w=P[q(-342237+389272)]end end end else if w<-401517+12675067 then if w<13075539-927610 then if w<44987+11956466 then if w<-990999+12992107 then w=13044477-502351 else o=w O=f[J[953557-953556]]i=f[J[181169+-181167]]V=f[J[654674-654671]]t=q(154855+-107506)Q=-685113+16276891406804 U=V(t,Q)h=i[U]l=O[h]a=l w=l and 11792621-477964 or-561398+14207707 end else w=F and 69448+11137283 or 1004917-(-7948)end else if w<-797461+12987118 then if w<12254396-75231 then F=f[J[439714-439712]]w=not F f[J[-435040+435042]]=w F={}w=P[q(-559076-(-606723))]else w=f[J[-158890-(-158893)]]F=w()w=14148135-(-986922)end else t=2054251134795-899983 O=q(843832+-796780)F=P[O]h=f[J[-796582+796585]]U=q(794085-746789)i=f[J[-967600-(-967604)]]V=i(U,t)O=h[V]h=q(968010+-920914)w=F[O]O=P[h]F=w(a,O)w=14988920-329090 end end else if w<211206+12194141 then if w<25866+12263072 then if w<982234+11303942 then w=P[q(133197+-86126)]a=nil F={}else w=f[J[747238-747228]]o=f[J[691787-691776]]a[w]=o w=f[J[-955009-(-955021)]]o={w(a)}w=P[q(-178701-(-225845))]F={x(o)}end else n=-232974+20462827942726 t=f[J[-56295-(-56304)]]A=f[J[-546600+546610]]k=f[J[185036+-185025]]m=f[J[-602702-(-602706)]]w=-796609+17107831 B=f[J[220751-220746]]K=q(150469-102962)G=B(K,n)S=m[G]X=k[S]k=-254863-(-254864)Q=t(A,X,k)end else if w<-267821+12716288 then if w<-144501+12563406 then V=nil h=nil t=z(t)w=3835323-(-519347)U=z(U)else K=397269+-397268 n=-656250-(-656256)w=f[V]G=w(K,n)w=q(-857535-(-904607))n=q(337890+-290818)P[w]=G K=P[n]n=943169-943167 w=K>n w=w and 13944713-829471 or 10480786-78641 end else w=P[q(-804437-(-851630))]F={}end end end end end end else if w<-782705+14993286 then if w<-363216+13490231 then if w<955351+11798905 then if w<-653130+13265735 then if w<733170+11787917 then if w<731251+11767763 then if w<-262277+12744638 then w=Y(4524750-39246,{O})G={w()}w=P[q(247527+-199946)]F={x(G)}else n=633877+-633877 m=#k S=m==n w=S and 5593016-(-699674)or 6379776-287837 end else if w<13544519-1033848 then I=-454967+23096306277178 V=q(491135+-443758)i=P[V]n=q(208338-161246)Q=q(-133860+181230)m=18687395678949-207080 t=P[Q]S=q(-578804-(-626480))A=f[J[787652+-787645]]j=61844+28371649790471 X=f[J[-759594-(-759602)]]G=650484+2898837280849 k=X(S,m)Q=A[k]E=912706+30014930864470 B=q(402607+-355534)U=t[Q]A=f[J[707642-707633]]k=f[J[-1010910+1010917]]S=f[J[399675+-399667]]m=S(B,G)X=k[m]Q=A[X]y=q(-445520-(-493171))m=q(-156696+204231)S=P[m]B=f[J[690137+-690130]]G=f[J[-893317-(-893325)]]K=G(n,I)m=B[K]k=S[m]B=f[J[188502+-188493]]K=f[J[249993+-249986]]n=f[J[-961818-(-961826)]]p=929587+34278382653223 I=n(y,j)v=q(-19293-(-66812))G=K[I]m=B[G]K=f[J[-1043117-(-1043126)]]I=f[J[617655-617648]]y=f[J[96740-96732]]j=y(v,E)n=I[j]G=K[n]I=q(-614093+661350)E=q(-202200-(-249341))n=P[I]y=f[J[34842+-34835]]j=f[J[-918814+918822]]v=j(E,p)w=4613304-(-262108)I=y[v]j=-601414+601414 V=q(434905+-387439)K=n[I]I=521446-521446 y=134555+-134556 n=K(I,y,j)B=G+n n=-723761+4659623138218 S=k(m,B)V=i[V]m=f[J[-586591+586598]]K=q(-213277-(-260857))B=f[J[835494-835486]]G=B(K,n)k=m[G]X=S[k]k=-770762+770766 A=X*k t=U(Q,A)U=f[J[531098-531093]]V=V(i,t,U)O=V else l=w i=f[J[873806+-873805]]U=f[J[-838694-(-838696)]]X=30235853188470-(-166281)t=f[J[576338+-576335]]A=q(586951+-539936)Q=t(A,X)V=U[Q]h=i[V]O=not h w=O and-878354+11263895 or-865983+7220237 o=O end end else if w<12339436-(-221140)then if w<12240203-(-302355)then o=nil w=P[q(-823692-(-870868))]l=nil a=nil h=nil F={}O=nil else I=f[J[-982673-(-982674)]]K=q(751182-703687)G=w v=q(-590346+637594)y=f[J[-999964+999966]]K=S[K]E=137977+27270111106721 j=y(v,E)n=I[j]K=K(S,n)B=K w=K and 9402484-715009 or 17170469-804436 end else V=q(-434937-(-482374))O=f[J[881904+-881903]]Q=q(169821-122716)U=18481905228841-440971 h=f[J[-988217-(-988219)]]i=h(V,U)A=5513152193013-38894 l=O[i]F=a[l]i=q(672671+-625154)h=P[i]V=f[J[-653088+653089]]U=f[J[-805583+805585]]t=U(Q,A)Q=7824710081696-544357 i=V[t]t=q(-611770-(-659055))O=h[i]i=f[J[566922-566921]]V=f[J[-96744+96746]]U=V(t,Q)h=i[U]l=O[h]w=F==l w=w and 16636178-800367 or 3098384-(-223589)end end else if w<-441569+13104081 then if w<12487352-(-140395)then if w<-817983+13437203 then o=W[190310-190308]w=f[J[-63670-(-63671)]]l=w a=W[-190242-(-190243)]w=l[o]w=w and 991666+15340667 or 189237+16402829 else w=775804+10437875 p=z(p)I=z(I)y=z(y)v=z(v)E=z(E)j=z(j)M=nil end else G=q(-1004108+1051517)G=o[G]I=f[J[-534982-(-534983)]]y=f[J[-104048-(-104050)]]v=q(-247228-(-294641))E=1577621602303-(-410335)j=y(v,E)n=I[j]K=S[n]n=true w=-375571+10989844 G=G(o,K,n)B=not G m=B end else if w<13228915-511790 then if w<792119+11897220 then w=q(457825-410322)w=S[w]w=w(S)w=9636474-154108 else w=f[J[428291-428288]]O=f[J[-56345+56346]]V=q(1018796-971772)U=22856357589848-(-554555)h=f[J[223180-223178]]a=nil i=h(V,U)l=O[i]i=q(460807+-413745)h=P[i]A=-480372+19097764738865 V=f[J[-668434+668435]]Q=q(290019-242735)U=f[J[651533+-651531]]t=U(Q,A)i=V[t]V=w U=-485616-(-485796)O=h[i]V=346558+-346557 t=27964459544549-1047816 i=o or U U=673556+-673376 h=O(i,V,U)w[l]=h l=f[J[-9280+9283]]U=q(-343552-(-390911))h=f[J[99365+-99364]]i=f[J[1028302-1028300]]V=i(U,t)O=h[V]h=false l[O]=h l=f[J[-572761-(-572764)]]U=q(668108+-620551)h=f[J[555290+-555289]]F={}i=f[J[-141143+141145]]t=29355095817577-198660 V=i(U,t)O=h[V]Q=-786566+32157404150532 h=true l[O]=h h=q(792469-745256)O=P[h]i=f[J[731720+-731719]]V=f[J[390399+-390397]]t=q(-644079-(-691693))U=V(t,Q)h=i[U]w=P[q(-752878-(-799997))]l=O[h]h=d(1288528-(-456744),{J[354336-354333],J[171677+-171676];J[-786301+786303];J[421117+-421113]})O=l(h)Q=-185174+11123253880721 t=q(117441+-70225)h=q(336360-289147)O=P[h]i=f[J[-271562+271563]]V=f[J[-363609+363611]]U=V(t,Q)h=i[U]o=nil l=O[h]h=r(1370389-196532,{J[330040-330037];J[401926-401925],J[479229-479227],J[590998-590994];J[233870+-233865];J[423522-423516],J[-560953+560960],J[-658544-(-658552)],J[543484-543475],J[-824076-(-824086)];J[-695+706];J[-910031-(-910043)]})O=l(h)end else U=true V=false t=false f[J[138215-138205]]=V f[J[820001+-819990]]=U f[J[653980+-653968]]=t A=f[J[1035411+-1035398]]Q=not A w=Q and 8606782-(-115972)or 10671230-(-858124)end end end else if w<12260637-(-687907)then if w<-930918+13755537 then if w<12039956-(-770878)then if w<11933276-(-856233)then h,U=i(O,h)w=h and 14403003-(-561193)or 3202566-470668 else U=f[J[-322311+322323]]i=w t=false V=U==t w=V and 896916+7752096 or 199999+3679853 F=V end else w=q(-369276+416343)w=U[w]w=w(U)w=5064504-899439 end else if w<218244+12701803 then if w<70705+12781613 then w=P[q(-905296+952875)]F={}else w=f[J[-403093-(-403094)]]w=w and 131543+4046777 or 11713283-(-449746)end else w=421315+3084465 G=A==X B=G end end else if w<13159878-65561 then if w<-482457+13546241 then if w<-642015+13657504 then o_=f[o]h_=228278+18146157651275 u_=74491+9684254289570 z_=q(-730682+778032)l_=f[O]O_=l_(z_,h_)H_=o_[O_]f_=l[H_]H_=q(-790695+838226)h_=q(-425498-(-472936))l_=f[o]O_=f[O]z_=O_(h_,u_)o_=l_[z_]r_=-963625+11182078724224 u_=678414+27116093167428 H_=f_[H_]b_=q(-941310+988379)H_=H_(f_,o_)U_=19397787239567-958791 V_=q(-846414+893523)f_=H()f[f_]=H_ Y_=q(335154-288063)h_=q(1049686-1002148)H_=f[f_]l_=f[o]O_=f[O]z_=O_(h_,u_)O_=q(147987+-100909)o_=l_[z_]l_=P[O_]h_=f[o]u_=f[O]d_=u_(b_,r_)z_=h_[d_]O_=q(1045215-997974)O_=l_[O_]O_=O_(l_,z_)H_[o_]=O_ l_=f[f_]i_=30755844088723-(-1037406)z_=f[o]b_=11472344266091-(-401267)h_=f[O]d_=q(515169-467566)u_=h_(d_,b_)O_=z_[u_]o_=l_[O_]u_=q(650282-602795)O_=f[o]d_=10125751645605-(-433350)z_=f[O]h_=z_(u_,d_)e_=26569355945912-(-936092)l_=O_[h_]h_=q(681349+-634214)u_=129500758538-131534 H_=o_[l_]l_=f[o]b_=7482120642521-(-847299)O_=f[O]z_=O_(h_,u_)d_=q(306129-258608)o_=l_[z_]z_=f[o]h_=f[O]u_=h_(d_,b_)O_=z_[u_]d_=f[o]b_=f[O]r_=b_(Y_,e_)Y_=q(-215986-(-263030))u_=d_[r_]h_=I[u_]d_=f[o]b_=f[O]e_=-107576+31465941474676 r_=b_(Y_,e_)u_=d_[r_]z_=h_..u_ u_=q(-466073-(-513745))l_=O_..z_ H_[o_]=l_ o_=f[f_]d_=-272016+6599479259793 O_=f[o]z_=f[O]h_=z_(u_,d_)l_=O_[h_]H_=o_[l_]O_=q(309817+-262583)b_=950720+29479484191711 l_=P[O_]z_=f[o]h_=f[O]d_=q(1009179+-961556)u_=h_(d_,b_)O_=z_[u_]r_=q(760579-712962)o_=l_[O_]z_=f[o]h_=f[O]b_=35028751231004-272485 d_=q(1633+45466)u_=h_(d_,b_)Y_=29929443089854-(-940210)O_=z_[u_]z_=f[M]l_=o_(O_,z_)d_=-554143+34701027308477 u_=q(831553+-784442)t_=30925+10001372780900 O_=f[o]z_=f[O]h_=z_(u_,d_)o_=O_[h_]z_=q(-133168+180476)O_=P[z_]u_=f[o]d_=f[O]b_=d_(r_,Y_)h_=u_[b_]z_=O_(h_)l_[o_]=z_ d_=30121788504903-(-359299)O_=f[o]z_=f[O]u_=q(235435+-188016)h_=z_(u_,d_)o_=O_[h_]O_=663568-663567 d_=-353182+4890344877187 l_[o_]=O_ u_=q(-487131+534717)O_=f[o]z_=f[O]h_=z_(u_,d_)z_=e(32737-(-53073),{U,o;O})o_=O_[h_]O_=true l_[o_]=O_ o_=q(-922113+969626)o_=l_[o_]o_=o_(l_)O_=b(-497497+10391837,{U,o;O})o_=H()f[o_]=O_ u_=Z(13240516-(-840173),{j,n;L,o_;p,A,o,O;M,m;Q;X,k})O_=H()f[O_]=z_ r_=Z(4559041-(-864282),{j;C;a_;o,O;M;R_;q_;o_,p,A,m;Q;X,k})h_=Y(-795283+2005033,{j;n,L;o_,p;A,o;O,M,m,Q,X;k})z_=H()f[z_]=h_ d_=b(-241820+16157896,{j,C,a_,o;O,M,R_,q_;o_;p,A;m;Q,X;k})h_=H()f[h_]=u_ u_=H()f[u_]=d_ d_=H()b_=u(-138697+3322729,{j,k,o_,p;A,o;O,M,m,Q;X})f[d_]=b_ b_=H()f[b_]=r_ e_=f[o]Z_=f[O]N_=Z_(V_,i_)i_=q(420120+-373078)Y_=e_[N_]r_=I[Y_]Z_=f[o]Y_=q(720376+-672845)Q_=32976862788590-(-98318)Y_=r_[Y_]N_=f[O]V_=N_(i_,U_)i_=q(-519781-(-566800))e_=Z_[V_]Y_=Y_(r_,e_)Z_=f[o]N_=f[O]r_=q(-901381+948912)U_=389043+3630228838119 V_=N_(i_,U_)r_=Y_[r_]e_=Z_[V_]i_=q(728606-681559)r_=r_(Y_,e_)Z_=f[o]N_=f[O]Y_=q(-579276-(-626807))U_=288074+30029344018773 V_=N_(i_,U_)U_=9853249545136-(-77372)e_=Z_[V_]Y_=r_[Y_]Y_=Y_(r_,e_)i_=q(861036+-813720)r_=q(-336810+384219)X_=q(14421-(-33249))Z_=f[o]r_=Y_[r_]N_=f[O]V_=N_(i_,U_)i_=q(820909+-773744)e_=Z_[V_]U_=31610932795067-875836 r_=r_(Y_,e_)Z_=f[o]N_=f[O]V_=N_(i_,U_)U_=q(318410+-270959)e_=Z_[V_]N_=f[o]V_=f[O]i_=V_(U_,Q_)Z_=N_[i_]U_=27218756005150-506780 r_[e_]=Z_ A_=-1005369+24703684690984 i_=q(1013783-966619)Z_=f[o]N_=f[O]V_=N_(i_,U_)Q_=-679772+11224675218374 e_=Z_[V_]r_=v[e_]e_=q(-496354+543870)e_=r_[e_]Z_=Z(5759762-915469,{o,O,z_,h_,u_,d_,b_,j;S})e_=e_(r_,Z_)U_=q(-272741-(-320313))r_=H()f[r_]=e_ N_=f[o]V_=f[O]i_=V_(U_,Q_)Z_=N_[i_]e_=v[Z_]N_=e(104917+14191055,{o;O;S})Z_=q(-205371+252887)Z_=e_[Z_]Z_=Z_(e_,N_)e_=H()f[e_]=Z_ i_=f[o]U_=f[O]Q_=U_(X_,A_)A_=-768018+17274509268862 V_=i_[Q_]N_=H_[V_]X_=q(909398-862345)i_=f[o]U_=f[O]Q_=U_(X_,A_)V_=i_[Q_]Z_=N_[V_]V_=Z(959241+351955,{z_})X_=q(739990-692708)A_=391737+32510093459689 N_=q(-564984+612500)N_=Z_[N_]N_=N_(Z_,V_)i_=f[o]U_=f[O]Q_=U_(X_,A_)V_=i_[Q_]X_=q(-822402-(-869528))A_=-167873+20606556730684 N_=H_[V_]i_=f[o]U_=f[O]Q_=U_(X_,A_)V_=i_[Q_]Z_=N_[V_]N_=q(402389-354873)X_=q(112709+-65319)N_=Z_[N_]V_=Y(4143290-(-1020347),{h_})A_=368761763120-(-510843)N_=N_(Z_,V_)i_=f[o]U_=f[O]Q_=U_(X_,A_)V_=i_[Q_]X_=q(724794-677523)N_=H_[V_]i_=f[o]U_=f[O]A_=-972130+32117474922445 Q_=U_(X_,A_)V_=i_[Q_]Z_=N_[V_]V_=d(12090021-789892,{d_})A_=33810855085625-(-685895)N_=q(-68561-(-116077))X_=q(-170416+217852)N_=Z_[N_]N_=N_(Z_,V_)i_=f[o]U_=f[O]Q_=U_(X_,A_)A_=791388+25430410959589 V_=i_[Q_]X_=q(-954145+1001487)N_=H_[V_]i_=f[o]U_=f[O]Q_=U_(X_,A_)A_=12974811020603-107938 X_=q(-927915+974978)V_=i_[Q_]Z_=N_[V_]V_=d(9872850-919911,{u_})N_=q(8546+38970)N_=Z_[N_]N_=N_(Z_,V_)i_=f[o]U_=f[O]Q_=U_(X_,A_)A_=49832+17108388404342 V_=i_[Q_]N_=H_[V_]i_=f[o]X_=q(-370055+417582)U_=f[O]Q_=U_(X_,A_)V_=i_[Q_]Z_=N_[V_]N_=q(-295429-(-342945))V_=d(-904542+13757917,{j,S})N_=Z_[N_]N_=N_(Z_,V_)V_=f[o]Q_=q(-434425+481627)A_=q(-215104+262365)X_=30943563396931-(-508166)i_=f[O]U_=i_(Q_,X_)N_=V_[U_]Z_=w_[N_]N_=q(-300988-(-348504))V_=e(-728594+14826057,{n;p,o,O})N_=Z_[N_]N_=N_(Z_,V_)V_=q(236143-189065)N_=P[V_]U_=f[o]Q_=f[O]V_=q(-719971-(-767212))V_=N_[V_]X_=Q_(A_,t_)A_=788567+25444961019377 i_=U_[X_]V_=V_(N_,i_)i_=f[o]X_=q(687680-640414)U_=f[O]t_=254101203707-682629 Q_=U_(X_,A_)N_=i_[Q_]Z_=V_[N_]N_=q(-624684+672200)V_=u(683774+8578904,{g,o,O,M,E,j;O_,p,A,S;L,m,k,o_,Q;X})N_=Z_[N_]i_=q(-30304+77850)N_=N_(Z_,V_)Z_=H()f[Z_]=N_ V_=P[i_]i_=V_()A_=q(321530-273895)U_=f[o]Q_=f[O]X_=Q_(A_,t_)V_=U_[X_]N_=i_[V_]w=N_ and 504231+7250917 or 1000645+5586960 else w=U U=-287262+287262.5 K=q(15720+31550)i=V or U G=11293141935574-(-814772)V=f[J[228048+-228041]]w=490887+6493555 Q=f[J[-694723+694725]]n=-34683+8885894158244 B=q(-619477-(-667098))k=f[J[-688652+688655]]S=f[J[-236265-(-236269)]]m=S(B,G)X=k[m]A=h[X]t=Q[A]X=f[J[-217197-(-217205)]]m=f[J[-123153-(-123156)]]B=f[J[-488694-(-488698)]]G=B(K,n)S=m[G]k=h[S]A=X[k]K=-227190+23401321325063 S=f[J[-73932-(-73935)]]G=q(-944965-(-992438))m=f[J[400414+-400410]]B=m(G,K)k=S[B]X=h[k]Q=A*X k=f[J[-357589+357592]]S=f[J[-657699+657703]]G=-68796+206095256859 B=q(-657239-(-704624))K=25876608864631-(-761242)m=S(B,G)X=k[m]A=h[X]G=q(217324+-169828)S=f[J[-869543+869546]]m=f[J[259102+-259098]]B=m(G,K)k=S[B]X=h[k]k=f[J[604088+-604079]]U=V(t,Q,i,A,X,k)i=nil end else t=f[J[632664+-632658]]Q=false U=t==Q i=U w=563716+10898928 end else if w<-267292+13388727 then if w<381332+12738175 then I=q(-138337-(-185538))K=q(-803713-(-850731))w=P[K]n=P[I]K=w(n)w=q(300006+-252934)P[w]=K w=12763176-(-454417)else F={}w=P[q(-216996+264317)]end else h=q(-546789+593853)l=P[h]k=q(553852-506721)V=f[o]A=-195234+29178609872821 S=-169717+10627887622729 U=f[O]w=8080490-(-223688)Q=q(788898-741375)t=U(Q,A)i=V[t]U=q(-849738+896816)V=P[U]Q=f[o]A=f[O]X=A(k,S)t=Q[X]Q=q(-573737+620770)Q=V[Q]U={Q(V,t)}h=l(i,x(U))end end end end else if w<13362320-(-263228)then if w<13590507-348753 then if w<14105996-924762 then if w<866543+12303577 then if w<-405674+13563032 then K=491530+12141743412747 U=w G=q(-457663+505044)X=f[J[923557+-923548]]S=f[J[767909+-767902]]m=f[J[454998+-454990]]B=m(G,K)k=S[B]A=X[k]G=34378+31525668598542 k=f[J[1030969+-1030962]]S=f[J[-1037223+1037231]]B=q(778769-731401)m=S(B,G)X=k[m]Q=A[X]A=70508+-70507 t=Q>A w=t and-669104+8642428 or 13580515-(-800819)V=t else w=true w=12115141-(-350114)end else if w<13901552-726325 then w=344945-166407 else w=k w=X and 430135+2962870 or 428420+6566323 end end else if w<12658810-(-568787)then if w<13068051-(-144551)then w=P[q(1037317+-989687)]F={}else w=-360674+5796245 end else w=k w=X and 5353143-(-365675)or 1549079-949630 end end else if w<234436+13239919 then if w<13495173-68325 then if w<14308705-1024266 then w=Q w=t and-265654+11295677 or-904337+1844506 else G=f[o]B=G w=G and 12075530-(-849394)or 3371821-(-133959)end else A=w k=nil X=l~=k Q=X w=X and-454376+4564890 or 9859763-(-957019)end else if w<-306293+13858969 then if w<641412+12870356 then o=q(-200027+247623)l=4126294-(-673406)F=746728+92627 a=o^l w=F-a F=q(-498759-(-545807))a=w w=F/a F={w}w=P[q(137359-90245)]else o=f[J[607643-607642]]O=f[J[811590-811588]]h=f[J[-570193+570196]]V=q(-767144-(-814533))U=65446+13004025075713 i=h(V,U)l=O[i]a=o[l]l=f[J[153252-153250]]O=f[J[334257+-334254]]V=31485687896909-1008136 i=q(-525984+573521)h=O(i,V)o=l[h]F=a[o]a=f[J[-592197+592201]]w=F<a w=w and 697683+4313970 or 12573052-(-1047482)end else w=P[q(921805-874160)]F={}end end end else if w<14962158-990742 then if w<388493+13342093 then if w<13850093-152583 then if w<13231742-(-400637)then l=q(-172421+219827)w=P[q(995867+-948554)]o=P[l]l=q(371786+-324143)a=o[l]l=f[J[-1047522-(-1047523)]]o={a(l)}F={x(o)}else h=f[J[39964+-39960]]V=f[J[-52532-(-52534)]]U=f[J[-898941+898944]]A=-166888+15168280405887 Q=q(999411-951844)w=10711544-(-603113)t=U(Q,A)i=V[t]O=h[i]h=-184628-(-184628)l=O==h a=l end else U=true f[J[369618-369602]]=U t=f[J[193444+-193430]]n=-170585+21206786949356 A=f[J[413296+-413288]]k=f[J[980954-980945]]m=f[J[-170595+170597]]B=f[J[-71254+71257]]K=q(909154+-861516)G=B(K,n)w=16479658-481687 S=m[G]X=k[S]k=-652792+652793 Q=t(A,X,k)end else if w<580702+13269543 then if w<13788620-55192 then w=-409135+12167309 else o=f[J[-872306-(-872309)]]l=667388-667241 a=o*l o=1012140+-1011883 F=a%o f[J[-649532-(-649535)]]=F w=-449230+644636 end else w=f[J[69539-69529]]w=w and 14770966-(-81902)or 829863+2535889 end end else if w<160861+13986938 then if w<-686448+14781528 then if w<14434138-406513 then w=V w=i and 748993-374840 or 16954939-212071 else w=f[J[736554-736553]]w=w and 7121177-(-11080)or 6770409-936739 end else a=W[835798+-835797]F=f[J[-631217-(-631218)]]w=not F w=w and 540819+13779506 or 15295900-(-651793)end else if w<13344686-(-835016)then if w<198304+13965178 then w=f[J[-12760-(-12761)]]F={}w[a]=F w=467766+7706528 else Z_=15165848824102-937360 h_=w b_=f[o]u_=q(-150768+198263)f_=l_ e_=q(43391-(-3722))r_=f[O]Y_=r_(e_,Z_)u_=O_[u_]d_=b_[Y_]u_=u_(O_,d_)z_=u_ w=u_ and 115930+10047423 or-110026+4891336 end else X=f[J[-20893-(-20902)]]S=f[J[-367372+367382]]B=f[J[914862+-914851]]y=q(1025599+-978123)j=958728+7505087212702 K=f[J[189662-189658]]n=f[J[43643-43638]]I=n(y,j)w=11081858-(-328772)G=K[I]m=B[G]B=-552833-(-552834)k=X(S,m,B)end end end end end else if w<-668627+16005977 then if w<-855095+15654976 then if w<13732671-(-774519)then if w<15203802-835664 then if w<-685051+14983947 then if w<15215362-964607 then c=-740216-(-740217)s=M[c]P_=s w=619116+5854864 else U=q(206119+-158875)a=W[-85871+85872]t=-520780+24646895165217 h=f[J[135672-135671]]X=412946+24637045104574 i=f[J[-924474+924476]]V=i(U,t)O=h[V]l=a[O]V=q(-255029-(-302546))A=q(719153-671748)i=P[V]U=f[J[-490671+490672]]t=f[J[-74063+74065]]Q=t(A,X)V=U[Q]Q=q(-357980-(-405616))h=i[V]V=f[J[-371393+371394]]U=f[J[-40704+40706]]A=30622459857694-(-961685)t=U(Q,A)i=V[t]O=h[i]o=l==O w=o and 811351+4941491 or-701815+16828056 F=o end else if w<13583647-(-773250)then w=P[q(432719-385635)]F={}else k=true f[J[946498+-946483]]=k v=q(-807559+854704)S=f[J[438778-438764]]B=f[J[695986-695978]]K=f[J[-819686+819695]]I=f[J[-524134-(-524136)]]y=f[J[-639451+639454]]E=-918126+18252433646497 j=y(v,E)n=I[j]w=-812983+10730383 G=K[n]K=-256965+256966 m=S(B,G,K)end end else if w<-220196+14695183 then if w<13501422-(-890981)then w=U w=V and-759527+9334381 or-1047992+12806166 else w=-871862+1884727 end else l=f[J[-531385-(-531386)]]a=W[-448767+448768]h=f[J[-599284-(-599286)]]U=q(112676-65365)t=17459893577143-1033717 i=f[J[-975765-(-975768)]]V=i(U,t)O=h[V]o=l[O]F=o w=o and-292992+12810190 or 16945071-558402 end end else if w<14768566-103588 then if w<14635169-(-23090)then if w<13606099-(-1033487)then v=-528353+3674019927695 j=q(548961+-501849)G=f[J[166115+-166107]]k=w n=f[J[232489-232483]]I=f[J[-318404+318411]]y=I(j,v)K=n[y]B=G[K]j=908798+26910041608948 K=f[J[-764819+764825]]y=q(-488728+535866)n=f[J[643776+-643769]]I=n(y,j)G=K[I]m=B[G]B=806579-806578 S=m>B X=S w=S and-712927+12160286 or 2717+4682770 else n=q(469031+-421999)Q=w S=f[J[-672257-(-672263)]]B=f[J[-284959-(-284963)]]I=-315653+3155467638466 G=f[J[-327675+327680]]K=G(n,I)m=B[K]K=q(347804+-300303)k=S[m]m=f[J[664292-664288]]B=f[J[232840-232835]]n=1170020021324-766508 G=B(K,n)S=m[G]X=k[S]k=-975489-(-975490)A=X>k t=A w=A and 9882077-(-904103)or 14190826-931858 end else w=P[q(-470844-(-517986))]l=nil o=nil F={}a=nil end else if w<-941429+15684178 then if w<14269889-(-449588)then t=true A=false f[J[828354+-828345]]=t Q=false f[J[367867-367857]]=Q f[J[351544-351533]]=A X=f[J[159105-159102]]j=31855562100149-480196 S=f[J[523319-523315]]B=f[J[499187+-499182]]y=q(974612-927325)K=f[J[874742+-874736]]n=f[J[566523+-566516]]I=n(y,j)w=378817+8548980 G=K[I]m=B[G]G=-379893+379894 B=314761-314761 k=X(S,m,B,G)else V=false i=true f[J[603716-603704]]=i U=false f[J[96670+-96657]]=V f[J[-628253-(-628267)]]=U Q=f[J[999072+-999057]]t=not Q w=t and 10969293-(-584882)or 451703+11865472 end else X=f[J[231314+-231313]]m=q(102667-54992)B=32761033898639-851704 w=-1031318+11398053 k=f[J[89158-89156]]S=k(m,B)A=X[S]K=-528774+30902910290364 Q=O[A]k=q(-211681+259198)X=P[k]S=f[J[-780793+780794]]m=f[J[994427-994425]]G=q(-450312+497358)B=m(G,K)k=S[B]A=X[k]t=Q~=A V=t end end end else if w<191621+14889034 then if w<-196127+15183541 then if w<14809609-(-63394)then if w<120753+14740527 then w=f[J[420548-420537]]o=-598252-(-598317)F=w(o)w=-632091+4832943 else I=H()j=186747-186647 y=q(-689255-(-736317))f[I]=B M=-695229+695231 F=P[y]y=q(-13818+60978)w=F[y]y=163214+-163213 v=583544-583289 F=w(y,j)y=H()C=718541-718541 f[y]=F j=-517385-(-517385)w=f[V]F=w(j,v)j=H()v=754681+-754680 T=883121+-873121 c=q(626619+-579601)f[j]=F w=f[V]p=-258345+258346 E=f[y]F=w(v,E)v=H()f[v]=F F=f[V]E=F(p,M)F=-997568-(-997569)w=E==F E=H()f[E]=w F=q(-267723-(-314879))s=P[c]g=f[V]w=q(980332-932666)L={g(C,T)}M=q(381720-334391)c=s(x(L))s=q(-954416-(-1001745))P_=c..s p=M..P_ w=S[w]M=q(-62375-(-109857))w=w(S,F,p)p=H()f[p]=w F=P[M]P_=r(1692545-(-866945),{V,I,Q,l;o,m,E;p,y,v,j;t})M={F(P_)}w={x(M)}M=w w=f[E]w=w and-278115+638842 or-556272+5381422 end else A=f[J[-497306+497308]]V=h m=358057+2704456388162 S=q(652740+-605132)X=f[J[733903-733900]]k=X(S,m)Q=A[k]t=o[Q]w=V~=t w=w and 12688979-(-132316)or-76892+4241957 end else if w<16051087-981677 then if w<227394+14772856 then F=a w=o w=-830426+12834337 else F=f[J[542012+-542006]]w=not F w=w and 14352945-391589 or-336396+3345529 end else o=f[J[-450424-(-450429)]]O=q(699595-652513)w=-814547+13099992 O=o[O]O=O(o)end end else if w<-709353+15847171 then if w<-160150+15280019 then if w<-332032+15423985 then j=570236+12897690018809 X=f[J[803656-803647]]S=f[J[227992+-227982]]y=q(518395-470905)B=f[J[-508010-(-508021)]]K=f[J[-627126-(-627130)]]n=f[J[-30576-(-30581)]]I=n(y,j)w=8175382-(-940201)G=K[I]m=B[G]B=-758010-(-758011)k=X(S,m,B)else w=F and 853641+8213865 or 1028931+11776337 end else Q=q(-530929+578289)O=f[J[-757163-(-757164)]]V=q(-754045-(-801424))U=13204299755439-546731 h=f[J[-519743+519745]]i=h(V,U)l=O[i]F=a[l]A=-454479+25061649931493 i=q(-1003213+1050730)h=P[i]V=f[J[363791-363790]]U=f[J[865381-865379]]t=U(Q,A)i=V[t]O=h[i]t=q(221600-174545)i=f[J[-923779+923780]]V=f[J[-1027936+1027938]]Q=16041709033909-(-33657)U=V(t,Q)h=i[U]l=O[h]w=F==l w=w and-944334+4014415 or 11747264-(-843056)end else if w<-520738+15839680 then if w<15257511-58788 then l=q(-85607-(-132669))w=nil o=w a=W[-232145-(-232146)]V=q(-991798+1039159)F=P[l]U=1039656+23827173641775 O=f[J[-871846-(-871847)]]h=f[J[-960633+960635]]i=h(V,U)l=O[i]V=q(-421764-(-469141))U=q(-982727+1029767)w=F[l]F=q(726337+-679307)l=w w=P[F]i=P[V]U=i[U]V={U(i)}i={w(x(V))}h=i[957919-957916]F=i[437139+-437138]O=i[-582810-(-582812)]i=F w=2370495-891990 else w=f[J[-854701-(-854708)]]w=w and 11104480-622706 or 5767204-(-300611)end else L=-166200-(-166202)g=M[L]L=f[p]c=g==L P_=c w=551204+9938868 end end end end else if w<-292091+16607729 then if w<15360099-(-637565)then if w<16015560-142882 then if w<478421+15215115 then if w<790888+14709695 then t=q(-1156-(-48505))o=w O=f[J[-1044699+1044700]]i=f[J[-361115+361117]]V=f[J[-573268-(-573271)]]Q=-1014753+16276891736444 U=V(t,Q)h=i[U]l=O[h]w=l and 14050478-(-944238)or-581490+9703304 a=l else l_,O_=H_(o_,l_)w=l_ and 511610+13660484 or 365844+12602385 end else if w<212231+15623544 then Q=f[J[-522776+522780]]w=-117325+13849552 X=f[J[-730369+730374]]S=f[J[892918-892912]]B=f[J[719775+-719768]]I=87957+18544745597478 n=q(-418994-(-466463))G=f[J[810818-810810]]K=G(n,I)m=B[K]k=S[m]S=530063+-530062 A=Q(X,k,S)else w=f[J[699536-699531]]F=w()w=2882404-(-439569)end end else if w<726255+15240584 then if w<739384+15193000 then w=f[J[231453-231452]]w=w and 13907792-786842 or 2388823-644219 else w=q(-285798+333077)F=f[J[-94229+94231]]w=a[w]w=w(a,F)w=w and 77616+10048230 or 443006+8308358 end else F=q(-942491-(-989558))w=P[F]F=w()w=f[J[690955-690954]]F=q(-462778-(-509860))F=w[F]F=F(w)w=f[J[721156-721154]]F=q(-778679-(-825761))F=w[F]F=F(w)w=f[J[652586+-652583]]F=q(320759-273677)F=w[F]F=F(w)w=f[J[-500889-(-500893)]]F=q(486079+-438576)F=w[F]F=F(w)w=P[q(-480427+527751)]F={}end end else if w<15972613-(-163379)then if w<16917474-811420 then if w<634200+15423365 then Q=false y=q(614452-567121)f[J[-812551+812563]]=Q A=false f[J[-554064+554079]]=A X=f[J[-648788-(-648795)]]j=8251059446626-(-469920)w=6551790-(-442953)S=f[J[63866+-63858]]B=f[J[-152429+152438]]K=f[J[-859405+859407]]n=f[J[-431885+431888]]I=n(y,j)y=q(145465+-98037)G=K[I]m=B[G]k=X(S,m)X=f[J[-863401-(-863408)]]S=f[J[127792-127784]]B=f[J[361949+-361940]]K=f[J[350255+-350253]]j=-353185+6669719924674 n=f[J[238603-238600]]I=n(y,j)G=K[I]m=B[G]k=X(S,m)else a=f[J[-570034-(-570035)]]F=#a a=315550+-315550 w=F==a w=w and 4601501-77575 or 13473906-(-154547)end else h=f[J[-401997+401998]]i=f[J[-107760-(-107762)]]U=q(555499-508016)t=-106631+28277123978230 V=i(U,t)O=h[V]V=q(373336-325819)l=a[O]A=q(-861291+908943)X=19482018222667-503515 i=P[V]U=f[J[769512-769511]]w=181721+5571121 t=f[J[894464-894462]]Q=t(A,X)V=U[Q]Q=q(211578+-164221)h=i[V]V=f[J[272466+-272465]]A=5291338501240-148185 U=f[J[586380-586378]]t=U(Q,A)i=V[t]O=h[i]o=l==O F=o end else if w<17029616-732734 then if w<849982+15368145 then B=f[J[-22881-(-22882)]]I=-658323+26584365136878 n=q(-65202-(-112259))G=f[J[279407-279405]]K=G(n,I)m=B[K]w=929888+3993318 y=-280901+6867579475394 S=o[m]m=q(-894017+941426)I=q(-740399+787946)G=f[J[268698+-268697]]K=f[J[-652166+652168]]n=K(I,y)B=G[n]m=S[m]m=m(S,B)X=m else h=q(820219+-773179)F=q(-436491-(-483521))w=P[F]l=f[J[-874456+874457]]h=l[h]O={h(l)}l={w(x(O))}a=l[427459+-427457]F=l[1037418+-1037417]o=l[-296861+296864]l=F w=-85513+11380757 end else w=-211687+1151856 end end end else if w<15686471-(-852629)then if w<17094774-692652 then if w<289935+16081813 then if w<16344059-(-14058)then w=6864997-242691 else I=f[J[-57284+57285]]v=q(-868848-(-916189))y=f[J[266439-266437]]E=20557488012757-(-862095)K=q(589803-542308)w=8457081-(-230394)j=y(v,E)n=I[j]K=S[K]K=K(S,n)B=K end else w=F and 10689189-421359 or 15568837-498735 end else if w<440040+16067980 then if w<16143347-(-306075)then F=U w=t w=22602+9115395 else u_=q(-515590+563085)h_=w e_=q(-646562-(-694073))b_=f[o]r_=f[O]u_=O_[u_]Z_=-648112+33953025712498 Y_=r_(e_,Z_)d_=b_[Y_]u_=u_(O_,d_)z_=u_ w=u_ and 6212291-(-738029)or 7306333-(-754341)end else K=q(656040+-608991)X=q(886919-839549)t=q(122873-75496)U=P[t]A=P[X]G=749940+17301425581572 k=f[J[36985-36981]]B=q(558826-511170)S=f[J[-287430+287435]]m=S(B,G)X=k[m]E=5277604806317-(-772844)v=q(126584-79332)p=q(-773075-(-820315))Q=A[X]k=f[J[754329+-754323]]y=q(-169942-(-217037))n=6783022627227-(-971451)m=f[J[-763707-(-763711)]]B=f[J[-359476-(-359481)]]G=B(K,n)S=m[G]G=q(727405+-679870)X=k[S]B=P[G]j=16434328289408-(-679268)K=f[J[-863983+863987]]n=f[J[949923+-949918]]I=n(y,j)G=K[I]m=B[G]M=486438+15635874295883 K=f[J[-378659-(-378665)]]w=-1002035+15022012 I=f[J[329081-329077]]y=f[J[130008+-130003]]j=y(v,E)n=I[j]G=K[n]I=f[J[-546752+546758]]j=f[J[611701-611697]]v=f[J[-503091-(-503096)]]P_=442535+26967372132454 E=v(p,M)y=j[E]n=I[y]j=q(658708+-611451)y=P[j]M=q(-163317-(-210451))v=f[J[159393+-159389]]E=f[J[-625629+625634]]p=E(M,P_)E=-721050+721050 t=q(351471+-304005)j=v[p]I=y[j]j=-61305-(-61305)v=28262+-28263 y=I(j,v,E)I=q(-389600-(-436659))K=n+y B=m(G,K)y=20241382772084-(-989021)G=f[J[-34862+34866]]K=f[J[-758064-(-758069)]]n=K(I,y)m=G[n]S=B[m]m=-56175-(-56179)k=S*m A=Q(X,k)t=U[t]Q=f[J[527492-527482]]t=t(U,A,Q)i=t end end else if w<811840+15878340 then if w<17545050-959222 then if w<16241043-(-304789)then w=t w=U and 12971926-(-757958)or 3524979-123946 else V=f[J[161954+-161950]]t=f[J[-712946+712951]]A=f[J[479411-479405]]G=34407885037261-811063 k=f[J[384469-384462]]S=f[J[-594028-(-594036)]]B=q(262666-215185)m=S(B,G)X=k[m]w=12469587-625877 Q=A[X]A=582453-582452 U=V(t,Q,A)end else w={}h=1009687+35184371079145 f[J[-52715+52717]]=w U=q(289379-241934)F=f[J[-1032447-(-1032450)]]O=F F=o%h V=722153+-721898 Q=-1038902-(-1038903)f[J[722604-722600]]=F i=o%V V=-371356-(-371358)h=i+V f[J[1040428+-1040423]]=h V=P[U]U=q(620705-573272)i=V[U]A=Q U=893922+-893921 V=i(a)i=q(-333327-(-380521))Q=864395+-864395 t=V X=A<Q l[o]=i w=-335597+6546873 i=-934894+935146 Q=U-A end else if w<-887479+17629168 then if w<-816803+17527337 then U=w K=29144329038233-(-985962)X=f[J[395423-395414]]S=f[J[-459775+459782]]G=q(-327312+374857)m=f[J[897795-897787]]B=m(G,K)k=S[B]G=1039800+23875648081333 A=X[k]k=f[J[40530+-40523]]B=q(680641-633455)S=f[J[194456-194448]]m=S(B,G)X=k[m]Q=A[X]A=-324495-(-324496)t=Q>A w=t and 2935085-406112 or-421443+3201023 V=t else j=-342272+4591363375450 y=q(209175+-162073)k=A K=f[J[-377761-(-377762)]]n=f[J[-575160-(-575162)]]I=n(y,j)G=K[I]B=q(835362+-787867)B=S[B]B=B(S,G)m=B w=B and 407667+964940 or 12584749-36514 end else Q=w I=1258741503877-1037627 S=f[J[-559547+559553]]n=q(682160-634696)B=f[J[-384656-(-384660)]]G=f[J[217049+-217044]]K=G(n,I)n=10560946698937-452484 m=B[K]k=S[m]m=f[J[610369+-610365]]B=f[J[-835838+835843]]K=q(317814-270484)G=B(K,n)S=m[G]X=k[S]k=-755189-(-755190)A=X>k w=A and 384089+10851780 or 6800442-617293 t=A end end end end end end end end end w=#R return x(F)end,function(P,q)local x=l(q)local W=function(W,J,R)return w(P,{W,J,R},q,x)end return W end,function(P,q)local x=l(q)local W=function(W)return w(P,{W},q,x)end return W end,function(P,q)local x=l(q)local W=function(W,J,R,D,F,f,a,H)return w(P,{W,J,R,D;F,f,a;H},q,x)end return W end,function(P,q)local x=l(q)local W=function()return w(P,{},q,x)end return W end,function()o=o+(575239+-575238)a[o]=890026+-890025 return o end,function(P,q)local x=l(q)local W=function(W,J,R,D,F)return w(P,{W;J,R,D;F},q,x)end return W end,function(P)local q,w=-636952+636953,P[290794-290793]while w do a[w],q=a[w]-(168359-168358),q+(857874-857873)if-728692-(-728692)==a[w]then a[w],f[w]=nil,nil end w=P[q]end end,function(P)a[P]=a[P]-(-399915+399916)if a[P]==797903-797903 then a[P],f[P]=nil,nil end end,function(P,q)local x=l(q)local W=function(...)return w(P,{...},q,x)end return W end,function(P,q)local x=l(q)local W=function(W,J,R,D,F,f)return w(P,{W;J;R,D,F,f},q,x)end return W end,function(P,q)local x=l(q)local W=function(W,J,R,D)return w(P,{W;J;R;D},q,x)end return W end,{}return(h(3838247-(-493519),{}))(x(F))end)(getfenv and getfenv()or _ENV,unpack or table[q(432671-385523)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
