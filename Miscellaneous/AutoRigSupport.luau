-- THIS GOES AFTER THE REANIMATION STARTS.

task.spawn(function()
	local Character = Empyrean.Rig
	local Parts = {
	Torso = "autorig_Torso",
	["Right Arm"] = "autorig_RightArm",
	["Left Arm"] = "autorig_LeftArm",
	["Right Leg"] = "autorig_RightLeg",
	["Left Leg"] = "autorig_LeftLeg"
    }
	for i, v in pairs(Parts) do
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
end)
