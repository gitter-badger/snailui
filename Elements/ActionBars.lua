-- ActionBars.lua
-- Written by Snail

function HandleActionBars()
	if GetConfiguration().ActionBars then
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

		if GetConfiguration().ActionBars.Player2 then
			local CurrentIndex = #Bars + 1

			Bars[CurrentIndex] = GetConfiguration().ActionBars.Player2
			Bars[CurrentIndex].ActionBar = "MultiBarRight"

			Buttons[CurrentIndex] = "MultiBarRightButton"
		end

		if GetConfiguration().ActionBars.Player3 then
			local CurrentIndex = #Bars + 1

			Bars[CurrentIndex] = GetConfiguration().ActionBars.Player3
			Bars[CurrentIndex].ActionBar = "MultiBarLeft"

			Buttons[CurrentIndex] = "MultiBarLeftButton"
		end

		if GetConfiguration().ActionBars.Player4 then
			local CurrentIndex = #Bars + 1

			Bars[CurrentIndex] = GetConfiguration().ActionBars.Player4
			Bars[CurrentIndex].ActionBar = "MultiBarBottomRight"

			Buttons[CurrentIndex] = "MultiBarBottomRightButton"
		end

		if GetConfiguration().ActionBars.Player5 then
			local CurrentIndex = #Bars + 1

			Bars[CurrentIndex] = GetConfiguration().ActionBars.Player5
			Bars[CurrentIndex].ActionBar = "MultiBarBottomLeft"

			Buttons[CurrentIndex] = "MultiBarBottomLeftButton"
		end

		if #Bars > 0 then
			local Class = select(2, UnitClass("Player"))
			local Texture

			ActionButton_UpdateUsable = function(Self)
				if Self.action then
					local IsUsable, NotEnoughMana = IsUsableAction(Self.action)

					if IsUsable then
						_G[Self:GetName() .. "Icon"]:SetVertexColor(1, 1, 1)
					elseif NotEnoughMana then
						_G[Self:GetName() .. "Icon"]:SetVertexColor(0.5, 0.5, 0.5)
					else
						_G[Self:GetName() .. "Icon"]:SetVertexColor(0.4, 0.4, 0.4)
					end

					if ActionHasRange(Self.action) then
						local Type, SpellID = GetActionInfo(Self.action)

						if Type == "macro" then
							_, _, SpellID = GetMacroSpell(SpellID)
						end

						local IsHarmful

						if Type == "item" then
							IsHarmful = IsHarmfulItem
						else
							IsHarmful = IsHarmfulSpell
						end

						if UnitIsConnected("Target") then
							if IsActionInRange(Self.action) == 0 then
								_G[Self:GetName() .. "Icon"]:SetVertexColor(1, 0.2, 0.2)
							elseif (UnitIsDeadOrGhost("Target") or not UnitCanAttack("Player", "Target")) and IsHarmful(GetSpellInfo(SpellID)) then
								_G[Self:GetName() .. "Icon"]:SetVertexColor(1, 0.2, 0.2)
							end
						else
							if IsHarmful(GetSpellInfo(SpellID)) then
								_G[Self:GetName() .. "Icon"]:SetVertexColor(0.4, 0.4, 0.4)
							end
						end
					end
				else
					if GetPetActionSlotUsable(Self:GetID()) then
						_G[Self:GetName() .. "Icon"]:SetVertexColor(1, 1, 1)
					else
						_G[Self:GetName() .. "Icon"]:SetVertexColor(0.4, 0.4, 0.4)
					end
				end

				if Self.BackgroundBottom and not Self.Hovering then
					if Self.action then
						Texture = GetActionTexture(Self.action)
					else
						Texture = select(3, GetPetActionInfo(Self:GetID()))
					end

					if Texture then
						Self.BackgroundBottom:Show()
						Self.BackgroundLeft:Show()
						Self.BackgroundRight:Show()
						Self.BackgroundTop:Show()

						Self.BorderBottom:Show()
						Self.BorderLeft:Show()
						Self.BorderRight:Show()
						Self.BorderTop:Show()
					else
						Self.BackgroundBottom:Hide()
						Self.BackgroundLeft:Hide()
						Self.BackgroundRight:Hide()
						Self.BackgroundTop:Hide()

						Self.BorderBottom:Hide()
						Self.BorderLeft:Hide()
						Self.BorderRight:Hide()
						Self.BorderTop:Hide()
					end
				end
			end

			local function UpdateCooldownText(Self, ElapsedTime)
				Self = Self:GetParent()

				if not Self.Time then
					Self.Time = 0.1
				end

				if (Self.Time + ElapsedTime) >= 0.1 then
					if Self.Text then
						local Duration
						local Start

						if Self.action then
							Start, Duration = GetActionCooldown(Self.action)
						else
							Start, Duration = GetPetActionCooldown(Self:GetID())
						end

						if Duration and (Duration > 2) then
							if (GetTime() - Start) < Duration then
								Self.Text:SetText(GetDuration(Duration - (GetTime() - Start)))
								Self.Text:Show()
							end
						else
							Self.Text:Hide()
							Self:SetScript("OnUpdate", nil)
						end
					else
						Self:SetScript("OnUpdate", nil)
					end

					Self.Time = 0
				else
					Self.Time = Self.Time + ElapsedTime
				end
			end

			for I = 1, #Bars do
				_G[Bars[I].ActionBar]:ClearAllPoints()
				_G[Bars[I].ActionBar]:SetSize((Bars[I].Buttons * Bars[I].Width) + ((Bars[I].Buttons - 1) * 4), Bars[I].Height)

				if Bars[I].UIParent then
					_G[Bars[I].ActionBar]:SetPoint(Bars[I].Anchor, UIParent, Bars[I].X, Bars[I].Y)
				else
					_G[Bars[I].ActionBar]:SetPoint(Bars[I].Anchor, Bars[I].X, Bars[I].Y)
				end

				_G[Bars[I].ActionBar].Index = I
				_G[Bars[I].ActionBar]:SetScript("OnUpdate",
					function(Self, ElapsedTime)
						if not Self.Time then
							Self.Time = 0
						end

						if (Self.Time + ElapsedTime) >= 0.1 then
							for I = 1, Bars[Self.Index].Buttons do
								ActionButton_UpdateUsable(_G[Buttons[Self.Index] .. I])
							end

							Self.Time = 0
						else
							Self.Time = Self.Time + ElapsedTime
						end
					end
				)

				_G[Bars[I].ActionBar].SetPoint = Blank

				for J = 1, Bars[I].Buttons do
					_G[Buttons[I] .. J]:ClearAllPoints()
					_G[Buttons[I] .. J]:GetCheckedTexture():SetAlpha(0)
					_G[Buttons[I] .. J]:GetCheckedTexture().SetAlpha = Blank
					_G[Buttons[I] .. J]:SetNormalTexture(nil)
					_G[Buttons[I] .. J]:SetPoint("LEFT", ((J - 1) * Bars[I].Width) + ((J - 1) * 4) + 3, 0)
					_G[Buttons[I] .. J]:SetSize(Bars[I].Width - 6, Bars[I].Height - 6)
					_G[Buttons[I] .. J]:Show()
					_G[Buttons[I] .. J]:HookScript("OnEnter",
						function(Self)
							Self.Hovering = true

							if Self.BackgroundBottom then
								Self.BackgroundBottom:Show()
								Self.BackgroundLeft:Show()
								Self.BackgroundRight:Show()
								Self.BackgroundTop:Show()

								Self.BorderBottom:Show()
								Self.BorderLeft:Show()
								Self.BorderRight:Show()
								Self.BorderTop:Show()
							end
						end
					)

					_G[Buttons[I] .. J]:HookScript("OnLeave",
						function(Self)
							if Self.BackgroundBottom then
								if _G[Self:GetName() .. "Icon"]:GetTexture() then
									Self.BackgroundBottom:Show()
									Self.BackgroundLeft:Show()
									Self.BackgroundRight:Show()
									Self.BackgroundTop:Show()

									Self.BorderBottom:Show()
									Self.BorderLeft:Show()
									Self.BorderRight:Show()
									Self.BorderTop:Show()
								else
									Self.BackgroundBottom:Hide()
									Self.BackgroundLeft:Hide()
									Self.BackgroundRight:Hide()
									Self.BackgroundTop:Hide()

									Self.BorderBottom:Hide()
									Self.BorderLeft:Hide()
									Self.BorderRight:Hide()
									Self.BorderTop:Hide()
								end
							end

							Self.Hovering = nil
						end
					)

					_G[Buttons[I] .. J].BackgroundBottom = _G[Buttons[I] .. J]:CreateTexture(nil, "LOW")
					_G[Buttons[I] .. J].BackgroundBottom:SetPoint("BOTTOM", 0, -2)
					_G[Buttons[I] .. J].BackgroundBottom:SetSize(Bars[I].Width - 2, 1)
					_G[Buttons[I] .. J].BackgroundBottom:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					_G[Buttons[I] .. J].BackgroundLeft = _G[Buttons[I] .. J]:CreateTexture(nil, "LOW")
					_G[Buttons[I] .. J].BackgroundLeft:SetPoint("LEFT", -2, 0)
					_G[Buttons[I] .. J].BackgroundLeft:SetSize(1, Bars[I].Height - 4)
					_G[Buttons[I] .. J].BackgroundLeft:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					_G[Buttons[I] .. J].BackgroundRight = _G[Buttons[I] .. J]:CreateTexture(nil, "LOW")
					_G[Buttons[I] .. J].BackgroundRight:SetPoint("RIGHT", 2, 0)
					_G[Buttons[I] .. J].BackgroundRight:SetSize(1, Bars[I].Height - 4)
					_G[Buttons[I] .. J].BackgroundRight:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					_G[Buttons[I] .. J].BackgroundTop = _G[Buttons[I] .. J]:CreateTexture(nil, "LOW")
					_G[Buttons[I] .. J].BackgroundTop:SetPoint("TOP", 0, 2)
					_G[Buttons[I] .. J].BackgroundTop:SetSize(Bars[I].Width - 2, 1)
					_G[Buttons[I] .. J].BackgroundTop:SetTexture(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					_G[Buttons[I] .. J].BorderBottom = _G[Buttons[I] .. J]:CreateTexture(nil, "BACKGROUND")
					_G[Buttons[I] .. J].BorderBottom:SetPoint("BOTTOM", 0, -3)
					_G[Buttons[I] .. J].BorderBottom:SetSize(Bars[I].Width, 3)
					_G[Buttons[I] .. J].BorderBottom:SetTexture(0, 0, 0)

					_G[Buttons[I] .. J].BorderLeft = _G[Buttons[I] .. J]:CreateTexture(nil, "BACKGROUND")
					_G[Buttons[I] .. J].BorderLeft:SetPoint("LEFT", -3, 0)
					_G[Buttons[I] .. J].BorderLeft:SetSize(3, Bars[I].Height - 2)
					_G[Buttons[I] .. J].BorderLeft:SetTexture(0, 0, 0)

					_G[Buttons[I] .. J].BorderRight = _G[Buttons[I] .. J]:CreateTexture(nil, "BACKGROUND")
					_G[Buttons[I] .. J].BorderRight:SetPoint("RIGHT", 3, 0)
					_G[Buttons[I] .. J].BorderRight:SetSize(3, Bars[I].Height - 2)
					_G[Buttons[I] .. J].BorderRight:SetTexture(0, 0, 0)

					_G[Buttons[I] .. J].BorderTop = _G[Buttons[I] .. J]:CreateTexture(nil, "BACKGROUND")
					_G[Buttons[I] .. J].BorderTop:SetPoint("TOP", 0, 3)
					_G[Buttons[I] .. J].BorderTop:SetSize(Bars[I].Width, 3)
					_G[Buttons[I] .. J].BorderTop:SetTexture(0, 0, 0)

					_G[Buttons[I] .. J].Hide = Blank
					_G[Buttons[I] .. J].SetNormalTexture = Blank

					_G[Buttons[I] .. J].Text = _G[Buttons[I] .. J .. "Cooldown"]:CreateFontString(nil, "OVERLAY")
					_G[Buttons[I] .. J].Text:Hide()
					_G[Buttons[I] .. J].Text:SetFont(Configuration.Font.Name, Configuration.Font.Size, Configuration.Font.Outline)
					_G[Buttons[I] .. J].Text:SetPoint("CENTER", 1, 0)
					_G[Buttons[I] .. J].Text:SetTextColor(RAID_CLASS_COLORS[Class].r, RAID_CLASS_COLORS[Class].g, RAID_CLASS_COLORS[Class].b)

					_G[Buttons[I] .. J .. "Border"]:SetAlpha(0)
					_G[Buttons[I] .. J .. "Border"].SetVertexColor = Blank

					_G[Buttons[I] .. J .. "Cooldown"]:SetSize(Bars[I].Width - 6, Bars[I].Height - 6)
					_G[Buttons[I] .. J .. "Cooldown"]:SetPoint("CENTER")
					_G[Buttons[I] .. J .. "Cooldown"]:HookScript("OnHide",
						function(Self)
							Self:SetScript("OnUpdate", nil)
						end
					)

					_G[Buttons[I] .. J .. "Cooldown"]:HookScript("OnShow",
						function(Self)
							Self.Time = 0.1
							Self:SetScript("OnUpdate", UpdateCooldownText)
						end
					)

					if _G[Buttons[I] .. J .. "Cooldown"]:IsShown() then
						_G[Buttons[I] .. J .. "Cooldown"].Time = 0.1
						_G[Buttons[I] .. J .. "Cooldown"]:SetScript("OnUpdate", UpdateCooldownText)
					end
					
					_G[Buttons[I] .. J .. "Count"]:SetAlpha(0)
					_G[Buttons[I] .. J .. "Count"].SetAlpha = Blank

					_G[Buttons[I] .. J .. "FlyoutBorder"]:SetAlpha(0)
					_G[Buttons[I] .. J .. "FlyoutBorderShadow"]:SetAlpha(0) 

					_G[Buttons[I] .. J .. "HotKey"]:SetAlpha(0)
					_G[Buttons[I] .. J .. "HotKey"].SetAlpha = Blank

					_G[Buttons[I] .. J .. "Icon"]:SetTexCoord(Bars[I].TextureCoordinate.Left, Bars[I].TextureCoordinate.Right, Bars[I].TextureCoordinate.Top, Bars[I].TextureCoordinate.Bottom)
					
					_G[Buttons[I] .. J .. "Name"]:SetAlpha(0)
					_G[Buttons[I] .. J .. "Name"].SetAlpha = Blank

					if _G[Buttons[I] .. J .. "AutoCastable"] then
						_G[Buttons[I] .. J .. "AutoCastable"]:SetAlpha(0)
					end

					if _G[Buttons[I] .. J .. "FloatingBG"] then
						_G[Buttons[I] .. J .. "FloatingBG"]:SetAlpha(0)
					end

					if _G[Buttons[I] .. J .. "Shine"] then
						_G[Buttons[I] .. J .. "Shine"]:SetAllPoints(_G[Buttons[I] .. J])
					end
				end
			end
		end
	end
end
