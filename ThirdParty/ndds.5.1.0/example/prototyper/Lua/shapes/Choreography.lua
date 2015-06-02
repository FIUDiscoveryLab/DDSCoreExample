--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---Choreography
-- Perform queries on streaming data (pub-sub). Mediates between pub-sub and 
-- request-reply communication patterns.
--  
-- Subscribes shapes and requests (last reader). Publishes responses.
--  
-- HOW TO?
-- rtiddsprototyper -cfgFile Choreography.xml 
--              -cfgName ChoreographyParticipantLibrary::ChoreographyParticipant 
--              -luaOnPeriod false
-- 
-- ShapesDemo: 
-- 		Publish Squares, Circles, Triangles of various colors.
-- 	
-- DataStoreApp (connextras)
-- DataStoreServer (connextras)
-- 		terminate it after it starts	
-- 			needed just to tell the DataStoreApp client to startup (discovery) 	 	
-- DataStoreApp (connextras)	 	  
-- 		r red
-- 			reports the current location of RED shapes
-- 		r blue
-- 			reports the current location of BLUE shapes
--     and so on

-- Interface: parameters, inputs, outputs
-- Input: First N-1 readers
local RequestReader = CONTAINER.READER[#CONTAINER.READER] -- last reader
-- Output:
local ReplyWriter   = CONTAINER.WRITER[#CONTAINER.WRITER] -- last writer


-- Globals (preserved across invocations)  
if not Shapes then Shapes={} end -- cache containing shape color location
if not NAME then NAME={ 'square', 'circle', 'triangle' } end -- constant

-- process streaming data : cache the latest location for a shape color ---
for r = 1, #CONTAINER.READER-1 do
	local reader = CONTAINER.READER[r]
	reader:take()
	
	-- cache the last value of each color for each shape ---
	for i, shape in ipairs(reader.samples) do
	
		if (not reader.infos[i].valid_data) then break end
			
		local color = shape['color']
		if not Shapes[color] then Shapes[color] = {} end
		if not Shapes[color][r] then Shapes[color][r] = {} end
		
		Shapes[color][r].x  =  shape['x']
		Shapes[color][r].y  =  shape['y']
		
		-- print(color, NAME[r], Shapes[color][r].x, Shapes[color][r].y)
	end
end

-- process requests ---
RequestReader:take()
for i, request in ipairs(RequestReader.samples) do
				
	if (not RequestReader.infos[i].valid_data) then break end
			
	local request = RequestReader.samples[i]
	local op = request['interaction.operation.op_name']  
		
	if op ~= 'get' then return end 	-- implements only the 'get' operation
	print(op, request['interaction.client.uri'])
	
	local color = string.upper(request['input.param[1]'])
	
	local result = ''	
	if Shapes[color] then
		for i, shape in pairs(Shapes[color]) do
			result = result .. NAME[i] .. '{' .. shape.x .. ', ' .. shape.y .. '} '
		end
	end
	print(color, result, "\n")
		
	-- reply --
	local reply = ReplyWriter.instance
	reply['output.param'] = result
	reply['error.param'] = ''
	reply['status'] = 3 -- DONE_SUCCESS
	
	reply['interaction.session_id']              = request['interaction.session_id']
	reply['interaction.client.uri']              = request['interaction.client.uri']
	reply['interaction.server.uri']              = request['interaction.server.uri']
	reply['interaction.operation.if_name']       = request['interaction.operation.if_name']
	reply['interaction.operation.op_name']       = request['interaction.operation.op_name']	
	reply['interaction.operation.invocation_id'] = request['interaction.operation.invocation_id']
	
	ReplyWriter:write()  
end
