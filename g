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
