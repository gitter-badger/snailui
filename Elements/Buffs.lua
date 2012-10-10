-- Buffs.lua
-- Written by Snail

function HandleBuffs()
    if GetConfiguration().Buffs then
        AuraButton_UpdateDuration = function(Self, TimeLeft)         
            if (SHOW_BUFF_DURATIONS == "1") and TimeLeft then
                Self.duration:SetFormattedText(SecondsToTimeAbbrev(TimeLeft));

                if TimeLeft < BUFF_DURATION_WARNING_TIME then
                    Self.duration:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
                else
                    Self.duration:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
                end

                local Text = Self.duration:GetText()

                Self.duration:SetText(Text:gsub(" ", ""))
                Self.duration:Show();
            else
                Self.duration:Hide();
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

            for i = 1, BUFF_ACTUAL_DISPLAY do
                _G["BuffButton" .. i]:ClearAllPoints()
                _G["BuffButton" .. i]:SetPoint("TOPRIGHT", -3, -(((i - 1) * GetConfiguration().Buffs.Height) + ((i - 1) * 4) + 3))
                _G["BuffButton" .. i]:SetSize(GetConfiguration().Buffs.Width - 6, GetConfiguration().Buffs.Height - 6)

                if not  _G["BuffButton" .. i].BackgroundBottom then
                    _G["BuffButton" .. i].BackgroundBottom = _G["BuffButton" .. i]:CreateTexture(nil, "LOW")
                    _G["BuffButton" .. i].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                    _G["BuffButton" .. i].BackgroundBottom:SetSize(GetConfiguration().Buffs.Width - 2, 1)
                    _G["BuffButton" .. i].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["BuffButton" .. i].BackgroundLeft = _G["BuffButton" .. i]:CreateTexture(nil, "LOW")
                    _G["BuffButton" .. i].BackgroundLeft:SetPoint("LEFT", -2, 0)
                    _G["BuffButton" .. i].BackgroundLeft:SetSize(1, GetConfiguration().Buffs.Height - 4)
                    _G["BuffButton" .. i].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["BuffButton" .. i].BackgroundRight = _G["BuffButton" .. i]:CreateTexture(nil, "LOW")
                    _G["BuffButton" .. i].BackgroundRight:SetPoint("RIGHT", 2, 0)
                    _G["BuffButton" .. i].BackgroundRight:SetSize(1, GetConfiguration().Buffs.Height - 4)
                    _G["BuffButton" .. i].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["BuffButton" .. i].BackgroundTop = _G["BuffButton" .. i]:CreateTexture(nil, "LOW")
                    _G["BuffButton" .. i].BackgroundTop:SetPoint("TOP", 0, 2)
                    _G["BuffButton" .. i].BackgroundTop:SetSize(GetConfiguration().Buffs.Width - 2, 1)
                    _G["BuffButton" .. i].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["BuffButton" .. i].BorderBottom = _G["BuffButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["BuffButton" .. i].BorderBottom:SetPoint("BOTTOM", 0, -3)
                    _G["BuffButton" .. i].BorderBottom:SetSize(GetConfiguration().Buffs.Width, 3)
                    _G["BuffButton" .. i].BorderBottom:SetTexture(0, 0, 0)

                    _G["BuffButton" .. i].BorderLeft = _G["BuffButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["BuffButton" .. i].BorderLeft:SetPoint("LEFT", -3, 0)
                    _G["BuffButton" .. i].BorderLeft:SetSize(3, GetConfiguration().Buffs.Height - 2)
                    _G["BuffButton" .. i].BorderLeft:SetTexture(0, 0, 0)

                    _G["BuffButton" .. i].BorderRight = _G["BuffButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["BuffButton" .. i].BorderRight:SetPoint("RIGHT", 3, 0)
                    _G["BuffButton" .. i].BorderRight:SetSize(3, GetConfiguration().Buffs.Height - 2)
                    _G["BuffButton" .. i].BorderRight:SetTexture(0, 0, 0)

                    _G["BuffButton" .. i].BorderTop = _G["BuffButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["BuffButton" .. i].BorderTop:SetPoint("TOP", 0, 3)
                    _G["BuffButton" .. i].BorderTop:SetSize(GetConfiguration().Buffs.Width, 3)
                    _G["BuffButton" .. i].BorderTop:SetTexture(0, 0, 0)
                end

                _G["BuffButton" .. i .. "Count"]:ClearAllPoints()
                _G["BuffButton" .. i .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                _G["BuffButton" .. i .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)

                _G["BuffButton" .. i .. "Duration"]:ClearAllPoints()
                _G["BuffButton" .. i .. "Duration"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                _G["BuffButton" .. i .. "Duration"]:SetPoint("CENTER", 1, 0)
                _G["BuffButton" .. i .. "Duration"]:SetShadowOffset(0, 0)

                _G["BuffButton" .. i .. "Icon"]:SetTexCoord(GetConfiguration().Buffs.TextureCoordinate.Left, GetConfiguration().Buffs.TextureCoordinate.Right, GetConfiguration().Buffs.TextureCoordinate.Top, GetConfiguration().Buffs.TextureCoordinate.Bottom)
            end

            for i = 1, DEBUFF_ACTUAL_DISPLAY do
                _G["DebuffButton" .. i]:ClearAllPoints()
                _G["DebuffButton" .. i]:SetPoint("TOPLEFT", 3, -(((i - 1) * GetConfiguration().Buffs.Height) + ((i - 1) * 4) + 3))
                _G["DebuffButton" .. i]:SetSize(GetConfiguration().Buffs.Width - 6, GetConfiguration().Buffs.Height - 6)

                if not  _G["DebuffButton" .. i].BackgroundBottom then
                    _G["DebuffButton" .. i].BackgroundBottom = _G["DebuffButton" .. i]:CreateTexture(nil, "LOW")
                    _G["DebuffButton" .. i].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                    _G["DebuffButton" .. i].BackgroundBottom:SetSize(GetConfiguration().Buffs.Width - 2, 1)
                    _G["DebuffButton" .. i].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["DebuffButton" .. i].BackgroundLeft = _G["DebuffButton" .. i]:CreateTexture(nil, "LOW")
                    _G["DebuffButton" .. i].BackgroundLeft:SetPoint("LEFT", -2, 0)
                    _G["DebuffButton" .. i].BackgroundLeft:SetSize(1, GetConfiguration().Buffs.Height - 4)
                    _G["DebuffButton" .. i].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["DebuffButton" .. i].BackgroundRight = _G["DebuffButton" .. i]:CreateTexture(nil, "LOW")
                    _G["DebuffButton" .. i].BackgroundRight:SetPoint("RIGHT", 2, 0)
                    _G["DebuffButton" .. i].BackgroundRight:SetSize(1, GetConfiguration().Buffs.Height - 4)
                    _G["DebuffButton" .. i].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["DebuffButton" .. i].BackgroundTop = _G["DebuffButton" .. i]:CreateTexture(nil, "LOW")
                    _G["DebuffButton" .. i].BackgroundTop:SetPoint("TOP", 0, 2)
                    _G["DebuffButton" .. i].BackgroundTop:SetSize(GetConfiguration().Buffs.Width - 2, 1)
                    _G["DebuffButton" .. i].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["DebuffButton" .. i].BorderBottom = _G["DebuffButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["DebuffButton" .. i].BorderBottom:SetPoint("BOTTOM", 0, -3)
                    _G["DebuffButton" .. i].BorderBottom:SetSize(GetConfiguration().Buffs.Width, 3)
                    _G["DebuffButton" .. i].BorderBottom:SetTexture(0, 0, 0)

                    _G["DebuffButton" .. i].BorderLeft = _G["DebuffButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["DebuffButton" .. i].BorderLeft:SetPoint("LEFT", -3, 0)
                    _G["DebuffButton" .. i].BorderLeft:SetSize(3, GetConfiguration().Buffs.Height - 2)
                    _G["DebuffButton" .. i].BorderLeft:SetTexture(0, 0, 0)

                    _G["DebuffButton" .. i].BorderRight = _G["DebuffButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["DebuffButton" .. i].BorderRight:SetPoint("RIGHT", 3, 0)
                    _G["DebuffButton" .. i].BorderRight:SetSize(3, GetConfiguration().Buffs.Height - 2)
                    _G["DebuffButton" .. i].BorderRight:SetTexture(0, 0, 0)

                    _G["DebuffButton" .. i].BorderTop = _G["DebuffButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["DebuffButton" .. i].BorderTop:SetPoint("TOP", 0, 3)
                    _G["DebuffButton" .. i].BorderTop:SetSize(GetConfiguration().Buffs.Width, 3)
                    _G["DebuffButton" .. i].BorderTop:SetTexture(0, 0, 0)
                end

                _G["DebuffButton" .. i .. "Border"]:Hide()

                _G["DebuffButton" .. i .. "Count"]:ClearAllPoints()
                _G["DebuffButton" .. i .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                _G["DebuffButton" .. i .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)

                _G["DebuffButton" .. i .. "Duration"]:ClearAllPoints()
                _G["DebuffButton" .. i .. "Duration"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                _G["DebuffButton" .. i .. "Duration"]:SetPoint("CENTER", 1, 0)
                _G["DebuffButton" .. i .. "Duration"]:SetShadowOffset(0, 0)

                _G["DebuffButton" .. i .. "Icon"]:SetTexCoord(GetConfiguration().Buffs.TextureCoordinate.Left, GetConfiguration().Buffs.TextureCoordinate.Right, GetConfiguration().Buffs.TextureCoordinate.Top, GetConfiguration().Buffs.TextureCoordinate.Bottom)
            end

            for i = 1, BuffFrame.numEnchants do
                _G["TempEnchant" .. i]:ClearAllPoints()
                _G["TempEnchant" .. i]:SetParent(BuffFrame)
                _G["TempEnchant" .. i]:SetPoint("TOPLEFT", -33, -(((i - 1) * GetConfiguration().Buffs.Height) + ((i - 1) * 4) + 3))
                _G["TempEnchant" .. i]:SetSize(GetConfiguration().Buffs.Width - 6, GetConfiguration().Buffs.Height - 6)

                if not  _G["TempEnchant" .. i].BackgroundBottom then
                    _G["TempEnchant" .. i].BackgroundBottom = _G["TempEnchant" .. i]:CreateTexture(nil, "LOW")
                    _G["TempEnchant" .. i].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                    _G["TempEnchant" .. i].BackgroundBottom:SetSize(GetConfiguration().Buffs.Width - 2, 1)
                    _G["TempEnchant" .. i].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["TempEnchant" .. i].BackgroundLeft = _G["TempEnchant" .. i]:CreateTexture(nil, "LOW")
                    _G["TempEnchant" .. i].BackgroundLeft:SetPoint("LEFT", -2, 0)
                    _G["TempEnchant" .. i].BackgroundLeft:SetSize(1, GetConfiguration().Buffs.Height - 4)
                    _G["TempEnchant" .. i].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["TempEnchant" .. i].BackgroundRight = _G["TempEnchant" .. i]:CreateTexture(nil, "LOW")
                    _G["TempEnchant" .. i].BackgroundRight:SetPoint("RIGHT", 2, 0)
                    _G["TempEnchant" .. i].BackgroundRight:SetSize(1, GetConfiguration().Buffs.Height - 4)
                    _G["TempEnchant" .. i].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["TempEnchant" .. i].BackgroundTop = _G["TempEnchant" .. i]:CreateTexture(nil, "LOW")
                    _G["TempEnchant" .. i].BackgroundTop:SetPoint("TOP", 0, 2)
                    _G["TempEnchant" .. i].BackgroundTop:SetSize(GetConfiguration().Buffs.Width - 2, 1)
                    _G["TempEnchant" .. i].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["TempEnchant" .. i].BorderBottom = _G["TempEnchant" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["TempEnchant" .. i].BorderBottom:SetPoint("BOTTOM", 0, -3)
                    _G["TempEnchant" .. i].BorderBottom:SetSize(GetConfiguration().Buffs.Width, 3)
                    _G["TempEnchant" .. i].BorderBottom:SetTexture(0, 0, 0)

                    _G["TempEnchant" .. i].BorderLeft = _G["TempEnchant" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["TempEnchant" .. i].BorderLeft:SetPoint("LEFT", -3, 0)
                    _G["TempEnchant" .. i].BorderLeft:SetSize(3, GetConfiguration().Buffs.Height - 2)
                    _G["TempEnchant" .. i].BorderLeft:SetTexture(0, 0, 0)

                    _G["TempEnchant" .. i].BorderRight = _G["TempEnchant" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["TempEnchant" .. i].BorderRight:SetPoint("RIGHT", 3, 0)
                    _G["TempEnchant" .. i].BorderRight:SetSize(3, GetConfiguration().Buffs.Height - 2)
                    _G["TempEnchant" .. i].BorderRight:SetTexture(0, 0, 0)

                    _G["TempEnchant" .. i].BorderTop = _G["TempEnchant" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["TempEnchant" .. i].BorderTop:SetPoint("TOP", 0, 3)
                    _G["TempEnchant" .. i].BorderTop:SetSize(GetConfiguration().Buffs.Width, 3)
                    _G["TempEnchant" .. i].BorderTop:SetTexture(0, 0, 0)
                end

                _G["TempEnchant" .. i .. "Border"]:Hide()

                _G["TempEnchant" .. i .. "Count"]:ClearAllPoints()
                _G["TempEnchant" .. i .. "Count"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                _G["TempEnchant" .. i .. "Count"]:SetPoint("BOTTOMRIGHT", 1, 0)

                _G["TempEnchant" .. i .. "Duration"]:ClearAllPoints()
                _G["TempEnchant" .. i .. "Duration"]:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                _G["TempEnchant" .. i .. "Duration"]:SetPoint("CENTER", 1, 0)
                _G["TempEnchant" .. i .. "Duration"]:SetShadowOffset(0, 0)

                _G["TempEnchant" .. i .. "Icon"]:SetTexCoord(GetConfiguration().Buffs.TextureCoordinate.Left, GetConfiguration().Buffs.TextureCoordinate.Right, GetConfiguration().Buffs.TextureCoordinate.Top, GetConfiguration().Buffs.TextureCoordinate.Bottom)
            end
        end
    end
end
