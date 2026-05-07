-- [[ Minos Prime : Reanimate ]] --

--[[
  Credits:
  // Melon - Created this script
  // Emper - Created the reanimation used
  // ZerX - Movement scripting (last part only, i edited it a bit + he migtve made the module, i edited it a bit too)
  // Hakita - Created the assets used to make this script.

  Note: if there's bugs pls let me know so i can fix them
  the code may be unoptimized at some parts and uses a lot of if statements

  Free rig:
  // Torso: https://www.roblox.com/catalog/4819740796/Robox
  // Upper Left Arm: https://www.roblox.com/catalog/4381707497/International-Fedora-Turkey
  // Lower Left Arm: https://www.roblox.com/catalog/6909084751/Artist-Backpack
  // Upper Left Leg: https://www.roblox.com/catalog/3409612660/International-Fedora-USA
  // Lower Left Leg: https://www.roblox.com/catalog/5552252553/Kinetic-Staff
  // Upper Right Arm: https://www.roblox.com/catalog/4645404679/International-Fedora-Thailand
  // Lower Right Arm: https://www.roblox.com/catalog/5354918926/Build-It-Backpack
  // Upper Right Leg: https://www.roblox.com/catalog/3033910400/International-Fedora-Germany
  // Lower Right Leg: https://www.roblox.com/catalog/15254947445/24k-Gold-Plunger

  Paid hats are found in this game:
  // https://www.roblox.com/games/15541318313/Melons-Baseplate
]] 

-- tables
local Settings = {
	AnimationSpeed = 1.25; -- unfortunately i didnt feel like adding this so it doesnt do anything for now
	Fling = true;
	Music = true;
	FOVEffects = true;
	CameraEffects = true;
	InfiniteJump = false;
}

local Reanimate_Settings = {
	Frequency = 6, -- this is basically how fast the oscillation goes
	Amplification = 6, -- this is how far the oscillation goes
	FrontOffset = 2.5, -- this is how much youre in front of the player during prediction
}

local Directories = {
	Main = "FEVerse/",
	RBXMs ="FEVerse/RBXMs/",
	Sounds = "FEVerse/Sounds/",
	Songs = "FEVerse/Songs/",
}

local ScriptSettings = {
	HitboxColor = Color3.fromRGB(255, 255, 255),
	Hitmarker = 103397225855135,
}
local AnimatorModule = {}
local Joints = {}
local AnimDefaults = {}
local TrashBin = {}
local ActiveConnections = {}
local HitHumanoids = {}

local FEManager = loadstring(game:HttpGet("https://gist.githubusercontent.com/MelonsStuff/a003ea305dd302eab1f8d372daed38b4/raw/9db59962b28555fd699a7c29891efb85d45677ab/gistfile1.txt"))()
for i, v in pairs(Directories) do FEManager.EnsureFolder(v) end
task.spawn(function()
	StarterGui = cloneref(game:GetService("StarterGui"))
	StarterGui:SetCore("SendNotification",{
		Title = "Cherry's Club",
		Text = "Files are currently downloading, you may need to run the script again after files download. (ignore this if you already have them)",
		Duration = 5,
	})
	FEManager.DownloadFile(Directories.RBXMs, "MinosPrime.rbxm", "https://github.com/MelonsStuff/FEVerse/raw/refs/heads/main/RBXMs/MinosPrime.rbxm")
	StarterGui:SetCore("SendNotification",{
		Title = "Cherry's Club",
		Text = "RBXMs Downloaded.",
		Duration = 2,
	})
	FEManager.DownloadFile(Directories.Songs, "MinosTheme.skibidi", "https://raw.githubusercontent.com/MelonsStuff/FEVerse/refs/heads/main/Songs/MinosTheme.skibidi")
	FEManager.DownloadFile(Directories.Sounds, "MinosIntro.skibidi", "https://raw.githubusercontent.com/MelonsStuff/FEVerse/refs/heads/main/Sounds/MinosIntro.skibidi")
	StarterGui:SetCore("SendNotification",{
		Title = "Cherry's Club",
		Text = "Download complete.",
		Duration = 2,
	})
end)

-- booleans + values
local Lines = 0
local ComboCount, MaxCombo, ComboResetTime = 0, 4, 0.8
local Idle, Walking = false, false
local Debounce = false
local ComboResetTimer

-- services
local InsertService = cloneref(game:GetService("InsertService"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local TweenService = cloneref(game:GetService("TweenService"))
local Debris = cloneref(game:GetService("Debris"))
local Players = cloneref(game:GetService("Players"))
local CoreGui = cloneref(game:GetService("CoreGui"))

local script = InsertService:LoadLocalAsset(getcustomasset(Directories.RBXMs.."MinosPrime.rbxm"))
local Objects = script:WaitForChild("Objects")
local Animations = script:WaitForChild("Animations")

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
			taskwait(OptionsBreakJointsDelay)

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

			Rig = Objects:FindFirstChild("StarterCharacter"):Clone()
			Rig.Name = "non"
			RigHumanoid = Rig.Humanoid
			-- RigHumanoid.HipHeight = 2.85
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
		-- Alternative Free
		{ Name = "RigLowerRA", MeshId = "686793422",  TextureId = "6900595602", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, Rad(-175), Rad(175)) },
		{ Name = "RigLowerLA", MeshId = "686793422",  TextureId = "5354879750", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(Rad(0), Rad(-175), Rad(175)) },
		{ Name = "RigLowerRL", MeshId = "5548423017",  TextureId = "5548423938", Offset = CFrame.new(0, 0, -1) * CFrame.Angles(Rad(-15), Rad(90), Rad(45)) },
		{ Name = "RigLowerLL", MeshId = "15172160708",  TextureId = "15172162617", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(Rad(-15), Rad(0), Rad(-125)) },
		-- Free Rig
		{ Name = "RigTorso", MeshId = "4819720316",  TextureId = "4819722776", Offset = CFrame.Angles(0, Rad(90), Rad(-15)) },
		{ Name = "RigLowerRA", MeshId = "319354652",  TextureId = "304117018", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, Rad(-175), Rad(175)) },
		{ Name = "RigLowerLA", MeshId = "319354652",  TextureId = "376186990", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(Rad(0), Rad(-175), Rad(175)) },
		{ Name = "RigLowerRL", MeshId = "220855121",  TextureId = "1102816925", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, Rad(0), Rad(0)) },
		{ Name = "RigLowerLL", MeshId = "2907183829",  TextureId = "2907184367", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(Rad(0), Rad(0), Rad(0)) },
		{ Name = "RigUpperRA", MeshId = "3030546036",  TextureId = "4645402630", Offset = CFrame.Angles(Rad(-90), 0, 0) },
		{ Name = "RigUpperLA", MeshId = "4324138105",  TextureId = "4381699432", Offset = CFrame.Angles(Rad(-90), 0, 0) },
		{ Name = "RigUpperRL", MeshId = "3030546036",  TextureId = "3409604993", Offset = CFrame.new(-0.1, 0, 0) * CFrame.Angles(Rad(90), 0, Rad(0))},
		{ Name = "RigUpperLL", MeshId = "3030546036",  TextureId = "3033898741", Offset = CFrame.new(-0.1, 0, 0) * CFrame.Angles(Rad(90), 0, Rad(0)) },
		-- Offsale Rig
		{ Name = "RigTorso", MeshId = "139792224823925",  TextureId = "89183204903931", Offset = CFrame.Angles(0, Rad(90), 0) },
		{ Name = "RigUpperRA", MeshId = "139733645770094",  TextureId = "130809869695496", Offset = CFrame.Angles(0, 0, Rad(90)) },
		{ Name = "RigLowerRA", MeshId = "99608462237958",  TextureId = "130809869695496", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, Rad(90)) },
		{ Name = "RigUpperLA", MeshId = "105141400603933",  TextureId = "71060417496309", Offset = CFrame.Angles(0, 0, Rad(90)) },
		{ Name = "RigLowerLA", MeshId = "90736849096372",  TextureId = "79186624401216", Offset = CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, Rad(90)) },
		{ Name = "RigUpperRL", MeshId = "125405780718494",  TextureId = "136752500636691", Offset = CFrame.Angles(0, 0, Rad(90)) },
		{ Name = "RigLowerRL", MeshId = "83395427313429",  TextureId = "97148121718581", Offset = CFrame.Angles(0, 0, Rad(90)) },
		{ Name = "RigUpperLL", MeshId = "125405780718494", TextureId = "136752500636691", Offset = CFrame.Angles(0, 0, Rad(90)) },
		{ Name = "RigLowerLL", MeshId = "83395427313429",  TextureId = "97148121718581", Offset = CFrame.Angles(0, 0, Rad(90)) },
		-- Paid Rig
		{ Name = "RigTorso", MeshId = "84515304632473",  TextureId = "84039546952302", Offset = CFrame.Angles(0, Rad(90), 0) },
		{ Name = "RigUpperRA", MeshId = "78293105051020",  TextureId = "122537687615163", Offset = CFrame.identity },
		{ Name = "RigLowerRA", MeshId = "135697222210595",  TextureId = "120408350187781", Offset = CFrame.identity },
		{ Name = "RigUpperLA", MeshId = "78293105051020",  TextureId = "122537687615163", Offset = CFrame.identity },
		{ Name = "RigLowerLA", MeshId = "134754275035651",  TextureId = "86702473018302", Offset = CFrame.identity },
		{ Name = "RigUpperRL", MeshId = "97033114253379",  TextureId = "95050943854091", Offset = CFrame.identity },
		{ Name = "RigLowerRL", MeshId = "117819431609325",  TextureId = "99296263400991", Offset = CFrame.identity },
		{ Name = "RigUpperLL", MeshId = "95514065215854", TextureId = "95360218235116", Offset = CFrame.identity },
		{ Name = "RigLowerLL", MeshId = "123367516502316", TextureId = "123343758540074", Offset = CFrame.identity },
		-- Offsale Torso 7ws
		{ Name = "RigTorso", MeshId = "110684113028749",  TextureId = "70661572547971", Offset = CFrame.Angles(0, Rad(90), 0) },
		-- Blocky Legs Torso (127855887796395)
		{ Name = "RigTorso", MeshId = "109295757295024",  TextureId = "111208135453240", Offset = CFrame.Angles(0, Rad(90), 0) },
	},
	ApplyDescription = true,
	BreakJointsDelay = 0.245,
	ClickFling = false,
	DefaultFlingOptions = {
		HatFling = false,
		Highlight = true,
		PredictionFling = true,
		Timeout = 0.5,
		ToolFling = false,
	},
	DisableCharacterCollisions = true,
	DisableHealthBar = true,
	DisableRigCollisions = true,
	HatDrop = false,
	HideCharacter = Vector3.new(0, -30, 0),
	ParentCharacter = true,
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

local DefaultFlingOptions = {
	HatFling = false,
	Highlight = false,
	PredictionFling = true,
	Timeout = 0.5,
	ToolFling = false,
}
local DefaultFlingOptions = {
	HatFling = false,
	Highlight = false,
	PredictionFling = true,
	Timeout = 0.5,
	ToolFling = false,
}

-- character setup
local Camera = workspace.CurrentCamera
local Player = Players.LocalPlayer
local Character = Empyrean.Rig
local Minos = Character:WaitForChild("Minos")
local Humanoid = Character:WaitForChild("Humanoid")
local Head = Character:WaitForChild("Head")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Mouse = Player:GetMouse()

-- effects setup
local LeftTrail, RightTrail = Character:WaitForChild("RigLowerRA").Trail, Character:WaitForChild("RigLowerLA").Trail

local Theme = Instance.new("Sound", RootPart)
if RunService:IsStudio() then
	Theme.SoundId = "rbxasset://MinosTheme.mp3"
else
	pcall(function()
		Theme.SoundId = getcustomasset(Directories.Songs.."MinosTheme.skibidi")
	end)
end
Theme.Volume = 1
Theme.Looped = true
Theme:Play()

-- animator module
local Contains = function(Table, Check)
	for Index, Value in next, Table do 
		if rawequal(Check, Index) or rawequal(Check, Value) then 
			return true
		end
	end
	return false
end

local Edit = function(Joint, Change, Duration, Style, Direction)
	if typeof(Style) == "EnumItem" and Style.Name == "Constant" then
		Joint.CFrame = Change
		return
	end 
	Style = Enum.EasingStyle[Style.Name]
	Direction = Enum.EasingDirection[Direction.Name]
	local Anim = TweenService:Create(Joint, TweenInfo.new(Duration, Style, Direction), {CFrame = Change})
	Anim:Play()
	return Anim
end

for i, v in pairs(Minos:GetDescendants()) do
	if v:IsA("Bone") then
		AnimDefaults[v.Name] = v.CFrame
		Joints[v.Name] = v
	end
end

function AnimatorModule:LoadAnimation(Rig, KeyframeSequence)
	local Sequence = KeyframeSequence
	assert(Sequence:IsA("KeyframeSequence"), "KeyframeSequence Missing!")
	local Class = {}
	Class.Speed = 1
	Class.KeepLast = 0
	local Keyframes = KeyframeSequence:GetKeyframes()
	table.sort(Keyframes, function(a, b) return a.Time < b.Time end) -- Thanks 10k_i, roblox not sorting by default.
	Class.Length = Keyframes[#(Keyframes)].Time
	local Yield = function(Seconds)
		local Time = Seconds * (60 + Class.Length)
		for i = 1, Time, Class.Speed do 
			task.wait()
		end
	end
	if Sequence:FindFirstChild("xSIXxNull", true) or Sequence:FindFirstChild("xSIXxCustomDir", true) or Sequence:FindFirstChild("xSIXxCustomStyle", true) then -- Moon Suite Fix
		local Children = Sequence:GetChildren()
		for i = 1, #(Children) do
			if Children[i]:FindFirstChild("Torso") then
				local Limbs = Children[i].Torso:GetChildren()
				for l = 1, #(Limbs) do
					Limbs[l].Parent = Children[i].HumanoidRootPart.Torso
				end
				Children[i].Torso:Destroy()
			end
		end
	end
	local Descendants = Sequence:GetDescendants()
	for i = 1, #(Descendants) do
		if Descendants[i]:IsA("IntValue") or Descendants[i]:IsA("StringValue") or Descendants[i]:IsA("Folder") then
			Descendants[i]:Destroy()
		end
		if Descendants[i].Parent ~= Sequence and Descendants[i]:IsA("Pose") and not Rig:FindFirstChild(Descendants[i].Name, true) then
			Descendants[i]:Destroy()
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
	Class["Play"] = function(self, FadeIn, Speed)
		if Speed and Speed < 0 then
			Speed += (Speed*2)
		end
		Class.Speed = Speed or Class.Speed
		Class.Stopped = false
		Class.IsPlaying = true
		task.spawn(function()
			wait(1/60)
			if FadeIn ~= nil then
				Class.TimePosition -= FadeIn
			end
			Class.Completed:Connect(function()
				if Class.Looped ~= false then
					Class.TimePosition = 0
				end
			end)
			repeat RunService.Heartbeat:Wait()
				Class.TimePosition += (1 * Class.Speed) / (60 * Class.Speed) 
			until Class.IsPlaying == false or Class.Stopped ~= false
		end)
		task.spawn(function()
			if FadeIn ~= nil then
				task.wait(1/55)
				task.spawn(function()
					local Frames = Keyframes[1]:GetDescendants()
					for i = 1, #(Frames) do 
						local Pose = Frames[i]
						if Contains(Joints, Pose.Name) then 
							task.spawn(function()
								for i = 1, 2 do
									Edit(Joints[Pose.Name], AnimDefaults[Pose.Name] * Pose.CFrame, FadeIn, Pose.EasingStyle, Pose.EasingDirection)
									task.wait()
								end
							end)
						end
					end
				end)
				Yield(FadeIn)
			end
			repeat
				for K = 1, #(Keyframes) do 
					local K0, K1, K2 = Keyframes[K-1], Keyframes[K], Keyframes[K+1]
					if Class.Stopped ~= true then
						if K0 ~= nil then 
							Yield(K1.Time - K0.Time)
						end
						task.spawn(function()
							for i = 1, #(K1:GetDescendants()) do 
								local Pose = K1:GetDescendants()[i]
								if Contains(Joints, Pose.Name) then 
									local Duration = K2 ~= nil and (K2.Time - K1.Time) / Class.Speed or 0.5
									Edit(Joints[Pose.Name], AnimDefaults[Pose.Name] * Pose.CFrame, Duration, Pose.EasingStyle, Pose.EasingDirection)
								end
							end
						end)
						if K == #(Keyframes) and Class.KeepLast > 0 then
							Yield(Class.KeepLast)
						end
						Reached:Fire(K1.Name)
					else
						break
					end
				end
				Completion:Fire()
			until Class.Looped ~= true or Class.Stopped ~= false
			Class.IsPlaying = false
		end)
	end
	Class["Stop"] = function()
		Class.Stopped = true
		Class.IsPlaying = false
	end
	Class["AdjustSpeed"] = function(self, Speed)
		if Speed < 0 then
			Speed += (Speed*2)
		end
		Class.Speed = Speed or Class.Speed
	end
	return Class
end

-- animator functions
local PlayAnim = function(Rig: Model, Animation: KeyframeSequence, AnimSpeed: number)
	if not AnimatorModule[Rig] then
		AnimatorModule[Rig] = {}
	end
	if not AnimatorModule[Rig][Animation.Name] then
		AnimatorModule[Rig][Animation.Name] = AnimatorModule:LoadAnimation(Rig, Animation)
	end
	for Name, Track in pairs(AnimatorModule[Rig]) do
		if Name ~= Animation.Name then
			Track:Stop()
		end
	end
	local AnimInstance = AnimatorModule[Rig][Animation.Name]
	if not AnimInstance.IsPlaying then
		AnimInstance:Play(AnimSpeed or 1)
	end
	return AnimInstance
end

local StopAnim = function(Rig: Model, Animation: KeyframeSequence)
	if not AnimatorModule[Rig] then
		AnimatorModule[Rig] = {}
	end
	if not AnimatorModule[Rig][Animation.Name] then
		AnimatorModule[Rig][Animation.Name] = AnimatorModule:LoadAnimation(Rig, Animation)
	end
	AnimatorModule[Rig][Animation.Name]:Stop()
end


local RestoreMovement = function()
	if RootPart.Velocity.Magnitude < 1 and workspace:FindPartOnRay(Ray.new(RootPart.Position, (CFrame.new(RootPart.Position, RootPart.Position + Vector3.new(0, -1, 0))).LookVector * 4), Character) then
		Idle = true
		Walking = false
		Running = false
		PlayAnim(Minos, Animations.Idle, .1)
	elseif RootPart.Velocity.Magnitude > 1 and workspace:FindPartOnRay(Ray.new(RootPart.Position, (CFrame.new(RootPart.Position, RootPart.Position + Vector3.new(0, -1, 0))).LookVector * 4), Character) then
		Idle = false
		Walking = true
		Running = false
		PlayAnim(Minos, Animations.Walk, .1)
	end
end

-- functions
local PlayUISFX = function(Audio: number)
	local Sound = Instance.new("Sound", workspace)
	Sound.SoundId = "rbxassetid://" .. Audio
	Sound.Volume = 1
	Sound.PlayOnRemove = true
	Sound:Destroy()
	return Sound
end

local PlaySFX = function(Audio: number)
	local Sound = Instance.new("Sound", RootPart)
	Sound.SoundId = "rbxassetid://" .. Audio
	Sound.Volume = 1
	Sound.PlayOnRemove = true
	Sound:Destroy()
	return Sound
end

local PlaySong = function(Parent: Instance, Audio: number)
	local Sound = Instance.new("Sound", Parent)
	Sound.Volume = 1
	Sound.SoundId = Audio
	return Sound
end

local FlashHitHighlight = function(Target: Model?)
	if not Target or not Target:IsA("Model") then return end
	if Target:FindFirstChild("HitHighlight") then return end 
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "HitHighlight"
	Highlight.Adornee = Target
	Highlight.FillColor = Color3.fromRGB(0, 0, 0)
	Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	Highlight.FillTransparency = 1
	Highlight.OutlineTransparency = 1
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.Parent = Target
	local FlashIn = TweenService:Create(Highlight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {FillTransparency = 0.3, OutlineTransparency = 0})
	local FadeOut = TweenService:Create(Highlight,TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {FillTransparency = 1,OutlineTransparency = 1})
	FlashIn:Play()
	FlashIn.Completed:Once(function() FadeOut:Play() end)
	FadeOut.Completed:Once(function() Highlight:Destroy() end)
end

local CanHit = function(Target: Instance)
	local Time = os.clock()
	if HitHumanoids[Target] and Time < HitHumanoids[Target] then
		return false
	end
	HitHumanoids[Target] = Time + 1.15
	return true
end

local NewHitbox = function(Position: Vector3 | CFrame, Size: number, HitSound: number)
	local Hitbox = Instance.new("Part")
	Hitbox.Size = Size or Vector3.new(4, 4, 4)
	Hitbox.Color = ScriptSettings.HitboxColor
	Hitbox.Material = Enum.Material.ForceField
	Hitbox.Transparency = 0.5
	Hitbox.Anchored = true
	Hitbox.CanCollide = false
	Hitbox.CanQuery = false
	Hitbox.CanTouch = true
	Hitbox.CFrame = Position or RootPart.CFrame -- RootPart.CFrame * CFrame.new(0, 0, -(4 / 2 + 2))
	Hitbox.Parent = workspace
	local OverlapParams = OverlapParams.new()
	OverlapParams.FilterType = Enum.RaycastFilterType.Exclude
	OverlapParams.FilterDescendantsInstances = {Character}
	local HitboxParts = workspace:GetPartsInPart(Hitbox, OverlapParams)
	for i, v in pairs(HitboxParts) do
		local Target = v:FindFirstAncestorOfClass("Model")
		if Target and Target:FindFirstChildOfClass("Humanoid")  then
			local TargetRoot = Target:FindFirstChild("HumanoidRootPart")
			if TargetRoot and CanHit(Target) then
				if Settings.Fling then
					Empyrean.Fling(Target, DefaultFlingOptions)
					FlashHitHighlight(Target)
					PlaySFX(ScriptSettings.Hitmarker)
					PlaySFX(HitSound or 108515070727256)
				end
			end
		end
	end
	local HitboxFade = TweenService:Create(Hitbox, TweenInfo.new(0.5), {Transparency = 1})
	HitboxFade:Play()
	Debris:AddItem(Hitbox, 0.5)
	return Hitbox -- added incase you wanna make it animated or even position it somewhere else
end

local FlashTrail = function(Trail: Trail)
	Trail.Enabled = true
	task.delay(0.2, function()
		Trail.Enabled = false
	end)
end

local SetWalkSpeed = function(Speed: number)
	Humanoid.WalkSpeed = Speed
end

local SetRootAnchored = function(Anchored: boolean)
	RootPart.Anchored = Anchored
end

-- caption handler thing
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SubtitleGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui
table.insert(TrashBin, ScreenGui)

local StackFrame = Instance.new("Frame")
StackFrame.Size = UDim2.new(1, 0, 0.3, 0)
StackFrame.Position = UDim2.new(0.5, 0, 0.95, 0)
StackFrame.AnchorPoint = Vector2.new(0.5, 1)
StackFrame.BackgroundTransparency = 1
StackFrame.Parent = ScreenGui

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.Padding = UDim.new(0, 6)
UIListLayout.Parent = StackFrame

local NewCaption = function(Text : string, Lifetime : number, Color : Color3)
	Lines += 1
	local Label = Instance.new("TextLabel")
	Label.LayoutOrder = Lines
	Label.BackgroundTransparency = 1
	Label.BackgroundColor3 = Color or Color3.fromRGB(0,0,0)
	Label.Text = Text
	Label.Font = Enum.Font.Arcade
	Label.TextSize = 24
	Label.TextColor3 = Color3.fromRGB(255,255,255)
	Label.Size = UDim2.new(0.6, 0, 0, 0)
	Label.AutomaticSize = Enum.AutomaticSize.Y
	Label.TextWrapped = true
	Label.TextXAlignment = Enum.TextXAlignment.Center
	Label.TextYAlignment = Enum.TextYAlignment.Top
	Label.TextWrapped = true
	Label.Parent = StackFrame
	local Padding = Instance.new("UIPadding")
	Padding.PaddingTop = UDim.new(0, 6)
	Padding.PaddingBottom = UDim.new(0, 6)
	Padding.PaddingLeft = UDim.new(0, 12)
	Padding.PaddingRight = UDim.new(0, 12)
	Padding.Parent = Label
	TweenService:Create(Label, TweenInfo.new(0.25), {BackgroundTransparency = 0.75, TextTransparency = 0}):Play()
	task.delay(Lifetime or 2, function()
		TweenService:Create(Label, TweenInfo.new(0.5), {BackgroundTransparency = 1, TextTransparency = 1}):Play()
		task.wait(0.5)
		Label:Destroy()
	end)
end

-- attacks
local Intro = function()
	local IntroText = {
		{Text = "Ahh..", Delay = 2},
		{Text = "Free at last", Delay = 4.5},
		{Text = "O Gabriel", Delay = 3.5},
		{Text = "Now dawns thy reckoning", Delay = 3.5},
		{Text = "And thy gore shall glisten before the temples of man", Delay = 7.75},
		{Text = "Creature of steel", Delay = 4},
		{Text = "My gratitude upon thee for my freedom", Delay = 5.15},
		{Text = "But the crimes thy kind have committed against humanity", Delay = 5.95},
		{Text = "Are NOT forgotten", Delay = 4},
		{Text = "And thy punishment...", Delay = 3.65},
		{Text = "Is DEATH", Delay = 0}
	}
	if Debounce then return end
	Debounce = true
	SetRootAnchored(true)
	local IntroAnim = PlayAnim(Minos, Animations.Intro, .1)
	local IntroSound = Instance.new("Sound", RootPart)
	pcall(function()
		IntroSound.SoundId = getcustomasset(Directories.Sounds.."MinosIntro.skibidi")
	end)
	IntroSound.Volume = 1
	IntroSound.PlayOnRemove = true
	IntroSound:Destroy()
	for i, v in ipairs(IntroText) do
		NewCaption(v.Text, 7, Color3.new(0, 0, 0))
		if v.Delay > 0 then
			task.wait(v.Delay)
		end
	end
	IntroAnim.Completed:Wait()
	Debounce = false
	RestoreMovement()
	SetRootAnchored(false)
end


local M1 = function()
	if Debounce then return end
	local Random = math.random(1, 100)
	Debounce = true
	if ComboResetTimer then
		task.cancel(ComboResetTimer)
		ComboResetTimer = nil
	end
	ComboCount = ComboCount + 1
	if ComboCount > MaxCombo then
		ComboCount = 1 
	end
	local AnimName = "Hit" .. ComboCount
	local PunchAnim = PlayAnim(Minos, Animations[AnimName], 0.1)
	PlaySFX(139560866218614)
	if Random < 25 then
		PlaySFX(131168537910787)
		NewCaption("Thy end is NOW!", 1, Color3.new(0, 0, 0))
	end
	local PunchConnection = PunchAnim.KeyframeReached:Connect(function(Keyframe)
		if Keyframe == "RightSwing" then
			PlaySFX(105199638652269)
			FlashTrail(RightTrail)
			local DashEffect = Objects:WaitForChild("Dash"):Clone()
			DashEffect.Parent = workspace
			DashEffect.Position = RootPart.Position
			DashEffect.CFrame = RootPart.CFrame * CFrame.new(0, 0, -10)
			for i, v in pairs(DashEffect:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
			NewHitbox(RootPart.CFrame * CFrame.new(0, 0, -6.5), Vector3.new(7, 7, 7), 87584459346537)
			Debris:AddItem(DashEffect, 5)
		end
		if Keyframe == "LeftSwing" then
			PlaySFX(105199638652269)
			FlashTrail(LeftTrail)
			local DashEffect = Objects:WaitForChild("Dash"):Clone()
			DashEffect.Parent = workspace
			DashEffect.Position = RootPart.Position
			DashEffect.CFrame = RootPart.CFrame * CFrame.new(0, 0, -10)
			for i, v in pairs(DashEffect:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
			NewHitbox(RootPart.CFrame * CFrame.new(0, 0, -6.5), Vector3.new(7, 7, 7), 87584459346537)
			Debris:AddItem(DashEffect, 5)
		end
		if Keyframe == "Slam" then
			PlaySFX(112192533344145)
			local SlamEffect = Objects:WaitForChild("M1Slam"):Clone()
			SlamEffect.Parent = workspace
			SlamEffect.Position = RootPart.Position
			SlamEffect.CFrame = RootPart.CFrame * CFrame.new(0, 0, -10)
			for i, v in pairs(SlamEffect:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
			NewHitbox(RootPart.CFrame * CFrame.new(0, 0, -10), Vector3.new(15, 15, 15), 87584459346537)
			Debris:AddItem(SlamEffect, 10)
		end
	end)
	PunchAnim.Completed:Wait()
	Debounce = false
	PunchConnection:Disconnect()
	RestoreMovement()
	ComboResetTimer = task.delay(ComboResetTime, function()
		ComboCount = 0
	end)
end

local Crush = function()
	if Debounce then return end
	Debounce = true
	local CrushAnim = PlayAnim(Minos, Animations.Crush, 0.1)
	local CrushConnection = CrushAnim.KeyframeReached:Connect(function(Keyframe)
		if Keyframe == "Launch" then
			PlaySFX(139560866218614)
			local BodyVelocity = Instance.new("BodyVelocity")
			BodyVelocity.MaxForce = Vector3.new(0, 100000, 0)
			BodyVelocity.Velocity = Vector3.new(0, 90, 0)
			BodyVelocity.Parent = RootPart
			Debris:AddItem(BodyVelocity, 2.75)
		end
		if Keyframe == "Freeze" then
			PlaySFX(138937922522006)
			NewCaption("Crush!", 1, Color3.new(0, 0, 0))
			RootPart.Velocity = Vector3.zero
			RootPart.AssemblyLinearVelocity = Vector3.zero
			SetRootAnchored(true)
		end
		if Keyframe == "Slam" then
			SetRootAnchored(false)
			local RaycastParameters = RaycastParams.new()
			RaycastParameters.FilterType = Enum.RaycastFilterType.Exclude
			RaycastParameters.FilterDescendantsInstances = {Character}
			local Result = workspace:Raycast(RootPart.Position, Vector3.new(0, -500, 0), RaycastParameters)
			if Result then
				SetRootAnchored(true)
				RootPart.CFrame = CFrame.new(Result.Position + Vector3.new(0, 3, 0))
				PlaySFX(112192533344145)
			end
			local SlamEffect = Objects:WaitForChild("Crush"):Clone()
			SlamEffect.Parent = workspace
			SlamEffect.Position = RootPart.Position
			SlamEffect.CFrame = RootPart.CFrame
			for i, v in pairs(SlamEffect:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
			NewHitbox(RootPart.CFrame, Vector3.new(25, 25, 25), 87584459346537)
			Debris:AddItem(SlamEffect, 10)
		end
	end)
	CrushAnim.Completed:Wait()
	SetRootAnchored(false)
	Debounce = false
	CrushConnection:Disconnect()
	RestoreMovement()
end

local Judgement = function()
	if Debounce then return end
	Debounce = true
	SetRootAnchored(true)
	PlaySFX(117154595454363)
	NewCaption("Judgement!", 1, Color3.new(0, 0, 0))
	local JudgementAnim = PlayAnim(Minos, Animations.Judgement, 0.1)
	local JudgementConnection = JudgementAnim.KeyframeReached:Connect(function(Keyframe)
		if Keyframe == "Teleport" then
			RootPart.CFrame = RootPart.CFrame * CFrame.new(0, 0, -15)
		end			
		if Keyframe == "Kick" then
			PlaySFX(112192533344145)
			local SlamEffect = Objects:WaitForChild("M1Slam"):Clone()
			SlamEffect.Parent = workspace
			SlamEffect.Position = RootPart.Position
			SlamEffect.CFrame = RootPart.CFrame
			for i, v in pairs(SlamEffect:GetDescendants()) do
				if v:IsA("ParticleEmitter") then
					v:Emit(v:GetAttribute("EmitCount"))
				end
			end
			NewHitbox(RootPart.CFrame, Vector3.new(25, 25, 25), 87584459346537)
			Debris:AddItem(SlamEffect, 10)
		end
	end)
	JudgementAnim.Completed:Wait()
	JudgementConnection:Disconnect()
	SetRootAnchored(false)
	Debounce = false
	RestoreMovement()
end

local SerpentShot = function()
	if Debounce then return end
	Debounce = true
	SetRootAnchored(true)
	PlaySFX(138811238692467)
	NewCaption("Prepare thyself!", 1, Color3.new(0, 0, 0))
	local Damaged, Thrown  = false, false
	local Projectile, ProjectileVelocity, Touched
	local ThrowConnection
	local SerpentAnim = PlayAnim(Character, Animations.Serpent, .1)
	ThrowConnection = SerpentAnim.KeyframeReached:Connect(function(Keyframe)
		if Keyframe == "Shoot" and not Thrown then
			PlaySFX(113519178156391)
			Thrown = true
			Projectile = Objects:WaitForChild("Serpent"):Clone()
			Projectile.Transparency = 0
			Projectile.Name = "SerpentProjectile"
			Projectile.Anchored = false
			Projectile.CanCollide = false
			Projectile.CFrame = CFrame.new(RootPart.Position + RootPart.CFrame.LookVector * 5, Mouse.Hit.Position)
			Projectile.Parent = workspace
			ProjectileVelocity = Instance.new("BodyVelocity")
			ProjectileVelocity.Velocity = (Mouse.Hit.Position - Projectile.Position).Unit * 100
			ProjectileVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
			ProjectileVelocity.Parent = Projectile
			Touched = Projectile.Touched:Connect(function(Hit)
				if Damaged then return end
				if Hit:IsDescendantOf(Character) then return end
				if Hit.Name == "SerpentProjectile" or Hit.Name == "SerpentHitbox" then return end
				Damaged = true
				local Target = Hit:FindFirstAncestorOfClass("Model")
				Projectile.Anchored = true
				Projectile.Transparency = 1
				Projectile.CanCollide = false
				PlaySFX(135670616983730)
				local Hitbox = NewHitbox(Projectile.CFrame, Vector3.new(10, 10, 10), 87584459346537)
				Hitbox.Name = "SerpentHitbox"
				local SlamEffect = Objects:WaitForChild("M1Slam"):Clone()
				SlamEffect.Parent = workspace
				SlamEffect.Position = Projectile.Position
				SlamEffect.CFrame = Projectile.CFrame
				for i, v in pairs(SlamEffect:GetDescendants()) do
					if v:IsA("ParticleEmitter") then
						v:Emit(v:GetAttribute("EmitCount"))
					end
				end
				task.delay(2, function()
					if SlamEffect then SlamEffect:Destroy() end
					if Hitbox then Hitbox:Destroy() end
					if ProjectileVelocity then ProjectileVelocity:Destroy() end
					if Projectile then Projectile:Destroy() end
					if Touched then Touched:Disconnect() end
				end)
			end)
		end
	end)
	SerpentAnim.Completed:Wait()
	task.delay(10, function()
		if Projectile then Projectile:Destroy() end
		if ThrowConnection and ThrowConnection.Connected then
			ThrowConnection:Disconnect()
		end
		if Touched and Touched.Connected then
			Touched:Disconnect()
		end
	end)
	Debounce = false
	SetRootAnchored(false)
	RestoreMovement()
end

-- input
local KeyDown = UserInputService.InputBegan:Connect(function(Key, GPE)
	if GPE then return end
	if Key.UserInputType == Enum.UserInputType.MouseButton1 then
		M1()
	end
	if Key.KeyCode == Enum.KeyCode.Q then
		Judgement()
	end
	if Key.KeyCode == Enum.KeyCode.E then
		Crush()
	end
	if Key.KeyCode == Enum.KeyCode.R then
		SerpentShot()
	end
	if Key.KeyCode == Enum.KeyCode.T then
		Intro()
	end
end)
table.insert(ActiveConnections, KeyDown)

local InfiniteJump = UserInputService.JumpRequest:Connect(function()
	if Settings.InfiniteJump and Humanoid then
		Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)
table.insert(ActiveConnections, InfiniteJump)

-- mobile ui
local GUI = script:WaitForChild("UIs").MobileUI
GUI.Parent = CoreGui
table.insert(TrashBin, GUI)

local UpdateUI = function()
	local LastInput = UserInputService:GetLastInputType()
	if LastInput == Enum.UserInputType.Touch
	then GUI.Enabled = true
	else GUI.Enabled = false
	end
end

UpdateUI()

GUI.AbilitiesUI["M1"].MouseButton1Down:connect(function() M1() end)
GUI.AbilitiesUI["Judgement"].MouseButton1Down:connect(function() Judgement() end)
GUI.AbilitiesUI["Crush"].MouseButton1Down:connect(function() Crush() end)
GUI.AbilitiesUI["Serpent"].MouseButton1Down:connect(function() SerpentShot() end)
GUI.AbilitiesUI["Intro"].MouseButton1Down:connect(function() Intro() end)

UserInputService.LastInputTypeChanged:Connect(UpdateUI)

-- settings ui
local MainGUI = script.UIs:WaitForChild("MainGUI")
table.insert(TrashBin, MainGUI)
MainGUI.Parent = CoreGui
local SettingsFrame = MainGUI:WaitForChild("SettingsFrame")
local Vignette = MainGUI:WaitForChild("Vignette")
local SettingsHolder = SettingsFrame:WaitForChild("SettingsHolder")
local FloatingButton = MainGUI:WaitForChild("FloatingButton")
local UIDragDetector = Instance.new("UIDragDetector", FloatingButton)

UIDragDetector.DragStart:Connect(function()
	SettingsFrame.Visible = not SettingsFrame.Visible
	PlayUISFX(18755588842)
end)

FloatingButton.MouseEnter:Connect(function()
	PlayUISFX(122453173810540)
end)

local SetupToggle = function(Setting: boolean)
	local Object = SettingsHolder:FindFirstChild(Setting)
	if not Object then return end
	local Button = Object:FindFirstChildWhichIsA("TextButton")
	if not Button then return end
	Button.BackgroundColor3 = Settings[Setting] and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
	Button.MouseButton1Click:Connect(function()
		PlayUISFX(18755588842)
		Settings[Setting] = not Settings[Setting]
		Button.BackgroundColor3 = Settings[Setting] and Color3.fromRGB(0,255,0) or Color3.fromRGB(255,0,0)
	end)
end

local SetupTextBox = function(Setting: string | number) -- currently only used in the rigsize (no other textboxes will exist i think)
	local Object = SettingsHolder:FindFirstChild(Setting)
	if not Object then return end
	local TextBox = Object:FindFirstChildWhichIsA("TextBox")
	if not TextBox then return end
	TextBox.Text = tostring(Settings[Setting])
	TextBox.FocusLost:Connect(function()
		local Value = tonumber(TextBox.Text)
		if Value then
			Settings[Setting] = math.clamp(Value, 0.5, 5)
		else
			TextBox.Text = tonumber(Settings[Setting])
		end
	end)
end

for i, v in pairs(Settings) do
	local Object = SettingsHolder:FindFirstChild(i)
	if Object then
		if Object:FindFirstChild("Button") then
			SetupToggle(i)
		elseif Object:FindFirstChild("Value") then
			SetupTextBox(i)
		end
	end
end

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

-- runservice connection
local RunServiceConnection = RunService.Heartbeat:Connect(function(dt)
	if Debounce then
		StopAnim(Minos,Animations.Idle)
		StopAnim(Minos,Animations.Walk)
	end
	if Settings.CameraEffects then
		Humanoid.CameraOffset = Humanoid.CameraOffset:Lerp((RootPart.CFrame * CFrame.new(0, 1.5, 0)):PointToObjectSpace(Head.Position), math.clamp(8 * 60 * 60, 0, 1))
	else
		Humanoid.CameraOffset = Vector3.new(0, 0, 0)
	end
	if not Debounce then
		SetWalkSpeed(24)
	end
	if Settings.FOVEffects then
		Camera.FieldOfView = 80 + Theme.PlaybackLoudness / 100
		Vignette.ImageTransparency = 1 - Theme.PlaybackLoudness / 900
	else
		Camera.FieldOfView = 70
		Vignette.ImageTransparency = 1
	end
	if Settings.Music then
		Theme.Playing = true
	else
		Theme.Playing = false
	end
	local RootPartOrigin = RootPart.Position
	local Direction = Vector3.new(0, -1, 0) * 4
	local Params = RaycastParams.new()
	Params.FilterDescendantsInstances = {Character}
	Params.FilterType = Enum.RaycastFilterType.Exclude
	Params.IgnoreWater = true
	local Result = workspace:Raycast(RootPartOrigin, Direction, Params)
	local HitFloor = Result and Result.Instance
	local TorsoVelocity = (RootPart.Velocity).Magnitude
	if TorsoVelocity < 1 and HitFloor ~= nil and Debounce == false then
		if Idle == false then
			Idle = true
			PlayAnim(Minos,Animations.Idle, 0.1)
		end
		Walking = false
		Running = false
		StopAnim(Minos,Animations.Walk)
	elseif TorsoVelocity > 1 and HitFloor ~= nil and Debounce == false then
		if Walking == false then
			Walking = true
			PlayAnim(Minos, Animations.Walk, 0.1)
		end
		Idle = false
		Running = false
		StopAnim(Minos,Animations.Idle)
	end
end)
table.insert(ActiveConnections, RunServiceConnection)

Empyrean.BindableEvent.Event:Once(function()
	print("Resetting.")
	for i, v in TrashBin do
		v:Destroy()
	end
	for i, v in ActiveConnections do
		v:Disconnect()
	end
end)
