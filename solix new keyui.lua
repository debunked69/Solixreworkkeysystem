repeat wait() until game:IsLoaded()

local cloneref = cloneref or function(o) return o end
Workspace = cloneref(game:GetService("Workspace"))
Players = cloneref(game:GetService("Players"))
PlayerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
HttpService = cloneref(game:GetService("HttpService"))
TweenService = cloneref(game:GetService("TweenService"))
UserInputService = cloneref(game:GetService("UserInputService"))
Market = cloneref(game:GetService("MarketplaceService"))
RBXAnalyt = cloneref(game:GetService("RbxAnalyticsService"))
CoreGui = cloneref(game:GetService("CoreGui"))
RunService = cloneref(game:GetService("RunService"))
Replicated = cloneref(game:GetService("ReplicatedStorage"))

local ListGame = {
	["3808223175"] = "4fe2dfc202115670b1813277df916ab2", -- Jujutsu Infinite
	["994732206"]  = "e2718ddebf562c5c4080dfce26b09398", -- Blox Fruits
	["1650291138"] = "9b64d07193c7c2aef970d57aeb286e70", -- Demon Fall
	["5750914919"] = "8bbc8a7c4e023bc0c80799fec3233162", -- Fisch
	["66654135"]   = "9c916252a9f79bbf5a108f97c531e807", -- Murder Mystery 2
	["3317771874"] = "e95ef6f27596e636a7d706375c040de4", -- Pet Simulator 99
	["1511883870"] = "fefdf5088c44beb34ef52ed6b520507c", -- Shindo Life
	["6035872082"] = "3bb7969a9ecb9e317b0a24681327c2e2", -- Rivals
	["245662005"]  = "21ad7f491e4658e9dc9529a60c887c6e", -- Jailbreak
	["7018190066"] = "98f5c64a0a9ecca29517078597bbcbdb", -- Dead Rails
	["7074860883"] = "0c8fdf9bb25a6a7071731b72a90e3c69", -- Arise Crossover
	["7436755782"] = "e4ea33e9eaf0ae943d59ea98f2444ebe", -- Grow a Garden
	["210851291"]  = "b3400f5a4e28cad1e1110b45004c3837", -- Build a Boat
	["6931042565"] = "036786acbfa6e6e030dce074faa1173f", -- Volleyball Legends
	["7326934954"] = "00e140acb477c5ecde501c1d448df6f9", -- 99 Nights in the Forest
	["7822444776"] = "ba4595cfb82d2434a478b9003f3674b4", -- Build a Plane
	["4871329703"] = "646e60921195f2b2d59015703b0b100a", -- Type Soul
	["1000233041"] = "c08f7269fc31f6a60ec57ecfacfdb34e", -- 3008
	["7750955984"] = "b8432035965d96be10e70bfb63a6964b", -- Hunty Zombie
	["6701277882"] = "05cd4dda96ee6767cd1903587da139fc", -- Fish it!
	["6884266247"] = "f8c8b872fe2939eb1e39457f2766862e", -- Anime Rangers X
	["8316902627"] = "641e8d02ffba666d731614a32c08eacf", -- Plants vs Brainrot
	["6216468795"] = "97722a63586043c0780da54598487218", -- Weak Legacy 2
	["8066283370"] = "c0e023292c5ede5fd683fc0cdc1b5eb0", -- Build a Zoo
	["8321616508"] = "2cd0668c5caf66913e7314cdb6d1eb9b", -- Rogue Piece
	["3457700596"] = "639c0b275001182cca67ac85f5bd529f", -- Fruit Battlegrounds
	["7671049560"] = "c0b41e859f576fb70183206224d4a75f", -- The Forge
}

local script_id
local executor_name = getexecutorname():match("^%s*(.-)%s*$") or "nigger"
local game_id = tostring(game.GameId)
local list_id = ListGame[tostring(game.GameId)]

if not list_id then
	Players.LocalPlayer:Kick("This game is not supported.")
end

if CoreGui:FindFirstChild("System") then
	CoreGui.System:Destroy()
end

script_id = list_id

for _, exec in ipairs({"Xeno", "Solara"}) do
	if string.find(executor_name, exec) then
		workspace:SetAttribute("low", true)
		break
	end
end

function Task()
	local status, res1, res2 = pcall(function()
		local api = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
		local Task = {}
		local v1 = {}
		local variables = {}

		local error_messages = {
			KEY_EXPIRED = "Your key has expired\nPlease renew it to continue.",
			KEY_BANNED = "This key has been blacklisted.\nContact support for assistance.",
			KEY_HWID_LOCKED = "This key is linked to a different HWID.\nPlease reset it via our bot.",
			KEY_INCORRECT = "The provided key is incorrect or no longer valid.",
			KEY_INVALID = "Invalid key format.\nPlease check your key and try again.",
			SCRIPT_ID_INCORRECT = "The provided script ID does not exist or has been removed.",
			SCRIPT_ID_INVALID = "This script has been deleted by its owner.",
			INVALID_EXECUTOR = "Invalid HWID header detected.\nYour executor may not be supported.",
			SECURITY_ERROR = "Security validation failed (Cloudflare check).\nPlease retry.",
			TIME_ERROR = "Invalid client time detected.\nPlease sync your system clock.",
			UNKNOWN_ERROR = "An unknown error occurred.\nPlease contact support."
		}
		-------------------------------------------------------------------------------
		v1.__index = v1
		local v_u_3 = buffer and buffer.tostring or function(b) return tostring(b) end
		local v_u_4 = buffer and buffer.fromstring or function(s) return s end
		function v1.revert(p6) return v_u_4(p6) end
		function v1.convert(p51) return v_u_3(p51) end
		-------------------------------------------------------------------------------
		local LSMT = game:GetObjects("rbxassetid://126113170246030")[1]

		function Close(Objectftween)
			TweenService:Create(Objectftween, TweenInfo.new(0.65, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(0, 10, 0, 10),
				Position = UDim2.new(0.5, 0, 0.5, 0)
			}):Play()

			task.wait(0.1)

			LSMT:Destroy()
		end

		local NotificationGUI = PlayerGui:FindFirstChild("Notifications") or Instance.new("ScreenGui")
		NotificationGUI.Name = "Notifications"
		NotificationGUI.Parent = PlayerGui

		local Container = NotificationGUI:FindFirstChild("Container") or Instance.new("Frame")
		Container.Name = "Container"
		Container.AnchorPoint = Vector2.new(1, 0)
		Container.Position = UDim2.new(1, -25, 0, 25)
		Container.BackgroundTransparency = 1
		Container.Size = UDim2.fromOffset(350, 600)
		Container.Parent = NotificationGUI

		if not Container:FindFirstChild("UIListLayout") then
			local Layout = Instance.new("UIListLayout")
			Layout.SortOrder = Enum.SortOrder.LayoutOrder
			Layout.Padding = UDim.new(0, 8)
			Layout.VerticalAlignment = Enum.VerticalAlignment.Top
			Layout.HorizontalAlignment = Enum.HorizontalAlignment.Right
			Layout.Parent = Container
		end

		function NotifyCustom(title, content, duration)
			duration = duration or 5
			color = color or Color3.fromRGB(255, 188, 254)

			local Notification = Instance.new("Frame")
			Notification.Name = "Notification"
			Notification.BackgroundTransparency = 0.06
			Notification.AutomaticSize = Enum.AutomaticSize.Y
			Notification.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
			Notification.BorderSizePixel = 0
			Notification.Size = UDim2.fromOffset(320, 70)
			Notification.Parent = Container

			local NotifCorner = Instance.new("UICorner")
			NotifCorner.CornerRadius = UDim.new(0, 8)
			NotifCorner.Parent = Notification

			local NotifStroke = Instance.new("UIStroke")
			NotifStroke.Color = Color3.fromRGB(158, 114, 158)
			NotifStroke.Transparency = 0.8
			NotifStroke.Parent = Notification

			local TitleText = Instance.new("TextLabel")
			TitleText.FontFace = Font.new("rbxassetid://12187365364", Enum.FontWeight.SemiBold)
			TitleText.Text = title
			TitleText.TextColor3 = Color3.fromRGB(199, 199, 203)
			TitleText.TextSize = 16
			TitleText.TextXAlignment = Enum.TextXAlignment.Left
			TitleText.BackgroundTransparency = 1
			TitleText.Size = UDim2.new(1, -20, 0, 20)
			TitleText.Position = UDim2.fromOffset(10, 6)
			TitleText.Parent = Notification

			local ContentText = Instance.new("TextLabel")
			ContentText.FontFace = Font.new("rbxassetid://12187365364")
			ContentText.Text = content
			ContentText.TextColor3 = Color3.fromRGB(180, 180, 185)
			ContentText.TextSize = 14
			ContentText.TextXAlignment = Enum.TextXAlignment.Left
			ContentText.TextYAlignment = Enum.TextYAlignment.Top
			ContentText.BackgroundTransparency = 1
			ContentText.AutomaticSize = Enum.AutomaticSize.Y
			ContentText.TextWrapped = true
			ContentText.Size = UDim2.new(1, -20, 0, 0)
			ContentText.Position = UDim2.fromOffset(10, 28)
			ContentText.Parent = Notification

			local ProgressBar = Instance.new("Frame")
			ProgressBar.BackgroundColor3 = Color3.fromRGB(44, 38, 44)
			ProgressBar.BorderSizePixel = 0
			ProgressBar.Size = UDim2.new(1, -20, 0, 6)
			ProgressBar.Position = UDim2.new(0, 10, 1, -12)
			ProgressBar.Parent = Notification

			local ProgressFill = Instance.new("Frame")
			ProgressFill.BackgroundColor3 = color
			ProgressFill.BorderSizePixel = 0
			ProgressFill.Size = UDim2.fromScale(1, 1)
			ProgressFill.Parent = ProgressBar

			local ProgressFillCorner = Instance.new("UICorner")
			ProgressFillCorner.Parent = ProgressFill

			TweenService:Create(ProgressFill, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size = UDim2.new(0, 0, 1, 0)}):Play()

			task.delay(duration, function()
				TweenService:Create(Notification, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
				task.wait(0.3)
				Notification:Destroy()
			end)

			return Notification
		end

		function DraggFunction(object, drag_object, enable_taptic, taptic_offset)
			local dragging = false
			local relative = nil
			local off_set = Vector2.zero

			local ScreenGui = object:FindFirstAncestorWhichIsA("ScreenGui")
			if ScreenGui and ScreenGui.IgnoreGuiInset then
				off_set = game:GetService('GuiService'):GetGuiInset()
			end

			drag_object.InputBegan:Connect(function(input, processed)
				if processed then return end
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					relative = object.AbsolutePosition + object.AbsoluteSize * object.AnchorPoint - UserInputService:GetMouseLocation()
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
					dragging = false
				end
			end)

			RunService.RenderStepped:Connect(function()
				if dragging then
					local position = UserInputService:GetMouseLocation() + relative + off_set
					if enable_taptic and taptic_offset then
						TweenService:Create(object, TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.fromOffset(position.X, position.Y)}):Play()
					else
						object.Position = UDim2.fromOffset(position.X, position.Y)
					end
				end
			end)

			object.Destroying:Connect(function()
				dragging = false
			end)
		end

		local coppy = setclipboard or toclipboard or set_clipboard or (Clipboard and Clipboard.set)
		LSMT.Enabled = false

		if get_ui then
			LSMT.Parent = get_ui()
		elseif syn and syn.protect_gui then
			syn.protect_gui(LSMT)
			LSMT.Parent = CoreGui
		else
			LSMT.Parent = CoreGui
		end

		pcall(function()
			LuarmorGot_System:Destroy()
		end)

		getgenv().LuarmorGot_System = LSMT
		-------------------------------------------------------------------------------
		function RandomName(b)
			local c = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[{]}\\|'\";:,<.>/? "
			local d = ""
			local f = math.random(0, 5)
			for g = 1, b - f do
				local a = math.random(1, #c - 1)
				d = d .. string.sub(c, a, a)
			end
			return d .. string.rep("\003", f)
		end

		local jas = RandomName(10)

		function Notification(Type, Message)
			NotifyCustom(Type, Message, 5)
		end

		function RenameAllChildren(parent)
			for _, child in pairs(parent:GetChildren()) do
				child.Name = RandomName(6)
				RenameAllChildren(child)
			end
		end

		function DeleteFile(File)
			if isfile(File) then
				delfile(File)
			end
		end

		variables[jas] = function(key, file_directory)
			if type(key) ~= "buffer" then
				Players.LocalPlayer:Kick("Invalid key type detected")
				return
			end

			local cleaned_key = v1.convert(key):gsub("%s", "")

			if not string.match(cleaned_key, "^[A-Za-z]+$") or #cleaned_key ~= 32 then
				DeleteFile("solixhub/key.txt")
				task.wait(1)
				Players.LocalPlayer:Kick("Invalid key format.\nPlease make sure you are using a valid key.")
				return nil
			end

			if cleaned_key ~= v1.convert(key) then
				Notification("Info", "Extra spaces detected in the key. Verifying without spaces...")
			end

			local success, status = pcall(api.check_key, cleaned_key)
			if not success then
				Notification("Error", "An unexpected error occurred while verifying the key.")
				return nil
			end

			if status.code == "KEY_VALID" then

				if CoreGui:FindFirstChild("System") then
					CoreGui.System:Destroy()
				end

				if not (
					game_id == "3808223175" -- Jujutsu Infinite
					game_id == "994732206" -- Blox Fruits
						or game_id == "1511883870" -- Shindo Life
						or game_id == "7018190066" -- Dead Rails
						or game_id == "1650291138" -- Demon Fall
						or game_id == "8321616508" -- Rogue Piece
						or game_id == "3457700596" -- Fruit Battlegrounds
						or game_id == "7671049560" -- The Forge
					)
						and Workspace:GetAttribute("low") then
					Players.LocalPlayer:Kick("This executor is not supported for this game.")
				end

				if not isfile(file_directory) then
					local save_success, err = pcall(writefile, file_directory, cleaned_key)
					if not save_success then
						Notification("Error", "Failed to save key:\n" .. err)
					end
				else
					local current_key = readfile(file_directory)
					if current_key ~= cleaned_key then
						local success, err = pcall(writefile, file_directory, cleaned_key)
						if not success then
							Notification("Error", "Failed to update key:\n" .. err)
						end
					end
				end

				script_key = cleaned_key

				local function ToTime(seconds)
					local days = math.floor(seconds / 86400)
					local hours = math.floor((seconds % 86400) / 3600)
					local minutes = math.floor((seconds % 3600) / 60)
					local secs = seconds % 60

					if days > 0 then
						return string.format("%dd %02dh %02dm %02ds", days, hours, minutes, secs)
					else
						return string.format("%02dh %02dm %02ds", hours, minutes, secs)
					end
				end

				Notification("Info", string.format("Key will expire in: %s", ToTime(status.data.auth_expire - os.time())))
				getgenv().LuarmorNote = status.data.note
				pcall(function() api.load_script() end)
				return true
			end

			if error_messages[status.code] then
				DeleteFile(file_directory)
				Notification("Warning", error_messages[status.code])

				if status.code == "KEY_HWID_LOCKED" then
					Players.LocalPlayer:Kick(error_messages[status.code])
				end

				if status.code == "INVALID_EXECUTOR" or status.code == "SECURITY_ERROR" or status.code == "UNKNOWN_ERROR" then
					Players.LocalPlayer:Kick(error_messages[status.code])
				end

				return nil
			end

			Players.LocalPlayer:Kick("Key check failed:\nCode: " .. status.code)
		end
		-------------------------------------------------------------------------------
		local Main = LSMT.Main
		local DragBar = Main.Movebar
		local Top = Main.Top
		local InputBox = Main.Input
		local Buttons = Main.ButtonContainer
		local CloseBT = Top.CloseButton
		local Title = Top.Title
		local icon = Top.Logo
		local Keybox = InputBox.TextBox
		local GetDiscord = Buttons.Discord
		local Links = Buttons.Links
		local Rinku = Links.LootLabs
		local Linkvertise = Links.Linkvertise

		Title.UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(180, 91, 255)), ColorSequenceKeypoint.new(1.000, Color3.fromRGB(88, 26, 181))};
		Title.UIGradient.Rotation = 90;

		Rinku.UIGradient.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromHex("#625409")),
			ColorSequenceKeypoint.new(1, Color3.fromHex("#530b78"))
		}
		Rinku.UIGradient.Rotation = 195

		Linkvertise.UIGradient.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0.000, Color3.fromRGB(215, 112, 61)),
			ColorSequenceKeypoint.new(1.000, Color3.fromRGB(77, 43, 14))
		}
		Linkvertise.UIGradient.Rotation = 195

		GetDiscord.UIGradient.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0.000, Color3.fromRGB(114, 137, 218)),
			ColorSequenceKeypoint.new(1.000, Color3.fromRGB(88, 101, 242))
		}
		GetDiscord.UIGradient.Rotation = 195

		Links:WaitForChild("LootLabs"):FindFirstChildOfClass("TextLabel").Text = "Rinku"
		-------------------------------------------------------------------------------
		function Task:Window(config)
			config.DisplayName = config.DisplayName or "QuantumPulsar X"
			config.Discord = config.Discord or ""
			config.File = config.File or "VaQSys.txt"
			config.MinIcon = config.MinIcon or "rbxassetid://100569530935041"
			config.Linkvertise = config.Linkvertise
			config.Rinku = config.Rinku

			local Window = {}

			api.script_id = script_id
			Top.Logo.Image = config.MinIcon
			Top.Title.Text = config.DisplayName

			for _,v in pairs(Main:GetDescendants()) do
				if v:IsA("TextLabel") or v:IsA("TextButton") then
					v.FontFace = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
				end
			end

			CloseBT.ImageButton.MouseButton1Click:Connect(function()
				Close(Main)
			end)

			Keybox.FocusLost:Connect(function()
				if Keybox.Text ~= "" then
					if variables[jas](v1.revert(Keybox.Text), config.File) then
						TweenService:Create(Keybox, TweenInfo.new(0.65), {BackgroundColor3 = Color3.fromRGB(60, 255, 60), BackgroundTransparency = 0.4}):Play()
						task.wait(0.65)
						TweenService:Create(Keybox, TweenInfo.new(0.65), {BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9}):Play()
						pcall(function() Close(Main) end)
					else
						Keybox.Text = ""
						TweenService:Create(Keybox, TweenInfo.new(0.65), {BackgroundColor3 = Color3.fromRGB(255, 60, 60), BackgroundTransparency = 0.4}):Play()
						task.wait(0.65)
						TweenService:Create(Keybox, TweenInfo.new(0.65), {BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0.9}):Play()
					end
				end
			end)

			Rinku.MouseButton1Click:Connect(function()
				coppy(config.Rinku)
				Notification("Success", "Link copied to clipboard!")
			end)

			Linkvertise.MouseButton1Click:Connect(function()
				coppy(config.Linkvertise)
				Notification("Success", "Link copied to clipboard!")
			end)

			Buttons.Discord.MouseButton1Click:Connect(function()
				coppy(tostring(config.Discord))
				Notification("Success", "Link copied to clipboard!")
			end)

			task.spawn(function()
				local ok, err = pcall(function()
					local key = (isfile(config.File) and readfile(config.File)) or (script_key ~= "" and script_key) or nil
					if not key then
						LSMT.Enabled = true
						return
					end

					local decoded
					local success_decode, decode_error = pcall(function()
						decoded = v1.revert(key)
					end)
					if not success_decode or not decoded then
						Notification("Warning", "Failed to decode key:\n" .. (decode_error or "Unknown error"))
						LSMT.Enabled = true
						return
					end

					local is_valid, valid_result = pcall(function()
						return variables[jas](decoded, config.File)
					end)

					if decoded ~= nil and (not is_valid or valid_result ~= true) then
						Notification("Warning", "Invalid or rejected key.")
						LSMT.Enabled = true
						return
					end
					pcall(function() if LSMT then LSMT:Destroy() end end)
				end)

				if not ok then
					Notification("Warning", "Key system error:\n" .. tostring(err))
					if LSMT then
						LSMT.Enabled = true
					end
				end
			end)

			RenameAllChildren(LSMT)
			DraggFunction(Main, DragBar, true, 0)
			return Window
		end
		return Task
	end)
	if not status then
		Notification("Warning", "Key system failed to load:\n" .. res1)
	else
		return res1, res2
	end
end

local Task = Task()

local Window = Task:Window({
	File = "solixhub/savedkey.txt",
	Discord = "https://discord.gg/solixhub",
	DisplayName = "solix hub key system relix xxx lilix",
	MinIcon = "rbxassetid://boiii",
	Linkvertise = "https://ads.luarmor.net/get_key?for=Solixhub_Free_KeySystem-OWlLHDMCHADk",
	Rinku = "https://ads.luarmor.net/get_key?for=Solix_Free_Keysystems-pqJCGTqnTsng",
})
