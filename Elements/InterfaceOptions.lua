-- InterfaceOptions.lua
-- Written by Snail

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
		"Written by Snail" ..
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

	InterfaceOptions_AddCategory(Category)
	InterfaceOptions_AddCategory(GeneralSubcategory)
	InterfaceOptions_AddCategory(FramesSubcategory)

	SlashCmdList["SnailUI"] = function()
		InterfaceOptionsFrame_OpenToCategory(Category)
		InterfaceOptionsFrame_OpenToCategory(Category)
	end

	SLASH_SnailUI1 = "/SnailUI"
	SLASH_SnailUI2 = "/SUI"
end
