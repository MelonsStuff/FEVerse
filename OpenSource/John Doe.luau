-- [[ John Doe : Reanimate ]] --

--[[
  Credits:
  // Melon - Created this script
  // Emper - Created the reanimation used
  // ZerX - Movement scripting (last part only, i edited it a bit)
  // Forsaken Team - Created the assets used to make this script.

  Note: if there's bugs pls let me know so i can fix them
  the code may be unoptimized at some parts and uses a lot of if statements

  Free hats:
  // Spike Arm P1: https://www.roblox.com/catalog/12103236257/AO-Surfboard
  // Spike Arm P2: https://www.roblox.com/catalog/7548993875/Slasher

  Free rig:
  // https://www.roblox.com/catalog/3033910400/International-Fedora-Germany
  // https://www.roblox.com/catalog/3409612660/International-Fedora-USA
  // https://www.roblox.com/catalog/3398308134/International-Fedora-Canada
  // https://www.roblox.com/catalog/3033908130/International-Fedora-France
  // https://www.roblox.com/catalog/4819740796/Robox

  Paid hats are found in this game:
  // https://www.roblox.com/games/15541318313/Melons-Baseplate
]] 

local Directories = {
	Main = "FEVerse/",
	RBXMs ="FEVerse/RBXMs/",
	Sounds = "FEVerse/Sounds/",
	Songs = "FEVerse/Songs/",
}

local FEManager = loadstring(game:HttpGet("https://gist.githubusercontent.com/MelonsStuff/a003ea305dd302eab1f8d372daed38b4/raw/9db59962b28555fd699a7c29891efb85d45677ab/gistfile1.txt"))()
for i, v in pairs(Directories) do FEManager.EnsureFolder(v) end
FEManager.DownloadFile(Directories.RBXMs, "John Doe.rbxmx", "https://raw.githubusercontent.com/MelonsStuff/FEVerse/refs/heads/main/RBXMs/John%20Doe.rbxmx")
FEManager.DownloadFile(Directories.RBXMs, "John Doe Kill Animations.rbxmx", "https://raw.githubusercontent.com/MelonsStuff/FEVerse/refs/heads/main/RBXMs/John%20Doe%20Kill%20Animations.rbxmx")

local Reanimate_Settings = {
	Frequency = 6, -- this is basically how fast the oscillation goes
	Amplification = 6, -- this is how far the oscillation goes
	FrontOffset = 2.5, -- this is how much youre in front of the player during prediction
}

do
  local ReanimateDummy
  
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
            ReanimateDummy = CreateObject("Reanimate_Dummy")

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
                ReanimateDummy.Anchored = false
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
		{ MeshId = "14768666349", Name = "Torso", Offset = CFrame.Angles(0, 0, 0), TextureId = "14768664565" },
		{ MeshId = "14768684979", Names = { "Left Arm", "Right Arm"}, Offset = CFrame.Angles(0, 0, 1.57), TextureId = "14768683674" },
	    -- Dummies
        -- 135402384718389 / 1x1x1x1 Companion
        { Name = "Reanimate_Dummy",  MeshId = "104517187424526", TextureId = "133044964286932", Offset = CFrame.Angles(0, Rad(180), 0) },
        -- 108495754880799 / Sans Buddy
        { Name = "Reanimate_Dummy",  MeshId = "105289859748885", TextureId = "126957807478034", Offset = CFrame.Angles(0, Rad(180), 0) },
        -- 103608104439992 / Minos Prime Buddy
        { Name = "Reanimate_Dummy",  MeshId = "126192907613302", TextureId = "112923148955520", Offset = CFrame.Angles(0, Rad(180), 0) },
        -- 123845356193764 - 98099894849025 / VHS Glitch
        { Name = "Reanimate_Dummy",  MeshId = "137246576921101", TextureId = "", Offset = CFrame.Angles(0, Rad(180), 0) },
        -- 7548993875 - 12103236257 / Free Dummy
        { Name = "Reanimate_Dummy", MeshId = "12495661615", TextureId = "12495666203", Offset = CFrame.new(0, -1, 0)},
        -- Arms
        -- 85716494418115 / Milestone 1 Arm
 	    { Name = "Right Arm", MeshId = "137855860286839",  TextureId = "117670564210592", Offset = CFrame.new(0.25, -0.5, 0) },
 	    -- 111138012932143 / Milestone 2 Arm
        { Name = "Right Arm", MeshId = "79875567101920",  TextureId = "136120210849686", Offset = CFrame.new(0.3, -0.5, 0) },
 	    -- 74890626600873 / Milestone 3 Arm
        { Name = "Right Arm", MeshId = "129215583333657",  TextureId = "128192857394964", Offset = CFrame.new(0.3, -0.5, 0) },
 	    -- 96699092482249 / Milestone 4 Arm
        { Name = "Right Arm", MeshId = "100825182699939",  TextureId = "89211322970449", Offset = CFrame.new(0.3, -0.5, 0) },
 	    -- 122293866267553 / Script Builder Arm
        { Name = "Right Arm", MeshId = "124989035573464",  TextureId = "128213334280922", Offset = CFrame.new(0.3, -0.5, 0) },
        -- 75437051504654 / Screamer Arm
        { Name = "Right Arm", MeshId = "107481082962823",  TextureId = "96761111981185", Offset = CFrame.new(0, -1, 0) },
 	     -- 103604163849610 / Living Legend Arm
        { Name = "Right Arm", MeshId = "105260093609634",  TextureId = "124661114206561", Offset = CFrame.new(0, 0, 0) },
        -- 86824424549357 / Original Arm
        { Name = "Right Arm", MeshId = "99922912174402",  TextureId = "84232685747564", Offset = CFrame.new(0.285, -0.75, 0) },
        -- 7548993875 - 12103236257 / Free Arm
        { Name = "Right Arm", MeshId = "7547179386",  TextureId = "7547152243", Offset = CFrame.Angles(Rad(0),  Rad(90), Rad(45)) },
        { Name = "Right Arm", MeshId = "12052123246",  TextureId = "12052422349", Offset = CFrame.Angles(Rad(90),  Rad(180), Rad(0)) },

  },
	ApplyDescription = true,
	BreakJointsDelay = 0.255,
	ClickFling = false,
	DefaultFlingOptions = {
		HatFling = false,
		Highlight = false,
		PredictionFling = true,
		Timeout = 0.1,
		ToolFling = false,
	},
	DisableCharacterCollisions = true,
	DisableHealthBar = true,
	DisableRigCollisions = true,
	HatDrop = false,
	HideCharacter = Vector3.new(0, -30, 0),
	ParentCharacter = true,
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
	Highlight = false,
	PredictionFling = true,
	Timeout = 0.25,
	ToolFling = false,
}

local AnimatorModule = {}
local TrashBin = {}

local script = game:GetObjects(getcustomasset(Directories.RBXMs.."John Doe.rbxmx"))[1]
local KillAnimations = game:GetObjects(getcustomasset(Directories.RBXMs.."John Doe Kill Animations.rbxmx"))[1]

local FPS = setfpscap(60)
local Blend = 0.35
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local AnimDefaults = {
	["Neck"] = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
	["RootJoint"] = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
	["Right Shoulder"] = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
	["Left Shoulder"] = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	["Right Hip"] = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
	["Left Hip"] = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	["Head"] = CFrame.new(0, 1, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
	["Torso"] = CFrame.new(0, 0, 0, -1, 0, 0, 0, 0, 1, 0, 1, -0),
	["Right Arm"] = CFrame.new(1, 0.5, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
	["Left Arm"] = CFrame.new(-1, 0.5, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	["Right Leg"] = CFrame.new(1, -1, 0, 0, 0, 1, 0, 1, -0, -1, 0, 0),
	["Left Leg"] = CFrame.new(-1, -1, 0, 0, 0, -1, 0, 1, 0, 1, 0, 0)
}

local function Edit(Joint, TargetCFrame, Duration, Style, Direction, Blend)
	if not Style or typeof(Style) ~= "EnumItem" or Style.EnumType ~= Enum.EasingStyle then
		Style = Enum.EasingStyle.Cubic
	end
	if not Direction or typeof(Direction) ~= "EnumItem" or Direction.EnumType ~= Enum.EasingDirection then
		Direction = Enum.EasingDirection.InOut
	end
	local StartCFrame = Joint.C0
	local Tween = TweenService:Create(Joint, TweenInfo.new(Duration, Style, Direction), {
		C0 = StartCFrame:Lerp(TargetCFrame, Blend)
	})
	Tween:Play()
	return Tween
end

function AnimatorModule:LoadAnimation(Rig, KeyframeSequence)
	local Sequence = KeyframeSequence
	local RigHumanoid = Rig:FindFirstChildOfClass("Humanoid")
	if RigHumanoid.RigType ~= Enum.HumanoidRigType.R6 then
		return error("Rig Humanoid is not R6!")
	end
	local Joints = {
		["Head"] = Rig.Torso["Neck"],
		["Torso"] = Rig.HumanoidRootPart:FindFirstChild("RootJoint") or Rig.HumanoidRootPart:FindFirstChild("Root Joint"),
		["Left Arm"] = Rig.Torso["Left Shoulder"],
		["Right Arm"] = Rig.Torso["Right Shoulder"],
		["Left Leg"] = Rig.Torso["Left Hip"],
		["Right Leg"] = Rig.Torso["Right Hip"],
	}
	local Class = {}
	Class.Speed = 1
	Class.KeepLast = 0
	local Keyframes = Sequence:GetKeyframes()
	table.sort(Keyframes, function(a, b) return a.Time < b.Time end)
	Class.Length = Keyframes[#Keyframes].Time
	local function Yield(Seconds)
		RunService.Heartbeat:Wait(Seconds / Class.Speed)
	end
	for _, v in ipairs(Sequence:GetDescendants()) do
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
			Class.Completed:Connect(function()
				if Class.Looped then
					Class.TimePosition = 0
				end
			end)
			local Connection
			Connection = RunService.Heartbeat:Connect(function(dt)
				if Class.IsPlaying and not Class.Stopped and RigHumanoid.Health > 0 then
					Class.TimePosition += math.min(dt * Class.Speed, 1)
				else
					Connection:Disconnect()
				end
			end)
		end)
		task.spawn(function()
			repeat
				for K = 1, #Keyframes do
					local K0, K1, K2 = Keyframes[K-1], Keyframes[K], Keyframes[K+1]
					if not Class.Stopped and RigHumanoid.Health > 0 then
						if K0 then
							Yield(K1.Time - K0.Time)
						end
						task.spawn(function()
							for _, Pose in ipairs(K1:GetDescendants()) do
								if Joints[Pose.Name] then
									local Duration = K2 and (K2.Time - K1.Time) / Class.Speed or 0.5
									Edit(Joints[Pose.Name], AnimDefaults[Pose.Name] * Pose.CFrame, Duration, Pose.EasingStyle, Pose.EasingDirection, Blend)
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
			until not Class.Looped or Class.Stopped or RigHumanoid.Health == 0
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

-- booleans + values
local Idle, Walking, Running, Enraged = false, false, false, false
local Debounce, Shift, CanHitbox = false, false, false
local MeleeHit = false
local HitboxConnection

-- character setup
local Player = Players.LocalPlayer
local Character = Empyrean.Rig
local Head = Character:WaitForChild("Head")
local Torso = Character:WaitForChild("Torso")
local LeftArm, RightArm = Character:WaitForChild("Left Arm"), Character:WaitForChild("Right Arm")
local LeftLeg, RightLeg = Character:WaitForChild("Left Leg"), Character:WaitForChild("Right Leg")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid")
pcall(function()
	Character:FindFirstChild("Animate"):Destroy()
	Humanoid:FindFirstChild("Animator"):Destroy()
end)
-- player functions
local function SetWalkSpeed(Speed) Humanoid.WalkSpeed = Speed end
local function SetRootPartAnchor(Bool) RootPart.Anchored = Bool end

-- effects setup
local Animations = script:WaitForChild("Animations")
local Camera = workspace.CurrentCamera
local Tween = TweenService:Create(Camera, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {FieldOfView = 80})
Tween:Play()
function PlaySound(Audio)
	local Sound = Instance.new("Sound", RootPart)
	Sound.SoundId = "rbxassetid://" .. Audio
	Sound.PlayOnRemove = true
	Sound:Destroy()
end
local Dummy = Players:CreateHumanoidModelFromDescription(game.Players:GetHumanoidDescriptionFromUserId(Player.UserId), Enum.HumanoidRigType.R6)
Dummy:WaitForChild("HumanoidRootPart").Anchored = true
Dummy.Parent = nil
for i, v in pairs(Dummy:GetDescendants()) do
	if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
		v.Color = Color3.fromRGB(255, 255, 255)
		v.Transparency = 1
	end
	if v:IsA("Decal") or v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("CharacterMesh") then
		v:Destroy()
	end
end

local Objects = script:WaitForChild("Objects")
pcall(function() -- so frickin tuff
Objects:WaitForChild("Number"):Clone().Parent = RightArm
Objects:WaitForChild("Number"):Clone().Parent = Head
Objects:WaitForChild("Aura").Parent = Torso
Objects:WaitForChild("Aura").Parent = Torso
Objects:WaitForChild("SpecsOrbs5").Parent = Torso
Objects:WaitForChild("SpecsOrbs").Parent = Torso
end)

local ReanimateDummy = Character:WaitForChild("Reanimate_Dummy")
local DummyWeld = Instance.new("Weld")
DummyWeld.Parent = RootPart
DummyWeld.Part0 = RootPart
DummyWeld.Part1 = ReanimateDummy
DummyWeld.C0 = CFrame.new(0, -15, 0)

local FlashHitHighlight = function(Target)
	if not Target or not Target:IsA("Model") then return end
	if Target:FindFirstChild("HitHighlight") then return end 
	local Highlight = Instance.new("Highlight")
	Highlight.Name = "HitHighlight"
	Highlight.Adornee = Target
	Highlight.FillColor = Color3.fromRGB(255, 60, 60)
	Highlight.OutlineColor = Color3.fromRGB(145, 0, 0)
	Highlight.FillTransparency = 1
	Highlight.OutlineTransparency = 1
	Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	Highlight.Parent = Target
	local FlashIn = TweenService:Create(Highlight, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {FillTransparency = 0.3, OutlineTransparency = 0})
	local FadeOut = TweenService:Create(Highlight,TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.In),{FillTransparency = 1,OutlineTransparency = 1})
	FlashIn:Play()
	FlashIn.Completed:Once(function() FadeOut:Play() end)
	FadeOut.Completed:Once(function() Highlight:Destroy() end)
end

local EnableHitbox = function()
	if HitboxConnection then
		HitboxConnection:Disconnect()
		HitboxConnection = nil
	end
	HitboxConnection = LeftArm.Touched:Connect(function(Hit)
		if not CanHitbox then return end
		if Hit:IsDescendantOf(Character) then return end
		local Target = Hit:FindFirstAncestorOfClass("Model")
		local TargetHumanoid = Target and Target:FindFirstChildOfClass("Humanoid")
		if TargetHumanoid then
			PlaySound(3417831369)
			Empyrean.Fling(Target, DefaultFlingOptions)
			FlashHitHighlight(Target)
			HitboxConnection:Disconnect()
			HitboxConnection = nil
		end
	end)
end

-- animator
local PlayAnim = function(Rig, Animation, AnimSpeed)
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

local StopAnim = function(Rig, Anim)
	if not AnimatorModule[Rig] then
		AnimatorModule[Rig] = {}
	end
	if not AnimatorModule[Rig][Anim.Name] then
		AnimatorModule[Rig][Anim.Name] = AnimatorModule:LoadAnimation(Rig, Anim)
	end
	AnimatorModule[Rig][Anim.Name]:Stop()
end

-- Extra functions
local RestoreMovement = function()
	if RootPart.Velocity.Magnitude < 1 and workspace:FindPartOnRay(Ray.new(RootPart.Position, (CFrame.new(RootPart.Position, RootPart.Position + Vector3.new(0, -1, 0))).LookVector * 4), Character) then
		Idle = true
		Walking = false
		Running = false
 	    PlayAnim(Character, Animations.Idle, 1)
 	elseif RootPart.Velocity.Magnitude > 1 and workspace:FindPartOnRay(Ray.new(RootPart.Position, (CFrame.new(RootPart.Position, RootPart.Position + Vector3.new(0, -1, 0))).LookVector * 4), Character) then
		Idle = false
		Walking = true
		Running = false
 		PlayAnim(Character, Animations.Walk, 1)
 	end
end

-- attacks
local Slash = function()
	if Debounce then return end
	local SwingEvent
	Debounce = true
	local SwingAnimation = PlayAnim(Character, Animations.Slash, 1)
	SwingEvent = SwingAnimation.KeyframeReached:Connect(function(Keyframe)
		if Keyframe == "Swing" then
			CanHitbox = true
			EnableHitbox()
			PlaySound(137628815514180)
			task.delay(0.25, function() CanHitbox = false end)
			if SwingEvent then
				SwingEvent:Disconnect()
				SwingEvent = nil
			end
		end
	end)
	SwingAnimation.Completed:Wait()
	Debounce = false
 	RestoreMovement()
end

local Corrupt_Energy = function()
	if Debounce then return end
	local HitHumanoids = {} 
	local SpikesEvent
	Debounce = true
	SetWalkSpeed(0.15)
	local SpikesAnimation = PlayAnim(Character, Animations["Corrupt Energy"], 1)
	PlaySound(119224961688213)
	SpikesEvent = SpikesAnimation.KeyframeReached:Connect(function(Keyframe)
		if Keyframe == "Start" then
			PlaySound(137628815514180)
			local StartPosition = RootPart.Position + Vector3.new(0, -3, 0)
			task.spawn(function()
				for i = 1, 27 do
				task.wait(0.1)
				local Spike = Objects:WaitForChild("Spike"):Clone()
                table.insert(TrashBin, Spike)
					Spike.Anchored = true
			  		PlaySound(104633111379428)
			    	local FrontOffset = RootPart.CFrame.LookVector * (i * 7)
		       		local RightVector = RootPart.CFrame.RightVector
			    	local SideOffset = RightVector * math.random(-2*100, 2*100) / 100
					local TargetPosition = StartPosition + FrontOffset + SideOffset
					local RayOrigin = TargetPosition + Vector3.new(0, 10, 0)
					local RayDirection = Vector3.new(0, -50, 0)
					local RaycastParams = RaycastParams.new()
					RaycastParams.FilterType = Enum.RaycastFilterType.Blacklist
					RaycastParams.FilterDescendantsInstances = { Character }
					local RaycastResult = workspace:Raycast(RayOrigin, RayDirection, RaycastParams)
					if RaycastResult then
						local GroundPosition = RaycastResult.Position + Vector3.new(0, 5, 0)
						Spike.Parent = workspace
						local SpikeTween = TweenService:Create(Spike, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Position = GroundPosition})
						SpikeTween:Play()
					end
					Spike.Position = TargetPosition
					Spike.Parent = workspace
 				    local OverlapParameters = OverlapParams.new()
			    	OverlapParameters.FilterType = Enum.RaycastFilterType.Blacklist
			      	OverlapParameters.FilterDescendantsInstances = { Character }
					local GetOverlappingParts = workspace:GetPartsInPart(Spike, OverlapParameters)
			     	for i, v in ipairs(GetOverlappingParts) do
					local Target = v:FindFirstAncestorOfClass("Model")
					if Target and not HitHumanoids[Target] then
						HitHumanoids[Target] = true
						local TargetHumanoid = Target:FindFirstChildOfClass("Humanoid")
						local EnemyRoot = Target:FindFirstChild("HumanoidRootPart")
						if TargetHumanoid and Target ~= Character then
                         Empyrean.Fling(Target, DefaultFlingOptions)    
                         if EnemyRoot then
							FlashHitHighlight(Target)
 							end
						end
					end
				end
				task.delay(14, function()
					PlaySound(121670325864544)
					local SpikeTween = TweenService:Create(Spike, TweenInfo.new(0.25, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {Position = Spike.Position + Vector3.new(0, -10, 0)})
					SpikeTween:Play()
					task.wait(0.25)
					Spike:Destroy()
 			    	end)
				end
			end)
 			if SpikesEvent then
				SpikesEvent:Disconnect()
				SpikesEvent = nil
			end
		end
	end)
	SpikesAnimation.Completed:Wait()
	Debounce = false
	RestoreMovement()
end

local Digital_Footprint = function() -- ts was so rushed so mb if its a little unoptimized, i used .Touched before but this felt more accurate
    if Debounce then return end
    local StompEvent
    Debounce = true
    SetWalkSpeed(0.25)
    local StompAnimation = PlayAnim(Character, Animations["Digital Footprint"], 1)
    PlaySound(72657841732583)
    StompEvent = StompAnimation.KeyframeReached:Connect(function(Keyframe)
            if Keyframe == "FinalStomp" then
                local RootPartRaycast = Ray.new(RootPart.Position, (CFrame.new(RootPart.Position, RootPart.Position + Vector3.new(0, -1, 0))).LookVector)
                local HitGround, HitPosition, HitNormal = workspace:FindPartOnRay(RootPartRaycast, Character)
                local Puddle = Objects:WaitForChild("Puddle"):Clone()
                table.insert(TrashBin, Puddle)
                Puddle.Anchored = true
                Puddle.CanTouch = true
                Puddle.CanCollide = false
                Puddle.CFrame = CFrame.new(HitPosition + (RootPart.CFrame.LookVector * 2) + Vector3.new(0, -1.845, 0)) * CFrame.Angles(0, 0, math.rad(90))
                Puddle.Size = Vector3.new(0.1, 0.1, 0.1)
                Puddle.Parent = workspace
                local PuddleTween = TweenService:Create(Puddle, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = Vector3.new(4.25, 4.25, 4.25)})
                PuddleTween:Play()
                PuddleTween.Completed:Wait()
                for i, v in ipairs(Puddle:GetDescendants()) do
                    if v:IsA("ParticleEmitter") then
                        v.Enabled = true
                    end
                end
                local Sound = Instance.new("Sound", Puddle)
                Sound.SoundId = "rbxassetid://83669531948820"
                Sound.Volume = 0.5
                Sound.Looped = true
                Sound:Play()
                local OverlapParams = OverlapParams.new()
                OverlapParams.FilterType = Enum.RaycastFilterType.Blacklist
                OverlapParams.FilterDescendantsInstances = {Character}
                task.spawn(function()
                        while Puddle and Puddle.Parent do
                            local Parts = workspace:GetPartsInPart(Puddle, OverlapParams)
                            for i, Hit in ipairs(Parts) do
                                local Target = Hit:FindFirstAncestorOfClass("Model")
                                local TargetHumanoid = Target and Target:FindFirstChildOfClass("Humanoid")
                                if TargetHumanoid and Target ~= Character then
                                    if not Hit:IsDescendantOf(Character) then
                                        local Target = Hit:FindFirstAncestorOfClass("Model")
                                        local TargetHumanoid = Target and Target:FindFirstChildOfClass("Humanoid")
                                        if TargetHumanoid then
                                            FlashHitHighlight(Target)
                                            for i, v in ipairs(Puddle:GetDescendants()) do
                                                if v:IsA("ParticleEmitter") then
                                                    v.Enabled = false
                                                end
                                            end
                                            task.delay(2, function()
                                                Empyrean.Fling(Target, DefaultFlingOptions)
                                                PuddleTween = TweenService:Create(Puddle, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {Size = Vector3.new(0, 0, 0)})
                                                PuddleTween:Play()
                                                Sound:Stop()
                                                task.wait(0.25)
                                                Puddle:Destroy()
                                             end)
                                        end
                                    end
                                    return
                                end
                            end
                            task.wait(0.1)
                        end
                    end)
                if StompEvent then
                    StompEvent:Disconnect()
                    StompEvent = nil
                end
            end
        end)
    StompAnimation.Completed:Wait()
    Debounce = false
    RestoreMovement()
end

-- ctrl c, ctrl v LOL
local Screamer_Kill = function()
	if Debounce then return end
	Debounce = true
  	SetRootPartAnchor(true)
 	local NPC = Dummy:Clone()
	NPC.Parent = workspace
    local NPCHead = NPC:WaitForChild("Head")
	local NPCRoot = NPC:WaitForChild("HumanoidRootPart")
	local NPCTorso = NPC:WaitForChild("Torso")
	DummyWeld.Part0 = NPCTorso
    DummyWeld.Part1 = ReanimateDummy
    DummyWeld.C0 = CFrame.new(0, 0, 0)
    NPCRoot.CFrame = CFrame.lookAt(RootPart.Position + (RootPart.CFrame.LookVector * -2.5), RootPart.Position) * CFrame.new(0, 0, -1.5)
	local KillerExecutionAnimation = PlayAnim(Character, KillAnimations.KillerExecution_Screamer, 1)
 	local VictimExecutionAnimation = PlayAnim(NPC, KillAnimations.VictimExecution_Screamer, 1)
    VictimExecutionAnimation.Completed:Wait()
    NPCRoot.Anchored = false
    NPCHead:Destroy()
	KillerExecutionAnimation.Completed:Wait()
	DummyWeld.Part0 = RootPart
    DummyWeld.Part1 = ReanimateDummy
    DummyWeld.C0 = CFrame.new(0, -15, 0)
    NPC:Destroy()
	SetRootPartAnchor(false)
 	Debounce = false
	RestoreMovement()
end

local Milestone4_Kill = function()
	if Debounce then return end
	Debounce = true
  	SetRootPartAnchor(true)
 	local NPC = Dummy:Clone()
	NPC.Parent = workspace
    local NPCHead = NPC:WaitForChild("Head")
	local NPCRoot = NPC:WaitForChild("HumanoidRootPart")
	local NPCTorso = NPC:WaitForChild("Torso")
	DummyWeld.Part0 = NPCTorso
    DummyWeld.Part1 = ReanimateDummy
    DummyWeld.C0 = CFrame.new(0, 0, 0)
    NPCRoot.CFrame = CFrame.lookAt(RootPart.Position + (RootPart.CFrame.LookVector * 2.5), RootPart.Position) * CFrame.new(0, 0, 1)
	local KillerExecutionAnimation = PlayAnim(Character, KillAnimations.KillerExecution_Milestone4, 1)
 	local VictimExecutionAnimation = PlayAnim(NPC, KillAnimations.VictimExecution_Milestone4, 1)
    VictimExecutionAnimation.Completed:Wait()
    NPCRoot.Anchored = false
    NPCHead:Destroy()
	KillerExecutionAnimation.Completed:Wait()
    DummyWeld.Part0 = RootPart
    DummyWeld.Part1 = ReanimateDummy
    DummyWeld.C0 = CFrame.new(0, -15, 0)
	NPC:Destroy()
	SetRootPartAnchor(false)
 	Debounce = false
	RestoreMovement()
end

local Milestone4Legacy_Kill = function()
	if Debounce then return end
	Debounce = true
  	SetRootPartAnchor(true)
 	local NPC = Dummy:Clone()
	NPC.Parent = workspace
    local NPCHead = NPC:WaitForChild("Head")
	local NPCRoot = NPC:WaitForChild("HumanoidRootPart")
	local NPCTorso = NPC:WaitForChild("Torso")
    DummyWeld.Part0 = NPCTorso
    DummyWeld.Part1 = ReanimateDummy
    DummyWeld.C0 = CFrame.new(0, 0, 0)
	NPCRoot.CFrame = CFrame.lookAt(RootPart.Position + (RootPart.CFrame.LookVector * -2.5), RootPart.Position) * CFrame.new(0, 0, -1.5)
	local KillerExecutionAnimation = PlayAnim(Character, KillAnimations.KillerExecution_Milestone4Legacy, 1)
 	local VictimExecutionAnimation = PlayAnim(NPC, KillAnimations.VictimExecution_Milestone4Legacy, 1)
    VictimExecutionAnimation.Completed:Wait()
    DummyWeld.Part0 = RootPart
    DummyWeld.Part1 = ReanimateDummy
    DummyWeld.C0 = CFrame.new(0, -15, 0)
    NPCRoot.Anchored = false
    NPCHead:Destroy()
	KillerExecutionAnimation.Completed:Wait()
	NPC:Destroy()
	SetRootPartAnchor(false)
 	Debounce = false
	RestoreMovement()
end

local Default_Kill = function()
	if Debounce then return end
	Debounce = true
  	SetRootPartAnchor(true)
 	local NPC = Dummy:Clone()
	NPC.Parent = workspace
    local NPCHead = NPC:WaitForChild("Head")
	local NPCRoot = NPC:WaitForChild("HumanoidRootPart")
	local NPCTorso = NPC:WaitForChild("Torso")
    DummyWeld.Part0 = NPCTorso
    DummyWeld.Part1 = ReanimateDummy
    DummyWeld.C0 = CFrame.new(0, 0, 0)
	NPCRoot.CFrame = CFrame.lookAt(RootPart.Position + (RootPart.CFrame.LookVector * 2.5), RootPart.Position) * CFrame.new(0, 0, 1)
	local KillerExecutionAnimation = PlayAnim(Character, KillAnimations.KillerExecution_Default, 1)
 	local VictimExecutionAnimation = PlayAnim(NPC, KillAnimations.VictimExecution_Default, 1)
    VictimExecutionAnimation.Completed:Wait()
    NPCRoot.Anchored = false
    NPCHead:Destroy()
	KillerExecutionAnimation.Completed:Wait()
    DummyWeld.Part0 = RootPart
    DummyWeld.Part1 = ReanimateDummy
    DummyWeld.C0 = CFrame.new(0, -15, 0)
	NPC:Destroy()
	SetRootPartAnchor(false)
 	Debounce = false
	RestoreMovement()
end

-- keybinds
local ShitlockController = Player.PlayerScripts:WaitForChild("PlayerModule"):WaitForChild("CameraModule"):WaitForChild("MouseLockController")
ShitlockController:FindFirstChild("BoundKeys").Value = "LeftControl, RightControl"
local KeyDown = UserInputService.InputBegan:Connect(function(Key, GPE)
	if GPE then return end
	if Key.UserInputType == Enum.UserInputType.MouseButton1 then
		Slash()
	end
	if Key.KeyCode == Enum.KeyCode.Q then
		Digital_Footprint()
	end
	if Key.KeyCode == Enum.KeyCode.E then
		Corrupt_Energy()
	end
    if Key.KeyCode == Enum.KeyCode.Z then
       Default_Kill()
    end
    if Key.KeyCode == Enum.KeyCode.C then
       Milestone4_Kill()
    end
    if Key.KeyCode == Enum.KeyCode.X then
       Milestone4Legacy_Kill()
    end
    if Key.KeyCode == Enum.KeyCode.V then
       Screamer_Kill()
    end
	if Key.KeyCode == Enum.KeyCode.LeftShift or Key.KeyCode == Enum.KeyCode.RightShift then
		if Debounce then return end
		Shift = true
		local Tween = TweenService:Create(Camera, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {FieldOfView = 90})	
		Tween:Play()
	end
end)

local KeyUp = UserInputService.InputEnded:Connect(function(Key)
	if Key.KeyCode == Enum.KeyCode.LeftShift or Key.KeyCode == Enum.KeyCode.RightShift then
		Shift = false
		local Tween = TweenService:Create(Camera, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {FieldOfView = 80})
		Tween:Play()
	end
end)

-- animations
local RunServiceEvent = RunService.Heartbeat:Connect(function(dt)
	Humanoid.CameraOffset = Humanoid.CameraOffset:Lerp((RootPart.CFrame * CFrame.new(0, 1.5, 0)):PointToObjectSpace(Head.Position), math.clamp(8 * 60 * 60, 0, 1))
	if Debounce then
		StopAnim(Character,Animations.Idle)
		StopAnim(Character,Animations.Walk)
		StopAnim(Character,Animations.Sprint)
	end
	if not Debounce then
		if Shift then
			SetWalkSpeed(27.25)
		else
			SetWalkSpeed(9)
		end
	end
	local HitFloor, HitPosition = workspace:FindPartOnRay(Ray.new(RootPart.Position, (CFrame.new(RootPart.Position, RootPart.Position + Vector3.new(0, -1, 0))).LookVector * 4), Character)
	local TorsoVelocity = (RootPart.Velocity).Magnitude
	local TorsoVerticalVelocity = RootPart.Velocity.Y
	if TorsoVelocity < 1 and HitFloor ~= nil and Debounce == false then
		if Idle == false then
			Idle = true
			PlayAnim(Character,Animations.Idle, 1)
		end
		Walking = false
		Running = false
		StopAnim(Character,Animations.Sprint)
		StopAnim(Character,Animations.Walk)
	elseif TorsoVelocity > 1 and HitFloor ~= nil and Debounce == false and Shift == true then
		if Running == false then
			Running = true
			PlayAnim(Character,Animations.Sprint, 1)
		end
		Idle = false
		Walking = false
		StopAnim(Character,Animations.Walk)
		StopAnim(Character,Animations.Idle)
	elseif TorsoVelocity > 1 and HitFloor ~= nil and Debounce == false then
		if Walking == false then
			Walking = true
			PlayAnim(Character, Animations.Walk, 1)
		end
		Idle = false
		Running = false
		StopAnim(Character,Animations.Sprint)
		StopAnim(Character,Animations.Idle)
	end
end)

local GUI = script:WaitForChild("UIs").MobileUI
GUI.Parent = game:GetService("CoreGui")

local UpdateUI = function()
	local LastInput = UserInputService:GetLastInputType()
	if LastInput == Enum.UserInputType.Touch
	then GUI.Enabled = true
	else GUI.Enabled = false
	end
end
UpdateUI()
UserInputService.LastInputTypeChanged:Connect(UpdateUI)

GUI.AbilitiesUI["Slash"].MouseButton1Down:connect(function() Slash() end)
GUI.AbilitiesUI["Corrupt Energy"].MouseButton1Down:connect(function() Corrupt_Energy() end)
GUI.AbilitiesUI["Digital Footprint"].MouseButton1Down:connect(function() Digital_Footprint() end)
GUI.AbilitiesUI["Sprint"].MouseButton1Down:connect(function() Shift = not Shift end)

Empyrean.BindableEvent.Event:Once(function()
  print("Resetting.")
    for i, v in TrashBin do
        v:Destroy()
    end
 	RunServiceEvent:Disconnect()
	KeyDown:Disconnect()
	KeyUp:Disconnect()
end)
