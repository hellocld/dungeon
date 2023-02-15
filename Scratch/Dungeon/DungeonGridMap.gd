extends GridMap


func _populate_map(dungeon:Dungeon) -> void:
	clear()
	for tile in dungeon._tiles.keys():
		var pos = Vector3i(tile.x, 0, tile.y)
		set_cell_item(pos, dungeon._tiles[tile].type)


func _on_dungeon_generator_dungeon_generated(dungeon):
	_populate_map(dungeon)
