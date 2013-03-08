-- ExperienceBar.lua
-- Written by Snail

function HandleExperienceBar()
	if GetConfiguration().ExperienceBar and (UnitLevel("Player") ~= MAX_PLAYER_LEVEL) then
		local Class = select(2, UnitClass("Player"))
		local OriginalExpBar_Update = ExpBar_Update

		ExhaustionTick:UnregisterAllEvents()
		ExpBar_Update = function()
			OriginalExpBar_Update()
			ExhaustionLevelFillBar:Hide()
			MainMenuExpBar:SetStatusBarColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
		end

		MainMenuExpBar:SetParent(UIParent)
		MainMenuExpBar:SetPoint(GetConfiguration().ExperienceBar.Anchor, GetConfiguration().ExperienceBar.X, GetConfiguration().ExperienceBar.Y)
		MainMenuExpBar:SetSize(GetConfiguration().ExperienceBar.Width - 6, GetConfiguration().ExperienceBar.Height - 6)
		MainMenuExpBar:SetStatusBarTexture(Configuration.Texture)
		MainMenuExpBar:SetScript("OnShow",
			function(Self)
				if GetConfiguration().ExtraButton then
					if ExtraButton:GetAlpha() == 0 then
						Self:Hide()
					end
				end
			end
		)

		MainMenuExpBar.BackgroundBottom = MainMenuExpBar:CreateTexture(nil, "LOW")
		MainMenuExpBar.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
		MainMenuExpBar.BackgroundBottom:SetSize(GetConfiguration().ExperienceBar.Width - 2, 1)
		MainMenuExpBar.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		MainMenuExpBar.BackgroundLeft = MainMenuExpBar:CreateTexture(nil, "LOW")
		MainMenuExpBar.BackgroundLeft:SetPoint("LEFT", -2, 0)
		MainMenuExpBar.BackgroundLeft:SetSize(1, GetConfiguration().ExperienceBar.Height - 4)
		MainMenuExpBar.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		MainMenuExpBar.BackgroundRight = MainMenuExpBar:CreateTexture(nil, "LOW")
		MainMenuExpBar.BackgroundRight:SetPoint("RIGHT", 2, 0)
		MainMenuExpBar.BackgroundRight:SetSize(1, GetConfiguration().ExperienceBar.Height - 4)
		MainMenuExpBar.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		MainMenuExpBar.BackgroundTop = MainMenuExpBar:CreateTexture(nil, "LOW")
		MainMenuExpBar.BackgroundTop:SetPoint("TOP", 0, 2)
		MainMenuExpBar.BackgroundTop:SetSize(GetConfiguration().ExperienceBar.Width - 2, 1)
		MainMenuExpBar.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		MainMenuExpBar.Border = MainMenuExpBar:CreateTexture(nil, "BACKGROUND")
		MainMenuExpBar.Border:SetPoint("TOPLEFT", -3, 3)
		MainMenuExpBar.Border:SetSize(GetConfiguration().ExperienceBar.Width, GetConfiguration().ExperienceBar.Height)
		MainMenuExpBar.Border:SetTexture(0, 0, 0)
	end
end
