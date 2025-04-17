spawn(function()
local mod = require(game:GetService("ReplicatedStorage").Client.Framework.Services.LocalData)

local score = 0
local finscore = 5
local id = "7817ddfa-48e6-42e5-9196-28f63b6e4752"
repeat
score = 0
local args = {
    [1] = "RerollEnchants",
    [2] = id
}

local debounce = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer(unpack(args))

game:GetService("RunService").RenderStepped:Wait()

for i,v in pairs(mod.Get().Pets) do

if v.Id == id then
finscore = #v.Enchants+1
for i,v in pairs(v.Enchants) do

if (v.Id == "team-up" and v.Level >= 5) then

score = score + 25

end


end

end

end
until score >= finscore
end)
