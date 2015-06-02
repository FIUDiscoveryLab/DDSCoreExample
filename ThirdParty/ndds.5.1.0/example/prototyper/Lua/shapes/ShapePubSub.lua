--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---ShapePubSub
-- Subscribes to Squares and transforms them to Triangles of different size, give
-- by the SHAPE_FACTOR.
--  
-- HOW TO?
-- rtiddsprototyper -cfgName MyParticipantLibrary::ShapePubSub 
-- ShapesDemo: 
-- 		1. Publish Squares of different colors  
-- 		2. Subscribe to Triangles. Watch then track the squares, scaled by a factor.
-- Change SHAPE_FACTOR to watch the triangle change size. 

-- Interface: parameters, inputs, outputs
local SIZE_FACTOR = 0.5 -- change the factor to see the size changing
local reader = CONTAINER.READER['MySubscriber::MySquareReader'] 
local writer = CONTAINER.WRITER['MyPublisher::MyTriangleWriter']

reader:take()

for i, shape in ipairs(reader.samples) do

	if (not reader.infos[i].valid_data) then break end
	
	writer.instance['color'] = shape['color']
	writer.instance['x'] = shape['x']
	writer.instance['y'] = shape['y']
	writer.instance['shapesize'] = shape['shapesize'] * SIZE_FACTOR

	writer:write()    	
end
