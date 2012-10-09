-- Experience.lua
-- Written by Snail

function HandleExperience()
    if GetConfiguration().Experience and (UnitLevel("Player") ~= MAX_PLAYER_LEVEL) then
        local function UpdateExperienceBarColors()
            MainMenuExpBar:SetStatusBarColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
        end

        MainMenuExpBar:RegisterEvent("PLAYER_ENTERING_WORLD", UpdateExperienceBarColors)
        MainMenuExpBar:RegisterEvent("PLAYER_LEVEL_UP", UpdateExperienceBarColors)
        MainMenuExpBar:RegisterEvent("PLAYER_UPDATE_RESTING", UpdateExperienceBarColors)
        MainMenuExpBar:RegisterEvent("PLAYER_XP_UPDATE", UpdateExperienceBarColors)
        MainMenuExpBar:RegisterEvent("UPDATE_EXHAUSTION", UpdateExperienceBarColors)
        MainMenuExpBar:RegisterEvent("UPDATE_EXPANSION_LEVEL", UpdateExperienceBarColors)

        MainMenuExpBar:SetParent(UIParent)
        MainMenuExpBar:SetPoint(GetConfiguration().Experience.Anchor, GetConfiguration().Experience.X, GetConfiguration().Experience.Y)
        MainMenuExpBar:SetSize(GetConfiguration().Experience.Width - 6, GetConfiguration().Experience.Height - 6)
        MainMenuExpBar:SetStatusBarTexture(Configuration.Texture)

        MainMenuExpBar.BackgroundBottom = MainMenuExpBar:CreateTexture(nil, "LOW")
        MainMenuExpBar.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
        MainMenuExpBar.BackgroundBottom:SetSize(GetConfiguration().Experience.Width - 2, 1)
        MainMenuExpBar.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        MainMenuExpBar.BackgroundLeft = MainMenuExpBar:CreateTexture(nil, "LOW")
        MainMenuExpBar.BackgroundLeft:SetPoint("LEFT", -2, 0)
        MainMenuExpBar.BackgroundLeft:SetSize(1, GetConfiguration().Experience.Height - 4)
        MainMenuExpBar.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        MainMenuExpBar.BackgroundRight = MainMenuExpBar:CreateTexture(nil, "LOW")
        MainMenuExpBar.BackgroundRight:SetPoint("RIGHT", 2, 0)
        MainMenuExpBar.BackgroundRight:SetSize(1, GetConfiguration().Experience.Height - 4)
        MainMenuExpBar.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        MainMenuExpBar.BackgroundTop = MainMenuExpBar:CreateTexture(nil, "LOW")
        MainMenuExpBar.BackgroundTop:SetPoint("TOP", 0, 2)
        MainMenuExpBar.BackgroundTop:SetSize(GetConfiguration().Experience.Width - 2, 1)
        MainMenuExpBar.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        MainMenuExpBar.Border = MainMenuExpBar:CreateTexture(nil, "BACKGROUND")
        MainMenuExpBar.Border:SetPoint("TOPLEFT", -3, 3)
        MainMenuExpBar.Border:SetSize(GetConfiguration().Experience.Width, GetConfiguration().Experience.Height)
        MainMenuExpBar.Border:SetTexture(0, 0, 0)
    end
end
