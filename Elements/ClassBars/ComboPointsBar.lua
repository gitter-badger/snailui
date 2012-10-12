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

        for I = 1, #GetConfiguration()[Self.Frame].ComboPointsBar do
            Self.CPoints[I] = CreateFrame("StatusBar", nil, Self)
            Self.CPoints[I]:SetPoint(GetConfiguration()[Self.Frame].ComboPointsBar[I].Anchor, Self.CPoints, GetConfiguration()[Self.Frame].ComboPointsBar[I].X, GetConfiguration()[Self.Frame].ComboPointsBar[I].Y)
            Self.CPoints[I]:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar[I].Width - 2, GetConfiguration()[Self.Frame].ComboPointsBar[I].Height - 2)
            Self.CPoints[I]:SetStatusBarTexture(Configuration.Texture)

            Self.CPoints[I].Border = Self.CPoints:CreateTexture(nil, "LOW")
            Self.CPoints[I].Border:SetPoint("TOPLEFT", Self.CPoints[I], -1, 1)
            Self.CPoints[I].Border:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar[I].Width, GetConfiguration()[Self.Frame].ComboPointsBar[I].Height)
            Self.CPoints[I].Border:SetTexture(0, 0, 0)
        end
    end
end
