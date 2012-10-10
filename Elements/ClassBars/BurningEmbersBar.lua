-- BurningEmbersBar.lua
-- Written by Snail

function HandleBurningEmbersBar(Self)
    local Class = select(2, UnitClass(Self.Frame))
    local Specialization = GetSpecialization()

    if Specialization then
        Specialization = select(2, GetSpecializationInfo(Specialization))
        Specialization = Specialization:gsub("(.)", string.upper)
    end

    if GetConfiguration()[Self.Frame].BurningEmbersBar and (Self.Frame == "Player") and (Class == "WARLOCK") and (Specialization == "DESTRUCTION") then
        Self.WarlockSpecBars = CreateFrame("Frame", nil, Self)
        Self.WarlockSpecBars:SetPoint(GetConfiguration()[Self.Frame].BurningEmbersBar.Anchor, GetConfiguration()[Self.Frame].BurningEmbersBar.X, GetConfiguration()[Self.Frame].BurningEmbersBar.Y)
        Self.WarlockSpecBars:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar.Width - 2, GetConfiguration()[Self.Frame].BurningEmbersBar.Height - 2)

        Self.warlockSpecBarsBackground = Self:CreateTexture(nil, "BACKGROUND")
        Self.warlockSpecBarsBackground:SetPoint("TOPLEFT", Self.WarlockSpecBars)
        Self.warlockSpecBarsBackground:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar.Width - 2, GetConfiguration()[Self.Frame].BurningEmbersBar.Height - 2)

        Self.warlockSpecBarsBorder = Self:CreateTexture(nil, "BACKGROUND")
        Self.warlockSpecBarsBorder:SetPoint("TOPLEFT", Self.WarlockSpecBars, -1, 1)
        Self.warlockSpecBarsBorder:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar.Width, GetConfiguration()[Self.Frame].BurningEmbersBar.Height)
        Self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

        for i = 1, #GetConfiguration()[Self.Frame].BurningEmbersBar do
            Self.WarlockSpecBars[i] = CreateFrame("StatusBar", nil, Self)
            Self.WarlockSpecBars[i]:SetPoint(GetConfiguration()[Self.Frame].BurningEmbersBar[i].Anchor, Self.WarlockSpecBars, GetConfiguration()[Self.Frame].BurningEmbersBar[i].X, GetConfiguration()[Self.Frame].BurningEmbersBar[i].Y)
            Self.WarlockSpecBars[i]:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar[i].Width - 2, GetConfiguration()[Self.Frame].BurningEmbersBar[i].Height - 2)
            Self.WarlockSpecBars[i]:SetStatusBarTexture(Configuration.Texture)

            Self.warlockSpecBarsBorder[i] = Self:CreateTexture(nil, "LOW")
            Self.warlockSpecBarsBorder[i]:SetPoint("TOPLEFT", Self.WarlockSpecBars[i], -1, 1)
            Self.warlockSpecBarsBorder[i]:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar[i].Width, GetConfiguration()[Self.Frame].BurningEmbersBar[i].Height)
            Self.warlockSpecBarsBorder[i]:SetTexture(0, 0, 0)
        end
    end
end
