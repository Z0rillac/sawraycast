#> fr.z0rillac.sawrc:raycast/unless_y_parallel
# @private
# @within fr.z0rillac.sawrc:raycast/run

scoreboard players operation dist fr.z0rillac.sawrc.temp = scale fr.z0rillac.sawrc.temp
scoreboard players operation dist fr.z0rillac.sawrc.temp -= $oy fr.z0rillac.sawrc.temp
execute if score $dy fr.z0rillac.sawrc.temp matches ..0 run scoreboard players operation dist fr.z0rillac.sawrc.temp = $oy fr.z0rillac.sawrc.temp

scoreboard players operation Y fr.z0rillac.sawrc.temp = dist fr.z0rillac.sawrc.temp
scoreboard players operation Y fr.z0rillac.sawrc.temp *= px fr.z0rillac.sawrc.temp
scoreboard players operation Y fr.z0rillac.sawrc.temp /= scale fr.z0rillac.sawrc.temp
scoreboard players operation Y fr.z0rillac.sawrc.temp *= pz fr.z0rillac.sawrc.temp

scoreboard players operation incY fr.z0rillac.sawrc.temp = px fr.z0rillac.sawrc.temp
scoreboard players operation incY fr.z0rillac.sawrc.temp *= pz fr.z0rillac.sawrc.temp

scoreboard players operation limitY fr.z0rillac.sawrc.temp = limit fr.z0rillac.sawrc.temp