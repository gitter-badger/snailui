--
-- Copyright (C) 2012-2015 Snail <https://github.com/snail23/snailui/>
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

local _

function HandleBank()
	if GetConfiguration().Bank then
		local Class = select(2, UnitClass("Player"))

		BankFrame.Bag = CreateFrame("Frame", nil, BankFrame)
		BankFrame.Bag:SetPoint(GetConfiguration().Bank.Anchor, UIParent, GetConfiguration().Bank.X, GetConfiguration().Bank.Y)

		for I = 1, NUM_BANKBAGSLOTS do
			BankSlotsFrame["Bag" .. I]:ClearAllPoints()
			BankSlotsFrame["Bag" .. I]:SetNormalTexture(nil)
			BankSlotsFrame["Bag" .. I]:SetParent(BankFrame.Bag)
			BankSlotsFrame["Bag" .. I]:SetSize(GetConfiguration().Bank.Width - 2, GetConfiguration().Bank.Height - 2)

			if I == 1 then
				BankSlotsFrame["Bag" .. I]:SetPoint("BOTTOMLEFT", 2, 2)
			else
				BankSlotsFrame["Bag" .. I]:SetPoint("BOTTOMLEFT", 2 + ((I - 1) * (GetConfiguration().Bank.Width + 1)), 2)
			end

			BankSlotsFrame["Bag" .. I].BackgroundBottom = BankSlotsFrame["Bag" .. I]:CreateTexture(nil, "LOW")
			BankSlotsFrame["Bag" .. I].BackgroundBottom:SetPoint("BOTTOM", BankSlotsFrame["Bag" .. I], 0, -2)
			BankSlotsFrame["Bag" .. I].BackgroundBottom:SetSize(GetConfiguration().Bank.Width + 2 , 1)
			BankSlotsFrame["Bag" .. I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			BankSlotsFrame["Bag" .. I].BackgroundLeft = BankSlotsFrame["Bag" .. I]:CreateTexture(nil, "LOW")
			BankSlotsFrame["Bag" .. I].BackgroundLeft:SetPoint("LEFT", BankSlotsFrame["Bag" .. I], -2, 0)
			BankSlotsFrame["Bag" .. I].BackgroundLeft:SetSize(1, GetConfiguration().Bank.Height)
			BankSlotsFrame["Bag" .. I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			BankSlotsFrame["Bag" .. I].BackgroundRight = BankSlotsFrame["Bag" .. I]:CreateTexture(nil, "LOW")
			BankSlotsFrame["Bag" .. I].BackgroundRight:SetPoint("RIGHT", BankSlotsFrame["Bag" .. I], 2, 0)
			BankSlotsFrame["Bag" .. I].BackgroundRight:SetSize(1, GetConfiguration().Bank.Height)
			BankSlotsFrame["Bag" .. I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			BankSlotsFrame["Bag" .. I].BackgroundTop = BankSlotsFrame["Bag" .. I]:CreateTexture(nil, "LOW")
			BankSlotsFrame["Bag" .. I].BackgroundTop:SetPoint("TOP", BankSlotsFrame["Bag" .. I], 0, 2)
			BankSlotsFrame["Bag" .. I].BackgroundTop:SetSize(GetConfiguration().Bank.Width + 2, 1)
			BankSlotsFrame["Bag" .. I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			BankSlotsFrame["Bag" .. I].Border = BankSlotsFrame["Bag" .. I]:CreateTexture(nil, "BACKGROUND")
			BankSlotsFrame["Bag" .. I].Border:SetPoint("TOPLEFT", BankSlotsFrame["Bag" .. I], -3, 3)
			BankSlotsFrame["Bag" .. I].Border:SetSize(GetConfiguration().Bank.Width + 4, GetConfiguration().Bank.Height + 4)
			BankSlotsFrame["Bag" .. I].Border:SetTexture(0, 0, 0)

			BankSlotsFrame["Bag" .. I].icon:SetTexCoord(GetConfiguration().Bank.TextureCoordinate.Left, GetConfiguration().Bank.TextureCoordinate.Right, GetConfiguration().Bank.TextureCoordinate.Top, GetConfiguration().Bank.TextureCoordinate.Bottom)
			BankSlotsFrame["Bag" .. I].IconBorder:SetAlpha(0)
		end

		for I = NUM_BANKGENERIC_SLOTS, 1, -1 do
			_G["BankFrameItem" .. I].BackgroundBottom = _G["BankFrameItem" .. I]:CreateTexture(nil, "LOW")
			_G["BankFrameItem" .. I].BackgroundBottom:SetPoint("BOTTOM", _G["BankFrameItem" .. I], 0, -2)
			_G["BankFrameItem" .. I].BackgroundBottom:SetSize(GetConfiguration().Bank.Width + 2 , 1)
			_G["BankFrameItem" .. I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["BankFrameItem" .. I].BackgroundLeft = _G["BankFrameItem" .. I]:CreateTexture(nil, "LOW")
			_G["BankFrameItem" .. I].BackgroundLeft:SetPoint("LEFT", _G["BankFrameItem" .. I], -2, 0)
			_G["BankFrameItem" .. I].BackgroundLeft:SetSize(1, GetConfiguration().Bank.Height)
			_G["BankFrameItem" .. I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["BankFrameItem" .. I].BackgroundRight = _G["BankFrameItem" .. I]:CreateTexture(nil, "LOW")
			_G["BankFrameItem" .. I].BackgroundRight:SetPoint("RIGHT", _G["BankFrameItem" .. I], 2, 0)
			_G["BankFrameItem" .. I].BackgroundRight:SetSize(1, GetConfiguration().Bank.Height)
			_G["BankFrameItem" .. I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["BankFrameItem" .. I].BackgroundTop = _G["BankFrameItem" .. I]:CreateTexture(nil, "LOW")
			_G["BankFrameItem" .. I].BackgroundTop:SetPoint("TOP", _G["BankFrameItem" .. I], 0, 2)
			_G["BankFrameItem" .. I].BackgroundTop:SetSize(GetConfiguration().Bank.Width + 2, 1)
			_G["BankFrameItem" .. I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["BankFrameItem" .. I].Border = _G["BankFrameItem" .. I]:CreateTexture(nil, "BACKGROUND")
			_G["BankFrameItem" .. I].Border:SetPoint("TOPLEFT", _G["BankFrameItem" .. I], -3, 3)
			_G["BankFrameItem" .. I].Border:SetSize(GetConfiguration().Bank.Width + 4, GetConfiguration().Bank.Height + 4)
			_G["BankFrameItem" .. I].Border:SetTexture(0, 0, 0)

			_G["BankFrameItem" .. I].IconBorder:SetAlpha(0)
			_G["BankFrameItem" .. I].IconQuestTexture:SetAlpha(0)

			_G["BankFrameItem" .. I].Text = _G["BankFrameItem" .. I .. "Cooldown"]:CreateFontString(nil, "OVERLAY")
			_G["BankFrameItem" .. I].Text:Hide()
			_G["BankFrameItem" .. I].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
			_G["BankFrameItem" .. I].Text:SetPoint("CENTER", 1, 0)
			_G["BankFrameItem" .. I].Text:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["BankFrameItem" .. I .. "Cooldown"]:SetScript("OnHide",
				function(Self)
					Self:SetScript("OnUpdate", nil)
				end
			)

			_G["BankFrameItem" .. I .. "Cooldown"]:SetScript("OnShow",
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

			_G["BankFrameItem" .. I .. "Count"]:ClearAllPoints()
			_G["BankFrameItem" .. I .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
			_G["BankFrameItem" .. I .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)

			_G["BankFrameItem" .. I .. "IconTexture"]:SetTexCoord(GetConfiguration().Bank.TextureCoordinate.Left, GetConfiguration().Bank.TextureCoordinate.Right, GetConfiguration().Bank.TextureCoordinate.Top, GetConfiguration().Bank.TextureCoordinate.Bottom)
			_G["BankFrameItem" .. I .. "NormalTexture"]:SetAlpha(0)
		end

		for I = (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) + 1, NUM_BAG_SLOTS + 2, -1 do
			for J = 1, MAX_CONTAINER_ITEMS do
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetPoint("BOTTOM", _G["ContainerFrame" .. I .. "Item" .. J], 0, -2)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetSize(GetConfiguration().Bank.Width + 2 , 1)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetPoint("LEFT", _G["ContainerFrame" .. I .. "Item" .. J], -2, 0)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetSize(1, GetConfiguration().Bank.Height)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetPoint("RIGHT", _G["ContainerFrame" .. I .. "Item" .. J], 2, 0)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetSize(1, GetConfiguration().Bank.Height)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetPoint("TOP", _G["ContainerFrame" .. I .. "Item" .. J], 0, 2)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetSize(GetConfiguration().Bank.Width + 2, 1)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].Border = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "BACKGROUND")
				_G["ContainerFrame" .. I .. "Item" .. J].Border:SetPoint("TOPLEFT", _G["ContainerFrame" .. I .. "Item" .. J], -3, 3)
				_G["ContainerFrame" .. I .. "Item" .. J].Border:SetSize(GetConfiguration().Bank.Width + 4, GetConfiguration().Bank.Height + 4)
				_G["ContainerFrame" .. I .. "Item" .. J].Border:SetTexture(0, 0, 0)

				_G["ContainerFrame" .. I .. "Item" .. J].JunkIcon:SetAlpha(0)
				_G["ContainerFrame" .. I .. "Item" .. J].IconBorder:SetAlpha(0)

				_G["ContainerFrame" .. I .. "Item" .. J].NewItemTexture.Show = Blank

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

				_G["ContainerFrame" .. I .. "Item" .. J .. "Count"]:ClearAllPoints()
				_G["ContainerFrame" .. I .. "Item" .. J .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				_G["ContainerFrame" .. I .. "Item" .. J .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)

				_G["ContainerFrame" .. I .. "Item" .. J .. "IconTexture"]:SetTexCoord(GetConfiguration().Bank.TextureCoordinate.Left, GetConfiguration().Bank.TextureCoordinate.Right, GetConfiguration().Bank.TextureCoordinate.Top, GetConfiguration().Bank.TextureCoordinate.Bottom)
				_G["ContainerFrame" .. I .. "Item" .. J .. "IconQuestTexture"]:SetAlpha(0)
			end
		end

		if BankFrame:GetNumRegions() > 0 then
			for _, Region in pairs({BankFrame:GetRegions()}) do
				if Region.GetTexture and Region:GetTexture() then
					Region:SetTexture(nil)
				end
			end
		end

		if BankSlotsFrame:GetNumRegions() > 0 then
			for _, Region in pairs({BankSlotsFrame:GetRegions()}) do
				if Region.GetTexture and Region:GetTexture() then
					Region:SetTexture(nil)
				end
			end
		end

		BankFrame:ClearAllPoints()
		BankFrame:SetPoint("TOPLEFT", UIParent, -500, 500)

		BankFrame.ClearAllPoints = Blank
		BankFrame.SetPoint = Blank

		for I = (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) + 1, NUM_BAG_SLOTS + 2, -1 do
			_G["ContainerFrame" .. I]:ClearAllPoints()
			_G["ContainerFrame" .. I]:SetPoint("TOPLEFT", UIParent, -500, 500)

			_G["ContainerFrame" .. I].ClearAllPoints = Blank
			_G["ContainerFrame" .. I].SetPoint = Blank
		end

		local function OpenBank()
			local CurrentColumn = 1
			local CurrentRow = 1
			local TotalBagSlots = NUM_BANKGENERIC_SLOTS

			for I = 1, GetNumBankSlots() do
				TotalBagSlots = TotalBagSlots + GetContainerNumSlots(I + 4)
			end

			local Rows = math.floor(TotalBagSlots / GetConfiguration().Bank.Columns)

			if (TotalBagSlots % GetConfiguration().Bank.Columns) ~= 0 then
				Rows = Rows + 1
			end

			BankFrame.Bag:SetSize(1 + (GetConfiguration().Bank.Columns * (GetConfiguration().Bank.Width + 1)), 26 + (Rows * (GetConfiguration().Bank.Height + 1)))

			local Bags = (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) + 1

			for I = (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) + 1, NUM_BAG_SLOTS + 2, -1 do
				if GetContainerNumSlots(I - 1) == 0 then
					Bags = Bags - 1
				end
			end

			for I = 1, NUM_BANKBAGSLOTS do
				BankSlotsFrame["Bag" .. I]:SetFrameLevel(BankFrame:GetFrameLevel())
			end

			for I = Bags, NUM_BAG_SLOTS + 2, -1 do
				for J = 1, GetContainerNumSlots(_G["ContainerFrame" .. I]:GetID()) do
					_G["ContainerFrame" .. I .. "Item" .. J]:ClearAllPoints()
					_G["ContainerFrame" .. I .. "Item" .. J]:SetFrameLevel(BankFrame:GetFrameLevel())
					_G["ContainerFrame" .. I .. "Item" .. J]:SetNormalTexture(nil)
					_G["ContainerFrame" .. I .. "Item" .. J]:SetSize(GetConfiguration().Bank.Width - 2, GetConfiguration().Bank.Height - 2)

					if (I == Bags) and (J == 1) then
						_G["ContainerFrame" .. I .. "Item" .. J]:SetPoint("BOTTOMRIGHT", BankFrame.Bag, -2, 27)
					else
						_G["ContainerFrame" .. I .. "Item" .. J]:SetPoint("BOTTOMRIGHT", BankFrame.Bag, -(2 + ((CurrentColumn - 1) * (GetConfiguration().Bank.Width + 1))), 27 + ((CurrentRow - 1) * (GetConfiguration().Bank.Height + 1)))
					end

					if CurrentColumn == GetConfiguration().Bank.Columns then
						CurrentColumn = 1
						CurrentRow = CurrentRow + 1
					else
						CurrentColumn = CurrentColumn + 1
					end
				end
			end

			for I = NUM_BANKGENERIC_SLOTS, 1, -1 do
				_G["BankFrameItem" .. I]:ClearAllPoints()
				_G["BankFrameItem" .. I]:SetFrameLevel(BankFrame:GetFrameLevel())
				_G["BankFrameItem" .. I]:SetNormalTexture(nil)
				_G["BankFrameItem" .. I]:SetSize(GetConfiguration().Bank.Width - 2, GetConfiguration().Bank.Height - 2)

				if (I == (NUM_BAG_FRAMES + 1)) and (J == 1) then
					_G["BankFrameItem" .. I]:SetPoint("BOTTOMRIGHT", BankFrame.Bag, -2, 27)
				else
					_G["BankFrameItem" .. I]:SetPoint("BOTTOMRIGHT", BankFrame.Bag, -(2 + ((CurrentColumn - 1) * (GetConfiguration().Bank.Width + 1))), 27 + ((CurrentRow - 1) * (GetConfiguration().Bank.Height + 1)))
				end

				if (CurrentRow == 1) and (CurrentColumn == GetConfiguration().Bank.Columns) then
					_G["BankFrameItem" .. I].BackgroundLeft:SetPoint("TOPLEFT", _G["BankFrameItem" .. I], -2, 1)
					_G["BankFrameItem" .. I].BackgroundLeft:SetSize(1, 1 + (GetConfiguration().Bank.Height * 2))
				else
					_G["BankFrameItem" .. I].BackgroundLeft:SetPoint("LEFT", _G["BankFrameItem" .. I], -2, 0)
					_G["BankFrameItem" .. I].BackgroundLeft:SetSize(1, GetConfiguration().Bank.Height)
				end

				if CurrentColumn == GetConfiguration().Bank.Columns then
					CurrentColumn = 1
					CurrentRow = CurrentRow + 1
				else
					CurrentColumn = CurrentColumn + 1
				end
			end
		end

		BankFrameItemButtonBag_OnClick = function(Self, Button)
			if not PutItemInBag(Self:GetInventorySlot()) then
				if Button and (not select(2, GetNumBankSlots())) then
					PlaySound("igMainMenuOption")
					StaticPopup_Show("CONFIRM_BUY_BANK_SLOT")
				end
			end
		end

		local OriginalBankFrameItemButtonBag_Pickup = BankFrameItemButtonBag_Pickup

		BankFrameItemButtonBag_Pickup = function(Self, Button)
			if not IsModifiedClick("PICKUPITEM") then
				OriginalBankFrameItemButtonBag_Pickup(Self, Button)
			end
		end

		local OriginalShowUIPanel = ShowUIPanel

		ShowUIPanel = function(Self)
			OriginalShowUIPanel(Self)

			for I = NUM_BAG_SLOTS + 1, NUM_BAG_SLOTS + NUM_BANKBAGSLOTS do
				OpenBag(I)
			end

			OpenBank()
		end

		local OriginalToggleAllBags = ToggleAllBags

		ToggleAllBags = function(Self)
			OriginalToggleAllBags(Self)

			if BankFrame:IsShown() then
				HideUIPanel(BankFrame)
			end
		end
	end
end
