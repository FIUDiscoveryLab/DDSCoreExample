--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---Correlator
-- Correlate the first two shape streams (Square, Circle) and output them as the
-- last shape stream (Triangle).
-- 
-- The output stream has the same position ad the 1st stream, but the size is 
-- defined by the 'x' position of the 2nd stream, if any, of the same color.
-- 
-- HOW TO?
-- rtiddsprototyper -cfgName MyParticipantLibrary::ShapePubSub 
--                  -luaFile shapes/Correlator.lua
-- 
-- ShapesDemo: 
-- 		1. Publish Squares and Circles of different colors  
-- 		2. Subscribe to Triangle topic 
-- 			The Triangle position should mirror that of the Squares and the size
-- 			should equal the 'x' position if Circles of the same color (if any).

-- Interface: parameters, inputs, outputs
local reader1   = CONTAINER.READER[1]
local reader2   = CONTAINER.READER[2]
local writer    = CONTAINER.WRITER[#CONTAINER.WRITER]

-- Globals (preserved across invocations)
if not shapesize then shapesize={} end -- shapesize of the output stream

-- Cache the 'shapesize' for a color from the 2nd input stream ---
reader2:take()
for i, shape in ipairs(reader2.samples)  do 

	if (not reader2.infos[i].valid_data) then break end
	
	local color = shape['color']
	shapesize[color] = shape['x']
end

-- Merge the 'shapesize' for a color with x and y from the 1st input stream ---
reader1:take()
for i, shape in ipairs(reader1.samples) do

	if (not reader1.infos[i].valid_data) then break end

	local color = shape['color']
		
	writer.instance['color'] = color
	writer.instance['x'] = shape['x']
	writer.instance['y'] = shape['y']
	
	writer.instance['shapesize'] = shapesize[color] or shape['shapesize']

	writer:write()
end
