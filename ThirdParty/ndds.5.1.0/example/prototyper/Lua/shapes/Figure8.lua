--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---Figure Eight Curve
-- Draw a curve in the shape of a figure eight, varying the thickness.
-- 
-- HOW TO?
-- rtiddsprototyper -cfgName MyParticipantLibrary::ShapePublisher 
--                  -luaFile shapes/Figure8.lua -period 0.1 
-- ShapesDemo: 
-- 		Subscribe to Triangle topic with a history of 25

-- Interface: parameters, inputs, outputs
local ShapeWriter = CONTAINER.WRITER[3] -- Triangles

-- Global counter (preserved across invocations)  
if not count then count = 0 else count = count + 1  end  

local shape = ShapeWriter.instance;
 
shape['x']         = 120 +  70*math.sin(count/4)  
shape['y']         = 120 + 100*math.cos(count/8)  
shape['shapesize'] =  30 +  20*math.sin(count/10)  

shape['color'] = "GREEN"
if shape['y'] > 100 then shape['color']="PURPLE" end

ShapeWriter:write()
