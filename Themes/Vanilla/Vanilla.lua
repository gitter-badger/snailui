-- Vanilla.lua
-- Written by Snail

Configuration.Themes.Vanilla = DeepCopy(Configuration.Themes.Compact)

Configuration.Themes.Vanilla.ActionBars.Player.Buttons = 12
Configuration.Themes.Vanilla.ActionBars.Player.Height = 40
Configuration.Themes.Vanilla.ActionBars.Player.Width = 40
Configuration.Themes.Vanilla.ActionBars.Player.Y = 4

Configuration.Themes.Vanilla.ActionBars.Player.TextureCoordinate =
{
	Bottom = 0.9,
	Left = 0.1,
	Right = 0.9,
	Top = 0.1
}

Configuration.Themes.Vanilla.ActionBars.Player2.Buttons = 12
Configuration.Themes.Vanilla.ActionBars.Player2.Height = 40
Configuration.Themes.Vanilla.ActionBars.Player2.Width = 40
Configuration.Themes.Vanilla.ActionBars.Player2.Y = 48

Configuration.Themes.Vanilla.ActionBars.Player2.TextureCoordinate =
{
	Bottom = 0.9,
	Left = 0.1,
	Right = 0.9,
	Top = 0.1
}

Configuration.Themes.Vanilla.Buffs.Anchor = "TOPRIGHT"
Configuration.Themes.Vanilla.Buffs.Orientation = nil
Configuration.Themes.Vanilla.Buffs.X = -232
Configuration.Themes.Vanilla.Buffs.Y = -4

Configuration.Themes.Vanilla.Chat =
{
	Anchor = "BOTTOMLEFT",
	Height = 150,
	Width = 384,
	X = 9,
	Y = 9
}

Configuration.Themes.Vanilla.Focus.Height = 64

Configuration.Themes.Vanilla.Focus.HealthBar.Anchor = "TOPRIGHT"
Configuration.Themes.Vanilla.Focus.HealthBar.Height = 52
Configuration.Themes.Vanilla.Focus.HealthBar.Width = 191
Configuration.Themes.Vanilla.Focus.HealthBar.X = -3

Configuration.Themes.Vanilla.Focus.Portrait =
{
	Anchor = "LEFT",
	Height = 60,
	Orientation = "HORIZONTAL",
	Width = 60,
	X = 3,
	Y = 0
}

Configuration.Themes.Vanilla.Focus.PowerBar.Anchor = "BOTTOMRIGHT"
Configuration.Themes.Vanilla.Focus.PowerBar.Height = 7
Configuration.Themes.Vanilla.Focus.PowerBar.Width = 191
Configuration.Themes.Vanilla.Focus.PowerBar.X = -3

Configuration.Themes.Vanilla.Focus.Initialize = function(Self)
end

Configuration.Themes.Vanilla.Meter.Anchor = "TOPRIGHT"
Configuration.Themes.Vanilla.Meter.Width = 152
Configuration.Themes.Vanilla.Meter.X = -7
Configuration.Themes.Vanilla.Meter.Y = -183

Configuration.Themes.Vanilla.Minimap.Anchor = "TOPRIGHT"
Configuration.Themes.Vanilla.Minimap.Height = 152
Configuration.Themes.Vanilla.Minimap.Width = 152
Configuration.Themes.Vanilla.Minimap.X = -7
Configuration.Themes.Vanilla.Minimap.Y = -7

Configuration.Themes.Vanilla.Minimap.Info.Height = 23
Configuration.Themes.Vanilla.Minimap.Info.Width = 152
Configuration.Themes.Vanilla.Minimap.Info.Y = -20

Configuration.Themes.Vanilla.Player.Anchor = "TOPLEFT"
Configuration.Themes.Vanilla.Player.Height = 64
Configuration.Themes.Vanilla.Player.Width = 256
Configuration.Themes.Vanilla.Player.X = 3
Configuration.Themes.Vanilla.Player.Y = -3

Configuration.Themes.Vanilla.Player.CastingBar.Anchor = "BOTTOMLEFT"
Configuration.Themes.Vanilla.Player.CastingBar.Width = 204
Configuration.Themes.Vanilla.Player.CastingBar.Y = -25

Configuration.Themes.Vanilla.Player.HealthBar.Anchor = "TOPRIGHT"
Configuration.Themes.Vanilla.Player.HealthBar.Height = 52
Configuration.Themes.Vanilla.Player.HealthBar.Width = 191
Configuration.Themes.Vanilla.Player.HealthBar.X = -3

Configuration.Themes.Vanilla.Player.Portrait =
{
	Anchor = "LEFT",
	Height = 60,
	Orientation = "HORIZONTAL",
	Width = 60,
	X = 3,
	Y = 0
}

Configuration.Themes.Vanilla.Player.PowerBar.Anchor = "BOTTOMRIGHT"
Configuration.Themes.Vanilla.Player.PowerBar.Height = 7
Configuration.Themes.Vanilla.Player.PowerBar.Width = 191
Configuration.Themes.Vanilla.Player.PowerBar.X = -3

Configuration.Themes.Vanilla.Raid.Columns = 1
Configuration.Themes.Vanilla.Raid.Height = 40
Configuration.Themes.Vanilla.Raid.Rows = 5
Configuration.Themes.Vanilla.Raid.Shown = true
Configuration.Themes.Vanilla.Raid.ShowSolo = false
Configuration.Themes.Vanilla.Raid.Width = 160

Configuration.Themes.Vanilla.Raid.HealthBar.Anchor = "TOPRIGHT"
Configuration.Themes.Vanilla.Raid.HealthBar.Height = 30
Configuration.Themes.Vanilla.Raid.HealthBar.Orientation = "HORIZONTAL"
Configuration.Themes.Vanilla.Raid.HealthBar.Width = 119
Configuration.Themes.Vanilla.Raid.HealthBar.X = -3
Configuration.Themes.Vanilla.Raid.HealthBar.Y = -3

Configuration.Themes.Vanilla.Raid.HealthBar.Health.SmallText = false
Configuration.Themes.Vanilla.Raid.Portrait =
{
	Anchor = "LEFT",
	Height = 36,
	Orientation = "HORIZONTAL",
	Width = 36,
	X = 3,
	Y = 0
}

Configuration.Themes.Vanilla.Raid.PowerBar =
{
	Anchor = "BOTTOMRIGHT",
	Height = 5,
	Orientation = "HORIZONTAL",
	Width = 119,
	X = -3,
	Y = 3
}

Configuration.Themes.Vanilla.Target.Anchor = "TOPLEFT"
Configuration.Themes.Vanilla.Target.Height = 64
Configuration.Themes.Vanilla.Target.Width = 256
Configuration.Themes.Vanilla.Target.X = 263
Configuration.Themes.Vanilla.Target.Y = -3

Configuration.Themes.Vanilla.Target.CastingBar =
{
	Anchor = "BOTTOMLEFT",
	Height = 24,
	Orientation = "HORIZONTAL",
	Width = 204,
	X = 55,
	Y = -25,

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
}

Configuration.Themes.Vanilla.Target.HealthBar.Anchor = "TOPRIGHT"
Configuration.Themes.Vanilla.Target.HealthBar.Height = 52
Configuration.Themes.Vanilla.Target.HealthBar.Width = 191
Configuration.Themes.Vanilla.Target.HealthBar.X = -3

Configuration.Themes.Vanilla.Target.Portrait =
{
	Anchor = "LEFT",
	Height = 60,
	Orientation = "HORIZONTAL",
	Width = 60,
	X = 3,
	Y = 0
}

Configuration.Themes.Vanilla.Target.PowerBar.Anchor = "BOTTOMRIGHT"
Configuration.Themes.Vanilla.Target.PowerBar.Height = 7
Configuration.Themes.Vanilla.Target.PowerBar.Width = 191
Configuration.Themes.Vanilla.Target.PowerBar.X = -3
