extends Node

signal dungeon_generated(dungeon:Dungeon)

@export
var size := Vector2i(64, 64)

var _dungeon: Dungeon

func _ready() -> void:
	_dungeon = Dungeon.new()
	_dungeon.size = size
	var room_a = DungeonRoom.new()
	var room_b = DungeonRoom.new()
	var room_c = DungeonRoom.new()
	room_a.initialize(Vector2i(16, 1), Vector2i(8, 8))
	room_b.initialize(Vector2i(1, 18), Vector2i(8, 8))
	room_c.initialize(Vector2i(3, 3), Vector2i(5, 13))
	assert(_dungeon.add_room(room_a), "Failed to add room_a!")
	assert(_dungeon.add_room(room_b), "Failed to add room_b!")
	assert(_dungeon.add_room(room_c), "Failed to add room_c!")
	_connect_rooms(_dungeon, room_a, room_b)
	_connect_rooms(_dungeon, room_b, room_c)
	_connect_rooms(_dungeon, room_c, room_a)
	dungeon_generated.emit(_dungeon)


var borders := [
	Vector2i(-1, -1),
	Vector2i(0, -1),
	Vector2i(1, -1),
	Vector2i(-1, 0),
	Vector2i(1, 0),
	Vector2i(-1, 1),
	Vector2i(0, 1),
	Vector2i(1, 1)
]

func _connect_rooms(dungeon:Dungeon, room_a:DungeonRoom, room_b:DungeonRoom) -> void:
	# Get midpoint between rooms
	var hall_center = Vector2i((room_a.center.x + room_b.center.x) / 2, (room_a.center.y + room_b.center.y) / 2)
	# Create floor tiles
	var floor_tile = DungeonTile.new()
	floor_tile.type = DungeonTile.Types.FLOOR
	# Begin with left/right
	var hall_tiles:= {}
	hall_tiles.merge(dungeon.draw_line(floor_tile, room_a.center, Vector2i(hall_center.x, room_a.center.y), true))
	hall_tiles.merge(dungeon.draw_line(floor_tile, room_b.center, Vector2i(hall_center.x, room_b.center.y), true))
	hall_tiles.merge(dungeon.draw_line(floor_tile, hall_center, Vector2i(hall_center.x, room_a.center.y), true))
	hall_tiles.merge(dungeon.draw_line(floor_tile, hall_center, Vector2i(hall_center.x, room_b.center.y), true))
	
	# Create wall tiles where there is no existing tile
	
	for t in hall_tiles.keys():
		for b in borders:
			if dungeon.tiles.has(t + b):
				continue
			var wall_tile = DungeonTile.new()
			wall_tile.type = DungeonTile.Types.WALL
			dungeon.add_tile(t + b, wall_tile)
	
