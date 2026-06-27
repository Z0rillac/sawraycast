# Simple Amanatides and Woo's Ray Casting  
Simple Amanatides and Woo's Ray Casting implementation for Minecraft datapacks, range 0 to 64.  
Useful for player interaction, like block breaking, block placing, and other interactions that require a raycast.  
This method does not take into account block geometry.  
> This method is meant to be inlined into your own code, and should not be called directly or imported as is in your code.

Executes function `fr.z0rillac.sawrc:raycast/accept` (should be changed) once for each block along a ray from origin, and provide the block coordinates at execution.  
Raycasting can be stopped by setting score `$continue fr.z0rillac.sawrc.temp` to `0` during the execution of `fr.z0rillac.sawrc:raycast/accept` (when it hits a block for example)

A proper way to fill the required parameters is given in the main function file.

You should look at [the main file](data/fr.z0rillac.sawrc/function/raycast/run.mcfunction)

```
@reads
  score $dx fr.z0rillac.sawrc.temp
      x component of the unit vector of the ray's direction, scaled by 8192
  score $dy fr.z0rillac.sawrc.temp
      y component of the unit vector of the ray's direction, scaled by 8192
  score $dz fr.z0rillac.sawrc.temp
      z component of the unit vector of the ray's direction, scaled by 8192
  score $ix fr.z0rillac.sawrc.temp
      x voxel coordinate of the initial position, not scaled
  score $iy fr.z0rillac.sawrc.temp
      y voxel coordinate of the initial position, not scaled
  score $iz fr.z0rillac.sawrc.temp
      z voxel coordinate of the initial position, not scaled
  score $ox fr.z0rillac.sawrc.temp
      x offset of the initial position, scaled by 8192
  score $oy fr.z0rillac.sawrc.temp
      y offset of the initial position, scaled by 8192
  score $oz fr.z0rillac.sawrc.temp
      z offset of the initial position, scaled by 8192
  score $max_distance fr.z0rillac.sawrc.temp
      maximum distance of the ray in blocks, not scaled
  score $continue fr.z0rillac.sawrc.temp
      whether to continue the raycast loop, 1 for yes, 0 for no, set by fr.z0rillac.sawrc:raycast/accept
@writes
  score $x fr.z0rillac.sawrc.temp
      x voxel coordinate of current block
  score $y fr.z0rillac.sawrc.temp
      y voxel coordinate of current block
  score $z fr.z0rillac.sawrc.temp
      z voxel coordinate of current block
```
