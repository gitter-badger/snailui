-- Configuration.lua
-- Written by Snail

Configuration =
{
	GoTexture = "Interface\\AddOns\\SnailUI\\Media\\Go.tga",
	GoTextureGlow = "Interface\\AddOns\\SnailUI\\Media\\GoGlow.tga",
	InactiveAlpha = 0.25,
	Texture = "Interface\\AddOns\\SnailUI\\Media\\SnailUI.tga",
	Theme = "Default",

	Font =
	{
		Name = "Interface\\AddOns\\SnailUI\\Media\\SnailUI.ttf",
		Outline = "MONOCHROME, OUTLINE",
		Size = 8,
	},

	Themes = {}
}

if Configuration.EnableThreatColorsOnAllFrames then
	EnableThreatColorsOnAllFrames = Configuration.EnableThreatColorsOnAllFrames
end

if not Theme then
	Theme = Configuration.Theme
end
