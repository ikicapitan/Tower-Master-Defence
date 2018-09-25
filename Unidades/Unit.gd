extends KinematicBody2D
#Movimiento PathFinding de unidades, enemigos, etc
var path = [] #Camino (lista de nodos a recorrer)
export (float) var MOV_SPEED
export (float) var ROT_SPEED

func _ready():
	create_path()

func create_path(): #Crear camino
	var nav = get_tree().get_nodes_in_group("nav")[0] #Obtengo Navigation2D
	var objetivo = get_parent().goalPos
	path = nav.get_simple_path(position, get_parent().goalPos, false) #Genero un path en base al objetivo
	print(path)

func _physics_process(delta): #Movimiento hacia el Path
	if(path.size() > 0): #Si aun hay camino pendiente
		var angulo = get_angle_to(path[0]) #Vemos el angulo hacia donde queremos ir
		rotate(angulo * ROT_SPEED * delta) #Rotamos con un lerp (a traves del tiempo)	
		var d = position.distance_to(path[0]) #Medimos la distancia a recorrer
		if(d > 2): #Si la distancia es mayor a 2, avanzamos
			position = position.linear_interpolate(path[0], (MOV_SPEED * delta)/d) #Avanzamos
		else:
			#print(position)
			#print(path[0])
			path.remove(0) #Si alcanzamos removemos el nodo path para chequear el proximo
			

