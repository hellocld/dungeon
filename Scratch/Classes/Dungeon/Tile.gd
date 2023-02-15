class_name DungeonTile
extends RefCounted

## Possible base tile types
enum Types {
	FLOOR = 0,
	WALL = 1
}
var type: Types

func is_traversible() -> bool:
	## Is it a wall?
	if type == Types.WALL:
		return false
	
	return true;
