#> fr.z0rillac.sawrc:raycast/loop
# @private
# @within fr.z0rillac.sawrc:raycast/run

function fr.z0rillac.sawrc:raycast/accept

scoreboard players set else fr.z0rillac.sawrc.temp 1
execute if score X fr.z0rillac.sawrc.temp <= Y fr.z0rillac.sawrc.temp if score X fr.z0rillac.sawrc.temp <= Z fr.z0rillac.sawrc.temp run function fr.z0rillac.sawrc:raycast/step_x
execute if score else fr.z0rillac.sawrc.temp matches 1 if score Y fr.z0rillac.sawrc.temp <= Z fr.z0rillac.sawrc.temp run function fr.z0rillac.sawrc:raycast/step_y
execute if score else fr.z0rillac.sawrc.temp matches 1 run function fr.z0rillac.sawrc:raycast/step_z