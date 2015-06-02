--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---Aggregator
-- Subscribes to the first two shapes topics (Square, Circle) and aggregates 
-- them on the last shape topic (Triangle).
--  
-- HOW TO?
-- rtiddsprototyper -cfgName MyParticipantLibrary::ShapePubSub 
--                  -luaFile shapes/Aggregator.lua
-- 
-- ShapesDemo: 
--		1. Publish Squares and Circles of different colors  
-- 		2. Subscribe to Triangle topic 
-- 				The Triangles should mirror the Squares and Circles

-- Interface: parameters, shapes, outputs
-- shape: First two readers
local writer = CONTAINER.WRITER[#CONTAINER.WRITER] -- Triangles

for r = 1,2 do -- aggregate samples from the first two readers
	reader = CONTAINER.READER[r]
	reader:take()

	for i, shape in ipairs(reader.samples) do

		if (not reader.infos[i].valid_data) then break end
		
		-- if shape['color'] ~= "RED" then break end
		
		writer.instance['color'] = shape['color']
		writer.instance['x'] = shape['x']
		writer.instance['y'] = shape['y'] 
		writer.instance['shapesize'] = shape['shapesize'] 

		writer:write()    	
	end
end
