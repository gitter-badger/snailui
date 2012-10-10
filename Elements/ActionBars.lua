-- ActionBars.lua
-- Written by Snail

function HandleActionBars()
    if GetConfiguration().ActionBars then
        ActionButton_UpdateUsable = function(Self)
            local IsUsable, NotEnoughMana = IsUsableAction(Self.action);

            if IsUsable then
                _G[Self:GetName() .. "Icon"]:SetVertexColor(1.0, 1.0, 1.0);
            elseif NotEnoughMana then
                _G[Self:GetName() .. "Icon"]:SetVertexColor(0.5, 0.5, 1.0);
            else
                _G[Self:GetName() .. "Icon"]:SetVertexColor(0.4, 0.4, 0.4);
            end
        end

        local Bars = {}
        local Buttons = {}

        if GetConfiguration().ActionBars.Pet then
            local CurrentIndex = #Bars + 1

            Bars[CurrentIndex] = GetConfiguration().ActionBars.Pet
            Bars[CurrentIndex].ActionBar = "PetActionBarFrame"

            Buttons[CurrentIndex] = "PetActionButton"
        end

        if GetConfiguration().ActionBars.Player then
            local CurrentIndex = #Bars + 1

            Bars[CurrentIndex] = GetConfiguration().ActionBars.Player
            Bars[CurrentIndex].ActionBar = "MainMenuBar"

            Buttons[CurrentIndex] = "ActionButton"
        end

        if #Bars > 0 then
            local Class = select(2, UnitClass("Player"))

            for i = 1, #Bars do
                _G[Bars[i].ActionBar]:ClearAllPoints()
                _G[Bars[i].ActionBar]:SetPoint(Bars[i].Anchor, Bars[i].X, Bars[i].Y)
                _G[Bars[i].ActionBar]:SetSize((Bars[i].Buttons * Bars[i].Width) + ((Bars[i].Buttons - 1) * 4), Bars[i].Height)
                _G[Bars[i].ActionBar].SetPoint = Blank

                for j = 1, Bars[i].Buttons do
                    _G[Buttons[i] .. j]:ClearAllPoints()
                    _G[Buttons[i] .. j]:SetNormalTexture(nil)
                    _G[Buttons[i] .. j]:SetPoint("LEFT", ((j - 1) * Bars[i].Width) + ((j - 1) * 4) + 3, 0)
                    _G[Buttons[i] .. j]:SetSize(Bars[i].Width - 6, Bars[i].Height - 6)

                    _G[Buttons[i] .. j].BackgroundBottom = _G[Buttons[i] .. j]:CreateTexture(nil, "LOW")
                    _G[Buttons[i] .. j].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                    _G[Buttons[i] .. j].BackgroundBottom:SetSize(Bars[i].Width - 2, 1)
                    _G[Buttons[i] .. j].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G[Buttons[i] .. j].BackgroundLeft = _G[Buttons[i] .. j]:CreateTexture(nil, "LOW")
                    _G[Buttons[i] .. j].BackgroundLeft:SetPoint("LEFT", -2, 0)
                    _G[Buttons[i] .. j].BackgroundLeft:SetSize(1, Bars[i].Height - 4)
                    _G[Buttons[i] .. j].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G[Buttons[i] .. j].BackgroundRight = _G[Buttons[i] .. j]:CreateTexture(nil, "LOW")
                    _G[Buttons[i] .. j].BackgroundRight:SetPoint("RIGHT", 2, 0)
                    _G[Buttons[i] .. j].BackgroundRight:SetSize(1, Bars[i].Height - 4)
                    _G[Buttons[i] .. j].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G[Buttons[i] .. j].BackgroundTop = _G[Buttons[i] .. j]:CreateTexture(nil, "LOW")
                    _G[Buttons[i] .. j].BackgroundTop:SetPoint("TOP", 0, 2)
                    _G[Buttons[i] .. j].BackgroundTop:SetSize(Bars[i].Width - 2, 1)
                    _G[Buttons[i] .. j].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G[Buttons[i] .. j].BorderBottom = _G[Buttons[i] .. j]:CreateTexture(nil, "LOW")
                    _G[Buttons[i] .. j].BorderBottom:SetPoint("BOTTOM", 0, -3)
                    _G[Buttons[i] .. j].BorderBottom:SetSize(Bars[i].Width, 3)
                    _G[Buttons[i] .. j].BorderBottom:SetTexture(0, 0, 0)

                    _G[Buttons[i] .. j].BorderLeft = _G[Buttons[i] .. j]:CreateTexture(nil, "LOW")
                    _G[Buttons[i] .. j].BorderLeft:SetPoint("LEFT", -3, 0)
                    _G[Buttons[i] .. j].BorderLeft:SetSize(3, Bars[i].Height - 2)
                    _G[Buttons[i] .. j].BorderLeft:SetTexture(0, 0, 0)

                    _G[Buttons[i] .. j].BorderRight = _G[Buttons[i] .. j]:CreateTexture(nil, "LOW")
                    _G[Buttons[i] .. j].BorderRight:SetPoint("RIGHT", 3, 0)
                    _G[Buttons[i] .. j].BorderRight:SetSize(3, Bars[i].Height - 2)
                    _G[Buttons[i] .. j].BorderRight:SetTexture(0, 0, 0)

                    _G[Buttons[i] .. j].BorderTop = _G[Buttons[i] .. j]:CreateTexture(nil, "LOW")
                    _G[Buttons[i] .. j].BorderTop:SetPoint("TOP", 0, 3)
                    _G[Buttons[i] .. j].BorderTop:SetSize(Bars[i].Width, 3)
                    _G[Buttons[i] .. j].BorderTop:SetTexture(0, 0, 0)

                    _G[Buttons[i] .. j].SetNormalTexture = Blank

                    _G[Buttons[i] .. j .. "Border"]:SetAlpha(0)
                    _G[Buttons[i] .. j .. "Border"].SetVertexColor = Blank
                    _G[Buttons[i] .. j .. "Cooldown"]:SetSize(Bars[i].Width - 6, Bars[i].Height - 6)
                    _G[Buttons[i] .. j .. "Cooldown"]:SetPoint("CENTER")
                    _G[Buttons[i] .. j .. "Count"]:SetAlpha(0)
                    _G[Buttons[i] .. j .. "FlyoutBorder"]:SetAlpha(0)
                    _G[Buttons[i] .. j .. "FlyoutBorderShadow"]:SetAlpha(0)                    
                    _G[Buttons[i] .. j .. "HotKey"]:SetAlpha(0)
                    _G[Buttons[i] .. j .. "Icon"]:SetTexCoord(Bars[i].TextureCoordinate.Left, Bars[i].TextureCoordinate.Right, Bars[i].TextureCoordinate.Top, Bars[i].TextureCoordinate.Bottom)
                    _G[Buttons[i] .. j .. "Name"]:SetAlpha(0)

                    if _G[Buttons[i] .. j .. "AutoCastable"] then
                        _G[Buttons[i] .. j .. "AutoCastable"]:SetAlpha(0)
                    end

                    if _G[Buttons[i] .. j .. "Shine"] then
                        _G[Buttons[i] .. j .. "Shine"]:SetAllPoints(_G[Buttons[i] .. j])
                    end
                end
            end
        end
    end
end
