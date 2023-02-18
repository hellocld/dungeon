class_name Dungeon
extends Resource

var size: Vector2i
var tiles:= {}
var rooms:= []


func add_tile(position:Vector2i, tile:DungeonTile, overwrite_existing:= false) -> Dictionary:
	var tile_added:= {}
	if tiles.has(position) && !overwrite_existing:
		print_debug("Tile already exists!")
		return tile_added
	tiles[position] = tile
	tile_added[position] = tile
	return tile_added


func add_room(room:DungeonRoom) -> bool:
	if tiles_occupied(room.position, room.size):
		return false
	if rooms.has(room):
		return false
	rooms.append(room)
	tiles.merge(room.tiles)
	return true


func draw_line(tile:DungeonTile, start:Vector2i, end:Vector2i, overwrite_existing:= false) -> Dictionary:
	var tiles_added:= {}
	var direction = Vector2(end - start).normalized()
	var walker = Vector2(start)
	while(Vector2i(walker) != end):
		walker += direction / 2.0
		var t = tile.duplicate(true)
		add_tile(Vector2i(walker), t, overwrite_existing)
		tiles_added[Vector2i(walker)] = t
	var t = tile.duplicate(true)
	add_tile(end, t, overwrite_existing)
	tiles_added[Vector2i(walker)] = t
	return tiles_added


func tiles_occupied(position:Vector2i, size:Vector2i) -> bool:
	for y in range(position.y, position.y + size.y):
		for x in range(position.x, position.x + size.x):
			if tiles.has(Vector2i(x, y)):
				return true
	return false
