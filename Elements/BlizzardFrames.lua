--
-- Copyright (C) 2012-2015 Snailsoft <http://www.snailsoft.me/>
--
-- This program is free software; you can redistribute it and/or modify it
-- under the terms of the GNU General Public License as published by the
-- Free Software Foundation; either version 2 of the License, or (at your
-- option) any later version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-- FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
-- more details.
--
-- You should have received a copy of the GNU General Public License along
-- with this program. If not, see <http://www.gnu.org/licenses/>.
--

function HandleBlizzardFrames()
	for I = 1, MAX_BOSS_FRAMES do
		_G["Boss" .. I .. "TargetFrame"]:SetScript("OnShow",
			function(Self)
				Self:Hide()
			end
		)

		_G["Boss" .. I .. "TargetFrame"]:Hide()
	end

	AchievementMicroButton_Update = Blank

	ActionButton_ShowGrid = Blank
	ActionButton_UpdateUsable = Blank

	CompactRaidFrameContainer:UnregisterAllEvents()
	CompactRaidFrameManager:UnregisterAllEvents()

	ExtraActionButton1:HookScript("OnShow",
		function(Self)
			Self:ClearAllPoints()
			Self:SetPoint("TOP", 0, -125)
		end
	)

	GhostFrame:HookScript("OnShow",
		function(Self)
			Self:SetPoint("TOP", 0, -125)
		end
	)

	hooksecurefunc("PetBattleFrame_Display",
		function(Self)
			Self:SetFrameLevel(10)
			Self:SetFrameStrata("HIGH")
		end
	)

	SetInsertItemsLeftToRight(false)
	SetSortBagsRightToLeft(false)

	VehicleSeatIndicator:HookScript("OnShow",
		function(Self)
			Self:ClearAllPoints()
			Self:SetPoint("BOTTOMRIGHT", ObjectiveTrackerFrame, "BOTTOMLEFT", -4, 4)

			Self.ClearAllPoints = Blank
			Self.SetPoint = Blank

			if ExtraButton then
				if ExtraButton:GetAlpha() == 0 then
					Self:Hide()
				end
			end
		end
	)

	WorldStateAlwaysUpFrame:HookScript("OnShow",
		function(Self)
			Self:SetPoint("TOP", 0, -25)
		end
	)

	local Frames =
	{
		"CompactRaidFrameContainer",
		"CompactRaidFrameManager",
		"PlayerPowerBarAlt",
		"RaidBossEmoteFrame",
		"UIErrorsFrame"
	}

	local Textures = {}

	if GetConfiguration().ActionBars then
		hooksecurefunc("InterfaceOptions_UpdateMultiActionBars",
			function()
				SHOW_MULTI_ACTIONBAR_1 = 1
				SHOW_MULTI_ACTIONBAR_2 = 1
				SHOW_MULTI_ACTIONBAR_3 = 1
				SHOW_MULTI_ACTIONBAR_4 = 1
			end
		)

		if GetConfiguration().ActionBars.Pet then
			if GetConfiguration().ActionBars.Pet.Buttons < NUM_PET_ACTION_SLOTS then
				for I = (GetConfiguration().ActionBars.Pet.Buttons + 1), NUM_PET_ACTION_SLOTS do
					Frames[#Frames + 1] = "PetActionButton" .. I
				end
			end
		else
			Frames[#Frames + 1] = "PetActionBarFrame"
		end

		if GetConfiguration().ActionBars.Player then
			Frames[#Frames + 1] = "AchievementMicroButton"
			Frames[#Frames + 1] = "ActionBarDownButton"
			Frames[#Frames + 1] = "ActionBarUpButton"
			Frames[#Frames + 1] = "CharacterMicroButton"
			Frames[#Frames + 1] = "CompanionsMicroButton"
			Frames[#Frames + 1] = "EJMicroButton"
			Frames[#Frames + 1] = "GuildMicroButton"
			Frames[#Frames + 1] = "HelpMicroButton"
			Frames[#Frames + 1] = "LFDMicroButton"
			Frames[#Frames + 1] = "MainMenuBarBackpackButton"
			Frames[#Frames + 1] = "MainMenuMicroButton"
			Frames[#Frames + 1] = "QuestLogMicroButton"
			Frames[#Frames + 1] = "ReputationWatchBar"
			Frames[#Frames + 1] = "SpellbookMicroButton"
			Frames[#Frames + 1] = "StoreMicroButton"
			Frames[#Frames + 1] = "TalentMicroButton"

			if GetConfiguration().ActionBars.Player.Buttons < NUM_ACTIONBAR_BUTTONS then
				for I = (GetConfiguration().ActionBars.Player.Buttons + 1), NUM_ACTIONBAR_BUTTONS do
					Frames[#Frames + 1] = "ActionButton" .. I
				end
			end

			StanceBarFrame:SetPoint("TOPLEFT", UIParent, -500, 500)

			Textures[#Textures + 1] = "MainMenuBarLeftEndCap"
			Textures[#Textures + 1] = "MainMenuBarPageNumber"
			Textures[#Textures + 1] = "MainMenuBarRightEndCap"
			Textures[#Textures + 1] = "MainMenuBarTexture0"
			Textures[#Textures + 1] = "MainMenuBarTexture1"
			Textures[#Textures + 1] = "MainMenuBarTexture2"
			Textures[#Textures + 1] = "MainMenuBarTexture3"
			Textures[#Textures + 1] = "SlidingActionBarTexture0"
			Textures[#Textures + 1] = "SlidingActionBarTexture1"
		else
			Frames[#Frames + 1] = "MainMenuBar"
		end

		if GetConfiguration().ActionBars.Player2 then
			if GetConfiguration().ActionBars.Player2.Buttons < NUM_MULTIBAR_BUTTONS then
				for I = (GetConfiguration().ActionBars.Player2.Buttons + 1), NUM_MULTIBAR_BUTTONS do
					Frames[#Frames + 1] = "MultiBarRightButton" .. I
				end
			end
		else
			Frames[#Frames + 1] = "MultiBarRight"
		end

		if GetConfiguration().ActionBars.Player3 then
			if GetConfiguration().ActionBars.Player3.Buttons < NUM_MULTIBAR_BUTTONS then
				for I = (GetConfiguration().ActionBars.Player3.Buttons + 1), NUM_MULTIBAR_BUTTONS do
					Frames[#Frames + 1] = "MultiBarLeftButton" .. I
				end
			end
		else
			Frames[#Frames + 1] = "MultiBarLeft"
		end

		if GetConfiguration().ActionBars.Player4 then
			if GetConfiguration().ActionBars.Player4.Buttons < NUM_MULTIBAR_BUTTONS then
				for I = (GetConfiguration().ActionBars.Player4.Buttons + 1), NUM_MULTIBAR_BUTTONS do
					Frames[#Frames + 1] = "MultiBarBottomRightButton" .. I
				end
			end
		else
			Frames[#Frames + 1] = "MultiBarBottomRight"
		end

		if GetConfiguration().ActionBars.Player5 then
			if GetConfiguration().ActionBars.Player5.Buttons < NUM_MULTIBAR_BUTTONS then
				for I = (GetConfiguration().ActionBars.Player5.Buttons + 1), NUM_MULTIBAR_BUTTONS do
					Frames[#Frames + 1] = "MultiBarBottomLeftButton" .. I
				end
			end
		else
			Frames[#Frames + 1] = "MultiBarBottomLeft"
		end
	end

	if not GetConfiguration().Bag then
		Frames[#Frames + 1] = "CharacterBag0Slot"
		Frames[#Frames + 1] = "CharacterBag1Slot"
		Frames[#Frames + 1] = "CharacterBag2Slot"
		Frames[#Frames + 1] = "CharacterBag3Slot"
	end

	if GetConfiguration().Bank then
		for I = 1, 7 do
			local Frame = BankSlotsFrame["Bag" .. I].HighlightFrame

			Frame:Hide()
			Frame:SetScript("OnShow",
				function(Self)
					Self:Hide()
				end
			)

			Frame.Show = Blank
		end
	end

	if GetConfiguration().Chat then
		Frames[#Frames + 1] = "ChatFrameMenuButton"
		Frames[#Frames + 1] = "FriendsMicroButton"
		Frames[#Frames + 1] = "GeneralDockManager"

		for I = 1, NUM_CHAT_WINDOWS do
			Frames[#Frames + 1] = "ChatFrame" .. I .. "ButtonFrame"
			Frames[#Frames + 1] = "ChatFrame" .. I .. "ResizeButton"

			Textures[#Textures + 1] = "ChatFrame" .. I .. "Background"
		end
	end

	if GetConfiguration().ExperienceBar then
		Frames[#Frames + 1] = "ExhaustionTick"
		Frames[#Frames + 1] = "MainMenuBarMaxLevelBar"
		Frames[#Frames + 1] = "MainMenuBarOverlayFrame"

		if GetConfiguration().ExtraButton then
			MainMenuExpBar:Hide()
		end

		Textures[#Textures + 1] = "ExhaustionLevelFillBar"
		Textures[#Textures + 1] = "MainMenuMaxLevelBar0"
		Textures[#Textures + 1] = "MainMenuMaxLevelBar1"
		Textures[#Textures + 1] = "MainMenuMaxLevelBar2"
		Textures[#Textures + 1] = "MainMenuMaxLevelBar3"
		Textures[#Textures + 1] = "MainMenuXPBarTextureLeftCap"
		Textures[#Textures + 1] = "MainMenuXPBarTextureMid"
		Textures[#Textures + 1] = "MainMenuXPBarTextureRightCap"

		for I = 1, 19 do
			Textures[#Textures + 1] = "MainMenuXPBarDiv" .. I
		end

		if UnitLevel("Player") == MAX_PLAYER_LEVEL then
			Frames[#Frames + 1] = "MainMenuExpBar"
		end
	end

	if GetConfiguration().ExtraButton then
		BuffFrame:Hide()

		MultiBarBottomRight:Hide()
		MultiBarLeft:Hide()

		MultiBarBottomRight:HookScript("OnShow",
			function(Self)
				if not Self.EnableShow then
					Self:Hide()
				end
			end
		)

		MultiBarLeft:HookScript("OnShow",
			function(Self)
				if not Self.EnableShow then
					Self:Hide()
				end
			end
		)

		ObjectiveTrackerFrame:Hide()
		VehicleSeatIndicator:Hide()
		WorldStateAlwaysUpFrame:Hide()
	end

	if GetConfiguration().Minimap then
		Frames[#Frames + 1] = "MinimapBackdrop"
		Frames[#Frames + 1] = "MinimapCluster"
		Frames[#Frames + 1] = "MinimapZoneTextButton"
	end

	for I = 1, #Frames do
		_G[Frames[I]]:Hide()
		_G[Frames[I]]:SetScript("OnShow",
			function(Self)
				Self:Hide()
			end
		)

		_G[Frames[I]].Show = Blank
	end

	for I = 1, #Textures do
		_G[Textures[I]]:Hide()
		_G[Textures[I]]:SetAlpha(0)
	end
end
