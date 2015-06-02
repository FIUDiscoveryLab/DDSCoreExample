--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

-- rtiddsprototyper  -luaFile tables.lua -luaOnStart true -luaOnStop true -luaOnData true -luaOnPeriod true

-- Globals (preserved across invocations)
if not count then count = 0 else count = count + 1 end
print("*** iteration ", count,  "***")

print("WRITER:")
local WRITER = CONTAINER.WRITER
for name,writer in pairs(WRITER) do
   	print(name, writer)
end

print("READER:")
local READER = CONTAINER.READER
for name,reader in pairs(READER) do
   	print(name, reader)
end

print("CONTEXT")
local CONTEXT = CONTAINER.CONTEXT
for name,value in pairs(CONTEXT) do
   	print(name, value)
end

-- terminate execution
CONTEXT.intentExit = true
