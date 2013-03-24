-- Minimap.lua
-- Written by Snail

function HandleMinimap()
	if GetConfiguration().Minimap then
		local Class = select(2, UnitClass("Player"))

		Minimap:ClearAllPoints()
		Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8X8.tga")
		Minimap:SetParent(UIParent)
		Minimap:SetPoint(GetConfiguration().Minimap.Anchor, GetConfiguration().Minimap.X, GetConfiguration().Minimap.Y)
		Minimap:SetSize(GetConfiguration().Minimap.Width - 6, GetConfiguration().Minimap.Height - 6)
		Minimap:SetScript("OnMouseWheel",
			function(Self, Direction)
				if Direction > 0 then
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
			TimeManagerClockTicker:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)
		end

		if GetConfiguration().Minimap.Info then
			Minimap.Info = CreateFrame("Frame", nil, Minimap)
			Minimap.Info:SetFrameLevel(Minimap:GetFrameLevel())
			Minimap.Info:SetPoint(GetConfiguration().Minimap.Info.Anchor, GetConfiguration().Minimap.Info.X, GetConfiguration().Minimap.Info.Y)
			Minimap.Info:SetSize(GetConfiguration().Minimap.Info.Width - 6, GetConfiguration().Minimap.Info.Height - 6)

			if GetConfiguration().Minimap.Info.FPS or GetConfiguration().Minimap.Info.Latency then
				Minimap.Info:SetScript("OnUpdate",
					function(Self, ElapsedTime)
						if not Self.Time then
							Self.Time = 1
						end

						if (Self.Time + ElapsedTime) >= 1 then
							if Self.FPS then
								Self.FPS:SetText(math.floor(GetFramerate() + 0.5) .. " fps")
							end

							if Self.Latency then
								Self.Latency:SetText(select(4, GetNetStats()) .. " ms")
							end

							Self.Time = 0
						else
							Self.Time = Self.Time + ElapsedTime
						end
					end
				)
			end

			Minimap.Info.BackgroundBottom = Minimap.Info:CreateTexture(nil, "LOW")
			Minimap.Info.BackgroundBottom:SetPoint("BOTTOM", 0, -2)
			Minimap.Info.BackgroundBottom:SetSize(GetConfiguration().Minimap.Info.Width - 2, 1)
			Minimap.Info.BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Minimap.Info.BackgroundLeft = Minimap.Info:CreateTexture(nil, "LOW")
			Minimap.Info.BackgroundLeft:SetPoint("LEFT", -2, 0)
			Minimap.Info.BackgroundLeft:SetSize(1, GetConfiguration().Minimap.Info.Height - 4)
			Minimap.Info.BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Minimap.Info.BackgroundRight = Minimap.Info:CreateTexture(nil, "LOW")
			Minimap.Info.BackgroundRight:SetPoint("RIGHT", 2, 0)
			Minimap.Info.BackgroundRight:SetSize(1, GetConfiguration().Minimap.Info.Height - 4)
			Minimap.Info.BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Minimap.Info.BackgroundTop = Minimap.Info:CreateTexture(nil, "LOW")
			Minimap.Info.BackgroundTop:SetPoint("TOP", 0, 2)
			Minimap.Info.BackgroundTop:SetSize(GetConfiguration().Minimap.Info.Width - 2, 1)
			Minimap.Info.BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

			Minimap.Info.BorderBottom = Minimap.Info:CreateTexture(nil, "BACKGROUND")
			Minimap.Info.BorderBottom:SetPoint("BOTTOM", 0, -3)
			Minimap.Info.BorderBottom:SetSize(GetConfiguration().Minimap.Info.Width, 3)
			Minimap.Info.BorderBottom:SetTexture(0, 0, 0)

			Minimap.Info.BorderLeft = Minimap.Info:CreateTexture(nil, "BACKGROUND")
			Minimap.Info.BorderLeft:SetPoint("LEFT", -3, 0)
			Minimap.Info.BorderLeft:SetSize(3, GetConfiguration().Minimap.Info.Height - 2)
			Minimap.Info.BorderLeft:SetTexture(0, 0, 0)

			Minimap.Info.BorderRight = Minimap.Info:CreateTexture(nil, "BACKGROUND")
			Minimap.Info.BorderRight:SetPoint("RIGHT", 3, 0)
			Minimap.Info.BorderRight:SetSize(3, GetConfiguration().Minimap.Info.Height - 2)
			Minimap.Info.BorderRight:SetTexture(0, 0, 0)

			Minimap.Info.BorderTop = Minimap.Info:CreateTexture(nil, "BACKGROUND")
			Minimap.Info.BorderTop:SetPoint("TOP", 0, 3)
			Minimap.Info.BorderTop:SetSize(GetConfiguration().Minimap.Info.Width, 3)
			Minimap.Info.BorderTop:SetTexture(0, 0, 0)

			Minimap.Info.TransparentBackground = Minimap.Info:CreateTexture(nil, "BACKGROUND")
			Minimap.Info.TransparentBackground:SetPoint("CENTER")
			Minimap.Info.TransparentBackground:SetSize(GetConfiguration().Minimap.Info.Width - 6, GetConfiguration().Minimap.Info.Height - 6)
			Minimap.Info.TransparentBackground:SetTexture(0, 0, 0, 0.5)

			if GetConfiguration().Minimap.Info.FPS then
				Minimap.Info.FPS = Minimap.Info:CreateFontString(nil, "OVERLAY")
				Minimap.Info.FPS:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				Minimap.Info.FPS:SetPoint(GetConfiguration().Minimap.Info.FPS.Anchor, GetConfiguration().Minimap.Info.FPS.X, GetConfiguration().Minimap.Info.FPS.Y)
				Minimap.Info.FPS:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				Minimap.Info.FPS.Frame = CreateFrame("Frame", nil, Minimap.Info)
				Minimap.Info.FPS.Frame:SetAllPoints(Minimap.Info.FPS)
				Minimap.Info.FPS.Frame:SetScript("OnEnter", Blank)
			end

			if GetConfiguration().Minimap.Info.Latency then
				Minimap.Info.Latency = Minimap.Info:CreateFontString(nil, "OVERLAY")
				Minimap.Info.Latency:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
				Minimap.Info.Latency:SetPoint(GetConfiguration().Minimap.Info.Latency.Anchor, GetConfiguration().Minimap.Info.Latency.X, GetConfiguration().Minimap.Info.Latency.Y)
				Minimap.Info.Latency:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

				Minimap.Info.Latency.Frame = CreateFrame("Frame", nil, Minimap.Info)
				Minimap.Info.Latency.Frame:SetAllPoints(Minimap.Info.Latency)
				Minimap.Info.Latency.Frame:SetScript("OnEnter",
					function(Self)
						GameTooltip_SetDefaultAnchor(GameTooltip, Self)
						GameTooltip:SetText("Bandwidth")

						local incoming, outgoing, home, world = GetNetStats()

						GameTooltip:AddDoubleLine("Incoming", string.format("%.1f", incoming) .. " kb/s", 1, 1, 1, 1, 1, 1)
						GameTooltip:AddDoubleLine("Outgoing", string.format("%.1f", outgoing) .. " kb/s", 1, 1, 1, 1, 1, 1)
						GameTooltip:AddLine(" ")
						GameTooltip:AddLine("Latency")
						GameTooltip:AddDoubleLine("Home", math.floor(home + 0.5) .. " ms", 1, 1, 1, 1, 1, 1)
						GameTooltip:AddDoubleLine("World", math.floor(world + 0.5) .. " ms", 1, 1, 1, 1, 1, 1)
						GameTooltip:Show()
					end
				)

				Minimap.Info.Latency.Frame:SetScript("OnLeave",
					function(Self)
						GameTooltip:Hide()
					end
				)
			end
		end

		if GetConfiguration().Minimap.Mail then
			MiniMapMailBorder:Hide()
			MiniMapMailFrame:ClearAllPoints()
			MiniMapMailFrame:SetParent(Minimap)
			MiniMapMailFrame:SetPoint(GetConfiguration().Minimap.Mail.Anchor, GetConfiguration().Minimap.Mail.X, GetConfiguration().Minimap.Mail.Y)
			MiniMapMailIcon:SetTexture("Interface\\Minimap\\Tracking\\Mailbox.tga")
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
end
