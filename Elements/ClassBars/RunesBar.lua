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

		for I = 1, #GetConfiguration()[Self.Frame].RunesBar do
			Self.Runes[I] = CreateFrame("StatusBar", nil, Self)
			Self.Runes[I]:SetPoint(GetConfiguration()[Self.Frame].RunesBar[I].Anchor, Self.Runes, GetConfiguration()[Self.Frame].RunesBar[I].X, GetConfiguration()[Self.Frame].RunesBar[I].Y)
			Self.Runes[I]:SetSize(GetConfiguration()[Self.Frame].RunesBar[I].Width - 2, GetConfiguration()[Self.Frame].RunesBar[I].Height - 2)
			Self.Runes[I]:SetStatusBarTexture(Configuration.Texture)

			Self.Runes[I].Border = Self.Runes:CreateTexture(nil, "LOW")
			Self.Runes[I].Border:SetPoint("TOPLEFT", Self.Runes[I], -1, 1)
			Self.Runes[I].Border:SetSize(GetConfiguration()[Self.Frame].RunesBar[I].Width, GetConfiguration()[Self.Frame].RunesBar[I].Height)
			Self.Runes[I].Border:SetTexture(0, 0, 0)
		end
	end
end
