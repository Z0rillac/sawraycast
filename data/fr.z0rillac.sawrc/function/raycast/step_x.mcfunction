#> fr.z0rillac.sawrc:raycast/step_x
# @private
# @within fr.z0rillac.sawrc:raycast/loop

scoreboard players set loop fr.z0rillac.sawrc.temp 0
execute if score X fr.z0rillac.sawrc.temp <= limitX fr.z0rillac.sawrc.temp run scoreboard players set loop fr.z0rillac.sawrc.temp 1

scoreboard players set else fr.z0rillac.sawrc.temp 0
scoreboard players operation $x fr.z0rillac.sawrc.temp += step_x fr.z0rillac.sawrc.temp
scoreboard players operation X fr.z0rillac.sawrc.temp += incX fr.z0rillac.sawrc.temp

execute if score $continue fr.z0rillac.sawrc.temp matches 1 if score loop fr.z0rillac.sawrc.temp matches 1 if score step_x fr.z0rillac.sawrc.temp matches 1 positioned ~1 ~ ~ run function fr.z0rillac.sawrc:raycast/loop
execute if score $continue fr.z0rillac.sawrc.temp matches 1 if score loop fr.z0rillac.sawrc.temp matches 1 if score step_x fr.z0rillac.sawrc.temp matches -1 positioned ~-1 ~ ~ run function fr.z0rillac.sawrc:raycast/loop