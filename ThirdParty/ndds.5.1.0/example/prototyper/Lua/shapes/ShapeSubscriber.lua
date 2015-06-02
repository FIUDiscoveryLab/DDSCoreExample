--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---ShapeSubscriber
-- Subscribes to all the shapes and print them on standard output.
-- 
-- HOW TO?
-- rtiddsprototyper -cfgName MyParticipantLibrary::ShapeSubscriber
-- ShapesDemo: 
-- 		Publish various shapes 
-- Watch the samples on the command line

-- Interface: parameters, inputs, outputs
-- Input: All the configured readers

-- Globals (preserved across invocations)
if not count then count = 0 else count = count + 1 end
print("*** iteration ", count,  "***")

-- Iterate over all the readers
for name,reader in pairs(CONTAINER.READER) do 

	print("READER", name)
	reader:take()

	for  i, shape in ipairs(reader.samples) do

		print("\t color:", shape['color']) -- key

		if (not reader.infos[i].valid_data) then
			print("\t invalid data!")
		end

		print("\t x:", shape['x']) 
		print("\t y:", shape['y'])
		print("\t shapesize:", shape['shapesize'])

	end
end
