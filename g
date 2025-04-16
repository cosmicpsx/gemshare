loadstring(game:HttpGet("https://raw.githubusercontent.com/vestyx/VestyHub/refs/heads/main/loader.lua", true))()
print(workspace.Rendered:GetChildren()[12].Name)
game:GetService("ReplicatedStorage").Assets.Sounds.UI.Pop.Volume=0
game:GetService("ReplicatedStorage").Assets.Sounds.CoinCollect.Volume=0
game:GetService("ReplicatedStorage").Assets.Sounds.Items.ItemNew.Volume=0
game:GetService("ReplicatedStorage").Assets.Particles.Stars.Enabled = false
game:GetService("ReplicatedStorage").Assets.Particles.Stars.Rate = 0
spawn(function()
while wait(2) do
for i,v in pairs(workspace.Rendered:GetChildren()[12]:GetChildren()) do
local args = {
    [1] = v.Name
}

game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup"):FireServer(unpack(args))
spawn(function()
wait(2)
for i,v in pairs(v:GetDescendants()) do
if v:IsA("BasePart") then v.Transparency = 1 end
if v.ClassName == "PointLight" then v:Destroy() end
end
v.Parent = nil
end)
end
end
end)
local obj = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Currency.Gems
local gemtext = obj:Clone() gemtext.Parent = obj.Parent gemtext.Frame.Buy:Destroy() gemtext.LayoutOrder = 420
gemtext.Frame.Icon.Label.Visible = true gemtext.Frame.Icon.Label.Text = "Vesty v3"
obj = game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Currency.Coins
local cgemtext = obj:Clone() cgemtext.Parent = obj.Parent cgemtext.Frame.Buy:Destroy() cgemtext.LayoutOrder = 69
cgemtext.Frame.Icon.Label.Text = "Vesty v3"
gemtext =gemtext.Frame.Label
cgemtext = cgemtext.Frame.Label

function format(num)
if num >= 1000000000 then
num = math.round(num / 100000000)/10
num = num.."B"
elseif num >= 1000000 then
num = math.round(num / 100000)/10
num = num.."M"
elseif num >= 1000 then
num = math.round(num / 100)/10
num = num.."K"
end
return num
end


local mod = require(game:GetService("ReplicatedStorage").Client.Framework.Services.LocalData)
local save = mod
local oldgems = save.Get().Gems
local gemdiff = 0

local oldcoins = save.Get().Coins
local coindiff = 0
spawn(function()
while wait() do
local newgems = save.Get().Gems
if oldgems ~= newgems then
local nd = (newgems-oldgems)
gemdiff = gemdiff + nd
print(gemdiff)
spawn(function()
wait(15)
gemdiff = gemdiff - nd
end)
end
oldgems = newgems

local newcoins = save.Get().Coins
if oldcoins ~= newcoins then
local nc = (newcoins-oldcoins)
coindiff = coindiff + nc
spawn(function()
wait(15)
coindiff = coindiff - nc
end)
end
oldcoins = newcoins

gemtext.Text = format(math.round(gemdiff/15)).."/s"
cgemtext.Text = format(math.round(coindiff/15)).."/s"
end

end)

local mod = require(game:GetService("ReplicatedStorage").Shared.Data.Pets)

local rem = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.Event
rem.OnClientEvent:Connect(function(thing, tab)
if thing == "HatchEgg" then
for i,v in pairs(tab.Pets) do
if mod[v.Pet.Name].Rarity == "Legendary" then
local chance = mod[v.Pet.Name].Chance/100

local msg = '{"content":"'.."<@1067898782135636009> Legendary Pet Hatched on Account "..game.Players.LocalPlayer.Name..": "..v.Pet.Name.."("..chance.."%)"..'"}'
local response =
        request(
        {
            Url = "https://discord.com/api/webhooks/1361995796051923119/he3RpDWljnpsBk0E_4GO8nI8_a7pAZkIsK5OYk1p6Kh7M-7mOt0BpWuoucYOZulBS6UB",
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = msg
        }
    )

end
end
end
end)
spawn(function()
while wait(20) do
local args = {
    [1] = "ClaimPlaytime",
    [2] = math.random(1,12)
}

game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer(unpack(args))

end
end)
