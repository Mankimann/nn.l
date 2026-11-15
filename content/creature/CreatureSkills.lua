local CreatureSkills = {}






function CreatureSkills.new()
   return {
      canHarvest = false,
      canSwim = false,
      canFly = false,
      canPickUp = false,
   }
end

return CreatureSkills
