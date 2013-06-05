-- DefaultTimers.lua
-- Written by Snail

Configuration.Themes.Default.Timers =
{
	["MONK"] =
	{
		["MISTWEAVER"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Expel Harm",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 270,

				Color =
				{
					B = 165 / 255,
					G = 190 / 255,
					R = 8 / 255
				}
			},

			[2] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Renewing Mist",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 141 / 255,
					G = 186 / 255,
					R = 57 / 255
				}
			},

			[3] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Chi Wave",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 326,

				Color =
				{
					B = 223 / 255,
					G = 251 / 255,
					R = 61 / 255
				}
			},

			[4] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Mana Tea",
				Type = "Cooldown",
				Width = 464,
				X = 26,
				Y = 354,

				Color =
				{
					B = 1,
					G = 165 / 255,
					R = 13 / 255
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
			Spell = "Garrote",
			Type = "Debuff",
			Unit = "Target",
			Width = 464,
			X = 26,
			Y = 242,

			Color =
			{
				B = 0,
				G = 13 / 255,
				R = 87 / 255
			}
		},

		[4] =
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
			},

			[4] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Cheap Shot",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 147 / 255,
					G = 168 / 255,
					R = 193 / 255
				}
			},

			[5] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Garrote - Silence",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 0,
					G = 13 / 255,
					R = 87 / 255
				}
			},

			[6] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Kidney Shot",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 144 / 255,
					G = 197 / 255,
					R = 1
				}
			},

			[7] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Blind",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 173 / 255,
					G = 211 / 255,
					R = 247 / 255
				}
			},

			[8] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Gouge",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 215 / 255,
					G = 212 / 255,
					R = 213 / 255
				}
			},

			[9] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Sap",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 167 / 255,
					G = 168 / 255,
					R = 167 / 255
				}
			},				

			[10] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Subterfuge",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 410,

				Color =
				{
					B = 132 / 255,
					G = 103 / 255,
					R = 79 / 255
				}
			}
		},

		["COMBAT"] =
		{
			[1] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Revealing Strike",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 298,

				Color =
				{
					B = 147 / 255,
					G = 164 / 255,
					R = 175 / 255
				}
			},

			[2] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Shallow Insight",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 326,

				Color =
				{
					B = 0,
					G = 153 / 255,
					R = 0
				}
			},

			[3] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Moderate Insight",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 326,

				Color =
				{
					B = 93 / 255,
					G = 236 / 255,
					R = 251 / 255
				}
			},

			[4] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Deep Insight",
				Type = "Buff",
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

			[5] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Adrenaline Rush",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 354,

				Color =
				{
					B = 130 / 255,
					G = 220 / 255,
					R = 240 / 255
				}
			},

			[6] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Blade Flurry",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 382,

				Color =
				{
					B = 34 / 255,
					G = 88 / 255,
					R = 226 / 255
				}
			},

			[7] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Shadow Blades",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 410,

				Color =
				{
					B = 1,
					G = 0,
					R = 143 / 255
				}
			},

			[8] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Cheap Shot",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 438,

				Color =
				{
					B = 147 / 255,
					G = 168 / 255,
					R = 193 / 255
				}
			},

			[9] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Garrote - Silence",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 438,

				Color =
				{
					B = 0,
					G = 13 / 255,
					R = 87 / 255
				}
			},

			[10] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Kidney Shot",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 438,

				Color =
				{
					B = 144 / 255,
					G = 197 / 255,
					R = 1
				}
			},

			[11] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Blind",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 438,

				Color =
				{
					B = 173 / 255,
					G = 211 / 255,
					R = 247 / 255
				}
			},

			[12] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Gouge",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 438,

				Color =
				{
					B = 215 / 255,
					G = 212 / 255,
					R = 213 / 255
				}
			},

			[13] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Sap",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 438,

				Color =
				{
					B = 167 / 255,
					G = 168 / 255,
					R = 167 / 255
				}
			},				

			[14] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Subterfuge",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 466,

				Color =
				{
					B = 132 / 255,
					G = 103 / 255,
					R = 79 / 255
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
			},

			[5] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Cheap Shot",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 410,

				Color =
				{
					B = 147 / 255,
					G = 168 / 255,
					R = 193 / 255
				}
			},

			[6] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Garrote - Silence",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 410,

				Color =
				{
					B = 0,
					G = 13 / 255,
					R = 87 / 255
				}
			},

			[7] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Kidney Shot",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 410,

				Color =
				{
					B = 144 / 255,
					G = 197 / 255,
					R = 1
				}
			},

			[8] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Blind",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 410,

				Color =
				{
					B = 173 / 255,
					G = 211 / 255,
					R = 247 / 255
				}
			},

			[9] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Gouge",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 410,

				Color =
				{
					B = 215 / 255,
					G = 212 / 255,
					R = 213 / 255
				}
			},

			[10] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Sap",
				Type = "Debuff",
				Unit = "Target",
				Width = 464,
				X = 26,
				Y = 410,

				Color =
				{
					B = 167 / 255,
					G = 168 / 255,
					R = 167 / 255
				}
			},

			[11] =
			{
				Anchor = "BOTTOM",
				Height = 24,
				Spell = "Subterfuge",
				Type = "Buff",
				Width = 464,
				X = 26,
				Y = 438,

				Color =
				{
					B = 132 / 255,
					G = 103 / 255,
					R = 79 / 255
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
