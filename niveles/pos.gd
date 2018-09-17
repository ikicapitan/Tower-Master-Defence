extends Position2D
#Hecho por Deybis A. Melendez (Damv)
#Variables modificables
var zoomMaximo = 1.5 # A menor mas lejos
var zoomMinimo = 3 # A mayor mas cerca
var velZoom = 2 #velocidad del Zoom, es muy sencible, usar incluso decimales

#No modificar
var zoom = Vector2(3,3)
var marginTop = -10000
var marginBottom = 10000
var marginLeft = -10000
var marginRight = 10000
var pos = Vector2()
onready var velCamara = get_parent().velCamara

func _input(event):
	if Input.is_action_just_pressed("ui_accept"): #Enter para cambiar el mapa
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
	
	if Input.is_action_pressed("zoom-"):
		#Boton E
		zoom += Vector2(velZoom,velZoom) * delta
	elif Input.is_action_pressed("zoom+"):
		#Boton Q
		zoom -= Vector2(velZoom,velZoom) * delta
	if zoom <= Vector2(zoomMaximo,zoomMaximo):
		zoom = Vector2(zoomMaximo,zoomMaximo)
	elif zoom >= Vector2(zoomMinimo,zoomMinimo):
		zoom = Vector2(zoomMinimo,zoomMinimo)
	$Camera2D.set_zoom(zoom)