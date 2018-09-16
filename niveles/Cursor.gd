extends Position2D

var tilemap
var mouse_pos

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if tilemap == null:
		return
	
	mouse_pos = get_viewport().get_mouse_position()
	position = mouse_pos
	
	
func set_tilemap(tilemap):
	pass
	

func _on_Area_body_entered(body):
	print(body)
