-- Buffs.lua
-- Written by Snail

function HandleBuffs()
    if GetConfiguration().Buffs then
        AuraButton_UpdateDuration = function(Self, TimeLeft)         
            if (SHOW_BUFF_DURATIONS == "1") and TimeLeft then
                local Class = select(2, UnitClass("Player"))
                
                Self.duration:SetFormattedText(SecondsToTimeAbbrev(TimeLeft))
                Self.duration:SetVertexColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                local Text = Self.duration:GetText()

                Self.duration:SetText(Text:gsub(" ", ""))
                Self.duration:Show()
            else
                Self.duration:Hide()
            end
        end
      
        local OriginalBuffFrame_Update = BuffFrame_Update    

        BuffFrame_Update = function()
            OriginalBuffFrame_Update()

            BuffFrame:ClearAllPoints()
            BuffFrame:SetPoint(GetConfiguration().Buffs.Anchor, GetConfiguration().Buffs.X, GetConfiguration().Buffs.Y)

            local Class = select(2, UnitClass("Player"))
            local GreaterBuff = BUFF_ACTUAL_DISPLAY

            if DEBUFF_ACTUAL_DISPLAY > GreaterBuff then
                GreaterBuff = DEBUFF_ACTUAL_DISPLAY
            end

            if BuffFrame.numEnchants > GreaterBuff then
                GreaterBuff = BuffFrame.numEnchants
            end

            if (DEBUFF_ACTUAL_DISPLAY > 0) and (BUFF_ACTUAL_DISPLAY > 0) then
                BuffFrame:SetSize((GetConfiguration().Buffs.Width * 2) + 4, GreaterBuff * GetConfiguration().Buffs.Height)
            else
                BuffFrame:SetSize(GetConfiguration().Buffs.Width, GreaterBuff * GetConfiguration().Buffs.Height)
            end

            for I = 1, BUFF_ACTUAL_DISPLAY do
                _G["BuffButton" .. I]:ClearAllPoints()
                _G["BuffButton" .. I]:SetPoint("TOPRIGHT", -3, -(((I - 1) * GetConfiguration().Buffs.Height) + ((I - 1) * 4) + 3))
                _G["BuffButton" .. I]:SetSize(GetConfiguration().Buffs.Width - 6, GetConfiguration().Buffs.Height - 6)

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
                _G["BuffButton" .. I .. "Duration"]:SetPoint("CENTER", 1, 0)
                _G["BuffButton" .. I .. "Duration"]:SetShadowOffset(0, 0)

                _G["BuffButton" .. I .. "Icon"]:SetTexCoord(GetConfiguration().Buffs.TextureCoordinate.Left, GetConfiguration().Buffs.TextureCoordinate.Right, GetConfiguration().Buffs.TextureCoordinate.Top, GetConfiguration().Buffs.TextureCoordinate.Bottom)
            end

            for I = 1, DEBUFF_ACTUAL_DISPLAY do
                _G["DebuffButton" .. I]:ClearAllPoints()
                _G["DebuffButton" .. I]:SetPoint("TOPLEFT", 3, -(((I - 1) * GetConfiguration().Buffs.Height) + ((I - 1) * 4) + 3))
                _G["DebuffButton" .. I]:SetSize(GetConfiguration().Buffs.Width - 6, GetConfiguration().Buffs.Height - 6)

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
                _G["DebuffButton" .. I .. "Duration"]:SetPoint("CENTER", 1, 0)
                _G["DebuffButton" .. I .. "Duration"]:SetShadowOffset(0, 0)

                _G["DebuffButton" .. I .. "Icon"]:SetTexCoord(GetConfiguration().Buffs.TextureCoordinate.Left, GetConfiguration().Buffs.TextureCoordinate.Right, GetConfiguration().Buffs.TextureCoordinate.Top, GetConfiguration().Buffs.TextureCoordinate.Bottom)
            end

            for I = 1, BuffFrame.numEnchants do
                _G["TempEnchant" .. I]:ClearAllPoints()
                _G["TempEnchant" .. I]:SetParent(BuffFrame)
                _G["TempEnchant" .. I]:SetPoint("TOPLEFT", -33, -(((I - 1) * GetConfiguration().Buffs.Height) + ((I - 1) * 4) + 3))
                _G["TempEnchant" .. I]:SetSize(GetConfiguration().Buffs.Width - 6, GetConfiguration().Buffs.Height - 6)

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
                _G["TempEnchant" .. I .. "Duration"]:SetPoint("CENTER", 1, 0)
                _G["TempEnchant" .. I .. "Duration"]:SetShadowOffset(0, 0)

                _G["TempEnchant" .. I .. "Icon"]:SetTexCoord(GetConfiguration().Buffs.TextureCoordinate.Left, GetConfiguration().Buffs.TextureCoordinate.Right, GetConfiguration().Buffs.TextureCoordinate.Top, GetConfiguration().Buffs.TextureCoordinate.Bottom)
            end
        end
    end
end
