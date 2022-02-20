tool
extends TileSet


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Define tile_id constants.
enum TILES{
	EMPTY,
	SNOW,
	EDGE,
	OUTSIDE_CORNER,
	INSIDE_CORNER,
	RAMP_A,
	RAMP_B,
	RAMP_C
}

const EMPTY = -1
const SNOW = 0
const RAMP_A = 1
const RAMP_B = 2
const RAMP_C = 3

const binds = {
	SNOW: [RAMP_A, RAMP_B, RAMP_C]
}

func _is_tile_bound(drawn_id, neighbor_id):
	# This func is called for each tile being drawn, for each neighbour,
	# to see if the current tile "binds" to that neighbour
	return neighbor_id in binds[drawn_id]
