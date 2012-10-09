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
            Bars[#Bars + 1] = "PetActionBarFrame"

            local #CurrentIndex = #Buttons + 1

            Buttons[CurrentIndex] = "PetActionButton"
            Buttons[CurrentIndex].ActionBar = GetConfiguration().ActionBars.Pet
        end

        if GetConfiguration().ActionBars.Player then
            Bars[#Bars + 1] = "MainMenuBar"

            local #CurrentIndex = #Buttons + 1

            Buttons[CurrentIndex] = "ActionButton"
            Buttons[CurrentIndex].ActionBar = GetConfiguration().ActionBars.Player
        end

        if #Bars > 0 then
            local Class = select(2, UnitClass(Self.Frame))

            for i = 1, #Bars do
                _G[bars[i]]:SetParent(UIParent)
                _G[bars[i]]:SetPoint(Bars[i].ActionBar.Anchor, Bars[i].ActionBar.X, Bars[i].ActionBar.Y)
                _G[bars[i]]:SetSize((Bars[i].ActionBar.Buttons * Bars[i].ActionBar.Width) + ((Bars[i].ActionBar.Buttons - 1) * 4), Bars[i].ActionBar.Height)
                _G[bars[i]].SetPoint = Blank

                for j = 1, Bars[i].ActionBar.Buttons do
                    _G[bars[i] .. j]:ClearAllPoints()
                    _G[bars[i] .. j]:SetNormalTexture(nil)
                    _G[bars[i] .. j]:SetPoint("LEFT", ((i - 1) * Bars[i].ActionBar.Width) + ((i - 1) * 4) + 3, 0)
                    _G[bars[i] .. j]:SetSize(Bars[i].ActionBar.Width - 6, Bars[i].ActionBar.Height - 6)

                    _G[bars[i] .. j].BackgroundBottom = _G[bars[i] .. j]:CreateTexture(nil, "LOW")
                    _G[bars[i] .. j].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                    _G[bars[i] .. j].BackgroundBottom:SetSize(Bars[i].ActionBar.Width - 2, 1)
                    _G[bars[i] .. j].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G[bars[i] .. j].BackgroundLeft = _G[bars[i] .. j]:CreateTexture(nil, "LOW")
                    _G[bars[i] .. j].BackgroundLeft:SetPoint("LEFT", -2, 0)
                    _G[bars[i] .. j].BackgroundLeft:SetSize(1, Bars[i].ActionBar.Height - 4)
                    _G[bars[i] .. j].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G[bars[i] .. j].BackgroundRight = _G[bars[i] .. j]:CreateTexture(nil, "LOW")
                    _G[bars[i] .. j].BackgroundRight:SetPoint("RIGHT", 2, 0)
                    _G[bars[i] .. j].BackgroundRight:SetSize(1, Bars[i].ActionBar.Height - 4)
                    _G[bars[i] .. j].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G[bars[i] .. j].BackgroundTop = _G[bars[i] .. j]:CreateTexture(nil, "LOW")
                    _G[bars[i] .. j].BackgroundTop:SetPoint("TOP", 0, 2)
                    _G[bars[i] .. j].BackgroundTop:SetSize(Bars[i].ActionBar.Width - 2, 1)
                    _G[bars[i] .. j].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G[bars[i] .. j].BorderBottom = _G[bars[i] .. j]:CreateTexture(nil, "LOW")
                    _G[bars[i] .. j].BorderBottom:SetPoint("BOTTOM", 0, -3)
                    _G[bars[i] .. j].BorderBottom:SetSize(Bars[i].ActionBar.Width, 3)
                    _G[bars[i] .. j].BorderBottom:SetTexture(0, 0, 0)

                    _G[bars[i] .. j].BorderLeft = _G[bars[i] .. j]:CreateTexture(nil, "LOW")
                    _G[bars[i] .. j].BorderLeft:SetPoint("LEFT", -3, 0)
                    _G[bars[i] .. j].BorderLeft:SetSize(3, Bars[i].ActionBar.Height - 2)
                    _G[bars[i] .. j].BorderLeft:SetTexture(0, 0, 0)

                    _G[bars[i] .. j].BorderRight = _G[bars[i] .. j]:CreateTexture(nil, "LOW")
                    _G[bars[i] .. j].BorderRight:SetPoint("RIGHT", 3, 0)
                    _G[bars[i] .. j].BorderRight:SetSize(3, Bars[i].ActionBar.Height - 2)
                    _G[bars[i] .. j].BorderRight:SetTexture(0, 0, 0)

                    _G[bars[i] .. j].BorderTop = _G[bars[i] .. j]:CreateTexture(nil, "LOW")
                    _G[bars[i] .. j].BorderTop:SetPoint("TOP", 0, 3)
                    _G[bars[i] .. j].BorderTop:SetSize(Bars[i].ActionBar.Width, 3)
                    _G[bars[i] .. j].BorderTop:SetTexture(0, 0, 0)

                    _G[bars[i] .. j].SetNormalTexture = Blank
                    
                    _G[bars[i] .. j .. "AutoCastable"]:SetAlpha(0)
                    _G[bars[i] .. j .. "Border"]:SetAlpha(0)
                    _G[bars[i] .. j .. "Border"].SetVertexColor = Blank
                    _G[bars[i] .. j .. "Cooldown"]:SetSize(Bars[i].ActionBar.Width - 6, Bars[i].ActionBar.Height - 6)
                    _G[bars[i] .. j .. "Cooldown"]:SetPoint("CENTER")
                    _G[bars[i] .. j .. "Count"]:SetAlpha(0)
                    _G[bars[i] .. j .. "FlyoutBorder"]:SetAlpha(0)
                    _G[bars[i] .. j .. "FlyoutBorderShadow"]:SetAlpha(0)                    
                    _G[bars[i] .. j .. "HotKey"]:SetAlpha(0)
                    _G[bars[i] .. j .. "Icon"]:SetTexCoord(Bars[i].ActionBar.TextureCoordinate.Left, Bars[i].ActionBar.TextureCoordinate.Right, Bars[i].ActionBar.TextureCoordinate.Top, Bars[i].ActionBar.TextureCoordinate.Bottom)
                    _G[bars[i] .. j .. "Name"]:SetAlpha(0)
                    _G[bars[i] .. j .. "Shine"]:SetAllPoints(_G[bars[i] .. j])
                end
            end
        end
    end
end
