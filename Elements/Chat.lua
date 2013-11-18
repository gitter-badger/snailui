-- Chat.lua
-- Written by Snail

function HandleChat()
	if GetConfiguration().Chat then
		local Class = select(2, UnitClass("Player"))

		hooksecurefunc("ChatEdit_OnEnterPressed",
			function(Self)
				Self:Hide()
			end
		)

		hooksecurefunc("ChatEdit_OnEscapePressed",
			function(Self)
				Self:Hide()
			end
		)

		ChatFrame1:ClearAllPoints()
		ChatFrame1:SetClampedToScreen(false)
		ChatFrame1:SetFont("Fonts\\FrizQT__.ttf", 10)
		ChatFrame1:SetPoint(GetConfiguration().Chat.Anchor, GetConfiguration().Chat.X, GetConfiguration().Chat.Y)
		ChatFrame1:SetSize(GetConfiguration().Chat.Width - 10, GetConfiguration().Chat.Height - 10)
		ChatFrame1:SetUserPlaced(true)

		ChatFrame1.BackgroundBottom = ChatFrame1:CreateTexture(nil, "LOW")
		ChatFrame1.BackgroundBottom:SetPoint("BOTTOM", 0, -4)
		ChatFrame1.BackgroundBottom:SetSize(GetConfiguration().Chat.Width - 2, 1)
		ChatFrame1.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		ChatFrame1.BackgroundLeft = ChatFrame1:CreateTexture(nil, "LOW")
		ChatFrame1.BackgroundLeft:SetPoint("LEFT", -4, 0)
		ChatFrame1.BackgroundLeft:SetSize(1, GetConfiguration().Chat.Height - 4)
		ChatFrame1.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		ChatFrame1.BackgroundRight = ChatFrame1:CreateTexture(nil, "LOW")
		ChatFrame1.BackgroundRight:SetPoint("RIGHT", 4, 0)
		ChatFrame1.BackgroundRight:SetSize(1, GetConfiguration().Chat.Height - 4)
		ChatFrame1.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		ChatFrame1.BackgroundTop = ChatFrame1:CreateTexture(nil, "LOW")
		ChatFrame1.BackgroundTop:SetPoint("TOP", 0, 4)
		ChatFrame1.BackgroundTop:SetSize(GetConfiguration().Chat.Width - 2, 1)
		ChatFrame1.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		ChatFrame1.BorderBottom = ChatFrame1:CreateTexture(nil, "BACKGROUND")
		ChatFrame1.BorderBottom:SetPoint("BOTTOM", 0, -5)
		ChatFrame1.BorderBottom:SetSize(GetConfiguration().Chat.Width, 3)
		ChatFrame1.BorderBottom:SetTexture(0, 0, 0)

		ChatFrame1.BorderLeft = ChatFrame1:CreateTexture(nil, "BACKGROUND")
		ChatFrame1.BorderLeft:SetPoint("LEFT", -5, 0)
		ChatFrame1.BorderLeft:SetSize(3, GetConfiguration().Chat.Height - 2)
		ChatFrame1.BorderLeft:SetTexture(0, 0, 0)

		ChatFrame1.BorderRight = ChatFrame1:CreateTexture(nil, "BACKGROUND")
		ChatFrame1.BorderRight:SetPoint("RIGHT", 5, 0)
		ChatFrame1.BorderRight:SetSize(3, GetConfiguration().Chat.Height - 2)
		ChatFrame1.BorderRight:SetTexture(0, 0, 0)

		ChatFrame1.BorderTop = ChatFrame1:CreateTexture(nil, "BACKGROUND")
		ChatFrame1.BorderTop:SetPoint("TOP", 0, 5)
		ChatFrame1.BorderTop:SetSize(GetConfiguration().Chat.Width, 3)
		ChatFrame1.BorderTop:SetTexture(0, 0, 0)

		ChatFrame1.OriginalSetPoint = ChatFrame1.SetPoint
		ChatFrame1.OriginalSetSize = ChatFrame1.SetSize

		ChatFrame1.TransparentBackground = ChatFrame1:CreateTexture(nil, "BACKGROUND")
		ChatFrame1.TransparentBackground:SetPoint("TOPLEFT", -2, 2)
		ChatFrame1.TransparentBackground:SetSize(GetConfiguration().Chat.Width - 6, GetConfiguration().Chat.Height - 6)
		ChatFrame1.TransparentBackground:SetTexture(0, 0, 0, 0.5)

		ChatFrame1.SetPoint = function()
			ChatFrame1:OriginalSetPoint(GetConfiguration().Chat.Anchor, GetConfiguration().Chat.X, GetConfiguration().Chat.Y)
		end

		ChatFrame1.SetSize = function()
			ChatFrame1:OriginalSetSize(GetConfiguration().Chat.Width - 10, GetConfiguration().Chat.Height - 10)
		end

		ChatFrame1EditBox:Hide()
		ChatFrame1EditBox:SetPoint("TOPLEFT", ChatFrame1, "TOPLEFT", -5, 6)

		local Events =
		{
			"CHAT_MSG_BN_CONVERSATION",
			"CHAT_MSG_BN_INLINE_TOAST_BROADCAST",
			"CHAT_MSG_BN_WHISPER",
			"CHAT_MSG_BN_WHISPER_INFORM",
			"CHAT_MSG_CHANNEL",
			"CHAT_MSG_EMOTE",
			"CHAT_MSG_DND",
			"CHAT_MSG_GUILD",
			"CHAT_MSG_INSTANCE_CHAT",
			"CHAT_MSG_INSTANCE_CHAT_LEADER",
			"CHAT_MSG_OFFICER",
			"CHAT_MSG_PARTY",
			"CHAT_MSG_PARTY_LEADER",
			"CHAT_MSG_RAID",
			"CHAT_MSG_RAID_LEADER",
			"CHAT_MSG_RAID_WARNING",
			"CHAT_MSG_SAY",
			"CHAT_MSG_WHISPER",
			"CHAT_MSG_WHISPER_INFORM"
		}

		local Patterns =
		{
			[1] =
			{
				"(%a+)://(%S+)",
				"%1://%2"
			},

			[2] =
			{
				"([_A-Za-z0-9-%.]+)@([_A-Za-z0-9-]+)(%.+)([_A-Za-z0-9-%.]+)",
				"%1@%2%3%4"
			},

			[3] =
			{
				"(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?):(%d%d?%d?%d?%d?)",
				"%1.%2.%3.%4:%5"
			},

			[4] =
			{
				"(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)%.(%d%d?%d?)",
				"%1.%2.%3.%4"
			},

			[5] =
			{
				"([_A-Za-z0-9-%.]+)%.([A-Za-z]+)([_A-Za-z0-9-+&@#/%?=~|!:,;]*)",
				"%1.%2%3"
			}
		}

		for I = 1, #Events do
			ChatFrame_AddMessageEventFilter(Events[I],
				function(Self, Event, String, Sender, ...)
					if not Self.Events then
						Self.Events = {}
					end

					if not Self.Events[Event] then
						Self.Events[Event] = {}
					end

					if (not Self.Events[Event].RepeatMessages) or (Self.Events[Event].RepeatCount > 100) then
						Self.Events[Event].RepeatCount = 0
						Self.Events[Event].RepeatMessages = {}
					end

					Self.Events[Event].LastMessage = Self.Events[Event].RepeatMessages[Sender]

					if Self.Events[Event].LastMessage == String then
						return true
					end

					Self.Events[Event].RepeatMessages[Sender] = String
					Self.Events[Event].RepeatCount = Self.Events[Event].RepeatCount + 1

					if Options.HideGuildSpam then
						local Match
						local Result

						if string.find(String, "<[%a%s]+>") then
							return true
						end

						local Message = string.lower(String)

						if string.find(Message, "guild") or string.find(Message, "/") then
							if string.find(Message, "looking") or string.find(Message, "recruiting") or string.find(Message, "seeking") or string.find(Message, "lf") then
								return true
							end
						end

						if (string.find(Message, "gold") or string.find(Message, "g0ld") or string.find(Message, "rating") or string.find(Message, "qq")) and (string.find(Message, "wts") or string.find(Message, "cheap") or string.find(Message, "sell")) then
							return true
						end
					end

					for I = 1, #Patterns do
						local Result, Match = string.gsub(String, Patterns[I][1], "|cFFFFFFFF|Hsurl:".. Patterns[I][2] .. "|h[" .. Patterns[I][2] .. "]|h|r")

						if Match > 0 then
							return false, Result, Sender,...
						end
					end
				end
			)
		end

		local OriginalSetItemRef = SetItemRef

		SetItemRef = function(Link, String, Button)
			if string.sub(Link, 1, 4) == "surl" then
				local Editbox = ChatEdit_ChooseBoxForSend()
				ChatEdit_ActivateChat(Editbox)

				Editbox:Insert(string.sub(Link, 6))
				Editbox:HighlightText()
			end

			return OriginalSetItemRef(Link, String, Button)
		end
	end
end
