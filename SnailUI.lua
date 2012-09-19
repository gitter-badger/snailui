-- Snail.lua
-- Written by Snail

class = select(2, UnitClass('Player'))
version = '0.2.1'

-- Functions

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

-- Tags

oUF.Tags.Events['SnailUI:Health'] = 'UNIT_HEALTH UNIT_HEAL_PREDICTION'
oUF.Tags.Methods['SnailUI:Health'] = function(unit)
    health = trim(GetUnitName(unit, false))

    if InCombatLockdown() or (math.floor(((UnitHealth(unit) / UnitHealthMax(unit)) * 100) + 0.5) < 100) then
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

-- Layout

oUF:Factory(
    function(self)
         category = CreateFrame('Frame', nil, UIParent)
         category.name = 'SnailUI'

         category.label1 = category:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
        category.label1:SetPoint('TOPLEFT', 16, -16)
        category.label1:SetText('SnailUI ' .. version)

        category.label2 = category:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
        category.label2:SetPoint('TOPLEFT', 16, -36)
        category.label2:SetText('Snail\'s minimalistic UI.')

        generalSubcategory = CreateFrame('Frame', nil, category)
         generalSubcategory.name = 'General'
         generalSubcategory.parent = category.name

        generalSubcategory.label1 = generalSubcategory:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
        generalSubcategory.label1:SetPoint('TOPLEFT', 16, -16)
        generalSubcategory.label1:SetText('General')

        generalSubcategory.label2 = generalSubcategory:CreateFontString(nil, 'OVERLAY', 'GameFontHighlight')
        generalSubcategory.label2:SetPoint('TOPLEFT', 16, -36)
        generalSubcategory.label2:SetText('General options for SnailUI.')

         InterfaceOptions_AddCategory(category)
         InterfaceOptions_AddCategory(generalSubcategory)

        SlashCmdList['SnailUI'] = function(command)
            InterfaceOptionsFrame_OpenToCategory(category)
        end

        SLASH_SnailUI1 = '/SnailUI'
        SLASH_SnailUI2 = '/SUI'

        UIErrorsFrame:Hide()

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

        if Configuration.ActionBars then
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

            if not Configuration.ActionBars.Pet then
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

            if Configuration.ActionBars.Pet then
                if Configuration.ActionBars.Pet.buttons < NUM_PET_ACTION_SLOTS then
                    for i = (Configuration.ActionBars.Pet.buttons + 1), NUM_PET_ACTION_SLOTS do
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
                PetActionBarFrame:SetSize((Configuration.ActionBars.Pet.buttons * Configuration.ActionBars.Pet.width) + ((Configuration.ActionBars.Pet.buttons - 1) * 4), Configuration.ActionBars.Pet.height)
                PetActionBarFrame:SetPoint(Configuration.ActionBars.Pet.anchor, Configuration.ActionBars.Pet.x, Configuration.ActionBars.Pet.y)
                PetActionBarFrame.SetPoint = function(self)
                end

                for i = 1, Configuration.ActionBars.Pet.buttons do
                    _G['PetActionButton' .. i]:ClearAllPoints()
                    _G['PetActionButton' .. i]:SetNormalTexture(nil)
                    _G['PetActionButton' .. i]:SetPoint('LEFT', ((i - 1) * Configuration.ActionBars.Pet.width) + ((i - 1) * 4) + 3, 0)
                    _G['PetActionButton' .. i]:SetSize(Configuration.ActionBars.Pet.width - 6, Configuration.ActionBars.Pet.height - 6)
                    _G['PetActionButton' .. i .. 'Icon']:SetTexCoord(Configuration.ActionBars.Pet.TextureCoordinate.left, Configuration.ActionBars.Pet.TextureCoordinate.right, Configuration.ActionBars.Pet.TextureCoordinate.top, Configuration.ActionBars.Pet.TextureCoordinate.bottom)

                    _G['PetActionButton' .. i].SetNormalTexture = function(self)
                    end

                    _G['PetActionButton' .. i].backgroundBottom = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].backgroundBottom:SetPoint('BOTTOM', 0, -2)
                    _G['PetActionButton' .. i].backgroundBottom:SetSize(Configuration.ActionBars.Pet.width - 2, 1)
                    _G['PetActionButton' .. i].backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    _G['PetActionButton' .. i].backgroundLeft = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].backgroundLeft:SetPoint('LEFT', -2, 0)
                    _G['PetActionButton' .. i].backgroundLeft:SetSize(1, Configuration.ActionBars.Pet.height - 4)
                    _G['PetActionButton' .. i].backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    _G['PetActionButton' .. i].backgroundRight = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].backgroundRight:SetPoint('RIGHT', 2, 0)
                    _G['PetActionButton' .. i].backgroundRight:SetSize(1, Configuration.ActionBars.Pet.height - 4)
                    _G['PetActionButton' .. i].backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    _G['PetActionButton' .. i].backgroundTop = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].backgroundTop:SetPoint('TOP', 0, 2)
                    _G['PetActionButton' .. i].backgroundTop:SetSize(Configuration.ActionBars.Pet.width - 2, 1)
                    _G['PetActionButton' .. i].backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                    
                    _G['PetActionButton' .. i].borderBottom = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].borderBottom:SetPoint('BOTTOM', 0, -3)
                    _G['PetActionButton' .. i].borderBottom:SetSize(Configuration.ActionBars.Pet.width, 3)
                    _G['PetActionButton' .. i].borderBottom:SetTexture(0, 0, 0)

                    _G['PetActionButton' .. i].borderLeft = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].borderLeft:SetPoint('LEFT', -3, 0)
                    _G['PetActionButton' .. i].borderLeft:SetSize(3, Configuration.ActionBars.Pet.height - 2)
                    _G['PetActionButton' .. i].borderLeft:SetTexture(0, 0, 0)

                    _G['PetActionButton' .. i].borderRight = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].borderRight:SetPoint('RIGHT', 3, 0)
                    _G['PetActionButton' .. i].borderRight:SetSize(3, Configuration.ActionBars.Pet.height - 2)
                    _G['PetActionButton' .. i].borderRight:SetTexture(0, 0, 0)

                    _G['PetActionButton' .. i].borderTop = _G['PetActionButton' .. i]:CreateTexture(nil, 'LOW')
                    _G['PetActionButton' .. i].borderTop:SetPoint('TOP', 0, 3)
                    _G['PetActionButton' .. i].borderTop:SetSize(Configuration.ActionBars.Pet.width, 3)
                    _G['PetActionButton' .. i].borderTop:SetTexture(0, 0, 0)

                    _G['PetActionButton' .. i .. 'AutoCastable']:SetAlpha(0)
                    _G['PetActionButton' .. i .. 'Shine']:SetAllPoints(_G['PetActionButton' .. i])
                end
            end

            if Configuration.ActionBars.Player.buttons < NUM_ACTIONBAR_BUTTONS then
                for i = (Configuration.ActionBars.Player.buttons + 1), NUM_ACTIONBAR_BUTTONS do
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
            MainMenuBar:SetSize((Configuration.ActionBars.Player.buttons * Configuration.ActionBars.Player.width) + ((Configuration.ActionBars.Player.buttons - 1) * 4), Configuration.ActionBars.Player.height)
            MainMenuBar:SetPoint(Configuration.ActionBars.Player.anchor, Configuration.ActionBars.Player.x, Configuration.ActionBars.Player.y)

            for i = 1, Configuration.ActionBars.Player.buttons do
                _G['ActionButton' .. i]:ClearAllPoints()
                _G['ActionButton' .. i]:SetNormalTexture(nil)
                _G['ActionButton' .. i]:SetPoint('LEFT', ((i - 1) * Configuration.ActionBars.Player.width) + ((i - 1) * 4) + 3, 0)
                _G['ActionButton' .. i]:SetSize(Configuration.ActionBars.Player.width - 6, Configuration.ActionBars.Player.height - 6)
                _G['ActionButton' .. i .. 'Icon']:SetTexCoord(Configuration.ActionBars.Player.TextureCoordinate.left, Configuration.ActionBars.Player.TextureCoordinate.right, Configuration.ActionBars.Player.TextureCoordinate.top, Configuration.ActionBars.Player.TextureCoordinate.bottom)

                _G['ActionButton' .. i].backgroundBottom = _G['ActionButton' .. i]:CreateTexture(nil, 'LOW')
                _G['ActionButton' .. i].backgroundBottom:SetPoint('BOTTOM', 0, -2)
                _G['ActionButton' .. i].backgroundBottom:SetSize(Configuration.ActionBars.Player.width - 2, 1)
                _G['ActionButton' .. i].backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                _G['ActionButton' .. i].backgroundLeft = _G['ActionButton' .. i]:CreateTexture(nil, 'LOW')
                _G['ActionButton' .. i].backgroundLeft:SetPoint('LEFT', -2, 0)
                _G['ActionButton' .. i].backgroundLeft:SetSize(1, Configuration.ActionBars.Player.height - 4)
                _G['ActionButton' .. i].backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                _G['ActionButton' .. i].backgroundRight = _G['ActionButton' .. i]:CreateTexture(nil, 'LOW')
                _G['ActionButton' .. i].backgroundRight:SetPoint('RIGHT', 2, 0)
                _G['ActionButton' .. i].backgroundRight:SetSize(1, Configuration.ActionBars.Player.height - 4)
                _G['ActionButton' .. i].backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                _G['ActionButton' .. i].backgroundTop = _G['ActionButton' .. i]:CreateTexture(nil, 'LOW')
                _G['ActionButton' .. i].backgroundTop:SetPoint('TOP', 0, 2)
                _G['ActionButton' .. i].backgroundTop:SetSize(Configuration.ActionBars.Player.width - 2, 1)
                _G['ActionButton' .. i].backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                
                _G['ActionButton' .. i].borderBottom = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                _G['ActionButton' .. i].borderBottom:SetPoint('BOTTOM', 0, -3)
                _G['ActionButton' .. i].borderBottom:SetSize(Configuration.ActionBars.Player.width, 3)
                _G['ActionButton' .. i].borderBottom:SetTexture(0, 0, 0)

                _G['ActionButton' .. i].borderLeft = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                _G['ActionButton' .. i].borderLeft:SetPoint('LEFT', -3, 0)
                _G['ActionButton' .. i].borderLeft:SetSize(3, Configuration.ActionBars.Player.height - 2)
                _G['ActionButton' .. i].borderLeft:SetTexture(0, 0, 0)

                _G['ActionButton' .. i].borderRight = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                _G['ActionButton' .. i].borderRight:SetPoint('RIGHT', 3, 0)
                _G['ActionButton' .. i].borderRight:SetSize(3, Configuration.ActionBars.Player.height - 2)
                _G['ActionButton' .. i].borderRight:SetTexture(0, 0, 0)

                _G['ActionButton' .. i].borderTop = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
                _G['ActionButton' .. i].borderTop:SetPoint('TOP', 0, 3)
                _G['ActionButton' .. i].borderTop:SetSize(Configuration.ActionBars.Player.width, 3)
                _G['ActionButton' .. i].borderTop:SetTexture(0, 0, 0)

                _G['ActionButton' .. i .. 'Count']:SetAlpha(0)
                _G['ActionButton' .. i .. 'Border']:SetAlpha(0)
                _G['ActionButton' .. i .. 'Border'].SetVertexColor = function(self)
                end

                _G['ActionButton' .. i .. 'FlyoutBorder']:SetAlpha(0)
                _G['ActionButton' .. i .. 'FlyoutBorderShadow']:SetAlpha(0)
                _G['ActionButton' .. i .. 'HotKey']:SetAlpha(0)
                _G['ActionButton' .. i .. 'Name']:SetAlpha(0)
            end
        end

        if Configuration.Chat then
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
        	ChatFrame1:SetPoint(Configuration.Chat.anchor, Configuration.Chat.x, Configuration.Chat.y)
        	ChatFrame1:SetSize(Configuration.Chat.width - 10, Configuration.Chat.height - 10)
        	ChatFrame1:SetUserPlaced(true)

        	ChatFrame1.backgroundBottom = ChatFrame1:CreateTexture(nil, 'LOW')
            ChatFrame1.backgroundBottom:SetPoint('BOTTOM', 0, -4)
            ChatFrame1.backgroundBottom:SetSize(Configuration.Chat.width - 2, 1)
            ChatFrame1.backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            ChatFrame1.backgroundLeft = ChatFrame1:CreateTexture(nil, 'LOW')
            ChatFrame1.backgroundLeft:SetPoint('LEFT', -4, 0)
            ChatFrame1.backgroundLeft:SetSize(1, Configuration.Chat.height - 4)
            ChatFrame1.backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            ChatFrame1.backgroundRight = ChatFrame1:CreateTexture(nil, 'LOW')
            ChatFrame1.backgroundRight:SetPoint('RIGHT', 4, 0)
            ChatFrame1.backgroundRight:SetSize(1, Configuration.Chat.height - 4)
            ChatFrame1.backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            ChatFrame1.backgroundTop = ChatFrame1:CreateTexture(nil, 'LOW')
            ChatFrame1.backgroundTop:SetPoint('TOP', 0, 4)
            ChatFrame1.backgroundTop:SetSize(Configuration.Chat.width - 2, 1)
            ChatFrame1.backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                
            ChatFrame1.borderBottom = ChatFrame1:CreateTexture(nil, 'BACKGROUND')
            ChatFrame1.borderBottom:SetPoint('BOTTOM', 0, -5)
            ChatFrame1.borderBottom:SetSize(Configuration.Chat.width, 3)
            ChatFrame1.borderBottom:SetTexture(0, 0, 0)

            ChatFrame1.borderLeft = ChatFrame1:CreateTexture(nil, 'BACKGROUND')
            ChatFrame1.borderLeft:SetPoint('LEFT', -5, 0)
            ChatFrame1.borderLeft:SetSize(3, Configuration.Chat.height - 2)
            ChatFrame1.borderLeft:SetTexture(0, 0, 0)

            ChatFrame1.borderRight = ChatFrame1:CreateTexture(nil, 'BACKGROUND')
            ChatFrame1.borderRight:SetPoint('RIGHT', 5, 0)
            ChatFrame1.borderRight:SetSize(3, Configuration.Chat.height - 2)
             ChatFrame1.borderRight:SetTexture(0, 0, 0)

            ChatFrame1.borderTop = ChatFrame1:CreateTexture(nil, 'BACKGROUND')
            ChatFrame1.borderTop:SetPoint('TOP', 0, 5)
            ChatFrame1.borderTop:SetSize(Configuration.Chat.width, 3)
            ChatFrame1.borderTop:SetTexture(0, 0, 0)

            ChatFrame1EditBox:SetPoint('TOPLEFT', ChatFrame1, 'TOPLEFT', -5, 6)
        end

        if Configuration.Focus then
            focusFrame = self:Spawn('Focus')
            focusFrame:SetPoint(Configuration.Focus.anchor, Configuration.Focus.x, Configuration.Focus.y)
        end

        if Configuration.FocusTarget then
            focusTargetFrame = self:Spawn('FocusTarget')
            focusTargetFrame:SetPoint(Configuration.FocusTarget.anchor, Configuration.FocusTarget.x, Configuration.FocusTarget.y)
        end

        if Configuration.Minimap then
            MinimapCluster:Hide()

            minimapFrame = CreateFrame('Minimap', nil, UIParent)
            minimapFrame:SetFrameStrata('HIGH')
            minimapFrame:SetMaskTexture([[Interface\Buttons\WHITE8X8]])
            minimapFrame:SetPoint(Configuration.Minimap.anchor, Configuration.Minimap.x, Configuration.Minimap.y)
            minimapFrame:SetSize(Configuration.Minimap.width - 6, Configuration.Minimap.height - 6)

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
            minimapFrame.backgroundBottom:SetSize(Configuration.Minimap.width - 2, 1)
            minimapFrame.backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            minimapFrame.backgroundLeft = minimapFrame:CreateTexture(nil, 'LOW')
            minimapFrame.backgroundLeft:SetPoint('LEFT', -2, 0)
            minimapFrame.backgroundLeft:SetSize(1, Configuration.Minimap.height - 4)
            minimapFrame.backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            minimapFrame.backgroundRight = minimapFrame:CreateTexture(nil, 'LOW')
            minimapFrame.backgroundRight:SetPoint('RIGHT', 2, 0)
            minimapFrame.backgroundRight:SetSize(1, Configuration.Minimap.height - 4)
            minimapFrame.backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

            minimapFrame.backgroundTop = minimapFrame:CreateTexture(nil, 'LOW')
            minimapFrame.backgroundTop:SetPoint('TOP', 0, 2)
            minimapFrame.backgroundTop:SetSize(Configuration.Minimap.width - 2, 1)
            minimapFrame.backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                
            minimapFrame.borderBottom = minimapFrame:CreateTexture(nil, 'BACKGROUND')
            minimapFrame.borderBottom:SetPoint('BOTTOM', 0, -3)
            minimapFrame.borderBottom:SetSize(Configuration.Minimap.width, 3)
            minimapFrame.borderBottom:SetTexture(0, 0, 0)

            minimapFrame.borderLeft = minimapFrame:CreateTexture(nil, 'BACKGROUND')
            minimapFrame.borderLeft:SetPoint('LEFT', -3, 0)
            minimapFrame.borderLeft:SetSize(3, Configuration.Minimap.height - 2)
            minimapFrame.borderLeft:SetTexture(0, 0, 0)

            minimapFrame.borderRight = minimapFrame:CreateTexture(nil, 'BACKGROUND')
            minimapFrame.borderRight:SetPoint('RIGHT', 3, 0)
            minimapFrame.borderRight:SetSize(3, Configuration.Minimap.height - 2)
            minimapFrame.borderRight:SetTexture(0, 0, 0)

            minimapFrame.borderTop = minimapFrame:CreateTexture(nil, 'BACKGROUND')
            minimapFrame.borderTop:SetPoint('TOP', 0, 3)
            minimapFrame.borderTop:SetSize(Configuration.Minimap.width, 3)
            minimapFrame.borderTop:SetTexture(0, 0, 0)

            if Configuration.Minimap.Clock then
                TimeManagerClockButton:ClearAllPoints()
                TimeManagerClockButton:GetRegions():Hide()
                TimeManagerClockButton:SetParent(minimapFrame)
                TimeManagerClockButton:SetPoint(Configuration.Minimap.Clock.anchor, Configuration.Minimap.Clock.x, Configuration.Minimap.Clock.y)
                TimeManagerClockTicker:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                TimeManagerClockButton:SetSize(TimeManagerClockTicker:GetWidth(), TimeManagerClockTicker:GetHeight())
                TimeManagerClockTicker:SetPoint('CENTER', TimeManagerClockButton)
                TimeManagerClockTicker:SetShadowOffset(0, 0)
            end

            if Configuration.Minimap.MailButton then
                MiniMapMailBorder:Hide()
                MiniMapMailFrame:ClearAllPoints()
                MiniMapMailFrame:SetParent(minimapFrame)
                MiniMapMailFrame:SetPoint(Configuration.Minimap.MailButton.anchor, Configuration.Minimap.MailButton.x, Configuration.Minimap.MailButton.y)
                MiniMapMailIcon:SetTexture([[Interface\Minimap\Tracking\Mailbox]])
            end

            if Configuration.Minimap.TrackingButton then
                MiniMapTracking:ClearAllPoints()
                MiniMapTracking:SetParent(minimapFrame)
                MiniMapTracking:SetPoint(Configuration.Minimap.TrackingButton.anchor, Configuration.Minimap.TrackingButton.x, Configuration.Minimap.TrackingButton.y)
                MiniMapTrackingBackground:Hide()
                MiniMapTrackingButtonBorder:Hide()
                MiniMapTrackingIconOverlay:SetTexture(nil)
            end

            if Configuration.Minimap.QueueStatusButton then
                QueueStatusMinimapButton:ClearAllPoints()
                QueueStatusMinimapButton:SetParent(minimapFrame)
                QueueStatusMinimapButton:SetPoint(Configuration.Minimap.QueueStatusButton.anchor, Configuration.Minimap.QueueStatusButton.x, Configuration.Minimap.QueueStatusButton.y)
                QueueStatusMinimapButtonBorder:Hide()
            end
        end

        if Configuration.Pet then
            petFrame = self:Spawn('Pet')
            petFrame:SetPoint(Configuration.Pet.anchor, Configuration.Pet.x, Configuration.Pet.y)
        end

        if Configuration.Player then
            playerFrame = self:Spawn('Player')
            playerFrame:SetPoint(Configuration.Player.anchor, Configuration.Player.x, Configuration.Player.y)
        end

        if Configuration.Raid then
            raidFrame = self:SpawnHeader(nil, nil, nil,
                'columnAnchorPoint', Configuration.Raid.columnAnchor,
                'columnSpacing', Configuration.Raid.columnSpacing,
                'groupBy', Configuration.Raid.groupBy,
                'groupingOrder', Configuration.Raid.groupOrder,
                'maxColumns', Configuration.Raid.columns,
                'showParty', Configuration.Raid.showParty,
                'showPlayer', Configuration.Raid.showPlayer,
                'showRaid', Configuration.Raid.showRaid,
                'showSolo', Configuration.Raid.showSolo,
                'unitsPerColumn', Configuration.Raid.rows,
                'xOffset', Configuration.Raid.columnX,
                'yOffset', Configuration.Raid.columnY
            )

            raidFrame:SetPoint(Configuration.Raid.anchor, Configuration.Raid.x, Configuration.Raid.y)
            raidFrame:Show()
        end

        if Configuration.Target then
            targetFrame = self:Spawn('Target')
            targetFrame:SetPoint(Configuration.Target.anchor, Configuration.Target.x, Configuration.Target.y)
        end

        if Configuration.TargetTarget then
            targetTargetFrame = self:Spawn('TargetTarget')
            targetTargetFrame:SetPoint(Configuration.TargetTarget.anchor, Configuration.TargetTarget.x, Configuration.TargetTarget.y)
        end
    end
)

oUF:RegisterStyle('SnailUI', 
    function(self, unit)
        unit = unit:gsub('(.)', string.upper, 1)
        
        if Configuration[unit] then            
            self.frame = unit
            self.menu = function(self)
                ToggleDropDownMenu(1, nil, _G[self.unit:gsub('(.)', string.upper, 1) .. 'FrameDropDown'], self, 0, 0)
            end

            self.background = self:CreateTexture(nil, 'LOW')
            self.background:SetPoint('TOPLEFT', 1, -1)
            self.background:SetSize(Configuration[self.frame].width - 2, Configuration[self.frame].height - 2)

            self.border = self:CreateTexture(nil, 'BACKGROUND')
            self.border:SetPoint('TOPLEFT')
            self.border:SetSize(Configuration[self.frame].width, Configuration[self.frame].height)
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

                if UnitThreatSituation(self.unit) and (self.frame == 'Raid') and Configuration[self.frame].colorByThreatLevel then
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

                            if Configuration[self.frame].healthThreshold then
                                if math.floor(((UnitHealth(self.unit) / UnitHealthMax(self.unit)) * 100) + 0.5) >= Configuration[self.frame].healthThreshold then
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
            self:SetSize(Configuration[self.frame].width, Configuration[self.frame].height)

            if Configuration[self.frame].healthThreshold then
                self:RegisterEvent('UNIT_HEALTH',
                    function(self)
                        self:SetAlpha(Configuration.inactiveAlpha)

                        if math.floor(((UnitHealth(self.unit) / UnitHealthMax(self.unit)) * 100) + 0.5) < Configuration[self.frame].healthThreshold then
                            if self.inRange then
                                self:SetAlpha(1)
                            end
                        end
                    end
                )
            end

            if Configuration[self.frame].BurningEmbersBar and (unit == 'Player') then
                if select(2, UnitClass(unit)) == 'WARLOCK' then
                    self.WarlockSpecBars = CreateFrame('Frame', nil, self)
                    self.WarlockSpecBars:SetPoint(Configuration[self.frame].BurningEmbersBar.anchor, Configuration[self.frame].BurningEmbersBar.x, Configuration[self.frame].BurningEmbersBar.y)
                    self.WarlockSpecBars:SetSize(Configuration[self.frame].BurningEmbersBar.width - 2, Configuration[self.frame].BurningEmbersBar.height - 2)

                    self.warlockSpecBarsBackground = self:CreateTexture(nil, 'BACKGROUND')
                    self.warlockSpecBarsBackground:SetPoint('TOPLEFT', self.WarlockSpecBars)
                    self.warlockSpecBarsBackground:SetSize(Configuration[self.frame].BurningEmbersBar.width - 2, Configuration[self.frame].BurningEmbersBar.height - 2)

                    self.warlockSpecBarsBorder = self:CreateTexture(nil, 'BACKGROUND')
                    self.warlockSpecBarsBorder:SetPoint('TOPLEFT', self.WarlockSpecBars, -1, 1)
                    self.warlockSpecBarsBorder:SetSize(Configuration[self.frame].BurningEmbersBar.width, Configuration[self.frame].BurningEmbersBar.height)
                    self.warlockSpecBarsBorder:SetTexture(0, 0, 0)

                    for i = 1, #Configuration[self.frame].BurningEmbersBar do
                        self.WarlockSpecBars[i] = CreateFrame('StatusBar', nil, self)
                        self.WarlockSpecBars[i]:SetPoint(Configuration[self.frame].BurningEmbersBar[i].anchor, self.WarlockSpecBars, Configuration[self.frame].BurningEmbersBar[i].x, Configuration[self.frame].BurningEmbersBar[i].y)
                        self.WarlockSpecBars[i]:SetSize(Configuration[self.frame].BurningEmbersBar[i].width - 2, Configuration[self.frame].BurningEmbersBar[i].height - 2)
                        self.WarlockSpecBars[i]:SetStatusBarTexture(Configuration.texture)

                        self.warlockSpecBarsBorder[i] = self:CreateTexture(nil, 'LOW')
                        self.warlockSpecBarsBorder[i]:SetPoint('TOPLEFT', self.WarlockSpecBars[i], -1, 1)
                        self.warlockSpecBarsBorder[i]:SetSize(Configuration[self.frame].BurningEmbersBar[i].width, Configuration[self.frame].BurningEmbersBar[i].height)
                        self.warlockSpecBarsBorder[i]:SetTexture(0, 0, 0)
                    end
                end
            end

            if Configuration[self.frame].CastingBar then
                self.Castbar = CreateFrame('StatusBar', nil, self)
                self.Castbar:SetOrientation(Configuration[self.frame].CastingBar.orientation)
                self.Castbar:SetPoint(Configuration[self.frame].CastingBar.anchor, Configuration[self.frame].CastingBar.x, Configuration[self.frame].CastingBar.y)
                self.Castbar:SetSize(Configuration[self.frame].CastingBar.width - 6, Configuration[self.frame].CastingBar.height - 6)
                self.Castbar:SetStatusBarTexture(Configuration.texture)

                self.Castbar.backgroundBottom = self.Castbar:CreateTexture(nil, 'LOW')
                self.Castbar.backgroundBottom:SetPoint('BOTTOM', 0, -2)
                self.Castbar.backgroundBottom:SetSize(Configuration[self.frame].CastingBar.width - 2, 1)
                self.Castbar.backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                self.Castbar.backgroundLeft = self.Castbar:CreateTexture(nil, 'LOW')
                self.Castbar.backgroundLeft:SetPoint('LEFT', -2, 0)
                self.Castbar.backgroundLeft:SetSize(1, Configuration[self.frame].CastingBar.height - 4)
                self.Castbar.backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                self.Castbar.backgroundRight = self.Castbar:CreateTexture(nil, 'LOW')
                self.Castbar.backgroundRight:SetPoint('RIGHT', 2, 0)
                self.Castbar.backgroundRight:SetSize(1, Configuration[self.frame].CastingBar.height - 4)
                self.Castbar.backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                self.Castbar.backgroundTop = self.Castbar:CreateTexture(nil, 'LOW')
                self.Castbar.backgroundTop:SetPoint('TOP', 0, 2)
                self.Castbar.backgroundTop:SetSize(Configuration[self.frame].CastingBar.width - 2, 1)
                self.Castbar.backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                
                self.Castbar.border = self.Castbar:CreateTexture(nil, 'BACKGROUND')
                self.Castbar.border:SetPoint('TOPLEFT', -3, 3)
                self.Castbar.border:SetSize(Configuration[self.frame].CastingBar.width, Configuration[self.frame].CastingBar.height)
                self.Castbar.border:SetTexture(0, 0, 0)
            end

            if Configuration[self.frame].ComboPointsBar and (unit == 'Player') then
                if select(2, UnitClass(unit)) == 'ROGUE' then
                    self.CPoints = CreateFrame('Frame', nil, self)
                    self.CPoints:SetPoint(Configuration[self.frame].ComboPointsBar.anchor, Configuration[self.frame].ComboPointsBar.x, Configuration[self.frame].ComboPointsBar.y)
                    self.CPoints:SetSize(Configuration[self.frame].ComboPointsBar.width - 2, Configuration[self.frame].ComboPointsBar.height - 2)

                    self.CPoints.background = self.CPoints:CreateTexture(nil, 'BACKGROUND')
                    self.CPoints.background:SetPoint('TOPLEFT')
                    self.CPoints.background:SetSize(Configuration[self.frame].ComboPointsBar.width - 2, Configuration[self.frame].ComboPointsBar.height - 2)

                    self.CPoints.border = self.CPoints:CreateTexture(nil, 'BACKGROUND')
                    self.CPoints.border:SetPoint('TOPLEFT', -1, 1)
                    self.CPoints.border:SetSize(Configuration[self.frame].ComboPointsBar.width, Configuration[self.frame].ComboPointsBar.height)
                    self.CPoints.border:SetTexture(0, 0, 0)

                    for i = 1, #Configuration[self.frame].ComboPointsBar do
                        self.CPoints[i] = CreateFrame('StatusBar', nil, self)
                        self.CPoints[i]:SetPoint(Configuration[self.frame].ComboPointsBar[i].anchor, self.CPoints, Configuration[self.frame].ComboPointsBar[i].x, Configuration[self.frame].ComboPointsBar[i].y)
                        self.CPoints[i]:SetSize(Configuration[self.frame].ComboPointsBar[i].width - 2, Configuration[self.frame].ComboPointsBar[i].height - 2)
                        self.CPoints[i]:SetStatusBarTexture(Configuration.texture)

                        self.CPoints[i].border = self.CPoints:CreateTexture(nil, 'LOW')
                        self.CPoints[i].border:SetPoint('TOPLEFT', self.CPoints[i], -1, 1)
                        self.CPoints[i].border:SetSize(Configuration[self.frame].ComboPointsBar[i].width, Configuration[self.frame].ComboPointsBar[i].height)
                        self.CPoints[i].border:SetTexture(0, 0, 0)
                    end
                end
            end

            if Configuration[self.frame].HealthBar then
                self:RegisterEvent('UNIT_HEAL_PREDICTION',
                    function(self)
                        self.HealPrediction.myBar:SetAlpha(self:GetAlpha() / 2)
                        self.HealPrediction.otherBar:SetAlpha(self:GetAlpha() / 2)
                    end
                )

                self.Health = CreateFrame('StatusBar', nil, self)
                self.Health.frequentUpdates = true
                self.Health:SetPoint(Configuration[self.frame].HealthBar.anchor, Configuration[self.frame].HealthBar.x, Configuration[self.frame].HealthBar.y)
                self.Health:SetSize(Configuration[self.frame].HealthBar.width - 2, Configuration[self.frame].HealthBar.height - 2)
                self.Health:SetStatusBarTexture(Configuration.texture)
                
                self.Health.border = self.Health:CreateTexture(nil, 'LOW')
                self.Health.border:SetPoint('TOPLEFT', -1, 1)
                self.Health.border:SetSize(Configuration[self.frame].HealthBar.width, Configuration[self.frame].HealthBar.height)
                self.Health.border:SetTexture(0, 0, 0)

                self.HealPrediction =
                {
                    maxOverflow = 1,
                    myBar = CreateFrame('StatusBar', nil, self),
                    otherBar = CreateFrame('StatusBar', nil, self)
                }

                self.HealPrediction.myBar:SetPoint('TOPLEFT', self.Health:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
                self.HealPrediction.myBar:SetPoint('BOTTOMLEFT', self.Health:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
                self.HealPrediction.myBar:SetSize(Configuration[self.frame].HealthBar.width - 2, Configuration[self.frame].HealthBar.height - 2)
                self.HealPrediction.myBar:SetStatusBarTexture(Configuration.texture)

                self.HealPrediction.otherBar:SetPoint('TOPLEFT', self.HealPrediction.myBar:GetStatusBarTexture(), 'TOPRIGHT', 0, 0)
                self.HealPrediction.otherBar:SetPoint('BOTTOMLEFT', self.HealPrediction.myBar:GetStatusBarTexture(), 'BOTTOMRIGHT', 0, 0)
                self.HealPrediction.otherBar:SetSize(Configuration[self.frame].HealthBar.width - 2, Configuration[self.frame].HealthBar.height - 2)
                self.HealPrediction.otherBar:SetStatusBarTexture(Configuration.texture)

                if Configuration[self.frame].HealthBar.Text then
                    self.Health.text = self.Health:CreateFontString(nil, 'OVERLAY')
                    self.Health.text.frequentUpdates = true
                    self.Health.text:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
                    self.Health.text:SetPoint(Configuration[self.frame].HealthBar.Text.anchor, Configuration[self.frame].HealthBar.Text.x, Configuration[self.frame].HealthBar.Text.y)
                    self:Tag(self.Health.text, '[SnailUI:Health]')
                end
            end

            if Configuration[self.frame].HolyPowerBar and (unit == 'Player') then
                if select(2, UnitClass(unit)) == 'PALADIN' then
                    self.ClassIcons = self:CreateTexture(self, 'BACKGROUND')
                    self.ClassIcons:SetPoint(Configuration[self.frame].HolyPowerBar.anchor, Configuration[self.frame].HolyPowerBar.x, Configuration[self.frame].HolyPowerBar.y)
                    self.ClassIcons:SetSize(Configuration[self.frame].HolyPowerBar.width, Configuration[self.frame].HolyPowerBar.height)
                    self.ClassIcons:SetTexture(0, 0, 0)

                    self.ClassIcons.background = self:CreateTexture(nil, 'BACKGROUND')
                    self.ClassIcons.background:SetPoint('TOPLEFT', self.ClassIcons, 1, -1)
                    self.ClassIcons.background:SetSize(Configuration[self.frame].HolyPowerBar.width - 2, Configuration[self.frame].HolyPowerBar.height - 2)

                    for i = 1, 5 do
                        self.ClassIcons[i] = self:CreateTexture(self, 'LOW')

                        if i <= #Configuration[self.frame].HolyPowerBar then
                            self.ClassIcons[i]:SetPoint(Configuration[self.frame].HolyPowerBar[i].anchor, self.ClassIcons, Configuration[self.frame].HolyPowerBar[i].x, Configuration[self.frame].HolyPowerBar[i].y)
                            self.ClassIcons[i]:SetSize(Configuration[self.frame].HolyPowerBar[i].width - 2, Configuration[self.frame].HolyPowerBar[i].height - 2)
                            self.ClassIcons[i]:SetTexture(Configuration.texture)

                            self.ClassIcons[i].border = self:CreateTexture(nil, 'LOW')
                            self.ClassIcons[i].border:SetPoint('TOPLEFT', self.ClassIcons[i], -1, 1)
                            self.ClassIcons[i].border:SetSize(Configuration[self.frame].HolyPowerBar[i].width, Configuration[self.frame].HolyPowerBar[i].height)
                            self.ClassIcons[i].border:SetTexture(0, 0, 0)
                        end
                    end
                end
            end

            if Configuration[self.frame].PowerBar then
                self.Power = CreateFrame('StatusBar', nil, self)
                self.Power.frequentUpdates = true
                self.Power:SetPoint(Configuration[self.frame].PowerBar.anchor, Configuration[self.frame].PowerBar.x, Configuration[self.frame].PowerBar.y)
                self.Power:SetStatusBarTexture(Configuration.texture)

                if Configuration[self.frame].PowerBar.border then
                    self.Power:SetSize(Configuration[self.frame].PowerBar.width - 6, Configuration[self.frame].PowerBar.height - 6)

                    self.Power.backgroundBottom = self.Power:CreateTexture(nil, 'LOW')
                    self.Power.backgroundBottom:SetPoint('BOTTOM', 0, -2)
                    self.Power.backgroundBottom:SetSize(Configuration[self.frame].PowerBar.width - 2, 1)
                    self.Power.backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    self.Power.backgroundLeft = self.Power:CreateTexture(nil, 'LOW')
                    self.Power.backgroundLeft:SetPoint('LEFT', -2, 0)
                    self.Power.backgroundLeft:SetSize(1, Configuration[self.frame].PowerBar.height - 4)
                    self.Power.backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    self.Power.backgroundRight = self.Power:CreateTexture(nil, 'LOW')
                    self.Power.backgroundRight:SetPoint('RIGHT', 2, 0)
                    self.Power.backgroundRight:SetSize(1, Configuration[self.frame].PowerBar.height - 4)
                    self.Power.backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

                    self.Power.backgroundTop = self.Power:CreateTexture(nil, 'LOW')
                    self.Power.backgroundTop:SetPoint('TOP', 0, 2)
                    self.Power.backgroundTop:SetSize(Configuration[self.frame].PowerBar.width - 2, 1)
                    self.Power.backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
                                    
                    self.Power.border = self.Power:CreateTexture(nil, 'BACKGROUND')
                    self.Power.border:SetPoint('TOPLEFT', -3, 3)
                    self.Power.border:SetSize(Configuration[self.frame].PowerBar.width, Configuration[self.frame].PowerBar.height)
                    self.Power.border:SetTexture(0, 0, 0)
                else
                    self.Power:SetSize(Configuration[self.frame].PowerBar.width - 2, Configuration[self.frame].PowerBar.height - 2)                    
                
                    self.Power.innerBorder = self.Power:CreateTexture(nil, 'LOW')
                    self.Power.innerBorder:SetPoint('TOPLEFT', -1, 1)
                    self.Power.innerBorder:SetSize(Configuration[self.frame].PowerBar.width, Configuration[self.frame].PowerBar.height)
                    self.Power.innerBorder:SetTexture(0, 0, 0)
                end
            end

            if Configuration[self.frame].RuneBar and (unit == 'Player') then
                if select(2, UnitClass(unit)) == 'DEATHKNIGHT' then
                    self.Runes = CreateFrame('Frame', nil, self)
                    self.Runes:SetPoint(Configuration[self.frame].RuneBar.anchor, Configuration[self.frame].RuneBar.x, Configuration[self.frame].RuneBar.y)
                    self.Runes:SetSize(Configuration[self.frame].RuneBar.width - 2, Configuration[self.frame].RuneBar.height - 2)

                    self.Runes.background = self.Runes:CreateTexture(nil, 'BACKGROUND')
                    self.Runes.background:SetPoint('TOPLEFT')
                    self.Runes.background:SetSize(Configuration[self.frame].RuneBar.width - 2, Configuration[self.frame].RuneBar.height - 2)

                    self.Runes.border = self.Runes:CreateTexture(nil, 'BACKGROUND')
                    self.Runes.border:SetPoint('TOPLEFT', -1, 1)
                    self.Runes.border:SetSize(Configuration[self.frame].RuneBar.width, Configuration[self.frame].RuneBar.height)
                    self.Runes.border:SetTexture(0, 0, 0)

                    for i = 1, #Configuration[self.frame].RuneBar do
                        self.Runes[i] = CreateFrame('StatusBar', nil, self)
                        self.Runes[i]:SetPoint(Configuration[self.frame].RuneBar[i].anchor, self.Runes, Configuration[self.frame].RuneBar[i].x, Configuration[self.frame].RuneBar[i].y)
                        self.Runes[i]:SetSize(Configuration[self.frame].RuneBar[i].width - 2, Configuration[self.frame].RuneBar[i].height - 2)
                        self.Runes[i]:SetStatusBarTexture(Configuration.texture)

                        self.Runes[i].border = self.Runes:CreateTexture(nil, 'LOW')
                        self.Runes[i].border:SetPoint('TOPLEFT', self.Runes[i], -1, 1)
                        self.Runes[i].border:SetSize(Configuration[self.frame].RuneBar[i].width, Configuration[self.frame].RuneBar[i].height)
                        self.Runes[i].border:SetTexture(0, 0, 0)
                    end
                end
            end

            if Configuration[self.frame].ShadowOrbsBar and (unit == 'Player') then
                if select(2, UnitClass(unit)) == 'PRIEST' then
                    self.ClassIcons = self:CreateTexture(self, 'BACKGROUND')
                    self.ClassIcons:SetPoint(Configuration[self.frame].ShadowOrbsBar.anchor, Configuration[self.frame].ShadowOrbsBar.x, Configuration[self.frame].ShadowOrbsBar.y)
                    self.ClassIcons:SetSize(Configuration[self.frame].ShadowOrbsBar.width, Configuration[self.frame].ShadowOrbsBar.height)
                    self.ClassIcons:SetTexture(0, 0, 0)

                    self.ClassIcons.background = self:CreateTexture(nil, 'LOW')
                    self.ClassIcons.background:SetPoint('TOPLEFT', self.ClassIcons, 1, -1)
                    self.ClassIcons.background:SetSize(Configuration[self.frame].ShadowOrbsBar.width - 2, Configuration[self.frame].ShadowOrbsBar.height - 2)

                    for i = 1, 5 do
                        self.ClassIcons[i] = self:CreateTexture(self, 'LOW')

                        if i <= #Configuration[self.frame].ShadowOrbsBar then
                            self.ClassIcons[i]:SetPoint(Configuration[self.frame].ShadowOrbsBar[i].anchor, self.ClassIcons, Configuration[self.frame].ShadowOrbsBar[i].x, Configuration[self.frame].ShadowOrbsBar[i].y)
                            self.ClassIcons[i]:SetSize(Configuration[self.frame].ShadowOrbsBar[i].width - 2, Configuration[self.frame].ShadowOrbsBar[i].height - 2)
                            self.ClassIcons[i]:SetTexture(Configuration.texture)

                            self.ClassIcons[i].border = self:CreateTexture(nil, 'LOW')
                            self.ClassIcons[i].border:SetPoint('TOPLEFT', self.ClassIcons[i], -1, 1)
                            self.ClassIcons[i].border:SetSize(Configuration[self.frame].ShadowOrbsBar[i].width, Configuration[self.frame].ShadowOrbsBar[i].height)
                            self.ClassIcons[i].border:SetTexture(0, 0, 0)
                        end
                    end
                end
            end
        end
    end
)
