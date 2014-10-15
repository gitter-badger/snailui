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

function HandleBag()
	if GetConfiguration().Bag then
		local Class = select(2, UnitClass("Player"))

		ContainerFrame1.Bag = CreateFrame("Frame", nil, ContainerFrame1)
		ContainerFrame1.Bag:SetPoint(GetConfiguration().Bag.Anchor, UIParent, GetConfiguration().Bag.X, GetConfiguration().Bag.Y)

		ContainerFrame1MoneyFrame:ClearAllPoints()
		ContainerFrame1MoneyFrame:SetHeight(GetConfiguration().Bag.Height)
		ContainerFrame1MoneyFrame:SetPoint("BOTTOMRIGHT", ContainerFrame1.Bag, 0, 1)

		ContainerFrame1MoneyFrame.BackgroundBottom = ContainerFrame1MoneyFrame:CreateTexture(nil, "LOW")
		ContainerFrame1MoneyFrame.BackgroundBottom:SetPoint("BOTTOMRIGHT", ContainerFrame1MoneyFrame, 0, -1)
		ContainerFrame1MoneyFrame.BackgroundBottom:SetSize(1 + (GetConfiguration().Bag.Columns * (GetConfiguration().Bag.Width + 1)), 1)
		ContainerFrame1MoneyFrame.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		ContainerFrame1MoneyFrame.BackgroundRight = ContainerFrame1MoneyFrame:CreateTexture(nil, "LOW")
		ContainerFrame1MoneyFrame.BackgroundRight:SetPoint("RIGHT", ContainerFrame1MoneyFrame)
		ContainerFrame1MoneyFrame.BackgroundRight:SetSize(1, GetConfiguration().Bag.Height)
		ContainerFrame1MoneyFrame.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		ContainerFrame1MoneyFrame.BackgroundTop = ContainerFrame1MoneyFrame:CreateTexture(nil, "LOW")
		ContainerFrame1MoneyFrame.BackgroundTop:SetPoint("TOPRIGHT", ContainerFrame1MoneyFrame, 0, 1)
		ContainerFrame1MoneyFrame.BackgroundTop:SetSize(1 + (GetConfiguration().Bag.Columns * (GetConfiguration().Bag.Width + 1)), 1)
		ContainerFrame1MoneyFrame.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

		ContainerFrame1MoneyFrame.Border = ContainerFrame1MoneyFrame:CreateTexture(nil, "BACKGROUND")
		ContainerFrame1MoneyFrame.Border:SetPoint("TOPRIGHT", ContainerFrame1MoneyFrame, 1, 0)
		ContainerFrame1MoneyFrame.Border:SetSize(3 + (GetConfiguration().Bag.Columns * (GetConfiguration().Bag.Width + 1)), GetConfiguration().Bag.Height + 2)
		ContainerFrame1MoneyFrame.Border:SetTexture(0, 0, 0)

		ContainerFrame1MoneyFrameCopperButtonText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
		ContainerFrame1MoneyFrameGoldButtonText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
		ContainerFrame1MoneyFrameSilverButtonText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)

		SetItemButtonNormalTextureVertexColor = Blank

		for I = 1, NUM_BAG_FRAMES do
			_G["CharacterBag" .. (I - 1) .. "Slot"]:ClearAllPoints()
			_G["CharacterBag" .. (I - 1) .. "Slot"]:SetCheckedTexture(nil)
			_G["CharacterBag" .. (I - 1) .. "Slot"]:SetNormalTexture(nil)
			_G["CharacterBag" .. (I - 1) .. "Slot"]:SetParent(ContainerFrame1.Bag)
			_G["CharacterBag" .. (I - 1) .. "Slot"]:SetSize(GetConfiguration().Bag.Width - 2, GetConfiguration().Bag.Height - 2)

			if I == 1 then
				_G["CharacterBag" .. (I - 1) .. "Slot"]:SetPoint("BOTTOMLEFT", 2, 2)
			else
				_G["CharacterBag" .. (I - 1) .. "Slot"]:SetPoint("BOTTOMLEFT", 2 + ((I - 1) * (GetConfiguration().Bag.Width + 1)), 2)
			end

			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundBottom = _G["CharacterBag" .. (I - 1) .. "Slot"]:CreateTexture(nil, "LOW")
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundBottom:SetPoint("BOTTOM", _G["CharacterBag" .. (I - 1) .. "Slot"], 0, -2)
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundBottom:SetSize(GetConfiguration().Bag.Width + 2 , 1)
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundLeft = _G["CharacterBag" .. (I - 1) .. "Slot"]:CreateTexture(nil, "LOW")
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundLeft:SetPoint("LEFT", _G["CharacterBag" .. (I - 1) .. "Slot"], -2, 0)
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundLeft:SetSize(1, GetConfiguration().Bag.Height)
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundRight = _G["CharacterBag" .. (I - 1) .. "Slot"]:CreateTexture(nil, "LOW")
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundRight:SetPoint("RIGHT", _G["CharacterBag" .. (I - 1) .. "Slot"], 2, 0)
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundRight:SetSize(1, GetConfiguration().Bag.Height)
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundTop = _G["CharacterBag" .. (I - 1) .. "Slot"]:CreateTexture(nil, "LOW")
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundTop:SetPoint("TOP", _G["CharacterBag" .. (I - 1) .. "Slot"], 0, 2)
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundTop:SetSize(GetConfiguration().Bag.Width + 2, 1)
			_G["CharacterBag" .. (I - 1) .. "Slot"].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["CharacterBag" .. (I - 1) .. "Slot"].IconBorder:SetAlpha(0)
			_G["CharacterBag" .. (I - 1) .. "SlotIconTexture"]:SetTexCoord(GetConfiguration().Bag.TextureCoordinate.Left, GetConfiguration().Bag.TextureCoordinate.Right, GetConfiguration().Bag.TextureCoordinate.Top, GetConfiguration().Bag.TextureCoordinate.Bottom)
		end

		for I = NUM_BAG_FRAMES + 1, 1, -1 do
			for J = 1, MAX_CONTAINER_ITEMS do
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetPoint("BOTTOM", _G["ContainerFrame" .. I .. "Item" .. J], 0, -2)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetSize(GetConfiguration().Bag.Width + 2 , 1)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetPoint("LEFT", _G["ContainerFrame" .. I .. "Item" .. J], -2, 0)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetSize(1, GetConfiguration().Bag.Height)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetPoint("RIGHT", _G["ContainerFrame" .. I .. "Item" .. J], 2, 0)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetSize(1, GetConfiguration().Bag.Height)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetPoint("TOP", _G["ContainerFrame" .. I .. "Item" .. J], 0, 2)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetSize(GetConfiguration().Bag.Width + 2, 1)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].Border = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "BACKGROUND")
				_G["ContainerFrame" .. I .. "Item" .. J].Border:SetPoint("TOPLEFT", _G["ContainerFrame" .. I .. "Item" .. J], -3, 3)
				_G["ContainerFrame" .. I .. "Item" .. J].Border:SetSize(GetConfiguration().Bag.Width + 4, GetConfiguration().Bag.Height + 4)
				_G["ContainerFrame" .. I .. "Item" .. J].Border:SetTexture(0, 0, 0)

				_G["ContainerFrame" .. I .. "Item" .. J].Text = _G["ContainerFrame" .. I .. "Item" .. J .. "Cooldown"]:CreateFontString(nil, "OVERLAY")
				_G["ContainerFrame" .. I .. "Item" .. J].Text:Hide()
				_G["ContainerFrame" .. I .. "Item" .. J].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				_G["ContainerFrame" .. I .. "Item" .. J].Text:SetPoint("CENTER", 1, 0)
				_G["ContainerFrame" .. I .. "Item" .. J].Text:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J .. "Cooldown"]:SetScript("OnHide",
					function(Self)
						Self:SetScript("OnUpdate", nil)
					end
				)

				_G["ContainerFrame" .. I .. "Item" .. J .. "Cooldown"]:SetScript("OnShow",
					function(Self)
						Self:SetScript("OnUpdate",
							function(Self, ElapsedTime)
								Self = Self:GetParent()

								if not Self.Time then
									Self.Time = 0
								end

								if (Self.Time + ElapsedTime) >= 0.1 then
									if Self.Text then
										local Start, Duration = GetContainerItemCooldown(Self:GetParent():GetID(), Self:GetID())

										if Duration and (Duration > 2) then
											if (GetTime() - Start) < Duration then
												Self.Text:SetText(GetDuration(Duration - (GetTime() - Start)))
												Self.Text:Show()
											end
										else
											Self.Text:Hide()
											Self:SetScript("OnUpdate", nil)
										end
									else
										Self:SetScript("OnUpdate", nil)
									end

									Self.Time = 0
								else
									Self.Time = Self.Time + ElapsedTime
								end
							end
						)
					end
				)

				_G["ContainerFrame" .. I .. "Item" .. J].IconBorder:SetAlpha(0)

				_G["ContainerFrame" .. I .. "Item" .. J .. "Count"]:ClearAllPoints()
				_G["ContainerFrame" .. I .. "Item" .. J .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				_G["ContainerFrame" .. I .. "Item" .. J .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)

				_G["ContainerFrame" .. I .. "Item" .. J .. "IconTexture"]:SetTexCoord(GetConfiguration().Bag.TextureCoordinate.Left, GetConfiguration().Bag.TextureCoordinate.Right, GetConfiguration().Bag.TextureCoordinate.Top, GetConfiguration().Bag.TextureCoordinate.Bottom)
				_G["ContainerFrame" .. I .. "Item" .. J .. "IconQuestTexture"]:SetAlpha(0)
			end
		end

		BagSlotButton_OnModifiedClick = Blank
		BagSlotButton_OnClick = function(Self)
			PutItemInBag(Self:GetID())
		end

		for I = NUM_BAG_FRAMES + 1, 1, -1 do
			_G["ContainerFrame" .. I]:ClearAllPoints()
			_G["ContainerFrame" .. I]:SetPoint("TOPLEFT", UIParent, -500, 500)

			_G["ContainerFrame" .. I].ClearAllPoints = Blank
			_G["ContainerFrame" .. I].SetPoint = Blank
		end

		local function OpenBags()
			local CurrentColumn = 1
			local CurrentRow = 1
			local TotalBagSlots = 0

			for I = 0, NUM_BAG_FRAMES do
				TotalBagSlots = TotalBagSlots + GetContainerNumSlots(I)
			end

			Rows = math.floor(TotalBagSlots / GetConfiguration().Bag.Columns)

			if (TotalBagSlots % GetConfiguration().Bag.Columns) ~= 0 then
				Rows = Rows + 1
			end

			ContainerFrame1.Bag:SetSize(1 + (GetConfiguration().Bag.Columns * (GetConfiguration().Bag.Width + 1)), 26 + (Rows * (GetConfiguration().Bag.Height + 1)))

			local Bags = NUM_BAG_SLOTS + 1

			for I = NUM_BAG_SLOTS + 1, 1, -1 do
				if GetContainerNumSlots(I - 1) == 0 then
					Bags = Bags - 1
				end
			end

			ContainerFrame1MoneyFrame:SetFrameLevel(ContainerFrame1:GetFrameLevel())

			for I = 1, NUM_BAG_FRAMES do
				_G["CharacterBag" .. (I - 1) .. "Slot"]:SetFrameLevel(ContainerFrame1:GetFrameLevel())
			end

			for I = Bags, 1, -1 do
				for J = 1, GetContainerNumSlots(_G["ContainerFrame" .. I]:GetID()) do
					_G["ContainerFrame" .. I .. "Item" .. J]:ClearAllPoints()
					_G["ContainerFrame" .. I .. "Item" .. J]:SetFrameLevel(ContainerFrame1:GetFrameLevel())
					_G["ContainerFrame" .. I .. "Item" .. J]:SetNormalTexture(nil)
					_G["ContainerFrame" .. I .. "Item" .. J]:SetSize(GetConfiguration().Bag.Width - 2, GetConfiguration().Bag.Height - 2)

					if (I == Bags) and (J == 1) then
						_G["ContainerFrame" .. I .. "Item" .. J]:SetPoint("BOTTOMRIGHT", ContainerFrame1.Bag, -2, 27)
					else
						_G["ContainerFrame" .. I .. "Item" .. J]:SetPoint("BOTTOMRIGHT", ContainerFrame1.Bag, -(2 + ((CurrentColumn - 1) * (GetConfiguration().Bag.Width + 1))), 27 + ((CurrentRow - 1) * (GetConfiguration().Bag.Height + 1)))
					end

					if CurrentColumn == GetConfiguration().Bag.Columns then
						CurrentColumn = 1
						CurrentRow = CurrentRow + 1
					else
						CurrentColumn = CurrentColumn + 1
					end
				end
			end
		end

		local OriginalOpenAllBags = OpenAllBags

		OpenAllBags = function(Self)
			OriginalOpenAllBags(Self)
			OpenBags()
		end

		local OriginalToggleAllBags = ToggleAllBags

		ToggleAllBags = function(Self)
			OriginalToggleAllBags(Self)
			OpenBags()
		end
	end
end
