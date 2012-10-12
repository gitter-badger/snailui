-- VendorAutoRepair.lua
-- Written by Snail

function HandleVendorAutoRepair(Self)
    if Self.Frame == "Player" then
        Self:RegisterEvent("MERCHANT_SHOW",
            function()
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
end
