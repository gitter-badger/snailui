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

local Class = select(2, UnitClass("Player"))

function HandleBuffs()
	if GetConfiguration().Buffs then
		hooksecurefunc("AuraButton_UpdateDuration",
			function(Self, TimeLeft)
				if (SHOW_BUFF_DURATIONS == "1") and TimeLeft then
					Self.count:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					Self.duration:SetText(GetDuration(TimeLeft))
					Self.duration:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
					Self.duration:Show()
				else
					Self.duration:Hide()
				end
			end
		)

		BuffFrame:ClearAllPoints()
		BuffFrame:SetPoint(GetConfiguration().Buffs.Anchor, GetConfiguration().Buffs.X, GetConfiguration().Buffs.Y)

		BuffFrame.ClearAllPoints = Blank
		BuffFrame.SetPoint = Blank
	  
		hooksecurefunc("BuffFrame_Update",
			function()
				local GreaterBuff = BUFF_ACTUAL_DISPLAY
	
				if DEBUFF_ACTUAL_DISPLAY > GreaterBuff then
					GreaterBuff = DEBUFF_ACTUAL_DISPLAY
				end
	
				if BuffFrame.numEnchants > GreaterBuff then
					GreaterBuff = BuffFrame.numEnchants
				end
	
				if ((DEBUFF_ACTUAL_DISPLAY > 0) or (BuffFrame.numEnchants > 0)) and (BUFF_ACTUAL_DISPLAY > 0) then
					if GetConfiguration().Buffs.Orientation and (GetConfiguration().Buffs.Orientation == "VERTICAL") then
						BuffFrame:SetSize((GetConfiguration().Buffs.Width * 2) + 4, (GreaterBuff * GetConfiguration().Buffs.Height) + ((GreaterBuff - 1) * 4))
					else
						BuffFrame:SetSize((GreaterBuff * GetConfiguration().Buffs.Width) + ((GreaterBuff - 1) * 4), (GetConfiguration().Buffs.Height * 2) + 4)
					end
				else
					if GetConfiguration().Buffs.Orientation and (GetConfiguration().Buffs.Orientation == "VERTICAL") then
						BuffFrame:SetSize(GetConfiguration().Buffs.Width, (GreaterBuff * GetConfiguration().Buffs.Height) + ((GreaterBuff - 1) * 4))
					else
						BuffFrame:SetSize((GreaterBuff * GetConfiguration().Buffs.Width) + ((GreaterBuff - 1) * 4), GetConfiguration().Buffs.Height)
					end
				end
	
				for I = 1, BUFF_ACTUAL_DISPLAY do
					_G["BuffButton" .. I]:ClearAllPoints()
					_G["BuffButton" .. I]:SetSize(GetConfiguration().Buffs.Width - 6, GetConfiguration().Buffs.Height - 6)
	
					if GetConfiguration().Buffs.Orientation and (GetConfiguration().Buffs.Orientation == "VERTICAL") then
						_G["BuffButton" .. I]:SetPoint("TOPRIGHT", -3, -(((I - 1) * GetConfiguration().Buffs.Height) + ((I - 1) * 4) + 3))
					else
						_G["BuffButton" .. I]:SetPoint("TOPRIGHT", -(((I - 1) * GetConfiguration().Buffs.Width) + ((I - 1) * 4) + 3), -3)
					end
	
					_G["BuffButton" .. I].ClearAllPoints = Blank
					_G["BuffButton" .. I].SetPoint = Blank
	
					if not  _G["BuffButton" .. I].BackgroundBottom then
						_G["BuffButton" .. I].BackgroundBottom = _G["BuffButton" .. I]:CreateTexture(nil, "LOW")
						_G["BuffButton" .. I].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
						_G["BuffButton" .. I].BackgroundBottom:SetSize(GetConfiguration().Buffs.Width - 2, 1)
						_G["BuffButton" .. I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["BuffButton" .. I].BackgroundLeft = _G["BuffButton" .. I]:CreateTexture(nil, "LOW")
						_G["BuffButton" .. I].BackgroundLeft:SetPoint("LEFT", -2, 0)
						_G["BuffButton" .. I].BackgroundLeft:SetSize(1, GetConfiguration().Buffs.Height - 4)
						_G["BuffButton" .. I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["BuffButton" .. I].BackgroundRight = _G["BuffButton" .. I]:CreateTexture(nil, "LOW")
						_G["BuffButton" .. I].BackgroundRight:SetPoint("RIGHT", 2, 0)
						_G["BuffButton" .. I].BackgroundRight:SetSize(1, GetConfiguration().Buffs.Height - 4)
						_G["BuffButton" .. I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["BuffButton" .. I].BackgroundTop = _G["BuffButton" .. I]:CreateTexture(nil, "LOW")
						_G["BuffButton" .. I].BackgroundTop:SetPoint("TOP", 0, 2)
						_G["BuffButton" .. I].BackgroundTop:SetSize(GetConfiguration().Buffs.Width - 2, 1)
						_G["BuffButton" .. I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["BuffButton" .. I].BorderBottom = _G["BuffButton" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["BuffButton" .. I].BorderBottom:SetPoint("BOTTOM", 0, -3)
						_G["BuffButton" .. I].BorderBottom:SetSize(GetConfiguration().Buffs.Width, 3)
						_G["BuffButton" .. I].BorderBottom:SetTexture(0, 0, 0)
	
						_G["BuffButton" .. I].BorderLeft = _G["BuffButton" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["BuffButton" .. I].BorderLeft:SetPoint("LEFT", -3, 0)
						_G["BuffButton" .. I].BorderLeft:SetSize(3, GetConfiguration().Buffs.Height - 2)
						_G["BuffButton" .. I].BorderLeft:SetTexture(0, 0, 0)
	
						_G["BuffButton" .. I].BorderRight = _G["BuffButton" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["BuffButton" .. I].BorderRight:SetPoint("RIGHT", 3, 0)
						_G["BuffButton" .. I].BorderRight:SetSize(3, GetConfiguration().Buffs.Height - 2)
						_G["BuffButton" .. I].BorderRight:SetTexture(0, 0, 0)
	
						_G["BuffButton" .. I].BorderTop = _G["BuffButton" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["BuffButton" .. I].BorderTop:SetPoint("TOP", 0, 3)
						_G["BuffButton" .. I].BorderTop:SetSize(GetConfiguration().Buffs.Width, 3)
						_G["BuffButton" .. I].BorderTop:SetTexture(0, 0, 0)
					end

					_G["BuffButton" .. I .. "Count"]:ClearAllPoints()
					_G["BuffButton" .. I .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
					_G["BuffButton" .. I .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)
	
					_G["BuffButton" .. I .. "Duration"]:ClearAllPoints()
					_G["BuffButton" .. I .. "Duration"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
					_G["BuffButton" .. I .. "Duration"]:SetPoint("CENTER", 2, 0)
					_G["BuffButton" .. I .. "Duration"]:SetShadowOffset(0, 0)
	
					_G["BuffButton" .. I .. "Icon"]:SetTexCoord(GetConfiguration().Buffs.TextureCoordinate.Left, GetConfiguration().Buffs.TextureCoordinate.Right, GetConfiguration().Buffs.TextureCoordinate.Top, GetConfiguration().Buffs.TextureCoordinate.Bottom)
				end
	
				for I = 1, DEBUFF_ACTUAL_DISPLAY do
					_G["DebuffButton" .. I]:ClearAllPoints()
					_G["DebuffButton" .. I]:SetSize(GetConfiguration().Buffs.Width - 6, GetConfiguration().Buffs.Height - 6)
	
					if GetConfiguration().Buffs.Orientation and (GetConfiguration().Buffs.Orientation == "VERTICAL") then
						_G["DebuffButton" .. I]:SetPoint("TOPLEFT", 3, -(((I - 1) * GetConfiguration().Buffs.Height) + ((I - 1) * 4) + 3))
					else
						_G["DebuffButton" .. I]:SetPoint("BOTTOMRIGHT", -(((I - 1) * GetConfiguration().Buffs.Width) + ((I - 1) * 4) + 3), 3)
					end
	
					_G["DebuffButton" .. I].ClearAllPoints = Blank
					_G["DebuffButton" .. I].SetPoint = Blank
	
					if not  _G["DebuffButton" .. I].BackgroundBottom then
						_G["DebuffButton" .. I].BackgroundBottom = _G["DebuffButton" .. I]:CreateTexture(nil, "LOW")
						_G["DebuffButton" .. I].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
						_G["DebuffButton" .. I].BackgroundBottom:SetSize(GetConfiguration().Buffs.Width - 2, 1)
						_G["DebuffButton" .. I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["DebuffButton" .. I].BackgroundLeft = _G["DebuffButton" .. I]:CreateTexture(nil, "LOW")
						_G["DebuffButton" .. I].BackgroundLeft:SetPoint("LEFT", -2, 0)
						_G["DebuffButton" .. I].BackgroundLeft:SetSize(1, GetConfiguration().Buffs.Height - 4)
						_G["DebuffButton" .. I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["DebuffButton" .. I].BackgroundRight = _G["DebuffButton" .. I]:CreateTexture(nil, "LOW")
						_G["DebuffButton" .. I].BackgroundRight:SetPoint("RIGHT", 2, 0)
						_G["DebuffButton" .. I].BackgroundRight:SetSize(1, GetConfiguration().Buffs.Height - 4)
						_G["DebuffButton" .. I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["DebuffButton" .. I].BackgroundTop = _G["DebuffButton" .. I]:CreateTexture(nil, "LOW")
						_G["DebuffButton" .. I].BackgroundTop:SetPoint("TOP", 0, 2)
						_G["DebuffButton" .. I].BackgroundTop:SetSize(GetConfiguration().Buffs.Width - 2, 1)
						_G["DebuffButton" .. I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["DebuffButton" .. I].BorderBottom = _G["DebuffButton" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["DebuffButton" .. I].BorderBottom:SetPoint("BOTTOM", 0, -3)
						_G["DebuffButton" .. I].BorderBottom:SetSize(GetConfiguration().Buffs.Width, 3)
						_G["DebuffButton" .. I].BorderBottom:SetTexture(0, 0, 0)
	
						_G["DebuffButton" .. I].BorderLeft = _G["DebuffButton" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["DebuffButton" .. I].BorderLeft:SetPoint("LEFT", -3, 0)
						_G["DebuffButton" .. I].BorderLeft:SetSize(3, GetConfiguration().Buffs.Height - 2)
						_G["DebuffButton" .. I].BorderLeft:SetTexture(0, 0, 0)
	
						_G["DebuffButton" .. I].BorderRight = _G["DebuffButton" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["DebuffButton" .. I].BorderRight:SetPoint("RIGHT", 3, 0)
						_G["DebuffButton" .. I].BorderRight:SetSize(3, GetConfiguration().Buffs.Height - 2)
						_G["DebuffButton" .. I].BorderRight:SetTexture(0, 0, 0)
	
						_G["DebuffButton" .. I].BorderTop = _G["DebuffButton" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["DebuffButton" .. I].BorderTop:SetPoint("TOP", 0, 3)
						_G["DebuffButton" .. I].BorderTop:SetSize(GetConfiguration().Buffs.Width, 3)
						_G["DebuffButton" .. I].BorderTop:SetTexture(0, 0, 0)
					end
	
					_G["DebuffButton" .. I .. "Border"]:Hide()
	
					_G["DebuffButton" .. I .. "Count"]:ClearAllPoints()
					_G["DebuffButton" .. I .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
					_G["DebuffButton" .. I .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)
	
					_G["DebuffButton" .. I .. "Duration"]:ClearAllPoints()
					_G["DebuffButton" .. I .. "Duration"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
					_G["DebuffButton" .. I .. "Duration"]:SetPoint("CENTER", 2, 0)
					_G["DebuffButton" .. I .. "Duration"]:SetShadowOffset(0, 0)
	
					_G["DebuffButton" .. I .. "Icon"]:SetTexCoord(GetConfiguration().Buffs.TextureCoordinate.Left, GetConfiguration().Buffs.TextureCoordinate.Right, GetConfiguration().Buffs.TextureCoordinate.Top, GetConfiguration().Buffs.TextureCoordinate.Bottom)
				end
	
				for I = 1, BuffFrame.numEnchants do
					_G["TempEnchant" .. I]:ClearAllPoints()
					_G["TempEnchant" .. I]:SetParent(BuffFrame)
					_G["TempEnchant" .. I]:SetSize(GetConfiguration().Buffs.Width - 6, GetConfiguration().Buffs.Height - 6)
	
					if DEBUFF_ACTUAL_DISPLAY > 0 then
						if GetConfiguration().Buffs.Orientation and (GetConfiguration().Buffs.Orientation == "VERTICAL") then
							_G["TempEnchant" .. I]:SetPoint("TOPLEFT", -33, -(((I - 1) * GetConfiguration().Buffs.Height) + ((I - 1) * 4) + 3))
						else
							_G["TempEnchant" .. I]:SetPoint("BOTTOMRIGHT", -(((I - 1) * GetConfiguration().Buffs.Width) + ((I - 1) * 4) + 3), -33)
						end
					else
						if GetConfiguration().Buffs.Orientation and (GetConfiguration().Buffs.Orientation == "VERTICAL") then
							_G["TempEnchant" .. I]:SetPoint("TOPLEFT", 3, -(((I - 1) * GetConfiguration().Buffs.Height) + ((I - 1) * 4) + 3))
						else
							_G["TempEnchant" .. I]:SetPoint("BOTTOMRIGHT", -(((I - 1) * GetConfiguration().Buffs.Width) + ((I - 1) * 4) + 3), 3)
						end
					end
	
					_G["TempEnchant" .. I].ClearAllPoints = Blank
					_G["TempEnchant" .. I].SetPoint = Blank
	
					if not  _G["TempEnchant" .. I].BackgroundBottom then
						_G["TempEnchant" .. I].BackgroundBottom = _G["TempEnchant" .. I]:CreateTexture(nil, "LOW")
						_G["TempEnchant" .. I].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
						_G["TempEnchant" .. I].BackgroundBottom:SetSize(GetConfiguration().Buffs.Width - 2, 1)
						_G["TempEnchant" .. I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["TempEnchant" .. I].BackgroundLeft = _G["TempEnchant" .. I]:CreateTexture(nil, "LOW")
						_G["TempEnchant" .. I].BackgroundLeft:SetPoint("LEFT", -2, 0)
						_G["TempEnchant" .. I].BackgroundLeft:SetSize(1, GetConfiguration().Buffs.Height - 4)
						_G["TempEnchant" .. I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["TempEnchant" .. I].BackgroundRight = _G["TempEnchant" .. I]:CreateTexture(nil, "LOW")
						_G["TempEnchant" .. I].BackgroundRight:SetPoint("RIGHT", 2, 0)
						_G["TempEnchant" .. I].BackgroundRight:SetSize(1, GetConfiguration().Buffs.Height - 4)
						_G["TempEnchant" .. I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["TempEnchant" .. I].BackgroundTop = _G["TempEnchant" .. I]:CreateTexture(nil, "LOW")
						_G["TempEnchant" .. I].BackgroundTop:SetPoint("TOP", 0, 2)
						_G["TempEnchant" .. I].BackgroundTop:SetSize(GetConfiguration().Buffs.Width - 2, 1)
						_G["TempEnchant" .. I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
	
						_G["TempEnchant" .. I].BorderBottom = _G["TempEnchant" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["TempEnchant" .. I].BorderBottom:SetPoint("BOTTOM", 0, -3)
						_G["TempEnchant" .. I].BorderBottom:SetSize(GetConfiguration().Buffs.Width, 3)
						_G["TempEnchant" .. I].BorderBottom:SetTexture(0, 0, 0)
	
						_G["TempEnchant" .. I].BorderLeft = _G["TempEnchant" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["TempEnchant" .. I].BorderLeft:SetPoint("LEFT", -3, 0)
						_G["TempEnchant" .. I].BorderLeft:SetSize(3, GetConfiguration().Buffs.Height - 2)
						_G["TempEnchant" .. I].BorderLeft:SetTexture(0, 0, 0)
	
						_G["TempEnchant" .. I].BorderRight = _G["TempEnchant" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["TempEnchant" .. I].BorderRight:SetPoint("RIGHT", 3, 0)
						_G["TempEnchant" .. I].BorderRight:SetSize(3, GetConfiguration().Buffs.Height - 2)
						_G["TempEnchant" .. I].BorderRight:SetTexture(0, 0, 0)
	
						_G["TempEnchant" .. I].BorderTop = _G["TempEnchant" .. I]:CreateTexture(nil, "BACKGROUND")
						_G["TempEnchant" .. I].BorderTop:SetPoint("TOP", 0, 3)
						_G["TempEnchant" .. I].BorderTop:SetSize(GetConfiguration().Buffs.Width, 3)
						_G["TempEnchant" .. I].BorderTop:SetTexture(0, 0, 0)
					end
	
					_G["TempEnchant" .. I .. "Border"]:Hide()
	
					_G["TempEnchant" .. I .. "Count"]:ClearAllPoints()
					_G["TempEnchant" .. I .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
					_G["TempEnchant" .. I .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)
	
					_G["TempEnchant" .. I .. "Duration"]:ClearAllPoints()
					_G["TempEnchant" .. I .. "Duration"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
					_G["TempEnchant" .. I .. "Duration"]:SetPoint("CENTER", 2, 0)
					_G["TempEnchant" .. I .. "Duration"]:SetShadowOffset(0, 0)
	
					_G["TempEnchant" .. I .. "Icon"]:SetTexCoord(GetConfiguration().Buffs.TextureCoordinate.Left, GetConfiguration().Buffs.TextureCoordinate.Right, GetConfiguration().Buffs.TextureCoordinate.Top, GetConfiguration().Buffs.TextureCoordinate.Bottom)
				end
			end
		)
	end
end
