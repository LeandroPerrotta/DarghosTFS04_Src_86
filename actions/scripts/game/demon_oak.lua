function onUse(cid, item, frompos, item2, topos)

	if(item.actionid == aid.DEMON_OAK_DEAD_TREE) then
		return useOnDeadTree(cid, item, frompos, item2, topos)
	end
end

function useOnDeadTree(cid, item, frompos, item2, topos)

	local level = getPlayerLevel(cid)
	if(level < 120) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "You must be level 120 or higher to across.")
		return true
	end	
	
	local questStatus = getGlobalStorageValue(gid.DEMON_OAK_STATUS)
	if(questStatus == 1) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "Another player already in there.")
		return true
	end
	
	local taskStatus = getPlayerStorageValue(cid, sid.TASK_KILL_DEMONS) or false
	if(not taskStatus) then
		doPlayerSendTextMessage(cid, MESSAGE_EVENT_DEFAULT, "You need special permission from Oldrak to go inside.")
		return true		
	end
	
	topos.y = topos.y + 1
	
    doTeleportThing(cid, topos, true)
    doSendMagicEffect(topos, CONST_ME_TELEPORT)
    doSendMagicEffect(frompos, CONST_ME_POFF)
    
    setGlobalStorageValue(gid.DEMON_OAK_STATUS, 1)
end