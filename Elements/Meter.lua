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

local Meter, _

local function RefreshTooltip(Self)
	local APS
	local Unit = Data.Meter.Fights[Data.Meter.Fight][(Self.I - 1) + Data.Meter.Position]

	if (Unit.EndTime - Unit.StartTime) > 0 then
		APS = ShortNumber(math.floor((Unit[Data.Meter.Mode] / (Unit.EndTime - Unit.StartTime)) + 0.05))
	else
		APS = ShortNumber(math.floor(Unit[Data.Meter.Mode] + 0.05))
	end

	GameTooltip_SetDefaultAnchor(GameTooltip, Self)

	if Unit.Realm:len() > 0 then
		GameTooltip:AddDoubleLine(Unit.Name .. "-" .. Unit.Realm .. GetActiveTime(Unit.EndTime - Unit.StartTime), ShortNumber(Unit[Data.Meter.Mode]) .. " (" .. APS .. ")")
	else
		GameTooltip:AddDoubleLine(Unit.Name .. GetActiveTime(Unit.EndTime - Unit.StartTime), ShortNumber(Unit[Data.Meter.Mode]) .. " (" .. APS .. ")")
	end

	for Index, Spell in ipairs(Unit[Data.Meter.Mode .. "Spells"]) do
		if (Unit.EndTime - Unit.StartTime) > 0 then
			APS = ShortNumber(math.floor((Spell.Amount / (Unit.EndTime - Unit.StartTime)) + 0.05))
		else
			APS = ShortNumber(math.floor(Spell.Amount + 0.05))
		end

		GameTooltip:AddDoubleLine(Index .. ". " .. Spell.SpellName, ShortNumber(Spell.Amount) .. " (" .. APS .. ", " .. string.format("%.1f", (Spell.Amount / Unit[Data.Meter.Mode]) * 100) .. "%)", 1, 1, 1, 1, 1, 1)
	end

	GameTooltip:Show()
end

local function RefreshMeter(Self)
	if #Data.Meter.Fights > 0 then
		table.sort(Data.Meter.Fights[Data.Meter.Fight],
			function(A, B)
				if A[Data.Meter.Mode] and B[Data.Meter.Mode] then
					return A[Data.Meter.Mode] > B[Data.Meter.Mode]
				end

				return nil
			end
		)

		for _, Unit in ipairs(Data.Meter.Fights[Data.Meter.Fight]) do
			table.sort(Unit.DamageSpells,
				function(A, B)
					return A.Amount > B.Amount
				end
			)
		end

		for _, Unit in ipairs(Data.Meter.Fights[Data.Meter.Fight]) do
			table.sort(Unit.HealingSpells,
				function(A, B)
					return A.Amount > B.Amount
				end
			)
		end

		local MaxAmount = 0

		for I = 1, #Data.Meter.Fights[Data.Meter.Fight] do
			if Data.Meter.Fights[Data.Meter.Fight][I][Data.Meter.Mode] then
				if Data.Meter.Fights[Data.Meter.Fight][I][Data.Meter.Mode] > MaxAmount then
					MaxAmount = Data.Meter.Fights[Data.Meter.Fight][I][Data.Meter.Mode]
				end
			end
		end

		for I = 1, #Self.Bars do
			if Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position] then
				if Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position][Data.Meter.Mode] then
					if Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position][Data.Meter.Mode] > 0 then
						Self.Bars[I]:SetMinMaxValues(0, MaxAmount)
						Self.Bars[I]:SetValue(Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position][Data.Meter.Mode])
						Self.Bars[I]:Show()

						if Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Hostile then
							Self.Bars[I]:SetStatusBarColor(RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].r / 2, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].g / 2, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].b / 2)
							Self.Bars[I].LeftText:SetTextColor(RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].r / 2, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].g / 2, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].b / 2)
							Self.Bars[I].RightText:SetTextColor(RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].r / 2, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].g / 2, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].b / 2)
						else
							Self.Bars[I]:SetStatusBarColor(RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].r, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].g, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].b)
							Self.Bars[I].LeftText:SetTextColor(RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].r, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].g, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].b)
							Self.Bars[I].RightText:SetTextColor(RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].r, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].g, RAID_CLASS_COLORS[Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Class or "UNKNOWN"].b)
						end

						Self.Bars[I].LeftText:SetText(Trim3(((I - 1) + Data.Meter.Position) .. ". " .. Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].Name))

						if (Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].EndTime - Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].StartTime) > 0 then
							Self.Bars[I].RightText:SetText(ShortNumber(Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position][Data.Meter.Mode]) .. " (" .. ShortNumber(math.floor((Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position][Data.Meter.Mode] / (Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].EndTime - Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position].StartTime)) + 0.05)) .. ")")
						else
							Self.Bars[I].RightText:SetText(ShortNumber(Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position][Data.Meter.Mode]) .. " (" .. ShortNumber(math.floor(Data.Meter.Fights[Data.Meter.Fight][(I - 1) + Data.Meter.Position][Data.Meter.Mode] + 0.05)) .. ")")
						end
					else
						Self.Bars[I]:Hide()
					end
				else
					Self.Bars[I]:Hide()
				end
			else
				Self.Bars[I]:Hide()
			end
		end

		for I = 1, #GetConfiguration().Meter do
			if Meter.Bars[I].Hovering then
				RefreshTooltip(Meter.Bars[I])
			end
		end
	end
end

function HandleMeter()
	if GetConfiguration().Meter then
		local LoginTime = time()

		if not Options.LogoutTime then
			Options.LogoutTime = 0
		end

		if not Data.Meter then
			Data.Meter =
			{
				Absorbs = {},
				Fight = 1,
				InCombat = nil,
				Mode = "Damage",
				Pets = {},
				Position = 1,

				Fights =
				{
					[1] =
					{
						CombatTime = 0,
						TotalDamage = 0,
						TotalHealing = 0
					}
				}
			}
		end

		if (LoginTime - Options.LogoutTime) >= 180 then
			Data.Meter.Absorbs = {}
			Data.Meter.Pets = {}
		end

		local Class = select(2, UnitClass("Player"))

		RAID_CLASS_COLORS["UNKNOWN"] =
		{
			b = 1,
			g = 0,
			r = 1
		}

		Meter = CreateFrame("Frame", nil, UIParent)
		Meter:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		Meter:RegisterEvent("PLAYER_LOGOUT")
		Meter:RegisterEvent("PLAYER_REGEN_DISABLED")
		Meter:RegisterEvent("PLAYER_REGEN_ENABLED")
		Meter:SetPoint(GetConfiguration().Meter.Anchor, GetConfiguration().Meter.X, GetConfiguration().Meter.Y)
		Meter:SetSize(GetConfiguration().Meter.Width - 6, GetConfiguration().Meter.Height - 6)
		Meter:SetScript("OnEvent",
			function(Self, Event, ...)
				if Event == "PLAYER_REGEN_DISABLED" then
					Data.Meter.InCombat = true
					Data.Meter.Position = 1

					for I = 5, 1, -1 do
						if I == 1 then
							Data.Meter.Fights[I] =
							{
								CombatTime = 0,
								TotalDamage = 0,
								TotalHealing = 0
							}
						else
							if Data.Meter.Fights[I - 1] and ((Data.Meter.Fights[I - 1].TotalDamage > 0) or (Data.Meter.Fights[I - 1].TotalHealing > 0)) then
								Data.Meter.Fights[I] = Data.Meter.Fights[I - 1]
							end
						end
					end

					AddPet(Data.Meter.Pets, UnitGUID("Player"), UnitGUID("Pet"))

					if GetNumGroupMembers() > 0 then
						local InRaid = IsInRaid()
						local Frame

						if InRaid then
							Frame = "Raid"
						else
							Frame = "Party"
						end

						for I = 1, GetNumGroupMembers() do
							AddPet(Data.Meter.Pets, UnitGUID(Frame .. I), UnitGUID(Frame .. I .. "Pet"))
						end
					end

					RefreshMeter(Meter)
					Meter:SetScript("OnUpdate",
						function(Self, ElapsedTime)
							if not Self.Time then
								Self.Time = 0
							end

							if (Self.Time + ElapsedTime) >= 1 then
								RefreshMeter(Self)
								Self.Time = 0
							else
								Self.Time = Self.Time + ElapsedTime
							end
						end
					)
				elseif Event == "PLAYER_REGEN_ENABLED" then
					Data.Meter.Fights[1].CombatTime = GetTime()
					Data.Meter.InCombat = nil

					Meter:SetScript("OnUpdate", nil)
					RefreshMeter(Meter)
				elseif Event == "PLAYER_LOGOUT" then
					Options.LogoutTime = time()
				elseif Event == "COMBAT_LOG_EVENT_UNFILTERED" then
					local CombatEvent = select(2, ...)

					if (select(3, ...) == false) then
						if string.find(CombatEvent, "_MISSED") then
							local Amount
							local Flags = select(10, ...)
							local Type

							if string.find(CombatEvent, "SWING") then
								Amount = select(14, ...)
								Type = select(12, ...)
							else
								Amount = select(17, ...)
								Type = select(15, ...)
							end

							if Amount and (Amount > 0) and Data.Meter.InCombat and (Type == "ABSORB") and ((bit.band(Flags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0)) then
								local Class
								local GUID = select(8, ...)
								local IsPet
								local Name
								local Realm
								local Unit

								if (bit.band(Flags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) then
									GUID = GetPetOwner(Data.Meter.Pets, GUID)

									if not GUID then
										GUID = select(8, ...)
										IsPet = true
									end
								end

								Unit = GetUnit(Data.Meter.Fights[1], GUID)

								if not IsPet then
									_, Class, _, _, _, Name, Realm = GetPlayerInfoByGUID(GUID)
								end

								if not Name then
									Name = select(9, ...)
								end

								if not Unit then
									Data.Meter.Fights[1][#Data.Meter.Fights[1] + 1] =
									{
										Class = Class or "UNKNOWN",
										Damage = 0,
										DamageSpells = {},
										EndTime = 0,
										GUID = GUID,
										Healing = 0,
										HealingSpells = {},
										Name = Name or "UNKNOWN",
										Realm = Realm or "",
										StartTime = GetTime()
									}

									Unit = Data.Meter.Fights[1][#Data.Meter.Fights[1]]
								end

								if not Data.Meter.Absorbs then
									Data.Meter.Absorbs = {}
								end

								if Data.Meter.Absorbs[GUID] then
									for _, Info in pairs(Data.Meter.Absorbs[GUID]) do
										local SpellName = select(1, GetSpellInfo(Info.Spell))

										for I = 1, 40 do
											local BuffName, _, _, _, _, _, _, BuffCasterUnit, _, _, _, _, _, _, BuffAmount = UnitBuff(Name, I)

											if BuffName and BuffCasterUnit then
												local BuffCasterGUID = UnitGUID(BuffCasterUnit)
												local SourceGUID = Info.SourceGUID

												if BuffAmount and BuffCasterGUID and (BuffCasterGUID == SourceGUID) and (BuffName == SpellName) and (Info.Amount ~= BuffAmount) then
													local IsPet
													
													if (bit.band(Info.SourceFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(Info.SourceFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) then
														SourceGUID = GetPetOwner(Data.Meter.Pets, SourceGUID)

														if not GUID then
															SourceGUID = Info.SourceGUID
															IsPet = true
														end
													end

													local SourceUnit = GetUnit(Data.Meter.Fights[1], SourceGUID)

													if not SourceUnit then
														local SourceClass
														local SourceName
														local SourceRealm

														if not IsPet then
															_, SourceClass, _, _, _, SourceName, SourceRealm = GetPlayerInfoByGUID(SourceGUID)
														end

														if not SourceName then
															SourceName = Info.SourceName
														end

														Data.Meter.Fights[1][#Data.Meter.Fights[1] + 1] =
														{
															Class = SourceClass or "UNKNOWN",
															Damage = 0,
															DamageSpells = {},
															EndTime = 0,
															GUID = SourceGUID,
															Healing = 0,
															HealingSpells = {},
															Name = SourceName or "UNKNOWN",
															Realm = SourceRealm or "",
															StartTime = GetTime()
														}

														SourceUnit = Data.Meter.Fights[1][#Data.Meter.Fights[1]]
													end

													local Spell = GetSpell(SourceUnit.HealingSpells, SpellName)

													if Spell then
														Spell.Amount = Spell.Amount + (Info.Amount - BuffAmount)
													else
														SourceUnit.HealingSpells[#SourceUnit.HealingSpells + 1] =
														{
															Amount = Info.Amount - BuffAmount,
															SpellName = SpellName
														}
													end

													SourceUnit.Healing = SourceUnit.Healing + math.floor(Info.Amount - BuffAmount)
													Data.Meter.Fights[1].TotalHealing = Data.Meter.Fights[1].TotalHealing + math.floor(Info.Amount - BuffAmount)
													Info.Amount = BuffAmount

													if Data.Meter.InCombat then
														SourceUnit.EndTime = GetTime()
													else
														if SourceUnit.EndTime == 0 then
															SourceUnit.EndTime = Data.Meter.Fights[1].CombatTime
														end
													end
												end
											end
										end
									end
								end
							end
						elseif (CombatEvent == "DAMAGE_SHIELD") or (CombatEvent == "DAMAGE_SPLIT") or string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") or string.find(CombatEvent, "_DAMAGE") or string.find(CombatEvent, "_DRAIN") or string.find(CombatEvent, "_EXTRA_ATTACKS") or string.find(CombatEvent, "_HEAL") or string.find(CombatEvent, "_LEECH") then
							local Flags
							local Unit

							if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") then
								Flags = select(10, ...)
							else
								Flags = select(6, ...)
							end

							if (Data.Meter.InCombat or ((string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED")))) and ((bit.band(Flags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PLAYER) ~= 0)) then
								local Class
								local GUID
								local IsPet
								local Name
								local Realm

								if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") then
									GUID = select(8, ...)
								else
									GUID = select(4, ...)
								end

								if (bit.band(Flags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(Flags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) then
									GUID = GetPetOwner(Data.Meter.Pets, GUID)

									if not GUID then
										if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") then
											GUID = select(8, ...)
										else
											GUID = select(4, ...)
										end

										IsPet = true
									end
								end

								local Amount
								local Spell
								local SpellName

								if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") then
									Amount = select(16, ...)

									if Amount and (select(15, ...) == "BUFF") then
										if not Data.Meter.Absorbs then
											Data.Meter.Absorbs = {}
										end

										local SpellID = select(12, ...)
										local SourceFlags = select(6, ...)
										local SourceGUID = select(4, ...)
										local SourceName = select(5, ...)

										if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") then
											local Absorb = GetAbsorb(Data.Meter.Absorbs, GUID, SpellID, SourceGUID)

											if Absorb then
												Absorb.Amount = Amount
												Absorb.SourceFlags = SourceFlags
												Absorb.SourceName = SourceName
											else
												Data.Meter.Absorbs[GUID][#Data.Meter.Absorbs[GUID] + 1] =
												{
													Amount = Amount,
													SourceFlags = SourceFlags,
													SourceGUID = SourceGUID,
													SourceName = SourceName,
													Spell = SpellID
												}
											end
										elseif string.find(CombatEvent, "_AURA_REMOVED") then
											local Absorb, AbsorbIndex = GetAbsorb(Data.Meter.Absorbs, GUID, SpellID, SourceGUID)

											if Absorb then
												if Absorb.Amount > Amount then
													local SourceClass
													local SourceIsPet
													local SourceRealm

													if (bit.band(SourceFlags, COMBATLOG_OBJECT_TYPE_GUARDIAN) ~= 0) or (bit.band(SourceFlags, COMBATLOG_OBJECT_TYPE_PET) ~= 0) then
														SourceGUID = GetPetOwner(Data.Meter.Pets, SourceGUID)

														if not SourceGUID then
															SourceGUID = select(4, ...)
															SourceIsPet = true
														end
													end

													local SourceUnit = GetUnit(Data.Meter.Fights[1], SourceGUID)

													if not SourceUnit then
														if not SourceIsPet then
															_, SourceClass, _, _, _, SourceName, SourceRealm = GetPlayerInfoByGUID(SourceGUID)
														end

														if not SourceName then
															SourceName = select(5, ...)
														end

														Data.Meter.Fights[1][#Data.Meter.Fights[1] + 1] =
														{
															Class = SourceClass or "UNKNOWN",
															Damage = 0,
															DamageSpells = {},
															EndTime = 0,
															GUID = SourceGUID,
															Healing = 0,
															HealingSpells = {},
															Name = SourceName or "UNKNOWN",
															Realm = SourceRealm or "",
															StartTime = GetTime()
														}

														SourceUnit = Data.Meter.Fights[1][#Data.Meter.Fights[1]]
													end

													if Data.Meter.InCombat then
														SourceUnit.EndTime = GetTime()
													else
														if SourceUnit.EndTime == 0 then
															SourceUnit.EndTime = Data.Meter.Fights[1].CombatTime
														end
													end

													SpellName = select(13, ...)
													Spell = GetSpell(SourceUnit.HealingSpells, SpellName)

													if Spell then
														Spell.Amount = Spell.Amount + (Absorb.Amount - Amount)
													else
														SourceUnit.HealingSpells[#SourceUnit.HealingSpells + 1] =
														{
															Amount = Absorb.Amount - Amount,
															SpellName = SpellName
														}
													end

													SourceUnit.Healing = SourceUnit.Healing + math.floor(Absorb.Amount - Amount)
													Data.Meter.Fights[1].TotalHealing = Data.Meter.Fights[1].TotalHealing + math.floor(Absorb.Amount - Amount)

													if not Data.Meter.InCombat then
														RefreshMeter(Meter)
													end
												end

												Data.Meter.Absorbs[GUID][AbsorbIndex] = nil

												table.sort(Data.Meter.Absorbs[GUID],
													function(A, B)
														if A and B then
															return A.Amount > B.Amount
														end

														return nil
													end
												)

												if #Data.Meter.Absorbs[GUID] == 0 then
													Data.Meter.Absorbs[GUID] = nil
												end
											end
										end
									end
								elseif Data.Meter.InCombat then
									Unit = GetUnit(Data.Meter.Fights[1], GUID)

									if not Unit then
										if not IsPet then
											_, Class, _, _, _, Name, Realm = GetPlayerInfoByGUID(GUID)
										end

										if not Name then
											if string.find(CombatEvent, "_AURA_APPLIED") or string.find(CombatEvent, "_AURA_REFRESH") or string.find(CombatEvent, "_AURA_REMOVED") then
												Name = select(9, ...)
											else
												Name = select(5, ...)
											end
										end

										Data.Meter.Fights[1][#Data.Meter.Fights[1] + 1] =
										{
											Class = Class or "UNKNOWN",
											Damage = 0,
											DamageSpells = {},
											EndTime = 0,
											GUID = GUID,
											Healing = 0,
											HealingSpells = {},
											Name = Name or "UNKNOWN",
											Realm = Realm or "",
											StartTime = GetTime()
										}

										Unit = Data.Meter.Fights[1][#Data.Meter.Fights[1]]
									end

									Unit.EndTime = GetTime()

									if bit.band(Flags, COMBATLOG_OBJECT_REACTION_HOSTILE) ~= 0 then
										Unit.Hostile = true
									else
										Unit.Hostile = nil
									end

									SpellName = (select(13, ...) or "Unknown")

									if SpellName ~= "Soul Link" then
										if string.find(CombatEvent, "_HEAL") then
											Amount = ((select(15, ...) or 0) + (select(17, ...) or 0)) - (select(16, ...) or 0)
											Spell = GetSpell(Unit.HealingSpells, SpellName)

											if Spell then
												Spell.Amount = Spell.Amount + Amount
											else
												Unit.HealingSpells[#Unit.HealingSpells + 1] =
												{
													Amount = Amount,
													SpellName = SpellName
												}
											end

											Unit.Healing = Unit.Healing + Amount
											Data.Meter.Fights[1].TotalHealing = Data.Meter.Fights[1].TotalHealing + Amount
										else
											if string.find(CombatEvent, "SWING") then
												Amount = (select(12, ...) or 0)
												SpellName = "Melee"
											else
												Amount = (select(15, ...) or 0)
												SpellName = (select(13, ...) or "Unknown")

												if string.find(SpellName, " Off%-Hand") then
													SpellName = string.sub(SpellName, 1, string.find(SpellName, " Off%-Hand") - 1)
												end

												if string.find(SpellName, " Off%-hand") then
													SpellName = string.sub(SpellName, 1, string.find(SpellName, " Off%-hand") - 1)
												end

												if string.find(CombatEvent, "_DRAIN") or string.find(CombatEvent, "_LEECH") then
													if select(16, ...) ~= -2 then
														Amount = 0
													end
												end
											end

											Spell = GetSpell(Unit.DamageSpells, SpellName)

											if Spell then
												Spell.Amount = Spell.Amount + Amount
											else
												Unit.DamageSpells[#Unit.DamageSpells + 1] =
												{
													Amount = Amount,
													SpellName = SpellName
												}
											end

											Unit.Damage = Unit.Damage + Amount
											Data.Meter.Fights[1].TotalDamage = Data.Meter.Fights[1].TotalDamage + Amount
										end
									end
								end
							end
						elseif string.find(CombatEvent, "_SUMMON") then
							AddPet(Data.Meter.Pets, select(4, ...), select(8, ...))
						end
					end
				end
			end
		)

		Meter:SetScript("OnMouseWheel",
			function(Self, Direction)
				if Direction > 0 then
					if Data.Meter.Position > 1 then
						Data.Meter.Position = Data.Meter.Position - 1
						RefreshMeter(Self)
					end
				else
					if Data.Meter.Position < (GetCount(Data.Meter.Fights[Data.Meter.Fight], Data.Meter.Mode) - (#Self.Bars - 1)) then
						Data.Meter.Position = Data.Meter.Position + 1
						RefreshMeter(Self)
					end
				end
			end
		)

		Meter.BackgroundBottom = Meter:CreateTexture(nil, "LOW")
		Meter.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
		Meter.BackgroundBottom:SetSize(GetConfiguration().Meter.Width - 2, 1)
		Meter.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		Meter.BackgroundLeft = Meter:CreateTexture(nil, "LOW")
		Meter.BackgroundLeft:SetPoint("LEFT", -2, 0)
		Meter.BackgroundLeft:SetSize(1, GetConfiguration().Meter.Height - 4)
		Meter.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		Meter.BackgroundRight = Meter:CreateTexture(nil, "LOW")
		Meter.BackgroundRight:SetPoint("RIGHT", 2, 0)
		Meter.BackgroundRight:SetSize(1, GetConfiguration().Meter.Height - 4)
		Meter.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		Meter.BackgroundTop = Meter:CreateTexture(nil, "LOW")
		Meter.BackgroundTop:SetPoint("TOP", 0, 2)
		Meter.BackgroundTop:SetSize(GetConfiguration().Meter.Width - 2, 1)
		Meter.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		Meter.BorderBottom = Meter:CreateTexture(nil, "BACKGROUND")
		Meter.BorderBottom:SetPoint("BOTTOM", 0, -3)
		Meter.BorderBottom:SetSize(GetConfiguration().Meter.Width, 3)
		Meter.BorderBottom:SetTexture(0, 0, 0)

		Meter.BorderLeft = Meter:CreateTexture(nil, "BACKGROUND")
		Meter.BorderLeft:SetPoint("LEFT", -3, 0)
		Meter.BorderLeft:SetSize(3, GetConfiguration().Meter.Height - 2)
		Meter.BorderLeft:SetTexture(0, 0, 0)

		Meter.BorderRight = Meter:CreateTexture(nil, "BACKGROUND")
		Meter.BorderRight:SetPoint("RIGHT", 3, 0)
		Meter.BorderRight:SetSize(3, GetConfiguration().Meter.Height - 2)
		Meter.BorderRight:SetTexture(0, 0, 0)

		Meter.BorderTop = Meter:CreateTexture(nil, "BACKGROUND")
		Meter.BorderTop:SetPoint("TOP", 0, 3)
		Meter.BorderTop:SetSize(GetConfiguration().Meter.Width, 3)
		Meter.BorderTop:SetTexture(0, 0, 0)

		Meter.TransparentBackground = Meter:CreateTexture(nil, "BACKGROUND")
		Meter.TransparentBackground:SetPoint("CENTER")
		Meter.TransparentBackground:SetSize(GetConfiguration().Meter.Width - 6, GetConfiguration().Meter.Height - 6)
		Meter.TransparentBackground:SetTexture(0, 0, 0, 0.5)

		local Bars = CreateFrame("Frame", nil, Meter)
		Meter.Bars = Bars

		for I = 0, #GetConfiguration().Meter do
			if I == 0 then
				Bars[I] = CreateFrame("Frame", nil, Meter)

				Bars[I].LeftText = Bars[I]:CreateFontString(nil, "OVERLAY")
				Bars[I].LeftText:Hide()
				Bars[I].LeftText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				Bars[I].LeftText:SetJustifyH("LEFT")
				Bars[I].LeftText:SetPoint("LEFT", 5, 0)
				Bars[I].LeftText:SetText("<")
				Bars[I].LeftText:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				Bars[I].LeftTextButton = CreateFrame("Button", nil, Bars[I])
				Bars[I].LeftTextButton:RegisterForClicks("AnyUp")
				Bars[I].LeftTextButton:SetAllPoints(Bars[I].LeftText)
				Bars[I].LeftTextButton:SetScript("OnClick",
					function(Self)
						if Data.Meter.Mode == "Healing" then
							Data.Meter.Mode = "Damage"
							Data.Meter.Position = 1

							local Bar = Self:GetParent()

							Bar.LeftText:Hide()
							Bar.LeftTextButton:Hide()

							Bar.RightText:Show()
							Bar.RightTextButton:Show()

							Bar.Text:SetText((Data.Meter.Fight > 1) and Data.Meter.Mode .. " (" .. Data.Meter.Fight .. ")" or Data.Meter.Mode)
							RefreshMeter(Bar:GetParent())
						end
					end
				)

				Bars[I].RightText = Bars[I]:CreateFontString(nil, "OVERLAY")
				Bars[I].RightText:Hide()
				Bars[I].RightText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				Bars[I].RightText:SetJustifyH("RIGHT")
				Bars[I].RightText:SetPoint("RIGHT", -2, 0)
				Bars[I].RightText:SetText(">")
				Bars[I].RightText:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				Bars[I].RightTextButton = CreateFrame("Button", nil, Bars[I])
				Bars[I].RightTextButton:RegisterForClicks("AnyUp")
				Bars[I].RightTextButton:SetAllPoints(Bars[I].RightText)
				Bars[I].RightTextButton:SetScript("OnClick",
					function(Self)
						if Data.Meter.Mode == "Damage" then
							Data.Meter.Mode = "Healing"
							Data.Meter.Position = 1

							local Bar = Self:GetParent()

							Bar.LeftText:Show()
							Bar.LeftTextButton:Show()

							Bar.RightText:Hide()
							Bar.RightTextButton:Hide()

							Bar.Text:SetText((Data.Meter.Fight > 1) and Data.Meter.Mode .. " (" .. Data.Meter.Fight .. ")" or Data.Meter.Mode)
							RefreshMeter(Bar:GetParent())
						end
					end
				)

				Bars[I].Text = Bars[I]:CreateFontString(nil, "OVERLAY")
				Bars[I].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				Bars[I].Text:SetPoint("CENTER", 1, 0)
				Bars[I].Text:SetText((Data.Meter.Fight > 1) and Data.Meter.Mode .. " (" .. Data.Meter.Fight .. ")" or Data.Meter.Mode)
				Bars[I].Text:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				Bars[I].TextButton = CreateFrame("Button", nil, Bars[I])
				Bars[I].TextButton:RegisterForClicks("AnyUp")
				Bars[I].TextButton:SetAllPoints(Bars[I].Text)
				Bars[I].TextButton:SetScript("OnClick",
					function(Self)
						if GetCount(Data.Meter.Fights[Data.Meter.Fight], Data.Meter.Mode) > 0 then
							local Type

							if GetNumGroupMembers() > 0 then
								if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
									Type = "INSTANCE_CHAT"
								elseif IsInRaid() then
									if UnitInBattleground("Player") then
										Type = "BATTLEGROUND"
									else
										Type = "RAID"
									end
								else
									Type = "PARTY"
								end
							end

							SendChatMessage("SnailUI / " .. Data.Meter.Mode, Type)
							local Count = GetCount(Data.Meter.Fights[Data.Meter.Fight], Data.Meter.Mode)

							if Count > 10 then
								Count = 10
							end

							for I = 1, Count do
								local APS

								if (Data.Meter.Fights[Data.Meter.Fight][I].EndTime - Data.Meter.Fights[Data.Meter.Fight][I].StartTime) > 0 then
									APS = ShortNumber(math.floor((Data.Meter.Fights[Data.Meter.Fight][I][Data.Meter.Mode] / (Data.Meter.Fights[Data.Meter.Fight][I].EndTime - Data.Meter.Fights[Data.Meter.Fight][I].StartTime)) + 0.05))
								else
									APS = ShortNumber(math.floor(Data.Meter.Fights[Data.Meter.Fight][I][Data.Meter.Mode] + 0.05))
								end

								if Data.Meter.Fights[Data.Meter.Fight][I].Realm:len() > 0 then
									SendChatMessage(I .. ". " .. Data.Meter.Fights[Data.Meter.Fight][I].Name .. "-" .. Data.Meter.Fights[Data.Meter.Fight][I].Realm .. " " .. ShortNumber(Data.Meter.Fights[Data.Meter.Fight][I][Data.Meter.Mode]) .. " (" .. APS .. ")", Type)
								else
									SendChatMessage(I .. ". " .. Data.Meter.Fights[Data.Meter.Fight][I].Name .. " " .. ShortNumber(Data.Meter.Fights[Data.Meter.Fight][I][Data.Meter.Mode]) .. " (" .. APS .. ")", Type)
								end
							end
						end
					end
				)

				Bars[I].TextButton:SetScript("OnMouseWheel",
					function(Self, Direction)
						local Bar = Self:GetParent()

						if Direction > 0 then
							if Data.Meter.Fight > 1 then
								Data.Meter.Fight = Data.Meter.Fight - 1
								Bar.Text:SetText((Data.Meter.Fight > 1) and Data.Meter.Mode .. " (" .. Data.Meter.Fight .. ")" or Data.Meter.Mode)
								RefreshMeter(Bar:GetParent())
							end
						else
							if Data.Meter.Fight < #Data.Meter.Fights then
								Data.Meter.Fight = Data.Meter.Fight + 1
								Bar.Text:SetText((Data.Meter.Fight > 1) and Data.Meter.Mode .. " (" .. Data.Meter.Fight .. ")" or Data.Meter.Mode)
								RefreshMeter(Bar:GetParent())
							end
						end
					end
				)

				if Data.Meter.Mode == "Damage" then
					Bars[I].RightText:Show()
				elseif Data.Meter.Mode == "Healing" then
					Bars[I].LeftText:Show()
				end
			else
				Bars[I] = CreateFrame("StatusBar", nil, Meter)
				Bars[I]:Hide()
				Bars[I]:SetStatusBarTexture(Configuration.Texture)
				Bars[I]:SetScript("OnEnter",
					function(Self)
						Self.Hovering = true
						RefreshTooltip(Self)
					end
				)

				Bars[I]:SetScript("OnLeave",
					function(Self)
						Self.Hovering = nil
						GameTooltip:Hide(Self)
					end
				)

				Bars[I].I = I

				Bars[I].LeftText = Bars[I]:CreateFontString(nil, "OVERLAY")
				Bars[I].LeftText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				Bars[I].LeftText:SetJustifyH("LEFT")
				Bars[I].LeftText:SetPoint("LEFT", 5, 0)

				Bars[I].RightText = Bars[I]:CreateFontString(nil, "OVERLAY")
				Bars[I].RightText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				Bars[I].RightText:SetJustifyH("RIGHT")
				Bars[I].RightText:SetPoint("RIGHT", -2, 0)
			end

			Bars[I]:SetFrameLevel(Meter:GetFrameLevel())
			Bars[I]:SetSize(GetConfiguration().Meter[I].Width - 6, GetConfiguration().Meter[I].Height - 6)

			if I == 0 then
				Bars[I]:SetPoint("TOP")
			end

			Bars[I].BackgroundBottom = Bars[I]:CreateTexture(nil, "LOW")
			Bars[I].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
			Bars[I].BackgroundBottom:SetSize(GetConfiguration().Meter[I].Width - 2, 1)
			Bars[I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Bars[I].BackgroundLeft = Bars[I]:CreateTexture(nil, "LOW")
			Bars[I].BackgroundLeft:SetPoint("LEFT", -2, 0)
			Bars[I].BackgroundLeft:SetSize(1, GetConfiguration().Meter[I].Height - 4)
			Bars[I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Bars[I].BackgroundRight = Bars[I]:CreateTexture(nil, "LOW")
			Bars[I].BackgroundRight:SetPoint("RIGHT", 2, 0)
			Bars[I].BackgroundRight:SetSize(1, GetConfiguration().Meter[I].Height - 4)
			Bars[I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Bars[I].BackgroundTop = Bars[I]:CreateTexture(nil, "LOW")
			Bars[I].BackgroundTop:SetPoint("TOP", 0, 2)
			Bars[I].BackgroundTop:SetSize(GetConfiguration().Meter[I].Width - 2, 1)
			Bars[I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Bars[I].BorderBottom = Bars[I]:CreateTexture(nil, "BACKGROUND")
			Bars[I].BorderBottom:SetPoint("BOTTOM", 0, -1)
			Bars[I].BorderBottom:SetSize(GetConfiguration().Meter[I].Width, 1)
			Bars[I].BorderBottom:SetTexture(0, 0, 0)

			Bars[I].BorderBottom2 = Bars[I]:CreateTexture(nil, "BACKGROUND")
			Bars[I].BorderBottom2:SetPoint("BOTTOM", 0, -3)
			Bars[I].BorderBottom2:SetSize(GetConfiguration().Meter[I].Width, 1)
			Bars[I].BorderBottom2:SetTexture(0, 0, 0)

			Bars[I].BorderLeft = Bars[I]:CreateTexture(nil, "BACKGROUND")
			Bars[I].BorderLeft:SetPoint("LEFT", -1, 0)
			Bars[I].BorderLeft:SetSize(1, GetConfiguration().Meter[I].Height - 2)
			Bars[I].BorderLeft:SetTexture(0, 0, 0)

			Bars[I].BorderRight = Bars[I]:CreateTexture(nil, "BACKGROUND")
			Bars[I].BorderRight:SetPoint("RIGHT", 1, 0)
			Bars[I].BorderRight:SetSize(1, GetConfiguration().Meter[I].Height - 2)
			Bars[I].BorderRight:SetTexture(0, 0, 0)

			Bars[I].BorderTop = Bars[I]:CreateTexture(nil, "BACKGROUND")
			Bars[I].BorderTop:SetPoint("TOP", 0, 1)
			Bars[I].BorderTop:SetSize(GetConfiguration().Meter[I].Width, 1)
			Bars[I].BorderTop:SetTexture(0, 0, 0)
		end

		for I = #GetConfiguration().Meter, 1, -1 do
			Bars[I]:SetPoint("BOTTOM", 0, ((#GetConfiguration().Meter - I) * GetConfiguration().Meter[I].Height) - ((#GetConfiguration().Meter - I) * 3))
		end

		RefreshMeter(Meter)
	end
end
