repeat wait() until game:IsLoaded()

local cloneref = cloneref or function(o) return o end
local CoreGui = cloneref(game:GetService("CoreGui"))
local TweenService = cloneref(game:GetService("TweenService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local Players = cloneref(game:GetService("Players"))
local TextService = cloneref(game:GetService("TextService"))
local HttpService = cloneref(game:GetService("HttpService"))
local Lighting = cloneref(game:GetService("Lighting"))
local Workspace = cloneref(game:GetService("Workspace"))
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled and not UserInputService.MouseEnabled

getgenv().lilix = getgenv().lilix or nil
getgenv().relix = getgenv().relix or nil

getgenv().key = getgenv().key or nil
getgenv().luarmor_api = getgenv().luarmor_api or nil
getgenv().key_expire = getgenv().key_expire or nil
getgenv().key_note = getgenv().key_note or nil
getgenv().key_executions = getgenv().key_executions or nil

if not LPH_OBFUSCATED then
	LPH_JIT_MAX = function(...) return ... end
	LPH_NO_VIRTUALIZE = function(f) return f end
	LPH_NO_UPVALUES = function(...) return ... end
	LPH_CRASH = function(...) return ... end
else
	print = function() end
	warn = function() end
end

local Folder_Configs = {
	Directory = "solixhub",
	Configs = "solixhub/Configs",
	Assets = "solixhub/Assets",
	Themes = "solixhub/Themes"
}

for _, Folder in pairs(Folder_Configs) do
	if not isfolder(Folder) then
		makefolder(Folder)
	end
end

local GameId = tostring(game.GameId)
local GameConfigFolder = Folder_Configs.Configs .. "/" .. GameId

if not isfolder(GameConfigFolder) then
	makefolder(GameConfigFolder)
end

local FontPath = Folder_Configs.Assets .. "/InterSemibold.ttf"

if not isfile(FontPath) then
	local FontData = game:HttpGet("https://github.com/sametexe001/luas/raw/main/fonts/InterSemibold.ttf")

	if FontData and FontData ~= "" then
		writefile(FontPath, FontData)
	end
end

local GameList = {
	["3808223175"] = { id = "4fe2dfc202115670b1813277df916ab2", keyless = false },
	["994732206"]  = { id = "e2718ddebf562c5c4080dfce26b09398", keyless = false },
	["1511883870"] = { id = "fefdf5088c44beb34ef52ed6b520507c", keyless = false },
	["6035872082"] = { id = "3bb7969a9ecb9e317b0a24681327c2e2", keyless = true },
	["245662005"]  = { id = "21ad7f491e4658e9dc9529a60c887c6e", keyless = true },
	["7018190066"] = { id = "98f5c64a0a9ecca29517078597bbcbdb", keyless = true },
	["7326934954"] = { id = "00e140acb477c5ecde501c1d448df6f9", keyless = true },
	["7671049560"] = { id = "c0b41e859f576fb70183206224d4a75f", keyless = false },
	["9363735110"] = { id = "4948419832e0bd4aa588e628c45b6f8d", keyless = false },
	["9509842868"] = { id = "ad4ccd094f8b6f972bff36de80475abe", keyless = true },
	["5130394318"] = { id = "3e7a75a970118d0f0cf629369524dc7d", keyless = false },
	["9186719164"] = { id = "892ccfefdc8834199a2a6e5856a8da67", keyless = true },
}

local Config = {
	File = "solixhub/savedkey.txt",
	Title = "Solix Hub Free 15+ Games",
	Description = "Lifetime key access is available for a one time payment of $15 via solixhub.com",
	Linkvertise = "https://ads.luarmor.net/get_key?for=Solixhub_Free_KeySystem-OWlLHDMCHADk",
	Rinku = "https://ads.luarmor.net/get_key?for=Solix_Free_Keysystems-pqJCGTqnTsng",
	Discord = "https://discord.gg/solixhub",
	Shop = "https://solixhub.com/",
}

local ErrorMessages = {
	KEY_EXPIRED = "Your key has expired. Please renew it to continue.",
	KEY_BANNED = "This key has been blacklisted. Contact support for assistance.",
	KEY_INCORRECT = "The provided key is incorrect or no longer valid.",
	KEY_INVALID = "Invalid key format. Please check your key and try again.",
	SCRIPT_ID_INCORRECT = "The provided script ID does not exist or has been removed.",
	SCRIPT_ID_INVALID = "This script has been deleted by its owner.",
	SECURITY_ERROR = "Security validation failed (Cloudflare check). Please retry.",
	TIME_ERROR = "Invalid client time detected. Please sync your system clock.",
	UNKNOWN_ERROR = "An unknown error occurred. Please contact support."
}

local GameConfig = GameList[GameId]

if not GameConfig then
	Players.LocalPlayer:Kick("This game is not supported.")
	return
end

local ScriptId = GameConfig.id
local IsKeyless = GameConfig.keyless

if hookfunction and hookmetamethod then
	getgenv().lilix = true
else
	getgenv().lilix = false
end

if IsMobile then
	getgenv().relix = true
else
	getgenv().relix = false
end

local function DeleteFile(v)
	if isfile(v) then
		delfile(v)
	end
end

local LuarmorApi = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
LuarmorApi.script_id = ScriptId

if IsKeyless then
	pcall(function()
		LuarmorApi.load_script()
	end)
	return
end

local Library do
	local wait = task.wait
	local spawn = task.spawn
	local delay = task.delay

	local LocalPlayer = Players.LocalPlayer

	local FromRGB = Color3.fromRGB

	local UDim2New = UDim2.new
	local UDimNew = UDim.new
	local Vector2New = Vector2.new

	local TableInsert = table.insert
	local StringFormat = string.format
	local InstanceNew = Instance.new

	local GetUI = gethui or function()
		local Success, Result = pcall(function()
			return game:GetService("CoreGui")
		end)
		return Success and Result or nil
	end

	local function SafeGetUI()
		local Success, Result = pcall(GetUI)
		if Success and Result then
			return Result
		end
		return game:GetService("CoreGui")
	end

	Library = {
		Theme = {
			["Background"] = FromRGB(15, 12, 16),
			["Inline"] = FromRGB(22, 20, 24),
			["Border"] = FromRGB(41, 37, 45),
			["Text"] = FromRGB(255, 255, 255),
			["Inactive Text"] = FromRGB(185, 185, 185),
			["Accent"] = FromRGB(232, 186, 248),
			["Element"] = FromRGB(36, 32, 39),
		},

		Tween = {
			Time = 0.3,
			Style = Enum.EasingStyle.Quad,
			Direction = Enum.EasingDirection.Out
		},

		Connections = { },
		Threads = { },
		ThemeMap = { },
		ThemeItems = { },

		Holder = nil,
		NotifHolder = nil,
		Font = nil
	}

	Library.__index = Library

	local Tween = { } do
		Tween.__index = Tween

		Tween.Create = function(self, Item, Info, Goal, IsRawItem)
			Item = IsRawItem and Item or Item.Instance
			Info = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)

			local NewTween = {
				Tween = TweenService:Create(Item, Info, Goal),
				Info = Info,
				Goal = Goal,
				Item = Item
			}

			NewTween.Tween:Play()
			setmetatable(NewTween, Tween)

			return NewTween
		end

		Tween.Get = function(self)
			if not self.Tween then
				return
			end
			return self.Tween, self.Info, self.Goal
		end

		Tween.Pause = function(self)
			if self.Tween then
				self.Tween:Pause()
			end
		end

		Tween.Play = function(self)
			if self.Tween then
				self.Tween:Play()
			end
		end

		Tween.Clean = function(self)
			if self.Tween then
				Tween:Pause()
			end
			self = nil
		end
	end

	local Instances = { } do
		Instances.__index = Instances

		Instances.Create = function(self, Class, Properties)
			local Success, Result = pcall(function()
				local NewItem = {
					Instance = InstanceNew(Class),
					Properties = Properties,
					Class = Class
				}

				setmetatable(NewItem, Instances)

				for Property, Value in pairs(NewItem.Properties) do
					pcall(function()
						NewItem.Instance[Property] = Value
					end)
				end

				return NewItem
			end)

			if Success and Result then
				return Result
			end

			return {
				Instance = nil,
				Properties = Properties or {},
				Class = Class,
				_Protected = true
			}
		end

		Instances.AddToTheme = function(self, Properties)
			if not self.Instance then
				return
			end
			Library:AddToTheme(self, Properties)
			return self
		end

		Instances.Connect = function(self, Event, Callback)
			if not self.Instance or not self.Instance[Event] then
				return
			end
			return Library:Connect(self.Instance[Event], Callback)
		end

		Instances.Tween = function(self, Info, Goal)
			if not self.Instance then
				return
			end
			return Tween:Create(self, Info, Goal)
		end

		Instances.Clean = function(self)
			if self.Instance then
				self.Instance:Destroy()
			end
			self = nil
		end

		Instances.MakeDraggable = function(self)
			if not self.Instance then
				return
			end

			local Gui = self.Instance
			local Dragging = false
			local DragStart
			local StartPosition
			local Changed

			self:Connect("InputBegan", function(Input)
				if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
					Dragging = true
					DragStart = Input.Position
					StartPosition = Gui.Position

					if Changed then
						return
					end

					Changed = Input.Changed:Connect(function()
						if Input.UserInputState == Enum.UserInputState.End then
							Dragging = false
							if Changed then
								Changed:Disconnect()
								Changed = nil
							end
						end
					end)
				end
			end)

		UserInputService.InputChanged:Connect(function(Input)
			if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and Dragging then
				local Scale = UIScale and UIScale.Scale or 1
				local DragDelta = (Input.Position - DragStart) / Scale
				self:Tween(TweenInfo.new(0.16, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
					Position = UDim2New(
						StartPosition.X.Scale,
						StartPosition.X.Offset + DragDelta.X,
						StartPosition.Y.Scale,
						StartPosition.Y.Offset + DragDelta.Y
					)
				})
			end
		end)

			return Dragging
		end
	end

	local DefaultFont = Enum.Font.GothamBold

	local function SafeFont(...)
		local Success, Result = pcall(function(...)
			return Font.new(...)
		end, ...)
		return Success and Result or nil
	end

	local FontSuccess, LoadedFont = pcall(function()
		local AssetFolder = Folder_Configs.Assets

		local FontAssetId = getcustomasset(FontPath)
		if not FontAssetId then
			return nil
		end

		local FontJson = {
			name = "InterSemibold",
			faces = {
				{
					name = "InterSemibold",
					weight = 400,
					style = "Regular",
					assetId = FontAssetId
				}
			}
		}

		local FontFilePath = AssetFolder .. "/InterSemibold.Font"
		writefile(FontFilePath, HttpService:JSONEncode(FontJson))

		local FontAssetPath = getcustomasset(FontFilePath)
		if not FontAssetPath then
			return nil
		end

		return SafeFont(FontAssetPath)
	end)

	local Resolved = FontSuccess and LoadedFont
	if not Resolved then
		Resolved = SafeFont(DefaultFont)
	end

	Library.Font = Resolved or DefaultFont

	Library.Holder = Instances:Create("ScreenGui", {
		Parent = SafeGetUI(),
		Name = "\0",
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
		DisplayOrder = 2,
		ResetOnSpawn = false
	})

	wait()

	Library.NotifHolder = Instances:Create("Frame", {
		Parent = Library.Holder.Instance,
		Name = "\0",
		BorderColor3 = FromRGB(0, 0, 0),
		AnchorPoint = Vector2New(1, 0),
		BackgroundTransparency = 1,
		Position = UDim2New(1, 0, 0, 0),
		Size = UDim2New(0, 0, 1, 0),
		BorderSizePixel = 0,
		AutomaticSize = Enum.AutomaticSize.X
	})
	Library.NotifLayoutOrder = 0

	Instances:Create("UIListLayout", {
		Parent = Library.NotifHolder.Instance,
		Name = "\0",
		Padding = UDimNew(0, 20),
		SortOrder = Enum.SortOrder.LayoutOrder,
		HorizontalAlignment = Enum.HorizontalAlignment.Right
	})

	Instances:Create("UIPadding", {
		Parent = Library.NotifHolder.Instance,
		Name = "\0",
		PaddingTop = UDimNew(0, 12),
		PaddingBottom = UDimNew(0, 12),
		PaddingRight = UDimNew(0, 12),
		PaddingLeft = UDimNew(0, 12)
	})

	Library.Thread = function(self, Function)
		local NewThread = coroutine.create(Function)
		coroutine.wrap(function()
			coroutine.resume(NewThread)
		end)()
		TableInsert(self.Threads, NewThread)
		return NewThread
	end

	Library.Connect = function(self, Event, Callback)
		local NewConnection = {
			Event = Event,
			Callback = Callback,
			Name = StringFormat("conn_%s", HttpService:GenerateGUID(false)),
			Connection = nil
		}

		Library.Thread(self, function()
			NewConnection.Connection = Event:Connect(Callback)
		end)

		TableInsert(self.Connections, NewConnection)
		return NewConnection
	end

	Library.AddToTheme = function(self, Item, Properties)
		Item = Item.Instance or Item

		local ThemeData = {
			Item = Item,
			Properties = Properties,
		}

		for Property, Value in pairs(ThemeData.Properties) do
			if type(Value) == "string" then
				Item[Property] = self.Theme[Value] or Value
			elseif type(Value) == "function" then
				Item[Property] = Value()
			end
		end

		TableInsert(self.ThemeItems, ThemeData)
		self.ThemeMap[Item] = ThemeData
	end

	local function ToTime(v)
		if v <= 0 or not v then
			return "Lifetime"
		end

		local days = math.floor(v / 86400)
		local hours = math.floor((v % 86400) / 3600)
		local minutes = math.floor((v % 3600) / 60)
		local seconds = v % 60

		if days > 0 then
			return StringFormat("%dd %dh %dm %ds", days, hours, minutes, seconds)
		elseif hours > 0 then
			return StringFormat("%dh %dm %ds", hours, minutes, seconds)
		elseif minutes > 0 then
			return StringFormat("%dm %ds", minutes, seconds)
		else
			return StringFormat("%ds", seconds)
		end
	end

	local function GetTextSize(Text, Width)
		local Success, Result = pcall(function()
			return TextService:GetTextSize(Text, 14, Library.Font, Vector2New(Width, 10000))
		end)
		if not Success or not Result then
			Result = TextService:GetTextSize(Text, 14, Enum.Font.SourceSans, Vector2New(Width, 10000))
		end
		return Result
	end

	Library.Notification = function(self, Data)
		wait()
		Library.NotifLayoutOrder = (Library.NotifLayoutOrder or 0) + 1

		local Items = { } do
			Items["Notification"] = Instances:Create("Frame", {
				Parent = Library.NotifHolder.Instance,
				Name = "\0",
				LayoutOrder = Library.NotifLayoutOrder,
				BackgroundTransparency = 0.3,
				BorderColor3 = FromRGB(0, 0, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme["Background"]
			}):AddToTheme({BackgroundColor3 = 'Background'})

			Instances:Create("UICorner", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Instances:Create("UIPadding", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				PaddingTop = UDimNew(0, 5),
				PaddingBottom = UDimNew(0, 5),
				PaddingRight = UDimNew(0, 6),
				PaddingLeft = UDimNew(0, 6)
			})

			Items["Title"] = Instances:Create("TextLabel", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				FontFace = Library.Font,
				TextColor3 = Library.Theme["Text"],
				BorderColor3 = FromRGB(0, 0, 0),
				Text = Data.Title or Data.Name,
				Size = UDim2New(0, 0, 0, 15),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				BorderSizePixel = 0,
				AutomaticSize = Enum.AutomaticSize.XY,
				TextSize = 14
			}):AddToTheme({TextColor3 = 'Text'})

			Items["Description"] = Instances:Create("TextLabel", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				FontFace = Library.Font,
				TextWrapped = true,
				TextColor3 = Library.Theme["Text"],
				TextTransparency = 0.4,
				Text = Data.Description,
				Size = UDim2New(0, 0, 0, 0),
				Position = UDim2New(0, 0, 0, 20),
				BorderSizePixel = 0,
				BorderColor3 = FromRGB(0, 0, 0),
				BackgroundTransparency = 1,
				TextXAlignment = Enum.TextXAlignment.Left,
				AutomaticSize = Enum.AutomaticSize.Y,
				TextSize = 14
			}):AddToTheme({TextColor3 = 'Text'})

			Items["Duration"] = Instances:Create("Frame", {
				Parent = Items["Notification"].Instance,
				Name = "\0",
				Position = UDim2New(0, 0, 0, 40),
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(1, 0, 0, 3),
				BorderSizePixel = 0,
				BackgroundColor3 = Library.Theme["Inline"]
			}):AddToTheme({BackgroundColor3 = 'Inline'})

			Instances:Create("UICorner", {
				Parent = Items["Duration"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})

			Items["Accent"] = Instances:Create("Frame", {
				Parent = Items["Duration"].Instance,
				Name = "\0",
				BorderColor3 = FromRGB(0, 0, 0),
				Size = UDim2New(1, 0, 1, 0),
				BorderSizePixel = 0,
				BackgroundColor3 = Data.Color
			})

			Instances:Create("UICorner", {
				Parent = Items["Accent"].Instance,
				Name = "\0",
				CornerRadius = UDimNew(0, 5)
			})
		end

		wait()

		local Content = GetTextSize(Data.Description or "", 10000).X
		local Description = math.max(math.ceil(GetTextSize(Data.Description or "", Content).Y), 14)
		local TitleSize = math.ceil(Items["Title"].Instance.TextBounds.X)
		local Final = math.max(TitleSize, Content)
		local SizeY = 5 + 20 + Description + 4 + 3 + 5

		Items["Description"].Instance.Size = UDim2New(0, Final, 0, 0)
		Items["Duration"].Instance.Position = UDim2New(0, 0, 0, 5 + 20 + Description + 4)
		Items["Notification"].Instance.Size = UDim2New(0, 0, 0, SizeY)

		for _, Value in pairs(Items) do
			if Value.Instance:IsA("Frame") then
				Value.Instance.BackgroundTransparency = 1
			elseif Value.Instance:IsA("TextLabel") then
				Value.Instance.TextTransparency = 1
			end
		end

		local Info = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)

		Library.Thread(self, function()
			for Index, Value in pairs(Items) do
				if Value.Instance:IsA("Frame") then
					Value:Tween(Info, {BackgroundTransparency = 0})
				elseif Value.Instance:IsA("TextLabel") and Index ~= "Description" then
					Value:Tween(Info, {TextTransparency = 0})
				elseif Value.Instance:IsA("TextLabel") and Index == "Description" then
					Value:Tween(Info, {TextTransparency = 0.4})
				end
			end

			Items["Notification"]:Tween(Info, {Size = UDim2New(0, Final, 0, SizeY)})
			Items["Accent"]:Tween(TweenInfo.new(Data.Duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = UDim2New(0, 0, 1, 0)})

			delay(Data.Duration + 0.1, function()
				for _, Value in pairs(Items) do
					if Value.Instance:IsA("Frame") then
						Value:Tween(nil, {BackgroundTransparency = 1})
					elseif Value.Instance:IsA("TextLabel") then
						Value:Tween(nil, {TextTransparency = 1})
					end
				end

				Items["Notification"]:Tween(Info, {Size = UDim2New(0, 0, 0, SizeY)})
				wait(0.5)
				Items["Notification"]:Clean()
			end)
		end)
	end

	local BlurEffect = Instances:Create("BlurEffect", {
		Name = "\0",
		Size = 0,
		Parent = Lighting
	})

	local Items = { } do
		Items["ScreenGui"] = Instances:Create("ScreenGui", {
			Parent = SafeGetUI(),
			Name = "\0",
			ResetOnSpawn = false,
			IgnoreGuiInset = true,
			DisplayOrder = 999,
			ZIndexBehavior = Enum.ZIndexBehavior.Global
		})

		Items["Overlay"] = Instances:Create("Frame", {
			Parent = Items["ScreenGui"].Instance,
			Name = "\0",
			Size = UDim2New(1, 0, 1, 0),
			BackgroundColor3 = FromRGB(0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 1
		})

		Items["MainFrame"] = Instances:Create("Frame", {
			Parent = Items["ScreenGui"].Instance,
			Name = "\0",
			AnchorPoint = Vector2New(0.5, 0.5),
			Position = UDim2New(0.5, 0, 0.5, 0),
			Size = UDim2New(0, 0, 0, 0),
			BackgroundColor3 = Library.Theme["Background"],
			BackgroundTransparency = 0.15,
			BorderSizePixel = 0,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = 'Background'})

		Instances:Create("UICorner", {
			Parent = Items["MainFrame"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 8)
		})

		Items["MainStroke"] = Instances:Create("UIStroke", {
			Parent = Items["MainFrame"].Instance,
			Name = "\0",
			Color = Library.Theme["Border"],
			Thickness = 1,
			Transparency = 1,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		}):AddToTheme({Color = 'Border'})

		Items["TitleLabel"] = Instances:Create("TextLabel", {
			Parent = Items["MainFrame"].Instance,
			Name = "\0",
			Position = UDim2New(0, 0, 0, 20),
			Size = UDim2New(1, 0, 0, 40),
			BackgroundTransparency = 1,
			FontFace = Library.Font,
			Text = Config.Title,
			TextColor3 = Library.Theme["Accent"],
			TextSize = 28,
			TextTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 2
		}):AddToTheme({TextColor3 = 'Accent'})

		Items["SubtitleLabel"] = Instances:Create("TextLabel", {
			Parent = Items["MainFrame"].Instance,
			Name = "\0",
			Position = UDim2New(0, 0, 0, 65),
			Size = UDim2New(1, 0, 0, 20),
			BackgroundTransparency = 1,
			FontFace = Library.Font,
			Text = Config.Description,
			TextColor3 = Library.Theme["Inactive Text"],
			TextSize = 13,
			TextTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 2
		}):AddToTheme({TextColor3 = 'Inactive Text'})

		Items["Line"] = Instances:Create("Frame", {
			Parent = Items["MainFrame"].Instance,
			Name = "\0",
			Position = UDim2New(0.08, 0, 0, 95),
			Size = UDim2New(0.84, 0, 0, 1),
			BackgroundColor3 = Library.Theme["Border"],
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = 'Border'})

		Items["TextBoxContainer"] = Instances:Create("Frame", {
			Parent = Items["MainFrame"].Instance,
			Name = "\0",
			Position = UDim2New(0.5, 0, 0, 115),
			AnchorPoint = Vector2New(0.5, 0),
			Size = UDim2New(0, 480, 0, 50),
			BackgroundColor3 = Library.Theme["Element"],
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = 'Element'})

		Instances:Create("UICorner", {
			Parent = Items["TextBoxContainer"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Instances:Create("UIGradient", {
			Parent = Items["TextBoxContainer"].Instance,
			Name = "\0",
			Rotation = 90,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, FromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, FromRGB(216, 216, 216))
			})
		})

		Items["TextBoxStroke"] = Instances:Create("UIStroke", {
			Parent = Items["TextBoxContainer"].Instance,
			Name = "\0",
			Color = Library.Theme["Border"],
			Thickness = 1,
			Transparency = 1,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		}):AddToTheme({Color = 'Border'})

		Items["KeyTextBox"] = Instances:Create("TextBox", {
			Parent = Items["TextBoxContainer"].Instance,
			Name = "\0",
			Size = UDim2New(1, -24, 1, 0),
			Position = UDim2New(0, 12, 0, 0),
			BackgroundTransparency = 1,
			FontFace = Library.Font,
			PlaceholderText = "Paste your key here...",
			PlaceholderColor3 = Library.Theme["Inactive Text"],
			Text = "",
			TextColor3 = Library.Theme["Text"],
			TextSize = 15,
			ClearTextOnFocus = false,
			TextTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 2,
			CursorPosition = -1,
			TextXAlignment = Enum.TextXAlignment.Left
		}):AddToTheme({TextColor3 = 'Text', PlaceholderColor3 = 'Inactive Text'})

		Items["CloseButton"] = Instances:Create("TextButton", {
			Parent = Items["MainFrame"].Instance,
			Name = "\0",
			Position = UDim2New(1, -40, 0, 10),
			Size = UDim2New(0, 30, 0, 30),
			BackgroundColor3 = Library.Theme["Element"],
			FontFace = Library.Font,
			Text = "X",
			TextColor3 = Library.Theme["Text"],
			TextSize = 18,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			TextTransparency = 1,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = 'Element', TextColor3 = 'Text'})

		Instances:Create("UICorner", {
			Parent = Items["CloseButton"].Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Items["CloseStroke"] = Instances:Create("UIStroke", {
			Parent = Items["CloseButton"].Instance,
			Name = "\0",
			Color = Library.Theme["Border"],
			Thickness = 1,
			Transparency = 1,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		}):AddToTheme({Color = 'Border'})
	end

	local Buttons = { }

	local function CreateButton(Text, Position)
		local Button = Instances:Create("TextButton", {
			Parent = Items["MainFrame"].Instance,
			Name = "\0",
			Position = Position,
			AnchorPoint = Vector2New(0.5, 0),
			Size = UDim2New(0, 220, 0, 45),
			BackgroundColor3 = Library.Theme["Element"],
			FontFace = Library.Font,
			Text = Text,
			TextColor3 = Library.Theme["Text"],
			TextSize = IsMobile and 13 or 15,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			BackgroundTransparency = 1,
			TextTransparency = 1,
			ZIndex = 2
		}):AddToTheme({BackgroundColor3 = 'Element', TextColor3 = 'Text'})

		Instances:Create("UICorner", {
			Parent = Button.Instance,
			Name = "\0",
			CornerRadius = UDimNew(0, 5)
		})

		Instances:Create("UIGradient", {
			Parent = Button.Instance,
			Name = "\0",
			Rotation = 90,
			Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, FromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, FromRGB(216, 216, 216))
			})
		})

		Items["ButtonStroke"] = Instances:Create("UIStroke", {
			Parent = Button.Instance,
			Name = "\0",
			Color = Library.Theme["Border"],
			Thickness = 1,
			Transparency = 1,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		}):AddToTheme({Color = 'Border'})

		TableInsert(Buttons, {Button = Button, Stroke = Items["ButtonStroke"]})
		return Button
	end

	if IsMobile then
		Items["Button1"] = CreateButton("Get Key (Linkvertise)", UDim2New(0.5, 0, 0, 185))
		Items["Button2"] = CreateButton("Get Key (Rinku)", UDim2New(0.5, 0, 0, 240))
		Items["Button3"] = CreateButton("Join Discord", UDim2New(0.5, 0, 0, 295))
		Items["Button4"] = CreateButton("Buy Standard Key", UDim2New(0.5, 0, 0, 350))

		for _, Button in Buttons do
			Button.Button.Instance.Size = UDim2New(0, 320, 0, 42)
		end
	else
		Items["Button1"] = CreateButton("Get Key (Linkvertise)", UDim2New(0.25, 0, 0, 190))
		Items["Button2"] = CreateButton("Get Key (Rinku)", UDim2New(0.75, 0, 0, 190))
		Items["Button3"] = CreateButton("Join Discord", UDim2New(0.25, 0, 0, 255))
		Items["Button4"] = CreateButton("Buy Standard Key", UDim2New(0.75, 0, 0, 255))
	end

	local TweenData = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local function CloseUI()
		BlurEffect:Tween(TweenData, {Size = 0})
		Items["Overlay"]:Tween(TweenData, {BackgroundTransparency = 1})

		Items["TitleLabel"]:Tween(TweenData, {TextTransparency = 1})
		Items["SubtitleLabel"]:Tween(TweenData, {TextTransparency = 1})
		Items["Line"]:Tween(TweenData, {BackgroundTransparency = 1})
		Items["TextBoxContainer"]:Tween(TweenData, {BackgroundTransparency = 1})
		Items["TextBoxStroke"]:Tween(TweenData, {Transparency = 1})
		Items["KeyTextBox"]:Tween(TweenData, {TextTransparency = 1})
		Items["CloseButton"]:Tween(TweenData, {BackgroundTransparency = 1, TextTransparency = 1})
		Items["CloseStroke"]:Tween(TweenData, {Transparency = 1})
		Items["MainStroke"]:Tween(TweenData, {Transparency = 1})

		for _, Button in Buttons do
			Button.Button:Tween(TweenData, {BackgroundTransparency = 1, TextTransparency = 1})
			Button.Stroke:Tween(TweenData, {Transparency = 1})
		end

		Items["MainFrame"]:Tween(TweenData, {Size = UDim2New(0, 0, 0, 0)})
		wait(0.35)
		BlurEffect:Clean()
		Items["ScreenGui"]:Clean()
	end

	local function ValidateKey(Key)
		local CleanedKey = Key:gsub("%s", "")

		if not string.match(CleanedKey, "^[A-Za-z0-9]+$") or #CleanedKey ~= 32 then
			Library:Notification({
				Title = "Error",
				Description = "Invalid key format. Key must be 32 characters.",
				Color = FromRGB(255, 60, 60),
				Duration = 5
			})
			return false
		end

		if CleanedKey ~= Key then
			Library:Notification({
				Title = "Info",
				Description = "Extra spaces detected, verifying without spaces...",
				Color = FromRGB(237, 170, 0),
				Duration = 5
			})
		end

		local Success, Result = pcall(LuarmorApi.check_key, CleanedKey)

		if not Success then
			Library:Notification({
				Title = "Error",
				Description = "Network error. Please try again.",
				Color = FromRGB(255, 60, 60),
				Duration = 5
			})
			return false
		end

		if Result.code == "KEY_VALID" then
			script_key = CleanedKey

			if not isfile(Config.File) then
				pcall(writefile, Config.File, CleanedKey)
			elseif readfile(Config.File) ~= CleanedKey then
				pcall(writefile, Config.File, CleanedKey)
			end

			getgenv().key = CleanedKey
			getgenv().luarmor_api = LuarmorApi
			getgenv().key_expire = Result.data.auth_expire
			getgenv().key_note = Result.data.note
			getgenv().key_executions = Result.data.total_executions or 0

			Library:Notification({
				Title = "Success",
				Description = "Key expires in: " .. ToTime(Result.data.auth_expire - os.time()),
				Color = FromRGB(60, 255, 60),
				Duration = 5
			})

			wait(1.5)
			CloseUI()

			if not (
				GameId == "3808223175"
					or GameId == "994732206"
					or GameId == "1511883870"
					or GameId == "7018190066"
					or GameId == "7671049560"
					or GameId == "9363735110"
					or GameId == "9509842868"
					or GameId == "5130394318"
				) and not getgenv().lilix then
				LocalPlayer:Kick("This executor is not supported for this game.")
			end

			pcall(function()
				LuarmorApi.load_script()
			end)

			return true
		end

		if ErrorMessages[Result.code] then
			if Result.code == "SECURITY_ERROR" or Result.code == "UNKNOWN_ERROR" then
				LocalPlayer:Kick(ErrorMessages[Result.code])
			else
				DeleteFile(Config.File)
				Library:Notification({
					Title = "Error",
					Description = ErrorMessages[Result.code],
					Color = FromRGB(255, 60, 60),
					Duration = 5
				})
			end
			return false
		end

		LocalPlayer:Kick("Key check failed:\nCode: " .. Result.code)
		return false
	end

	for _, Button in Buttons do
		Button.Button:Connect("MouseEnter", function()
			Button.Button:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = IsMobile and UDim2New(0, 330, 0, 45) or UDim2New(0, 230, 0, 48)})
		end)
		Button.Button:Connect("MouseLeave", function()
			Button.Button:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = IsMobile and UDim2New(0, 320, 0, 42) or UDim2New(0, 220, 0, 45)})
		end)
		Button.Button:Connect("MouseButton1Down", function()
			Button.Button:Tween(TweenInfo.new(0.08), {Size = IsMobile and UDim2New(0, 310, 0, 40) or UDim2New(0, 210, 0, 42)})
		end)
		Button.Button:Connect("MouseButton1Up", function()
			Button.Button:Tween(TweenInfo.new(0.08), {Size = IsMobile and UDim2New(0, 320, 0, 42) or UDim2New(0, 220, 0, 45)})
		end)
	end

	Items["Button1"]:Connect("MouseButton1Click", function()
		if setclipboard then
			setclipboard(Config.Linkvertise)
		end
		Library:Notification({
			Title = "Link Copied",
			Description = "Linkvertise link copied to clipboard",
			Color = FromRGB(60, 255, 60),
			Duration = 5
		})
	end)

	Items["Button2"]:Connect("MouseButton1Click", function()
		if setclipboard then
			setclipboard(Config.Rinku)
		end
		Library:Notification({
			Title = "Link Copied",
			Description = "Rinku link copied to clipboard",
			Color = FromRGB(60, 255, 60),
			Duration = 5
		})
	end)

	Items["Button3"]:Connect("MouseButton1Click", function()
		if setclipboard then
			setclipboard(Config.Discord)
		end
		Library:Notification({
			Title = "Discord Copied",
			Description = "Discord invite copied to clipboard",
			Color = FromRGB(60, 255, 60),
			Duration = 5
		})
	end)

	Items["Button4"]:Connect("MouseButton1Click", function()
		if setclipboard then
			setclipboard(Config.Shop)
		end
		Library:Notification({
			Title = "Link Copied",
			Description = "Standard key shop link copied",
			Color = FromRGB(60, 255, 60),
			Duration = 5
		})
	end)

	Items["KeyTextBox"]:Connect("FocusLost", function()
		if Items["KeyTextBox"].Instance.Text == "" then
			return
		end

		if not ValidateKey(Items["KeyTextBox"].Instance.Text) then
			Items["KeyTextBox"].Instance.Text = ""
		end
	end)

	Items["CloseButton"]:Connect("MouseButton1Click", function()
		CloseUI()
	end)

	Items["CloseButton"]:Connect("MouseEnter", function()
		Items["CloseButton"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2New(0, 35, 0, 35)})
	end)

	Items["CloseButton"]:Connect("MouseLeave", function()
		Items["CloseButton"]:Tween(TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2New(0, 30, 0, 30)})
	end)

	Items["MainFrame"]:MakeDraggable()

	local UIScale = InstanceNew("UIScale")
	UIScale.Scale = 1
	UIScale.Parent = Library.Holder.Instance

	local function GetViewportSize()
		local Camera = Workspace.CurrentCamera
		return (Camera and Camera.ViewportSize) or Vector2.new(1920, 1080)
	end

	local function SetMobileScale()
		local Viewport = GetViewportSize()

		if IsMobile then
			local Scale = math.clamp(Viewport.Y / 500, 0.5, 1.5)
			UIScale.Scale = Scale
		else
			UIScale.Scale = 1
		end
	end

	if IsMobile then
		Items["MainFrame"].Instance.Size = UDim2New(0, 380, 0, 440)
		Items["TitleLabel"].Instance.TextSize = 22
		Items["SubtitleLabel"].Instance.TextSize = 10
		Items["TextBoxContainer"].Instance.Size = UDim2New(0, 340, 0, 45)
		SetMobileScale()
	end

	local FinalSize = IsMobile and UDim2New(0, 380, 0, 440) or UDim2New(0, 580, 0, 340)
	local TweenInfo2 = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

	BlurEffect:Tween(TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = 24})
	Items["Overlay"]:Tween(TweenInfo.new(0.3), {BackgroundTransparency = 0.3})
	Items["MainFrame"]:Tween(TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = FinalSize})

	wait(0.3)

	Items["TitleLabel"]:Tween(TweenInfo2, {TextTransparency = 0})
	Items["SubtitleLabel"]:Tween(TweenInfo2, {TextTransparency = 0})
	Items["Line"]:Tween(TweenInfo2, {BackgroundTransparency = 0})
	Items["TextBoxContainer"]:Tween(TweenInfo2, {BackgroundTransparency = 0})
	Items["TextBoxStroke"]:Tween(TweenInfo2, {Transparency = 0})
	Items["KeyTextBox"]:Tween(TweenInfo2, {TextTransparency = 0})
	Items["CloseButton"]:Tween(TweenInfo2, {BackgroundTransparency = 0, TextTransparency = 0})
	Items["CloseStroke"]:Tween(TweenInfo2, {Transparency = 0})
	Items["MainStroke"]:Tween(TweenInfo2, {Transparency = 0})

	for _, Button in Buttons do
		Button.Button:Tween(TweenInfo2, {BackgroundTransparency = 0, TextTransparency = 0})
		Button.Stroke:Tween(TweenInfo2, {Transparency = 0})
	end

	spawn(function()
		while task.wait(0.3) do
			local SavedKey = (isfile(Config.File) and readfile(Config.File)) or (script_key ~= "" and script_key) or nil

			if SavedKey and ValidateKey(SavedKey) then
				return
			end
		end
	end)
end
