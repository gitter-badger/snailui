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

local function SortTimers(Timers)
	local FocusTimer = Focus and Timers.Parent.Timers.ShowOnFocus

	table.sort(Timers.Timers,
		function(A, B)
			if Timers.Parent[A] and Timers.Parent[B] then
				if FocusTimer then
					return Timers.Parent[A].Timer.Priority > Timers.Parent[B].Timer.Priority
				end

				return Timers.Parent[A].Timer.Priority < Timers.Parent[B].Timer.Priority
			end

			return nil
		end
	)

	Timers.CurrentTimer = 1

	for I = 1, #Timers.Timers do
		if Timers.Parent[Timers.Timers[I]]:IsShown() then
			if Raid and Timers.Parent.Timers.AnchorToRaid then
				Timers.Parent[Timers.Timers[I]]:SetPoint(Timers.Parent.Timers.Anchor, Raid, Timers.Parent.Timers.Anchor, Timers.Parent.Timers.X, Timers.Parent.Timers.Y + (Timers.Parent.Timers.Height * (Timers.CurrentTimer - 2)) + ((Timers.CurrentTimer - 1) * 4))
			elseif FocusTimer then
				Timers.Parent[Timers.Timers[I]]:SetPoint(Timers.Parent.Timers.Anchor, Focus, Timers.Parent.Timers.Anchor, Timers.Parent.Timers.X, Timers.Parent.Timers.Y - (Timers.Parent.Timers.Height * (Timers.CurrentTimer - 1)) - ((Timers.CurrentTimer - 1) * 4))
			else
				Timers.Parent[Timers.Timers[I]]:SetPoint(Timers.Parent.Timers.Anchor, Timers.Parent.Timers.X, Timers.Parent.Timers.Y + (Timers.Parent.Timers.Height * (Timers.CurrentTimer - 1)) + ((Timers.CurrentTimer - 1) * 4))
			end

			Timers.CurrentTimer = Timers.CurrentTimer + 1
		end
	end
end

local function CreateTimers(TimerBars)
	local Class = select(2, UnitClass("Player"))

	TimerBars.Timers = Options.Timers[UnitGUID("Player")]

	for I = 1, #Options.Timers[UnitGUID("Player")] do
		TimerBars[I] = CreateFrame("StatusBar", nil, UIParent)
		TimerBars[I]:Hide()
		TimerBars[I]:RegisterEvent("PLAYER_ENTERING_WORLD")
		TimerBars[I]:RegisterEvent("PLAYER_FOCUS_CHANGED")
		TimerBars[I]:RegisterEvent("PLAYER_TARGET_CHANGED")
		TimerBars[I]:RegisterEvent("SPELL_UPDATE_COOLDOWN")
		TimerBars[I]:RegisterEvent("UNIT_AURA")

		TimerBars[I]:SetSize(Options.Timers[UnitGUID("Player")].Width - 6, Options.Timers[UnitGUID("Player")].Height - 6)
		TimerBars[I]:SetStatusBarTexture(Configuration.Texture)
		TimerBars[I]:SetStatusBarColor(Options.Timers[UnitGUID("Player")][I].Color.R, Options.Timers[UnitGUID("Player")][I].Color.G, Options.Timers[UnitGUID("Player")][I].Color.B)
		TimerBars[I]:SetScript("OnEvent",
			function(Self, Event, Unit)
				if not Self.Timer.Unit then
					Self.Timer.Unit = "Player"
				end

				if Unit then
					Unit = Unit:gsub("(.)", string.upper, 1)
				else
					if Event == "PLAYER_FOCUS_CHANGED" then
						Unit = "Focus"
					elseif Event == "PLAYER_TARGET_CHANGED" then
						Unit = "Target"
					else
						Unit = "Player"
					end
				end

				if Unit == Self.Timer.Unit then
					if Self.Timer.Type == "Buff" then
						if UnitBuff(Unit, Self.Timer.Spell, nil, "PLAYER") then
							Self:Show()
						end
					elseif Self.Timer.Type == "Cooldown" then
						local Start, Duration = GetSpellCooldown(Self.Timer.Spell)

						if Duration and (Duration > 2) then
							Self:Show()
						end
					elseif Self.Timer.Type == "Debuff" then
						if UnitDebuff(Unit, Self.Timer.Spell, nil, "PLAYER") then
							Self:Show()
						end
					end
				end
			end
		)

		TimerBars[I]:SetScript("OnHide",
			function(Self)
				Self:SetScript("OnUpdate", nil)
			end
		)

		TimerBars[I]:SetScript("OnShow",
			function(Self)
				Self:SetScript("OnUpdate",
					function(Self, ElapsedTime)
						local SpellAmount
						local SpellCount
						local SpellDuration
						local SpellExpires
						local SpellIcon
						local SpellName

						if Self.Timer.Type == "Buff" then
							SpellName, _, SpellIcon, SpellCount, _, SpellDuration, SpellExpires, _, _, _, _, _, _, _, SpellAmount = UnitBuff(Self.Timer.Unit, Self.Timer.Spell, nil, "PLAYER")
						elseif Self.Timer.Type == "Cooldown" then
							SpellExpires, SpellDuration, Enabled = GetSpellCooldown(Self.Timer.Spell)

							if SpellDuration and (SpellDuration > 2) then
								SpellName, _, SpellIcon = GetSpellInfo(Self.Timer.Spell)
								SpellExpires = SpellExpires + SpellDuration
							end
						elseif Self.Timer.Type == "Debuff" then
							SpellName, _, SpellIcon, SpellCount, _, SpellDuration, SpellExpires, _, _, _, _, _, _, _, SpellAmount = UnitDebuff(Self.Timer.Unit, Self.Timer.Spell, nil, "PLAYER")
						end

						if SpellName then
							if SpellDuration > 0 then
								Self:SetMinMaxValues(0, SpellDuration)
								Self:SetValue(SpellExpires - GetTime())

								Self.Time:SetText(math.ceil(SpellExpires - GetTime()))
							else
								Self:SetMinMaxValues(0, 1)
								Self:SetValue(1)

								Self.Time:SetText(nil)
							end

							Self.Icon:SetTexture(SpellIcon)

							if SpellCount and (SpellCount > 1) then
								Self.Text:SetText(SpellName .. ": " .. SpellCount)
							elseif Self.Timer.ShowAmount then
								Self.Text:SetText(SpellName .. ": " .. SpellAmount)
							else
								Self.Text:SetText(SpellName)
							end
						else
							Self:Hide()
						end

						SortTimers(Self)
					end
				)
			end
		)

		TimerBars[I].BackgroundBottom = TimerBars[I]:CreateTexture(nil, "LOW")
		TimerBars[I].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
		TimerBars[I].BackgroundBottom:SetSize(Options.Timers[UnitGUID("Player")].Width - 2, 1)
		TimerBars[I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		TimerBars[I].BackgroundLeft = TimerBars[I]:CreateTexture(nil, "LOW")
		TimerBars[I].BackgroundLeft:SetPoint("LEFT", -2, 0)
		TimerBars[I].BackgroundLeft:SetSize(1, Options.Timers[UnitGUID("Player")].Height - 4)
		TimerBars[I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		TimerBars[I].BackgroundRight = TimerBars[I]:CreateTexture(nil, "LOW")
		TimerBars[I].BackgroundRight:SetPoint("RIGHT", 2, 0)
		TimerBars[I].BackgroundRight:SetSize(1, Options.Timers[UnitGUID("Player")].Height - 4)
		TimerBars[I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		TimerBars[I].BackgroundTop = TimerBars[I]:CreateTexture(nil, "LOW")
		TimerBars[I].BackgroundTop:SetPoint("TOP", 0, 2)
		TimerBars[I].BackgroundTop:SetSize(Options.Timers[UnitGUID("Player")].Width - 2, 1)
		TimerBars[I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		TimerBars[I].Border = TimerBars[I]:CreateTexture(nil, "BACKGROUND")
		TimerBars[I].Border:SetPoint("TOPLEFT", -3, 3)
		TimerBars[I].Border:SetSize(Options.Timers[UnitGUID("Player")].Width, Options.Timers[UnitGUID("Player")].Height)
		TimerBars[I].Border:SetTexture(0, 0, 0)

		TimerBars[I].Icon = TimerBars[I]:CreateTexture(nil, "LOW")
		TimerBars[I].Icon:SetPoint("LEFT", -(Options.Timers[UnitGUID("Player")].Height * 2) - 4, 0)
		TimerBars[I].Icon:SetSize((Options.Timers[UnitGUID("Player")].Height * 2) - 6, Options.Timers[UnitGUID("Player")].Height - 6)
		TimerBars[I].Icon:SetTexCoord(0.1, 0.9, 0.3, 0.7)

		TimerBars[I].IconBackgroundBottom = TimerBars[I]:CreateTexture(nil, "LOW")
		TimerBars[I].IconBackgroundBottom:SetPoint("BOTTOM", TimerBars[I].Icon, 0, -2)
		TimerBars[I].IconBackgroundBottom:SetSize((Options.Timers[UnitGUID("Player")].Height * 2) - 2, 1)
		TimerBars[I].IconBackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		TimerBars[I].IconBackgroundLeft = TimerBars[I]:CreateTexture(nil, "LOW")
		TimerBars[I].IconBackgroundLeft:SetPoint("LEFT", TimerBars[I].Icon, -2, 0)
		TimerBars[I].IconBackgroundLeft:SetSize(1, Options.Timers[UnitGUID("Player")].Height - 4)
		TimerBars[I].IconBackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		TimerBars[I].IconBackgroundRight = TimerBars[I]:CreateTexture(nil, "LOW")
		TimerBars[I].IconBackgroundRight:SetPoint("RIGHT", TimerBars[I].Icon, 2, 0)
		TimerBars[I].IconBackgroundRight:SetSize(1, Options.Timers[UnitGUID("Player")].Height - 4)
		TimerBars[I].IconBackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		TimerBars[I].IconBackgroundTop = TimerBars[I]:CreateTexture(nil, "LOW")
		TimerBars[I].IconBackgroundTop:SetPoint("TOP", TimerBars[I].Icon, 0, 2)
		TimerBars[I].IconBackgroundTop:SetSize((Options.Timers[UnitGUID("Player")].Height * 2) - 2, 1)
		TimerBars[I].IconBackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		TimerBars[I].IconBorder = TimerBars[I]:CreateTexture(nil, "BACKGROUND")
		TimerBars[I].IconBorder:SetPoint("TOPLEFT", TimerBars[I].Icon, -3, 3)
		TimerBars[I].IconBorder:SetSize(Options.Timers[UnitGUID("Player")].Height * 2, Options.Timers[UnitGUID("Player")].Height)
		TimerBars[I].IconBorder:SetTexture(0, 0, 0)

		TimerBars[I].Parent = TimerBars

		TimerBars[I].Text = TimerBars[I]:CreateFontString(nil, "OVERLAY")
		TimerBars[I].Text:SetJustifyH("LEFT")
		TimerBars[I].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
		TimerBars[I].Text:SetPoint("LEFT", 6, 0)
		TimerBars[I].Text:SetTextColor(Options.Timers[UnitGUID("Player")][I].Color.R, Options.Timers[UnitGUID("Player")][I].Color.G, Options.Timers[UnitGUID("Player")][I].Color.B)

		TimerBars[I].Time = TimerBars[I]:CreateFontString(nil, "OVERLAY")
		TimerBars[I].Time:SetJustifyH("RIGHT")
		TimerBars[I].Time:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
		TimerBars[I].Time:SetPoint("RIGHT", -4, 0)
		TimerBars[I].Time:SetTextColor(Options.Timers[UnitGUID("Player")][I].Color.R, Options.Timers[UnitGUID("Player")][I].Color.G, Options.Timers[UnitGUID("Player")][I].Color.B)

		TimerBars[I].Timer = Options.Timers[UnitGUID("Player")][I]
		TimerBars[I].Timers = {}

		for J = 1, #Options.Timers[UnitGUID("Player")] do
			TimerBars[I].Timers[#TimerBars[I].Timers + 1] = J
		end
	end
end

function HandleTimers()
	if not Options.Timers then
		Options.Timers = {}
	end
	
	if not Options.Timers[UnitGUID("Player")] then
		Options.Timers[UnitGUID("Player")] =
		{
			Anchor = "BOTTOM",
			Height = 24,
			Width = 464,
			X = 26,
			Y = 242
		}
	end

	local FocusTimers = {}

	if Focus and Options.Timers[UnitGUID("Player")] then
		FocusTimers.Anchor = "BOTTOMRIGHT"
		FocusTimers.Height = Options.Timers[UnitGUID("Player")].Height
		FocusTimers.ShowOnFocus = true
		FocusTimers.Width = GetConfiguration().Focus.Width - 52
		FocusTimers.X = -3
		FocusTimers.Y = -(GetConfiguration().Focus.Height + 1)

		for I = 1, #Options.Timers[UnitGUID("Player")] do
			if Options.Timers[UnitGUID("Player")][I].ShowOnFocus then
				FocusTimers[#FocusTimers + 1] = DeepCopy(Options.Timers[UnitGUID("Player")][I])
				FocusTimers[#FocusTimers].Unit = "Focus"
			end
		end
	end

	if Focus and (#FocusTimers > 0) then
		local FocusTimerBars = CreateFrame("Frame", nil, UIParent)
		
		CreateTimers(FocusTimerBars, FocusTimers)
	end

	if #Options.Timers[UnitGUID("Player")] > 0 then
		local TimerBars = CreateFrame("Frame", nil, UIParent)
		
		CreateTimers(TimerBars)
	end
end
