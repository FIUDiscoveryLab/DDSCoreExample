--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---FileInputAdaptor
-- Reads a FILE (stdin by default) one line at a time, looks for data in the
-- format:
--           size;x;y
-- and publishes it as a shape of COLOR on the 1st shape writer.
-- 
-- To exit the loop type in the following special value (i.e. a size of 0):
--           0;0;0
-- 
-- HOW TO?
-- rtiddsprototyper -cfgName MyParticipantLibrary::ShapePublisher 
--                  -luaFile shapes/Figure8.lua -period 0.1 
-- ShapesDemo: 
-- 		Subscribe to Triangle topic
-- Change FILE parameter to read from a serial device

-- Interface: parameters, inputs, outputs
local FILE -- = "/dev/tty.usbserial-A600aeEE"
local COLOR = "RED"
local writer = CONTAINER.WRITER[3] -- Triangles


-- Read from FILE
io.input(FILE)

local isNotValid = true
while isNotValid do
  local line = io.read('*line')
  --print("line", line)
  if line then
    _,_,size,x,y = line:find('(%d+);(%d+);(%d+)')
    if size and x and y then
      isNotValid = false;
      print('x=' .. x .. ',y=' .. y .. ',size=' .. size .. '\n')
    end
  end
end

-- Processing and preparing the data
writer.instance['color'] = COLOR
writer.instance['x'] = tonumber(x)
writer.instance['y'] = tonumber(y)
writer.instance['shapesize'] = tonumber(size)

-- Output the data
writer:write()

-- Stop?
if (tonumber(size)==0) then CONTAINER.CONTEXT.intentExit = true end
