-- Bag.lua
-- Written by Snail

function HandleBag()
    if GetConfiguration().Bag then
        local TotalBagSlots = 0

        for i = 0, NUM_BAG_FRAMES do
            TotalBagSlots = TotalBagSlots + GetContainerNumSlots(i)
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

            for i = 0, NUM_BAG_FRAMES do
                TotalBagSlots = TotalBagSlots + GetContainerNumSlots(i)
            end

            Rows = math.floor(TotalBagSlots / GetConfiguration().Bag.Columns)

            if (TotalBagSlots % GetConfiguration().Bag.Columns) ~= 0 then
                Rows = Rows + 1
            end

            for i = NUM_BAG_FRAMES + 1, 1, -1 do
                _G["ContainerFrame" .. i]:ClearAllPoints()
                _G["ContainerFrame" .. i]:SetPoint("TOPLEFT", UIParent, -500, 500)

                _G["ContainerFrame" .. i].ClearAllPoints = Blank
                _G["ContainerFrame" .. i].SetPoint = Blank

                for j = 1, GetContainerNumSlots(i - 1) do
                    _G["ContainerFrame" .. i .. "Item" .. j]:ClearAllPoints()
                    _G["ContainerFrame" .. i .. "Item" .. j]:SetNormalTexture(nil)
                    _G["ContainerFrame" .. i .. "Item" .. j]:SetSize(GetConfiguration().Bag.Width - 2, GetConfiguration().Bag.Height - 2)

                    if (i == (NUM_BAG_FRAMES + 1)) and (j == 1) then
                        _G["ContainerFrame" .. i .. "Item" .. j]:SetPoint("BOTTOMRIGHT", ContainerFrame1.Bag, -2, 27)
                    else
                        _G["ContainerFrame" .. i .. "Item" .. j]:SetPoint("BOTTOMRIGHT", ContainerFrame1.Bag, -(2 + ((CurrentColumn - 1) * (GetConfiguration().Bag.Width + 1))), 27 + ((CurrentRow - 1) * (GetConfiguration().Bag.Height + 1)))
                    end

                    if not _G["ContainerFrame" .. i .. "Item" .. j].BackgroundBottom then
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundBottom = _G["ContainerFrame" .. i .. "Item" .. j]:CreateTexture(nil, "LOW")
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundBottom:SetSize(GetConfiguration().Bag.Width + 2 , 1)
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundLeft = _G["ContainerFrame" .. i .. "Item" .. j]:CreateTexture(nil, "LOW")
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundRight = _G["ContainerFrame" .. i .. "Item" .. j]:CreateTexture(nil, "LOW")
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundRight:SetPoint("RIGHT", 2, 0)
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundRight:SetSize(1, GetConfiguration().Bag.Height)
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundTop = _G["ContainerFrame" .. i .. "Item" .. j]:CreateTexture(nil, "LOW")
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundTop:SetPoint("TOP", 0, 2)
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundTop:SetSize(GetConfiguration().Bag.Width + 2, 1)
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                        _G["ContainerFrame" .. i .. "Item" .. j].Border = _G["ContainerFrame" .. i .. "Item" .. j]:CreateTexture(nil, "BACKGROUND")
                        _G["ContainerFrame" .. i .. "Item" .. j].Border:SetPoint("TOPLEFT", -3, 3)
                        _G["ContainerFrame" .. i .. "Item" .. j].Border:SetSize(GetConfiguration().Bag.Width + 4, GetConfiguration().Bag.Height + 4)
                        _G["ContainerFrame" .. i .. "Item" .. j].Border:SetTexture(0, 0, 0)
                    end

                    if (CurrentRow == 1) and (CurrentColumn == GetConfiguration().Bag.Columns) then
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundLeft:SetPoint("TOPLEFT", -2, 1)
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundLeft:SetSize(1, 1 + (GetConfiguration().Bag.Height * 2))
                    else
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundLeft:SetPoint("LEFT", -2, 0)
                        _G["ContainerFrame" .. i .. "Item" .. j].BackgroundLeft:SetSize(1, GetConfiguration().Bag.Height)
                    end

                    _G["ContainerFrame" .. i .. "Item" .. j .. "Count"]:ClearAllPoints()
                    _G["ContainerFrame" .. i .. "Item" .. j .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                    _G["ContainerFrame" .. i .. "Item" .. j .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)
                    _G["ContainerFrame" .. i .. "Item" .. j .. "IconTexture"]:SetTexCoord(GetConfiguration().Bag.TextureCoordinate.Left, GetConfiguration().Bag.TextureCoordinate.Right, GetConfiguration().Bag.TextureCoordinate.Top, GetConfiguration().Bag.TextureCoordinate.Bottom)
                    _G["ContainerFrame" .. i .. "Item" .. j .. "IconQuestTexture"]:SetSize(GetConfiguration().Bag.Width - 2, GetConfiguration().Bag.Height - 2)
                    
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
