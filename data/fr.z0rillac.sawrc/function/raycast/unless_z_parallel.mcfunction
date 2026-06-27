#> fr.z0rillac.sawrc:raycast/unless_z_parallel
# @private
# @within fr.z0rillac.sawrc:raycast/run

scoreboard players operation dist fr.z0rillac.sawrc.temp = scale fr.z0rillac.sawrc.temp
scoreboard players operation dist fr.z0rillac.sawrc.temp -= $oz fr.z0rillac.sawrc.temp
execute if score $dz fr.z0rillac.sawrc.temp matches ..0 run scoreboard players operation dist fr.z0rillac.sawrc.temp = $oz fr.z0rillac.sawrc.temp

scoreboard players operation Z fr.z0rillac.sawrc.temp = dist fr.z0rillac.sawrc.temp
scoreboard players operation Z fr.z0rillac.sawrc.temp *= px fr.z0rillac.sawrc.temp
scoreboard players operation Z fr.z0rillac.sawrc.temp /= scale fr.z0rillac.sawrc.temp
scoreboard players operation Z fr.z0rillac.sawrc.temp *= py fr.z0rillac.sawrc.temp

scoreboard players operation incZ fr.z0rillac.sawrc.temp = px fr.z0rillac.sawrc.temp
scoreboard players operation incZ fr.z0rillac.sawrc.temp *= py fr.z0rillac.sawrc.temp

scoreboard players operation limitZ fr.z0rillac.sawrc.temp = limit fr.z0rillac.sawrc.temp