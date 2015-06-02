--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---MouseInputAdaptor
-- Reads the mouse device and publishes the mouse actions as Shapes
--      Left-Click      -->   Shape Color: Rotate to next color in COLOR array
--		Right-Click     -->   Exit
--      Wheel Up        -->   Increase shape size
--      Wheel Down      -->   Decrease shape size
--      Left Movement   -->   Increase x position
--      Right Movement  -->   Decrease x position
--      Down Movement   -->   Increase y position
--      Up Movement     -->   Decrease y position
--
-- HOW TO?
-- 
-- Build the DLL to wit for mouse events:
-- 			make 
-- NOTE: tested on Raspberry Pi only
-- 
-- rtiddsprototyper -cfgFile ../../USER_QOS_PROFILES.xml 
-- 					-cfgName MyParticipantLibrary::ShapePublisher 
--                  -luaFile shapes/MouseInputAdaptor.lua 
-- 
-- ShapesDemo: Subscribe to Square topic
-- Change DEVICE parameter to read from an alternative device

-- Interface: parameters, inputs, outputs
local DEVICE = "/dev/input/event0"
local writer = CONTAINER.WRITER[2] 

require("mouse")

-- Globals (preserved across invocations)
if x==nil then 
  SIZE_LOWER = 6
  SIZE_UPPER = 200
  MOST_RIGHT = 256
  MOST_DOWN  = 256
  ZOOM_UP_FACTOR   = 1.5
  ZOOM_DOWN_FACTOR = 1/ZOOM_UP_FACTOR
  MOVE_FACTOR      = 10
  COLORS={"PURPLE","BLUE", "RED", "GREEN", "YELLOW", "CYAN", "MAGENTA", "ORANGE"}
  leftUp=true
  x = 128
  y = 128
  size = 30
  colorIndex = 1;
end

-- Wait for a mouse event
event = mouse(DEVICE)

-- Find out what event and update the shape
if event == "LEFT_CLICK" then
  colorIndex = ((colorIndex+1)%#COLORS)+1 
elseif event == "RIGHT_CLICK" then 
  CONTAINER.CONTEXT.intentExit = true
elseif event == "WHEEL_UP" then
  size=size*ZOOM_UP_FACTOR
  if size > SIZE_UPPER then size=SIZE_UPPER end
elseif event == "WHEEL_DOWN" then
  size = size*ZOOM_DOWN_FACTOR
  if size < SIZE_LOWER then size = SIZE_LOWER end
elseif event == "RIGHT" then
  x=x+MOVE_FACTOR
  if x > MOST_RIGHT then x=MOST_RIGHT end
elseif event == "LEFT" then
  x=x-MOVE_FACTOR
  if x < 0 then x=0 end
elseif event == "DOWN" then
  y=y+MOVE_FACTOR
  if y > MOST_DOWN then y=MOST_DOWN end
elseif event == "UP" then
  y=y-MOVE_FACTOR
  if y < 0 then y=0 end
end

--Print on the command line
print("x     = " .. x)
print("y     = " .. y)
print("size  = " .. size)
print("color = " .. COLORS[colorIndex])


-- Publish shape with the new values
local shape = writer.instance
shape['color'] = COLORS[colorIndex]
shape['x'] = x
shape['y'] = y
shape['shapesize'] = size

writer:write()
