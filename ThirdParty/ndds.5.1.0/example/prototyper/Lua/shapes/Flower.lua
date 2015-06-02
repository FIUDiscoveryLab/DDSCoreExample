--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---Flower: Hypocycloid Curves
-- Draw flower shaped curves. Change the parameter C below to see the 
-- flowers change forms in real-time.
-- 
-- HOW TO?
-- rtiddsprototyper -cfgName MyParticipantLibrary::ShapePublisher 
--                  -luaFile shapes/Flower.lua -period 0.01
-- ShapesDemo: 
-- Subscribe to Triangle topic with a history of 500
-- Change the "C" parameter to see various forms

-- Interface: parameters, inputs, outputs
local A, B, C = 30, 30, 10 -- Change the 'C' parameter to to see various flower shapes 
local ShapeWriter = CONTAINER.WRITER[3] -- Triangles

-- Global counter (preserved across invocations)  
if not count then count = 0 else count = count + 1  end  

local shape = ShapeWriter.instance;
local angle = count % 360;

shape['x']         = 120 + (A+B) * math.cos(angle) + B * math.cos((A/B-C)*angle)  
shape['y']         = 120 + (A+B) * math.sin(angle) + B * math.sin((A/B-C)*angle)

shape['shapesize'] = 5

shape['color'] = "RED"
-- if count % 2 == 0 then shape['color'] = "YELLOW" end

ShapeWriter:write()
