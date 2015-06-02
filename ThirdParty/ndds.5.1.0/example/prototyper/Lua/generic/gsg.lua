--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

--- gsg.lua
-- Getting Started Guide: Lua Code Fragments.
-- Use to illustrate the Lua component programming API.
-- Used to cut-n-paste syntax highlighted into the Getting Started Guide.

-- rtiddsprototyper -luaFile gsg.lua


-- Globals (preserved across invocations)
if not count then count = 0 else count = count + 1 end
print("\n*** iteration ", count,  " ***")

if CONTAINER == PROTOTYPER then print("PROTOTYPER", PROTOTYPER) end

print("--Accessing an invalid READER or WRITER returns 'nil'")
print("Invalid READER name", CONTAINER.READER["MY_INVALID_NAME"])
print("Invalid READER index", CONTAINER.READER[1+#CONTAINER.READER])
print("Invalid WRITER name", CONTAINER.WRITER["MY_INVALID_NAME"])
print("Invalid WRITER index", CONTAINER.WRITER[1+#CONTAINER.WRITER])

print("--Iterator: numeric for loops")
for r = 1, #CONTAINER.READER do
	local reader = CONTAINER.READER[r]
	print("READER", r)
	reader:read()
	for i = 1, #reader.samples do
		print("\t", i, "color:", reader.samples[i]['color'])
	end
end

print("--Iterator: generic and numeric for loop")
for name,reader in pairs(CONTAINER.READER) do
	print("READER", name)
	reader:read()
	for i = 1, #reader.samples do
		print("\t", i, "color:", reader.samples[i]['color'])
	end
end

print("--Iterator: generic for loops")
for name,reader in pairs(CONTAINER.READER) do
	print("READER", name)
	reader:read()
	for i, shape in ipairs(reader.samples) do 
		print("\t", i, "color:", shape['color'])
	end
	for i, info in ipairs(reader.infos) do 
		print("\t", i, "valid_data:", info.valid_data) 
	end
end 


print("--Retrieving an invalid field returns 'nil'")
for name,reader in pairs(CONTAINER.READER) do
	print("READER", name)
	reader:read()
	for i = 1, #reader.samples do
		print("\t", i, "BAD.MY_INVALID_FIELD:", reader.samples[i]['BAD.MY_INVALID_FIELD'])
	end
end

print("--Setting a sample field is a 'no-op' and logs a warning")
for name,reader in pairs(CONTAINER.READER) do
	print("READER", name)
	reader:read()
	for i = 1, #reader.samples do
		reader.samples[i]['color'] = "RED"
	end
end

print("--Setting an invalid field on an instance is a 'no-op' and logs a warning")
for name,writer in pairs(CONTAINER.WRITER) do
	print("WRITER", name)
	-- writer.instance['BAD.MY_INVALID_FIELD'] = "RED"
	writer.instance['color'] = "RED_from_gsg.lua"
	writer:write()
end

print("--Empty reader caches by taking all the samples")
for name,reader in pairs(CONTAINER.READER) do
	print("READER", name) 
	reader:take()
end


--- Getting Started Guide Code Fragments from the section
-- 			"The Lua Engine Programming Model"
--
print("--The Lua Engine Programming Model")

local foo = 'HelloPublisher::HelloWriter'
-- or --
local foo = 1

local WRITER = CONTAINER.WRITER

local foo_writer = WRITER[foo]

local data = foo_writer.instance

foo_writer.instance['x'] = 100   
foo_writer.instance['y'] = 100   
foo_writer.instance['shapesize'] = 30   
foo_writer.instance['color'] = "BLUE"  

foo_writer:write()
foo_writer:dispose()
foo_writer:unregister()


local foo = 'HelloPublisher::HelloReader'
-- or --
local foo = 1

local READER = CONTAINER.READER
local foo_reader = READER[foo]

print("Number of infos:",
                  #foo_reader.infos)
print("Number of samples:",
                  #foo_reader.samples)
                            
for i = 1, #foo_reader.infos do
  print("\t valid_data:",  
           foo_reader.infos[i].valid_data)
end
-- or --
for i, info in ipairs(foo_reader.infos) do
  print("\t valid_data:",  
          		 info.valid_data)
end


for i = 1, #foo_reader.samples do
  print("\t color:",  -- key
           foo_reader.samples[i]['color'])

  if (not foo_reader.infos[i].valid_data)
  then
     print("\t invalid data!")
  end

  print("\t x:",
               foo_reader.samples[i]['x'])
  print("\t y:",
               foo_reader.samples[i]['y'])    
  print("\t shapesize:",
       foo_reader.samples[i]['shapesize'])

end
-- or --
for i, shape in ipairs(foo_reader.samples) do
  print("\t color:", shape['color']) -- key

  if (not foo_reader.infos[i].valid_data)
  then
     print("\t invalid data!")
  end

  print("\t x:", shape['x'])
  print("\t y:", shape['y'])    
  print("\t shapesize:", shape['shapesize'])

end

foo_reader:take()
foo_reader:read()
       
--CONTAINER.CONTEXT.intentExit=true
