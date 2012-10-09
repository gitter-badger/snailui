-- CastingBar.lua
-- Written by Snail

function HandleCastingBar(Self)
    if GetConfiguration()[Self.Frame].CastingBar then
        Self.Castbar = CreateFrame("StatusBar", nil, Self)
        Self.Castbar:SetOrientation(GetConfiguration()[Self.Frame].CastingBar.Orientation)
        Self.Castbar:SetPoint(GetConfiguration()[Self.Frame].CastingBar.Anchor, GetConfiguration()[Self.Frame].CastingBar.X, GetConfiguration()[Self.Frame].CastingBar.Y)
        Self.Castbar:SetSize(GetConfiguration()[Self.Frame].CastingBar.Width - 6, GetConfiguration()[Self.Frame].CastingBar.Height - 6)
        Self.Castbar:SetStatusBarTexture(Configuration.Texture)

        Self.Castbar.BackgroundBottom = Self.Castbar:CreateTexture(nil, "LOW")
        Self.Castbar.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
        Self.Castbar.BackgroundBottom:SetSize(GetConfiguration()[Self.Frame].CastingBar.Width - 2, 1)

        Self.Castbar.BackgroundLeft = Self.Castbar:CreateTexture(nil, "LOW")
        Self.Castbar.BackgroundLeft:SetPoint("LEFT", -2, 0)
        Self.Castbar.BackgroundLeft:SetSize(1, GetConfiguration()[Self.Frame].CastingBar.Height - 4)

        Self.Castbar.BackgroundRight = Self.Castbar:CreateTexture(nil, "LOW")
        Self.Castbar.BackgroundRight:SetPoint("RIGHT", 2, 0)
        Self.Castbar.BackgroundRight:SetSize(1, GetConfiguration()[Self.Frame].CastingBar.Height - 4)

        Self.Castbar.BackgroundTop = Self.Castbar:CreateTexture(nil, "LOW")
        Self.Castbar.BackgroundTop:SetPoint("TOP", 0, 2)
        Self.Castbar.BackgroundTop:SetSize(GetConfiguration()[Self.Frame].CastingBar.Width - 2, 1)

        Self.Castbar.Border = Self.Castbar:CreateTexture(nil, "BACKGROUND")
        Self.Castbar.Border:SetPoint("TOPLEFT", -3, 3)
        Self.Castbar.Border:SetSize(GetConfiguration()[Self.Frame].CastingBar.Width, GetConfiguration()[Self.Frame].CastingBar.Height)
        Self.Castbar.Border:SetTexture(0, 0, 0)

        if GetConfiguration()[Self.Frame].CastingBar.Spell then
            if GetConfiguration()[Self.Frame].CastingBar.Spell.Duration then
                Self.Castbar.Time = Self.Castbar:CreateFontString(nil, "OVERLAY")
                Self.Castbar.Time:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                Self.Castbar.Time:SetPoint(GetConfiguration()[Self.Frame].CastingBar.Spell.Duration.Anchor, GetConfiguration()[Self.Frame].CastingBar.Spell.Duration.X, GetConfiguration()[Self.Frame].CastingBar.Spell.Duration.Y)
            end

            if GetConfiguration()[Self.Frame].CastingBar.Spell.Name then
                Self.Castbar.Text = Self.Castbar:CreateFontString(nil, "OVERLAY")
                Self.Castbar.Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                Self.Castbar.Text:SetPoint(GetConfiguration()[Self.Frame].CastingBar.Spell.Name.Anchor, GetConfiguration()[Self.Frame].CastingBar.Spell.Name.X, GetConfiguration()[Self.Frame].CastingBar.Spell.Name.Y)
            end

            if GetConfiguration()[Self.Frame].CastingBar.Spell.Texture then
                Self.Castbar.Icon = Self.Castbar:CreateTexture(nil, "LOW")
                Self.Castbar.Icon:SetPoint(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Anchor, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.X, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Y)
                Self.Castbar.Icon:SetSize(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Width - 6, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Height - 6)
                Self.Castbar.Icon:SetTexCoord(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.TextureCoordinate.Left, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.TextureCoordinate.Right, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.TextureCoordinate.Top, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.TextureCoordinate.Bottom)

                Self.Castbar.IconBackgroundBottom = Self.Castbar:CreateTexture(nil, "LOW")
                Self.Castbar.IconBackgroundBottom:SetPoint("BOTTOM", Self.Castbar.Icon, 0, -2)
                Self.Castbar.IconBackgroundBottom:SetSize(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Width - 2, 1)

                Self.Castbar.IconBackgroundLeft = Self.Castbar:CreateTexture(nil, "LOW")
                Self.Castbar.IconBackgroundLeft:SetPoint("LEFT", Self.Castbar.Icon, -2, 0)
                Self.Castbar.IconBackgroundLeft:SetSize(1, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Height - 4)

                Self.Castbar.IconBackgroundRight = Self.Castbar:CreateTexture(nil, "LOW")
                Self.Castbar.IconBackgroundRight:SetPoint("RIGHT", Self.Castbar.Icon, 2, 0)
                Self.Castbar.IconBackgroundRight:SetSize(1, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Height - 4)

                Self.Castbar.IconBackgroundTop = Self.Castbar:CreateTexture(nil, "LOW")
                Self.Castbar.IconBackgroundTop:SetPoint("TOP", Self.Castbar.Icon, 0, 2)
                Self.Castbar.IconBackgroundTop:SetSize(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Width - 2, 1)

                Self.Castbar.IconBorder = Self.Castbar:CreateTexture(nil, "BACKGROUND")
                Self.Castbar.IconBorder:SetPoint("TOPLEFT", Self.Castbar.Icon, -3, 3)
                Self.Castbar.IconBorder:SetSize(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Width, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Height)
                Self.Castbar.IconBorder:SetTexture(0, 0, 0)
            end
        end
    end
end
