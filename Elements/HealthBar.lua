-- HealthBar.lua
-- Written by Snail

function HandleHealthBar(Self)
    if GetConfiguration()[Self.Frame].HealthBar then
        Self:RegisterEvent("UNIT_HEAL_PREDICTION",
            local function(Self)
                Self.HealPrediction.myBar:SetAlpha(Self:GetAlpha() / 2)
                Self.HealPrediction.otherBar:SetAlpha(Self:GetAlpha() / 2)
            end
        )

        Self.HealPrediction =
        {
            maxOverflow = 1,
            myBar = CreateFrame("StatusBar", nil, Self),
            otherBar = CreateFrame("StatusBar", nil, Self)
        }

        Self.HealPrediction.myBar:SetPoint("TOPLEFT", Self.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
        Self.HealPrediction.myBar:SetPoint("BOTTOMLEFT", Self.Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
        Self.HealPrediction.myBar:SetSize(GetConfiguration()[Self.Frame].HealthBar.Width - 2, GetConfiguration()[Self.Frame].HealthBar.Height - 2)
        Self.HealPrediction.myBar:SetStatusBarTexture(Configuration.Texture)

        Self.HealPrediction.otherBar:SetPoint("TOPLEFT", Self.HealPrediction.myBar:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
        Self.HealPrediction.otherBar:SetPoint("BOTTOMLEFT", Self.HealPrediction.myBar:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
        Self.HealPrediction.otherBar:SetSize(GetConfiguration()[Self.Frame].HealthBar.Width - 2, GetConfiguration()[Self.Frame].HealthBar.Height - 2)
        Self.HealPrediction.otherBar:SetStatusBarTexture(Configuration.Texture)

        Self.Health = CreateFrame("StatusBar", nil, Self)
        Self.Health.frequentUpdates = true
        Self.Health:SetOrientation(GetConfiguration()[Self.Frame].HealthBar.Orientation)
        Self.Health:SetPoint(GetConfiguration()[Self.Frame].HealthBar.Anchor, GetConfiguration()[Self.Frame].HealthBar.X, GetConfiguration()[Self.Frame].HealthBar.Y)
        Self.Health:SetSize(GetConfiguration()[Self.Frame].HealthBar.Width - 2, GetConfiguration()[Self.Frame].HealthBar.Height - 2)
        Self.Health:SetStatusBarTexture(Configuration.Texture)

        Self.Health.Border = Self.Health:CreateTexture(nil, "LOW")
        Self.Health.Border:SetPoint("TOPLEFT", -1, 1)
        Self.Health.Border:SetSize(GetConfiguration()[Self.Frame].HealthBar.Width, GetConfiguration()[Self.Frame].HealthBar.Height)
        Self.Health.Border:SetTexture(0, 0, 0)

        if GetConfiguration()[Self.Frame].HealthBar.Health then
            Self.Health.Health = Self.Health:CreateFontString(nil, "OVERLAY")
            Self.Health.Health.frequentUpdates = true
            Self.Health.Health:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
            Self.Health.Health:SetPoint(GetConfiguration()[Self.Frame].HealthBar.Health.Anchor, GetConfiguration()[Self.Frame].HealthBar.Health.X, GetConfiguration()[Self.Frame].HealthBar.Health.Y)

            if GetConfiguration()[Self.Frame].HealthBar.Health.SmallText then
                Self:Tag(Self.Health.Health, "[SnailUI:SmallHealth]")
            else
                Self:Tag(Self.Health.Health, "[SnailUI:Health]")
            end
        end
    end
end
