-- guardian wtf is this

local zxq = game:GetService("Players").LocalPlayer
local function nkfrqp(brzt)
for i, wq in ipairs(brzt:GetDescendants()) do
if wq:IsA("BasePart") and wq.CanCollide then
wq.CanCollide = false
end
end
end
game:GetService("RunService").Heartbeat:Connect(function(dt)
for i, wq in ipairs(game:GetService("Players"):GetPlayers()) do
if wq ~= zxq and wq.Character then
nkfrqp(wq.Character)
end
end
end)
local function dvxotm(mgtplo)
mgtplo.DescendantAdded:Connect(function(wq)
if wq:IsA("BasePart") then
wq.CanCollide = false
end
end)
end
game:GetService("Players").PlayerAdded:Connect(function(hbnre)
hbnre.CharacterAdded:Connect(dvxotm)
end)
for i, wq in ipairs(game:GetService("Players"):GetPlayers()) do
if wq ~= zxq then
if wq.Character then
dvxotm(wq.Character)
end
wq.CharacterAdded:Connect(dvxotm)
end
end
