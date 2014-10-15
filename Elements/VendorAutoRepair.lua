--
-- Copyright (C) 2012-2014 Snailsoft <http://www.snailsoft.me/>
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

function HandleVendorAutoRepair()
	local VendorAutoRepair = CreateFrame("Frame", nil, UIParent)

	VendorAutoRepair:RegisterEvent("MERCHANT_SHOW")
	VendorAutoRepair:SetScript("OnEvent",
		function(Self)
			for I = 0, NUM_BAG_FRAMES do
				for J = 1, GetContainerNumSlots(I) do
					local ItemLink = GetContainerItemLink(I, J)

					if ItemLink then
						if select(3, GetItemInfo(ItemLink)) == 0 then
							UseContainerItem(I, J)
						end
					end
				end
			end
			
			if CanMerchantRepair() then
				local RepairCost = GetRepairAllCost()

				if RepairCost > 0 then
					local Money = GetMoney()

					if CanGuildBankRepair() then
						local GuildRepairAllowance = GetGuildBankWithdrawMoney()

						if GuildRepairAllowance > GetGuildBankMoney() then
							GuildRepairAllowance = GetGuildBankMoney()
						end

						if GuildRepairAllowance >= RepairCost then
							RepairAllItems(1)
						elseif Money >= RepairCost then
							RepairAllItems()
						end
					elseif Money >= RepairCost then
						RepairAllItems()
					end
				end
			end
		end
	)
end
