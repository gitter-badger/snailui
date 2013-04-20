-- BlizzardFrames.lua
-- Written by Snail

function HandleBlizzardFrames()
	CompactRaidFrameContainer:UnregisterAllEvents()
	CompactRaidFrameManager:UnregisterAllEvents()

	ExtraActionBarFrame:ClearAllPoints()
	ExtraActionBarFrame:SetPoint("TOP", UIParent, 0, -100)

	ExtraActionBarFrame.ClearAllPoints = Blank
	ExtraActionBarFrame.SetPoint = Blank

	GhostFrame:ClearAllPoints()
	GhostFrame:SetPoint("TOP", 0, -100)
	GhostFrame.OriginalSetPoint = ExtraActionBarFrame.SetPoint
	GhostFrame.SetPoint = function()
		GhostFrame:ClearAllPoints()
		GhostFrame:OriginalSetPoint("TOP", 0, -100)
	end

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
		local OriginalInterfaceOptions_UpdateMultiActionBars = InterfaceOptions_UpdateMultiActionBars

		InterfaceOptions_UpdateMultiActionBars = function()
			SHOW_MULTI_ACTIONBAR_1 = 1
			SHOW_MULTI_ACTIONBAR_2 = 1
			SHOW_MULTI_ACTIONBAR_3 = 1
			SHOW_MULTI_ACTIONBAR_4 = 1

			OriginalInterfaceOptions_UpdateMultiActionBars()
		end

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
			AchievementMicroButton_Update = Blank

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
			Frames[#Frames + 1] = "PVPMicroButton"
			Frames[#Frames + 1] = "QuestLogMicroButton"
			Frames[#Frames + 1] = "ReputationWatchBar"
			Frames[#Frames + 1] = "SpellbookMicroButton"
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
			Frames[#Frames + 1] = "BankFrameBag" .. I .. "HighlightFrame"
		end
	end

	if GetConfiguration().Chat then
		Frames[#Frames + 1] = "ChatFrameMenuButton"
		Frames[#Frames + 1] = "FriendsMicroButton"

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
		WatchFrame:Hide()
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
