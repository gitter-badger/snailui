-- Bank.lua
-- Written by Snail

function HandleBank()
	if GetConfiguration().Bank then
		local Class = select(2, UnitClass("Player"))

		BankFrame:HookScript("OnHide",
			function(Self)
				for I = 1, NUM_BANKBAGSLOTS do
					_G["BankFrameBag" .. I].BackgroundBottom:Hide()
					_G["BankFrameBag" .. I].BackgroundLeft:Hide()
					_G["BankFrameBag" .. I].BackgroundRight:Hide()
					_G["BankFrameBag" .. I].BackgroundTop:Hide()
					_G["BankFrameBag" .. I].Border:Hide()
				end

				for I = NUM_BANKGENERIC_SLOTS, 1, -1 do
					_G["BankFrameItem" .. I].BackgroundBottom:Hide()
					_G["BankFrameItem" .. I].BackgroundLeft:Hide()
					_G["BankFrameItem" .. I].BackgroundRight:Hide()
					_G["BankFrameItem" .. I].BackgroundTop:Hide()
					_G["BankFrameItem" .. I].Border:Hide()
				end
			end
		)

		BankFrame:HookScript("OnShow",
			function(Self)
				for I = 1, NUM_BANKBAGSLOTS do
					_G["BankFrameBag" .. I].BackgroundBottom:Show()
					_G["BankFrameBag" .. I].BackgroundLeft:Show()
					_G["BankFrameBag" .. I].BackgroundRight:Show()
					_G["BankFrameBag" .. I].BackgroundTop:Show()
					_G["BankFrameBag" .. I].Border:Show()
				end

				for I = NUM_BANKGENERIC_SLOTS, 1, -1 do
					_G["BankFrameItem" .. I].BackgroundBottom:Show()
					_G["BankFrameItem" .. I].BackgroundLeft:Show()
					_G["BankFrameItem" .. I].BackgroundRight:Show()
					_G["BankFrameItem" .. I].BackgroundTop:Show()
					_G["BankFrameItem" .. I].Border:Show()
				end
			end
		)

		for I = (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) + 1, NUM_BAG_SLOTS + 2, -1 do
			_G["ContainerFrame" .. I]:HookScript("OnShow",
				function(Self)
					for J = 1, MAX_CONTAINER_ITEMS do
						_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:Show()
						_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:Show()
						_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:Show()
						_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:Show()
						_G["ContainerFrame" .. I .. "Item" .. J].Border:Show()
					end
				end
			)

			_G["ContainerFrame" .. I]:HookScript("OnHide",
				function(Self)
					for J = 1, MAX_CONTAINER_ITEMS do
						_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:Hide()
						_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:Hide()
						_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:Hide()
						_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:Hide()
						_G["ContainerFrame" .. I .. "Item" .. J].Border:Hide()
					end
				end
			)
		end

		BankFrame.Bag = CreateFrame("Frame", nil, BankFrame)
		BankFrame.Bag:SetPoint(GetConfiguration().Bank.Anchor, UIParent, GetConfiguration().Bank.X, GetConfiguration().Bank.Y)

		for I = 1, NUM_BANKBAGSLOTS do
			_G["BankFrameBag" .. I]:ClearAllPoints()
			_G["BankFrameBag" .. I]:SetNormalTexture(nil)
			_G["BankFrameBag" .. I]:SetParent(BankFrame.Bag)
			_G["BankFrameBag" .. I]:SetSize(GetConfiguration().Bank.Width - 2, GetConfiguration().Bank.Height - 2)

			if I == 1 then
				_G["BankFrameBag" .. I]:SetPoint("BOTTOMLEFT", 2, 2)
			else
				_G["BankFrameBag" .. I]:SetPoint("BOTTOMLEFT", 2 + ((I - 1) * (GetConfiguration().Bank.Width + 1)), 2)
			end

			if not _G["BankFrameBag" .. I].BackgroundBottom then
				_G["BankFrameBag" .. I].BackgroundBottom = UIParent:CreateTexture(nil, "LOW")
				_G["BankFrameBag" .. I].BackgroundBottom:Hide()
				_G["BankFrameBag" .. I].BackgroundBottom:SetPoint("BOTTOM", _G["BankFrameBag" .. I], 0, -2)
				_G["BankFrameBag" .. I].BackgroundBottom:SetSize(GetConfiguration().Bank.Width + 2 , 1)
				_G["BankFrameBag" .. I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["BankFrameBag" .. I].BackgroundLeft = UIParent:CreateTexture(nil, "LOW")
				_G["BankFrameBag" .. I].BackgroundLeft:Hide()
				_G["BankFrameBag" .. I].BackgroundLeft:SetPoint("LEFT", _G["BankFrameBag" .. I], -2, 0)
				_G["BankFrameBag" .. I].BackgroundLeft:SetSize(1, GetConfiguration().Bank.Height)
				_G["BankFrameBag" .. I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["BankFrameBag" .. I].BackgroundRight = UIParent:CreateTexture(nil, "LOW")
				_G["BankFrameBag" .. I].BackgroundRight:Hide()
				_G["BankFrameBag" .. I].BackgroundRight:SetPoint("RIGHT", _G["BankFrameBag" .. I], 2, 0)
				_G["BankFrameBag" .. I].BackgroundRight:SetSize(1, GetConfiguration().Bank.Height)
				_G["BankFrameBag" .. I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["BankFrameBag" .. I].BackgroundTop = UIParent:CreateTexture(nil, "LOW")
				_G["BankFrameBag" .. I].BackgroundTop:Hide()
				_G["BankFrameBag" .. I].BackgroundTop:SetPoint("TOP", _G["BankFrameBag" .. I], 0, 2)
				_G["BankFrameBag" .. I].BackgroundTop:SetSize(GetConfiguration().Bank.Width + 2, 1)
				_G["BankFrameBag" .. I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["BankFrameBag" .. I].Border = UIParent:CreateTexture(nil, "BACKGROUND")
				_G["BankFrameBag" .. I].Border:Hide()
				_G["BankFrameBag" .. I].Border:SetPoint("TOPLEFT", _G["BankFrameBag" .. I], -3, 3)
				_G["BankFrameBag" .. I].Border:SetSize(GetConfiguration().Bank.Width + 4, GetConfiguration().Bank.Height + 4)
				_G["BankFrameBag" .. I].Border:SetTexture(0, 0, 0)
			end

			_G["BankFrameBag" .. I .. "IconTexture"]:SetTexCoord(GetConfiguration().Bank.TextureCoordinate.Left, GetConfiguration().Bank.TextureCoordinate.Right, GetConfiguration().Bank.TextureCoordinate.Top, GetConfiguration().Bank.TextureCoordinate.Bottom)
		end

		for I = NUM_BANKGENERIC_SLOTS, 1, -1 do
			_G["BankFrameItem" .. I].BackgroundBottom = UIParent:CreateTexture(nil, "LOW")
			_G["BankFrameItem" .. I].BackgroundBottom:Hide()
			_G["BankFrameItem" .. I].BackgroundBottom:SetPoint("BOTTOM", _G["BankFrameItem" .. I], 0, -2)
			_G["BankFrameItem" .. I].BackgroundBottom:SetSize(GetConfiguration().Bank.Width + 2 , 1)
			_G["BankFrameItem" .. I].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["BankFrameItem" .. I].BackgroundLeft = UIParent:CreateTexture(nil, "LOW")
			_G["BankFrameItem" .. I].BackgroundLeft:Hide()
			_G["BankFrameItem" .. I].BackgroundLeft:SetPoint("LEFT", _G["BankFrameItem" .. I], -2, 0)
			_G["BankFrameItem" .. I].BackgroundLeft:SetSize(1, GetConfiguration().Bank.Height)
			_G["BankFrameItem" .. I].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["BankFrameItem" .. I].BackgroundRight = UIParent:CreateTexture(nil, "LOW")
			_G["BankFrameItem" .. I].BackgroundRight:Hide()
			_G["BankFrameItem" .. I].BackgroundRight:SetPoint("RIGHT", _G["BankFrameItem" .. I], 2, 0)
			_G["BankFrameItem" .. I].BackgroundRight:SetSize(1, GetConfiguration().Bank.Height)
			_G["BankFrameItem" .. I].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["BankFrameItem" .. I].BackgroundTop = UIParent:CreateTexture(nil, "LOW")
			_G["BankFrameItem" .. I].BackgroundTop:Hide()
			_G["BankFrameItem" .. I].BackgroundTop:SetPoint("TOP", _G["BankFrameItem" .. I], 0, 2)
			_G["BankFrameItem" .. I].BackgroundTop:SetSize(GetConfiguration().Bank.Width + 2, 1)
			_G["BankFrameItem" .. I].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			_G["BankFrameItem" .. I].Border = UIParent:CreateTexture(nil, "BACKGROUND")
			_G["BankFrameItem" .. I].Border:Hide()
			_G["BankFrameItem" .. I].Border:SetPoint("TOPLEFT", _G["BankFrameItem" .. I], -3, 3)
			_G["BankFrameItem" .. I].Border:SetSize(GetConfiguration().Bank.Width + 4, GetConfiguration().Bank.Height + 4)
			_G["BankFrameItem" .. I].Border:SetTexture(0, 0, 0)

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
			_G["BankFrameItem" .. I .. "IconQuestTexture"]:SetAlpha(0)
		end

		for I = (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) + 1, NUM_BAG_SLOTS + 2, -1 do
			for J = 1, MAX_CONTAINER_ITEMS do
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom = UIParent:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:Hide()
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetPoint("BOTTOM", _G["ContainerFrame" .. I .. "Item" .. J], 0, -2)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetSize(GetConfiguration().Bank.Width + 2 , 1)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft = UIParent:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:Hide()
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetPoint("LEFT", _G["ContainerFrame" .. I .. "Item" .. J], -2, 0)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetSize(1, GetConfiguration().Bank.Height)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight = UIParent:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:Hide()
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetPoint("RIGHT", _G["ContainerFrame" .. I .. "Item" .. J], 2, 0)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetSize(1, GetConfiguration().Bank.Height)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop = UIParent:CreateTexture(nil, "LOW")
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:Hide()
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetPoint("TOP", _G["ContainerFrame" .. I .. "Item" .. J], 0, 2)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetSize(GetConfiguration().Bank.Width + 2, 1)
				_G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				_G["ContainerFrame" .. I .. "Item" .. J].Border = UIParent:CreateTexture(nil, "BACKGROUND")
				_G["ContainerFrame" .. I .. "Item" .. J].Border:Hide()
				_G["ContainerFrame" .. I .. "Item" .. J].Border:SetPoint("TOPLEFT", _G["ContainerFrame" .. I .. "Item" .. J], -3, 3)
				_G["ContainerFrame" .. I .. "Item" .. J].Border:SetSize(GetConfiguration().Bank.Width + 4, GetConfiguration().Bank.Height + 4)
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

			local Bags = NUM_BAG_SLOTS + 1

			for I = (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) + 1, NUM_BAG_SLOTS + 2, -1 do
				if GetContainerNumSlots(I - 1) > 0 then
					Bags = Bags + 1
				end
			end

			for I = Bags, NUM_BAG_SLOTS + 2, -1 do
				for J = 1, GetContainerNumSlots(I - 1) do
					_G["ContainerFrame" .. I .. "Item" .. J]:ClearAllPoints()
					_G["ContainerFrame" .. I .. "Item" .. J]:SetNormalTexture(nil)
					_G["ContainerFrame" .. I .. "Item" .. J]:SetSize(GetConfiguration().Bank.Width - 2, GetConfiguration().Bank.Height - 2)

					if (I == (NUM_BAG_SLOTS + NUM_BANKBAGSLOTS) + 1) and (J == 1) then
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
			PutItemInBag(Self:GetInventorySlot())
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

		local OriginalBankFrameItemButton_Update = BankFrameItemButton_Update

		BankFrameItemButton_Update = function(Self)
			OriginalBankFrameItemButton_Update(Self)

			if string.match(Self:GetName(), "BankFrameBag") then
				OpenBank()
				OpenBag(Self:GetID())
				print(Self:GetID())
			end
		end
	end
end
