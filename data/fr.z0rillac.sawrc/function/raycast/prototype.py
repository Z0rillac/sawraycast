INF = 2147483647

def voxel_traversal(direction, offset, max_distance, SCALE=4096):
    dx, dy, dz = direction
    ox, oy, oz = offset

    x = y = z = 0

    step_x = (dx > 0) - (dx < 0)
    step_y = (dy > 0) - (dy < 0)
    step_z = (dz > 0) - (dz < 0)

    adx = abs(dx)
    ady = abs(dy)
    adz = abs(dz)

    axy = adx * ady
    ayz = ady * adz
    axz = adx * adz

    limit = max_distance * axy * adz
    print("limit", limit)

    if adx == 0:
        X = INF
        incX = 0
        limitX = INF
    else:
        dist = SCALE - ox if dx > 0 else ox
        X = dist * ayz
        incX = SCALE * ayz
        limitX = limit

    if ady == 0:
        Y = INF
        incY = 0
        limitY = INF
    else:
        dist = SCALE - oy if dy > 0 else oy
        Y = dist * axz
        incY = SCALE * axz
        limitY = limit

    if adz == 0:
        Z = INF
        incZ = 0
        limitZ = INF
    else:
        dist = SCALE - oz if dz > 0 else oz
        Z = dist * axy
        incZ = SCALE * axy
        limitZ = limit

    while True:

        yield x, y, z

        if X <= Y and X <= Z:

            if X > limitX:
                break

            x += step_x
            X += incX

        elif Y <= Z:

            if Y > limitY:
                break

            y += step_y
            Y += incY

        else:

            if Z > limitZ:
                break

            z += step_z
            Z += incZ