
local me = UnitName("player")
local function Print(...) print("|cFF33FF99[GroupCalenNagger]|r", ...) end
local GC4users = setmetatable({}, {__newindex = function(t,i,v) rawset(t,i,v); if v and i ~= me then Print("Discovered user:", i, v) end end})


local lastsend = 0

local f = CreateFrame("Frame")
f:RegisterEvent("CHAT_MSG_ADDON")
f:SetScript("OnEvent", function(self, event, prefix, msg, channel, sender)
	if prefix == "GC4" then
		local v = msg:match("VER:([%d.]+)")
		GC4users[sender] = v
		if v and (lastsend + 60) < GetTime() then
			lastsend = GetTime()
			SendAddonMessage("GC4", "VER:5.0,298169999", "GUILD")
		end
	end
end)
