extends Position2D

var marginTop = -10000
var marginBottom = 10000
var marginLeft = -10000
var marginRight = 10000
var pos = Vector2()
onready var velCamara = get_parent().velCamara

func _input(event):
	if Input.is_action_just_pressed("ui_accept"): #Enter
		get_tree().reload_current_scene()

func _physics_process(delta):
	pos = global_position
	if pos.x > marginRight:
		global_position.x = marginRight
	elif pos.x < marginLeft:
		global_position.x = marginLeft
	if pos.y > marginBottom:
		global_position.y = marginBottom
	elif pos.y < marginTop:
		global_position.y = marginTop
	if Input.is_action_pressed("ui_right"):
		global_position.x += velCamara * delta
	elif Input.is_action_pressed("ui_left"):
		global_position.x -= velCamara * delta
	if Input.is_action_pressed("ui_up"):
		global_position.y -= velCamara * delta
	elif Input.is_action_pressed("ui_down"):
		global_position.y += velCamara * delta