-- HolyPowerBar.lua
-- Written by Snail

function HandleHolyPowerBar(Self)
    local Class = select(2, UnitClass(Self.Frame))

    if GetConfiguration()[Self.Frame].HolyPowerBar and (Self.Frame == "Player") and (Class == "PALADIN") then
        Self.ClassIcons = Self:CreateTexture(Self, "BACKGROUND")
        Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].HolyPowerBar.Anchor, GetConfiguration()[Self.Frame].HolyPowerBar.X, GetConfiguration()[Self.Frame].HolyPowerBar.Y)
        Self.ClassIcons:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar.Width, GetConfiguration()[Self.Frame].HolyPowerBar.Height)
        Self.ClassIcons:SetTexture(0, 0, 0)

        Self.ClassIcons.Background = Self:CreateTexture(nil, "BACKGROUND")
        Self.ClassIcons.Background:SetPoint("TOPLEFT", Self.ClassIcons, 1, -1)
        Self.ClassIcons.Background:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar.Width - 2, GetConfiguration()[Self.Frame].HolyPowerBar.Height - 2)

        for i = 1, 5 do
            Self.ClassIcons[i] = Self:CreateTexture(Self, "LOW")

            if i <= #GetConfiguration()[Self.Frame].HolyPowerBar then
                Self.ClassIcons[i]:SetPoint(GetConfiguration()[Self.Frame].HolyPowerBar[i].Anchor, Self.ClassIcons, GetConfiguration()[Self.Frame].HolyPowerBar[i].X, GetConfiguration()[Self.Frame].HolyPowerBar[i].Y)
                Self.ClassIcons[i]:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar[i].Width - 2, GetConfiguration()[Self.Frame].HolyPowerBar[i].Height - 2)
                Self.ClassIcons[i]:SetTexture(Configuration.Texture)

                Self.ClassIcons[i].Border = Self:CreateTexture(nil, "LOW")
                Self.ClassIcons[i].Border:SetPoint("TOPLEFT", Self.ClassIcons[i], -1, 1)
                Self.ClassIcons[i].Border:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar[i].Width, GetConfiguration()[Self.Frame].HolyPowerBar[i].Height)
                Self.ClassIcons[i].Border:SetTexture(0, 0, 0)
            end
        end
    end
end
