-- BlizzardFrames.lua
-- Written by Snail

function HandleBlizzardFrames()
    BuffFrame:Hide()

    CompactRaidFrameContainer:UnregisterAllEvents()
    CompactRaidFrameManager:UnregisterAllEvents()

    WatchFrame:Hide()
    WorldStateAlwaysUpFrame:Hide()

    local Frames =
    {
        "CompactRaidFrameContainer",
        "CompactRaidFrameManager",
        "MinimapCluster",
        "RaidBossEmoteFrame",
        "UIErrorsFrame"
    }

    local Textures = {}

    if GetConfiguration().ActionBars then
        if GetConfiguration().ActionBars.Player then
            AchievementMicroButton_Update = Blank

            Frames[#Frames + 1] = "AchievementMicroButton"
            Frames[#Frames + 1] = "ActionBarDownButton"
            Frames[#Frames + 1] = "ActionBarUpButton"
            Frames[#Frames + 1] = "CharacterBag0Slot"
            Frames[#Frames + 1] = "CharacterBag1Slot"
            Frames[#Frames + 1] = "CharacterBag2Slot"
            Frames[#Frames + 1] = "CharacterBag3Slot"
            Frames[#Frames + 1] = "CharacterMicroButton"
            Frames[#Frames + 1] = "CompanionsMicroButton"
            Frames[#Frames + 1] = "EJMicroButton"
            Frames[#Frames + 1] = "GuildMicroButton"
            Frames[#Frames + 1] = "HelpMicroButton"
            Frames[#Frames + 1] = "LFDMicroButton"
            Frames[#Frames + 1] = "MainMenuBarBackpackButton"
            Frames[#Frames + 1] = "MainMenuMicroButton"
            Frames[#Frames + 1] = "MultiBarBottomLeft"
            Frames[#Frames + 1] = "MultiBarBottomRight"
            Frames[#Frames + 1] = "MultiBarLeft"
            Frames[#Frames + 1] = "MultiBarRight"        
            Frames[#Frames + 1] = "PVPMicroButton"
            Frames[#Frames + 1] = "QuestLogMicroButton"
            Frames[#Frames + 1] = "ReputationWatchBar"
            Frames[#Frames + 1] = "SpellbookMicroButton"
            Frames[#Frames + 1] = "TalentMicroButton"

            if GetConfiguration().ActionBars.Player.Buttons < NUM_ACTIONBAR_BUTTONS then
                for i = (GetConfiguration().ActionBars.Player.Buttons + 1), NUM_ACTIONBAR_BUTTONS do
                    Frames[#Frames + 1] = "ActionButton" .. i
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

        if GetConfiguration().ActionBars.Pet then
            if GetConfiguration().ActionBars.Pet.Buttons < NUM_PET_ACTION_SLOTS then
                for i = (GetConfiguration().ActionBars.Pet.Buttons + 1), NUM_PET_ACTION_SLOTS do
                    Frames[#Frames + 1] = "PetActionButton" .. i
                end
            end
        else
            Frames[#Frames + 1] = "PetActionBarFrame"
        end
    end

    if GetConfiguration().Bag then
        Frames[#Frames + 1] = "BagItemSearchBox"
        Frames[#Frames + 1] = "ContainerFrame1CloseButton"
        Frames[#Frames + 1] = "ContainerFrame1PortraitButton"

        Textures[#Textures + 1] = "ContainerFrame1BackgroundBottom"
        Textures[#Textures + 1] = "ContainerFrame1BackgroundMiddle1"
        Textures[#Textures + 1] = "ContainerFrame1BackgroundMiddle2"
        Textures[#Textures + 1] = "ContainerFrame1BackgroundTop"
        Textures[#Textures + 1] = "ContainerFrame1Name"
        Textures[#Textures + 1] = "ContainerFrame1Portrait"
    end

    if GetConfiguration().Chat then
        Frames[#Frames + 1] = "ChatFrameMenuButton"
        Frames[#Frames + 1] = "FriendsMicroButton"
        Frames[#Frames + 1] = "GeneralDockManager"

        for i = 1, NUM_CHAT_WINDOWS do
            Frames[#Frames + 1] = "ChatFrame" .. i .. "ButtonFrame"
            Frames[#Frames + 1] = "ChatFrame" .. i .. "ResizeButton"
        end
    end

    if GetConfiguration().ExperienceBar and (UnitLevel("Player") ~= MAX_PLAYER_LEVEL) then
        Frames[#Frames + 1] = "ExhaustionTick"
        Frames[#Frames + 1] = "MainMenuBarMaxLevelBar"
        Frames[#Frames + 1] = "MainMenuBarOverlayFrame"

        if GetConfiguration().ExtraButton then
            MainMenuExpBar:Hide()
        end

        Textures[#Textures + 1] = "ExhaustionLevelFillBar"
        Textures[#Textures + 1] = "MainMenuXPBarTextureLeftCap"
        Textures[#Textures + 1] = "MainMenuXPBarTextureMid"
        Textures[#Textures + 1] = "MainMenuXPBarTextureRightCap"

        for i = 1, 19 do
            Textures[#Textures + 1] = "MainMenuXPBarDiv" .. i
        end
    elseif GetConfiguration().ActionBars.Player then
            Frames[#Frames + 1] = "MainMenuExpBar"
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

    for i = 1, #Textures do
        _G[Textures[i]]:Hide()
        _G[Textures[i]]:SetAlpha(0)
    end
end
