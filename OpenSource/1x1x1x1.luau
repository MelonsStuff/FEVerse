-- [[ 1x1x1x1 : Reanimate ]] -- 

--[[
  Credits:
  // Melon - Created this script
  // Emper - Created the reanimation used
  // ZerX - Movement scripting (last part only, i edited it a lot)
  // Forsaken Team - Created the assets used to make this script.
  Note: if there's bugs pls let me know so i can fix them

  Free hats:
  // Sword 1: https://www.roblox.com/catalog/7548993875/Slasher
  // Sword 2: https://www.roblox.com/catalog/11702906576/Battle-Beam

  Free rig:
  // https://www.roblox.com/catalog/3033910400/International-Fedora-Germany
  // https://www.roblox.com/catalog/3409612660/International-Fedora-USA
  // https://www.roblox.com/catalog/3398308134/International-Fedora-Canada
  // https://www.roblox.com/catalog/3033908130/International-Fedora-France
  // https://www.roblox.com/catalog/4819740796/Robox

  Paid hats are found in this game:
  // https://www.roblox.com/games/75212043521343/Melons-Testing-World
]] 

local ScriptSettings = {
DefaultFlingOptions = {
HatFling = false,
Highlight = false,
PredictionFling = true,
Timeout = 0.35,
ToolFling = false,
};
Reanimate_Settings = {
Frequency = 4, -- this is basically how fast the oscillation goes
Amplification = 6, -- this is how far the oscillation goes
FrontOffset = 2.5, -- this is how much youre in front of the player during prediction
};
Directories = {
Main = "FEVerse/",
RBXMs ="FEVerse/RBXMs/",
Sounds = "FEVerse/Sounds/",
Songs = "FEVerse/Songs/",
EmoteSongs = "FEVerse/EmoteSongs/",
};
EmoteAudioOverrides = {
["Gangnam if it was awesome"] = "Gangnam Style",
["Speed Bounce"] = "TuffAsf",
["Miss Me Retake"] = "Miss Me",
["Ronald Insanity"] = "Insanity",
["Kazotsky Kick (Heavy)"] = "Kazotsky Kick",
["Kazotsky Kick (Engineer)"] = "Kazotsky Kick",
["Kazotsky Kick (Sniper)"] = "Kazotsky Kick",
["Kazotsky Kick (Scout)"] = "Kazotsky Kick",
["Kazotsky Kick (Medic)"] = "Kazotsky Kick",
["Kazotsky Kick (Pyro)"] = "Kazotsky Kick",
["Kazotsky Kick (Soldier)"] = "Kazotsky Kick",
["Kazotsky Kick (Demoman)"] = "Kazotsky Kick",
["Kazotsky Kick (Spy)"] = "Kazotsky Kick",
};
Customization = {
EmotesLibrary = true,
HitboxColor = Color3.fromRGB(255, 255, 255),
Hitmarker = 103397225855135
};
Options = {
AnimationBlending = 0.65;
AnimationSpeed = 1;
Fling = true;
Music = true;
CameraEffects = true;
InfiniteJump = true;
Spin = false;
HeadFollowsMouse = true;
};
Quotes = {
"DESPITE EVERYTHING ITS STILL YOU.";
"ENEMY AC-130 ABOVE!";
"RIP AND TEAR UNTIL IT IS DONE.";
"WAR NEVER CHANGES.";
"FOR KOLECHIA!";
"A VISITOR? HMM... INDEED.";
"PICK UP THAT CAN.";
"THIS CHAPTER OF EZIC IS OVER - WE CAN OFFER NO HELP TO YOUR FAMILY";
"ITS NO USE!";
"FOR THE EMPEROR!";
"WHAT WILL YOU HAVE AFTER 500 YEARS?!";
"SAY MY NAME.";
"C'est la vie to glee!";
'I weep and say, "Goodnight, love"';
"Where'd all the time go? It's starting to fly";
"We can be Heroes, just for one day";
"Most people fear dying before they're ready, but they also fear living long enough to become exhausted by existence itself";
"You survived long enough to watch your favorite memories become old.";
"You are here to suffer in this world, yet somehow find reasons to smile.";
"The cruelest thing about existence is that it can be beautiful.";
"MY SHATTERED TRUST NOW CONTROLS YOUR FATE."; -- guess what the quotes below are in reference to lol
"ILL WATCH AS YOU BLEED.";
"BUT LIFE ISNT FAIR AND I HAVE TO MAKE THEM ALL PAY.";
"CARBIDE TO CERISE.";
"SECRETS NO LONGER HIDDEN AWAY.";
}
}

local States = {
Movement = {
Idle = false;
Running = false;
Walking = false;
};
Input = {
Emoting = false;
Debounce = false;
Shift = false;
};
}

local AnimatorCache = {
AnimDefaults = {};
Joints = {};
JointTypes = {};
Rigs = {};
}

local ScriptCache = {
TrashBin = {};
ActiveConnections = {};
StoredMotors = {};
HitHumanoids = {};
CurrentEmoteTrack = nil;
CurrentEmoteSound = nil;
EmoteRigConnection = nil;
StoredConstraints = {};
IsFading = false;
Timer = 0;
AnimDefaultsCached = table.clone(AnimatorCache.AnimDefaults);
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
Lighting = game:GetService("Lighting");
}

local FEManager = loadstring(game:HttpGet("https://gist.githubusercontent.com/MelonsStuff/a003ea305dd302eab1f8d372daed38b4/raw/9db59962b28555fd699a7c29891efb85d45677ab/gistfile1.txt"))()
for i, v in pairs(ScriptSettings.Directories) do FEManager.EnsureFolder(v) end
task.spawn(function()
FEManager.DownloadFile(ScriptSettings.Directories.RBXMs, "1x1x1x1.rbxm", "https://github.com/MelonsStuff/FEVerse/raw/refs/heads/main/RBXMs/1x1x1x1.rbxm")
FEManager.DownloadFile(ScriptSettings.Directories.RBXMs, "Emotes.rbxm", "https://github.com/MelonsStuff/FEVerse/raw/refs/heads/main/RBXMs/Emotes.rbxm")
end)

local script = Services.InsertService:LoadLocalAsset(getcustomasset(ScriptSettings.Directories.RBXMs.."1x1x1x1.rbxm"))

local ScriptAssets = {
Animations = script:WaitForChild("Animations");
Objects = script:WaitForChild("Objects");
Emotes = Services.InsertService:LoadLocalAsset(getcustomasset(ScriptSettings.Directories.RBXMs.."Emotes.rbxm"))
}

local AudioFunctions = {
PlaySFX = function(Audio: number)
local Sound = Instance.new("Sound", workspace)
Sound.SoundId = "rbxassetid://" .. Audio
Sound.Volume = 1
Sound.PlayOnRemove = true
Sound:Destroy()
return Sound
end;
PlaySong = function(Parent: Instance, Audio: number)
local Sound = Instance.new("Sound", Parent)
Sound.Volume = 1
Sound.SoundId = Audio
return Sound
end
}

do
local LeftSword
local RightSword
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
end
end
end

local OnCharacterAdded = function(NewCharacter)
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
for i, v in next, GetChildren(Character) do
if IsA(v, "Script") or IsA(v, "LocalScript") then
v.Disabled = true
end
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
local Frequency = ScriptSettings.Reanimate_Settings.Frequency
local Amplification = ScriptSettings.Reanimate_Settings.Amplification
local Time = tick()
local TargetFace = Target.CFrame.LookVector
local Oscillation = mathsin(Time * mathpi * 2 * Frequency) * Amplification
local OscillatedOffset = TargetFace * Oscillation
local FrontFaceOffset = TargetFace * ScriptSettings.Reanimate_Settings.FrontOffset
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

taskwait(OptionsBreakJointsDelay)

if Humanoid then Humanoid.Health = 0 end
ModelBreakJoints(Character)
if replicatesignal and OptionsUseServerBreakJoints then replicatesignal(Humanoid.ServerBreakJoints) end
ChangeState(Humanoid, Dead)

Wait(Humanoid.Died)

tableclear(Aligns)
tableclear(Blacklist)
tableclear(Accessories)

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
RightSword = CreateObject("RightSword")
LeftSword = CreateObject("LeftSword")
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
RightSword.Anchored = false
LeftSword.Anchored = false
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
-- MAKE THIS EASIER FOR YOURSELF MELON, ADD THE IDS!
{ MeshId = "14768666349", Name = "Torso", Offset = CFrame.Angles(0, 0, 0), TextureId = "14768664565" },
{ MeshId = "14768684979", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14768683674" },
-- Pursuer Swords (120095227086693, 79973033119759)
{ Name = "RightSword", MeshId = "71903417346210",  TextureId = "107739922507680", Offset = CFrame.new(0, 0, 1.5) * CFrame.Angles(Rad(90), 0, Rad(135)) },
{ Name = "LeftSword", MeshId = "115003779345247",  TextureId = "123170803748316", Offset = CFrame.new(0, 0, 1.5) * CFrame.Angles(Rad(90), 0, Rad(135)) },
-- Free Swords (11702906576, 7548993875)
{ Name = "RightSword", MeshId = "7547179386",  TextureId = "7547152243", Offset = CFrame.new(-0.5, 0, 1.5) * CFrame.Angles(Rad(90), 0, Rad(-135)) },
{ Name = "LeftSword", MeshId = "11524268570",  TextureId = "11524268595", Offset = CFrame.new(0, 0, 1.5) * CFrame.Angles(Rad(0), Rad(-35), Rad(90)) },
-- Blue Swords (16315420250, 16315451703) 
{ Name = "RightSword", MeshId = "16314704074",  TextureId = "16315327972", Offset = CFrame.new(-0.25, -0.25, 1.75) * CFrame.Angles(Rad(90), 0, Rad(115)) },
{ Name = "LeftSword", MeshId = "16314704074",  TextureId = "16315325620", Offset = CFrame.new(0, 0, 1.75) * CFrame.Angles(Rad(90), 0, Rad(115)) },
-- Revenant Swords (18355866294, 10714384525) 
{ Name = "RightSword", MeshId = "18355837051",  TextureId = "18355837122", Offset = CFrame.new(-0.25, -0.15, 1.45) * CFrame.Angles(0, Rad(45), Rad(90)) },
{ Name = "LeftSword", MeshId = "10670453071",  TextureId = "10670458678", Offset = CFrame.new(0, 0, 1.75) * CFrame.Angles(Rad(-90), 0, Rad(135)) },
-- Locust Pipes (78562027197644, 79979918316141) 
{ Name = "RightSword", MeshId = "116045584178656",  TextureId = "78542750221272", Offset = CFrame.new(-0.1, -0.15, 1.45) * CFrame.Angles(Rad(90), 0, Rad(-45)) },
{ Name = "LeftSword", MeshId = "116045584178656",  TextureId = "85294451310881", Offset = CFrame.new(0, 0, 1.75) * CFrame.Angles(Rad(-90), 0, Rad(135)) },
-- 1x1x1x1 Swords (70853356022704, 107622409967624) 
{ Name = "RightSword", MeshId = "95053678425313",  TextureId = "88753338346360", Offset = CFrame.new(-0.1, -0.15, 1.65) * CFrame.Angles(Rad(90), Rad(90), 0) },
{ Name = "LeftSword", MeshId = "80099408559509",  TextureId = "89046147359206", Offset = CFrame.new(0, 0, 2) * CFrame.Angles(Rad(-90), 0, Rad(-45)) },
},
ApplyDescription = true,
BreakJointsDelay = 0.225, -- dont modify
ClickFling = false,
DefaultFlingOptions = {
HatFling = false,
Highlight = true,
PredictionFling = true,
Timeout = 0.5,
ToolFling = false,
},
DisableCharacterCollisions = true, -- dont modify
DisableHealthBar = true, -- dont modify
DisableRigCollisions = true, -- dont modify
HatDrop = false, -- dont use
HideCharacter = Vector3.new(0, -30, 0),
ParentCharacter = true, -- dont modify
RigSize = 1, -- dont use
RigTransparency = 1,
R15 = false, -- dont use
SetCameraSubject = true, -- dont modify
SetCameraType = true, -- dont modify
SetCharacter = false, -- dont use
SetCollisionGroup = true, -- dont modify
SimulationRadius = 2147483647, -- dont modify
TeleportRadius = 12, 
UseServerBreakJoints = true, -- dont modify
})

-- character setup
local Player = Services.Players.LocalPlayer
local Character = Empyrean.Rig

local CharacterTable = {
Head = Character:WaitForChild("Head");
RootPart = Character:WaitForChild("HumanoidRootPart");
Torso = Character:WaitForChild("Torso");
LeftArm = Character:WaitForChild("Left Arm");
RightArm = Character:WaitForChild("Right Arm");
LeftLeg = Character:WaitForChild("Left Leg");
RightLeg = Character:WaitForChild("Right Leg");
Humanoid = Character:WaitForChild("Humanoid");
}

local HaxxedSwordLeft = ScriptAssets.Objects:WaitForChild("HaxxedSwordLeft"):Clone()
HaxxedSwordLeft.Parent = Character
for i, v in pairs(HaxxedSwordLeft:GetDescendants()) do
if v:IsA("BasePart") then
v.Transparency = 1
end
end
local LeftSword = Character:FindFirstChild("LeftSword")
local LeftSwordW = Instance.new("Weld", LeftSword)
LeftSwordW.Part0 = HaxxedSwordLeft.HaxxedGripL
LeftSwordW.Part1 = LeftSword
local HaxxedGripL = Instance.new("Motor6D", CharacterTable.RootPart)
HaxxedGripL.Part0 = CharacterTable.RootPart
HaxxedGripL.Part1 = HaxxedSwordLeft.HaxxedGripL
HaxxedGripL.C0 = CFrame.new(0, 0, 1.652) * CFrame.Angles(0, math.rad(-180), math.rad(-90))

local HaxxedSwordRight = ScriptAssets.Objects:WaitForChild("HaxxedSwordRight"):Clone()
HaxxedSwordRight.Parent = Character
for i, v in pairs(HaxxedSwordRight:GetDescendants()) do
if v:IsA("BasePart") then
v.Transparency = 1
end
end
local HaxxedGripR = Instance.new("Motor6D", CharacterTable.RootPart)
HaxxedGripR.Part0 = CharacterTable.RootPart
HaxxedGripR.Part1 = HaxxedSwordRight.HaxxedGripR
HaxxedGripR.C0 = CFrame.new(0, 0, 1.652) * CFrame.Angles(0, math.rad(-180), math.rad(-90))
local RightSword = Character:FindFirstChild("RightSword")
local RightSwordW = Instance.new("Weld", RightSword)
RightSwordW.Part0 = HaxxedSwordRight.HaxxedGripR
RightSwordW.Part1 = RightSword

pcall(function()
Character:FindFirstChild("Animate"):Destroy()
CharacterTable.Humanoid:FindFirstChild("Animator"):Destroy()
end)

-- animator module
local AnimatorFunctions = {
RegisterRigJoints = function(Rig: Model)
if not AnimatorCache.Joints[Rig] then
AnimatorCache.Joints[Rig] = {}
AnimatorCache.AnimDefaults[Rig] = {}
AnimatorCache.JointTypes[Rig] = {}
end
for i, v in ipairs(Rig:GetDescendants()) do
if v:IsA("Bone") then
AnimatorCache.Joints[Rig][v.Name] = v
AnimatorCache.AnimDefaults[Rig][v.Name] = v.CFrame
AnimatorCache.JointTypes[Rig][v.Name] = "Bone"
elseif v:IsA("Motor6D") and v.Part1 then
AnimatorCache.Joints[Rig][v.Part1.Name] = v
AnimatorCache.AnimDefaults[Rig][v.Part1.Name] = v.C0
AnimatorCache.JointTypes[Rig][v.Part1.Name] = "Motor6D"
AnimatorCache.Joints[Rig][v.Name] = v
AnimatorCache.AnimDefaults[Rig][v.Name] = v.C0
AnimatorCache.JointTypes[Rig][v.Name] = "Motor6D"
end
end
end;
UnregisterRigJoints = function(Rig: Model)
AnimatorCache.Joints[Rig] = nil
AnimatorCache.AnimDefaults[Rig] = nil
AnimatorCache.JointTypes[Rig] = nil
if AnimatorCache.Rigs[Rig] then
for i, v in pairs(AnimatorCache.Rigs[Rig]) do
v:Stop()
end
AnimatorCache.Rigs[Rig] = nil
end
end;
EditJoint = function(Joint, TargetCFrame, Duration, Style, Direction, IsBone)
if ScriptSettings.Options.HeadFollowsMouse and Joint == AnimatorCache.Joints[Character]["Head"] then return end
local Property = IsBone and "CFrame" or "C0"
if typeof(Style) == "EnumItem" and Style.Name == "Constant" then
local Tween = Services.TweenService:Create(Joint, TweenInfo.new(0.001, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { [Property] = TargetCFrame })
Tween:Play()
return
end
Style = Enum.EasingStyle[Style.Name]
Direction = Enum.EasingDirection[Direction.Name]
local StartCFrame = Joint[Property]
local Tween = Services.TweenService:Create(Joint, TweenInfo.new(Duration, Style, Direction), { [Property] = StartCFrame:Lerp(TargetCFrame, ScriptSettings.Options.AnimationBlending) })
Tween:Play()
return Tween
end;
}

AnimatorFunctions.RegisterRigJoints(Character)

local LoadAnimation = function(Rig: Model, KeyframeSequence: KeyframeSequence)
local Sequence = KeyframeSequence
local Class = {}
Class.Speed = 1
Class.KeepLast = 0
local Keyframes = Sequence:GetKeyframes()
table.sort(Keyframes, function(a, b) return a.Time < b.Time end)
Class.Length = Keyframes[#Keyframes].Time
local function Yield(Seconds)
local Elapsed = 0
repeat
local dt = Services.RunService.Heartbeat:Wait()
Elapsed += dt
until Elapsed >= Seconds / (Class.Speed * ScriptSettings.Options.AnimationSpeed)
end
for i, v in ipairs(Sequence:GetDescendants()) do
if v:IsA("IntValue") or v:IsA("StringValue") or v:IsA("Folder") then
v:Destroy()
elseif v:IsA("Pose") and not Rig:FindFirstChild(v.Name, true) then
v:Destroy()
end
end
Class.Stopped = true
Class.IsPlaying = false
Class.TimePosition = 0
Class.Looped = Sequence.Loop
local Completion = Instance.new("BindableEvent")
local Reached = Instance.new("BindableEvent")
Class.Completed = Completion.Event
Class.KeyframeReached = Reached.Event
function Class:Play(Speed)
if Speed and Speed < 0 then
Speed = math.abs(Speed)
end
Class.Speed = math.clamp(Speed or 180, 1, 180)
Class.Stopped = false
Class.IsPlaying = true
task.spawn(function()
Class.Completed:Once(function()
if Class.Looped then
Class.TimePosition = 0
end
end)
local Connection
Connection = Services.RunService.Heartbeat:Connect(function(dt)
if Class.IsPlaying and not Class.Stopped then
Class.TimePosition += dt * Class.Speed
else
Connection:Disconnect()
end
end)
end)
task.spawn(function()
repeat
for K = 1, #Keyframes do
local K0, K1, K2 = Keyframes[K-1], Keyframes[K], Keyframes[K+1]
if not Class.Stopped then
if K0 then
Yield(K1.Time - K0.Time)
end
task.spawn(function()
for i, Pose in ipairs(K1:GetDescendants()) do
if AnimatorCache.Joints[Rig][Pose.Name] then
local Duration = K2 and (K2.Time - K1.Time) / Class.Speed or 0.5
local IsBone = AnimatorCache.JointTypes[Rig][Pose.Name] == "Bone"
AnimatorFunctions.EditJoint(AnimatorCache.Joints[Rig][Pose.Name], AnimatorCache.AnimDefaults[Rig][Pose.Name] * Pose.CFrame, Duration, Pose.EasingStyle, Pose.EasingDirection, IsBone)
end
end
end)
if K == #Keyframes and Class.KeepLast > 0 then
Yield(Class.KeepLast)
end
Reached:Fire(K1.Name)
else
break
end
end
Completion:Fire()
until not Class.Looped or Class.Stopped
Class.IsPlaying = false
end)
end
function Class:Stop()
Class.Stopped = true
end
function Class:AdjustSpeed(Speed)
if Speed < 0 then
Speed = math.abs(Speed)
end
Class.Speed = math.clamp(Speed or Class.Speed, 1, 180)
end
return Class
end

local HolsteredCFrameL = CFrame.new(0, 0.5, 2) * CFrame.fromOrientation(math.rad(90), math.rad(-145), 0)
local HolsteredCFrameR = CFrame.new(0, 0.5, 2) * CFrame.fromOrientation(math.rad(90), math.rad(145), 0)
local DefaultCFrameL = CFrame.identity
local DefaultCFrameR = CFrame.identity

local HolsterSwords = function()
HaxxedGripL.Part0 = CharacterTable.Torso
HaxxedGripR.Part0 = CharacterTable.Torso
HaxxedGripL.C0 = CFrame.identity
HaxxedGripR.C0 = CFrame.identity
HaxxedGripL.C1 = HolsteredCFrameL
HaxxedGripR.C1 = HolsteredCFrameR
end

local UnholsterSwords = function()
HaxxedGripL.Part0 = CharacterTable.RootPart
HaxxedGripR.Part0 = CharacterTable.RootPart
HaxxedGripL.C0 = DefaultCFrameL
HaxxedGripR.C0 = DefaultCFrameR
HaxxedGripL.C1 = CFrame.identity
HaxxedGripR.C1 = CFrame.identity
end

local AnimationPlayer = {
PlayAnim = function(Rig: Model, Animation: KeyframeSequence, AnimSpeed: number)
if not AnimatorCache.Rigs[Rig] then
AnimatorCache.Rigs[Rig] = {}
end
if not AnimatorCache.Rigs[Rig][Animation.Name] then
AnimatorCache.Rigs[Rig][Animation.Name] = LoadAnimation(Rig, Animation)
end
for Name, Track in pairs(AnimatorCache.Rigs[Rig]) do
if Name ~= Animation.Name then
Track:Stop()
end
end
local AnimInstance = AnimatorCache.Rigs[Rig][Animation.Name]
if not AnimInstance.IsPlaying then
AnimInstance:Play(AnimSpeed or 1)
end
return AnimInstance
end;
StopAnim = function(Rig: Model, Animation: KeyframeSequence)
if not AnimatorCache.Rigs[Rig] then
AnimatorCache.Rigs[Rig] = {}
end
if not AnimatorCache.Rigs[Rig][Animation.Name] then
AnimatorCache.Rigs[Rig][Animation.Name] = LoadAnimation(Rig, Animation)
end
AnimatorCache.Rigs[Rig][Animation.Name]:Stop()
end;
StopEmote = function()
if ScriptCache.CurrentEmoteTrack then
ScriptCache.CurrentEmoteTrack:Stop()
ScriptCache.CurrentEmoteTrack = nil
end
if ScriptCache.CurrentEmoteSound then
ScriptCache.CurrentEmoteSound:Stop()
ScriptCache.CurrentEmoteSound:Destroy()
ScriptCache.CurrentEmoteSound = nil
end
UnholsterSwords()
States.Input.Emoting = false
States.Input.Debounce = false
end
}

local RestoreMovement = function()
local RootPartOrigin = CharacterTable.RootPart.Position
local Direction = Vector3.new(0, -1, 0) * (4 * Character:GetScale())
local Params = RaycastParams.new()
Params.FilterDescendantsInstances = {Character}
Params.FilterType = Enum.RaycastFilterType.Exclude
Params.IgnoreWater = true
local Result = workspace:Raycast(RootPartOrigin, Direction, Params)
local HitFloor = Result and Result.Instance
if CharacterTable.RootPart.Velocity.Magnitude < 1 and HitFloor then
States.Movement.Idle = true
States.Movement.Walking = false
States.Movement.Running = false
AnimationPlayer.PlayAnim(Character, ScriptAssets.Animations.Idle, 1)
elseif CharacterTable.RootPart.Velocity.Magnitude > 1 and HitFloor then
States.Movement.Idle = false
States.Movement.Walking = true
States.Movement.Running = false
AnimationPlayer.PlayAnim(Character, ScriptAssets.Animations.Walk, 1)
end
end

local PlayAttackSFX = function(Audio: number)
local Sound = Instance.new("Sound", CharacterTable.RootPart)
Sound.SoundId = "rbxassetid://" .. Audio
Sound.Volume = 1
Sound.PlayOnRemove = true
Sound:Destroy()
return Sound
end

-- player functions
local MiscVariables = {
Mouse = Player:GetMouse();
Camera = workspace.CurrentCamera;
Neck = AnimatorCache.Joints[Character]["Head"];
NeckC0 = AnimatorCache.AnimDefaults[Character]["Head"];
}

local PlayerFunctions = {
SetWalkSpeed = function(Speed) CharacterTable.Humanoid.WalkSpeed = Speed end;
SetRootPartAnchor = function(Bool) CharacterTable.RootPart.Anchored = Bool end;
}

task.spawn(function()
local ShiftlockController = Player.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("MouseLockController")
ShiftlockController:FindFirstChild("BoundKeys").Value = "LeftControl, RightControl"
end)

-- hitbox functions
local CanHit = function(Target)
local Time = os.clock()
if ScriptCache.HitHumanoids[Target] and Time < ScriptCache.HitHumanoids[Target] then
return false
end
ScriptCache.HitHumanoids[Target] = Time + 1.15
return true
end

local FlashHitHighlight = function(Target: Model?)
if not Target or not Target:IsA("Model") then return end
if Target:FindFirstChild("HitHighlight") then return end 
local Highlight = Instance.new("Highlight", Target)
Highlight.Name = "HitHighlight"
Highlight.Adornee = Target
Highlight.FillColor = Color3.fromRGB(0, 0, 0)
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
Highlight.FillTransparency = 1
Highlight.OutlineTransparency = 1
Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
local FlashIn = Services.TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {FillTransparency = 0.3, OutlineTransparency = 0})
local FadeOut = Services.TweenService:Create(Highlight,TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {FillTransparency = 1,OutlineTransparency = 1})
FlashIn:Play()
FlashIn.Completed:Once(function() FadeOut:Play() end)
FadeOut.Completed:Once(function() Highlight:Destroy() end)
end

local NewHitbox = function(Position: Vector3, Size: number, HitSound: number)
local Hitbox = Instance.new("Part", workspace)
Hitbox.Size = Size * Character:GetScale() or Vector3.new(4, 4, 4) 
Hitbox.Color = ScriptSettings.Customization.HitboxColor
Hitbox.Material = Enum.Material.ForceField
Hitbox.Transparency = 0.5
Hitbox.Anchored = true
Hitbox.CanCollide = false
Hitbox.CanQuery = false
Hitbox.CanTouch = true
Hitbox.CFrame = Position or CharacterTable.RootPart.CFrame -- RootPart.CFrame * CFrame.new(0, 0, -(4 / 2 + 2))
local OverlapParams = OverlapParams.new()
OverlapParams.FilterType = Enum.RaycastFilterType.Exclude
OverlapParams.FilterDescendantsInstances = {Character}
local HitboxParts = workspace:GetPartsInPart(Hitbox, OverlapParams)
for i, v in pairs(HitboxParts) do
local Target = v:FindFirstAncestorOfClass("Model")
if Target and Target:FindFirstChildOfClass("Humanoid")  then
local TargetRoot = Target:FindFirstChild("HumanoidRootPart")
if TargetRoot and CanHit(Target) then
FlashHitHighlight(Target)
if ScriptSettings.Options.Fling then
AudioFunctions.PlaySFX(ScriptSettings.Customization.Hitmarker)
AudioFunctions.PlaySFX(HitSound or 108515070727256)
Empyrean.Fling(Target, ScriptSettings.DefaultFlingOptions)
end
end
end
end
local HitboxFade = Services.TweenService:Create(Hitbox, TweenInfo.new(0.5), {Transparency = 1})
HitboxFade:Play()
Services.Debris:AddItem(Hitbox, 0.5)
return Hitbox -- added incase you wanna make it animated or even position it somewhere else
end

-- attack functions
local Attacks = {
Slash = function()
if States.Input.Debounce then return end
States.Input.Debounce = true
local SlashAnim = AnimationPlayer.PlayAnim(Character, ScriptAssets.Animations.Slash, 0.1)
PlayAttackSFX(94150824041445)
task.spawn(function()
for i = 1, 3 do
NewHitbox(CharacterTable.RootPart.CFrame * CFrame.new(0, 0, -2), Vector3.new(4, 4, 4), 138443694594588)
task.wait(0.04)
end
end)
SlashAnim.Completed:Wait()
States.Input.Debounce = false
RestoreMovement()
end;
Entanglement = function()
if States.Input.Debounce then return end
States.Input.Debounce = true
PlayerFunctions.SetWalkSpeed(3)
local EntanglementAnim = AnimationPlayer.PlayAnim(Character, ScriptAssets.Animations["Entanglement"], 0.1)
local EntanglementConnection
EntanglementConnection = EntanglementAnim.KeyframeReached:Connect(function(Keyframe)
if Keyframe == "Throw" then
EntanglementConnection:Disconnect()
local ForwardDirection = CharacterTable.RootPart.CFrame.LookVector
local ThrownSwords = ScriptAssets.Objects.EntanglementSwords:Clone()
ThrownSwords.Parent = workspace
ThrownSwords:SetPrimaryPartCFrame(CharacterTable.RootPart.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(math.rad(-90), math.rad(180), 0))
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.Velocity = ForwardDirection * 80
BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
BodyVelocity.Parent = ThrownSwords.PrimaryPart
task.spawn(function()
for i = 1, 45 do
if not ThrownSwords or not ThrownSwords.PrimaryPart then break end
NewHitbox(ThrownSwords.PrimaryPart.CFrame, Vector3.new(4, 2, 4), 138443694594588)
task.wait(0.08)
end
end)
game:GetService("Debris"):AddItem(ThrownSwords, 3)
end
end)
PlayAttackSFX(83273236172664)
EntanglementAnim.Completed:Wait()
States.Input.Debounce = false
RestoreMovement()
end;
MassInfection = function()
if States.Input.Debounce then return end
States.Input.Debounce = true
PlayerFunctions.SetWalkSpeed(3)
local MassInfectionAnim = AnimationPlayer.PlayAnim(Character, ScriptAssets.Animations["Mass Infection"], 0.1)
local MassInfectionConnection
MassInfectionConnection = MassInfectionAnim.KeyframeReached:Connect(function(Keyframe)
if Keyframe == "Throw" then
MassInfectionConnection:Disconnect()
local ForwardDirection = CharacterTable.RootPart.CFrame.LookVector
local Shockwave = ScriptAssets.Objects.MassInfectionShockwave:Clone()
Shockwave.Parent = workspace
Shockwave:SetPrimaryPartCFrame(CharacterTable.RootPart.CFrame * CFrame.new(0, 0, -3))
local BodyVelocity = Instance.new("BodyVelocity")
BodyVelocity.Velocity = ForwardDirection * 80
BodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
BodyVelocity.Parent = Shockwave.PrimaryPart
task.spawn(function()
for i = 1, 45 do
if not Shockwave or not Shockwave.PrimaryPart then break end
NewHitbox(Shockwave.PrimaryPart.CFrame, Vector3.new(4, 2, 4), 138443694594588)
task.wait(0.08)
end
end)
game:GetService("Debris"):AddItem(Shockwave, 3)
end
end)
PlayAttackSFX(122781296475409)
MassInfectionAnim.Completed:Wait()
States.Input.Debounce = false
RestoreMovement()
end;
UnstableEye = function()
if States.Input.Debounce then return end
States.Input.Debounce = true
PlayerFunctions.SetWalkSpeed(3)
local UnstableEyeAnim = AnimationPlayer.PlayAnim(Character, ScriptAssets.Animations["Unstable Eye"], 0.1)
PlayAttackSFX(132444032352118)
local UnstableEyeConnection
UnstableEyeConnection = UnstableEyeAnim.KeyframeReached:Connect(function(Keyframe)
if Keyframe == "Blind" then
UnstableEyeConnection:Disconnect()
task.spawn(function()
local Highlights = {}
local Blur = Instance.new("BlurEffect")
Blur.Parent = game:GetService("Lighting")
Blur.Size = 0
for i, v in ipairs(workspace:GetDescendants()) do
if v:IsA("Humanoid") then
local Model = v:FindFirstAncestorOfClass("Model")
if Model and Model ~= Character and Model.Name ~= Player.Name and not Model:FindFirstChild("UnstableEyeHighlight") then
local Highlight = Instance.new("Highlight")
Highlight.Name = "UnstableEyeHighlight"
Highlight.Adornee = Model
Highlight.FillTransparency = 1
Highlight.OutlineTransparency = 1
Highlight.FillColor = Color3.fromRGB(133, 140, 0)
Highlight.OutlineColor = Color3.fromRGB(255, 217, 0)
Highlight.Parent = Model
table.insert(Highlights, Highlight)
Services.TweenService:Create(Highlight, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { FillTransparency = 0.5, OutlineTransparency = 0 }):Play()
end
end
end
Services.TweenService:Create(Blur, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), { Size = 45 }):Play()
task.wait(5)
for i, v in ipairs(Highlights) do
Services.TweenService:Create(v, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { FillTransparency = 1, OutlineTransparency = 1 }):Play()
end
Services.TweenService:Create(Blur, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), { Size = 0 }):Play()
task.wait(0.5)
for i, v in ipairs(Highlights) do
if v and v.Parent then
v:Destroy()
end
end
Blur:Destroy()
end)
end
end)
UnstableEyeAnim.Completed:Wait()
States.Input.Debounce = false
RestoreMovement()
end
} 

-- keybinds
local KeybindConnections = {
KeyDown = Services.UserInputService.InputBegan:Connect(function(Key, GPE)
if GPE then return end
if Key.UserInputType == Enum.UserInputType.MouseButton1 then
Attacks.Slash()			
end
if Key.KeyCode == Enum.KeyCode.Q then
Attacks.MassInfection()
end
if Key.KeyCode == Enum.KeyCode.E then
Attacks.Entanglement()
end
if Key.KeyCode == Enum.KeyCode.R then
Attacks.UnstableEye()
end
if Key.KeyCode == Enum.KeyCode.LeftShift or Key.KeyCode == Enum.KeyCode.RightShift then
if States.Input.Debounce then return end
States.Input.Shift = true
end
end);
KeyUp = Services.UserInputService.InputEnded:Connect(function(Key)
if Key.KeyCode == Enum.KeyCode.LeftShift or Key.KeyCode == Enum.KeyCode.RightShift then
States.Input.Shift = false
end
end);
JumpRequest = Services.UserInputService.JumpRequest:Connect(function()
if ScriptSettings.Options.InfiniteJump and CharacterTable.Humanoid then
CharacterTable.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end
end);
} 

table.insert(ScriptCache.ActiveConnections, KeybindConnections.KeyDown)
table.insert(ScriptCache.ActiveConnections, KeybindConnections.KeyUp)
table.insert(ScriptCache.ActiveConnections, KeybindConnections.JumpRequest)

-- mobile ui
local GUI = script:WaitForChild("UIs").MobileUI
GUI.Parent = Services.CoreGui
table.insert(ScriptCache.TrashBin, GUI)
local UpdateUI = function()
local LastInput = Services.UserInputService:GetLastInputType()
if LastInput == Enum.UserInputType.Touch
then GUI.Enabled = true
else GUI.Enabled = false
end
end
UpdateUI()
GUI.AbilitiesUI["M1"].MouseButton1Down:connect(function() Attacks.Slash() end)
GUI.AbilitiesUI["MassInfection"].MouseButton1Down:connect(function() Attacks.MassInfection() end)
GUI.AbilitiesUI["Entanglement"].MouseButton1Down:connect(function() Attacks.Entanglement() end)
GUI.AbilitiesUI["UnstableEye"].MouseButton1Down:connect(function() Attacks.UnstableEye() end)
GUI.AbilitiesUI["Sprint"].MouseButton1Down:connect(function() States.Input.Shift = not States.Input.Shift end)
Services.UserInputService.LastInputTypeChanged:Connect(UpdateUI)

-- ui setup
local MainGUI = script.UIs:WaitForChild("MainGUI")
MainGUI.Parent = Services.CoreGui
table.insert(ScriptCache.TrashBin, MainGUI)
local TitleBar = MainGUI:WaitForChild("TitleBar")
local QuoteLabel = MainGUI:WaitForChild("QuoteLabel")
local SettingsFrame = MainGUI:WaitForChild("SettingsFrame")
local SettingsHolder = SettingsFrame:WaitForChild("SettingsHolder")
local EmoteFrame = MainGUI:WaitForChild("EmoteFrame")
local EmotesHolder = EmoteFrame:WaitForChild("EmotesHolder")
local Template = EmotesHolder:WaitForChild("Template"):Clone()
local FloatingButton = MainGUI:WaitForChild("FloatingButton")
local UIDragDetector = Instance.new("UIDragDetector", FloatingButton)
local SearchBar = EmoteFrame:WaitForChild("SearchBar")

QuoteLabel.TextTransparency = 0
Template.Parent = nil
EmotesHolder:WaitForChild("Template"):Destroy()
EmoteFrame.Visible = false

if ScriptSettings.Customization.EmotesLibrary then
EmoteFrame.Visible = true
local Animations = ScriptAssets.Emotes
for i, v in Animations:GetChildren() do
local NewTemplate = Template:Clone()
NewTemplate.Name = v.Name
NewTemplate.Title.Text = v.Name
NewTemplate.Parent = EmotesHolder
NewTemplate.Button.MouseButton1Click:Connect(function()
if States.Input.Debounce and not States.Input.Emoting then return end
if States.Input.Emoting and ScriptCache.CurrentEmoteTrack and AnimatorCache.Rigs[Character] and AnimatorCache.Rigs[Character][v.Name] == ScriptCache.CurrentEmoteTrack then
AnimationPlayer.StopEmote()
RestoreMovement()
return
end
AnimationPlayer.StopEmote()
States.Input.Emoting = true
States.Input.Debounce = true
local AudioName = ScriptSettings.EmoteAudioOverrides[v.Name] or v.Name
ScriptCache.CurrentEmoteSound = AudioFunctions.PlaySong(workspace, getcustomasset(ScriptSettings.Directories.EmoteSongs..AudioName..".mp3"))
ScriptCache.CurrentEmoteSound.Looped = true
ScriptCache.CurrentEmoteSound:Play()
ScriptCache.CurrentEmoteTrack = AnimationPlayer.PlayAnim(Character, v, 0.05)
task.delay(0.1, function()
HolsterSwords()
end)
end)
end
end

-- ui handlers
local SetupToggle = function(Setting: string)
local Object = SettingsHolder:FindFirstChild(Setting)
if not Object then return end
local Button = Object:FindFirstChildWhichIsA("TextButton")
if not Button then return end
Button.BackgroundColor3 = ScriptSettings.Options[Setting] and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
Button.MouseButton1Click:Connect(function()
AudioFunctions.PlaySFX(18755588842)
ScriptSettings.Options[Setting] = not ScriptSettings.Options[Setting]
Button.BackgroundColor3 = ScriptSettings.Options[Setting] and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
end)
end
local SetupTextBox = function(Setting: string)
local Object = SettingsHolder:FindFirstChild(Setting)
if not Object then return end
local TextBox = Object:FindFirstChildWhichIsA("TextBox")
if not TextBox then return end
TextBox.Text = tostring(ScriptSettings.Options[Setting])
TextBox.FocusLost:Connect(function()
local Value = tonumber(TextBox.Text)
if Value then
ScriptSettings.Options[Setting] = math.clamp(Value, 0.1, 4)
else
TextBox.Text = tonumber(ScriptSettings.Options[Setting])
end
end)
end
for i, v in pairs(ScriptSettings.Options) do
local Object = SettingsHolder:FindFirstChild(i)
if Object then
if Object:FindFirstChild("Button") then
SetupToggle(i)
elseif Object:FindFirstChild("Value") then
SetupTextBox(i)
end
end
end
UIDragDetector.DragStart:Connect(function()
if ScriptSettings.Customization.EmotesLibrary then EmoteFrame.Visible = not EmoteFrame.Visible end
TitleBar.Visible = not TitleBar.Visible
QuoteLabel.Visible = not QuoteLabel.Visible
SettingsFrame.Visible = not SettingsFrame.Visible
AudioFunctions.PlaySFX(18755588842)
end)
FloatingButton.MouseEnter:Connect(function()
AudioFunctions.PlaySFX(122453173810540)
end)

-- tp to nearest spawn thing
SettingsHolder.TPToNearestSpawn.Button.MouseButton1Click:Connect(function()
local RootPart = Character:FindFirstChild("HumanoidRootPart")
local GetClosestSpawn = function()
local ClosestSpawn, ClosestDistance = nil, math.huge
for i, v in pairs(workspace:GetDescendants()) do
if v:IsA("SpawnLocation") then
local Distance = (RootPart.Position - v.Position).Magnitude
if Distance < ClosestDistance then
ClosestSpawn = v
ClosestDistance = Distance
end
end
end
return ClosestSpawn
end
local Spawn = GetClosestSpawn()
if Spawn then
RootPart.CFrame = Spawn.CFrame + Vector3.new(0, 5, 0)
else
warn("No one is around to help.")
end
end)

-- emote search bar
local FilterEmotes = function()
local Query = string.lower(SearchBar.Text)
local Emotes = EmotesHolder:GetChildren()
for i, v in ipairs(Emotes) do
if v:IsA("GuiObject") then
v.Visible = Query == "" or string.find(string.lower(v.Name), Query, 1, true) ~= nil
end
end
end
SearchBar:GetPropertyChangedSignal("Text"):Connect(FilterEmotes)
local FadeOutTween = Services.TweenService:Create(QuoteLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 1})
local FadeInTween = Services.TweenService:Create(QuoteLabel, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextTransparency = 0})

-- scale textbox
for i, v in pairs(AnimatorCache.AnimDefaults[Character]) do ScriptCache.AnimDefaultsCached[i] = v end
local ScaleTo = function(Scale: number)
local SavedSizes = {}
for i, v in ipairs(Character:GetDescendants()) do
if v:IsA("BasePart") and v.Name == "Handle" then
SavedSizes[v] = { Size = v.Size }
local Mesh = v:FindFirstChildOfClass("SpecialMesh")
if Mesh then
SavedSizes[v].MeshScale = Mesh.Scale
end
end
end
Character:ScaleTo(Scale)
Character:SetPrimaryPartCFrame(Character.PrimaryPart.CFrame * CFrame.new(0, 16, 0))
for i, v in next, SavedSizes do
i.Size = v.Size
local Mesh = i:FindFirstChildOfClass("SpecialMesh")
if Mesh and v.MeshScale then
Mesh.Scale = v.MeshScale
end
end
for i, v in ipairs(Character:GetDescendants()) do
if v:IsA("Motor6D") and v.Part1 then
local Default = ScriptCache.AnimDefaultsCached[v.Name]
if Default then
local ScaledC0 = Default + Default.Position * (Scale - 1)
v.C0 = ScaledC0
if AnimatorCache.AnimDefaults[Character][v.Part1.Name] then
AnimatorCache.AnimDefaults[Character][v.Part1.Name] = ScaledC0
end
AnimatorCache.AnimDefaults[Character][v.Name] = ScaledC0
end
end
end
MiscVariables.NeckC0 = AnimatorCache.AnimDefaults[Character]["Head"]
end
local ScaleBox = SettingsHolder:FindFirstChild("RigSize"):FindFirstChildWhichIsA("TextBox")
ScaleBox.FocusLost:Connect(function()
local Value = tonumber(ScaleBox.Text)
if Value then
ScaleTo(math.clamp(Value, 0.45, 7)) -- fix for bigs that are resized using the roblox accessory scale thing
else
ScaleBox.Text = "1"
end
end)

-- runservice connection
local RunServiceConnection = Services.RunService.Heartbeat:Connect(function(dt)
local RootPartOrigin = CharacterTable.RootPart.Position
local Direction = Vector3.new(0, -1, 0) * (4 * Character:GetScale())
local Params = RaycastParams.new()
Params.FilterDescendantsInstances = {Character}
Params.FilterType = Enum.RaycastFilterType.Exclude
Params.IgnoreWater = true
local Result = workspace:Raycast(RootPartOrigin, Direction, Params)
local HitFloor = Result and Result.Instance
local TorsoVelocity = (CharacterTable.RootPart.Velocity).Magnitude
if ScriptSettings.Options.HeadFollowsMouse then
local LookDir = (MiscVariables.Mouse.Hit.Position - CharacterTable.Head.Position).Unit
local LocalDir = CharacterTable.Torso.CFrame:VectorToObjectSpace(LookDir)
MiscVariables.Neck.C0 = MiscVariables.Neck.C0:Lerp(MiscVariables.NeckC0 * CFrame.Angles(math.atan((CharacterTable.Head.Position - MiscVariables.Mouse.Hit.Position).Unit.Y), 0, (CharacterTable.Head.Position - MiscVariables.Mouse.Hit.Position).Unit:Cross(CharacterTable.Torso.CFrame.LookVector).Y), math.clamp(8 * dt, 0, 1))
end
if States.Input.Debounce then
AnimationPlayer.StopAnim(Character, ScriptAssets.Animations.Idle)
AnimationPlayer.StopAnim(Character, ScriptAssets.Animations.Walk)
AnimationPlayer.StopAnim(Character, ScriptAssets.Animations.Sprint)
end
if ScriptSettings.Options.CameraEffects then
CharacterTable.Humanoid.CameraOffset = CharacterTable.Humanoid.CameraOffset:Lerp((CharacterTable.RootPart.CFrame * CFrame.new(0, 1.5, 0)):PointToObjectSpace(CharacterTable.Head.Position), math.clamp(dt * 10, 0, 1))
else
CharacterTable.Humanoid.CameraOffset = CharacterTable.Humanoid.CameraOffset:Lerp(Vector3.zero, math.clamp(dt * 10, 0, 1))
end
if ScriptSettings.Options.Spin and Character.PrimaryPart then
Character:SetPrimaryPartCFrame(Character.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(5), 0))
end
if not States.Input.Debounce then
if States.Input.Shift then
PlayerFunctions.SetWalkSpeed(28)
else
PlayerFunctions.SetWalkSpeed(10)
end
end
if TorsoVelocity < 0.001 and HitFloor ~= nil and not States.Input.Debounce then
if States.Movement.Idle == false then
States.Movement.Idle = true
AnimationPlayer.PlayAnim(Character,ScriptAssets.Animations.Idle, 1)
end
States.Movement.Walking = false
States.Movement.Running = false
AnimationPlayer.StopAnim(Character,ScriptAssets.Animations.Sprint)
AnimationPlayer.StopAnim(Character,ScriptAssets.Animations.Walk)
elseif TorsoVelocity > 1 and HitFloor ~= nil and not States.Input.Debounce and States.Input.Shift then
if States.Movement.Running == false then
States.Movement.Running = true
AnimationPlayer.PlayAnim(Character,ScriptAssets.Animations.Sprint, 1)
end
States.Movement.Idle = false
States.Movement.Walking = false
AnimationPlayer.StopAnim(Character,ScriptAssets.Animations.Walk)
AnimationPlayer.StopAnim(Character,ScriptAssets.Animations.Idle)
elseif TorsoVelocity > 1 and HitFloor ~= nil and not States.Input.Debounce then
if States.Movement.Walking == false then
States.Movement.Walking = true
AnimationPlayer.PlayAnim(Character, ScriptAssets.Animations.Walk, 1)
end
States.Movement.Idle = false
States.Movement.Running = false
AnimationPlayer.StopAnim(Character,ScriptAssets.Animations.Sprint)
AnimationPlayer.StopAnim(Character,ScriptAssets.Animations.Idle)
end
if ScriptCache.IsFading then return end
ScriptCache.Timer += dt
if ScriptCache.Timer >= 3 then
ScriptCache.Timer = 0
ScriptCache.IsFading = true
FadeOutTween:Play()
FadeOutTween.Completed:Once(function()
QuoteLabel.Text = ScriptSettings.Quotes[math.random(1, #ScriptSettings.Quotes)]
FadeInTween:Play()
FadeInTween.Completed:Once(function()
ScriptCache.IsFading = false
end)
end)
end
end)
table.insert(ScriptCache.ActiveConnections, RunServiceConnection)

Empyrean.BindableEvent.Event:Once(function()
print("Resetting.")
for i, v in ScriptCache.TrashBin do
v:Destroy()
end
for i, v in ScriptCache.ActiveConnections do
v:Disconnect()
end
if ScriptCache.CurrentEmoteSound then
ScriptCache.CurrentEmoteSound:Destroy()
end
end)
