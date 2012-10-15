-- Colors.lua
-- Written by Snail

function HandleColors(Self)
    Self.PostUpdate = function(Self)
        local Class = select(2, UnitClass(Self.unit))
        
        if UnitClass(Self.unit) then
            Self.ClassColor = RAID_CLASS_COLORS[Class]
        else
            Self.ClassColor =
            {
                b = 1,
                g = 1,
                r = 1
            }
        end

        Self.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

        if UnitThreatSituation(Self.unit) and ((Self.Frame == "Raid") or EnableThreatColorsOnAllFrames) then
            if UnitThreatSituation(Self.unit) > 0 then
                Self.ThreatColor =
                {
                    b = 0,
                    g = 0,
                    r = 0
                }

                Self.ThreatColor.r, Self.ThreatColor.g, Self.ThreatColor.b = GetThreatStatusColor(UnitThreatSituation(Self.unit))
                Self.Background:SetTexture(Self.ThreatColor.r, Self.ThreatColor.g, Self.ThreatColor.b)
            end
        end

        if Self.Castbar then
            Self.Castbar:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            Self.Castbar.BackgroundBottom:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            Self.Castbar.BackgroundLeft:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            Self.Castbar.BackgroundRight:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            Self.Castbar.BackgroundTop:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

            if Self.Castbar.IconBackgroundBottom then
                Self.Castbar.IconBackgroundBottom:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                Self.Castbar.IconBackgroundLeft:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                Self.Castbar.IconBackgroundRight:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                Self.Castbar.IconBackgroundTop:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            end

            if Self.Castbar.Text then
                Self.Castbar.Text:SetTextColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            end

            if Self.Castbar.Time then
                Self.Castbar.Time:SetTextColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            end
        end

        if Self.ClassIcons then
            Self.ClassIcons.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

            for I = 1, #Self.ClassIcons do
                Self.ClassIcons[I]:SetVertexColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            end
        end

        if Self.CPoints then
            Self.CPoints.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

            for I = 1, #Self.CPoints do
                Self.CPoints[I]:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            end
        end

        if Self.EclipseBar then
            Self.EclipseBar.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
        end

        if Self.Health then
            Self.Health:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

            if Self.HealPrediction.myBar then
                Self.HealPrediction.myBar:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            end

            if Self.HealPrediction.otherBar then
                Self.HealPrediction.otherBar:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            end

            if Self.Health.Health then
                Self.Health.Health:SetTextColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            end
        end

        if Self.Power then
            Self.Power:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

            if Self.Power.BackgroundBottom then
                Self.Power.BackgroundBottom:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                Self.Power.BackgroundLeft:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                Self.Power.BackgroundRight:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                Self.Power.BackgroundTop:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            end
        end

        if Self.Runes then
            Self.Runes.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
        end

        if Self.WarlockSpecBars then
            Self.warlockSpecBarsBackground:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

            for I = 1, #Self.WarlockSpecBars do
                Self.WarlockSpecBars[I]:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
            end
        end
    end
end
