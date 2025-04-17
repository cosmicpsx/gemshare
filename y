
spawn(function()
while wait(30) do
local args = {
    [1] = "BuyShopItem",
    [2] = "alien-shop",
    [3] = math.random(1,3)
}

game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
end
end)
spawn(function()
while wait(30) do
local args = {
    [1] = "BuyShopItem",
    [2] = "shard-shop",
    [3] = math.random(1,3)
}

game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
end
end)
spawn(function()
while wait(60*25) do
local args = {
    [1] = "ClaimFreeWheelSpin"
}

game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
end
end)
