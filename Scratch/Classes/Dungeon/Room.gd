class_name DungeonRoom
extends Resource

## Northwest corner of the room
var position: Vector2i

## Size of the room
var size: Vector2i

## Center of the room
var center: Vector2i:
	get:
		var c = position
		c.x += size.x / 2
		c.y += size.y / 2
		return c

## Collection of tiles in the room.
## Key: position (Vector2i)
## Value: DungeonTile
var tiles:= {}
## Array of all connected rooms. Helps prevent duplicate
## connections via hallways.
var connected_rooms:= []


func initialize(pos:Vector2i, size:Vector2i):
	self.position = pos
	self.size = size
	for y in range(position.y, position.y + size.y):
		for x in range(position.x, position.x + size.x):
			var t = DungeonTile.new()
			if y == position.y || y == position.y + (size.y - 1) || x == position.x || x == position.x + (size.x - 1):
				t.type = DungeonTile.Types.WALL
			else:
				t.type = DungeonTile.Types.FLOOR
			tiles[Vector2i(x, y)] = t
