function searchItemInContainer(container, foundItems)    
    for k = (getContainerSize(container) - 1), 0, -1 do
        local tmp = getContainerItem(container, k)
        
        if (isInArray(cannotBeTraded, tmp.itemid)) then	
    		foundItems = foundItems + 1
        elseif isContainer(tmp.uid) then
        	searchItemInContainer(tmp.uid, foundItems)
        end
    end
end

function canTradePremiumScroll(item)

	local unusableCount = 0
	
	function searchAlreadyUsedPremiumScrolls(container)
	    for k = (getContainerSize(container) - 1), 0, -1 do
	        local tmp = getContainerItem(container, k)
	        
	        if (tmp.itemid == CUSTOM_ITEMS.PREMIUM_SCROLL) then	
	        
	        	local log_id = getItemAttribute(tmp.uid, "itemShopLogId")
	        	
	        	if(not log_id or not canUseShopItem(log_id)) then
	        	
	        		unusableCount = unusableCount + 1
	        	end
	        elseif isContainer(tmp.uid) then
	        	searchAlreadyUsedPremiumScrolls(tmp.uid)
	        end
	    end
	end	
	
	if(isContainer(item.uid)) then
		searchAlreadyUsedPremiumScrolls(item.uid)	
	else
		if(item.itemid == CUSTOM_ITEMS.PREMIUM_SCROLL) then				
        	local log_id = getItemAttribute(item.uid, "itemShopLogId")
        	
        	if(not log_id or not canUseShopItem(log_id)) then
        	
        		unusableCount = unusableCount + 1
        	end			
		end	
	end
	
	if(unusableCount > 0) then
		return false
	end
	
	return true
end

function onTradeAccept(cid, target, item, targetItem)

	local foundItems = 0
	
	--[[
	if(isContainer(item.uid)) then
		searchItemInContainer(item.uid, foundItems)
	else
		if(isInArray(cannotBeTraded, item.itemid)) then	
			foundItems = foundItems + 1
		end
	end
	
	if(isContainer(targetItem.uid)) then
		searchItemInContainer(targetItem.uid, foundItems)
	else
		if(isInArray(cannotBeTraded, targetItem.itemid)) then	
			foundItems = foundItems + 1
		end
	end	
	]]--
	
	if(not canTradePremiumScroll(item) or not canTradePremiumScroll(targetItem)) then
		foundItems = 1
	end
	
	if(foundItems > 0) then
	
		local msg = "Você ou seu parceiro de troca colocou um item não trocavel. Remova itens não trocaveis e tente novamente."
	
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, msg)
		doPlayerSendTextMessage(target, MESSAGE_INFO_DESCR, msg)

		return false
	end
	
	return true
end