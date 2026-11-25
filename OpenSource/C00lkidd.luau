-- [[ C00LKIDD : Reanimate ]] --
local CherryClub1a01 = true -- buggy but fixed (?)

-- do not touch vars below
local CherryClub1a02
local CherryClub1a03 = nil
local CherryClub1a04 = {}
local CherryClub1a05 = false -- do NOT touch this (pretty pls with a big cherry on the top)
local CherryClub1a06 -- cause we forgot that folders mess with welding (oops)

local CherryClub1a07 = {
CoreGui = game:GetService("CoreGui");
InsertService = game:GetService("InsertService");
ReplicatedStorage = game:GetService("ReplicatedStorage");
Players = game:GetService("Players");
UserInputService = game:GetService("UserInputService");
TweenService = game:GetService("TweenService");
RunService = game:GetService("RunService");
Debris = game:GetService("Debris");
StarterGui = game:GetService("StarterGui");
HttpService = game:GetService("HttpService");
}

local CherryClub1a08 = getcustomasset
local CherryClub1a09 = readfile
local CherryClub1a0a = isfile
local CherryClub1a0b = listfiles
local CherryClub1a0c = replicatesignal
local CherryClub1a0d = sethiddenproperty
local CherryClub1a0e = setscriptable
local CherryClub1a0f = script

local CherryClub1a10 = math.rad

local CherryClub1a11 = {}
local CherryClub1a12 = {}
local CherryClub1a13 = {}
local CherryClub1a14 = {}
local CherryClub1a15 = {}
local CherryClub1a16 = {}
local CherryClub1a17 = {}
local CherryClub1a18 = {}
local CherryClub1a19 = {}

local CherryClub1a1a = {
    UpdateSong = nil
}

local CherryClub1a1b = {
AnimDefaults = {};
Joints = {};
JointTypes = {};
Rigs = {};
JointPaths = {};
}

local CherryClub1a1c = {
Movement = {
Idle = false;
Running = false;
Walking = false;
};
Input = {
Emoting = false;
Debounce = false;
Shift = false;
LandedAttack = false;
};
}

local CherryClub1a1d = {
TrashBin = {};
ActiveConnections = {};
HitHumanoids = {};
CurrentEmoteTrack = nil;
AnimDefaultsCached = table.clone(CherryClub1a1b.AnimDefaults);
CurrentScale = 1;
EmoteCount = 0;
IsStudio = CherryClub1a07.RunService:IsStudio();
RequiredAssets = {
RBXM = {Link = "https://github.com/MelonsStuff/FEVerse/raw/refs/heads/main/RBXMs/c00lkidd.rbxm", Name = "c00lkidd.rbxm"},
},
MP3Files = {},
CurrentSongIndex = 1,
CurrentTimePosition = 1,
}

local CherryClub1a1e = {
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
Main = "CherryClub/";
RBXMs ="CherryClub/RBXMs/";
Sounds = "CherryClub/Sounds/";
Songs = "CherryClub/Songs/";
EmoteSongs = "CherryClub/EmoteSongs/";
Emotes = "CherryClub/Emotes/";
Lyrics = "CherryClub/Lyrics/";
};
EmoteAudioOverrides = {};
Customization = {
EmotesLibrary = nil;
HitboxColor = Color3.fromRGB(255, 255, 255);
Hitmarker = 103397225855135;
};
Options = {
SprintSpeed = 28;
WalkSpeed = 9;
AnimationBlending = 0.55;
AnimationSpeed = 1;
Fling = true;
ClickFling = true;
MusicEnabled = true;
SFXEnabled = true;
CameraEffects = true;
InfiniteJump = true;
Spin = false;
HeadFollowsMouse = false;
VisibleHitboxes = true;
LyricsEnabled = true;
LyricsAboveHead = true;
CensorLyrics = true;
};
}

CherryClub1a14.SendNotification = function(CherryClub1a1f)  
if CherryClub1a07.RunService:IsStudio() then
print("Notification: "..CherryClub1a1f) -- stupid corescripts
else
CherryClub1a07.StarterGui:SetCore("SendNotification",{
Title = "Cherry Club Notification",
Text = CherryClub1a1f,
})
end
end

if CherryClub1a1d.IsStudio then
CherryClub1a1e.Customization.EmotesLibrary = false
CherryClub1a0f = CherryClub1a0f.Assets
else 
CherryClub1a1e.Customization.EmotesLibrary = true
pcall(function()
CherryClub1a1e.EmoteAudioOverrides = loadstring(game:HttpGet("https://raw.githubusercontent.com/MelonsStuff/FEVerse/refs/heads/main/Miscellaneous/EmoteAudioOverrides.luau"))()
end)
end

if not CherryClub1a1d.IsStudio then
local CherryClub1a20 = loadstring(game:HttpGet("https://gist.githubusercontent.com/MelonsStuff/a003ea305dd302eab1f8d372daed38b4/raw/9db59962b28555fd699a7c29891efb85d45677ab/gistfile1.txt"))()
for CherryClub1a21, CherryClub1a22 in pairs(CherryClub1a1e.Directories) do CherryClub1a20.EnsureFolder(CherryClub1a22) end
task.spawn(function() CherryClub1a20.DownloadFile(CherryClub1a1e.Directories.RBXMs, CherryClub1a1d.RequiredAssets.RBXM.Name, CherryClub1a1d.RequiredAssets.RBXM.Link) end)
CherryClub1a14.SendNotification("we are downloading the file pls wait")
CherryClub1a0f = CherryClub1a07.InsertService:LoadLocalAsset(CherryClub1a08(CherryClub1a1e.Directories.RBXMs..CherryClub1a1d.RequiredAssets.RBXM.Name))
end

CherryClub1a15.Animations = CherryClub1a0f:WaitForChild("Animations")
CherryClub1a15.Objects = CherryClub1a0f:WaitForChild("Objects")
CherryClub1a15.UIs = CherryClub1a0f:WaitForChild("UIs")

--reanim here
if not CherryClub1a1d.IsStudio then
do
local CherryClub1a23 = {}
local CherryClub1a24 = {}
local CherryClub1a25 = {}
local CherryClub1a26 = nil
local CherryClub1a27 = {}
local CherryClub1a28 = CFrame
local CherryClub1a29 = CherryClub1a28.identity
local CherryClub1a2a = CherryClub1a28.lookAt
local CherryClub1a2b = CherryClub1a28.new
local CherryClub1a2c = nil
local CherryClub1a2d = nil
local CherryClub1a2e = Enum
local CherryClub1a2f = CherryClub1a2e.CameraType.Custom
local CherryClub1a30 = CherryClub1a2e.CoreGuiType.Health
local CherryClub1a31 = CherryClub1a2e.HumanoidRigType
local CherryClub1a32 = CherryClub1a31.R6
local CherryClub1a33 = CherryClub1a2e.HumanoidStateType.Dead
local CherryClub1a34 = CherryClub1a2e.HumanoidStateType.Physics
local CherryClub1a35 = CherryClub1a2e.HumanoidStateType.Freefall

local CherryClub1a36 = CherryClub1a2e.MouseBehavior.LockCenter
local CherryClub1a37 = CherryClub1a2e.UserInputType
local CherryClub1a38 = CherryClub1a37.MouseButton1
local CherryClub1a39 = CherryClub1a37.Touch
local CherryClub1a3a = {}
local CherryClub1a3b = game
local CherryClub1a3c = CherryClub1a3b.Clone
local CherryClub1a3d = CherryClub1a3b.Close
local CherryClub1a3e = CherryClub1a3d.Connect
local CherryClub1a3f = CherryClub1a3e(CherryClub1a3d, function() end).Disconnect
local CherryClub1a40 = CherryClub1a3d.Wait
local CherryClub1a41 = CherryClub1a3b.Destroy
local CherryClub1a42 = CherryClub1a3b.FindFirstAncestorOfClass
local CherryClub1a43 = CherryClub1a3b.FindFirstAncestorWhichIsA
local CherryClub1a44 = CherryClub1a3b.FindFirstChild
local CherryClub1a45 = CherryClub1a3b.FindFirstChildOfClass
local CherryClub1a46 = CherryClub1a45(CherryClub1a3b, "Players")
local CherryClub1a47 = CherryClub1a46.CreateHumanoidModelFromDescription
local CherryClub1a48 = CherryClub1a46.GetPlayers
local CherryClub1a49 = CherryClub1a46.LocalPlayer
local CherryClub1a4a = CherryClub1a49.CharacterAdded
local CherryClub1a4b = CherryClub1a49:GetMouse()
local CherryClub1a4c = CherryClub1a49.Kill
local CherryClub1a4d = CherryClub1a45(CherryClub1a3b, "RunService")
local CherryClub1a4e = CherryClub1a4d.PostSimulation
local CherryClub1a4f = CherryClub1a4d.PreRender
local CherryClub1a50 = CherryClub1a4d.PreSimulation
local CherryClub1a51 = CherryClub1a45(CherryClub1a3b, "StarterGui")
local CherryClub1a52 = CherryClub1a51.GetCoreGuiEnabled
local CherryClub1a53 = CherryClub1a51.SetCore
local CherryClub1a54 = CherryClub1a51.SetCoreGuiEnabled
local CherryClub1a55 = CherryClub1a45(CherryClub1a3b, "Workspace")
local CherryClub1a56 = CherryClub1a55.FallenPartsDestroyHeight
if CherryClub1a55.FallenPartsDestroyHeight then CherryClub1a55.FallenPartsDestroyHeight = -50000 end -- finally
local CherryClub1a57 = CherryClub1a56 - 0.7
local CherryClub1a58 = CherryClub1a3b.FindFirstChildWhichIsA
local CherryClub1a59 = CherryClub1a45(CherryClub1a3b, "UserInputService")
local CherryClub1a5a = CherryClub1a59.InputBegan
local CherryClub1a5b = CherryClub1a59.IsMouseButtonPressed
local CherryClub1a5c = CherryClub1a3b.GetChildren
local CherryClub1a5d = CherryClub1a3b.GetDescendants
local CherryClub1a5e = CherryClub1a3b.GetPropertyChangedSignal
local CherryClub1a5f = CherryClub1a5e(CherryClub1a55, "CurrentCamera")
local CherryClub1a60 = CherryClub1a5e(CherryClub1a59, "MouseBehavior")
local CherryClub1a61 = CherryClub1a3b.IsA
local CherryClub1a62 = CherryClub1a3b.IsDescendantOf
local CherryClub1a63 = {}
local CherryClub1a64 = Instance.new
local CherryClub1a65 = CherryClub1a64("Animation")
local CherryClub1a66 = CherryClub1a64("Animation")
local CherryClub1a67 = CherryClub1a64("HumanoidDescription")
local CherryClub1a68 = CherryClub1a47(CherryClub1a46, CherryClub1a67, CherryClub1a32)
local CherryClub1a69 = CherryClub1a47(CherryClub1a46, CherryClub1a67, CherryClub1a31.R15)
local CherryClub1a6a = CherryClub1a67.SetAccessories
local CherryClub1a6b = CherryClub1a68.BreakJoints
local CherryClub1a6c = CherryClub1a68.Head
local CherryClub1a6d = CherryClub1a6c.BreakJoints
local CherryClub1a6e = CherryClub1a6c.GetJoints
local CherryClub1a6f = CherryClub1a6c.IsGrounded
local CherryClub1a70 = CherryClub1a68.Humanoid
local CherryClub1a71 = CherryClub1a70.ChangeState
local CherryClub1a72 = CherryClub1a70.EquipTool
local CherryClub1a73 = CherryClub1a70.GetAppliedDescription
local CherryClub1a74 = CherryClub1a70.GetPlayingAnimationTracks
local CherryClub1a75 = CherryClub1a70.LoadAnimation
local CherryClub1a76 = CherryClub1a70.Move
local CherryClub1a77 = CherryClub1a70.UnequipTools
local CherryClub1a78 = CherryClub1a68.ScaleTo
local CherryClub1a79 = false
local CherryClub1a7a = nil
local CherryClub1a7b = false
local CherryClub1a7c = false
local CherryClub1a7d = false
local CherryClub1a7e = nil
local CherryClub1a7f = math
local CherryClub1a80 = CherryClub1a7f.random
local CherryClub1a81 = CherryClub1a7f.sin
local CherryClub1a82 = CherryClub1a7f.pi
local CherryClub1a83 = 0 / 0
local CherryClub1a84 = Vector3.new(CherryClub1a83, CherryClub1a83, CherryClub1a83)
local CherryClub1a85 = next
local CherryClub1a86 = nil
local CherryClub1a87 = nil
local CherryClub1a88 = nil
local CherryClub1a89 = nil
local CherryClub1a8a = nil
local CherryClub1a8b = nil
local CherryClub1a8c = nil
local CherryClub1a8d = nil
local CherryClub1a8e = nil
local CherryClub1a8f = nil
local CherryClub1a90 = nil
local CherryClub1a91 = nil
local CherryClub1a92 = nil
local CherryClub1a93 = nil
local CherryClub1a94 = nil
local CherryClub1a95 = nil
local CherryClub1a96
local CherryClub1a97 = os.clock
local CherryClub1a98 = nil
local CherryClub1a99 = {}

local CherryClub1a9a = nil
local CherryClub1a9b = nil
local CherryClub1a9c = nil
local CherryClub1a9d = string.find
local CherryClub1a9e = table
local CherryClub1a9f = CherryClub1a9e.clear
local CherryClub1aa0 = CherryClub1a9e.find
local CherryClub1aa1 = CherryClub1a9e.insert
local CherryClub1aa2 = CherryClub1a9e.remove
local CherryClub1aa3 = {}
local CherryClub1aa4 = task
local CherryClub1aa5 = CherryClub1aa4.defer
local CherryClub1aa6 = CherryClub1aa4.spawn
local CherryClub1aa7 = CherryClub1aa4.wait
local CherryClub1aa8 = nil
local CherryClub1aa9 = {}
local CherryClub1aaa = Vector3
local CherryClub1aab = CherryClub1aaa.new
local CherryClub1aac = CherryClub1aab(0, -16384, 0)
local CherryClub1aad = CherryClub1aab(0, 27, 0)
local CherryClub1aae = CherryClub1aab(0, -30, 0)
local CherryClub1aaf = CherryClub1aaa.one
local CherryClub1ab0 = CherryClub1aab(1, 0, 1)
local CherryClub1ab1 = CherryClub1aaa.zero
local CherryClub1ab2 = CherryClub1ab1
local CherryClub1ab3 = Color3.fromRGB

CherryClub1a65.AnimationId = "rbxassetid://507767968"
CherryClub1a66.AnimationId = "rbxassetid://180436148"
CherryClub1a70 = nil
CherryClub1a41(CherryClub1a67)
CherryClub1a67 = nil

local CherryClub1ab4 = function(CherryClub1ab5, CherryClub1ab6, CherryClub1ab7)
for CherryClub1ab8, CherryClub1ab9 in CherryClub1a85, CherryClub1a5c(CherryClub1ab5) do
if CherryClub1a61(CherryClub1ab9, CherryClub1ab6) and CherryClub1ab9.Name == CherryClub1ab7 then
return CherryClub1ab9
end
end
end

local CherryClub1aba = function(CherryClub1abb)
for CherryClub1abc, CherryClub1abd in CherryClub1a5c(CherryClub1a2c) do
if CherryClub1a61(CherryClub1abd, "Accoutrement") then
local CherryClub1abe = CherryClub1ab4(CherryClub1abd, "BasePart", "Handle")
if CherryClub1abe then
local CherryClub1abf = nil
local CherryClub1ac0 = nil
if CherryClub1a61(CherryClub1abe, "MeshPart") then
CherryClub1abf = CherryClub1abe.MeshId
CherryClub1ac0 = CherryClub1abe.TextureID
else
local CherryClub1ac1 = CherryClub1a45(CherryClub1abe, "SpecialMesh")
if CherryClub1ac1 then
CherryClub1abf = CherryClub1ac1.MeshId
CherryClub1ac0 = CherryClub1ac1.TextureId
end
end
if CherryClub1abf then
if CherryClub1a9d(CherryClub1abf, CherryClub1abb.MeshId) and CherryClub1a9d(CherryClub1ac0, CherryClub1abb.TextureId) then
return CherryClub1abe
end
end
end
end
end
end

local CherryClub1ac2 = function(self, CherryClub1ac3, CherryClub1ac4)
self[CherryClub1ac3] = CherryClub1ac4
end

local CherryClub1ac5 = function(CherryClub1ac6)
if CherryClub1a61(CherryClub1ac6, "Accoutrement") and CherryClub1a8d then
if not pcall(CherryClub1ac2, CherryClub1ac6, "BackendAccoutrementState", 0) then
if CherryClub1a0d then
pcall(CherryClub1a0d, CherryClub1ac6, "BackendAccoutrementState", 0)
elseif CherryClub1a0e then
CherryClub1a0e(CherryClub1ac6, "BackendAccoutrementState", true)
CherryClub1ac6.BackendAccoutrementState = 0
end
end
elseif CherryClub1a61(CherryClub1ac6, "Attachment") then
local CherryClub1ac7 = CherryClub1a25[CherryClub1ac6.Name]
if CherryClub1ac7 then
local CherryClub1ac8 = CherryClub1ac6.Parent
if CherryClub1a61(CherryClub1ac8, "BasePart") then
local CherryClub1ac9 = nil
local CherryClub1aca = nil
if CherryClub1a61(CherryClub1ac8, "MeshPart") then
CherryClub1ac9 = CherryClub1ac8.MeshId
CherryClub1aca = CherryClub1ac8.TextureID
else
local CherryClub1acb = CherryClub1a45(CherryClub1ac8, "SpecialMesh")
if CherryClub1acb then
CherryClub1ac9 = CherryClub1acb.MeshId
CherryClub1aca = CherryClub1acb.TextureId
end
end
if CherryClub1ac9 then
for CherryClub1acc, CherryClub1acd in CherryClub1a85, CherryClub1a23 do
if CherryClub1acd.MeshId == CherryClub1ac9 and CherryClub1acd.TextureId == CherryClub1aca then
local CherryClub1ace = CherryClub1acd.Handle
CherryClub1aa1(CherryClub1a24, {
LastPosition = CherryClub1ace.Position,
Offset = CherryClub1a29,
Part0 = CherryClub1ac8,
Part1 = CherryClub1ace
})
return
end
end
for CherryClub1acf, CherryClub1ad0 in CherryClub1a85, CherryClub1a86 do
if CherryClub1a9d(CherryClub1ac9, CherryClub1ad0.MeshId) and CherryClub1a9d(CherryClub1aca, CherryClub1ad0.TextureId) then
local CherryClub1ad1 = nil
local CherryClub1ad2 = CherryClub1ad0.Name
local CherryClub1ad3 = CherryClub1ad0.Names
if CherryClub1ad2 then
CherryClub1ad1 = CherryClub1ab4(CherryClub1a9a, "BasePart", CherryClub1ad2)
else
for CherryClub1ad4, CherryClub1ad5 in CherryClub1a85, CherryClub1ad3 do
local CherryClub1ad6 = CherryClub1ab4(CherryClub1a9a, "BasePart", CherryClub1ad5)
if not ( CherryClub1ad3[CherryClub1ad4 + 1] and CherryClub1a27[CherryClub1ad6] ) then
CherryClub1ad1 = CherryClub1ad6
break
end
end
end
if CherryClub1ad1 then
local CherryClub1ad7 = CherryClub1a27[CherryClub1ad1]
if not ( CherryClub1ad7 and CherryClub1ad7.MeshId == CherryClub1ac9 and CherryClub1ad7.TextureId == CherryClub1aca ) then
CherryClub1aa1(CherryClub1a24, {
Offset = CherryClub1ad0.Offset,
Part0 = CherryClub1ac8,
Part1 = CherryClub1ad1
})
CherryClub1a27[CherryClub1ad1] = { MeshId = CherryClub1ac9, TextureId = CherryClub1aca }
return
end
end
end
end
local CherryClub1ad8 = CherryClub1a43(CherryClub1ac8, "Accoutrement")
if CherryClub1ad8 and CherryClub1a61(CherryClub1ad8, "Accoutrement") then
local CherryClub1ad9 = CherryClub1a3c(CherryClub1ad8)
local CherryClub1ada = CherryClub1ab4(CherryClub1ad9, "BasePart", "Handle")
CherryClub1ada.Transparency = CherryClub1a90
for CherryClub1adb, CherryClub1adc in CherryClub1a85, CherryClub1a5d(CherryClub1ada) do
if CherryClub1a61(CherryClub1adc, "JointInstance") then
CherryClub1a41(CherryClub1adc)
end
end
local CherryClub1add = CherryClub1a64("Weld")
CherryClub1add.C0 = CherryClub1ac6.CFrame
CherryClub1add.C1 = CherryClub1ac7.CFrame
CherryClub1add.Name = "AccessoryWeld"
CherryClub1add.Part0 = CherryClub1ada
CherryClub1add.Part1 = CherryClub1ac7.Parent
CherryClub1add.Parent = CherryClub1ada
CherryClub1ad9.Parent = CherryClub1a9a
CherryClub1aa1(CherryClub1a23, {
Handle = CherryClub1ada,
MeshId = CherryClub1ac9,
TextureId = CherryClub1aca
})
CherryClub1aa1(CherryClub1a24, {
Offset = CherryClub1a29,
Part0 = CherryClub1ac8,
Part1 = CherryClub1ada
})
end
end
end
end
end
end

local CherryClub1ade = function()
local CherryClub1adf = CherryClub1a2d.CFrame
CherryClub1a40(CherryClub1a4f)
if CherryClub1a2d.CameraSubject ~= CherryClub1a9b then
CherryClub1a2d.CameraSubject = CherryClub1a9b -- yes because one check ISNT ENOUGHT!!!!!!!!!!!!!!!!!!!!!!!
end
CherryClub1a2d.CFrame = CherryClub1adf
end

local CherryClub1ae0 = function()
if CherryClub1a2d.CameraSubject ~= CherryClub1a9b then
CherryClub1aa5(CherryClub1ade)
end
end

local CherryClub1ae1 = function()
if CherryClub1a2d.CameraType ~= CherryClub1a2f then
CherryClub1a2d.CameraType = CherryClub1a2f
end
end

local CherryClub1ae2 = function()
local CherryClub1ae3 = CherryClub1a55.CurrentCamera
if CherryClub1ae3 and CherryClub1a91 then
CherryClub1a2d = CherryClub1a55.CurrentCamera
CherryClub1aa6(CherryClub1ade)
CherryClub1ae0()
CherryClub1aa1(CherryClub1a99, CherryClub1a3e(CherryClub1a5e(CherryClub1a2d, "CameraSubject"), CherryClub1ae0))
if CherryClub1a92 then
CherryClub1ae1()
CherryClub1aa1(CherryClub1a99, CherryClub1a3e(CherryClub1a5e(CherryClub1a2d, "CameraType"), CherryClub1ae1))
end
end
end

local CherryClub1ae4 = function(CherryClub1ae5, CherryClub1ae6)
CherryClub1ae5:SetStateEnabled(CherryClub1ae6, true)
CherryClub1ae5:ChangeState(CherryClub1ae6)
end

local CherryClub1ae7 = function(CherryClub1ae8, CherryClub1ae9, CherryClub1aea)
CherryClub1ae8[CherryClub1ae9] = CherryClub1aea
end

local CherryClub1aeb = function()
CherryClub1a49.Character = CherryClub1a9a
end

local CherryClub1aec = function()
CherryClub1a49.SimulationRadius = CherryClub1a95
end

local CherryClub1aed = function(CherryClub1aee, CherryClub1aef)
local CherryClub1af0 = CherryClub1a45(CherryClub1aee, CherryClub1aef)
while not CherryClub1af0 do
CherryClub1a40(CherryClub1aee.ChildAdded)
CherryClub1af0 = CherryClub1a45(CherryClub1aee, CherryClub1aef)
end
return CherryClub1af0
end

local CherryClub1af1 = function(CherryClub1af2, ...)
local CherryClub1af3 = CherryClub1ab4(CherryClub1af2, ...)
while not CherryClub1af3 do
CherryClub1a40(CherryClub1af2.ChildAdded)
CherryClub1af3 = CherryClub1ab4(CherryClub1af2, ...)
end
return CherryClub1af3
end

local CherryClub1af4 = function(CherryClub1af5, CherryClub1af6)
if CherryClub1af5 then
local CherryClub1af7 = CherryClub1af6.Highlight
if CherryClub1a61(CherryClub1af5, "Humanoid") then
CherryClub1af5 = CherryClub1af5.Parent
end
if CherryClub1a61(CherryClub1af5, "Model") then
CherryClub1af5 = CherryClub1ab4(CherryClub1af5, "BasePart", "HumanoidRootPart") or CherryClub1a58(CherryClub1a2c, "BasePart")
end
if not CherryClub1aa0(CherryClub1aa3, CherryClub1af5) and CherryClub1a61(CherryClub1af5, "BasePart") and not CherryClub1af5.Anchored and not CherryClub1a62(CherryClub1a2c, CherryClub1af5) and not CherryClub1a62(CherryClub1a9a, CherryClub1af5) then
local CherryClub1af8 = CherryClub1a42(CherryClub1af5, "Model")
if CherryClub1af8 and CherryClub1a45(CherryClub1af8, "Humanoid") then
CherryClub1af5 = CherryClub1ab4(CherryClub1af8, "BasePart", "HumanoidRootPart") or CherryClub1a58(CherryClub1a2c, "BasePart") or CherryClub1af5	
else
CherryClub1af8 = CherryClub1af5
end
if CherryClub1af7 then
local CherryClub1af9 = type(CherryClub1af7) == "boolean" and CherryClub1af7 and CherryClub1a64("Highlight") or CherryClub1a3c(CherryClub1af7)
CherryClub1af9.Adornee = CherryClub1af8
CherryClub1af9.Parent = CherryClub1af8
CherryClub1af9.OutlineColor = CherryClub1ab3(255, 0, 0)
CherryClub1af9.FillColor = CherryClub1ab3(0, 0, 0)
CherryClub1af9.DepthMode = CherryClub1a2e.HighlightDepthMode.AlwaysOnTop
local CherryClub1afa = CherryClub1a07.TweenService:Create(CherryClub1af9, TweenInfo.new(0.1, CherryClub1a2e.EasingStyle.Quad, CherryClub1a2e.EasingDirection.Out), {FillTransparency = 0.3, OutlineTransparency = 0})
local CherryClub1afb = CherryClub1a07.TweenService:Create(CherryClub1af9, TweenInfo.new(0.25, CherryClub1a2e.EasingStyle.Quad, CherryClub1a2e.EasingDirection.In), {FillTransparency = 1, OutlineTransparency = 1})
CherryClub1afa:Play()
CherryClub1afa.Completed:Once(function() CherryClub1afb:Play() end)
CherryClub1afb.Completed:Once(function() CherryClub1af9:Destroy() end)
CherryClub1af6.HighlightObject = CherryClub1af9
CherryClub1aa1(CherryClub1a63, CherryClub1af9)
end
CherryClub1aa3[CherryClub1af5] = CherryClub1af6
end
end
end

local CherryClub1afc = function(CherryClub1afd)
if CherryClub1afd:IsA("Sound") then
CherryClub1afd.Volume = 0
elseif CherryClub1afd:IsA("Script") or CherryClub1afd:IsA("LocalScript") then
CherryClub1afd.Disabled = true
end
end

local CherryClub1afe = function(CherryClub1aff)
if CherryClub1aff ~= CherryClub1a9a then
CherryClub1a9f(CherryClub1a24)
CherryClub1a9f(CherryClub1a27)
CherryClub1a9f(CherryClub1a23)
for CherryClub1b00, CherryClub1b01 in CherryClub1a85, CherryClub1a5c(CherryClub1a9a) do
if CherryClub1a61(CherryClub1b01, "Accoutrement") then
CherryClub1a41(CherryClub1b01)
end
end
CherryClub1a2c = CherryClub1aff
local CherryClub1b02 = CherryClub1aff.DescendantAdded:Connect(CherryClub1afc)
CherryClub1a9e.insert(CherryClub1a99, CherryClub1b02)
if CherryClub1a91 then
CherryClub1aa6(CherryClub1ade)
end
if CherryClub1a93 then
CherryClub1aa5(CherryClub1aeb)
end
if CherryClub1a8f then
CherryClub1a2c.Parent = CherryClub1a9a
end
for CherryClub1b03, CherryClub1b04 in CherryClub1a85, CherryClub1a5d(CherryClub1a2c) do
CherryClub1aa6(CherryClub1ac5, CherryClub1b04)
end
CherryClub1aa1(CherryClub1a99, CherryClub1a3e(CherryClub1a2c.DescendantAdded, CherryClub1ac5))
CherryClub1a70 = CherryClub1aed(CherryClub1a2c, "Humanoid")
local CherryClub1b05 = CherryClub1af1(CherryClub1a2c, "BasePart", "HumanoidRootPart")
if CherryClub1a79 then
if CherryClub1b05 then
CherryClub1a9c.CFrame = CherryClub1b05.CFrame
if CherryClub1a94 then
local CherryClub1b06 = CherryClub1b05.CollisionGroup
for CherryClub1b07, CherryClub1b08 in CherryClub1a85, CherryClub1a5d(CherryClub1a9a) do
if CherryClub1a61(CherryClub1b08, "BasePart") then
CherryClub1b08.CollisionGroup = CherryClub1b06
end
end
end
end
CherryClub1a79 = false
end
local CherryClub1b09 = true
if CherryClub1b05 then
for CherryClub1b0a, CherryClub1b0b in CherryClub1a85, CherryClub1aa3 do
if CherryClub1a62(CherryClub1b0a, CherryClub1a55) then
local CherryClub1b0c = CherryClub1b0a.Position
local CherryClub1b0d = CherryClub1b0b.PredictionFling
local CherryClub1b0e = CherryClub1b0c
local CherryClub1b0f = CherryClub1a97() + (CherryClub1b0b.Timeout or 1)
if CherryClub1b05 then
if CherryClub1a0d and CherryClub1a01 then -- i am too lazy to add a thing such as OptionsNanFling - guardian
CherryClub1ae4(CherryClub1a70, CherryClub1a35)
else
CherryClub1ae4(CherryClub1a70, CherryClub1a34)
end
while CherryClub1a62(CherryClub1b0a, CherryClub1a55) and CherryClub1a97() < CherryClub1b0f do
local CherryClub1b10 = CherryClub1aa7()
local CherryClub1b11 = CherryClub1b0a.Position
if ( CherryClub1b11 - CherryClub1b0c ).Magnitude > 100 then
break
end
local CherryClub1b12 = CherryClub1ab1
if CherryClub1b0d then
local CherryClub1b13 = (CherryClub1b11 - CherryClub1b0e) / CherryClub1b10 * 0.13
local CherryClub1b14 = CherryClub1a1e.Reanimate_Settings.Frequency
local CherryClub1b15 = CherryClub1a1e.Reanimate_Settings.Amplification
local CherryClub1b16 = tick()
local CherryClub1b17 = CherryClub1b0a.CFrame.LookVector
local CherryClub1b18 = CherryClub1a81(CherryClub1b16 * CherryClub1a82 * 2 * CherryClub1b14) * CherryClub1b15
local CherryClub1b19 = CherryClub1b17 * CherryClub1b18
local CherryClub1b1a = CherryClub1b17 * CherryClub1a1e.Reanimate_Settings.FrontOffset
CherryClub1b12 = CherryClub1b13 + CherryClub1b19 + CherryClub1b1a
end
CherryClub1b05.AssemblyAngularVelocity = CherryClub1aac
CherryClub1b05.AssemblyLinearVelocity = CherryClub1aac
if CherryClub1a0d and CherryClub1a01 then -- wtf
pcall(CherryClub1a0d, CherryClub1b05, "PhysicsRepRootRef", InstanceHandle.new(CherryClub1b0a))
pcall(function() CherryClub1a70:Move(CherryClub1a84) end)
pcall(CherryClub1a0d, CherryClub1a70, "MoveDirectionInternal", CherryClub1a84)
end
if CherryClub1a0d and CherryClub1a01 then -- wtf
CherryClub1b05.CFrame = CherryClub1a28.new(CherryClub1b0a.Position) * CherryClub1a28.Angles(0, CherryClub1b0a.Orientation.Y, 0)
else
CherryClub1b05.CFrame = CherryClub1a28.new(CherryClub1b0a.Position + CherryClub1b12) * CherryClub1a28.Angles(0, CherryClub1b0a.Orientation.Y, 0)
end
CherryClub1b0e = CherryClub1b11
end
end
end
CherryClub1aa3[CherryClub1b0a] = nil
end
CherryClub1b05.AssemblyAngularVelocity = CherryClub1ab1
CherryClub1b05.AssemblyLinearVelocity = CherryClub1ab1
if CherryClub1a0d and CherryClub1a01 then
pcall(CherryClub1a0d, CherryClub1b05, "PhysicsRepRootRef", InstanceHandle.new(nil))
pcall(CherryClub1a0d, CherryClub1a70, "MoveDirectionInternal", CherryClub1ab1)
end
if CherryClub1a8d then
CherryClub1aa6(function()
CherryClub1af1(CherryClub1a2c, "LocalScript", "Animate").Enabled = false
for CherryClub1b1b, CherryClub1b1c in CherryClub1a85, CherryClub1a74(CherryClub1a70) do
CherryClub1b1c:Stop()
end
CherryClub1a75(CherryClub1a70, CherryClub1a70.RigType == CherryClub1a32 and CherryClub1a66 or CherryClub1a65):Play(0)
pcall(CherryClub1ac2, CherryClub1a55, "FallenPartsDestroyHeight", CherryClub1a83)
local CherryClub1b1d = CherryClub1a9c.CFrame
CherryClub1b1d = CherryClub1a2b(CherryClub1b1d.X, CherryClub1a57, CherryClub1b1d.Z)
while CherryClub1b09 do
CherryClub1b05.AssemblyAngularVelocity = CherryClub1ab1
CherryClub1b05.AssemblyLinearVelocity = CherryClub1aad
CherryClub1b05.CFrame = CherryClub1b1d
CherryClub1aa7()
end
end)
elseif CherryClub1a8e then
local CherryClub1b1e = typeof(CherryClub1a8e) == "Vector3" and CherryClub1a8e or CherryClub1aae
local CherryClub1b1f = CherryClub1a9c.CFrame + CherryClub1b1e
CherryClub1aa6(function()
while CherryClub1b09 do
CherryClub1b05.AssemblyAngularVelocity = CherryClub1ab1
CherryClub1b05.AssemblyLinearVelocity = CherryClub1ab1
CherryClub1b05.CFrame = CherryClub1b1f
CherryClub1aa7()
end
end)
end
end
local CherryClub1b20 = CherryClub1a8c.ToolFling
local CherryClub1b21 = {}
if CherryClub1b20 then
local CherryClub1b22 = CherryClub1a45(CherryClub1a49, "Backpack")
CherryClub1a9f(CherryClub1aa9)
if type(CherryClub1b20) == "string" then
local CherryClub1b23 = CherryClub1ab4(CherryClub1b22, "Tool", CherryClub1b20)
if CherryClub1b23 then
CherryClub1b23.Parent = CherryClub1a2c
CherryClub1aa1(CherryClub1b21, CherryClub1b23)
end
else
for CherryClub1b24, CherryClub1b25 in CherryClub1a5c(CherryClub1b22) do
if CherryClub1a61(CherryClub1b25, "Tool") then
CherryClub1b25.Parent = CherryClub1a2c
CherryClub1aa1(CherryClub1b21, CherryClub1b25)
end
end
end
CherryClub1a77(CherryClub1a70)
end
--[[
-- for personal use, ignore this
local Hats = {16253032644, 130849299345520, 123845356193764}
for i, v in pairs(Hats) do
	game.ReplicatedStorage.LoadHat:FireServer(v)
end]]
CherryClub1aa7(CherryClub1a87)
if CherryClub1a70 then
CherryClub1ae7(CherryClub1a70, "BreakJointsOnDeath", true)
CherryClub1ae7(CherryClub1a70, "Health", 0)
end
for CherryClub1b26, CherryClub1b27 in pairs(CherryClub1a2c:GetDescendants()) do
if CherryClub1b27:IsA("JointInstance") or CherryClub1b27:IsA("Constraint") then
CherryClub1b27:Destroy()
end
end
CherryClub1a6b(CherryClub1a2c)
if CherryClub1a0c and CherryClub1a96 then
CherryClub1a0c(CherryClub1a4c)
CherryClub1a0c(CherryClub1a70.ServerBreakJoints)
end
CherryClub1ae4(CherryClub1a70, CherryClub1a33)
CherryClub1a40(CherryClub1a70.Died)
for CherryClub1b28, CherryClub1b29 in CherryClub1a63 do
CherryClub1a41(CherryClub1b29)
end
CherryClub1a9f(CherryClub1a24)
CherryClub1a9f(CherryClub1a27)
CherryClub1a9f(CherryClub1a23)
for CherryClub1b2a, CherryClub1b2b in CherryClub1a85, CherryClub1a5c(CherryClub1a9a) do -- pretty much FORCE welds to delete cause games with ragdoll messed ts up and only 3 hats worked (fixed)
if CherryClub1a61(CherryClub1b2b, "Accoutrement") then
CherryClub1a41(CherryClub1b2b)
end
end
for CherryClub1b2c, CherryClub1b2d in CherryClub1a85, CherryClub1a5d(CherryClub1a2c) do CherryClub1aa6(CherryClub1ac5, CherryClub1b2d) end
for CherryClub1b2e, CherryClub1b2f in CherryClub1b21 do
local CherryClub1b30 = CherryClub1ab4(CherryClub1b2f, "BasePart", "Handle")
if CherryClub1b30 then
CherryClub1b2f.Parent = CherryClub1a2c
else
CherryClub1aa2(CherryClub1b21, CherryClub1b2e)
end
end
CherryClub1aa9 = CherryClub1b21
CherryClub1a77(CherryClub1a70)
CherryClub1b09 = false
if CherryClub1a8d then
pcall(CherryClub1ac2, CherryClub1a55, "FallenPartsDestroyHeight", CherryClub1a56)
end
end
end

local CherryClub1b31 = function(CherryClub1b32)
if not CherryClub1a1e.Options.ClickFling then return end
local CherryClub1b33 = CherryClub1b32.UserInputType
if CherryClub1b33 == CherryClub1a38 or CherryClub1b33 == CherryClub1a39 then
local CherryClub1b34 = CherryClub1a4b.Target
if not CherryClub1b34 or CherryClub1b34:IsDescendantOf(CherryClub1a9a) then return end
if not CherryClub1b34 or CherryClub1b34:IsDescendantOf(CherryClub1a2c) then return end
if CherryClub1a06 and CherryClub1b34:IsDescendantOf(CherryClub1a06) then return end
local CherryClub1b35 = CherryClub1a8c.HatFling
local CherryClub1b36 = CherryClub1a8c.ToolFling
if CherryClub1b35 and CherryClub1a8d then
local CherryClub1b37 = type(CherryClub1b35) == "table" and CherryClub1aba(CherryClub1b35)
if not CherryClub1b37 then
for CherryClub1b38, CherryClub1b39 in CherryClub1a5c(CherryClub1a2c) do
if CherryClub1a61(CherryClub1b39, "Accoutrement") then
local CherryClub1b3a = CherryClub1ab4(CherryClub1b39, "BasePart", "Handle")
if CherryClub1b3a then
CherryClub1b37 = CherryClub1b3a
break
end
end
end
end
if CherryClub1b37 then
CherryClub1a3a[CherryClub1b37] = true
while CherryClub1a5b(CherryClub1a59, CherryClub1a38) do
if CherryClub1b37.ReceiveAge == 0 then
CherryClub1b37.AssemblyAngularVelocity = CherryClub1aac
CherryClub1b37.AssemblyLinearVelocity = CherryClub1aac
CherryClub1b37.CFrame = CherryClub1a4b.Hit + CherryClub1ab2
end
CherryClub1aa7()
end
CherryClub1a3a[CherryClub1b37] = nil
end
elseif CherryClub1b36 then
local CherryClub1b3b = CherryClub1a45(CherryClub1a49, "Backpack")
local CherryClub1b3c = nil
if type(CherryClub1b36) == "string" then
CherryClub1b3c = CherryClub1a44(CherryClub1b3b, CherryClub1b36) or CherryClub1a44(CherryClub1a2c, CherryClub1b36)
end
if not CherryClub1b3c then
CherryClub1b3c = CherryClub1a45(CherryClub1b3b, "Tool") or CherryClub1a45(CherryClub1a2c, "Tool")
end
if CherryClub1b3c then
local CherryClub1b3d = CherryClub1ab4(CherryClub1b3c, "BasePart", "Handle") or CherryClub1a58(CherryClub1b3c, "BasePart")
if CherryClub1b3d then
CherryClub1b3c.Parent = CherryClub1a2c
while CherryClub1a5b(CherryClub1a59, CherryClub1a38) do
if CherryClub1b3d.ReceiveAge == 0 then
CherryClub1b3d.AssemblyAngularVelocity = CherryClub1aac
CherryClub1b3d.AssemblyLinearVelocity = CherryClub1aac
CherryClub1b3d.CFrame = CherryClub1a4b.Hit + CherryClub1ab2
end
CherryClub1aa7()
end
CherryClub1a77(CherryClub1a70)
CherryClub1b3d.AssemblyAngularVelocity = CherryClub1ab1
CherryClub1b3d.AssemblyLinearVelocity = CherryClub1ab1
CherryClub1b3d.CFrame = CherryClub1a9c.CFrame
end
end
else
CherryClub1af4(CherryClub1b34, CherryClub1a8c)
end
end
end

local CherryClub1b3e = function()
CherryClub1aa8 = CherryClub1a97()
local CherryClub1b3f = CherryClub1aa8 - CherryClub1a7e
CherryClub1a7e = CherryClub1aa8
if not CherryClub1a93 and CherryClub1a7b then
local CherryClub1b40 = CherryClub1a9c.Position
CherryClub1a9b.AutoRotate = false
CherryClub1a9c.CFrame = CherryClub1a2a(CherryClub1b40, CherryClub1b40 + CherryClub1a2d.CFrame.LookVector * CherryClub1ab0)
elseif not CherryClub1a93 and not CherryClub1a7b then
CherryClub1a9b.AutoRotate = true
end
if CherryClub1a95 then
pcall(CherryClub1aec)
end
CherryClub1ab2 = CherryClub1a81(CherryClub1aa8 * 15) * 0.0015 * CherryClub1aaf
local CherryClub1b41 = 27 + CherryClub1a81(CherryClub1aa8)
for CherryClub1b42, CherryClub1b43 in CherryClub1a85, CherryClub1a24 do
local CherryClub1b44 = CherryClub1b43.Part0
if not CherryClub1a3a[CherryClub1b44] then
if CherryClub1b44.ReceiveAge == 0 then
if CherryClub1a62(CherryClub1b44, CherryClub1a55) and not CherryClub1a6e(CherryClub1b44)[1] and not CherryClub1a6f(CherryClub1b44) then
local CherryClub1b45 = CherryClub1b43.Part1
CherryClub1b44.AssemblyAngularVelocity = CherryClub1ab1
local CherryClub1b46 = CherryClub1b45.AssemblyLinearVelocity * CherryClub1b41
CherryClub1b44.AssemblyLinearVelocity = CherryClub1aab(CherryClub1b46.X, CherryClub1b41, CherryClub1b46.Z)
CherryClub1b44.CFrame = CherryClub1b45.CFrame * CherryClub1b43.Offset + CherryClub1ab2
end
end
end
end
if not CherryClub1a93 and CherryClub1a70 then
CherryClub1a76(CherryClub1a9b, CherryClub1a70.MoveDirection)
CherryClub1a9b.Jump = CherryClub1a70.Jump
end
end

local CherryClub1b47 = function()
local CherryClub1b48 = CherryClub1a9c.Position
CherryClub1a9c.CFrame = CherryClub1a2a(CherryClub1b48, CherryClub1b48 + CherryClub1a2d.CFrame.LookVector * CherryClub1ab0)
for CherryClub1b49, CherryClub1b4a in CherryClub1a85, CherryClub1a24 do
local CherryClub1b4b = CherryClub1b4a.Part0
if CherryClub1b4b.ReceiveAge == 0 and CherryClub1a62(CherryClub1b4b, CherryClub1a55) and not CherryClub1a6e(CherryClub1b4b)[1] and not CherryClub1a6f(CherryClub1b4b) then
CherryClub1b4b.CFrame = CherryClub1b4a.Part1.CFrame * CherryClub1b4a.Offset
end
end
end

local CherryClub1b4c = function()
CherryClub1a7b = CherryClub1a59.MouseBehavior == CherryClub1a36
if CherryClub1a7b then
CherryClub1a98 = CherryClub1a3e(CherryClub1a4f, CherryClub1b47)
CherryClub1aa1(CherryClub1a99, CherryClub1a98)
elseif CherryClub1a98 then
CherryClub1a3f(CherryClub1a98)
CherryClub1aa2(CherryClub1a99, CherryClub1aa0(CherryClub1a99, CherryClub1a98))
end
end

local CherryClub1b4d = function()
if CherryClub1a89 and CherryClub1a2c then
for CherryClub1b4e, CherryClub1b4f in CherryClub1a85, CherryClub1a5d(CherryClub1a2c) do
if CherryClub1a61(CherryClub1b4f, "BasePart") then
CherryClub1b4f.CanCollide = false
end
end
end
for CherryClub1b50, CherryClub1b51 in CherryClub1a85, CherryClub1a5c(CherryClub1a9a) do
if CherryClub1a61(CherryClub1b51, "BasePart") then
CherryClub1b51.CanCollide = false
end
end
end

local CherryClub1b52 = function()
repeat
CherryClub1a7c = pcall(CherryClub1a53, CherryClub1a51, "ResetButtonCallback", CherryClub1a26)
CherryClub1aa7()
until CherryClub1a7c
end

CherryClub1a04.Start = function(CherryClub1b53)
print("starting up the reanimate")
if not CherryClub1a7d then
CherryClub1a79 = true
CherryClub1a7d = true
CherryClub1b53 = CherryClub1b53 or {}
CherryClub1a86 = CherryClub1b53.Accessories or {}
CherryClub1a87 = CherryClub1b53.BreakJointsDelay or 0
CherryClub1a88 = CherryClub1b53.ClickFling
CherryClub1a89 = CherryClub1b53.DisableCharacterCollisions
CherryClub1a8a = CherryClub1b53.DisableHealthBar
CherryClub1a8b = CherryClub1b53.DisableRigCollisions
CherryClub1a8c = CherryClub1b53.DefaultFlingOptions or {}
CherryClub1a8d = CherryClub1b53.HatDrop
CherryClub1a8e = CherryClub1b53.HideCharacter
CherryClub1a8f = CherryClub1b53.ParentCharacter
CherryClub1a90 = CherryClub1b53.RigTransparency or 1
CherryClub1a91 = CherryClub1b53.SetCameraSubject
CherryClub1a92 = CherryClub1b53.SetCameraType
CherryClub1a93 = CherryClub1b53.SetCharacter
CherryClub1a94 = CherryClub1b53.SetCollisionGroup
CherryClub1a95 = CherryClub1b53.SimulationRadius
CherryClub1a96 = CherryClub1b53.UseServerBreakJoints
if CherryClub1a8a then
CherryClub1a7a = CherryClub1a52(CherryClub1a51, CherryClub1a30)
CherryClub1a54(CherryClub1a51, CherryClub1a30, false)
end
CherryClub1a26 = CherryClub1a64("BindableEvent")
CherryClub1aa1(CherryClub1a99, CherryClub1a3e(CherryClub1a26.Event, CherryClub1a04.Stop))
CherryClub1a9a = CherryClub1a15.Objects.StarterCharacter
CherryClub1a9a.Name = "non"
CherryClub1a9b = CherryClub1a9a.Humanoid
CherryClub1a9c = CherryClub1a9a.HumanoidRootPart
CherryClub1a9a.Parent = CherryClub1a55
local CherryClub1b54 = function(CherryClub1b55)
local CherryClub1b56 = Instance.new("Part")
CherryClub1b56.Name = CherryClub1b55
CherryClub1b56.Massless = true
CherryClub1b56.CanCollide = true
CherryClub1b56.Transparency = 1
CherryClub1b56.Size = CherryClub1aab(0.1, 0.1, 0.1)
CherryClub1b56.Anchored = false
CherryClub1b56.Parent = CherryClub1a9a
local CherryClub1b57 = Instance.new("Weld", CherryClub1b56)
CherryClub1b57.Name = "WeaponWeld"
CherryClub1b57.Part0 = CherryClub1a9c
CherryClub1b57.Part1 = CherryClub1b56
return CherryClub1b56, CherryClub1b57
end
for CherryClub1b58, CherryClub1b59 in CherryClub1a85, CherryClub1a5d(CherryClub1a9a) do
if CherryClub1a61(CherryClub1b59, "Attachment") then
CherryClub1a25[CherryClub1b59.Name] = CherryClub1b59
elseif CherryClub1a61(CherryClub1b59, "BasePart") or CherryClub1a61(CherryClub1b59, "Decal") then
CherryClub1b59.Transparency = CherryClub1a90
end
end
CherryClub1a9b.JumpPower = 50
CherryClub1a9b.WalkSpeed = 16
CherryClub1ae2()
CherryClub1aa1(CherryClub1a99, CherryClub1a3e(CherryClub1a5f, CherryClub1ae2))
if CherryClub1a88 then CherryClub1aa1(CherryClub1a99, CherryClub1a3e(CherryClub1a5a, CherryClub1b31)) end
local CherryClub1b5a = CherryClub1a49.Character
pcall(function()
if CherryClub1b5a:FindFirstChild("Humanoid").RigType == CherryClub1a2e.HumanoidRigType.R15 then
CherryClub1a14.SendNotification("Script might not work here, please ensure R6!")
end
end)
for CherryClub1b5b, CherryClub1b5c in CherryClub1a85, CherryClub1a5d(CherryClub1b5a) do -- i kept messing ts up so im just putting it here
if CherryClub1a61(CherryClub1b5c, "Script") or CherryClub1a61(CherryClub1b5c, "LocalScript") then
CherryClub1b5c.Disabled = true
elseif CherryClub1a61(CherryClub1b5c, "Sound") then
CherryClub1b5c.Volume = 0
end
end
if CherryClub1b5a then CherryClub1afe(CherryClub1b5a) end
CherryClub1aa1(CherryClub1a99, CherryClub1a3e(CherryClub1a4a, CherryClub1afe))
CherryClub1a7e = CherryClub1a97()
CherryClub1aa1(CherryClub1a99, CherryClub1a3e(CherryClub1a4e, CherryClub1b3e))
if not CherryClub1a93 then
CherryClub1b4c()
CherryClub1aa1(CherryClub1a99, CherryClub1a3e(CherryClub1a60, CherryClub1b4c))
end
if CherryClub1a89 or CherryClub1a8b then
CherryClub1b4d()
CherryClub1aa1(CherryClub1a99, CherryClub1a3e(CherryClub1a50, CherryClub1b4d))
end
CherryClub1a7c = pcall(CherryClub1a53, CherryClub1a51, "ResetButtonCallback", CherryClub1a26)
if not CherryClub1a7c then
CherryClub1aa6(CherryClub1b52)
end
return {
BindableEvent = CherryClub1a26, Fling = CherryClub1af4, Rig = CherryClub1a9a, CreateObject = CherryClub1b54
}
end
end

CherryClub1a04.Stop = function()
if CherryClub1a7d then
CherryClub1a79 = false
CherryClub1a7d = false
for CherryClub1b5d, CherryClub1b5e in CherryClub1a63 do CherryClub1a41(CherryClub1b5e) end
CherryClub1a9f(CherryClub1a63)
for CherryClub1b5f, CherryClub1b60 in CherryClub1a85, CherryClub1a99 do CherryClub1a3f(CherryClub1b60) end
CherryClub1a9f(CherryClub1a99)
CherryClub1a41(CherryClub1a26)
if CherryClub1a2c.Parent == CherryClub1a9a then CherryClub1a2c.Parent = CherryClub1a55 end
if CherryClub1a70 then CherryClub1ae4(CherryClub1a70, CherryClub1a33) end
CherryClub1a41(CherryClub1a9a)
CherryClub1a13.PlaySFX(133987417538818, 0.25)
if CherryClub1a8a and not CherryClub1a52(CherryClub1a51, CherryClub1a30) then CherryClub1a54(CherryClub1a51, CherryClub1a30, CherryClub1a7a) end
if CherryClub1a7c then
pcall(CherryClub1a53, CherryClub1a51, "ResetButtonCallback", true)
else
CherryClub1a7c = pcall(CherryClub1a53, CherryClub1a51, "ResetButtonCallback", true)
end
end
end
end

CherryClub1a03 = CherryClub1a04.Start({
Accessories = {
-- [[ Personal Rigs ]] --
-- Expunged
{ Name = "RigHead", MeshId = "98698170543564",  TextureId = "124770705854744", Offset = CFrame.new(0, -2, 0)  * CFrame.Angles(0,CherryClub1a10(180),0)},
{ Name = "RigTorso", MeshId = "130560142697210",  TextureId = "79464129372236", Offset = CFrame.new(0, -1.5, 0)  * CFrame.Angles(0, CherryClub1a10(180), CherryClub1a10(90)) },
{ Name = "RigLowerRightArm", MeshId = "89283846238826", TextureId = "123982598235943", Offset = CFrame.new(0, 1, 0) * CFrame.Angles(0, 0, CherryClub1a10(180)) },
{ Name = "RigLowerLeftArm", MeshId = "91954470098413", TextureId = "86740100072304", Offset = CFrame.new(0, -1, 0) * CFrame.Angles(0, 0, 0) },
{ Name = "RigLowerRightLeg", MeshId = "92159540430952", TextureId = "94097694385646", Offset = CFrame.new(1, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ Name = "RigLowerLeftLeg", MeshId = "97106536931958", TextureId = "76346736700850", Offset = CFrame.new(1, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ Name = "RigUpperLeftLeg", MeshId = "90732752771845", TextureId = "116097583924123", Offset = CFrame.new(1, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ Name = "RigUpperRightLeg", MeshId = "125263390379233", TextureId = "126044218871162", Offset = CFrame.new(1, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ Name = "RigUpperLeftArm", MeshId = "100143607156458", TextureId = "131442934919924", Offset = CFrame.new(0, -1, 0) * CFrame.Angles(0, 0, 0) },
{ Name = "RigUpperRightArm", MeshId = "124404454583804", TextureId = "128898397887659", Offset = CFrame.new(0, 1, 0) * CFrame.Angles(0, 0, CherryClub1a10(180)) },
-- TCM
{ Name = "RigHead", MeshId = "78094900360596",  TextureId = "105957453830035", Offset = CFrame.new(0.2, 0.75, 0) * CFrame.Angles(CherryClub1a10(-90), CherryClub1a10(180), 0) },
{ Name = "RigTorso", MeshId = "114739032540174",  TextureId = "108663499769525", Offset = CFrame.new(0, 1, 0.5) * CFrame.Angles(0, CherryClub1a10(180), CherryClub1a10(0)) },
{ Name = "RigLowerRightLeg", MeshId = "103008503474936",  TextureId = "93085031525971", Offset = CFrame.new(0, 0.15, -0.25) * CFrame.Angles(CherryClub1a10(0),  CherryClub1a10(180), CherryClub1a10(0)) },
{ Name = "RigLowerLeftLeg", MeshId = "99466624502858",  TextureId = "72743522298716", Offset = CFrame.new(0, 0.15, -0.25) * CFrame.Angles(CherryClub1a10(0),  CherryClub1a10(180), CherryClub1a10(0)) },
{ Name = "RigUpperLeftLeg", MeshId = "124123205390758",  TextureId = "111776742887072", Offset = CFrame.new(0, -0.15, 0) * CFrame.Angles(CherryClub1a10(0),  CherryClub1a10(180), CherryClub1a10(0)) },
{ Name = "RigUpperRightLeg", MeshId = "103833171481290",  TextureId = "88939441849582", Offset = CFrame.new(0, -0.15, 0) * CFrame.Angles(CherryClub1a10(0),  CherryClub1a10(180), CherryClub1a10(0)) },
{ Name = "RigUpperRightArm", MeshId = "85988378633420",  TextureId = "74635820752751", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(CherryClub1a10(0), CherryClub1a10(180), CherryClub1a10(-90)) },
{ Name = "RigUpperLeftArm", MeshId = "70997855416439",  TextureId = "99653861878482", Offset = CFrame.new(0.5, 0, 0) * CFrame.Angles(CherryClub1a10(0), CherryClub1a10(180), CherryClub1a10(90)) },
{ Name = "RigLowerLeftArm", MeshId = "92557789815686",  TextureId = "139091484578365", Offset = CFrame.new(0, 0, -0.25) * CFrame.Angles(CherryClub1a10(0), CherryClub1a10(180), CherryClub1a10(90)) },
{ Name = "RigLowerRightArm", MeshId = "105951317613703",  TextureId = "137429085584265", Offset = CFrame.new(1.76, 0, 0.25) * CFrame.Angles(0, CherryClub1a10(-90), CherryClub1a10(0)) },
-- TSM
{ Name = "RigHead", MeshId = "74957576121425",  TextureId = "90439261082583", Offset = CFrame.new(0, 0.5, -0.5) * CFrame.Angles(0, CherryClub1a10(180), 0) },
{ Name = "RigTorso", MeshId = "126412421726455",  TextureId = "90439261082583", Offset = CFrame.new(0, 0, 0.525) * CFrame.Angles(0, CherryClub1a10(180), 0) },
{ Name = "RigUpperRightArm", MeshId = "131496992539452",  TextureId = "90439261082583", Offset = CFrame.new(-1, 0, 0) * CFrame.Angles( CherryClub1a10(180), 0, CherryClub1a10(90)) },
{ Name = "RigLowerRightArm", MeshId = "134898160133485",  TextureId = "90439261082583", Offset = CFrame.new(1, 0.1, -0.3) * CFrame.Angles(CherryClub1a10(-90), 0, CherryClub1a10(90)) },
{ Name = "RigUpperLeftArm", MeshId = "113500115312840",  TextureId = "90439261082583", Offset = CFrame.new(1, 0, 0) * CFrame.Angles(CherryClub1a10(180), 0, CherryClub1a10(-90)) }, 
{ Name = "RigLowerLeftArm", MeshId = "95765363522505",  TextureId = "90439261082583", Offset = CFrame.new(-1, -0.1, 0.45) * CFrame.Angles(CherryClub1a10(-90), 0, CherryClub1a10(-90)) },
{ Name = "RigUpperLeftLeg", MeshId = "74049199968378",  TextureId = "90439261082583", Offset = CFrame.new(0, -0.5, 0) * CFrame.Angles(0, 0, 0) }, 
{ Name = "RigLowerLeftLeg", MeshId = "133860365669727",  TextureId = "90439261082583", Offset = CFrame.new(0, 0, -0.5) * CFrame.Angles(0, CherryClub1a10(180), CherryClub1a10(0)) },
{ Name = "RigUpperRightLeg", MeshId = "74049199968378",  TextureId = "90439261082583", Offset = CFrame.new(0, -0.5, 0) * CFrame.Angles(0, 0, 0) }, 
{ Name = "RigLowerRightLeg", MeshId = "133860365669727",  TextureId = "90439261082583", Offset = CFrame.new(0, 0, -0.5) * CFrame.Angles(0, CherryClub1a10(180), CherryClub1a10(0)) },
-- Storm Diver
{ Name = "Head", MeshId = "130528366395356",  TextureId = "134634090566246", Offset = CFrame.new(0, 0, 0) *  CFrame.Angles(CherryClub1a10(90), 0, 0) },
{ Name = "Right Arm",MeshId = "82577587092197",  TextureId = "87495382910947", Offset = CFrame.new(0,0.5,0) * CFrame.Angles(0, 0, 0) },
{ Name = "Left Arm", MeshId = "89075266423953", TextureId = "103348056725415", Offset =  CFrame.new(0,0.5,0) * CFrame.Angles(0, 0, 0) },
-- Watchman Of Doom
{ Name = "Head", MeshId = "81999203987808",  TextureId = "79888847989576", Offset = CFrame.new(0, 0.25, -0.5) *  CFrame.Angles(0, CherryClub1a10(-90), 0) },
{ Name = "Torso", MeshId = "102984632980851",  TextureId = "81847697951713", Offset = CFrame.new(0, -1, 0) * CFrame.Angles(0, CherryClub1a10(180), CherryClub1a10(-90)) },
{ Name = "Right Arm",MeshId = "134998437563297",  TextureId = "94525177307368", Offset = CFrame.new(-0.75, 0, -0.25) * CFrame.Angles(0, CherryClub1a10(180), CherryClub1a10(90)) },
{ Name = "Left Arm", MeshId = "137429815067276", TextureId = "113923135466330", Offset =  CFrame.new(1.25, -0.5, -0.25) * CFrame.Angles(0, CherryClub1a10(180), CherryClub1a10(90)) },
{ Name = "Right Leg", MeshId = "74433149404909", TextureId = "132160831836019", Offset = CFrame.new(-0.5, 0.5, -0.5) * CFrame.Angles(CherryClub1a10(90), 0, CherryClub1a10(180)) },
{ Name = "Left Leg", MeshId = "92698483129705", TextureId = "92025952495069", Offset = CFrame.new(0.5, 0.5, -0.5) * CFrame.Angles(CherryClub1a10(-90), 0, CherryClub1a10(180))},
-- 0.5x
{ Name = "Head", MeshId = "89847818414123",  TextureId = "103125099216572", Offset = CFrame.new(-0.25, 0.2, -0.1) },
{ Name = "Torso", MeshId = "78830115421669",  TextureId = "90543415008299", Offset = CFrame.new(-0.25, -0.05, -0.1) },
{ Name = "Right Arm",MeshId = "136577594841741",  TextureId = "125499341699446", Offset = CFrame.new(0, 0.715, -0.1) },
{ Name = "Left Arm", MeshId = "72011909416460", TextureId = "87230741883790", Offset =  CFrame.new(0, 0.715, -0.1) },
{ Name = "Right Leg", MeshId = "100902167286726", TextureId = "116337017995094", Offset = CFrame.new(0, 0.715, -0.1) },
{ Name = "Left Leg", MeshId = "89759352540257", TextureId = "136588898494317", Offset = CFrame.new(0, 0.715, -0.1)},
-- Admin Noli
{ Name = "Torso", MeshId = "126186803906708",  TextureId = "122870281823952", Offset = CFrame.identity * CFrame.Angles(0, 0, 0) },
{ Name = "Right Arm",MeshId = "77873410023837",  TextureId = "70916964304856", Offset = CFrame.new(-0.498, 0, 0) * CFrame.Angles(0, 0, 0) },
{ Name = "Left Arm", MeshId = "110692313911860", TextureId = "110387230836162", Offset =  CFrame.new(0.498, -0.02, 0) * CFrame.Angles(0, 0, 0) },
{ Name = "Right Leg", MeshId = "113534787795395", TextureId = "93105168133552", Offset = CFrame.new(-0.15, -0.02, 0) * CFrame.Angles(0, 0, 0) },
{ Name = "Left Leg", MeshId = "121869193358744", TextureId = "137862730588147", Offset = CFrame.new(0.15, -0.02, 0) * CFrame.Angles(0, 0, 0)},
-- Tords Rig
{ Name = "Torso", MeshId = "97772676424430",  TextureId = "96282018871478", Offset = CFrame.identity },
{ Name = "Right Arm", MeshId = "128839203893104",  TextureId = "100542973447024", Offset = CFrame.identity },
{ Name = "Left Arm", MeshId = "113944263422349",  TextureId = "79061753792604", Offset = CFrame.identity },
-- Cannoneer Rig
{ Name = "Torso", MeshId = "131018666998514",  TextureId = "114854030584735", Offset = CFrame.identity },
{ Name = "Right Arm", MeshId = "74241169361466", TextureId = "103596506136222", Offset = CFrame.Angles(CherryClub1a10(90), 0, 0) },
{ Name = "Left Arm", MeshId = "103399434286698", TextureId = "71393000026580", Offset = CFrame.Angles(CherryClub1a10(90), 0, 0) },
{ Name = "Right Leg",MeshId = "80852136456671",  TextureId = "114854030584735", Offset = CFrame.Angles(CherryClub1a10(90), 0, CherryClub1a10(180))},
{ Name = "Left Leg", MeshId = "80852136456671", TextureId = "114854030584735", Offset = CFrame.Angles(CherryClub1a10(90), 0, CherryClub1a10(180)) },
-- Snake Banisher Rig
{ MeshId = "125443585075666", Name = "Torso", Offset = CFrame.Angles(0, 3.15, 0), TextureId = "121023324229475" },
{ MeshId = "121342985816617", Name = "Left Arm", Offset = CFrame.Angles(0, 0, 1.57), TextureId = "129264637819824" },
{ MeshId = "121342985816617", Name = "Right Arm", Offset = CFrame.Angles(0, 3.15, 1.57), TextureId = "129264637819824" },
-- Pink / Mad Mew Mew Rig
{ Name = "Head", MeshId = "98446589710566",  TextureId = "119635993693074", Offset = CFrame.new(0, 0.45, 0.25) * CFrame.Angles(0, CherryClub1a10(-90), 0) },
{ Name = "Torso", MeshId = "88670014628071",  TextureId = "104272728399686", Offset = CFrame.new(0, 0, 0.25) * CFrame.Angles(0, 0, 0)},
{ Name = "Right Arm", MeshId = "97918060335026", TextureId = "84455196693842", Offset = CFrame.new(-1, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(-90))},
{ Name = "Left Arm", MeshId = "129730330903007", TextureId = "85488881025695", Offset = CFrame.new(1, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(90))},
{ Name = "Right Leg", MeshId = "92281228403628", TextureId = "109118465689949", Offset = CFrame.new(-0.2, 0.25, 0) * CFrame.Angles(0, 0, CherryClub1a10(-0))},
{ Name = "Left Leg", MeshId = "108100372158808", TextureId = "112786904549176", Offset = CFrame.new(0.2, 0.25, 0) * CFrame.Angles(0, 0, CherryClub1a10(0))},
-- XD Slasher
{ Name = "Torso", MeshId = "78439058167390",  TextureId = "104743126177064", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(CherryClub1a10(-90), 0, 0)},
{ Name = "Right Arm", MeshId = "79881929077848", TextureId = "122717615396118", Offset = CFrame.new(0.05, 0.2, 0) * CFrame.Angles(0, CherryClub1a10(180), CherryClub1a10(0))},
{ Name = "Left Arm", MeshId = "71919527930500", TextureId = "132129969728725", Offset = CFrame.new(0.05, -0.25, 0) * CFrame.Angles(CherryClub1a10(90), CherryClub1a10(180), 0)},
{ Name = "Right Leg", MeshId = "101330913717713", TextureId = "122909801440130", Offset = CFrame.new(0, 0, -0.1) * CFrame.Angles(CherryClub1a10(-90), 0, CherryClub1a10(-180))},
{ Name = "Left Leg", MeshId = "77842651172094", TextureId = "100136022948953", Offset = CFrame.new(0, 0, -0.1) * CFrame.Angles(CherryClub1a10(90), 0, CherryClub1a10(180))},

-- [[ Humanoid Rigs ]] --
-- John Doe
{ Name = "RigHead", MeshId = "106352630533813",  TextureId = "117484156735788", Offset = CFrame.identity },
{ Name = "RigTorso", MeshId = "138334323968183",  TextureId = "128188607625786", Offset = CFrame.Angles(0, 0, CherryClub1a10(-55)) },
{ Name = "RigUpperRightArm", MeshId = "94818190090394",  TextureId = "76433872168542", Offset = CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ Name = "RigUpperLeftArm", MeshId = "99922912174402",  TextureId = "84232685747564", Offset = CFrame.Angles(0, 0, CherryClub1a10(-90)) }, 
{ Name = "RigLowerRightArm", MeshId = "91437672690613",  TextureId = "121934090435678", Offset = CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ Name = "RigLowerLeftArm", MeshId = "79875567101920",  TextureId = "136120210849686", Offset = CFrame.Angles(0, 0, CherryClub1a10(-90)) },
{ Name = "RigUpperRightLeg", MeshId = "124989035573464",  TextureId = "128213334280922", Offset = CFrame.identity },
{ Name = "RigUpperLeftLeg", MeshId = "110898878196498",  TextureId = "129884500343732", Offset = CFrame.identity },
{ Name = "RigLowerRightLeg", MeshId = "136539510016060",  TextureId = "85097353817585", Offset = CFrame.identity },
{ Name = "RigLowerLeftLeg", MeshId = "86170590010778",  TextureId = "104769782771396", Offset = CFrame.identity },
-- Sin Dragon 
{ Name = "RigHead", MeshId = "76446501643738",  TextureId = "138228578975518", Offset = CFrame.new(-0.75, 5, 4)  * CFrame.Angles(0, CherryClub1a10(90), 0)},
{ Name = "RigHead", MeshId = "136491922265650",  TextureId = "138228578975518", Offset = CFrame.new(0.75, 5, 4) * CFrame.Angles(0, CherryClub1a10(90), 0) },
{ Name = "RigLowerRightArm", MeshId = "132002102982560", TextureId = "84952244891471", Offset = CFrame.new(0, 4, 0)  * CFrame.Angles(0, 0,CherryClub1a10(-90)) },
{ Name = "RigLowerLeftArm", MeshId = "137803778555219", TextureId = "84952244891471", Offset = CFrame.new(0, 4, 0) * CFrame.Angles(CherryClub1a10(180),0,CherryClub1a10(90)) },
-- Sword / Spears (Locust)
{ Name = "RigTorso", MeshId = "138334323968183",  TextureId = "128188607625786", Offset = CFrame.Angles(0, 0, CherryClub1a10(-55)) },
{ Name = "RigUpperRightArm", MeshId = "17605983196", TextureId = "17606581728", Offset = CFrame.identity * CFrame.Angles(0, 0, CherryClub1a10(-90)) },
{ Name = "RigUpperLeftArm", MeshId = "18610679741", TextureId = "18625348232", Offset = CFrame.identity * CFrame.Angles(0, CherryClub1a10(45), CherryClub1a10(-90)) },
{ Name = "RigLowerLeftArm", MeshId = "110382824830787", TextureId = "119800753686181", Offset = CFrame.identity * CFrame.Angles(CherryClub1a10(90), 0, CherryClub1a10(90)) },
{ Name = "RigLowerRightArm", MeshId = "110382824830787", TextureId = "119800753686181", Offset = CFrame.identity * CFrame.Angles(CherryClub1a10(90), 0, CherryClub1a10(-90)) },
{ Name = "RigUpperRightLeg", MeshId = "76624859423759", TextureId = "81203167910667", Offset = CFrame.identity * CFrame.Angles(0, 0, CherryClub1a10(-45)) },
{ Name = "RigUpperLeftLeg", MeshId = "76624859423759", TextureId = "124580012086562", Offset = CFrame.identity * CFrame.Angles(0, CherryClub1a10(-180), CherryClub1a10(-45)) },
{ Name = "RigLowerRightLeg", MeshId = "75709149822509", TextureId = "120166750183004", Offset = CFrame.Angles(0, 0, CherryClub1a10(-45)) },
{ Name = "RigLowerLeftLeg", MeshId = "18610679813", TextureId = "18626048026", Offset = CFrame.Angles(CherryClub1a10(-45), 0, 0) },
-- Prosthetic / Space Marine (123214023564626, 18615135385, 99726531005445, 18989526470, 77193178349068, 137978033543581, 139102413583361, 121830551276315)
{ Name = "RigLowerRightLeg", MeshId = "107288378965608", TextureId = "83319628621726", Offset = CFrame.identity },
{ Name = "RigLowerLeftLeg", MeshId = "18614790719", TextureId = "18614777867", Offset = CFrame.identity * CFrame.Angles(0, CherryClub1a10(180), 0) },
{ Name = "RigUpperRightLeg", MeshId = "136378854630150", TextureId = "120675101379312", Offset = CFrame.identity },
{ Name = "RigUpperLeftLeg", MeshId = "18989397242", TextureId = "18989397363", Offset = CFrame.identity },
{ Name = "RigLowerLeftArm", MeshId = "123388937940630", TextureId = "84429400539007", Offset = CFrame.identity * CFrame.Angles(CherryClub1a10(90), 0, CherryClub1a10(-90)) },
{ Name = "RigLowerRightArm", MeshId = "117554824897780", TextureId = "84429400539007", Offset = CFrame.identity * CFrame.Angles(CherryClub1a10(90), 0, CherryClub1a10(90)) },
{ Name = "RigUpperRightArm", MeshId = "136000704446163", TextureId = "70374418157305", Offset = CFrame.identity * CFrame.Angles(0, 0, CherryClub1a10(-90)) },
{ Name = "RigUpperLeftArm", MeshId = "85336536194577", TextureId = "70374418157305", Offset = CFrame.identity * CFrame.Angles(0, 0, CherryClub1a10(90)) },
-- Block rig
{ Name = "RigHead", MeshId = "14282117876",  TextureId = "14282120779", Offset = CFrame.Angles(0, CherryClub1a10(-90), 0) },
{ Name = "RigTorso", MeshId = "17345242336",  TextureId = "17345250641", Offset = CFrame.identity },
{ Name = "RigUpperLeftLeg", MeshId = "70807086513216",  TextureId = "87564259970629", Offset = CFrame.identity },
{ Name = "RigLowerLeftLeg", MeshId = "98818051326497",  TextureId = "87142331045456", Offset = CFrame.identity },
{ Name = "RigUpperRightLeg", MeshId = "115322100534609",  TextureId = "140198794837319", Offset = CFrame.identity },
{ Name = "RigLowerRightLeg", MeshId = "97418736735022",  TextureId = "84047101371984", Offset = CFrame.identity },
{ Name = "RigUpperLeftArm", MeshId = "106942781700680",  TextureId = "90838563977106", Offset = CFrame.identity * CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ Name = "RigUpperRightArm", MeshId = "82433902584666",  TextureId = "129625048922193", Offset = CFrame.identity * CFrame.Angles(0, 0, CherryClub1a10(-90)) },
{ Name = "RigLowerLeftArm", MeshId = "17323421898",  TextureId = "75930329122564", Offset = CFrame.identity * CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ Name = "RigLowerRightArm", MeshId = "17323421898",  TextureId = "95461117386269", Offset = CFrame.identity * CFrame.Angles(0, 0, CherryClub1a10(90)) },

-- [[ R6 Rigs ]] --
-- Immortality Lord Rig
{ Name = "Head", MeshId = "17375312569",  TextureId = "17375312612", Offset = CFrame.new(0, 1, 0) * CFrame.Angles(0, CherryClub1a10(180), 0) },
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
-- 2x Rig
{ Name = "Head", MeshId = "92572400594624",  TextureId = "117484156735788", Offset = CFrame.identity * CFrame.Angles(0, CherryClub1a10(180), 0) },
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
-- Free (1.5x)
{ Name = "Torso", MeshId = "17858522136",  TextureId = "17858501380", Offset = CFrame.Angles(CherryClub1a10(100), 0, 0) },
{ Name = "Left Arm", MeshId = "686793422",  TextureId = "6900595602", Offset = CFrame.new(1, 1, 0) * CFrame.Angles(0, CherryClub1a10(-90), 0) },
{ Name = "Left Arm", MeshId = "3030546036",  TextureId = "3650139425", Offset = CFrame.new(0.25, -0.5, 0) * CFrame.Angles(CherryClub1a10(-90), 0, CherryClub1a10(90)) },
{ Name = "Right Arm", MeshId = "686793422",  TextureId = "5354879750", Offset = CFrame.new(-1, 1, 0) * CFrame.Angles(0, CherryClub1a10(90), 0) },
{ Name = "Right Arm", MeshId = "4324138105",  TextureId = "4381699432", Offset = CFrame.new(-0.25, -0.5, 0) * CFrame.Angles(CherryClub1a10(-90), 0, CherryClub1a10(-90)) },
{ Name = "Left Leg", MeshId = "4324138105",  TextureId = "4391374782", Offset = CFrame.new(-0.25, -0.65, 0) * CFrame.Angles(CherryClub1a10(-90), 0, CherryClub1a10(90)) },
{ Name = "Left Leg", MeshId = "4154474745",  TextureId = "4154474807", Offset = CFrame.new(-0.25, 0.55, 0) * CFrame.Angles(CherryClub1a10(-90), 0, CherryClub1a10(90)) },
{ Name = "Right Leg", MeshId = "4489232754",  TextureId = "4584026407", Offset = CFrame.new(0.25, -0.65, 0) * CFrame.Angles(CherryClub1a10(-90), 0, CherryClub1a10(-90)) },
{ Name = "Right Leg", MeshId = "3030546036",  TextureId = "4645402630", Offset = CFrame.new(0.25, 0.55, 0) * CFrame.Angles(CherryClub1a10(-90), 0, CherryClub1a10(-90)) },
-- New Free Hair Limbs
{ MeshId = "319354652", Name = "Left Arm", Offset = CFrame.new(0.15, 0, 0) *  CFrame.Angles(0, -1.57, 0), TextureId = "376186990" },
{ MeshId = "319354652", Name = "Right Arm", Offset = CFrame.new(-0.15, 0, 0) * CFrame.Angles(0, 1.57, 0), TextureId = "304117018" },
{ MeshId = "81642452", Name = "Left Leg", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(180)), TextureId = "6858317942" },
{ MeshId = "81642452", Name = "Right Leg", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(180)), TextureId = "6858318826" },
-- New Free Rig
{ MeshId = "4819720316", Name = "Torso", Offset = CFrame.Angles(0, 0, -0.25), TextureId = "4819722776" },
{ MeshId = "3030546036", Name = "Left Arm", Offset = CFrame.new(0.15, 0, 0) *  CFrame.Angles(-1.57, 0, 1.57), TextureId = "3033903209" },
{ MeshId = "3030546036", Name = "Right Arm", Offset = CFrame.new(-0.15, 0, 0) * CFrame.Angles(-1.57, 0, -1.57), TextureId = "3360978739" },
{ MeshId = "3030546036", Name = "Left Leg", Offset = CFrame.new(0.15, 0, 0) * CFrame.Angles(-1.57, 0, 1.57), TextureId = "3033898741" },
{ MeshId = "3030546036", Name = "Right Leg", Offset = CFrame.new(0.15, 0, 0) *  CFrame.Angles(-1.57, 0, -1.57), TextureId = "3409604993" },
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
{ MeshId = "125405780718494", Name = "Left Arm", Offset = CFrame.Angles(0, 0,  CherryClub1a10(90)), TextureId = "136752500636691" },
{ MeshId = "125405780718494", Name = "Right Arm", Offset = CFrame.Angles(0, 0,  CherryClub1a10(90)), TextureId = "136752500636691" },
{ MeshId = "125405780718494", Name = "Left Leg", Offset = CFrame.Angles(0, 0, CherryClub1a10(90)), TextureId = "136752500636691" },
{ MeshId = "125405780718494", Name = "Right Leg", Offset = CFrame.Angles(0, 0,  CherryClub1a10(90)), TextureId = "136752500636691" },
-- Genesis White Rig
{ MeshId = "126825022897778", Name = "Torso", Offset = CFrame.identity, TextureId = "130689541138804" },
{ MeshId = "99608462237958", Name = "Left Arm", Offset = CFrame.Angles(0, 0,  CherryClub1a10(90)), TextureId = "130809869695496" },
{ MeshId = "139733645770094", Name = "Right Arm", Offset = CFrame.Angles(0, 0,  CherryClub1a10(90)), TextureId = "130809869695496" },
{ MeshId = "105141400603933", Name = "Left Leg", Offset = CFrame.Angles(0, 0, CherryClub1a10(90)), TextureId = "71060417496309" },
{ MeshId = "90736849096372", Name = "Right Leg", Offset = CFrame.Angles(0, 0,  CherryClub1a10(90)), TextureId = "79186624401216" },
-- Prosthetics (Furnace Rig)
{ MeshId = "117554824897780", Name = "Right Leg", Offset = CFrame.Angles(0, -1.57, 0), TextureId = "99077561039115" },
{ MeshId = "123388937940630", Name = "Left Leg", Offset = CFrame.Angles(0, 1.57, 0), TextureId = "99077561039115" },
{ MeshId = "117554824897780", Name = "Right Leg", Offset = CFrame.Angles(0, -1.57, 0), TextureId = "84429400539007" },
{ MeshId = "123388937940630", Name = "Left Leg", Offset = CFrame.Angles(0, 1.57, 0), TextureId = "84429400539007" },
-- Lay's Rig
{ Name = "Torso", MeshId = "139792224823925",  TextureId = "89183204903931", Offset = CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ Name = "Right Arm", MeshId = "105263225400272",  TextureId = "111402858657243", Offset = CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ Name = "Left Arm", MeshId = "105263225400272",  TextureId = "111402858657243", Offset = CFrame.Angles(0, 0, CherryClub1a10(90)) },
{ MeshId = "83395427313429", Names = { "Left Leg", "Right Leg" }, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "97148121718581" },--18641142410

-- [[ Weapon Aligns ]] --
-- Free Set 1 (7548993875, 12495746361, 6531967293)
{ Name = "FakeTorso", MeshId = "12495661615", TextureId = "12495666203", Offset =  CFrame.Angles(0, 0, 0) },
{ Name = "FakeCorruptNature", MeshId = "6525013171", TextureId = "6524708339", Offset =  CFrame.Angles(0, 0, 0) },
{ Name = "FakeFirebrand", MeshId = "7547179386", TextureId = "7547152243", Offset = CFrame.new(-1, -1, -2) * CFrame.Angles(CherryClub1a10(45), CherryClub1a10(-90), 0) },
-- Free Set 2 (11702906576, 2309346267, 71409823493730)
{ Name = "FakeTorso", MeshId = "138168756098366", TextureId = "138059494752404", Offset =  CFrame.Angles(0, 0, 0) },
{ Name = "FakeCorruptNature", MeshId = "2309330801", TextureId = "2309333814", Offset =  CFrame.Angles(0, 0, 0) },
{ Name = "FakeFirebrand", MeshId = "11524268570", TextureId = "11524268595", Offset = CFrame.new(-0.5, -1, -2) * CFrame.Angles(CherryClub1a10(145), CherryClub1a10(0), 0) },
-- Paid Set 1 (16253032644, 130849299345520, 123845356193764)
{ Name = "FakeTorso", MeshId = "137246576921101", TextureId = "136291455301053", Offset =  CFrame.Angles(0, 0, 0) },
{ Name = "FakeCorruptNature", MeshId = "16253002660", TextureId = "16253004813", Offset =  CFrame.Angles(0, 0, 0) },
{ Name = "FakeFirebrand", MeshId = "97840495591427", TextureId = "78019023039410", Offset = CFrame.new(0, -0.95, -1.45) * CFrame.Angles(CherryClub1a10(0), CherryClub1a10(0), CherryClub1a10(90)) },
},
BreakJointsDelay = 0.155, -- dont modify
ClickFling = true,
DefaultFlingOptions = {
HatFling = false,
Highlight = true,
PredictionFling = true,
Timeout = 0.75,
ToolFling = false,
},
DisableCharacterCollisions = true, -- dont modify
DisableHealthBar = true, -- dont modify
DisableRigCollisions = true, -- dont modify
HatDrop = false, -- dont use
HideCharacter = Vector3.new(0, -50, 0),
ParentCharacter = true, -- dont modify
RigTransparency = 1,
SetCameraSubject = true, -- dont modify
SetCameraType = true, -- dont modify
SetCharacter = false, -- dont use
SetCollisionGroup = true, -- dont modify
SimulationRadius = 2147483647, -- dont modify
UseServerBreakJoints = true, -- dont modify
})
end
--reanim end

-- character setup
local CherryClub1b61 = os.clock()
local CherryClub1b62 = CherryClub1a07.Players.LocalPlayer
local CherryClub1b63
if CherryClub1a1d.IsStudio then CherryClub1b63 = CherryClub1b62.Character or CherryClub1b62.CharacterAdded:Wait() else CherryClub1b63 = CherryClub1a03.Rig end
local CherryClub1b64 = {
Head = CherryClub1b63:WaitForChild("Head");
RootPart = CherryClub1b63:WaitForChild("HumanoidRootPart");
Torso = CherryClub1b63:WaitForChild("Torso");
LeftArm = CherryClub1b63:WaitForChild("Left Arm");
RightArm = CherryClub1b63:WaitForChild("Right Arm");
LeftLeg = CherryClub1b63:WaitForChild("Left Leg");
RightLeg = CherryClub1b63:WaitForChild("Right Leg");
Humanoid = CherryClub1b63:WaitForChild("Humanoid");
} -- feel free to use Character i just prefer to have the main parts here :p
local CherryClub1b65 = Instance.new("Folder", CherryClub1b63)
CherryClub1b65.Name = "EmpyreanFolder"
pcall(function()
CherryClub1b63:FindFirstChild("Animate"):Destroy()
CherryClub1b64.Humanoid:FindFirstChild("Animator"):Destroy()
end)

-- audio functions
local CherryClub1b66 = Instance.new("Sound", CherryClub1b64.Head)
CherryClub1b66.Looped = true
CherryClub1a13.PlaySFX = function(CherryClub1b67: number, CherryClub1b68)
if not CherryClub1a1e.Options.SFXEnabled then return end
local CherryClub1b69 = Instance.new("Sound", workspace)
CherryClub1b69.SoundId = "rbxassetid://" .. CherryClub1b67
CherryClub1b69.Volume = CherryClub1b68 or 1
CherryClub1b69.PlayOnRemove = true
CherryClub1b69:Destroy()
return CherryClub1b69
end
CherryClub1a13.PlaySong = function(CherryClub1b6a: Instance, CherryClub1b6b: string)
local CherryClub1b6c = Instance.new("Sound", CherryClub1b6a)
CherryClub1b6c.Volume = 1
CherryClub1b6c.SoundId = CherryClub1b6b
CherryClub1b6c:Play()
return CherryClub1b6c
end
CherryClub1a13.PlayAttackSFX = function(CherryClub1b6d: string, CherryClub1b6e)
if not CherryClub1a1e.Options.SFXEnabled then return end
local CherryClub1b6f = Instance.new("Sound", CherryClub1b64.RootPart)
CherryClub1b6f.SoundId = CherryClub1b6d
CherryClub1b6f.Volume = 1
CherryClub1b6f:Play()
CherryClub1b6e = CherryClub1b6e or true
if CherryClub1b6e then
CherryClub1b6f.Ended:Connect(function()
CherryClub1b6f:Destroy()
end)
end	
return CherryClub1b6f
end
if not CherryClub1a1d.IsStudio then
for CherryClub1b70, CherryClub1b71 in ipairs(CherryClub1a0b(CherryClub1a1e.Directories.Songs)) do
if CherryClub1b71:match("%.mp3$") or CherryClub1b71:match("%.ogg$") or CherryClub1b71:match("%.wav$") then
table.insert(CherryClub1a1d.MP3Files, CherryClub1b71)
end
end
table.sort(CherryClub1a1d.MP3Files)
end
CherryClub1a13.LoadSong = function(CherryClub1b72)
if #CherryClub1a1d.MP3Files == 0 then return end
CherryClub1b66:Stop()
CherryClub1b66.Name = CherryClub1a1d.MP3Files[CherryClub1b72]:match("([^\\/]+)$"):gsub("%.%w+$", "")
if not CherryClub1a1d.IsStudio then
pcall(function()
CherryClub1b66.SoundId = CherryClub1a08(CherryClub1a1d.MP3Files[CherryClub1b72])
end)
end
CherryClub1b66:Play()
end
CherryClub1a13.NextSong = function()
CherryClub1a1d.CurrentSongIndex += 1
if CherryClub1a1d.CurrentSongIndex > #CherryClub1a1d.MP3Files then
CherryClub1a1d.CurrentSongIndex = 1
end
CherryClub1a13.LoadSong(CherryClub1a1d.CurrentSongIndex)
end
CherryClub1a13.PreviousSong = function()
CherryClub1a1d.CurrentSongIndex -= 1
if CherryClub1a1d.CurrentSongIndex < 1 then
CherryClub1a1d.CurrentSongIndex = #CherryClub1a1d.MP3Files
end
CherryClub1a13.LoadSong(CherryClub1a1d.CurrentSongIndex)
end

CherryClub1a13.LoadSong(CherryClub1a1d.CurrentSongIndex)

-- animator module | guardian was here
CherryClub1a1b.GetBonePath = function(CherryClub1b73)
local CherryClub1b74 = {CherryClub1b73.Name}
local CherryClub1b75 = CherryClub1b73.Parent
while CherryClub1b75 and CherryClub1b75:IsA("Bone") do
table.insert(CherryClub1b74, 1, CherryClub1b75.Name)
CherryClub1b75 = CherryClub1b75.Parent
end
return table.concat(CherryClub1b74, "/")
end
CherryClub1a1b.GetPosePath = function(CherryClub1b76)
local CherryClub1b77 = {CherryClub1b76.Name}
local CherryClub1b78 = CherryClub1b76.Parent
while CherryClub1b78 and CherryClub1b78:IsA("Pose") do
table.insert(CherryClub1b77, 1, CherryClub1b78.Name)
CherryClub1b78 = CherryClub1b78.Parent
end
table.remove(CherryClub1b77, 1)
return table.concat(CherryClub1b77, "/")
end
CherryClub1a1b.RegisterRigJoints = function(CherryClub1b79: Model)
if not CherryClub1a1b.Joints[CherryClub1b79] then
CherryClub1a1b.Joints[CherryClub1b79] = {}
CherryClub1a1b.AnimDefaults[CherryClub1b79] = {}
CherryClub1a1b.JointTypes[CherryClub1b79] = {}
CherryClub1a1b.JointPaths[CherryClub1b79] = {}
end
local CherryClub1b7a = {}
for CherryClub1b7b, CherryClub1b7c in ipairs(CherryClub1b79:GetDescendants()) do
if CherryClub1b7c:IsA("Motor6D") and CherryClub1b7c.Part1 then
CherryClub1b7a[CherryClub1b7c.Part1] = CherryClub1b7c
end
end
local CherryClub1b7d = function(CherryClub1b7e)
local CherryClub1b7f = {CherryClub1b7e.Name}
local CherryClub1b80 = CherryClub1b7a[CherryClub1b7e]
while CherryClub1b80 and CherryClub1b80.Part0 and CherryClub1b7a[CherryClub1b80.Part0] do
CherryClub1b7e = CherryClub1b80.Part0
table.insert(CherryClub1b7f, 1, CherryClub1b7e.Name)
CherryClub1b80 = CherryClub1b7a[CherryClub1b7e]
end
return table.concat(CherryClub1b7f, "/")
end
for CherryClub1b81, CherryClub1b82 in ipairs(CherryClub1b79:GetDescendants()) do
if CherryClub1b82:IsA("Bone") then
local CherryClub1b83 = CherryClub1a1b.GetBonePath(CherryClub1b82)
CherryClub1a1b.Joints[CherryClub1b79][CherryClub1b83] = CherryClub1b82
CherryClub1a1b.AnimDefaults[CherryClub1b79][CherryClub1b83] = CherryClub1b82.CFrame
CherryClub1a1b.JointTypes[CherryClub1b79][CherryClub1b83] = "Bone"
CherryClub1a1b.JointPaths[CherryClub1b79][CherryClub1b82] = CherryClub1b83
elseif CherryClub1b82:IsA("Motor6D") and CherryClub1b82.Part1 then
local CherryClub1b84 = CherryClub1b7d(CherryClub1b82.Part1)
CherryClub1a1b.Joints[CherryClub1b79][CherryClub1b84] = CherryClub1b82
CherryClub1a1b.AnimDefaults[CherryClub1b79][CherryClub1b84] = CherryClub1b82.C0
CherryClub1a1b.JointTypes[CherryClub1b79][CherryClub1b84] = "Motor6D"
CherryClub1a1b.JointPaths[CherryClub1b79][CherryClub1b82] = CherryClub1b84
CherryClub1a1b.JointPaths[CherryClub1b79][CherryClub1b82] = CherryClub1b84
end
end
CherryClub1a1b.NameToPath = CherryClub1a1b.NameToPath or {}
CherryClub1a1b.NameToPath[CherryClub1b79] = {}
for CherryClub1b85 in pairs(CherryClub1a1b.Joints[CherryClub1b79]) do
local CherryClub1b86 = CherryClub1b85:match("([^/]+)$")
CherryClub1a1b.NameToPath[CherryClub1b79][CherryClub1b86] = CherryClub1b85
end
end
CherryClub1a1b.UnregisterRigJoints = function(CherryClub1b87: Model)
CherryClub1a1b.Joints[CherryClub1b87] = nil
CherryClub1a1b.AnimDefaults[CherryClub1b87] = nil
CherryClub1a1b.JointTypes[CherryClub1b87] = nil
if CherryClub1a1b.Rigs[CherryClub1b87] then
for CherryClub1b88, CherryClub1b89 in pairs(CherryClub1a1b.Rigs[CherryClub1b87]) do CherryClub1b89:Stop() end
CherryClub1a1b.Rigs[CherryClub1b87] = nil
end
end
CherryClub1a1b.EditJoint = function(CherryClub1b8a, CherryClub1b8b, CherryClub1b8c, CherryClub1b8d, CherryClub1b8e, CherryClub1b8f, CherryClub1b90)
if CherryClub1a1e.Options.HeadFollowsMouse and CherryClub1b8a == CherryClub1a12.Neck then return end
local CherryClub1b91 = CherryClub1b8f and "CFrame" or "Transform"
CherryClub1a1b.ActiveTweens = CherryClub1a1b.ActiveTweens or {}
local CherryClub1b92 = CherryClub1a1b.ActiveTweens[CherryClub1b8a]
if CherryClub1b92 then CherryClub1b92:Cancel() end
if typeof(CherryClub1b8d) == "EnumItem" and CherryClub1b8d.Name == "Constant" then
local CherryClub1b93 = CherryClub1a07.TweenService:Create(CherryClub1b8a, TweenInfo.new(0.001, Enum.EasingStyle.Linear, Enum.EasingDirection.In), { [CherryClub1b91] = CherryClub1b8b })
CherryClub1a1b.ActiveTweens[CherryClub1b8a] = CherryClub1b93
CherryClub1b93:Play()
return
end
CherryClub1b8d = Enum.EasingStyle[CherryClub1b8d.Name]
CherryClub1b8e = Enum.EasingDirection[CherryClub1b8e.Name]
local CherryClub1b94 = CherryClub1b8a[CherryClub1b91]
local CherryClub1b95 = CherryClub1a07.TweenService:Create(CherryClub1b8a, TweenInfo.new(CherryClub1b8c, CherryClub1b8d, CherryClub1b8e), { [CherryClub1b91] = CherryClub1b94:Lerp(CherryClub1b8b, CherryClub1a1e.Options.AnimationBlending) })
CherryClub1a1b.ActiveTweens[CherryClub1b8a] = CherryClub1b95
CherryClub1b95:Play()
return CherryClub1b95
end
CherryClub1a1b.RegisterRigJoints(CherryClub1b63)
CherryClub1a1b.LoadAnimation = function(CherryClub1b96: Model, CherryClub1b97: KeyframeSequence)
local CherryClub1b98 = CherryClub1b97
local CherryClub1b99 = {}
CherryClub1b99.Speed = 1
CherryClub1b99.KeepLast = 0
local CherryClub1b9a = CherryClub1b98:GetKeyframes()
table.sort(CherryClub1b9a, function(CherryClub1b9b, CherryClub1b9c) return CherryClub1b9b.Time < CherryClub1b9c.Time end)
CherryClub1b99.Length = CherryClub1b9a[#CherryClub1b9a].Time
local function CherryClub1b9d(CherryClub1b9e)
local CherryClub1b9f = 0
repeat
local CherryClub1ba0 = CherryClub1a07.RunService.Heartbeat:Wait()
CherryClub1b9f += CherryClub1ba0
until CherryClub1b9f >= CherryClub1b9e / (CherryClub1b99.Speed * CherryClub1a1e.Options.AnimationSpeed)
end
for CherryClub1ba1, CherryClub1ba2 in ipairs(CherryClub1b98:GetDescendants()) do
if CherryClub1ba2:IsA("IntValue") or CherryClub1ba2:IsA("StringValue") or CherryClub1ba2:IsA("Folder") then
CherryClub1ba2:Destroy()
elseif CherryClub1ba2:IsA("Pose") and not CherryClub1b96:FindFirstChild(CherryClub1ba2.Name, true) then
CherryClub1ba2:Destroy()
end
end
CherryClub1b99.Priority = 0
CherryClub1b99.Paths = {}
for CherryClub1ba3, CherryClub1ba4 in ipairs(CherryClub1b98:GetDescendants()) do
if CherryClub1ba4:IsA("Pose") then
local CherryClub1ba5 = CherryClub1a1b.GetPosePath(CherryClub1ba4)
if not CherryClub1a1b.Joints[CherryClub1b96][CherryClub1ba5] then
CherryClub1ba5 = CherryClub1a1b.NameToPath[CherryClub1b96][CherryClub1ba4.Name] or CherryClub1ba5
end
CherryClub1b99.Paths[CherryClub1ba5] = true
end
end
CherryClub1a1b.Claims = CherryClub1a1b.Claims or {}
CherryClub1a1b.Claims[CherryClub1b96] = CherryClub1a1b.Claims[CherryClub1b96] or {}
local function CherryClub1ba6()
for CherryClub1ba7 in pairs(CherryClub1b99.Paths) do
if CherryClub1a1b.Claims[CherryClub1b96][CherryClub1ba7] == CherryClub1b99 then
CherryClub1a1b.Claims[CherryClub1b96][CherryClub1ba7] = nil
end
end
if CherryClub1b99.Priority > 0 then
local CherryClub1ba8 = CherryClub1a1b.Joints[CherryClub1b96]
if CherryClub1ba8 then
CherryClub1a1b.ActiveTweens = CherryClub1a1b.ActiveTweens or {}
for CherryClub1ba9 in pairs(CherryClub1b99.Paths) do
local CherryClub1baa = CherryClub1ba8[CherryClub1ba9]
if CherryClub1baa then
local CherryClub1bab = CherryClub1baa:IsA("Motor6D") and {Transform = CFrame.identity} or {CFrame = CherryClub1a1b.AnimDefaults[CherryClub1b96][CherryClub1ba9]}
local CherryClub1bac = CherryClub1a07.TweenService:Create(CherryClub1baa, TweenInfo.new(0.15), CherryClub1bab)
CherryClub1a1b.ActiveTweens[CherryClub1baa] = CherryClub1bac
CherryClub1bac:Play()
end
end
end
end
end
CherryClub1b99.Stopped = true
CherryClub1b99.IsPlaying = false
CherryClub1b99.TimePosition = 0
CherryClub1b99.Looped = CherryClub1b98.Loop
local CherryClub1bad = Instance.new("BindableEvent")
local CherryClub1bae = Instance.new("BindableEvent")
CherryClub1b99.Completed = CherryClub1bad.Event
CherryClub1b99.KeyframeReached = CherryClub1bae.Event
function CherryClub1b99:Play(CherryClub1baf)
if CherryClub1baf and CherryClub1baf < 0 then
CherryClub1baf = math.abs(CherryClub1baf)
end
CherryClub1b99.Speed = math.clamp(CherryClub1baf or 180, 1, 180)
CherryClub1b99.Stopped = false
CherryClub1b99.Run = (CherryClub1b99.Run or 0) + 1
local CherryClub1bb0 = CherryClub1b99.Run
local function CherryClub1bb1() return CherryClub1b99.Stopped or CherryClub1b99.Run ~= CherryClub1bb0 end
CherryClub1b99.IsPlaying = true
CherryClub1b99.TimePosition = 0
local CherryClub1bb2
CherryClub1bb2 = CherryClub1a07.RunService.Heartbeat:Connect(function(CherryClub1bb3)
if CherryClub1b99.IsPlaying and not CherryClub1b99.Stopped then
CherryClub1b99.TimePosition += CherryClub1bb3 * CherryClub1b99.Speed * CherryClub1a1e.Options.AnimationSpeed
else
CherryClub1bb2:Disconnect()
end
end)
local function CherryClub1bb4(CherryClub1bb5)
while not CherryClub1b99.Stopped and CherryClub1b99.TimePosition < CherryClub1bb5 do
CherryClub1a07.RunService.Heartbeat:Wait()
end
end
local function CherryClub1bb6(CherryClub1bb7)
local CherryClub1bb8 = CherryClub1b99.TimePosition + CherryClub1bb7
while not CherryClub1b99.Stopped and CherryClub1b99.TimePosition < CherryClub1bb8 do
CherryClub1a07.RunService.Heartbeat:Wait()
end
end
if CherryClub1b99.Priority > 0 then
for CherryClub1bb9 in pairs(CherryClub1b99.Paths) do CherryClub1a1b.Claims[CherryClub1b96][CherryClub1bb9] = CherryClub1b99 end
end
task.spawn(function()
repeat
for CherryClub1bba = 1, #CherryClub1b9a do
local CherryClub1bbb, CherryClub1bbc = CherryClub1b9a[CherryClub1bba], CherryClub1b9a[CherryClub1bba + 1]
if CherryClub1b99.Stopped then break end
CherryClub1bb4(CherryClub1bbb.Time)
if CherryClub1b99.Stopped then break end
task.spawn(function()
if not CherryClub1a1b.Joints[CherryClub1b96] then return end
for CherryClub1bbd, CherryClub1bbe in ipairs(CherryClub1bbb:GetDescendants()) do
local CherryClub1bbf = CherryClub1a1b.GetPosePath(CherryClub1bbe)
if not CherryClub1a1b.Joints[CherryClub1b96][CherryClub1bbf] then
CherryClub1bbf = CherryClub1a1b.NameToPath[CherryClub1b96][CherryClub1bbe.Name] or CherryClub1bbf
end
local CherryClub1bc0 = CherryClub1a1b.Claims[CherryClub1b96][CherryClub1bbf]
if CherryClub1bc0 and CherryClub1bc0 ~= CherryClub1b99 and CherryClub1bc0.Priority > CherryClub1b99.Priority then continue end
if CherryClub1a1b.Joints[CherryClub1b96][CherryClub1bbf] then
local CherryClub1bc1 = CherryClub1bbc and (CherryClub1bbc.Time - CherryClub1bbb.Time) / (CherryClub1b99.Speed * CherryClub1a1e.Options.AnimationSpeed) or 0.5
local CherryClub1bc2 = CherryClub1a1b.JointTypes[CherryClub1b96][CherryClub1bbf] == "Bone"
local CherryClub1bc3 = CherryClub1bbe.CFrame
local CherryClub1bc4 = CherryClub1bc3.Rotation + (CherryClub1bc3.Position * CherryClub1a1d.CurrentScale)
local CherryClub1bc5 = CherryClub1bc2 and (CherryClub1a1b.AnimDefaults[CherryClub1b96][CherryClub1bbf] * CherryClub1bc4) or CherryClub1bc4
CherryClub1a1b.EditJoint(CherryClub1a1b.Joints[CherryClub1b96][CherryClub1bbf], CherryClub1bc5, CherryClub1bc1, CherryClub1bbe.EasingStyle, CherryClub1bbe.EasingDirection, CherryClub1bc2)
end
end
end)
if CherryClub1bba == #CherryClub1b9a and CherryClub1b99.KeepLast > 0 then
CherryClub1bb6(CherryClub1b99.KeepLast)
end
CherryClub1bae:Fire(CherryClub1bbb.Name)
end
CherryClub1bad:Fire()
if CherryClub1b99.Looped then
CherryClub1b99.TimePosition = 0
end
until not CherryClub1b99.Looped or CherryClub1b99.Stopped
CherryClub1ba6()              
CherryClub1b99.IsPlaying = false
end)
end
function CherryClub1b99:Stop()
CherryClub1b99.Stopped = true
CherryClub1b99.IsPlaying = false
CherryClub1ba6()
CherryClub1bad:Fire()
end
function CherryClub1b99:AdjustSpeed(CherryClub1bc6)
if CherryClub1bc6 < 0 then
CherryClub1bc6 = math.abs(CherryClub1bc6)
end
CherryClub1b99.Speed = math.clamp(CherryClub1bc6 or CherryClub1b99.Speed, 1, 180)
end
return CherryClub1b99
end
local CherryClub1bc7={["Linear"]=Enum.PoseEasingStyle.Linear,["Constant"]=Enum.PoseEasingStyle.Constant,["Elastic"]=Enum.PoseEasingStyle.Elastic,["Cubic"]=Enum.PoseEasingStyle.Cubic,["Bounce"]=Enum.PoseEasingStyle.Bounce,["CubicV2"]=Enum.PoseEasingStyle.CubicV2}
local CherryClub1bc8={["In"]=Enum.PoseEasingDirection.In,["Out"]=Enum.PoseEasingDirection.Out,["InOut"]=Enum.PoseEasingDirection.InOut}
local CherryClub1bc9={"HumanoidRootPart","Torso","Head","Left Arm","Right Arm","Left Leg","Right Leg"}
local CherryClub1bca={["HumanoidRootPart"]=1,["Torso"]=2,["Head"]=3,["Left Arm"]=4,["Right Arm"]=5,["Left Leg"]=6,["Right Leg"]=7}
local CherryClub1bcb={[1]=0,[2]=1,[3]=2,[4]=2,[5]=2,[6]=2,[7]=2}
local CherryClub1bcc=buffer.readu16
local CherryClub1bcd=buffer.readu32
local CherryClub1bce=buffer.readf32
local CherryClub1bcf=buffer.readstring
CherryClub1a1b.ParseAnim=function(CherryClub1bd0:string,CherryClub1bd1:string):KeyframeSequence?
local CherryClub1bd2=buffer.fromstring(CherryClub1bd0)
local CherryClub1bd3=0
local CherryClub1bd4=CherryClub1bcc(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=2
local CherryClub1bd5=CherryClub1bcf(CherryClub1bd2,CherryClub1bd3,CherryClub1bd4) CherryClub1bd3+=CherryClub1bd4
local CherryClub1bd6=CherryClub1bcd(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bd7=Instance.new("KeyframeSequence")
CherryClub1bd7.Name=CherryClub1bd1:match("([^/\\]+)%.anim$") or CherryClub1bd1
CherryClub1bd7.Loop=true
for CherryClub1bd8=1,CherryClub1bd6 do
local CherryClub1bd9=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bda=CherryClub1bcd(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bdb=Instance.new("Keyframe")
CherryClub1bdb.Time=CherryClub1bd9
local CherryClub1bdc={}
local CherryClub1bdd={}
for CherryClub1bde=1,CherryClub1bda do
local CherryClub1bdf=CherryClub1bcc(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=2
local CherryClub1be0=CherryClub1bcf(CherryClub1bd2,CherryClub1bd3,CherryClub1bdf) CherryClub1bd3+=CherryClub1bdf
local CherryClub1be1=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1be2=CherryClub1bcc(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=2
local CherryClub1be3=CherryClub1bcf(CherryClub1bd2,CherryClub1bd3,CherryClub1be2) CherryClub1bd3+=CherryClub1be2
local CherryClub1be4=CherryClub1bcc(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=2
local CherryClub1be5=CherryClub1bcf(CherryClub1bd2,CherryClub1bd3,CherryClub1be4) CherryClub1bd3+=CherryClub1be4
local CherryClub1be6=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1be7=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1be8=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1be9=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bea=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1beb=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bec=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bed=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bee=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bef=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bf0=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bf1=CherryClub1bce(CherryClub1bd2,CherryClub1bd3) CherryClub1bd3+=4
local CherryClub1bf2=Instance.new("Pose")
CherryClub1bf2.Name=CherryClub1be0
CherryClub1bf2.Weight=CherryClub1be1
CherryClub1bf2.EasingStyle=CherryClub1bc7[CherryClub1be3] or Enum.PoseEasingStyle.Linear
CherryClub1bf2.EasingDirection=CherryClub1bc8[CherryClub1be5] or Enum.PoseEasingDirection.Out
CherryClub1bf2.CFrame=CFrame.new(CherryClub1be6,CherryClub1be7,CherryClub1be8,CherryClub1be9,CherryClub1bea,CherryClub1beb,CherryClub1bec,CherryClub1bed,CherryClub1bee,CherryClub1bef,CherryClub1bf0,CherryClub1bf1)
local CherryClub1bf3=CherryClub1bca[CherryClub1be0]
if CherryClub1bf3 then
CherryClub1bdc[CherryClub1bf3]=CherryClub1bf2
else
CherryClub1bdd[#CherryClub1bdd+1]=CherryClub1bf2
end
end
for CherryClub1bf4=1,7 do
local CherryClub1bf5=CherryClub1bdc[CherryClub1bf4]
if CherryClub1bf5 then
local CherryClub1bf6=CherryClub1bcb[CherryClub1bf4]
if CherryClub1bf6==0 then
CherryClub1bf5.Parent=CherryClub1bdb
else
local CherryClub1bf7=CherryClub1bdc[CherryClub1bf6]
CherryClub1bf5.Parent=CherryClub1bf7 or CherryClub1bdb
end
end
end
local CherryClub1bf8=CherryClub1bdc[2]
for CherryClub1bf9=1,#CherryClub1bdd do
CherryClub1bdd[CherryClub1bf9].Parent=CherryClub1bf8 or CherryClub1bdb
end
CherryClub1bdb.Parent=CherryClub1bd7
end
return CherryClub1bd7
end
CherryClub1a1b.PlayAnim = function(CherryClub1bfa: Model, CherryClub1bfb: KeyframeSequence, CherryClub1bfc: number)
if not CherryClub1a1b.Rigs[CherryClub1bfa] then
CherryClub1a1b.Rigs[CherryClub1bfa] = {}
end
if not CherryClub1a1b.Rigs[CherryClub1bfa][CherryClub1bfb.Name] then
CherryClub1a1b.Rigs[CherryClub1bfa][CherryClub1bfb.Name] = CherryClub1a1b.LoadAnimation(CherryClub1bfa, CherryClub1bfb)
end
local CherryClub1bfd = CherryClub1a1b.Rigs[CherryClub1bfa][CherryClub1bfb.Name]
for CherryClub1bfe, CherryClub1bff in pairs(CherryClub1a1b.Rigs[CherryClub1bfa]) do
if CherryClub1bfe ~= CherryClub1bfb.Name and CherryClub1bff.Priority == 0 then
CherryClub1bff:Stop()
end
end
if not CherryClub1bfd.IsPlaying or CherryClub1bfd.Stopped then
CherryClub1bfd:Play(CherryClub1bfc or 1)
end
return CherryClub1bfd
end
CherryClub1a1b.StopAnim = function(CherryClub1c00: Model, CherryClub1c01: KeyframeSequence)
if not CherryClub1a1b.Rigs[CherryClub1c00] then
CherryClub1a1b.Rigs[CherryClub1c00] = {}
end
if not CherryClub1a1b.Rigs[CherryClub1c00][CherryClub1c01.Name] then
CherryClub1a1b.Rigs[CherryClub1c00][CherryClub1c01.Name] = CherryClub1a1b.LoadAnimation(CherryClub1c00, CherryClub1c01)
end
CherryClub1a1b.Rigs[CherryClub1c00][CherryClub1c01.Name]:Stop()
end
CherryClub1a1b.StopEmote = function(CherryClub1c02) -- took some time but i did it
if CherryClub1a1d.CurrentEmoteTrack then
CherryClub1a1d.CurrentEmoteTrack:Stop()
CherryClub1a1d.CurrentEmoteTrack = nil
end
if not CherryClub1c02 then
CherryClub1a13.LoadSong(CherryClub1a1d.SavedSongIndex or CherryClub1a1d.CurrentSongIndex)
local CherryClub1c03 = CherryClub1a1d.SavedTimePosition
if CherryClub1c03 then
task.spawn(function()
if not CherryClub1b66.IsLoaded then CherryClub1b66.Loaded:Wait() end
CherryClub1b66.TimePosition = CherryClub1c03
end)
CherryClub1a1d.SavedTimePosition = nil
end
CherryClub1a1a.ClearLyrics("")
CherryClub1a1a.UpdateSong(CherryClub1b66.Name)
end
CherryClub1a1c.Input.Emoting = false
CherryClub1a1c.Input.Debounce = false
local CherryClub1c04 = CherryClub1a1b.ActiveTweens or {}
for CherryClub1c05, CherryClub1c06 in pairs(CherryClub1b64.Torso:GetChildren()) do
if CherryClub1c06:IsA("Motor6D") then
if CherryClub1c04[CherryClub1c06] then CherryClub1c04[CherryClub1c06]:Cancel() end
CherryClub1c06.Transform = CFrame.identity
end
end
if CherryClub1c04[CherryClub1b64.RootPart.RootJoint] then CherryClub1c04[CherryClub1b64.RootPart.RootJoint]:Cancel() end
CherryClub1b64.RootPart.RootJoint.Transform = CFrame.identity
if not CherryClub1c02 then CherryClub1a1b.RestoreMovement() end
end
CherryClub1a1b.RestoreMovement = function()
CherryClub1a1c.Movement.Idle = false
CherryClub1a1c.Movement.Walking = false
CherryClub1a1c.Movement.Running = false
end
CherryClub1a1b.GetAnim = function(CherryClub1c07, CherryClub1c08)
if not CherryClub1a1b.Rigs[CherryClub1c07] then
CherryClub1a1b.Rigs[CherryClub1c07] = {}
end
if not CherryClub1a1b.Rigs[CherryClub1c07][CherryClub1c08.Name] then
CherryClub1a1b.Rigs[CherryClub1c07][CherryClub1c08.Name] = CherryClub1a1b.LoadAnimation(CherryClub1c07, CherryClub1c08)
end
return CherryClub1a1b.Rigs[CherryClub1c07][CherryClub1c08.Name]
end
CherryClub1a1b.PlayAction = function(CherryClub1c09, CherryClub1c0a, CherryClub1c0b)
local CherryClub1c0c = CherryClub1a1b.GetAnim(CherryClub1c09, CherryClub1c0a)
CherryClub1c0c.Priority = 1
if not CherryClub1c0c.IsPlaying then CherryClub1c0c:Play(CherryClub1c0b or 1) end
return CherryClub1c0c
end

-- player functions
CherryClub1a12.Mouse = CherryClub1b62:GetMouse()
CherryClub1a12.Camera = workspace.CurrentCamera
CherryClub1a12.Neck = CherryClub1b64.Torso:FindFirstChild("Neck")
local CherryClub1c0d = CherryClub1a12.Neck and CherryClub1a1b.JointPaths[CherryClub1b63][CherryClub1a12.Neck]
CherryClub1a12.NeckC0 = CherryClub1c0d and CherryClub1a1b.AnimDefaults[CherryClub1b63][CherryClub1c0d]
CherryClub1a14.SetWalkSpeed = function(CherryClub1c0e, CherryClub1c0f)
CherryClub1c0f = CherryClub1c0f or 0.5
local CherryClub1c10 = CherryClub1a07.TweenService:Create(CherryClub1b64.Humanoid, TweenInfo.new(CherryClub1c0f, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), { WalkSpeed = CherryClub1c0e })
CherryClub1c10:Play()
return CherryClub1c10
end
CherryClub1a14.SetRootPartAnchor = function(CherryClub1c11) CherryClub1b64.RootPart.Anchored = CherryClub1c11 end
CherryClub1a14.LaunchPlayer = function(CherryClub1c12: number, CherryClub1c13: Vector3, CherryClub1c14: number)
local CherryClub1c15 = Instance.new("BodyVelocity", CherryClub1b64.RootPart)
CherryClub1c15.MaxForce = Vector3.new(1e9, 0, 1e9)
CherryClub1c15.Velocity = CherryClub1c13 * CherryClub1c12 * CherryClub1b63:GetScale()
task.delay(CherryClub1c14, function() CherryClub1c15:Destroy() end)
return CherryClub1c15
end
task.spawn(function()
local CherryClub1c16 = CherryClub1b62.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("MouseLockController")
CherryClub1c16:FindFirstChild("BoundKeys").Value = "LeftControl, RightControl"
end)

-- hitbox functions
CherryClub1a16.CanHit = function(CherryClub1c17)
local CherryClub1c18 = os.clock()
if CherryClub1a1d.HitHumanoids[CherryClub1c17] and CherryClub1c18 < CherryClub1a1d.HitHumanoids[CherryClub1c17] then
return false
end
CherryClub1a1d.HitHumanoids[CherryClub1c17] = CherryClub1c18 + 1.15
return true
end
CherryClub1a16.FlashHitHighlight = function(CherryClub1c19: Model?)
if not CherryClub1c19 or not CherryClub1c19:IsA("Model") then return end
if CherryClub1c19:FindFirstChild("HitHighlight") then return end 
local CherryClub1c1a = Instance.new("Highlight", CherryClub1c19)
CherryClub1c1a.Name = "HitHighlight"
CherryClub1c1a.Adornee = CherryClub1c19
CherryClub1c1a.FillColor = Color3.fromRGB(0, 0, 0)
CherryClub1c1a.OutlineColor = Color3.fromRGB(255, 255, 255)
CherryClub1c1a.FillTransparency = 1
CherryClub1c1a.OutlineTransparency = 1
CherryClub1c1a.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
local CherryClub1c1b = CherryClub1a07.TweenService:Create(CherryClub1c1a, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {FillTransparency = 0.3, OutlineTransparency = 0})
local CherryClub1c1c = CherryClub1a07.TweenService:Create(CherryClub1c1a,TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {FillTransparency = 1,OutlineTransparency = 1})
CherryClub1c1b:Play()
CherryClub1c1b.Completed:Once(function() CherryClub1c1c:Play() end)
CherryClub1c1c.Completed:Once(function() CherryClub1c1a:Destroy() end)
end
CherryClub1a16.NewHitbox = function(CherryClub1c1d: CFrame, CherryClub1c1e: number, CherryClub1c1f: number)
local CherryClub1c20 = Instance.new("Part", CherryClub1b65)
CherryClub1c20.Size = CherryClub1c1e * CherryClub1b63:GetScale() or Vector3.new(4, 4, 4) 
CherryClub1c20.Color = CherryClub1a1e.Customization.HitboxColor
CherryClub1c20.Material = Enum.Material.ForceField
CherryClub1c20.Name = "EmpyreanHitbox"
CherryClub1c20.Transparency = CherryClub1a1e.Options.VisibleHitboxes and 0.5 or 1
CherryClub1c20.Anchored = true
CherryClub1c20.CanCollide = false
CherryClub1c20.CanQuery = false
CherryClub1c20.CanTouch = true
CherryClub1c20.CFrame = CherryClub1c1d or CherryClub1b64.RootPart.CFrame
local CherryClub1c21 = OverlapParams.new()
CherryClub1c21.FilterType = Enum.RaycastFilterType.Exclude
CherryClub1c21.FilterDescendantsInstances = { CherryClub1b63, CherryClub1a06}
local CherryClub1c22 = workspace:GetPartsInPart(CherryClub1c20, CherryClub1c21)
for CherryClub1c23, CherryClub1c24 in pairs(CherryClub1c22) do
local CherryClub1c25 = CherryClub1c24:FindFirstAncestorOfClass("Model")
if CherryClub1c25 and CherryClub1c25:FindFirstChildOfClass("Humanoid")  then
local CherryClub1c26 = CherryClub1c25:FindFirstChild("HumanoidRootPart")
if CherryClub1c26 and CherryClub1a16.CanHit(CherryClub1c25) then
CherryClub1a16.FlashHitHighlight(CherryClub1c25)
CherryClub1a13.PlaySFX(CherryClub1a1e.Customization.Hitmarker)
CherryClub1a13.PlaySFX(CherryClub1c1f or 108515070727256)
if CherryClub1a1e.Options.Fling then
if not CherryClub1a1d.IsStudio then CherryClub1a03.Fling(CherryClub1c25, CherryClub1a1e.DefaultFlingOptions) end
end
CherryClub1a1c.Input.LandedAttack = true;
task.delay(0.65, function()
CherryClub1a1c.Input.LandedAttack = false;
end)
end
end
end
local CherryClub1c27 = CherryClub1a07.TweenService:Create(CherryClub1c20, TweenInfo.new(0.5), {Transparency = 1})
CherryClub1c27:Play()
CherryClub1a07.Debris:AddItem(CherryClub1c20, 0.5)
return CherryClub1c20 -- added incase you wanna make it animated or even position it somewhere else (in retrospect is useless LOL)
end

-- bone setup
local CherryClub1c28 = {}
CherryClub1c28._0x25 = CherryClub1c28._0x25 or {}
CherryClub1c28._0x25 = {}
CherryClub1a17._0x1a3f = setmetatable({}, { __mode = "k" })
CherryClub1a17._0x2b7c = {}
CherryClub1a17._0x3c91 = nil
CherryClub1a17._0x4d02 = {}
CherryClub1a17._0x5e68 = {}
CherryClub1a17._0x6f1b = nil
CherryClub1a17._0x7a44 = 0.5
CherryClub1a17._0x8b95 = 45
CherryClub1a17._0x9c3e = 115
CherryClub1a17._0xad27 = 0.5
CherryClub1a17._0xbe80 = 0.6
CherryClub1a17._0xcf5d = {
RigHead = { _0x01 = "Head", _0x02 = CFrame.new(0, 1.5, 0) };
["RigTorso"] = { _0x01 = "Torso", _0x02 = CFrame.new(0, 1.5, 0) };
["RigUpperLeftLeg"] = "Left Leg";
["RigUpperRightLeg"] = "Right Leg";
["RigLowerLeftLeg"] = "Left Leg";
["RigLowerRightLeg"] = "Right Leg";
["RigUpperLeftArm"] = { _0x01 = "Left Arm", _0x02 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(90)) };
["RigLowerLeftArm"] = { _0x01 = "Left Arm", _0x02 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(90)) };
["RigLowerRightArm"] = { _0x01 = "Right Arm", _0x02 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(-90)) };
["RigUpperRightArm"] = { _0x01 = "Right Arm", _0x02 = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, CherryClub1a10(-90)) };
}
CherryClub1a17._0xd0a9 = {
RigLowerLeftArm = { _0x03 = "RigUpperLeftArm", _0x04 = "Left Arm", _0x05 = Vector3.new(-0.5, 0.4, 0), _0x06 = Vector3.new(-0.35, -0.6, 0.7) },
RigLowerRightArm = { _0x03 = "RigUpperRightArm", _0x04 = "Right Arm", _0x05 = Vector3.new(0.5, 0.4, 0), _0x06 = Vector3.new(0.35, -0.6, 0.7) },
RigLowerLeftLeg = { _0x03 = "RigUpperLeftLeg", _0x04 = "Left Leg", _0x05 = Vector3.new(-0.25, -0.5, 0), _0x06 = Vector3.new(-0.15, 0.4, -1) },
RigLowerRightLeg = { _0x03 = "RigUpperRightLeg", _0x04 = "Right Leg", _0x05 = Vector3.new(0.25, -0.5, 0), _0x06 = Vector3.new(0.15, 0.4, -1) },
}
for CherryClub1c29, CherryClub1c2a in pairs(CherryClub1a17._0xd0a9) do
CherryClub1a17._0x4d02[CherryClub1c29] = true
CherryClub1a17._0x4d02[CherryClub1c2a._0x03] = true
end
CherryClub1a17._0xe1c4 = function(CherryClub1c2b)
return CherryClub1c2b:FindFirstChildOfClass("RigidConstraint")
end
CherryClub1a17._0xf2d8 = function(CherryClub1c2c)
if type(CherryClub1c2c) == "table" then
return CherryClub1c2c._0x01, CherryClub1c2c._0x02 or CFrame.identity
elseif type(CherryClub1c2c) == "string" then
return CherryClub1c2c, CFrame.identity
end
return nil, nil
end
CherryClub1a17._0x0a6e = function(CherryClub1c2d, CherryClub1c2e)
local CherryClub1c2f = CherryClub1c2d.Magnitude
return CherryClub1c2f > 1e-4 and CherryClub1c2d / CherryClub1c2f or CherryClub1c2e
end
CherryClub1a17._0x1b73 = function(CherryClub1c30, CherryClub1c31, CherryClub1c32)
if CherryClub1c32 <= 0 then return CherryClub1c31 end
local CherryClub1c33 = CherryClub1c30.CFrame:PointToObjectSpace(CherryClub1c31)
local CherryClub1c34 = CherryClub1c30.Size / 2
local CherryClub1c35, CherryClub1c36, CherryClub1c37 = CherryClub1c34.X - math.abs(CherryClub1c33.X), CherryClub1c34.Y - math.abs(CherryClub1c33.Y), CherryClub1c34.Z - math.abs(CherryClub1c33.Z)
if CherryClub1c35 <= 0 or CherryClub1c36 <= 0 or CherryClub1c37 <= 0 then return CherryClub1c31 end
if CherryClub1c35 < CherryClub1c37 then
CherryClub1c33 = Vector3.new((CherryClub1c33.X >= 0 and 1 or -1) * (CherryClub1c34.X + math.min(CherryClub1c35, CherryClub1c32)), CherryClub1c33.Y, CherryClub1c33.Z)
else
CherryClub1c33 = Vector3.new(CherryClub1c33.X, CherryClub1c33.Y, (CherryClub1c33.Z > CherryClub1c34.Z * 0.25 and 1 or -1) * (CherryClub1c34.Z + math.min(CherryClub1c37, CherryClub1c32)))
end
return CherryClub1c30.CFrame:PointToWorldSpace(CherryClub1c33)
end
CherryClub1a17._0x2c0f = function(CherryClub1c38)
local CherryClub1c39, CherryClub1c3a = CherryClub1a17._0xf2d8(CherryClub1a17._0xcf5d[CherryClub1c38.Name])
local CherryClub1c3b = CherryClub1c39 and CherryClub1b63:FindFirstChild(CherryClub1c39)
local CherryClub1c3c = CherryClub1a17._0xe1c4(CherryClub1c38)
if not CherryClub1c3b or not CherryClub1c3c then return end
local CherryClub1c3d = CherryClub1c38.Name .. "_Attach"
if CherryClub1a17._0x1a3f[CherryClub1c38] == nil then
local CherryClub1c3e = CherryClub1c3c.Attachment1
CherryClub1a17._0x1a3f[CherryClub1c38] = (CherryClub1c3e and CherryClub1c3e.Name ~= CherryClub1c3d) and CherryClub1c3e or false
end
local CherryClub1c3f = CherryClub1c3b:FindFirstChild(CherryClub1c3d)
if not CherryClub1c3f then
CherryClub1c3f = Instance.new("Attachment")
CherryClub1c3f.Name = CherryClub1c3d
CherryClub1c3f.Parent = CherryClub1c3b
end
CherryClub1c3f.CFrame = CherryClub1c3a
CherryClub1c3c.Attachment1 = CherryClub1c3f
CherryClub1c3c.Enabled = true
end
CherryClub1a17._0x3d86 = function(CherryClub1c40)
local CherryClub1c41 = CherryClub1a17._0xe1c4(CherryClub1c40)
if not CherryClub1c41 then return end
local CherryClub1c42 = CherryClub1a17._0x1a3f[CherryClub1c40]
if CherryClub1c42 ~= nil then
CherryClub1c41.Attachment1 = CherryClub1c42 or nil
CherryClub1a17._0x1a3f[CherryClub1c40] = nil
end
CherryClub1c41.Enabled = true
local CherryClub1c43 = CherryClub1a17._0xf2d8(CherryClub1a17._0xcf5d[CherryClub1c40.Name])
local CherryClub1c44 = CherryClub1c43 and CherryClub1b63:FindFirstChild(CherryClub1c43)
local CherryClub1c45 = CherryClub1c44 and CherryClub1c44:FindFirstChild(CherryClub1c40.Name .. "_Attach")
if CherryClub1c45 then CherryClub1c45:Destroy() end
end
CherryClub1a17._0x4e5a = function(CherryClub1c46)
local CherryClub1c47, CherryClub1c48 = CherryClub1a17._0xf2d8(CherryClub1a17._0xcf5d[CherryClub1c46.Name])
local CherryClub1c49 = CherryClub1a17._0xe1c4(CherryClub1c46)
local CherryClub1c4a = CherryClub1c49 and CherryClub1c49.Attachment0
if CherryClub1c4a and CherryClub1c4a.Parent ~= CherryClub1c46 then CherryClub1c4a = nil end
return CherryClub1c48 * (CherryClub1c4a and CherryClub1c4a.CFrame:Inverse() or CFrame.identity)
end
CherryClub1a17._0x5f21 = function(CherryClub1c4b, CherryClub1c4c)
local CherryClub1c4d = CherryClub1c4c:VectorToObjectSpace(Vector3.yAxis)
local CherryClub1c4e = CherryClub1c4b.Size
return math.abs(CherryClub1c4d.X) * CherryClub1c4e.X + math.abs(CherryClub1c4d.Y) * CherryClub1c4e.Y + math.abs(CherryClub1c4d.Z) * CherryClub1c4e.Z
end
CherryClub1a17._0x6a9c = function(CherryClub1c4f, CherryClub1c50, CherryClub1c51)
local CherryClub1c52 = -CherryClub1c4f.UpVector
local CherryClub1c53 = CherryClub1c52:Cross(CherryClub1c50)
local CherryClub1c54 = math.clamp(CherryClub1c52:Dot(CherryClub1c50), -1, 1)
local CherryClub1c55
if CherryClub1c53.Magnitude < 1e-4 then
CherryClub1c55 = CherryClub1c54 > 0 and CFrame.identity or CFrame.fromAxisAngle(CherryClub1c4f.RightVector, math.pi)
else
CherryClub1c55 = CFrame.fromAxisAngle(CherryClub1c53.Unit, math.acos(CherryClub1c54))
end
return CFrame.new(CherryClub1c51) * (CherryClub1c55 * CherryClub1c4f.Rotation)
end
CherryClub1a17._0x7b38 = function(CherryClub1c56, CherryClub1c57)
local CherryClub1c58, CherryClub1c59, CherryClub1c5a, CherryClub1c5b = CherryClub1c56._0x10, CherryClub1c56._0x11, CherryClub1c56._0x12, CherryClub1c56._0x13
if not (CherryClub1c58.Parent and CherryClub1c59.Parent and CherryClub1c5a.Parent and CherryClub1c5b.Parent) then
CherryClub1a17._0x9d12(CherryClub1c5b)
return
end
local CherryClub1c5c = string.find(CherryClub1c56._0x14._0x04, "Arm") ~= nil
local CherryClub1c5d = CherryClub1c56._0x1b > 0 and CherryClub1b63:GetScale() / CherryClub1c56._0x1b or 1
local CherryClub1c5e, CherryClub1c5f = CherryClub1c56._0x17 * CherryClub1c5d, CherryClub1c56._0x18 * CherryClub1c5d
local CherryClub1c60 = CFrame.new(CherryClub1c56._0x15.Position * CherryClub1c5d) * CherryClub1c56._0x15.Rotation
local CherryClub1c61 = CFrame.new(CherryClub1c56._0x16.Position * CherryClub1c5d) * CherryClub1c56._0x16.Rotation
local CherryClub1c62 = CherryClub1c58.CFrame:PointToWorldSpace(CherryClub1c58.Size * CherryClub1c56._0x14._0x05)
local CherryClub1c63 = CherryClub1c59.CFrame:PointToWorldSpace(Vector3.new(0, -CherryClub1c59.Size.Y / 2, 0))
local CherryClub1c64, CherryClub1c65, CherryClub1c66
if CherryClub1c5c then
CherryClub1c64 = -CherryClub1c59.CFrame.UpVector
local CherryClub1c67 = CherryClub1c58.CFrame:VectorToObjectSpace(CherryClub1c64)
local CherryClub1c68 = math.clamp(-CherryClub1c67.Z, 0, 1) * math.clamp(1 + CherryClub1c67.Y, 0, 1)
local CherryClub1c69 = CherryClub1c68 * CherryClub1c68 * (3 - 2 * CherryClub1c68)
local CherryClub1c6a = CherryClub1a17._0x8b95 + (CherryClub1a17._0x9c3e - CherryClub1a17._0x8b95) * CherryClub1c69
local CherryClub1c6b = 1 - 0.5 ^ ((CherryClub1c57 or 1 / 60) * 20)
CherryClub1c56._0x1c = CherryClub1c56._0x1c and (CherryClub1c56._0x1c + (CherryClub1c6a - CherryClub1c56._0x1c) * CherryClub1c6b) or CherryClub1c6a
CherryClub1c66 = CherryClub1a10(CherryClub1c56._0x1c)
CherryClub1c65 = math.sqrt(CherryClub1c5e * CherryClub1c5e + CherryClub1c5f * CherryClub1c5f + 2 * CherryClub1c5e * CherryClub1c5f * math.cos(CherryClub1c66))
else
local CherryClub1c6c = CherryClub1c63 - CherryClub1c62
CherryClub1c64 = CherryClub1a17._0x0a6e(CherryClub1c6c, -CherryClub1c59.CFrame.UpVector)
local CherryClub1c6d = CherryClub1c6c.Magnitude
local CherryClub1c6e = 0.8
local CherryClub1c6f = math.clamp(CherryClub1c6d / ((CherryClub1c5e + CherryClub1c5f) * 0.97), CherryClub1c6e, 1)
CherryClub1c5e, CherryClub1c5f = CherryClub1c5e * CherryClub1c6f, CherryClub1c5f * CherryClub1c6f
local CherryClub1c70, CherryClub1c71 = math.abs(CherryClub1c5e - CherryClub1c5f) + 0.001, CherryClub1c5e + CherryClub1c5f - 0.001
CherryClub1c65 = math.clamp(CherryClub1c6d, CherryClub1c70, math.max(CherryClub1c70, CherryClub1c71))
end
local CherryClub1c72 = (CherryClub1c5e * CherryClub1c5e - CherryClub1c5f * CherryClub1c5f + CherryClub1c65 * CherryClub1c65) / (2 * CherryClub1c65)
local CherryClub1c73 = math.sqrt(math.max(CherryClub1c5e * CherryClub1c5e - CherryClub1c72 * CherryClub1c72, 0))
local CherryClub1c74 = CherryClub1c56._0x14._0x06
if CherryClub1c5c then
local CherryClub1c75 = CherryClub1c58.CFrame:VectorToObjectSpace(CherryClub1c64)
local CherryClub1c76 = math.sign(CherryClub1c56._0x14._0x05.X)
local CherryClub1c77 = math.clamp(CherryClub1c75.Y, 0, 1)
local CherryClub1c78 = math.clamp(-CherryClub1c75.Z, 0, 1)
CherryClub1c74 = CherryClub1c74:Lerp(Vector3.new(CherryClub1c76 * 0.8, -0.2, 0.5), CherryClub1c77 * 0.6)
CherryClub1c74 = CherryClub1c74:Lerp(Vector3.new(CherryClub1c76 * 0.4, -1, 0), CherryClub1c78 * 0.5)
end
local CherryClub1c79 = CherryClub1c58.CFrame:VectorToWorldSpace(CherryClub1c74).Unit
local CherryClub1c7a = CherryClub1c79 - CherryClub1c64 * CherryClub1c79:Dot(CherryClub1c64)
local CherryClub1c7b = CherryClub1c7a.Magnitude
local CherryClub1c7c
if CherryClub1c56._0x1d then
CherryClub1c7c = CherryClub1c56._0x1d
if CherryClub1c7b > 1e-3 then
local CherryClub1c7d = (1 - 0.5 ^ ((CherryClub1c57 or 1 / 60) * 60)) * math.clamp(CherryClub1c7b / 0.25, 0, 1)
CherryClub1c7c = CherryClub1c56._0x1d:Lerp(CherryClub1c7a / CherryClub1c7b, CherryClub1c7d)
end
else
CherryClub1c7c = CherryClub1c7b > 1e-3 and CherryClub1c7a / CherryClub1c7b or CherryClub1c58.CFrame.LookVector
end
CherryClub1c7c = CherryClub1a17._0x0a6e(CherryClub1c7c - CherryClub1c64 * CherryClub1c7c:Dot(CherryClub1c64), CherryClub1a17._0x0a6e(CherryClub1c64:Cross(CherryClub1c58.CFrame.RightVector), CherryClub1c58.CFrame.LookVector))
CherryClub1c56._0x1d = CherryClub1c7c
local CherryClub1c7e, CherryClub1c7f
if CherryClub1c5c then
local CherryClub1c80, CherryClub1c81 = CherryClub1c66 * CherryClub1a17._0xad27, CherryClub1c66 * (1 - CherryClub1a17._0xad27)
CherryClub1c7e = CherryClub1c62 + (CherryClub1c64 * math.cos(CherryClub1c80) + CherryClub1c7c * math.sin(CherryClub1c80)) * CherryClub1c5e
CherryClub1c7f = CherryClub1c7e + (CherryClub1c64 * math.cos(CherryClub1c81) - CherryClub1c7c * math.sin(CherryClub1c81)) * CherryClub1c5f
local CherryClub1c82 = CherryClub1c56._0x19 * CherryClub1a17._0xbe80 * CherryClub1c5d
CherryClub1c7e = CherryClub1c62 + CherryClub1a17._0x0a6e(CherryClub1a17._0x1b73(CherryClub1c58, CherryClub1c7e, CherryClub1c82) - CherryClub1c62, CherryClub1c64) * CherryClub1c5e
CherryClub1c7f = CherryClub1c7e + CherryClub1a17._0x0a6e(CherryClub1c7f - CherryClub1c7e, CherryClub1c64) * CherryClub1c5f
local CherryClub1c83 = (CherryClub1c7e + CherryClub1c7f) / 2
CherryClub1c7f = CherryClub1c7f + (CherryClub1a17._0x1b73(CherryClub1c58, CherryClub1c83, CherryClub1c82) - CherryClub1c83) * 2
CherryClub1c7f = CherryClub1c7e + CherryClub1a17._0x0a6e(CherryClub1a17._0x1b73(CherryClub1c58, CherryClub1c7f, CherryClub1c82) - CherryClub1c7e, CherryClub1c64) * CherryClub1c5f
else
CherryClub1c7e = CherryClub1c62 + CherryClub1c64 * CherryClub1c72 + CherryClub1c7c * CherryClub1c73
CherryClub1c7f = CherryClub1c62 + CherryClub1c64 * CherryClub1c65
end
local CherryClub1c84 = CherryClub1a17._0x0a6e(CherryClub1c7e - CherryClub1c62, CherryClub1c64)
local CherryClub1c85 = CherryClub1a17._0x0a6e(CherryClub1c7f - CherryClub1c7e, CherryClub1c64)
CherryClub1c5a.CFrame = CherryClub1a17._0x6a9c(CherryClub1c59.CFrame, CherryClub1c84, (CherryClub1c62 + CherryClub1c7e) / 2) * CherryClub1c60
CherryClub1c5b.CFrame = CherryClub1a17._0x6a9c(CherryClub1c59.CFrame, CherryClub1c85, (CherryClub1c7e + CherryClub1c7f) / 2) * CherryClub1c61
end
CherryClub1a17._0x8c4d = function(CherryClub1c86)
local CherryClub1c87 = CherryClub1a17._0xd0a9[CherryClub1c86.Name]
if not CherryClub1c87 then return end
local CherryClub1c88 = CherryClub1b63:FindFirstChild(CherryClub1c87._0x03, true)
local CherryClub1c89 = CherryClub1b63:FindFirstChild(CherryClub1c87._0x04)
local CherryClub1c8a = CherryClub1b63:FindFirstChild("RigTorso", true)
if not (CherryClub1c88 and CherryClub1c89 and CherryClub1c8a) then return end
CherryClub1a17._0x9d12(CherryClub1c86)
local CherryClub1c8b, CherryClub1c8c = CherryClub1a17._0x4e5a(CherryClub1c88), CherryClub1a17._0x4e5a(CherryClub1c86)
local CherryClub1c8d = {
_0x14 = CherryClub1c87, _0x12 = CherryClub1c88, _0x13 = CherryClub1c86, _0x11 = CherryClub1c89, _0x10 = CherryClub1c8a,
_0x15 = CherryClub1c8b, _0x16 = CherryClub1c8c,
_0x17 = CherryClub1a17._0x5f21(CherryClub1c88, CherryClub1c8b), _0x18 = CherryClub1a17._0x5f21(CherryClub1c86, CherryClub1c8c),
_0x19 = math.min(CherryClub1c88.Size.X, CherryClub1c88.Size.Y, CherryClub1c88.Size.Z) / 2,
_0x1a = { [CherryClub1c88] = CherryClub1c88.Anchored, [CherryClub1c86] = CherryClub1c86.Anchored },
_0x1b = CherryClub1b63:GetScale(),
}
for CherryClub1c8e, CherryClub1c8f in ipairs({ CherryClub1c88, CherryClub1c86 }) do
local CherryClub1c90 = CherryClub1a17._0xe1c4(CherryClub1c8f)
if CherryClub1c90 then CherryClub1c90.Enabled = false end
CherryClub1c8f.Anchored = true
end
CherryClub1a17._0x2b7c[CherryClub1c86] = CherryClub1c8d
if not CherryClub1a17._0x3c91 then
CherryClub1a17._0x3c91 = CherryClub1a07.RunService.PreRender:Connect(function(CherryClub1c91)
for CherryClub1c92, CherryClub1c93 in pairs(CherryClub1a17._0x2b7c) do
CherryClub1a17._0x7b38(CherryClub1c93, CherryClub1c91)
end
end)
CherryClub1c28._0x25[#CherryClub1c28._0x25 + 1] = CherryClub1a17._0x3c91
end
end
CherryClub1a17._0x9d12 = function(CherryClub1c94)
local CherryClub1c95 = CherryClub1a17._0x2b7c[CherryClub1c94]
if not CherryClub1c95 then return end
CherryClub1a17._0x2b7c[CherryClub1c94] = nil
for CherryClub1c96, CherryClub1c97 in pairs(CherryClub1c95._0x1a) do
CherryClub1c96.Anchored = CherryClub1c97
end
if next(CherryClub1a17._0x2b7c) == nil and CherryClub1a17._0x3c91 then
CherryClub1a17._0x3c91:Disconnect()
CherryClub1a17._0x3c91 = nil
end
end
CherryClub1a17._0xae87 = function(CherryClub1c98)
local CherryClub1c99, CherryClub1c9a, CherryClub1c9b, CherryClub1c9c = CherryClub1c98._0x1e, CherryClub1c98._0x1f, CherryClub1c98._0x20, CherryClub1c98._0x10
if not (CherryClub1c99.Parent and CherryClub1c9a.Parent and CherryClub1c9b.Parent and CherryClub1c9c.Parent) then
CherryClub1a17._0xc0e3(CherryClub1c99)
return
end
local CherryClub1c9d = CherryClub1c98._0x1b > 0 and CherryClub1b63:GetScale() / CherryClub1c98._0x1b or 1
local CherryClub1c9e = CherryClub1c9b.CFrame:ToObjectSpace(CherryClub1c9a.CFrame)
local CherryClub1c9f = CherryClub1c9e.Rotation * CherryClub1c98._0x21:Inverse()
local CherryClub1ca0 = CherryClub1c9e.Position - CherryClub1c98._0x22 * CherryClub1c9d
local CherryClub1ca1 = CFrame.new(0, CherryClub1c9c.Size.Y / 2 + CherryClub1a17._0x7a44 * CherryClub1c9d, 0)
CherryClub1c99.CFrame = CherryClub1c9c.CFrame * CFrame.new(CherryClub1ca0) * CherryClub1ca1 * CherryClub1c9f * CFrame.new(0, CherryClub1c99.Size.Y / 2, 0) * CherryClub1c98._0x23
end
CherryClub1a17._0xbf6b = function(CherryClub1ca2)
local CherryClub1ca3 = CherryClub1b63:FindFirstChild("Head")
local CherryClub1ca4 = CherryClub1b63:FindFirstChild("Torso")
local CherryClub1ca5 = CherryClub1b63:FindFirstChild("RigTorso", true)
if not (CherryClub1ca3 and CherryClub1ca4 and CherryClub1ca5) then return end
CherryClub1a17._0xc0e3(CherryClub1ca2)
local CherryClub1ca6 = CherryClub1ca4.CFrame:ToObjectSpace(CherryClub1ca3.CFrame)
CherryClub1a17._0x5e68[CherryClub1ca2] = {
_0x1e = CherryClub1ca2, _0x1f = CherryClub1ca3, _0x20 = CherryClub1ca4, _0x10 = CherryClub1ca5,
_0x21 = CherryClub1ca6.Rotation,
_0x22 = CherryClub1ca6.Position,
_0x23 = CherryClub1ca5.CFrame:ToObjectSpace(CherryClub1ca2.CFrame).Rotation,
_0x1b = CherryClub1b63:GetScale(),
_0x24 = CherryClub1ca2.Anchored,
}
local CherryClub1ca7 = CherryClub1a17._0xe1c4(CherryClub1ca2)
if CherryClub1ca7 then CherryClub1ca7.Enabled = false end
CherryClub1ca2.Anchored = true
if not CherryClub1a17._0x6f1b then
CherryClub1a17._0x6f1b = CherryClub1a07.RunService.PreSimulation:Connect(function()
for CherryClub1ca8, CherryClub1ca9 in pairs(CherryClub1a17._0x5e68) do
CherryClub1a17._0xae87(CherryClub1ca9)
end
end)
CherryClub1c28._0x25[#CherryClub1c28._0x25 + 1] = CherryClub1a17._0x6f1b
end
end
CherryClub1a17._0xc0e3 = function(CherryClub1caa)
local CherryClub1cab = CherryClub1a17._0x5e68[CherryClub1caa]
if not CherryClub1cab then return end
CherryClub1a17._0x5e68[CherryClub1caa] = nil
CherryClub1caa.Anchored = CherryClub1cab._0x24
if next(CherryClub1a17._0x5e68) == nil and CherryClub1a17._0x6f1b then
CherryClub1a17._0x6f1b:Disconnect()
CherryClub1a17._0x6f1b = nil
end
end
CherryClub1a17.AttachAll = function()
local CherryClub1cac = CherryClub1b64.Humanoid
if CherryClub1cac then CherryClub1cac.HipHeight = 0.2 end
for CherryClub1cad, CherryClub1cae in ipairs(CherryClub1b63:GetDescendants()) do
if CherryClub1cae:IsA("BasePart") and CherryClub1a17._0xcf5d[CherryClub1cae.Name] then
if CherryClub1a17._0xd0a9[CherryClub1cae.Name] then
CherryClub1a17._0x8c4d(CherryClub1cae)
elseif CherryClub1cae.Name == "RigHead" then
CherryClub1a17._0xbf6b(CherryClub1cae)
elseif not CherryClub1a17._0x4d02[CherryClub1cae.Name] then
CherryClub1a17._0x2c0f(CherryClub1cae)
end
end
end
end
CherryClub1a17.DetachAll = function()
local CherryClub1caf = CherryClub1b64.Humanoid
if CherryClub1caf then CherryClub1caf.HipHeight = 0 end
for CherryClub1cb0, CherryClub1cb1 in ipairs(CherryClub1b63:GetDescendants()) do
if CherryClub1cb1:IsA("BasePart") and CherryClub1a17._0xd0a9[CherryClub1cb1.Name] then
CherryClub1a17._0x9d12(CherryClub1cb1)
end
end
for CherryClub1cb2, CherryClub1cb3 in ipairs(CherryClub1b63:GetDescendants()) do
if CherryClub1cb3:IsA("BasePart") and CherryClub1cb3.Name == "RigHead" then
CherryClub1a17._0xc0e3(CherryClub1cb3)
end
end
for CherryClub1cb4, CherryClub1cb5 in ipairs(CherryClub1b63:GetDescendants()) do
if CherryClub1cb5:IsA("BasePart") and CherryClub1a17._0xcf5d[CherryClub1cb5.Name] then
CherryClub1a17._0x3d86(CherryClub1cb5)
end
end
end
CherryClub1a17.AttachAll()

-- ui setup
CherryClub1a19.PaperSounds = {
135041843438612,
9125723307,
82896519916504,
131637122852317,
9125654187
}
CherryClub1a19.MainGUI = CherryClub1a15.UIs:WaitForChild("MainGUI"):Clone()
table.insert(CherryClub1a1d.TrashBin, CherryClub1a19.MainGUI)
local CherryClub1cb6 = CherryClub1a15.UIs:WaitForChild("MobileUI")
table.insert(CherryClub1a1d.TrashBin, CherryClub1cb6)
if CherryClub1a1d.IsStudio then
CherryClub1a19.MainGUI.Parent = CherryClub1b62.PlayerGui
CherryClub1cb6.Parent = CherryClub1b62.PlayerGui
else
CherryClub1a19.MainGUI.Parent = CherryClub1a07.CoreGui
CherryClub1cb6.Parent = CherryClub1a07.CoreGui
end
local CherryClub1cb7 = function()
local CherryClub1cb8 = CherryClub1a07.UserInputService:GetLastInputType()
if CherryClub1cb8 == Enum.UserInputType.Touch
then CherryClub1cb6.Enabled = true
else CherryClub1cb6.Enabled = false
end
end
CherryClub1cb7()
CherryClub1a07.UserInputService.LastInputTypeChanged:Connect(CherryClub1cb7)
CherryClub1a19.Topbar = CherryClub1a19.MainGUI.Topbar
CherryClub1a19.Holder = CherryClub1a19.Topbar.Holder
CherryClub1a19.MainUI = {	
Shutters = {
TopShutter = CherryClub1a19.Holder.Shutters.Top;
BottomShutter = CherryClub1a19.Holder.Shutters.Bottom;
TopShutterPosition = UDim2.new(0.5, 0, 0.248, 0);
TopShutterClosedPosition = UDim2.new(0.5, 0, -0.321, 0);
BottomShutterPosition = UDim2.new(0.5, 0, 0.746, 0);
BottomShutterClosedPosition = UDim2.new(0.5, 0, 1.259, 0);
TweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)
};
CurrentTab = nil;
}
CherryClub1a19.Tabs = {
StartMenu = CherryClub1a19.Holder.StartMenu;
HomeMenu = CherryClub1a19.Holder.HomeMenu;
EmotesMenu = CherryClub1a19.Holder.EmotesMenu;
MusicMenu = CherryClub1a19.Holder.MusicMenu;
SettingsMenu = CherryClub1a19.Holder.SettingsMenu;
};
CherryClub1a19.Tween = function(CherryClub1cb9, CherryClub1cba, CherryClub1cbb)
local CherryClub1cbc = CherryClub1a07.TweenService:Create(CherryClub1cb9, CherryClub1cbb, CherryClub1cba)
CherryClub1cbc:Play()
return CherryClub1cbc
end
CherryClub1a19.SetShuttersState = function(CherryClub1cbd)
local CherryClub1cbe = CherryClub1a19.MainUI.Shutters.TopShutter
local CherryClub1cbf = CherryClub1a19.MainUI.Shutters.BottomShutter
local CherryClub1cc0, CherryClub1cc1
if CherryClub1cbd then
CherryClub1cc0 = CherryClub1a19.Tween(CherryClub1cbe, {Position = CherryClub1a19.MainUI.Shutters.TopShutterPosition}, CherryClub1a19.MainUI.Shutters.TweenInfo)
CherryClub1cc1 = CherryClub1a19.Tween(CherryClub1cbf, {Position = CherryClub1a19.MainUI.Shutters.BottomShutterPosition}, CherryClub1a19.MainUI.Shutters.TweenInfo)
CherryClub1a13.PlaySFX(CherryClub1a19.PaperSounds[math.random(1, #CherryClub1a19.PaperSounds)])
else
CherryClub1cc0 = CherryClub1a19.Tween(CherryClub1cbe, {Position = CherryClub1a19.MainUI.Shutters.TopShutterClosedPosition}, CherryClub1a19.MainUI.Shutters.TweenInfo)
CherryClub1cc1 = CherryClub1a19.Tween(CherryClub1cbf, {Position = CherryClub1a19.MainUI.Shutters.BottomShutterClosedPosition}, CherryClub1a19.MainUI.Shutters.TweenInfo)
CherryClub1a13.PlaySFX(CherryClub1a19.PaperSounds[math.random(1, #CherryClub1a19.PaperSounds)])
end	
return CherryClub1cc0, CherryClub1cc1
end
CherryClub1a19.HoverPulse = function(CherryClub1cc2)
local CherryClub1cc3 = CherryClub1cc2.Size
local CherryClub1cc4 = function(CherryClub1cc5)
return UDim2.new(CherryClub1cc3.X.Scale * CherryClub1cc5, CherryClub1cc3.X.Offset * CherryClub1cc5, CherryClub1cc3.Y.Scale * CherryClub1cc5, CherryClub1cc3.Y.Offset * CherryClub1cc5)
end
CherryClub1cc2.MouseEnter:Connect(function()
CherryClub1a19.Tween(CherryClub1cc2, {Size = CherryClub1cc4(1.2)}, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out))
end)
CherryClub1cc2.MouseLeave:Connect(function()
CherryClub1a19.Tween(CherryClub1cc2, {Size = CherryClub1cc3}, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out))
end)
end
CherryClub1a19.SetContainerVisible = function(CherryClub1cc6, CherryClub1cc7)
for CherryClub1cc8, CherryClub1cc9 in ipairs(CherryClub1cc6:GetChildren()) do
if CherryClub1cc9:IsA("GuiObject") then
CherryClub1cc9.Visible = CherryClub1cc7
end
end
end
CherryClub1a19.Transitioning = false
CherryClub1a19.SetTab = function(CherryClub1cca)
if CherryClub1a19.Transitioning or CherryClub1a19.MainUI.CurrentTab == CherryClub1cca then return end
CherryClub1a19.Transitioning = true
local CherryClub1ccb = CherryClub1a19.SetShuttersState(true)
CherryClub1ccb.Completed:Wait()
if CherryClub1a19.MainUI.CurrentTab and CherryClub1a19.Tabs[CherryClub1a19.MainUI.CurrentTab] then CherryClub1a19.SetContainerVisible(CherryClub1a19.Tabs[CherryClub1a19.MainUI.CurrentTab], false) end
if CherryClub1a19.Tabs[CherryClub1cca] then CherryClub1a19.SetContainerVisible(CherryClub1a19.Tabs[CherryClub1cca], true) end
CherryClub1a19.MainUI.CurrentTab = CherryClub1cca
task.wait(0.1)
local CherryClub1ccc = CherryClub1a19.SetShuttersState(false)
CherryClub1ccc.Completed:Wait()
CherryClub1a19.Transitioning = false
end
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.StartMenu.Button)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.EmotesMenu.Back)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.EmotesMenu.Refresh)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.MusicMenu.Back)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.MusicMenu.Next)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.MusicMenu.Previous)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.SettingsMenu.Back)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.HomeMenu.Back)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.HomeMenu.Music)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.HomeMenu.Settings)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.HomeMenu.Credits)
CherryClub1a19.HoverPulse(CherryClub1a19.Tabs.HomeMenu.Emotes)
CherryClub1a19.Tabs.StartMenu.Button.MouseButton1Click:Connect(function()
CherryClub1a19.SetTab("HomeMenu")
CherryClub1a19.SetContainerVisible(CherryClub1a19.Tabs.StartMenu, false)
end)
CherryClub1a19.Tabs.StartMenu.Background.Cherry.MouseButton1Click:Connect(function() CherryClub1a13.PlaySFX(134881862056957) end)
CherryClub1a19.Tabs.HomeMenu.Settings.MouseButton1Click:Connect(function() CherryClub1a19.SetTab("SettingsMenu") end)
CherryClub1a19.Tabs.HomeMenu.Emotes.MouseButton1Click:Connect(function() CherryClub1a19.SetTab("EmotesMenu") end)
CherryClub1a19.Tabs.HomeMenu.Music.MouseButton1Click:Connect(function() CherryClub1a19.SetTab("MusicMenu") end)
CherryClub1a19.Tabs.HomeMenu.Back.MouseButton1Click:Connect(function() CherryClub1a19.SetTab("StartMenu") end)
CherryClub1a19.Tabs.SettingsMenu.Back.MouseButton1Click:Connect(function() CherryClub1a19.SetTab("HomeMenu") end)
CherryClub1a19.Tabs.MusicMenu.Back.MouseButton1Click:Connect(function() CherryClub1a19.SetTab("HomeMenu") end)
CherryClub1a19.Tabs.EmotesMenu.Back.MouseButton1Click:Connect(function() CherryClub1a19.SetTab("HomeMenu") end)
CherryClub1a19.Tabs.EmotesMenu.Refresh.MouseButton1Click:Connect(function() CherryClub1a18.RefreshEmotes() end)
CherryClub1a19.Tabs.HomeMenu.Back.MouseButton1Click:Connect(function() CherryClub1a19.SetTab("StartMenu") end)

-- emotes setup (expanded so it got its own section)
local CherryClub1ccd = CherryClub1a19.Tabs.EmotesMenu.EmotesHolder.Template:Clone()
CherryClub1ccd.Parent = nil
CherryClub1a19.Tabs.EmotesMenu.EmotesHolder:WaitForChild("Template"):Destroy()
CherryClub1a19.Tabs.EmotesMenu.EmotesHolder.Visible = false
CherryClub1a18.EmoteCache = {}
CherryClub1a18.ClearEmote = function(CherryClub1cce)
local CherryClub1ccf = CherryClub1a18.EmoteCache[CherryClub1cce]
if not CherryClub1ccf then return end
for CherryClub1cd0, CherryClub1cd1 in ipairs(CherryClub1ccf.Templates) do CherryClub1cd1:Destroy()  end
CherryClub1a1d.EmoteCount -= #CherryClub1ccf.Templates
CherryClub1a18.EmoteCache[CherryClub1cce] = nil
end
CherryClub1a18.PlayEmote = function(CherryClub1cd2)
CherryClub1a13.PlaySFX(17767112842)
if CherryClub1a1c.Input.Debounce and not CherryClub1a1c.Input.Emoting then return end
if CherryClub1a1c.Input.Emoting and CherryClub1a1d.CurrentEmoteTrack and CherryClub1a1b.Rigs[CherryClub1b63] and CherryClub1a1b.Rigs[CherryClub1b63][CherryClub1cd2.Name] == CherryClub1a1d.CurrentEmoteTrack then
CherryClub1a1b.StopEmote()
CherryClub1a1b.RestoreMovement()
return
end
if not CherryClub1a1c.Input.Emoting then
CherryClub1a1d.SavedSongIndex = CherryClub1a1d.CurrentSongIndex
CherryClub1a1d.SavedTimePosition = CherryClub1b66.TimePosition
end
CherryClub1a1b.StopEmote(true)
CherryClub1a1c.Input.Emoting = true
CherryClub1a1c.Input.Debounce = true
CherryClub1a1d.CurrentEmoteTrack = CherryClub1a1b.PlayAnim(CherryClub1b63, CherryClub1cd2, 0)
local CherryClub1cd3 = CherryClub1a1e.EmoteAudioOverrides[CherryClub1cd2.Name] or CherryClub1cd2.Name
local CherryClub1cd4 = CherryClub1a1e.Directories.EmoteSongs .. CherryClub1cd3 .. ".mp3"
if not CherryClub1a0a(CherryClub1cd4) then
CherryClub1cd4 = CherryClub1a1e.Directories.EmoteSongs .. CherryClub1cd3 .. ".ogg"
end
if CherryClub1a0a(CherryClub1cd4) then
pcall(function()
CherryClub1b66.SoundId = CherryClub1a08(CherryClub1cd4)
CherryClub1a1a.UpdateSong(CherryClub1cd3)
end)
else
CherryClub1a14.SendNotification(CherryClub1cd3 .. " did not have an audio file, replaced with placeholder!")
CherryClub1b66.SoundId = "rbxassetid://130537833459944"
CherryClub1a1a.UpdateSong("adddadadadadadadadada")
end
CherryClub1b66.Name = CherryClub1cd3
CherryClub1b66.TimePosition = 0
CherryClub1b66:Play()
end
CherryClub1a18.LoadEmote = function(CherryClub1cd5, CherryClub1cd6)
local CherryClub1cd7 = CherryClub1cd5:lower()
local CherryClub1cd8 = {}
if CherryClub1cd7:match("%.rbxmx?$") then
local CherryClub1cd9, CherryClub1cda = pcall(function() return CherryClub1a07.InsertService:LoadLocalAsset(CherryClub1a08(CherryClub1cd5)) end)
if CherryClub1cd9 and CherryClub1cda then
local CherryClub1cdb = CherryClub1cda:GetDescendants()
table.insert(CherryClub1cdb, 1, CherryClub1cda)
for CherryClub1cdc, CherryClub1cdd in ipairs(CherryClub1cdb) do
if CherryClub1cdd:IsA("KeyframeSequence") then table.insert(CherryClub1cd8, CherryClub1cdd) end
end
end
elseif CherryClub1cd7:match("%.anim$") then
local CherryClub1cde, CherryClub1cdf = pcall(CherryClub1a1b.ParseAnim, CherryClub1cd6, CherryClub1cd5)
if CherryClub1cde and CherryClub1cdf then table.insert(CherryClub1cd8, CherryClub1cdf) end
else
return
end
local CherryClub1ce0 = { Content = CherryClub1cd6, Templates = {} }
CherryClub1a18.EmoteCache[CherryClub1cd5] = CherryClub1ce0
CherryClub1a1d.EmoteCount += #CherryClub1cd8
for CherryClub1ce1, CherryClub1ce2 in ipairs(CherryClub1cd8) do
local CherryClub1ce3 = CherryClub1ccd:Clone()
CherryClub1ce3.Name = CherryClub1ce2.Name
CherryClub1ce3.Title.Text = CherryClub1ce2.Name
CherryClub1ce3.Parent = CherryClub1a19.Tabs.EmotesMenu.EmotesHolder
CherryClub1ce3.Visible = true
CherryClub1ce3.Button.MouseButton1Click:Connect(function()
if not CherryClub1a05 then return end
CherryClub1a18.PlayEmote(CherryClub1ce2)
end)
table.insert(CherryClub1ce0.Templates, CherryClub1ce3)
end
end
CherryClub1a18.RefreshEmotes = function()
local CherryClub1ce4 = {}
for CherryClub1ce5, CherryClub1ce6 in ipairs(CherryClub1a0b(CherryClub1a1e.Directories.Emotes)) do
CherryClub1ce4[CherryClub1ce6] = true
end
for CherryClub1ce7, CherryClub1ce8 in pairs(CherryClub1a18.EmoteCache) do
if not CherryClub1ce4[CherryClub1ce7] then CherryClub1a18.ClearEmote(CherryClub1ce7) end
end
for CherryClub1ce9, CherryClub1cea in pairs(CherryClub1ce4) do
local CherryClub1ceb, CherryClub1cec = pcall(CherryClub1a09, CherryClub1ce9)
local CherryClub1ced = CherryClub1a18.EmoteCache[CherryClub1ce9]
if CherryClub1ceb and (not CherryClub1ced or CherryClub1ced.Content ~= CherryClub1cec) then
CherryClub1a18.ClearEmote(CherryClub1ce9)
CherryClub1a18.LoadEmote(CherryClub1ce9, CherryClub1cec)
end
end
end
if CherryClub1a1e.Customization.EmotesLibrary then CherryClub1a18.RefreshEmotes() end
CherryClub1a14.SendNotification("loaded " .. CherryClub1a1d.EmoteCount .. " emotes.")

-- overall ui stuff idk
local CherryClub1cee = function(CherryClub1cef: string)
local CherryClub1cf0 = CherryClub1a19.Tabs.SettingsMenu.SettingsHolder:FindFirstChild(CherryClub1cef)
if not CherryClub1cf0 then return end
local CherryClub1cf1 = CherryClub1cf0:FindFirstChildWhichIsA("TextButton")
if not CherryClub1cf1 then return end
CherryClub1cf1.BackgroundColor3 = CherryClub1a1e.Options[CherryClub1cef] and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
CherryClub1cf1.MouseButton1Click:Connect(function()
if not CherryClub1a05 then return end
CherryClub1a13.PlaySFX(17767069818)
CherryClub1a1e.Options[CherryClub1cef] = not CherryClub1a1e.Options[CherryClub1cef]
CherryClub1cf1.BackgroundColor3 = CherryClub1a1e.Options[CherryClub1cef] and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
end)
end
local CherryClub1cf2 = function(CherryClub1cf3: string, CherryClub1cf4: number, CherryClub1cf5: number)
local CherryClub1cf6 = CherryClub1a19.Tabs.SettingsMenu.SettingsHolder:FindFirstChild(CherryClub1cf3)
if not CherryClub1cf6 then return end
local CherryClub1cf7 = CherryClub1cf6:FindFirstChildWhichIsA("TextBox")
if not CherryClub1cf7 then return end
local CherryClub1cf8 = CherryClub1cf6:FindFirstChild("Minimum") and CherryClub1cf6.Minimum.Value or -math.huge
local CherryClub1cf9 = CherryClub1cf6:FindFirstChild("Maximum") and CherryClub1cf6.Maximum.Value or math.huge
CherryClub1cf7.Text = tostring(CherryClub1a1e.Options[CherryClub1cf3])
CherryClub1cf7.FocusLost:Connect(function()
local CherryClub1cfa = tonumber(CherryClub1cf7.Text)
if CherryClub1cfa then CherryClub1a1e.Options[CherryClub1cf3] = math.clamp(CherryClub1cfa, CherryClub1cf8, CherryClub1cf9) else CherryClub1cf7.Text = tonumber(CherryClub1a1e.Options[CherryClub1cf3])
end
end)
end
for CherryClub1cfb, CherryClub1cfc in pairs(CherryClub1a1e.Options) do
local CherryClub1cfd = CherryClub1a19.Tabs.SettingsMenu.SettingsHolder:FindFirstChild(CherryClub1cfb)
if CherryClub1cfd then
if CherryClub1cfd:FindFirstChild("Button") then
CherryClub1cee(CherryClub1cfb)
elseif CherryClub1cfd:FindFirstChild("Value") then
CherryClub1cf2(CherryClub1cfb)
end
end
end
CherryClub1a19.Topbar.UIDragDetector.DragStart:Connect(function()
CherryClub1a19.Holder.Visible = not CherryClub1a19.Holder.Visible
CherryClub1a13.PlaySFX(CherryClub1a19.PaperSounds[math.random(1, #CherryClub1a19.PaperSounds)])
end)
CherryClub1a19.Tabs.SettingsMenu.SettingsHolder.TPToNearestSpawn.Button.MouseButton1Click:Connect(function()
CherryClub1a13.PlaySFX(17767112842)
local CherryClub1cfe = function()
local CherryClub1cff, CherryClub1d00 = nil, math.huge
for CherryClub1d01, CherryClub1d02 in pairs(workspace:GetDescendants()) do
if CherryClub1d02:IsA("SpawnLocation") then
local CherryClub1d03 = (CherryClub1b64.RootPart.Position - CherryClub1d02.Position).Magnitude
if CherryClub1d03 < CherryClub1d00 then
CherryClub1cff = CherryClub1d02
CherryClub1d00 = CherryClub1d03
end
end
end
return CherryClub1cff
end
local CherryClub1d04 = CherryClub1cfe()
if CherryClub1d04 then CherryClub1b64.RootPart.CFrame = CherryClub1d04.CFrame + Vector3.new(0, 5, 0) else warn("No one is around to help.") end
end)
local CherryClub1d05 = function()
CherryClub1a19.Tabs.EmotesMenu.EmotesHolder.CanvasPosition = Vector2.new(0, 0)
local CherryClub1d06 = string.lower(CherryClub1a19.Tabs.EmotesMenu.SearchBar.Text)
local CherryClub1d07 = CherryClub1a19.Tabs.EmotesMenu.EmotesHolder:GetChildren()
for CherryClub1d08, CherryClub1d09 in ipairs(CherryClub1d07) do
if CherryClub1d09:IsA("GuiObject") then CherryClub1d09.Visible = CherryClub1d06 == "" or string.find(string.lower(CherryClub1d09.Name), CherryClub1d06, 1, true) ~= nil end
end
end
CherryClub1a19.Tabs.EmotesMenu.SearchBar:GetPropertyChangedSignal("Text"):Connect(CherryClub1d05)
for CherryClub1d0a, CherryClub1d0b in pairs(CherryClub1a1b.AnimDefaults[CherryClub1b63]) do CherryClub1a1d.AnimDefaultsCached[CherryClub1d0a] = CherryClub1d0b end
local CherryClub1d0c = function(CherryClub1d0d: number)
CherryClub1a1d.CurrentScale = CherryClub1d0d
local CherryClub1d0e = {}
for CherryClub1d0f, CherryClub1d10 in ipairs(CherryClub1b63:GetDescendants()) do
if CherryClub1d10:IsA("BasePart") and CherryClub1d10.Name == "Handle" then
CherryClub1d0e[CherryClub1d10] = { Size = CherryClub1d10.Size }
local CherryClub1d11 = CherryClub1d10:FindFirstChildOfClass("SpecialMesh")
if CherryClub1d11 then CherryClub1d0e[CherryClub1d10].MeshScale = CherryClub1d11.Scale end
end
end
CherryClub1b63:ScaleTo(CherryClub1d0d)
CherryClub1b63:SetPrimaryPartCFrame(CherryClub1b63.PrimaryPart.CFrame * CFrame.new(0, 16, 0))
for CherryClub1d12, CherryClub1d13 in next, CherryClub1d0e do
CherryClub1d12.Size = CherryClub1d13.Size
local CherryClub1d14 = CherryClub1d12:FindFirstChildOfClass("SpecialMesh")
if CherryClub1d14 and CherryClub1d13.MeshScale then CherryClub1d14.Scale = CherryClub1d13.MeshScale end
end
for CherryClub1d15, CherryClub1d16 in ipairs(CherryClub1b63:GetDescendants()) do
if CherryClub1d16:IsA("Motor6D") and CherryClub1d16.Part1 then
local CherryClub1d17 = CherryClub1a1b.JointPaths[CherryClub1b63][CherryClub1d16]
local CherryClub1d18 = CherryClub1d17 and CherryClub1a1d.AnimDefaultsCached[CherryClub1d17]
if CherryClub1d18 then
local CherryClub1d19 = CherryClub1d18.Rotation + (CherryClub1d18.Position * CherryClub1d0d)
CherryClub1d16.C0 = CherryClub1d19
CherryClub1a1b.AnimDefaults[CherryClub1b63][CherryClub1d17] = CherryClub1d19
end
elseif CherryClub1d16:IsA("Bone") then
local CherryClub1d1a = CherryClub1a1b.JointPaths[CherryClub1b63][CherryClub1d16]
local CherryClub1d1b = CherryClub1d1a and CherryClub1a1d.AnimDefaultsCached[CherryClub1d1a]
if CherryClub1d1b then
local CherryClub1d1c = CherryClub1d1b.Rotation + (CherryClub1d1b.Position * CherryClub1d0d)
CherryClub1d16.CFrame = CherryClub1d1c
CherryClub1a1b.AnimDefaults[CherryClub1b63][CherryClub1d1a] = CherryClub1d1c
end
end
end
end
local CherryClub1d1d = CherryClub1a19.Tabs.SettingsMenu.SettingsHolder:FindFirstChild("RigSize"):FindFirstChildWhichIsA("TextBox")
CherryClub1d1d.FocusLost:Connect(function()
local CherryClub1d1e = tonumber(CherryClub1d1d.Text)
if CherryClub1d1e then CherryClub1d0c(math.clamp(CherryClub1d1e, 0.45, 7.25)) else CherryClub1d1d.Text = "1" end
end)
CherryClub1a19.Tabs.MusicMenu.Next.MouseButton1Click:Connect(function()
if not CherryClub1a05 then return end
if CherryClub1a1c.Input.Debounce then return end
CherryClub1a13.NextSong()
CherryClub1a1a.UpdateSong(CherryClub1b66.Name)
end)
CherryClub1a19.Tabs.MusicMenu.Previous.MouseButton1Click:Connect(function()
if not CherryClub1a05 then return end
if CherryClub1a1c.Input.Debounce then return end
CherryClub1a13.PreviousSong()
CherryClub1a1a.UpdateSong(CherryClub1b66.Name)
end)
CherryClub1a19.Tabs.MusicMenu.ProgressBar.Active = true
CherryClub1a19.Tabs.MusicMenu.ProgressBar.InputBegan:Connect(function(CherryClub1d1f)
if CherryClub1a1c.Input.Emoting then return end
if CherryClub1d1f.UserInputType == Enum.UserInputType.MouseButton1 or CherryClub1d1f.UserInputType == Enum.UserInputType.Touch then
local CherryClub1d20 = (CherryClub1d1f.Position.X - CherryClub1a19.Tabs.MusicMenu.ProgressBar.absolutePosition.X) / CherryClub1a19.Tabs.MusicMenu.ProgressBar.absoluteSize.X
CherryClub1b66.TimePosition = math.clamp(CherryClub1d20, 0, 1) * CherryClub1b66.TimeLength
end
end)

-- keybinds and attacks
local CherryClub1d21 = true
local CherryClub1d22 = true
local CherryClub1d23 = true
local CherryClub1d24 = function(CherryClub1d25) return CherryClub1d25["adminnoliwillreturnin2027"] end
local CherryClub1d26, CherryClub1d27 = CherryClub1b63.FakeHead, CherryClub1b63.FakeTorso
local CherryClub1d28, CherryClub1d29 = CherryClub1b63.FakeLeftArm, CherryClub1b63.FakeRightArm
local CherryClub1d2a, CherryClub1d2b = CherryClub1b63.FakeLeftLeg, CherryClub1b63.FakeRightLeg
local CherryClub1d2c, CherryClub1d2d = CherryClub1b63.FakeCorruptNature, CherryClub1b63.FakeFirebrand
local CherryClub1d2e = CherryClub1d24(CherryClub1d26)
local CherryClub1d2f = CherryClub1d24(CherryClub1d27)
local CherryClub1d30 = CherryClub1d24(CherryClub1d28)
local CherryClub1d31 = CherryClub1d24(CherryClub1d29)
local CherryClub1d32 = CherryClub1d24(CherryClub1d2a)
local CherryClub1d33 = CherryClub1d24(CherryClub1d2b)
local CherryClub1d34 = CherryClub1d24(CherryClub1d2c)
local CherryClub1d35 = CherryClub1d24(CherryClub1d2d)
local CherryClub1d36 = {
["Head"] = CherryClub1d2e,
["Torso"] = CherryClub1d2f,
["Left Arm"] = CherryClub1d30,
["Right Arm"] = CherryClub1d31,
["Left Leg"] = CherryClub1d32,
["Right Leg"] = CherryClub1d33,
}
local CherryClub1d37 = function(CherryClub1d38)
for CherryClub1d39, CherryClub1d3a in CherryClub1d38:GetDescendants() do
if CherryClub1d3a:IsA("Motor6D") and CherryClub1d3a.Part0 and CherryClub1d3a.Part1 then
local CherryClub1d3b, CherryClub1d3c = Instance.new("Attachment"), Instance.new("Attachment")
CherryClub1d3b.CFrame, CherryClub1d3c.CFrame = CherryClub1d3a.C0, CherryClub1d3a.C1
CherryClub1d3b.Parent, CherryClub1d3c.Parent = CherryClub1d3a.Part0, CherryClub1d3a.Part1
local CherryClub1d3d = Instance.new("BallSocketConstraint")
CherryClub1d3d.Attachment0, CherryClub1d3d.Attachment1 = CherryClub1d3b, CherryClub1d3c
CherryClub1d3d.LimitsEnabled = true
CherryClub1d3d.TwistLimitsEnabled = true
CherryClub1d3d.Parent = CherryClub1d3a.Part1
CherryClub1d3a.Enabled = false
end
end
for CherryClub1d3e, CherryClub1d3f in CherryClub1d38:GetDescendants() do
if CherryClub1d3f:IsA("BasePart") and CherryClub1d3f.Name ~= "HumanoidRootPart" then CherryClub1d3f.CanCollide = true end
end
end
local CherryClub1d40 = function(CherryClub1d41, CherryClub1d42)
task.spawn(function()
local CherryClub1d43 = os.clock()
while CherryClub1d41.Parent and os.clock() - CherryClub1d43 < CherryClub1d42 do
local CherryClub1d44 = 1 - (os.clock() - CherryClub1d43) / CherryClub1d42
for CherryClub1d45, CherryClub1d46 in CherryClub1d41:GetChildren() do
if CherryClub1d46:IsA("BasePart") and CherryClub1d46.Name ~= "HumanoidRootPart" then
local CherryClub1d47 = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5)
CherryClub1d46:ApplyAngularImpulse(CherryClub1d47 * CherryClub1d46.Mass * 40 * CherryClub1d44)
end
end
task.wait(0.1)
end
end)
end
CherryClub1a11.LaunchBullet = function()
local CherryClub1d48, CherryClub1d49  = false, false
local CherryClub1d4a, CherryClub1d4b, CherryClub1d4c
CherryClub1d4a = Instance.new("Part")
CherryClub1d4a.Transparency = 0.95
CherryClub1d4a.Size = Vector3.new(2, 1, 1)
CherryClub1d4a.Name = "EmpyreanProjectile"
CherryClub1d4a.Anchored = false
CherryClub1d4a.Massless = true
CherryClub1d4a.CanCollide = false
CherryClub1d4a.CFrame = CFrame.new(CherryClub1b64.RootPart.Position + CherryClub1b64.RootPart.CFrame.LookVector * 5, CherryClub1a12.Mouse.Hit.Position)
CherryClub1d4a.Parent = CherryClub1b65
CherryClub1d34.Part0 = CherryClub1d4a
CherryClub1d34.C0 = CFrame.identity
local CherryClub1d4d = Instance.new("Sound", CherryClub1d4a)
CherryClub1d4d.SoundId = "rbxassetid://125458211367708"
CherryClub1d4d.Volume = 2
CherryClub1d4d:Play()
CherryClub1d4b = Instance.new("BodyVelocity")
CherryClub1d4b.Velocity = (CherryClub1a12.Mouse.Hit.Position - CherryClub1d4a.Position).Unit * 100
CherryClub1d4b.MaxForce = Vector3.new(1e6, 1e6, 1e6)
CherryClub1d4b.Parent = CherryClub1d4a
local CherryClub1d4e = Instance.new("BodyAngularVelocity")
CherryClub1d4e.AngularVelocity = Vector3.new(0, 0, 40)
CherryClub1d4e.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
CherryClub1d4e.Parent = CherryClub1d4a
CherryClub1d4c = CherryClub1d4a.Touched:Connect(function(CherryClub1d4f)
if CherryClub1d48 then return end
if CherryClub1a06 and CherryClub1d4f:IsDescendantOf(CherryClub1a06) then return end
if CherryClub1d4f:IsDescendantOf(CherryClub1b63) then return end
CherryClub1d34.Part0 = CherryClub1b64.RootPart
CherryClub1d34.C0 = CFrame.new(0, -10, 0)
CherryClub1d48 = true
CherryClub1a16.NewHitbox(CherryClub1d4a.CFrame, Vector3.new(5, 5, 5), 75199396119752)
local CherryClub1d50 = CherryClub1d4f:FindFirstAncestorOfClass("Model")
CherryClub1d4a.Anchored = true
CherryClub1d4a.Transparency = 1
CherryClub1d4a.CanCollide = false
CherryClub1d4d:Destroy()
task.delay(2, function()
if CherryClub1d4b then CherryClub1d4b:Destroy() end
if CherryClub1d4a then CherryClub1d4a:Destroy() end
if CherryClub1d4c then CherryClub1d4c:Disconnect() end
end)
end)
task.delay(3, function()
if CherryClub1d4a then CherryClub1d4a:Destroy() end
if CherryClub1d4c and CherryClub1d4c.Connected then CherryClub1d4c:Disconnect() end
CherryClub1d34.Part0 = CherryClub1b64.RootPart
CherryClub1d34.C0 = CFrame.new(0, -10, 0)
end)
end
CherryClub1a11.M1 = function()
if not CherryClub1d23 then return end
if CherryClub1a1c.Input.Debounce then return end
CherryClub1a1c.Input.Debounce = true
CherryClub1d23 = false
local CherryClub1d51 = CherryClub1a1b.PlayAction(CherryClub1b63, CherryClub1a15.Animations["Punch"], 0.1)
CherryClub1a13.PlayAttackSFX("rbxassetid://85704827606334")
CherryClub1a16.NewHitbox(CherryClub1b64.RootPart.CFrame * CFrame.new(0, 0, -5), Vector3.new(5, 5, 5), 84923063686841)
CherryClub1d51.Completed:Wait()
CherryClub1a1c.Input.Debounce = false
CherryClub1a1b.RestoreMovement()
task.delay(2, function()
CherryClub1d23 = true
end)
end
CherryClub1a11.WalkspeedOverride = function()
if CherryClub1a1c.Input.Debounce then return end
CherryClub1a1c.Input.Debounce = true
local CherryClub1d52 = false
CherryClub1a14.SetWalkSpeed(4, 0.35)
local CherryClub1d53 = CherryClub1a1b.PlayAnim(CherryClub1b63, CherryClub1a15.Animations["WalkspeedOverrideStart"], 1)
CherryClub1a13.PlayAttackSFX("rbxassetid://89209157768137")
local CherryClub1d54 = CherryClub1a13.PlayAttackSFX("rbxassetid://83124122799450")
CherryClub1d53.Completed:Wait()
local CherryClub1d55 = CherryClub1a1b.PlayAnim(CherryClub1b63, CherryClub1a15.Animations["WalkspeedOverrideLoop"], 1)
local CherryClub1d56 = CherryClub1a14.LaunchPlayer(50, CherryClub1b64.RootPart.CFrame.LookVector, 1.2)
for CherryClub1d57 = 1, 12 do
CherryClub1a16.NewHitbox(CherryClub1b64.RootPart.CFrame * CFrame.new(0, 0, -5), Vector3.new(5, 5, 5), 92188315735827)
if CherryClub1a1c.Input.LandedAttack then
CherryClub1d52 = true
break
end
task.wait(0.1)
end
CherryClub1d56:Destroy()
CherryClub1d55:Stop()
CherryClub1d54:Destroy()
if CherryClub1d52 then
CherryClub1a1c.Input.LandedAttack = false
CherryClub1a14.SetRootPartAnchor(true)
CherryClub1d35.Part0 = CherryClub1b64.RightArm
CherryClub1d35.C0 = CFrame.identity
local CherryClub1d58 = CherryClub1a1b.PlayAnim(CherryClub1b63, CherryClub1a15.Animations["WalkspeedOverrideHit"], 1)
CherryClub1a13.PlayAttackSFX("rbxassetid://119606868919977")
CherryClub1d58.Completed:Wait()
CherryClub1a14.SetRootPartAnchor(false)
CherryClub1d35.Part0 = CherryClub1b64.RootPart
CherryClub1d35.C0 = CFrame.new(0, -10, 0)
else
local CherryClub1d59 = CherryClub1a1b.PlayAnim(CherryClub1b63, CherryClub1a15.Animations["WalkspeedOverrideMiss"], 1)
CherryClub1a13.PlayAttackSFX("rbxassetid://134011935956800")
CherryClub1d59.Completed:Wait()
end
CherryClub1a1c.Input.Debounce = false
CherryClub1a1b.RestoreMovement()
end
CherryClub1a11.CorruptNature = function()
if not CherryClub1d22 then return end
if CherryClub1a1c.Input.Debounce then return end
CherryClub1a1c.Input.Debounce = true
CherryClub1d22 = false
local CherryClub1d5a
CherryClub1a14.SetWalkSpeed(4, 0.35)
local CherryClub1d5b = CherryClub1a1b.PlayAnim(CherryClub1b63, CherryClub1a15.Animations["CorruptNature"], 1)
CherryClub1a13.PlayAttackSFX("rbxassetid://100009343972667")
CherryClub1d5a = CherryClub1d5b.KeyframeReached:Connect(function(CherryClub1d5c)
if CherryClub1d5c == "Throw" then CherryClub1a11.LaunchBullet() end
end)	
CherryClub1d5b.Completed:Wait()
CherryClub1d5a:Disconnect()
CherryClub1a1c.Input.Debounce = false
CherryClub1a1b.RestoreMovement()
task.delay(3.35, function() CherryClub1d22 = true end)
end
CherryClub1a11.KillNPC = function()
if not CherryClub1d21 then return end
if CherryClub1a1c.Input.Debounce then return end
CherryClub1a1c.Input.Debounce = true
CherryClub1a14.SetWalkSpeed(0)
local CherryClub1d5d = CherryClub1a1b.PlayAnim(CherryClub1b63, CherryClub1a15.Animations["Punch"], 1)
CherryClub1a13.PlayAttackSFX("rbxassetid://73042063796962")
CherryClub1a16.NewHitbox(CherryClub1b64.RootPart.CFrame * CFrame.new(0, 0, -5), Vector3.new(5, 5, 5), 136918668747110)
if CherryClub1a1c.Input.LandedAttack and CherryClub1d21 then
CherryClub1d5d:Stop()
local CherryClub1d5e
CherryClub1d21 = false
CherryClub1a14.SetRootPartAnchor(true)
CherryClub1a13.PlayAttackSFX("rbxassetid://73722439391703")
CherryClub1a06 = CherryClub1a15.Objects.Dummy:Clone()
for CherryClub1d5f, CherryClub1d60 in CherryClub1a06:GetDescendants() do
if CherryClub1d60:IsA("BasePart") then CherryClub1d60.Transparency = 1 CherryClub1d60.Massless = true end
end
CherryClub1a06:ScaleTo(CherryClub1b63:GetScale())
for CherryClub1d61, CherryClub1d62 in CherryClub1d36 do
CherryClub1d62.Part0 = CherryClub1a06[CherryClub1d61]
CherryClub1d62.C0 = CFrame.identity
end
local CherryClub1d63 = CherryClub1a07.RunService.Heartbeat:Connect(function() CherryClub1a06.HumanoidRootPart.CFrame = CherryClub1b64.RootPart.CFrame end)
CherryClub1a06.Parent = workspace
CherryClub1a1b.RegisterRigJoints(CherryClub1a06)
local CherryClub1d64 = CherryClub1a1b.PlayAnim(CherryClub1b63, CherryClub1a15.Animations["Kill"], 1)
CherryClub1d5e = CherryClub1d64.KeyframeReached:Connect(function(CherryClub1d65)
if CherryClub1d65 == "Throw" then
for CherryClub1d66, CherryClub1d67 in CherryClub1a06:GetDescendants() do
if CherryClub1d67:IsA("BasePart") then
CherryClub1d67.CanCollide = false
end
end
CherryClub1d63:Disconnect()
CherryClub1a06.HumanoidRootPart.Velocity = CherryClub1b64.RootPart.CFrame.RightVector * 100
CherryClub1a06.Humanoid:ChangeState(Enum.HumanoidStateType.Physics)
CherryClub1a06.HumanoidRootPart.Anchored = false
CherryClub1d37(CherryClub1a06)
CherryClub1d40(CherryClub1a06, 2)
end
end)
local CherryClub1d68 = CherryClub1a1b.PlayAnim(CherryClub1a06, CherryClub1a15.Animations["KillVictim"], 1)
CherryClub1d64.Completed:Wait()
CherryClub1d5e:Disconnect()
CherryClub1a14.SetRootPartAnchor(false)
CherryClub1a1b.UnregisterRigJoints(CherryClub1a06)
CherryClub1a1c.Input.LandedAttack = false
CherryClub1a1c.Input.Debounce = false
CherryClub1a1b.RestoreMovement()
task.delay(4, function()
for CherryClub1d69, CherryClub1d6a in CherryClub1d36 do
CherryClub1d6a.Part0 = CherryClub1b64.RootPart
CherryClub1d6a.C0 = CFrame.new(0, -10, 0)
end
CherryClub1a06:Destroy()
CherryClub1d21 = true
end)
return
end
task.wait()
if CherryClub1d5d.IsPlaying then CherryClub1d5d.Completed:Wait() end
CherryClub1a1c.Input.Debounce = false
CherryClub1a1b.RestoreMovement()
end

-- connections
local CherryClub1d6b = {
KeyDown = CherryClub1a07.UserInputService.InputBegan:Connect(function(CherryClub1d6c, CherryClub1d6d)
if CherryClub1d6d then return end
if not CherryClub1a05 then return end
if CherryClub1d6c.UserInputType == Enum.UserInputType.MouseButton1 then CherryClub1a11.M1() end
if CherryClub1d6c.KeyCode == Enum.KeyCode.Q then CherryClub1a11.CorruptNature() end
if CherryClub1d6c.KeyCode == Enum.KeyCode.E then CherryClub1a11.WalkspeedOverride() end
if CherryClub1d6c.KeyCode == Enum.KeyCode.R then CherryClub1a11.KillNPC() end
if CherryClub1d6c.KeyCode == Enum.KeyCode.LeftShift or CherryClub1d6c.KeyCode == Enum.KeyCode.RightShift then if CherryClub1a1c.Input.Debounce then return end CherryClub1a1c.Input.Shift = true end;
if CherryClub1d6c.KeyCode == Enum.KeyCode.F5 then
CherryClub1a14.SendNotification("Loaded " .. CherryClub1a1d.EmoteCount .. " emotes.")
CherryClub1a14.SendNotification("Script took " .. CherryClub1a02 .. " seconds to load.")
end
end);
KeyUp = CherryClub1a07.UserInputService.InputEnded:Connect(function(CherryClub1d6e)
if CherryClub1d6e.KeyCode == Enum.KeyCode.LeftShift or CherryClub1d6e.KeyCode == Enum.KeyCode.RightShift then CherryClub1a1c.Input.Shift = false end
end);
} 
table.insert(CherryClub1a1d.ActiveConnections, CherryClub1d6b.KeyDown)
table.insert(CherryClub1a1d.ActiveConnections, CherryClub1d6b.KeyUp)
local CherryClub1d6f = CherryClub1a1b.GetAnim(CherryClub1b63, CherryClub1a15.Animations.Walk)
local CherryClub1d70 = CherryClub1a1b.GetAnim(CherryClub1b63, CherryClub1a15.Animations.Sprint)
CherryClub1d6f.KeyframeReached:Connect(function(CherryClub1d71)
if CherryClub1d71 == "Footstep" then CherryClub1a13.PlayAttackSFX("rbxassetid://73871404556766") end
end)
CherryClub1d70.KeyframeReached:Connect(function(CherryClub1d72)
if CherryClub1d72 == "Footstep" then CherryClub1a13.PlayAttackSFX("rbxassetid://92103616531947") end
end)
local CherryClub1d73 = CherryClub1a07.RunService.Heartbeat:Connect(function(CherryClub1d74)
local CherryClub1d75 = CherryClub1b64.RootPart.Position
local CherryClub1d76 = Vector3.new(0, -1, 0) * (4 * CherryClub1b63:GetScale())
local CherryClub1d77 = RaycastParams.new()
CherryClub1d77.FilterDescendantsInstances = {CherryClub1b63}
CherryClub1d77.FilterType = Enum.RaycastFilterType.Exclude
CherryClub1d77.IgnoreWater = true
local CherryClub1d78 = workspace:Raycast(CherryClub1d75, CherryClub1d76, CherryClub1d77)
local CherryClub1d79 = CherryClub1d78 and CherryClub1d78.Instance
local CherryClub1d7a = (CherryClub1b64.RootPart.Velocity).Magnitude
local CherryClub1d7b = CherryClub1b64.RootPart.AssemblyLinearVelocity.Y
if CherryClub1a1e.Options.HeadFollowsMouse then
local CherryClub1d7c = (CherryClub1a12.Mouse.Hit.Position - CherryClub1b64.Head.Position).Unit
CherryClub1a12.Neck.Transform = CherryClub1a12.Neck.Transform:Lerp(CFrame.Angles(math.atan((CherryClub1b64.Head.Position - CherryClub1a12.Mouse.Hit.Position).Unit.Y), 0, (CherryClub1b64.Head.Position - CherryClub1a12.Mouse.Hit.Position).Unit:Cross(CherryClub1b64.Torso.CFrame.LookVector).Y), math.clamp(8 * CherryClub1d74, 0, 1))
end
if CherryClub1a1e.Options.MusicEnabled then
CherryClub1b66.Volume = 0.25
CherryClub1b66.PlaybackSpeed = math.lerp(CherryClub1b66.PlaybackSpeed, CherryClub1a1e.Options.AnimationSpeed, 0.1)
CherryClub1a19.Tabs.MusicMenu.Timestamp.Text = os.date("!%M:%S", CherryClub1b66.TimePosition) .. " - " .. os.date("!%M:%S", CherryClub1b66.TimeLength)
CherryClub1a19.Tabs.MusicMenu.ProgressBar.Progress.Size = UDim2.fromScale(CherryClub1b66.TimePosition / CherryClub1b66.TimeLength, 1)
else
CherryClub1b66.Volume = 0
CherryClub1a19.Tabs.MusicMenu.ProgressBar.Progress.Size = UDim2.fromScale(0, 1)
end
if CherryClub1a1e.Options.InfiniteJump and CherryClub1b64.Humanoid and CherryClub1b64.Humanoid.Jump then
if CherryClub1b64.Humanoid.RootPart then
CherryClub1b64.Humanoid.RootPart.AssemblyLinearVelocity = Vector3.new(CherryClub1b64.Humanoid.RootPart.AssemblyLinearVelocity.X, 45, CherryClub1b64.Humanoid.RootPart.AssemblyLinearVelocity.Z)
end
end
if CherryClub1a1e.Options.CameraEffects then
CherryClub1b64.Humanoid.CameraOffset = CherryClub1b64.Humanoid.CameraOffset:Lerp((CherryClub1b64.RootPart.CFrame * CFrame.new(0, 1.5, 0)):PointToObjectSpace(CherryClub1b64.Head.Position), math.clamp(CherryClub1d74 * 10, 0, 1))
else
CherryClub1b64.Humanoid.CameraOffset = CherryClub1b64.Humanoid.CameraOffset:Lerp(Vector3.zero, math.clamp(CherryClub1d74 * 10, 0, 1))
end
if not CherryClub1a1c.Input.Debounce then
if CherryClub1a1c.Input.Shift then
CherryClub1a14.SetWalkSpeed(CherryClub1a1e.Options.SprintSpeed * CherryClub1b63:GetScale())
else
CherryClub1a14.SetWalkSpeed(CherryClub1a1e.Options.WalkSpeed * CherryClub1b63:GetScale())
end
end
if CherryClub1d7a < 0.001 and CherryClub1d79 ~= nil and not CherryClub1a1c.Input.Debounce then
if CherryClub1a1c.Movement.Idle == false  then
CherryClub1a1c.Movement.Idle = true
CherryClub1a1b.PlayAnim(CherryClub1b63,CherryClub1a15.Animations.Idle, 1)
end
CherryClub1a1c.Movement.Walking = false
CherryClub1a1c.Movement.Running = false
CherryClub1a1b.StopAnim(CherryClub1b63,CherryClub1a15.Animations.Sprint)
CherryClub1a1b.StopAnim(CherryClub1b63,CherryClub1a15.Animations.Walk)
elseif CherryClub1d7a > 1 and CherryClub1d79 ~= nil and not CherryClub1a1c.Input.Debounce and CherryClub1a1c.Input.Shift then
if CherryClub1a1c.Movement.Running == false then
CherryClub1a1c.Movement.Running = true
CherryClub1a1b.PlayAnim(CherryClub1b63,CherryClub1a15.Animations.Sprint, 1)
end
CherryClub1a1c.Movement.Idle = false
CherryClub1a1c.Movement.Walking = false
CherryClub1a1b.StopAnim(CherryClub1b63,CherryClub1a15.Animations.Walk)
CherryClub1a1b.StopAnim(CherryClub1b63,CherryClub1a15.Animations.Idle)
elseif CherryClub1d7a > 1 and CherryClub1d79 ~= nil and not CherryClub1a1c.Input.Debounce then
if CherryClub1a1c.Movement.Walking == false then
CherryClub1a1c.Movement.Walking = true
CherryClub1a1b.PlayAnim(CherryClub1b63,CherryClub1a15.Animations.Walk, 1)
end
CherryClub1a1c.Movement.Idle = false
CherryClub1a1c.Movement.Running = false
CherryClub1a1b.StopAnim(CherryClub1b63,CherryClub1a15.Animations.Sprint)
CherryClub1a1b.StopAnim(CherryClub1b63,CherryClub1a15.Animations.Idle)
end
CherryClub1a19.Tabs.MusicMenu.TitleLabel.Text = CherryClub1b66.Name
end)
table.insert(CherryClub1a1d.ActiveConnections, CherryClub1d73)
CherryClub1cb6.AbilitiesUI.Q.MouseButton1Down:Connect(function()
CherryClub1a11.CorruptNature()
end)
CherryClub1cb6.AbilitiesUI.E.MouseButton1Down:Connect(function()
CherryClub1a11.WalkspeedOverride()
end)
CherryClub1cb6.AbilitiesUI.R.MouseButton1Down:Connect(function()
CherryClub1a11.KillNPC()
end)
CherryClub1cb6.AbilitiesUI.M1.MouseButton1Down:Connect(function()
CherryClub1a11.M1()
end)
CherryClub1cb6.AbilitiesUI.SHIFT.MouseButton1Down:Connect(function()
CherryClub1a1c.Input.Shift = not CherryClub1a1c.Input.Shift 
end)

if not CherryClub1a1d.IsStudio then
CherryClub1a03.BindableEvent.Event:Once(function()
print("resetting")
for CherryClub1d7d, CherryClub1d7e in CherryClub1a1d.ActiveConnections do
if typeof(CherryClub1d7e) == "RBXScriptConnection" then
CherryClub1d7e:Disconnect()
end
end
table.clear(CherryClub1a1d.ActiveConnections)
task.wait()
for CherryClub1d7f, CherryClub1d80 in CherryClub1a1d.TrashBin do
pcall(function()
CherryClub1d80:Destroy()
end)
end
end)
end

-- lyrics stuff
if not CherryClub1a1d.IsStudio then
local CherryClub1d81 = {}
CherryClub1d81.CaptionLabels = {}
CherryClub1d81.ScrambleCharacters = {"#", "@", "%", "&", "?", "!", "$", "*", "+", "="}
CherryClub1d81.ScrambleCharacter = function() return CherryClub1d81.ScrambleCharacters[math.random(1, #CherryClub1d81.ScrambleCharacters)] end
CherryClub1d81.ActiveId = 0
CherryClub1d81.CharsOf = function(CherryClub1d82)
local CherryClub1d83 = {}
for CherryClub1d84, CherryClub1d85 in utf8.codes(CherryClub1d82) do table.insert(CherryClub1d83, utf8.char(CherryClub1d85)) end return CherryClub1d83 end
CherryClub1d81.NewCaption = function(CherryClub1d86, CherryClub1d87, CherryClub1d88, CherryClub1d89)
CherryClub1d81.ActiveId += 1
local CherryClub1d8a = CherryClub1d81.ActiveId
CherryClub1d87 = CherryClub1d87 or 2
local CherryClub1d8b = CherryClub1b64.Head
local CherryClub1d8c = CherryClub1d8b:FindFirstChild("CaptionGui")
if CherryClub1d8c then CherryClub1d8c:Destroy() end
if not CherryClub1d86 or CherryClub1d86 == "" then return end
local CherryClub1d8d = CherryClub1d81.CharsOf(CherryClub1d86)
local CherryClub1d8e = {[" "] = true, ["\t"] = true, ["-"] = true, ["—"] = true, ["–"] = true}
local CherryClub1d8f, CherryClub1d90, CherryClub1d91 = {}, {}, 0
local CherryClub1d92, CherryClub1d93, CherryClub1d94 = "", 0, false
local CherryClub1d95 = function() -- just like skibidi
if CherryClub1d93 > 0 then
table.insert(CherryClub1d8f, CherryClub1d92)
table.insert(CherryClub1d90, CherryClub1d93 + 1)
CherryClub1d91 += CherryClub1d93 + 1
CherryClub1d92, CherryClub1d93, CherryClub1d94 = "", 0, false
end
end
for CherryClub1d96, CherryClub1d97 in ipairs(CherryClub1d8d) do
if CherryClub1d8e[CherryClub1d97] then
CherryClub1d94 = true
else
if CherryClub1d94 then CherryClub1d95() end
CherryClub1d93 += 1
end
CherryClub1d92..= CherryClub1d97 -- LOL
end
CherryClub1d95()
if #CherryClub1d8f == 0 then return end
local CherryClub1d98 = CherryClub1d87 * 0.85
local CherryClub1d99, CherryClub1d9a = {}, 0
for CherryClub1d9b, CherryClub1d9c in ipairs(CherryClub1d90) do CherryClub1d99[CherryClub1d9b] = (CherryClub1d9a / CherryClub1d91) * CherryClub1d98 CherryClub1d9a += CherryClub1d9c end
local function CherryClub1d9d(CherryClub1d9e) return (CherryClub1d9e:gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;")) end
local CherryClub1d9f = Instance.new("BillboardGui")
CherryClub1d9f.Name = "CaptionGui"
CherryClub1d9f.Adornee = CherryClub1d8b
CherryClub1d9f.Size = UDim2.fromScale(8, 2)
CherryClub1d9f.StudsOffset = Vector3.new(0, 5, 0)
CherryClub1d9f.AlwaysOnTop = true
CherryClub1d9f.LightInfluence = 0
CherryClub1d9f.MaxDistance = math.huge
CherryClub1d9f.Parent = CherryClub1d8b
local CherryClub1da0 = Instance.new("Frame")
CherryClub1da0.Size = UDim2.fromScale(1, 1)
CherryClub1da0.BackgroundTransparency = 1
CherryClub1da0.Parent = CherryClub1d9f
CherryClub1da0.BackgroundColor3 = Color3.new(1, 1, 1)
local CherryClub1da1 = Instance.new("TextLabel")
CherryClub1da1.Size = UDim2.fromScale(1, 1)
CherryClub1da1.BackgroundTransparency = 1
CherryClub1da1.TextScaled = true
CherryClub1da1.TextWrapped = true
CherryClub1da1.RichText = true
CherryClub1da1.Font = Enum.Font.Code
CherryClub1da1.TextColor3 = Color3.new(1, 1, 1)
CherryClub1da1.Text = ""
CherryClub1da1.Parent = CherryClub1da0
local CherryClub1da2 = Instance.new("UIStroke")
CherryClub1da2.Thickness = 2
CherryClub1da2.Color = Color3.new(0, 0, 0)
CherryClub1da2.Parent = CherryClub1da1		local CherryClub1da3 = os.clock()
local CherryClub1da4 = function()
if CherryClub1d89 and CherryClub1d89.Parent and CherryClub1d88 then return CherryClub1d89.TimePosition - CherryClub1d88 end
return os.clock() - CherryClub1da3
end
local CherryClub1da5 = function(CherryClub1da6)
local CherryClub1da7 = table.create(#CherryClub1d8f)
for CherryClub1da8, CherryClub1da9 in ipairs(CherryClub1d8f) do
local CherryClub1daa = CherryClub1d9d(CherryClub1da9)
if CherryClub1da8 <= CherryClub1da6 then CherryClub1da7[CherryClub1da8] = CherryClub1daa else CherryClub1da7[CherryClub1da8] = '<font transparency="1">'..CherryClub1daa.."</font>" end
end
CherryClub1da1.Text = table.concat(CherryClub1da7)
end
CherryClub1da5(0)
local CherryClub1dab = -1
while true do
if CherryClub1d8a ~= CherryClub1d81.ActiveId or not CherryClub1d9f.Parent then return end
local CherryClub1dac = CherryClub1da4()
if CherryClub1dac >= CherryClub1d87 then break end
local CherryClub1dad = 0
for CherryClub1dae, CherryClub1daf in ipairs(CherryClub1d99) do if CherryClub1dac >= CherryClub1daf then CherryClub1dad = CherryClub1dae else break end end
if CherryClub1dad ~= CherryClub1dab then CherryClub1dab = CherryClub1dad CherryClub1da5(CherryClub1dad) end
CherryClub1a07.RunService.RenderStepped:Wait()
end
CherryClub1da5(#CherryClub1d8f)
if CherryClub1d8a ~= CherryClub1d81.ActiveId or not CherryClub1d9f.Parent then return end
CherryClub1da1.RichText = false
CherryClub1da1.Text = table.concat(CherryClub1d8d)
local CherryClub1db0, CherryClub1db1 = 0, 0.6
local CherryClub1db2
CherryClub1db2 = CherryClub1a07.RunService.RenderStepped:Connect(function(CherryClub1db3)
if CherryClub1d8a ~= CherryClub1d81.ActiveId or not CherryClub1d9f.Parent then CherryClub1db2:Disconnect() return end
CherryClub1db0 += CherryClub1db3
local CherryClub1db4 = math.clamp(CherryClub1db0 / CherryClub1db1, 0, 1)
local CherryClub1db5 = table.create(#CherryClub1d8d)
for CherryClub1db6, CherryClub1db7 in ipairs(CherryClub1d8d) do
if not CherryClub1d8e[CherryClub1db7] and CherryClub1db4 > (CherryClub1db6 / #CherryClub1d8d) * 0.7 then
CherryClub1db5[CherryClub1db6] = CherryClub1d81.ScrambleCharacter()
else
CherryClub1db5[CherryClub1db6] = CherryClub1db7
end
end
CherryClub1da1.Text = table.concat(CherryClub1db5)
local CherryClub1db8 = math.floor(4 * CherryClub1db4)
CherryClub1da1.Position = UDim2.fromOffset(math.random(-CherryClub1db8, CherryClub1db8), math.random(-CherryClub1db8, CherryClub1db8))
CherryClub1da1.TextTransparency = CherryClub1db4 ^ 2
CherryClub1da2.Transparency = CherryClub1db4 ^ 2
if CherryClub1db4 >= 1 then
CherryClub1db2:Disconnect()
CherryClub1d9f:Destroy()
end
end)
end
CherryClub1a1a.CurrentLyrics = {}
CherryClub1a1a.Decode = function(CherryClub1db9) local CherryClub1dba = {} for CherryClub1dbb in CherryClub1db9:gmatch("%d+") do table.insert(CherryClub1dba, string.char(tonumber(CherryClub1dbb))) end return table.concat(CherryClub1dba) end
CherryClub1a1a.Cache = {}
CherryClub1a1a.CurrentIndex = 0
CherryClub1a1a.Swears = {"110/105/103/103", "102/117/99/107", "115/104/105/116", "98/105/116/99/104", "115/117/105/99/105/100"}
CherryClub1a1a.ExactSwears = {"100/105/99/107", "100/105/99/107/115", "104/111/101", "104/111/101/115", "97/115/115", "97/115/115/101/115", "114/97/112/101", "114/97/112/101/100", "114/97/112/105/110/103", "114/97/112/105/115/116", "114/97/112/105/115/116/115", "102/97/103", "102/97/103/115", "99/111/99/107", "99/111/99/107/115", "98/108/117/110/116", "119/101/101/100", "119/101/101/100/115", "98/108/117/110/116/115"}
CherryClub1a1a.ExactCache = {}
for CherryClub1dbc, CherryClub1dbd in ipairs(CherryClub1a1a.Swears) do CherryClub1a1a.Swears[CherryClub1dbc] = CherryClub1a1a.Decode(CherryClub1dbd) end
for CherryClub1dbe, CherryClub1dbf in ipairs(CherryClub1a1a.ExactSwears) do CherryClub1a1a.ExactCache[CherryClub1a1a.Decode(CherryClub1dbf)] = true end
CherryClub1a1a.CensorText = function(CherryClub1dc0) return (CherryClub1dc0:gsub("[%a']+", function(CherryClub1dc1) local CherryClub1dc2 = CherryClub1dc1:lower() if CherryClub1a1a.ExactCache[CherryClub1dc2] then return string.rep("#", #CherryClub1dc1) end for CherryClub1dc3, CherryClub1dc4 in ipairs(CherryClub1a1a.Swears) do if CherryClub1dc2:find(CherryClub1dc4, 1, true) then return string.rep("#", #CherryClub1dc1) end end end)) end
CherryClub1a1a.GetText = function(CherryClub1dc5) return CherryClub1a1e.Options.CensorLyrics and CherryClub1a1a.CensorText(CherryClub1dc5.Text) or CherryClub1dc5.Text end
CherryClub1a1a.ParseLRC = function(CherryClub1dc6)
CherryClub1a1a.Lyrics = {}
for CherryClub1dc7 in CherryClub1dc6:gmatch("[^\r\n]+") do
local CherryClub1dc8, CherryClub1dc9, CherryClub1dca = CherryClub1dc7:match("%[(%d+):([%d%.]+)%]%s*(.*)")
if CherryClub1dc8 and CherryClub1dc9 then table.insert(CherryClub1a1a.Lyrics, {Time = tonumber(CherryClub1dc8) * 60 + tonumber(CherryClub1dc9), Text = CherryClub1dca}) end
end
table.sort(CherryClub1a1a.Lyrics, function(CherryClub1dcb, CherryClub1dcc) return CherryClub1dcb.Time < CherryClub1dcc.Time end)
return CherryClub1a1a.Lyrics
end
CherryClub1a1a.ClearLyrics = function(CherryClub1dcd) CherryClub1d81.NewCaption("") CherryClub1a1a.CurrentLyrics = {} CherryClub1a1a.CurrentIndex = -1 CherryClub1a19.Tabs.MusicMenu.LyricsLabel.Text = CherryClub1dcd or "" end
CherryClub1a1a.UpdateSong = function(CherryClub1dce)
CherryClub1d81.NewCaption("")
local CherryClub1dcf = CherryClub1a1a.Cache[CherryClub1dce]
if CherryClub1dcf then
CherryClub1a1a.CurrentLyrics = CherryClub1dcf
CherryClub1a1a.CurrentIndex = -1
CherryClub1a19.Tabs.MusicMenu.LyricsLabel.Text = ""
return
end
local CherryClub1dd0 = CherryClub1a1e.Directories.Lyrics .. CherryClub1dce .. ".lrc"
local CherryClub1dd1, CherryClub1dd2 = pcall(CherryClub1a09, CherryClub1dd0)
if not CherryClub1dd1 then
CherryClub1dd0 = CherryClub1a1e.Directories.Lyrics .. CherryClub1dce .. ".txt"
CherryClub1dd1, CherryClub1dd2 = pcall(CherryClub1a09, CherryClub1dd0)
end
if not CherryClub1dd1 then
CherryClub1a1a.ClearLyrics("No lyrics found / error with readfile / this is an instrumental.")
return
end
local CherryClub1dd3 = CherryClub1a1a.ParseLRC(CherryClub1dd2)
CherryClub1a1a.Cache[CherryClub1dce] = CherryClub1dd3
CherryClub1a1a.CurrentLyrics = CherryClub1dd3
CherryClub1a1a.CurrentIndex = -1
end
CherryClub1a1a.ReturnLyricIndex = function(CherryClub1dd4) local CherryClub1dd5 = 0 for CherryClub1dd6, CherryClub1dd7 in ipairs(CherryClub1a1a.CurrentLyrics) do if CherryClub1dd4 >= CherryClub1dd7.Time then CherryClub1dd5 = CherryClub1dd6 else break end end return CherryClub1dd5 end
local CherryClub1dd8 = CherryClub1a1e.Options.CensorLyrics
local CherryClub1dd9 = CherryClub1a07.RunService.Heartbeat:Connect(function()
if not CherryClub1a1e.Options.LyricsEnabled then CherryClub1a19.Tabs.MusicMenu.LyricsLabel.Text = "Lyrics disabled." return end
if #CherryClub1a1a.CurrentLyrics == 0 then return end
if CherryClub1dd8 ~= CherryClub1a1e.Options.CensorLyrics then CherryClub1dd8 = CherryClub1a1e.Options.CensorLyrics CherryClub1a1a.CurrentIndex = -1 end
local CherryClub1dda = CherryClub1a1a.ReturnLyricIndex(CherryClub1b66.TimePosition)
if CherryClub1dda ~= CherryClub1a1a.CurrentIndex then
CherryClub1a1a.CurrentIndex = CherryClub1dda
CherryClub1a19.Tabs.MusicMenu.LyricsLabel.Text = CherryClub1dda > 0 and CherryClub1a1a.GetText(CherryClub1a1a.CurrentLyrics[CherryClub1dda]) or ""
if CherryClub1a1e.Options.LyricsAboveHead and CherryClub1dda > 0 then CherryClub1d81.NewCaption(CherryClub1a19.Tabs.MusicMenu.LyricsLabel.Text, math.min(((CherryClub1a1a.CurrentLyrics[CherryClub1dda + 1] or {Time = CherryClub1a1a.CurrentLyrics[CherryClub1dda].Time + 3}).Time - CherryClub1a1a.CurrentLyrics[CherryClub1dda].Time) * 0.9, 6), CherryClub1a1a.CurrentLyrics[CherryClub1dda].Time, CherryClub1b66) end
if CherryClub1a1e.Options.LyricsAboveHead and CherryClub1dda == 0 then CherryClub1d81.NewCaption("") end
end
end)
table.insert(CherryClub1a1d.ActiveConnections, CherryClub1dd9)
end

-- directional thing (found this in my old game idk if i made it ngl)
local CherryClub1ddb = {}
local CherryClub1ddc = {}
local CherryClub1ddd = {
RootJoint = CherryClub1b64.RootPart:WaitForChild("RootJoint"),
Neck = CherryClub1b64.Torso:WaitForChild("Neck"),
RightShoulder = CherryClub1b64.Torso:WaitForChild("Right Shoulder"),
LeftShoulder = CherryClub1b64.Torso:WaitForChild("Left Shoulder"),
RightHip = CherryClub1b64.Torso:WaitForChild("Right Hip"),
LeftHip = CherryClub1b64.Torso:WaitForChild("Left Hip"),
}
for CherryClub1dde, CherryClub1ddf in pairs(CherryClub1ddd) do CherryClub1ddb[CherryClub1dde] = CherryClub1ddf.C0 CherryClub1ddc[CherryClub1dde] = CFrame.new() end
local CherryClub1de0 = CherryClub1a07.RunService.RenderStepped:Connect(function(CherryClub1de1)
local CherryClub1de2 = CherryClub1b64.Humanoid
local CherryClub1de3 = CherryClub1b64.RootPart.CFrame:VectorToObjectSpace(CherryClub1de2.MoveDirection)
local CherryClub1de4 = CherryClub1de2.FloorMaterial == Enum.Material.Air and 0.4 or 1
local CherryClub1de5 = CherryClub1de3.X * CherryClub1de4
local CherryClub1de6 = CherryClub1de3.Z * CherryClub1de4
local CherryClub1de7 = {
RootJoint = CFrame.Angles(CherryClub1a10(-CherryClub1de6 * 10), 0, CherryClub1a10(-CherryClub1de5 * 35)),
Neck = CFrame.Angles(CherryClub1a10(CherryClub1de6 * 8), 0, CherryClub1a10(CherryClub1de5 * 20)),
RightShoulder = CFrame.Angles(0, CherryClub1a10(-CherryClub1de5 * 15), 0),
LeftShoulder = CFrame.Angles(0, CherryClub1a10(-CherryClub1de5 * 15), 0),
RightHip = CFrame.Angles(0, CherryClub1a10(-CherryClub1de5 * 15), 0),
LeftHip = CFrame.Angles(0, CherryClub1a10(-CherryClub1de5 * 15), 0),
}
local CherryClub1de8 = 1 - math.exp(-CherryClub1de1 * 14)
for CherryClub1de9, CherryClub1dea in pairs(CherryClub1de7) do CherryClub1ddc[CherryClub1de9] = CherryClub1ddc[CherryClub1de9]:Lerp(CherryClub1dea, CherryClub1de8) local CherryClub1deb = CherryClub1ddb[CherryClub1de9] CherryClub1ddd[CherryClub1de9].C0 = (CherryClub1deb - CherryClub1deb.Position + CherryClub1deb.Position * CherryClub1b63:GetScale()) * CherryClub1ddc[CherryClub1de9] end
end)
table.insert(CherryClub1a1d.ActiveConnections, CherryClub1de0)

--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
-- made with love, for whoever ends up here have a good day and live restfully
-- to you from melon and theguardian, on behalf of cherry club
--||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

CherryClub1a05 = true
local CherryClub1dec = os.clock()
CherryClub1a02 = CherryClub1dec - CherryClub1b61
CherryClub1a02 = math.floor(CherryClub1a02 * 10 + 0.5) / 10
print("it took around:", CherryClub1a02 .. " seconds to run the script, while loading ".. CherryClub1a1d.EmoteCount.." emotes")
CherryClub1a14.SendNotification("notes: emotes requires RBXM / .anim in Emotes folder, does not come with any pre-built")
pcall(function()
local CherryClub1ded = loadstring(game:HttpGet("https://github.com/MelonsStuff/FEVerse/raw/refs/heads/main/Miscellaneous/BannerModule.luau"))()
CherryClub1ded("C 0 0 L K I D D", "join team c00lkidd today!!", 1)
end)
