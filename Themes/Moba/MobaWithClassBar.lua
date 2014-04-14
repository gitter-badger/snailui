-- MobaWithClassBar.lua
-- Written by Snail

MobaWithClassBar = DeepCopy(Configuration.Themes.Moba)
MobaWithClassBar.Player.BurningEmbersBar =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 1,
	Y = 27,

	[1] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 127,
		X = 2,
		Y = -2
	},

	[2] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 128,
		X = -64,
		Y = -2
	},

	[3] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 128,
		X = 65,
		Y = -2
	},

	[4] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 126,
		X = -2,
		Y = -2
	}
}

MobaWithClassBar.Player.CastingBar.Y = 53
MobaWithClassBar.Player.ChiBar =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 0,
	Y = 28,

	[1] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 127,
		X = 3,
		Y = -3
	},

	[2] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 128,
		X = -64,
		Y = -3
	},

	[3] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 128,
		X = 65,
		Y = -3
	},

	[4] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 126,
		X = -3,
		Y = -3
	}
}

MobaWithClassBar.Player.ChiBar2 =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 0,
	Y = 28,

	[1] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 102,
		X = 3,
		Y = -3
	},

	[2] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 102,
		X = 106,
		Y = -3
	},

	[3] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 100,
		X = 0,
		Y = -3
	},

	[4] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 102,
		X = -106,
		Y = -3
	},

	[5] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 102,
		X = -3,
		Y = -3
	}
}

MobaWithClassBar.Player.ComboPointsBar =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 1,
	Y = 27,

	[1] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 102,
		X = 2,
		Y = -2
	},

	[2] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 102,
		X = 105,
		Y = -2
	},

	[3] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 100,
		X = 0,
		Y = -2
	},

	[4] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 102,
		X = -105,
		Y = -2
	},

	[5] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 102,
		X = -2,
		Y = -2
	}
}

MobaWithClassBar.Player.EclipseBar =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 1,
	Y = 27,

	[1] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 512,
		X = 0,
		Y = -2
	}
}

MobaWithClassBar.Player.DemonicFuryBar =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 1,
	Y = 27,

	[1] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 512,
		X = 0,
		Y = -2
	}
}

MobaWithClassBar.Player.HealthBar.Anchor = "CENTER"
MobaWithClassBar.Player.HealthBar.Height = 20
MobaWithClassBar.Player.HealthBar.Y = 0
MobaWithClassBar.Player.HolyPowerBar =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 0,
	Y = 28,

	[1] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 170,
		X = 3,
		Y = -3
	},

	[2] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 170,
		X = 0,
		Y = -3
	},

	[3] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 170,
		X = -3,
		Y = -3
	}
}

MobaWithClassBar.Player.HolyPowerBar2 =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 0,
	Y = 28,

	[1] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 102,
		X = 3,
		Y = -3
	},

	[2] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 102,
		X = 106,
		Y = -3
	},

	[3] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 100,
		X = 0,
		Y = -3
	},

	[4] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 102,
		X = -106,
		Y = -3
	},

	[5] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 102,
		X = -3,
		Y = -3
	}
}

MobaWithClassBar.Player.PowerBar.Anchor = "TOPLEFT"
MobaWithClassBar.Player.PowerBar.Height = 6
MobaWithClassBar.Player.PowerBar.Width = 512
MobaWithClassBar.Player.PowerBar.X = 3
MobaWithClassBar.Player.PowerBar.Y = 11
MobaWithClassBar.Player.RunesBar =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 1,
	Y = 27,

	[1] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 85,
		X = 2,
		Y = -2
	},

	[2] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 84,
		X = 88,
		Y = -2
	},

	[3] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 84,
		X = -43,
		Y = -2
	},

	[4] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 84,
		X = 42,
		Y = -2
	},

	[5] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 85,
		X = -88,
		Y = -2
	},

	[6] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 85,
		X = -2,
		Y = -2
	}
}

MobaWithClassBar.Player.ShadowOrbsBar =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 0,
	Y = 28,

	[1] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 170,
		X = 3,
		Y = -3
	},

	[2] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 170,
		X = 0,
		Y = -3
	},

	[3] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 170,
		X = -3,
		Y = -3
	}
}

MobaWithClassBar.Player.SoulShardsBar =
{
	Anchor = "TOPLEFT",
	Height = 24,
	Width = 516,
	X = 1,
	Y = 27,

	[1] =
	{
		Anchor = "TOPLEFT",
		Height = 13,
		Width = 127,
		X = 2,
		Y = -2
	},

	[2] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 128,
		X = -64,
		Y = -2
	},

	[3] =
	{
		Anchor = "TOP",
		Height = 13,
		Width = 126,
		X = 64,
		Y = -2
	},

	[4] =
	{
		Anchor = "TOPRIGHT",
		Height = 13,
		Width = 128,
		X = -2,
		Y = -2
	}
}
