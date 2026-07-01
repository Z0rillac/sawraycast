#> fr.z0rillac.sawrc:raycast/run
#
# Simple Amanatides and Woo's Ray Casting  
# Fast Voxel Traversal Algorithm, range 0 to 64  
# Implementation by Z0rillac  
# MIT License Copyright (c) 2026 Z0rillac  
#
# ***
# 
# Executes fr.z0rillac.sawrc:raycast/accept once for each block along a ray from origin, and provide the block coordinates.  
# Useful for player interaction, like block breaking, block placing, and other interactions that require a raycast.  
# This method does not take into account block geometry.  
# > This method is meant to be inlined into your own code, and should not be called directly.
#
# ***
#
# @public
# @context any
# @reads
#   score $dx fr.z0rillac.sawrc.temp
#       x component of the unit vector of the ray's direction, scaled by 8192
#   score $dy fr.z0rillac.sawrc.temp
#       y component of the unit vector of the ray's direction, scaled by 8192
#   score $dz fr.z0rillac.sawrc.temp
#       z component of the unit vector of the ray's direction, scaled by 8192
#   score $ix fr.z0rillac.sawrc.temp
#       x voxel coordinate of the initial position, not scaled
#   score $iy fr.z0rillac.sawrc.temp
#       y voxel coordinate of the initial position, not scaled
#   score $iz fr.z0rillac.sawrc.temp
#       z voxel coordinate of the initial position, not scaled
#   score $ox fr.z0rillac.sawrc.temp
#       x offset of the initial position, scaled by 8192
#   score $oy fr.z0rillac.sawrc.temp
#       y offset of the initial position, scaled by 8192
#   score $oz fr.z0rillac.sawrc.temp
#       z offset of the initial position, scaled by 8192
#   score $max_distance fr.z0rillac.sawrc.temp
#       maximum distance of the ray in blocks, not scaled
#   score $continue fr.z0rillac.sawrc.temp
#       whether to continue the raycast loop, 1 for yes, 0 for no, set by fr.z0rillac.sawrc:raycast/accept
# @writes
#   score $x fr.z0rillac.sawrc.temp
#       x voxel coordinate of current block
#   score $y fr.z0rillac.sawrc.temp
#       y voxel coordinate of current block
#   score $z fr.z0rillac.sawrc.temp
#      z voxel coordinate of current block


## This should be externalized at load time.
scoreboard objectives add fr.z0rillac.sawrc.temp dummy
scoreboard players set -1 fr.z0rillac.sawrc.temp -1
scoreboard players set scale fr.z0rillac.sawrc.temp 46340
scoreboard players set range_scale fr.z0rillac.sawrc.temp 16

## This should be externalized at load time. You must ensure that this entity is available and unique, by for example, using a forceloaded chunk.
# Simple direct referenceable marker
kill aae5ea72-f991-4d75-9e08-1c41230edc8c
summon marker ~ ~ ~ {UUID:[I;-1427772814,-107917963,-1643635647,588176524]}

## This is the recommended way to provide the raycast parameters.
# unit vector $dx, $dy, $dz
execute at @s positioned 0.0 0.0 0.0 run tp aae5ea72-f991-4d75-9e08-1c41230edc8c ^ ^ ^1
execute store result score $dx fr.z0rillac.sawrc.temp run data get entity aae5ea72-f991-4d75-9e08-1c41230edc8c Pos[0] 46340
execute store result score $dy fr.z0rillac.sawrc.temp run data get entity aae5ea72-f991-4d75-9e08-1c41230edc8c Pos[1] 46340
execute store result score $dz fr.z0rillac.sawrc.temp run data get entity aae5ea72-f991-4d75-9e08-1c41230edc8c Pos[2] 46340
# floor initial position $ix, $iy, $iz
execute at @s anchored eyes positioned ^ ^ ^ align xyz run tp aae5ea72-f991-4d75-9e08-1c41230edc8c ~ ~ ~
execute store result score $ix fr.z0rillac.sawrc.temp run data get entity aae5ea72-f991-4d75-9e08-1c41230edc8c Pos[0] 1
execute store result score $iy fr.z0rillac.sawrc.temp run data get entity aae5ea72-f991-4d75-9e08-1c41230edc8c Pos[1] 1
execute store result score $iz fr.z0rillac.sawrc.temp run data get entity aae5ea72-f991-4d75-9e08-1c41230edc8c Pos[2] 1
# initial offset $ox, $oy, $oz
execute store result storage fr.z0rillac.sawrc:temp x double -1 run scoreboard players get $ix fr.z0rillac.sawrc.temp
execute store result storage fr.z0rillac.sawrc:temp y double -1 run scoreboard players get $iy fr.z0rillac.sawrc.temp
execute store result storage fr.z0rillac.sawrc:temp z double -1 run scoreboard players get $iz fr.z0rillac.sawrc.temp
execute at @s anchored eyes positioned ^ ^ ^ as aae5ea72-f991-4d75-9e08-1c41230edc8c run function fr.z0rillac.sawrc:raycast/help_offset with storage fr.z0rillac.sawrc:temp
execute store result score $ox fr.z0rillac.sawrc.temp run data get entity aae5ea72-f991-4d75-9e08-1c41230edc8c Pos[0] 46340
execute store result score $oy fr.z0rillac.sawrc.temp run data get entity aae5ea72-f991-4d75-9e08-1c41230edc8c Pos[1] 46340
execute store result score $oz fr.z0rillac.sawrc.temp run data get entity aae5ea72-f991-4d75-9e08-1c41230edc8c Pos[2] 46340
# max distance $max_distance
execute store result score $max_distance fr.z0rillac.sawrc.temp run attribute @s block_interaction_range get 16
scoreboard players set $max_distance fr.z0rillac.sawrc.temp 4096

## Algorithm logic
# path
scoreboard players set step_x fr.z0rillac.sawrc.temp 0
execute if score $dx fr.z0rillac.sawrc.temp matches 1.. run scoreboard players set step_x fr.z0rillac.sawrc.temp 1
execute if score $dx fr.z0rillac.sawrc.temp matches ..-1 run scoreboard players set step_x fr.z0rillac.sawrc.temp -1
scoreboard players set step_y fr.z0rillac.sawrc.temp 0
execute if score $dy fr.z0rillac.sawrc.temp matches 1.. run scoreboard players set step_y fr.z0rillac.sawrc.temp 1
execute if score $dy fr.z0rillac.sawrc.temp matches ..-1 run scoreboard players set step_y fr.z0rillac.sawrc.temp -1
scoreboard players set step_z fr.z0rillac.sawrc.temp 0
execute if score $dz fr.z0rillac.sawrc.temp matches 1.. run scoreboard players set step_z fr.z0rillac.sawrc.temp 1
execute if score $dz fr.z0rillac.sawrc.temp matches ..-1 run scoreboard players set step_z fr.z0rillac.sawrc.temp -1

# absolutes and products
scoreboard players operation adx fr.z0rillac.sawrc.temp = $dx fr.z0rillac.sawrc.temp
execute if score $dx fr.z0rillac.sawrc.temp matches ..-1 run scoreboard players operation adx fr.z0rillac.sawrc.temp *= -1 fr.z0rillac.sawrc.temp
scoreboard players operation ady fr.z0rillac.sawrc.temp = $dy fr.z0rillac.sawrc.temp
execute if score $dy fr.z0rillac.sawrc.temp matches ..-1 run scoreboard players operation ady fr.z0rillac.sawrc.temp *= -1 fr.z0rillac.sawrc.temp
scoreboard players operation adz fr.z0rillac.sawrc.temp = $dz fr.z0rillac.sawrc.temp
execute if score $dz fr.z0rillac.sawrc.temp matches ..-1 run scoreboard players operation adz fr.z0rillac.sawrc.temp *= -1 fr.z0rillac.sawrc.temp
scoreboard players operation px fr.z0rillac.sawrc.temp = adx fr.z0rillac.sawrc.temp
scoreboard players operation py fr.z0rillac.sawrc.temp = ady fr.z0rillac.sawrc.temp
scoreboard players operation pz fr.z0rillac.sawrc.temp = adz fr.z0rillac.sawrc.temp
execute if score adx fr.z0rillac.sawrc.temp matches 0 run scoreboard players set px fr.z0rillac.sawrc.temp 1
execute if score ady fr.z0rillac.sawrc.temp matches 0 run scoreboard players set py fr.z0rillac.sawrc.temp 1
execute if score adz fr.z0rillac.sawrc.temp matches 0 run scoreboard players set pz fr.z0rillac.sawrc.temp 1

# limit
scoreboard players operation limit fr.z0rillac.sawrc.temp = px fr.z0rillac.sawrc.temp
scoreboard players operation limit fr.z0rillac.sawrc.temp *= py fr.z0rillac.sawrc.temp
scoreboard players operation limit fr.z0rillac.sawrc.temp /= scale fr.z0rillac.sawrc.temp
scoreboard players operation limit fr.z0rillac.sawrc.temp *= pz fr.z0rillac.sawrc.temp
scoreboard players operation limit fr.z0rillac.sawrc.temp /= scale fr.z0rillac.sawrc.temp
scoreboard players operation limit fr.z0rillac.sawrc.temp *= $max_distance fr.z0rillac.sawrc.temp
scoreboard players operation limit fr.z0rillac.sawrc.temp /= range_scale fr.z0rillac.sawrc.temp

# steps
execute if score adx fr.z0rillac.sawrc.temp matches 0 run function fr.z0rillac.sawrc:raycast/if_x_parallel
execute unless score adx fr.z0rillac.sawrc.temp matches 0 run function fr.z0rillac.sawrc:raycast/unless_x_parallel
execute if score ady fr.z0rillac.sawrc.temp matches 0 run function fr.z0rillac.sawrc:raycast/if_y_parallel
execute unless score ady fr.z0rillac.sawrc.temp matches 0 run function fr.z0rillac.sawrc:raycast/unless_y_parallel
execute if score adz fr.z0rillac.sawrc.temp matches 0 run function fr.z0rillac.sawrc:raycast/if_z_parallel
execute unless score adz fr.z0rillac.sawrc.temp matches 0 run function fr.z0rillac.sawrc:raycast/unless_z_parallel

# loop
scoreboard players set $continue fr.z0rillac.sawrc.temp 1
scoreboard players operation $x fr.z0rillac.sawrc.temp = $ix fr.z0rillac.sawrc.temp
scoreboard players operation $y fr.z0rillac.sawrc.temp = $iy fr.z0rillac.sawrc.temp
scoreboard players operation $z fr.z0rillac.sawrc.temp = $iz fr.z0rillac.sawrc.temp
execute at @s anchored eyes positioned ^ ^ ^ align xyz run function fr.z0rillac.sawrc:raycast/loop