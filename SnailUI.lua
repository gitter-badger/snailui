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

oUF.TagEvents['SnailUI:Health'] = 'UNIT_HEALTH UNIT_HEAL_PREDICTION'
oUF.Tags['SnailUI:Health'] = function(unit)
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

			StanceBarFrame:ClearAllPoints()
			StanceBarFrame:SetAlpha(0)
			StanceBarFrame:SetPoint('TOPLEFT', -100, 100)

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

					_G['PetActionButton' .. i].backgroundBottom = _G['PetActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
					_G['PetActionButton' .. i].backgroundBottom:SetPoint('BOTTOM', 0, -2)
					_G['PetActionButton' .. i].backgroundBottom:SetSize(Configuration.ActionBars.Pet.width - 2, 1)
					_G['PetActionButton' .. i].backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

					_G['PetActionButton' .. i].backgroundLeft = _G['PetActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
					_G['PetActionButton' .. i].backgroundLeft:SetPoint('LEFT', -2, 0)
					_G['PetActionButton' .. i].backgroundLeft:SetSize(1, Configuration.ActionBars.Pet.height - 4)
					_G['PetActionButton' .. i].backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

					_G['PetActionButton' .. i].backgroundRight = _G['PetActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
					_G['PetActionButton' .. i].backgroundRight:SetPoint('RIGHT', 2, 0)
					_G['PetActionButton' .. i].backgroundRight:SetSize(1, Configuration.ActionBars.Pet.height - 4)
					_G['PetActionButton' .. i].backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

					_G['PetActionButton' .. i].backgroundTop = _G['PetActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
					_G['PetActionButton' .. i].backgroundTop:SetPoint('TOP', 0, 2)
					_G['PetActionButton' .. i].backgroundTop:SetSize(Configuration.ActionBars.Pet.width - 2, 1)
					_G['PetActionButton' .. i].backgroundTop:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
									
					_G['PetActionButton' .. i].borderBottom = _G['PetActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
					_G['PetActionButton' .. i].borderBottom:SetPoint('BOTTOM', 0, -3)
					_G['PetActionButton' .. i].borderBottom:SetSize(Configuration.ActionBars.Pet.width, 3)
					_G['PetActionButton' .. i].borderBottom:SetTexture(0, 0, 0)

					_G['PetActionButton' .. i].borderLeft = _G['PetActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
					_G['PetActionButton' .. i].borderLeft:SetPoint('LEFT', -3, 0)
					_G['PetActionButton' .. i].borderLeft:SetSize(3, Configuration.ActionBars.Pet.height - 2)
					_G['PetActionButton' .. i].borderLeft:SetTexture(0, 0, 0)

					_G['PetActionButton' .. i].borderRight = _G['PetActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
					_G['PetActionButton' .. i].borderRight:SetPoint('RIGHT', 3, 0)
					_G['PetActionButton' .. i].borderRight:SetSize(3, Configuration.ActionBars.Pet.height - 2)
					_G['PetActionButton' .. i].borderRight:SetTexture(0, 0, 0)

					_G['PetActionButton' .. i].borderTop = _G['PetActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
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

				_G['ActionButton' .. i].backgroundBottom = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
				_G['ActionButton' .. i].backgroundBottom:SetPoint('BOTTOM', 0, -2)
				_G['ActionButton' .. i].backgroundBottom:SetSize(Configuration.ActionBars.Player.width - 2, 1)
				_G['ActionButton' .. i].backgroundBottom:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

				_G['ActionButton' .. i].backgroundLeft = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
				_G['ActionButton' .. i].backgroundLeft:SetPoint('LEFT', -2, 0)
				_G['ActionButton' .. i].backgroundLeft:SetSize(1, Configuration.ActionBars.Player.height - 4)
				_G['ActionButton' .. i].backgroundLeft:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

				_G['ActionButton' .. i].backgroundRight = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
				_G['ActionButton' .. i].backgroundRight:SetPoint('RIGHT', 2, 0)
				_G['ActionButton' .. i].backgroundRight:SetSize(1, Configuration.ActionBars.Player.height - 4)
				_G['ActionButton' .. i].backgroundRight:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

				_G['ActionButton' .. i].backgroundTop = _G['ActionButton' .. i]:CreateTexture(nil, 'BACKGROUND')
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
				_G['ActionButton' .. i .. 'FlyoutBorder']:SetAlpha(0)
				_G['ActionButton' .. i .. 'FlyoutBorderShadow']:SetAlpha(0)
				_G['ActionButton' .. i .. 'HotKey']:SetAlpha(0)
				_G['ActionButton' .. i .. 'Name']:SetAlpha(0)
			end
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

			minimapFrame.background = minimapFrame:CreateTexture(nil, 'BACKGROUND')
			minimapFrame.background:SetPoint('TOPLEFT', -2, 2)
			minimapFrame.background:SetSize(Configuration.Minimap.width - 2, Configuration.Minimap.height - 2)
			minimapFrame.background:SetTexture(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)

			minimapFrame.border = minimapFrame:CreateTexture(nil, 'BACKGROUND')
			minimapFrame.border:SetPoint('TOPLEFT', -3, 3)
			minimapFrame.border:SetSize(Configuration.Minimap.width, Configuration.Minimap.height)
			minimapFrame.border:SetTexture(0, 0, 0)

			minimapFrame.innerBorderBottom = minimapFrame:CreateTexture(nil, 'LOW')
			minimapFrame.innerBorderBottom:SetPoint('BOTTOM', 0, -1)
			minimapFrame.innerBorderBottom:SetSize(Configuration.Minimap.width - 4, 1)
			minimapFrame.innerBorderBottom:SetTexture(0, 0, 0)

			minimapFrame.innerBorderLeft = minimapFrame:CreateTexture(nil, 'LOW')
			minimapFrame.innerBorderLeft:SetPoint('LEFT', -1, 0)
			minimapFrame.innerBorderLeft:SetSize(1, Configuration.Minimap.height - 6)
			minimapFrame.innerBorderLeft:SetTexture(0, 0, 0)

			minimapFrame.innerBorderRight = minimapFrame:CreateTexture(nil, 'LOW')
			minimapFrame.innerBorderRight:SetPoint('RIGHT', 1, 0)
			minimapFrame.innerBorderRight:SetSize(1, Configuration.Minimap.height - 6)
			minimapFrame.innerBorderRight:SetTexture(0, 0, 0)

			minimapFrame.innerBorderTop = minimapFrame:CreateTexture(nil, 'LOW')
			minimapFrame.innerBorderTop:SetPoint('TOP', 0, 1)
			minimapFrame.innerBorderTop:SetSize(Configuration.Minimap.width - 4, 1)
			minimapFrame.innerBorderTop:SetTexture(0, 0, 0)

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

			self.background = self:CreateTexture(nil, 'BACKGROUND')
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
					self.Castbar.background:SetTexture(self.classColor.r, self.classColor.g, self.classColor.b)
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

					if self.Health.Text then
						self.Health.Text:SetTextColor(self.classColor.r, self.classColor.g, self.classColor.b)
					end
				end
				
				if self.Power then
					self.Power:SetStatusBarColor(self.classColor.r, self.classColor.g, self.classColor.b)

					if self.Power.Text then
						self.Power.Text:SetColor(self.classColor.r, self.classColor.g, self.classColor.b)
					end
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

			if Configuration[self.frame].HealthBar then
				self:RegisterEvent('UNIT_HEAL_PREDICTION',
					function(self)
						self.HealPrediction.myBar:SetAlpha(self:GetAlpha() / 2)
						self.HealPrediction.otherBar:SetAlpha(self:GetAlpha() / 2)
					end
				)
			end

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

				self.Castbar.background = self.Castbar:CreateTexture(nil, 'BACKGROUND')
				self.Castbar.background:SetPoint('TOPLEFT', -2, 2)
				self.Castbar.background:SetSize(Configuration[self.frame].CastingBar.width - 2, Configuration[self.frame].CastingBar.height - 2)
								
				self.Castbar.border = self.Castbar:CreateTexture(nil, 'BACKGROUND')
				self.Castbar.border:SetPoint('TOPLEFT', -3, 3)
				self.Castbar.border:SetSize(Configuration[self.frame].CastingBar.width, Configuration[self.frame].CastingBar.height)
				self.Castbar.border:SetTexture(0, 0, 0)

				self.Castbar.innerBorder = self.Castbar:CreateTexture(nil, 'LOW')
				self.Castbar.innerBorder:SetPoint('TOPLEFT', -1, 1)
				self.Castbar.innerBorder:SetSize(Configuration[self.frame].CastingBar.width - 4, Configuration[self.frame].CastingBar.height - 4)
				self.Castbar.innerBorder:SetTexture(0, 0, 0)
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
					self.Health.Text = self.Health:CreateFontString(nil, 'OVERLAY')
					self.Health.Text.frequentUpdates = true
					self.Health.Text:SetFont(Configuration.Font.name, Configuration.Font.size, Configuration.Font.outline)
					self.Health.Text:SetPoint(Configuration[self.frame].HealthBar.Text.anchor, Configuration[self.frame].HealthBar.Text.x, Configuration[self.frame].HealthBar.Text.y)
					self:Tag(self.Health.Text, '[SnailUI:Health]')
				end
			end

			if Configuration[self.frame].PowerBar then
				self.Power = CreateFrame('StatusBar', nil, self)
				self.Power.frequentUpdates = true
				self.Power:SetPoint(Configuration[self.frame].PowerBar.anchor, Configuration[self.frame].PowerBar.x, Configuration[self.frame].PowerBar.y)
				self.Power:SetSize(Configuration[self.frame].PowerBar.width - 2, Configuration[self.frame].PowerBar.height - 2)
				self.Power:SetStatusBarTexture(Configuration.texture)
				
				self.Power.border = self.Power:CreateTexture(nil, 'LOW')
				self.Power.border:SetPoint('TOPLEFT', -1, 1)
				self.Power.border:SetSize(Configuration[self.frame].PowerBar.width, Configuration[self.frame].PowerBar.height)
				self.Power.border:SetTexture(0, 0, 0)
			end
		end
	end
)
