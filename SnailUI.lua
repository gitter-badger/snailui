-- Snail.lua
-- Written by Snail

class = select(2, UnitClass('Player'))
version = '0.2.1'

if not theme then
    theme = Configuration.theme
end

function getConfiguration()
    if Configuration.Themes[theme][class] then
        if spec then
            if Configuration.Themes[theme][class][spec] then
                return Configuration.Themes[theme][class][spec]
            else
                return Configuration.Themes[theme][class]
            end
        else
            return Configuration.Themes[theme][class]
        end
    end

    return Configuration.Themes[theme]
end

function trim(string1, string2)
    if string2 then
        if string2:len() > 0 then
            if (string1:len() + string2:len()) > 11 then
                return string1:sub(1, 11 - string2:len()) .. '...' .. string2
            end

            return string1 .. string2
        end
    end

    if string1:len() > 11 then
        return string1:sub(1, 8) .. '...'
    end

    return string1
end

function trim2(string)
    if string:len() > 3 then
        return string:sub(1, 3)
    end

    return string
end

oUF.Tags.Events['SnailUI:EclipseDirection'] = 'ECLIPSE_DIRECTION_CHANGE'
oUF.Tags.Events['SnailUI:Health'] = 'UNIT_HEALTH UNIT_HEAL_PREDICTION'
oUF.Tags.Events['SnailUI:SmallHealth'] = 'UNIT_HEALTH UNIT_HEAL_PREDICTION'

oUF.Tags.Methods['SnailUI:EclipseDirection'] = function(unit)
    direction = GetEclipseDirection()

    if direction == 'moon' then
        return '<-'
    elseif direction == 'sun' then
        return '->'
    end

    return nil
end

oUF.Tags.Methods['SnailUI:Health'] = function(unit)
    health = trim(GetUnitName(unit, false))

    if math.floor(((UnitHealth(unit) / UnitHealthMax(unit)) * 100) + 0.5) < 100 then
        if UnitGetIncomingHeals(unit) then
            health = math.floor((((UnitHealth(unit) + UnitGetIncomingHeals(unit)) / UnitHealthMax(unit)) * 100) + 0.5) .. '%'
        else
            health = math.floor(((UnitHealth(unit) / UnitHealthMax(unit)) * 100) + 0.5) .. '%'
        end
    end

    if UnitIsDead(unit) then
        health = trim(GetUnitName(unit, false), ' | Dead')
    end

    if UnitIsGhost(unit) then
        health = trim(GetUnitName(unit, false), ' | Ghost')
    end

    if UnitIsAFK(unit) then
        health = trim(GetUnitName(unit, false), ' | AFK')
    end

    if not UnitIsConnected(unit) then
        health = trim(GetUnitName(unit, false), ' | D/C')
    end

    return health
end

oUF.Tags.Methods['SnailUI:SmallHealth'] = function(unit)
    health = trim2(GetUnitName(unit, false))

    if math.floor(((UnitHealth(unit) / UnitHealthMax(unit)) * 100) + 0.5) < 100 then
        if UnitGetIncomingHeals(unit) then
            health = math.floor((((UnitHealth(unit) + UnitGetIncomingHeals(unit)) / UnitHealthMax(unit)) * 100) + 0.5) .. '%'
        else
            health = math.floor(((UnitHealth(unit) / UnitHealthMax(unit)) * 100) + 0.5) .. '%'
        end
    end

    if UnitIsDead(unit) then
        health = 'DEA'
    end

    if UnitIsGhost(unit) then
        health = 'GHO'
    end

    if UnitIsAFK(unit) then
        health = 'AFK'
    end

    if not UnitIsConnected(unit) then
        health = 'D/C'
    end

    return health
end

oUF:RegisterStyle('SnailUI', 
    function(self, unit)
        unit = unit:gsub('(.)', string.upper, 1)
        
        if getConfiguration()[unit] then            
            self.frame = unit
            self.menu = function(self)
                if self.unit:match('^party') then
                    ToggleDropDownMenu(1, nil, _G['PartyMemberFrame' .. self.id .. 'DropDown'], 'cursor', 0, 0)
                elseif self.unit:match('^raid') then
                    self.name = self.unit
                    RaidGroupButton_ShowMenu(self)
                else
                    ToggleDropDownMenu(1, nil, _G[self.unit:gsub('(.)', string.upper, 1) .. 'FrameDropDown'], 'cursor', 0, 0)
                end
            end

            self.background = self:CreateTexture(nil, 'LOW')
            self.background:SetPoint('TOPLEFT', 1, -1)
            self.background:SetSize(getConfiguration()[self.frame].width - 2, getConfiguration()[self.frame].height - 2)

            self.border = self:CreateTexture(nil, 'BACKGROUND')
            self.border:SetPoint('TOPLEFT')
            self.border:SetSize(getConfiguration()[self.frame].width, getConfiguration()[self.frame].height)
            self.border:SetTexture(0, 0, 0)

            self.PostUpdate = function(self)
                if UnitClass(self.unit) then
                    self.classColor = RAID_CLASS_COLORS[select(2, UnitClass(self.unit))]
                else
                    self.classColor =
                    {
                        b = 1,
                        g = 1,
                        r = 1
                    }
                end

                self.background:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)

                if UnitThreatSituation(self.unit) and (self.frame == 'Raid') and getConfiguration()[self.frame].colorByThreatLevel then
                    if UnitThreatSituation(self.unit) > 0 then
                        self.threatColor =
                        {
                            b = 0,
                            g = 0,
                            r = 0
                        }

                        self.threatColor.r, self.threatColor.g, self.threatColor.b = GetThreatStatusColor(UnitThreatSituation(self.unit))
                        self.background:SetTexture(self.threatColor.r, self.threatColor.g, self.threatColor.b)
                    end
                end

                if self.Castbar then
                    self.Castbar:SetStatusBarColor(self.classColor.r, self.classColor.g, self.classColor.b)
                    self.Castbar.backgroundBottom:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
                    self.Castbar.backgroundLeft:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
                    self.Castbar.backgroundRight:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
                    self.Castbar.backgroundTop:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
                end

                if self.ClassIcons then
                    self.ClassIcons.background:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)

                    for i = 1, 5 do
                        self.ClassIcons[i]:SetVertexColor(self.classColor.r, self.classColor.g, self.classColor.b)
                    end
                end

                if self.CPoints then
                    self.CPoints.background:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)

                    for i = 1, #self.CPoints do
                        self.CPoints[i]:SetStatusBarColor(self.classColor.r, self.classColor.g, self.classColor.b)
                    end
                end

                if self.EclipseBar then
                    self.EclipseBar.background:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
                end

                if self.Health then
                    self.Health:SetStatusBarColor(self.classColor.r, self.classColor.g, self.classColor.b)

                    if self.HealPrediction.myBar then
                        self.HealPrediction.myBar:SetStatusBarColor(self.classColor.r, self.classColor.g, self.classColor.b)
                    end

                    if self.HealPrediction.otherBar then
                        self.HealPrediction.otherBar:SetStatusBarColor(self.classColor.r, self.classColor.g, self.classColor.b)
                    end

                    if self.Health.text then
                        self.Health.text:SetTextColor(self.classColor.r, self.classColor.g, self.classColor.b)
                    end
                end
                
                if self.Power then
                    self.Power:SetStatusBarColor(self.classColor.r, self.classColor.g, self.classColor.b)

                    if self.Power.backgroundBottom then
                        self.Power.backgroundBottom:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
                        self.Power.backgroundLeft:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
                        self.Power.backgroundRight:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
                        self.Power.backgroundTop:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
                    end

                    if self.Power.text then
                        self.Power.text:SetColor(self.classColor.r, self.classColor.g, self.classColor.b)
                    end
                end

                if self.Runes then
                    self.Runes.background:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
                end

                if self.WarlockSpecBars then
                    self.warlockSpecBarsBackground:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)

                    for i = 1, #self.WarlockSpecBars do
                        self.WarlockSpecBars[i]:SetStatusBarColor(self.classColor.r, self.classColor.g, self.classColor.b)
                    end
                end
            end

            self.SpellRange =
            {
                Update = function(self, inRange)
                    if Configuration.inactiveAlpha then
                        if UnitIsUnit(self.unit, 'player') then
                            inRange = true
                        end

                        if inRange then
                            self:SetAlpha(1)
                            self.inRange = inRange

                            if getConfiguration()[self.frame].healthThreshold then
                                if math.floor(((UnitHealth(self.unit) / UnitHealthMax(self.unit)) * 100) + 0.5) >= getConfiguration()[self.frame].healthThreshold then
                                    self:SetAlpha(Configuration.inactiveAlpha)
                                end
                            end
                        else
                            self:SetAlpha(Configuration.inactiveAlpha)
                            self.inRange = nil
                        end
                    end
                end
            }

            self:RegisterEvent('UNIT_THREAT_SITUATION_UPDATE', self.PostUpdate)
            self:RegisterForClicks('AnyUp')
            self:SetSize(getConfiguration()[self.frame].width, getConfiguration()[self.frame].height)
            self:SetScript('OnEnter',
                function(self)
                    UnitFrame_UpdateTooltip(self)
                end
            )

            if getConfiguration()[self.frame].healthThreshold then
                self:RegisterEvent('UNIT_HEALTH',
                    function(self)
                        self:SetAlpha(Configuration.inactiveAlpha)

                        if math.floor(((UnitHealth(self.unit) / UnitHealthMax(self.unit)) * 100) + 0.5) < getConfiguration()[self.frame].healthThreshold then
                            if self.inRange then
                                self:SetAlpha(1)
                            end
                        end
                    end
                )
            end

            if getConfiguration()[self.frame].BurningEmbersBar and (unit == 'Player') then
                if (class == 'WARLOCK') and (spec == 'DESTRUCTION') then
                    self.WarlockSpecBars = CreateFrame('Frame', nil, self)
                    self.WarlockSpecBars:SetPoint(getConfiguration()[self.frame].BurningEmbersBar.anchor, getConfiguration()[self.frame].BurningEmbersBar.x, getConfiguration()[self.frame].BurningEmbersBar.y)
                    self.WarlockSpecBars:SetSize(getConfiguration()[self.frame].BurningEmbersBar.width - 2, getConfiguration()[self.frame].BurningEmbersBar.height - 2)

                    self.warlockSpecBarsBackground = self:CreateTexture(nil, 'BACKGROUND')
                    self.warlockSpecBarsBackground:SetPoint('TOPLEFT', self.WarlockSpecBars)
                    self.warlockSpecBarsBackground:SetSize(getConfiguration()[self.frame].BurningEmbersBar.width - 2, getConfiguration()[self.frame].BurningEmbersBar.height - 2)

                    self.warlockSpecBarsBorder = self:CreateTexture(nil, 'BACKGROUND')
                    self.warlockSpecBarsBorder:SetPoint('TOPLEFT', self.WarlockSpecBars, -1, 1)
                    self.warlockSpecBarsBorder:SetSize(getConfiguration()[self.frame].BurningEmbersBar.width, getConfiguration()[self.frame].BurningEmbersBar.height)
                    self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

                    for i = 1, #getConfiguration()[self.frame].BurningEmbersBar do
                        self.WarlockSpecBars[i] = CreateFrame('StatusBar', nil, self)
                        self.WarlockSpecBars[i]:SetPoint(getConfiguration()[self.frame].BurningEmbersBar[i].anchor, self.WarlockSpecBars, getConfiguration()[self.frame].BurningEmbersBar[i].x, getConfiguration()[self.frame].BurningEmbersBar[i].y)
                        self.WarlockSpecBars[i]:SetSize(getConfiguration()[self.frame].BurningEmbersBar[i].width - 2, getConfiguration()[self.frame].BurningEmbersBar[i].height - 2)
                        self.WarlockSpecBars[i]:SetStatusBarTexture(Configuration.texture)

                        self.warlockSpecBarsBorder[i] = self:CreateTexture(nil, 'LOW')
                        self.warlockSpecBarsBorder[i]:SetPoint('TOPLEFT', self.WarlockSpecBars[i], -1, 1)
                        self.warlockSpecBarsBorder[i]:SetSize(getConfiguration()[self.frame].BurningEmbersBar[i].width, getConfiguration()[self.frame].BurningEmbersBar[i].height)
                        self.warlockSpecBarsBorder[i]:SetTexture(0, 0, 0)
                    end
                end
            end

            if getConfiguration()[self.frame].CastingBar then
                self.Castbar = CreateFrame('StatusBar', nil, self)
                self.Castbar:SetOrientation(getConfiguration()[self.frame].CastingBar.orientation)
                self.Castbar:SetPoint(getConfiguration()[self.frame].CastingBar.anchor, getConfiguration()[self.frame].CastingBar.x, getConfiguration()[self.frame].CastingBar.y)
                self.Castbar:SetSize(getConfiguration()[self.frame].CastingBar.width - 6, getConfiguration()[self.frame].CastingBar.height - 6)
                self.Castbar:SetStatusBarTexture(Configuration.texture)

                self.Castbar.backgroundBottom = self.Castbar:CreateTexture(nil, 'LOW')
                self.Castbar.backgroundBottom:SetPoint('BOTTOM', 0, -2)
                self.Castbar.backgroundBottom:SetSize(getConfiguration()[self.frame].CastingBar.width - 2, 1)
                self.Castbar.backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                self.Castbar.backgroundLeft = self.Castbar:CreateTexture(nil, 'LOW')
                self.Castbar.backgroundLeft:SetPoint('LEFT', -2, 0)
                self.Castbar.backgroundLeft:SetSize(1, getConfiguration()[self.frame].CastingBar.height - 4)
                self.Castbar.backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                self.Castbar.backgroundRight = self.Castbar:CreateTexture(nil, 'LOW')
                self.Castbar.backgroundRight:SetPoint('RIGHT', 2, 0)
                self.Castbar.backgroundRight:SetSize(1, getConfiguration()[self.frame].CastingBar.height - 4)
                self.Castbar.backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                self.Castbar.backgroundTop = self.Castbar:CreateTexture(nil, 'LOW')
                self.Castbar.backgroundTop:SetPoint('TOP', 0, 2)
                self.Castbar.backgroundTop:SetSize(getConfiguration()[self.frame].CastingBar.width - 2, 1)
                self.Castbar.backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                
                self.Castbar.border = self.Castbar:CreateTexture(nil, 'BACKGROUND')
                self.Castbar.border:SetPoint('TOPLEFT', -3, 3)
                self.Castbar.border:SetSize(getConfiguration()[self.frame].CastingBar.width, getConfiguration()[self.frame].CastingBar.height)
                self.Castbar.border:SetTexture(0, 0, 0)
            end

            if getConfiguration()[self.frame].ComboPointsBar and (unit == 'Player') then
                if (class == 'ROGUE') or ((class == 'DRUID') and (spec == 'FERAL')) then
                    self.CPoints = CreateFrame('Frame', nil, self)
                    self.CPoints:SetPoint(getConfiguration()[self.frame].ComboPointsBar.anchor, getConfiguration()[self.frame].ComboPointsBar.x, getConfiguration()[self.frame].ComboPointsBar.y)
                    self.CPoints:SetSize(getConfiguration()[self.frame].ComboPointsBar.width - 2, getConfiguration()[self.frame].ComboPointsBar.height - 2)

                    self.CPoints.background = self.CPoints:CreateTexture(nil, 'BACKGROUND')
                    self.CPoints.background:SetPoint('TOPLEFT')
                    self.CPoints.background:SetSize(getConfiguration()[self.frame].ComboPointsBar.width - 2, getConfiguration()[self.frame].ComboPointsBar.height - 2)

                    self.CPoints.border = self.CPoints:CreateTexture(nil, 'BACKGROUND')
                    self.CPoints.border:SetPoint('TOPLEFT', -1, 1)
                    self.CPoints.border:SetSize(getConfiguration()[self.frame].ComboPointsBar.width, getConfiguration()[self.frame].ComboPointsBar.height)
                    self.CPoints.border:SetTexture(0, 0, 0)

                    for i = 1, #getConfiguration()[self.frame].ComboPointsBar do
                        self.CPoints[i] = CreateFrame('StatusBar', nil, self)
                        self.CPoints[i]:SetPoint(getConfiguration()[self.frame].ComboPointsBar[i].anchor, self.CPoints, getConfiguration()[self.frame].ComboPointsBar[i].x, getConfiguration()[self.frame].ComboPointsBar[i].y)
                        self.CPoints[i]:SetSize(getConfiguration()[self.frame].ComboPointsBar[i].width - 2, getConfiguration()[self.frame].ComboPointsBar[i].height - 2)
                        self.CPoints[i]:SetStatusBarTexture(Configuration.texture)

                        self.CPoints[i].border = self.CPoints:CreateTexture(nil, 'LOW')
                        self.CPoints[i].border:SetPoint('TOPLEFT', self.CPoints[i], -1, 1)
                        self.CPoints[i].border:SetSize(getConfiguration()[self.frame].ComboPointsBar[i].width, getConfiguration()[self.frame].ComboPointsBar[i].height)
                        self.CPoints[i].border:SetTexture(0, 0, 0)
                    end
                end
            end

            if getConfiguration()[self.frame].EclipseBar and (unit == 'Player') then
                if (class == 'DRUID') and (spec == 'BALANCE') then
                    self.EclipseBar = CreateFrame('Frame', nil, self)
                    self.EclipseBar:SetPoint(getConfiguration()[self.frame].EclipseBar.anchor, getConfiguration()[self.frame].EclipseBar.x, getConfiguration()[self.frame].EclipseBar.y)
                    self.EclipseBar:SetSize(getConfiguration()[self.frame].EclipseBar.width - 2, getConfiguration()[self.frame].EclipseBar.height - 2)

                    self.EclipseBar.background = self.EclipseBar:CreateTexture(nil, 'BACKGROUND')
                    self.EclipseBar.background:SetPoint('TOPLEFT')
                    self.EclipseBar.background:SetSize(getConfiguration()[self.frame].EclipseBar.width - 2, getConfiguration()[self.frame].EclipseBar.height - 2)

                    self.EclipseBar.border = self.EclipseBar:CreateTexture(nil, 'BACKGROUND')
                    self.EclipseBar.border:SetPoint('TOPLEFT', -1, 1)
                    self.EclipseBar.border:SetSize(getConfiguration()[self.frame].EclipseBar.width, getConfiguration()[self.frame].EclipseBar.height)
                    self.EclipseBar.border:SetTexture(0, 0, 0)

                    self.EclipseBar.innerBorder = self.EclipseBar:CreateTexture(nil, 'LOW')
                    self.EclipseBar.innerBorder:SetPoint('TOPLEFT', 1, -1)
                    self.EclipseBar.innerBorder:SetSize(getConfiguration()[self.frame].EclipseBar[1].width, getConfiguration()[self.frame].EclipseBar[1].height)
                    self.EclipseBar.innerBorder:SetTexture(0, 0, 0)

                    self.EclipseBar.LunarBar = CreateFrame('StatusBar', nil, self)
                    self.EclipseBar.LunarBar:SetPoint(getConfiguration()[self.frame].EclipseBar[1].anchor, self.EclipseBar, getConfiguration()[self.frame].EclipseBar[1].x, getConfiguration()[self.frame].EclipseBar[1].y)
                    self.EclipseBar.LunarBar:SetSize(getConfiguration()[self.frame].EclipseBar[1].width - 2, getConfiguration()[self.frame].EclipseBar[1].height - 2)
                    self.EclipseBar.LunarBar:SetStatusBarTexture(Configuration.texture)
                    self.EclipseBar.LunarBar:SetStatusBarColor(0.3, 0.52, 0.9)

                    self.EclipseBar.SolarBar = CreateFrame('StatusBar', nil, self)
                    self.EclipseBar.SolarBar:SetPoint('LEFT', self.EclipseBar.LunarBar:GetStatusBarTexture(), 'RIGHT')
                    self.EclipseBar.SolarBar:SetSize(getConfiguration()[self.frame].EclipseBar[1].width - 2, getConfiguration()[self.frame].EclipseBar[1].height - 2)
                    self.EclipseBar.SolarBar:SetStatusBarTexture(Configuration.texture)
                    self.EclipseBar.SolarBar:SetStatusBarColor(0.8, 0.82, 0.6)

                    self.EclipseBar.text = self.EclipseBar:CreateFontString(nil, 'OVERLAY')
                    self.EclipseBar.text.frequentUpdates = true
                    self.EclipseBar.text:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                    self.EclipseBar.text:SetPoint('CENTER', self.EclipseBar.innerBorder, 1, 0)
                    self.EclipseBar.text:SetTextColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    self:Tag(self.EclipseBar.text, '[SnailUI:EclipseDirection]')
                end
            end

            if getConfiguration()[self.frame].DemonicFuryBar and (unit == 'Player') then
                if (class == 'WARLOCK') and (spec == 'DEMONOLOGY') then
                    self.WarlockSpecBars = CreateFrame('Frame', nil, self)
                    self.WarlockSpecBars:SetPoint(getConfiguration()[self.frame].DemonicFuryBar.anchor, getConfiguration()[self.frame].DemonicFuryBar.x, getConfiguration()[self.frame].DemonicFuryBar.y)
                    self.WarlockSpecBars:SetSize(getConfiguration()[self.frame].DemonicFuryBar.width - 2, getConfiguration()[self.frame].DemonicFuryBar.height - 2)

                    self.warlockSpecBarsBackground = self:CreateTexture(nil, 'BACKGROUND')
                    self.warlockSpecBarsBackground:SetPoint('TOPLEFT', self.WarlockSpecBars)
                    self.warlockSpecBarsBackground:SetSize(getConfiguration()[self.frame].DemonicFuryBar.width - 2, getConfiguration()[self.frame].DemonicFuryBar.height - 2)

                    self.warlockSpecBarsBorder = self:CreateTexture(nil, 'BACKGROUND')
                    self.warlockSpecBarsBorder:SetPoint('TOPLEFT', self.WarlockSpecBars, -1, 1)
                    self.warlockSpecBarsBorder:SetSize(getConfiguration()[self.frame].DemonicFuryBar.width, getConfiguration()[self.frame].DemonicFuryBar.height)
                    self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

                    for i = 1, #getConfiguration()[self.frame].DemonicFuryBar do
                        self.WarlockSpecBars[i] = CreateFrame('StatusBar', nil, self)
                        self.WarlockSpecBars[i]:SetPoint(getConfiguration()[self.frame].DemonicFuryBar[i].anchor, self.WarlockSpecBars, getConfiguration()[self.frame].DemonicFuryBar[i].x, getConfiguration()[self.frame].DemonicFuryBar[i].y)
                        self.WarlockSpecBars[i]:SetSize(getConfiguration()[self.frame].DemonicFuryBar[i].width - 2, getConfiguration()[self.frame].DemonicFuryBar[i].height - 2)
                        self.WarlockSpecBars[i]:SetStatusBarTexture(Configuration.texture)

                        self.warlockSpecBarsBorder[i] = self:CreateTexture(nil, 'LOW')
                        self.warlockSpecBarsBorder[i]:SetPoint('TOPLEFT', self.WarlockSpecBars[i], -1, 1)
                        self.warlockSpecBarsBorder[i]:SetSize(getConfiguration()[self.frame].DemonicFuryBar[i].width, getConfiguration()[self.frame].DemonicFuryBar[i].height)
                        self.warlockSpecBarsBorder[i]:SetTexture(0, 0, 0)
                    end
                end
            end

            if getConfiguration()[self.frame].HealthBar then
                self:RegisterEvent('UNIT_HEAL_PREDICTION',
                    function(self)
                        self.HealPrediction.myBar:SetAlpha(self:GetAlpha() / 2)
                        self.HealPrediction.otherBar:SetAlpha(self:GetAlpha() / 2)
                    end
                )

                self.Health = CreateFrame('StatusBar', nil, self)
                self.Health.frequentUpdates = true
                self.Health:SetOrientation(getConfiguration()[self.frame].HealthBar.orientation)
                self.Health:SetPoint(getConfiguration()[self.frame].HealthBar.anchor, getConfiguration()[self.frame].HealthBar.x, getConfiguration()[self.frame].HealthBar.y)
                self.Health:SetSize(getConfiguration()[self.frame].HealthBar.width - 2, getConfiguration()[self.frame].HealthBar.height - 2)
                self.Health:SetStatusBarTexture(Configuration.texture)
                
                self.Health.border = self.Health:CreateTexture(nil, 'LOW')
                self.Health.border:SetPoint('TOPLEFT', -1, 1)
                self.Health.border:SetSize(getConfiguration()[self.frame].HealthBar.width, getConfiguration()[self.frame].HealthBar.height)
                self.Health.border:SetTexture(0, 0, 0)

                self.HealPrediction =
                {
                    maxOverflow = 1,
                    myBar = CreateFrame('StatusBar', nil, self),
                    otherBar = CreateFrame('StatusBar', nil, self)
                }

                self.HealPrediction.myBar:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
                self.HealPrediction.myBar:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
                self.HealPrediction.myBar:SetSize(getConfiguration()[self.frame].HealthBar.width - 2, getConfiguration()[self.frame].HealthBar.height - 2)
                self.HealPrediction.myBar:SetStatusBarTexture(Configuration.texture)

                self.HealPrediction.otherBar:SetPoint('TOPLEFT', self.HealPrediction.myBar:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
                self.HealPrediction.otherBar:SetPoint('BOTTOMLEFT', self.HealPrediction.myBar:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
                self.HealPrediction.otherBar:SetSize(getConfiguration()[self.frame].HealthBar.width - 2, getConfiguration()[self.frame].HealthBar.height - 2)
                self.HealPrediction.otherBar:SetStatusBarTexture(Configuration.texture)

                if getConfiguration()[self.frame].HealthBar.Text then
                    self.Health.text = self.Health:CreateFontString(nil, 'OVERLAY')
                    self.Health.text.frequentUpdates = true
                    self.Health.text:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                    self.Health.text:SetPoint(getConfiguration()[self.frame].HealthBar.Text.anchor, getConfiguration()[self.frame].HealthBar.Text.x, getConfiguration()[self.frame].HealthBar.Text.y)

                    if getConfiguration()[self.frame].HealthBar.smallText then
                        self:Tag(self.Health.text, '[SnailUI:SmallHealth]')
                    else
                        self:Tag(self.Health.text, '[SnailUI:Health]')
                    end
                end
            end

            if getConfiguration()[self.frame].HolyPowerBar and (unit == 'Player') then
                if class == 'PALADIN' then
                    self.ClassIcons = self:CreateTexture(self, 'BACKGROUND')
                    self.ClassIcons:SetPoint(getConfiguration()[self.frame].HolyPowerBar.anchor, getConfiguration()[self.frame].HolyPowerBar.x, getConfiguration()[self.frame].HolyPowerBar.y)
                    self.ClassIcons:SetSize(getConfiguration()[self.frame].HolyPowerBar.width, getConfiguration()[self.frame].HolyPowerBar.height)
                    self.ClassIcons:SetTexture(0, 0, 0)

                    self.ClassIcons.background = self:CreateTexture(nil, 'BACKGROUND')
                    self.ClassIcons.background:SetPoint('TOPLEFT', self.ClassIcons, 1, -1)
                    self.ClassIcons.background:SetSize(getConfiguration()[self.frame].HolyPowerBar.width - 2, getConfiguration()[self.frame].HolyPowerBar.height - 2)

                    for i = 1, 5 do
                        self.ClassIcons[i] = self:CreateTexture(self, 'LOW')

                        if i <= #getConfiguration()[self.frame].HolyPowerBar then
                            self.ClassIcons[i]:SetPoint(getConfiguration()[self.frame].HolyPowerBar[i].anchor, self.ClassIcons, getConfiguration()[self.frame].HolyPowerBar[i].x, getConfiguration()[self.frame].HolyPowerBar[i].y)
                            self.ClassIcons[i]:SetSize(getConfiguration()[self.frame].HolyPowerBar[i].width - 2, getConfiguration()[self.frame].HolyPowerBar[i].height - 2)
                            self.ClassIcons[i]:SetTexture(Configuration.texture)

                            self.ClassIcons[i].border = self:CreateTexture(nil, 'LOW')
                            self.ClassIcons[i].border:SetPoint('TOPLEFT', self.ClassIcons[i], -1, 1)
                            self.ClassIcons[i].border:SetSize(getConfiguration()[self.frame].HolyPowerBar[i].width, getConfiguration()[self.frame].HolyPowerBar[i].height)
                            self.ClassIcons[i].border:SetTexture(0, 0, 0)
                        end
                    end
                end
            end

            if getConfiguration()[self.frame].PowerBar then
                self.Power = CreateFrame('StatusBar', nil, self)
                self.Power.frequentUpdates = true
                self.Power:SetOrientation(getConfiguration()[self.frame].PowerBar.orientation)
                self.Power:SetPoint(getConfiguration()[self.frame].PowerBar.anchor, getConfiguration()[self.frame].PowerBar.x, getConfiguration()[self.frame].PowerBar.y)
                self.Power:SetStatusBarTexture(Configuration.texture)

                if getConfiguration()[self.frame].PowerBar.border then
                    self.Power:SetSize(getConfiguration()[self.frame].PowerBar.width - 6, getConfiguration()[self.frame].PowerBar.height - 6)

                    self.Power.backgroundBottom = self.Power:CreateTexture(nil, 'LOW')
                    self.Power.backgroundBottom:SetPoint('BOTTOM', 0, -2)
                    self.Power.backgroundBottom:SetSize(getConfiguration()[self.frame].PowerBar.width - 2, 1)
                    self.Power.backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    self.Power.backgroundLeft = self.Power:CreateTexture(nil, 'LOW')
                    self.Power.backgroundLeft:SetPoint('LEFT', -2, 0)
                    self.Power.backgroundLeft:SetSize(1, getConfiguration()[self.frame].PowerBar.height - 4)
                    self.Power.backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    self.Power.backgroundRight = self.Power:CreateTexture(nil, 'LOW')
                    self.Power.backgroundRight:SetPoint('RIGHT', 2, 0)
                    self.Power.backgroundRight:SetSize(1, getConfiguration()[self.frame].PowerBar.height - 4)
                    self.Power.backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    self.Power.backgroundTop = self.Power:CreateTexture(nil, 'LOW')
                    self.Power.backgroundTop:SetPoint('TOP', 0, 2)
                    self.Power.backgroundTop:SetSize(getConfiguration()[self.frame].PowerBar.width - 2, 1)
                    self.Power.backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                    
                    self.Power.border = self.Power:CreateTexture(nil, 'BACKGROUND')
                    self.Power.border:SetPoint('TOPLEFT', -3, 3)
                    self.Power.border:SetSize(getConfiguration()[self.frame].PowerBar.width, getConfiguration()[self.frame].PowerBar.height)
                    self.Power.border:SetTexture(0, 0, 0)
                else
                    self.Power:SetSize(getConfiguration()[self.frame].PowerBar.width - 2, getConfiguration()[self.frame].PowerBar.height - 2)                    
                
                    self.Power.innerBorder = self.Power:CreateTexture(nil, 'LOW')
                    self.Power.innerBorder:SetPoint('TOPLEFT', -1, 1)
                    self.Power.innerBorder:SetSize(getConfiguration()[self.frame].PowerBar.width, getConfiguration()[self.frame].PowerBar.height)
                    self.Power.innerBorder:SetTexture(0, 0, 0)
                end
            end

            if getConfiguration()[self.frame].RuneBar and (unit == 'Player') then
                if class == 'DEATHKNIGHT' then
                    self.Runes = CreateFrame('Frame', nil, self)
                    self.Runes:SetPoint(getConfiguration()[self.frame].RuneBar.anchor, getConfiguration()[self.frame].RuneBar.x, getConfiguration()[self.frame].RuneBar.y)
                    self.Runes:SetSize(getConfiguration()[self.frame].RuneBar.width - 2, getConfiguration()[self.frame].RuneBar.height - 2)

                    self.Runes.background = self.Runes:CreateTexture(nil, 'BACKGROUND')
                    self.Runes.background:SetPoint('TOPLEFT')
                    self.Runes.background:SetSize(getConfiguration()[self.frame].RuneBar.width - 2, getConfiguration()[self.frame].RuneBar.height - 2)

                    self.Runes.border = self.Runes:CreateTexture(nil, 'BACKGROUND')
                    self.Runes.border:SetPoint('TOPLEFT', -1, 1)
                    self.Runes.border:SetSize(getConfiguration()[self.frame].RuneBar.width, getConfiguration()[self.frame].RuneBar.height)
                    self.Runes.border:SetTexture(0, 0, 0)

                    for i = 1, #getConfiguration()[self.frame].RuneBar do
                        self.Runes[i] = CreateFrame('StatusBar', nil, self)
                        self.Runes[i]:SetPoint(getConfiguration()[self.frame].RuneBar[i].anchor, self.Runes, getConfiguration()[self.frame].RuneBar[i].x, getConfiguration()[self.frame].RuneBar[i].y)
                        self.Runes[i]:SetSize(getConfiguration()[self.frame].RuneBar[i].width - 2, getConfiguration()[self.frame].RuneBar[i].height - 2)
                        self.Runes[i]:SetStatusBarTexture(Configuration.texture)

                        self.Runes[i].border = self.Runes:CreateTexture(nil, 'LOW')
                        self.Runes[i].border:SetPoint('TOPLEFT', self.Runes[i], -1, 1)
                        self.Runes[i].border:SetSize(getConfiguration()[self.frame].RuneBar[i].width, getConfiguration()[self.frame].RuneBar[i].height)
                        self.Runes[i].border:SetTexture(0, 0, 0)
                    end
                end
            end

            if getConfiguration()[self.frame].ShadowOrbsBar and (unit == 'Player') then
                if (class == 'PRIEST') and (spec == 'SHADOW') then
                    self.ClassIcons = self:CreateTexture(self, 'BACKGROUND')
                    self.ClassIcons:SetPoint(getConfiguration()[self.frame].ShadowOrbsBar.anchor, getConfiguration()[self.frame].ShadowOrbsBar.x, getConfiguration()[self.frame].ShadowOrbsBar.y)
                    self.ClassIcons:SetSize(getConfiguration()[self.frame].ShadowOrbsBar.width, getConfiguration()[self.frame].ShadowOrbsBar.height)
                    self.ClassIcons:SetTexture(0, 0, 0)

                    self.ClassIcons.background = self:CreateTexture(nil, 'LOW')
                    self.ClassIcons.background:SetPoint('TOPLEFT', self.ClassIcons, 1, -1)
                    self.ClassIcons.background:SetSize(getConfiguration()[self.frame].ShadowOrbsBar.width - 2, getConfiguration()[self.frame].ShadowOrbsBar.height - 2)

                    for i = 1, 5 do
                        self.ClassIcons[i] = self:CreateTexture(self, 'LOW')

                        if i <= #getConfiguration()[self.frame].ShadowOrbsBar then
                            self.ClassIcons[i]:SetPoint(getConfiguration()[self.frame].ShadowOrbsBar[i].anchor, self.ClassIcons, getConfiguration()[self.frame].ShadowOrbsBar[i].x, getConfiguration()[self.frame].ShadowOrbsBar[i].y)
                            self.ClassIcons[i]:SetSize(getConfiguration()[self.frame].ShadowOrbsBar[i].width - 2, getConfiguration()[self.frame].ShadowOrbsBar[i].height - 2)
                            self.ClassIcons[i]:SetTexture(Configuration.texture)

                            self.ClassIcons[i].border = self:CreateTexture(nil, 'LOW')
                            self.ClassIcons[i].border:SetPoint('TOPLEFT', self.ClassIcons[i], -1, 1)
                            self.ClassIcons[i].border:SetSize(getConfiguration()[self.frame].ShadowOrbsBar[i].width, getConfiguration()[self.frame].ShadowOrbsBar[i].height)
                            self.ClassIcons[i].border:SetTexture(0, 0, 0)
                        end
                    end
                end
            end

            if getConfiguration()[self.frame].SoulShardsBar and (unit == 'Player') then
                if (class == 'WARLOCK') and (spec == 'AFFLICTION') then
                    self.WarlockSpecBars = CreateFrame('Frame', nil, self)
                    self.WarlockSpecBars:SetPoint(getConfiguration()[self.frame].SoulShardsBar.anchor, getConfiguration()[self.frame].SoulShardsBar.x, getConfiguration()[self.frame].SoulShardsBar.y)
                    self.WarlockSpecBars:SetSize(getConfiguration()[self.frame].SoulShardsBar.width - 2, getConfiguration()[self.frame].SoulShardsBar.height - 2)

                    self.warlockSpecBarsBackground = self:CreateTexture(nil, 'BACKGROUND')
                    self.warlockSpecBarsBackground:SetPoint('TOPLEFT', self.WarlockSpecBars)
                    self.warlockSpecBarsBackground:SetSize(getConfiguration()[self.frame].SoulShardsBar.width - 2, getConfiguration()[self.frame].SoulShardsBar.height - 2)

                    self.warlockSpecBarsBorder = self:CreateTexture(nil, 'BACKGROUND')
                    self.warlockSpecBarsBorder:SetPoint('TOPLEFT', self.WarlockSpecBars, -1, 1)
                    self.warlockSpecBarsBorder:SetSize(getConfiguration()[self.frame].SoulShardsBar.width, getConfiguration()[self.frame].SoulShardsBar.height)
                    self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

                    for i = 1, #getConfiguration()[self.frame].SoulShardsBar do
                        self.WarlockSpecBars[i] = CreateFrame('StatusBar', nil, self)
                        self.WarlockSpecBars[i]:SetPoint(getConfiguration()[self.frame].SoulShardsBar[i].anchor, self.WarlockSpecBars, getConfiguration()[self.frame].SoulShardsBar[i].x, getConfiguration()[self.frame].SoulShardsBar[i].y)
                        self.WarlockSpecBars[i]:SetSize(getConfiguration()[self.frame].SoulShardsBar[i].width - 2, getConfiguration()[self.frame].SoulShardsBar[i].height - 2)
                        self.WarlockSpecBars[i]:SetStatusBarTexture(Configuration.texture)

                        self.warlockSpecBarsBorder[i] = self:CreateTexture(nil, 'LOW')
                        self.warlockSpecBarsBorder[i]:SetPoint('TOPLEFT', self.WarlockSpecBars[i], -1, 1)
                        self.warlockSpecBarsBorder[i]:SetSize(getConfiguration()[self.frame].SoulShardsBar[i].width, getConfiguration()[self.frame].SoulShardsBar[i].height)
                        self.warlockSpecBarsBorder[i]:SetTexture(0, 0, 0)
                    end
                end
            end
        end
    end
)

oUF:Factory(
    function(self)
        warlockCheckForSacrifice()
        spec = GetSpecialization()

        if spec then
            spec = select(2, GetSpecializationInfo(spec))
            spec = spec:gsub('(.)', string.upper)
        else
            spec = nil
        end

        category = CreateFrame('Frame', nil, UIParent)
        category.name = 'SnailUI'

        category.label1 = category:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
        category.label1:SetJustifyH('LEFT')
        category.label1:SetPoint('TOPLEFT', 16, -16)
        category.label1:SetText('SnailUI')

        category.label2 = category:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
        category.label2:SetJustifyH('LEFT')
        category.label2:SetPoint('TOPLEFT', 16, -36)
        category.label2:SetText(
            'Snail\'s minimalistic UI' ..
            '\n\n' ..
            'Version ' .. version ..
            '\n\n' ..
            'Written by Snail' ..
            '\n' ..
            'http://twitter.com/1Snail' ..
            '\n' ..
            'http://wowinterface.com/downloads/info20900-SnailUI'
        )

        category.default = function(self)
        end

        category.okay = function(self)
            ReloadUI();
        end

        generalSubcategory = CreateFrame('Frame', nil, category)
        generalSubcategory.name = 'General'
        generalSubcategory.parent = category.name

        generalSubcategory.label1 = generalSubcategory:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
        generalSubcategory.label1:SetJustifyH('LEFT')
        generalSubcategory.label1:SetPoint('TOPLEFT', 16, -16)
        generalSubcategory.label1:SetText('General')

        generalSubcategory.label2 = generalSubcategory:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
        generalSubcategory.label2:SetJustifyH('LEFT')
        generalSubcategory.label2:SetPoint('TOPLEFT', 16, -36)
        generalSubcategory.label2:SetText(
            'General options for SnailUI' ..
            '\n\n' ..
            'Theme a'
        )

        InterfaceOptions_AddCategory(category)
        InterfaceOptions_AddCategory(generalSubcategory)

        SlashCmdList['SnailUI'] = function(command)
            InterfaceOptionsFrame_OpenToCategory(category)
        end

        SLASH_SnailUI1 = '/SnailUI'
        SLASH_SnailUI2 = '/SUI'

        SetCVar('consolidateBuffs', '0')
        SetCVar('useUiScale', '0')

        RaidBossEmoteFrame:Hide()
        UIErrorsFrame:Hide()
        WatchFrame:Hide()
        WorldStateAlwaysUpFrame:Hide()

        CompactRaidFrameManager:UnregisterAllEvents()
        CompactRaidFrameManager:Hide()
        CompactRaidFrameManager:SetScript('OnShow',
            function(self)
                self:Hide()
            end
        )
            
        CompactRaidFrameContainer:UnregisterAllEvents()
        CompactRaidFrameContainer:Hide()
        CompactRaidFrameContainer:SetScript('OnShow',
            function(self)
                self:Hide()
            end
        )

        self:SetActiveStyle('SnailUI')

        if getConfiguration().ActionBars then
            frames =
            {
                'AchievementMicroButton',
                'ActionBarDownButton',
                'ActionBarUpButton',
                'CharacterBag0Slot',
                'CharacterBag1Slot',
                'CharacterBag2Slot',
                'CharacterBag3Slot',
                'CharacterMicroButton',
                'CompanionsMicroButton',
                'EJMicroButton',
                'GuildMicroButton',
                'HelpMicroButton',
                'MainMenuBarBackpackButton',
                'MainMenuBarMaxLevelBar',
                'MainMenuExpBar',
                'MainMenuMicroButton',
                'MultiBarBottomLeft',
                'MultiBarBottomRight',
                'MultiBarLeft',
                'MultiBarRight',
                'LFDMicroButton',
                'PVPMicroButton',
                'QuestLogMicroButton',
                'ReputationWatchBar',
                'SpellbookMicroButton',
                'TalentMicroButton'
            }

            AchievementMicroButton_Update = function(self)
            end

            StanceBarFrame:SetPoint('TOPLEFT', UIParent, -500, 500)

            if not getConfiguration().ActionBars.Pet then
                PetActionBarFrame:Hide()
                PetActionBarFrame:SetScript('OnShow',
                    function(self)
                        self:Hide()
                    end
                )
            end

            for i = 1, #frames do
                _G[frames[i]]:Hide()
                _G[frames[i]]:SetScript('OnShow',
                    function(self)
                        self:Hide()
                    end
                )

                _G[frames[i]].Show = function(self)
                end
            end

            textures =
            {
                'MainMenuBarLeftEndCap',
                'MainMenuBarPageNumber',
                'MainMenuBarRightEndCap',
                'MainMenuBarTexture0',
                'MainMenuBarTexture1',
                'MainMenuBarTexture2',
                'MainMenuBarTexture3',
                'SlidingActionBarTexture0',
                'SlidingActionBarTexture1'
            }

            for i = 1, #textures do
                _G[textures[i]]:Hide()
                _G[textures[i]]:SetAlpha(0)
            end

            if getConfiguration().ActionBars.Pet then
                if getConfiguration().ActionBars.Pet.buttons < NUM_PET_ACTION_SLOTS then
                    for i = (getConfiguration().ActionBars.Pet.buttons + 1), NUM_PET_ACTION_SLOTS do
                        _G['PetActionButton' .. i]:Hide()
                        _G['PetActionButton' .. i]:SetScript('OnShow',
                            function(self)
                                self:Hide()
                            end
                        )

                        _G['PetActionButton' .. i].Show = function(self)
                        end
                    end
                end

                PetActionBarFrame:ClearAllPoints()
                PetActionBarFrame:SetSize((getConfiguration().ActionBars.Pet.buttons * getConfiguration().ActionBars.Pet.width) + ((getConfiguration().ActionBars.Pet.buttons - 1) * 4), getConfiguration().ActionBars.Pet.height)
                PetActionBarFrame:SetPoint(getConfiguration().ActionBars.Pet.anchor, getConfiguration().ActionBars.Pet.x, getConfiguration().ActionBars.Pet.y)
                PetActionBarFrame.SetPoint = function(self)
                end

                for i = 1, getConfiguration().ActionBars.Pet.buttons do
                    _G['PetActionButton' .. i]:ClearAllPoints()
                    _G['PetActionButton' .. i]:SetNormalTexture(nil)
                    _G['PetActionButton' .. i]:SetPoint('LEFT', ((i - 1) * getConfiguration().ActionBars.Pet.width) + ((i - 1) * 4) + 3, 0)
                    _G['PetActionButton' .. i]:SetSize(getConfiguration().ActionBars.Pet.width - 6, getConfiguration().ActionBars.Pet.height - 6)
                    _G['PetActionButton' .. i].SetNormalTexture = function(self)
                    end

                    _G['PetActionButton' .. i].backgroundBottom = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].backgroundBottom:SetPoint('BOTTOM', 0, -2)
                    _G['PetActionButton' .. i].backgroundBottom:SetSize(getConfiguration().ActionBars.Pet.width - 2, 1)
                    _G['PetActionButton' .. i].backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    _G['PetActionButton' .. i].backgroundLeft = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].backgroundLeft:SetPoint('LEFT', -2, 0)
                    _G['PetActionButton' .. i].backgroundLeft:SetSize(1, getConfiguration().ActionBars.Pet.height - 4)
                    _G['PetActionButton' .. i].backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    _G['PetActionButton' .. i].backgroundRight = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].backgroundRight:SetPoint('RIGHT', 2, 0)
                    _G['PetActionButton' .. i].backgroundRight:SetSize(1, getConfiguration().ActionBars.Pet.height - 4)
                    _G['PetActionButton' .. i].backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    _G['PetActionButton' .. i].backgroundTop = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].backgroundTop:SetPoint('TOP', 0, 2)
                    _G['PetActionButton' .. i].backgroundTop:SetSize(getConfiguration().ActionBars.Pet.width - 2, 1)
                    _G['PetActionButton' .. i].backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                    
                    _G['PetActionButton' .. i].borderBottom = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].borderBottom:SetPoint('BOTTOM', 0, -3)
                    _G['PetActionButton' .. i].borderBottom:SetSize(getConfiguration().ActionBars.Pet.width, 3)
                    _G['PetActionButton' .. i].borderBottom:SetTexture(0, 0, 0)

                    _G['PetActionButton' .. i].borderLeft = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].borderLeft:SetPoint('LEFT', -3, 0)
                    _G['PetActionButton' .. i].borderLeft:SetSize(3, getConfiguration().ActionBars.Pet.height - 2)
                    _G['PetActionButton' .. i].borderLeft:SetTexture(0, 0, 0)

                    _G['PetActionButton' .. i].borderRight = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].borderRight:SetPoint('RIGHT', 3, 0)
                    _G['PetActionButton' .. i].borderRight:SetSize(3, getConfiguration().ActionBars.Pet.height - 2)
                    _G['PetActionButton' .. i].borderRight:SetTexture(0, 0, 0)

                    _G['PetActionButton' .. i].borderTop = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].borderTop:SetPoint('TOP', 0, 3)
                    _G['PetActionButton' .. i].borderTop:SetSize(getConfiguration().ActionBars.Pet.width, 3)
                    _G['PetActionButton' .. i].borderTop:SetTexture(0, 0, 0)

                    _G['PetActionButton' .. i .. 'AutoCastable']:SetAlpha(0)
                    _G['PetActionButton' .. i .. 'Cooldown']:SetSize(getConfiguration().ActionBars.Pet.width - 6, getConfiguration().ActionBars.Pet.height - 6)
                    _G['PetActionButton' .. i .. 'Cooldown']:SetPoint('CENTER')
                    _G['PetActionButton' .. i .. 'Icon']:SetTexCoord(getConfiguration().ActionBars.Pet.TextureCoordinate.left, getConfiguration().ActionBars.Pet.TextureCoordinate.right, getConfiguration().ActionBars.Pet.TextureCoordinate.top, getConfiguration().ActionBars.Pet.TextureCoordinate.bottom)
                    _G['PetActionButton' .. i .. 'Shine']:SetAllPoints(_G['PetActionButton' .. i])
                end
            end

            if getConfiguration().ActionBars.Player.buttons < NUM_ACTIONBAR_BUTTONS then
                for i = (getConfiguration().ActionBars.Player.buttons + 1), NUM_ACTIONBAR_BUTTONS do
                    _G['ActionButton' .. i]:Hide()
                    _G['ActionButton' .. i]:SetScript('OnShow',
                        function(self)
                            self:Hide()
                        end
                    )

                    _G['ActionButton' .. i].Show = function(self)
                    end
                end
            end

            MainMenuBar:ClearAllPoints()
            MainMenuBar:SetSize((getConfiguration().ActionBars.Player.buttons * getConfiguration().ActionBars.Player.width) + ((getConfiguration().ActionBars.Player.buttons - 1) * 4), getConfiguration().ActionBars.Player.height)
            MainMenuBar:SetPoint(getConfiguration().ActionBars.Player.anchor, getConfiguration().ActionBars.Player.x, getConfiguration().ActionBars.Player.y)

            for i = 1, getConfiguration().ActionBars.Player.buttons do
                _G['ActionButton' .. i]:ClearAllPoints()
                _G['ActionButton' .. i]:SetNormalTexture(nil)
                _G['ActionButton' .. i]:SetPoint('LEFT', ((i - 1) * getConfiguration().ActionBars.Player.width) + ((i - 1) * 4) + 3, 0)
                _G['ActionButton' .. i]:SetSize(getConfiguration().ActionBars.Player.width - 6, getConfiguration().ActionBars.Player.height - 6)
                
                _G['ActionButton' .. i].backgroundBottom = _G['ActionButton' .. i]:CreateTexture(nil, 'LOW')
                _G['ActionButton' .. i].backgroundBottom:SetPoint('BOTTOM', 0, -2)
                _G['ActionButton' .. i].backgroundBottom:SetSize(getConfiguration().ActionBars.Player.width - 2, 1)
                _G['ActionButton' .. i].backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                _G['ActionButton' .. i].backgroundLeft = _G['ActionButton' .. i]:CreateTexture(nil, 'LOW')
                _G['ActionButton' .. i].backgroundLeft:SetPoint('LEFT', -2, 0)
                _G['ActionButton' .. i].backgroundLeft:SetSize(1, getConfiguration().ActionBars.Player.height - 4)
                _G['ActionButton' .. i].backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                _G['ActionButton' .. i].backgroundRight = _G['ActionButton' .. i]:CreateTexture(nil, 'LOW')
                _G['ActionButton' .. i].backgroundRight:SetPoint('RIGHT', 2, 0)
                _G['ActionButton' .. i].backgroundRight:SetSize(1, getConfiguration().ActionBars.Player.height - 4)
                _G['ActionButton' .. i].backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                _G['ActionButton' .. i].backgroundTop = _G['ActionButton' .. i]:CreateTexture(nil, 'LOW')
                _G['ActionButton' .. i].backgroundTop:SetPoint('TOP', 0, 2)
                _G['ActionButton' .. i].backgroundTop:SetSize(getConfiguration().ActionBars.Player.width - 2, 1)
                _G['ActionButton' .. i].backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                
                _G['ActionButton' .. i].borderBottom = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                _G['ActionButton' .. i].borderBottom:SetPoint('BOTTOM', 0, -3)
                _G['ActionButton' .. i].borderBottom:SetSize(getConfiguration().ActionBars.Player.width, 3)
                _G['ActionButton' .. i].borderBottom:SetTexture(0, 0, 0)

                _G['ActionButton' .. i].borderLeft = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                _G['ActionButton' .. i].borderLeft:SetPoint('LEFT', -3, 0)
                _G['ActionButton' .. i].borderLeft:SetSize(3, getConfiguration().ActionBars.Player.height - 2)
                _G['ActionButton' .. i].borderLeft:SetTexture(0, 0, 0)

                _G['ActionButton' .. i].borderRight = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                _G['ActionButton' .. i].borderRight:SetPoint('RIGHT', 3, 0)
                _G['ActionButton' .. i].borderRight:SetSize(3, getConfiguration().ActionBars.Player.height - 2)
                _G['ActionButton' .. i].borderRight:SetTexture(0, 0, 0)

                _G['ActionButton' .. i].borderTop = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                _G['ActionButton' .. i].borderTop:SetPoint('TOP', 0, 3)
                _G['ActionButton' .. i].borderTop:SetSize(getConfiguration().ActionBars.Player.width, 3)
                _G['ActionButton' .. i].borderTop:SetTexture(0, 0, 0)

                _G['ActionButton' .. i .. 'Count']:SetAlpha(0)
                _G['ActionButton' .. i .. 'Border']:SetAlpha(0)
                _G['ActionButton' .. i .. 'Border'].SetVertexColor = function(self)
                end

                _G['ActionButton' .. i .. 'Icon']:SetTexCoord(getConfiguration().ActionBars.Player.TextureCoordinate.left, getConfiguration().ActionBars.Player.TextureCoordinate.right, getConfiguration().ActionBars.Player.TextureCoordinate.top, getConfiguration().ActionBars.Player.TextureCoordinate.bottom)
                _G['ActionButton' .. i .. 'FlyoutBorder']:SetAlpha(0)
                _G['ActionButton' .. i .. 'FlyoutBorderShadow']:SetAlpha(0)
                _G['ActionButton' .. i .. 'HotKey']:SetAlpha(0)
                _G['ActionButton' .. i .. 'Name']:SetAlpha(0)
            end
        end

        if getConfiguration().Buffs then
            AuraButton_UpdateDuration = function(self, timeLeft)         
                if (SHOW_BUFF_DURATIONS == '1') and timeLeft then
                    self.duration:SetFormattedText(SecondsToTimeAbbrev(timeLeft));
                    text = self.duration:GetText()

                    if timeLeft < BUFF_DURATION_WARNING_TIME then
                        self.duration:SetVertexColor(HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b);
                    else
                        self.duration:SetVertexColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
                    end

                    self.duration:SetText(text:gsub(' ', ''))
                    self.duration:Show();
                else
                    self.duration:Hide();
                end
            end

            BuffFrame:Hide()
            OriginalBuffFrame_Update = BuffFrame_Update    

            BuffFrame_Update = function(self)
                OriginalBuffFrame_Update(self)

                BuffFrame:ClearAllPoints()
                BuffFrame:SetPoint(getConfiguration().Buffs.anchor, getConfiguration().Buffs.x, getConfiguration().Buffs.y)

                greaterBuff = BUFF_ACTUAL_DISPLAY

                if DEBUFF_ACTUAL_DISPLAY > greaterBuff then
                    greaterBuff = DEBUFF_ACTUAL_DISPLAY
                end

                if BuffFrame.numEnchants > greaterBuff then
                    greaterBuff = BuffFrame.numEnchants
                end

                if DEBUFF_ACTUAL_DISPLAY > 0 then
                    BuffFrame:SetSize((getConfiguration().Buffs.width * 2) + 4, greaterBuff * getConfiguration().Buffs.height)
                else
                    BuffFrame:SetSize(getConfiguration().Buffs.width, greaterBuff * getConfiguration().Buffs.height)
                end

                for i = 1, BUFF_ACTUAL_DISPLAY do
                    _G['BuffButton' .. i]:ClearAllPoints()
                    _G['BuffButton' .. i]:SetPoint('TOPRIGHT', -3, -(((i - 1) * getConfiguration().Buffs.height) + ((i - 1) * 4) + 3))
                    _G['BuffButton' .. i]:SetSize(getConfiguration().Buffs.width - 6, getConfiguration().Buffs.height - 6)

                    if not  _G['BuffButton' .. i].backgroundBottom then
                        _G['BuffButton' .. i].backgroundBottom = _G['BuffButton' .. i]:CreateTexture(nil, 'LOW')
                        _G['BuffButton' .. i].backgroundBottom:SetPoint('BOTTOM', 0, -2)
                        _G['BuffButton' .. i].backgroundBottom:SetSize(getConfiguration().Buffs.width - 2, 1)
                        _G['BuffButton' .. i].backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                        _G['BuffButton' .. i].backgroundLeft = _G['BuffButton' .. i]:CreateTexture(nil, 'LOW')
                        _G['BuffButton' .. i].backgroundLeft:SetPoint('LEFT', -2, 0)
                        _G['BuffButton' .. i].backgroundLeft:SetSize(1, getConfiguration().Buffs.height - 4)
                        _G['BuffButton' .. i].backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                        _G['BuffButton' .. i].backgroundRight = _G['BuffButton' .. i]:CreateTexture(nil, 'LOW')
                        _G['BuffButton' .. i].backgroundRight:SetPoint('RIGHT', 2, 0)
                        _G['BuffButton' .. i].backgroundRight:SetSize(1, getConfiguration().Buffs.height - 4)
                        _G['BuffButton' .. i].backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                        _G['BuffButton' .. i].backgroundTop = _G['BuffButton' .. i]:CreateTexture(nil, 'LOW')
                        _G['BuffButton' .. i].backgroundTop:SetPoint('TOP', 0, 2)
                        _G['BuffButton' .. i].backgroundTop:SetSize(getConfiguration().Buffs.width - 2, 1)
                        _G['BuffButton' .. i].backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                        
                        _G['BuffButton' .. i].borderBottom = _G['BuffButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['BuffButton' .. i].borderBottom:SetPoint('BOTTOM', 0, -3)
                        _G['BuffButton' .. i].borderBottom:SetSize(getConfiguration().Buffs.width, 3)
                        _G['BuffButton' .. i].borderBottom:SetTexture(0, 0, 0)

                        _G['BuffButton' .. i].borderLeft = _G['BuffButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['BuffButton' .. i].borderLeft:SetPoint('LEFT', -3, 0)
                        _G['BuffButton' .. i].borderLeft:SetSize(3, getConfiguration().Buffs.height - 2)
                        _G['BuffButton' .. i].borderLeft:SetTexture(0, 0, 0)

                        _G['BuffButton' .. i].borderRight = _G['BuffButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['BuffButton' .. i].borderRight:SetPoint('RIGHT', 3, 0)
                        _G['BuffButton' .. i].borderRight:SetSize(3, getConfiguration().Buffs.height - 2)
                        _G['BuffButton' .. i].borderRight:SetTexture(0, 0, 0)

                        _G['BuffButton' .. i].borderTop = _G['BuffButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['BuffButton' .. i].borderTop:SetPoint('TOP', 0, 3)
                        _G['BuffButton' .. i].borderTop:SetSize(getConfiguration().Buffs.width, 3)
                        _G['BuffButton' .. i].borderTop:SetTexture(0, 0, 0)
                    end

                    _G['BuffButton' .. i .. 'Count']:ClearAllPoints()
                    _G['BuffButton' .. i .. 'Count']:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                    _G['BuffButton' .. i .. 'Count']:SetPoint('BOTTOMRIGHT', 1, 0)

                    _G['BuffButton' .. i .. 'Duration']:ClearAllPoints()
                    _G['BuffButton' .. i .. 'Duration']:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                    _G['BuffButton' .. i .. 'Duration']:SetPoint('CENTER', 1, 0)
                    _G['BuffButton' .. i .. 'Duration']:SetShadowOffset(0, 0)

                    _G['BuffButton' .. i .. 'Icon']:SetTexCoord(0.1, 0.9, 0.1, 0.9)
                end

                 for i = 1, DEBUFF_ACTUAL_DISPLAY do
                    _G['DebuffButton' .. i]:ClearAllPoints()
                    _G['DebuffButton' .. i]:SetPoint('TOPLEFT', 3, -(((i - 1) * getConfiguration().Buffs.height) + ((i - 1) * 4) + 3))
                    _G['DebuffButton' .. i]:SetSize(getConfiguration().Buffs.width - 6, getConfiguration().Buffs.height - 6)

                    if not  _G['DebuffButton' .. i].backgroundBottom then
                        _G['DebuffButton' .. i].backgroundBottom = _G['DebuffButton' .. i]:CreateTexture(nil, 'LOW')
                        _G['DebuffButton' .. i].backgroundBottom:SetPoint('BOTTOM', 0, -2)
                        _G['DebuffButton' .. i].backgroundBottom:SetSize(getConfiguration().Buffs.width - 2, 1)
                        _G['DebuffButton' .. i].backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                        _G['DebuffButton' .. i].backgroundLeft = _G['DebuffButton' .. i]:CreateTexture(nil, 'LOW')
                        _G['DebuffButton' .. i].backgroundLeft:SetPoint('LEFT', -2, 0)
                        _G['DebuffButton' .. i].backgroundLeft:SetSize(1, getConfiguration().Buffs.height - 4)
                        _G['DebuffButton' .. i].backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                        _G['DebuffButton' .. i].backgroundRight = _G['DebuffButton' .. i]:CreateTexture(nil, 'LOW')
                        _G['DebuffButton' .. i].backgroundRight:SetPoint('RIGHT', 2, 0)
                        _G['DebuffButton' .. i].backgroundRight:SetSize(1, getConfiguration().Buffs.height - 4)
                        _G['DebuffButton' .. i].backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                        _G['DebuffButton' .. i].backgroundTop = _G['DebuffButton' .. i]:CreateTexture(nil, 'LOW')
                        _G['DebuffButton' .. i].backgroundTop:SetPoint('TOP', 0, 2)
                        _G['DebuffButton' .. i].backgroundTop:SetSize(getConfiguration().Buffs.width - 2, 1)
                        _G['DebuffButton' .. i].backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                        
                        _G['DebuffButton' .. i].borderBottom = _G['DebuffButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['DebuffButton' .. i].borderBottom:SetPoint('BOTTOM', 0, -3)
                        _G['DebuffButton' .. i].borderBottom:SetSize(getConfiguration().Buffs.width, 3)
                        _G['DebuffButton' .. i].borderBottom:SetTexture(0, 0, 0)

                        _G['DebuffButton' .. i].borderLeft = _G['DebuffButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['DebuffButton' .. i].borderLeft:SetPoint('LEFT', -3, 0)
                        _G['DebuffButton' .. i].borderLeft:SetSize(3, getConfiguration().Buffs.height - 2)
                        _G['DebuffButton' .. i].borderLeft:SetTexture(0, 0, 0)

                        _G['DebuffButton' .. i].borderRight = _G['DebuffButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['DebuffButton' .. i].borderRight:SetPoint('RIGHT', 3, 0)
                        _G['DebuffButton' .. i].borderRight:SetSize(3, getConfiguration().Buffs.height - 2)
                        _G['DebuffButton' .. i].borderRight:SetTexture(0, 0, 0)

                        _G['DebuffButton' .. i].borderTop = _G['DebuffButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['DebuffButton' .. i].borderTop:SetPoint('TOP', 0, 3)
                        _G['DebuffButton' .. i].borderTop:SetSize(getConfiguration().Buffs.width, 3)
                        _G['DebuffButton' .. i].borderTop:SetTexture(0, 0, 0)
                    end

                    _G['DebuffButton' .. i .. 'Border']:Hide()

                    _G['DebuffButton' .. i .. 'Count']:ClearAllPoints()
                    _G['DebuffButton' .. i .. 'Count']:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                    _G['DebuffButton' .. i .. 'Count']:SetPoint('BOTTOMRIGHT', 1, 0)

                    _G['DebuffButton' .. i .. 'Duration']:ClearAllPoints()
                    _G['DebuffButton' .. i .. 'Duration']:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                    _G['DebuffButton' .. i .. 'Duration']:SetPoint('CENTER', 1, 0)
                    _G['DebuffButton' .. i .. 'Duration']:SetShadowOffset(0, 0)

                    _G['DebuffButton' .. i .. 'Icon']:SetTexCoord(0.1, 0.9, 0.1, 0.9)
                end

                for i = 1, BuffFrame.numEnchants do
                    _G['TempEnchant' .. i]:ClearAllPoints()
                    _G['TempEnchant' .. i]:SetParent(BuffFrame)
                    _G['TempEnchant' .. i]:SetPoint('TOPLEFT', -33, -(((i - 1) * getConfiguration().Buffs.height) + ((i - 1) * 4) + 3))
                    _G['TempEnchant' .. i]:SetSize(getConfiguration().Buffs.width - 6, getConfiguration().Buffs.height - 6)

                    if not  _G['TempEnchant' .. i].backgroundBottom then
                        _G['TempEnchant' .. i].backgroundBottom = _G['TempEnchant' .. i]:CreateTexture(nil, 'LOW')
                        _G['TempEnchant' .. i].backgroundBottom:SetPoint('BOTTOM', 0, -2)
                        _G['TempEnchant' .. i].backgroundBottom:SetSize(getConfiguration().Buffs.width - 2, 1)
                        _G['TempEnchant' .. i].backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                        _G['TempEnchant' .. i].backgroundLeft = _G['TempEnchant' .. i]:CreateTexture(nil, 'LOW')
                        _G['TempEnchant' .. i].backgroundLeft:SetPoint('LEFT', -2, 0)
                        _G['TempEnchant' .. i].backgroundLeft:SetSize(1, getConfiguration().Buffs.height - 4)
                        _G['TempEnchant' .. i].backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                        _G['TempEnchant' .. i].backgroundRight = _G['TempEnchant' .. i]:CreateTexture(nil, 'LOW')
                        _G['TempEnchant' .. i].backgroundRight:SetPoint('RIGHT', 2, 0)
                        _G['TempEnchant' .. i].backgroundRight:SetSize(1, getConfiguration().Buffs.height - 4)
                        _G['TempEnchant' .. i].backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                        _G['TempEnchant' .. i].backgroundTop = _G['TempEnchant' .. i]:CreateTexture(nil, 'LOW')
                        _G['TempEnchant' .. i].backgroundTop:SetPoint('TOP', 0, 2)
                        _G['TempEnchant' .. i].backgroundTop:SetSize(getConfiguration().Buffs.width - 2, 1)
                        _G['TempEnchant' .. i].backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                        
                        _G['TempEnchant' .. i].borderBottom = _G['TempEnchant' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['TempEnchant' .. i].borderBottom:SetPoint('BOTTOM', 0, -3)
                        _G['TempEnchant' .. i].borderBottom:SetSize(getConfiguration().Buffs.width, 3)
                        _G['TempEnchant' .. i].borderBottom:SetTexture(0, 0, 0)

                        _G['TempEnchant' .. i].borderLeft = _G['TempEnchant' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['TempEnchant' .. i].borderLeft:SetPoint('LEFT', -3, 0)
                        _G['TempEnchant' .. i].borderLeft:SetSize(3, getConfiguration().Buffs.height - 2)
                        _G['TempEnchant' .. i].borderLeft:SetTexture(0, 0, 0)

                        _G['TempEnchant' .. i].borderRight = _G['TempEnchant' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['TempEnchant' .. i].borderRight:SetPoint('RIGHT', 3, 0)
                        _G['TempEnchant' .. i].borderRight:SetSize(3, getConfiguration().Buffs.height - 2)
                        _G['TempEnchant' .. i].borderRight:SetTexture(0, 0, 0)

                        _G['TempEnchant' .. i].borderTop = _G['TempEnchant' .. i]:CreateTexture(nil, 'BACKGROUND')
                        _G['TempEnchant' .. i].borderTop:SetPoint('TOP', 0, 3)
                        _G['TempEnchant' .. i].borderTop:SetSize(getConfiguration().Buffs.width, 3)
                        _G['TempEnchant' .. i].borderTop:SetTexture(0, 0, 0)
                    end

                    _G['TempEnchant' .. i .. 'Border']:Hide()

                    _G['TempEnchant' .. i .. 'Count']:ClearAllPoints()
                    _G['TempEnchant' .. i .. 'Count']:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                    _G['TempEnchant' .. i .. 'Count']:SetPoint('BOTTOMRIGHT', 1, 0)

                    _G['TempEnchant' .. i .. 'Duration']:ClearAllPoints()
                    _G['TempEnchant' .. i .. 'Duration']:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                    _G['TempEnchant' .. i .. 'Duration']:SetPoint('CENTER', 1, 0)
                    _G['TempEnchant' .. i .. 'Duration']:SetShadowOffset(0, 0)

                    _G['TempEnchant' .. i .. 'Icon']:SetTexCoord(0.1, 0.9, 0.1, 0.9)
                end
            end
        end

        if getConfiguration().Chat then
        	for i = 1, NUM_CHAT_WINDOWS do
                _G['ChatFrame' .. i .. 'ButtonFrame']:Hide()
                _G['ChatFrame' .. i .. 'ButtonFrame']:SetScript('OnShow',
                    function(self)
                        self:Hide()
                    end
                )

                _G['ChatFrame' .. i .. 'ButtonFrame'].Show = function(self)
                end

                _G['ChatFrame' .. i .. 'EditBox']:Hide()
                _G['ChatFrame' .. i .. 'ResizeButton']:Hide()
                _G['ChatFrame' .. i .. 'ResizeButton']:SetScript('OnShow',
                    function(self)
                        self:Hide()
                    end
                )

                _G['ChatFrame' .. i .. 'ResizeButton'].Show = function(self)
                end
            end

            _G['ChatFrameMenuButton']:Hide()
            _G['ChatFrameMenuButton']:SetScript('OnShow',
                function(self)
                    self:Hide()
                end
            )

            _G['ChatFrameMenuButton'].Show = function(self)
            end

            _G['FriendsMicroButton']:Hide()
            _G['FriendsMicroButton']:SetScript('OnShow',
                function(self)
                    self:Hide()
                end
            )

            _G['FriendsMicroButton'].Show = function(self)
            end

            _G['GeneralDockManager']:Hide()
            _G['GeneralDockManager']:SetScript('OnShow',
                function(self)
                    self:Hide()
                end
            )

            _G['GeneralDockManager'].Show = function(self)
            end

            OriginalChatEdit_OnEscapePressed = ChatEdit_OnEscapePressed
            ChatEdit_OnEscapePressed = function(self)
            	OriginalChatEdit_OnEscapePressed(self)
            	self:Hide()
        	end

        	ChatFrame1:ClearAllPoints()
        	ChatFrame1:SetClampedToScreen(false)
        	ChatFrame1:SetFont([[Fonts\FRIZQT__.TTF]], 10)
        	ChatFrame1:SetPoint(getConfiguration().Chat.anchor, getConfiguration().Chat.x, getConfiguration().Chat.y)
        	ChatFrame1:SetSize(getConfiguration().Chat.width - 10, getConfiguration().Chat.height - 10)
        	ChatFrame1:SetUserPlaced(true)

        	ChatFrame1.backgroundBottom = ChatFrame1:CreateTexture(nil, 'LOW')
            ChatFrame1.backgroundBottom:SetPoint('BOTTOM', 0, -4)
            ChatFrame1.backgroundBottom:SetSize(getConfiguration().Chat.width - 2, 1)
            ChatFrame1.backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            ChatFrame1.backgroundLeft = ChatFrame1:CreateTexture(nil, 'LOW')
            ChatFrame1.backgroundLeft:SetPoint('LEFT', -4, 0)
            ChatFrame1.backgroundLeft:SetSize(1, getConfiguration().Chat.height - 4)
            ChatFrame1.backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            ChatFrame1.backgroundRight = ChatFrame1:CreateTexture(nil, 'LOW')
            ChatFrame1.backgroundRight:SetPoint('RIGHT', 4, 0)
            ChatFrame1.backgroundRight:SetSize(1, getConfiguration().Chat.height - 4)
            ChatFrame1.backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            ChatFrame1.backgroundTop = ChatFrame1:CreateTexture(nil, 'LOW')
            ChatFrame1.backgroundTop:SetPoint('TOP', 0, 4)
            ChatFrame1.backgroundTop:SetSize(getConfiguration().Chat.width - 2, 1)
            ChatFrame1.backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                
            ChatFrame1.borderBottom = ChatFrame1:CreateTexture(nil, 'BACKGROUND')
            ChatFrame1.borderBottom:SetPoint('BOTTOM', 0, -5)
            ChatFrame1.borderBottom:SetSize(getConfiguration().Chat.width, 3)
            ChatFrame1.borderBottom:SetTexture(0, 0, 0)

            ChatFrame1.borderLeft = ChatFrame1:CreateTexture(nil, 'BACKGROUND')
            ChatFrame1.borderLeft:SetPoint('LEFT', -5, 0)
            ChatFrame1.borderLeft:SetSize(3, getConfiguration().Chat.height - 2)
            ChatFrame1.borderLeft:SetTexture(0, 0, 0)

            ChatFrame1.borderRight = ChatFrame1:CreateTexture(nil, 'BACKGROUND')
            ChatFrame1.borderRight:SetPoint('RIGHT', 5, 0)
            ChatFrame1.borderRight:SetSize(3, getConfiguration().Chat.height - 2)
             ChatFrame1.borderRight:SetTexture(0, 0, 0)

            ChatFrame1.borderTop = ChatFrame1:CreateTexture(nil, 'BACKGROUND')
            ChatFrame1.borderTop:SetPoint('TOP', 0, 5)
            ChatFrame1.borderTop:SetSize(getConfiguration().Chat.width, 3)
            ChatFrame1.borderTop:SetTexture(0, 0, 0)

            ChatFrame1.innerBorder = ChatFrame1:CreateTexture(nil, 'BACKGROUND')
            ChatFrame1.innerBorder:SetPoint('TOPLEFT', -2, 2)
            ChatFrame1.innerBorder:SetSize(getConfiguration().Chat.width - 6, getConfiguration().Chat.height - 6)
            ChatFrame1.innerBorder:SetTexture(0, 0, 0, 0.5)

            ChatFrame1EditBox:SetPoint('TOPLEFT', ChatFrame1, 'TOPLEFT', -5, 6)
        end

        if getConfiguration().ExtraButton then
            extraButton = CreateFrame('Button', nil, UIParent)
            extraButton:RegisterForClicks('AnyUp')
            extraButton:SetPoint(getConfiguration().ExtraButton.anchor, getConfiguration().ExtraButton.x, getConfiguration().ExtraButton.y)
            extraButton:SetSize(getConfiguration().ExtraButton.width - 4, getConfiguration().ExtraButton.height - 4)
            extraButton:SetScript('OnClick',
                function(self)
                    if BuffFrame:IsShown() then
                        BuffFrame:Hide()
                        WatchFrame:Hide()
                        WorldStateAlwaysUpFrame:Hide()

                        if not getConfiguration().Raid.shown then
                            raidFrame:Hide()
                        end

                        self.Bar.text:SetText('Show Misc Frames')
                    else
                        BuffFrame:Show()
                        WatchFrame:Show()
                        WorldStateAlwaysUpFrame:Show()

                        if not getConfiguration().Raid.shown then
                            raidFrame:Show()
                        end

                        self.Bar.text:SetText('Hide Misc Frames')
                    end
                end
            )

            if getConfiguration().ExtraButton.hoverToShow then
                extraButton:SetAlpha(0)
                extraButton:SetScript('OnEnter',
                    function(self)
                        self:SetAlpha(1)
                    end
                )

                extraButton:SetScript('OnLeave',
                    function(self)
                        self:SetAlpha(0)
                    end
                )
            end

            extraButton.background = extraButton:CreateTexture(nil, 'LOW')
            extraButton.background:SetPoint('TOPLEFT', -1, 1)
            extraButton.background:SetSize(getConfiguration().ExtraButton.width - 2, getConfiguration().ExtraButton.height - 2)
            extraButton.background:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            extraButton.border = extraButton:CreateTexture(nil, 'BACKGROUND')
            extraButton.border:SetPoint('TOPLEFT', -2, 2)
            extraButton.border:SetSize(getConfiguration().ExtraButton.width, getConfiguration().ExtraButton.height)
            extraButton.border:SetTexture(0, 0, 0)

            extraButton.Bar = CreateFrame('StatusBar', nil, extraButton)
            extraButton.Bar:SetPoint('CENTER')
            extraButton.Bar:SetSize(getConfiguration().ExtraButton.width - 6, getConfiguration().ExtraButton.height - 6)
            extraButton.Bar:SetStatusBarTexture(Configuration.texture)
            extraButton.Bar:SetStatusBarColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            extraButton.Bar.border = extraButton.Bar:CreateTexture(nil, 'BACKGROUND')
            extraButton.Bar.border:SetPoint('TOPLEFT', -1, 1)
            extraButton.Bar.border:SetSize(getConfiguration().ExtraButton.width - 4, getConfiguration().ExtraButton.height - 4)
            extraButton.Bar.border:SetTexture(0, 0, 0)

            extraButton.Bar.text = extraButton.Bar:CreateFontString(nil, 'OVERLAY')
            extraButton.Bar.text.frequentUpdates = true
            extraButton.Bar.text:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
            extraButton.Bar.text:SetPoint('CENTER', 1, 0)
            extraButton.Bar.text:SetText('Show Misc Frames')
            extraButton.Bar.text:SetTextColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

        end

        if getConfiguration().Focus then
            focusFrame = self:Spawn('Focus')
            focusFrame:SetPoint(getConfiguration().Focus.anchor, getConfiguration().Focus.x, getConfiguration().Focus.y)
        end

        if getConfiguration().FocusTarget then
            focusTargetFrame = self:Spawn('FocusTarget')
            focusTargetFrame:SetPoint(getConfiguration().FocusTarget.anchor, getConfiguration().FocusTarget.x, getConfiguration().FocusTarget.y)
        end

        if getConfiguration().Minimap then
            MinimapCluster:Hide()

            minimapFrame = CreateFrame('Minimap', nil, UIParent)
            minimapFrame:SetMaskTexture([[Interface\Buttons\WHITE8X8]])
            minimapFrame:SetPoint(getConfiguration().Minimap.anchor, getConfiguration().Minimap.x, getConfiguration().Minimap.y)
            minimapFrame:SetSize(getConfiguration().Minimap.width - 6, getConfiguration().Minimap.height - 6)
            minimapFrame:SetScript('OnMouseWheel',
                function(self, zoom)
                    if zoom > 0 then
                        Minimap_ZoomIn()
                    else
                        Minimap_ZoomOut()
                    end
                end
            )

            minimapFrame.backgroundBottom = minimapFrame:CreateTexture(nil, 'LOW')
            minimapFrame.backgroundBottom:SetPoint('BOTTOM', 0, -2)
            minimapFrame.backgroundBottom:SetSize(getConfiguration().Minimap.width - 2, 1)
            minimapFrame.backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            minimapFrame.backgroundLeft = minimapFrame:CreateTexture(nil, 'LOW')
            minimapFrame.backgroundLeft:SetPoint('LEFT', -2, 0)
            minimapFrame.backgroundLeft:SetSize(1, getConfiguration().Minimap.height - 4)
            minimapFrame.backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            minimapFrame.backgroundRight = minimapFrame:CreateTexture(nil, 'LOW')
            minimapFrame.backgroundRight:SetPoint('RIGHT', 2, 0)
            minimapFrame.backgroundRight:SetSize(1, getConfiguration().Minimap.height - 4)
            minimapFrame.backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            minimapFrame.backgroundTop = minimapFrame:CreateTexture(nil, 'LOW')
            minimapFrame.backgroundTop:SetPoint('TOP', 0, 2)
            minimapFrame.backgroundTop:SetSize(getConfiguration().Minimap.width - 2, 1)
            minimapFrame.backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                
            minimapFrame.borderBottom = minimapFrame:CreateTexture(nil, 'BACKGROUND')
            minimapFrame.borderBottom:SetPoint('BOTTOM', 0, -3)
            minimapFrame.borderBottom:SetSize(getConfiguration().Minimap.width, 3)
            minimapFrame.borderBottom:SetTexture(0, 0, 0)

            minimapFrame.borderLeft = minimapFrame:CreateTexture(nil, 'BACKGROUND')
            minimapFrame.borderLeft:SetPoint('LEFT', -3, 0)
            minimapFrame.borderLeft:SetSize(3, getConfiguration().Minimap.height - 2)
            minimapFrame.borderLeft:SetTexture(0, 0, 0)

            minimapFrame.borderRight = minimapFrame:CreateTexture(nil, 'BACKGROUND')
            minimapFrame.borderRight:SetPoint('RIGHT', 3, 0)
            minimapFrame.borderRight:SetSize(3, getConfiguration().Minimap.height - 2)
            minimapFrame.borderRight:SetTexture(0, 0, 0)

            minimapFrame.borderTop = minimapFrame:CreateTexture(nil, 'BACKGROUND')
            minimapFrame.borderTop:SetPoint('TOP', 0, 3)
            minimapFrame.borderTop:SetSize(getConfiguration().Minimap.width, 3)
            minimapFrame.borderTop:SetTexture(0, 0, 0)

            if getConfiguration().Minimap.Calender then
                GameTimeFrame:ClearAllPoints()
                GameTimeFrame:SetParent(minimapFrame)
                GameTimeFrame:SetPoint(getConfiguration().Minimap.Calender.anchor, getConfiguration().Minimap.Calender.x, getConfiguration().Minimap.Calender.y)
                GameTimeFrame:SetSize(32, 32)

                GameTimeFrame.text = GameTimeFrame:CreateFontString(nil, 'OVERLAY')
                GameTimeFrame.text:SetFont([[Fonts\FRIZQT__.TTF]], Configuration.Font.size)
                GameTimeFrame.text:SetPoint('CENTER', 0, -2)
                GameTimeFrame.text:SetTextColor(0, 0, 0)

                GameTimeFrame_SetDate = function(self)
                    _, _, day = CalendarGetDate()
                    GameTimeFrame.text:SetText(day)
                end

                GameTimeFrame:SetText(nil)
            end

            if getConfiguration().Minimap.Clock then
                TimeManagerClockButton:ClearAllPoints()
                TimeManagerClockButton:GetRegions():Hide()
                TimeManagerClockButton:SetParent(minimapFrame)
                TimeManagerClockButton:SetPoint(getConfiguration().Minimap.Clock.anchor, getConfiguration().Minimap.Clock.x, getConfiguration().Minimap.Clock.y)
                TimeManagerClockButton:SetSize(TimeManagerClockTicker:GetWidth(), TimeManagerClockTicker:GetHeight())

                TimeManagerClockTicker:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                TimeManagerClockTicker:SetPoint('CENTER', TimeManagerClockButton)
                TimeManagerClockTicker:SetShadowOffset(0, 0)
            end

            if getConfiguration().Minimap.MailButton then
                MiniMapMailBorder:Hide()
                MiniMapMailFrame:ClearAllPoints()
                MiniMapMailFrame:SetParent(minimapFrame)
                MiniMapMailFrame:SetPoint(getConfiguration().Minimap.MailButton.anchor, getConfiguration().Minimap.MailButton.x, getConfiguration().Minimap.MailButton.y)
                MiniMapMailIcon:SetTexture([[Interface\Minimap\Tracking\Mailbox]])
            end

            if getConfiguration().Minimap.TrackingButton then
                MiniMapTracking:ClearAllPoints()
                MiniMapTracking:SetParent(minimapFrame)
                MiniMapTracking:SetPoint(getConfiguration().Minimap.TrackingButton.anchor, getConfiguration().Minimap.TrackingButton.x, getConfiguration().Minimap.TrackingButton.y)
                MiniMapTrackingBackground:Hide()
                MiniMapTrackingButtonBorder:Hide()
                MiniMapTrackingIconOverlay:SetTexture(nil)
            end

            if getConfiguration().Minimap.QueueStatusButton then
                QueueStatusMinimapButton:ClearAllPoints()
                QueueStatusMinimapButton:SetParent(minimapFrame)
                QueueStatusMinimapButton:SetPoint(getConfiguration().Minimap.QueueStatusButton.anchor, getConfiguration().Minimap.QueueStatusButton.x, getConfiguration().Minimap.QueueStatusButton.y)
                QueueStatusMinimapButtonBorder:Hide()
            end
        end

        if getConfiguration().Pet then
            petFrame = self:Spawn('Pet')
            petFrame:SetPoint(getConfiguration().Pet.anchor, getConfiguration().Pet.x, getConfiguration().Pet.y)
        end

        if getConfiguration().Player then
            playerFrame = self:Spawn('Player')
            playerFrame:SetPoint(getConfiguration().Player.anchor, getConfiguration().Player.x, getConfiguration().Player.y)
        end

        if getConfiguration().Raid then
            raidFrame = self:SpawnHeader(nil, nil, nil,
                'columnAnchorPoint', getConfiguration().Raid.columnAnchor,
                'columnSpacing', getConfiguration().Raid.columnSpacing,
                'groupBy', getConfiguration().Raid.groupBy,
                'groupingOrder', getConfiguration().Raid.groupOrder,
                'maxColumns', getConfiguration().Raid.columns,
                'showParty', getConfiguration().Raid.showParty,
                'showPlayer', getConfiguration().Raid.showPlayer,
                'showRaid', getConfiguration().Raid.showRaid,
                'showSolo', getConfiguration().Raid.showSolo,
                'unitsPerColumn', getConfiguration().Raid.rows,
                'xOffset', getConfiguration().Raid.columnX,
                'yOffset', getConfiguration().Raid.columnY
            )

            raidFrame:SetPoint(getConfiguration().Raid.anchor, getConfiguration().Raid.x, getConfiguration().Raid.y)

            if getConfiguration().Raid.shown then
                raidFrame:Show()
            else
                raidFrame:Hide()
            end
        end

        if getConfiguration().Target then
            targetFrame = self:Spawn('Target')
            targetFrame:SetPoint(getConfiguration().Target.anchor, getConfiguration().Target.x, getConfiguration().Target.y)
        end

        if getConfiguration().TargetTarget then
            targetTargetFrame = self:Spawn('TargetTarget')
            targetTargetFrame:SetPoint(getConfiguration().TargetTarget.anchor, getConfiguration().TargetTarget.x, getConfiguration().TargetTarget.y)
        end
    end
)
