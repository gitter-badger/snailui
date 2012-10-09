-- ComboPointsBar.lua
-- Written by Snail

function HandleComboPointsBar(Self)
    local Class = select(2, UnitClass(Self.Frame))
    local Specialization = GetSpecialization()

    if Specialization then
        Specialization = select(2, GetSpecializationInfo(Specialization))
        Specialization = Specialization:gsub("(.)", string.upper)
    end

    if GetConfiguration()[Self.Frame].ComboPointsBar and (Self.Frame == "Player") and ((Class == "ROGUE") or ((Class == "DRUID") and (Specialization == "FERAL"))) then
        Self.CPoints = CreateFrame("Frame", nil, Self)
        Self.CPoints:SetPoint(GetConfiguration()[Self.Frame].ComboPointsBar.Anchor, GetConfiguration()[Self.Frame].ComboPointsBar.X, GetConfiguration()[Self.Frame].ComboPointsBar.Y)
        Self.CPoints:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar.Width - 2, GetConfiguration()[Self.Frame].ComboPointsBar.Height - 2)

        Self.CPoints.Background = Self.CPoints:CreateTexture(nil, "BACKGROUND")
        Self.CPoints.Background:SetPoint("TOPLEFT")
        Self.CPoints.Background:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar.Width - 2, GetConfiguration()[Self.Frame].ComboPointsBar.Height - 2)

        Self.CPoints.Border = Self.CPoints:CreateTexture(nil, "BACKGROUND")
        Self.CPoints.Border:SetPoint("TOPLEFT", -1, 1)
        Self.CPoints.Border:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar.Width, GetConfiguration()[Self.Frame].ComboPointsBar.Height)
        Self.CPoints.Border:SetTexture(0, 0, 0)

        for i = 1, #GetConfiguration()[Self.Frame].ComboPointsBar do
            Self.CPoints[i] = CreateFrame("StatusBar", nil, Self)
            Self.CPoints[i]:SetPoint(GetConfiguration()[Self.Frame].ComboPointsBar[i].Anchor, Self.CPoints, GetConfiguration()[Self.Frame].ComboPointsBar[i].X, GetConfiguration()[Self.Frame].ComboPointsBar[i].Y)
            Self.CPoints[i]:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar[i].Width - 2, GetConfiguration()[Self.Frame].ComboPointsBar[i].Height - 2)
            Self.CPoints[i]:SetStatusBarTexture(Configuration.Texture)

            Self.CPoints[i].Border = Self.CPoints:CreateTexture(nil, "LOW")
            Self.CPoints[i].Border:SetPoint("TOPLEFT", Self.CPoints[i], -1, 1)
            Self.CPoints[i].Border:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar[i].Width, GetConfiguration()[Self.Frame].ComboPointsBar[i].Height)
            Self.CPoints[i].Border:SetTexture(0, 0, 0)
        end
    end
end
