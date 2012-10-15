-- Bag.lua
-- Written by Snail

function HandleBag()
    if GetConfiguration().Bag then
        local Class = select(2, UnitClass("Player"))
        local TotalBagSlots = 0

        for I = 0, NUM_BAG_FRAMES do
            TotalBagSlots = TotalBagSlots + GetContainerNumSlots(I)
        end

        local Rows = math.floor(TotalBagSlots / GetConfiguration().Bag.Columns)

        if (TotalBagSlots % GetConfiguration().Bag.Columns) ~= 0 then
            Rows = Rows + 1
        end

        ContainerFrame1.Bag = CreateFrame("Frame", nil, ContainerFrame1)
        ContainerFrame1.Bag:SetPoint(GetConfiguration().Bag.Anchor, UIParent, GetConfiguration().Bag.X, GetConfiguration().Bag.Y)
        ContainerFrame1.Bag:SetSize(1 + (GetConfiguration().Bag.Columns * (GetConfiguration().Bag.Width + 1)), 26 + (Rows * (GetConfiguration().Bag.Height + 1)))

        ContainerFrame1MoneyFrame:ClearAllPoints()
        ContainerFrame1MoneyFrame:SetHeight(GetConfiguration().Bag.Height)
        ContainerFrame1MoneyFrame:SetPoint("BOTTOMRIGHT", ContainerFrame1.Bag, 0, 1)

        ContainerFrame1MoneyFrame.BackgroundBottom = ContainerFrame1MoneyFrame:CreateTexture(nil, "LOW")
        ContainerFrame1MoneyFrame.BackgroundBottom:SetPoint("BOTTOMRIGHT", 0, -1)
        ContainerFrame1MoneyFrame.BackgroundBottom:SetSize(1 + (GetConfiguration().Bag.Columns * (GetConfiguration().Bag.Width + 1)), 1)
        ContainerFrame1MoneyFrame.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        ContainerFrame1MoneyFrame.BackgroundRight = ContainerFrame1MoneyFrame:CreateTexture(nil, "LOW")
        ContainerFrame1MoneyFrame.BackgroundRight:SetPoint("RIGHT")
        ContainerFrame1MoneyFrame.BackgroundRight:SetSize(1, GetConfiguration().Bag.Height)
        ContainerFrame1MoneyFrame.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        ContainerFrame1MoneyFrame.BackgroundTop = ContainerFrame1MoneyFrame:CreateTexture(nil, "LOW")
        ContainerFrame1MoneyFrame.BackgroundTop:SetPoint("TOPRIGHT", 0, 1)
        ContainerFrame1MoneyFrame.BackgroundTop:SetSize(1 + (GetConfiguration().Bag.Columns * (GetConfiguration().Bag.Width + 1)), 1)
        ContainerFrame1MoneyFrame.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        ContainerFrame1MoneyFrame.Border = ContainerFrame1MoneyFrame:CreateTexture(nil, "BACKGROUND")
        ContainerFrame1MoneyFrame.Border:SetPoint("TOPRIGHT", 1, 0)
        ContainerFrame1MoneyFrame.Border:SetSize(3 + (GetConfiguration().Bag.Columns * (GetConfiguration().Bag.Width + 1)), GetConfiguration().Bag.Height + 2)
        ContainerFrame1MoneyFrame.Border:SetTexture(0, 0, 0)

        ContainerFrame1MoneyFrameCopperButtonText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
        ContainerFrame1MoneyFrameGoldButtonText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
        ContainerFrame1MoneyFrameSilverButtonText:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)

        local function OpenBags()
            local CurrentColumn = 1
            local CurrentRow = 1

            TotalBagSlots = 0

            for I = 0, NUM_BAG_FRAMES do
                TotalBagSlots = TotalBagSlots + GetContainerNumSlots(I)
            end

            Rows = math.floor(TotalBagSlots / GetConfiguration().Bag.Columns)

            if (TotalBagSlots % GetConfiguration().Bag.Columns) ~= 0 then
                Rows = Rows + 1
            end

            for I = NUM_BAG_FRAMES + 1, 1, -1 do
                _G["ContainerFrame" .. I]:ClearAllPoints()
                _G["ContainerFrame" .. I]:SetPoint("TOPLEFT", UIParent, -500, 500)

                _G["ContainerFrame" .. I].ClearAllPoints = Blank
                _G["ContainerFrame" .. I].SetPoint = Blank

                for J = 1, GetContainerNumSlots(I - 1) do
                    _G["ContainerFrame" .. I .. "Item" .. J]:ClearAllPoints()
                    _G["ContainerFrame" .. I .. "Item" .. J]:SetNormalTexture(nil)
                    _G["ContainerFrame" .. I .. "Item" .. J]:SetSize(GetConfiguration().Bag.Width - 2, GetConfiguration().Bag.Height - 2)

                    if (I == (NUM_BAG_FRAMES + 1)) and (J == 1) then
                        _G["ContainerFrame" .. I .. "Item" .. J]:SetPoint("BOTTOMRIGHT", ContainerFrame1.Bag, -2, 27)
                    else
                        _G["ContainerFrame" .. I .. "Item" .. J]:SetPoint("BOTTOMRIGHT", ContainerFrame1.Bag, -(2 + ((CurrentColumn - 1) * (GetConfiguration().Bag.Width + 1))), 27 + ((CurrentRow - 1) * (GetConfiguration().Bag.Height + 1)))
                    end

                    _G["ContainerFrame" .. I .. "Item" .. J]:SetScript("OnUpdate",
                        function(Self, ElapsedTime)
                            if not Self.Time then
                                Self.Time = 0
                            end

                            if not Self.CooldownTime then
                                Self.CooldownTime = 0
                            end

                            if (Self.Time + ElapsedTime) >= 0.1 then
                                local Start, Duration, Enable, Charges, MaxCharges = GetContainerItemCooldown(Self:GetParent():GetID(), Self:GetID())

                                if Duration > 0 then
                                    if Self.CooldownTime < Duration then
                                        Self.CooldownTime = Self.CooldownTime + (Self.Time + ElapsedTime)
                                        Self.Text:SetFormattedText(SecondsToTimeAbbrev(Duration - Self.CooldownTime))

                                        local Text = Self.Text:GetText()

                                        Self.Text:SetText(Text:gsub(" ", ""))
                                        Self.Text:Show()
                                    else
                                        Self.CooldownTime = 0
                                    end
                                else
                                    Self.CooldownTime = 0
                                    Self.Text:Hide()
                                end

                                Self.Time = 0
                            else
                                Self.Time = Self.Time + ElapsedTime
                            end
                        end
                    )

                    if not _G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom then
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetSize(GetConfiguration().Bag.Width + 2 , 1)
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetPoint("RIGHT", 2, 0)
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetSize(1, GetConfiguration().Bag.Height)
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "LOW")
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetPoint("TOP", 0, 2)
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetSize(GetConfiguration().Bag.Width + 2, 1)
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                        _G["ContainerFrame" .. I .. "Item" .. J].Border = _G["ContainerFrame" .. I .. "Item" .. J]:CreateTexture(nil, "BACKGROUND")
                        _G["ContainerFrame" .. I .. "Item" .. J].Border:SetPoint("TOPLEFT", -3, 3)
                        _G["ContainerFrame" .. I .. "Item" .. J].Border:SetSize(GetConfiguration().Bag.Width + 4, GetConfiguration().Bag.Height + 4)
                        _G["ContainerFrame" .. I .. "Item" .. J].Border:SetTexture(0, 0, 0)
                    end

                    if (CurrentRow == 1) and (CurrentColumn == GetConfiguration().Bag.Columns) then
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetPoint("TOPLEFT", -2, 1)
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetSize(1, 1 + (GetConfiguration().Bag.Height * 2))
                    else
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetPoint("LEFT", -2, 0)
                        _G["ContainerFrame" .. I .. "Item" .. J].BackgroundLeft:SetSize(1, GetConfiguration().Bag.Height)
                    end

                    _G["ContainerFrame" .. I .. "Item" .. J].Text = _G["ContainerFrame" .. I .. "Item" .. J .. "Cooldown"]:CreateFontString(nil, "OVERLAY")
                    _G["ContainerFrame" .. I .. "Item" .. J].Text:Hide()
                    _G["ContainerFrame" .. I .. "Item" .. J].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                    _G["ContainerFrame" .. I .. "Item" .. J].Text:SetPoint("CENTER", 1, 0)
                    _G["ContainerFrame" .. I .. "Item" .. J].Text:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["ContainerFrame" .. I .. "Item" .. J .. "Count"]:ClearAllPoints()
                    _G["ContainerFrame" .. I .. "Item" .. J .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                    _G["ContainerFrame" .. I .. "Item" .. J .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)
                    _G["ContainerFrame" .. I .. "Item" .. J .. "IconTexture"]:SetTexCoord(GetConfiguration().Bag.TextureCoordinate.Left, GetConfiguration().Bag.TextureCoordinate.Right, GetConfiguration().Bag.TextureCoordinate.Top, GetConfiguration().Bag.TextureCoordinate.Bottom)
                    _G["ContainerFrame" .. I .. "Item" .. J .. "IconQuestTexture"]:SetSize(GetConfiguration().Bag.Width - 2, GetConfiguration().Bag.Height - 2)
                    
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
