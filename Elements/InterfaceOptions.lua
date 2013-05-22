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
		"http://curse.com/addons/wow/snailui" ..
		"\n" ..
		"http://wowinterface.com/downloads/info20900-SnailUI"
	)

	FramesSubcategory = CreateFrame("Frame", nil, Category)
	FramesSubcategory.name = "Frames"
	FramesSubcategory.parent = Category.name

	FramesSubcategory.RaidEnabledCheckbox = CreateFrame("CheckButton", nil, FramesSubcategory, "InterfaceOptionsCheckButtonTemplate")
	FramesSubcategory.RaidEnabledCheckbox:SetPoint("TOPLEFT", 16, -119)
	FramesSubcategory.RaidEnabledCheckbox:SetScript("OnClick",
		function(Self)
			if not EnableRaidFrames then
				EnableRaidFrames = true
				Self:SetChecked(false)
			else
				EnableRaidFrames = nil
				Self:SetChecked(true)
			end
		end
	)

	if not EnableRaidFrames then
		FramesSubcategory.RaidEnabledCheckbox:SetChecked(true)
	end

	FramesSubcategory.SideBarsEnabledCheckbox = CreateFrame("CheckButton", nil, FramesSubcategory, "InterfaceOptionsCheckButtonTemplate")
	FramesSubcategory.SideBarsEnabledCheckbox:SetPoint("TOPLEFT", 16, -73)
	FramesSubcategory.SideBarsEnabledCheckbox:SetScript("OnClick",
		function(Self)
			if EnableSideBars then
				EnableSideBars = nil
				Self:SetChecked(false)
			else
				EnableSideBars = true
				Self:SetChecked(true)
			end
		end
	)

	if EnableSideBars then
		FramesSubcategory.SideBarsEnabledCheckbox:SetChecked(true)
	end

	FramesSubcategory.ThreatColorsCheckBox = CreateFrame("CheckButton", nil, FramesSubcategory, "InterfaceOptionsCheckButtonTemplate")
	FramesSubcategory.ThreatColorsCheckBox:SetPoint("TOPLEFT", 16, -165)
	FramesSubcategory.ThreatColorsCheckBox:SetScript("OnClick",
		function(Self)
			if EnableThreatColorsOnAllFrames then
				EnableThreatColorsOnAllFrames = nil
				Self:SetChecked(false)
			else
				EnableThreatColorsOnAllFrames = true
				Self:SetChecked(true)
			end
		end
	)

	if EnableThreatColorsOnAllFrames then
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

	GeneralSubcategory = CreateFrame("Frame", nil, Category)
	GeneralSubcategory.name = "General"
	GeneralSubcategory.parent = Category.name

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
	GeneralSubcategory.Label3:SetText("Theme")

	GeneralSubcategory.ThemeDropdownMenu = CreateFrame("Frame", "ThemeDropdownMenu", GeneralSubcategory, "UIDropDownMenuTemplate")
	GeneralSubcategory.ThemeDropdownMenu:SetPoint("TOPLEFT", 0, -73)
		
	UIDropDownMenu_Initialize(GeneralSubcategory.ThemeDropdownMenu,
		function(ThemeDropdownMenu, Level)
			local Index = 1

			for Key, _ in pairs(Configuration.Themes) do
				local Info = UIDropDownMenu_CreateInfo()

				Info.text = Key
				Info.func = function(Self)
					UIDropDownMenu_SetSelectedID(ThemeDropdownMenu, Self:GetID())
					Theme = Themes[Self:GetID()]
				end

				Themes[Index] = Key
				Themes[Key] = Index

				Index = Index + 1
				UIDropDownMenu_AddButton(Info, Level)
			end
		end
	)

	UIDropDownMenu_JustifyText(GeneralSubcategory.ThemeDropdownMenu, "LEFT")
	UIDropDownMenu_SetSelectedID(GeneralSubcategory.ThemeDropdownMenu, Themes[Theme])

	InterfaceOptions_AddCategory(Category)
	InterfaceOptions_AddCategory(GeneralSubcategory)
	InterfaceOptions_AddCategory(FramesSubcategory)

	SlashCmdList["SnailUI"] = function()
		InterfaceOptionsFrame_OpenToCategory(Category)
	end

	SLASH_SnailUI1 = "/SnailUI"
	SLASH_SnailUI2 = "/SUI"
end
