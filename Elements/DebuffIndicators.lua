-- DebuffIndicators.lua
-- Written by Snail

function HandleDebuffIndicators(Self)
	if (Self.Frame == "Raid") and GetConfiguration().DebuffIndicators then
		local Class = select(2, UnitClass("Player"))
		local Specialization = GetSpecialization()

		if Specialization then
			Specialization = select(2, GetSpecializationInfo(Specialization))
			Specialization = Specialization:gsub("(.)", string.upper)
		end

		local Dispels = {}
		local DispelTypes =
		{
			["DRUID"] =
			{
				"Curse",
				"Poison",

				["RESTORATION"] =
				{
					"Magic"
				}
			},

			["MAGE"] =
			{
				"Curse"
			},

			["MONK"] =
			{
				"Disease",
				"Poison",

				["MISTWEAVER"] =
				{
					"Magic"
				}
			},

			["PALADIN"] =
			{
				"Disease",
				"Poison",

				["HOLY"] =
				{
					"Magic"
				}
			},

			["PRIEST"] =
			{
				["DISCIPLINE"] =
				{
					"Disease",
					"Magic"
				},

				["HOLY"] =
				{
					"Disease",
					"Magic"
				}
			},

			["SHAMAN"] =
			{
				"Curse",

				["RESTORATION"] =
				{
					"Magic"
				}
			}
		}

		if DispelTypes[Class] then			
			if DispelTypes[Class][Specialization] then
				for I = 1, #DispelTypes[Class][Specialization] do
					Dispels[#Dispels + 1] = DispelTypes[Class][Specialization][I]
				end
			end

			for I = 1, #DispelTypes[Class] do
				Dispels[#Dispels + 1] = DispelTypes[Class][I]
			end
		end

		if #Dispels > 0 then
			Self.DebuffIndicators = CreateFrame("Frame", nil, Self)
			Self.DebuffIndicators:Hide()
			Self.DebuffIndicators:RegisterEvent("PLAYER_ENTERING_WORLD")
			Self.DebuffIndicators:RegisterEvent("UNIT_AURA")
			Self.DebuffIndicators:SetFrameLevel(Self:GetFrameLevel() + 2)
			Self.DebuffIndicators:SetPoint("LEFT", 3, 0)
			Self.DebuffIndicators:SetSize(GetConfiguration()[Self.Frame].Height - 6, GetConfiguration()[Self.Frame].Height - 6)
			Self.DebuffIndicators:SetScript("OnEvent",
				function(Self, Event, Unit)
					if not Unit then
						Unit = Self.Parent.unit
					end

					if Unit == Self.Parent.unit then
						local DebuffIcon
						local DebuffName

						for I = 40, 1, -1 do
							DebuffName, _, DebuffIcon, _, DebuffType = UnitDebuff(Self.Parent.unit, I)

							if DebuffName and GetDispel(Self.Dispels, DebuffType) then
								I = 1

								Self.DebuffName = DebuffName
								Self.Icon:SetTexture(DebuffIcon)

								Self:Show()
							end
						end
					end
				end
			)

			Self.DebuffIndicators:SetScript("OnHide",
				function(Self)
					Self:SetScript("OnUpdate", nil)
					Self.Parent.ShowingDebuffIndicators = nil
					Self.Parent.SpellRange.Update(Self.Parent, Self.Parent.InRange)
				end
			)

			Self.DebuffIndicators:SetScript("OnShow",
				function(Self)
					Self.Parent.ShowingDebuffIndicators = true
					Self.Parent.SpellRange.Update(Self.Parent, Self.Parent.InRange)

					Self:SetScript("OnUpdate",
						function(Self, ElapsedTime)
							local DebuffExpires = select(7, UnitDebuff(Self.Parent.unit, Self.DebuffName))

							if DebuffExpires and (DebuffExpires > GetTime()) then
								Self.Text:SetText(math.ceil(DebuffExpires - GetTime()))

								if DebuffCount and (DebuffCount > 1) then
									--
								end
							else
								Self.DebuffName = nil
								Self:Hide()
							end
						end
					)
				end
			)

			Self.DebuffIndicators.Border = Self.DebuffIndicators:CreateTexture(nil, "BACKGROUND")
			Self.DebuffIndicators.Border:SetPoint("TOPLEFT", -1, 1)
			Self.DebuffIndicators.Border:SetSize(GetConfiguration()[Self.Frame].Height - 4, GetConfiguration()[Self.Frame].Height - 4)
			Self.DebuffIndicators.Border:SetTexture(0, 0, 0)

			Self.DebuffIndicators.Dispels = Dispels

			Self.DebuffIndicators.Icon = Self.DebuffIndicators:CreateTexture(nil, "LOW")
			Self.DebuffIndicators.Icon:SetPoint("CENTER")
			Self.DebuffIndicators.Icon:SetTexCoord(GetConfiguration().DebuffIndicators.TextureCoordinate.Left, GetConfiguration().DebuffIndicators.TextureCoordinate.Right, GetConfiguration().DebuffIndicators.TextureCoordinate.Top, GetConfiguration().DebuffIndicators.TextureCoordinate.Bottom)
			Self.DebuffIndicators.Icon:SetSize(GetConfiguration()[Self.Frame].Height - 6, GetConfiguration()[Self.Frame].Height - 6)

			Self.DebuffIndicators.Parent = Self

			Self.DebuffIndicators.Text = Self.DebuffIndicators:CreateFontString(nil, "OVERLAY")
			Self.DebuffIndicators.Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
			Self.DebuffIndicators.Text:SetPoint("CENTER", 1, 0)
		end
	end
end
