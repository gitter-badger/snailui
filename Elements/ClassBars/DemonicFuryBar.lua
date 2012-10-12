-- DemonicFuryBar.lua
-- Written by Snail

function HandleDemonicFuryBar(Self)
    local Class = select(2, UnitClass(Self.Frame))
    local Specialization = GetSpecialization()

    if Specialization then
        Specialization = select(2, GetSpecializationInfo(Specialization))
        Specialization = Specialization:gsub("(.)", string.upper)
    end

    if GetConfiguration()[Self.Frame].DemonicFuryBar and (Self.Frame == "Player") and (Class == "WARLOCK") and (Specialization == "DEMONOLOGY") then
        Self.WarlockSpecBars = CreateFrame("Frame", nil, Self)
        Self.WarlockSpecBars:SetPoint(GetConfiguration()[Self.Frame].DemonicFuryBar.Anchor, GetConfiguration()[Self.Frame].DemonicFuryBar.X, GetConfiguration()[Self.Frame].DemonicFuryBar.Y)
        Self.WarlockSpecBars:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar.Width - 2, GetConfiguration()[Self.Frame].DemonicFuryBar.Height - 2)

        Self.warlockSpecBarsBackground = Self:CreateTexture(nil, "BACKGROUND")
        Self.warlockSpecBarsBackground:SetPoint("TOPLEFT", Self.WarlockSpecBars)
        Self.warlockSpecBarsBackground:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar.Width - 2, GetConfiguration()[Self.Frame].DemonicFuryBar.Height - 2)

        Self.warlockSpecBarsBorder = Self:CreateTexture(nil, "BACKGROUND")
        Self.warlockSpecBarsBorder:SetPoint("TOPLEFT", Self.WarlockSpecBars, -1, 1)
        Self.warlockSpecBarsBorder:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar.Width, GetConfiguration()[Self.Frame].DemonicFuryBar.Height)
        Self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

        for I = 1, #GetConfiguration()[Self.Frame].DemonicFuryBar do
            Self.WarlockSpecBars[I] = CreateFrame("StatusBar", nil, Self)
            Self.WarlockSpecBars[I]:SetPoint(GetConfiguration()[Self.Frame].DemonicFuryBar[I].Anchor, Self.WarlockSpecBars, GetConfiguration()[Self.Frame].DemonicFuryBar[I].X, GetConfiguration()[Self.Frame].DemonicFuryBar[I].Y)
            Self.WarlockSpecBars[I]:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar[I].Width - 2, GetConfiguration()[Self.Frame].DemonicFuryBar[I].Height - 2)
            Self.WarlockSpecBars[I]:SetStatusBarTexture(Configuration.Texture)

            Self.warlockSpecBarsBorder[I] = Self:CreateTexture(nil, "LOW")
            Self.warlockSpecBarsBorder[I]:SetPoint("TOPLEFT", Self.WarlockSpecBars[I], -1, 1)
            Self.warlockSpecBarsBorder[I]:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar[I].Width, GetConfiguration()[Self.Frame].DemonicFuryBar[I].Height)
            Self.warlockSpecBarsBorder[I]:SetTexture(0, 0, 0)
        end
    end
end
