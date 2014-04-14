-- Configuration.lua
-- Written by Snail

Configuration =
{
	GoTexture = "Interface\\AddOns\\SnailUI\\Media\\Go.tga",
	GoTextureGlow = "Interface\\AddOns\\SnailUI\\Media\\GoGlow.tga",
	InactiveAlpha = 0.25,
	Texture = "Interface\\AddOns\\SnailUI\\Media\\SnailUI.tga",
	Theme = "Compact",

	Font =
	{
		Name = "Interface\\AddOns\\SnailUI\\Media\\SnailUI.ttf",
		Outline = "MONOCHROME, OUTLINE",
		Size = 8,
	},

	Themes = {}
}

if not Data then
	Data = {}
end

if not Options then
	Options =
	{
		EnableRaidFrames = true,
		HideGuildSpam = true
	}
end

if not Options.Theme then
	Options.Theme = Configuration.Theme
elseif Options.Theme == "Default" then
	Options.Theme = Configuration.Theme
end
