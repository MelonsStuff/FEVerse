-- [[ Jason Revisited : Reanimate ]] --

--[[
Features:
head follows mouse - makes the characters head follow where you are pointing your mouse at
animation speed - directly modify how fast / slow you want animations to play (0.1 - 5)
animation blending - directly modify how smooth you want animations to lerp (0 - 1)
rig scale - lets you scale how big your character is which allows the big rigs to be used (0.45 - 7.25)
camera follows head - camera smoothly follows the characters head to allow for some interesting shit idk
emote library support - allows you to import rbxms / rbxmxs (or .anim files) into your workspace folder
for an endless amount of emotes (anim files recommended for more optimization)
walk / sprint speed boxes - lets you directly change speed without modifying the scripts source
scriptless emote library - import a file and audio and your emote will be successfully imported requiring 0 lua editing / scripting

Help:
for the emote folder please join my discord: https://discord.gg/HuBhaN5h9
file import - all animations MUST match their mp3 (example, gangnam style.anim must be gangnam style.mp3)
it is CASE SENSITIVE meaning mp3s HAVE to match the rbxm / anim file.
]]

--[[ 
Credits | <3
Melon - created everything in the script (excluding pretty much all of the animations and reanimation changes)
Emper - created the reanim used to make this script work ofc
STEVETHEREALONE - created the .anim format
TheGuardian - created anim2rbxm and .anim parser, also did a lot of edits and bug fixes on the reanimate (cool guy btw)
imbluuhahaalt_ - created the "Final Night" emote (cool guy btw)
F̷̎͝l̷̄͆ő̵̌ṕ̴̓p̸̃̈́á̷̔  - gave some cool align ideas (cool guy btw)

Special Thanks | <3
Cherry Club - my beloved community + always sticking with me even through the burn out ive gone through
Cherry - my extremely cool character + emotional anchor
Kronos / Astron / Saturn - being very cool + very funny and overall amazing person to be with
Diego / Banana - being very cool + killed boredom every second we called, thanks man
Zink - being very cool + always being talkative, always iconic!
my family - always a cool reminder to keep going + something to always love
the people on the art wall of melons testing world - cool as HELL for drawing my character + thank you doing something with me in mind, means a lot <3
nil - being very cool + always gave advice when i didnt know who to ask, never forgetting the day we started talking.

Honorary Mentions | <3
Monster Energy / Redbull - thank you for fueling me when i slept for 4-5 hours + tasting like shit sometimes
pickle rick trap remix - reminds me that even the strangest of things can be unconsciously amazing 
dr eggman robotnik - a reminder that being defeated is just a reminder to get better
my microwave - fueled me with cheap hot pockets and burritos when i was lowkey hungry
my laptop - not giving up after 3 years unlike the previous one i had to return because the fans exploded
call of duty warzone - making me rage and realize that scripting / drawing / animating was more enjoyable
]]

local StartTime = os.clock()

local Runtime
local Empyrean = nil
local UseAutoRig = false -- buggy but works (doesnt align after a fling but ig its fine?)

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

local getcustomasset = getcustomasset
local readfile = readfile
local isfile = isfile
local listfiles = listfiles
local replicatesignal = replicatesignal
local sethiddenproperty = sethiddenproperty
local setscriptable = setscriptable

local Rad = math.rad

local script = script

local Attacks = {}
local MiscVariables = {}
local AudioFunctions = {}
local PlayerFunctions = {}
local ScriptAssets = {}
local Reanimator = {}
local HitboxService = {}
local AnimatorModule = {
AnimDefaults = {};
Joints = {};
JointTypes = {};
Rigs = {};
JointPaths = {};
}
local States = {
Movement = {
Idle = false;
Running = false;
Walking = false;
};
Input = {
Raging = false;
Emoting = false;
Debounce = false;
Shift = false;
HitGashing = false;
};
}
local ScriptCache = {
TrashBin = {};
ActiveConnections = {};
HitHumanoids = {};
CurrentEmoteTrack = nil;
IsFading = false;
Timer = 0;
AnimDefaultsCached = table.clone(AnimatorModule.AnimDefaults);
CurrentScale = 1;
EmoteCount = 0;
}
local ScriptSettings = {
DefaultFlingOptions = {
HatFling = false,
Highlight = false,
PredictionFling = true,
Timeout = 0.75,
ToolFling = false,
};
Reanimate_Settings = { -- useless unless you dont have shp
Frequency = 4, -- this is basically how fast the oscillation goes
Amplification = 6, -- this is how far the oscillation goes
FrontOffset = 2.35, -- this is how much youre in front of the player during prediction
};
Directories = {
Main = "FEVerse/";
RBXMs ="FEVerse/RBXMs/";
Sounds = "FEVerse/Sounds/";
Songs = "FEVerse/Songs/";
EmoteSongs = "FEVerse/EmoteSongs/";
Emotes = "FEVerse/Emotes/";
};
AutoRigParts = {
Torso = "autorig_Torso",
["Right Arm"] = "autorig_RightArm",
["Left Arm"] = "autorig_LeftArm",
["Right Leg"] = "autorig_RightLeg",
["Left Leg"] = "autorig_LeftLeg"
};
EmoteAudioOverrides = { -- use this if you have multiple emotes which share the same audio
["Tinky Dance"] = "Nocturnal Protocol",
["TInky Rap"] = "Nocturnal Protocol",
["Thriller Live"] = "Thriller",
["Speed Bounce"] = "Tuff Asf",
["AVGN Faker"] = "Kwik Flip",
["AVGN Dance"] = "Kwik Flip",
["Miss Me Retake"] = "Miss Me",
["Circus Sigma"] = "Freddy",
["Horror Funk"] = "Six Seven",
["Imposter Syndrome"] = "Just Be Competent",
["Gangnam if it was awesome"] = "Gangnam Style",
["Crank That"] = "Crank Dat",
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
EmotesLibrary = true;
HitboxColor = Color3.fromRGB(255, 255, 255);
Hitmarker = 103397225855135;
};
Options = {
SprintSpeed = 28;
RagingSpeed = 19;
WalkSpeed = 9;
AnimationBlending = 0.55;
AnimationSpeed = 1;
Fling = true;
ClickFling = true;
Music = true;
CameraEffects = true;
InfiniteJump = true;
Spin = false;
HeadFollowsMouse = false;
VisibleHitboxes = true;
};
}
PlayerFunctions.SendNotification = function(Input)  
if Services.RunService:IsStudio() then
print("Notification: "..Input) -- stupid corescripts
else
Services.StarterGui:SetCore("SendNotification",{
Title = "Cherry Club Notification",
Text = Input,
})
end
end
if Services.RunService:IsStudio() then
ScriptSettings.Quotes = {"You're in studio!"}
else 
ScriptSettings.Quotes = {"You're in game!"}
end

if not Services.RunService:IsStudio() then
local FEManager = loadstring(game:HttpGet("https://gist.githubusercontent.com/MelonsStuff/a003ea305dd302eab1f8d372daed38b4/raw/9db59962b28555fd699a7c29891efb85d45677ab/gistfile1.txt"))()
for i, v in pairs(ScriptSettings.Directories) do FEManager.EnsureFolder(v) end
task.spawn(function()
FEManager.DownloadFile(ScriptSettings.Directories.Songs, "JasonTheme.mp3", "https://github.com/MelonsStuff/FEVerse/raw/refs/heads/main/Songs/JasonTheme.mp3")
FEManager.DownloadFile(ScriptSettings.Directories.RBXMs, "Jason.rbxm", "https://github.com/MelonsStuff/forthetesters/raw/refs/heads/main/Jason.rbxm")
end)
PlayerFunctions.SendNotification("we are downloading the file pls wait")
repeat wait() until isfile(ScriptSettings.Directories.RBXMs.."Jason.rbxm")
script = Services.InsertService:LoadLocalAsset(getcustomasset(ScriptSettings.Directories.RBXMs.."Jason.rbxm"))
end
repeat wait() until isfile(ScriptSettings.Directories.RBXMs.."Jason.rbxm")

ScriptAssets.Animations = script:WaitForChild("Animations")
ScriptAssets.Objects = script:WaitForChild("Objects")
ScriptAssets.UIs = script:WaitForChild("UIs")

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
local Frequency = ScriptSettings.Reanimate_Settings.Frequency
local Amplification = ScriptSettings.Reanimate_Settings.Amplification
local Time = tick()
local TargetFace = Target.CFrame.LookVector
local Oscillation = mathsin(Time * mathpi * 2 * Frequency) * Amplification
local OscillatedOffset = TargetFace * Oscillation
local FrontFaceOffset = TargetFace * ScriptSettings.Reanimate_Settings.FrontOffset
Offset = BaseOffset + OscillatedOffset + FrontFaceOffset
if sethiddenproperty then
pcall(function() Humanoid:Move(Vector3nan) end)
pcall(sethiddenproperty, HumanoidRootPart, "PhysicsRepRootPart", Target)
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
if not ScriptSettings.Options.ClickFling then return end
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
tableinsert(RBXScriptConnections, Connect(BindableEvent.Event, Reanimator.Stop))
Rig = ScriptAssets.Objects.StarterCharacter
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

{ Name = "Machete", MeshId = "106996866742069",  TextureId = "73165162168835", Offset = CFrame.Angles(0, Rad(-90), Rad(55)) },
{ Name = "Chainsaw",MeshId = "138791659920636",  TextureId = "115860183331629", Offset = CFrame.Angles(0, Rad(-90), Rad(-65)) },

},
ApplyDescription = true,
BreakJointsDelay = 0.225, -- dont modify
ClickFling = true,
DefaultFlingOptions = {
HatFling = false,
Highlight = true,
PredictionFling = true,
Timeout = 0.95,
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
--reanim end


-- character setup
local Player = Services.Players.LocalPlayer
local Character
if Services.RunService:IsStudio() then Character = Player.Character or Player.CharacterAdded:Wait() else Character = Empyrean.Rig end
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
pcall(function()
Character:FindFirstChild("Animate"):Destroy()
CharacterTable.Humanoid:FindFirstChild("Animator"):Destroy()
end)
local CurrentSound = Instance.new("Sound", CharacterTable.RootPart)
CurrentSound.Looped = true
CurrentSound.Volume = 1
if not Services.RunService:IsStudio() then
CurrentSound.SoundId = getcustomasset(ScriptSettings.Directories.Songs.."JasonTheme.mp3")
else
print("studio")
CurrentSound.SoundId = "rbxasset://emotetesting.mp3"
end
CurrentSound:Play()

-- animator module
AnimatorModule.GetBonePath = function(Bone)
local Path = {Bone.Name}
local Parent = Bone.Parent
while Parent and Parent:IsA("Bone") do
table.insert(Path, 1, Parent.Name)
Parent = Parent.Parent
end
return table.concat(Path, "/")
end
AnimatorModule.GetPosePath = function(Pose)
local Path = {Pose.Name}
local Parent = Pose.Parent
while Parent and Parent:IsA("Pose") do
table.insert(Path, 1, Parent.Name)
Parent = Parent.Parent
end
table.remove(Path, 1)
return table.concat(Path, "/")
end
AnimatorModule.RegisterRigJoints = function(Rig: Model)
if not AnimatorModule.Joints[Rig] then
AnimatorModule.Joints[Rig] = {}
AnimatorModule.AnimDefaults[Rig] = {}
AnimatorModule.JointTypes[Rig] = {}
AnimatorModule.JointPaths[Rig] = {}
end
local PartToMotor = {}
for i, v in ipairs(Rig:GetDescendants()) do
if v:IsA("Motor6D") and v.Part1 then
PartToMotor[v.Part1] = v
end
end
local GetMotorPath = function(Part)
local Path = {Part.Name}
local Joint = PartToMotor[Part]
while Joint and Joint.Part0 and PartToMotor[Joint.Part0] do
Part = Joint.Part0
table.insert(Path, 1, Part.Name)
Joint = PartToMotor[Part]
end
return table.concat(Path, "/")
end
for i, v in ipairs(Rig:GetDescendants()) do
if v:IsA("Bone") then
local Path = AnimatorModule.GetBonePath(v)
AnimatorModule.Joints[Rig][Path] = v
AnimatorModule.AnimDefaults[Rig][Path] = v.CFrame
AnimatorModule.JointTypes[Rig][Path] = "Bone"
AnimatorModule.JointPaths[Rig][v] = Path
elseif v:IsA("Motor6D") and v.Part1 then
local Path = GetMotorPath(v.Part1)
AnimatorModule.Joints[Rig][Path] = v
AnimatorModule.AnimDefaults[Rig][Path] = v.C0
AnimatorModule.JointTypes[Rig][Path] = "Motor6D"
AnimatorModule.JointPaths[Rig][v] = Path
end
end
end
AnimatorModule.UnregisterRigJoints = function(Rig: Model)
AnimatorModule.Joints[Rig] = nil
AnimatorModule.AnimDefaults[Rig] = nil
AnimatorModule.JointTypes[Rig] = nil
if AnimatorModule.Rigs[Rig] then
for i, v in pairs(AnimatorModule.Rigs[Rig]) do
v:Stop()
end
AnimatorModule.Rigs[Rig] = nil
end
end
AnimatorModule.EditJoint = function(Joint, TargetCFrame, Duration, Style, Direction, IsBone)
if ScriptSettings.Options.HeadFollowsMouse and Joint == MiscVariables.Neck then return end
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
end
AnimatorModule.RegisterRigJoints(Character)
AnimatorModule.LoadAnimation = function(Rig: Model, KeyframeSequence: KeyframeSequence)
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
function Class:Play(Speed) -- guardian was here 
if Speed and Speed < 0 then
Speed = math.abs(Speed)
end
Class.Speed = math.clamp(Speed or 180, 1, 180)
Class.Stopped = false
Class.IsPlaying = true
Class.TimePosition = 0
local Connection
Connection = Services.RunService.Heartbeat:Connect(function(dt)
if Class.IsPlaying and not Class.Stopped then
Class.TimePosition += dt * Class.Speed * ScriptSettings.Options.AnimationSpeed
else
Connection:Disconnect()
end
end)
local function WaitUntil(TargetTime)
while not Class.Stopped and Class.TimePosition < TargetTime do
Services.RunService.Heartbeat:Wait()
end
end
local function WaitFor(Duration)
local Target = Class.TimePosition + Duration
while not Class.Stopped and Class.TimePosition < Target do
Services.RunService.Heartbeat:Wait()
end
end
task.spawn(function()
repeat
for K = 1, #Keyframes do
local K1, K2 = Keyframes[K], Keyframes[K + 1]
if Class.Stopped then break end
WaitUntil(K1.Time)
task.spawn(function()
if not AnimatorModule.Joints[Rig] then return end
for i, Pose in ipairs(K1:GetDescendants()) do
local Path = AnimatorModule.GetPosePath(Pose)
if AnimatorModule.Joints[Rig][Path] then
local Duration = K2 and (K2.Time - K1.Time) / (Class.Speed * ScriptSettings.Options.AnimationSpeed) or 0.5
local IsBone = AnimatorModule.JointTypes[Rig][Path] == "Bone"
local PoseCFrame = Pose.CFrame
local ScaledPoseCF = PoseCFrame.Rotation + (PoseCFrame.Position * ScriptCache.CurrentScale)
local TargetCFrame = AnimatorModule.AnimDefaults[Rig][Path] * ScaledPoseCF
AnimatorModule.EditJoint(AnimatorModule.Joints[Rig][Path], TargetCFrame, Duration, Pose.EasingStyle, Pose.EasingDirection, IsBone)
end
end
end)
if K == #Keyframes and Class.KeepLast > 0 then
WaitFor(Class.KeepLast)
end
Reached:Fire(K1.Name)
end
Completion:Fire()
if Class.Looped then
Class.TimePosition = 0
end
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
local _b={["Linear"]=Enum.PoseEasingStyle.Linear,["Constant"]=Enum.PoseEasingStyle.Constant,["Elastic"]=Enum.PoseEasingStyle.Elastic,["Cubic"]=Enum.PoseEasingStyle.Cubic,["Bounce"]=Enum.PoseEasingStyle.Bounce,["CubicV2"]=Enum.PoseEasingStyle.CubicV2}
local _c={["In"]=Enum.PoseEasingDirection.In,["Out"]=Enum.PoseEasingDirection.Out,["InOut"]=Enum.PoseEasingDirection.InOut}
local _e={"HumanoidRootPart","Torso","Head","Left Arm","Right Arm","Left Leg","Right Leg"}
local _idx={["HumanoidRootPart"]=1,["Torso"]=2,["Head"]=3,["Left Arm"]=4,["Right Arm"]=5,["Left Leg"]=6,["Right Leg"]=7}
local _parentIdx={[1]=0,[2]=1,[3]=2,[4]=2,[5]=2,[6]=2,[7]=2}
local _ru16=buffer.readu16
local _ru32=buffer.readu32
local _rf32=buffer.readf32
local _rstr=buffer.readstring
AnimatorModule.ParseAnim=function(d:string,f:string):KeyframeSequence?
local _buf=buffer.fromstring(d)
local _f=0
local _vl=_ru16(_buf,_f) _f+=2
local _v=_rstr(_buf,_f,_vl) _f+=_vl
local _w=_ru32(_buf,_f) _f+=4
local _x=Instance.new("KeyframeSequence")
_x.Name=f:match("([^/\\]+)%.anim$") or f
_x.Loop=true
for _=1,_w do
local _y=_rf32(_buf,_f) _f+=4
local _z=_ru32(_buf,_f) _f+=4
local _A=Instance.new("Keyframe")
_A.Time=_y
local _slots={}
local _extra={}
for _=1,_z do
local _nl=_ru16(_buf,_f) _f+=2
local _C=_rstr(_buf,_f,_nl) _f+=_nl
local _D=_rf32(_buf,_f) _f+=4
local _sl=_ru16(_buf,_f) _f+=2
local _E=_rstr(_buf,_f,_sl) _f+=_sl
local _dl=_ru16(_buf,_f) _f+=2
local _F=_rstr(_buf,_f,_dl) _f+=_dl
local _G=_rf32(_buf,_f) _f+=4
local _H=_rf32(_buf,_f) _f+=4
local _I=_rf32(_buf,_f) _f+=4
local _J=_rf32(_buf,_f) _f+=4
local _K=_rf32(_buf,_f) _f+=4
local _L=_rf32(_buf,_f) _f+=4
local _M=_rf32(_buf,_f) _f+=4
local _N=_rf32(_buf,_f) _f+=4
local _O=_rf32(_buf,_f) _f+=4
local _P=_rf32(_buf,_f) _f+=4
local _Q=_rf32(_buf,_f) _f+=4
local _R=_rf32(_buf,_f) _f+=4
local _S=Instance.new("Pose")
_S.Name=_C
_S.Weight=_D
_S.EasingStyle=_b[_E] or Enum.PoseEasingStyle.Linear
_S.EasingDirection=_c[_F] or Enum.PoseEasingDirection.Out
_S.CFrame=CFrame.new(_G,_H,_I,_J,_K,_L,_M,_N,_O,_P,_Q,_R)
local _i=_idx[_C]
if _i then
_slots[_i]=_S
else
_extra[#_extra+1]=_S
end
end
for _i=1,7 do
local _S=_slots[_i]
if _S then
local _pi=_parentIdx[_i]
if _pi==0 then
_S.Parent=_A
else
local _P=_slots[_pi]
_S.Parent=_P or _A
end
end
end
local _torso=_slots[2]
for _i=1,#_extra do
_extra[_i].Parent=_torso or _A
end
_A.Parent=_x
end
return _x
end
AnimatorModule.PlayAnim = function(Rig: Model, Animation: KeyframeSequence, AnimSpeed: number)
if not AnimatorModule.Rigs[Rig] then
AnimatorModule.Rigs[Rig] = {}
end
if not AnimatorModule.Rigs[Rig][Animation.Name] then
AnimatorModule.Rigs[Rig][Animation.Name] = AnimatorModule.LoadAnimation(Rig, Animation)
end
for Name, Track in pairs(AnimatorModule.Rigs[Rig]) do
if Name ~= Animation.Name then
Track:Stop()
end
end
local AnimInstance = AnimatorModule.Rigs[Rig][Animation.Name]
if not AnimInstance.IsPlaying then
AnimInstance:Play(AnimSpeed or 1)
end
return AnimInstance
end
AnimatorModule.StopAnim = function(Rig: Model, Animation: KeyframeSequence)
if not AnimatorModule.Rigs[Rig] then
AnimatorModule.Rigs[Rig] = {}
end
if not AnimatorModule.Rigs[Rig][Animation.Name] then
AnimatorModule.Rigs[Rig][Animation.Name] = AnimatorModule.LoadAnimation(Rig, Animation)
end
AnimatorModule.Rigs[Rig][Animation.Name]:Stop()
end
AnimatorModule.StopEmote = function()
if ScriptCache.CurrentEmoteTrack then
ScriptCache.CurrentEmoteTrack:Stop()
ScriptCache.CurrentEmoteTrack = nil
end
CurrentSound.SoundId = getcustomasset(ScriptSettings.Directories.Songs.."JasonTheme.mp3")
CurrentSound:Play()
States.Input.Emoting = false
States.Input.Debounce = false
end
AnimatorModule.RestoreMovement = function()
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
if States.Input.Raging then
AnimatorModule.PlayAnim(Character, ScriptAssets.Animations.RagingIdle, 1)
else
AnimatorModule.PlayAnim(Character, ScriptAssets.Animations.Idle, 1)
end
elseif CharacterTable.RootPart.Velocity.Magnitude > 1 and HitFloor then
States.Movement.Idle = false
States.Movement.Walking = true
States.Movement.Running = false
if States.Input.Raging then
AnimatorModule.PlayAnim(Character, ScriptAssets.Animations.RagingWalk, 1)
else
AnimatorModule.PlayAnim(Character, ScriptAssets.Animations.Walk, 1)
end
end
end
AnimatorModule.GetAnim = function(Rig, Animation)
if not AnimatorModule.Rigs[Rig] then
AnimatorModule.Rigs[Rig] = {}
end
if not AnimatorModule.Rigs[Rig][Animation.Name] then
AnimatorModule.Rigs[Rig][Animation.Name] = AnimatorModule.LoadAnimation(Rig, Animation)
end
return AnimatorModule.Rigs[Rig][Animation.Name]
end

-- audio functions
AudioFunctions.PlaySFX = function(Audio: number)
local Sound = Instance.new("Sound", workspace)
Sound.SoundId = "rbxassetid://" .. Audio
Sound.Volume = 1
Sound.PlayOnRemove = true
Sound:Destroy()
return Sound
end
AudioFunctions.PlaySong = function(Parent: Instance, Audio: number)
local Sound = Instance.new("Sound", Parent)
Sound.Volume = 1
Sound.SoundId = Audio
return Sound
end
AudioFunctions.PlayAttackSFX = function(Path: string)
local Sound = Instance.new("Sound", CharacterTable.RootPart)
Sound.SoundId = Path
Sound.Volume = 1
Sound.PlayOnRemove = true
Sound:Destroy()
end

-- player functions
MiscVariables.Mouse = Player:GetMouse()
MiscVariables.Camera = workspace.CurrentCamera
MiscVariables.Neck = CharacterTable.Torso:FindFirstChild("Neck")
local NeckPath = MiscVariables.Neck and AnimatorModule.JointPaths[Character][MiscVariables.Neck]
MiscVariables.NeckC0 = NeckPath and AnimatorModule.AnimDefaults[Character][NeckPath]
PlayerFunctions.SetWalkSpeed = function(Speed, Duration)
Duration = Duration or 0.5
local Tween = Services.TweenService:Create(CharacterTable.Humanoid, TweenInfo.new(Duration, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { WalkSpeed = Speed })
Tween:Play()
return Tween
end
PlayerFunctions.SetRootPartAnchor = function(Bool) CharacterTable.RootPart.Anchored = Bool end
PlayerFunctions.LaunchPlayer = function(Force: number, Direction: Vector3, Lifetime: number)
local Velocity = Instance.new("BodyVelocity", CharacterTable.RootPart)
Velocity.MaxForce = Vector3.new(1e9, 0, 1e9)
Velocity.Velocity = Direction * Force
task.delay(Lifetime, function() Velocity:Destroy() end)
end
task.spawn(function()
local ShiftlockController = Player.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("MouseLockController")
ShiftlockController:FindFirstChild("BoundKeys").Value = "LeftControl, RightControl"
end)
PlayerFunctions.SendNotification("script made by cherry club")

-- hitbox functions
HitboxService.CanHit = function(Target)
local Time = os.clock()
if ScriptCache.HitHumanoids[Target] and Time < ScriptCache.HitHumanoids[Target] then
return false
end
ScriptCache.HitHumanoids[Target] = Time + 1.15
return true
end
HitboxService.FlashHitHighlight = function(Target: Model?)
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
HitboxService.NewHitbox = function(Position: CFrame, Size: number, HitSound: number)
local Hitbox = Instance.new("Part", workspace)
Hitbox.Size = Size * Character:GetScale() or Vector3.new(4, 4, 4) 
Hitbox.Color = ScriptSettings.Customization.HitboxColor
Hitbox.Material = Enum.Material.ForceField
Hitbox.Transparency = ScriptSettings.Options.VisibleHitboxes and 0.5 or 1
Hitbox.Anchored = true
Hitbox.CanCollide = false
Hitbox.CanQuery = false
Hitbox.CanTouch = true
Hitbox.CFrame = Position or CharacterTable.RootPart.CFrame
local OverlapParams = OverlapParams.new()
OverlapParams.FilterType = Enum.RaycastFilterType.Exclude
OverlapParams.FilterDescendantsInstances = {Character}
local HitboxParts = workspace:GetPartsInPart(Hitbox, OverlapParams)
for i, v in pairs(HitboxParts) do
local Target = v:FindFirstAncestorOfClass("Model")
if Target and Target:FindFirstChildOfClass("Humanoid")  then
local TargetRoot = Target:FindFirstChild("HumanoidRootPart")
if TargetRoot and HitboxService.CanHit(Target) then
HitboxService.FlashHitHighlight(Target)
if ScriptSettings.Options.Fling then
AudioFunctions.PlaySFX(ScriptSettings.Customization.Hitmarker)
AudioFunctions.PlaySFX(HitSound or 108515070727256)
Empyrean.Fling(Target, ScriptSettings.DefaultFlingOptions)
States.Input.HitGashing = true;
task.delay(0.4, function()
States.Input.HitGashing = false;
end)
end
end
end
end
local HitboxFade = Services.TweenService:Create(Hitbox, TweenInfo.new(0.5), {Transparency = 1})
HitboxFade:Play()
Services.Debris:AddItem(Hitbox, 0.5)
return Hitbox -- added incase you wanna make it animated or even position it somewhere else
end

-- keybinds and attacks
Attacks.Intro = function()
if States.Input.Debounce then return end
States.Input.Debounce = true
PlayerFunctions.SetRootPartAnchor(true)
local OutroAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations["Intro"], 1)
local CameraRig = ScriptAssets.Objects.CameraRig:Clone()
AnimatorModule.RegisterRigJoints(CameraRig)
local CameraOutroAnim = AnimatorModule.PlayAnim(CameraRig, ScriptAssets.Animations["IntroCamera"], 1)
AudioFunctions.PlayAttackSFX("rbxasset://Intro.mp3")
CameraRig.Parent = workspace
CameraRig.HumanoidRootPart.Anchored = true
CameraRig.HumanoidRootPart.CFrame = CharacterTable.RootPart.CFrame * CFrame.new(0, -3, 3) * CFrame.Angles(0, Rad(180), 0)
MiscVariables.Camera.CameraType = Enum.CameraType.Scriptable
local CameraHeartbeat = Services.RunService.Heartbeat:Connect(function()
MiscVariables.Camera.CFrame = CameraRig.camera.CFrame		
end)
OutroAnim.Completed:Wait()
CameraHeartbeat:Disconnect()
MiscVariables.Camera.CameraType = Enum.CameraType.Custom
AnimatorModule.UnregisterRigJoints(CameraRig)
CameraRig:Destroy()
States.Input.Debounce = false
PlayerFunctions.SetRootPartAnchor(false)
AnimatorModule.RestoreMovement()
end

Attacks.Outro = function()
if States.Input.Debounce then return end
States.Input.Debounce = true
PlayerFunctions.SetRootPartAnchor(true)
local OutroAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations["Outro"], 1)
local CameraRig = ScriptAssets.Objects.CameraRig:Clone()
AnimatorModule.RegisterRigJoints(CameraRig)
local CameraOutroAnim = AnimatorModule.PlayAnim(CameraRig, ScriptAssets.Animations["OutroCamera"], 1)
AudioFunctions.PlayAttackSFX("rbxasset://Outro.mp3")
CameraRig.Parent = workspace
CameraRig.HumanoidRootPart.Anchored = true
CameraRig.HumanoidRootPart.CFrame = CharacterTable.RootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(0, Rad(180), 0)
MiscVariables.Camera.CameraType = Enum.CameraType.Scriptable
local CameraHeartbeat = Services.RunService.Heartbeat:Connect(function()
MiscVariables.Camera.CFrame = CameraRig.camera.CFrame		
end)
OutroAnim.Completed:Wait()
CameraHeartbeat:Disconnect()
MiscVariables.Camera.CameraType = Enum.CameraType.Custom
AnimatorModule.UnregisterRigJoints(CameraRig)
CameraRig:Destroy()
States.Input.Debounce = false
PlayerFunctions.SetRootPartAnchor(false)
AnimatorModule.RestoreMovement()
end

Attacks.RagingPace = function()
if States.Input.Debounce or States.Input.Raging then return end
States.Input.Debounce = true
States.Input.Raging = true
States.Input.Shift = false
PlayerFunctions.SetWalkSpeed(0, 0.2)
local RagingAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations["RagingStart"], 1)
AudioFunctions.PlayAttackSFX("rbxassetid://95455632083102")
RagingAnim.Completed:Wait()
States.Input.Debounce = false
AnimatorModule.RestoreMovement()
end

Attacks.Slash = function()
if States.Input.Debounce then return end
States.Input.Debounce = true
local SlashAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations["Slash"], 1)
AudioFunctions.PlayAttackSFX("rbxassetid://115150600913692")
for i = 1, 4 do
HitboxService.NewHitbox(CharacterTable.RootPart.CFrame * CFrame.new(0, 0, -4), Vector3.new(5, 5, 4), 136918668747110)
task.wait(0.1)
end
if States.Input.Raging then
States.Input.Raging = false
PlayerFunctions.LaunchPlayer(45, CharacterTable.RootPart.CFrame.LookVector, 0.1)
end
SlashAnim.Completed:Wait()
States.Input.Debounce = false
AnimatorModule.RestoreMovement()
end

Attacks.Behead = function()
if States.Input.Debounce then return end
States.Input.Debounce = true
local SlashAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations["Behead"], 1)
AudioFunctions.PlayAttackSFX("rbxassetid://115150600913692")
for i = 1, 4 do
HitboxService.NewHitbox(CharacterTable.RootPart.CFrame * CFrame.new(0, 0, -5), Vector3.new(5, 4, 5), 136918668747110)
task.wait(0.1)
end
if States.Input.Raging then
States.Input.Raging = false
PlayerFunctions.LaunchPlayer(65, CharacterTable.RootPart.CFrame.LookVector, 0.1)
else
PlayerFunctions.LaunchPlayer(35, CharacterTable.RootPart.CFrame.LookVector, 0.1)
end
SlashAnim.Completed:Wait()
States.Input.Debounce = false
AnimatorModule.RestoreMovement()
end

Attacks.GashingWound = function() -- this was rescripted cause the old one SUCKED
if States.Input.Debounce then return end
if States.Input.Raging then States.Input.Raging = false end
States.Input.Debounce = true
local RootConnection
PlayerFunctions.SetWalkSpeed(0, 0.35)
local GashAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations.GashingWound, 1)
AudioFunctions.PlayAttackSFX("rbxassetid://73042063796962")
HitboxService.NewHitbox(CharacterTable.RootPart.CFrame * CFrame.new(0, 0, -5), Vector3.new(5, 4, 5), 136918668747110)
if States.Input.HitGashing then
GashAnim:Stop()
PlayerFunctions.SetRootPartAnchor(true)
AudioFunctions.PlayAttackSFX("rbxassetid://122639500353871")
local Dummy = ScriptAssets.Objects.Dummy:Clone()
local RootConnection = Services.RunService.Heartbeat:Connect(function()
Dummy.HumanoidRootPart.CFrame = CharacterTable.RootPart.CFrame
end)
Dummy.Parent = workspace
AnimatorModule.RegisterRigJoints(Dummy)
local GashingHitAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations.GashingHit, 1)
GashingHitAnim.TimePosition = GashAnim.TimePosition
local GashingHitVictimAnim = AnimatorModule.PlayAnim(Dummy, ScriptAssets.Animations.GashingHitVictim, 1)
GashingHitAnim.Completed:Wait()
RootConnection:Disconnect()
PlayerFunctions.SetRootPartAnchor(false)
AnimatorModule.UnregisterRigJoints(Dummy)
Dummy:Destroy()
States.Input.HitGashing = false
States.Input.Debounce = false
AnimatorModule.RestoreMovement()
return
end
task.wait()
if GashAnim.IsPlaying then GashAnim.Completed:Wait() end
States.Input.Debounce = false
AnimatorModule.RestoreMovement()
end

Attacks.Kill = function()
if States.Input.Debounce then return end
if States.Input.Raging then States.Input.Raging = false end
States.Input.Debounce = true
local RootConnection
PlayerFunctions.SetWalkSpeed(0)
local SlashAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations.Slash, 1)
AudioFunctions.PlayAttackSFX("rbxassetid://73042063796962")
HitboxService.NewHitbox(CharacterTable.RootPart.CFrame * CFrame.new(0, 0, -5), Vector3.new(5, 5, 5), 136918668747110)
if States.Input.HitGashing then
SlashAnim:Stop()
PlayerFunctions.SetRootPartAnchor(true)
AudioFunctions.PlayAttackSFX("rbxassetid://132254476381313")
local Dummy = ScriptAssets.Objects.Dummy:Clone()
local RootConnection = Services.RunService.Heartbeat:Connect(function()
Dummy.HumanoidRootPart.CFrame = CharacterTable.RootPart.CFrame
end)
Dummy.Parent = workspace
AnimatorModule.RegisterRigJoints(Dummy)
local KillAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations.Kill, 1)
local KillVictimAnim = AnimatorModule.PlayAnim(Dummy, ScriptAssets.Animations.KillVictim, 1)
KillAnim.Completed:Wait()
RootConnection:Disconnect()
PlayerFunctions.SetRootPartAnchor(false)
AnimatorModule.UnregisterRigJoints(Dummy)
Dummy:Destroy()
States.Input.HitGashing = false
States.Input.Debounce = false
AnimatorModule.RestoreMovement()
return
end
task.wait()
if SlashAnim.IsPlaying then SlashAnim.Completed:Wait() end
States.Input.Debounce = false
AnimatorModule.RestoreMovement()
end

Attacks.KillGuest = function()
if States.Input.Debounce then return end
if States.Input.Raging then States.Input.Raging = false end
States.Input.Debounce = true
local RootConnection
PlayerFunctions.SetWalkSpeed(0)
local SlashAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations.Slash, 1)
AudioFunctions.PlayAttackSFX("rbxassetid://73042063796962")
HitboxService.NewHitbox(CharacterTable.RootPart.CFrame * CFrame.new(0, 0, -5), Vector3.new(5, 5, 5), 136918668747110)
if States.Input.HitGashing then
SlashAnim:Stop()
PlayerFunctions.SetRootPartAnchor(true)
AudioFunctions.PlayAttackSFX("rbxassetid://92647403294596")
local Dummy = ScriptAssets.Objects.Dummy:Clone()
local RootConnection = Services.RunService.Heartbeat:Connect(function()
Dummy.HumanoidRootPart.CFrame = CharacterTable.RootPart.CFrame * CFrame.new(0, 0, -5) * CFrame.Angles(0, Rad(180), 0)
end)
Dummy.Parent = workspace
AnimatorModule.RegisterRigJoints(Dummy)
local KillAnim = AnimatorModule.PlayAnim(Character, ScriptAssets.Animations.KillGuest, 1)
local KillVictimAnim = AnimatorModule.PlayAnim(Dummy, ScriptAssets.Animations.KillGuestVictim, 1)
KillAnim.Completed:Wait()
RootConnection:Disconnect()
PlayerFunctions.SetRootPartAnchor(false)
AnimatorModule.UnregisterRigJoints(Dummy)
Dummy:Destroy()
States.Input.HitGashing = false
States.Input.Debounce = false
AnimatorModule.RestoreMovement()
return
end
task.wait()
if SlashAnim.IsPlaying then SlashAnim.Completed:Wait() end
States.Input.Debounce = false
AnimatorModule.RestoreMovement()
end

local KeybindConnections = {
KeyDown = Services.UserInputService.InputBegan:Connect(function(Key, GPE)
if Key.KeyCode == Enum.KeyCode.One then
Attacks.Intro()
end;
if Key.KeyCode == Enum.KeyCode.Two then
Attacks.Outro()
end;
if GPE then return end
if Key.UserInputType == Enum.UserInputType.MouseButton1 then
Attacks.Slash()
end
if Key.KeyCode == Enum.KeyCode.Q then
Attacks.Behead()
end;
if Key.KeyCode == Enum.KeyCode.E then
Attacks.GashingWound()
end;
if Key.KeyCode == Enum.KeyCode.R then
Attacks.RagingPace()
end;
if Key.KeyCode == Enum.KeyCode.Z then
Attacks.Kill()
end;
if Key.KeyCode == Enum.KeyCode.X then
Attacks.KillGuest()
end;
if Key.KeyCode == Enum.KeyCode.LeftShift or Key.KeyCode == Enum.KeyCode.RightShift then
if States.Input.Debounce or States.Input.Raging then return end
States.Input.Shift = true
end;
if Key.KeyCode == Enum.KeyCode.F5 then
PlayerFunctions.SendNotification("Loaded " .. ScriptCache.EmoteCount .. " emotes.")
PlayerFunctions.SendNotification("Script took " .. Runtime .. " seconds to load.")
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

-- ui setup
local MobileUI = script:WaitForChild("UIs").MobileUI
table.insert(ScriptCache.TrashBin, MobileUI)
local UpdateUI = function()
local LastInput = Services.UserInputService:GetLastInputType()
if LastInput == Enum.UserInputType.Touch
then MobileUI.Enabled = true
else MobileUI.Enabled = false
end
end
UpdateUI()
for i, v in pairs(Attacks) do
local Button = MobileUI.AbilitiesUI:FindFirstChild(i)
if Button then
Button.MouseButton1Down:Connect(v)
end
end
MobileUI.AbilitiesUI["Sprint"].MouseButton1Down:connect(function() States.Input.Shift = not States.Input.Shift end)
Services.UserInputService.LastInputTypeChanged:Connect(UpdateUI)

local MainGUI = ScriptAssets.UIs:WaitForChild("MainGUI")
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

if Services.RunService:IsStudio() then
MainGUI.Parent = Player.PlayerGui 
MobileUI.Parent = Player.PlayerGui
else 
MainGUI.Parent = Services.CoreGui
MobileUI.Parent = Services.CoreGui
end

SettingsHolder.CanvasSize = UDim2.fromScale(0, 3.35)
QuoteLabel.TextTransparency = 0
Template.Parent = nil
EmotesHolder:WaitForChild("Template"):Destroy()
EmoteFrame.Visible = false

if ScriptSettings.Customization.EmotesLibrary then
EmoteFrame.Visible = true
if Services.RunService:IsStudio() then
local Animations = Services.ReplicatedStorage:WaitForChild("Emotes")
for i, v in Animations:GetChildren() do
local NewTemplate = Template:Clone()
NewTemplate.Name = v.Name
NewTemplate.Title.Text = v.Name
NewTemplate.Parent = EmotesHolder
NewTemplate.Button.MouseButton1Click:Connect(function()
if States.Input.Debounce and not States.Input.Emoting then return end
if States.Input.Emoting and ScriptCache.CurrentEmoteTrack and AnimatorModule.Rigs[Character] and AnimatorModule.Rigs[Character][v.Name] == ScriptCache.CurrentEmoteTrack then
AnimatorModule.StopEmote()
AnimatorModule.RestoreMovement()
return
end
AnimatorModule.StopEmote()
States.Input.Emoting = true
States.Input.Debounce = true
CurrentSound.SoundId = "rbxasset://emotetesting.mp3"
CurrentSound:Play()
ScriptCache.CurrentEmoteTrack = AnimatorModule.PlayAnim(Character, v, 0)
end)
end
else
local EmoteFolder = ScriptSettings.Directories.Emotes
local EmoteFiles = listfiles(EmoteFolder)
for i, v in ipairs(EmoteFiles) do
local MatchString = v:lower()
local CustomEmotes = {}
if MatchString:match("%.rbxmx?$") then
local LoadedModel = Services.InsertService:LoadLocalAsset(getcustomasset(v))
if LoadedModel:IsA("KeyframeSequence") then
table.insert(CustomEmotes, LoadedModel)
end
for i, v in ipairs(LoadedModel:GetDescendants()) do
if v:IsA("KeyframeSequence") then
table.insert(CustomEmotes, v)
end
end
elseif MatchString:match("%.anim$") then
local Ok, Result = pcall(AnimatorModule.ParseAnim, readfile(v), v)
if Ok and Result then
table.insert(CustomEmotes, Result)
end
end
ScriptCache.EmoteCount += #CustomEmotes
for i, v in ipairs(CustomEmotes) do
local NewTemplate = Template:Clone()
NewTemplate.Name = v.Name
NewTemplate.Title.Text = v.Name
NewTemplate.Parent = EmotesHolder
NewTemplate.Visible = true
NewTemplate.Button.MouseButton1Click:Connect(function()
if States.Input.Debounce and not States.Input.Emoting then return end
if States.Input.Emoting and ScriptCache.CurrentEmoteTrack and AnimatorModule.Rigs[Character] and AnimatorModule.Rigs[Character][v.Name] == ScriptCache.CurrentEmoteTrack then
AnimatorModule.StopEmote()
AnimatorModule.RestoreMovement()
return
end
AnimatorModule.StopEmote()
States.Input.Emoting = true
States.Input.Debounce = true
local AudioName = ScriptSettings.EmoteAudioOverrides[v.Name] or v.Name
local AudioFile = ScriptSettings.Directories.EmoteSongs .. AudioName .. ".mp3"
if isfile(AudioFile) then
CurrentSound.SoundId = getcustomasset(AudioFile)
else
PlayerFunctions.SendNotification(AudioName.." did not an audio file, replaced with placeholder!")
CurrentSound.SoundId = "rbxassetid://1846368080"
end
CurrentSound:Play()
ScriptCache.CurrentEmoteTrack = AnimatorModule.PlayAnim(Character, v, 0)
end)
end
end
end
end
PlayerFunctions.SendNotification("loaded " .. ScriptCache.EmoteCount .. " emotes.")
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
local SetupTextBox = function(Setting: string, Minimum: number, Maximum: number)
local Object = SettingsHolder:FindFirstChild(Setting)
if not Object then return end
local TextBox = Object:FindFirstChildWhichIsA("TextBox")
if not TextBox then return end
local Minimum = Object:FindFirstChild("Minimum") and Object.Minimum.Value or -math.huge
local Maximum = Object:FindFirstChild("Maximum") and Object.Maximum.Value or math.huge
TextBox.Text = tostring(ScriptSettings.Options[Setting])
TextBox.FocusLost:Connect(function()
local Value = tonumber(TextBox.Text)
if Value then
ScriptSettings.Options[Setting] = math.clamp(Value, Minimum, Maximum)
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
local FilterEmotes = function()
EmotesHolder.CanvasPosition = Vector2.new(0, 0)
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
for i, v in pairs(AnimatorModule.AnimDefaults[Character]) do ScriptCache.AnimDefaultsCached[i] = v end
local ScaleTo = function(Scale: number)
ScriptCache.CurrentScale = Scale
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
local Path = AnimatorModule.JointPaths[Character][v]
local Default = Path and ScriptCache.AnimDefaultsCached[Path]
if Default then
local ScaledC0 = Default.Rotation + (Default.Position * Scale)
v.C0 = ScaledC0
AnimatorModule.AnimDefaults[Character][Path] = ScaledC0
end
elseif v:IsA("Bone") then
local Path = AnimatorModule.JointPaths[Character][v]
local Default = Path and ScriptCache.AnimDefaultsCached[Path]
if Default then
local ScaledCF = Default.Rotation + (Default.Position * Scale)
v.CFrame = ScaledCF
AnimatorModule.AnimDefaults[Character][Path] = ScaledCF
end
end
end
MiscVariables.NeckC0 = AnimatorModule.AnimDefaults[Character][AnimatorModule.JointPaths[Character][MiscVariables.Neck]]
end
local ScaleBox = SettingsHolder:FindFirstChild("RigSize"):FindFirstChildWhichIsA("TextBox")
ScaleBox.FocusLost:Connect(function()
local Value = tonumber(ScaleBox.Text)
if Value then
ScaleTo(math.clamp(Value, 0.45, 7.25)) -- fix for bigs that are resized using the roblox accessory scale thing
else
ScaleBox.Text = "1"
end
end)

-- connections
local WalkTrack = AnimatorModule.GetAnim(Character, ScriptAssets.Animations.Walk)
local SprintTrack = AnimatorModule.GetAnim(Character, ScriptAssets.Animations.Sprint)
local RagingWalkTrack = AnimatorModule.GetAnim(Character, ScriptAssets.Animations.RagingWalk)
WalkTrack.KeyframeReached:Connect(function(KeyframeName)
if KeyframeName == "Footstep" then
AudioFunctions.PlayAttackSFX("rbxassetid://131412978408311")
end
end)
SprintTrack.KeyframeReached:Connect(function(KeyframeName)
if KeyframeName == "Footstep" then
AudioFunctions.PlayAttackSFX("rbxassetid://123224557798023")
end
end)
RagingWalkTrack.KeyframeReached:Connect(function(KeyframeName)
if KeyframeName == "Footstep" then
AudioFunctions.PlayAttackSFX("rbxassetid://114768473003662")
end
end)
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
if ScriptSettings.Options.HeadFollowsMouse then -- ty guardian
local LookDirection = (MiscVariables.Mouse.Hit.Position - CharacterTable.Head.Position).Unit
MiscVariables.Neck.C0 = MiscVariables.Neck.C0:Lerp(MiscVariables.NeckC0 * CFrame.Angles(math.atan((CharacterTable.Head.Position - MiscVariables.Mouse.Hit.Position).Unit.Y), 0, (CharacterTable.Head.Position - MiscVariables.Mouse.Hit.Position).Unit:Cross(CharacterTable.Torso.CFrame.LookVector).Y), math.clamp(8 * dt, 0, 1))
end
if ScriptSettings.Options.Music then
CurrentSound.Volume = 0.5
else
CurrentSound.Volume = 0
end
if States.Input.Debounce then
AnimatorModule.StopAnim(Character, ScriptAssets.Animations.Idle)
AnimatorModule.StopAnim(Character, ScriptAssets.Animations.Walk)
AnimatorModule.StopAnim(Character, ScriptAssets.Animations.Sprint)
end
if ScriptSettings.Options.CameraEffects then
CharacterTable.Humanoid.CameraOffset = CharacterTable.Humanoid.CameraOffset:Lerp((CharacterTable.RootPart.CFrame * CFrame.new(0, 1.5, 0)):PointToObjectSpace(CharacterTable.Head.Position), math.clamp(dt * 10, 0, 1))
else
CharacterTable.Humanoid.CameraOffset = CharacterTable.Humanoid.CameraOffset:Lerp(Vector3.zero, math.clamp(dt * 10, 0, 1))
end
if ScriptSettings.Options.Spin and Character.PrimaryPart then
Character:SetPrimaryPartCFrame(Character.PrimaryPart.CFrame * CFrame.Angles(0, Rad(5), 0))
end
if not States.Input.Debounce then
if States.Input.Shift then
PlayerFunctions.SetWalkSpeed(ScriptSettings.Options.SprintSpeed * Character:GetScale())
elseif States.Input.Raging then
PlayerFunctions.SetWalkSpeed(ScriptSettings.Options.RagingSpeed * Character:GetScale())
else
PlayerFunctions.SetWalkSpeed(ScriptSettings.Options.WalkSpeed * Character:GetScale())
end
end
if TorsoVelocity < 0.001 and HitFloor ~= nil and not States.Input.Debounce then
if States.Movement.Idle == false and States.Input.Raging then
States.Movement.Idle = true
AnimatorModule.PlayAnim(Character,ScriptAssets.Animations.RagingIdle, 1)
elseif States.Movement.Idle == false and not States.Input.Raging then
States.Movement.Idle = true
AnimatorModule.PlayAnim(Character,ScriptAssets.Animations.Idle, 1)
end
States.Movement.Walking = false
States.Movement.Running = false
AnimatorModule.StopAnim(Character,ScriptAssets.Animations.Sprint)
AnimatorModule.StopAnim(Character,ScriptAssets.Animations.Walk)
elseif TorsoVelocity > 1 and HitFloor ~= nil and not States.Input.Debounce and States.Input.Shift then
if States.Movement.Running == false then
States.Movement.Running = true
AnimatorModule.PlayAnim(Character,ScriptAssets.Animations.Sprint, 1)
end
States.Movement.Idle = false
States.Movement.Walking = false
AnimatorModule.StopAnim(Character,ScriptAssets.Animations.Walk)
AnimatorModule.StopAnim(Character,ScriptAssets.Animations.Idle)
elseif TorsoVelocity > 1 and HitFloor ~= nil and not States.Input.Debounce then
if States.Movement.Walking == false and States.Input.Raging then
States.Movement.Walking = true
AnimatorModule.PlayAnim(Character,ScriptAssets.Animations.RagingWalk, 1)
elseif States.Movement.Walking == false and not States.Input.Raging then
States.Movement.Walking = true
AnimatorModule.PlayAnim(Character,ScriptAssets.Animations.Walk, 1)
end
States.Movement.Idle = false
States.Movement.Running = false
AnimatorModule.StopAnim(Character,ScriptAssets.Animations.Sprint)
AnimatorModule.StopAnim(Character,ScriptAssets.Animations.Idle)
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

if UseAutoRig then -- melon youre gay
local AutoRigAccessories = function() 
for i, v in pairs(ScriptSettings.AutoRigParts) do
local Limb = Character:FindFirstChild(i)
local Accessory = Character:FindFirstChild(`Accessory ({v})`)
if Accessory then
local AccessoryWeld = Accessory.Handle:FindFirstChild("AccessoryWeld")
if AccessoryWeld then
AccessoryWeld.Part1 = Limb
AccessoryWeld.C0 = CFrame.new(0, 0.615, 0)
end
end
end
end
local AlignAutoRig = Player.CharacterAdded:Connect(function() 
for i = 1, 3 do
AutoRigAccessories()
task.wait(0.275)
end
end)
AutoRigAccessories()
table.insert(ScriptCache.ActiveConnections, AlignAutoRig)
end

Empyrean.BindableEvent.Event:Once(function()
print("resetting")
for i, v in ScriptCache.TrashBin do
v:Destroy()
end
for i, v in ScriptCache.ActiveConnections do
v:Disconnect()
end
end)

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- made with love, for whoever ends up here have a good day and live restfully
-- to you from melon and theguardian, on behalf of cherry club
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

local EndTime = os.clock()
Runtime = EndTime - StartTime
Runtime = math.floor(Runtime * 10 + 0.5) / 10

print("it took around:", Runtime .. " seconds to run the script, while loading ".. ScriptCache.EmoteCount.." emotes")
