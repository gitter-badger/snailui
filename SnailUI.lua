-- Snail.lua
-- Written by Snail

local Class = select(2, UnitClass("Player"))
local Themes = {}
local Version = "0.3.3"

if not Theme then
    Theme = Configuration.Theme
end

oUF:RegisterStyle("SnailUI", 
    function(Self, Unit)
        Unit = Unit:gsub("(.)", string.upper, 1)
        
        if GetConfiguration()[Unit] then
            local Specialization = GetSpecialization()

            if Specialization then
                Specialization = select(2, GetSpecializationInfo(Specialization))
                Specialization = Specialization:gsub("(.)", string.upper)
            else
                Specialization = nil
            end

            Self.Frame = Unit
            Self.menu = function(Self)
                if Self.unit:match("^party") then
                    ToggleDropDownMenu(1, nil, _G["PartyMemberFrame" .. Self.id .. "DropDown"], "cursor", 0, 0)
                elseif Self.unit:match("^raid") then
                    Self.name = Self.unit
                    RaidGroupButton_ShowMenu(Self)
                else
                    ToggleDropDownMenu(1, nil, _G[Self.unit:gsub("(.)", string.upper, 1) .. "FrameDropDown"], "cursor", 0, 0)
                end
            end

            Self.Background = Self:CreateTexture(nil, "LOW")
            Self.Background:SetPoint("TOPLEFT", 1, -1)
            Self.Background:SetSize(GetConfiguration()[Self.Frame].Width - 2, GetConfiguration()[Self.Frame].Height - 2)

            Self.Border = Self:CreateTexture(nil, "BACKGROUND")
            Self.Border:SetPoint("TOPLEFT")
            Self.Border:SetSize(GetConfiguration()[Self.Frame].Width, GetConfiguration()[Self.Frame].Height)
            Self.Border:SetTexture(0, 0, 0)

            Self.PostUpdate = function(Self)
                if UnitClass(Self.unit) then
                    Self.ClassColor = RAID_CLASS_COLORS[select(2, UnitClass(Self.unit))]
                else
                    Self.ClassColor =
                    {
                        b = 1,
                        g = 1,
                        r = 1
                    }
                end

                Self.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

                if UnitThreatSituation(Self.unit) and (Self.Frame == "Raid") and GetConfiguration()[Self.Frame].ColorByThreatLevel then
                    if UnitThreatSituation(Self.unit) > 0 then
                        Self.threatColor =
                        {
                            b = 0,
                            g = 0,
                            r = 0
                        }

                        Self.threatColor.r, Self.threatColor.g, Self.threatColor.b = GetThreatStatusColor(UnitThreatSituation(Self.unit))
                        Self.Background:SetTexture(Self.threatColor.r, Self.threatColor.g, Self.threatColor.b)
                    end
                end

                if Self.Castbar then
                    Self.Castbar:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    Self.Castbar.BackgroundBottom:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    Self.Castbar.BackgroundLeft:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    Self.Castbar.BackgroundRight:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    Self.Castbar.BackgroundTop:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

                    if Self.Castbar.IconBackgroundBottom then
                        Self.Castbar.IconBackgroundBottom:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                        Self.Castbar.IconBackgroundLeft:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                        Self.Castbar.IconBackgroundRight:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                        Self.Castbar.IconBackgroundTop:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    end

                    if Self.Castbar.Text then
                        Self.Castbar.Text:SetTextColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    end

                    if Self.Castbar.Time then
                        Self.Castbar.Time:SetTextColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    end
                end

                if Self.ClassIcons then
                    Self.ClassIcons.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

                    for i = 1, 5 do
                        Self.ClassIcons[i]:SetVertexColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    end
                end

                if Self.CPoints then
                    Self.CPoints.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

                    for i = 1, #Self.CPoints do
                        Self.CPoints[i]:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    end
                end

                if Self.EclipseBar then
                    Self.EclipseBar.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                end

                if Self.Health then
                    Self.Health:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

                    if Self.HealPrediction.myBar then
                        Self.HealPrediction.myBar:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    end

                    if Self.HealPrediction.otherBar then
                        Self.HealPrediction.otherBar:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    end

                    if Self.Health.Health then
                        Self.Health.Health:SetTextColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    end
                end
                
                if Self.Power then
                    Self.Power:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

                    if Self.Power.BackgroundBottom then
                        Self.Power.BackgroundBottom:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                        Self.Power.BackgroundLeft:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                        Self.Power.BackgroundRight:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                        Self.Power.BackgroundTop:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    end
                end

                if Self.Runes then
                    Self.Runes.Background:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                end

                if Self.WarlockSpecBars then
                    Self.warlockSpecBarsBackground:SetTexture(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)

                    for i = 1, #Self.WarlockSpecBars do
                        Self.WarlockSpecBars[i]:SetStatusBarColor(Self.ClassColor.r, Self.ClassColor.g, Self.ClassColor.b)
                    end
                end
            end

            Self.SpellRange =
            {
                Update = function(Self, InRange)
                    if Configuration.InactiveAlpha then
                        if UnitIsUnit(Self.unit, "player") then
                            InRange = true
                        end

                        if InRange then
                            Self:SetAlpha(1)
                            Self.InRange = InRange

                            if GetConfiguration()[Self.Frame].HealthThreshold then
                                if math.floor(((UnitHealth(Self.unit) / UnitHealthMax(Self.unit)) * 100) + 0.5) >= GetConfiguration()[Self.Frame].HealthThreshold then
                                    Self:SetAlpha(Configuration.InactiveAlpha)
                                end
                            end
                        else
                            Self:SetAlpha(Configuration.InactiveAlpha)
                            Self.InRange = nil
                        end
                    end
                end
            }

            if Unit == "Player" then
                Self:RegisterEvent("PLAYER_DEAD",
                    function()
                        local InInstance, InstanceType = IsInInstance()

                        if InInstance then
                            if InstanceType == "pvp" then
                                RepopMe()
                            end
                        end
                    end
                )
            end

            Self:RegisterEvent("UNIT_THREAT_SITUATION_UPDATE", Self.PostUpdate)
            Self:RegisterForClicks("AnyUp")
            Self:SetSize(GetConfiguration()[Self.Frame].Width, GetConfiguration()[Self.Frame].Height)
            Self:SetScript("OnEnter",
                function(Self)
                    UnitFrame_UpdateTooltip(Self)
                end
            )

            Self:SetScript("OnLeave",
                function(Self)
                    GameTooltip_Hide()
                end
            )

            if GetConfiguration()[Self.Frame].HealthThreshold then
                Self:RegisterEvent("UNIT_HEALTH",
                    function(Self)
                        Self:SetAlpha(Configuration.InactiveAlpha)

                        if math.floor(((UnitHealth(Self.unit) / UnitHealthMax(Self.unit)) * 100) + 0.5) < GetConfiguration()[Self.Frame].HealthThreshold then
                            if Self.InRange then
                                Self:SetAlpha(1)
                            end
                        end
                    end
                )
            end

            if GetConfiguration()[Self.Frame].BurningEmbersBar and (Unit == "Player") then
                if (Class == "WARLOCK") and (Specialization == "DESTRUCTION") then
                    Self.WarlockSpecBars = CreateFrame("Frame", nil, Self)
                    Self.WarlockSpecBars:SetPoint(GetConfiguration()[Self.Frame].BurningEmbersBar.Anchor, GetConfiguration()[Self.Frame].BurningEmbersBar.X, GetConfiguration()[Self.Frame].BurningEmbersBar.Y)
                    Self.WarlockSpecBars:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar.Width - 2, GetConfiguration()[Self.Frame].BurningEmbersBar.Height - 2)

                    Self.warlockSpecBarsBackground = Self:CreateTexture(nil, "BACKGROUND")
                    Self.warlockSpecBarsBackground:SetPoint("TOPLEFT", Self.WarlockSpecBars)
                    Self.warlockSpecBarsBackground:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar.Width - 2, GetConfiguration()[Self.Frame].BurningEmbersBar.Height - 2)

                    Self.warlockSpecBarsBorder = Self:CreateTexture(nil, "BACKGROUND")
                    Self.warlockSpecBarsBorder:SetPoint("TOPLEFT", Self.WarlockSpecBars, -1, 1)
                    Self.warlockSpecBarsBorder:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar.Width, GetConfiguration()[Self.Frame].BurningEmbersBar.Height)
                    Self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

                    for i = 1, #GetConfiguration()[Self.Frame].BurningEmbersBar do
                        Self.WarlockSpecBars[i] = CreateFrame("StatusBar", nil, Self)
                        Self.WarlockSpecBars[i]:SetPoint(GetConfiguration()[Self.Frame].BurningEmbersBar[i].Anchor, Self.WarlockSpecBars, GetConfiguration()[Self.Frame].BurningEmbersBar[i].X, GetConfiguration()[Self.Frame].BurningEmbersBar[i].Y)
                        Self.WarlockSpecBars[i]:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar[i].Width - 2, GetConfiguration()[Self.Frame].BurningEmbersBar[i].Height - 2)
                        Self.WarlockSpecBars[i]:SetStatusBarTexture(Configuration.Texture)

                        Self.warlockSpecBarsBorder[i] = Self:CreateTexture(nil, "LOW")
                        Self.warlockSpecBarsBorder[i]:SetPoint("TOPLEFT", Self.WarlockSpecBars[i], -1, 1)
                        Self.warlockSpecBarsBorder[i]:SetSize(GetConfiguration()[Self.Frame].BurningEmbersBar[i].Width, GetConfiguration()[Self.Frame].BurningEmbersBar[i].Height)
                        Self.warlockSpecBarsBorder[i]:SetTexture(0, 0, 0)
                    end
                end
            end

            if GetConfiguration()[Self.Frame].CastingBar then
                Self.Castbar = CreateFrame("StatusBar", nil, Self)
                Self.Castbar:SetOrientation(GetConfiguration()[Self.Frame].CastingBar.Orientation)
                Self.Castbar:SetPoint(GetConfiguration()[Self.Frame].CastingBar.Anchor, GetConfiguration()[Self.Frame].CastingBar.X, GetConfiguration()[Self.Frame].CastingBar.Y)
                Self.Castbar:SetSize(GetConfiguration()[Self.Frame].CastingBar.Width - 6, GetConfiguration()[Self.Frame].CastingBar.Height - 6)
                Self.Castbar:SetStatusBarTexture(Configuration.Texture)

                Self.Castbar.BackgroundBottom = Self.Castbar:CreateTexture(nil, "LOW")
                Self.Castbar.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                Self.Castbar.BackgroundBottom:SetSize(GetConfiguration()[Self.Frame].CastingBar.Width - 2, 1)

                Self.Castbar.BackgroundLeft = Self.Castbar:CreateTexture(nil, "LOW")
                Self.Castbar.BackgroundLeft:SetPoint("LEFT", -2, 0)
                Self.Castbar.BackgroundLeft:SetSize(1, GetConfiguration()[Self.Frame].CastingBar.Height - 4)

                Self.Castbar.BackgroundRight = Self.Castbar:CreateTexture(nil, "LOW")
                Self.Castbar.BackgroundRight:SetPoint("RIGHT", 2, 0)
                Self.Castbar.BackgroundRight:SetSize(1, GetConfiguration()[Self.Frame].CastingBar.Height - 4)

                Self.Castbar.BackgroundTop = Self.Castbar:CreateTexture(nil, "LOW")
                Self.Castbar.BackgroundTop:SetPoint("TOP", 0, 2)
                Self.Castbar.BackgroundTop:SetSize(GetConfiguration()[Self.Frame].CastingBar.Width - 2, 1)

                Self.Castbar.Border = Self.Castbar:CreateTexture(nil, "BACKGROUND")
                Self.Castbar.Border:SetPoint("TOPLEFT", -3, 3)
                Self.Castbar.Border:SetSize(GetConfiguration()[Self.Frame].CastingBar.Width, GetConfiguration()[Self.Frame].CastingBar.Height)
                Self.Castbar.Border:SetTexture(0, 0, 0)

                if GetConfiguration()[Self.Frame].CastingBar.Spell then
                    if GetConfiguration()[Self.Frame].CastingBar.Spell.Duration then
                        Self.Castbar.Time = Self.Castbar:CreateFontString(nil, "OVERLAY")
                        Self.Castbar.Time:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                        Self.Castbar.Time:SetPoint(GetConfiguration()[Self.Frame].CastingBar.Spell.Duration.Anchor, GetConfiguration()[Self.Frame].CastingBar.Spell.Duration.X, GetConfiguration()[Self.Frame].CastingBar.Spell.Duration.Y)
                    end

                    if GetConfiguration()[Self.Frame].CastingBar.Spell.Name then
                        Self.Castbar.Text = Self.Castbar:CreateFontString(nil, "OVERLAY")
                        Self.Castbar.Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                        Self.Castbar.Text:SetPoint(GetConfiguration()[Self.Frame].CastingBar.Spell.Name.Anchor, GetConfiguration()[Self.Frame].CastingBar.Spell.Name.X, GetConfiguration()[Self.Frame].CastingBar.Spell.Name.Y)
                    end

                    if GetConfiguration()[Self.Frame].CastingBar.Spell.Texture then
                        Self.Castbar.Icon = Self.Castbar:CreateTexture(nil, "LOW")
                        Self.Castbar.Icon:SetPoint(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Anchor, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.X, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Y)
                        Self.Castbar.Icon:SetSize(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Width - 6, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Height - 6)
                        Self.Castbar.Icon:SetTexCoord(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.TextureCoordinate.Left, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.TextureCoordinate.Right, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.TextureCoordinate.Top, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.TextureCoordinate.Bottom)

                        Self.Castbar.IconBackgroundBottom = Self.Castbar:CreateTexture(nil, "LOW")
                        Self.Castbar.IconBackgroundBottom:SetPoint("BOTTOM", Self.Castbar.Icon, 0, -2)
                        Self.Castbar.IconBackgroundBottom:SetSize(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Width - 2, 1)

                        Self.Castbar.IconBackgroundLeft = Self.Castbar:CreateTexture(nil, "LOW")
                        Self.Castbar.IconBackgroundLeft:SetPoint("LEFT", Self.Castbar.Icon, -2, 0)
                        Self.Castbar.IconBackgroundLeft:SetSize(1, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Height - 4)

                        Self.Castbar.IconBackgroundRight = Self.Castbar:CreateTexture(nil, "LOW")
                        Self.Castbar.IconBackgroundRight:SetPoint("RIGHT", Self.Castbar.Icon, 2, 0)
                        Self.Castbar.IconBackgroundRight:SetSize(1, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Height - 4)

                        Self.Castbar.IconBackgroundTop = Self.Castbar:CreateTexture(nil, "LOW")
                        Self.Castbar.IconBackgroundTop:SetPoint("TOP", Self.Castbar.Icon, 0, 2)
                        Self.Castbar.IconBackgroundTop:SetSize(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Width - 2, 1)

                        Self.Castbar.IconBorder = Self.Castbar:CreateTexture(nil, "BACKGROUND")
                        Self.Castbar.IconBorder:SetPoint("TOPLEFT", Self.Castbar.Icon, -3, 3)
                        Self.Castbar.IconBorder:SetSize(GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Width, GetConfiguration()[Self.Frame].CastingBar.Spell.Texture.Height)
                        Self.Castbar.IconBorder:SetTexture(0, 0, 0)
                    end
                end
            end

            if GetConfiguration()[Self.Frame].ChiBar and (Unit == "Player") then
                if Class == "MONK" then
                    Self.ClassIcons = Self:CreateTexture(Self, "BACKGROUND")
                    Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].ChiBar.Anchor, GetConfiguration()[Self.Frame].ChiBar.X, GetConfiguration()[Self.Frame].ChiBar.Y)
                    Self.ClassIcons:SetSize(GetConfiguration()[Self.Frame].ChiBar.Width, GetConfiguration()[Self.Frame].ChiBar.Height)
                    Self.ClassIcons:SetTexture(0, 0, 0)

                    Self.ClassIcons.Background = Self:CreateTexture(nil, "BACKGROUND")
                    Self.ClassIcons.Background:SetPoint("TOPLEFT", Self.ClassIcons, 1, -1)
                    Self.ClassIcons.Background:SetSize(GetConfiguration()[Self.Frame].ChiBar.Width - 2, GetConfiguration()[Self.Frame].ChiBar.Height - 2)

                    for i = 1, 5 do
                        Self.ClassIcons[i] = Self:CreateTexture(Self, "LOW")

                        if i <= #GetConfiguration()[Self.Frame].ChiBar then
                            Self.ClassIcons[i]:SetPoint(GetConfiguration()[Self.Frame].ChiBar[i].Anchor, Self.ClassIcons, GetConfiguration()[Self.Frame].ChiBar[i].X, GetConfiguration()[Self.Frame].ChiBar[i].Y)
                            Self.ClassIcons[i]:SetSize(GetConfiguration()[Self.Frame].ChiBar[i].Width - 2, GetConfiguration()[Self.Frame].ChiBar[i].Height - 2)
                            Self.ClassIcons[i]:SetTexture(Configuration.Texture)

                            Self.ClassIcons[i].Border = Self:CreateTexture(nil, "LOW")
                            Self.ClassIcons[i].Border:SetPoint("TOPLEFT", Self.ClassIcons[i], -1, 1)
                            Self.ClassIcons[i].Border:SetSize(GetConfiguration()[Self.Frame].ChiBar[i].Width, GetConfiguration()[Self.Frame].ChiBar[i].Height)
                            Self.ClassIcons[i].Border:SetTexture(0, 0, 0)
                        end
                    end
                end
            end

            if GetConfiguration()[Self.Frame].ComboPointsBar and (Unit == "Player") then
                if (Class == "ROGUE") or ((Class == "DRUID") and (Specialization == "FERAL")) then
                    Self.CPoints = CreateFrame("Frame", nil, Self)
                    Self.CPoints:SetPoint(GetConfiguration()[Self.Frame].ComboPointsBar.Anchor, GetConfiguration()[Self.Frame].ComboPointsBar.X, GetConfiguration()[Self.Frame].ComboPointsBar.Y)
                    Self.CPoints:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar.Width - 2, GetConfiguration()[Self.Frame].ComboPointsBar.Height - 2)

                    Self.CPoints.Background = Self.CPoints:CreateTexture(nil, "BACKGROUND")
                    Self.CPoints.Background:SetPoint("TOPLEFT")
                    Self.CPoints.Background:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar.Width - 2, GetConfiguration()[Self.Frame].ComboPointsBar.Height - 2)

                    Self.CPoints.Border = Self.CPoints:CreateTexture(nil, "BACKGROUND")
                    Self.CPoints.Border:SetPoint("TOPLEFT", -1, 1)
                    Self.CPoints.Border:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar.Width, GetConfiguration()[Self.Frame].ComboPointsBar.Height)
                    Self.CPoints.Border:SetTexture(0, 0, 0)

                    for i = 1, #GetConfiguration()[Self.Frame].ComboPointsBar do
                        Self.CPoints[i] = CreateFrame("StatusBar", nil, Self)
                        Self.CPoints[i]:SetPoint(GetConfiguration()[Self.Frame].ComboPointsBar[i].Anchor, Self.CPoints, GetConfiguration()[Self.Frame].ComboPointsBar[i].X, GetConfiguration()[Self.Frame].ComboPointsBar[i].Y)
                        Self.CPoints[i]:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar[i].Width - 2, GetConfiguration()[Self.Frame].ComboPointsBar[i].Height - 2)
                        Self.CPoints[i]:SetStatusBarTexture(Configuration.Texture)

                        Self.CPoints[i].Border = Self.CPoints:CreateTexture(nil, "LOW")
                        Self.CPoints[i].Border:SetPoint("TOPLEFT", Self.CPoints[i], -1, 1)
                        Self.CPoints[i].Border:SetSize(GetConfiguration()[Self.Frame].ComboPointsBar[i].Width, GetConfiguration()[Self.Frame].ComboPointsBar[i].Height)
                        Self.CPoints[i].Border:SetTexture(0, 0, 0)
                    end
                end
            end

            if GetConfiguration()[Self.Frame].EclipseBar and (Unit == "Player") then
                if (Class == "DRUID") and (Specialization == "BALANCE") then
                    Self.EclipseBar = CreateFrame("Frame", nil, Self)
                    Self.EclipseBar:SetPoint(GetConfiguration()[Self.Frame].EclipseBar.Anchor, GetConfiguration()[Self.Frame].EclipseBar.X, GetConfiguration()[Self.Frame].EclipseBar.Y)
                    Self.EclipseBar:SetSize(GetConfiguration()[Self.Frame].EclipseBar.Width - 2, GetConfiguration()[Self.Frame].EclipseBar.Height - 2)

                    Self.EclipseBar.Background = Self.EclipseBar:CreateTexture(nil, "BACKGROUND")
                    Self.EclipseBar.Background:SetPoint("TOPLEFT")
                    Self.EclipseBar.Background:SetSize(GetConfiguration()[Self.Frame].EclipseBar.Width - 2, GetConfiguration()[Self.Frame].EclipseBar.Height - 2)

                    Self.EclipseBar.Border = Self.EclipseBar:CreateTexture(nil, "BACKGROUND")
                    Self.EclipseBar.Border:SetPoint("TOPLEFT", -1, 1)
                    Self.EclipseBar.Border:SetSize(GetConfiguration()[Self.Frame].EclipseBar.Width, GetConfiguration()[Self.Frame].EclipseBar.Height)
                    Self.EclipseBar.Border:SetTexture(0, 0, 0)

                    Self.EclipseBar.InnerBorder = Self.EclipseBar:CreateTexture(nil, "LOW")
                    Self.EclipseBar.InnerBorder:SetPoint("TOPLEFT", 1, -1)
                    Self.EclipseBar.InnerBorder:SetSize(GetConfiguration()[Self.Frame].EclipseBar[1].Width, GetConfiguration()[Self.Frame].EclipseBar[1].Height)
                    Self.EclipseBar.InnerBorder:SetTexture(0, 0, 0)

                    Self.EclipseBar.LunarBar = CreateFrame("StatusBar", nil, Self)
                    Self.EclipseBar.LunarBar:SetPoint(GetConfiguration()[Self.Frame].EclipseBar[1].Anchor, Self.EclipseBar, GetConfiguration()[Self.Frame].EclipseBar[1].X, GetConfiguration()[Self.Frame].EclipseBar[1].Y)
                    Self.EclipseBar.LunarBar:SetSize(GetConfiguration()[Self.Frame].EclipseBar[1].Width - 2, GetConfiguration()[Self.Frame].EclipseBar[1].Height - 2)
                    Self.EclipseBar.LunarBar:SetStatusBarTexture(Configuration.Texture)
                    Self.EclipseBar.LunarBar:SetStatusBarColor(0.3, 0.52, 0.9)

                    Self.EclipseBar.SolarBar = CreateFrame("StatusBar", nil, Self)
                    Self.EclipseBar.SolarBar:SetPoint("LEFT", Self.EclipseBar.LunarBar:GetStatusBarTexture(), "RIGHT")
                    Self.EclipseBar.SolarBar:SetSize(GetConfiguration()[Self.Frame].EclipseBar[1].Width - 2, GetConfiguration()[Self.Frame].EclipseBar[1].Height - 2)
                    Self.EclipseBar.SolarBar:SetStatusBarTexture(Configuration.Texture)
                    Self.EclipseBar.SolarBar:SetStatusBarColor(0.8, 0.82, 0.6)

                    Self.EclipseBar.direction = Self.EclipseBar:CreateFontString(nil, "OVERLAY")
                    Self.EclipseBar.direction.frequentUpdates = true
                    Self.EclipseBar.direction:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                    Self.EclipseBar.direction:SetPoint("CENTER", Self.EclipseBar.InnerBorder, 1, 0)
                    Self.EclipseBar.direction:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    Self:Tag(Self.EclipseBar.direction, "[SnailUI:EclipseDirection]")
                end
            end

            if GetConfiguration()[Self.Frame].DemonicFuryBar and (Unit == "Player") then
                if (Class == "WARLOCK") and (Specialization == "DEMONOLOGY") then
                    Self.WarlockSpecBars = CreateFrame("Frame", nil, Self)
                    Self.WarlockSpecBars:SetPoint(GetConfiguration()[Self.Frame].DemonicFuryBar.Anchor, GetConfiguration()[Self.Frame].DemonicFuryBar.X, GetConfiguration()[Self.Frame].DemonicFuryBar.Y)
                    Self.WarlockSpecBars:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar.Width - 2, GetConfiguration()[Self.Frame].DemonicFuryBar.Height - 2)

                    Self.warlockSpecBarsBackground = Self:CreateTexture(nil, "BACKGROUND")
                    Self.warlockSpecBarsBackground:SetPoint("TOPLEFT", Self.WarlockSpecBars)
                    Self.warlockSpecBarsBackground:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar.Width - 2, GetConfiguration()[Self.Frame].DemonicFuryBar.Height - 2)

                    Self.warlockSpecBarsBorder = Self:CreateTexture(nil, "BACKGROUND")
                    Self.warlockSpecBarsBorder:SetPoint("TOPLEFT", Self.WarlockSpecBars, -1, 1)
                    Self.warlockSpecBarsBorder:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar.Width, GetConfiguration()[Self.Frame].DemonicFuryBar.Height)
                    Self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

                    for i = 1, #GetConfiguration()[Self.Frame].DemonicFuryBar do
                        Self.WarlockSpecBars[i] = CreateFrame("StatusBar", nil, Self)
                        Self.WarlockSpecBars[i]:SetPoint(GetConfiguration()[Self.Frame].DemonicFuryBar[i].Anchor, Self.WarlockSpecBars, GetConfiguration()[Self.Frame].DemonicFuryBar[i].X, GetConfiguration()[Self.Frame].DemonicFuryBar[i].Y)
                        Self.WarlockSpecBars[i]:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar[i].Width - 2, GetConfiguration()[Self.Frame].DemonicFuryBar[i].Height - 2)
                        Self.WarlockSpecBars[i]:SetStatusBarTexture(Configuration.Texture)

                        Self.warlockSpecBarsBorder[i] = Self:CreateTexture(nil, "LOW")
                        Self.warlockSpecBarsBorder[i]:SetPoint("TOPLEFT", Self.WarlockSpecBars[i], -1, 1)
                        Self.warlockSpecBarsBorder[i]:SetSize(GetConfiguration()[Self.Frame].DemonicFuryBar[i].Width, GetConfiguration()[Self.Frame].DemonicFuryBar[i].Height)
                        Self.warlockSpecBarsBorder[i]:SetTexture(0, 0, 0)
                    end
                end
            end

            if GetConfiguration()[Self.Frame].HealthBar then
                Self:RegisterEvent("UNIT_HEAL_PREDICTION",
                    function(Self)
                        Self.HealPrediction.myBar:SetAlpha(Self:GetAlpha() / 2)
                        Self.HealPrediction.otherBar:SetAlpha(Self:GetAlpha() / 2)
                    end
                )

                Self.Health = CreateFrame("StatusBar", nil, Self)
                Self.Health.frequentUpdates = true
                Self.Health:SetOrientation(GetConfiguration()[Self.Frame].HealthBar.Orientation)
                Self.Health:SetPoint(GetConfiguration()[Self.Frame].HealthBar.Anchor, GetConfiguration()[Self.Frame].HealthBar.X, GetConfiguration()[Self.Frame].HealthBar.Y)
                Self.Health:SetSize(GetConfiguration()[Self.Frame].HealthBar.Width - 2, GetConfiguration()[Self.Frame].HealthBar.Height - 2)
                Self.Health:SetStatusBarTexture(Configuration.Texture)
                
                Self.Health.Border = Self.Health:CreateTexture(nil, "LOW")
                Self.Health.Border:SetPoint("TOPLEFT", -1, 1)
                Self.Health.Border:SetSize(GetConfiguration()[Self.Frame].HealthBar.Width, GetConfiguration()[Self.Frame].HealthBar.Height)
                Self.Health.Border:SetTexture(0, 0, 0)

                Self.HealPrediction =
                {
                    maxOverflow = 1,
                    myBar = CreateFrame("StatusBar", nil, Self),
                    otherBar = CreateFrame("StatusBar", nil, Self)
                }

                Self.HealPrediction.myBar:SetPoint("TOPLEFT", Self.Health:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
                Self.HealPrediction.myBar:SetPoint("BOTTOMLEFT", Self.Health:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
                Self.HealPrediction.myBar:SetSize(GetConfiguration()[Self.Frame].HealthBar.Width - 2, GetConfiguration()[Self.Frame].HealthBar.Height - 2)
                Self.HealPrediction.myBar:SetStatusBarTexture(Configuration.Texture)

                Self.HealPrediction.otherBar:SetPoint("TOPLEFT", Self.HealPrediction.myBar:GetStatusBarTexture(), "TOPRIGHT", 0, 0)
                Self.HealPrediction.otherBar:SetPoint("BOTTOMLEFT", Self.HealPrediction.myBar:GetStatusBarTexture(), "BOTTOMRIGHT", 0, 0)
                Self.HealPrediction.otherBar:SetSize(GetConfiguration()[Self.Frame].HealthBar.Width - 2, GetConfiguration()[Self.Frame].HealthBar.Height - 2)
                Self.HealPrediction.otherBar:SetStatusBarTexture(Configuration.Texture)

                if GetConfiguration()[Self.Frame].HealthBar.Health then
                    Self.Health.Health = Self.Health:CreateFontString(nil, "OVERLAY")
                    Self.Health.Health.frequentUpdates = true
                    Self.Health.Health:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                    Self.Health.Health:SetPoint(GetConfiguration()[Self.Frame].HealthBar.Health.Anchor, GetConfiguration()[Self.Frame].HealthBar.Health.X, GetConfiguration()[Self.Frame].HealthBar.Health.Y)

                    if GetConfiguration()[Self.Frame].HealthBar.Health.SmallText then
                        Self:Tag(Self.Health.Health, "[SnailUI:SmallHealth]")
                    else
                        Self:Tag(Self.Health.Health, "[SnailUI:Health]")
                    end
                end
            end

            if GetConfiguration()[Self.Frame].HolyPowerBar and (Unit == "Player") then
                if Class == "PALADIN" then
                    Self.ClassIcons = Self:CreateTexture(Self, "BACKGROUND")
                    Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].HolyPowerBar.Anchor, GetConfiguration()[Self.Frame].HolyPowerBar.X, GetConfiguration()[Self.Frame].HolyPowerBar.Y)
                    Self.ClassIcons:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar.Width, GetConfiguration()[Self.Frame].HolyPowerBar.Height)
                    Self.ClassIcons:SetTexture(0, 0, 0)

                    Self.ClassIcons.Background = Self:CreateTexture(nil, "BACKGROUND")
                    Self.ClassIcons.Background:SetPoint("TOPLEFT", Self.ClassIcons, 1, -1)
                    Self.ClassIcons.Background:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar.Width - 2, GetConfiguration()[Self.Frame].HolyPowerBar.Height - 2)

                    for i = 1, 5 do
                        Self.ClassIcons[i] = Self:CreateTexture(Self, "LOW")

                        if i <= #GetConfiguration()[Self.Frame].HolyPowerBar then
                            Self.ClassIcons[i]:SetPoint(GetConfiguration()[Self.Frame].HolyPowerBar[i].Anchor, Self.ClassIcons, GetConfiguration()[Self.Frame].HolyPowerBar[i].X, GetConfiguration()[Self.Frame].HolyPowerBar[i].Y)
                            Self.ClassIcons[i]:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar[i].Width - 2, GetConfiguration()[Self.Frame].HolyPowerBar[i].Height - 2)
                            Self.ClassIcons[i]:SetTexture(Configuration.Texture)

                            Self.ClassIcons[i].Border = Self:CreateTexture(nil, "LOW")
                            Self.ClassIcons[i].Border:SetPoint("TOPLEFT", Self.ClassIcons[i], -1, 1)
                            Self.ClassIcons[i].Border:SetSize(GetConfiguration()[Self.Frame].HolyPowerBar[i].Width, GetConfiguration()[Self.Frame].HolyPowerBar[i].Height)
                            Self.ClassIcons[i].Border:SetTexture(0, 0, 0)
                        end
                    end
                end
            end

            if GetConfiguration()[Self.Frame].PowerBar then
                Self.Power = CreateFrame("StatusBar", nil, Self)
                Self.Power.frequentUpdates = true
                Self.Power:SetOrientation(GetConfiguration()[Self.Frame].PowerBar.Orientation)
                Self.Power:SetPoint(GetConfiguration()[Self.Frame].PowerBar.Anchor, GetConfiguration()[Self.Frame].PowerBar.X, GetConfiguration()[Self.Frame].PowerBar.Y)
                Self.Power:SetStatusBarTexture(Configuration.Texture)

                if GetConfiguration()[Self.Frame].PowerBar.Border then
                    Self.Power:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width - 6, GetConfiguration()[Self.Frame].PowerBar.Height - 6)

                    Self.Power.BackgroundBottom = Self.Power:CreateTexture(nil, "LOW")
                    Self.Power.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                    Self.Power.BackgroundBottom:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width - 2, 1)
                    Self.Power.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    Self.Power.BackgroundLeft = Self.Power:CreateTexture(nil, "LOW")
                    Self.Power.BackgroundLeft:SetPoint("LEFT", -2, 0)
                    Self.Power.BackgroundLeft:SetSize(1, GetConfiguration()[Self.Frame].PowerBar.Height - 4)
                    Self.Power.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    Self.Power.BackgroundRight = Self.Power:CreateTexture(nil, "LOW")
                    Self.Power.BackgroundRight:SetPoint("RIGHT", 2, 0)
                    Self.Power.BackgroundRight:SetSize(1, GetConfiguration()[Self.Frame].PowerBar.Height - 4)
                    Self.Power.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    Self.Power.BackgroundTop = Self.Power:CreateTexture(nil, "LOW")
                    Self.Power.BackgroundTop:SetPoint("TOP", 0, 2)
                    Self.Power.BackgroundTop:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width - 2, 1)
                    Self.Power.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
                                    
                    Self.Power.Border = Self.Power:CreateTexture(nil, "BACKGROUND")
                    Self.Power.Border:SetPoint("TOPLEFT", -3, 3)
                    Self.Power.Border:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width, GetConfiguration()[Self.Frame].PowerBar.Height)
                    Self.Power.Border:SetTexture(0, 0, 0)
                else
                    Self.Power:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width - 2, GetConfiguration()[Self.Frame].PowerBar.Height - 2)                    
                
                    Self.Power.InnerBorder = Self.Power:CreateTexture(nil, "LOW")
                    Self.Power.InnerBorder:SetPoint("TOPLEFT", -1, 1)
                    Self.Power.InnerBorder:SetSize(GetConfiguration()[Self.Frame].PowerBar.Width, GetConfiguration()[Self.Frame].PowerBar.Height)
                    Self.Power.InnerBorder:SetTexture(0, 0, 0)
                end
            end

            if GetConfiguration()[Self.Frame].RuneBar and (Unit == "Player") then
                if Class == "DEATHKNIGHT" then
                    Self.Runes = CreateFrame("Frame", nil, Self)
                    Self.Runes:SetPoint(GetConfiguration()[Self.Frame].RuneBar.Anchor, GetConfiguration()[Self.Frame].RuneBar.X, GetConfiguration()[Self.Frame].RuneBar.Y)
                    Self.Runes:SetSize(GetConfiguration()[Self.Frame].RuneBar.Width - 2, GetConfiguration()[Self.Frame].RuneBar.Height - 2)

                    Self.Runes.Background = Self.Runes:CreateTexture(nil, "BACKGROUND")
                    Self.Runes.Background:SetPoint("TOPLEFT")
                    Self.Runes.Background:SetSize(GetConfiguration()[Self.Frame].RuneBar.Width - 2, GetConfiguration()[Self.Frame].RuneBar.Height - 2)

                    Self.Runes.Border = Self.Runes:CreateTexture(nil, "BACKGROUND")
                    Self.Runes.Border:SetPoint("TOPLEFT", -1, 1)
                    Self.Runes.Border:SetSize(GetConfiguration()[Self.Frame].RuneBar.Width, GetConfiguration()[Self.Frame].RuneBar.Height)
                    Self.Runes.Border:SetTexture(0, 0, 0)

                    for i = 1, #GetConfiguration()[Self.Frame].RuneBar do
                        Self.Runes[i] = CreateFrame("StatusBar", nil, Self)
                        Self.Runes[i]:SetPoint(GetConfiguration()[Self.Frame].RuneBar[i].Anchor, Self.Runes, GetConfiguration()[Self.Frame].RuneBar[i].X, GetConfiguration()[Self.Frame].RuneBar[i].Y)
                        Self.Runes[i]:SetSize(GetConfiguration()[Self.Frame].RuneBar[i].Width - 2, GetConfiguration()[Self.Frame].RuneBar[i].Height - 2)
                        Self.Runes[i]:SetStatusBarTexture(Configuration.Texture)

                        Self.Runes[i].Border = Self.Runes:CreateTexture(nil, "LOW")
                        Self.Runes[i].Border:SetPoint("TOPLEFT", Self.Runes[i], -1, 1)
                        Self.Runes[i].Border:SetSize(GetConfiguration()[Self.Frame].RuneBar[i].Width, GetConfiguration()[Self.Frame].RuneBar[i].Height)
                        Self.Runes[i].Border:SetTexture(0, 0, 0)
                    end
                end
            end

            if GetConfiguration()[Self.Frame].ShadowOrbsBar and (Unit == "Player") then
                if (Class == "PRIEST") and (Specialization == "SHADOW") then
                    Self.ClassIcons = Self:CreateTexture(Self, "BACKGROUND")
                    Self.ClassIcons:SetPoint(GetConfiguration()[Self.Frame].ShadowOrbsBar.Anchor, GetConfiguration()[Self.Frame].ShadowOrbsBar.X, GetConfiguration()[Self.Frame].ShadowOrbsBar.Y)
                    Self.ClassIcons:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar.Width, GetConfiguration()[Self.Frame].ShadowOrbsBar.Height)
                    Self.ClassIcons:SetTexture(0, 0, 0)

                    Self.ClassIcons.Background = Self:CreateTexture(nil, "LOW")
                    Self.ClassIcons.Background:SetPoint("TOPLEFT", Self.ClassIcons, 1, -1)
                    Self.ClassIcons.Background:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar.Width - 2, GetConfiguration()[Self.Frame].ShadowOrbsBar.Height - 2)

                    for i = 1, 5 do
                        Self.ClassIcons[i] = Self:CreateTexture(Self, "LOW")

                        if i <= #GetConfiguration()[Self.Frame].ShadowOrbsBar then
                            Self.ClassIcons[i]:SetPoint(GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Anchor, Self.ClassIcons, GetConfiguration()[Self.Frame].ShadowOrbsBar[i].X, GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Y)
                            Self.ClassIcons[i]:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Width - 2, GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Height - 2)
                            Self.ClassIcons[i]:SetTexture(Configuration.Texture)

                            Self.ClassIcons[i].Border = Self:CreateTexture(nil, "LOW")
                            Self.ClassIcons[i].Border:SetPoint("TOPLEFT", Self.ClassIcons[i], -1, 1)
                            Self.ClassIcons[i].Border:SetSize(GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Width, GetConfiguration()[Self.Frame].ShadowOrbsBar[i].Height)
                            Self.ClassIcons[i].Border:SetTexture(0, 0, 0)
                        end
                    end
                end
            end

            if GetConfiguration()[Self.Frame].SoulShardsBar and (Unit == "Player") then
                if (Class == "WARLOCK") and (Specialization == "AFFLICTION") then
                    Self.WarlockSpecBars = CreateFrame("Frame", nil, Self)
                    Self.WarlockSpecBars:SetPoint(GetConfiguration()[Self.Frame].SoulShardsBar.Anchor, GetConfiguration()[Self.Frame].SoulShardsBar.X, GetConfiguration()[Self.Frame].SoulShardsBar.Y)
                    Self.WarlockSpecBars:SetSize(GetConfiguration()[Self.Frame].SoulShardsBar.Width - 2, GetConfiguration()[Self.Frame].SoulShardsBar.Height - 2)

                    Self.warlockSpecBarsBackground = Self:CreateTexture(nil, "BACKGROUND")
                    Self.warlockSpecBarsBackground:SetPoint("TOPLEFT", Self.WarlockSpecBars)
                    Self.warlockSpecBarsBackground:SetSize(GetConfiguration()[Self.Frame].SoulShardsBar.Width - 2, GetConfiguration()[Self.Frame].SoulShardsBar.Height - 2)

                    Self.warlockSpecBarsBorder = Self:CreateTexture(nil, "BACKGROUND")
                    Self.warlockSpecBarsBorder:SetPoint("TOPLEFT", Self.WarlockSpecBars, -1, 1)
                    Self.warlockSpecBarsBorder:SetSize(GetConfiguration()[Self.Frame].SoulShardsBar.Width, GetConfiguration()[Self.Frame].SoulShardsBar.Height)
                    Self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

                    for i = 1, #GetConfiguration()[Self.Frame].SoulShardsBar do
                        Self.WarlockSpecBars[i] = CreateFrame("StatusBar", nil, Self)
                        Self.WarlockSpecBars[i]:SetPoint(GetConfiguration()[Self.Frame].SoulShardsBar[i].Anchor, Self.WarlockSpecBars, GetConfiguration()[Self.Frame].SoulShardsBar[i].X, GetConfiguration()[Self.Frame].SoulShardsBar[i].Y)
                        Self.WarlockSpecBars[i]:SetSize(GetConfiguration()[Self.Frame].SoulShardsBar[i].Width - 2, GetConfiguration()[Self.Frame].SoulShardsBar[i].Height - 2)
                        Self.WarlockSpecBars[i]:SetStatusBarTexture(Configuration.Texture)

                        Self.warlockSpecBarsBorder[i] = Self:CreateTexture(nil, "LOW")
                        Self.warlockSpecBarsBorder[i]:SetPoint("TOPLEFT", Self.WarlockSpecBars[i], -1, 1)
                        Self.warlockSpecBarsBorder[i]:SetSize(GetConfiguration()[Self.Frame].SoulShardsBar[i].Width, GetConfiguration()[Self.Frame].SoulShardsBar[i].Height)
                        Self.warlockSpecBarsBorder[i]:SetTexture(0, 0, 0)
                    end
                end
            end
        end
    end
)

oUF:Factory(
    function(Self)
        if GetConfiguration().Initialize then
            GetConfiguration():Initialize()
        end

        local Category = CreateFrame("Frame", nil, UIParent)
        Category.name = "SnailUI"

        Category.Label1 = Category:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        Category.Label1:SetJustifyH("LEFT")
        Category.Label1:SetPoint("TOPLEFT", 16, -16)
        Category.Label1:SetText("SnailUI")

        Category.Label2 = Category:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        Category.Label2:SetJustifyH("LEFT")
        Category.Label2:SetPoint("TOPLEFT", 16, -36)
        Category.Label2:SetText(
            "Snail\"s minimalistic UI" ..
            "\n\n" ..
            "Version " .. Version ..
            "\n" ..
            "Written by Snail" ..
            "\n\n" ..
            "http://twitter.com/1Snail" ..
            "\n" ..
            "http://wowinterface.com/downloads/info20900-SnailUI"
        )

        GeneralSubcategory = CreateFrame("Frame", nil, Category)
        GeneralSubcategory.name = "General"
        GeneralSubcategory.parent = Category.name

        GeneralSubcategory.Label1 = GeneralSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
        GeneralSubcategory.Label1:SetJustifyH("LEFT")
        GeneralSubcategory.Label1:SetPoint("TOPLEFT", 16, -16)
        GeneralSubcategory.Label1:SetText("General")

        GeneralSubcategory.Label2 = GeneralSubcategory:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        GeneralSubcategory.Label2:SetJustifyH("LEFT")
        GeneralSubcategory.Label2:SetPoint("TOPLEFT", 16, -36)
        GeneralSubcategory.Label2:SetText("General options for SnailUI")

        GeneralSubcategory.Label3 = GeneralSubcategory:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        GeneralSubcategory.Label3:SetJustifyH("LEFT")
        GeneralSubcategory.Label3:SetPoint("TOPLEFT", 16, -60)
        GeneralSubcategory.Label3:SetText("Theme")

        GeneralSubcategory.ThemeDropdownMenu = CreateFrame("Frame", "ThemeDropdownMenu", GeneralSubcategory, "UIDropDownMenuTemplate")
        GeneralSubcategory.ThemeDropdownMenu:SetPoint("TOPLEFT", 0, -73)
        
        UIDropDownMenu_Initialize(GeneralSubcategory.ThemeDropdownMenu,
            function(ThemeDropdownMenu, Level)
                local Index = 1

                for Key, Value in pairs(Configuration.Themes) do
                    local Info = UIDropDownMenu_CreateInfo()

                    Info.text = Key
                    Info.func = function(Self)
                        UIDropDownMenu_SetSelectedID(ThemeDropdownMenu, Self:GetID())
                        Theme = Themes[Self:GetID()]
                    end

                    Themes[Index] = Key
                    Themes[Key] = Index

                    Index = Index + 1
                    UIDropDownMenu_AddButton(Info, Level)
                end
            end
        )

        UIDropDownMenu_JustifyText(GeneralSubcategory.ThemeDropdownMenu, "LEFT")
        UIDropDownMenu_SetSelectedID(GeneralSubcategory.ThemeDropdownMenu, Themes[Theme])

        InterfaceOptions_AddCategory(Category)
        InterfaceOptions_AddCategory(GeneralSubcategory)

        SlashCmdList["SnailUI"] = function(Command)
            InterfaceOptionsFrame_OpenToCategory(Category)
        end

        SLASH_SnailUI1 = "/SnailUI"
        SLASH_SnailUI2 = "/SUI"

        SetCVar("consolidateBuffs", "0")
        SetCVar("useUiScale", "0")

        RaidBossEmoteFrame:Hide()
        UIErrorsFrame:Hide()
        WatchFrame:Hide()
        WorldStateAlwaysUpFrame:Hide()

        CompactRaidFrameManager:UnregisterAllEvents()
        CompactRaidFrameManager:Hide()
        CompactRaidFrameManager:SetScript("OnShow",
            function(Self)
                Self:Hide()
            end
        )
            
        CompactRaidFrameContainer:UnregisterAllEvents()
        CompactRaidFrameContainer:Hide()
        CompactRaidFrameContainer:SetScript("OnShow",
            function(Self)
                Self:Hide()
            end
        )

        Self:SetActiveStyle("SnailUI")

        if GetConfiguration().ActionBars then
            local Frames =
            {
                "AchievementMicroButton",
                "ActionBarDownButton",
                "ActionBarUpButton",
                "CharacterBag0Slot",
                "CharacterBag1Slot",
                "CharacterBag2Slot",
                "CharacterBag3Slot",
                "CharacterMicroButton",
                "CompanionsMicroButton",
                "EJMicroButton",
                "GuildMicroButton",
                "HelpMicroButton",
                "MainMenuBarBackpackButton",
                "MainMenuBarMaxLevelBar",
                "MainMenuExpBar",
                "MainMenuMicroButton",
                "MultiBarBottomLeft",
                "MultiBarBottomRight",
                "MultiBarLeft",
                "MultiBarRight",
                "LFDMicroButton",
                "PVPMicroButton",
                "QuestLogMicroButton",
                "ReputationWatchBar",
                "SpellbookMicroButton",
                "TalentMicroButton"
            }

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

            AchievementMicroButton_Update = Blank
            StanceBarFrame:SetPoint("TOPLEFT", UIParent, -500, 500)

            if not GetConfiguration().ActionBars.Pet then
                PetActionBarFrame:Hide()
                PetActionBarFrame:SetScript("OnShow",
                    function(Self)
                        Self:Hide()
                    end
                )
            end

            if not GetConfiguration().ActionBars.Player then
                MainMenuBar:Hide()
                MainMenuBar:SetScript("OnShow",
                    function(Self)
                        Self:Hide()
                    end
                )
            end

            for i = 1, #Frames do
                _G[Frames[i]]:Hide()
                _G[Frames[i]]:SetScript("OnShow",
                    function(Self)
                        Self:Hide()
                    end
                )

                _G[Frames[i]].Show = Blank
            end

            local Textures =
            {
                "MainMenuBarLeftEndCap",
                "MainMenuBarPageNumber",
                "MainMenuBarRightEndCap",
                "MainMenuBarTexture0",
                "MainMenuBarTexture1",
                "MainMenuBarTexture2",
                "MainMenuBarTexture3",
                "SlidingActionBarTexture0",
                "SlidingActionBarTexture1"
            }

            for i = 1, #Textures do
                _G[Textures[i]]:Hide()
                _G[Textures[i]]:SetAlpha(0)
            end

            if GetConfiguration().ActionBars.Pet then
                if GetConfiguration().ActionBars.Pet.Buttons < NUM_PET_ACTION_SLOTS then
                    for i = (GetConfiguration().ActionBars.Pet.Buttons + 1), NUM_PET_ACTION_SLOTS do
                        _G["PetActionButton" .. i]:Hide()
                        _G["PetActionButton" .. i]:SetScript("OnShow",
                            function(Self)
                                Self:Hide()
                            end
                        )

                        _G["PetActionButton" .. i].Show = Blank
                    end
                end

                PetActionBarFrame:ClearAllPoints()
                PetActionBarFrame:SetSize((GetConfiguration().ActionBars.Pet.Buttons * GetConfiguration().ActionBars.Pet.Width) + ((GetConfiguration().ActionBars.Pet.Buttons - 1) * 4), GetConfiguration().ActionBars.Pet.Height)
                PetActionBarFrame:SetPoint(GetConfiguration().ActionBars.Pet.Anchor, GetConfiguration().ActionBars.Pet.X, GetConfiguration().ActionBars.Pet.Y)
                PetActionBarFrame.SetPoint = Blank

                for i = 1, GetConfiguration().ActionBars.Pet.Buttons do
                    _G["PetActionButton" .. i]:ClearAllPoints()
                    _G["PetActionButton" .. i]:SetNormalTexture(nil)
                    _G["PetActionButton" .. i]:SetPoint("LEFT", ((i - 1) * GetConfiguration().ActionBars.Pet.Width) + ((i - 1) * 4) + 3, 0)
                    _G["PetActionButton" .. i]:SetSize(GetConfiguration().ActionBars.Pet.Width - 6, GetConfiguration().ActionBars.Pet.Height - 6)

                    _G["PetActionButton" .. i].BackgroundBottom = _G["PetActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["PetActionButton" .. i].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                    _G["PetActionButton" .. i].BackgroundBottom:SetSize(GetConfiguration().ActionBars.Pet.Width - 2, 1)
                    _G["PetActionButton" .. i].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["PetActionButton" .. i].BackgroundLeft = _G["PetActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["PetActionButton" .. i].BackgroundLeft:SetPoint("LEFT", -2, 0)
                    _G["PetActionButton" .. i].BackgroundLeft:SetSize(1, GetConfiguration().ActionBars.Pet.Height - 4)
                    _G["PetActionButton" .. i].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["PetActionButton" .. i].BackgroundRight = _G["PetActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["PetActionButton" .. i].BackgroundRight:SetPoint("RIGHT", 2, 0)
                    _G["PetActionButton" .. i].BackgroundRight:SetSize(1, GetConfiguration().ActionBars.Pet.Height - 4)
                    _G["PetActionButton" .. i].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["PetActionButton" .. i].BackgroundTop = _G["PetActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["PetActionButton" .. i].BackgroundTop:SetPoint("TOP", 0, 2)
                    _G["PetActionButton" .. i].BackgroundTop:SetSize(GetConfiguration().ActionBars.Pet.Width - 2, 1)
                    _G["PetActionButton" .. i].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
                                    
                    _G["PetActionButton" .. i].BorderBottom = _G["PetActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["PetActionButton" .. i].BorderBottom:SetPoint("BOTTOM", 0, -3)
                    _G["PetActionButton" .. i].BorderBottom:SetSize(GetConfiguration().ActionBars.Pet.Width, 3)
                    _G["PetActionButton" .. i].BorderBottom:SetTexture(0, 0, 0)

                    _G["PetActionButton" .. i].BorderLeft = _G["PetActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["PetActionButton" .. i].BorderLeft:SetPoint("LEFT", -3, 0)
                    _G["PetActionButton" .. i].BorderLeft:SetSize(3, GetConfiguration().ActionBars.Pet.Height - 2)
                    _G["PetActionButton" .. i].BorderLeft:SetTexture(0, 0, 0)

                    _G["PetActionButton" .. i].BorderRight = _G["PetActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["PetActionButton" .. i].BorderRight:SetPoint("RIGHT", 3, 0)
                    _G["PetActionButton" .. i].BorderRight:SetSize(3, GetConfiguration().ActionBars.Pet.Height - 2)
                    _G["PetActionButton" .. i].BorderRight:SetTexture(0, 0, 0)

                    _G["PetActionButton" .. i].BorderTop = _G["PetActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["PetActionButton" .. i].BorderTop:SetPoint("TOP", 0, 3)
                    _G["PetActionButton" .. i].BorderTop:SetSize(GetConfiguration().ActionBars.Pet.Width, 3)
                    _G["PetActionButton" .. i].BorderTop:SetTexture(0, 0, 0)

                    _G["PetActionButton" .. i].SetNormalTexture = Blank

                    _G["PetActionButton" .. i .. "AutoCastable"]:SetAlpha(0)
                    _G["PetActionButton" .. i .. "Cooldown"]:SetSize(GetConfiguration().ActionBars.Pet.Width - 6, GetConfiguration().ActionBars.Pet.Height - 6)
                    _G["PetActionButton" .. i .. "Cooldown"]:SetPoint("CENTER")
                    _G["PetActionButton" .. i .. "Icon"]:SetTexCoord(GetConfiguration().ActionBars.Pet.TextureCoordinate.Left, GetConfiguration().ActionBars.Pet.TextureCoordinate.Right, GetConfiguration().ActionBars.Pet.TextureCoordinate.Top, GetConfiguration().ActionBars.Pet.TextureCoordinate.Bottom)
                    _G["PetActionButton" .. i .. "Shine"]:SetAllPoints(_G["PetActionButton" .. i])
                end
            end

            if GetConfiguration().ActionBars.Player.Buttons < NUM_ACTIONBAR_BUTTONS then
                for i = (GetConfiguration().ActionBars.Player.Buttons + 1), NUM_ACTIONBAR_BUTTONS do
                    _G["ActionButton" .. i]:Hide()
                    _G["ActionButton" .. i]:SetScript("OnShow",
                        function(Self)
                            Self:Hide()
                        end
                    )

                    _G["ActionButton" .. i].Show = Blank
                end
            end

            if GetConfiguration().ActionBars.Player then
                MainMenuBar:ClearAllPoints()
                MainMenuBar:SetSize((GetConfiguration().ActionBars.Player.Buttons * GetConfiguration().ActionBars.Player.Width) + ((GetConfiguration().ActionBars.Player.Buttons - 1) * 4), GetConfiguration().ActionBars.Player.Height)
                MainMenuBar:SetPoint(GetConfiguration().ActionBars.Player.Anchor, GetConfiguration().ActionBars.Player.X, GetConfiguration().ActionBars.Player.Y)

                for i = 1, GetConfiguration().ActionBars.Player.Buttons do
                    _G["ActionButton" .. i]:ClearAllPoints()
                    _G["ActionButton" .. i]:SetNormalTexture(nil)
                    _G["ActionButton" .. i]:SetPoint("LEFT", ((i - 1) * GetConfiguration().ActionBars.Player.Width) + ((i - 1) * 4) + 3, 0)
                    _G["ActionButton" .. i]:SetSize(GetConfiguration().ActionBars.Player.Width - 6, GetConfiguration().ActionBars.Player.Height - 6)
                    
                    _G["ActionButton" .. i].BackgroundBottom = _G["ActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["ActionButton" .. i].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
                    _G["ActionButton" .. i].BackgroundBottom:SetSize(GetConfiguration().ActionBars.Player.Width - 2, 1)
                    _G["ActionButton" .. i].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["ActionButton" .. i].BackgroundLeft = _G["ActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["ActionButton" .. i].BackgroundLeft:SetPoint("LEFT", -2, 0)
                    _G["ActionButton" .. i].BackgroundLeft:SetSize(1, GetConfiguration().ActionBars.Player.Height - 4)
                    _G["ActionButton" .. i].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["ActionButton" .. i].BackgroundRight = _G["ActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["ActionButton" .. i].BackgroundRight:SetPoint("RIGHT", 2, 0)
                    _G["ActionButton" .. i].BackgroundRight:SetSize(1, GetConfiguration().ActionBars.Player.Height - 4)
                    _G["ActionButton" .. i].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

                    _G["ActionButton" .. i].BackgroundTop = _G["ActionButton" .. i]:CreateTexture(nil, "LOW")
                    _G["ActionButton" .. i].BackgroundTop:SetPoint("TOP", 0, 2)
                    _G["ActionButton" .. i].BackgroundTop:SetSize(GetConfiguration().ActionBars.Player.Width - 2, 1)
                    _G["ActionButton" .. i].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
                                    
                    _G["ActionButton" .. i].BorderBottom = _G["ActionButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["ActionButton" .. i].BorderBottom:SetPoint("BOTTOM", 0, -3)
                    _G["ActionButton" .. i].BorderBottom:SetSize(GetConfiguration().ActionBars.Player.Width, 3)
                    _G["ActionButton" .. i].BorderBottom:SetTexture(0, 0, 0)

                    _G["ActionButton" .. i].BorderLeft = _G["ActionButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["ActionButton" .. i].BorderLeft:SetPoint("LEFT", -3, 0)
                    _G["ActionButton" .. i].BorderLeft:SetSize(3, GetConfiguration().ActionBars.Player.Height - 2)
                    _G["ActionButton" .. i].BorderLeft:SetTexture(0, 0, 0)

                    _G["ActionButton" .. i].BorderRight = _G["ActionButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["ActionButton" .. i].BorderRight:SetPoint("RIGHT", 3, 0)
                    _G["ActionButton" .. i].BorderRight:SetSize(3, GetConfiguration().ActionBars.Player.Height - 2)
                    _G["ActionButton" .. i].BorderRight:SetTexture(0, 0, 0)

                    _G["ActionButton" .. i].BorderTop = _G["ActionButton" .. i]:CreateTexture(nil, "BACKGROUND")
                    _G["ActionButton" .. i].BorderTop:SetPoint("TOP", 0, 3)
                    _G["ActionButton" .. i].BorderTop:SetSize(GetConfiguration().ActionBars.Player.Width, 3)
                    _G["ActionButton" .. i].BorderTop:SetTexture(0, 0, 0)

                    _G["ActionButton" .. i .. "Count"]:SetAlpha(0)
                    _G["ActionButton" .. i .. "Border"]:SetAlpha(0)
                    _G["ActionButton" .. i .. "Border"].SetVertexColor = Blank

                    _G["ActionButton" .. i .. "Icon"]:SetTexCoord(GetConfiguration().ActionBars.Player.TextureCoordinate.Left, GetConfiguration().ActionBars.Player.TextureCoordinate.Right, GetConfiguration().ActionBars.Player.TextureCoordinate.Top, GetConfiguration().ActionBars.Player.TextureCoordinate.Bottom)
                    _G["ActionButton" .. i .. "FlyoutBorder"]:SetAlpha(0)
                    _G["ActionButton" .. i .. "FlyoutBorderShadow"]:SetAlpha(0)
                    _G["ActionButton" .. i .. "HotKey"]:SetAlpha(0)
                    _G["ActionButton" .. i .. "Name"]:SetAlpha(0)
                end
            end
        end

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

            local OpenBags = function()
                BagItemSearchBox:Hide()

                ContainerFrame1BackgroundBottom:Hide()
                ContainerFrame1BackgroundMiddle1:Hide()
                ContainerFrame1BackgroundMiddle2:Hide()
                ContainerFrame1BackgroundTop:Hide()
                ContainerFrame1CloseButton:Hide()
                ContainerFrame1Name:Hide()
                ContainerFrame1Portrait:Hide()
                ContainerFrame1PortraitButton:Hide()

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

            BuffFrame:Hide()            
            local OriginalBuffFrame_Update = BuffFrame_Update    

            BuffFrame_Update = function()
                OriginalBuffFrame_Update()

                BuffFrame:ClearAllPoints()
                BuffFrame:SetPoint(GetConfiguration().Buffs.Anchor, GetConfiguration().Buffs.X, GetConfiguration().Buffs.Y)

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

        if GetConfiguration().Chat then
        	for i = 1, NUM_CHAT_WINDOWS do
                _G["ChatFrame" .. i .. "ButtonFrame"]:Hide()
                _G["ChatFrame" .. i .. "ButtonFrame"]:SetScript("OnShow",
                    function(Self)
                        Self:Hide()
                    end
                )

                _G["ChatFrame" .. i .. "ButtonFrame"].Show = Blank
                _G["ChatFrame" .. i .. "EditBox"]:Hide()

                _G["ChatFrame" .. i .. "ResizeButton"]:Hide()
                _G["ChatFrame" .. i .. "ResizeButton"]:SetScript("OnShow",
                    function(Self)
                        Self:Hide()
                    end
                )

                _G["ChatFrame" .. i .. "ResizeButton"].Show = Blank
            end

            _G["ChatFrameMenuButton"]:Hide()
            _G["ChatFrameMenuButton"]:SetScript("OnShow",
                function(Self)
                    Self:Hide()
                end
            )

            _G["ChatFrameMenuButton"].Show = Blank
            _G["FriendsMicroButton"]:Hide()
            _G["FriendsMicroButton"]:SetScript("OnShow",
                function(Self)
                    Self:Hide()
                end
            )

            _G["FriendsMicroButton"].Show = Blank
            _G["GeneralDockManager"]:Hide()
            _G["GeneralDockManager"]:SetScript("OnShow",
                function(Self)
                    Self:Hide()
                end
            )

            _G["GeneralDockManager"].Show = Blank
            local OriginalChatEdit_OnEscapePressed = ChatEdit_OnEscapePressed

            ChatEdit_OnEscapePressed = function(Self)
            	OriginalChatEdit_OnEscapePressed(Self)
            	Self:Hide()
        	end

        	ChatFrame1:ClearAllPoints()
        	ChatFrame1:SetClampedToScreen(false)
        	ChatFrame1:SetFont("Fonts\\FrizQT__.ttf", 10)
        	ChatFrame1:SetPoint(GetConfiguration().Chat.Anchor, GetConfiguration().Chat.X, GetConfiguration().Chat.Y)
        	ChatFrame1:SetSize(GetConfiguration().Chat.Width - 10, GetConfiguration().Chat.Height - 10)
        	ChatFrame1:SetUserPlaced(true)

        	ChatFrame1.BackgroundBottom = ChatFrame1:CreateTexture(nil, "LOW")
            ChatFrame1.BackgroundBottom:SetPoint("BOTTOM", 0, -4)
            ChatFrame1.BackgroundBottom:SetSize(GetConfiguration().Chat.Width - 2, 1)
            ChatFrame1.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            ChatFrame1.BackgroundLeft = ChatFrame1:CreateTexture(nil, "LOW")
            ChatFrame1.BackgroundLeft:SetPoint("LEFT", -4, 0)
            ChatFrame1.BackgroundLeft:SetSize(1, GetConfiguration().Chat.Height - 4)
            ChatFrame1.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            ChatFrame1.BackgroundRight = ChatFrame1:CreateTexture(nil, "LOW")
            ChatFrame1.BackgroundRight:SetPoint("RIGHT", 4, 0)
            ChatFrame1.BackgroundRight:SetSize(1, GetConfiguration().Chat.Height - 4)
            ChatFrame1.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            ChatFrame1.BackgroundTop = ChatFrame1:CreateTexture(nil, "LOW")
            ChatFrame1.BackgroundTop:SetPoint("TOP", 0, 4)
            ChatFrame1.BackgroundTop:SetSize(GetConfiguration().Chat.Width - 2, 1)
            ChatFrame1.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
                                
            ChatFrame1.BorderBottom = ChatFrame1:CreateTexture(nil, "BACKGROUND")
            ChatFrame1.BorderBottom:SetPoint("BOTTOM", 0, -5)
            ChatFrame1.BorderBottom:SetSize(GetConfiguration().Chat.Width, 3)
            ChatFrame1.BorderBottom:SetTexture(0, 0, 0)

            ChatFrame1.BorderLeft = ChatFrame1:CreateTexture(nil, "BACKGROUND")
            ChatFrame1.BorderLeft:SetPoint("LEFT", -5, 0)
            ChatFrame1.BorderLeft:SetSize(3, GetConfiguration().Chat.Height - 2)
            ChatFrame1.BorderLeft:SetTexture(0, 0, 0)

            ChatFrame1.BorderRight = ChatFrame1:CreateTexture(nil, "BACKGROUND")
            ChatFrame1.BorderRight:SetPoint("RIGHT", 5, 0)
            ChatFrame1.BorderRight:SetSize(3, GetConfiguration().Chat.Height - 2)
            ChatFrame1.BorderRight:SetTexture(0, 0, 0)

            ChatFrame1.BorderTop = ChatFrame1:CreateTexture(nil, "BACKGROUND")
            ChatFrame1.BorderTop:SetPoint("TOP", 0, 5)
            ChatFrame1.BorderTop:SetSize(GetConfiguration().Chat.Width, 3)
            ChatFrame1.BorderTop:SetTexture(0, 0, 0)

            ChatFrame1.InnerBorder = ChatFrame1:CreateTexture(nil, "BACKGROUND")
            ChatFrame1.InnerBorder:SetPoint("TOPLEFT", -2, 2)
            ChatFrame1.InnerBorder:SetSize(GetConfiguration().Chat.Width - 6, GetConfiguration().Chat.Height - 6)
            ChatFrame1.InnerBorder:SetTexture(0, 0, 0, 0.5)

            ChatFrame1EditBox:SetPoint("TOPLEFT", ChatFrame1, "TOPLEFT", -5, 6)
        end

        if GetConfiguration().ExtraButton then
            local ExtraButton = CreateFrame("Button", nil, UIParent)

            ExtraButton:RegisterForClicks("AnyUp")
            ExtraButton:SetPoint(GetConfiguration().ExtraButton.Anchor, GetConfiguration().ExtraButton.X, GetConfiguration().ExtraButton.Y)
            ExtraButton:SetSize(GetConfiguration().ExtraButton.Width - 4, GetConfiguration().ExtraButton.Height - 4)
            ExtraButton:SetScript("OnClick",
                function(Self)
                    if Self.Shown then
                        BuffFrame:Hide()
                        WatchFrame:Hide()
                        WorldStateAlwaysUpFrame:Hide()

                        if not GetConfiguration().Raid.Shown then
                            Raid:Hide()
                        end

                        Self.Bar.Text:SetText("Show Misc Frames")
                        Self.Shown = nil
                    else
                        BuffFrame:Show()
                        WatchFrame:Show()
                        WorldStateAlwaysUpFrame:Show()

                        if not GetConfiguration().Raid.shown then
                            Raid:Show()
                        end

                        Self.Bar.Text:SetText("Hide Misc Frames")
                        Self.Shown = true
                    end
                end
            )

            if GetConfiguration().ExtraButton.HoverToShow then
                ExtraButton:SetAlpha(0)
                ExtraButton:SetScript("OnEnter",
                    function(Self)
                        if not ExtraButton.Shown then
                            Self:SetAlpha(1)
                        end
                    end
                )

                ExtraButton:SetScript("OnLeave",
                    function(Self)
                        if not ExtraButton.Shown then
                            Self:SetAlpha(0)
                        end
                    end
                )
            end

            ExtraButton.Background = ExtraButton:CreateTexture(nil, "LOW")
            ExtraButton.Background:SetPoint("TOPLEFT", -1, 1)
            ExtraButton.Background:SetSize(GetConfiguration().ExtraButton.Width - 2, GetConfiguration().ExtraButton.Height - 2)
            ExtraButton.Background:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            ExtraButton.Border = ExtraButton:CreateTexture(nil, "BACKGROUND")
            ExtraButton.Border:SetPoint("TOPLEFT", -2, 2)
            ExtraButton.Border:SetSize(GetConfiguration().ExtraButton.Width, GetConfiguration().ExtraButton.Height)
            ExtraButton.Border:SetTexture(0, 0, 0)

            ExtraButton.Bar = CreateFrame("StatusBar", nil, ExtraButton)
            ExtraButton.Bar:SetPoint("CENTER")
            ExtraButton.Bar:SetSize(GetConfiguration().ExtraButton.Width - 6, GetConfiguration().ExtraButton.Height - 6)
            ExtraButton.Bar:SetStatusBarTexture(Configuration.Texture)
            ExtraButton.Bar:SetStatusBarColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            ExtraButton.Bar.Border = ExtraButton.Bar:CreateTexture(nil, "BACKGROUND")
            ExtraButton.Bar.Border:SetPoint("TOPLEFT", -1, 1)
            ExtraButton.Bar.Border:SetSize(GetConfiguration().ExtraButton.Width - 4, GetConfiguration().ExtraButton.Height - 4)
            ExtraButton.Bar.Border:SetTexture(0, 0, 0)

            ExtraButton.Bar.Text = ExtraButton.Bar:CreateFontString(nil, "OVERLAY")
            ExtraButton.Bar.Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
            ExtraButton.Bar.Text:SetPoint("CENTER", 1, 0)
            ExtraButton.Bar.Text:SetText("Show Misc Frames")
            ExtraButton.Bar.Text:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

        end

        if GetConfiguration().Focus then
            local Focus = Self:Spawn("Focus")
            Focus:SetPoint(GetConfiguration().Focus.Anchor, GetConfiguration().Focus.X, GetConfiguration().Focus.Y)
        end

        if GetConfiguration().FocusTarget then
            local FocusTarget = Self:Spawn("FocusTarget")
            FocusTarget:SetPoint(GetConfiguration().FocusTarget.Anchor, GetConfiguration().FocusTarget.X, GetConfiguration().FocusTarget.Y)
        end

        if GetConfiguration().Minimap then
            MinimapCluster:Hide()
            local Minimap = CreateFrame("Minimap", nil, UIParent)

            Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8.tga") -- here
            Minimap:SetPoint(GetConfiguration().Minimap.Anchor, GetConfiguration().Minimap.X, GetConfiguration().Minimap.Y)
            Minimap:SetSize(GetConfiguration().Minimap.Width - 6, GetConfiguration().Minimap.Height - 6)
            Minimap:SetScript("OnMouseWheel",
                function(Self, Zoom)
                    if Zoom > 0 then
                        Minimap_ZoomIn()
                    else
                        Minimap_ZoomOut()
                    end
                end
            )

            Minimap.BackgroundBottom = Minimap:CreateTexture(nil, "LOW")
            Minimap.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
            Minimap.BackgroundBottom:SetSize(GetConfiguration().Minimap.Width - 2, 1)
            Minimap.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            Minimap.BackgroundLeft = Minimap:CreateTexture(nil, "LOW")
            Minimap.BackgroundLeft:SetPoint("LEFT", -2, 0)
            Minimap.BackgroundLeft:SetSize(1, GetConfiguration().Minimap.Height - 4)
            Minimap.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            Minimap.BackgroundRight = Minimap:CreateTexture(nil, "LOW")
            Minimap.BackgroundRight:SetPoint("RIGHT", 2, 0)
            Minimap.BackgroundRight:SetSize(1, GetConfiguration().Minimap.Height - 4)
            Minimap.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

            Minimap.BackgroundTop = Minimap:CreateTexture(nil, "LOW")
            Minimap.BackgroundTop:SetPoint("TOP", 0, 2)
            Minimap.BackgroundTop:SetSize(GetConfiguration().Minimap.Width - 2, 1)
            Minimap.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
                                
            Minimap.BorderBottom = Minimap:CreateTexture(nil, "BACKGROUND")
            Minimap.BorderBottom:SetPoint("BOTTOM", 0, -3)
            Minimap.BorderBottom:SetSize(GetConfiguration().Minimap.Width, 3)
            Minimap.BorderBottom:SetTexture(0, 0, 0)

            Minimap.BorderLeft = Minimap:CreateTexture(nil, "BACKGROUND")
            Minimap.BorderLeft:SetPoint("LEFT", -3, 0)
            Minimap.BorderLeft:SetSize(3, GetConfiguration().Minimap.Height - 2)
            Minimap.BorderLeft:SetTexture(0, 0, 0)

            Minimap.BorderRight = Minimap:CreateTexture(nil, "BACKGROUND")
            Minimap.BorderRight:SetPoint("RIGHT", 3, 0)
            Minimap.BorderRight:SetSize(3, GetConfiguration().Minimap.Height - 2)
            Minimap.BorderRight:SetTexture(0, 0, 0)

            Minimap.BorderTop = Minimap:CreateTexture(nil, "BACKGROUND")
            Minimap.BorderTop:SetPoint("TOP", 0, 3)
            Minimap.BorderTop:SetSize(GetConfiguration().Minimap.Width, 3)
            Minimap.BorderTop:SetTexture(0, 0, 0)

            if GetConfiguration().Minimap.Calender then
                GameTimeFrame:ClearAllPoints()
                GameTimeFrame:SetParent(Minimap)
                GameTimeFrame:SetPoint(GetConfiguration().Minimap.Calender.Anchor, GetConfiguration().Minimap.Calender.X, GetConfiguration().Minimap.Calender.Y)
                GameTimeFrame:SetSize(32, 32)

                GameTimeFrame.Time = GameTimeFrame:CreateFontString(nil, "OVERLAY")
                GameTimeFrame.Time:SetFont("Fonts\\FrizQT__.ttf", Configuration.Font.Size)
                GameTimeFrame.Time:SetPoint("CENTER", 0, -2)
                GameTimeFrame.Time:SetTextColor(0, 0, 0)

                GameTimeFrame_SetDate = function()
                    local _, _, Day = CalendarGetDate()
                    GameTimeFrame.Time:SetText(Day)
                end

                GameTimeFrame:SetText(nil)
            end

            if GetConfiguration().Minimap.Clock then
                TimeManagerClockButton:ClearAllPoints()
                TimeManagerClockButton:GetRegions():Hide()
                TimeManagerClockButton:SetParent(Minimap)
                TimeManagerClockButton:SetPoint(GetConfiguration().Minimap.Clock.Anchor, GetConfiguration().Minimap.Clock.X, GetConfiguration().Minimap.Clock.Y)
                TimeManagerClockButton:SetSize(TimeManagerClockTicker:GetWidth(), TimeManagerClockTicker:GetHeight())

                TimeManagerClockTicker:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
                TimeManagerClockTicker:SetPoint("CENTER", TimeManagerClockButton)
                TimeManagerClockTicker:SetShadowOffset(0, 0)
            end

            if GetConfiguration().Minimap.Mail then
                MiniMapMailBorder:Hide()
                MiniMapMailFrame:ClearAllPoints()
                MiniMapMailFrame:SetParent(Minimap)
                MiniMapMailFrame:SetPoint(GetConfiguration().Minimap.Mail.Anchor, GetConfiguration().Minimap.Mail.X, GetConfiguration().Minimap.Mail.Y)
                MiniMapMailIcon:SetTexture("Interface\\Minimap\\Tracking\\Mailbox.tga") -- here
            end

            if GetConfiguration().Minimap.Tracking then
                MiniMapTracking:ClearAllPoints()
                MiniMapTracking:SetParent(Minimap)
                MiniMapTracking:SetPoint(GetConfiguration().Minimap.Tracking.Anchor, GetConfiguration().Minimap.Tracking.X, GetConfiguration().Minimap.Tracking.Y)
                MiniMapTrackingBackground:Hide()
                MiniMapTrackingButtonBorder:Hide()
                MiniMapTrackingIconOverlay:SetTexture(nil)
            end

            if GetConfiguration().Minimap.QueueStatus then
                QueueStatusMinimapButton:ClearAllPoints()
                QueueStatusMinimapButton:SetParent(Minimap)
                QueueStatusMinimapButton:SetPoint(GetConfiguration().Minimap.QueueStatus.Anchor, GetConfiguration().Minimap.QueueStatus.X, GetConfiguration().Minimap.QueueStatus.Y)
                QueueStatusMinimapButtonBorder:Hide()
            end
        end

        if GetConfiguration().Pet then
            local Pet = Self:Spawn("Pet")
            Pet:SetPoint(GetConfiguration().Pet.Anchor, GetConfiguration().Pet.X, GetConfiguration().Pet.Y)
        end

        if GetConfiguration().Player then
            local Player = Self:Spawn("Player")
            Player:SetPoint(GetConfiguration().Player.Anchor, GetConfiguration().Player.X, GetConfiguration().Player.Y)
        end

        if GetConfiguration().Raid then
            Raid = Self:SpawnHeader(nil, nil, nil,
                "columnAnchorPoint", GetConfiguration().Raid.ColumnAnchor,
                "columnSpacing", GetConfiguration().Raid.ColumnSpacing,
                "groupBy", GetConfiguration().Raid.GroupBy,
                "groupingOrder", GetConfiguration().Raid.GroupOrder,
                "maxColumns", GetConfiguration().Raid.Columns,
                "showParty", GetConfiguration().Raid.ShowParty,
                "showPlayer", GetConfiguration().Raid.ShowPlayer,
                "showRaid", GetConfiguration().Raid.ShowRaid,
                "showSolo", GetConfiguration().Raid.ShowSolo,
                "UnitsPerColumn", GetConfiguration().Raid.Rows,
                "xOffset", GetConfiguration().Raid.ColumnX,
                "yOffset", GetConfiguration().Raid.ColumnY
            )

            Raid:SetPoint(GetConfiguration().Raid.Anchor, GetConfiguration().Raid.X, GetConfiguration().Raid.Y)

            if GetConfiguration().Raid.Shown then
                Raid:Show()
            else
                Raid:Hide()
            end
        end

        if GetConfiguration().Target then
            local Target = Self:Spawn("Target")            
            Target:SetPoint(GetConfiguration().Target.Anchor, GetConfiguration().Target.X, GetConfiguration().Target.Y)
        end

        if GetConfiguration().TargetTarget then
            local TargetTarget = Self:Spawn("TargetTarget")
            TargetTarget:SetPoint(GetConfiguration().TargetTarget.Anchor, GetConfiguration().TargetTarget.X, GetConfiguration().TargetTarget.Y)
        end
    end
)
