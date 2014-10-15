--
-- Copyright (C) 2012-2014 Snailsoft <http://www.snailsoft.me/>
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at your
-- option) any later version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details.
--
-- You should have received a copy of the GNU General Public License along
-- with this program. If not, see <http://www.gnu.org/licenses/>.
--

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
