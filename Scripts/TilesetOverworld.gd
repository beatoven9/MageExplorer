tool
extends TileSet


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Define tile_id constants.
enum TILES{
	EMPTY,
	PPLATEAU,
	EDGE,
	OUTSIDE_CORNER,
	INSIDE_CORNER,
	RAMP_A,
	RAMP_B,
	RAMP_C
}

const EMPTY = -1
const SNOW = 0
const SNOW_WATER = 1
const SNOW_PLATEAU = 2
const SNOW_DITCH = 3
const SNOW_RAMP_A = 4
const SNOW_RAMP_B = 5
const SNOW_RAMP_C = 6
const MEADOW_GRASS = 7
const MEADOW_WATER = 8
const MEADOW_DIRT = 9
const FOREST_GRASS = 10
const FOREST_WATER = 11
const FOREST_DIRT = 12
const DESERT_SAND = 13
const DESERT_WATER = 14


const binds = {
	SNOW: [SNOW_DITCH, SNOW_WATER, SNOW_PLATEAU, SNOW_DITCH],
	SNOW_PLATEAU: [SNOW_RAMP_A, SNOW_RAMP_B, SNOW_RAMP_C, SNOW_WATER],
	SNOW_DITCH: [SNOW_RAMP_A, SNOW_RAMP_B, SNOW_RAMP_C, SNOW_WATER],
	FOREST_GRASS: [FOREST_DIRT, FOREST_WATER, SNOW, DESERT_SAND],
	MEADOW_GRASS: [FOREST_GRASS],
	MEADOW_DIRT: [MEADOW_WATER],
	DESERT_SAND: [DESERT_WATER]
}

func _is_tile_bound(drawn_id, neighbor_id):
	# This func is called for each tile being drawn, for each neighbour,
	# to see if the current tile "binds" to that neighbour
	return neighbor_id in binds[drawn_id]
