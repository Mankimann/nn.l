local Vector2 = require("vec")

local Val: number = 0

local OUTER_RADIUS: number = 25
local INNER_RADIUS_STATE: number = 22

local InputNeuronInnerColor = {
   1,0,0,1
}

local WorkingNeuronInnerColor = {
   0,1,0,1
}

local OutputNeuronInnerColor = {
   0,0,1,1
}

local enum Type
 "Input"
 "Working"
 "Output"
end

local record Neuron is {Neuron}
id: integer
layer: number
val: number
weight: number
name: string
position: Vector2
end


local function setVal(v: number): number
   return v
end

local function getVal(): number
   return Val
end

local function getValW(): number
   return getVal() * Neuron.weight
end

-- List Of Input Neurons
local InputNeurons: {Neuron} = {
   
}

-- List Of Working Neurons
local WorkingNeurons: {Neuron} = {
   
}

-- List Of Output Neurons
local OutputNeurons: {Neuron} = {
   
}

function Neuron:new()

end

function Neuron:draw(position: Vector2, t: Type)
   if t == "Input" then
      print("Input Neuron")
      love.graphics.setColor(InputNeuronInnerColor)
      elseif t == "Working" then
	 print("Working Neuron")
	 love.graphics.setColor(WorkingNeuronInnerColor)
      else
	 print("Output Neuron")
	 love.graphics.setColor(OutputNeuronInnerColor)
      end
   love.graphics.circle("fill", position.x, position.y, OUTER_RADIUS)
end

function Neuron:dispose()

   end


return Neuron
