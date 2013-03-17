-- Vanilla.lua
-- Written by Snail

Configuration.Themes.Vanilla = 
{
	ActionBars =
	{
		Pet =
		{
			Anchor = "BOTTOM",
			Buttons = 10,
			Height = 24,
			Width = 48,
			X = 0,
			Y = 56,

			TextureCoordinate =
			{
				Bottom = 0.7,
				Left = 0.1,
				Right = 0.9,
				Top = 0.3
			}
		},

		Player =
		{
			Anchor = "BOTTOM",
			Buttons = 12,
			Height = 24,
			Width = 48,
			X = 0,
			Y = 4,

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
			Buttons = 12,
			Height = 24,
			Width = 48,
			X = 0,
			Y = 32,

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
			Height = 24,
			Orientation = "VERTICAL",
			UIParent = true,
			Width = 48,
			X = -4,
			Y = 0,

			TextureCoordinate =
			{
				Bottom = 0.7,
				Left = 0.1,
				Right = 0.9,
				Top = 0.3
			}
		},

		Player4 =
		{
			Anchor = "RIGHT",
			Buttons = 12,
			Height = 24,
			Orientation = "VERTICAL",
			UIParent = true,
			Width = 48,
			X = -56,
			Y = 0,

			TextureCoordinate =
			{
				Bottom = 0.7,
				Left = 0.1,
				Right = 0.9,
				Top = 0.3
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
		Anchor = "TOPRIGHT",
		Height = 32,
		Width = 32,
		X = -168,
		Y = -4,

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
		Anchor = "BOTTOMLEFT",
		Height = 160,
		Width = 384,
		X = 9,
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
		Anchor = "TOPRIGHT",
		Height = 8,
		Width = 160,
		X = -7,
		Y = -275
	},

	Initialize = function(Self)
		local Class = select(2, UnitClass("Player"))
		local HasSecondaryResource
		local Specialization = GetSpecialization()

		if Specialization then
			Specialization = select(2, GetSpecializationInfo(Specialization))
			Specialization = Specialization:gsub("(.)", string.upper)
		end

		if (Class == "DEATHKNIGHT") or ((Class == "DRUID") and (Specialization == "BALANCE")) or ((Class == "DRUID") and (Specialization == "FERAL")) or ((Class == "PRIEST") and (Specialization == "SHADOW")) or (Class == "ROGUE") or (Class == "WARLOCK") then
			HasSecondaryResource = true
		elseif Class == "MONK" then
			local _, _, _, _, Selected = GetTalentInfo(8)

			if Selected == true then
				Configuration.Themes.Vanilla.Player.ChiBar = Configuration.Themes.Vanilla.Player.ChiBar2
			end

			HasSecondaryResource = true
		elseif Class == "PALADIN" then
			local Level = UnitLevel("Player")

			if Level and (Level >= 85) then
				Configuration.Themes.Vanilla.Player.HolyPowerBar = Configuration.Themes.Vanilla.Player.HolyPowerBar2
			end

			HasSecondaryResource = true
		end

		if HasSecondaryResource then
			Configuration.Themes.Vanilla.Pet.Y = Configuration.Themes.Vanilla.Pet.Y - (Configuration.Themes.Vanilla.Player.RunesBar.Height + 4)
			Configuration.Themes.Vanilla.Player.CastingBar.Y = Configuration.Themes.Vanilla.Player.CastingBar.Y - (Configuration.Themes.Vanilla.Player.RunesBar.Height + 4)
		end
	end,

	Meter =
	{
		Anchor = "TOPRIGHT",
		Height = 100,
		Width = 160,
		X = -7,
		Y = -171,

		[0] =
		{
			Anchor = "TOP",
			Height = 24,
			Width = 160,
			X = 0,
			Y = 0
		},

		[1] =
		{
			Anchor = "TOP",
			Height = 22,
			Width = 160,
			X = 0,
			Y = -21
		},

		[2] =
		{
			Anchor = "CENTER",
			Height = 22,
			Width = 160,
			X = 0,
			Y = -1
		},

		[3] =
		{
			Anchor = "BOTTOM",
			Height = 22,
			Width = 160,
			X = 0,
			Y = 19
		},

		[4] =
		{
			Anchor = "BOTTOM",
			Height = 22,
			Width = 160,
			X = 0,
			Y = 0
		}
	},

	Minimap =
	{
		Anchor = "TOPRIGHT",
		Height = 160,
		Width = 160,
		X = -7,
		Y = -7,

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

	Pet =
	{
		Anchor = "TOPLEFT",
		Height = 36,
		Width = 256,
		X = 4,
		Y = -77,

		CastingBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Orientation = "HORIZONTAL",
			Width = 218,
			X = 19,
			Y = -18,

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
					Height = 17,
					Width = 34,
					X = -38,
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
			Anchor = "TOPRIGHT",
			Height = 27,
			Orientation = "HORIZONTAL",
			Width = 219,
			X = -3,
			Y = -3,

			Health =
			{
				Anchor ="CENTER",
				X = 1,
				Y = 0
			}
		},

		Portrait =
		{
			Anchor = "LEFT",
			Height = 32,
			Width = 32,
			X = 3,
			Y = 0
		},

		PowerBar =
		{
			Anchor = "BOTTOMRIGHT",
			Height = 4,
			Orientation = "HORIZONTAL",
			Width = 219,
			X = -3,
			Y = 3
		}
	},
	
	Player =
	{
		Anchor = "TOPLEFT",
		Height = 48,
		Width = 256,
		X = 4,
		Y = -4,

		BurningEmbersBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 63,
				X = 2,
				Y = 0
			},

			[2] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 62,
				X = -31,
				Y = 0
			},

			[3] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 62,
				X = 32,
				Y = 0
			},

			[4] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 62,
				X = -2,
				Y = 0
			}
		},

		CastingBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Orientation = "HORIZONTAL",
			Width = 218,
			X = 19,
			Y = -18,

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
					Height = 17,
					Width = 34,
					X = -38,
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

		ChiBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 63,
				X = 3,
				Y = 0
			},

			[2] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 62,
				X = -31,
				Y = 0
			},

			[3] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 62,
				X = 32,
				Y = 0
			},

			[4] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 62,
				X = -3,
				Y = 0
			}
		},

		ChiBar2 =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 50,
				X = 3,
				Y = 0
			},

			[2] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 49,
				X = 54,
				Y = 0
			},

			[3] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 50,
				X = 0,
				Y = 0
			},

			[4] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 49,
				X = -54,
				Y = 0
			},

			[5] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 50,
				X = -3,
				Y = 0
			}
		},

		ComboPointsBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 50,
				X = 2,
				Y = 0
			},

			[2] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 49,
				X = 53,
				Y = 0
			},

			[3] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 50,
				X = 0,
				Y = 0
			},

			[4] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 49,
				X = -53,
				Y = 0
			},

			[5] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 50,
				X = -2,
				Y = 0
			}
		},

		DemonicFuryBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 252,
				X = 0,
				Y = 0
			}
		},

		EclipseBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 252,
				X = 0,
				Y = 0
			}
		},

		HealthBar =
		{
			Anchor = "TOPRIGHT",
			Height = 37,
			Orientation = "HORIZONTAL",
			Width = 207,
			X = -3,
			Y = -3,

			Health =
			{
				Anchor ="CENTER",
				X = 1,
				Y = 0
			}
		},

		HolyPowerBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 83,
				X = 3,
				Y = 0
			},

			[2] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 84,
				X = 0,
				Y = 0
			},

			[3] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 83,
				X = -3,
				Y = 0
			}
		},

		HolyPowerBar2 =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 50,
				X = 3,
				Y = 0
			},

			[2] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 49,
				X = 54,
				Y = 0
			},

			[3] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 50,
				X = 0,
				Y = 0
			},

			[4] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 49,
				X = -54,
				Y = 0
			},

			[5] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 50,
				X = -3,
				Y = 0
			}
		},

		Portrait =
		{
			Anchor = "LEFT",
			Height = 44,
			Width = 44,
			X = 3,
			Y = 0
		},

		PowerBar =
		{
			Anchor = "BOTTOMRIGHT",
			Height = 6,
			Orientation = "HORIZONTAL",
			Width = 207,
			X = -3,
			Y = 3
		},

		RunesBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 41,
				X = 2,
				Y = 0
			},

			[2] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 40,
				X = 44,
				Y = 0
			},

			[3] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 42,
				X = -22,
				Y = 0
			},

			[4] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 42,
				X = 21,
				Y = 0
			},

			[5] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 41,
				X = -44,
				Y = 0
			},

			[6] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 41,
				X = -2,
				Y = 0
			}
		},

		ShadowOrbsBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 83,
				X = 3,
				Y = 0
			},

			[2] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 84,
				X = 0,
				Y = 0
			},

			[3] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 83,
				X = -3,
				Y = 0
			}
		},

		SoulShardsBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Width = 256,
			X = 0,
			Y = -20,

			[1] =
			{
				Anchor = "LEFT",
				Height = 13,
				Width = 63,
				X = 2,
				Y = 0
			},

			[2] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 62,
				X = -31,
				Y = 0
			},

			[3] =
			{
				Anchor = "CENTER",
				Height = 13,
				Width = 62,
				X = 32,
				Y = 0
			},

			[4] =
			{
				Anchor = "RIGHT",
				Height = 13,
				Width = 62,
				X = -2,
				Y = 0
			}
		}
	},

	Raid =
	{
		Anchor = "LEFT",
		ColumnAnchor = "LEFT",
		Columns = 4,
		ColumnSpacing = 4,
		ColumnX = 4,
		ColumnY = -4,
		GroupBY = "GROUP",
		GroupOrder = "1, 2, 3, 4, 5, 6, 7, 8",
		HealthThreshold = 90,
		Height = 32,
		Rows = 10,
		Shown = true,
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
		Anchor = "TOPLEFT",
		Height = 48,
		Width = 256,
		X = 264,
		Y = -4,

		CastingBar =
		{
			Anchor = "BOTTOM",
			Height = 17,
			Orientation = "HORIZONTAL",
			Width = 218,
			X = 19,
			Y = -18,

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
					Height = 17,
					Width = 34,
					X = -38,
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
			Anchor = "TOPLEFT",
			Height = 37,
			Orientation = "HORIZONTAL",
			Width = 207,
			X = 3,
			Y = -3,

			Health =
			{
				Anchor ="CENTER",
				X = 1,
				Y = 0
			}
		},

		Portrait =
		{
			Anchor = "RIGHT",
			Height = 44,
			Width = 44,
			X = -4,
			Y = 0
		},

		PowerBar =
		{
			Anchor = "BOTTOMLEFT",
			Height = 6,
			Orientation = "HORIZONTAL",
			Width = 207,
			X = 3,
			Y = 3
		}
	}
}
