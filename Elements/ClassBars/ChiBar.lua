-- ChiBar.lua
-- Written by Snail

function HandleChiBar(Self)
    local Class = select(2, UnitClass(Self.Frame))

    if GetConfiguration()[Self.Frame].ChiBar and (Self.Frame == "Player") and (Class == "MONK") then
        Self.ClassIcons = Self:CreateTexture(Self, "BACKGROUND")
        Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].ChiBar.Anchor, GetConfiguration()[Self.Frame].ChiBar.X, GetConfiguration()[Self.Frame].ChiBar.Y)
        Self.ClassIcons:SetSize(GetConfiguration()[Self.Frame].ChiBar.Width, GetConfiguration()[Self.Frame].ChiBar.Height)
        Self.ClassIcons:SetTexture(0, 0, 0)

        Self.ClassIcons.Background = Self:CreateTexture(nil, "BACKGROUND")
        Self.ClassIcons.Background:SetPoint("TOPLEFT", Self.ClassIcons, 1, -1)
        Self.ClassIcons.Background:SetSize(GetConfiguration()[Self.Frame].ChiBar.Width - 2, GetConfiguration()[Self.Frame].ChiBar.Height - 2)

        for i = 1, 5 do
            Self.ClassIcons[i] = Self:CreateTexture(Self, "LOW")

            if i <= #GetConfiguration()[Self.Frame].ChiBar then
                Self.ClassIcons[i]:SetPoint(GetConfiguration()[Self.Frame].ChiBar[i].Anchor, Self.ClassIcons, GetConfiguration()[Self.Frame].ChiBar[i].X, GetConfiguration()[Self.Frame].ChiBar[i].Y)
                Self.ClassIcons[i]:SetSize(GetConfiguration()[Self.Frame].ChiBar[i].Width - 2, GetConfiguration()[Self.Frame].ChiBar[i].Height - 2)
                Self.ClassIcons[i]:SetTexture(Configuration.Texture)

                Self.ClassIcons[i].Border = Self:CreateTexture(nil, "LOW")
                Self.ClassIcons[i].Border:SetPoint("TOPLEFT", Self.ClassIcons[i], -1, 1)
                Self.ClassIcons[i].Border:SetSize(GetConfiguration()[Self.Frame].ChiBar[i].Width, GetConfiguration()[Self.Frame].ChiBar[i].Height)
                Self.ClassIcons[i].Border:SetTexture(0, 0, 0)
            end
        end
    end
end
