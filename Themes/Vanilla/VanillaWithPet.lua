-- VanillaWithPet.lua
-- Written by Snail

VanillaWithPet = DeepCopy(Configuration.Themes.Vanilla)
VanillaWithPet.ActionBars.Pet =
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
}

VanillaWithPet.Pet =
{
	Anchor = "BOTTOM",
	Height = 24,
	Width = 100,
	X = 0,
	Y = 211,

	HealthBar =
	{
		Anchor = "TOP",
		Height = 15,
		Orientation = "HORIZONTAL",
		Width = 96,
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
		Width = 96,
		X = 0,
		Y = 3
	}
}
	
VanillaWithPet.Player.HealthBar.Width = 200
VanillaWithPet.Player.PowerBar.Width = 200
VanillaWithPet.Player.Width = 204
VanillaWithPet.Player.X = -156
VanillaWithPet.Player.Y = 211
VanillaWithPet.Target.HealthBar.Width = 200
VanillaWithPet.Target.PowerBar.Width = 200
VanillaWithPet.Target.Width = 204
VanillaWithPet.Target.X = 156
VanillaWithPet.Target.Y = 211
