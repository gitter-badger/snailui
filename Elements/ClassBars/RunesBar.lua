-- RunesBar.lua
-- Written by Snail

function HandleRunesBar(Self)
    local Class = select(2, UnitClass(Self.Frame))

    if GetConfiguration()[Self.Frame].RunesBar and (Self.Frame == "Player") and (Class == "DEATHKNIGHT") then
        Self.Runes = CreateFrame("Frame", nil, Self)
        Self.Runes:SetPoint(GetConfiguration()[Self.Frame].RunesBar.Anchor, GetConfiguration()[Self.Frame].RunesBar.X, GetConfiguration()[Self.Frame].RunesBar.Y)
        Self.Runes:SetSize(GetConfiguration()[Self.Frame].RunesBar.Width - 2, GetConfiguration()[Self.Frame].RunesBar.Height - 2)

        Self.Runes.Background = Self.Runes:CreateTexture(nil, "BACKGROUND")
        Self.Runes.Background:SetPoint("TOPLEFT")
        Self.Runes.Background:SetSize(GetConfiguration()[Self.Frame].RunesBar.Width - 2, GetConfiguration()[Self.Frame].RunesBar.Height - 2)

        Self.Runes.Border = Self.Runes:CreateTexture(nil, "BACKGROUND")
        Self.Runes.Border:SetPoint("TOPLEFT", -1, 1)
        Self.Runes.Border:SetSize(GetConfiguration()[Self.Frame].RunesBar.Width, GetConfiguration()[Self.Frame].RunesBar.Height)
        Self.Runes.Border:SetTexture(0, 0, 0)

        for i = 1, #GetConfiguration()[Self.Frame].RunesBar do
            Self.Runes[i] = CreateFrame("StatusBar", nil, Self)
            Self.Runes[i]:SetPoint(GetConfiguration()[Self.Frame].RunesBar[i].Anchor, Self.Runes, GetConfiguration()[Self.Frame].RunesBar[i].X, GetConfiguration()[Self.Frame].RunesBar[i].Y)
            Self.Runes[i]:SetSize(GetConfiguration()[Self.Frame].RunesBar[i].Width - 2, GetConfiguration()[Self.Frame].RunesBar[i].Height - 2)
            Self.Runes[i]:SetStatusBarTexture(Configuration.Texture)

            Self.Runes[i].Border = Self.Runes:CreateTexture(nil, "LOW")
            Self.Runes[i].Border:SetPoint("TOPLEFT", Self.Runes[i], -1, 1)
            Self.Runes[i].Border:SetSize(GetConfiguration()[Self.Frame].RunesBar[i].Width, GetConfiguration()[Self.Frame].RunesBar[i].Height)
            Self.Runes[i].Border:SetTexture(0, 0, 0)
        end
    end
end
