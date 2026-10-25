local _tl_compat; if (tonumber((_VERSION or ''):match('[%d.]*$')) or 0) < 5.3 then local p, m = pcall(require, 'compat53.module'); if p then _tl_compat = m end end; local ipairs = _tl_compat and _tl_compat.ipairs or ipairs; local InputNeurons = {}
local WorkingNeurons = {}

local function createFullMesh()
   for input, k in ipairs(InputNeurons) do
      for working, g in ipairs(WorkingNeurons) do

      end
   end

end

local function createOutput()

end
