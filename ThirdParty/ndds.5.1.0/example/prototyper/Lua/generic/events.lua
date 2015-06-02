--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

-- rtiddsprototyper -luaFile events.lua -luaOnStart true -luaOnStop true -luaOnData true -luaOnPeriod true

-- Globals (preserved across invocations)
if not count then count = 0 else count = count + 1 end
print("*** iteration ", count,  " ***")

if CONTAINER.CONTEXT.onStartEvent then
	print("onStartEvent")
end

if CONTAINER.CONTEXT.onDataEvent then
	print("onDataEvent")
end

if CONTAINER.CONTEXT.onPeriodEvent then
	print("onPeriodEvent")
end

if CONTAINER.CONTEXT.onStopEvent then
	print("onStopEvent")	
end

--CONTAINER.CONTEXT.intentExit=true
