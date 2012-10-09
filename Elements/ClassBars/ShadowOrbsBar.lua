-- ShadowOrbsBar.lua
-- Written by Snail

function HandleShadowOrbsBar(Self)
    local Class = select(2, UnitClass(Self.Frame))
    local Specialization = GetSpecialization()

    if Specialization then
        Specialization = select(2, GetSpecializationInfo(Specialization))
        Specialization = Specialization:gsub("(.)", string.upper)
    end

    if GetConfiguration()[Self.Frame].ShadowOrbsBar and (Self.Frame == "Player") and (Class == "PRIEST") and (Specialization == "SHADOW") then
        Self.ClassIcons = Self:CreateTexture(Self, "BACKGROUND")
        Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].ShadowOrbsBar.Anchor, GetConfiguration()[Self.Frame].ShadowOrbsBar.X, GetConfiguration()[Self.Frame].ShadowOrbsBar.Y)
        Self.ClassIcons:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar.Width, GetConfiguration()[Self.Frame].ShadowOrbsBar.Height)
        Self.ClassIcons:SetTexture(0, 0, 0)

        Self.ClassIcons.Background = Self:CreateTexture(nil, "LOW")
        Self.ClassIcons.Background:SetPoint("TOPLEFT", Self.ClassIcons, 1, -1)
        Self.ClassIcons.Background:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar.Width - 2, GetConfiguration()[Self.Frame].ShadowOrbsBar.Height - 2)

        for i = 1, 5 do
            Self.ClassIcons[i] = Self:CreateTexture(Self, "LOW")

            if i <= #GetConfiguration()[Self.Frame].ShadowOrbsBar then
                Self.ClassIcons[i]:SetPoint(GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Anchor, Self.ClassIcons, GetConfiguration()[Self.Frame].ShadowOrbsBar[i].X, GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Y)
                Self.ClassIcons[i]:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Width - 2, GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Height - 2)
                Self.ClassIcons[i]:SetTexture(Configuration.Texture)

                Self.ClassIcons[i].Border = Self:CreateTexture(nil, "LOW")
                Self.ClassIcons[i].Border:SetPoint("TOPLEFT", Self.ClassIcons[i], -1, 1)
                Self.ClassIcons[i].Border:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Width, GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Height)
                Self.ClassIcons[i].Border:SetTexture(0, 0, 0)
            end
        end
    end
end
