--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---ShapePublisher
-- Publish Circle and Triangle shapes to make an interesting pattern. Terminate
-- after a number of iterations. Dispose the data upon stopping. 
-- 
-- HOW TO?
-- rtiddsprototyper -cfgName MyParticipantLibrary::ShapePublisher -luaOnStop true
-- ShapesDemo: 
-- 		Subscribe to Circle & Triangle with a history of 25

-- Interface: parameters, inputs, outputs
local MyCircleWriter = CONTAINER.WRITER['MyPublisher::MyCircleWriter']
local MyTriangleWriter = CONTAINER.WRITER['MyPublisher::MyTriangleWriter']

-- Globals (preserved across invocations)
if count then count = count + 1 
else -- initialize (first time)
	count = 0
	center = 120; radius = 70; yAmplitude = 100 
end
-- print("*** iteration ", count,  "***")


-- Write a RED circle on a 'circular' trajectory     
local circle = MyCircleWriter.instance
circle['color'] = 'RED'
circle['x'] = center + radius * math.sin(count)
circle['y'] = center + radius * math.cos(count) 
circle['shapesize'] = 30

MyCircleWriter:write()


-- Write a YELLOW Triangle on a 'vertical' trajectory  
local triangle = MyTriangleWriter.instance
triangle['color'] = "YELLOW"
triangle['x'] = center --  radius * math.sin(count);
triangle['y'] = center  + yAmplitude * math.cos(count)
triangle['shapesize'] = 30

MyTriangleWriter:write()



-- Dispose the data objects upon stopping:
if CONTAINER.CONTEXT.onStopEvent then
	print("disposing")
	MyCircleWriter:dispose()
	MyTriangleWriter:dispose()
end

-- stop the simulation after N iterations
if count > 25 then CONTAINER.CONTEXT.intentExit = true end
