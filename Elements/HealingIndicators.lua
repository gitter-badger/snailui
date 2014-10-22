--
-- Copyright (C) 2012-2014 Snailsoft <http://www.snailsoft.me/>
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at your
-- option) any later version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details.
--
-- You should have received a copy of the GNU General Public License along
-- with this program. If not, see <http://www.gnu.org/licenses/>.
--

local _

function HandleHealingIndicators(Self)
	if Self.Frame == "Raid" then
		if not Options.HealingIndicators then
			Options.HealingIndicators = {}
		end

		if not Options.HealingIndicators[UnitGUID("Player")] then
			Options.HealingIndicators[UnitGUID("Player")] = {}
		end

		if #Options.HealingIndicators[UnitGUID("Player")] > 0 then
			Self.HealingIndicators = CreateFrame("Frame", nil, Self)

			Self.HealingIndicators:SetFrameLevel(Self:GetFrameLevel() + 2)
			Self.HealingIndicators:SetPoint("LEFT", 3, 0)

			Self.HealingIndicators.ShownIndicators = 0

			for I = 1, #Options.HealingIndicators[UnitGUID("Player")] do
				Self.HealingIndicators[I] = CreateFrame("Frame", nil, Self.HealingIndicators)
				Self.HealingIndicators[I]:Hide()
				Self.HealingIndicators[I]:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
				Self.HealingIndicators[I]:RegisterEvent("PLAYER_ENTERING_WORLD")
				Self.HealingIndicators[I]:RegisterEvent("UNIT_AURA")
				Self.HealingIndicators[I]:SetSize(GetConfiguration()[Self.Frame].Height - 6, GetConfiguration()[Self.Frame].Height - 6)
				Self.HealingIndicators[I]:SetScript("OnEvent",
					function(Self, Event, Unit, ...)
						local CombatEvent = select(1, ...)

						if ((Event == "COMBAT_LOG_EVENT_UNFILTERED") and CombatEvent and string.find(CombatEvent, "_AURA")) or (Event ~= "COMBAT_LOG_EVENT_UNFILTERED") then
							if not Unit then
								Unit = Self.Parent.unit
							end

							if Unit == Self.Parent.unit then
								local BuffIcon
								local BuffName
								local BuffSource
								local Debuff

								BuffName, _, BuffIcon, _, _, _, _, BuffSource = UnitBuff(Self.Parent.unit, Options.HealingIndicators[UnitGUID("Player")][Self.I], nil, "PLAYER")

								if not BuffName then
									BuffName, _, BuffIcon, _, _, _, _, BuffSource = UnitDebuff(Self.Parent.unit, Options.HealingIndicators[UnitGUID("Player")][Self.I], nil, "PLAYER")
									Debuff = true
								end

								if BuffName and (BuffSource == "player") then
									Self.BuffName = BuffName
									Self.Debuff = Debuff
									Self.Icon:SetTexture(BuffIcon)

									Self:Hide()
									Self:Show()
								end
							end
						end
					end
				)

				Self.HealingIndicators[I].UpdatePoints = function(Self)
					local Count = 1

					if Self.Parent.DebuffIndicators:IsShown() then
						Count = Count + 1
					end

					for J = 1, #Options.HealingIndicators[UnitGUID("Player")] do
						if Self:GetParent()[J].Shown then
							Self:GetParent()[J]:SetPoint("LEFT", ((Count - 1) * (GetConfiguration()[Self.Frame].Height - 6)) + ((Count - 1) * 1), 0)
							Count = Count + 1
						end
					end
				end

				Self.HealingIndicators[I]:SetScript("OnHide",
					function(Self)
						Self:GetParent().ShownIndicators = Self:GetParent().ShownIndicators - 1
						Self:GetParent():SetSize((Self:GetParent().ShownIndicators * (GetConfiguration()[Self.Frame].Height - 6)) + ((Self:GetParent().ShownIndicators - 1) * 1), GetConfiguration()[Self.Frame].Height - 6)

						Self:SetScript("OnUpdate", nil)
						Self.Shown = nil

						Self:UpdatePoints(Self)
					end
				)

				Self.HealingIndicators[I]:SetScript("OnShow",
					function(Self)
						Self:GetParent().ShownIndicators = Self:GetParent().ShownIndicators + 1
						Self:GetParent():SetSize((Self:GetParent().ShownIndicators * (GetConfiguration()[Self.Frame].Height - 6)) + ((Self:GetParent().ShownIndicators - 1) * 1), GetConfiguration()[Self.Frame].Height - 6)

						Self.Shown = true

						Self:UpdatePoints(Self)
						Self:SetScript("OnUpdate",
							function(Self, ElapsedTime)
								local BuffExpires
								local BuffName

								if Self.Debuff then
									BuffName, _, _, _, _, _, BuffExpires = UnitDebuff(Self.Parent.unit, Self.BuffName)
								else
									BuffName, _, _, _, _, _, BuffExpires  = UnitBuff(Self.Parent.unit, Self.BuffName)
								end

								if BuffName then
									if BuffExpires and (BuffExpires > GetTime()) then
										Self.Text:SetText(math.ceil(BuffExpires - GetTime()))
									else
										Self.Text:SetText("")
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
				Self.HealingIndicators[I].Icon:SetTexCoord(0.1, 0.9, 0.1, 0.9)
				Self.HealingIndicators[I].Icon:SetSize(GetConfiguration()[Self.Frame].Height - 6, GetConfiguration()[Self.Frame].Height - 6)

				Self.HealingIndicators[I].Parent = Self

				Self.HealingIndicators[I].Text = Self.HealingIndicators[I]:CreateFontString(nil, "OVERLAY")
				Self.HealingIndicators[I].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				Self.HealingIndicators[I].Text:SetPoint("CENTER", 1, 0)
			end
		end
	end
end
