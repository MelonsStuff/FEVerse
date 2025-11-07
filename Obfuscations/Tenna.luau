local Reanimate_Settings = {
	Frequency = 6, -- this is basically how fast the oscillation goes
	Amplification = 6, -- this is how far the oscillation goes
	FrontOffset = 2.5, -- this is how much youre in front of the player during prediction
}

local ReanimateSpamton

if not isfolder("FEVerse") then makefolder("FEVerse") end
if not isfolder("FEVerse/RBXMXFiles") then makefolder("FEVerse/RBXMXFiles") end
if not isfolder("FEVerse/Songs") then makefolder("FEVerse/Songs") end

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

			ReanimateSpamton = CreateObject("Reanimate_Spamton")

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
				ReanimateSpamton.Anchored   = false
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
		-- Lightning Cannon
		{ Name = "Torso", MeshId = "131018666998514",  TextureId = "114854030584735", Offset = CFrame.identity },
		{ Name = "Right Arm", MeshId = "74241169361466", TextureId = "103596506136222", Offset = CFrame.Angles(Rad(90), 0, 0) },
		{ Name = "Left Arm", MeshId = "103399434286698", TextureId = "71393000026580", Offset = CFrame.Angles(Rad(90), 0, 0) },
		{ Name = "Right Leg",MeshId = "80852136456671",  TextureId = "114854030584735", Offset = CFrame.Angles(Rad(90), 0, Rad(180))},
		{ Name = "Left Leg", MeshId = "80852136456671", TextureId = "114854030584735", Offset = CFrame.Angles(Rad(90), 0, Rad(180)) },
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
		-- Devesto Cube
		{ Name = "Reanimate_Spamton",  MeshId = "93839976189892", TextureId = "87530318962700", Offset = CFrame.identity },
    -- Angel Spamton
		{ Name = "Reanimate_Spamton",  MeshId = "121479536198148", TextureId = "135498376757550", Offset = CFrame.Angles(0, Rad(180), 0)},

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
return(function(...)local v={"\080\051\053\114\067\068\104\081\097\110\087\070";"\113\085\119\099\071\113\054\097\118\077\065\061";"\073\065\098\099\120\100\055\054\098\054\089\073\104\111\122\061","\112\083\078\084\078\121\057\083\086\082\053\053\068\075\081\085";"\071\101\051\074\085\112\113\105\119\052\075\120\057\065\102\052\066\071\108\081\051\121\067\078\116\117\068\071\107\053\111\106\103\076\050\122\082\101\081\114\086\075\109\107\078\047\107\108\104\098\088\081\104\103\122\116\122\043\069\117\099\056\056\055\085\111\056\052\082\056\121\056\121\054\070\089\105\069\085\074\087\080\108\076\116\070\052\047\082\052\075\081\115\075\057\118\081\110\069\111\068\090\101\079\099\112\109\107\110\072\090\117\090\090\090\070";"\080\102\057\117\098\121\082\061","\088\099\055\118\114\087\100\050\076\084\050\108\114\087\113\110";"\122\051\111\100\079\052\061\061","\070\067\108\119\116\065\061\061","\078\119\100\083";"\117\076\057\112\071\052\061\061","\108\112\108\078\098\043\119\098\102\075\100\113";"\119\120\080\107\121\108\051\068\102\109\052\061","\074\108\107\071\104\057\111\090\115\070\050\119\114\101\104\119\081\122\061\061";"\104\110\118\069\099\075\117\114\066\099\089\114\072\070\086\107\105\114\121\089\098\112\053\086\102\089\067\120\073\121\115\078\090\067\117\116\048\068\067\099\088\085\103\104","\072\078\080\119\073\113\104\108\121\065\061\061";"\043\103\069\076\054\083\114\101\043\098\110\061";"\100\066\090\078";"\111\112\118\118\122\120\084\113\065\079\071\105\087\084\052\061","\117\076\100\109","\051\109\076\067\111\052\115\119";"\083\105\090\122\090\099\069\071\078\052\061\061","\051\088\071\109","\080\114\080\088\120\053\098\098\114\073\114\061";"\121\102\122\051\099\065\055\107\070\071\075\070\043\073\116\119","\115\085\104\050\069\108\079\108\076\111\088\071\086\108\085\054","\105\082\072\117";"\114\111\066\115\065\074\098\100\118\082\073\072\115\098\077\103\118\073\071\043\084\077\050\107\122\120\068\083";"\067\078\074\078\111\085\107\090\086\079\102\110\111\087\055\107\074\054\053\061","\056\052\049\112";"\080\099\088\053\076\057\088\050\115\080\061\061","\114\051\085\070\080\083\104\090\076\111\111\071\081\054\113\068\102\080\061\061","\099\099\098\053\102\053\088\076\114\051\110\110\104\053\050\052\067\122\061\061","\103\088\067\086\057\047\100\066\079\053\108\079\080\108\067\056\101\122\061\061","\078\052\043\102\090\080\061\061";"\086\067\117\113\054\100\121\047\048\106\110\061","\117\083\105\065";"\108\057\077\048\052\047\043\057\083\085\080\061";"\102\070\088\081\074\050\118\087\104\053\119\077\086\050\118\057","\077\087\116\108\105\086\071\098\085\065\061\061","\081\084\054\101\070\118\108\108\069\066\053\120\067\080\061\061";"\074\108\050\084\089\053\114\097\081\083\098\081\111\054\100\111\117\065\061\061";"\050\074\050\115\055\108\119\067\054\076\054\061";"\109\078\047\043\057\082\110\061";"\082\071\076\118\067\075\116\073\053\101\119\098\090\098\101\110\053\109\110\081","\086\109\104\083\114\065\061\061";"\104\099\081\065\089\115\057\068\113\071\050\047","\121\090\087\101\087\110\114\061","\122\048\104\104\085\055\080\101\073\051\053\061";"\055\072\100\121\097\122\061\061";"\070\111\052\108\086\065\061\061","\106\080\112\066";"\084\069\113\078\051\111\065\061";"\076\099\050\072\080\081\077\067\117\111\111\106\074\057\104\108";"\087\076\100\116\068\080\061\061","\065\109\081\112\107\084\100\055\066\108\121\113\102\081\113\051\119\114\053\081","\054\078\085\116\067\085\079\051\080\083\077\088\088\087\083\109";"\068\068\108\079\051\106\043\122\065\048\106\074\085\043\051\055\080\065\056\086\077\055\116\110\080\082\086\103\115\112\108\061";"\085\070\090\118\103\065\061\061";"\055\075\115\082\066\099\118\084\085\112\101\117\056\119\049\120\075\056\121\061","\047\078\081\105","\073\113\057\074\098\050\065\116\087\086\083\111\112\043\116\097\107\051\053\081","\116\101\110\071\074\120\087\122\104\049\114\081";"\074\087\105\097\052\103\106\065\098\080\061\061","\084\057\113\066\090\090\110\061","\102\115\067\065\097\100\110\079";"\108\043\068\104\119\080\051\079\105\090\056\061","\122\118\052\110\100\119\071\107","\069\109\088\043\117\099\055\072","\071\078\081\106\110\097\104\105\088\109\120\088\110\065\077\077";"\073\087\112\074\120\066\079\055\114\111\121\083\120\086\085\121\119\078\072\050\048\080\061\061","\088\084\111\097\074\070\098\068\089\080\061\061";"\110\079\119\084\070\076\117\069\073\122\061\061";"\088\051\111\108\081\051\098\048\086\099\104\108\069\052\061\061";"\068\043\118\078\050\114\066\075\099\065\109\068\119\083\080\101\098\068\090\053\070\080\061\061";"\090\054\072\071\087\047\056\061","\073\122\069\047";"\069\101\111\106\104\085\047\043\054\109\086\070\114\099\069\110\102\050\102\061";"\118\102\102\121\103\049\049\082\075\049\114\120\074\052\061\061","\114\104\100\104\112\097\065\116\077\081\098\085\081\111\090\114\049\115\055\055\097\113\054\097\055\102\083\117\047\065\061\061","\088\084\120\117\070\069\066\112\080\065\052\105\098\081\106\116\056\090\069\061","\099\068\049\079\112\068\080\073\043\080\061\061";"\079\104\067\085\117\065\049\080\111\069\075\081";"\101\120\077\080\112\105\089\106\077\083\118\089\115\043\116\105\088\119\053\061","\084\077\088\108\090\110\073\085\106\102\117\102\097\067\120\077\107\043\115\113\122\122\061\061","\057\083\113\107\115\087\088\050\089\122\061\061";"\098\067\070\099\070\052\061\061","\076\079\082\097\076\108\086\057\069\108\111\084\074\101\111\111","\076\100\071\112\112\055\087\057\080\121\090\108\052\117\056\105\056\117\049\048\116\116\107\108\110\119\052\061","\078\108\068\118\066\069\051\074\101\121\102\061","\079\066\079\056\122\090\072\089\072\080\061\061","\083\088\081\108\121\056\067\110\072\119\057\050\070\098\089\116\115\107\043\074\080\052\061\061","\048\053\100\084","\120\052\102\061";"\055\073\121\084\057\101\085\120\087\107\076\083\114\089\110\061";"\071\047\069\074\057\116\117\051\086\078\069\074";"\088\069\072\073\070\110\080\109\057\117\074\068\068\050\117\047\084\103\097\117\102\102\120\113\119\097\085\071\049\065\061\061","\053\070\115\087\057\105\106\068\077\052\061\061","\087\073\104\118";"\088\052\079\067\051\105\081\047\070\117\104\116\105\106\113\052\103\052\061\061";"\047\098\051\114\099\122\111\113\072\082\069\111\120\097\068\097\050\115\077\113\097\080\084\122\043\110\102\109\053\118\122\109\053\118\073\069\072\083\085\047\080\068\065\082\098\054\111\116\051\086\098\107\117\054\068\108\078\057\099\081\088\047\072\066\105\056\081\072\119\116\073\078\113\078\099\121\106\068\101\118\048\108\065\048\049\055\080\106\105\067\122\080\122\049\100\072\090\098\082\050\111\084\108\069\103\069\069\061";"\114\068\043\113","\090\078\067\087\119\049\113\103";"\081\084\111\043\069\122\061\061";"\109\114\070\107\055\072\072\120\112\118\081\052","\104\072\111\121\069\072\086\079\102\084\111\101\102\101\077\052\074\065\061\061","\109\122\121\069\086\118\049\104\101\116\117\072\057\080\061\061";"\104\089\048\074\115\122\061\061";"\103\121\087\116\114\107\053\061","\115\108\121\052\076\057\047\043\067\079\104\077\076\051\088\078\117\079\052\061","\084\114\075\098\100\052\061\061","\101\090\049\109\076\122\061\061";"\057\083\113\119\086\057\088\118\074\084\085\090\115\084\054\061";"\084\100\088\049\073\079\084\102\103\122\061\061";"\074\089\117\066\088\109\122\061","\065\105\072\087\113\078\065\077\090\090\122\061","\054\051\111\108\054\087\113\068\074\085\077\118\069\072\088\077\115\087\104\121\115\109\047\061";"\079\084\048\101\089\070\070\111\076\121\099\117\113\087\106\086\078\113\116\101\070\090\102\054\121\076\084\047\047\122\071\104\121\116\054\089\117\122\069\061";"\071\103\053\082\072\070\119\121\084\048\108\106\082\065\061\061","\081\108\052\110\074\050\086\076\069\079\074\107\054\072\065\043";"\066\051\071\080\078\088\120\109\073\079\086\104\109\099\068\114\102\099\119\106";"\102\053\113\097\088\054\085\090\069\050\080\083\076\081\088\068\115\051\047\061","\085\069\121\109","\072\051\082\089\073\072\052\104\071\122\047\061","\116\090\052\108\088\080\061\061","\115\054\113\112\050\117\117\076\077\043\043\112\043\049\105\057\081\111\079\061","\047\071\056\078";"\113\056\086\047\082\043\052\107\099\052\122\061";"\083\085\043\051\068\089\115\113\068\101\114\049\104\117\118\071\104\083\104\083\066\072\073\066\101\071\111\079\102\076\104\112\086\115\121\084\066\115\099\105\114\102\070\072","\114\115\105\087\113\112\055\077\074\069\066\047";"\048\111\069\048\122\083\050\078","\056\053\115\090","\086\055\069\052\114\049\069\052\066\121\056\105","\098\090\089\066\117\103\082\122\101\066\118\097\113\122\061\061","\065\122\070\089\104\073\101\081\090\107\107\090\065\104\103\122\084\115\080\047\107\079\084\090\053\052\111\054\054\122\061\061";"\098\078\110\073\069\049\082\087\053\100\114\061","\099\088\103\085\113\098\117\057\043\083\054\061","\119\054\077\071\101\073\088\074\122\052\061\061";"\099\111\122\109\081\078\088\085\111\084\107\078\089\079\088\108","\086\111\070\105\043\070\118\085\086\052\061\061";"\088\099\055\083\115\080\061\061";"\090\109\087\119\076\086\116\116\052\065\116\055\085\071\051\111","\049\086\057\117\067\086\083\072\089\079\110\101";"\090\115\084\071\121\122\049\066\120\105\103\089";"\122\043\098\056\089\067\056\114\054\122\061\061","\081\057\085\104\115\085\074\079\054\070\107\084\081\097\074\098\080\051\114\061";"\052\099\119\118\113\077\122\061";"\065\099\070\067\087\053\122\070";"\051\084\075\122\103\108\087\047\076\118\074\114\089\047\110\102","\111\049\081\069\081\106\053\080\048\089\079\047";"\107\107\050\122\090\080\056\102\101\100\102\090\103\101\110\061";"\109\081\078\081\084\097\067\102\118\065\061\061","\054\051\098\066\088\085\122\109\074\087\100\043\102\057\111\050\104\065\061\061","\088\078\104\086\099\052\061\061";"\111\087\111\101\074\084\113\043\102\065\061\061","\076\099\055\097\074\084\085\071\114\051\054\061";"\054\087\111\097\074\084\113\043\086\054\083\068\074\087\111\119\086\099\055\108","\099\101\050\072\104\050\107\097\076\051\113\056\081\053\118\097\076\111\122\061","\067\065\061\061","\068\043\043\087\108\090\075\089\051\122\061\061","\104\109\077\104\048\080\054\061";"\115\073\119\077";"\054\097\111\110\117\081\086\120\069\108\050\066\104\108\104\081\088\087\102\061","\086\084\119\099\102\097\122\043\074\101\088\054\076\109\050\083";"\083\043\082\101\117\047\118\083\117\122\061\061";"\048\088\052\106\114\122\061\061","\071\104\115\104\052\070\087\068","\075\087\106\102","\080\051\085\071\088\099\055\108\114\099\055\072\115\084\054\061";"\089\112\116\101\074\054\121\061","\102\108\114\078\085\078\047\061","\113\047\056\099\089\086\102\052","\113\116\102\049\098\080\061\061";"\075\088\083\052\118\047\085\065\088\043\069\061";"\080\108\086\043\114\099\083\050";"\076\108\085\080\076\108\100\051\054\072\107\111\117\054\119\102";"\082\106\087\065\110\054\057\110\078\048\048\102","\074\051\113\043\117\109\104\052\114\099\104\050";"\086\057\098\043\115\109\047\061";"\048\056\049\079\068\057\056\061";"\077\054\053\069\078\052\061\061";"\082\105\105\098\051\079\108\061","\120\065\061\061";"\102\050\100\070\065\054\052\061","\115\050\106\081","\084\049\110\076\083\078\101\068","\051\049\104\103";"\112\055\110\048\097\077\065\085","\074\051\098\109\102\053\107\076\111\084\107\106\115\108\055\114","\052\097\056\072\083\109\101\102\098\101\087\075\090\043\099\111\084\067\076\111\112\122\061\061","\070\097\116\080\086\107\075\101\065\104\079\087";"\099\099\067\107\067\117\079\061";"\074\104\104\048\056\074\069\050\112\080\061\061";"\103\104\070\067\075\105\111\053\069\070\071\074\050\043\072\101\111\098\101\121\065\069\079\061","\069\070\098\107\115\072\080\061";"\066\065\043\053\069\048\084\055\049\057\084\112\051\114\057\109\080\075\107\073\122\121\101\047\115\071\087\078\074\104\079\061";"\101\050\057\087","\106\118\118\088\068\077\081\083\065\099\116\053","\065\122\076\085\109\106\085\088","\116\080\061\061","\080\099\104\100\099\070\111\066\102\053\121\055\054\054\100\090";"\067\081\079\119","\072\105\079\066\047\087\114\076","\090\106\043\054\057\083\099\074\068\088\099\114\078\057\070\078\100\075\102\115\056\079\051\047\118\043\066\078\077\080\061\061","\053\070\121\086\122\115\085\084\107\085\118\098\087\122\061\061";"\114\079\051\108\108\112\076\117\057\109\056\061","\074\103\101\101\070\052\061\061","\121\120\113\122\069\098\068\087\053\069\108\116\049\118\114\078\065\122\061\061","\098\057\074\102","\069\098\057\101\122\122\061\061";"\116\089\088\083\083\118\098\083\067\071\049\105","\088\087\050\043\086\080\061\061";"\121\109\119\109\103\052\061\061","\066\113\089\100\101\122\061\061";"\076\084\048\053\065\122\067\105\112\090\122\097\051\117\082\048\075\112\104\116\079\070\122\061";"\070\088\108\111\106\068\104\116\120\084\102\061";"\098\117\068\087\122\117\098\117\073\055\097\069";"\053\079\088\068\077\073\115\104\055\065\071\090\065\052\061\061","\113\082\056\054";"\112\112\115\086","\109\101\097\120\048\089\118\085\103\075\052\086\117\122\061\061";"\111\070\074\050\086\099\055\098\115\087\086\068","\088\099\079\043\114\109\121\100\074\083\086\086\117\079\111\116\054\065\061\061","\114\051\113\071\114\051\085\108";"\049\051\054\114";"\102\100\067\080\057\073\102\082";"\088\087\050\071\086\079\086\107\069\072\104\108\080\051\118\107\115\084\080\061","\113\087\098\104\085\118\102\061";"\112\104\105\065\102\088\103\070\120\122\061\061","\082\097\119\117\079\065\061\061";"\120\052\090\048";"\122\108\077\115\049\111\071\051\082\072\075\118\081\067\114\061";"\049\101\047\061";"\106\088\076\097\104\122\061\061","\078\105\086\066\115\082\122\061","\074\109\098\107\074\084\111\087\117\099\100\050";"\066\067\113\067\075\098\052\086\090\065\061\061";"\054\051\111\108\080\051\113\043\086\080\061\061","\099\085\050\105\054\099\110\100\086\084\050\084\054\078\104\051","\103\071\115\079\083\076\112\112\072\050\121\068\097\109\073\049\051\099\108\061";"\072\113\067\080","\068\075\082\057\115\055\057\104\112\089\043\083\074\088\066\082\084\055\098\074\099\122\061\061","\074\111\085\109\088\053\052\083\111\084\107\083\067\078\098\076";"\111\052\098\110\070\069\073\117";"\112\089\113\077\073\052\061\061","\114\048\080\061","\079\084\048\069\074\114\101\052\074\109\082\061","\069\051\111\108\115\099\111\108\114\057\088\118\114\087\100\050","\088\087\050\071\086\079\086\107\069\072\104\108\080\051\118\107\115\084\088\112\086\053\104\056\114\057\104\097";"\117\057\104\087\117\099\100\050","\111\072\066\075\050\080\061\061","\050\065\090\121\115\057\071\086\073\109\050\083\119\106\056\090\077\119\110\052\074\080\061\061","\076\097\116\072\105\076\079\061";"\112\083\082\077\080\070\081\105\084\078\109\085\086\043\110\056\099\101\047\090\114\050\108\089\071\069\054\061","\065\114\120\087\081\070\047\049\054\081\113\057\108\101\054\049\047\056\073\115\070\055\043\067\083\052\061\061";"\056\118\087\052\055\087\114\089\083\087\069\049\050\121\043\083\116\122\086\122","\103\118\050\118\072\120\120\107\102\066\085\078","\116\101\070\098","\099\072\098\106\081\111\077\108\081\078\104\106\054\078\098\056\076\052\061\061";"\047\100\082\061";"\047\117\110\118\077\105\084\100\120\115\056\061","\116\114\078\051";"\117\053\086\068\117\072\104\112\117\079\104\116\117\051\100\055","\117\084\047\120\074\111\047\061";"\054\084\113\107\115\072\088\054\115\108\113\090\117\087\111\101\074\085\104\052\114\099\104\050","\069\051\111\108\086\072\077\097\114\051\085\052";"\072\105\087\080\077\049\054\072\102\122\061\061";"\079\111\112\056\076\122\061\061";"\075\074\112\106";"\078\065\061\061","\112\099\071\067\089\090\110\052\080\073\065\061";"\043\098\116\115","\088\101\111\087\076\081\086\097\089\072\118\057\081\053\104\055\069\078\114\061";"\086\112\081\085\110\071\118\119\109\071\069\122","\097\066\112\122","\053\102\084\076\108\080\061\061","\069\087\111\119\115\109\086\050";"\089\113\081\121\104\070\102\061","\098\075\087\083\047\082\110\061";"\050\113\054\099\082\090\057\090\073\112\087\051","\080\109\098\050\114\057\088\050","\079\070\083\057\120\099\056\055\076\072\090\066";"\099\055\084\047\086\056\052\061";"\080\051\100\068\115\087\054\061";"\111\077\110\082\053\104\069\061","\053\107\080\116\068\065\061\061";"\122\108\067\071\112\086\065\061","\114\052\049\069";"\043\055\104\099\100\122\061\061","\074\079\088\078\104\099\113\077\076\057\098\106\074\078\122\052";"\057\052\061\061","\110\111\114\061","\054\084\098\085\101\075\089\043\078\084\100\116\112\083\069\104\106\120\072\089\111\116\108\085\084\069\113\086\119\104\072\114\086\068\047\106\118\073\119\102";"\068\086\106\071\069\043\054\122\078\081\068\083\100\080\061\061";"\114\051\113\043\115\109\111\108\117\099\055\050","\098\117\047\077\067\119\048\078";"\101\110\077\089\115\103\088\098\054\052\061\061","\054\085\107\053\074\085\050\105\102\057\086\052\054\053\100\084","\077\088\087\079\098\105\065\061";"\110\111\101\108\057\079\067\065","\088\116\052\108\055\122\108\061","\119\119\122\079","\105\090\099\110\109\071\112\107","\115\080\061\061","\086\051\111\108\086\051\111\071\074\065\061\061";"\077\109\088\099\051\076\122\061";"\119\047\098\073\052\100\083\051\088\122\061\061","\113\052\061\061","\110\050\112\103\087\082\075\100\113\085\088\100\113\117\054\061";"\115\089\086\086";"\043\085\118\055\108\100\050\072\076\065\061\061";"\074\084\113\097\074\070\098\107\115\087\069\061","\097\108\121\087\078\080\061\061";"\069\101\104\080\076\054\053\052\067\054\118\048\086\070\050\109\086\101\122\061";"\121\116\070\115\116\048\048\047\101\090\104\099","\054\084\100\118\089\080\061\061","\067\119\086\073\086\082\115\075\049\070\122\061","\086\067\088\051\122\109\083\071\055\071\122\121","\080\051\113\056\115\109\098\081\086\057\085\083\086\099\055\101\086\054\119\050\089\057\077\068\117\099\055\108";"\086\051\083\118\074\084\104\121","\111\101\056\075\084\080\061\061","\067\065\113\117";"","\056\055\070\122\084\080\061\061","\113\118\043\048\089\098\079\061";"\106\076\068\055\072\108\048\103\050\071\116\082\103\122\061\061";"\088\051\111\108\081\099\113\083\069\051\054\061";"\072\072\110\070\077\114\074\084\101\052\061\061";"\081\090\055\122\066\121\048\098\049\054\122\054";"\048\087\085\121\120\068\075\050\101\071\112\100\065\068\081\057\050\110\113\111\081\104\098\067\121\103\057\102\089\121\121\112\110\106\073\072\118\119\100\087","\066\043\078\080\100\113\077\117\104\072\102\089\069\072\103\085\113\122\061\061";"\121\100\089\084";"\080\099\055\088\102\111\074\099\088\111\074\104\081\087\100\067";"\117\106\074\068\049\065\047\052\069\087\104\103\047\080\081\069\109\109\090\068","\072\102\056\061","\054\109\088\083\115\065\061\061","\111\054\088\107\115\081\047\061";"\047\071\072\073\075\076\119\110","\115\053\113\072\111\054\107\079\074\053\080\055\076\051\113\078\089\080\061\061";"\065\114\106\047\103\082\080\061";"\105\122\086\121\077\101\057\049\043\056\080\061","\108\105\049\051\112\122\061\061","\079\099\072\107\074\089\052\072\087\121\053\088";"\118\067\109\070\056\051\083\068\117\108\057\080\069\080\061\061";"\088\050\090\071";"\088\083\050\085\047\080\061\061","\085\077\085\077\076\080\061\061";"\106\075\121\051\106\105\080\068\066\115\089\089","\086\051\111\108\114\109\111\097\074\084\113\119\114\057\104\097\086\057\080\061","\112\077\073\071\065\052\061\061";"\114\072\077\081\074\099\083\057\111\051\108\097\081\070\107\085\088\122\061\061";"\090\098\071\068";"\049\078\055\098\107\115\086\071\122\080\061\061";"\102\050\077\120\117\108\086\117\067\078\074\067\054\108\111\057","\074\082\068\105\043\069\065\078\119\077\052\061";"\115\078\047\061","\054\057\120\051\086\072\055\071\109\084\056\061";"\074\070\077\053\104\083\104\116\089\070\111\080\069\109\085\080\114\051\065\061";"\120\070\101\071\050\116\090\081";"\084\115\109\055\054\112\048\098\118\048\088\121\086\047\073\116\073\070\110\104\104\052\061\061","\087\077\043\051\113\084\043\066\097\083\088\081\069\049\067\051\051\068\098\110\076\104\071\073\100\101\115\122\047\072\076\098\098\090\090\056\057\047\051\122\109\098\106\052\122\103\043\076\069\121\047\079\069\112\119\067\053\110\057\117\068\071\079\107\114\116\047\118\068\078\089\083\075\087\053\065\115\100\080\052\114\065\073\052\120\113\077\071\078\101\122\079\112\114\104\082\080\074\075\109\070\114\069\052\081\077\111\083\072\073\118\073\106\088\076\078\049\056\075\112\106\108\079\083\100\121\047\117\043\082\104\073\073\080\052\083\067\089\069\122\065\100\082\113\089\048\102\061";"\080\051\113\043\069\072\111\052\074\079\055\118\074\070\111\043\086\080\061\061","\114\108\043\103\109\097\119\119","\116\081\121\104\079\065\121\061","\114\085\090\051\070\081\103\103\101\122\061\061";"\050\085\115\101","\097\076\097\069\047\066\106\056\077\120\118\072\111\122\061\061";"\078\049\088\070\055\089\104\114\104\073\074\053","\078\048\116\080\114\088\099\110\099\121\083\100\110\118\114\061";"\114\105\074\102\051\120\081\086\119\078\104\086\117\053\054\061","\115\119\108\066\070\068\087\081\088\077\074\099";"\111\051\085\056\117\109\104\052\086\099\111\053\081\109\086\050\069\072\098\107\086\084\054\061";"\069\116\118\104\117\122\061\061";"\047\105\104\049";"\067\073\119\073\109\080\061\061";"\080\068\053\077\078\122\061\061";"\048\115\107\053\089\112\114\061";"\078\103\122\077\071\110\111\085\074\090\113\048\112\048\072\118\085\052\061\061";"\100\119\100\057\103\067\048\075\097\052\061\061","\066\054\054\061","\067\079\118\117\115\079\108\051\115\084\119\050\088\083\118\104\115\080\061\061","\106\053\115\079\121\122\114\110\081\076\081\077";"\109\075\056\121","\047\113\110\113\112\057\083\072\102\084\107\048\054\088\054\115\054\122\061\061";"\115\081\085\117\102\084\083\057\081\085\114\083\074\051\100\050";"\070\079\122\051\084\110\119\081\070\121\052\061";"\118\104\050\051\075\073\108\061";"\088\065\086\087\116\122\061\061","\109\073\075\111\108\103\102\061","\086\087\100\068\115\109\047\061";"\085\043\053\106\085\088\077\077\086\073\119\074\050\065\061\061";"\115\069\056\117\043\051\119\103\055\080\061\061","\112\121\068\119\114\110\056\043\116\071\068\088\106\097\048\115\055\056\052\052\098\065\061\061";"\073\071\083\098\055\122\067\065\109\122\106\117","\077\051\082\050\100\079\109\112\067\080\061\061";"\086\050\077\047\102\084\111\104\088\051\085\056\067\057\074\056","\079\079\072\084\065\089\069\061","\048\102\085\073\120\080\061\061";"\067\057\080\066\111\090\097\073\052\080\061\061";"\069\069\089\087\112\089\110\074\110\068\052\111\121\117\053\061","\078\048\122\088";"\088\084\111\087\114\057\111\056\074\079\086\056\117\099\055\072\081\109\077\108\117\099\113\071\069\052\061\061","\070\120\056\067\102\080\061\061","\070\078\120\116\101\107\108\061";"\122\097\115\069";"\086\057\048\105\121\086\071\077\051\066\084\083\082\055\120\100";"\052\055\106\043\050\047\118\119\110\084\053\061";"\108\103\066\076\079\052\061\061";"\081\077\065\077\057\118\070\067","\069\087\085\071\086\084\113\119";"\081\051\055\101\086\080\061\061";"\105\098\065\108\097\072\119\070\084\072\080\061","\072\048\056\074","\122\113\104\098\051\097\088\116\072\116\043\074\079\043\085\108\119\077\090\079\112\079\057\047\072\107\112\107";"\069\079\111\047\099\087\104\051\099\084\083\051\069\111\118\116","\052\075\047\066\080\090\102\061";"\066\048\081\074\109\099\086\107\102\107\108\061";"\115\088\097\068\101\086\070\047";"\088\065\116\108\113\070\078\103\089\111\103\071\121\103\077\098\070\080\061\061","\077\069\109\122\050\056\056\100\090\049\070\048\065\079\112\069\056\053\082\054\072\083\098\080\081\099\052\076\068\075\100\114\052\073\080\109\043\052\121\116\115\081\120\072","\073\119\100\080";"\069\114\098\100\068\120\065\061","\115\115\114\088\116\076\107\111\115\109\121\114\104\067\112\121\070\077\114\061","\084\111\107\052\067\074\089\082\100\103\101\069\098\052\061\061","\073\068\103\047","\116\068\049\100\068\112\112\088","\050\078\054\069";"\071\072\103\074\057\099\079\116\099\070\102\061";"\057\107\068\084\085\089\110\103\055\078\051\047\100\050\089\106\110\107\079\100\043\055\097\115\104\103\118\097\083\098\084\115\069\090\074\117\090\122\061\061";"\074\070\085\104\104\051\085\084\086\083\077\083\081\054\086\077";"\099\074\080\098\049\052\061\061";"\090\110\077\089";"\097\087\054\115\111\080\061\061";"\114\051\118\118\069\065\061\061";"\117\075\111\088\080\051\051\051\076\097\080\085\055\087\119\115\088\109\077\089","\081\084\113\118\086\079\085\071\117\099\083\118\074\084\050\068\115\065\061\061";"\107\055\088\097\080\111\075\120\083\052\061\061","\055\103\056\102\056\078\108\055\085\048\114\117\049\078\053\057\087\078\113\107","\056\088\069\111\087\049\110\103\097\052\061\061";"\070\084\075\118\086\066\049\082\085\071\085\053\089\071\083\089";"\068\069\075\076\083\067\114\061";"\097\071\109\068\043\107\101\053\100\052\061\061","\072\056\087\103\121\051\057\118","\056\066\090\112","\109\065\088\049\111\108\051\067\114\100\100\109\101\070\052\113","\074\081\054\061","\076\085\077\048\088\050\088\047\115\111\085\068\117\051\074\088","\104\119\051\078\116\080\050\076\090\075\104\071\105\065\061\061","\080\051\113\071\115\087\111\101\074\122\061\061","\113\110\071\106\047\100\076\116\086\052\061\061","\077\102\072\120\107\052\077\051","\080\067\089\112\056\070\097\088\089\107\102\076";"\115\043\066\112\117\110\099\078\118\074\101\069\076\066\102\078";"\114\087\105\050\079\109\098\089";"\088\051\111\108\076\051\111\055\086\072\098\118\115\099\111\097","\103\051\116\053";"\120\073\102\061";"\117\106\090\116\056\100\115\085\111\102\068\076\047\075\090\105","\070\082\069\098\104\102\081\097\085\110\121\061","\117\082\084\073\082\118\048\113\079\111\102\061","\087\055\110\101\056\054\049\074\111\065\061\061";"\080\120\086\118\076\114\054\049\080\047\089\102\057\072\108\061";"\047\087\106\122";"\066\102\083\102\080\056\053\078\043\122\061\061","\074\078\089\079\108\052\061\061","\068\121\084\073\117\087\085\098\122\052\061\061","\069\079\121\113\099\122\061\061","\083\110\106\049\098\105\078\083\085\114\109\118\087\097\052\116\116\080\061\061";"\081\065\077\116\074\087\122\061","\065\102\079\061";"\098\080\061\061";"\111\070\050\101\117\083\085\043\054\054\118\120\089\054\074\111","\101\072\111\120\086\108\053\061","\057\109\085\089\100\066\084\117\113\116\072\070\109\081\068\050\118\080\067\067\055\110\105\122\073\085\110\098\084\110\083\050\068\050\098\106\118\103\066\114\052\081\101\114\098\117\052\073\077\051\080\099\090\065\055\047\048\103\079\055\054\050\109\108\098\053\101\073\073\054\117\110\116\073\069\051\067\075\085\084\053\088\098\110\078\078\072\111\049\051\074\118\110\097\099\097\043\053\078\072\072\084\107\111\109\086\106\086\078\098\122\112\122\078\099\082\120\100\081\074\122\098\105\079\074\087\122\061";"\110\099\055\049\120\122\061\061","\077\112\118\122\083\052\071\089";"\075\117\066\066\087\069\071\103\104\080\061\061";"\084\122\109\043\105\121\105\068\098\118\077\079\088\054\112\084\052\087\043\098\086\122\061\061";"\072\043\067\080\105\073\074\111\047\052\069\061";"\088\070\086\101\115\070\086\071\117\057\085\112\054\081\077\077\081\070\069\061";"\080\051\113\056\115\109\047\097","\079\122\106\080\098\073\050\106\078\102\085\097\070\069\080\072\072\065\112\111","\111\084\085\119\069\084\111\043\047\079\088\050\074\084\111\101\074\084\111\053\047\080\061\061","\071\052\114\098";"\118\070\106\057\121\052\061\061";"\098\106\097\114\118\052\061\061";"\115\099\085\108\117\122\061\061","\098\074\117\088\065\075\088\082";"\111\099\086\107\069\111\047\108\114\109\054\110\104\099\083\099\104\052\061\061";"\121\052\072\073\119\065\086\070\048\080\099\054","\054\085\115\043\066\087\085\085\105\057\076\086\099\097\067\120";"\097\074\109\082\122\075\070\099\113\052\051\043\066\088\048\115\084\068\069\085\107\105\098\070\101\054\121\119\043\052\061\061","\076\055\074\054","\069\119\052\079\082\065\061\061";"\076\112\065\099\067\112\108\083";"\076\057\104\079\086\057\104\101\086\099\055\053\114\099\055\108\081\051\114\061";"\121\086\107\072\074\065\115\088\050\048\052\061","\108\106\050\108\085\076\099\083\103\065\115\120","\107\099\067\057\099\076\054\077\112\080\061\061","\054\078\054\066\070\085\048\072\109\099\100\049\121\080\061\061";"\088\087\050\071\086\079\086\107\069\072\104\108\080\099\055\101\086\057\104\108\115\109\098\112\086\053\104\056\114\057\104\097","\053\065\110\083\051\048\117\086","\049\051\101\119\082\080\061\061","\076\053\086\105\102\084\098\098\086\070\065\109\069\085\088\088\080\080\061\061","\074\084\085\097\117\052\061\061";"\053\111\102\100\117\080\098\109\048\122\061\061";"\120\084\104\054\075\047\104\048\090\043\065\099","\068\113\052\089\121\118\070\068\054\065\061\061","\088\111\118\048\081\054\104\098\074\057\065\051\102\081\074\104\102\072\102\061","\047\101\113\050\111\056\047\111\056\114\055\122\120\097\073\111\050\120\119\097\048\055\076\077\110\048\121\061","\080\099\088\048\074\057\104\108\054\109\077\050\086\099\080\061","\043\083\106\113\101\082\103\066\072\114\112\048\107\097\117\090\078\052\061\061","\081\078\079\055\099\099\050\086\089\070\104\111\115\053\107\067";"\084\100\099\099\067\047\090\071\111\119\054\061";"\065\068\081\052";"\090\113\065\077\118\069\075\076\117\056\068\119\047\110\097\082\048\122\061\061","\079\109\047\055\082\110\100\050\048\097\084\087\120\056\052\061","\110\048\101\101\103\073\122\052\053\122\075\069\079\106\100\122\108\117\082\061","\087\074\056\111\119\102\065\056\107\120\076\073\110\114\050\109\057\071\055\098\074\117\049\118\071\080\061\061","\113\098\069\061";"\052\050\120\082\083\122\061\061";"\076\083\069\052\114\053\098\097\081\052\061\061","\104\102\048\053\101\052\061\061";"\069\070\050\097\071\111\114\101\073\122\080\061";"\088\057\074\077\054\084\055\048\102\051\082\052\076\053\111\070\086\053\121\061";"\103\099\109\103\082\073\110\116";"\111\109\088\090\099\099\052\043\104\078\077\118\117\079\119\068\111\099\114\061","\103\052\061\061","\054\109\088\068\069\079\085\071\117\099\108\061";"\108\076\121\089\120\080\061\061";"\056\067\074\043\117\115\083\111\100\109\070\053\068\080\061\061","\065\082\085\107\088\098\078\105";"\115\121\108\066";"\080\082\050\106\120\075\111\054\097\052\061\061","\119\098\121\103","\086\051\085\119\086\080\061\061","\043\087\104\085\048\117\112\053\050\122\061\061";"\043\122\086\056\122\090\086\113\067\052\061\061","\118\104\117\083\106\053\054\061";"\072\082\081\084\105\114\069\061","\116\110\056\089\116\072\051\097\082\079\108\108\087\072\048\079\047\122\061\061";"\114\072\050\108\086\080\061\061";"\070\085\068\100\087\100\074\055\118\054\069\061","\104\108\055\054\111\101\098\067\069\053\111\052\069\087\088\048\099\070\080\061","\104\051\055\117\111\097\086\085\111\108\098\116\102\109\079\055\088\122\061\061";"\068\071\056\118\082\076\121\122\097\088\051\118\084\097\084\052\080\043\098\072\067\080\061\061","\101\066\070\050\090\072\067\078\117\066\079\089\090\122\061\061";"\100\117\102\120\069\072\088\087\078\103\100\069\108\098\086\079\080\115\118\067\103\118\053\056\086\057\065\073\119\073\055\107";"\074\084\085\090\115\084\054\061";"\055\120\108\103\115\105\065\061";"\048\116\051\102\107\100\050\105\082\051\053\083\107\114\113\072\107\052\061\061";"\048\054\100\055\117\098\067\108","\074\066\086\051\067\053\049\078\057\043\097\106\090\049\047\061";"\100\047\106\109\121\077\113\088\089\080\061\061";"\104\084\085\112\114\083\074\109\074\087\086\055\104\079\107\047\076\109\080\061";"\068\087\109\049\109\056\067\052\110\080\068\086";"\117\121\107\104\056\072\073\074\115\054\090\113","\086\051\055\053\086\057\088\090\054\079\074\067\115\083\080\043\102\054\079\061","\118\100\083\076";"\088\065\079\069\071\081\055\053\090\121\099\082";"\111\084\104\079\076\072\086\097\114\081\077\057\081\087\085\057\111\065\061\061";"\090\113\053\112\104\109\114\109\098\065\061\061","\054\087\077\122\073\068\108\117\069\076\080\061","\097\056\116\068\103\078\076\086\106\084\083\111\070\084\088\112";"\117\087\119\085\089\099\100\119\054\085\107\099\081\070\065\108\115\052\061\061","\085\068\108\118","\101\117\048\078\120\090\083\101\080\098\056\061","\054\087\085\055","\066\085\075\103\085\098\049\085\084\071\089\097\120\097\043\090";"\097\054\072\076\084\067\102\103\048\065\122\049\085\083\050\048\099\055\056\061","\075\113\105\104\102\047\086\073\086\112\107\107\111\122\082\118\066\065\050\111","\051\073\104\101\099\052\061\061";"\097\084\048\119","\050\057\079\119\065\089\097\068\077\052\073\050","\098\121\118\070\047\110\121\120\076\108\049\047\100\120\052\076\119\055\118\098\118\065\061\061";"\089\082\101\120\069\052\116\075\109\110\074\050\122\047\053\061";"\055\104\111\055\047\108\056\055\084\055\043\089\072\055\097\086\065\097\082\116\067\075\103\103\116\054\107\085\070\089\080\079\104\080\061\061";"\056\118\110\066\055\052\112\116","\122\056\114\102\100\055\103\083\118\053\084\101\054\076\107\079\106\052\061\061";"\065\090\043\079\076\075\122\061","\067\084\113\070\080\054\111\116\088\057\085\078\069\053\050\076","\079\098\108\071\050\120\080\117\082\098\052\104\113\051\084\053\083\072\082\061","\056\050\112\071";"\083\078\108\084\083\120\065\114\103\071\100\073\107\054\066\076\050\112\077\089";"\076\057\104\077";"\068\043\079\069\121\107\109\066\075\065\061\061","\078\118\115\104\114\051\076\066\114\050\069\069","\111\101\088\110\076\053\113\109\089\054\113\076\081\087\088\118","\074\109\098\108\102\053\083\079\067\099\085\098\081\072\111\051\076\087\052\061";"\079\065\112\047\122\090\101\112","\074\072\085\048\117\108\113\071\099\053\080\083\074\051\074\112\069\122\061\061";"\072\113\114\087\071\098\072\056\108\080\084\101\049\052\061\061","\117\084\070\098\116\116\052\101";"\076\052\107\114\106\078\080\061","\118\104\113\110\048\114\103\082","\074\104\109\084\114\122\061\061";"\047\054\053\057\122\088\051\053\076\077\098\089\117\052\061\061";"\088\099\083\052\089\057\098\050\114\099\110\061";"\080\053\104\076\081\051\104\121\081\081\102\083\117\101\053\051\069\122\061\061";"\069\070\100\116\103\083\048\108\118\122\061\061","\109\080\061\061";"\074\084\113\071\074\099\083\090\086\057\047\061","\083\077\079\072\053\052\061\061";"\120\052\101\121\050\078\101\084\051\080\061\061";"\113\111\098\055";"\074\070\050\052\086\099\113\087";"\111\103\052\119\108\115\048\074\057\066\077\047\079\049\076\047","\109\115\050\047\057\122\089\083\082\080\080\081\078\098\121\052\065\101\067\084\072\072\107\050\067\083\053\055\122\113\054\069\084\083\090\090\097\068\080\089\069\101\106\120\081\056\112\050\107\082\049\087\122\097\054\090\113\102\043\107\075\104\074\102\103\113\118\103\080\051\048\109\106\075\116\077\117\055\082\080\106\115\050\054\055\043\072\080\075\086\119\056\110\114\057\106\114\068\049\083\106\118\104\090\068\101\052\061","\080\057\088\108\114\099\104\116","\101\080\057\089\105\079\082\122\050\057\054\084";"\101\103\080\079\119\119\113\098\075\121\099\108\121\110\104\050\079\090\106\054";"\074\111\098\067\102\070\053\043\088\051\107\081\099\099\074\081\074\054\110\061","\043\113\115\065","\067\066\109\105\055\117\118\053","\106\117\071\049\072\103\114\089\067\103\069\061";"\080\051\118\118\115\087\074\050\054\051\113\071\086\052\061\061","\083\055\051\114\052\108\113\082\051\089\078\076";"\066\081\079\057\073\073\118\108\102\047\114\100\084\103\109\103","\090\074\082\109\069\101\074\104\082\047\052\061","\107\055\103\104\049\052\100\101\053\115\119\088\076\086\053\082\081\097\053\082","\086\065\061\061";"\073\070\080\084";"\088\084\050\097\114\051\113\071\115\087\111\101\074\122\061\061";"\054\084\100\118\089\111\104\068\074\099\055\053","\086\108\086\081\102\109\088\099\089\079\100\068\117\084\118\070\067\099\114\061","\054\084\100\118\089\054\085\071\117\099\108\061";"\104\081\121\065\090\076\047\050","\054\109\088\068\069\122\061\061";"\103\110\076\118","\067\090\065\050\086\106\121\107\067\065\061\061","\080\067\065\109","\110\116\081\070\048\052\061\061";"\057\083\113\056\086\099\110\061","\073\090\109\047\065\043\073\070\057\073\101\109\120\104\069\061","\122\052\118\051\098\050\068\079";"\090\082\109\077\050\086\078\072\105\098\086\069\113\073\055\078\068\108\050\121\081\065\061\061";"\088\109\102\122\049\052\061\061";"\066\082\109\112\053\065\061\061";"\088\099\083\107\074\122\061\061","\052\122\081\114\104\117\054\073\068\047\097\086\104\051\109\083\098\080\061\061";"\117\079\106\084\120\053\069\079\051\052\061\061";"\110\067\119\103\108\101\099\070\090\112\081\112\113\052\061\061","\112\055\079\122\112\052\054\075\107\049\108\113\071\080\061\061";"\119\053\107\113\121\112\115\055";"\104\113\086\047\047\082\053\100\090\116\107\122\120\100\082\061","\080\052\061\061";"\088\051\111\108\088\084\111\097\114\051\111\071\086\084\085\071\074\070\102\061";"\104\069\057\069\089\065\061\061","\073\113\072\049\102\080\061\061","\086\087\112\108\090\054\110\061";"\074\067\103\084\085\118\104\043","\109\084\075\090\075\073\043\086\069\050\054\061","\111\072\066\103\106\107\110\061";"\090\114\043\108\116\083\080\061";"\081\078\054\052\074\079\074\119\054\054\118\118\081\084\121\100\114\052\061\061";"\122\071\109\051\085\111\069\097\050\065\061\061";"\111\072\085\101\102\057\107\102\054\053\055\055\076\053\118\102";"\090\085\122\083\086\050\072\110\117\080\061\061";"\104\055\082\121\075\119\098\108\068\056\069\076\097\116\098\103\100\084\102\061";"\087\103\076\051\086\056\056\057\118\065\112\080\110\068\090\088\109\085\118\073\086\112\116\049\118\115\104\101\052\052\061\061","\074\067\117\100\108\053\112\051\099\115\122\061","\117\057\104\087\115\051\100\053\086\057\047\061";"\108\081\115\111\100\079\072\117";"\053\099\065\090\103\085\048\101\081\049\050\076\120\073\105\049\115\116\081\071","\110\103\069\050";"\076\121\097\116\118\072\080\114","\048\068\070\120\083\100\052\061","\084\090\113\098\087\113\043\119\048\056\079\061";"\054\051\111\108\111\051\085\056\117\083\104\052\086\099\111\053","\097\085\070\112\109\069\069\061";"\112\122\119\112\101\065\061\061","\054\051\118\068\074\108\055\068\074\084\050\087\117\099\104\118\074\084\050\068\115\065\061\061";"\065\118\117\101";"\113\075\104\069","\088\051\111\108\054\051\111\043\074\087\050\101\086\080\061\061";"\079\107\056\066\075\052\107\048\112\075\104\098\110\065\112\077","\117\052\074\107\101\057\056\057\043\110\048\053\105\107\083\086";"\079\110\073\115\099\112\115\070\098\085\056\114","\113\101\117\066\076\048\072\054","\071\055\050\112","\114\047\074\100\068\070\107\054\074\122\061\061","\080\080\061\061","\108\086\067\122\069\116\070\054\066\047\047\061","\047\070\087\066\048\052\061\061","\054\071\083\100\079\098\121\114";"\088\087\050\071\086\085\077\118\069\072\088\112\115\050\098\118\089\080\061\061";"\111\078\104\106\051\065\066\084\110\114\065\061";"\112\107\057\055\048\113\121\086\111\122\061\061";"\099\103\118\088\100\068\056\121\054\043\102\061";"\080\051\113\056\115\109\098\081\086\057\085\083\086\099\055\101\086\080\061\061";"\083\072\071\113";"\074\113\102\108\107\080\061\061";"\111\051\085\107\074\122\061\061","\050\070\068\113\114\076\079\099";"\076\051\100\101\076\097\050\116\099\080\061\061","\115\055\076\101\120\122\061\061","\079\069\122\051\114\105\068\079\101\065\061\061","\083\073\114\048\082\073\117\074\113\072\121\061","\077\107\118\097\082\113\097\122\079\106\081\053\088\082\076\104\100\117\084\102\072\080\061\061";"\081\084\083\109\088\083\077\047\104\070\077\099\081\079\098\051","\122\106\057\077\104\080\061\061";"\048\050\048\052\114\068\100\120\109\119\117\070\106\052\061\061";"\080\101\118\086\054\085\074\043\104\053\121\097\080\050\104\052\111\053\053\061","\111\120\079\053\047\120\067\100\108\112\121\061";"\069\103\109\051\056\070\098\053\099\088\121\061";"\107\120\082\067\081\052\061\061";"\043\066\048\071\076\052\052\118\105\122\061\061";"\069\084\085\107\069\072\102\061";"\121\047\050\084\049\047\110\061","\055\101\114\114\116\075\120\119";"\112\082\043\048\074\048\069\102\111\080\061\061","\079\051\121\061","\081\111\098\110\104\079\107\077\088\050\118\111\074\087\118\097","\102\054\104\071\076\099\088\099\115\087\110\083\074\097\050\099\115\087\065\061";"\099\078\085\053\067\084\108\109\069\085\098\057\102\072\107\067";"\069\084\104\118\115\084\052\061";"\100\072\089\121\107\088\051\109","\080\088\117\114\081\110\121\102\119\103\098\099","\101\052\080\097\080\073\101\100\052\079\047\061";"\073\100\053\080\089\099\118\085\055\110\090\076","\110\088\082\101\072\111\068\057";"\106\074\073\071","\055\070\077\118\076\102\075\077\122\050\051\056\122\080\061\061";"\114\100\080\055\072\067\056\061","\072\101\116\089\081\104\074\086\122\117\054\061";"\111\101\079\052\099\054\104\054\080\097\098\085\088\087\104\076\067\080\061\061";"\090\105\088\043\117\098\052\113\056\065\077\113\056\052\061\061","\074\078\081\074\102\105\098\055\053\067\089\069\052\071\109\072\053\080\061\061";"\089\099\047\105","\080\115\080\100\118\047\080\061";"\111\051\085\107\074\079\086\068\069\053\104\121\117\099\100\053","\085\077\085\068\051\122\051\051\048\053\069\078","\049\072\101\114\104\119\120\114\049\106\110\061";"\109\110\088\102\073\116\057\102\080\110\109\090\102\043\103\112\114\099\118\070\080\069\086\067\057\078\065\061";"\082\065\043\117\102\118\056\066\104\118\078\076\075\069\068\081","\115\119\056\074\072\078\053\082\090\065\061\061";"\115\072\057\117\111\072\053\061","\112\089\072\118\054\057\113\086";"\089\070\053\109\054\099\100\109\088\111\085\100\115\083\086\078\080\099\079\061";"\120\115\051\116\108\103\078\085";"\072\120\086\076\119\077\055\080\077\080\083\072\103\080\061\061";"\104\074\049\072\097\115\054\061";"\103\081\111\104\057\076\084\114\112\105\074\117\081\108\120\077\108\065\061\061","\080\076\097\112\054\113\056\043\067\075\052\077";"\113\109\056\061","\111\079\085\052\069\109\074\052\054\079\083\110\115\108\080\110\111\054\079\061";"\103\111\112\119\089\084\118\084\074\043\088\049";"\054\050\104\108\054\072\104\056\099\070\047\052\074\099\086\055\074\052\061\061";"\071\087\054\048\102\108\076\051\056\084\054\061","\102\100\071\055\099\105\101\103\099\074\121\061","\057\083\113\072\114\052\061\061";"\055\115\076\077\083\076\122\103\068\117\074\068","\121\110\085\115\052\052\061\061","\072\088\116\066\089\079\117\048\106\051\082\061";"\087\055\098\114\101\072\086\119\082\109\099\043","\073\069\100\050\116\080\061\061","\099\099\055\115\122\073\073\080\112\086\077\048\097\085\079\061";"\081\067\052\056\053\122\061\061";"\055\122\086\099\080\074\086\050\085\108\108\114\104\087\107\104\078\054\099\122\090\077\077\071\122\099\119\056\088\080\061\061","\052\115\047\100\057\111\083\102\057\050\082\061";"\089\051\086\098\108\080\061\061";"\116\047\102\074\080\080\116\115\057\117\077\043","\053\084\121\101","\118\074\078\052\086\109\047\061","\116\051\073\051\110\105\072\055\117\100\117\069\052\110\114\050","\087\109\090\090","\117\087\065\088\083\069\077\052\050\080\061\061";"\104\084\085\104\111\109\086\052\115\050\050\084\081\072\054\052\081\052\061\061";"\069\109\104\067\049\078\111\099\054\080\061\061","\043\065\081\116\114\048\072\081\052\103\081\083\051\122\061\061","\057\080\078\054","\106\065\108\115\116\104\098\088\082\122\061\061";"\121\073\115\085","\115\088\065\122","\054\097\069\083\115\108\080\100\104\084\086\076\086\051\054\097\074\051\080\061","\081\077\068\057\113\089\078\115\077\083\105\110\057\111\066\106\069\122\061\061";"\108\080\107\100\090\119\065\051\051\101\080\061","\104\066\076\110\097\119\103\122\083\115\101\073";"\115\099\085\116\086\099\086\068\115\084\088\050\069\065\061\061","\070\066\090\054","\104\109\053\051\054\081\118\098\111\053\088\105\074\083\077\080","\043\043\115\100\122\066\112\079\084\047\103\120\104\047\070\051\053\087\056\072\075\101\067\052\108\113\071\101\048\054\077\075\080\122\055\078\107\057\101\054","\072\099\111\052\109\102\099\043\100\055\082\061","\079\079\067\070\109\082\104\071";"\073\117\069\085\054\057\070\082";"\097\103\100\056";"\107\086\076\113\065\113\053\061";"\089\101\055\068\051\071\067\107\113\097\110\061","\071\105\067\043\115\120\106\118\114\072\079\061","\114\043\114\121\086\115\121\103\113\086\080\066\056\116\102\088";"\097\100\067\047","\076\070\088\108\069\079\074\050\074\122\061\061";"\078\121\110\079\078\115\073\119\056\100\109\057\080\070\082\061","\100\082\079\088\099\056\057\073\071\080\061\061","\057\065\061\061","\070\117\057\121\098\111\099\088\076\100\121\061";"\109\065\101\075";"\108\076\051\072\088\052\052\061";"\078\121\086\076\113\050\120\071\085\098\089\075\076\052\061\061","\081\122\083\113\051\052\069\061";"\053\115\048\049\072\078\065\061","\053\099\066\105","\102\054\079\104";"\099\080\043\121\085\085\054\061","\106\119\121\121\072\076\099\107\105\082\085\099";"\115\084\111\071","\065\052\061\061","\054\051\111\047\069\083\065\043\067\078\077\077\080\111\098\098\117\087\080\061";"\084\051\074\102\089\100\054\070\054\076\102\068\111\111\100\081\088\113\110\080\048\122\061\061","\088\100\110\098\051\098\053\061","\117\053\100\104\088\084\104\067\089\050\088\077\115\057\080\100";"\100\098\052\074","\082\086\076\072","\121\053\102\099\110\101\112\105","\107\071\052\080\101\107\075\087\050\082\088\118\110\052\113\085";"\048\083\105\067";"\111\087\111\101\074\084\113\043\102\052\061\061","\074\099\055\052\114\099\104\116";"\051\121\043\107\121\078\108\069\111\070\110\080\113\078\068\099\112\084\052\115","\070\052\108\055\100\105\049\067\104\122\061\061","\113\068\121\057";"\081\108\074\043\102\051\050\066\104\051\111\088\117\079\074\120\076\122\061\061","\105\067\116\073\116\122\065\065\077\103\076\116\056\089\106\097\098\110\067\101","\047\116\054\116\087\090\057\049","\114\108\113\100\099\085\077\078\117\053\050\047\111\109\111\109\104\122\061\061";"\050\104\117\089\057\067\071\052\100\077\069\061","\100\116\115\056\043\119\056\061";"\117\057\077\118\117\057\098\097";"\115\078\079\061","\057\084\109\117\072\105\051\122";"\085\090\047\088\048\108\099\050","\050\056\122\065\117\117\104\051\052\049\110\113\050\083\097\051";"\097\104\083\053\072\081\087\083";"\102\097\088\051\115\053\050\118\111\085\111\117\069\081\098\067\054\099\114\061"}local function B(B)return v[B+(-497719-(-541956))]end for B,L in ipairs({{-226390-(-226391),19100-18266},{-481300+481301,478300+-477852},{819889+-819440;878006+-877172}})do while L[865043-865042]<L[227848-227846]do v[L[-552072-(-552073)]],v[L[-410333-(-410335)]],L[-815743+815744],L[933469-933467]=v[L[-958173+958175]],v[L[455598-455597]],L[-675002-(-675003)]+(440530+-440529),L[768369-768367]-(-681354-(-681355))end end do local B=math.floor local L=table.insert local H=table.concat local M=type local z=v local Q={d=-898608+898657;["\055"]=-432985+433042,y=658502-658462,u=-511389-(-511415);g=331031-330969,["\050"]=-923535-(-923572),["\052"]=-874324+874372;E=237136+-237108;W=-253023-(-253061);H=-832102-(-832141);k=514212-514171,a=-917010+917061;B=19705+-19695;h=614068+-614055,L=-95234-(-95252),x=870725-870667,t=415717+-415674;p=-732647+732662;P=750243+-750227;D=-335876+335923,Y=-269174+269204;w=954674-954629;J=-140268-(-140297),T=596397-596391;I=430207+-430176,K=579702+-579639;["\054"]=533530-533510,Q=745290+-745271,["\049"]=881967+-881908;S=813625-813572;["\047"]=942098+-942090;O=-623504+623508;n=-196277-(-196333),["\048"]=7474+-7432,o=-1034238-(-1034259),i=13883-13872,l=-864290-(-864342),Z=-932567+932601;z=519976-519976,C=-518784-(-518798);A=-68467-(-68499);R=238530-238470,b=606487+-606478;["\057"]=-511825+511848,V=753368-753343;["\051"]=109617+-109563;X=-149621-(-149638);["\043"]=743809+-743759,c=152434-152412;q=616976+-616915,U=-173884-(-173889);F=972572+-972565,e=-401401+401436;N=939981-939978,m=964602-964547,s=-559720-(-559747),f=771204-771192;["\053"]=1009652-1009616,r=912759+-912735,["\056"]=524990-524946;G=389501+-389455,M=-23228+23229,v=469020+-468987,j=-329280-(-329282)}local N=string.char local K=string.len local I=string.sub for v=-734123-(-734124),#z,-669890-(-669891)do local o=z[v]if M(o)=="\115\116\114\105\110\103"then local M=K(o)local b={}local V=-488911+488912 local q=606114+-606114 local c=692038-692038 while V<=M do local v=I(o,V,V)local H=Q[v]if H then q=q+H*(625219-625155)^((140460+-140457)-c)c=c+(395197-395196)if c==866307+-866303 then c=393572+-393572 local v=B(q/(533943-468407))local H=B((q%(-344715+410251))/(-828504-(-828760)))local M=q%(822756-822500)L(b,N(v,H,M))q=897670-897670 end elseif v=="\061"then L(b,N(B(q/(-30811-(-96347)))))if V>=M or I(o,V+(-635606+635607),V+(908949+-908948))~="\061"then L(b,N(B((q%(-930462-(-995998)))/(-1009704+1009960))))end break end V=V+(729681+-729680)end z[v]=H(b)end end end return(function(v,H,M,z,Q,N,K,R,d,Y,q,j,t,w,I,A,b,F,h,o,L,W,c,V,C)R,c,I,d,o,Y,W,w,A,t,C,j,L,V,F,b,q,h=function(v,B)local H=q(B)local M=function()return L(v,{},B,H)end return M end,function(v)local B,L=-1024601+1024602,v[-356126-(-356127)]while L do o[L],B=o[L]-(215446+-215445),(326293+-326292)+B if o[L]==-91000-(-91000)then o[L],I[L]=nil,nil end L=v[B]end end,{},function(v,B)local H=q(B)local M=function(M,z,Q,N)return L(v,{M,z;Q;N},B,H)end return M end,{},function(v,B)local H=q(B)local M=function(M,z)return L(v,{M,z},B,H)end return M end,function(v)o[v]=o[v]-(921481-921480)if-892955-(-892955)==o[v]then o[v],I[v]=nil,nil end end,function(v,B)local H=q(B)local M=function(M,z,Q,N,K,I,o,b,V,q)return L(v,{M;z,Q,N,K;I;o,b,V,q},B,H)end return M end,function(v,B)local H=q(B)local M=function(M,z,Q,N,K,I)return L(v,{M,z,Q;N,K,I},B,H)end return M end,function(v,B)local H=q(B)local M=function(M,z,Q)return L(v,{M,z,Q},B,H)end return M end,function(v,B)local H=q(B)local M=function(M,z,Q,N,K,I,o)return L(v,{M;z,Q;N;K;I,o},B,H)end return M end,function(v,B)local H=q(B)local M=function(...)return L(v,{...},B,H)end return M end,function(L,M,z,Q)local dJ,q,G,nJ,y,mJ,xJ,LJ,BJ,i,PJ,NJ,l,p,vJ,f,HJ,MJ,o,a,c,TJ,K,uJ,g,s,X,QJ,gJ,wJ,IJ,AJ,XJ,j,VJ,JJ,T,E,bJ,S,sJ,YJ,zJ,WJ,SJ,pJ,Z,u,FJ,m,RJ,cJ,OJ,r,V,k,aJ,n,x,hJ,qJ,lJ,e,KJ,DJ,jJ,O,CJ,D,tJ,oJ,P,U,J,fJ while L do if L<-93285+7870362 then if L<429501+3721901 then if L<2524428-493297 then if L<512717+509378 then if L<-92385-(-511714)then if L<52060+290996 then if L<-266578-(-445350)then if L<-822201+967904 then if L<292368-239447 then L=328353+2358465 else q=K L=q and 535899+12485229 or 15867167-936704 end else if L<1207624-1038616 then L=g L=K and 5557296-(-250393)or-535832+4940278 else q=-386090+386155 V=I[z[-909955-(-909957)]]o=V*q V=493608+32749594424169 K=o+V o=-688371+35184372777203 L=K%o I[z[-137368+137370]]=L V=-661097-(-661098)o=I[z[-690522+690525]]L=4166541-961260 K=o~=V end end else if L<84589-(-230950)then if L<-532808+740339 then L=g and 6654809-926215 or 533560+1507509 else D=I[z[-426788-(-426789)]]T=B(798531-842155)O=23143152992897-792681 g=I[z[711713-711711]]X=g(T,O)n=7987201644629-(-702002)j=D[X]c=o[j]X=B(973381-1017029)g=v[X]T=I[z[-615137+615138]]O=I[z[74477+-74475]]s=B(31941+-75578)f=O(s,n)X=T[f]f=B(-652779+609008)D=g[X]s=-120087+20838283967230 X=I[z[59335+-59334]]T=I[z[-206965-(-206967)]]O=T(f,s)g=X[O]j=D[g]q=c==j L=q and 10902328-13738 or 681748+8097020 end else q=I[z[-177349-(-177355)]]V=q==o K=V L=-472269+2328108 end end else if L<997483+-634124 then if L<984192-625791 then if L<-491639+838119 then D=7646810425372-473652 o=M[299218+-299217]j=B(13409+-56850)L=I[z[-102350-(-102351)]]V=I[z[719183+-719181]]q=I[z[129737+-129734]]c=q(j,D)K=V[c]V=o o=nil L[K]=V L=v[B(866917-910826)]K={}else j=B(390202+-433824)K=I[z[29840-29839]]V=I[z[-76784-(-76786)]]D=735340+27293505796409 q=I[z[-925473-(-925476)]]c=q(j,D)o=V[c]L=K[o]L=L and 854514+7283968 or 15294486-(-697916)end else X=593572+22845025884906 L=I[z[-975166+975169]]c=I[z[1005131-1005130]]g=B(1184-44690)O=B(235012-278965)j=I[z[-84756+84758]]D=j(g,X)f=27423639003486-372604 q=c[D]D=B(-79915-(-35779))j=v[D]g=I[z[-587217-(-587218)]]X=I[z[15086-15084]]T=X(O,f)D=g[T]g=L g=-672344+672345 c=j[D]X=-652336+652516 o=nil D=V or X X=888702+-888522 j=c(D,g,X)L[q]=j T=32943970178713-350893 q=I[z[478069+-478066]]j=I[z[-978785-(-978786)]]X=B(292341+-336572)D=I[z[-723762-(-723764)]]g=D(X,T)c=j[g]j=false T=777813+4380453317026 q[c]=j X=B(-44331+638)O=12977350872892-292769 q=I[z[-733207-(-733210)]]j=I[z[-594557-(-594558)]]D=I[z[287979+-287977]]g=D(X,T)c=j[g]T=B(1002749+-1046572)j=true q[c]=j V=nil j=B(-788607+744489)c=v[j]D=I[z[611840+-611839]]g=I[z[761049+-761047]]X=g(T,O)j=D[X]O=33710111915759-98718 q=c[j]j=R(14176709-310586,{z[811562-811559];z[778369-778368],z[981783-981781];z[386083-386079];z[-832368+832373]})c=q(j)j=B(1000508-1044626)c=v[j]D=I[z[-910923+910924]]g=I[z[864031+-864029]]T=B(31428-75033)X=g(T,O)j=D[X]q=c[j]j=R(9954691-210016,{z[156080-156077];z[778094+-778093],z[94503-94501];z[888519+-888514];z[-582360-(-582366)];z[364442+-364435];z[-930432-(-930440)];z[-256047-(-256056)],z[401320-401310];z[231811-231800],z[-750595-(-750607)],z[268969-268956]})c=q(j)L=v[B(738686-782570)]K={}end else if L<598949-208851 then if L<1222401-843779 then L=B(-71029+27034)L=X[L]L=L(X)L=626509+224421 else L=751366+6621408 end else K=B(-192228+148233)L=v[K]K=L()L=I[z[563537-563536]]K=B(504796-548796)K=L[K]K=K(L)K=B(480412-524412)L=I[z[-620234-(-620236)]]K=L[K]K=K(L)L=I[z[568127+-568124]]K=B(100931-144931)K=L[K]K=K(L)L=I[z[974192+-974188]]K=B(603579-647296)K=L[K]K=K(L)K={}L=v[B(983788-1027698)]end end end else if L<-195211-(-1015825)then if L<-327063-(-863105)then if L<1362498-844787 then if L<-28826+476650 then q=311592+1258604 K=-882960+4777118 V=B(-621804+577708)o=V^q L=K-o K=B(717960+-762061)o=L L=K/o K={L}L=v[B(388724+-432690)]else D=false K=I[z[99781-99771]]L=K==D L=L and 119610+1958546 or 736655+6079624 end else I[V]=BJ k=-312013-(-312014)vJ=I[i]E=vJ+k r=U[E]Z=f+r r=-687733+687989 L=Z%r f=L L=13270634-921104 E=I[a]r=s+E E=944509-944253 Z=r%E s=Z end else if L<990848-272030 then if L<675969+-129650 then J=I[V]L=J and 202203+3950291 or 424218+5335581 m=J else L=311333+-311332 I[z[-436493-(-436494)]]=L L=v[B(805431-849243)]K={}end else s=nil O=L f=q~=s L=f and 936560+7572937 or-111539+1327483 T=f end end else if L<1000203+-58908 then if L<1034897-125613 then if L<290597-(-580033)then L=5511306-912289 g=nil X=nil else O=B(954950-999166)L=I[z[733689-733688]]s=B(347398+-391258)V=I[z[650882+-650880]]q=I[z[796122+-796119]]j=B(-231027-(-187259))D=-837205+6441031815692 X=B(-323724-(-279781))f=33759646850425-483345 c=q(j,D)K=V[c]T=-886978+35103338907804 c=B(-715348-(-671734))q=v[c]j=I[z[-111217-(-111219)]]D=I[z[434652-434649]]g=D(X,T)c=j[g]n=2140612653836-978728 V=q[c]g=I[z[107758-107756]]X=I[z[-963572-(-963575)]]T=X(O,f)D=g[T]X=B(230929+-274735)j=o[D]g=v[X]T=I[z[-450848-(-450850)]]O=I[z[256372+-256369]]f=O(s,n)X=T[f]O=-689492+689492 D=g[X]X=-522880+522880 T=650924-650919 g=D(X,T,O)c=j+g q=V(c)L[K]=q L=2735344-968612 end else f=false s=false L=301269+4543721 I[z[-1047005-(-1047015)]]=f I[z[775593+-775581]]=s l=B(-1018899-(-974805))i=190236+32987732841701 n=v[l]p=I[z[808964+-808957]]a=B(-291329+247491)J=I[z[545605+-545597]]S=I[z[-646546+646548]]u=I[z[-900144+900147]]x=u(a,i)P=S[x]m=J[P]l=n(p,m)l=B(-1033258-(-989164))n=v[l]p=I[z[-566512-(-566519)]]a=B(447335+-491073)J=I[z[-868140+868148]]S=I[z[-755411+755413]]i=28109627395652-(-566493)u=I[z[945641-945638]]x=u(a,i)P=S[x]m=J[P]l=n(p,m)end else if L<1064481-50956 then if L<1998512-1006502 then K=B(-353092-(-309092))L=I[z[207421+-207420]]K=L[K]K=K(L)L=-345318+14369570 else O=B(914274-958079)T=v[O]K=T L=902750+4282317 end else q=B(688493-732629)o=M[-147048+147049]L=nil g=B(802356+-845935)X=13647020575297-(-36497)K=v[q]c=I[z[680441+-680440]]V=L j=I[z[-788007+788009]]D=j(g,X)q=c[D]g=B(734404+-778015)L=K[q]K=B(-1006371+962576)X=B(-765914+721938)q=L L=v[K]D=v[g]X=D[X]g={X(D)}D={L(H(g))}c=D[763286-763284]K=D[-744560-(-744561)]j=D[886500+-886497]D=K L=13987032-51012 end end end end else if L<-264204+1828304 then if L<530327-(-873998)then if L<-567030+1670852 then if L<1110843-66480 then if L<112579+929382 then K={}L=v[B(596891-640799)]else V=B(-862465-(-818854))u=-289473+23284483937563 p=13981971644991-(-22319)j=B(-890340+846285)o=v[V]f=B(-702658-(-658905))c=v[j]S=32984143585470-(-449345)T=B(-114459+70527)D=I[z[-133598-(-133600)]]g=I[z[731003+-731000]]O=21250760837656-500593 X=g(T,O)s=5355752766688-(-3293)j=D[X]q=c[j]m=B(846891-890678)J=94115+28977105192210 D=I[z[848700-848699]]X=I[z[721951+-721949]]T=I[z[326604-326601]]l=B(-360323-(-316121))O=T(f,s)g=X[O]j=D[g]O=B(147345-190959)P=B(-153612+110209)T=v[O]f=I[z[-587122-(-587124)]]V=B(276198+-320135)s=I[z[-929003-(-929006)]]n=s(l,p)O=f[n]X=T[O]f=I[z[-461847+461848]]n=I[z[-366490-(-366492)]]l=I[z[946218+-946215]]p=l(m,J)s=n[p]V=o[V]O=f[s]n=I[z[-349258+349259]]p=I[z[-910788+910790]]m=I[z[4748+-4745]]J=m(P,S)l=p[J]s=n[l]p=B(-458319-(-414513))l=v[p]m=I[z[316192+-316190]]S=B(295856-339682)J=I[z[-688158+688161]]P=J(S,u)p=m[P]J=773611-773611 m=1000637+-1000638 n=l[p]p=756875-756875 l=n(p,m,J)f=s+l T=X(O,f)O=I[z[974940-974938]]n=B(-208001+164021)f=I[z[-385570+385573]]l=-255119+32523622965175 s=f(n,l)X=O[s]g=T[X]X=-131684-(-131688)D=g*X c=q(j,D)q=I[z[861092-861088]]V=V(o,c,q)L=8216675-(-473520)K=V end else if L<1933300-881444 then g=5171597043923-188267 L=-959885-(-959886)K=I[z[397876-397872]]D=B(-1044322-(-1000424))q=I[z[801351-801350]]c=I[z[331770+-331768]]o+=L j=c(D,g)V=q[j]c=681247-681242 L=-452131+5221826 q=o*c K[V]=q else K={c}L=v[B(-774869+731134)]end end else if L<-462752+1789114 then if L<1326812-137936 then m=B(926110+-970050)n=I[z[-539751-(-539752)]]J=-756868+24957061233129 P=B(-373373-(-329321))l=I[z[242277-242275]]S=29422506402849-(-610659)p=l(m,J)l=B(587636-631284)L=16519859-(-215244)s=n[p]f=j[s]n=v[l]p=I[z[-602095-(-602096)]]m=I[z[-408790+408792]]J=m(P,S)l=p[J]s=n[l]O=f~=s X=O else g=T L=O L=7817388-466740 end else L=s l=B(-703710-(-659857))P=28700153797044-(-678528)p=787417+3491710173824 f[L]=K K=I[z[460811+-460810]]s=I[z[-551326+551328]]n=s(l,p)L=K[n]n=B(-899769-(-855627))s=v[n]J=B(-559253+515168)l=I[z[-695862-(-695863)]]p=I[z[931530-931528]]m=p(J,P)n=l[m]l=403037-403037 K=s[n]p=319432+-319432 n=540925-540925 s=K(n,l,p)P=8306849381760-28260 p=883394+23118643933003 f[L]=s l=B(-117351-(-73325))K=I[z[118693+-118692]]s=I[z[52921+-52919]]n=s(l,p)L=K[n]K=true f[L]=K K=I[z[-541062+541063]]s=I[z[120692+-120690]]p=-949356+21047446954676 l=B(149048-192762)n=s(l,p)L=K[n]n=B(-825779-(-781637))J=B(990914+-1035031)s=v[n]l=I[z[1005488+-1005487]]p=I[z[-715858-(-715860)]]m=p(J,P)n=l[m]p=961975+-961720 K=s[n]n=-682577-(-682832)l=-801625+801880 s=K(n,l,p)f[L]=s K=I[z[868580+-868579]]l=B(463815-507679)s=I[z[865800-865798]]p=596742+25406010037040 n=s(l,p)L=K[n]K=940260-940260 l=B(86868+-130597)p=-1021910+5827258294895 f[L]=K K=I[z[286802+-286801]]s=I[z[-835605-(-835607)]]n=s(l,p)l=B(480014-523662)L=K[n]S=-707381+34470398265832 n=v[l]p=I[z[714050-714049]]P=B(527749-571298)m=I[z[-853592-(-853594)]]J=m(P,S)P=-267605+8523257373909 l=p[J]s=n[l]l=I[z[-977476-(-977477)]]J=B(-159453-(-115950))p=I[z[-361353-(-361355)]]m=p(J,P)n=l[m]l=B(-815621+771460)P=B(-597353-(-553757))K=s[n]f[L]=K K=I[z[242352+-242351]]p=296251+23540291822998 s=I[z[825748+-825746]]n=s(l,p)s=B(-649139+605506)L=K[n]J=-640622+23182577217689 K=true f[L]=K m=B(-279355+235698)K=v[s]n=I[z[-649690+649691]]l=I[z[-220406-(-220408)]]p=l(m,J)m=B(152728+-196568)J=9688450825718-617559 s=n[p]L=K[s]n=I[z[251355+-251354]]l=I[z[1037546+-1037544]]p=l(m,J)s=n[p]K=L(s)p=B(352682-396227)s=K m=-116438+10268116310403 K=I[z[915670+-915669]]n=I[z[-879694-(-879696)]]l=n(p,m)m=634105+6977828904888 L=K[l]p=B(783535-827023)K=j s[L]=K K=I[z[315684-315683]]n=I[z[689197+-689195]]l=n(p,m)L=K[l]l=B(-915949+871807)S=838329+21039404751756 n=v[l]p=I[z[-367796+367797]]m=I[z[-340625+340627]]J=m(P,S)m=1003206-1002951 l=p[J]p=238224-237969 K=n[l]l=726702+-726447 n=K(l,p,m)J=B(-525851+481721)s[L]=n K=I[z[335582-335581]]p=B(-66786+22723)n=I[z[167954+-167952]]m=14500921623751-(-595353)l=n(p,m)L=K[l]P=32175600915619-(-746979)K=749534+-749532 s[L]=K n=B(-759373+715740)K=v[n]l=I[z[-612950-(-612951)]]p=I[z[-603615-(-603617)]]m=p(J,P)J=B(82441-126034)P=32696133008474-147681 n=l[m]L=K[n]l=I[z[-842720+842721]]p=I[z[-377669-(-377671)]]m=p(J,P)J=2455080953046-581727 n=l[m]K=L(n)n=K m=B(-790240+746821)K=I[z[939298+-939297]]l=I[z[-286679+286681]]p=l(m,J)J=166438+27469703866321 L=K[p]K=3.65 n[L]=K K=I[z[-2394+2395]]m=B(289226-332712)l=I[z[317632+-317630]]p=l(m,J)L=K[p]K=j n[L]=K K={c;j}L=v[B(-973668-(-929636))]end end else if L<847330-(-648354)then if L<-389233+1816310 then if L<1778809-367646 then P=B(-71614-(-28137))u=B(472280+-516074)L=v[P]S=v[u]P=L(S)L=B(372391-415824)v[L]=P L=12967960-(-947369)else L=v[B(-1044778-(-1001142))]K={V}end else c=I[z[-111721-(-111722)]]q=c[o]D=I[z[507711+-507709]]g=I[z[38389-38386]]T=B(-361304+317839)O=326683+30526108892011 X=g(T,O)j=D[X]c=V[j]K=q[c]L=not K L=L and 15259762-349800 or 548259+3992226 end else if L<1266622-(-266889)then if L<2084803-559387 then m=false p=I[z[132294+-132288]]L=10340652-33294 l=p==m s=l else K=I[z[-291858-(-291860)]]L=not K I[z[-840690-(-840692)]]=L L=v[B(-467935-(-424500))]K={}end else X=B(-287590-(-243939))j=I[z[-449344+449345]]T=32037234966251-328869 s=29475989062647-(-831910)D=I[z[-787556-(-787558)]]g=D(X,T)c=j[g]q=o[c]g=B(516246-559894)D=v[g]X=I[z[-794216-(-794217)]]T=I[z[-844071+844073]]f=B(120609+-164496)O=T(f,s)g=X[O]j=D[g]L=6851351-(-377095)g=I[z[318+-317]]f=33917427127542-(-534716)X=I[z[874511-874509]]O=B(960125-1003795)T=X(O,f)D=g[T]c=j[D]V=q==c K=V end end end else if L<1003336+808795 then if L<2225588-496860 then if L<1241580-(-408120)then if L<311227+1298049 then l=p a=l L=14583263-659900 n[l]=a l=nil else L=V L=6270157-325634 K=o end else K=B(-990087-(-946467))L=true v[K]=L K=I[z[-731430+731435]]q=B(660907+-704624)q=K[q]q=q(K)q=B(995386-1039103)g=B(-513236-(-469617))K=I[z[-191064+191070]]q=K[q]q=q(K)q=B(8685-52685)K=I[z[965643+-965636]]q=K[q]q=q(K)X=9402635461964-414770 K=I[z[854290-854282]]c=I[z[158928+-158926]]j=I[z[-771340-(-771343)]]D=j(g,X)q=c[D]V=nil c=I[z[733609-733600]]X=27830702742192-43025 g=B(201934-245907)K[q]=c K=I[z[738761-738753]]c=I[z[532250-532248]]j=I[z[326442+-326439]]f=12347980089191-782578 D=j(g,X)g=B(205298+-248854)q=c[D]X=-991627+21460467337364 c=I[z[-73852-(-73862)]]K[q]=c K=I[z[-71354+71362]]c=I[z[-871595-(-871597)]]O=B(783035+-826878)j=I[z[989312+-989309]]D=j(g,X)q=c[D]D=B(563936-607550)j=v[D]L=v[B(-558709-(-514789))]g=I[z[-1012405-(-1012407)]]X=I[z[413652-413649]]T=X(O,f)D=g[T]X=37709-37709 c=j[D]g=741749-741764 T=18460879794076-(-619000)D=-361532+361532 j=c(D,g,X)K[q]=j c=B(-793575+749550)q=v[c]j=I[z[-873601-(-873603)]]D=I[z[-535424-(-535427)]]X=B(-355+-43729)g=D(X,T)c=j[g]K=q[c]j=B(-59957-(-15736))c=v[j]q=K(o,c)o=nil K={}end else if L<-714122+2496042 then if L<427864+1333857 then L=I[z[613530+-613526]]K=B(-239365+195365)K=L[K]K=K(L)L=11922114-127725 else L=639666+7722350 o=nil end else T=I[z[55498+-55492]]O=false X=T==O D=X L=28714+9704130 end end else if L<973464+944812 then if L<1033135-(-798176)then if L<1968652-153229 then L=p and 13244931-1028738 or-181281+2138182 else L=755663+8297055 end else o=nil I[z[228468+-228463]]=K L=-987391+7634022 end else if L<1976232-(-33691)then if L<2979961-1011255 then n=nil l=nil L=438904+6965039 else L=O n=32917374653915-(-370181)L[K]=T s=B(284588+-328464)L=I[X]T=I[z[61000+-60999]]O=I[z[-35282+35284]]S=B(-42240-1274)e=-825649+1759745285220 m=B(563729-607327)f=O(s,n)K=T[f]s=B(-105995-(-62347))f=v[s]n=I[z[737912+-737911]]l=I[z[-296386-(-296388)]]J=-974736+18047947587684 p=l(m,J)s=n[p]p=B(359161+-402637)O=f[s]s=I[z[141805+-141804]]m=814016+4199160519651 n=I[z[189379+-189377]]l=n(p,m)n=B(944280+-988130)i=-787988+18905725020279 f=s[l]l=402051+30267445646475 T=O[f]L[K]=T T=B(-705741-(-662108))K=v[T]m=B(883630-927432)O=I[z[724229+-724228]]f=I[z[-1040679+1040681]]s=f(n,l)T=O[s]a=B(-547134-(-502961))L=K[T]O=I[z[552113+-552112]]n=B(-220369+176137)l=10185762089943-(-173744)f=I[z[491542+-491540]]s=f(n,l)T=O[s]K=L(T)T=b()I[T]=K L=I[T]n=B(-866589+822982)O=I[z[795077-795076]]l=17504981649918-(-300505)u=305772021509-116343 f=I[z[923497+-923495]]s=f(n,l)K=O[s]s=B(373670+-417603)f=v[s]n=I[z[-215960+215961]]J=-808893+6218147865356 l=I[z[867228+-867226]]p=l(m,J)s=n[p]O=f[s]p=B(451456+-494926)l=v[p]m=I[z[339796-339795]]J=I[z[-530701-(-530703)]]P=J(S,u)p=m[P]P=B(880389-924531)n=l[p]p=724540+-724540 J=v[P]S=I[z[341564+-341563]]u=I[z[979586-979584]]x=u(a,i)u=541315-541315 P=S[x]m=J[P]P=690309-690309 S=-506597+506597 i=B(898010+-941701)J={m(P,S,u)}l=n(p,H(J))x=-568064+5280702903451 m=B(470785-514255)p=v[m]J=I[z[-1041880-(-1041881)]]u=B(-427767-(-383773))P=I[z[242974-242972]]S=P(u,x)m=J[S]n=p[m]S=B(748758+-792900)m=-845597+845598 P=v[S]u=I[z[-347079+347080]]x=I[z[-559737+559739]]a=x(i,e)S=u[a]x=-984371+984626 u=-564819+565074 J=P[S]S=-635038-(-635293)P={J(S,u,x)}p={n(m,H(P))}s={l,H(p)}f=O(s)n=B(272731+-316911)L[K]=f L=I[T]l=7141539832319-(-1010430)O=I[z[970070-970069]]f=I[z[-505687-(-505689)]]s=f(n,l)K=O[s]O=I[X]L[K]=O O=B(-111428+67310)l=B(192842+-237043)m=B(609843-653692)p=691383+2027629049593 K=v[O]f=I[z[-776019-(-776020)]]s=I[z[482683+-482681]]n=s(l,p)O=f[n]L=K[O]O=Y(6614004-(-959405),{z[38857+-38856],z[619346+-619344];X;T})K=L(O)p=661446+25224543720988 O=B(283325+-326958)K=v[O]l=B(30736+-74495)f=I[z[186096-186095]]s=I[z[584429-584427]]n=s(l,p)O=f[n]L=K[O]p=35142402813924-241656 f=I[z[-64956+64957]]s=I[z[312295-312293]]l=B(-324516+280984)n=s(l,p)O=f[n]K=L(O)l=235582+28097962056414 O=K J=-942352+8084792750020 n=B(500423+-544367)K=I[z[165970-165969]]f=I[z[80353-80351]]s=f(n,l)L=K[s]K=j O[L]=K l=-16046+6192202631665 K=I[z[-151831+151832]]n=B(-171960-(-127997))f=I[z[302982-302980]]s=f(n,l)L=K[s]K=-236850-(-236851)n=B(-9665+-34225)l=518634+5835312062643 O[L]=K K=I[z[-914785+914786]]P=14791066894769-(-71990)f=I[z[483443-483441]]s=f(n,l)L=K[s]s=B(509011-552463)f=v[s]n=I[z[-181588-(-181589)]]l=I[z[-26501+26503]]p=l(m,J)l=.11 s=n[p]J=-961222+8770253306553 K=f[s]n=-263366+263366 m=B(-546514-(-502824))s=.29 p=-242224+242224 f=K(s,n,l,p)O[L]=f n=B(-679009+635332)l=14666585423417-(-171124)K=I[z[-28749-(-28750)]]f=I[z[-1026216+1026218]]s=f(n,l)L=K[s]s=B(72255-115707)f=v[s]n=I[z[10327-10326]]l=I[z[754399+-754397]]p=l(m,J)s=n[p]n=9089+-9089 l=.38 K=f[s]p=-891424-(-891424)s=.68 f=K(s,n,l,p)l=17555734330630-(-713449)n=B(-240950+197507)O[L]=f K=I[z[660020+-660019]]f=I[z[-65408+65410]]s=f(n,l)n=B(-607381+563733)L=K[s]s=v[n]J=B(-541120+497707)l=I[z[565021+-565020]]p=I[z[65750-65748]]m=p(J,P)n=l[m]f=s[n]n=I[z[273695-273694]]l=I[z[-553016-(-553018)]]m=B(762515-806400)J=-831598+2287366632599 p=l(m,J)s=n[p]K=f[s]O[L]=K K=I[z[1021800+-1021799]]n=B(-101720-(-57500))l=19964182546331-(-826549)f=I[z[696032-696030]]s=f(n,l)L=K[s]K=o f=L L=o and-903312+8149246 or 436910+4866402 end else L=B(-372822-(-328695))K=I[z[-511580+511584]]L=o[L]L=L(o,K)L=L and 3019768-(-685534)or-68722+7865610 end end end end end else if L<452519+2661072 then if L<547733+2110806 then if L<-797150+3016219 then if L<2110776-(-36569)then if L<2729062-617152 then if L<809178+1232292 then D=B(-859343+815225)l=5509406876664-39411 K=v[D]O=I[z[-439202+439204]]f=I[z[570981-570978]]n=B(594845+-638558)s=f(n,l)D=O[s]L=K[D]D=R(10986172-(-243970),{X,z[101996-101989];z[-1044084-(-1044086)];z[802593-802590],T;z[24042+-24041];z[-211456-(-211464)];z[-323103+323112];z[-848885-(-848895)]})K=L(D)f=I[z[321256-321251]]O=#f D=j==O K=D L=D and 600874+15832581 or 11394084-96502 else L=true I[z[-208445+208455]]=L l=B(-321162-(-276970))D=B(-480060-(-436063))K=v[D]g=I[z[928411-928404]]p=34765102187453-132225 L=-388437+7204716 T=I[z[395675+-395667]]f=I[z[-79541-(-79543)]]s=I[z[30833+-30830]]n=s(l,p)O=f[n]X=T[O]T=461752-461751 D=K(g,X,T)end else if L<3084246-942704 then K={}L=v[B(-503760-(-459962))]else S=#n p=520243+-520242 l=q(p,S)p=D(n,l)l=nil a=-375976-(-375977)S=I[s]L=-105834+3002811 x=p-a u=g(x)S[p]=u p=nil end end else if L<228595+1938664 then if L<-783264+2947625 then L=B(-764923-(-720885))g=j l=27346685750938-425180 O=I[z[538725+-538724]]L=X[L]n=B(190065+-233754)f=I[z[-149973-(-149975)]]s=f(n,l)T=O[s]L=L(X,T)L=L and 225647+15455301 or-490883+6836891 else q=I[z[997975+-997966]]c=q L={}V=59546-59545 o=L L=480608+10574594 q=-832194+832195 j=q q=-671630-(-671630)D=j<q q=V-j end else q=B(-483056-(-438982))V=v[q]q=B(-109667-(-66155))o=V[q]q=I[z[-160008-(-160009)]]V={o(q)}L=v[B(-416500-(-372489))]K={H(V)}end end else if L<-302743+2666936 then if L<1619414-(-724167)then if L<2151249-(-127268)then L=g X=836291+-836111 g=-679258+679259 j=c(D,g,X)V=nil o=nil K={}L[q]=j L=v[B(765101-808714)]else L=1466026-(-675610)p=#n S=-998037-(-998037)l=p==S end else L=v[B(25283+-69426)]K={}end else if L<388717+2214338 then if L<-396338+2876832 then S=-115009-(-115015)L=I[g]P=267035-267034 J=L(P,S)L=B(-827047-(-783614))S=B(-600564-(-557131))v[L]=J P=v[S]S=-837497-(-837499)L=P>S L=L and 2210893-803706 or-422531+12739072 else T=I[z[365878-365873]]X=L g=T L=T and 13534054-(-153666)or 4161735-(-706174)end else O=B(-814668-(-770937))K=B(-1089946-(-1046336))L=v[K]f=29787208316401-524227 g=I[z[7396+-7395]]X=I[z[489714-489712]]T=X(O,f)D=g[T]K={L(D)}L=v[B(865414-909622)]K={H(K)}end end end else if L<-839839+3661391 then if L<2761100-45230 then if L<-135121+2839064 then if L<880524+1807224 then c=W(c)f=nil q=W(q)c=b()g=W(g)X=nil L=1047258+12876105 O=W(O)p=W(p)j=W(j)V=W(V)q=nil s=nil l=nil V=nil n=nil D=nil n={}O=b()I[c]=V g=B(-586199-(-542063))V=b()I[V]=q D=B(719522+-763658)j=v[D]D=B(-612992-(-568759))q=j[D]X=B(838070-882144)j=b()T=W(T)I[j]=q D=v[g]g=B(-911578-(-867365))q=D[g]T=B(-878142-(-834422))f={}g=v[X]p=-604748+605004 X=B(-494874+451362)D=g[X]S=p X=v[T]T=B(-59369-(-15180))g=X[T]X=-323058+323058 l=-983560-(-983561)T=b()I[T]=X X=-371991+371993 I[O]=X p=841367+-841366 s=b()u=p p=1014073+-1014073 X={}I[s]=f x=u<p f=412954+-412954 p=l-u else c=-527364-(-527364)q=V<c K=q L=-316521+15592109 end else u=I[z[69595-69594]]e=9341202430272-(-333757)i=B(-706952-(-663510))x=I[z[-17457+17459]]J=B(425076-468638)a=x(i,e)S=u[a]P=l[S]J=V[J]L=1075603-(-738381)S=true J=J(V,P,S)m=not J p=m end else if L<-224650+3009570 then if L<3404569-661516 then L=I[z[-516836+516837]]L=L and 1553403-(-808643)or 5931906-502541 else V=-230330+230354 K=B(-260064-(-216110))L=v[K]K=L(V)L=-745560+1124238 end else L=1212323-(-418700)j=I[z[-555132-(-555136)]]O=B(-883842-(-840052))g=I[z[-188000+188002]]X=I[z[544032-544029]]f=-803645+27761607046588 T=X(O,f)D=g[T]c=j[D]j=385706+-385706 q=c==j o=q end end else if L<-1019943+4051720 then if L<384497+2628105 then if L<3811290-848252 then S=-15380+15380 p=#n l=p==S L=l and-959468+7213699 or 1775023-(-366613)else n=not s O=O+f X=O<=T X=n and X n=O>=T n=s and n X=n or X n=129850+7127101 L=X and n X=-345083+10227062 L=L or X end else V=M[-756765+756767]O=10928232249475-(-252765)q=M[-654116-(-654119)]o=M[57238-57237]c=B(-639354+595267)K=v[c]D=I[z[-264320-(-264321)]]g=I[z[-48120+48122]]c=B(89533+-133481)T=B(849513-893188)X=g(T,O)j=D[X]c=K[c]T=-204886+32735151676385 c=c(K,j)j=I[z[-288080-(-288081)]]X=B(-28598+-15268)D=I[z[618350-618348]]f=-380960+28729426871394 g=D(X,T)X=B(-700553+656685)T=195591+24791435948305 K=j[g]L=c[K]j=I[z[806733+-806732]]s=-234010+6105829023029 D=I[z[-260742+260744]]O=B(-857017-(-813431))g=D(X,T)c=j[g]g=b()K=B(659804-703696)K=L[K]p=27284765558861-448172 K=K(L,c)L=I[z[287961+-287958]]D={L(o,V,q)}c=K j=D[269881+-269879]l=B(-519539+475385)K=D[-87826-(-87827)]D=b()I[D]=K I[g]=j L=I[D]j=I[z[191718+-191717]]o=nil X=I[z[388262-388260]]T=X(O,f)q=nil K=j[T]j=c L[K]=j j=B(852190-896264)K=v[j]f=B(-743946+699937)X=I[z[-735646-(-735647)]]T=I[z[-863383-(-863385)]]O=T(f,s)j=X[O]L=K[j]j=I[z[-321522-(-321526)]]f=I[z[641002+-641001]]s=I[z[-752426-(-752428)]]X=-725504-(-725505)n=s(l,p)O=f[n]s=1386421615149-964520 f=I[g]T={[O]=f}K=L(j,X,T)V=nil L=I[z[222062+-222057]]c=nil K=L()j=B(489542+-533036)K=v[j]X=I[z[-452051+452052]]T=I[z[-697726-(-697728)]]f=B(547756+-591537)O=T(f,s)j=X[O]L=K[j]j=Y(14849478-(-622486),{z[-45104+45110],g,z[-376106+376107],z[-771780-(-771782)],z[560329-560325];z[-348882-(-348887)],D})K=L(j)g=W(g)L=K()D=W(D)K={}L=v[B(-781923+738273)]end else if L<520930+2589168 then if L<3057588-(-18710)then O=-1001767+33551723939374 o=M[-25950-(-25951)]D=B(217889-261734)K=I[z[-434358-(-434359)]]T=B(-159469+115633)q=I[z[-815498+815500]]c=I[z[-567092-(-567095)]]g=3429920535722-(-577939)j=c(D,g)V=q[j]L=K[V]c=I[z[1019289+-1019285]]D=I[z[-39499+39501]]g=I[z[-768798-(-768801)]]K=B(-459817+415887)X=g(T,O)j=D[X]q=c[j]V=o/q K=L[K]o=nil K=K(L,V)K={}L=v[B(-247310-(-203342))]else L=s L=1439012-223068 T=f end else V,j=q(o,V)L=V and 2534088-(-1031744)or 635859+12498713 end end end end else if L<966508+2868258 then if L<-755948+4283084 then if L<543945+2777710 then if L<3810911-622784 then if L<-117201+3267081 then BJ=I[V]K=BJ L=BJ and 9256490-(-36547)or-113035+8824812 else X=B(221565+-265409)L=6230602-(-1024924)j=v[X]T=I[D]X=j(T)end else if L<-438389+3646898 then q=-625780-(-625927)V=I[z[-272878-(-272881)]]o=V*q V=324405+-324148 K=o%V I[z[-698069-(-698072)]]=K L=606375+11958272 else L=true f=25814549823582-4458 n=B(367353-411006)V=B(-904767-(-861262))g=B(-640203-(-596542))I[z[-629468+629471]]=L K=I[z[4516+-4512]]V=K[V]V=V(K)I[z[-341423-(-341428)]]=V K=I[z[681098+-681093]]c=I[z[-1034964-(-1034965)]]j=I[z[-738878-(-738880)]]X=373743+14901235443499 l=-627816+10212284901115 D=j(g,X)q=c[D]O=B(-52630-(-9113))c=false g=B(-450468-(-406897))K[q]=c K=I[z[-263092+263097]]X=774503+481488465785 P=29832598341350-(-257885)c=I[z[-520744-(-520745)]]j=I[z[64012+-64010]]D=j(g,X)q=c[D]g=B(761561+-805540)J=-423747+31303281520691 c=false X=2945344417613-158194 K[q]=c K=I[z[881549+-881544]]c=I[z[296166+-296165]]j=I[z[-52351-(-52353)]]D=j(g,X)q=c[D]D=B(939603+-983217)j=v[D]g=I[z[-995607+995608]]m=B(-978617+934489)X=I[z[-127939+127941]]T=X(O,f)D=g[T]c=j[D]X=I[z[953598+-953592]]O=I[z[383205-383204]]f=I[z[628836-628834]]s=f(n,l)T=O[s]g=X[T]f=I[z[-332229-(-332235)]]n=I[z[-1044505+1044506]]l=I[z[-1009039+1009041]]p=l(m,J)s=n[p]p=B(-398465+354881)O=f[s]m=25852898731587-849725 s=I[z[10031-10030]]n=I[z[-443364+443366]]J=B(-970526+926909)l=n(p,m)f=s[l]T=O[f]O=56934-56926 p=-688959+6009468243501 X=T*O D=g+X T=I[z[-826965-(-826971)]]f=I[z[1020087-1020086]]l=B(-1087260-(-1043097))s=I[z[444641+-444639]]n=s(l,p)O=f[n]X=T[O]s=I[z[-401867-(-401873)]]l=I[z[335534+-335533]]p=I[z[-735219-(-735221)]]m=p(J,P)J=4688844940473-(-582606)n=l[m]f=s[n]n=I[z[158117+-158116]]l=I[z[676071-676069]]m=B(1041815+-1085907)p=l(m,J)s=n[p]O=f[s]f=401772+-401763 T=O*f g=X+T j=c(D,g)K[q]=j l=3122875621935-760961 T=-419147+26161688466657 K=I[z[-380024-(-380029)]]X=-1023126+30783757161620 g=B(523299-567446)c=I[z[-185563-(-185564)]]j=I[z[-522817-(-522819)]]D=j(g,X)q=c[D]j=B(331981+-375592)c=v[j]X=B(242468-286469)K[q]=c c=B(985522+-1029155)q=v[c]j=I[z[-280904+280905]]D=I[z[419453-419451]]g=D(X,T)X=B(146100-190265)c=j[g]K=q[c]j=I[z[300079-300078]]D=I[z[962534-962532]]T=555236+6809276257150 g=D(X,T)c=j[g]q=K(c)I[z[889156-889149]]=q K=I[z[-652881-(-652888)]]j=I[z[679668+-679667]]X=B(593916+-637785)D=I[z[-167301+167303]]T=-576427+17712923782115 n=B(-755512+711854)g=D(X,T)c=j[g]X=I[z[-246090+246096]]O=I[z[-1037927+1037928]]f=I[z[-658118+658120]]s=f(n,l)T=O[s]n=924304+19507331614955 g=X[T]T=I[z[-437602+437603]]s=B(909047+-952510)O=I[z[384001-383999]]f=O(s,n)X=T[f]D=g[X]g=262306-262206 s=692172+31590299363754 j=D*g K[c]=j T=7453860455470-890528 X=B(953999-997961)K=I[z[359854+-359847]]j=I[z[735289-735288]]D=I[z[981453+-981451]]f=B(-330771-(-286877))g=D(X,T)c=j[g]g=B(92476-136282)D=v[g]X=I[z[-86889+86890]]T=I[z[-182456+182458]]O=T(f,s)g=X[O]j=D[g]g=-46771+1046771 X=1906094-906094 T=752395-(-247605)D=j(g,X,T)K[c]=D K=I[z[-815752-(-815759)]]j=I[z[-356000+356001]]T=735962+9453202200151 D=I[z[389634+-389632]]X=B(706693+-750119)g=D(X,T)X=B(846157+-890376)c=j[g]j=I[z[933914-933909]]K[c]=j K=I[z[1031357-1031349]]j=I[z[999370+-999369]]T=22023994428468-631845 D=I[z[-1011666+1011668]]f=B(-944151-(-899953))g=D(X,T)s=-876565+23399850216101 c=j[g]j=I[z[-983939-(-983948)]]K[c]=j K=I[z[503415+-503407]]T=-568151+11696628236445 j=I[z[-994968+994969]]X=B(74825-118274)D=I[z[345056-345054]]g=D(X,T)c=j[g]j=I[z[-983233+983238]]K[c]=j T=8482862278358-841576 K=I[z[-266550-(-266558)]]j=I[z[185472-185471]]X=B(-876628-(-833174))D=I[z[-590848+590850]]g=D(X,T)c=j[g]g=B(-367591-(-323977))D=v[g]X=I[z[-968798-(-968799)]]T=I[z[-26664-(-26666)]]O=T(f,s)g=X[O]j=D[g]X=-52200+52200 T=969704+-969704 g=195876+-195876 D=j(g,X,T)L=5513679-(-162826)T=B(83334+-127431)O=374105+15675788519210 K[c]=D c=B(-751181-(-707094))K=v[c]D=I[z[535477+-535476]]c=B(-60877+16929)g=I[z[-1024630-(-1024632)]]c=K[c]X=g(T,O)j=D[X]D=-122251-(-122254)c=c(K,j)j=I[z[523255-523250]]K=B(895375-939133)K=c[K]O=16980719706295-(-572972)K=K(c,j,D)T=B(-156214-(-112226))c=B(529518-573605)K=v[c]D=I[z[470295+-470294]]c=B(927583+-971531)g=I[z[216132+-216130]]c=K[c]X=g(T,O)O=-395316+787362859426 j=D[X]D=-1018282+1018285 c=c(K,j)K=B(537672+-581430)j=I[z[277195+-277188]]K=c[K]K=K(c,j,D)c=I[z[1031470+-1031465]]D=I[z[-4046+4047]]T=B(314993-359054)g=I[z[-537326-(-537328)]]X=g(T,O)j=D[X]K=c[j]j=Y(13125+10049273,{z[957418+-957408];z[387979-387978],z[767464+-767462];z[-196808+196819];z[409450+-409443],z[812928+-812923];z[690673-690661];z[895815-895807];z[-402868+402874];z[854659-854650]})c=B(-320336-(-276162))c=K[c]c=c(K,j)I[z[-988699+988711]]=c end end else if L<4369951-894317 then if L<-983877+4403263 then L=true L=-315137+7849154 else f=712616+6442416073743 j=B(644097-687650)q=v[j]g=I[c]O=B(606793-650252)X=I[V]l=8133627650764-824321 T=X(O,f)X=B(716331+-760418)D=g[T]g=v[X]O=I[c]n=B(-1049669-(-1005885))f=I[V]s=f(n,l)T=O[s]O=B(-650392+606561)O=g[O]X={O(g,T)}j=q(D,H(X))L=11496800-(-127152)end else j=B(-890472+846919)q=v[j]g=I[c]X=I[V]O=B(-569389+525186)f=532855+4530990606022 T=X(O,f)L=391796+9336465 X=B(383957+-428044)D=g[T]g=v[X]O=I[c]n=B(429991-474140)l=12641413101107-(-1007819)f=I[V]s=f(n,l)T=O[s]O=B(-176976-(-133145))O=g[O]X={O(g,T)}j=q(D,H(X))end end else if L<52228+3636403 then if L<2655405-(-933710)then if L<-682256+4248949 then D=I[z[-388986+388988]]c=V s=B(-332679-(-288809))T=I[z[-902409-(-902412)]]O=I[z[-244334+244338]]n=24773131792119-(-540184)f=O(s,n)X=T[f]g=j[X]L=D[g]L=L and-133741+2719389 or 15592722-1007281 else K=B(-851800-(-808347))L=v[K]K=L()L=v[B(-766434+722283)]K={}end else J=B(840402+-884492)l=I[z[-800263+800264]]P=368246+14348392102819 p=I[z[683704+-683702]]m=p(J,P)n=l[m]K=n L=1781420-419479 end else if L<-632025+4429021 then if L<4005278-294266 then K={}L=v[B(-816321-(-772297))]else c,g=j(q,c)L=c and 911757+4521931 or 216737+8299694 end else L=Z L=735303+7976474 K=BJ end end end else if L<4441201-446644 then if L<-1038846+4995362 then if L<-835689+4772117 then if L<-642970+4538866 then L=v[B(470581+-514757)]K={}else L=275717+245859 r=481717+-481716 Z=U[r]BJ=Z end else K={}L=v[B(-194753+151122)]o=nil end else if L<886763+3079371 then if L<-70523+4032268 then K=551905+-551903 L=-584809+5910449 I[z[427206+-427202]]=K else P=I[z[115569+-115568]]a=4627100803112-(-469058)m=B(-66343-(-22305))x=B(152220+-196087)S=I[z[-607215+607217]]u=S(x,a)J=P[u]m=l[m]m=m(l,J)p=m L=m and 2877406-161730 or 1732891-(-81093)end else L=K and 541854-346877 or-869754+14097690 end end else if L<4758389-734976 then if L<4550739-532854 then if L<532513+3470345 then V=I[z[251482+-251477]]o=#V K=-932115+932116 V=o o=155189-155188 q=o o=-359628-(-359628)c=q<o o=K-q L=16490600-939837 else K={}L=v[B(480720+-524246)]end else K=B(414207+-458206)L=v[K]V=93187345790008-(-987642)K=L(V)V=7405430377-(-508903)K=B(155081-199080)L=v[K]T=B(788029+-831918)K=L(V)K=B(-415634+371634)L=I[z[702510+-702506]]D=B(-1032822-(-988596))K=L[K]K=K(L)V=B(983292-1027317)g=-384555+15290700085755 K=B(419537-463537)L=I[z[894211+-894206]]K=L[K]K=K(L)L=I[z[-953639+953645]]K=B(-520324-(-476607))K=L[K]K=K(L)K=v[V]q=I[z[48072-48070]]c=I[z[973757-973754]]j=c(D,g)V=q[j]q=B(520499-564720)L=K[V]V=v[q]K=L(o,V)K=B(365650-409647)L=v[K]V=I[z[326423+-326422]]O=-969956+34214031575840 c=I[z[482542+-482535]]D=I[z[-935508+935510]]g=I[z[-868825-(-868828)]]X=g(T,O)j=D[X]q=c[j]j=861817-861816 c=-448375+448375 K=L(V,q,c,j)L=I[z[-191573+191581]]V=K K=B(227359+-271343)K=L[K]q=340269+-340267 D=B(-609758+565887)K=K(L,q)q=I[z[361831+-361829]]c=I[z[-426338+426341]]g=1375856029291-502763 j=c(D,g)K=q[j]L=V[K]K=B(-421359-(-377429))V=nil K=L[K]K=K(L)K=false L=true I[z[-528965-(-528974)]]=L I[z[306836-306826]]=K c=B(913537+-957169)q=v[c]c=q()L=-732893+4675337 end else if L<-471963+4585760 then if L<4017805-(-18884)then O=10906438829598-799304 D=I[z[6261-6260]]T=B(-50144-(-6125))g=I[z[-206082-(-206084)]]X=g(T,O)j=D[X]s=B(396188-440042)X=B(-628453-(-584805))c=o[j]g=v[X]n=8582279403697-837909 T=I[z[-276916-(-276917)]]O=I[z[267686-267684]]f=O(s,n)X=T[f]D=g[X]f=B(603658+-647680)s=18045828890693-(-499854)X=I[z[-946776-(-946777)]]T=I[z[46262-46260]]O=T(f,s)g=X[O]j=D[g]q=c==j L=q and 685712+14511127 or 4571237-(-740490)else L=5782442-541442 q=nil end else L=v[B(-547318-(-503239))]K={V}end end end end end end else if L<4848985-(-956448)then if L<588390+4495277 then if L<341270+4256218 then if L<426234+3997085 then if L<474319+3892441 then if L<4469047-279347 then if L<4249339-88364 then J=f==s m=J L=5946650-186851 else K=B(398314-442313)o=82037408525539-(-574334)L=v[K]T=152865+2758685372387 K=L(o)o=17567054565-(-695079)K=B(-142315+98316)L=v[K]K=L(o)K=B(-149511-(-105794))L=I[z[342268+-342262]]K=L[K]X=B(-685390-(-641181))K=K(L)K=B(-1056059-(-1012062))L=v[K]o=I[z[684689+-684682]]q=I[z[911346+-911338]]j=I[z[612444-612442]]D=I[z[696701-696698]]g=D(X,T)c=j[g]V=q[c]q=-828703-(-828703)c=768376-768375 D=-92646+4141531591022 j=B(-470686-(-427074))K=L(o,V,q,c)o=K V=I[z[-612263+612265]]q=I[z[835647+-835644]]c=q(j,D)K=V[c]L=o[K]o=nil K=B(-254624-(-210694))K=L[K]K=K(L)L=false I[z[-26580-(-26589)]]=L V=B(-530334-(-486702))L=v[B(-832714-(-788649))]K=v[V]V=K()K={}end else if L<4227104-(-35265)then j=O p=-20047+20048 n=I[D]l=f[p]s=n..l p=B(979833-1023372)l=v[p]p=l(s)n=not p L=n and 5055570-(-622887)or 15804418-96947 else L=f L=O and 13698158-(-342033)or 139484+4705506 end end else if L<619271+3781720 then if L<956460+3426267 then o=1.1793461131043e+14 K=B(-822629-(-778630))L=v[K]K=L(o)D=-715367+20627529256940 K=I[z[-727397+727398]]o=I[z[728096-728094]]L=K[o]j=B(94369+-138013)o=L L=I[z[572212-572209]]V=I[z[-922633+922637]]q=I[z[-538240-(-538245)]]c=q(j,D)s=650414+15810152689684 K=V[c]q=B(459306-502746)V=v[q]j=I[z[-430761+430767]]X=I[z[324264-324260]]T=I[z[-519721+519726]]f=B(-357669-(-313566))O=T(f,s)g=X[O]D=o[g]c=j..D q=V(c)j=B(-590950-(-547310))D=32399678731853-1014622 L[K]=q L=I[z[-382908-(-382911)]]V=I[z[523823+-523819]]q=I[z[-47715+47720]]c=q(j,D)K=V[c]T=B(-573524-(-529860))V=133554-133554 L[K]=V O=-163564+23264013068605 K=B(856345+-900296)g=B(-225286+181828)L=v[K]c=I[z[139419-139415]]j=I[z[-952925+952930]]X=400279+4950488575338 D=j(g,X)q=c[D]D=I[z[126911-126907]]g=I[z[-271565-(-271570)]]X=g(T,O)T=28805604847245-(-837080)j=D[X]c=o[j]V=q..c X=B(497764-541264)j=I[z[730527-730523]]O=B(-358942+315150)f=959891+14403690951840 D=I[z[-503541+503546]]g=D(X,T)c=j[g]g=I[z[-591192+591196]]X=I[z[96398+-96393]]T=X(O,f)D=g[T]j=o[D]q=c..j K=L(V,q)V=328381+-328380 K=I[z[-42016+42018]]L=K+V q=-939216+939218 I[z[719532+-719530]]=L V=I[z[-176898-(-176900)]]K=V>q L=K and 21975+13749976 or 998746+5140226 else L=I[z[498408-498407]]X=B(326537-370438)V=I[z[-737288-(-737290)]]j=B(197733-241749)q=I[z[487384+-487381]]D=-138939+29083010683809 s=15006024691903-415092 T=161706+6195948508059 c=q(j,D)K=V[c]c=B(595044-639180)f=B(-618746+575137)q=v[c]j=I[z[608356-608354]]D=I[z[-1048514+1048517]]g=D(X,T)c=j[g]V=q[c]D=I[z[616096-616095]]X=I[z[-339759+339761]]T=I[z[-139683+139686]]O=T(f,s)g=X[O]j=D[g]c=o*j j=612335-612334 q=V(c,j)L[K]+=q L=82077+6877433 end else n=6193253492295-793348 T=I[z[544204-544203]]s=B(-342410-(-298244))J=399360+6202207810376 O=I[z[489192-489190]]f=O(s,n)X=T[f]s=B(517735-561302)g=o[X]X=I[z[-740830-(-740833)]]f=v[s]n=I[z[-868885-(-868886)]]l=I[z[226467-226465]]m=B(390747+-434509)p=l(m,J)s=n[p]T=B(806740+-850248)O=f[s]m=B(-134844+90966)f=O(q,c,j)n=I[z[123329-123328]]J=-858452+32021368361875 l=I[z[428992-428990]]p=l(m,J)s=n[p]n=B(-99001+55316)T=X[T]n=g[n]L=v[B(484807+-528433)]n=n(g,V,D)O={[s]=n}T=T(X,o,f,O)X=B(-172456+128983)X=T[X]X=X(T)K={T}end end else if L<-111439+4651513 then if L<-886785+5417190 then if L<-339421+4807637 then K={}L=v[B(36062+-79809)]else L=I[z[705352+-705351]]o=I[z[-565200-(-565202)]]j=-751496+22222968070132 V=I[z[459776-459773]]c=B(444322+-488140)q=V(c,j)K=o[q]o=false L[K]=o K={}L=v[B(-234502+190309)]end else q=-823445+823477 f=515270+-515257 V=I[z[-633674-(-633677)]]o=V%q T=-267572+267574 c=I[z[208103+-208099]]g=I[z[718416+-718414]]l=I[z[-612020-(-612023)]]n=l-o l=-94156-(-94188)s=n/l O=f-s X=T^O f=-420635+420891 D=g/X j=c(D)c=4295579042-611746 q=j%c j=-784017+784019 X=-358998+358999 c=j^o V=q/c o=nil c=I[z[-178075-(-178079)]]g=V%X X=4295513448-546152 D=g*X g=70969+-5433 j=c(D)c=I[z[-548344-(-548348)]]D=c(V)q=j+D j=-542071-(-607607)c=q%j D=q-c j=D/g q=nil g=-643680+643936 D=c%g T=73477-73221 X=c-D g=X/T T=264974+-264718 L=968260+1199908 c=nil X=j%T V=nil O=j-X T=O/f O={D,g;X;T}j=nil X=nil g=nil T=nil I[z[-459212+459213]]=O D=nil end else if L<-353970+4934218 then if L<-790104+5336977 then q=I[z[-13295+13296]]X=B(-655202-(-611681))K=q[o]j=I[z[692980+-692978]]D=I[z[-133650-(-133653)]]T=11793809395061-899074 g=D(X,T)c=j[g]q=V[c]o=nil L=K[q]K=B(1046087+-1090082)K=L[K]V=nil K=K(L)K={}L=v[B(-157630-(-113520))]else K=T L=O L=T and-363059+5548126 or-325978+1336657 end else L=I[z[-12878+12882]]K=B(-554370-(-510370))K=L[K]K=K(L)L=589740+7620272 end end end else if L<201809+4644541 then if L<895836+3808633 then if L<15278+4658807 then if L<382200+4230909 then j,X=D(c,j)L=j and 8941362-258001 or 14269760-516509 else X=B(-487480-(-443941))j=v[X]O=I[D]s=I[c]p=B(-728513-(-684709))n=I[V]S=-792165+21893965594168 l=n(p,S)f=s[l]T=O..f X=j(T)L=X and 8007070-(-669414)or 6498110-(-172486)end else P=I[z[-992044+992045]]x=B(-220121+175995)n=f S=I[z[346598+-346596]]a=483828+24654408026852 u=S(x,a)m=B(502670-546708)m=l[m]J=P[u]m=m(l,J)L=m and 983291+14049634 or-878631+10494228 p=m end else if L<428146+4409061 then if L<3833332-(-967045)then c=B(-771581+727463)T=-58133+4384722299662 q=v[c]j=I[z[-980051+980052]]D=I[z[950032-950030]]X=B(-104389+60650)g=D(X,T)c=j[g]V=q[c]q=V()K=q L=q and 752707+9687570 or 10090117-(-782190)else o=M[299277+-299276]V=M[664045-664043]q=I[z[187500-187499]]K=q[o]L=not K L=L and 1032796+7647419 or 416698+1071342 end else q=nil V=nil c=nil K={}o=nil j=nil L=v[B(925460-969048)]end end else if L<4885975-(-94872)then if L<4674891-(-256987)then if L<5825219-968908 then T=-945184+945439 V=q X=763200+-763200 L=I[z[-225474+225475]]g=L(X,T)o[V]=g L=-419079+11474281 V=nil else L=X X=-904624.5-(-904625)D=g or X g=I[z[-697833+697840]]O=I[z[-709983-(-709985)]]n=I[z[-553414+553417]]m=B(152068+-195643)l=I[z[-1002108+1002112]]J=17589192201483-(-559859)p=l(m,J)L=15486203-900762 P=B(-510747+466609)S=6995391213584-(-1006761)s=n[p]f=j[s]T=O[f]s=I[z[-848780-(-848788)]]p=I[z[66117+-66114]]m=I[z[745781+-745777]]J=m(P,S)l=p[J]n=j[l]P=171842+2174762411186 J=B(-72860-(-29430))f=s[n]l=I[z[546697+-546694]]p=I[z[846635-846631]]m=p(J,P)n=l[m]J=157796+17952554285123 s=j[n]O=f*s n=I[z[1028687+-1028684]]l=I[z[90546-90542]]m=B(-859182+815702)P=-681616+22544989802386 p=l(m,J)s=n[p]f=j[s]l=I[z[569173-569170]]J=B(-352008+308208)p=I[z[641525-641521]]m=p(J,P)n=l[m]s=j[n]n=I[z[-412805-(-412814)]]X=g(T,O,D,f,s,n)D=nil end else X=B(-720489+676769)L={}I[z[-1046678+1046680]]=L j=-163459+35184372252291 K=I[z[927685+-927682]]c=K K=V%j I[z[-976653-(-976657)]]=K g=-830159-(-830414)D=V%g g=744435+-744433 j=D+g I[z[-706580-(-706585)]]=j O=1042834+-1042833 g=v[X]X=B(-442463+398646)D=g[X]g=D(o)f=O X=956858-956857 T=g L=3986993-988967 D=B(807513-850979)q[V]=D D=31811-31631 O=-480434+480434 s=f<O O=X-f end else if L<5971212-894855 then if L<5533294-513155 then K=I[z[509781+-509779]]L=B(650338+-694465)L=o[L]L=L(o,K)L=L and-286457+4164655 or 13697821-729874 else V=B(-514371-(-470738))K=v[V]g=499733+14561421048423 q=I[z[-517215-(-517216)]]D=B(-209624+165606)c=I[z[-895681-(-895683)]]j=c(D,g)g=-934714+16544910877010 o=M[-329180-(-329181)]V=q[j]D=B(-507890-(-464077))L=K[V]q=I[z[967468+-967467]]c=I[z[-937308+937310]]j=c(D,g)V=q[j]q=I[z[529625-529622]]g=B(586114+-630186)K=L(V,q)D=-881235+5180384410559 X=29981410769129-(-327072)V=K K=I[z[-586359+586360]]q=I[z[721922+-721920]]j=B(-1080464-(-1036302))c=q(j,D)L=K[c]c=I[z[-1020713+1020714]]j=I[z[787872+-787870]]D=j(g,X)q=c[D]j=B(810293-854476)K=q..o V[L]=K K=I[z[549620+-549619]]o=nil D=10327838739272-(-264065)q=I[z[-669998+670000]]c=q(j,D)L=K[c]K=true V[L]=K K={}L=B(-544783-(-501066))L=V[L]L=L(V)L=v[B(106258-150292)]V=nil end else s=I[z[152311-152310]]p=B(-829640+785864)n=I[z[952083-952081]]m=809783362459-(-179678)l=n(p,m)n=B(-277895+234247)f=s[l]P=568439+2409279969258 O=c[f]L=7872126-(-264965)s=v[n]l=I[z[2797-2796]]p=I[z[415143+-415141]]J=B(-743650-(-700230))m=p(J,P)n=l[m]f=s[n]T=O~=f g=T end end end end else if L<-531047+5952529 then if L<4531378-(-777564)then if L<4563874-(-618848)then if L<-537110+5687615 then if L<5098407-(-40237)then O,f=X(T,O)L=O and 72499+4181265 or 4750592-121259 else L=K and 898137+3486281 or 6307280-426801 end else if L<-175574+5341802 then L=c and 377247+10975731 or-509691+4589357 else l=I[z[328673+-328664]]p=true n=l==p L=3314356-209525 f=n end end else if L<5419701-142384 then if L<4629349-(-566134)then f=-840980+841045 T=b()O=-152157-(-152160)l=d(-35975+6333637,{})I[T]=K L=I[g]K=L(O,f)L=-138475-(-138475)f=L O=b()L=889301+-889301 I[O]=K n=B(152233+-196140)s=L K=v[n]P=B(-85490+42013)n={K(l)}L={H(n)}n=L K=-151625-(-151627)L=n[K]l=L K=B(515218-559239)L=v[K]p=I[q]J=v[P]P=J(l)J=B(-573390-(-529397))m=p(P,J)p={m()}K=L(H(p))p=b()L=12642243-235985 I[p]=K K=-734756-(-734757)m=I[O]J=m m=40662-40661 P=m m=353123-353123 S=P<m m=K-P else V=nil o=nil K={}L=v[B(478379-522493)]end else n=I[z[-379819-(-379820)]]J=630799+26163547574152 m=B(654593+-698384)l=I[z[-24416-(-24418)]]p=l(m,J)L=-364942+7610876 s=n[p]K=s end end else if L<4469302-(-876316)then if L<4741304-(-584234)then if L<-549898+5868367 then T=B(-120112+76339)D=I[z[-231022-(-231023)]]g=I[z[157889+-157887]]O=-34857+31533966606725 X=g(T,O)j=D[X]s=B(-163172+118988)c=o[j]X=B(-714031-(-670383))g=v[X]T=I[z[-708225+708226]]n=842745+24392431063141 O=I[z[911714+-911712]]f=O(s,n)X=T[f]D=g[X]X=I[z[-694482+694483]]T=I[z[360363+-360361]]f=B(780015-823513)s=15261134794142-(-224804)O=T(f,s)g=X[O]j=D[g]q=c==j L=q and-294151+12175031 or-812485+12029301 else K={}L=v[B(-616145+572382)]end else L=11188347-(-593510)end else if L<-387270+5785295 then if L<-881684+6272892 then s=B(252753-296750)L=517911-(-402633)O=true I[z[-586478+586489]]=O f=v[s]n=I[z[624453-624446]]p=I[z[-1012779-(-1012787)]]J=I[z[145757+-145755]]u=B(-732752+689208)x=23741452411413-423654 P=I[z[347871+-347868]]S=P(u,x)m=J[S]l=p[m]p=637077-637076 s=f(n,l,p)else j=B(-817642+774031)c=v[j]X=B(-108778-(-64723))g=v[X]P=24829198370605-481796 s=B(115294+-159516)n=16321865935395-(-340877)T=I[z[681395-681393]]l=B(-429177+385649)p=255912+12432186519285 O=I[z[-240528+240531]]f=O(s,n)X=T[f]D=g[X]x=B(-428074+384228)J=B(408386-451990)u=22007646943701-332237 T=I[z[364706+-364705]]i=21990092945744-(-454319)f=I[z[783665+-783663]]s=I[z[613362+-613359]]n=s(l,p)O=f[n]a=-844399+9083788948212 n=B(-531506+487892)X=T[O]s=v[n]l=I[z[443885-443883]]p=I[z[-667790-(-667793)]]m=p(J,P)n=l[m]f=s[n]l=I[z[641323-641322]]S=B(368696-412128)m=I[z[-341048-(-341050)]]J=I[z[138720+-138717]]L=-475662+11767526 j=B(913957-957894)P=J(S,u)p=m[P]n=l[p]m=I[z[-816277-(-816278)]]P=I[z[419521+-419519]]S=I[z[314936-314933]]u=S(x,a)J=P[u]P=B(472162-515968)p=m[J]J=v[P]S=I[z[-160455+160457]]j=c[j]a=B(-778951-(-735424))u=I[z[-23145-(-23148)]]x=u(a,i)P=S[x]S=977386-977387 m=J[P]P=504851-504851 u=-1020249+1020249 J=m(P,S,u)l=p+J s=f(n,l)n=I[z[781315-781313]]m=B(-815083-(-771373))J=77128+23872833535524 l=I[z[122311+-122308]]p=l(m,J)f=n[p]O=s[f]f=-266158-(-266162)T=O*f g=D(X,T)D=I[z[-349316-(-349320)]]j=j(c,g,D)V=j end else L=I[z[315762+-315761]]K=B(-606094-(-562094))K=L[K]K=K(L)L=nil I[z[474382-474381]]=L L=272549+13255762 end end end else if L<5758084-80957 then if L<-379938+5922248 then if L<649023+4791843 then if L<4969332-(-460929)then V=-180057+98035287772584 L=true o=B(-85912+41913)f=-211074+9730795244085 I[z[559405-559404]]=L K=v[o]o=K(V)o=B(-240434+196437)K=v[o]O=14664961030829-40961 V=I[z[903367-903365]]c=I[z[59122+-59119]]D=I[z[-125637+125641]]g=I[z[144949-144944]]T=B(722069-765761)X=g(T,O)j=D[X]q=c[j]c=513162-513162 j=-951567-(-951568)g=-1001447+10913314986944 D=B(291522-334929)o=K(V,q,c,j)q=I[z[-157903+157907]]c=I[z[-901438+901443]]n=B(-409790+365757)j=c(D,g)l=33713689566109-(-41398)V=q[j]K=o[V]V=B(971510-1015440)V=K[V]V=V(K)V=B(493169+-537166)K=v[V]q=I[z[-700097-(-700099)]]j=I[z[-80248+80251]]O=B(702491+-746252)g=I[z[-57839-(-57843)]]X=I[z[927381-927376]]T=X(O,f)D=g[T]c=j[D]j=1003695+-1003695 X=B(-608806-(-565078))D=-921960+921961 V=K(q,c,j,D)c=B(941438-985071)V=nil T=28357936507058-(-330467)q=v[c]j=I[z[-942280-(-942284)]]D=I[z[444263+-444258]]g=D(X,T)c=j[g]X=B(-778851+734993)K=q[c]j=I[z[86526+-86522]]D=I[z[122929+-122924]]T=-786659+38348849396 g=D(X,T)T=383149+30981555003309 c=j[g]q=K(c)c=b()I[c]=q K=I[c]j=I[z[20870-20866]]X=B(399399-443335)D=I[z[972599-972594]]g=D(X,T)q=j[g]X=I[z[-377392+377398]]O=I[z[-1025556+1025560]]f=I[z[31914-31909]]s=f(n,l)T=O[s]g=X[T]n=-586368+14020320316416 s=B(256807-300703)T=I[z[-770185-(-770189)]]O=I[z[112924-112919]]f=O(s,n)X=T[f]D=g[X]g=125687-125642 j=D*g X=B(664318-708192)K[q]=j K=I[c]j=I[z[-1035093-(-1035097)]]T=-165892+24774288733460 o=nil D=I[z[341502+-341497]]g=D(X,T)q=j[g]g=B(-35552-8254)D=v[g]f=B(41576+-85168)p=3979162188380-963360 s=674810+31513460878680 X=I[z[605814+-605810]]l=-127958+28467425322910 T=I[z[315327+-315322]]O=T(f,s)g=X[O]T=717261+282739 j=D[g]g=-837520+1837520 X=-23844+1023844 D=j(g,X,T)K[q]=D K=I[c]X=B(-289226-(-245737))T=-120356+2120431409663 j=I[z[-443619-(-443623)]]D=I[z[327253-327248]]g=D(X,T)n=-171073+22113539343482 q=j[g]j=I[z[1002595+-1002589]]K[q]=j K=false D=b()q=b()I[q]=K K=nil j=b()I[j]=K K=nil s=B(583141+-627248)I[D]=K g=I[z[36388-36381]]T=I[z[-941862+941866]]O=I[z[132028+-132023]]f=O(s,n)X=T[f]K=g[X]g=B(-713737-(-669563))g=K[g]X=F(-315584+9089793,{c,z[-380345-(-380349)],z[269703+-269698],z[179575+-179569]})g=g(K,X)I[D]=g X=I[z[842092-842086]]n=B(468001+-511553)O=I[z[-356030-(-356034)]]L=v[B(379533-423575)]f=I[z[591323-591318]]s=f(n,l)T=O[s]K=X[T]T=t(11563000-(-685799),{z[216759+-216757];z[-954820+954824];z[91604-91599],j,D,c;z[605075+-605072];z[-885195+885203];q;z[284298-284297]})X=B(-512191-(-468017))X=K[X]X=X(K,T)O=B(-435079+390961)I[j]=X T=v[O]f=I[z[-275149-(-275153)]]s=I[z[293907-293902]]l=B(802590-846476)n=s(l,p)O=f[n]K=T[O]O=343572+-343569 f=R(8765010-(-664659),{j;z[533273+-533269],z[398348+-398343],D;q,c;z[-330890+330892],z[-379706+379709];z[623992+-623991]})c=W(c)q=W(q)T=K(O,f)j=W(j)D=W(D)K={}else n=B(-861772+818031)l=178672+8701713815012 D=c O=I[z[-301378-(-301381)]]f=I[z[-935332+935336]]s=f(n,l)T=O[s]X=g[T]T=I[z[113844-113842]]L=X==T L=L and 5694314-(-599479)or 12899215-112149 end else L=11485873-(-295984)end else if L<-725393+6391398 then if L<-504518+6068407 then o=M[111964+-111963]V=M[630772-630770]q=M[-646872-(-646875)]D=M[362507+-362501]c=M[81478-81474]g=not c K=g j=M[-396369-(-396374)]L=g and 3989+6221920 or 13678986-388631 else L=K and 13962986-596078 or 8757674-104834 end else L=v[B(438472-482139)]K={}o=nil end end else if L<-444932+6201161 then if L<5064910-(-667906)then if L<6652374-955139 then a=-73298+73300 l=B(521946+-565499)n=v[l]S=B(1038453+-1082540)p=v[S]u=f[a]a=B(164182-208013)a=p[a]S={a(p,u)}L=15278775-(-428696)l=n(s,H(S))else L=I[z[-497391+497397]]J=5716914007511-484209 f=I[X]m=B(-918197-(-874419))n=I[z[887536-887534]]l=I[z[-39629+39632]]p=l(m,J)s=n[p]O=f[s]n=I[z[109280-109278]]l=I[z[-249513+249516]]m=B(944529+-988687)J=3215472516232-513711 p=l(m,J)s=n[p]f=g[s]D=O-f K=L(D)L=1283463-(-757606)end else l=B(-52995-(-9270))X=I[z[244042-244041]]f=B(158460+-201942)T=I[z[-270486+270488]]p=-277931+20894819427244 s=3405956420242-(-177056)O=T(f,s)g=X[O]O=B(-522827+479179)D=o[g]T=v[O]L=13077379-582399 f=I[z[-721599-(-721600)]]s=I[z[887025-887023]]n=s(l,p)O=f[n]n=B(-646611+602630)X=T[O]l=-449221+9508330185 O=I[z[-662793-(-662794)]]f=I[z[-974590-(-974592)]]s=f(n,l)T=O[s]g=X[T]j=D==g q=j end else if L<6410909-634674 then if L<6619053-850911 then I[V]=m L=I[V]L=L and-765439+803223 or 2316546-(-1040802)else T=B(916759+-960756)g=true I[z[-174771-(-174783)]]=g X=v[T]O=I[z[-822890-(-822897)]]L=6714407-(-721557)s=I[z[577875+-577867]]l=I[z[372762-372760]]p=I[z[-664439-(-664442)]]P=28603234660661-(-639698)J=B(-855704+811569)m=p(J,P)n=l[m]f=s[n]s=336927+-336926 T=X(O,f,s)end else T=20001292840519-(-603674)o=M[-436939-(-436940)]j=I[z[410419-410418]]X=B(547543-591771)D=I[z[853860+-853858]]f=B(595938+-639961)g=D(X,T)s=-224985+4253260560021 c=j[g]g=B(-136591-(-92943))q=o[c]D=v[g]X=I[z[312893-312892]]T=I[z[-1011837-(-1011839)]]O=T(f,s)g=X[O]f=391631+33894011028440 O=B(-723833-(-679797))j=D[g]g=I[z[586233+-586232]]X=I[z[754919+-754917]]T=X(O,f)D=g[T]c=j[D]V=q==c L=V and 8032686-804240 or 2024760-462235 K=V end end end end end else if L<-939241+7561395 then if L<-399558+6651161 then if L<1008112+5022603 then if L<4949708-(-985708)then if L<5864561-(-22487)then if L<-76107+5951518 then T=B(903597-947245)n=B(234493-278220)L=544333+3860113 X=v[T]O=I[z[-687233+687234]]l=8864042336562-28947 f=I[z[21131-21129]]s=f(n,l)T=O[s]n=-176763+26769411711788 g=X[T]T=I[z[-660618+660619]]O=I[z[-49239+49241]]s=B(408341+-452234)f=O(s,n)X=T[f]K=g[X]j=K else V=I[z[-158696-(-158701)]]c=B(-85689-(-41689))c=V[c]c=c(V)L=6675245-(-284265)end else if L<294147+5610557 then L=v[B(12958+-56659)]o=nil K={}else V=I[z[-42096-(-42097)]]c=I[z[-335427-(-335429)]]g=B(-676913-(-633439))X=-693219+8466888991561 j=I[z[12520-12517]]D=j(g,X)q=c[D]L=4848363-(-794768)o=V[q]K=o end end else if L<6081249-68976 then if L<-271798+6248097 then L=54059+3942548 else q=I[z[-305793-(-305800)]]L=q and-556679+16099078 or 804872+8170518 end else L=true L=L and-218887+2037138 or 7050188-(-483829)end end else if L<6627785-498700 then if L<421701+5657753 then if L<413346+5638412 then f=359083+19629946136841 L=4609784-(-548318)g=I[z[949625+-949622]]O=B(-1016821+972851)X=I[z[469694-469690]]T=X(O,f)D=g[T]j=q[D]c=j else L=I[z[688796-688785]]O=I[X]s=I[z[793401+-793399]]p=B(-828495+784402)n=I[z[749530+-749527]]m=716850+14784254945970 l=n(p,m)f=s[l]K=B(-1012173-(-968596))K=L[K]D=O[f]K=K(L,D)L=13756383-635394 end else o=M[183295+-183294]V=M[-959176-(-959178)]K=V L=V and 3459600-770139 or-595060+15870648 end else if L<216660+6023693 then if L<6943099-766737 then o=nil K={}L=v[B(-976918-(-933021))]else L=K and-774170+15579290 or 755447+8916925 end else L=K and 892673+3584092 or 3371402-(-625205)end end end else if L<6357522-(-28599)then if L<5681062-(-646621)then if L<5984041-(-313055)then if L<5985434-(-271290)then p=b()S=R(-102030+13269339,{p,T;O,j})U=B(-61000+17324)x=B(454193+-497734)l={}a={}I[p]=l l=b()I[l]=S D=nil e=B(-29604+-14099)S={}u=b()g=nil I[u]=S S=v[x]X=nil r=nil G=I[u]q=nil f=nil n=nil i={[e]=G,[U]=r}f=B(689026-732867)x=S(a,i)I[c]=x S=C(10736150-141955,{u,p;s;T,O,l})p=W(p)j=W(j)T=W(T)I[V]=S u=W(u)D=B(-13750+-29789)j=v[D]s=W(s)X=I[c]s=-322767+3439605216016 O=W(O)T=I[V]l=W(l)O=T(f,s)g=X[O]D=j(g)q=not D L=q and 121196+3325267 or-821535+12445487 else n=B(513075-557071)l=33453765922155-725137 T=B(-909848+865774)X=v[T]O=I[z[424967+-424964]]f=I[z[431372+-431368]]s=f(n,l)T=O[s]L=X[T]T=I[z[-665898+665903]]X=L(T,D)D=nil L=17646+8498785 g=nil end else V=B(77432+-121360)q=453640+15597350 K=7988654-(-166205)o=V^q L=K-o o=L K=B(-670161-(-626099))L=K/o K={L}L=v[B(805464+-849220)]end else if L<95688+6244381 then if L<-895828+7229826 then L=I[z[31945-31943]]L=L and-27987+8729315 or-273724+13009054 else K=B(280600+-324210)L=v[K]o=B(161303-205443)K=L(o)K={}L=v[B(383040+-426471)]end else X=nil g=nil L=13762357-(-173663)end end else if L<7571562-1038202 then if L<699307+5761351 then if L<6609285-155832 then L=v[B(521568+-565193)]K={}else L=true L=L and 13609174-167886 or-8412+12575145 end else q=M[-562997+563000]o=M[-114551-(-114552)]V=M[789445+-789443]j=I[z[369276-369275]]X=B(-896838+853139)s=794735+11674000143565 T=24590787755082-479120 L=B(-609342-(-565802))c=q D=I[z[859085-859083]]L=V[L]g=D(X,T)K=j[g]j=b()L=L(V,K)I[j]=L D=I[j]X=I[z[-1028953-(-1028954)]]f=B(764023+-807652)l=17193232639220-476590 T=I[z[141320+-141318]]O=T(f,s)g=X[O]K=D[g]T=B(707935+-751583)X=v[T]O=I[z[624755+-624754]]n=B(1016421+-1060424)f=I[z[-394627+394629]]s=f(n,l)T=O[s]s=B(-462843+419434)g=X[T]T=I[z[-595032+595033]]O=I[z[-886948+886950]]n=286751+12334940616272 f=O(s,n)X=T[f]D=g[X]L=K~=D L=L and 2790013-180618 or 443229+12744064 end else if L<134823+6468035 then if L<5946977-(-631806)then X=B(878427-922392)j=I[z[350067-350066]]D=I[z[-738364+738366]]T=619783+23415622403 g=D(X,T)c=j[g]q=o[c]j=I[z[496489-496486]]D=203735-203734 c=j[D]K=q==c L=K and 901469+3058636 or 10981195-128199 else X=-301142+9129406507249 V=I[z[778436+-778432]]g=B(901416+-945541)c=I[z[-976260-(-976262)]]j=I[z[-467621+467624]]D=j(g,X)L=8059511-723362 q=c[D]o=V[q]K=o end else o=M[897613+-897612]o=nil D=2102798049421-695482 j=B(-65139+21579)L=I[z[408777+-408776]]V=I[z[-977483-(-977485)]]q=I[z[-779745+779748]]c=q(j,D)K=V[c]V=true L[K]=V K={}L=v[B(384999+-428922)]end end end end else if L<-995691+8288505 then if L<-134163+7175291 then if L<7384051-566611 then if L<542312+6171719 then if L<-266755+6937286 then L=I[z[631325+-631318]]L=L and 16245763-263692 or 2501239-335997 else T=B(704883+-748477)l=B(-43618+190)j=v[T]f=I[c]p=252596+24328223740300 s=I[V]n=s(l,p)O=f[n]T={j(O)}L=v[B(916358+-960108)]K={H(T)}end else if L<857811+5950703 then V=nil L=v[B(99126+-142981)]K={}o=nil else K=false I[z[1011928-1011917]]=K D=false X=B(287608-331702)I[z[-103469+103481]]=D g=v[X]T=I[z[636825+-636818]]m=B(-836601-(-792718))f=I[z[-764807-(-764815)]]J=167244+11593970730954 n=I[z[-894668+894670]]l=I[z[463328+-463325]]p=l(m,J)s=n[p]O=f[s]m=B(666366+-710146)X=g(T,O)X=B(877569-921663)g=v[X]T=I[z[-805197+805204]]J=16742924116038-278994 f=I[z[-579781+579789]]L=4508461-(-336529)n=I[z[-248550+248552]]l=I[z[63102-63099]]p=l(m,J)s=n[p]O=f[s]X=g(T,O)end end else if L<6011828-(-915402)then if L<6199401-(-647051)then V=I[z[585675+-585673]]q=I[z[-305728+305731]]o=V==q L=16241181-(-447498)K=o else L=V and 11921521-(-279541)or 7737731-177799 end else o=nil L=v[B(-676265+632207)]K={}end end else if L<7643404-389030 then if L<-757100+7992257 then if L<-226514+7410088 then Z=I[V]BJ=Z L=Z and-417426+4321385 or-772709+1294285 else L=K and-859223+15428099 or-703196+6591788 end else L=f m=B(154617+-198552)O[L]=K K=I[z[502395-502394]]f=I[z[-846478+846480]]n=B(-22648+-20774)l=18301618165757-(-411981)s=f(n,l)L=K[s]s=B(-628213-(-584071))f=v[s]n=I[z[-122551+122552]]l=I[z[89904+-89902]]J=771386+17713034058494 p=l(m,J)s=n[p]l=175375+-175375 K=f[s]S=8513080515749-625961 J=21912195966685-(-213246)s=-737408+737408 n=-809260+809260 f=K(s,n,l)O[L]=f K=I[z[388842+-388841]]f=I[z[785707+-785705]]l=23896552094281-970450 n=B(-392663+348488)s=f(n,l)L=K[s]K=true m=B(532255+-575971)n=B(-9117-34312)l=1165192169904-(-931950)O[L]=K K=I[z[-985234+985235]]f=I[z[-112530+112532]]s=f(n,l)L=K[s]s=B(163096-207238)f=v[s]n=I[z[44084+-44083]]l=I[z[820051+-820049]]p=l(m,J)l=-355471-(-355726)s=n[p]K=f[s]n=694106-693851 s=364699+-364444 f=K(s,n,l)l=-240293+18979625307435 O[L]=f n=B(610420+-654551)K=I[z[-1026105+1026106]]P=4232805630644-(-394495)f=I[z[253023+-253021]]s=f(n,l)L=K[s]K=-413513-(-413513)n=B(-1089706-(-1045601))O[L]=K l=11350954748448-(-617093)K=I[z[-468527-(-468528)]]f=I[z[953776+-953774]]s=f(n,l)n=B(541530-585178)L=K[s]J=B(155053+-198758)s=v[n]l=I[z[-574533-(-574534)]]p=I[z[248637-248635]]m=p(J,P)n=l[m]f=s[n]n=I[z[387469-387468]]J=25197771961014-(-162591)l=I[z[-531910+531912]]m=B(-132867+89308)p=l(m,J)s=n[p]K=f[s]O[L]=K n=B(573631-617609)p=B(-177837-(-134431))l=11656726954844-(-315864)K=I[z[601028+-601027]]f=I[z[396955+-396953]]s=f(n,l)L=K[s]K=true O[L]=K m=-236738+23138530494168 f=B(-390847-(-347214))K=v[f]s=I[z[212915+-212914]]n=I[z[992834+-992832]]l=n(p,m)f=s[l]L=K[f]p=B(645719-689445)s=I[z[610645-610644]]n=I[z[983696+-983694]]m=-771146+30478475230138 l=n(p,m)P=-871021+17801194859214 f=s[l]l=B(234464+-277957)K=L(f)f=K p=833734+13416470912929 K=I[z[-636240-(-636241)]]s=I[z[676608-676606]]n=s(l,p)L=K[n]p=30280070244205-(-855975)K=j f[L]=K J=B(408252-451989)K=I[z[414091-414090]]s=I[z[333139+-333137]]l=B(738843-782428)n=s(l,p)L=K[n]p=32506105097475-881123 K=-920262-(-920263)l=B(783774+-827601)f[L]=K K=I[z[-165187-(-165188)]]s=I[z[-246261+246263]]n=s(l,p)L=K[n]n=B(-479733+436281)s=v[n]l=I[z[933121+-933120]]p=I[z[-423989-(-423991)]]m=p(J,P)n=l[m]m=-784961-(-784961)l=-494104+494104 K=s[n]n=.29 p=.54 J=B(-1036016+992593)s=K(n,l,p,m)f[L]=s p=-249175+8555049671910 l=B(-499069-(-455084))K=I[z[516770+-516769]]s=I[z[-579804-(-579806)]]n=s(l,p)L=K[n]n=B(-1030281+986829)P=2493328836504-(-130289)s=v[n]l=I[z[-819694-(-819695)]]p=I[z[1031166+-1031164]]m=p(J,P)n=l[m]p=.31 K=s[n]P=B(-153653+110030)n=.68 m=348890-348890 l=-654746+654746 s=K(n,l,p,m)p=905469+7841365359942 l=B(-928372-(-884933))f[L]=s K=I[z[-116274-(-116275)]]s=I[z[149280+-149278]]n=s(l,p)l=B(858755-902403)L=K[n]n=v[l]p=I[z[631284-631283]]m=I[z[767604-767602]]J=m(P,S)l=p[J]P=1036857+30591290221932 J=B(-257667+213874)s=n[l]l=I[z[731591+-731590]]p=I[z[-305145+305147]]m=p(J,P)n=l[m]K=s[n]f[L]=K K=I[z[-399813-(-399814)]]s=I[z[-460508-(-460510)]]p=341846+14033568539184 l=B(-1012764+969083)n=s(l,p)L=K[n]s=L K=V L=V and 614280-(-747661)or-31083+3633201 end else if L<850395+6432042 then if L<8036155-780135 then X=B(-1006377-(-962462))j=v[X]f={j(q)}L=5508210-394935 X=f[-873457-(-873458)]O=f[-844398-(-844401)]T=f[-672+674]else X=O P=B(474033+-517753)J=v[P]P=B(1013550+-1057631)m=J[P]J=m(o,X)m=I[z[721847-721841]]P=m()p=J+P l=p+D p=-1025413+1025669 n=l%p p=q[V]X=nil D=n P=-366173-(-366174)J=D+P L=-306244+3304270 m=c[J]l=p..m q[V]=l end else L=I[z[-601608+601609]]D=-806272+32194517354511 V=I[z[-487595+487597]]o=M[-1015491-(-1015492)]j=B(-409933-(-366499))q=I[z[502932-502929]]c=q(j,D)K=V[c]V=o L[K]=V o=nil L=v[B(883535-927292)]K={}end end end else if L<191472+7299226 then if L<453767+6931774 then if L<-801103+8155448 then if L<8041101-698061 then L=K and 5176794-580325 or 678253+7531759 else L=X L=g and 792735+8394470 or 478696+13053821 end else f=B(-810066-(-766548))T=B(382174+-425754)K=B(-191124-(-147513))l=B(845919+-889420)j=B(-736795+692740)s=92919+19779501586691 O=133326+5286966034639 L=v[K]p=-76558+26016176101984 c=v[j]D=I[z[-45338+45340]]S=30883952487721-(-297732)g=I[z[-94555+94558]]X=g(T,O)j=D[X]q=c[j]D=I[z[-275704-(-275708)]]X=I[z[182189+-182187]]T=I[z[754774-754771]]O=T(f,s)g=X[O]O=B(843430-887044)m=B(-195829+152032)j=D[g]T=v[O]f=I[z[1010338+-1010336]]u=15510090590751-151017 J=11077408130709-356975 s=I[z[331516-331513]]n=s(l,p)O=f[n]X=T[O]f=I[z[-735899+735903]]n=I[z[-835809-(-835811)]]l=I[z[-1037513-(-1037516)]]p=l(m,J)s=n[p]O=f[s]n=I[z[-947767-(-947771)]]P=B(145374+-189518)p=I[z[875993-875991]]m=I[z[66140-66137]]J=m(P,S)l=p[J]p=B(-565356-(-521550))s=n[l]l=v[p]S=B(-2491-41330)m=I[z[682929-682927]]J=I[z[767539-767536]]P=J(S,u)J=-533472+533472 p=m[P]n=l[p]m=303807-303808 p=271906-271906 l=n(p,m,J)f=s+l l=24855051352324-(-390194)T=X(O,f)O=I[z[-888280+888282]]n=B(-1021651+977730)f=I[z[738910+-738907]]s=f(n,l)X=O[s]g=T[X]X=-87233-(-87237)D=g*X f=13933371779532-(-257932)c=q(j,D)q=I[z[401051-401044]]j=B(335814+-379751)j=L[j]j={j(L,c,q)}c=I[z[-118544-(-118548)]]K=j[1028090-1028089]O=655006+27642314994601 T=B(695755-739203)D=I[z[707033+-707031]]q=K V=j[-526704-(-526706)]g=I[z[-497382-(-497385)]]X=g(T,O)O=B(736937-780552)j=D[X]K=c[j]T=-239110+2092191410644 X=B(325251+-369142)j=I[z[881536+-881534]]D=I[z[-818273+818276]]g=D(X,T)c=j[g]L=K[c]c=L j=I[z[-651168+651172]]g=I[z[946371-946369]]X=I[z[-434484-(-434487)]]T=X(O,f)D=g[T]O=-747277+13169705795329 K=j[D]T=B(-220446+176965)D=I[z[-474623+474625]]g=I[z[661224-661221]]X=g(T,O)g=-788312-(-788313)j=D[X]L=K[j]D=c<g j=L K=D L=D and 13441942-687401 or-741560+12220266 end else if L<7421429-(-14013)then if L<7346409-(-80078)then f,l=s(O,f)L=f and 5200215-516604 or 15862378-675415 else g=B(-740406+696559)c=I[z[-441752-(-441753)]]o=M[-930475-(-930476)]j=I[z[93490+-93488]]X=4243753050681-596609 O=B(764359-808114)V=M[811608+-811606]D=j(g,X)q=c[D]K=o[q]D=B(682012-725660)j=v[D]g=I[z[-619630-(-619631)]]f=25805153588596-288388 X=I[z[389065+-389063]]T=X(O,f)D=g[T]T=B(841042-884877)c=j[D]D=I[z[89024+-89023]]O=-560079+12035941736883 g=I[z[-86324-(-86326)]]X=g(T,O)j=D[X]q=c[j]L=K==q L=L and 995053+10170826 or-863329+12063683 end else f=B(541759+-585853)T=false S=B(587285+-631212)X=false I[z[-155429+155439]]=X I[z[722179-722168]]=T O=v[f]s=I[z[-288829+288836]]l=I[z[-668313-(-668321)]]m=I[z[963946-963944]]J=I[z[79174+-79171]]u=33647001692083-27263 P=J(S,u)p=m[P]n=l[p]f=O(s,n)L=-690161+5535151 f=B(-95037+50943)O=v[f]s=I[z[-903892-(-903899)]]S=B(-691464+647602)l=I[z[996154-996146]]m=I[z[868960+-868958]]J=I[z[-465910-(-465913)]]u=667094+392904889056 P=J(S,u)p=m[P]n=l[p]f=O(s,n)end end else if L<-786770+8358903 then if L<7003185-(-540362)then if L<8257568-726858 then f=23558561699096-109118 j=I[z[59461-59460]]c=j[o]g=I[z[-47354+47356]]X=I[z[738490-738487]]O=B(269091-313077)T=X(O,f)D=g[T]j=V[D]K=c[j]L=not K L=L and 14066883-786387 or-39297+11199009 else L=t(8402307-392050,{c})J={L()}K={H(J)}L=v[B(-78745-(-35337))]end else f=B(-697782-(-654358))s=15703775954985-600985 X=I[z[448471+-448470]]c=L T=I[z[-110284+110286]]O=T(f,s)g=X[O]D=o[g]O=B(-363449-(-319801))l=B(222874+-266800)T=v[O]p=22575707577951-275791 f=I[z[-618100-(-618101)]]s=I[z[528989-528987]]n=s(l,p)l=-48211+14200229893671 O=f[n]X=T[O]O=I[z[406455+-406454]]n=B(199078+-243307)f=I[z[-870359-(-870361)]]s=f(n,l)T=O[s]g=X[T]j=D==g q=j L=j and 490863+12004117 or 6488383-745762 end else if L<8072596-326213 then if L<7952922-307607 then L=-511633+511633 o=L L=5763916-994221 else L=2271298-846606 end else c=I[z[942885-942884]]V=L D=I[z[-519709+519711]]g=I[z[-799404+799407]]O=-577198+9993663504603 T=B(917788+-961912)X=g(T,O)j=D[X]q=c[j]o=q L=q and 369147+13107750 or 14639559-(-178737)end end end end end end end else if L<12633518-228825 then if L<9752870-(-664698)then if L<201381+8561094 then if L<978337+7531052 then if L<7869333-(-282516)then if L<8258247-187146 then if L<8609110-646929 then if L<7045023-(-739298)then p=m L=J L=15193106-160181 else c=I[z[-96791-(-96793)]]j=I[z[-110539-(-110542)]]X=1036620+12929465845304 g=B(-825492+781518)D=j(g,X)X=872526+20978976232923 q=c[D]K=o[q]c=I[z[305654+-305652]]g=B(-213948-(-170266))j=I[z[451877-451874]]D=j(g,X)q=c[D]L=K==q L=L and-51452+5376914 or-90059+1805619 end else if L<-241355+8270996 then L=-227757+6682762 else L=v[B(-681041+636943)]K={}end end else if L<748594+7389696 then if L<8397417-263388 then o=M[364277-364276]c=I[z[-1010102-(-1010103)]]j=I[z[230593-230591]]g=B(-983842-(-940003))X=23464754340915-(-1033851)D=j(g,X)q=c[D]V=o==q L=V and 15784046-502479 or 9983118-(-778757)K=V else L=X L=5238952-(-986957)K=g end else L=I[z[-596190+596191]]o=I[z[573363-573361]]j=4733271640347-884863 V=I[z[-787173+787176]]c=B(9750-53920)q=V(c,j)K=o[q]o=622686+-622686 L[K]=o L=-1033581+17025983 end end else if L<8005083-(-421998)then if L<8514353-184963 then if L<7922912-(-300845)then j=211299+2497845873448 L=I[z[967012+-967007]]c=B(-991283-(-947773))o=I[z[-399142-(-399144)]]V=I[z[-455781+455784]]q=V(c,j)K=o[q]o=I[z[769850+-769844]]j=-315915+3115115108277 L[K]=o X=-731884+33281602955125 L=I[z[-544462+544467]]c=B(172055+-215616)o=I[z[-921740-(-921742)]]V=I[z[181807-181804]]g=B(-201954+157758)q=V(c,j)K=o[q]c=B(-894604+851107)o=I[z[-718540-(-718547)]]L[K]=o L=I[z[-1029609+1029614]]o=I[z[787402-787400]]j=13818251703890-(-25296)V=I[z[-238008-(-238011)]]q=V(c,j)K=o[q]q=B(343047-386661)V=v[q]c=I[z[-438558+438560]]j=I[z[-689494+689497]]D=j(g,X)q=c[D]o=V[q]q=-723862+723862 j=126740-126740 c=223622+-223637 V=o(q,c,j)L[K]=V L=true I[z[-757604-(-757612)]]=L K={}L=v[B(285692-329238)]else L=true I[z[676340+-676339]]=L L=v[B(916744+-960621)]K={}end else K={}L=v[B(-44844+1161)]end else if L<8237624-(-224563)then if L<-476889+8928549 then K=true f=827855+2759130571573 V=B(143066-186848)L=true I[z[468421-468420]]=L I[z[-914113+914115]]=K o=v[V]V=o()V=B(887235-931232)o=v[V]q=I[z[-2183+2186]]O=B(739438-783161)j=I[z[697097-697093]]L=v[B(306968-350810)]g=I[z[136500-136495]]X=I[z[-148956+148962]]T=X(O,f)D=g[T]c=j[D]j=-301641-(-301642)V=o(q,c,j)X=33121359107271-465032 q=B(71127-115126)K={}c=373066+11849134 o=v[q]q=o(c)c=I[z[-260034-(-260039)]]g=B(374913-419046)j=I[z[230815-230809]]D=j(g,X)q=c[D]o=V[q]q=B(375572-419502)q=o[q]q=q(o)o=false I[z[-757644+757645]]=o q=false I[z[109061-109059]]=q c=I[z[976743+-976736]]j=c()j=B(824690-868322)c=v[j]V=nil j=c()else K=I[z[-663712-(-663716)]]q=-242424+242425 L=K+q I[z[-566119+566123]]=L q=I[z[-459965-(-459969)]]j=I[z[-199993-(-199996)]]c=#j K=q>c L=K and 12138981-(-317287)or 4402649-(-1045622)end else D=L L=B(-424116+380643)g=338072+-338071 L=c[L]j=q or g L=L(c,j)L=441699-(-616234)end end end else if L<904732+7775204 then if L<9579653-959252 then if L<510894+8041325 then if L<-856738+9366876 then l=I[z[545069-545063]]p=false s=L n=l==p f=n L=n and-597456+5766011 or-66836+3171667 else L=I[z[-253865+253871]]q=L()L=I[z[-954908-(-954915)]]q=B(248247+-291964)q=L[q]q=q(L)c=I[z[-403518+403523]]q=#c c=-287383-(-287386)L=q>c L=L and-783121+14908181 or-175752+5416752 end else L=I[z[-649142-(-649143)]]L=L and 9244366-(-315744)or 2150228-622675 end else if L<8093012-(-585971)then if L<31325+8640753 then o=I[z[876886+-876882]]K=o L=o and 6921708-340301 or 6293304-(-1042845)else T=B(-365078-(-321445))l=18046556704419-(-676400)i=22967319941123-(-874947)X=v[T]O=I[c]n=B(-26867+-16820)f=I[V]s=f(n,l)n=B(-710874-(-667246))T=O[s]j=X[T]l=266721+10639395340665 O=I[c]f=I[V]s=f(n,l)T=O[s]n=B(720379+-764494)X=j(T)I[g]=X a=B(671960-715704)j=I[g]O=I[c]f=I[V]L=9956977-356290 l=5520019185411-(-551687)s=f(n,l)f=B(636072+-679512)T=O[s]O=v[f]n=I[D]p=I[c]S=I[V]u=S(a,i)l=p[u]s=n..l f=O(s)j[T]=f j=I[g]O=I[c]l=30984786943373-(-711375)f=I[V]n=B(-565763-(-521692))s=f(n,l)T=O[s]l=20331949161974-(-141061)O=-40360+40360.5 j[T]=O j=I[g]n=B(-379773-(-336170))O=I[c]f=I[V]s=f(n,l)T=O[s]O=nil j[T]=O j=I[g]l=203610+27951605389181 O=I[c]n=B(250094+-294066)f=I[V]s=f(n,l)T=O[s]O=true j[T]=O end else K={}L=v[B(-816842+773343)]o=nil end end else if L<9586518-893687 then if L<-115810+8802076 then if L<524755+8157377 then L=I[z[903427+-903426]]K={}L[o]=K L=1174020-(-314020)else l=B(815914+-860070)g=j p=-880465+23679552100963 f=I[z[-446627+446629]]s=I[z[-129011+129014]]n=s(l,p)O=f[n]T=V[O]L=g~=T L=L and 1250074-882253 or 389769+461161 end else L=K and-647134+11458957 or 14815725-149379 end else if L<9622921-921336 then if L<9537258-836582 then K={}L=v[B(-535425+491909)]else K={}L=v[B(936375-980443)]end else I[V]=K L=13148269-798739 end end end end else if L<970487+8644767 then if L<8564529-(-698966)then if L<717365+8264922 then if L<-862454+9709145 then if L<-905907+9682895 then L=I[z[326290+-326289]]c=B(-766175+722602)o=I[z[547894+-547892]]V=I[z[307858+-307855]]j=634312+12145558284367 q=V(c,j)K=o[q]c=I[z[612629+-612625]]D=I[z[99325+-99323]]T=B(286117-330208)g=I[z[650167-650164]]O=12698055724720-(-2152)X=g(T,O)T=-158779+24925308606865 j=D[X]q=c[j]j=I[z[-170807-(-170809)]]X=B(-669769-(-625570))D=I[z[108847+-108844]]g=D(X,T)c=j[g]V=q[c]q=857359+-857314 o=V*q L[K]=o K={}L=v[B(128825-172585)]else D=I[z[-472935+472936]]T=B(-342468+298379)g=I[z[-314123+314125]]O=-428913+32272558835237 s=B(-621319+577468)X=g(T,O)j=D[X]c=o[j]X=B(-884264-(-840616))g=v[X]T=I[z[-559177-(-559178)]]n=10485048392242-(-39136)O=I[z[66835+-66833]]f=O(s,n)X=T[f]D=g[X]X=I[z[642256-642255]]T=I[z[953544-953542]]s=23953399101029-461523 f=B(164526+-208007)O=T(f,s)g=X[O]j=D[g]q=c==j L=q and 863367+15348809 or 4321227-290267 end else if L<8727948-(-226907)then L=I[z[-664619+664628]]L=L and-105734+2881714 or 11782158-(-402994)else q=true L=529995+6233635 I[z[85267+-85259]]=q end end else if L<-895538+10007359 then if L<279931+8795445 then L=true L=L and-874274+3243217 or 11527626-(-864594)else s=I[z[-633461-(-633462)]]m=32933223770422-208207 p=B(-534583+490929)n=I[z[-184237-(-184239)]]L=604814+1380845 l=n(p,m)f=s[l]T=f end else X=I[z[-539589+539601]]T=false g=X==T L=g and 6067216-296523 or-362075+7798039 end end else if L<-448959+9942953 then if L<8956261-(-423317)then if L<10183878-889074 then vJ=757898+-757897 Z=L E=U[vJ]vJ=false r=E==vJ BJ=r L=r and 15440163-864331 or 227562+3583809 else K=B(158646-202653)L=v[K]K=L()L=v[B(125422-169022)]K={}end else K=I[z[-936309+936310]]D=523082+8497858319403 V=I[z[1032395+-1032393]]j=B(-87890-(-43719))q=I[z[178897+-178894]]c=q(j,D)o=V[c]L=K[o]L=L and 747076+243085 or 13261169-(-763083)end else if L<120760+9471082 then if L<500602+9058005 then X=L O=-636059+636060 T=c>O L=T and-61385-(-834225)or 6701803-(-648845)g=T else L=v[B(291247-334890)]K={}end else a=491062+11540591023816 s=B(432286+-475726)e=B(180171-224319)zJ=-162049+162050 u=B(714126-757622)O=B(652910+-696997)T=v[O]f=v[s]E=723161+7664162833687 O=B(-693162-(-649447))l=I[c]p=I[V]O=T[O]S=p(u,a)cJ=664868-664868 n=l[S]s={f(n)}vJ=390798+-390798 O=O(T,H(s))f=-1002146-(-1002206)T=-667191+667192 r=B(-641163-(-597605))j=O[T]O=B(189144-232667)T=v[O]O=T(f)f=B(687406-731493)u=14222829143325-650046 S=B(-240101-(-196316))i=13447898838055-(-697423)T=v[f]n=I[c]l=I[V]p=l(S,u)s=n[p]u=B(-984169+940093)f=B(-441960+398012)f=T[f]f=f(T,s)T=b()a=33974969644496-(-657404)HJ=314056+-314055 I[T]=f s=B(105511+-149598)f=v[s]s=B(-622552+578604)G=14389895438033-476325 s=f[s]k=-1005982+1005982 l=I[c]p=I[V]S=p(u,a)n=l[S]s=s(f,n)f=b()n=B(-733732+689645)I[f]=s s=v[n]p=I[c]a=B(195128-239358)S=I[V]n=B(-872368-(-828420))hJ=254704+-254703 MJ=760421-760421 n=s[n]u=S(a,i)l=p[u]n=n(s,l)s=-1030930+1030930.5 IJ=-189758+189758 l=b()p=b()I[l]=s s={}I[p]=s u=I[c]a=I[V]LJ=7845+-7845 i=a(e,G)S=u[i]i=B(-145627+102013)QJ=-853520-(-853520)a=v[i]e=I[c]G=I[V]VJ=745928-745928 U=G(r,E)i=e[U]G=-1010205+1010205 E=414957+-414957 e=-72479-(-72480)r=677169-677169 qJ=552755-552755 U=854287-854288 dJ=662645-662645 u=a[i]y=408984+-408983 i=828848-828848 a=u(i,e,G,U,r,E,vJ,k,y,LJ,HJ,MJ)DJ=280972+2319706520236 i=I[c]r=170709+1812350888054 U=B(254505-298247)e=I[V]G=e(U,r)u=i[G]G=B(503717-547331)k=11955117788397-(-2258)e=v[G]U=I[c]vJ=B(-214029+170542)LJ=-601821+601821 r=I[V]RJ=293302-293302 E=r(vJ,k)vJ=186322+-186322 r=-243393-(-243393)HJ=946050-946049 G=U[E]k=-1008714+1008714 y=983187-983187 i=e[G]E=-596232+596231 G=236159-236159 U=-541530-(-541530)MJ=992529-992529 e=i(G,U,r,E,vJ,k,y,LJ,HJ,MJ,zJ,QJ)G=I[c]E=B(-177241-(-133277))U=I[V]vJ=32522537988026-(-19310)LJ=5251956086276-134263 zJ=152766-152766 r=U(E,vJ)y=B(-274353+230657)NJ=136465+-136465 i=G[r]MJ=-555405-(-555406)r=B(577206-620820)U=v[r]E=I[c]vJ=I[V]KJ=-179700-(-179700)k=vJ(y,LJ)QJ=65370+-65371 r=E[k]G=U[r]y=181488+-181488 E=-412295.5-(-412296)HJ=919505+-919505 k=-22301+22301 vJ=140823-140823 LJ=-377250-(-377251)r=-907301-(-907302)U=G(r,E,vJ,k,y,LJ,HJ,MJ,zJ,QJ,NJ,KJ)QJ=691814+-691813 r=I[c]y=18397534738694-161679 k=B(-716959+672915)HJ=B(408014-451584)E=I[V]vJ=E(k,y)G=r[vJ]vJ=B(449936-493550)E=v[vJ]k=I[c]y=I[V]MJ=-548248+5471793276812 wJ=277954+-277954 oJ=84494+-84494 LJ=y(HJ,MJ)vJ=k[LJ]y=-840403+840403 NJ=909453+-909453 LJ=-246688+246688 KJ=815995-815994 jJ=-652259-(-652259)k=415093.5-415093 HJ=-264848-(-264848)r=E[vJ]vJ=-688165+688164 zJ=-346167-(-346167)bJ=-437103+437103 MJ=305682+-305683 E=r(vJ,k,y,LJ,HJ,MJ,zJ,QJ,NJ,KJ,IJ,oJ)HJ=17154+20356236747269 vJ=I[c]OJ=-685604+6846558683800 k=I[V]QJ=22928525564419-(-151473)LJ=B(-85254+41836)y=k(LJ,HJ)r=vJ[y]y=B(-51618+8004)pJ=8088857353286-(-766576)k=v[y]LJ=I[c]HJ=I[V]zJ=B(-701478+657958)MJ=HJ(zJ,QJ)y=LJ[MJ]zJ=-771119+771119 LJ=-978771+978770 HJ=-89468+89468 IJ=-490840+490840 MJ=745024-745024 oJ=824091+-824092 NJ=-930539+930539 KJ=432688-432687 vJ=k[y]QJ=-191558+191559 y=-514231+514232 WJ=227586+-227585 k=vJ(y,LJ,HJ,MJ,zJ,QJ,NJ,KJ,IJ,oJ,bJ,VJ)AJ=-957799+957799 NJ=B(792378-836569)y=I[c]LJ=I[V]zJ=700618+18113206136872 KJ=-157709+2622878837970 MJ=B(-839749+795554)HJ=LJ(MJ,zJ)vJ=y[HJ]bJ=-846798+846798 HJ=B(-748193-(-704579))LJ=v[HJ]MJ=I[c]gJ=-409152+409152 zJ=I[V]SJ=34583445026548-981004 oJ=-289345-(-289346)QJ=zJ(NJ,KJ)HJ=MJ[QJ]VJ=741408+-741407 MJ=329927-329928 NJ=101251+-101251 QJ=-924388+924388 KJ=-744305+744304 IJ=358533+-358533 y=LJ[HJ]HJ=-38898+38897 zJ=898637-898637 LJ=y(HJ,MJ,zJ,QJ,NJ,KJ,IJ,oJ,bJ,VJ,qJ,cJ)HJ=I[c]MJ=I[V]NJ=113585+2822123850097 QJ=B(532098+-576235)zJ=MJ(QJ,NJ)VJ=-363410-(-363410)y=HJ[zJ]qJ=466471+-466470 zJ=B(473646-517260)IJ=B(-641237-(-597426))MJ=v[zJ]QJ=I[c]oJ=16705609797367-(-479084)NJ=I[V]KJ=NJ(IJ,oJ)cJ=-999245-(-999245)zJ=QJ[KJ]HJ=MJ[zJ]QJ=-339094+339095 KJ=-58854+58853 bJ=-166610-(-166610)FJ=235963+-235963 zJ=-91822+91822 NJ=-397884+397884 oJ=289025-289025 IJ=-961594+961594 MJ=HJ(zJ,QJ,NJ,KJ,IJ,oJ,bJ,VJ,qJ,cJ,WJ,jJ)bJ=B(-1010950-(-967284))WJ=692725-692724 zJ=I[c]IJ=-385688+21261456951620 VJ=258262+22591379503169 QJ=I[V]KJ=B(27238-71119)NJ=QJ(KJ,IJ)HJ=zJ[NJ]NJ=B(12540-56154)QJ=v[NJ]KJ=I[c]IJ=I[V]oJ=IJ(bJ,VJ)bJ=71190-71190 VJ=414389+-414389 NJ=KJ[oJ]IJ=-124791-(-124791)zJ=QJ[NJ]jJ=31223-31223 oJ=815021-815022 KJ=818763-818763 NJ=-916894-(-916894)qJ=-633797+633797 CJ=294090+-294090 cJ=388772+-388772 QJ=zJ(NJ,KJ,IJ,oJ,bJ,VJ,qJ,cJ,WJ,jJ,hJ,RJ)qJ=B(-482917+439502)bJ=2213043340312-(-606190)NJ=I[c]KJ=I[V]oJ=B(-31762+-12183)IJ=KJ(oJ,bJ)tJ=-758775-(-758775)zJ=NJ[IJ]jJ=-570408-(-570409)IJ=B(895484-939098)RJ=917121+-917122 WJ=-133418+133418 KJ=v[IJ]cJ=6825616890458-(-586256)oJ=I[c]bJ=I[V]VJ=bJ(qJ,cJ)IJ=oJ[VJ]qJ=475131-475131 bJ=-79522-(-79522)NJ=KJ[IJ]IJ=144229-144228 cJ=217640-217639 hJ=-655322+655322 oJ=-311285.5-(-311286)VJ=-526969+526969 KJ=NJ(IJ,oJ,bJ,VJ,qJ,cJ,WJ,jJ,hJ,RJ,dJ,tJ)IJ=I[c]VJ=B(652283+-695948)WJ=B(-124786+80678)qJ=9300973341660-883441 oJ=I[V]bJ=oJ(VJ,qJ)NJ=IJ[bJ]bJ=B(787264+-830878)oJ=v[bJ]jJ=20259600631221-(-696101)VJ=I[c]RJ=-10375-(-10376)hJ=972305-972305 YJ=-707619+707619 qJ=I[V]dJ=857672+-857672 cJ=qJ(WJ,jJ)bJ=VJ[cJ]WJ=-894135+894135 IJ=oJ[bJ]VJ=203163+-203162.5 qJ=-825057+825057 cJ=-303250-(-303250)tJ=561058-561057 bJ=655580+-655581 jJ=-955634-(-955633)oJ=IJ(bJ,VJ,qJ,cJ,WJ,jJ,hJ,RJ,dJ,tJ,CJ,wJ)bJ=I[c]cJ=B(795808-839514)WJ=12673+17465013087811 hJ=B(254044-298101)VJ=I[V]qJ=VJ(cJ,WJ)IJ=bJ[qJ]dJ=-43233+43233 tJ=-956844+956845 qJ=B(968829+-1012443)VJ=v[qJ]cJ=I[c]RJ=-320848+14820992532549 WJ=I[V]jJ=WJ(hJ,RJ)qJ=cJ[jJ]hJ=-62567+62567 WJ=467668-467668 bJ=VJ[qJ]qJ=-804674-(-804675)jJ=-865434+865434 wJ=601314+-601315 cJ=511961+-511962 CJ=524959-524959 RJ=-417951-(-417952)VJ=bJ(qJ,cJ,WJ,jJ,hJ,RJ,dJ,tJ,CJ,wJ,YJ,AJ)jJ=B(-847651-(-803817))qJ=I[c]XJ=B(-666860-(-623381))cJ=I[V]hJ=-1002070+8042551056631 dJ=B(-548154+504015)WJ=cJ(jJ,hJ)wJ=-965724-(-965725)bJ=qJ[WJ]WJ=B(142333-185947)cJ=v[WJ]tJ=144402+13265428505615 jJ=I[c]hJ=I[V]RJ=hJ(dJ,tJ)YJ=-446443-(-446443)CJ=37398+-37398 dJ=188513+-188513 WJ=jJ[RJ]hJ=451905-451905 jJ=144941-144942 qJ=cJ[WJ]tJ=306915-306916 WJ=-1027811+1027810 RJ=-545794-(-545794)AJ=-551244-(-551245)cJ=qJ(WJ,jJ,hJ,RJ,dJ,tJ,CJ,wJ,YJ,AJ,FJ,gJ)s={[S]=a,[u]=e;[i]=U,[G]=E;[r]=k,[vJ]=LJ,[y]=MJ,[HJ]=QJ,[zJ]=KJ,[NJ]=oJ;[IJ]=VJ,[bJ]=cJ}u=w(403650+5148162,{c;V,T})i=B(779517-823704)S=b()CJ=-209613+25572678574417 E=b()I[S]=s s=b()e=b()I[s]=u hJ=758560+2317600518423 u=d(6729106-217805,{c;V;f;s,S,l})TJ=-1047120+1854563384751 a=I[p]a[i]=u fJ=9456951540962-(-300113)dJ=3206078173180-707112 VJ=34140148678984-(-982225)G=false u=false WJ=-694570+29445824122553 k=b()i=false r=true zJ=B(994592+-1038240)U=false I[e]=u qJ=1220702678495-(-365657)u=b()a=false I[u]=a y=b()vJ=-801234-(-801235)a=b()I[a]=i i=false I[E]=i i=b()I[i]=G G=b()I[G]=U U=b()I[U]=r oJ=-649224+17500742354909 mJ=21766473622783-785768 r=nil IJ=B(-166134+122612)bJ=11669646186919-754797 I[k]=vJ vJ=545602+-545601 I[y]=vJ MJ=v[zJ]QJ=I[c]cJ=30422268956471-71649 NJ=I[V]KJ=NJ(IJ,oJ)zJ=QJ[KJ]HJ=MJ[zJ]IJ=430037433735-(-394049)KJ=B(-787640+743463)zJ=I[c]QJ=I[V]NJ=QJ(KJ,IJ)oJ=B(-645017-(-601161))MJ=zJ[NJ]LJ=HJ[MJ]QJ=B(664075+-707723)zJ=v[QJ]NJ=I[c]KJ=I[V]IJ=KJ(oJ,bJ)QJ=NJ[IJ]MJ=zJ[QJ]QJ=I[c]NJ=I[V]bJ=B(246320+-290123)IJ=B(484477+-528006)oJ=32506766868888-886391 KJ=NJ(IJ,oJ)zJ=QJ[KJ]HJ=MJ[zJ]NJ=B(605465-649113)QJ=v[NJ]KJ=I[c]IJ=I[V]oJ=IJ(bJ,VJ)NJ=KJ[oJ]zJ=QJ[NJ]bJ=-395744+27206797261661 oJ=B(332592+-376692)NJ=I[c]KJ=I[V]IJ=KJ(oJ,bJ)QJ=NJ[IJ]MJ=zJ[QJ]KJ=B(-177075+133427)VJ=B(-184950-(-141489))NJ=v[KJ]IJ=I[c]oJ=I[V]bJ=oJ(VJ,qJ)wJ=-819646+13175001717173 KJ=IJ[bJ]QJ=NJ[KJ]KJ=I[c]IJ=I[V]VJ=50188+4672691029107 bJ=B(-949865-(-905926))oJ=IJ(bJ,VJ)NJ=KJ[oJ]IJ=B(-913550-(-869902))zJ=QJ[NJ]KJ=v[IJ]oJ=I[c]qJ=B(516912-561071)bJ=I[V]VJ=bJ(qJ,cJ)IJ=oJ[VJ]NJ=KJ[IJ]IJ=I[c]cJ=B(-150472-(-107062))VJ=B(-681584+637968)qJ=-250190+6730110147979 oJ=I[V]bJ=oJ(VJ,qJ)FJ=-893376+20975433074663 PJ=41797+1535134277509 oJ=B(1023466+-1067114)KJ=IJ[bJ]QJ=NJ[KJ]IJ=v[oJ]bJ=I[c]VJ=I[V]jJ=846119+8850067367666 qJ=VJ(cJ,WJ)oJ=bJ[qJ]KJ=IJ[oJ]cJ=289897+19912780330959 oJ=I[c]bJ=I[V]qJ=B(983584+-1027009)VJ=bJ(qJ,cJ)WJ=B(-476516+432479)bJ=B(-457578-(-413930))IJ=oJ[VJ]NJ=KJ[IJ]oJ=v[bJ]VJ=I[c]qJ=I[V]cJ=qJ(WJ,jJ)WJ=262030+29592467306054 bJ=VJ[cJ]IJ=oJ[bJ]bJ=I[c]cJ=B(-105935-(-62300))RJ=-1003145+31767231154257 VJ=I[V]jJ=B(-402077-(-357920))qJ=VJ(cJ,WJ)VJ=B(353526-397174)oJ=bJ[qJ]KJ=IJ[oJ]bJ=v[VJ]qJ=I[c]cJ=I[V]WJ=cJ(jJ,hJ)jJ=15845460329443-(-104687)VJ=qJ[WJ]WJ=B(-862372-(-818861))oJ=bJ[VJ]VJ=I[c]qJ=I[V]cJ=qJ(WJ,jJ)bJ=VJ[cJ]hJ=B(545441+-589383)qJ=B(677654+-721302)IJ=oJ[bJ]VJ=v[qJ]cJ=I[c]WJ=I[V]jJ=WJ(hJ,RJ)qJ=cJ[jJ]bJ=VJ[qJ]qJ=I[c]hJ=20270155893225-156938 cJ=I[V]jJ=B(48173+-91658)WJ=cJ(jJ,hJ)RJ=B(-788522-(-744540))VJ=qJ[WJ]cJ=B(-642831+599183)oJ=bJ[VJ]qJ=v[cJ]WJ=I[c]jJ=I[V]hJ=jJ(RJ,dJ)cJ=WJ[hJ]VJ=qJ[cJ]cJ=I[c]RJ=-390762+3765134916931 WJ=I[V]hJ=B(-92471-(-48952))jJ=WJ(hJ,RJ)qJ=cJ[jJ]bJ=VJ[qJ]vJ={LJ;HJ,MJ;zJ,QJ;NJ;KJ;IJ,oJ,bJ}JJ=5790441000501-(-605267)LJ=b()I[LJ]=vJ zJ=I[c]KJ=B(165942-209518)qJ=767102+10567566499514 IJ=25883363859692-(-709160)QJ=I[V]NJ=QJ(KJ,IJ)MJ=zJ[NJ]IJ=B(249508-293621)bJ=8707007869945-(-875485)WJ=-1004862+33924525757171 QJ=I[c]NJ=I[V]VJ=-465215+692655856257 oJ=17990333817441-688552 KJ=NJ(IJ,oJ)zJ=QJ[KJ]oJ=B(-536619-(-492447))NJ=I[c]KJ=I[V]IJ=KJ(oJ,bJ)QJ=NJ[IJ]bJ=B(86969-131033)cJ=-819209+30929976883275 KJ=I[c]YJ=B(-27778+-15974)IJ=I[V]oJ=IJ(bJ,VJ)VJ=B(-1046261+1002108)NJ=KJ[oJ]IJ=I[c]oJ=I[V]bJ=oJ(VJ,qJ)KJ=IJ[bJ]oJ=I[c]bJ=I[V]qJ=B(-29564+-13891)VJ=bJ(qJ,cJ)bJ=7878072195366-19154 IJ=oJ[VJ]HJ={[MJ]=zJ,[QJ]=NJ,[KJ]=IJ}QJ=I[c]qJ=161306+9326851988189 NJ=I[V]IJ=B(-37418+-5998)oJ=2795453297998-536633 KJ=NJ(IJ,oJ)zJ=QJ[KJ]oJ=B(76216-120221)NJ=I[c]KJ=I[V]IJ=KJ(oJ,bJ)QJ=NJ[IJ]bJ=B(1040521+-1084726)VJ=-308025+16423783354648 KJ=I[c]IJ=I[V]oJ=IJ(bJ,VJ)NJ=KJ[oJ]IJ=I[c]VJ=B(-206901-(-162967))oJ=I[V]hJ=B(-852363-(-808832))bJ=oJ(VJ,qJ)KJ=IJ[bJ]oJ=I[c]gJ=225844+26099601964357 qJ=B(716565+-760260)cJ=-163074+13351769101643 bJ=I[V]VJ=bJ(qJ,cJ)IJ=oJ[VJ]bJ=I[c]cJ=B(939433-983166)VJ=I[V]qJ=VJ(cJ,WJ)oJ=bJ[qJ]MJ={[zJ]=QJ;[NJ]=KJ;[IJ]=oJ}vJ={HJ;MJ}zJ=B(85140-129227)HJ=b()oJ=B(-282943-(-238857))I[HJ]=vJ bJ=9756890974528-980865 MJ=v[zJ]dJ=B(-788464+744955)zJ=B(608462-652410)NJ=I[c]KJ=I[V]zJ=MJ[zJ]IJ=KJ(oJ,bJ)QJ=NJ[IJ]IJ=B(-1045012-(-1000942))zJ=zJ(MJ,QJ)oJ=25021413679685-(-707390)qJ=-195856+17043839343632 RJ=-31573+12863427728059 QJ=I[c]NJ=I[V]KJ=NJ(IJ,oJ)bJ=-728740+31246919374714 oJ=B(486047+-529826)MJ=QJ[KJ]vJ=zJ[MJ]QJ=B(-954980+910955)zJ=v[QJ]NJ=I[c]KJ=I[V]IJ=KJ(oJ,bJ)cJ=-383344+32467622073470 QJ=NJ[IJ]MJ=zJ[QJ]bJ=B(-595767+551740)zJ=b()I[zJ]=MJ QJ=B(790719-834611)MJ=I[zJ]VJ=368197+8712667181460 KJ=I[c]IJ=I[V]oJ=IJ(bJ,VJ)QJ=MJ[QJ]NJ=KJ[oJ]VJ=B(-543004-(-499330))QJ=QJ(MJ,NJ)MJ=b()NJ=B(-669070-(-625178))I[MJ]=QJ QJ=I[zJ]WJ=13385359587560-958607 IJ=I[c]NJ=QJ[NJ]oJ=I[V]bJ=oJ(VJ,qJ)KJ=IJ[bJ]NJ=NJ(QJ,KJ)QJ=b()I[QJ]=NJ NJ=I[zJ]tJ=787315+28708887359685 oJ=I[c]KJ=B(-412865+368973)bJ=I[V]qJ=B(-636932-(-592884))VJ=bJ(qJ,cJ)KJ=NJ[KJ]IJ=oJ[VJ]KJ=KJ(NJ,IJ)NJ=b()I[NJ]=KJ KJ=I[zJ]bJ=I[c]IJ=B(388316+-432208)IJ=KJ[IJ]VJ=I[V]cJ=B(-388014-(-344006))qJ=VJ(cJ,WJ)oJ=bJ[qJ]IJ=IJ(KJ,oJ)KJ=b()I[KJ]=IJ oJ=B(-876330-(-832423))bJ=d(425622+11478400,{zJ,c,V,KJ})IJ=v[oJ]oJ=IJ(bJ)oJ=t(-44018-(-387216),{KJ,c;V})IJ=B(119556-163018)IJ=vJ[IJ]IJ=IJ(vJ)bJ=B(-129731+85777)v[bJ]=oJ bJ=B(-768477+724805)oJ=t(1010449+6277956,{NJ;c,V})v[bJ]=oJ oJ={}bJ=b()I[bJ]=oJ cJ=I[c]WJ=I[V]jJ=WJ(hJ,RJ)qJ=cJ[jJ]RJ=-73232+2054905504204 VJ=j[qJ]cJ=I[c]hJ=B(-228286-(-184297))AJ=1926002253628-1006524 WJ=I[V]jJ=WJ(hJ,RJ)qJ=cJ[jJ]oJ=VJ[qJ]VJ=B(-562816-(-519311))VJ=oJ[VJ]VJ=VJ(oJ)oJ=b()I[oJ]=VJ hJ=B(79053+-123222)VJ=I[oJ]cJ=I[c]RJ=782626+34512117058980 WJ=I[V]jJ=WJ(hJ,RJ)qJ=cJ[jJ]jJ=I[c]hJ=I[V]RJ=hJ(dJ,tJ)WJ=jJ[RJ]RJ=B(205986+-249910)cJ=vJ[WJ]VJ[qJ]=cJ qJ=I[oJ]dJ=-276482+33822135858567 WJ=I[c]jJ=I[V]hJ=jJ(RJ,dJ)cJ=WJ[hJ]VJ=qJ[cJ]tJ=B(-502607+459112)WJ=d(15771084-419428,{c,V})qJ=b()cJ=d(15745180-(-649351),{bJ;c,V;T})I[qJ]=cJ cJ=b()jJ=B(-600442-(-556491))I[cJ]=WJ WJ=A(3261641-240711,{c,V,cJ,bJ,qJ;T})v[jJ]=WJ hJ=I[c]WJ=B(-887768-(-843876))RJ=I[V]WJ=j[WJ]dJ=RJ(tJ,CJ)jJ=hJ[dJ]WJ=WJ(j,jJ)jJ=b()CJ=B(-662007+618529)I[jJ]=WJ RJ=I[c]dJ=I[V]tJ=dJ(CJ,wJ)hJ=RJ[tJ]WJ=B(-983766+939874)dJ=B(887243+-930876)WJ=j[WJ]WJ=WJ(j,hJ)RJ=v[dJ]tJ=I[c]CJ=I[V]wJ=CJ(YJ,AJ)YJ=B(156639+-200596)AJ=-407361+17673071777638 dJ=tJ[wJ]hJ=RJ[dJ]tJ=I[c]CJ=I[V]wJ=CJ(YJ,AJ)dJ=tJ[wJ]tJ=I[zJ]RJ=hJ(dJ,tJ)dJ=B(970613+-1014612)hJ=F(613496+4458188,{c;V;NJ})v[dJ]=hJ hJ=I[g]tJ=I[c]AJ=-392624+31363779147452 CJ=I[V]YJ=B(-946354-(-902545))wJ=CJ(YJ,AJ)dJ=tJ[wJ]tJ=I[NJ]hJ[dJ]=tJ YJ=B(-556061+512031)AJ=3732810289524-(-619862)hJ=I[g]tJ=I[c]CJ=I[V]wJ=CJ(YJ,AJ)YJ=B(461254+-504940)dJ=tJ[wJ]tJ=140573.5-140573 hJ[dJ]=tJ hJ=I[g]tJ=I[c]CJ=I[V]AJ=27229412918384-37609 wJ=CJ(YJ,AJ)dJ=tJ[wJ]tJ=true hJ[dJ]=tJ YJ=B(-514957-(-471250))hJ=I[g]AJ=796614+8225874978608 dJ=B(420786-464259)dJ=hJ[dJ]dJ=dJ(hJ)tJ=I[c]CJ=I[V]wJ=CJ(YJ,AJ)dJ=tJ[wJ]AJ=B(-162392-(-118708))hJ=WJ[dJ]CJ=I[c]wJ=I[V]YJ=wJ(AJ,FJ)dJ=B(-823548-(-779656))tJ=CJ[YJ]dJ=hJ[dJ]dJ=dJ(hJ,tJ)hJ=B(-495499+451994)AJ=B(-849693+806092)hJ=dJ[hJ]hJ=hJ(dJ)dJ=b()FJ=217599+34352625085565 I[dJ]=hJ hJ=I[dJ]CJ=I[c]wJ=I[V]YJ=wJ(AJ,FJ)tJ=CJ[YJ]FJ=B(349863-393458)CJ=I[NJ]hJ[tJ]=CJ hJ=I[zJ]wJ=I[c]YJ=I[V]AJ=YJ(FJ,gJ)CJ=wJ[AJ]tJ=B(-808522+764960)tJ=hJ[tJ]gJ=B(-674200+630242)wJ=B(-1048396+1004763)tJ=tJ(hJ,CJ)CJ=v[wJ]lJ=-953599+34290847353694 YJ=I[c]AJ=I[V]FJ=AJ(gJ,DJ)wJ=YJ[FJ]hJ=CJ[wJ]YJ=I[c]gJ=B(-958142-(-914412))DJ=-821703+14814723548345 AJ=I[V]FJ=AJ(gJ,DJ)DJ=32329248153505-(-449325)wJ=YJ[FJ]YJ=nil CJ=hJ(wJ,YJ)hJ=b()I[hJ]=CJ CJ=I[hJ]gJ=B(619825-664040)YJ=I[c]AJ=I[V]FJ=AJ(gJ,DJ)wJ=YJ[FJ]FJ=B(-31221-12585)AJ=v[FJ]gJ=I[c]DJ=I[V]sJ=DJ(XJ,OJ)DJ=58450-58449 FJ=gJ[sJ]YJ=AJ[FJ]gJ=-599127-(-599128)FJ=-365041+365042 AJ=YJ(FJ,gJ,DJ)CJ[wJ]=AJ CJ=I[hJ]gJ=B(192046+-235992)DJ=-439609+4965270797889 YJ=I[c]AJ=I[V]FJ=AJ(gJ,DJ)wJ=YJ[FJ]YJ=-126288+126289 OJ=B(979602-1023371)CJ[wJ]=YJ DJ=-804339+13642639924931 gJ=B(280720+-324288)CJ=I[hJ]sJ=18351239373562-639385 YJ=I[c]AJ=I[V]FJ=AJ(gJ,DJ)wJ=YJ[FJ]YJ=false CJ[wJ]=YJ YJ=B(784332-827965)wJ=v[YJ]AJ=I[c]FJ=I[V]DJ=B(-541158+497351)gJ=FJ(DJ,sJ)sJ=-409547+16155224005933 YJ=AJ[gJ]CJ=wJ[YJ]DJ=B(-1075028-(-1031053))AJ=I[c]FJ=I[V]gJ=FJ(DJ,sJ)YJ=AJ[gJ]gJ=B(-769060+725427)FJ=v[gJ]DJ=I[c]sJ=I[V]XJ=sJ(OJ,fJ)gJ=DJ[XJ]AJ=FJ[gJ]OJ=B(-593105-(-549306))fJ=165493+26847148862048 DJ=I[c]sJ=I[V]XJ=sJ(OJ,fJ)gJ=DJ[XJ]DJ=I[zJ]FJ={AJ(gJ,DJ)}wJ=CJ(YJ,H(FJ))CJ=b()I[CJ]=wJ DJ=B(455327-498741)wJ=I[CJ]AJ=I[c]sJ=-682150+24856938272220 fJ=7726345627552-678291 FJ=I[V]gJ=FJ(DJ,sJ)YJ=AJ[gJ]OJ=B(-153673-(-110206))gJ=B(-938433-(-894627))FJ=v[gJ]DJ=I[c]sJ=I[V]XJ=sJ(OJ,fJ)gJ=DJ[XJ]AJ=FJ[gJ]DJ=269973-269972 gJ=-439686-(-439687)sJ=-675615-(-675616)FJ=AJ(gJ,DJ,sJ)wJ[YJ]=FJ XJ=810919+3546516596428 wJ=I[CJ]sJ=-482923+27628391747756 AJ=I[c]FJ=I[V]DJ=B(-946416-(-902583))gJ=FJ(DJ,sJ)YJ=AJ[gJ]AJ=209765+-209764 wJ[YJ]=AJ sJ=9302511661958-(-318821)DJ=B(-192163+148040)wJ=I[CJ]AJ=I[c]FJ=I[V]gJ=FJ(DJ,sJ)YJ=AJ[gJ]AJ=false wJ[YJ]=AJ AJ=B(-141720-(-98087))YJ=v[AJ]FJ=I[c]gJ=I[V]sJ=B(99996-144006)DJ=gJ(sJ,XJ)sJ=B(-199370+155418)AJ=FJ[DJ]wJ=YJ[AJ]FJ=I[c]gJ=I[V]XJ=546247+18016696978174 DJ=gJ(sJ,XJ)AJ=FJ[DJ]FJ=I[CJ]XJ=-312928+22477513191234 YJ=wJ(AJ,FJ)wJ=b()I[wJ]=YJ YJ=I[wJ]sJ=B(-470839-(-426689))FJ=I[c]gJ=I[V]DJ=gJ(sJ,XJ)AJ=FJ[DJ]FJ=I[CJ]YJ[AJ]=FJ XJ=-256837+5472518927673 YJ=I[wJ]FJ=I[c]fJ=B(884117-927937)gJ=I[V]sJ=B(50975-94711)DJ=gJ(sJ,XJ)AJ=FJ[DJ]FJ=I[NJ]sJ=B(-264608+220697)YJ[AJ]=FJ YJ=I[wJ]FJ=I[c]XJ=505397565169-759302 gJ=I[V]DJ=gJ(sJ,XJ)AJ=FJ[DJ]DJ=B(-357895+314281)gJ=v[DJ]sJ=I[c]XJ=I[V]OJ=XJ(fJ,TJ)DJ=sJ[OJ]FJ=gJ[DJ]XJ=-53880+53880 sJ=250083-250098 DJ=-642534-(-642534)gJ=FJ(DJ,sJ,XJ)YJ[AJ]=gJ FJ=B(-149712-(-106079))OJ=474650+22017428138482 AJ=v[FJ]XJ=B(114256+-158066)gJ=I[c]DJ=I[V]sJ=DJ(XJ,OJ)OJ=-173740+5685780508931 XJ=B(-872143+828212)FJ=gJ[sJ]YJ=AJ[FJ]gJ=I[c]DJ=I[V]sJ=DJ(XJ,OJ)FJ=gJ[sJ]XJ=-868545+31835974302377 gJ=I[CJ]sJ=B(-436364-(-392900))AJ=YJ(FJ,gJ)FJ=I[c]gJ=I[V]DJ=gJ(sJ,XJ)YJ=FJ[DJ]FJ=I[CJ]AJ[YJ]=FJ FJ=I[c]XJ=105001+32345267511468 gJ=I[V]sJ=B(909306+-953262)DJ=gJ(sJ,XJ)YJ=FJ[DJ]FJ=tJ AJ[YJ]=FJ YJ=nil FJ=b()gJ=Y(12546978-563834,{FJ})I[FJ]=YJ DJ=B(169225+-213007)YJ=b()sJ=Y(-240407+15246285,{c;V,g})I[YJ]=gJ gJ=d(13923513-(-572101),{QJ;c;V;G,zJ;YJ;FJ})v[DJ]=gJ nJ=B(748749+-792631)DJ=B(898096+-942093)gJ=d(12720606-(-716558),{p;c;V})v[DJ]=gJ DJ=B(-958489-(-914395))gJ=C(5359573-549133,{p;c,V})v[DJ]=gJ DJ=B(786720-830352)gJ=Y(-388954+13875579,{NJ;c,V;zJ,e;u,a;jJ})v[DJ]=gJ gJ=t(1046431+9551854,{E;zJ;jJ,c;V})DJ=B(-786706-(-743253))v[DJ]=gJ DJ=B(-720188-(-676174))gJ=t(286279+12201168,{E;G;zJ;jJ,c,V,YJ})v[DJ]=gJ DJ=B(917485+-960902)gJ=t(2710881-(-7045),{E,zJ,jJ;c;V,NJ,f;dJ})v[DJ]=gJ gJ=t(-496101+13989038,{U,E;zJ,jJ,c,V,hJ;NJ;wJ;CJ})DJ=B(-40429+-2998)v[DJ]=gJ gJ=d(539864+3839759,{HJ,y;g,c,V,D})DJ=B(902945+-946952)v[DJ]=gJ DJ=d(297091-(-269589),{k})gJ=b()I[gJ]=DJ DJ=b()I[DJ]=sJ OJ=I[c]fJ=I[V]TJ=fJ(nJ,lJ)XJ=OJ[TJ]sJ=n[XJ]XJ=B(729886-774060)OJ=F(8307926-874519,{c,V,LJ,k,DJ;gJ,E,i})XJ=sJ[XJ]lJ=B(-201288+157540)XJ=XJ(sJ,OJ)sJ=b()I[sJ]=XJ fJ=I[c]TJ=I[V]nJ=TJ(lJ,pJ)OJ=fJ[nJ]XJ=n[OJ]fJ=d(-353569+6133249,{c;V,i})OJ=B(-479081-(-434907))OJ=XJ[OJ]OJ=OJ(XJ,fJ)XJ=b()pJ=B(-84846+40735)I[XJ]=OJ TJ=I[c]nJ=I[V]lJ=nJ(pJ,PJ)fJ=TJ[lJ]OJ=vJ[fJ]nJ=I[c]lJ=I[V]PJ=B(971922-1015641)pJ=lJ(PJ,JJ)JJ=11104450441342-(-664500)TJ=nJ[pJ]fJ=B(-975368-(-931476))fJ=OJ[fJ]fJ=fJ(OJ,TJ)PJ=B(507045+-551177)OJ=B(105139-149031)nJ=I[c]OJ=fJ[OJ]lJ=I[V]pJ=lJ(PJ,JJ)PJ=B(526416+-569950)TJ=nJ[pJ]OJ=OJ(fJ,TJ)fJ=B(-485696-(-441804))nJ=I[c]lJ=I[V]JJ=-899032+24678287418555 fJ=OJ[fJ]pJ=lJ(PJ,JJ)PJ=B(-702475-(-659029))JJ=13777643707981-(-244418)TJ=nJ[pJ]fJ=fJ(OJ,TJ)nJ=I[c]lJ=I[V]pJ=lJ(PJ,JJ)JJ=31942734054367-(-898619)OJ=B(-841345-(-797783))OJ=fJ[OJ]TJ=nJ[pJ]OJ=OJ(fJ,TJ)PJ=B(-141717+97993)nJ=I[c]lJ=I[V]pJ=lJ(PJ,JJ)JJ=B(-917324+873278)TJ=nJ[pJ]lJ=I[c]pJ=I[V]PJ=pJ(JJ,mJ)nJ=lJ[PJ]JJ=B(-83807-(-39991))OJ[TJ]=nJ lJ=I[c]mJ=24262691799840-(-600322)pJ=I[V]PJ=pJ(JJ,mJ)JJ=B(748773-792310)nJ=lJ[PJ]TJ=VJ[nJ]lJ=I[c]pJ=I[V]mJ=817928+20711760685732 PJ=pJ(JJ,mJ)nJ=lJ[PJ]OJ=TJ[nJ]TJ=B(-495278+451104)nJ=d(12121516-(-169788),{})TJ=OJ[TJ]TJ=TJ(OJ,nJ)lJ=I[c]JJ=B(360966+-404907)pJ=I[V]mJ=32672911887029-1019719 PJ=pJ(JJ,mJ)nJ=lJ[PJ]TJ=VJ[nJ]mJ=32844970962556-(-3394)JJ=B(-1031992-(-987915))lJ=I[c]pJ=I[V]PJ=pJ(JJ,mJ)nJ=lJ[PJ]OJ=TJ[nJ]TJ=B(-369988-(-325814))nJ=t(13687977-1005991,{})TJ=OJ[TJ]mJ=3573218952622-163631 TJ=TJ(OJ,nJ)lJ=I[c]JJ=B(-527420+483325)pJ=I[V]PJ=pJ(JJ,mJ)JJ=B(460498-504216)nJ=lJ[PJ]TJ=VJ[nJ]lJ=I[c]pJ=I[V]mJ=29022504702023-(-648323)PJ=pJ(JJ,mJ)nJ=lJ[PJ]OJ=TJ[nJ]TJ=B(270500-314674)nJ=F(-653225+15185497,{})TJ=OJ[TJ]mJ=22053030121518-(-645103)JJ=B(930949-975101)TJ=TJ(OJ,nJ)lJ=I[c]pJ=I[V]PJ=pJ(JJ,mJ)nJ=lJ[PJ]TJ=VJ[nJ]JJ=B(527688+-571392)mJ=18834353803526-(-4412)lJ=I[c]pJ=I[V]PJ=pJ(JJ,mJ)nJ=lJ[PJ]OJ=TJ[nJ]nJ=t(131601+3437824,{})JJ=B(414495-458084)TJ=B(457002+-501176)TJ=OJ[TJ]TJ=TJ(OJ,nJ)lJ=I[c]pJ=I[V]mJ=30322588962952-170336 PJ=pJ(JJ,mJ)mJ=34525103066263-(-406070)nJ=lJ[PJ]TJ=VJ[nJ]lJ=I[c]pJ=I[V]JJ=B(-385065+341466)PJ=pJ(JJ,mJ)nJ=lJ[PJ]OJ=TJ[nJ]TJ=B(-226219-(-182045))JJ=B(-45052+1050)TJ=OJ[TJ]mJ=27716721641218-(-764776)nJ=R(-108555+8713559,{E,i})TJ=TJ(OJ,nJ)lJ=I[c]pJ=I[V]PJ=pJ(JJ,mJ)JJ=B(-868707-(-824893))nJ=lJ[PJ]mJ=10841992429705-371921 TJ=VJ[nJ]lJ=I[c]pJ=I[V]PJ=pJ(JJ,mJ)nJ=lJ[PJ]JJ=B(-338051-(-294460))OJ=TJ[nJ]nJ=d(9856014-558240,{})TJ=B(489578-533752)TJ=OJ[TJ]TJ=TJ(OJ,nJ)TJ=I[f]lJ=I[c]pJ=I[V]mJ=-1019474+21916439688751 PJ=pJ(JJ,mJ)nJ=lJ[PJ]OJ=TJ[nJ]nJ=d(-345667+10086987,{KJ;c;V;NJ,MJ;E,zJ,jJ,i;e,u;a})TJ=B(-1038361-(-994187))TJ=OJ[TJ]mJ=B(-761224-(-717144))TJ=TJ(OJ,nJ)lJ=B(-770679+727195)OJ=b()I[OJ]=TJ nJ=v[lJ]lJ=nJ()pJ=I[c]PJ=I[V]JJ=PJ(mJ,SJ)nJ=pJ[JJ]TJ=lJ[nJ]L=TJ and 13119914-(-637178)or 12182460-(-537616)end end end else if L<9556162-(-220690)then if L<9813072-82390 then if L<-6092+9688506 then if L<10660221-990785 then u=I[z[-316778-(-316779)]]i=B(-830890-(-787252))J=L P=B(978624-1022662)e=1037379+33217127868456 x=I[z[473985-473983]]a=x(i,e)S=u[a]P=l[P]P=P(l,S)m=P L=P and 6808522-(-970931)or 757341+11865873 else g=L X=not j L=X and-296030-(-446711)or 170313+11451515 K=X end else O=17451014575495-554441 f=B(-549397+505212)D=I[c]g=I[V]p=-98179+20691805873446 T=B(449634-493191)n=33776775115102-(-412690)s=692287+15077969660718 X=g(T,O)j=D[X]X=I[c]T=I[V]O=T(f,s)s=B(-597674+553986)g=X[O]T=I[c]O=I[V]f=O(s,n)X=T[f]f=B(710584-754807)n=B(297064+-340732)D={g;X}s=-301041+18638578186712 X=I[c]T=I[V]l=-658514+19769256439879 O=T(f,s)g=X[O]O=I[c]f=I[V]s=f(n,l)l=B(514553-558568)T=O[s]f=I[c]s=I[V]n=s(l,p)O=f[n]X={T;O}q={[j]=D;[g]=X}O=20748532205983-(-810014)D=I[c]g=I[V]T=B(-705608-(-661945))X=g(T,O)T=B(-695012-(-651051))j=D[X]D=b()I[D]=j g=b()j=nil I[g]=j X=v[T]O=I[D]T=X(O)j=not T L=j and 3804322-653871 or-493579+7749105 end else if L<10229869-485562 then if L<-446531+10182130 then L=g K=D L=441854+11036852 else j=B(-889087-(-845140))L=I[z[-231576+231577]]X=B(563278-607495)V=I[z[-607027-(-607029)]]q=I[z[67456-67453]]f=B(-1025965+982063)T=14247948222537-(-432545)o=M[-900889+900890]D=-176393+6732580322632 c=q(j,D)s=7626886451226-737851 K=V[c]q=I[z[-508172-(-508173)]]j=I[z[353131-353129]]D=I[z[-410738-(-410741)]]n=6742087502514-(-524689)g=D(X,T)c=j[g]V=q[c]D=I[z[671441+-671437]]X=I[z[855332-855330]]T=I[z[-603781-(-603784)]]O=T(f,s)g=X[O]X=B(954556+-998170)j=D[g]g=v[X]T=I[z[-817665-(-817667)]]s=B(300784-344776)O=I[z[-661755+661758]]f=O(s,n)X=T[f]D=g[X]X=261294-261294 O=609767+-609767 T=-784559+784560.5 s=B(-649269-(-605351))g=D(X,T,O)q=B(-511625-(-467940))c=j*g g=I[z[497574-497569]]j=B(836426+-879950)n=22336806728250-(-63079)T=I[z[-612838+612840]]j=c[j]O=I[z[-337291+337294]]f=O(s,n)X=T[f]D=g[X]s=517837+27628178656116 j=j(c,D)g=B(954302-998438)f=B(-135386+91567)D=v[g]X=I[z[559395-559393]]T=I[z[956826-956823]]O=T(f,s)T=-156661-(-156662)g=X[O]q=V[q]c=D[g]g=-692418-(-721218)X=-824489-(-824489)D={c(g,X,T)}q=q(V,j,H(D))L[K]=q L=I[z[-498906+498912]]L=L and 11609223-(-246236)or 17008821-820742 end else q=I[z[635570+-635569]]j=I[z[-705046-(-705048)]]D=I[z[-1043801-(-1043804)]]T=4941873750259-(-452618)X=B(593791+-637381)g=D(X,T)c=j[g]V=q[c]o=not V K=o L=o and-296579+6241102 or 12503971-909140 end end else if L<-49210+10293290 then if L<668536+9461787 then if L<-60263+10058939 then g=nil L=1263263-(-161429)D=nil c=nil else L=I[z[929765-929764]]o=M[984957+-984956]L=L and-120399+2260678 or 13341621-433707 end else m=-836809+12718813633515 s=I[z[747044-747043]]n=I[z[-107460+107462]]p=B(-637944-(-593957))l=n(p,m)f=s[l]L=167081+11164279 J=-153767+11865045151292 m=B(-44218-(-563))O=V[f]n=I[z[850342+-850341]]f=B(613755-657317)l=I[z[-96895+96897]]p=l(m,J)s=n[p]f=O[f]f=f(O,s)X=f end else if L<10244177-(-161718)then if L<-489953+10804972 then O=s L=n L=1033981+3264889 else K={}L=v[B(-414850-(-370623))]end else X=22913052271006-(-149519)o=M[326248+-326247]V=M[-466830-(-466832)]c=I[z[544941+-544940]]j=I[z[850750+-850748]]g=B(-269748-(-226301))T=26940291290200-(-973993)D=j(g,X)q=c[D]K=o[q]j=I[z[939065+-939064]]D=I[z[499349-499347]]X=B(848023+-892143)g=D(X,T)c=j[g]q=V[c]L=K<q K={L}L=v[B(-74440-(-30592))]end end end end end else if L<12421650-993659 then if L<-58498+11099638 then if L<68647+10742575 then if L<-211534+10750330 then if L<9503085-(-963458)then if L<10921202-480909 then X=B(105488+-149448)T=13459349975464-(-452307)q=I[z[-576798-(-576801)]]j=I[z[768641+-768640]]D=I[z[-590984-(-590986)]]L=-693849+11566156 g=D(X,T)c=j[g]V=q[c]K=V else s=32006935747454-1040710 L=292158+14785630 f=B(-894275-(-850154))D=I[z[74093+-74089]]X=I[z[-665504+665506]]T=I[z[831540-831537]]O=T(f,s)g=X[O]j=D[g]D=-490890+490890 c=j>D V=c end else if L<-832200+11351492 then V,j=q(o,V)L=V and 478306+13635395 or 8161072-(-539281)else o=M L=true V=b()I[V]=L q=B(-701744-(-658024))j=b()K=v[q]q=B(-556114-(-512645))L=K[q]c=b()q=b()I[q]=L L=h(7193397-854741,{})I[c]=L g=B(-960277+916370)L=false I[j]=L D=v[g]X=R(8913393-665431,{j})g=D(X)K=g L=g and 722070+10561620 or 12318429-(-844665)end end else if L<11387291-732415 then if L<510468+10086727 then L=I[z[374205-374204]]V=M[-261953+261955]q=L L=q[V]o=M[-782164+782165]L=L and-255155+7995497 or 143397+4827956 else L=I[z[252233-252232]]L=L and 446077+14553226 or 15255840-587773 end else L=K and-369277+3599401 or 6046082-369577 end end else if L<-797322+11671653 then if L<11142144-274594 then if L<-563274+11389208 then o=false q=B(-562713-(-518716))L=true I[z[-703508-(-703513)]]=L f=B(-412558+368368)K=false I[z[936506-936500]]=K I[z[-452839+452846]]=o L=-483167+13814944 s=15816470032333-561928 V=v[q]c=I[z[-900613+900617]]D=I[z[-219525-(-219533)]]X=I[z[-717199-(-717201)]]T=I[z[-122616-(-122619)]]O=T(f,s)g=X[O]j=D[g]D=-649356+649357 q=V(c,j,D)else q=I[z[581993+-581987]]L=6101917-776277 c=q()end else L=K and 1460791-413368 or 511511+8167603 end else if L<-149353+11119764 then if L<316517+10571762 then f=I[z[1002512+-1002508]]n=I[z[200134+-200132]]J=-1010170+3898310177041 L=4353264-385350 m=B(-127060+82863)l=I[z[137947-137944]]p=l(m,J)s=n[p]O=f[s]f=-16387-(-16387)D=O>f K=D else c=B(-333627-(-289620))q=v[c]c=q()L=8004191-(-774577)end else g=B(274971+-318443)X=-434508+22682239027854 L=I[z[-368571-(-368576)]]V=I[z[-389593-(-389594)]]c=I[z[-493825-(-493827)]]j=I[z[895227-895224]]D=j(g,X)q=c[D]o=V[q]K=L(o)o=K L=o and 38934+833677 or 1311847-(-454885)end end end else if L<11362721-133366 then if L<10296362-(-878477)then if L<-769196+11932569 then if L<10070414-(-1017590)then q=q+j V=q<=c g=not D V=g and V g=q>=c g=D and g V=g or V g=-99992+4947190 L=V and g V=14359816-(-878304)L=L or V else K=B(27649+-71564)L=v[K]g=I[z[376227+-376226]]D=g[o]g={L(D)}L=-528878+5127895 K=g[-814708-(-814709)]j=g[371157+-371154]D=K c=g[332237-332235]end else c=I[z[-592718+592719]]j=I[z[108711+-108709]]g=B(226337+-270104)X=25222730347820-788299 D=j(g,X)q=c[D]K=o[q]c=I[z[803392+-803389]]j=I[z[-816089+816093]]q=c[j]L=K==q L=L and 7629879-(-825920)or-404973+6974126 end else if L<-866354+12077305 then if L<-70642+11281284 then L=V and 47325-(-975682)or 15105323-(-36986)else T=I[z[-69895+69898]]L=-1048257+3288265 l=B(-866895+823391)f=I[z[-408324+408325]]p=5473697267623-505267 s=I[z[-309941+309943]]n=s(l,p)O=f[n]X=T[O]D=X end else s=B(-384876+340672)D=I[z[-530168-(-530169)]]T=B(-417026+373615)g=I[z[807212+-807210]]O=1300082449705-(-992564)X=g(T,O)j=D[X]c=o[j]X=B(-97016+53368)n=12472071830292-(-875419)g=v[X]T=I[z[281635-281634]]O=I[z[453585-453583]]f=O(s,n)X=T[f]D=g[X]s=8882369645626-1047570 X=I[z[583057+-583056]]f=B(47099+-90987)T=I[z[110165-110163]]O=T(f,s)g=X[O]j=D[g]q=c==j L=q and 726611+15938477 or 467906+6407516 end end else if L<12003115-708116 then if L<11767201-478852 then if L<497755+10741734 then K=B(-867291-(-823496))j=B(754218+-798194)L=v[K]q=I[z[1003189-1003188]]j=q[j]c={j(q)}q={L(H(c))}K=q[-1031760+1031761]V=q[920924+-920921]o=q[-856663-(-856665)]L=512433+2598217 q=K else D=I[j]L=744887+12418207 K=D end else L=q L=V and 13239583-756387 or 13845056-513279 end else if L<10797988-(-544105)then if L<10858814-(-454313)then L=K and-43306+12820533 or 107406+5947678 else m=B(105890+-149392)l=940010+33781090313608 n=B(586327+-630067)O=I[z[1041460-1041459]]f=I[z[-917973+917975]]J=30183824850121-(-1047070)s=f(n,l)L=T T=O[s]n=I[z[-411880-(-411881)]]i=708843+11874041021614 S=8264882392610-(-49382)l=I[z[-995030+995032]]p=l(m,J)s=n[p]J=26686037576663-367437 m=B(-235418-(-191336))f=V[s]n=I[z[921626+-921625]]l=I[z[-724821-(-724823)]]p=l(m,J)s=n[p]O=f[s]s=I[z[11694-11693]]n=I[z[536294+-536292]]m=6639268693397-(-509566)p=B(-983697-(-939630))l=n(p,m)f=s[l]p=I[z[1038080-1038079]]u=B(623266+-667473)P=B(938074+-981599)m=I[z[-863445+863447]]J=m(P,S)S=26654606711546-92798 l=p[J]n=V[l]p=I[z[726278-726277]]P=B(-477336+433136)m=I[z[-289408+289410]]J=m(P,S)P=-339896+7449053084996 l=p[J]s=n[l]l=I[z[-992374-(-992375)]]p=I[z[-711920+711922]]J=B(48032-91778)m=p(J,P)n=l[m]J=I[z[123756+-123755]]P=I[z[875714+-875712]]x=712862+10674162266828 S=P(u,x)x=2979396261999-807684 a=B(-997445-(-953803))m=J[S]p=V[m]J=I[z[539888+-539887]]P=I[z[880976+-880974]]u=B(-191661-(-147742))S=P(u,x)m=J[S]S=B(-671882-(-628105))l=p[m]u=22481665161858-364958 m=I[z[605393+-605392]]J=I[z[-830424-(-830426)]]P=J(S,u)p=m[P]S=I[z[-990769-(-990770)]]u=I[z[-397642-(-397644)]]x=u(a,i)P=S[x]J=V[P]i=-111834+27936456042410 S=I[z[797949-797948]]u=I[z[-12030-(-12032)]]a=B(-463959-(-419893))x=u(a,i)P=S[x]m=J[P]L={[K]=D,[g]=X,[T]=O;[f]=s;[n]=l;[p]=m}D=b()I[D]=L g=b()l=19521495718610-341840 L={}I[g]=L L=I[g]s=16719799951795-230218 f=B(-289923-(-246305))X=I[z[-703100+703101]]T=I[z[-416183+416185]]O=T(f,s)K=X[O]X=-476838+476839 f=B(-1087483-(-1043384))s=20738083447659-(-606797)L[K]=X L=I[g]X=I[z[3309+-3308]]T=I[z[257217+-257215]]O=T(f,s)K=X[O]X=110465+-110465 L[K]=X T=B(914539-958613)p=B(-729643-(-685652))X=b()L=B(563639-607807)L=c[L]L=L(c)m=914227+12319466693429 I[X]=L K=v[T]O=I[z[1004583-1004582]]f=I[z[-1034885-(-1034887)]]n=B(214171+-258093)s=f(n,l)T=O[s]L=K[T]T=I[X]O=Y(761182+9649725,{z[470809+-470808];z[944220-944218]})K=L(T,O)L=I[g]s=B(42928+-87142)n=-647051+16358491422028 T=I[z[-215188-(-215189)]]O=I[z[-120295+120297]]f=O(s,n)K=T[f]f=I[X]n=I[X]s=#n O=f[s]s=I[z[-849499-(-849500)]]n=I[z[989228+-989226]]l=n(p,m)f=s[l]T=O[f]L[K]=T T=b()L=A(2412409-(-646985),{z[255261-255258];z[-836873+836874];z[-85551+85553];g})K=B(137540-181335)I[T]=L n=B(97342+-141318)n=c[n]L=v[K]s={n(c)}n={L(H(s))}K=n[-906842-(-906843)]f=n[-603872+603875]s=K O=n[551016-551014]L=-134757+7538700 end else X=B(906943+-950433)j=I[z[511850-511847]]D=I[z[478485-478481]]T=-535479+31004545098780 g=D(X,T)c=j[g]L=q[c]c=B(466402-510119)c=L[c]c=c(L)L=-523746+4603412 end end end end else if L<57610+11992245 then if L<302237+11486332 then if L<169022+11453011 then if L<11701642-135788 then if L<-311027+11870657 then L=K and-587706+1060493 or 9185651-(-371948)else L=1027189+5318819 T=nil end else if L<11675163-58063 then V=L c=I[z[428844-428843]]T=B(-403569+359445)O=9993662854088-(-73317)D=I[z[-719587-(-719589)]]g=I[z[-757823+757826]]X=g(T,O)j=D[X]q=c[j]o=q L=q and 1149806-(-481217)or-628402+3439224 else s=B(-625900-(-581883))f=v[s]s=f(j)T=L n=I[z[319567-319566]]m=B(-427446+383773)J=1199879269621-518855 l=I[z[906330+-906328]]p=l(m,J)f=n[p]O=s~=f L=O and 17144898-409795 or 1880042-701687 X=O end end else if L<11229938-(-556780)then if L<144763+11596743 then D=B(657090+-700629)j=v[D]X=I[c]T=I[V]s=-728396+15104281524421 f=B(-280803-(-237143))O=T(f,s)g=X[O]D=j(g)q=not D L=q and 462674+3022063 or 9698120-(-30141)else L=-897507+12097861 end else g=B(842036+-886270)X=444458+20678178643315 L=I[z[-251421+251424]]c=I[z[433397-433396]]j=I[z[-689577+689579]]D=j(g,X)q=c[D]D=B(-261082+216946)f=6531398974109-(-414020)O=B(184104+-228133)j=v[D]g=I[z[-683395-(-683396)]]X=I[z[2824-2822]]T=X(O,f)D=g[T]g=L c=j[D]D=V L=V and 2028230-(-211778)or 11421676-210982 end end else if L<12661123-785001 then if L<886592+10954490 then if L<930531+10862436 then L=B(824873-868590)L=l[L]L=L(l)L=2060185-103284 else L=I[z[962056-962051]]L=L and 3563820-(-874582)or 4817162-655528 end else K=B(-670225-(-626131))O=-497381+10995348859621 L=v[K]V=I[z[781097+-781090]]T=B(-1088261-(-1044583))c=I[z[170145-170137]]D=I[z[736261+-736259]]g=I[z[-664350+664353]]X=g(T,O)j=D[X]q=c[j]O=21046446629440-523256 K=L(V,q)K=B(-734503+690409)L=v[K]V=I[z[480751+-480744]]c=I[z[1001456+-1001448]]D=I[z[-51101-(-51103)]]g=I[z[-189349+189352]]T=B(252108+-295862)X=g(T,O)j=D[X]q=c[j]T=B(-183479+140028)K=L(V,q)K=B(355862-399956)L=v[K]V=I[z[532783+-532776]]c=I[z[-488782-(-488790)]]D=I[z[-164542-(-164544)]]O=-582144+24481042288263 g=I[z[134990-134987]]X=g(T,O)j=D[X]q=c[j]K=L(V,q)L=16545510-357431 end else if L<12035945-66623 then if L<587014+11296563 then L=506699+10710117 else L=I[z[752189-752188]]V=I[z[844844+-844842]]q=I[z[-72401+72404]]D=-853925+12281736781308 K=B(-821546+777984)j=B(-522829-(-479131))K=L[K]c=q(j,D)o=V[c]K=K(L,o)j=B(-416283+372410)L=B(-691292-(-647575))L=K[L]L=L(K)L=I[z[-505034-(-505038)]]V=I[z[-692369-(-692371)]]q=I[z[542250+-542247]]D=4013359427942-(-54758)c=q(j,D)o=V[c]K=B(214771+-258333)K=L[K]K=K(L,o)L=B(-714938+671221)L=K[L]L=L(K)K={}L=v[B(304968+-348372)]end else L=I[z[241373+-241372]]L=L and 831735+4575625 or 24313+13503998 end end end else if L<11581735-(-680960)then if L<-222786+12416827 then if L<12986620-822543 then if L<13080281-959148 then O=X V=O L=T q=L L=-578443+12139331 else V=I[z[-991018-(-991019)]]g=B(-607397-(-563393))X=-1013741+21845902417833 c=I[z[-495488-(-495490)]]j=I[z[-843624-(-843627)]]D=j(g,X)q=c[D]D=B(-914030-(-870424))o=V[q]q=I[z[-391251-(-391253)]]g=38153+9087161957246 c=I[z[959056+-959053]]j=c(D,g)V=q[j]K=o[V]o=I[z[-331574+331578]]L=K<o L=L and 58337+10938326 or-722312+9084328 end else K=B(-967389-(-923435))V=-290822+290837 L=v[K]K=L(V)L=-290265-(-668943)end else if L<891085+11354498 then if L<473391+11732434 then L=v[B(58593-102712)]K={}else L=B(474909-518626)L=l[L]L=L(l)L=93692+1863209 end else L=B(-1007322-(-963195))o=M[-875+876]K=I[z[638957+-638956]]L=o[L]L=L(o,K)L=L and 879558+3126478 or 15746986-634833 end end else if L<-294616+12617304 then if L<12601600-289038 then if L<12967614-681523 then K=-881198+881198 V=M[465041-465039]o=M[665695+-665694]L=V<K L=L and-124181+14150037 or 398543+11389856 else K=B(702935+-746949)L=v[K]K=L()L=v[B(-227431+183642)]K={}end else S=B(914432+-957865)L=v[S]S=B(829090-872884)v[S]=L L=-362203+14277532 end else if L<12047844-(-337749)then if L<-489505+12841000 then U=nil L=-536332+12942590 i=W(i)G=W(G)u=W(u)a=W(a)e=W(e)x=W(x)else q=L D=I[z[-122155+122156]]X=I[z[1024806-1024804]]f=B(-943138-(-899171))s=184807+8163191684338 T=I[z[-511015-(-511018)]]O=T(f,s)g=X[O]j=D[g]c=not j V=c L=c and 11210769-769266 or 219252+14858536 end else K={}L=v[B(433617+-477432)]end end end end end end else if L<-201344+14286858 then if L<480219+12770721 then if L<625855+12144666 then if L<11900139-(-677129)then if L<11522755-(-971844)then if L<-501911+12963588 then if L<13373702-935102 then m=m+P K=m<=J u=not S K=u and K u=m>=J u=S and u K=u or K u=-448501+13610634 L=K and u K=753020+-208868 L=L or K else K=I[z[414052+-414047]]L=403027+5045244 q=K()K=I[z[-22749+22755]]q=K()end else if L<-562810+13047914 then q=true c=false V=false I[z[-91696-(-91701)]]=V I[z[112366-112360]]=q D=B(-65676-(-21679))p=-988254+9468201330070 l=B(-713592+670054)I[z[-691795+691802]]=c j=v[D]g=I[z[65582-65578]]T=I[z[-865003-(-865011)]]f=I[z[-1020436+1020438]]L=12347352-(-984425)s=I[z[-129007+129010]]n=s(l,p)O=f[n]X=T[O]T=192238+-192237 D=j(g,X,T)else L=I[z[-925568+925569]]L=L and-715951+11033824 or 7967941-(-477668)end end else if L<13218274-653127 then if L<13540940-994193 then L=c L=q and 903053+5094485 or 6257135-(-506495)else q=-382239-(-382240)V=I[z[-83948-(-83951)]]o=V~=q L=o and-428372+4965483 or 3977922-772641 end else L=v[B(942484-986163)]K={}end end else if L<-901154+13619694 then if L<11852664-(-837008)then if L<869836+11786755 then u=I[z[456241+-456240]]P=B(-733830+689792)e=18183462205744-530461 i=B(931867+-975508)x=I[z[524237-524235]]a=x(i,e)S=u[a]P=l[P]P=P(l,S)m=P L=7248188-(-531265)else K=B(-592293-(-548876))L=v[K]K=L()L=v[B(650726-694724)]K={}end else j=I[z[-343330+343333]]q=B(-1027578+984038)L=11724-(-44584)D=I[z[314530+-314526]]T=24390308071484-(-320545)q=V[q]X=B(-399508-(-355553))g=D(X,T)c=j[g]q=q(V,c)K=q end else if L<11756700-(-985124)then if L<13489588-754737 then e=W(e)YJ=W(YJ)IJ=nil r=nil SJ=612987+15429055742357 lJ=B(981456-1025089)nJ=v[lJ]fJ=nil f=W(f)s=W(s)HJ=W(HJ)q=nil O=nil AJ=nil pJ=I[c]a=W(a)jJ=W(jJ)mJ=B(543553+-587732)PJ=I[V]QJ=W(QJ)l=W(l)KJ=W(KJ)k=W(k)JJ=PJ(mJ,SJ)NJ=W(NJ)lJ=pJ[JJ]y=W(y)cJ=W(cJ)bJ=W(bJ)TJ=nJ[lJ]SJ=-954194+23430326958576 dJ=W(dJ)hJ=W(hJ)pJ=I[c]mJ=B(744447+-788028)PJ=I[V]JJ=PJ(mJ,SJ)G=W(G)CJ=W(CJ)lJ=pJ[JJ]nJ=TJ(lJ)i=W(i)SJ=-999234+29782928323950 mJ=B(-33656-10140)uJ=17521248310507-767245 MJ=W(MJ)gJ=W(gJ)pJ=I[c]PJ=I[V]VJ=nil E=W(E)JJ=PJ(mJ,SJ)g=W(g)FJ=W(FJ)wJ=W(wJ)tJ=nil j=nil lJ=pJ[JJ]S=W(S)n=nil vJ=nil pJ=Y(408671+-5971,{OJ,sJ;XJ,oJ})TJ=nJ[lJ]LJ=W(LJ)lJ=B(-85457-(-41245))SJ=B(-709289-(-665844))K={}lJ=TJ[lJ]U=W(U)oJ=W(oJ)lJ=lJ(TJ,pJ)lJ=B(-1005808-(-961721))T=W(T)TJ=v[lJ]p=W(p)PJ=I[c]qJ=W(qJ)JJ=I[V]mJ=JJ(SJ,uJ)lJ=B(-786513+742565)RJ=nil XJ=W(XJ)uJ=-288360+2179326224990 u=W(u)WJ=nil pJ=PJ[mJ]DJ=W(DJ)zJ=W(zJ)sJ=W(sJ)SJ=B(-158627+114523)lJ=TJ[lJ]lJ=lJ(TJ,pJ)PJ=I[c]TJ=B(980837+-1024388)JJ=I[V]mJ=JJ(SJ,uJ)V=W(V)pJ=PJ[mJ]c=W(c)OJ=W(OJ)TJ=lJ[TJ]L=v[B(-604078+560622)]TJ=TJ(lJ,pJ,nJ)nJ=nil D=W(D)else q=742118-742115 K=false O=B(883365-927348)V=B(405132+-449086)L=true I[z[-934069+934071]]=L I[z[-68553-(-68554)]]=K o=v[V]V=o(q)V=B(-992076-(-948079))o=v[V]s=B(-751010+707051)f=512062+12142103905752 q=I[z[-166073-(-166076)]]K={}j=I[z[-387273+387277]]g=I[z[375464+-375459]]X=I[z[760794-760788]]T=X(O,f)D=g[T]c=j[D]j=507327+-507326 D=false V=o(q,c,j)q=b()n=2544501738689-(-948191)o=nil I[q]=o j=b()o=nil I[j]=o g=b()o=b()c=nil I[o]=c l=B(-934180-(-890266))p=875500+31672749759920 c=false I[g]=c c=b()I[c]=D T=I[z[-662476-(-662481)]]O=I[z[-977865+977871]]f=O(s,n)X=T[f]T=A(7930485-(-194548),{z[-564246+564251];z[983488+-983482];c;z[244243+-244236],j,z[796768+-796760];o;z[-142959-(-142968)],z[-978640+978650];g,z[628090-628087],q})D=V[X]X=B(652686-696860)X=D[X]O=B(897633+-941751)X=X(D,T)D=b()I[D]=X T=v[O]f=I[z[327218-327213]]s=I[z[635090-635084]]n=s(l,p)o=W(o)O=f[n]f=R(436649+15279548,{q,z[430325+-430320];z[-909116+909122],D;z[-537526-(-537535)],z[-1041112+1041120],z[154309-154299];z[484189-484188]})X=T[O]n=B(-364173+320601)c=W(c)O=747155+-747152 l=711152+29276802145105 T=X(O,f)g=W(g)O=I[z[239714+-239709]]f=I[z[-977558-(-977564)]]s=f(n,l)T=O[s]O=B(446747-490379)X=V[T]T=B(556049+-599979)T=X[T]T=T(X)X=false j=W(j)D=W(D)I[z[-498918+498920]]=X T=v[O]L=v[B(573703+-617153)]O=T()V=nil q=W(q)end else g=L T=nil X=q~=T D=X L=X and 1121298-(-666079)or 10067374-334530 end end end else if L<517327+12608834 then if L<12732301-(-181773)then if L<12149709-(-647265)then if L<676798+12102456 then L=I[z[75060+-75054]]O=I[z[-1026292-(-1026293)]]m=5613208488218-(-344347)p=B(31369-75232)s=I[z[-274208-(-274210)]]n=I[z[94787-94784]]l=n(p,m)f=s[l]D=O[f]K=L(D)L=5611563-(-443521)else L=-941975+4658000 D=nil g=nil end else D=-367912+18434474786480 j=B(594028+-637941)V=I[z[3478+-3476]]q=I[z[-991460-(-991463)]]c=q(j,D)D=B(1020859+-1064968)K=V[c]g=21122252637805-860162 L=o[K]K=B(-889735-(-846195))q=I[z[316319+-316317]]K=L[K]c=I[z[81168-81165]]j=c(D,g)V=q[j]K=K(L,V)V=K L=not V L=L and 6867588-451474 or 470205+1560504 end else if L<13529009-485997 then if L<13913640-916904 then V=I[z[276104+-276101]]j=B(785927-829786)L=B(924276-968398)q=I[z[-555948-(-555952)]]L=o[L]D=185334+384412052669 c=q(j,D)K=V[c]L=L(o,K)V=L K=V L=V and 614732+12101548 or-734731-(-791039)else O=926794+10091061849617 c=705236+6164148497 K=B(-1091977-(-1047978))L=v[K]T=B(811229-854837)K=L(c)K=B(377747+-421341)L=v[K]D=I[z[973135+-973132]]g=I[z[141370-141366]]X=g(T,O)j=D[X]c=o[j]T=21359843667988-(-751302)K=L(c)c=B(-1034486-(-990461))K=v[c]j=I[z[-604306-(-604309)]]X=B(-763614+719792)D=I[z[746590-746586]]g=D(X,T)c=j[g]j=B(-1028161+983940)L=K[c]c=v[j]K=L(V,c)L=I[z[-697676+697681]]K=L()L=15772868-842405 end else L=433488+15117275 T=W(T)X=W(X)j=nil g=nil end end else if L<13699262-532944 then if L<13074859-(-88021)then if L<13904201-748839 then K={}L=v[B(-232890-(-189015))]else u=b()a=903325+-903225 x=B(118399+-162535)I[u]=m k=438886-438886 K=v[x]x=B(-923191-(-878978))i=-547630-(-547885)L=K[x]G=930644-930643 x=-703341+703342 K=L(x,a)y=-982619+992619 x=b()I[x]=K a=460005+-460005 L=I[g]K=L(a,i)a=b()I[a]=K U=22376-22374 i=1029245+-1029244 L=I[g]e=I[x]K=L(i,e)i=b()r=B(-312472+268995)I[i]=K K=I[g]e=K(G,U)K=188839-188838 L=e==K K=B(-286081+242088)U=B(763384+-807014)e=b()I[e]=L Z=v[r]E=I[g]vJ={E(k,y)}r=Z(H(vJ))L=B(993649+-1037392)Z=B(-402862-(-359232))L=l[L]BJ=r..Z G=U..BJ U=B(-718137-(-674230))L=L(l,K,G)G=b()I[G]=L K=v[U]BJ=d(15350323-604598,{g,u;O,q;V;p,e;G;x,i;a,T})U={K(BJ)}L={H(U)}U=L L=I[e]L=L and 911279+2238563 or-4562+7178513 end else X=B(-337972+293898)g=B(343770+-387906)D=K K=v[g]g=B(-355442+311229)L=K[g]g=b()s=B(848715+-892789)I[g]=L K=v[X]X=B(-235773-(-192208))L=K[X]f=v[s]T=f O=L X=L L=f and 17088278-622054 or 4869190-317787 end else if L<12636687-(-577675)then if L<14199742-1030603 then o=I[z[-474953+474954]]K=#o o=522853+-522853 L=K==o L=L and 511787+-339360 or 28662+2139506 else D=I[z[15711-15710]]T=B(125959+-170088)n=15157064306155-(-560551)O=19816110114665-(-728226)s=B(-1090817-(-1046734))J=13521490291019-381107 g=I[z[296292+-296290]]X=g(T,O)K=D[X]T=I[z[383177-383176]]O=I[z[57318+-57316]]f=O(s,n)X=T[f]g=V[X]n=11308445752149-(-211260)T=I[z[957182-957181]]O=I[z[787089-787087]]s=B(891047-934912)f=O(s,n)X=T[f]D=g[X]X=I[z[-563698+563699]]T=I[z[-921616+921618]]p=B(-439490-(-395943))f=B(94698-138771)s=123892+5893195179716 O=T(f,s)g=X[O]T=L s=I[z[714645-714644]]m=656552+2564071866369 n=I[z[-981146-(-981148)]]l=n(p,m)f=s[l]m=B(36520-80035)O=V[f]n=I[z[42851-42850]]f=B(-698630+655068)l=I[z[-215770-(-215772)]]f=O[f]p=l(m,J)s=n[p]f=f(O,s)L=f and 10847672-(-483688)or 10207301-38129 X=f end else X=W(X)j=nil T=W(T)g=nil L=-967466+15857048 end end end end else if L<14168679-493749 then if L<14034632-595371 then if L<943482+12411700 then if L<-459047+13746647 then if L<13052324-(-220499)then c=B(398786+-442239)q=v[c]L=707040-452124 c=q()else K=I[z[-647428+647429]]T=1006293665463-804067 X=B(-499320+455738)L=K[o]j=I[z[986140+-986138]]D=I[z[-194630+194633]]g=D(X,T)c=j[g]K=V[c]c=I[z[689632+-689631]]j=B(-978224-(-934037))j=c[j]j=j(c,o,V)L[K]=j L=587046+10572666 end else if L<13261155-(-40913)then m=-821211+35152942335948 f=B(-787936+743919)X=L p=B(-852261+808719)O=v[f]f=O(c)s=I[z[-443546-(-443547)]]n=I[z[595556+-595554]]l=n(p,m)O=s[l]T=f~=O g=T L=T and 261107+7875984 or 4679915-(-396943)else L=v[B(-902340+858810)]K={}end end else if L<504821+12927264 then if L<13592076-202967 then L=I[z[1001879-1001878]]K=B(-42036+-1964)K=L[K]K=K(L)L=7999604-(-653236)else K=I[z[-711937-(-711938)]]L=not K o=M[406140-406139]L=L and 504694+7530379 or 4148873-(-858774)end else o=M[99355+-99354]q=M[-979460-(-979463)]V=M[-128438-(-128440)]c=I[z[60297+-60296]]K=c[o]L=not K L=L and 15669861-(-514345)or 6647059-(-876066)end end else if L<12449627-(-1039961)then if L<-274832+13756055 then if L<13947975-486401 then K=B(-254403+210970)o=B(710924-754718)L=v[K]K=v[o]o=B(-812205-(-768411))v[o]=L o=B(763651-807084)v[o]=K L=6430985-(-24020)o=I[z[-152395-(-152396)]]V=o()else K=o L=V L=5301425-(-948636)end else T=B(764879-808630)c=I[z[803201-803200]]D=I[z[88757-88755]]O=-632083+13692976479739 g=I[z[-78211+78214]]X=g(T,O)j=D[X]q=c[j]j=I[z[449745-449743]]D=I[z[984474+-984471]]X=B(159881-203742)T=24309406786599-604144 g=D(X,T)c=j[g]V=q[c]q=-443325-(-443326)o=V<q L=o and 1966894-922760 or-884456+9574651 K=o end else if L<71462+13457337 then if L<13903830-379287 then K=I[z[-144894-(-144895)]]L=not K L=L and 14268646-584730 or 308709+6021192 else L=v[B(220575-264709)]K={}end else f=L n=167508-167507 s=c>n L=s and-754123+16558178 or-283912+4582782 O=s end end end else if L<14804907-898972 then if L<12932220-(-824331)then if L<399901+13319836 then if L<911561+12772482 then K={}L=v[B(562665+-606397)]else s=I[z[-780272+780277]]l=I[z[369288-369285]]p=I[z[994154+-994150]]J=B(-137148+93414)S=2119958084261-(-231734)L=-603058+5470967 P=24674884245914-404664 m=p(J,P)n=l[m]f=s[n]n=I[z[202208-202207]]P=B(362883-406934)p=I[z[-900202-(-900205)]]m=I[z[282193+-282189]]J=m(P,S)l=p[J]s=n[l]O=f-s s=I[z[20597-20591]]J=B(-90384+46787)l=I[z[-787432+787435]]P=301278+146643838822 p=I[z[-525848-(-525852)]]m=p(J,P)n=l[m]f=s[n]T=O/f g=T end else j=I[z[725620-725619]]c=j[o]O=B(-87582-(-44069))g=I[z[-702317+702319]]f=3188911772674-(-438730)X=I[z[51205-51202]]T=X(O,f)D=g[T]O=B(805991-849630)j=V[D]L=c[j]f=33335541457688-(-22923)g=I[z[48990-48988]]c=L X=I[z[680831-680828]]T=X(O,f)D=g[T]j=c[D]L=not j L=L and 69479+8430288 or 839248+218685 end else if L<14029969-217813 then if L<12914080-(-855295)then pJ=B(189868+-233955)lJ=v[pJ]JJ=I[c]uJ=B(-603057+559411)mJ=I[V]xJ=19719799936668-340670 SJ=mJ(uJ,xJ)pJ=B(677500-721062)uJ=34842208070692-(-54076)pJ=lJ[pJ]PJ=JJ[SJ]pJ=pJ(lJ,PJ)xJ=B(-833099-(-789275))SJ=B(415205+-459280)PJ=I[c]JJ=I[V]mJ=JJ(SJ,uJ)lJ=PJ[mJ]aJ=554214+19790491840281 nJ=pJ[lJ]lJ=823138+-823128 TJ=nJ+lJ PJ=B(-1001901+957814)nJ=b()I[nJ]=TJ lJ=A(-479295+1499387,{c;V})TJ=b()I[TJ]=lJ pJ=v[PJ]mJ=I[c]SJ=I[V]uJ=SJ(xJ,aJ)JJ=mJ[uJ]uJ=B(-669077-(-625570))PJ=B(-67630-(-23682))L=-310007+13030083 PJ=pJ[PJ]xJ=-606635+17395273032015 PJ=PJ(pJ,JJ)JJ=I[c]mJ=I[V]SJ=mJ(uJ,xJ)pJ=JJ[SJ]lJ=PJ[pJ]pJ=B(517576+-561750)PJ=d(12509743-372238,{NJ;c;V,nJ,TJ})pJ=lJ[pJ]TJ=W(TJ)pJ=pJ(lJ,PJ)nJ=W(nJ)else L=7066636-927664 K=143230+-143229 I[z[324923-324921]]=K end else K=I[z[-267722-(-267723)]]V=I[z[-875574-(-875576)]]D=17281092772857-(-326518)j=B(-275266+231806)q=I[z[980569+-980566]]g=33639582873853-(-1000499)c=q(j,D)o=V[c]L=K[o]o=R(972670-620252,{z[690057-690056],z[39436+-39434],z[-630050+630053]})D=B(-305236+261333)K=B(617702+-661876)K=L[K]K=K(L,o)o=b()L=nil I[o]=L K=I[z[51459+-51455]]q=I[z[1034360-1034358]]c=I[z[-986435+986438]]j=c(D,g)V=q[j]L=K[V]K=B(766498+-810672)K=L[K]V=F(15540444-114509,{z[132785+-132784];z[34920-34918];z[-212623+212626],z[-307267+307272];o})K=K(L,V)I[o]=K o=W(o)K={}L=v[B(-318294+274493)]end end else if L<14452741-516569 then if L<14860373-926787 then if L<13809817-(-112978)then L=8835298-(-217420)else p=p+u l=p<=S a=not x l=a and l a=p>=S a=x and a l=a or l a=-549295+2122628 L=l and a l=-493149+2778747 L=L or l end else j,X=D(c,j)L=j and 2009102-(-139329)or 3748510-(-376413)end else if L<13959870-(-67186)then if L<-841410+14865684 then D=265737+12571884964053 j=B(128590+-172639)K=I[z[-211739+211743]]V=I[z[314831+-314829]]q=I[z[-80346-(-80349)]]c=q(j,D)o=V[c]L=K[o]L=L and-989864+2740093 or 630433+11163956 else q=B(301458-345594)K=v[q]c=I[z[388758+-388757]]j=I[z[-777073+777075]]X=-928890+32494877927317 g=B(629863+-673715)D=j(g,X)q=c[D]L=K[q]K=L(V)L=12679768-891369 V=K end else s=false f=I[z[-293067-(-293078)]]O=f==s L=O and 5334199-(-51402)or 626574+293970 end end end end end else if L<15400350-211921 then if L<939286+13874070 then if L<257370+14325941 then if L<963253+13566275 then if L<-534229+14797787 then if L<203762+13914986 then D=.05 s=590491-590481 J=B(859605-903216)a=-245593+19597901718270 T=960576+-960575 x=B(-424521+380366)c=V X=c-T m=v[J]P=I[z[648579-648577]]O=-645201-(-645211)S=I[z[-219404+219407]]u=S(x,a)J=P[u]p=m[J]x=7252+31914965605817 u=B(-796501+752323)J=I[z[732460+-732458]]P=I[z[465741+-465738]]S=P(u,x)m=J[S]l=p[m]m=I[z[-956167+956169]]J=I[z[-122133-(-122136)]]S=B(-560585+516608)u=-167765+2402898187187 P=J(S,u)p=m[P]n=l[p]f=s/n n=B(490793+-534329)T=O+f S=B(1038792+-1082562)p=B(-13858+-30092)g=X*T L=D+g u=11109906082596-(-682257)D=L l=50575+10296893885739 L=I[z[273788-273784]]O=I[z[-983510+983512]]f=I[z[678024-678021]]s=f(n,l)f=B(-705926-(-662359))m=-828341+14720927465083 T=O[s]X=j[T]O=v[f]s=I[z[-724401+724403]]n=I[z[873521-873518]]g=B(448067-491575)l=n(p,m)p=B(379906-423554)f=s[l]T=O[f]l=v[p]m=I[z[316904-316902]]f=.3 J=I[z[82231-82228]]P=J(S,u)p=m[P]n=l[p]P=B(-77260+33435)p=I[z[980299+-980297]]j=nil S=10989549760976-433619 m=I[z[-1035472-(-1035475)]]x=-343995+25288494247354 J=m(P,S)l=p[J]s=n[l]m=B(-46934-(-3286))u=B(201726-245914)p=v[m]J=I[z[287293+-287291]]P=I[z[515964+-515961]]S=P(u,x)m=J[S]l=p[m]S=B(-965407+921641)u=-373006+6855511096710 m=I[z[636623-636621]]J=I[z[-485524+485527]]P=J(S,u)p=m[P]n=l[p]m=-961436+13785003050159 O=T(f,s,n)s=I[z[137642+-137640]]p=B(109529+-153294)n=I[z[270996-270993]]l=n(p,m)f=s[l]c=nil g=L[g]P=B(87904+-131341)l=B(-97541-(-54089))n=v[l]p=I[z[-765887+765889]]m=I[z[-1040720+1040723]]S=33166566819438-739866 J=m(P,S)l=p[J]s=n[l]m=-529195-(-529195)l=.98 p=24309+-24309 n=s(l,p,D,m)T={[f]=n}g=g(L,X,O,T)D=nil L=B(-542383-(-498910))L=g[L]L=L(g)L=311853+10197512 else T=437896+781241783011 c=B(-754946+710872)q=v[c]X=B(-139242-(-95197))j=I[z[-160194+160197]]D=I[z[-737000-(-737004)]]g=D(X,T)c=j[g]L=q[c]c=I[z[267047-267042]]q=L(c)L=q and 814869+5234797 or 5972390-814288 c=q end else if L<-367216+14857456 then q=I[z[146841+-146840]]j=I[z[-635467-(-635469)]]X=B(-521876-(-478286))D=I[z[-824184-(-824187)]]T=-87492+4941874290369 g=D(X,T)c=j[g]V=q[c]o=not V K=o L=o and 5964298-(-285763)or 994111+6754191 else K=I[z[-686076+686077]]V=I[z[59884-59882]]D=-1028669+1865188029857 q=I[z[958276+-958273]]j=B(670693-714442)c=q(j,D)o=V[c]L=K[o]K=B(91172+-135346)K=L[K]o=d(-854635+14281734,{z[-581381-(-581385)],z[-315784+315789];z[134430-134428],z[1047595+-1047592];z[-420694-(-420700)]})K=K(L,o)I[z[-735677-(-735684)]]=K K={}L=v[B(676419-719894)]end end else if L<-936882+15507984 then if L<13559118-(-1008024)then K=B(-11749-31678)L=v[K]K=L()L=v[B(66541+-110619)]K={}else L=false I[z[-717267+717270]]=L L=6146626-258034 end else vJ=-1008881-(-1008883)E=U[vJ]vJ=I[G]L=-1027575+4838946 r=E==vJ BJ=r end end else if L<205779+14502171 then if L<14536747-(-129669)then if L<14955254-319886 then j=nil L=-629678+3740328 c=nil else q=L g=I[z[453759+-453758]]T=I[z[-752812-(-752814)]]n=10577625170200-732635 s=B(387191-431397)O=I[z[554322+-554319]]f=O(s,n)X=T[f]f=B(-1086051-(-1042392))s=235149+2811769040528 D=g[X]X=I[z[770037+-770035]]T=I[z[192535+-192532]]O=T(f,s)g=X[O]j=D[g]D=-737003-(-737004)c=j>D V=c L=c and 6125036-730308 or 11240453-(-51411)end else L=true I[z[-646591+646592]]=L f=30828045378198-617091 O=640421+11196029046456 V=true o=B(574331+-618003)T=B(170326+-214206)K=v[o]o=K(V)o=B(-4092-39905)K=v[o]V=I[z[782386+-782384]]c=I[z[-896447+896450]]D=I[z[697690+-697686]]g=I[z[-380687+380692]]X=g(T,O)j=D[X]D=B(-308149-(-264244))q=c[j]c=-836415-(-836416)o=K(V,q,c)g=33963895828788-(-576659)s=34970190203171-936327 q=I[z[-109487-(-109491)]]c=I[z[-602429-(-602434)]]j=c(D,g)V=q[j]K=o[V]L=v[B(-216986-(-173275))]V=B(207165+-251095)V=K[V]V=V(K)V=B(791922+-835919)K=v[V]q=I[z[-1038242-(-1038244)]]O=B(-615196-(-571142))j=I[z[257453-257450]]g=I[z[87995+-87991]]X=I[z[892670+-892665]]T=X(O,f)D=g[T]c=j[D]g=B(-590516+546871)j=-475748+475749 V=K(q,c,j)c=I[z[866760+-866756]]j=I[z[-893769+893774]]X=259404+34754591033835 D=j(g,X)q=c[D]c=969368-969363 K=V[q]q=B(-561887-(-517957))q=K[q]q=q(K,c)q=B(695736+-739733)K=v[q]c=I[z[782696-782694]]D=I[z[130897+-130894]]f=B(-492705-(-448919))X=I[z[69879+-69875]]T=I[z[688288+-688283]]O=T(f,s)g=X[O]j=D[g]T=-918024+19323224794414 X=B(-596327-(-552211))D=-238729+238730 q=K(c,j,D)j=I[z[-805512+805516]]D=I[z[86472+-86467]]V=nil g=D(X,T)o=nil c=j[g]K=q[c]c=B(434571-478501)c=K[c]c=c(K)K=false D=false j=B(-476830+433158)I[z[602886-602885]]=K c=v[j]j=c(D)q=nil K={}j=B(697300-740932)c=v[j]j=c()end else if L<-40102+14843183 then if L<14873886-137098 then g=B(415663+-459823)X=5007513279984-(-617259)q=B(46965+-91101)K=v[q]c=I[z[-57797+57798]]j=I[z[412393+-412391]]D=j(g,X)q=c[D]L=K[q]K=L(V)L=860639+-499585 V=K else c=18146+-18145 j=-245858-(-245860)V=I[z[-969516+969517]]q=V(c,j)V=-235540+235541 o=q==V K=o L=o and-345872+17034551 or-151033+6980694 end else X=B(291900-335548)g=v[X]n=274803+11509160665980 s=B(694866+-738913)T=I[z[-924809-(-924810)]]O=I[z[512018+-512016]]f=O(s,n)X=T[f]K=g[X]X=I[z[81635+-81634]]f=B(670329+-713741)T=I[z[-512706+512708]]s=15032612712429-660629 O=T(f,s)g=X[O]L=K[g]c=L L=9462656-(-209716)end end end else if L<15529162-496617 then if L<15760623-841744 then if L<633104+14276461 then if L<14773204-(-84699)then j=I[z[-152306+152310]]O=B(-1042731-(-998941))f=27761606626850-383907 g=I[z[270529-270527]]X=I[z[980841-980838]]T=X(O,f)D=g[T]L=1019903+12456994 c=j[D]j=-793317-(-793317)q=c==j o=q else L=I[z[761736-761724]]K=B(200577+-244154)K=L[K]K=K(L)L=253186+14236962 end else K=I[z[410587-410586]]L=K[o]c=I[z[-506002+506004]]X=8154181831209-(-754860)g=B(633327+-676882)j=I[z[-265644+265647]]D=j(g,X)q=c[D]K=V[q]q=I[z[-615458+615459]]c=B(-352102-(-307915))c=q[c]c=c(q,o,V)L[K]=c L=997141+3543344 end else if L<-528246+15531172 then if L<-866762+15857389 then V=nil q=nil o=nil L=v[B(-941926+898360)]K={}else L=v[B(1007561+-1051230)]K={}end else K=B(157159-201158)D=10103634349069-(-247379)o=-429001+17767498819 L=v[K]K=L(o)K=B(1024614+-1068565)j=B(-1023936-(-980265))L=v[K]g=-351533+5317861598937 V=I[z[-677677+677678]]q=I[z[5338-5336]]c=q(j,D)o=V[c]D=B(312383+-355918)q=I[z[534779-534778]]X=22886553216126-(-132387)c=I[z[61157-61155]]j=c(D,g)V=q[j]c=I[z[-106791+106792]]j=I[z[-951998-(-952000)]]g=B(-442684-(-398490))D=j(g,X)q=c[D]K=L(o,V,q)L=I[z[127295+-127292]]c=B(-889551-(-845327))o=I[z[720381+-720380]]j=-990545+33503484926530 g=B(-371622+327848)V=I[z[755683-755681]]q=V(c,j)K=o[q]X=299389+20993649841330 V=B(-148873-(-105433))o=v[V]c=I[z[-584000-(-584001)]]j=I[z[1005956-1005954]]D=j(g,X)q=c[D]j=4682901031435-(-491129)V=o(q)c=B(93544-137603)L[K]=V L=I[z[-227120-(-227123)]]o=I[z[-88740+88741]]V=I[z[-388282+388284]]q=V(c,j)K=o[q]o=709447-709447 L[K]=o K={}L=v[B(-420274+376783)]end end else if L<-609727+15732878 then if L<554631+14537245 then if L<-356428+15405618 then L=p and 11685742-(-107043)or-14874+3977822 else L=q L=6151208-1005682 K=V end else V=I[z[-58688-(-58690)]]j=B(-67272+23709)q=I[z[501940+-501937]]D=25130241494721-(-1007349)c=q(j,D)K=V[c]L=o[K]q=I[z[-583937+583939]]c=I[z[261441+-261438]]g=14570133242319-(-989361)D=B(-51228+7168)j=c(D,g)K=B(-277289+233749)K=L[K]V=q[j]K=K(L,V)L=K and-807459+4828964 or 3440354-(-502090)end else if L<961086+14200614 then if L<-118932+15263500 then D=I[z[218768-218767]]n=11498822939466-(-876960)g=I[z[980622-980620]]s=B(507783-551612)O=4682272299189-512049 T=B(290644-334825)X=g(T,O)j=D[X]c=o[j]X=B(-544387-(-500739))g=v[X]T=I[z[482705-482704]]O=I[z[1002055-1002053]]f=O(s,n)X=T[f]f=B(82445-126072)D=g[X]s=439075+12371395109725 X=I[z[805231-805230]]T=I[z[433354+-433352]]O=T(f,s)g=X[O]j=D[g]q=c==j L=q and 615938+12641688 or 1155257-900341 else g=302897-302896 K=I[z[1029354+-1029349]]j=o m=B(-190322-(-146253))D=j-g T=967974-967973 L=K[D]D=I[z[-661187-(-661192)]]J=15537151126889-(-306906)K=D[j]g=I[z[710550-710545]]X=j+T D=g[X]T=b()X=b()I[X]=K I[T]=D f=I[z[741209-741208]]g=L n=I[z[518657+-518655]]l=I[z[-543082-(-543085)]]p=l(m,J)s=n[p]O=f[s]D=not O K=D L=D and-1020244+11897139 or 820887+3147027 end else l=B(850284-893776)L=I[g]p=24076656485083-(-493808)f=I[z[1044280+-1044279]]s=I[z[603891+-603889]]n=s(l,p)O=f[n]l=B(-181926+138348)m=B(-611185+567483)f=true p=191644+7191173619832 L[O]=f L=I[g]f=I[z[686812+-686811]]s=I[z[735750+-735748]]n=s(l,p)p=22862692276079-(-397863)O=f[n]f=false L[O]=f L=I[g]f=I[z[-453682+453683]]s=I[z[185265+-185263]]J=653265+19056218155736 l=B(36768+-80532)n=s(l,p)O=f[n]p=1611097832478-162096 f=676766+-676766 l=B(-171707+127986)L[O]=f L=I[g]f=I[z[1024820-1024819]]s=I[z[-601500+601502]]n=s(l,p)O=f[n]n=I[z[967158+-967157]]l=I[z[-682633+682635]]p=l(m,J)J=10557883882121-(-30891)s=n[p]f=c[s]L[O]=f f=B(-292279+248646)O=v[f]s=I[z[820172+-820171]]S=B(734390-778572)n=I[z[-628505-(-628507)]]m=-213702+21459412036046 p=B(-440750-(-396540))l=n(p,m)f=s[l]L=O[f]m=-152347+31794923719920 p=B(898792+-942197)s=I[z[941314-941313]]u=2028119212756-786212 n=I[z[-303559+303561]]l=n(p,m)f=s[l]O=L(f)s=B(629144-672777)f=b()I[f]=O O=v[s]m=B(-881442+837873)n=I[z[-783852+783853]]l=I[z[254990-254988]]p=l(m,J)J=356982+28098680668326 s=n[p]L=O[s]m=B(418412+-462307)n=I[z[707558+-707557]]l=I[z[-395645+395647]]p=l(m,J)s=n[p]O=L(s)s=b()m=B(-578850+535429)I[s]=O J=4875433835345-(-69005)L=I[g]n=I[z[-3655+3656]]l=I[z[-578960+578962]]p=l(m,J)O=n[p]l=I[f]m=I[z[-688372+688373]]J=I[z[886169+-886167]]P=J(S,u)p=m[P]m=B(-571509+527368)S=B(-361839-(-318159))J=-286061+363361967638 n=l[p]L[O]=n L=I[g]n=I[z[786957-786956]]u=24412+15549596876012 l=I[z[-722537-(-722539)]]p=l(m,J)O=n[p]l=I[s]m=I[z[317476-317475]]J=I[z[-764547-(-764549)]]P=J(S,u)p=m[P]n=l[p]L[O]=n O=I[g]n=B(-44280-(-807))L=F(5212320-(-871527),{z[-60474+60475],z[-953001+953003];g,z[383306-383303];j,X,T,D;z[-389037+389041];z[1033475-1033470];z[-937796-(-937802)],s,f})O[n]=L O=I[g]L=F(92423+6525437,{g,z[616401-616400],z[-491422+491424]})n=B(-767322-(-723327))O[n]=L O=I[g]n=B(13738+-57850)L=C(-1035080+13314128,{z[-543781+543782],z[972801+-972799];g})O[n]=L L=I[g]K={L}L=v[B(-534282-(-490732))]end end end end else if L<730156+15107567 then if L<-352770+15852879 then if L<7747+15318992 then if L<773758+14468796 then if L<14705243-(-511547)then c=B(208436+-251853)q=v[c]L=-536586+5848313 c=q()else L=I[z[440032+-440022]]V=I[z[496116+-496105]]o[L]=V L=I[z[651167-651155]]V={L(o)}L=v[B(886231-930006)]K={H(V)}end else if L<14348710-(-930813)then L=K and-897038+15623506 or-23409-(-384463)else L=10626361-(-135514)q=I[z[-578246+578249]]V=not q K=V end end else if L<16099763-661553 then if L<658098+14701604 then q=M[254389-254386]V=M[275556+-275554]u=455114+6317809129907 T=923428+23279292846900 c=B(-199548+155915)K=v[c]o=M[-315414-(-315415)]l=134278+31931299376527 X=B(984300-1028157)j=I[z[96517-96516]]D=I[z[847986-847984]]g=D(X,T)c=j[g]L=K[c]j=I[z[917293+-917292]]x=20839821697934-(-442970)D=I[z[-495725+495727]]f=B(293727+-337768)T=204853+23111854049749 X=B(-455534-(-411655))g=D(X,T)X=924320+11333962004989 c=j[g]g=B(-210243+166775)K=L(c)c=K K=I[z[-339560+339561]]j=I[z[-107148-(-107150)]]D=j(g,X)L=K[D]T=-253779+22019446687584 X=B(-1037959+994259)j=I[z[565309-565308]]D=I[z[58691-58689]]g=D(X,T)K=j[g]c[L]=K s=-610598+18081993585162 K=I[z[-715840-(-715841)]]g=B(493639+-537692)X=790980+32868743457285 j=I[z[621629-621627]]D=j(g,X)X=-461580+1171005672749 L=K[D]K=true c[L]=K g=B(34964-78672)K=I[z[520237+-520236]]j=I[z[-629032-(-629034)]]D=j(g,X)g=B(928569+-972217)L=K[D]D=v[g]X=I[z[-229361-(-229362)]]T=I[z[709977+-709975]]O=T(f,s)f=869004+6397038823702 g=X[O]j=D[g]O=B(-257009-(-213093))g=I[z[-399136+399137]]X=I[z[792017-792015]]T=X(O,f)O=396047+15365242163427 D=g[T]g=B(929100+-972747)K=j[D]c[L]=K X=18214844399007-40062 T=B(653798-697838)K=I[z[828997-828996]]j=I[z[-819989+819991]]D=j(g,X)L=K[D]K=false j=B(-212382+168749)c[L]=K K=v[j]D=I[z[-676302-(-676303)]]g=I[z[-742994-(-742996)]]X=g(T,O)T=B(-998612+954376)j=D[X]L=K[j]D=I[z[-600030-(-600031)]]g=I[z[-551841-(-551843)]]O=825599+19782397496060 X=g(T,O)j=D[X]K=L(j)X=B(991292+-1035527)j=K K=I[z[-55295-(-55296)]]O=19378602238083-179524 T=-998919+30496581301632 D=I[z[638839-638837]]f=B(-930281-(-886717))g=D(X,T)T=B(1044465+-1088039)L=K[g]D=I[z[-124844+124845]]g=I[z[-615139-(-615141)]]X=g(T,O)K=D[X]j[L]=K K=I[z[-559110+559111]]D=I[z[289315-289313]]s=-100347+32242029855392 X=B(-850359-(-806331))T=473592+27429207816172 g=D(X,T)L=K[g]K=c j[L]=K K=I[z[471619-471618]]T=302549+27506724443187 D=I[z[-655809-(-655811)]]X=B(613689+-657383)g=D(X,T)L=K[g]g=B(857306+-900940)D=v[g]X=I[z[-249005-(-249006)]]T=I[z[-856396-(-856398)]]O=T(f,s)g=X[O]f=B(-245094-(-201182))X=-906046+906046 K=D[g]g=234347+-234346 D=K(g,X)j[L]=D T=29484114769266-1048529 X=B(556473-600170)K=I[z[902954+-902953]]D=I[z[114404-114402]]g=D(X,T)L=K[g]g=B(332484-376626)D=v[g]s=26834469694003-(-788124)X=I[z[526795+-526794]]T=I[z[-513854+513856]]O=T(f,s)g=X[O]X=8467+-8212 K=D[g]T=473759+-473504 g=947510+-947255 D=K(g,X,T)j[L]=D T=-165186+25766545962016 s=28121876693783-(-503824)K=I[z[148272+-148271]]X=B(101915+-145723)D=I[z[-222041+222043]]g=D(X,T)L=K[g]g=B(-889214-(-845072))f=B(-599733+555547)D=v[g]X=I[z[-574032-(-574033)]]T=I[z[-891930-(-891932)]]O=T(f,s)g=X[O]K=D[g]g=28351+-28096 T=-367300+367555 X=-856744+856999 D=K(g,X,T)T=-145842+11247999995431 j[L]=D K=I[z[437985+-437984]]X=B(-274344+230305)s=622074+30524774594956 D=I[z[874386+-874384]]g=D(X,T)L=K[g]f=B(-439448-(-395398))K=994206-994206 j[L]=K K=I[z[-930770-(-930771)]]T=199483+22497139105201 D=I[z[373216+-373214]]X=B(-209206+164995)g=D(X,T)L=K[g]g=B(495729-539181)D=v[g]X=I[z[-210524-(-210525)]]T=I[z[-557801-(-557803)]]O=T(f,s)T=.05 g=X[O]O=-101912+101912 K=D[g]f=B(-321405-(-277743))X=147980-147980 g=1.05 s=-300730+2033694136941 D=K(g,X,T,O)j[L]=D K=I[z[718004-718003]]J=-446634+2624978212208 T=895349+21544892890555 D=I[z[90006+-90004]]X=B(-410920+366695)g=D(X,T)L=K[g]g=B(-988702+945250)D=v[g]X=I[z[-864725+864726]]T=I[z[788011-788009]]O=T(f,s)g=X[O]s=B(823502+-867648)K=D[g]O=586556-586556 g=.35 T=.15 f=32534442833096-(-296550)X=960738+-960738 D=K(g,X,T,O)j[L]=D O=B(928399-971947)K=I[z[469363+-469362]]X=B(-773043+728898)T=6450309965660-88993 D=I[z[73823-73821]]g=D(X,T)L=K[g]D=B(612192-655825)n=1004441+25304380725870 K=true j[L]=K K=v[D]g=I[z[-603068+603069]]X=I[z[159631-159629]]T=X(O,f)O=B(-910342-(-866417))D=g[T]L=K[D]g=I[z[-62279-(-62280)]]f=27322188354113-598159 X=I[z[-348057-(-348059)]]T=X(O,f)D=g[T]K=L(D)D=K K=I[z[602292-602291]]O=13305821463974-863602 g=I[z[881567-881565]]T=B(-127129-(-83191))X=g(T,O)L=K[X]K=j D[L]=K T=B(192351-236394)K=I[z[-837276+837277]]O=11135072797797-(-315356)g=I[z[983134+-983132]]X=g(T,O)L=K[X]X=B(-873351+829209)g=v[X]T=I[z[919949+-919948]]O=I[z[470983-470981]]f=O(s,n)X=T[f]K=g[X]O=127966+-127711 X=118030+-117775 T=-243333-(-243588)g=K(X,T,O)T=B(-813580+770109)O=-742013+1400743023881 f=B(-79969+35881)s=685991+34246926681764 D[L]=g K=I[z[-552966+552967]]g=I[z[501019+-501017]]X=g(T,O)g=B(132254-175887)L=K[X]K=-805788+805790 D[L]=K K=v[g]X=I[z[58108+-58107]]T=I[z[525131-525129]]O=T(f,s)f=B(-653840-(-609940))g=X[O]L=K[g]s=1453972883821-329416 X=I[z[-152286+152287]]m=B(62853-106565)T=I[z[582237+-582235]]O=T(f,s)g=X[O]K=L(g)g=K K=I[z[-837180-(-837181)]]X=I[z[333273+-333271]]S=B(-3237+-40412)O=B(530391+-573945)f=595622+23420188120051 T=X(O,f)L=K[T]n=B(322255-366087)T=B(497641-541574)X=v[T]O=I[z[52294-52293]]f=I[z[155165-155163]]s=f(n,l)T=O[s]s=B(-448203-(-404733))K=X[T]f=v[s]n=I[z[-550094+550095]]l=I[z[-982990+982992]]p=l(m,J)s=n[p]O=f[s]p=B(668520-712662)l=v[p]s=368133+-368133 m=I[z[363541+-363540]]J=I[z[-334223+334225]]P=J(S,u)p=m[P]n=l[p]m=-163408+163408 P=3143966625692-(-472604)J=-285652-(-285652)p=-635925-(-635925)l={n(p,m,J)}f=O(s,H(l))n=B(-389994-(-346524))J=B(-357503-(-313882))s=v[n]l=I[z[382578-382577]]p=I[z[-331015+331017]]m=p(J,P)n=l[m]O=s[n]m=B(-789025-(-744883))n=-1037732+1037733 p=v[m]u=B(476592-520028)J=I[z[-728809-(-728810)]]P=I[z[649132-649130]]S=P(u,x)P=-711025-(-711280)m=J[S]l=p[m]J=451869+-451614 m=-125399-(-125654)p={l(m,J,P)}s={O(n,H(p))}T={f,H(s)}O=B(57989+-101641)n=867386+16152029471015 X=K(T)g[L]=X s=B(386891+-431058)K=I[z[-28978-(-28979)]]X=I[z[-321679+321681]]f=21683053132182-987686 T=X(O,f)O=B(195798-239727)L=K[T]K=756780+-756870 g[L]=K K=I[z[374579+-374578]]X=I[z[-67819-(-67821)]]f=-799575+22926366235914 T=X(O,f)L=K[T]K=j X=B(12326-55959)g[L]=K K=v[X]T=I[z[-887776+887777]]O=I[z[-450538-(-450540)]]f=O(s,n)X=T[f]L=K[X]n=5877282112258-14418 T=I[z[-575706-(-575707)]]O=I[z[-243720-(-243722)]]s=B(926994+-971025)f=O(s,n)X=T[f]K=L(X)X=b()I[X]=K L=I[X]T=I[z[777501-777500]]n=-160393+15171201781281 O=I[z[1006713-1006711]]s=B(-312221-(-268304))f=O(s,n)n=B(246671-290154)l=8474383704374-725452 K=T[f]O=I[z[900880+-900879]]f=I[z[-42305+42307]]s=f(n,l)T=O[s]s=B(582866+-626772)L[K]=T L=I[X]T=I[z[-228435-(-228436)]]O=I[z[352861-352859]]n=-476816+2934940240870 f=O(s,n)s=B(445058-488767)K=T[f]T=j L[K]=T L=I[X]T=I[z[585571+-585570]]O=I[z[947281-947279]]n=9470943691219-454809 f=O(s,n)K=T[f]T=-1016327-(-1016328)L[K]=T s=B(-114386+70803)n=124480866230-(-505987)L=I[X]T=I[z[295146-295145]]m=28701485289860-(-271025)O=I[z[467893-467891]]f=O(s,n)K=T[f]f=B(675808+-719260)p=B(-221595-(-177993))O=v[f]s=I[z[398169-398168]]n=I[z[611360+-611358]]l=n(p,m)f=s[l]T=O[f]n=.042 m=11372480529444-(-692363)f=.018 s=-506038+506038 l=139851-139851 O=T(f,s,n,l)L[K]=O L=I[X]T=I[z[679008+-679007]]n=-413123+2408448741924 s=B(-771050-(-726948))O=I[z[795316+-795314]]f=O(s,n)K=T[f]f=B(626584+-670036)O=v[f]s=I[z[399085-399084]]n=I[z[-343771+343773]]p=B(-551845+507896)l=n(p,m)f=s[l]T=O[f]l=-455709+455709 f=781262+-781261.75 n=.9 s=145316+-145316 O=T(f,s,n,l)s=B(278359-322328)L[K]=O n=-245328+16014253022065 L=I[X]T=I[z[-317104-(-317105)]]O=I[z[-641665-(-641667)]]f=O(s,n)K=T[f]T=q O=L L=q and 1471810-(-513849)or-314945+9405536 else o=M[-550371+550372]q=I[z[736357-736356]]j=I[z[437182+-437180]]T=4428601638187-(-396003)D=I[z[728373-728370]]X=B(-800059+756271)g=D(X,T)c=j[g]V=q[c]K=V L=V and-979449+13341560 or 4619615-(-525911)end else n=690457+22691683573805 T=-748372+14618909427179 c=B(-188731+145164)L=I[z[-365316+365317]]o=I[z[-561529-(-561531)]]q=v[c]j=I[z[-842945+842948]]D=I[z[293654-293650]]X=B(-877106+833519)p=84429+6229646328199 g=D(X,T)X=B(-845858+802210)c=j[g]s=B(986112-1030218)V=q[c]g=v[X]l=28967302051981-885725 c=-895826.5-(-895827)T=I[z[-723526-(-723529)]]O=I[z[175006+-175002]]f=O(s,n)X=T[f]f=B(-505506+461723)D=g[X]s=-934074+15419990465734 X=I[z[800423+-800420]]T=I[z[-863043+863047]]K=B(-640694-(-597186))O=T(f,s)T=B(731277+-774925)g=X[O]j=D[g]X=v[T]O=I[z[670489+-670486]]S=976487+11504679759494 n=B(-341261+297249)f=I[z[116529-116525]]s=f(n,l)T=O[s]g=X[T]K=L[K]s=B(-111929+68092)T=I[z[767068-767065]]n=-217433+26183395442937 O=I[z[-831710+831714]]f=O(s,n)s=B(-525897-(-481733))X=T[f]D=g[X]T=8935772719573-801172 X=B(-963859-(-919888))q=V(c,j,D)j=I[z[-487684+487687]]D=I[z[563454-563450]]g=D(X,T)c=j[g]g=I[z[659685-659683]]n=-399672+16901574277110 l=-901466+12046470027075 T=I[z[175868+-175865]]O=I[z[-976291+976295]]f=O(s,n)X=T[f]D=g[X]T=B(-576030-(-532578))n=B(1003854-1047311)X=v[T]O=I[z[-238791-(-238794)]]f=I[z[194326-194322]]s=f(n,l)T=O[s]P=B(-986745+942841)g=X[T]f=-631907-(-631907)s=-141176-(-141176)T=.07 O=-688537+688537 X=g(T,O,f,s)j=D-X V={[c]=j}K=K(L,o,q,V)L=B(-147067+103594)j=B(986116-1030122)D=17242620964766-(-307135)o=K L=o[L]L=L(o)V=I[z[-136533+136536]]q=I[z[-45339-(-45343)]]c=q(j,D)K=V[c]L=o[K]D=B(-468037+424017)K=B(786164-830094)K=L[K]T=B(-582273+538055)V=B(-335648-(-291530))K=K(L)g=7123211404436-(-1001569)K=v[V]q=I[z[197678+-197675]]c=I[z[-145940-(-145944)]]j=c(D,g)V=q[j]L=K[V]j=B(83826+-127393)V=-496908+496911 K=L(V)L=I[z[-667537-(-667538)]]V=I[z[-586332+586334]]K=B(2853+-46361)c=v[j]O=17873727419933-1021338 D=I[z[90893-90890]]l=16528647235330-510194 n=B(219328-263158)g=I[z[-29564+29568]]X=g(T,O)j=D[X]q=c[j]j=913724.5-913724 T=B(587237+-630885)X=v[T]O=I[z[245750+-245747]]f=I[z[852284-852280]]s=f(n,l)T=O[s]l=B(346113+-389646)n=15646469446519-(-82174)s=B(-19031-24714)g=X[T]T=I[z[-100733-(-100736)]]O=I[z[-532585-(-532589)]]f=O(s,n)O=B(122556+-166204)X=T[f]D=g[X]T=v[O]f=I[z[-533778+533781]]s=I[z[-505407-(-505411)]]n=s(l,p)l=520190+4526850676797 O=f[n]X=T[O]O=I[z[432898+-432895]]n=B(1037733+-1081276)f=I[z[1026780-1026776]]s=f(n,l)T=O[s]g=X[T]O=25334920137361-400508 c=q(j,D,g)T=B(-99905-(-56183))D=I[z[91175-91172]]g=I[z[-756720-(-756724)]]X=g(T,O)j=D[X]X=B(803111-846563)g=v[X]s=B(681676-725120)T=I[z[-695069-(-695072)]]O=I[z[-501717+501721]]n=662848+16497761943746 f=O(s,n)X=T[f]K=L[K]D=g[X]n=I[z[579235+-579233]]X=1.1 p=I[z[680819-680816]]m=I[z[268473-268469]]J=m(P,S)l=p[J]T=-173941+173941 s=n[l]J=B(989518-1033346)l=I[z[-579666-(-579669)]]p=I[z[1043031-1043027]]P=11189954178231-956509 m=p(J,P)n=l[m]f=s[n]n=I[z[-342114-(-342117)]]J=-390169+30998685215867 m=B(466225-510124)l=I[z[1030788+-1030784]]p=l(m,J)s=n[p]O=f[s]f=-832827+832827 g=D(X,T,O,f)q={[j]=g}K=K(L,V,c,q)L=B(-779367+735894)V=K L=V[L]L=L(V)q=I[z[-862284+862287]]c=I[z[864655-864651]]D=B(-282288-(-238632))g=129521+8495910163843 j=c(D,g)K=q[j]L=V[K]K=B(375252-419182)K=L[K]K=K(L)K=B(995137-1038932)L=v[K]j=I[z[-911621-(-911626)]]D={L(j)}q=D[-777904-(-777906)]K=D[-233338+233339]j=K L=3841548-125523 c=D[-394346-(-394349)]end end else if L<16379207-686683 then if L<16373897-798162 then if L<1046102+14500376 then K={}L=v[B(71291-115326)]else o=o+q j=not c K=o<=V K=j and K j=o>=V j=c and j K=j or K j=-760606+15905614 L=K and j K=14455635-(-433947)L=L or K end else s=I[z[737583-737582]]m=-2608+6399924049364 n=I[z[-241612-(-241614)]]p=B(-427711-(-383655))l=n(p,m)f=s[l]p=799455149585-(-148323)O=X[f]l=B(-665616+621603)T=O-o f=I[z[127478+-127477]]s=I[z[1023294-1023292]]n=s(l,p)O=f[n]L=T[O]T=L L=T<q L=L and-669049+12785751 or-288104+11848992 end else if L<-146603+15940181 then if L<15592608-(-116683)then f=nil j=nil L=4226726-(-886549)s=nil else o=I[z[482436+-482435]]K=o L=o and 6599284-693956 or 6383889-740758 end else p=nil l=q~=p s=l n=L L=l and 1732848-223166 or-310077+10617435 end end end else if L<244575+16181394 then if L<16454926-267492 then if L<16673965-510585 then if L<15573015-(-417819)then o=B(971228-1014838)L=v[o]q=461154+-461154 V=I[z[768827-768819]]o=L(V,q)L=3126513-961271 else L=v[B(-391947-(-348509))]K={}end else L=I[z[-717876-(-717877)]]K={}L[o]=K L=-6723+7529848 end else if L<-1033803+17328124 then if L<15434982-(-773750)then K=I[z[-983371-(-983377)]]L=not K L=L and 9944785-999415 or-996118+8368892 else c=B(44215+-87642)L=3221128-(-809832)q=v[c]c=q()end else K=B(-481949-(-438154))L=v[K]q=I[z[-104647-(-104648)]]c={L(q)}L=102488+10406877 K=c[-426595+426596]V=c[-33638+33641]q=K o=c[184564-184562]end end else if L<16424975-(-248338)then if L<17152097-599091 then if L<17342404-899380 then f=I[z[-323431+323432]]J=17427+7182276462845 n=I[z[259220+-259218]]l=I[z[392030-392027]]m=B(42616+-86388)p=l(m,J)L=-189643+11487225 s=n[p]O=f[s]f=-832376+832376 D=O>f K=D else n=B(896071-940145)s=v[n]n=B(44624-88429)f=s[n]L=-409855+4961258 T=f end else c=B(714799+-758813)q=v[c]c=q()L=762409+6113013 end else if L<17511490-805886 then if L<17265943-577281 then c=B(-216805-(-173328))K=B(482004-526025)L=v[K]X=B(-983826-(-939919))o=I[z[152833-152829]]q=v[c]T=R(1451633-1005489,{})g=v[X]X={g(T)}g=859862+-859860 D={H(X)}j=D[g]c=q(j)q=B(-509990+465997)V=o(c,q)o={V()}K=L(H(o))V=I[z[378474+-378469]]o=K K=V L=V and 651520+-310397 or 346601+1509238 else L=K and 641992+16044511 or-224380+6871011 end else K=X L=T L=1037458-886777 end end end end end end end end end L=#Q return H(K)end,-983660+983660,function(v,B)local H=q(B)local M=function(M,z,Q,N,K)return L(v,{M,z,Q,N,K},B,H)end return M end,function()V=(656037+-656036)+V o[V]=-272779+272780 return V end,function(v)for B=791740-791739,#v,-246979-(-246980)do o[v[B]]=(-86119-(-86120))+o[v[B]]end if M then local L=M(true)local H=Q(L)H[B(481137-524840)],H[B(-912607-(-868735))],H[B(-655626+611636)]=v,c,function()return 2569139-105504 end return L else return z({},{[B(-947497-(-903625))]=c;[B(-24417+-19286)]=v;[B(247185+-291175)]=function()return 677655+1785980 end})end end,function(v,B)local H=q(B)local M=function(M)return L(v,{M},B,H)end return M end return(j(-745268+11282837,{}))(H(K))end)(getfenv and getfenv()or _ENV,unpack or table[B(544906+-588711)],newproxy,setmetatable,getmetatable,select,{...})end)(...)
