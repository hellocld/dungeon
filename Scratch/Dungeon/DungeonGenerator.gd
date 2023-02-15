extends Node

signal dungeon_generated(dungeon:Dungeon)

@export
var size := Vector2i(64, 64)

var _dungeon: Dungeon

func _ready() -> void:
	_dungeon = Dungeon.new()
	_dungeon.size = size
	var room = DungeonRoom.new()
	room.initialize(Vector2i(1, 1), Vector2i(8, 8))
	assert(_dungeon.add_room(room), "Failed to add room!")
	dungeon_generated.emit(_dungeon)


