-- DefaultTimers.lua
-- Written by Snail

Configuration.Themes.Default.Timers =
{
	["HUNTER"] =
	{
		Anchor = "BOTTOM",
		Height = 24,
		Width = 464,
		X = 26,
		Y = 298,

		[1] =
		{
			Priority = 1,
			Spell = "Serpent Sting",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 30 / 255,
				G = 115 / 255,
				R = 79 / 255
			}
		},

		["SURVIVAL"] =
		{
			[1] =
			{
				Priority = 2,
				Spell = "Explosive Shot",
				Type = "Cooldown",

				Color =
				{
					B = 33 / 255,
					G = 138 / 255,
					R = 235 / 255
				}
			},

			[2] =
			{
				Priority = 3,
				Spell = "Black Arrow",
				Type = "Cooldown",

				Color =
				{
					B = 185 / 255,
					G = 0,
					R = 102 / 255
				}
			},

			[3] =
			{
				Priority = 4,
				Spell = "Dire Beast",
				Type = "Cooldown",

				Color =
				{
					B = 124 / 255,
					G = 107 / 255,
					R = 66 / 255
				}
			},

			[5] =
			{
				Priority = 5,
				Spell = "Kill Shot",
				Type = "Cooldown",

				Color =
				{
					B = 33 / 255,
					G = 22 / 255,
					R = 179 / 255
				}
			}
		}
	},

	["MAGE"] =
	{
		Anchor = "BOTTOM",
		Height = 24,
		Width = 464,
		X = 26,
		Y = 242,

		["FIRE"] =
		{
			[1] =
			{
				Priority = 1,
				Spell = "Living Bomb",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 16 / 255,
					G = 204 / 255,
					R = 247 / 255
				}
			},

			[2] =
			{
				Priority = 2,
				ShowAmount = true,
				Spell = "Ignite",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 20 / 255,
					G = 101 / 255,
					R = 230 / 255
				}
			},

			[3] =
			{
				Priority = 3,
				Spell = "Inferno Blast",
				Type = "Cooldown",

				Color =
				{
					B = 13 / 255,
					G = 33 / 255,
					R = 220 / 255
				}
			},

			[4] =
			{
				Priority = 4,
				ShowAmount = true,
				Spell = "Combustion",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 6 / 255,
					G = 158 / 255,
					R = 223 / 255
				}
			}
		}
	},

	["MONK"] =
	{
		Anchor = "BOTTOM",
		AnchorToRaid = true,
		Height = 24,
		Width = 464,
		X = 26,
		Y = 31,

		["MISTWEAVER"] =
		{
			[1] =
			{
				Priority = 1,
				Spell = "Expel Harm",
				Type = "Cooldown",

				Color =
				{
					B = 165 / 255,
					G = 190 / 255,
					R = 8 / 255
				}
			},

			[2] =
			{
				Priority = 2,
				Spell = "Renewing Mist",
				Type = "Cooldown",

				Color =
				{
					B = 141 / 255,
					G = 186 / 255,
					R = 57 / 255
				}
			},

			[3] =
			{
				Priority = 3,
				Spell = "Chi Wave",
				Type = "Cooldown",

				Color =
				{
					B = 223 / 255,
					G = 251 / 255,
					R = 61 / 255
				}
			},

			[4] =
			{
				Priority = 4,
				Spell = "Mana Tea",
				Type = "Cooldown",

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
		Anchor = "BOTTOM",
		Height = 24,
		Width = 464,
		X = 26,
		Y = 242,

		[1] =
		{
			Priority = 1,
			Spell = "Garrote",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 0,
				G = 13 / 255,
				R = 87 / 255
			}
		},

		[2] =
		{
			Priority = 2,
			Spell = "Rupture",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 41 / 255,
				G = 32 / 255,
				R = 206 / 255
			}
		},

		[3] =
		{
			Priority = 3,
			Spell = "Crimson Tempest",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 30 / 255,
				G = 40 / 255,
				R = 198 / 255
			}
		},

		[4] =
		{
			Priority = 4,
			Spell = "Slice and Dice",
			Type = "Buff",

			Color =
			{
				B = 0,
				G = 85 / 255,
				R = 204 / 255
			}
		},

		[5] =
		{
			Priority = 90,
			Spell = "Recuperate",
			Type = "Buff",

			Color =
			{
				B = 107 / 255,
				G = 142 / 255,
				R = 41 / 255
			}
		},

		[6] =
		{
			Priority = 91,
			Spell = "Feint",
			Type = "Buff",

			Color =
			{
				B = 179 / 255,
				G = 142 / 255,
				R = 100 / 255
			}
		},

		[7] =
		{
			Priority = 92,
			Spell = "Gouge",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 215 / 255,
				G = 212 / 255,
				R = 213 / 255
			}
		},

		[8] =
		{
			Priority = 93,
			Spell = "Garrote - Silence",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 0,
				G = 13 / 255,
				R = 87 / 255
			}
		},

		[9] =
		{
			Priority = 94,
			Spell = "Cheap Shot",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 147 / 255,
				G = 168 / 255,
				R = 193 / 255
			}
		},

		[10] =
		{
			Priority = 95,
			Spell = "Kidney Shot",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 144 / 255,
				G = 197 / 255,
				R = 1
			}
		},

		[11] =
		{
			Priority = 96,
			Spell = "Blind",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 173 / 255,
				G = 211 / 255,
				R = 247 / 255
			}
		},

		[12] =
		{
			Priority = 97,
			Spell = "Dismantle",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 112 / 255,
				G = 230 / 255,
				R = 235 / 255
			}
		},

		[13] =
		{
			Priority = 98,
			Spell = "Sap",
			Type = "Debuff",
			Unit = "Target",

			Color =
			{
				B = 167 / 255,
				G = 168 / 255,
				R = 167 / 255
			}
		},

		[14] =
		{
			Priority = 99,
			Spell = "Subterfuge",
			Type = "Buff",

			Color =
			{
				B = 132 / 255,
				G = 103 / 255,
				R = 79 / 255
			}
		},

		["ASSASSINATION"] =
		{
			[1] =
			{
				Priority = 5,
				Spell = "Envenom",
				Type = "Buff",

				Color =
				{
					B = 0,
					G = 153 / 255,
					R = 0
				}
			},

			[2] =
			{
				Priority = 6,
				Spell = "Vendetta",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 0,
					G = 0,
					R = 139 / 255
				}
			},

			[3] =
			{
				Priority = 7,
				Spell = "Shadow Blades",
				Type = "Buff",

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
				Priority = 5,
				Spell = "Revealing Strike",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 147 / 255,
					G = 164 / 255,
					R = 175 / 255
				}
			},

			[2] =
			{
				Priority = 6,
				Spell = "Shallow Insight",
				Type = "Buff",

				Color =
				{
					B = 0,
					G = 153 / 255,
					R = 0
				}
			},

			[3] =
			{
				Priority = 6,
				Spell = "Moderate Insight",
				Type = "Buff",

				Color =
				{
					B = 93 / 255,
					G = 236 / 255,
					R = 251 / 255
				}
			},

			[4] =
			{
				Priority = 6,
				Spell = "Deep Insight",
				Type = "Buff",

				Color =
				{
					B = 0,
					G = 0,
					R = 139 / 255
				}
			},

			[5] =
			{
				Priority = 7,
				Spell = "Adrenaline Rush",
				Type = "Buff",

				Color =
				{
					B = 130 / 255,
					G = 220 / 255,
					R = 240 / 255
				}
			},

			[6] =
			{
				Priority = 8,
				Spell = "Shadow Blades",
				Type = "Buff",

				Color =
				{
					B = 1,
					G = 0,
					R = 143 / 255
				}
			},

			[7] =
			{
				Priority = 9,
				Spell = "Blade Flurry",
				Type = "Buff",

				Color =
				{
					B = 34 / 255,
					G = 88 / 255,
					R = 226 / 255
				}
			}
		},

		["SUBTLETY"] =
		{
			[1] =
			{
				Priority = 5,
				Spell = "Hemorrhage",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 0,
					G = 0,
					R = 139 / 255
				}
			},

			[2] =
			{
				Priority = 6,
				Spell = "Find Weakness",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 107 / 255,
					G = 168 / 255,
					R = 0
				}
			},

			[3] =
			{
				Priority = 7,
				Spell = "Shadow Dance",
				Type = "Buff",

				Color =
				{
					B = 1,
					G = 0,
					R = 10 / 255
				}
			},

			[4] =
			{
				Priority = 8,
				Spell = "Shadow Blades",
				Type = "Buff",

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
		Anchor = "BOTTOM",
		Height = 24,
		Width = 464,
		X = 26,
		Y = 298,

		["AFFLICTION"] =
		{
			[1] =
			{
				Priority = 1,
				Spell = "Unstable Affliction",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 171 / 255,
					G = 0,
					R = 115 / 255
				}
			},

			[2] =
			{
				Priority = 2,
				Spell = "Corruption",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 1,
					G = 0,
					R = 111 / 255
				}
			},

			[3] =
			{
				Priority = 3,
				Spell = "Agony",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 27 / 255,
					G = 70 / 255,
					R = 128 / 255
				}
			},

			[4] =
			{
				Priority = 4,
				Spell = "Haunt",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 157 / 255,
					G = 186 / 255,
					R = 169 / 255
				}
			},

			[5] =
			{
				Priority = 5,
				Spell = "Dark Soul: Misery",
				Type = "Buff",

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
				Priority = 1,
				Spell = "Hand of Gul'dan",
				Type = "Cooldown",

				Color =
				{
					B = 193 / 255,
					G = 84 / 255,
					R = 193 / 255
				}
			},

			[2] =
			{
				Priority = 2,
				Spell = "Corruption",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 1,
					G = 0,
					R = 111 / 255
				}
			},

			[3] =
			{
				Priority = 3,
				Spell = "Doom",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 192 / 255,
					G = 192 / 255,
					R = 192 / 255
				}
			},

			[4] =
			{
				Priority = 4,
				Spell = "Dark Soul: Knowledge",
				Type = "Buff",

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
				Priority = 1,
				Spell = "Conflagrate",
				Type = "Cooldown",

				Color =
				{
					B = 0,
					G = 85 / 255,
					R = 204 / 255
				}
			},

			[2] =
			{
				Priority = 2,
				Spell = "Immolate",
				Type = "Debuff",
				Unit = "Target",

				Color =
				{
					B = 0,
					G = 0,
					R = 139 / 255
				}
			},

			[3] =
			{
				Priority = 3,
				Spell = "Rain of Fire",
				Type = "Buff",

				Color =
				{
					B = 10 / 255,
					G = 83 / 255,
					R = 198 / 255
				}
			},

			[4] =
			{
				Priority = 4,		
				Spell = "Backdraft",
				Type = "Buff",

				Color =
				{
					B = 6 / 255,
					G = 128 / 255,
					R = 1
				}
			},

			[5] =
			{
				Priority = 5,
				Spell = "Havoc",
				Type = "Cooldown",

				Color =
				{
					B = 41 / 255,
					G = 32 / 255,
					R = 206 / 255
				}
			},

			[6] =
			{
				Priority = 6,
				Spell = "Dark Soul: Instability",
				Type = "Buff",

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
