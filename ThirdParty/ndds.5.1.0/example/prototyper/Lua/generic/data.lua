--*****************************************************************************
--*    (c) 2005-2013 Copyright, Real-Time Innovations, All rights reserved.   *
--*                                                                           *
--*         Permission to modify and use for internal purposes granted.       *
--* This software is provided "as is", without warranty, express or implied.  *
--*                                                                           *
--*****************************************************************************

--- data.lua
-- Illustrate syntax for various data types. Used to cut-n-paste syntax 
-- highlighted into the Getting Started Guide.
-- 
local data 

-- get the data field "x" -- 
x = data['x']  

-- set the data field "x" --   
data['x'] = 5  

local adouble = data['adouble']
local astring = data['astring']
local abool = data['abool']

local choice = data['#']
local value = data[choice]

local adouble =
        data['outer.inner.adouble']

local astring = 
       data['outer.inner.astring']

local abool = 
       data['outer.inner.abool']

       
local choice = data['aunion#']
local value = data['aunion.'..choice]

local seq_length = data['seq#']
local arr_length = data['arr#']

local seq_k = data['seq[k]']
local arr_k = data['arr[k]']

local seq_k = data['seq[k]. adouble']
local arr_k = data['arr[k]. adouble']

local seq_k_choice = data['seq[k]#']
local seq_k_val = 
       data['seq[k].' .. seq_k_choice]

local arr_k_choice = data['arr[k]#']
local arr_k_val = 
       data['arr[k].' .. arr_k_choice]

local foo_writer
foo_writer.instance['x'] = -5.3
print(foo_writer.instance['x'])

foo_writer.instance['x'] = "hello" 
print(foo_writer.instance['x'])  
     
-- get the data   
local z = data['complex.z']
     
local choice = data['complex.aunion#']
local value = data['complex.aunion.'..choice]

-- if choice == sData, prints value else prints nil
print(data['complex.aunion.sData']) 

-- if choice == lData, prints value else prints nil
print(data['complex.aunion.lData]) 

-- prints 'nil' because member is invalid
print(data['complex.aunion.does_not_exist']) 


-- the discriminator is automatically set to 2 (i.e. discriminator field == 'lData')  
data['complex.aunion.lData'] = 5

-- get the length   
local length = data['complex.array#']

print(data['complex.array[3]'])

-- get the length   
local length = data['complex.array']
for i=1,length do
	  print(data['complex.array['..i..']'])
end  

-- prints 'nil' because the index is invalid
print(data['complex.array[11]']) 

