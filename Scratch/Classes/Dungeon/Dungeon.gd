class_name Dungeon
extends Resource

var size: Vector2i
var _tiles:= {}
var _rooms:= []


func add_tile(position:Vector2i, tile:DungeonTile) -> bool:
	if _tiles.has(position):
		print_debug("Tile already exists!")
		return false
	_tiles[position] = tile
	return true


func add_room(room:DungeonRoom) -> bool:
	if tiles_occupied(room.position, room.size):
		return false
	if _rooms.has(room):
		return false
	_rooms.append(room)
	_tiles.merge(room.tiles)
	return true


func tiles_occupied(position:Vector2i, size:Vector2i) -> bool:
	for y in range(position.y, position.y + size.y):
		for x in range(position.x, position.x + size.x):
			if _tiles.has(Vector2i(x, y)):
				return true
	return false
