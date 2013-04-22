-- HealingIndicators.lua
-- Written by Snail

function HandleHealingIndicators(Self)
	if (Self.Frame == "Raid") and GetConfiguration().HealingIndicators then
		local Class = select(2, UnitClass("Player"))
		local Specialization = GetSpecialization()

		if Specialization then
			Specialization = select(2, GetSpecializationInfo(Specialization))
			Specialization = Specialization:gsub("(.)", string.upper)
		end

		local HealingIndicators = {}

		if GetConfiguration().HealingIndicators[Class] then
			if GetConfiguration().HealingIndicators[Class][Specialization] then
				for I = 1, #GetConfiguration().HealingIndicators[Class][Specialization] do
					HealingIndicators[#HealingIndicators + 1] = GetConfiguration().HealingIndicators[Class][Specialization][I]
				end
			end

			for I = 1, #GetConfiguration().HealingIndicators[Class] do
				HealingIndicators[#HealingIndicators + 1] = GetConfiguration().HealingIndicators[Class][I]
			end
		end

		if #HealingIndicators > 0 then
			Self.HealingIndicators = CreateFrame("Frame", nil, Self)

			if Self.DebuffIndicators then
				Self.DebuffIndicators:SetPoint("LEFT", Self.HealingIndicators, "RIGHT", 1, 0)
			end

			Self.HealingIndicators:SetFrameLevel(Self:GetFrameLevel() + 2)
			Self.HealingIndicators:SetPoint("LEFT", 3, 0)

			Self.HealingIndicators.ShownIndicators = 0

			for I = 1, #HealingIndicators do
				Self.HealingIndicators[I] = CreateFrame("Frame", nil, Self.HealingIndicators)
				Self.HealingIndicators[I]:Hide()
				Self.HealingIndicators[I]:RegisterEvent("PLAYER_ENTERING_WORLD")
				Self.HealingIndicators[I]:RegisterEvent("UNIT_AURA")
				Self.HealingIndicators[I]:SetSize(GetConfiguration()[Self.Frame].Height - 6, GetConfiguration()[Self.Frame].Height - 6)
				Self.HealingIndicators[I]:SetScript("OnEvent",
					function(Self, Event, Unit)
						if not Unit then
							Unit = Self.Parent.unit
						end

						if Unit == Self.Parent.unit then
							local BuffIcon
							local BuffName
							local Debuff

							BuffName, _, BuffIcon = UnitBuff(Self.Parent.unit, HealingIndicators[Self.I], nil, "PLAYER")

							if not BuffName then
								BuffName, _, BuffIcon = UnitDebuff(Self.Parent.unit, HealingIndicators[Self.I])
								Debuff = true
							end

							if BuffName then
								Self.BuffName = BuffName
								Self.Debuff = Debuff
								Self.Icon:SetTexture(BuffIcon)

								Self:Show()
							end
						end
					end
				)

				Self.HealingIndicators[I]:SetScript("OnHide",
					function(Self)
						Self:GetParent().ShownIndicators = Self:GetParent().ShownIndicators - 1
						Self:GetParent():SetSize((Self:GetParent().ShownIndicators * (GetConfiguration()[Self.Frame].Height - 6)) + ((Self:GetParent().ShownIndicators - 1) * 1), GetConfiguration()[Self.Frame].Height - 6)

						Self:SetScript("OnUpdate", nil)
						Self.Shown = nil

						local Count = 1

						for J = 1, #HealingIndicators do
							if Self:GetParent()[J].Shown then
								Self:GetParent()[J]:SetPoint("LEFT", ((Count - 1) * (GetConfiguration()[Self.Frame].Height - 6)) + ((Count - 1) * 1), 0)
								Count = Count + 1
							end
						end
					end
				)

				Self.HealingIndicators[I]:SetScript("OnShow",
					function(Self)
						Self:GetParent().ShownIndicators = Self:GetParent().ShownIndicators + 1
						Self:GetParent():SetSize((Self:GetParent().ShownIndicators * (GetConfiguration()[Self.Frame].Height - 6)) + ((Self:GetParent().ShownIndicators - 1) * 1), GetConfiguration()[Self.Frame].Height - 6)
						Self.Shown = true

						local Count = 1

						for J = 1, #HealingIndicators do
							if Self:GetParent()[J].Shown then
								Self:GetParent()[J]:SetPoint("LEFT", ((Count - 1) * (GetConfiguration()[Self.Frame].Height - 6)) + ((Count - 1) * 1), 0)
								Count = Count + 1
							end
						end

						Self:SetScript("OnUpdate",
							function(Self, ElapsedTime)
								local BuffExpires

								if Self.Debuff then
									BuffExpires = select(7, UnitDebuff(Self.Parent.unit, Self.BuffName))
								else
									BuffExpires = select(7, UnitBuff(Self.Parent.unit, Self.BuffName))
								end

								if BuffExpires and (BuffExpires > GetTime()) then
									Self.Text:SetText(math.ceil(BuffExpires - GetTime()))

									if BuffCount and (BuffCount > 1) then
										--
									end
								else
									Self.BuffName = nil
									Self.Debuff = nil
									Self:Hide()
								end
							end
						)
					end
				)

				Self.HealingIndicators[I].Border = Self.HealingIndicators[I]:CreateTexture(nil, "BACKGROUND")
				Self.HealingIndicators[I].Border:SetPoint("TOPLEFT", -1, 1)
				Self.HealingIndicators[I].Border:SetSize(GetConfiguration()[Self.Frame].Height - 4, GetConfiguration()[Self.Frame].Height - 4)
				Self.HealingIndicators[I].Border:SetTexture(0, 0, 0)

				Self.HealingIndicators[I].Frame = Self.Frame
				Self.HealingIndicators[I].I = I

				Self.HealingIndicators[I].Icon = Self.HealingIndicators[I]:CreateTexture(nil, "LOW")
				Self.HealingIndicators[I].Icon:SetPoint("CENTER")
				Self.HealingIndicators[I].Icon:SetTexCoord(GetConfiguration().HealingIndicators.TextureCoordinate.Left, GetConfiguration().HealingIndicators.TextureCoordinate.Right, GetConfiguration().HealingIndicators.TextureCoordinate.Top, GetConfiguration().HealingIndicators.TextureCoordinate.Bottom)
				Self.HealingIndicators[I].Icon:SetSize(GetConfiguration()[Self.Frame].Height - 6, GetConfiguration()[Self.Frame].Height - 6)

				Self.HealingIndicators[I].Parent = Self

				Self.HealingIndicators[I].Text = Self.HealingIndicators[I]:CreateFontString(nil, "OVERLAY")
				Self.HealingIndicators[I].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				Self.HealingIndicators[I].Text:SetPoint("CENTER", 1, 0)
			end
		end
	end
end
