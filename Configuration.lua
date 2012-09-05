-- Configuration.lua
-- Written by Snail

Configuration =
{
	inactiveAlpha = 0.1,
	texture = [[Interface\AddOns\SnailUI\SnailUI]],

	Font =
	{
		name = [[Interface\AddOns\SnailUI\SnailUI.ttf]],
		outline = 'MONOCHROME, OUTLINE',
		size = 8,
	},

	----------------------------------------

	ActionBars =
	{
		Player =
		{
			anchor = 'BOTTOM',
			buttons = 10,
			height = 24,
			width = 48,
			x = 0,
			y = 108,

			TextureCoordinate =
			{
				bottom = 0.7,
				left = 0.1,
				right = 0.9,
				top = 0.3
			}
		}
	},

	Minimap =
	{
		anchor = 'TOPRIGHT',
		height = 192,
		width = 192,
		x = -7,
		y = -7,

		Clock =
		{
			anchor ='BOTTOM',
			x = 2,
			y = 6
		},

		MailButton =
		{
			anchor ='BOTTOMRIGHT',
			x = 1,
			y = -2
		},

		TrackingButton =
		{
			anchor ='TOPLEFT',
			x = -1,
			y = 0
		},

		QueueStatusButton =
		{
			anchor ='BOTTOMLEFT',
			x = 0,
			y = 0
		},
	},
	
	Player =
	{
		anchor = 'BOTTOM',
		height = 24,
		width = 256,
		x = -130,
		y = 136,

		CastingBar =
		{
			anchor = 'TOPLEFT',
			height = 24,
			orientation = 'HORIZONTAL',
			width = 516,
			x = 3,
			y = 25
		},

		HealthBar =
		{
			anchor = 'TOP',
			height = 15,
			width = 252,
			x = 0,
			y = -3,

			Text =
			{
				anchor ='CENTER',
				x = 1,
				y = 0
			}
		},

		PowerBar =
		{
			anchor = 'BOTTOM',
			height = 4,
			width = 252,
			x = 0,
			y = 3
		},

		RuneBar =
		{
			anchor = 'TOPLEFT',
			height = 24,
			width = 516,
			x = 1,
			y = 27,

			[1] =
			{
				anchor = 'TOPLEFT',
				height = 13,
				width = 85,
				x = 2,
				y = -2
			},

			[2] =
			{
				anchor = 'TOPLEFT',
				height = 13,
				width = 84,
				x = 88,
				y = -2
			},

			[3] =
			{
				anchor = 'TOP',
				height = 13,
				width = 84,
				x = -43,
				y = -2
			},

			[4] =
			{
				anchor = 'TOP',
				height = 13,
				width = 84,
				x = 42,
				y = -2
			},

			[5] =
			{
				anchor = 'TOPRIGHT',
				height = 13,
				width = 85,
				x = -88,
				y = -2
			},

			[6] =
			{
				anchor = 'TOPRIGHT',
				height = 13,
				width = 85,
				x = -2,
				y = -2
			}
		}
	},

	Raid =
	{
		anchor = 'LEFT',
		columnAnchor = 'LEFT',
		columns = 1,
		columnSpacing = 4,
		columnX = 4,
		columnY = -4,
		groupBy = 'GROUP',
		groupOrder = '1, 2, 3, 4, 5, 6, 7, 8',
		healthThreshold = 90,
		height = 24,
		rows = 40,
		showParty = true,
		showPlayer = true,
		showRaid = true,
		showSolo = true,
		width = 100,
		x = 4,
		y = 0,

		HealthBar =
		{
			anchor = 'CENTER',
			height = 20,
			width = 96,
			x = 0,
			y = 0,

			Text =
			{
				anchor ='CENTER',
				x = 1,
				y = 0
			}
		}
	},

	Target =
	{
		anchor = 'BOTTOM',
		height = 24,
		width = 256,
		x = 130,
		y = 136,

		CastingBar =
		{
			anchor = 'TOPRIGHT',
			height = 52,
			orientation = 'VERTICAL',
			width = 8,
			x = 9,
			y = -3
		},

		HealthBar =
		{
			anchor = 'TOP',
			height = 15,
			width = 252,
			x = 0,
			y = -3,

			Text =
			{
				anchor ='CENTER',
				x = 1,
				y = 0
			}
		},

		PowerBar =
		{
			anchor = 'BOTTOM',
			height = 4,
			width = 252,
			x = 0,
			y = 3
		}
	}
}
