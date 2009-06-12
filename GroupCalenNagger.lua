
local function Print(...) print("|cFF33FF99[GroupCalenNagger]|r", ...) end
local GC5users, GC4users = {}, setmetatable({}, {__newindex = function(t,i,v) rawset(t,i,v); if not GC5users[i] then Print("Discovered GC4 user:", i) end end})


local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", function(self, event, prefix, msg, channel, sender) if prefix == "GC4" then GC4users[sender] = true elseif prefix == "GC5" then GC5users[sender] = true end end)


local function dump()
	local tmp1, tmp2 = {}, {}
	for user in pairs(GC4users) do
		table.insert(GC5users[user] and tmp1 or tmp2, user)
	end
	if (#tmp1 + #tmp2) == 0 then
		Print("No one appears to be using an outdated version of GroupCalendar.  You may need to wait a short time for users to expose themselves on the hidden addon channel.")
	else
		if #tmp2 > 0 then Print("Users with 4.5:", unpack(tmp2)) end
		if #tmp1 > 0 then Print("Users with 4.5 and 5.0:", unpack(tmp1)) end
		Print("Type '/gcnag send' to bother 4.5 users and '/gcnag all' to nag 4.5 users and users with both versions.")
	end
end


local function nag(extranaggy)
	for user in pairs(GC4users) do
		if not GC5users[user] then
			SendChatMessage("[GroupCalendar5] You are running an incompatible version of GroupCalendar.  Please upgrade to GroupCalendar5 at curse.com", "WHISPER", GetDefaultLanguage("player"), user)
		elseif extranaggy then
			SendChatMessage("[GroupCalendar5] You are running both GroupCalendar 4.5 and 5.0.  Please you should disable 4.5 as it is not compatible with 5.0", "WHISPER", GetDefaultLanguage("player"), user)
		end
	end
end


SLASH_ADDONTEMPLATE1 = "/gcnag"
SlashCmdList.ADDONTEMPLATE = function(msg) if msg == "send" then nag() elseif msg == "all" then nag(true) else dump() end end


TEK = {[4] = GC4users, [5] = GC5users}
