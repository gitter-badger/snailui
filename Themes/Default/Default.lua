-- Default.lua
-- Written by Snail

local FocusX = math.floor(GetScreenWidth() / 4)

Configuration.Themes.Default = 
{
	ActionBars =
	{
		Player =
		{
			Anchor = "BOTTOM",
			Buttons = 10,
			Height = 24,
			Width = 48,
			X = 0,
			Y = 127,

			TextureCoordinate =
			{
				Bottom = 0.7,
				Left = 0.1,
				Right = 0.9,
				Top = 0.3
			}
		},

		Player2 =
		{
			Anchor = "BOTTOM",
			Buttons = 10,
			Height = 24,
			Width = 48,
			X = 0,
			Y = 155,

			TextureCoordinate =
			{
				Bottom = 0.7,
				Left = 0.1,
				Right = 0.9,
				Top = 0.3
			}
		},

		Player3 =
		{
			Anchor = "RIGHT",
			Buttons = 12,
			Height = 32,
			Orientation = "VERTICAL",
			UIParent = true,
			Width = 32,
			X = -4,
			Y = 0,

			TextureCoordinate =
			{
				Bottom = 0.9,
				Left = 0.1,
				Right = 0.9,
				Top = 0.1
			}
		},

		Player4 =
		{
			Anchor = "RIGHT",
			Buttons = 12,
			Height = 32,
			Orientation = "VERTICAL",
			UIParent = true,
			Width = 32,
			X = -40,
			Y = 0,

			TextureCoordinate =
			{
				Bottom = 0.9,
				Left = 0.1,
				Right = 0.9,
				Top = 0.1
			}
		}
	},

	Bag =
	{
		Anchor = "BOTTOMRIGHT",
		Columns = 8,
		Height = 24,
		Width = 48,
		X = -5,
		Y = 5,

		TextureCoordinate =
		{
			Bottom = 0.7,
			Left = 0.1,
			Right = 0.9,
			Top = 0.3
		}
	},

	Bank =
	{
		Anchor = "BOTTOMLEFT",
		Columns = 8,
		Height = 24,
		Width = 48,
		X = 5,
		Y = 5,

		TextureCoordinate =
		{
			Bottom = 0.7,
			Left = 0.1,
			Right = 0.9,
			Top = 0.3
		}
	},

	Buffs =
	{
		Anchor = "RIGHT",
		Height = 32,
		Orientation = "VERTICAL",
		Width = 32,
		X = -76,
		Y = 0,

		TextureCoordinate =
		{
			Bottom = 0.9,
			Left = 0.1,
			Right = 0.9,
			Top = 0.1
		}
	},

	Chat =
	{
		Anchor = "BOTTOM",
		Height = 119,
		Width = 256,
		X = -130,
		Y = 9
	},

	DebuffIndicators =
	{
		TextureCoordinate =
		{
			Bottom = 0.9,
			Left = 0.1,
			Right = 0.9,
			Top = 0.1
		}
	},

	ExperienceBar =
	{
		Anchor = "TOP",
		Height = 8,
		Width = 204,
		X = 0,
		Y = -28
	},

	ExtraButton =
	{
		Anchor = "TOP",
		Height = 24,
		HoverToShow = true,
		Width = 204,
		X = 0,
		Y = -6
	},

	Focus =
	{
		Anchor = "LEFT",
		Height = 24,
		Width = 256,
		X = FocusX,
		Y = 0,

		CastingBar =
		{
			Anchor = "TOPLEFT",
			Height = 24,
			Orientation = "HORIZONTAL",
			Width = 204,
			X = 55,
			Y = 25,

			Spell =
			{
				Duration =
				{
					Anchor = "RIGHT",
					X = -4,
					Y = 0
				},

				Name =
				{
					Anchor = "LEFT",
					X = 6,
					Y = 0
				},

				Texture =
				{
					Anchor = "LEFT",
					Height = 24,
					Width = 48,
					X = -52,
					Y = 0,

					TextureCoordinate =
					{
						Bottom = 0.7,
						Left = 0.1,
						Right = 0.9,
						Top = 0.3
					}
				}
			}
		},

		HealthBar =
		{
			Anchor = "TOP",
			Height = 15,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = -3,

			Health =
			{
				Anchor ="CENTER",
				X = 1,
				Y = 0
			}
		},

		PowerBar =
		{
			Anchor = "BOTTOM",
			Height = 4,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = 3
		}
	},

	Initialize = function(Self)
		Configuration.Themes.Default["DEATHKNIGHT"] = DefaultWithClassBar
		Configuration.Themes.Default["DEATHKNIGHT"]["UNHOLY"] = DefaultWithClassBarWithPet
		Configuration.Themes.Default["DRUID"] = Configuration.Themes.Default
		Configuration.Themes.Default["DRUID"]["BALANCE"] = DefaultWithClassBar
		Configuration.Themes.Default["DRUID"]["FERAL"] = DefaultWithClassBar
		Configuration.Themes.Default["DRUID"]["RESTORATION"] = DefaultHealer
		Configuration.Themes.Default["HUNTER"] = DefaultWithClassBarWithPet
		Configuration.Themes.Default["MAGE"] = Configuration.Themes.Default
		Configuration.Themes.Default["MAGE"]["FROST"] = DefaultWithPet
		Configuration.Themes.Default["MONK"] = DefaultWithClassBar
		Configuration.Themes.Default["MONK"]["MISTWEAVER"] = DefaultHealerWithClassBar
		Configuration.Themes.Default["PALADIN"] = DefaultWithClassBar
		Configuration.Themes.Default["PALADIN"]["HOLY"] = DefaultHealerWithClassBar
		Configuration.Themes.Default["PRIEST"] = DefaultHealer
		Configuration.Themes.Default["PRIEST"]["SHADOW"] = DefaultWithClassBar
		Configuration.Themes.Default["ROGUE"] = DefaultWithClassBar
		Configuration.Themes.Default["SHAMAN"] = Configuration.Themes.Default
		Configuration.Themes.Default["SHAMAN"]["RESTORATION"] = DefaultHealer
		Configuration.Themes.Default["WARLOCK"] = DefaultWithPet
		Configuration.Themes.Default["WARLOCK"]["AFFLICTION"] = DefaultWithClassBarWithPet
		Configuration.Themes.Default["WARLOCK"]["DEMONOLOGY"] = DefaultWithClassBarWithPet
		Configuration.Themes.Default["WARLOCK"]["DESTRUCTION"] = DefaultWithClassBarWithPet
		Configuration.Themes.Default["WARRIOR"] = DefaultWithClassBar

		local Class = select(2, UnitClass("Player"))

		if Class == "WARLOCK" then
			local _, _, _, _, Selected = GetTalentInfo(15)

			if Selected == true then
				Configuration.Themes.Default["WARLOCK"] = DefaultWithClassBar
			end
		end

		local Specialization = GetSpecialization()

		if Specialization then
			Specialization = select(2, GetSpecializationInfo(Specialization))
			Specialization = Specialization:gsub("(.)", string.upper)
		end

		local Timers = {}

		if GetConfiguration().Timers[Class] then
			Timers.Anchor = GetConfiguration().Timers[Class].Anchor
			Timers.Height = GetConfiguration().Timers[Class].Height
			Timers.Width = GetConfiguration().Timers[Class].Width
			Timers.X = GetConfiguration().Timers[Class].X
			Timers.Y = GetConfiguration().Timers[Class].Y
			
			if GetConfiguration().Timers[Class].AnchorToRaid then
				Timers.AnchorToRaid = GetConfiguration().Timers[Class].AnchorToRaid
			end

			if GetConfiguration().Timers[Class][Specialization] then
				if GetConfiguration().Timers[Class][Specialization].Anchor then
					Timers.Anchor = GetConfiguration().Timers[Class][Specialization].Anchor
				end

				if GetConfiguration().Timers[Class][Specialization].Height then
					Timers.Height = GetConfiguration().Timers[Class][Specialization].Height
				end

				if GetConfiguration().Timers[Class][Specialization].Width then
					Timers.Width = GetConfiguration().Timers[Class][Specialization].Width
				end

				if GetConfiguration().Timers[Class][Specialization].X then
					Timers.X = GetConfiguration().Timers[Class][Specialization].X
				end

				if GetConfiguration().Timers[Class][Specialization].Y then
					Timers.Y = GetConfiguration().Timers[Class][Specialization].Y
				end

				if GetConfiguration().Timers[Class][Specialization].AnchorToRaid then
					Timers.AnchorToRaid = GetConfiguration().Timers[Class][Specialization].AnchorToRaid
				end
				
				for I = 1, #GetConfiguration().Timers[Class][Specialization] do
					Timers[#Timers + 1] = GetConfiguration().Timers[Class][Specialization][I]
				end
			end

			for I = 1, #GetConfiguration().Timers[Class] do
				Timers[#Timers + 1] = GetConfiguration().Timers[Class][I]
			end
		end

		if (Class == "DEATHKNIGHT") and (Specialization == "UNHOLY") then
			if #Timers > 0 then
				GetConfiguration().Timers[Class].Y = GetConfiguration().Timers[Class].Y + 28
			end
		elseif Class == "MONK" then
			local _, _, _, _, Selected = GetTalentInfo(8)

			if Selected == true then
				GetConfiguration().Player.ChiBar = GetConfiguration().Player.ChiBar2
			end
		elseif Class == "PALADIN" then
			local Level = UnitLevel("Player")

			if Level and (Level >= 85) then
				GetConfiguration().Player.HolyPowerBar = GetConfiguration().Player.HolyPowerBar2
			end
		elseif Class == "WARLOCK" then
			local _, _, _, _, Selected = GetTalentInfo(15)

			if Selected == true then
				if #Timers > 0 then
					GetConfiguration().Timers[Class].Y = GetConfiguration().Timers[Class].Y - 28
				end
			end

			if (#Timers > 0) and IsSpellKnown(101508) then
				for I = 1, #Timers do
					if Timers[I].Spell == "Backdraft" then
						Timers[I].Color =
						{
							B = 57 / 255,
							G = 241 / 255,
							R = 127 / 255
						}
					elseif Timers[I].Spell == "Conflagrate" then
						Timers[I].Color =
						{
							B = 10 / 255,
							G = 221 / 255,
							R = 153 / 255
						}
					elseif Timers[I].Spell == "Immolate" then
						Timers[I].Color =
						{
							B = 63 / 255,
							G = 1,
							R = 204 / 255
						}
					elseif Timers[I].Spell == "Molten Core" then
						Timers[I].Color =
						{
							B = 22 / 255,
							G = 231 / 255,
							R = 217 / 255
						}
					elseif Timers[I].Spell == "Rain of Fire" then
						Timers[I].Color =
						{
							B = 13 / 255,
							G = 182 / 255,
							R = 141 / 255
						}
					end
				end
			end
		elseif (Class == "HUNTER") or ((Class == "DRUID") and (Specialization == "GUARDIAN")) or (Class == "WARRIOR") then
			local T = DefaultWithClassBar

			if Class == "HUNTER" then
				T = DefaultWithClassBarWithPet
			end

			T.Player.PowerBar.Border = true
			T.Player.PowerBar.Height = 24
			T.Player.PowerBar.Width = 516
			T.Player.PowerBar.Y = 25
		end

		if not Options.EnableSideBars then
			GetConfiguration().ActionBars.Player3 = nil
			GetConfiguration().ActionBars.Player4 = nil
			GetConfiguration().Buffs.X = GetConfiguration().Buffs.X + 72
		end
	end,

	Meter =
	{
		Anchor = "BOTTOM",
		Height = 119,
		Width = 152,
		X = 78,
		Y = 7,

		[0] =
		{
			Height = 24,
			Width = 152
		},

		[1] =
		{
			Height = 22,
			Width = 152
		},

		[2] =
		{
			Height = 22,
			Width = 152
		},

		[3] =
		{
			Height = 22,
			Width = 152
		},

		[4] =
		{
			Height = 22,
			Width = 152
		},

		[5] =
		{
			Height = 22,
			Width = 152
		}
	},

	Minimap =
	{
		Anchor = "BOTTOM",
		Height = 100,
		Width = 100,
		X = 208,
		Y = 26,

		Calender =
		{
			Anchor ="TOPRIGHT",
			X = 0,
			Y = 0
		},

		Clock =
		{
			Anchor ="BOTTOM",
			X = 2,
			Y = 5
		},

		Info =
		{
			Anchor = "BOTTOM",
			Height = 22,
			Width = 100,
			X = 0,
			Y = -19,

			FPS =
			{
				Anchor = "LEFT",
				X = 5,
				Y = 0
			},

			Latency =
			{
				Anchor = "RIGHT",
				X = -2,
				Y = 0
			}
		},

		Mail =
		{
			Anchor ="BOTTOMRIGHT",
			X = 1,
			Y = -2
		},

		Tracking =
		{
			Anchor ="TOPLEFT",
			X = -1,
			Y = 0
		},

		QueueStatus =
		{
			Anchor ="BOTTOMLEFT",
			X = 0,
			Y = 0
		},
	},
	
	Player =
	{
		Anchor = "BOTTOM",
		Height = 24,
		Width = 256,
		X = -130,
		Y = 183,

		CastingBar =
		{
			Anchor = "TOPLEFT",
			Height = 24,
			Orientation = "HORIZONTAL",
			Width = 464,
			X = 55,
			Y = 25,

			Spell =
			{
				Duration =
				{
					Anchor = "RIGHT",
					X = -4,
					Y = 0
				},

				Name =
				{
					Anchor = "LEFT",
					X = 6,
					Y = 0
				},

				Texture =
				{
					Anchor = "LEFT",
					Height = 24,
					Width = 48,
					X = -52,
					Y = 0,

					TextureCoordinate =
					{
						Bottom = 0.7,
						Left = 0.1,
						Right = 0.9,
						Top = 0.3
					}
				}
			}
		},

		HealthBar =
		{
			Anchor = "TOP",
			Height = 15,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = -3,

			Health =
			{
				Anchor ="CENTER",
				X = 1,
				Y = 0
			}
		},

		PowerBar =
		{
			Anchor = "BOTTOM",
			Height = 4,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = 3
		}
	},

	Raid =
	{
		Anchor = "LEFT",
		ColumnAnchor = "LEFT",
		Columns = 1,
		ColumnSpacing = 4,
		ColumnX = 4,
		ColumnY = -4,
		GroupBY = "GROUP",
		GroupOrder = "1, 2, 3, 4, 5, 6, 7, 8",
		HealthThreshold = 90,
		Height = 32,
		Rows = 40,
		ShowParty = true,
		ShowPlayer = true,
		ShowRaid = true,
		ShowSolo = true,
		Width = 32,
		X = 4,
		Y = 0,

		HealthBar =
		{
			Anchor = "CENTER",
			Height = 28,
			Orientation = "VERTICAL",
			Width = 28,
			X = 0,
			Y = 0,

			Health =
			{
				Anchor ="CENTER",
				SmallText = true,
				X = 1,
				Y = 0
			}
		}
	},

	Target =
	{
		Anchor = "BOTTOM",
		Height = 24,
		Width = 256,
		X = 130,
		Y = 183,

		HealthBar =
		{
			Anchor = "TOP",
			Height = 15,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = -3,

			Health =
			{
				Anchor ="CENTER",
				X = 1,
				Y = 0
			}
		},

		PowerBar =
		{
			Anchor = "BOTTOM",
			Height = 4,
			Orientation = "HORIZONTAL",
			Width = 252,
			X = 0,
			Y = 3
		}
	},

	TimerTrackers =
	{
		Anchor = "TOP",
		Height = 24,
		Width = 204,
		X = 0,
		Y = -33
	}
}
