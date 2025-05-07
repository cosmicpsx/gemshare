local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/main/source.lua", true))()
local Window = Luna:CreateWindow({
	Name = "AetherX", -- This Is Title Of Your Window
	Subtitle = "Competitive Update", -- A Gray Subtitle next To the main title.
	LogoID = "140516501434214", -- The Asset ID of your logo. Set to nil if you do not have a logo for Luna to use.
	LoadingEnabled = false, -- Whether to enable the loading animation. Set to false if you do not want the loading screen or have your own custom one.
	LoadingTitle = "AetherX", -- Header for loading screen
	LoadingSubtitle = "", -- Subtitle for loading screen

	ConfigSettings = {
		RootFolder = "aetherx", -- The Root Folder Is Only If You Have A Hub With Multiple Game Scripts and u may remove it. DO NOT ADD A SLASH
		ConfigFolder = "GG" -- The Name Of The Folder Where Luna Will Store Configs For This Script. DO NOT ADD A SLASH
	},

	KeySystem = false, -- As Of Beta 6, Luna Has officially Implemented A Key System!
	KeySettings = {
		Title = "Luna Example Key",
		Subtitle = "Key System",
		Note = "Best Key System Ever! Also, Please Use A HWID Keysystem like Pelican, Luarmor etc. that provide key strings based on your HWID since putting a simple string is very easy to bypass",
		SaveInRoot = false, -- Enabling will save the key in your RootFolder (YOU MUST HAVE ONE BEFORE ENABLING THIS OPTION)
		SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
		Key = {""}, -- List of keys that will be accepted by the system, please use a system like Pelican or Luarmor that provide key strings based on your HWID since putting a simple string is very easy to bypass
		SecondAction = {
			Enabled = true, -- Set to false if you do not want a second action,
			Type = "Link", -- Link / Discord.
			Parameter = "" -- If Type is Discord, then put your invite link (DO NOT PUT DISCORD.GG/). Else, put the full link of your key system here.
		}
	}
})
function info(title, text)
Luna:Notification({ 
	Title = title,
	Icon = "notifications_active",
	ImageSource = "Material",
	Content = text
})
end
local ar_op = CFrame.new()
function teleportRift(rift, postback)
    ar_op = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
    local robj
    if postback then
        robj = rift.Display.CFrame
    else
        robj = rift 
    end
    wait(1)
    local prv=10
    repeat
    prv=prv+1
    local twn = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.PrimaryPart, TweenInfo.new(prv), {["CFrame"]=robj})
    twn:Play()
    twn.Completed:Wait()
    wait(2)
    until game.Players.LocalPlayer.Character.PrimaryPart.Position.Y+250>robj.Position.Y and game.Players.LocalPlayer.Character.PrimaryPart.Position.Y-250<robj.Position.Y
    if postback then
    rift.Destroying:Connect(function()
    local robj = ar_op
    repeat
        prv=prv+1
        local twn = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.PrimaryPart, TweenInfo.new(prv), {["CFrame"]=robj})
        twn:Play()
        twn.Completed:Wait()
        wait(2)
        until game.Players.LocalPlayer.Character.PrimaryPart.Position.Y+100>oldpos.Position.Y and game.Players.LocalPlayer.Character.PrimaryPart.Position.Y-100<oldpos.Position.Y
        
    end)
    end
    return true
end
function teleportTo(path)
    local args = {
        [1] = "Teleport",
        [2] = path
    }
    
    game:GetService("ReplicatedStorage")
    :WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
end
function sell()
    local oldpos = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
    if workspace.Rendered.Rifts:FindFirstChild("bubble-rift") ~= nil then
    teleportRift(workspace.Rendered.Rifts["bubble-rift"].Display.CFrame, false)
    else
    teleportTo("Workspace.Worlds.The Overworld.Islands.Twilight.Island.Portal.Spawn")
    end
    wait(0.5)

    local args = {
        [1] = "SellBubble"
    }
    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
    wait(0.5)
    teleportRift(oldpos, false)
end
local OverworldCoins = workspace.Rendered:GetChildren()[13]
local collectRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Pickups"):WaitForChild("CollectPickup")

function collectCoins()
    
    for _, coin in pairs(OverworldCoins:GetChildren()) do
        if coin:IsA("Model") or coin:IsA("Part") then
            local id = coin.Name
            collectRemote:FireServer(id)
            wait(0.05)
            spawn(function() wait(2) coin.Parent = nil coin.Name = "nil-this" end)
        end
    end
end
OverworldCoins.ChildAdded:Connect(function(c)
if c.Name == "nil-this" then c.Parent = nil end
end)
function data()
return require(game:GetService("ReplicatedStorage").Client.Framework.Services.LocalData).Get()
end
function petData()
return require(game:GetService("ReplicatedStorage").Shared.Data.Pets)
end


local Tab = Window:CreateTab({
	Name = "Basic Autofarms",
	Icon = "autorenew",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
local HatchTab = Window:CreateTab({
	Name = "Hatching",
	Icon = "102052517059235",
	ImageSource = "Custom",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
local RewardTab = Window:CreateTab({
	Name = "Rewards",
	Icon = "card_giftcard",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
local ToyTab = Window:CreateTab({
	Name = "Toy World",
	Icon = "79450376715421",
	ImageSource = "Custom",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
local MarketTab = Window:CreateTab({
	Name = "Market",
	Icon = "92768859826736",
	ImageSource = "Custom",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
local RiftTab = Window:CreateTab({
	Name = "Rifts",
	Icon = "111490867676309",
	ImageSource = "Custom",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})

info("AetherX", "Hi")
local AutoBubble = Tab:CreateToggle({
	Name = "Auto Bubble",
	Description = nil,
	CurrentValue = false,
    	Callback = function(Value)
        _G.blow = Value
        if Value then
            info("Auto Bubble", "Auto Bubble is ON", "info")
            task.spawn(function()
                while _G.blow do
                    local args = {
                        [1] = "BlowBubble"
                    }
                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                    wait(0.1)
                end
            end)
        else
            info("Auto Bubble", "Auto Bubble is OFF", "x")
        end
       	end
}, "AutoBubble_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
local AutoSell = Tab:CreateToggle({
	Name = "Auto Sell",
	Description = "Auto Sells every minute",
	CurrentValue = false,
    	Callback = function(Value)
        _G.autosell = Value
        if Value then
            info("Auto Sell", "Auto Sell is ON", "info")
            task.spawn(function()
                repeat
                    wait(60)
                    if _G.autosell then
                        sell()
                    end
                until not _G.autosell
            end)
        else
            info("Auto Sell", "Auto Sell is OFF", "x")
        end
       	end
}, "AutoSell_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
local AutoSellAt = Tab:CreateToggle({
	Name = "Auto Sell at X Bubbles",
	Description = "Auto Sells when you reach x Bubbles (Select below)",
	CurrentValue = false,
    	Callback = function(Value)
        _G.autosellat = Value
        if Value then
            info("Auto Sell", "Auto Sell is ON", "info")
            task.spawn(function()
                repeat
                    wait(1)
                    if _G.autosellat and data().Bubble.Amount >= (_G.sellatb or 100000) then
                        sell()
                    end
                until not _G.autosellat
            end)
        else
            info("Auto Sell", "Auto Sell is OFF", "x")
        end
       	end
}, "AutoSellAt_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local AutoSellSlider = Tab:CreateSlider({
	Name = "Sell at Bubble Size",
	Range = {100, 10000000}, -- The Minimum And Maximum Values Respectively
	Increment = 100, -- Basically The Changing Value/Rounding Off
	CurrentValue = 100000, -- The Starting Value
    	Callback = function(Value)
       	_G.sellatb=Value
    	end
}, "ASSlider_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
Tab:CreateSection("Auto Collect Drops")
local AutoCollect = Tab:CreateToggle({
	Name = "Auto Collect Coins",
	Description = "Automatically collects coin & gem drops",
	CurrentValue = false,
    	Callback = function(Value)
        _G.autocollect = Value
        if Value then
            info("Auto Collect", "Auto Collect is ON", "info")
            task.spawn(function()
                repeat
                    collectCoins()
                    wait(0.5)
                until not _G.autocollect
            end)
        else
            info("Auto Collect", "Auto Collect is OFF", "x")
        end
       	end
}, "AutoCollect_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
Tab:CreateSection("Coin Farm Addons")
local ATPZ = Tab:CreateSlider({
	Name = "Auto Teleport to Zen at low coins: (IN MILLION)",
	Range = {1, 1000}, -- The Minimum And Maximum Values Respectively
	Increment = 1, -- Basically The Changing Value/Rounding Off
	CurrentValue = 1, -- The Starting Value
    	Callback = function(Value)
       	_G.lowcoin=Value
    	end
}, "CollectNewAt_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
local TPBAT = Tab:CreateSlider({
	Name = "Auto Teleport Back at: (IN MILLION)",
	Range = {1, 500000}, -- The Minimum And Maximum Values Respectively
	Increment = 1, -- Basically The Changing Value/Rounding Off
	CurrentValue = 1000, -- The Starting Value
    	Callback = function(Value)
       	_G.highcoin=Value
    	end
}, "TPBACK_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
local NewAutoCollect = Tab:CreateToggle({
	Name = "Enable Auto Teleport to Zen",
	Description = "Automatically teleports to Zen on low coins, as set up above.",
	CurrentValue = false,
    	Callback = function(Value)
        _G.autocollectnew = Value
        if Value then
            info("Auto Collect", "Auto Teleport is ON", "info")
            task.spawn(function()
                repeat
                    repeat
                    wait(1)
                    until data().Coins <= _G.lowcoin*1000000
                    local keep = _G.autocollect or false
                    teleportTo("Workspace.Worlds.The Overworld.Islands.Zen.Island.Portal.Spawn")
                    if not keep then _G.autocollect = true end
                    repeat
                    wait(1)
                    until data().Coins >= _G.highcoin*1000000
                    if not keep then _G.autocollect = false end
                wait(2)
                until not _G.autocollectnew
            end)
        else
            info("Auto Collect", "Auto Teleport is OFF", "x")
        end
       	end
}, "AutoCollectNew_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
local AutoGolden = Tab:CreateToggle({
	Name = "Auto Use Golden Orb while farming",
	Description = "Automatically uses golden orb when farming",
	CurrentValue = false,
    	Callback = function(Value)
        _G.autogoldorb = Value
        if Value then
            info("Auto Collect", "Auto Gold Orb is ON", "info")
            task.spawn(function()
                repeat
                local donut = true
                for i,v in pairs(data().ActiveBuffs) do if v.Name=="GoldRush" then donut=false end end
                if data().Powerups["Golden Orb"]>=1 and donut and _G.autocollect and (_G.autocollectnew or game.Players.LocalPlayer.Character.PrimaryPart.Position.Y>=5000) then
                local args = {
                    "UseGoldenOrb"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

                end
                wait(2)
                until not _G.autogoldorb
            end)
        else
            info("Auto Collect", "Auto Gold Orb is OFF", "x")
        end
       	end
}, "AutoCollect_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local AutoFreeSpin = RewardTab:CreateToggle({
	Name = "Auto Claim Free Spin Ticket",
	Description = "Automatically claims the free spin ticket you get every 20 minutes",
	CurrentValue = false,
    	Callback = function(Value)
        _G.acfsp = Value
        if Value then
            info("Auto Ticket", "Auto Ticket Claim is ON", "info")
            task.spawn(function()
                repeat
                local args = {
                    [1] = "ClaimFreeWheelSpin"
                }

                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                wait(60*21)
                until not _G.acfsp
            end)
        else
            info("Auto Ticket", "Auto Ticket Claim is OFF", "x")
        end
       	end
}, "AutoGamble_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
local AutoSpinFree = RewardTab:CreateToggle({
	Name = "Auto Spin Ticket",
	Description = "Automatically uses your Spin tickets",
	CurrentValue = false,
    	Callback = function(Value)
        _G.autoticket = Value
        if Value then
            info("Auto Ticket", "Auto Ticket Spin is ON", "info")
            task.spawn(function()
                repeat
                if data().Powerups["Spin Ticket"] and data().Powerups["Spin Ticket"]>=1 then 
                local args = {
                    "WheelSpin"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer(unpack(args))
                wait()
                local args = {
                    "ClaimWheelSpinQueue"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

                end
                wait(1)
                until not _G.autoticket
            end)
        else
            info("Auto Ticket", "Auto Ticket Spin is OFF", "x")
        end
       	end
}, "AutoGambleFR_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
for i,v in pairs(require(game:GetService("ReplicatedStorage").Client.Framework.Services.LocalData).Get().MasteryUpgrades) do 
if v.Type == "QuickCollect" then
local AutoChest = RewardTab:CreateToggle({
	Name = "Auto Open Giant/Void/Tickets Chest",
	Description = "Automatically opens the island chest (without teleporting)",
	CurrentValue = false,
    	Callback = function(Value)
        _G.chestcoll = Value
        if Value then
            info("Auto Chest", "Auto Chest Open is ON", "info")
            task.spawn(function()
                repeat
                local ost = os.time()
                local vct = data().Cooldowns["Void Chest"]
                if ost >= vct then
                local args = {
                    "ClaimChest",
                    "Void Chest",
                    true
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                end
                local gct = data().Cooldowns["Giant Chest"]
                if ost >= gct then
                local args = {
                    "ClaimChest",
                    "Giant Chest",
                    true
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                end
                local gtct = data().Cooldowns["Ticket Chest"]
                if ost >= gtct then
                local args = {
                    "ClaimChest",
                    "Ticket Chest",
                    true
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                end
                wait(15)
                until not _G.chestcoll
            end)
        else
            info("Auto Chest", "Auto Chest Open is OFF", "x")
        end
       	end
}, "AutoChest_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

end end
local AutoPlaytime = RewardTab:CreateToggle({
	Name = "Auto Claim Playtime Gifts",
	Description = "Automatically claims the playtime gifts (without animation)",
	CurrentValue = false,
    	Callback = function(Value)
        _G.autoplay = Value
        if Value then
            info("Auto Claim", "Auto Claim (Playtime) is ON", "info")
        else
            info("Auto Claim", "Auto Claim (Playtime) is OFF", "x")
        end
       	end
}, "AutoPlaytime_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
spawn(function()
game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Buttons.Playtime.Button.Notification.Changed:Connect(function()
if game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.HUD.Left.Buttons.Playtime.Button.Notification.Visible and _G.autoplay then
for i=1,13,1 do
local args = {
    [1] = "ClaimPlaytime",
    [2] = i
}

game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer(unpack(args))

end 
end
end)
end)

local AutoDoggy = RewardTab:CreateToggle({
	Name = "Auto Play Doggy Jump",
	Description = "Automatically claims the Mystery Box from Doggy Jump",
	CurrentValue = false,
    	Callback = function(Value)
        _G.autodog = Value
        if Value then
            info("Auto Jump", "Doggy Jump is ON", "info")
            task.spawn(function()
                repeat
                if data().DoggyJump.Claimed<=2 then
                local args = {
                    "DoggyJumpWin",
                    3
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                end
                wait(15)
                until not _G.autodog
            end)
        else
            info("Auto Jump", "Doggy Jump is OFF", "x")
        end
       	end
}, "AutoDoggy_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
RewardTab:CreateSection("Mystery Boxes")
local AutoOpenMB = RewardTab:CreateToggle({
	Name = "Auto Open Mystery Boxes",
	Description = "Automatically opens Mystery Boxes (only if 10+)",
	CurrentValue = false,
    	Callback = function(Value)
        _G.autoboxmyst = Value
        if Value then
            info("Auto Open", "Auto Opening Mystery Boxes is ON", "info")
            task.spawn(function()
                repeat
                if data().Powerups["Mystery Box"] and data().Powerups["Mystery Box"] >= 10 then
                local args = {
                    "UseGift",
                    "Mystery Box",
                    10
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

                end
                if #workspace.Rendered.Gifts:GetChildren() >= 1 then
                wait(1)
                for i,v in pairs(workspace.Rendered.Gifts:GetChildren()) do
                local args = {
                    "ClaimGift",
                    v.Name
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                v.Parent = nil
                end
                end
                wait(1)
                until not _G.autoboxmyst
            end)
        else
            info("Auto Open", "Auto Opening Mystery Boxes is OFF", "x")
        end
       	end
}, "AutoMB_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local AutoHatch = HatchTab:CreateToggle({
	Name = "Auto Hatch nearest Egg",
	Description = "Automatically hatches the nearest egg (switches)",
	CurrentValue = false,
    	Callback = function(Value)
        _G.hatch = Value
        if Value then
            info("Auto Hatching", "Auto Hatching is ON", "info")
        else
            info("Auto Hatching", "Auto Hatching is OFF", "x")
        end
       	end
}, "AutoHatch_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
local ReduceAH = HatchTab:CreateToggle({
	Name = "Reduce Hatches",
	Description = "Reduces Hatched Pets for less animations (You still get all Pets)",
	CurrentValue = false,
    	Callback = function(Value)
        _G.redh = Value
        if Value then
            info("Auto Hatching", "Lag Reducing is ON", "info")
        else
            info("Auto Hatching", "Lag Reducing is OFF", "x")
        end
       	end
}, "AutoH_Red_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps


spawn(function()
local hatchstatus = false
repeat
local egg = ""
local dist = 999
local hatch = false
for i,v in pairs(workspace.Rendered:GetChildren()[12]:GetChildren()) do
local dest = (game.Players.LocalPlayer.Character.PrimaryPart.Position-v.Root.Position).Magnitude
if dest <= 25 and dest <=dist and _G.hatch then
egg = v.Name
hatch = true
dist = dest
end 
end 
if hatch then
local args = {
    [1] = "HatchEgg",
    [2] = egg,
    [3] = 4
}

game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

end
if not hatch == hatchstatus then
if hatch then
info("Auto Hatch", "Hatching "..egg, "info")
else
info("Auto Hatch", "Canceled Hatching (Too far)", "x")
end
end
hatchstatus = hatch
wait()
until _G.tx
end) 

spawn(function()
local rem = game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.Event
local cons = getconnections(game:GetService("ReplicatedStorage").Shared.Framework.Network.Remote.Event.OnClientEvent)
local mod = require(game:GetService("ReplicatedStorage").Shared.Data.Pets)

local func
for i,v in pairs(cons) do 
pcall(function()
if getupvalue(v.Function, 1) == "HatchEgg" then
func = v.Function
end 
end)
end
local old
old = hookfunction(func, function(he, tab)
if he == "HatchEgg" and _G.redh then
local newtab = tab
local lc = 0
for i=#newtab.Pets,1,-1 do
local petname = newtab.Pets[i].Pet.Name
local rarity = mod[petname].Rarity
if not string.find(rarity, "Legendary") and not string.find(rarity, "Secret") then
if i==1 and lc == 0 then
else
table.remove(newtab.Pets, i)
end
else
lc = lc + 1
end 
end
old("HatchEgg", newtab)
return
end
return old(he, tab)
end)
end)


local AutoDice = ToyTab:CreateToggle({
	Name = "Auto Use Dices",
	Description = "Automatically uses your dices in the Toy World",
	CurrentValue = false,
    	Callback = function(Value)
        _G.autodice = Value
        if Value then
            info("Auto Dice", "Auto Dice is ON", "info")
            task.spawn(function()
                repeat
                local vct = data().Powerups
                if vct["Dice"] and vct["Dice"] >= 1 then
                local args = {
                    "RollDice",
                    "Dice"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer(unpack(args))
                wait(1)
                local args = {
                    "ClaimTile"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

                end
                if vct["Giant Dice"] and vct["Giant Dice"] >= 1 then
                local args = {
                    "RollDice",
                    "Giant Dice"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer(unpack(args))
                wait(1)
                local args = {
                    "ClaimTile"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

                end
                if vct["Golden Dice"] and vct["Golden Dice"] >= 1 then
                local args = {
                    "RollDice",
                    "Golden Dice"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Function"):InvokeServer(unpack(args))
                wait(1)
                local args = {
                    "ClaimTile"
                }
                game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

                end
                wait(1)
                until not _G.autodice
            end)
        else
            info("Auto Dice", "Auto Dice is OFF", "x")
        end
       	end
}, "AutoUseDice_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
ToyTab:CreateSection("Auto Minigame Options:")
_G.Diff = "Easy"
local AutoMinigameDiff = ToyTab:CreateDropdown({
	Name = "Minigame Difficulty",
    	Description = "Choose the Difficulty to play on (needs to be unlocked)",
	Options = {"Easy","Medium","Hard","Insane"},
    	CurrentOption = {"Easy"},
    	MultipleOptions = false,
    	SpecialType = nil,
    	Callback = function(Options)
     	_G.Diff = Options
        end
}, "AutoUseMinigame_Rarity_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
_G.difftime = 10
local TimeSlider = ToyTab:CreateSlider({
	Name = "Time between Minigames (Seconds)",
	Range = {0, 60}, -- The Minimum And Maximum Values Respectively
	Increment = 1, -- Basically The Changing Value/Rounding Off
	CurrentValue = 10, -- The Starting Value
    	Callback = function(Value)
       	_G.difftime = Value
        end
}, "AutoMinigameTime_Slide_AEX")
ToyTab:CreateSection("Minigames: (Only one at a time works)")
local AutoClawMG = ToyTab:CreateToggle({
	Name = "Auto Play Claw Machine",
	Description = "Automatically starts and plays Claw Machine",
	CurrentValue = false,
    	Callback = function(Value)
        if _G.mg_match or _G.mg_cart then return false end
        _G.mg_claw = Value
        if Value then
            info("Auto Play", "Auto Playing Claw Machine", "info")
            task.spawn(function()
            repeat
            local args = {
                "SkipMinigameCooldown",
                "Robot Claw"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))


            wait(2)
            repeat wait(1) 
            local args = {
                "StartMinigame",
                "Robot Claw",
                _G.Diff
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            until workspace:FindFirstChild("ClawMachine") ~= nil

            wait(5)


            local tab = {}
            for x,y in pairs(workspace.ClawMachine:GetChildren()) do
            if y.Name == "Capsule" then
            table.insert(tab, y)
            end
            end
            for i,v in pairs(tab) do
            local nmb = #game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.MinigameHUD["Robot Claw"].CollectedItems:GetChildren()
            local xt = os.time()
            repeat wait()
            local args = {
                "GrabMinigameItem",
                v:GetAttribute("ItemGUID")
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            until #game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.MinigameHUD["Robot Claw"].CollectedItems:GetChildren() ~= nmb or os.time()-xt >= 4 or game:GetService("Players").LocalPlayer.PlayerGui.ScreenGui.MinigameHUD["Robot Claw"].Visible == false

            v.Parent = nil
            wait(4)
            end
            repeat wait() until workspace:FindFirstChild("ClawMachine") == nil
            wait(2+_G.difftime)

            until not _G.mg_claw
            end)
        else
            info("Auto Play", "Auto Playing is OFF", "x")
        end
       	end
}, "AutoClaw_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
local AutoMineMG = ToyTab:CreateToggle({
	Name = "Auto Play Minecart Game",
	Description = "Automatically starts and plays the Minecart Game",
	CurrentValue = false,
    	Callback = function(Value)
        if _G.mg_match or _G.mg_claw then return false end
        _G.mg_cart = Value
        if Value then
            info("Auto Play", "Auto Playing Minecart", "info")
            task.spawn(function()
            repeat

            local args = {
                "SkipMinigameCooldown",
                "Cart Escape"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))

            wait(2)

            local args = {
                "StartMinigame",
                "Cart Escape",
                _G.Diff
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))


            wait(25)
            local args = {
                "FinishMinigame"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))


            wait(2+_G.difftime)

            until not _G.mg_cart
            end)
        else
            info("Auto Play", "Auto Playing is OFF", "x")
        end
       	end
}, "AutoCart_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
local AutoMatchMG = ToyTab:CreateToggle({
	Name = "Auto Play Match Game",
	Description = "Automatically starts and plays the Matching Game",
	CurrentValue = false,
    	Callback = function(Value)
        if _G.mg_cart or _G.mg_claw then return false end
        _G.mg_match = Value
        if Value then
            info("Auto Play", "Auto Playing Match", "info")
            task.spawn(function()
            repeat

            local args = {
                "SkipMinigameCooldown",
                "Pet Match"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
            print("testing here")
            wait(2)

            local args = {
                "StartMinigame",
                "Pet Match",
                _G.Diff
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))


            wait(5)
            local args = {
                "FinishMinigame"
            }
            game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))


            wait(2+_G.difftime)

            until not _G.mg_match
            end)
        else
            info("Auto Play", "Auto Playing is OFF", "x")
        end
       	end
}, "AutoMatch_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps





-- RiftTab
local rifts = {}
local btns = {}
local cantp = true
for i=1,12,1 do
local xvc = i
local btn = RiftTab:CreateButton({
	Name = "Rift",
	Description = nil, -- Creates A Description For Users to know what the button does (looks bad if you use it all the time),
    	Callback = function()
            if cantp and btns[xvc].Settings.Name ~= "No more rifts :(" then
            cantp = false
            local rift = rifts[xvc]
            teleportRift(rift.Display.CFrame, false)
            cantp = true
            end
    	end
})
table.insert(btns, btn)
end


spawn(function()
function reload()
pcall(function()
rifts = {}
for i,v in pairs(workspace.Rendered.Rifts:GetChildren()) do
table.insert(rifts, v)
end
table.sort(rifts, function(a,b) return a.Output.CFrame.Position.Y*(a.Output.CFrame.Position.X>=5000 and 100 or 1)>=b.Output.CFrame.Position.Y*(b.Output.CFrame.Position.X>=5000 and 100 or 1) end)
for i=1,12,1 do
local button = btns[i]
if #rifts >= i then
local v = rifts[i]
local text = ""
if v.Name == "golden-chest" then text = "Rift Chest (Normal)"
elseif v.Name == "gift-rift" then text = "Gift"
elseif v.Name == "bubble-rift" then text = "Sell Rift"
elseif v.Name == "dice-rift" then text = "Dice Chest"
elseif string.find(v.Name, "-chest") then text = "Royal Chest (RARE)"
elseif string.find(v.Name, "egg") or string.find(v.Name, "event-") then
local eggname = string.split(v.Name, "-")[1]
eggname = string.upper(string.sub(eggname, 1, 1))..string.sub(eggname, 2).." Egg"
text = eggname
if v.Name=="event-1" then text = "Bunny Egg"
elseif v.Name == "event-2" then text = "Pastel Egg"
elseif v.Name == "event-3" then text = "Throwback Egg" end
local luckamt = v.Display.SurfaceGui.Icon.Luck.Text
text = text.." ("..luckamt.." Luck)"
else
text = "Unknown"
end
text = text.." -> "..(math.round(v.Output.CFrame.Position.Y*10)/10).."m"
local settings = button.Settings
settings.Name = text
button:Set(settings)
button.Settings.Name = text
else
local settings = button.Settings
settings.Name = "No more rifts :("
button:Set(settings)
button.Settings.Name = "No more rifts :("
end
end
end)
end 
workspace.Rendered.Rifts.ChildAdded:Connect(function(c)
wait(1)
reload()
end)
workspace.Rendered.Rifts.ChildRemoved:Connect(function()
wait(1)
reload()
end)
wait(3)
reload()
end)
local isbusy = false
RiftTab:CreateSection("Rift Autofarm")
local opt_rfs = {"-"}
local AutoMinigameDiff = ToyTab:CreateDropdown({
	Name = "Minigame Difficulty",
    	Description = "Choose the Difficulty to play on (needs to be unlocked)",
	Options = opt_rfs,
    	CurrentOption = {"-"},
    	MultipleOptions = true,
    	SpecialType = nil,
    	Callback = function(Options)
     	_G.Diff = Options
        end
}, "AutoUseMinigame_Rarity_AEX")






local AutoVoid = MarketTab:CreateToggle({
	Name = "Auto Buy Alien (Zen)",
	Description = "Automatically buy from the Zen Shop",
	CurrentValue = false,
    	Callback = function(Value)
        _G.ab_as = Value
        if Value then
            info("Auto Buy", "Enabled Auto Buy", "info")
            spawn(function()
            local debounce = os.time()
                repeat
                    local args = {
                        [1] = "BuyShopItem",
                        [2] = "alien-shop",
                        [3] = math.random(1,3)
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                    debounce=debounce+1
                    if os.time() >= debounce+1 then debounce = 0 wait(120) debounce = os.time() end
                    wait()
                until _G.ab_as == false
            end)
        else
            info("Auto Buy", "Disabled Auto Buy", "x")
        end
       	end
}, "AutoZen_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local AutoBM = MarketTab:CreateToggle({
	Name = "Auto Buy Blackmarket (Void)",
	Description = "Automatically buy from the Black Market",
	CurrentValue = false,
    	Callback = function(Value)
        _G.ab_as3 = Value
        if Value then
            info("Auto Buy", "Enabled Auto Buy", "info")
            spawn(function()
            local debounce = os.time()
                repeat
                    local args = {
                        [1] = "BuyShopItem",
                        [2] = "shard-shop",
                        [3] = math.random(1,3)
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                    if os.time() >= debounce+1 then debounce = 0 wait(120*7.5) debounce = os.time() end
                    wait()
                until _G.ab_as3 == false
            end)
        else
            info("Auto Buy", "Disabled Auto Buy", "x")
        end
       	end
}, "AutoShard_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps

local AutoDiceM = MarketTab:CreateToggle({
	Name = "Auto Buy Dice Shop",
	Description = "Automatically buy from the Dice Shop",
	CurrentValue = false,
    	Callback = function(Value)
        _G.ab_as2 = Value
        if Value then
            info("Auto Buy", "Enabled Auto Buy", "info")
            spawn(function()
            local debounce = os.time()
                repeat
                    local args = {
                        [1] = "BuyShopItem",
                        [2] = "dice-shop",
                        [3] = math.random(1,3)
                    }

                    game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Framework"):WaitForChild("Network"):WaitForChild("Remote"):WaitForChild("Event"):FireServer(unpack(args))
                    if os.time() >= debounce+1 then debounce = 0 wait(120) debounce = os.time() end
                    wait()
                until _G.ab_as2 == false
            end)
        else
            info("Auto Buy", "Disabled Auto Buy", "x")
        end
       	end
}, "AutoDiceshop_AEX") -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps












local SettingsTab = Window:CreateTab({
	Name = "Settings",
	Icon = "source",
	ImageSource = "Material",
	ShowTitle = true -- This will determine whether the big header text in the tab will show
})
local SettingsTabNote = SettingsTab:CreateParagraph({
	Title = "How Config Works:",
	Text = "The script doesn't automatically save your options. You can save multiple Configs here. You can manually or auto-load them. If you want to convert them to another Exeuctor, just copy the 'aetherx' folder in "..identifyexecutor().."s Workspace folder and paste it in your new executor's workspace folder"
})
SettingsTab:BuildConfigSection()
--Luna:LoadAutoloadConfig()

if not _G.looptime then
_G.looptime = true
end



local vu = game:GetService("VirtualUser")
local player = game:GetService("Players").LocalPlayer

player.Idled:Connect(function()    
    if 1==1 then
        vu:CaptureController()
        vu:ClickButton2(Vector2.new(0, 0))
    end
end)
