class_name Unit
extends Area2D

@onready var main = get_tree().root.get_node("Main")
@onready var grid: Grid = main.get_node("Grid")
@onready var pf: PathFinder = grid.get_node("PathFinder")
var data: UnitData
var speed = 100

var path: Array[Vector2]
var pos: Vector2:
	get:
		return pos
	set(value):
		pos = value
		
func _process(delta):
	move(delta)
	
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var clicked = grid.worldToGrid(get_global_mouse_position())
			var packedPath = pf.getPath(pos, clicked)
			path.clear()
			for point in packedPath:
				path.append(point / 128)
	
func move(delta):
	if path.size() > 0:
		if position.distance_to(grid.gridToWorld(path[0])) < 5:
			position = grid.gridToWorld(path[0])
			pos = path[0]
			path.pop_front()
		else:
			position += (grid.gridToWorld(path[0]) - position).normalized() * speed * delta
