--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

---SplitterDelayNAverage
-- Subscribes to an input shape stream, and publishes two derived output streams
--   1. an output steam matching the input, but delayed by MAX_HISTORY samples 
--   2. an output that is the moving average of the last MAX_HISTORY samples
--   
-- HOW TO?
-- rtiddsprototyper -cfgName MyParticipantLibrary::ShapePubSub
--                  -luaFile shapes/SpiltterDelayNAverage -luaOnStop true
-- ShapesDemo: 
-- 1. Publish a Square. Let it bounce horizontally, left and right.
--2. Subscribe to Square and Circles with a history of MAX_HISTORY to 
--   watch the trailing delayed Circles 
-- 3. Subscribe to Triangle topic to watch the moving average of Square 
--    topic over the last MAX_HISTORY samples

-- Interface: parameters, inputs, outputs
local MAX_HISTORY = 6
local reader = CONTAINER.READER[1] -- Square
local delay_writer  = CONTAINER.WRITER[#CONTAINER.WRITER-1] -- Circle
local average_writer  = CONTAINER.WRITER[#CONTAINER.WRITER]   -- Triangle 

-- Function-object (closure) to maintain a first-in-first-out (FIFO) queue  
function newFifo (max_h)
	local index = 0
	local history = {}
	local max_history = max_h
	return function (element)
		if index == max_history then index = 1 else index=index+1 end
		oldest = history[index] 
		history[index] = element
		return oldest, #history
	end 
end

--- Re-publish input delayed by by MAX_HISTORY samples
function delay()
	-- Globals (preserved across invocations)
	if not delay_size_history then   
		delay_x_history    = {}  
		delay_y_history    = {}  
		delay_size_history = {}   
	end  

	-- Iterate over each sample we got  
	for i, shape in ipairs(reader.samples) do    
		local color = shape['color']
		local x = shape['x']
		local y = shape['y']
		local size = shape['shapesize']

		-- SKIP sample if data is not valid
		if not x then break end

		-- If a new color create FIFOs to hold the last positions and averages  
		if not delay_size_history[color] then   
			delay_x_history[color] = newFifo(MAX_HISTORY)  
			delay_y_history[color] = newFifo(MAX_HISTORY)  
			delay_size_history[color] = newFifo(MAX_HISTORY)  
		end  

		-- Push a new value to the FIFO returning the oldest value and  
		-- the number of elements in the FIFO, including the new one just pushed  
		local oldest_x, samplesInHistory = delay_x_history[color](x)  
		local oldest_y = delay_y_history[color](y)  
		local oldest_size = delay_size_history[color](size)  

		-- write only if we have accumulated enough history and gotten   
		-- something out of the FIFO  
		if oldest_x then   
			shape = delay_writer.instance
			shape['color'] = color
			shape['x'] = oldest_x
			shape['y'] = oldest_y  
			shape['shapesize'] = oldest_size

			-- print(color, oldest_x, oldest_y, oldest_size)
			delay_writer:write()         
		end  
	end  
end

--- Publish the moving average of the last MAX_HISTORY samples
function average()
	-- Globals (preserved across invocations)
	if not x_avg then 
		average_x_history    = {}  
		average_y_history    = {} 
		x_avg = {}
		y_avg = {}
	end

	-- Iterate over each sample we got  
	for i, shape in ipairs(reader.samples) do
		local color = shape['color']
		local x = shape['x']
		local y = shape['y']

		-- SKIP sample if data is not valid
		if not x then break end

		-- If a new color create FIFOs to hold the historical values  
		if not x_avg[color] then   
			average_x_history[color] = newFifo(MAX_HISTORY)  
			average_y_history[color] = newFifo(MAX_HISTORY)  
			x_avg[color] = 0
			y_avg[color] = 0 
		end  

		-- Push a new value to the FIFO returning the oldest value and  
		-- the number of elements in the FIFO, including the new one 
		-- just pushed  
		local oldest_x, samplesInHistory = average_x_history[color](x)  
		local oldest_y = average_y_history[color](y)  

		-- compute the moving average
		if oldest_x then 
			x_avg[color] = x_avg[color] + (x - oldest_x)/samplesInHistory
			y_avg[color] = y_avg[color] + (y - oldest_y)/samplesInHistory
		else
			x_avg[color] = (x_avg[color] * (samplesInHistory-1) + x)/samplesInHistory
			y_avg[color] = (y_avg[color] * (samplesInHistory-1) + y)/samplesInHistory
		end

		-- write
		shape = average_writer.instance
		shape['color'] = color
		shape['x'] = x_avg[color]
		shape['y'] = y_avg[color]
		shape['shapesize'] = 20

		-- print(color, x_avg[color], y_avg[color])
		average_writer:write()
	end
end

-- main ---
reader:take() -- update the local cache
delay()
average()
