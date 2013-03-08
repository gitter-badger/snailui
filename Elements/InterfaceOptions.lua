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

	GeneralSubcategory.Label4 = GeneralSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	GeneralSubcategory.Label4:SetJustifyH("LEFT")
	GeneralSubcategory.Label4:SetPoint("TOPLEFT", 16, -115)
	GeneralSubcategory.Label4:SetText("Miscellaneous")

	GeneralSubcategory.ThemeDropdownMenu = CreateFrame("Frame", "ThemeDropdownMenu", GeneralSubcategory, "UIDropDownMenuTemplate")
	GeneralSubcategory.ThemeDropdownMenu:SetPoint("TOPLEFT", 0, -73)

	GeneralSubcategory.ThreatColorsCheckBox = CreateFrame("CheckButton", nil, GeneralSubcategory, "InterfaceOptionsCheckButtonTemplate")
	GeneralSubcategory.ThreatColorsCheckBox:SetPoint("TOPLEFT", 16, -128)
	GeneralSubcategory.ThreatColorsCheckBox:SetScript("OnClick",
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
		GeneralSubcategory.ThreatColorsCheckBox:SetChecked(true)
	end

	GeneralSubcategory.ThreatColorsText = GeneralSubcategory:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	GeneralSubcategory.ThreatColorsText:SetJustifyH("LEFT")
	GeneralSubcategory.ThreatColorsText:SetPoint("RIGHT", GeneralSubcategory.ThreatColorsCheckBox, 290, 0)
	GeneralSubcategory.ThreatColorsText:SetText(
		"Color all frame borders based on the unit's threat level" ..
		"\n" ..
		"Default: Only color the raid frames' borders"
	)
		
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

	SlashCmdList["SnailUI"] = function()
		InterfaceOptionsFrame_OpenToCategory(Category)
	end

	SLASH_SnailUI1 = "/SnailUI"
	SLASH_SnailUI2 = "/SUI"
end
