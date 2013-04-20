-- DefaultTimers.lua
-- Written by Snail

Configuration.Themes.Default.Timers =
{
	["DEATHKNIGHT"] =
	{
		[1] =
		{
			Anchor = "BOTTOM",
			Height = 24,
			Spell = "Blood Plague",
			Type = "Debuff",
			Unit = "Target",
			Width = 464,
			X = 26,
			Y = 242,

			Color =
			{
				B = 171 / 255,
				G = 0,
				R = 115 / 255
			}
		},

		[2] =
		{
			Anchor = "BOTTOM",
			Height = 24,
			Spell = "Frost Fever",
			Type = "Debuff",
			Unit = "Target",
			Width = 464,
			X = 26,
			Y = 270,

			Color =
			{
				B = 251 / 255,
				G = 194 / 255,
				R = 115 / 255
			}
		},

		["UNHOLY"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Death and Decay",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 0,
					G = 0,
					R = 139 / 255
				}
			}
		}
	},

	["MAGE"] =
	{
		["FROST"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Frost Bomb",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 270,

				Color =
				{
					B = 239 / 255,
					G = 237 / 255,
					R = 90 / 255
				}
			},

			[2] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Frozen Orb",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 1,
					G = 184 / 255,
					R = 38 / 255
				}
			}
		}
	},

	["PRIEST"] =
	{
		["DISCIPLINE"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Penance",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 242,

				Color =
				{
					B = 131 / 255,
					G = 1,
					R = 1
				}
			}
		},

		["SHADOW"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Mind Blast",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 270,

				Color =
				{
					B = 171 / 255,
					G = 0,
					R = 115 / 255
				}
			},

			[2] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Vampiric Touch",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 189 / 255,
					G = 96 / 255,
					R = 21 / 255
				}
			},

			[3] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Shadow Word: Pain",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 326,

				Color =
				{
					B = 0,
					G = 0,
					R = 139 / 255
				}
			},

			[4] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Shadow Word: Death",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 354,

				Color =
				{
					B = 192 / 255,
					G = 192 / 255,
					R = 192 / 255
				}
			}
		}
	},

	["ROGUE"] =
	{
		[1] =
		{
			Anchor = "BOTTOM",
			Height = 24,
			Spell = "Rupture",
			Type = "Debuff",
			Unit = "Target",
			Width = 464,
			X = 26,
			Y = 242,

			Color =
			{
				B = 41 / 255,
				G = 32 / 255,
				R = 206 / 255
			}
		},

		[2] =
		{
			Anchor = "BOTTOM",
			Height = 24,
			Spell = "Slice and Dice",
			Type = "Buff",
			Width = 464,
			X = 26,
			Y = 270,

			Color =
			{
				B = 0,
				G = 85 / 255,
				R = 204 / 255
			}
		},

		["ASSASSINATION"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Envenom",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 0,
					G = 153 / 255,
					R = 0
				}
			},

			[2] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Vendetta",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 326,

				Color =
				{
					B = 0,
					G = 0,
					R = 139 / 255
				}
			},

			[3] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Shadow Blades",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 354,

				Color =
				{
					B = 1,
					G = 0,
					R = 143 / 255
				}
			}
		},

		["COMBAT"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Shallow Insight",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 0,
					G = 153 / 255,
					R = 0
				}
			},

			[2] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Moderate Insight",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 93 / 255,
					G = 236 / 255,
					R = 251 / 255
				}
			},

			[3] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Deep Insight",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 0,
					G = 0,
					R = 139 / 255
				}
			},

			[4] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Adrenaline Rush",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 326,

				Color =
				{
					B = 130 / 255,
					G = 220 / 255,
					R = 240 / 255
				}
			},

			[5] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Blade Flurry",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 354,

				Color =
				{
					B = 34 / 255,
					G = 88 / 255,
					R = 226 / 255
				}
			},

			[6] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Shadow Blades",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 1,
					G = 0,
					R = 143 / 255
				}
			}
		},

		["SUBTLETY"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Hemorrhage",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 0,
					G = 0,
					R = 139 / 255
				}
			},

			[2] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Find Weakness",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 326,

				Color =
				{
					B = 107 / 255,
					G = 168 / 255,
					R = 0
				}
			},

			[3] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Shadow Dance",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 354,

				Color =
				{
					B = 1,
					G = 0,
					R = 10 / 255
				}
			},

			[4] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Shadow Blades",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 1,
					G = 0,
					R = 143 / 255
				}
			}
		}
	},

	["WARLOCK"] =
	{
		["AFFLICTION"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Unstable Affliction",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 270,

				Color =
				{
					B = 171 / 255,
					G = 0,
					R = 115 / 255
				}
			},

			[2] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Corruption",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 1,
					G = 0,
					R = 111 / 255
				}
			},

			[3] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Agony",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 326,

				Color =
				{
					B = 27 / 255,
					G = 70 / 255,
					R = 128 / 255
				}
			},

			[4] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Haunt",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 354,

				Color =
				{
					B = 157 / 255,
					G = 186 / 255,
					R = 169 / 255
				}
			},

			[5] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Dark Soul: Misery",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 1,
					G = 0,
					R = 143 / 255
				}
			}
		},

		["DEMONOLOGY"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Hand of Gul'dan",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 270,

				Color =
				{
					B = 193 / 255,
					G = 84 / 255,
					R = 193 / 255
				}
			},

			[2] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Corruption",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 1,
					G = 0,
					R = 111 / 255
				}
			},

			[3] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Doom",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 326,

				Color =
				{
					B = 192 / 255,
					G = 192 / 255,
					R = 192 / 255
				}
			},

			[4] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Dark Soul: Knowledge",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 354,

				Color =
				{
					B = 1,
					G = 0,
					R = 143 / 255
				}
			}
		},

		["DESTRUCTION"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Conflagrate",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 270,

				Color =
				{
					B = 0,
					G = 85 / 255,
					R = 204 / 255
				}
			},

			[2] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Immolate",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 0,
					G = 0,
					R = 139 / 255
				}
			},

			[3] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Rain of Fire",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 326,

				Color =
				{
					B = 10 / 255,
					G = 83 / 255,
					R = 198 / 255
				}
			},

			[4] =
			{
				Anchor = "BOTTOM",
				Height = 24,				
				Spell = "Backdraft",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 354,

				Color =
				{
					B = 6 / 255,
					G = 128 / 255,
					R = 1
				}
			},

			[5] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Havoc",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 41 / 255,
					G = 32 / 255,
					R = 206 / 255
				}
			},

			[6] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Dark Soul: Instability",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 410,

				Color =
				{
					B = 27 / 255,
					G = 111 / 255,
					R = 244 / 255
				}
			}
		}
	}
}
