local record CreatureSkills
   canHarvest: boolean
   canSwim: boolean
   canFly: boolean
   canPickUp: boolean
end

function CreatureSkills.new(): CreatureSkills
   return {
      canHarvest = false,
      canSwim = false,
      canFly = false,
      canPickUp = false,
   }
end

return CreatureSkills
