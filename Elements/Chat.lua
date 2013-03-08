-- Chat.lua
-- Written by Snail

function HandleChat()
	if GetConfiguration().Chat then
		local Class = select(2, UnitClass("Player"))
		local OriginalChatEdit_OnEscapePressed = ChatEdit_OnEscapePressed

		ChatEdit_OnEscapePressed = function(Self)
			OriginalChatEdit_OnEscapePressed(Self)
			Self:Hide()
		end

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
	end
end
