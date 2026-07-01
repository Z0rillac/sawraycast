#> fr.z0rillac.sawrc:raycast/unless_x_parallel
# @private
# @within fr.z0rillac.sawrc:raycast/run

scoreboard players operation dist fr.z0rillac.sawrc.temp = scale fr.z0rillac.sawrc.temp
scoreboard players operation dist fr.z0rillac.sawrc.temp -= $ox fr.z0rillac.sawrc.temp
execute if score $dx fr.z0rillac.sawrc.temp matches ..0 run scoreboard players operation dist fr.z0rillac.sawrc.temp = $ox fr.z0rillac.sawrc.temp

scoreboard players operation X fr.z0rillac.sawrc.temp = dist fr.z0rillac.sawrc.temp
scoreboard players operation X fr.z0rillac.sawrc.temp *= py fr.z0rillac.sawrc.temp
scoreboard players operation X fr.z0rillac.sawrc.temp /= scale fr.z0rillac.sawrc.temp
scoreboard players operation X fr.z0rillac.sawrc.temp *= pz fr.z0rillac.sawrc.temp
scoreboard players operation X fr.z0rillac.sawrc.temp /= scale fr.z0rillac.sawrc.temp

scoreboard players operation incX fr.z0rillac.sawrc.temp = py fr.z0rillac.sawrc.temp
scoreboard players operation incX fr.z0rillac.sawrc.temp *= pz fr.z0rillac.sawrc.temp
scoreboard players operation incX fr.z0rillac.sawrc.temp /= scale fr.z0rillac.sawrc.temp

scoreboard players operation limitX fr.z0rillac.sawrc.temp = limit fr.z0rillac.sawrc.temp