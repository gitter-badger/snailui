--
-- Copyright (C) 2012-2015 Snailsoft <http://www.snailsoft.me/>
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at your
-- option) any later version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details.
--
-- You should have received a copy of the GNU General Public License along
-- with this program. If not, see <http://www.gnu.org/licenses/>.
--

local Themes = {}

function HandleInterfaceOptions(Version)
	local Category = CreateFrame("Frame", nil, UIParent)
	Category.name = "SnailUI"

	Category.Label1 = Category:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	Category.Label1:SetJustifyH("LEFT")
	Category.Label1:SetPoint("TOPLEFT", 16, -16)
	Category.Label1:SetText("SnailUI")

	Category.Label2 = Category:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	Category.Label2:SetJustifyH("LEFT")
	Category.Label2:SetPoint("TOPLEFT", 16, -36)
	Category.Label2:SetText(
		"Snail's minimalistic UI" ..
		"\n\n" ..
		"Version " .. Version ..
		"\n" ..
		"Written by Snailsoft" ..
		"\n\n" ..
		"http://wowinterface.com/downloads/info20900-SnailUI" ..
		"\n" ..
		"http://curse.com/addons/wow/snailui" ..
		"\n" ..
		"http://snailsoft.me"
	)

	local FramesSubcategory = CreateFrame("Frame", nil, Category)

	FramesSubcategory.name = "Frames"
	FramesSubcategory.parent = Category.name

	FramesSubcategory.RaidEnabledCheckbox = CreateFrame("CheckButton", nil, FramesSubcategory, "InterfaceOptionsCheckButtonTemplate")
	FramesSubcategory.RaidEnabledCheckbox:SetPoint("TOPLEFT", 16, -119)
	FramesSubcategory.RaidEnabledCheckbox:SetScript("OnClick",
		function(Self)
			if Options.EnableRaidFrames then
				Options.EnableRaidFrames = nil
				Self:SetChecked(false)
			else
				Options.EnableRaidFrames = true
				Self:SetChecked(true)
			end
		end
	)

	if Options.EnableRaidFrames then
		FramesSubcategory.RaidEnabledCheckbox:SetChecked(true)
	end

	FramesSubcategory.SideBarsEnabledCheckbox = CreateFrame("CheckButton", nil, FramesSubcategory, "InterfaceOptionsCheckButtonTemplate")
	FramesSubcategory.SideBarsEnabledCheckbox:SetPoint("TOPLEFT", 16, -73)
	FramesSubcategory.SideBarsEnabledCheckbox:SetScript("OnClick",
		function(Self)
			if Options.EnableSideBars then
				Options.EnableSideBars = nil
				Self:SetChecked(false)
			else
				Options.EnableSideBars = true
				Self:SetChecked(true)
			end
		end
	)

	if Options.EnableSideBars then
		FramesSubcategory.SideBarsEnabledCheckbox:SetChecked(true)
	end

	FramesSubcategory.ThreatColorsCheckBox = CreateFrame("CheckButton", nil, FramesSubcategory, "InterfaceOptionsCheckButtonTemplate")
	FramesSubcategory.ThreatColorsCheckBox:SetPoint("TOPLEFT", 16, -165)
	FramesSubcategory.ThreatColorsCheckBox:SetScript("OnClick",
		function(Self)
			if Options.EnableThreatColorsOnAllFrames then
				Options.EnableThreatColorsOnAllFrames = nil
				Self:SetChecked(false)
			else
				Options.EnableThreatColorsOnAllFrames = true
				Self:SetChecked(true)
			end
		end
	)

	if Options.EnableThreatColorsOnAllFrames then
		FramesSubcategory.ThreatColorsCheckBox:SetChecked(true)
	end

	FramesSubcategory.Label1 = FramesSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	FramesSubcategory.Label1:SetJustifyH("LEFT")
	FramesSubcategory.Label1:SetPoint("TOPLEFT", 16, -16)
	FramesSubcategory.Label1:SetText("Frames")

	FramesSubcategory.Label2 = FramesSubcategory:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	FramesSubcategory.Label2:SetJustifyH("LEFT")
	FramesSubcategory.Label2:SetPoint("TOPLEFT", 16, -36)
	FramesSubcategory.Label2:SetText("Frame options for SnailUI")

	FramesSubcategory.Label3 = FramesSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	FramesSubcategory.Label3:SetJustifyH("LEFT")
	FramesSubcategory.Label3:SetPoint("TOPLEFT", 16, -60)
	FramesSubcategory.Label3:SetText("Action Bars")

	FramesSubcategory.Label4 = FramesSubcategory.SideBarsEnabledCheckbox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	FramesSubcategory.Label4:SetJustifyH("LEFT")
	FramesSubcategory.Label4:SetPoint("RIGHT", 200, 0)
	FramesSubcategory.Label4:SetText("Enable the third and fourth action bars")

	FramesSubcategory.Label5 = FramesSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	FramesSubcategory.Label5:SetJustifyH("LEFT")
	FramesSubcategory.Label5:SetPoint("TOPLEFT", 16, -108)
	FramesSubcategory.Label5:SetText("Raid")

	FramesSubcategory.Label6 = FramesSubcategory.RaidEnabledCheckbox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	FramesSubcategory.Label6:SetJustifyH("LEFT")
	FramesSubcategory.Label6:SetPoint("RIGHT", 44, 0)
	FramesSubcategory.Label6:SetText("Enabled")

	FramesSubcategory.Label7 = FramesSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	FramesSubcategory.Label7:SetJustifyH("LEFT")
	FramesSubcategory.Label7:SetPoint("TOPLEFT", 16, -156)
	FramesSubcategory.Label7:SetText("Other")

	FramesSubcategory.Label8 = FramesSubcategory.ThreatColorsCheckBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	FramesSubcategory.Label8:SetJustifyH("LEFT")
	FramesSubcategory.Label8:SetPoint("RIGHT", 423, 0)
	FramesSubcategory.Label8:SetText("Color all frame borders based on the unit's threat level (Default: Raid frames only)")

	local GeneralSubcategory = CreateFrame("Frame", nil, Category)

	GeneralSubcategory.name = "General"
	GeneralSubcategory.parent = Category.name

	GeneralSubcategory.HideGuildSpamCheckbox = CreateFrame("CheckButton", nil, GeneralSubcategory, "InterfaceOptionsCheckButtonTemplate")
	GeneralSubcategory.HideGuildSpamCheckbox:SetPoint("TOPLEFT", 16, -73)
	GeneralSubcategory.HideGuildSpamCheckbox:SetScript("OnClick",
		function(Self)
			if Options.HideGuildSpam then
				Options.HideGuildSpam = nil
				Self:SetChecked(false)
			else
				Options.HideGuildSpam = true
				Self:SetChecked(true)
			end
		end
	)

	if Options.HideGuildSpam then
		GeneralSubcategory.HideGuildSpamCheckbox:SetChecked(true)
	end

	GeneralSubcategory.Label1 = GeneralSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	GeneralSubcategory.Label1:SetJustifyH("LEFT")
	GeneralSubcategory.Label1:SetPoint("TOPLEFT", 16, -16)
	GeneralSubcategory.Label1:SetText("General")

	GeneralSubcategory.Label2 = GeneralSubcategory:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	GeneralSubcategory.Label2:SetJustifyH("LEFT")
	GeneralSubcategory.Label2:SetPoint("TOPLEFT", 16, -36)
	GeneralSubcategory.Label2:SetText("General options for SnailUI")

	GeneralSubcategory.Label3 = GeneralSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	GeneralSubcategory.Label3:SetJustifyH("LEFT")
	GeneralSubcategory.Label3:SetPoint("TOPLEFT", 16, -60)
	GeneralSubcategory.Label3:SetText("Hide guild advertisements")

	GeneralSubcategory.Label4 = GeneralSubcategory.HideGuildSpamCheckbox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	GeneralSubcategory.Label4:SetJustifyH("LEFT")
	GeneralSubcategory.Label4:SetPoint("RIGHT", 386, 0)
	GeneralSubcategory.Label4:SetText("Hide most guild advertisements (unusual ads will sometimes get through)")

	GeneralSubcategory.Label5 = GeneralSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	GeneralSubcategory.Label5:SetJustifyH("LEFT")
	GeneralSubcategory.Label5:SetPoint("TOPLEFT", 16, -108)
	GeneralSubcategory.Label5:SetText("Theme")

	GeneralSubcategory.ThemeDropdownMenu = CreateFrame("Frame", "ThemeDropdownMenu", GeneralSubcategory, "UIDropDownMenuTemplate")
	GeneralSubcategory.ThemeDropdownMenu:SetPoint("TOPLEFT", 0, -121)

	UIDropDownMenu_Initialize(GeneralSubcategory.ThemeDropdownMenu,
		function(ThemeDropdownMenu, Level)
			local Index = 1

			for Theme, _ in pairs(Configuration.Themes) do
				local Info = UIDropDownMenu_CreateInfo()

				Info.text = Theme
				Info.func = function(Self)
					UIDropDownMenu_SetSelectedID(ThemeDropdownMenu, Self:GetID())
					Options.Theme = Themes[Self:GetID()]
				end

				Themes[Index] = Theme
				Themes[Theme] = Index

				Index = Index + 1
				UIDropDownMenu_AddButton(Info, Level)
			end
		end
	)

	UIDropDownMenu_JustifyText(GeneralSubcategory.ThemeDropdownMenu, "LEFT")
	UIDropDownMenu_SetSelectedID(GeneralSubcategory.ThemeDropdownMenu, Themes[Options.Theme])

	local HealingIndicatorsSubcategory = CreateFrame("Frame", nil, Category)

	HealingIndicatorsSubcategory.name = "Healing Indicators"
	HealingIndicatorsSubcategory.parent = Category.name

	HealingIndicatorsSubcategory.Label1 = HealingIndicatorsSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	HealingIndicatorsSubcategory.Label1:SetJustifyH("LEFT")
	HealingIndicatorsSubcategory.Label1:SetPoint("TOPLEFT", 16, -16)
	HealingIndicatorsSubcategory.Label1:SetText("Healing Indicators")

	HealingIndicatorsSubcategory.Label2 = HealingIndicatorsSubcategory:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	HealingIndicatorsSubcategory.Label2:SetJustifyH("LEFT")
	HealingIndicatorsSubcategory.Label2:SetPoint("TOPLEFT", 16, -36)
	HealingIndicatorsSubcategory.Label2:SetText("Healing indicator options for SnailUI")

	HealingIndicatorsSubcategory.Label3 = HealingIndicatorsSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	HealingIndicatorsSubcategory.Label3:SetJustifyH("LEFT")
	HealingIndicatorsSubcategory.Label3:SetPoint("TOPLEFT", 16, -60)
	HealingIndicatorsSubcategory.Label3:SetText("Spell name")

	local ReloadHIDropdownMenu = function()
		UIDropDownMenu_Initialize(HIDropdownMenu,
			function(HIDropdownMenu, Level)
				for I = 1, #Options.HealingIndicators[UnitGUID("Player")] do
					local Info = UIDropDownMenu_CreateInfo()

					Info.text = Options.HealingIndicators[UnitGUID("Player")][I]
					Info.func = function(Self)
						UIDropDownMenu_SetSelectedID(HIDropdownMenu, Self:GetID())
					end

					UIDropDownMenu_AddButton(Info, Level)
				end
			end
		)

		UIDropDownMenu_SetSelectedID(HealingIndicatorsSubcategory.HIDropdownMenu, 1)
	end

	HealingIndicatorsSubcategory.HICreateButton = CreateFrame("Button", "HICreateButton", HealingIndicatorsSubcategory, "UIPanelButtonTemplate")
	HealingIndicatorsSubcategory.HICreateButton:SetPoint("TOPLEFT", 16, -108)
	HealingIndicatorsSubcategory.HICreateButton:SetSize(96, 21)
	HealingIndicatorsSubcategory.HICreateButton:SetText("Create")
	HealingIndicatorsSubcategory.HICreateButton:SetScript("OnClick",
		function(Self)
			local Found = false

			for I = 1, #Options.HealingIndicators[UnitGUID("Player")] do
				if Options.HealingIndicators[UnitGUID("Player")][I] == HIInputBox:GetText() then
					Found = true
				end
			end

			if (not Found) and (HIInputBox:GetText() ~= "") then
				Options.HealingIndicators[UnitGUID("Player")][#Options.HealingIndicators[UnitGUID("Player")] + 1] = HIInputBox:GetText()

				HIInputBox:SetText("")
				HIInputBox:ClearFocus()

				ReloadHIDropdownMenu()
			end
		end
	)

	HealingIndicatorsSubcategory.HIDeleteButton = CreateFrame("Button", "HIDeleteButton", HealingIndicatorsSubcategory, "UIPanelButtonTemplate")
	HealingIndicatorsSubcategory.HIDeleteButton:SetPoint("TOPLEFT", 158, -108)
	HealingIndicatorsSubcategory.HIDeleteButton:SetSize(96, 21)
	HealingIndicatorsSubcategory.HIDeleteButton:SetText("Delete")
	HealingIndicatorsSubcategory.HIDeleteButton:SetScript("OnClick",
		function(Self)
			if #Options.HealingIndicators[UnitGUID("Player")] > 0 then
				for I = UIDropDownMenu_GetSelectedID(HIDropdownMenu), (#Options.HealingIndicators[UnitGUID("Player")] - 1) do
					Options.HealingIndicators[UnitGUID("Player")][I] = Options.HealingIndicators[UnitGUID("Player")][I + 1]
				end

				Options.HealingIndicators[UnitGUID("Player")][#Options.HealingIndicators[UnitGUID("Player")]] = nil
				ReloadHIDropdownMenu()
			end
		end
	)

	HealingIndicatorsSubcategory.HIDropdownMenu = CreateFrame("Frame", "HIDropdownMenu", HealingIndicatorsSubcategory, "UIDropDownMenuTemplate")
	HealingIndicatorsSubcategory.HIDropdownMenu:SetPoint("TOPLEFT", 142, -75)

	if not Options.HealingIndicators then
		Options.HealingIndicators = {}
	end

	if not Options.HealingIndicators[UnitGUID("Player")] then
		Options.HealingIndicators[UnitGUID("Player")] = {}
	end

	UIDropDownMenu_JustifyText(HealingIndicatorsSubcategory.HIDropdownMenu, "LEFT")
	ReloadHIDropdownMenu()

	HealingIndicatorsSubcategory.HIInputBox = CreateFrame("EditBox", "HIInputBox", HealingIndicatorsSubcategory, "InputBoxTemplate")
	HealingIndicatorsSubcategory.HIInputBox:SetAutoFocus(false)
	HealingIndicatorsSubcategory.HIInputBox:SetHeight(29)
	HealingIndicatorsSubcategory.HIInputBox:SetPoint("TOPLEFT", 22, -73)
	HealingIndicatorsSubcategory.HIInputBox:SetWidth(126)

	if not Options.Timers then
		Options.Timers = {}
	end

	if not Options.Timers[UnitGUID("Player")] then
		Options.Timers[UnitGUID("Player")] =
		{
			Anchor = "BOTTOM",
			Height = 24,
			Width = 464,
			X = 26,
			Y = 242
		}
	end

	local TimersSubcategory = CreateFrame("Frame", nil, Category)

	TimersSubcategory.name = "Timers"
	TimersSubcategory.parent = Category.name
	TimersSubcategory.okay = function(Self)
		Options.Timers[UnitGUID("Player")].Anchor = Anchors[UIDropDownMenu_GetSelectedID(AnchorDropdownMenu)]
		Options.Timers[UnitGUID("Player")].Height = tonumber(HeightInputBox:GetText())
		Options.Timers[UnitGUID("Player")].Width = tonumber(WidthInputBox:GetText())
		Options.Timers[UnitGUID("Player")].X = tonumber(XInputBox:GetText())
		Options.Timers[UnitGUID("Player")].Y = tonumber(YInputBox:GetText())
	end

	TimersSubcategory.Label1 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	TimersSubcategory.Label1:SetJustifyH("LEFT")
	TimersSubcategory.Label1:SetPoint("TOPLEFT", 16, -16)
	TimersSubcategory.Label1:SetText("Timers")

	TimersSubcategory.Label2 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	TimersSubcategory.Label2:SetJustifyH("LEFT")
	TimersSubcategory.Label2:SetPoint("TOPLEFT", 16, -36)
	TimersSubcategory.Label2:SetText("Timer options for SnailUI")

	TimersSubcategory.Label3 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	TimersSubcategory.Label3:SetJustifyH("LEFT")
	TimersSubcategory.Label3:SetPoint("TOPLEFT", 16, -60)
	TimersSubcategory.Label3:SetText("Anchor")

	TimersSubcategory.Label4 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	TimersSubcategory.Label4:SetJustifyH("LEFT")
	TimersSubcategory.Label4:SetPoint("TOPLEFT", 157, -60)
	TimersSubcategory.Label4:SetText("Width")

	TimersSubcategory.Label5 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	TimersSubcategory.Label5:SetJustifyH("LEFT")
	TimersSubcategory.Label5:SetPoint("TOPLEFT", 260, -60)
	TimersSubcategory.Label5:SetText("Height")

	TimersSubcategory.Label6 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	TimersSubcategory.Label6:SetJustifyH("LEFT")
	TimersSubcategory.Label6:SetPoint("TOPLEFT", 370, -60)
	TimersSubcategory.Label6:SetText("Position (Use increments of [X: 52 | Y: 28])")

	TimersSubcategory.Label7 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	TimersSubcategory.Label7:SetJustifyH("LEFT")
	TimersSubcategory.Label7:SetPoint("TOPLEFT", 16, -111)
	TimersSubcategory.Label7:SetText("Spell name")

	TimersSubcategory.Label8 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	TimersSubcategory.Label8:SetJustifyH("LEFT")
	TimersSubcategory.Label8:SetPoint("TOPLEFT", 156, -111)
	TimersSubcategory.Label8:SetText("Type")

	TimersSubcategory.Label9 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	TimersSubcategory.Label9:SetJustifyH("LEFT")
	TimersSubcategory.Label9:SetPoint("TOPLEFT", 297, -111)
	TimersSubcategory.Label9:SetText("Unit")

	TimersSubcategory.Label10 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	TimersSubcategory.Label10:SetJustifyH("LEFT")
	TimersSubcategory.Label10:SetPoint("TOPLEFT", 438, -111)
	TimersSubcategory.Label10:SetText("Priority")

	TimersSubcategory.Label11 = TimersSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	TimersSubcategory.Label11:SetJustifyH("LEFT")
	TimersSubcategory.Label11:SetPoint("TOPLEFT", 16, -158)
	TimersSubcategory.Label11:SetText("Color")

	TimersSubcategory.AnchorDropdownMenu = CreateFrame("Frame", "AnchorDropdownMenu", TimersSubcategory, "UIDropDownMenuTemplate")
	TimersSubcategory.AnchorDropdownMenu:SetPoint("TOPLEFT", 0, -75)

	Anchors =
	{
		"BOTTOM",
		"BOTTOMLEFT",
		"BOTTOMRIGHT",
		"CENTER",
		"TOP",
		"TOPLEFT",
		"TOPRIGHT"
	}

	UIDropDownMenu_Initialize(AnchorDropdownMenu,
		function(AnchorDropdownMenu, Level)
			for I = 1, #Anchors do
				local Info = UIDropDownMenu_CreateInfo()

				Info.text = Anchors[I]
				Info.func = function(Self)
					UIDropDownMenu_SetSelectedID(AnchorDropdownMenu, Self:GetID())
				end

				UIDropDownMenu_AddButton(Info, Level)
			end
		end
	)

	local AnchorIndex

	for I = 1, #Anchors do
		if Options.Timers[UnitGUID("Player")].Anchor == Anchors[I] then
			AnchorIndex = I
		end
	end

	UIDropDownMenu_JustifyText(TimersSubcategory.AnchorDropdownMenu, "LEFT")
	UIDropDownMenu_SetSelectedID(TimersSubcategory.AnchorDropdownMenu, AnchorIndex or 1)

	TimersSubcategory.WidthInputBox = CreateFrame("EditBox", "WidthInputBox", TimersSubcategory, "InputBoxTemplate")
	TimersSubcategory.WidthInputBox:SetAutoFocus(false)
	TimersSubcategory.WidthInputBox:SetHeight(29)
	TimersSubcategory.WidthInputBox:SetPoint("TOPLEFT", 163, -73)
	TimersSubcategory.WidthInputBox:SetText(Options.Timers[UnitGUID("Player")].Width)
	TimersSubcategory.WidthInputBox:SetCursorPosition(0)
	TimersSubcategory.WidthInputBox:SetWidth(88)

	TimersSubcategory.HeightInputBox = CreateFrame("EditBox", "HeightInputBox", TimersSubcategory, "InputBoxTemplate")
	TimersSubcategory.HeightInputBox:SetAutoFocus(false)
	TimersSubcategory.HeightInputBox:SetHeight(29)
	TimersSubcategory.HeightInputBox:SetPoint("LEFT", TimersSubcategory.WidthInputBox, "RIGHT", 15, 0)
	TimersSubcategory.HeightInputBox:SetText(Options.Timers[UnitGUID("Player")].Height)
	TimersSubcategory.HeightInputBox:SetCursorPosition(0)
	TimersSubcategory.HeightInputBox:SetWidth(88)

	TimersSubcategory.XInputBox = CreateFrame("EditBox", "XInputBox", TimersSubcategory, "InputBoxTemplate")
	TimersSubcategory.XInputBox:SetAutoFocus(false)
	TimersSubcategory.XInputBox:SetHeight(29)
	TimersSubcategory.XInputBox:SetPoint("LEFT", TimersSubcategory.HeightInputBox, "RIGHT", 22, 0)
	TimersSubcategory.XInputBox:SetText(Options.Timers[UnitGUID("Player")].X)
	TimersSubcategory.XInputBox:SetCursorPosition(0)
	TimersSubcategory.XInputBox:SetWidth(88)

	TimersSubcategory.XInputBox.Label1 = TimersSubcategory.XInputBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	TimersSubcategory.XInputBox.Label1:SetJustifyH("LEFT")
	TimersSubcategory.XInputBox.Label1:SetPoint("RIGHT", TimersSubcategory.XInputBox, "LEFT", -5, 0)
	TimersSubcategory.XInputBox.Label1:SetText("X: ")

	TimersSubcategory.YInputBox = CreateFrame("EditBox", "YInputBox", TimersSubcategory, "InputBoxTemplate")
	TimersSubcategory.YInputBox:SetAutoFocus(false)
	TimersSubcategory.YInputBox:SetHeight(29)
	TimersSubcategory.YInputBox:SetPoint("LEFT", TimersSubcategory.XInputBox, "RIGHT", 21, 0)
	TimersSubcategory.YInputBox:SetText(Options.Timers[UnitGUID("Player")].Y)
	TimersSubcategory.YInputBox:SetCursorPosition(0)
	TimersSubcategory.YInputBox:SetWidth(88)

	TimersSubcategory.YInputBox.Label1 = TimersSubcategory.YInputBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	TimersSubcategory.YInputBox.Label1:SetJustifyH("LEFT")
	TimersSubcategory.YInputBox.Label1:SetPoint("RIGHT", TimersSubcategory.YInputBox, "LEFT", -5, 0)
	TimersSubcategory.YInputBox.Label1:SetText("Y: ")

	TimersSubcategory.SpellNameInputBox = CreateFrame("EditBox", "SpellNameInputBox", TimersSubcategory, "InputBoxTemplate")
	TimersSubcategory.SpellNameInputBox:SetAutoFocus(false)
	TimersSubcategory.SpellNameInputBox:SetHeight(29)
	TimersSubcategory.SpellNameInputBox:SetPoint("TOPLEFT", 22, -123)
	TimersSubcategory.SpellNameInputBox:SetWidth(126)

	TimersSubcategory.TypeDropdownMenu = CreateFrame("Frame", "TypeDropdownMenu", TimersSubcategory, "UIDropDownMenuTemplate")
	TimersSubcategory.TypeDropdownMenu:SetPoint("TOPLEFT", 140, -125)

	Types =
	{
		"Buff",
		"Cooldown",
		"Debuff"
	}

	UIDropDownMenu_Initialize(TypeDropdownMenu,
		function(TypeDropdownMenu, Level)
			for I = 1, #Types do
				local Info = UIDropDownMenu_CreateInfo()

				Info.text = Types[I]
				Info.func = function(Self)
					UIDropDownMenu_SetSelectedID(TypeDropdownMenu, Self:GetID())
				end

				UIDropDownMenu_AddButton(Info, Level)
			end
		end
	)

	UIDropDownMenu_JustifyText(TimersSubcategory.TypeDropdownMenu, "LEFT")
	UIDropDownMenu_SetSelectedID(TimersSubcategory.TypeDropdownMenu, 1)

	TimersSubcategory.UnitDropdownMenu = CreateFrame("Frame", "UnitDropdownMenu", TimersSubcategory, "UIDropDownMenuTemplate")
	TimersSubcategory.UnitDropdownMenu:SetPoint("LEFT", TimersSubcategory.TypeDropdownMenu, "RIGHT", 101, 0)

	Units =
	{
		"Player",
		"Focus",
		"Target"
	}

	UIDropDownMenu_Initialize(UnitDropdownMenu,
		function(UnitDropdownMenu, Level)
			for I = 1, #Units do
				local Info = UIDropDownMenu_CreateInfo()

				Info.text = Units[I]
				Info.func = function(Self)
					UIDropDownMenu_SetSelectedID(UnitDropdownMenu, Self:GetID())
				end

				UIDropDownMenu_AddButton(Info, Level)
			end
		end
	)

	UIDropDownMenu_JustifyText(TimersSubcategory.UnitDropdownMenu, "LEFT")
	UIDropDownMenu_SetSelectedID(TimersSubcategory.UnitDropdownMenu, 1)

	TimersSubcategory.PriorityInputBox = CreateFrame("EditBox", "PriorityInputBox", TimersSubcategory, "InputBoxTemplate")
	TimersSubcategory.PriorityInputBox:SetAutoFocus(false)
	TimersSubcategory.PriorityInputBox:SetHeight(29)
	TimersSubcategory.PriorityInputBox:SetPoint("TOPLEFT", TimersSubcategory.UnitDropdownMenu, "TOPRIGHT", 123, 2)
	TimersSubcategory.PriorityInputBox:SetText("1")
	TimersSubcategory.PriorityInputBox:SetCursorPosition(0)
	TimersSubcategory.PriorityInputBox:SetWidth(88)

	TimersSubcategory.RInputBox = CreateFrame("EditBox", "RInputBox", TimersSubcategory, "InputBoxTemplate")
	TimersSubcategory.RInputBox:SetAutoFocus(false)
	TimersSubcategory.RInputBox:SetHeight(29)
	TimersSubcategory.RInputBox:SetPoint("TOPLEFT", 34, -170)
	TimersSubcategory.RInputBox:SetWidth(88)

	TimersSubcategory.RInputBox.Label1 = TimersSubcategory.RInputBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	TimersSubcategory.RInputBox.Label1:SetJustifyH("LEFT")
	TimersSubcategory.RInputBox.Label1:SetPoint("RIGHT", TimersSubcategory.RInputBox, "LEFT", -4, 0)
	TimersSubcategory.RInputBox.Label1:SetText("R: ")

	TimersSubcategory.GInputBox = CreateFrame("EditBox", "GInputBox", TimersSubcategory, "InputBoxTemplate")
	TimersSubcategory.GInputBox:SetAutoFocus(false)
	TimersSubcategory.GInputBox:SetHeight(29)
	TimersSubcategory.GInputBox:SetPoint("LEFT", TimersSubcategory.RInputBox, "RIGHT", 21, 0)
	TimersSubcategory.GInputBox:SetWidth(88)

	TimersSubcategory.GInputBox.Label1 = TimersSubcategory.GInputBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	TimersSubcategory.GInputBox.Label1:SetJustifyH("LEFT")
	TimersSubcategory.GInputBox.Label1:SetPoint("RIGHT", TimersSubcategory.GInputBox, "LEFT", -4, 0)
	TimersSubcategory.GInputBox.Label1:SetText("G: ")

	TimersSubcategory.BInputBox = CreateFrame("EditBox", "BInputBox", TimersSubcategory, "InputBoxTemplate")
	TimersSubcategory.BInputBox:SetAutoFocus(false)
	TimersSubcategory.BInputBox:SetHeight(29)
	TimersSubcategory.BInputBox:SetPoint("LEFT", TimersSubcategory.GInputBox, "RIGHT", 20, 0)
	TimersSubcategory.BInputBox:SetWidth(88)

	TimersSubcategory.BInputBox.Label1 = TimersSubcategory.BInputBox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	TimersSubcategory.BInputBox.Label1:SetJustifyH("LEFT")
	TimersSubcategory.BInputBox.Label1:SetPoint("RIGHT", TimersSubcategory.BInputBox, "LEFT", -4, 0)
	TimersSubcategory.BInputBox.Label1:SetText("B: ")

	TimersSubcategory.ShowColorPickerButton = CreateFrame("Button", "ShowColorPickerButton", TimersSubcategory, "UIPanelButtonTemplate")
	TimersSubcategory.ShowColorPickerButton:SetPoint("LEFT", TimersSubcategory.BInputBox, "RIGHT", 9, 0)
	TimersSubcategory.ShowColorPickerButton:SetSize(96, 21)
	TimersSubcategory.ShowColorPickerButton:SetText("Pick Color")
	TimersSubcategory.ShowColorPickerButton:SetScript("OnClick",
		function(Self)
			ColorPickerFrame.cancelFunc = function()
				RInputBox:SetText(ColorPickerFrame.previousValues[1])
				GInputBox:SetText(ColorPickerFrame.previousValues[2])
				BInputBox:SetText(ColorPickerFrame.previousValues[3])
			end

			ColorPickerFrame.func = function()
				local R, G, B = ColorPickerFrame:GetColorRGB()

				RInputBox:SetText(R * OpacitySliderFrame:GetValue())
				GInputBox:SetText(G * OpacitySliderFrame:GetValue())
				BInputBox:SetText(B * OpacitySliderFrame:GetValue())
			end

			ColorPickerFrame.previousValues = {RInputBox:GetText(), GInputBox:GetText(), BInputBox:GetText(), 1}
			ColorPickerFrame:Show()
		end
	)

	TimersSubcategory.ShowOnFocusCheckbox = CreateFrame("CheckButton", "ShowOnFocusCheckbox", TimersSubcategory, "InterfaceOptionsCheckButtonTemplate")
	TimersSubcategory.ShowOnFocusCheckbox:SetPoint("LEFT", TimersSubcategory.ShowColorPickerButton, "RIGHT", 6, 0)
	TimersSubcategory.ShowOnFocusCheckbox:SetScript("OnClick",
		function(Self)
			if not Self:GetChecked() then
				Self:SetChecked(false)
			else
				Self:SetChecked(true)
			end
		end
	)

	TimersSubcategory.ShowOnFocusCheckbox.Label1 = TimersSubcategory.ShowOnFocusCheckbox:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	TimersSubcategory.ShowOnFocusCheckbox.Label1:SetJustifyH("LEFT")
	TimersSubcategory.ShowOnFocusCheckbox.Label1:SetPoint("LEFT", TimersSubcategory.BInputBox, "RIGHT", 142, 0)
	TimersSubcategory.ShowOnFocusCheckbox.Label1:SetText("Show on focus frame")

	local ReloadTimerDropdownMenu = function()
		UIDropDownMenu_Initialize(TimerDropdownMenu,
			function(TimerDropdownMenu, Level)
				for Index, Timer in ipairs(Options.Timers[UnitGUID("Player")]) do
					local Info = UIDropDownMenu_CreateInfo()

					Info.text = Timer.Spell
					Info.func = function(Self)
						UIDropDownMenu_SetSelectedID(TimerDropdownMenu, Self:GetID())
					end

					UIDropDownMenu_AddButton(Info, Level)
				end
			end
		)

		UIDropDownMenu_SetSelectedID(TimersSubcategory.TimerDropdownMenu, 1)
	end

	TimersSubcategory.CreateTimerButton = CreateFrame("Button", "CreateTimerButton", TimersSubcategory, "UIPanelButtonTemplate")
	TimersSubcategory.CreateTimerButton:SetPoint("TOPLEFT", 15, -201)
	TimersSubcategory.CreateTimerButton:SetSize(96, 21)
	TimersSubcategory.CreateTimerButton:SetText("Create")
	TimersSubcategory.CreateTimerButton:SetScript("OnClick",
		function(Self)
			local Found = false

			for Index, Timer in ipairs(Options.Timers[UnitGUID("Player")]) do
				if (Timer.Spell == SpellNameInputBox:GetText()) and (Timer.Type == Types[UIDropDownMenu_GetSelectedID(TypeDropdownMenu)]) and (Timer.Unit == Units[UIDropDownMenu_GetSelectedID(UnitDropdownMenu)]) then
					Found = true
				end
			end

			if (not Found) and (SpellNameInputBox:GetText() ~= "") and (RInputBox:GetText() ~= "") and (GInputBox:GetText() ~= "") and (BInputBox:GetText() ~= "") then
				Options.Timers[UnitGUID("Player")][#Options.Timers[UnitGUID("Player")] + 1] =
				{
						Priority = tonumber(PriorityInputBox:GetText()),
						ShowOnFocus = ShowOnFocusCheckbox:GetChecked(),
						Spell = SpellNameInputBox:GetText(),
						Type = Types[UIDropDownMenu_GetSelectedID(TypeDropdownMenu)],
						Unit = Units[UIDropDownMenu_GetSelectedID(UnitDropdownMenu)],

						Color =
						{
							R = tonumber(RInputBox:GetText()),
							G = tonumber(GInputBox:GetText()),
							B = tonumber(BInputBox:GetText())
						}
				}

				PriorityInputBox:SetText("1")
				PriorityInputBox:SetCursorPosition(0)
				PriorityInputBox:ClearFocus()

				SpellNameInputBox:SetText("")
				SpellNameInputBox:SetCursorPosition(0)
				SpellNameInputBox:ClearFocus()

				RInputBox:SetText("")
				RInputBox:SetCursorPosition(0)
				RInputBox:ClearFocus()

				GInputBox:SetText("")
				GInputBox:SetCursorPosition(0)
				GInputBox:ClearFocus()

				BInputBox:SetText("")
				BInputBox:SetCursorPosition(0)
				BInputBox:ClearFocus()

				ReloadTimerDropdownMenu()
			end
		end
	)

	TimersSubcategory.DeleteTimerButton = CreateFrame("Button", "DeleteTimerButton", TimersSubcategory, "UIPanelButtonTemplate")
	TimersSubcategory.DeleteTimerButton:SetPoint("LEFT", TimersSubcategory.CreateTimerButton, "RIGHT", 8, 0)
	TimersSubcategory.DeleteTimerButton:SetSize(96, 21)
	TimersSubcategory.DeleteTimerButton:SetText("Delete")
	TimersSubcategory.DeleteTimerButton:SetScript("OnClick",
		function(Self)
			if #Options.Timers[UnitGUID("Player")] > 0 then
				for I = UIDropDownMenu_GetSelectedID(TimerDropdownMenu), (#Options.Timers[UnitGUID("Player")] - 1) do
					Options.Timers[UnitGUID("Player")][I] = Options.Timers[UnitGUID("Player")][I + 1]
				end

				Options.Timers[UnitGUID("Player")][#Options.Timers[UnitGUID("Player")]] = nil
				ReloadTimerDropdownMenu()
			end
		end
	)

	TimersSubcategory.TimerDropdownMenu = CreateFrame("Frame", "TimerDropdownMenu", TimersSubcategory, "UIDropDownMenuTemplate")
	TimersSubcategory.TimerDropdownMenu:SetPoint("TOPLEFT", TimersSubcategory.DeleteTimerButton, "TOPRIGHT", -9, 1)

	ReloadTimerDropdownMenu()

	UIDropDownMenu_JustifyText(TimersSubcategory.TimerDropdownMenu, "LEFT")
	UIDropDownMenu_SetSelectedID(TimersSubcategory.TimerDropdownMenu, 1)

	InterfaceOptions_AddCategory(Category)
	InterfaceOptions_AddCategory(GeneralSubcategory)
	InterfaceOptions_AddCategory(FramesSubcategory)
	InterfaceOptions_AddCategory(HealingIndicatorsSubcategory)
	InterfaceOptions_AddCategory(TimersSubcategory)

	SlashCmdList["SnailUI"] = function()

		InterfaceOptionsFrame_OpenToCategory(Category)
		InterfaceOptionsFrame_OpenToCategory(Category)
	end

	SLASH_SnailUI1 = "/SnailUI"
	SLASH_SnailUI2 = "/SUI"
end
