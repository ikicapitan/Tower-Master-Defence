extends Node2D

#Modificar bajo tu propio riesgo!
#Hecho por Deybis A. Melendez (Damv)

#Variables modificables...
var direccionRandom = Vector2(0,1) #Indicamos que la direccion inicial es hacia abajo
var distanciaPasillo = randi()%6+6 #tamaño del pasillo a generar, mas abajo se vuelve a randomizar
var cantidadPasillo = 18 #cantidad maxima de pasillos
var camaraMargen = Vector2(60,30) #Espacio de terreno extra al rededor de los pasillos
var velCamara = 1000 #Velocidad de camara moviendo con Flechas
var distanciaEntrePasillos = 1 #Debe ser mayor que cero

#Variables para el generador, no cambiar!
var origenCamino = Vector2(0,0) #punto Origen del mapa
var esqIzqMapa = Vector2(0,0) #Punto esquina izquierda del mapa
var esqDerMapa = Vector2(0,0) #Punto esquina derecha del mapa
var x = -1
var y = -1
var x2 = 0
var y2 = 0
var puntoEscan = Vector2()
var dirAnterior = Vector2()
var dirActual = direccionRandom
var direccion = {
	arriba = Vector2(0,-1),
	abajo = Vector2(0,1),
	derecha = Vector2(1,0),
	izquierda = Vector2(-1,0)
}

func _ready():
	$enemigos.spawnPos = origenCamino
	randomize() # gracias Iki
	generarMapa() #generamos los pasillos
	generarMuros() #generamos el terreno al rededor del pasillo

func generarMapa():
	#Ciclo para generar pasillos uno a uno, en base a la cantidad de pasillos.
	for pasilloNo in range(cantidadPasillo):
		#A continuacion se genera el pasillo en base a la distancia elegida.
		for pasillo in range(distanciaPasillo):
			#Escaneamos el terreno para saber si no hay camino donde se colocara el terreno.
			if !escanTerreno(): #si no hay terreno, generamos terreno
				$tilemap.set_cell(origenCamino.x,origenCamino.y,1)
				origenCamino += direccionRandom #nos posicionamos en el siguiente tile
		
		#revisamos si la posicion del tile es la mas lejos en los ejes x,-x,y,-y
		#en caso de ser cierto, registramos la posicion
		if esqIzqMapa.x > origenCamino.x: esqIzqMapa.x = origenCamino.x
		if esqIzqMapa.y > origenCamino.y: esqIzqMapa.y = origenCamino.y
		if esqDerMapa.x < origenCamino.x: esqDerMapa.x = origenCamino.x
		if esqDerMapa.y < origenCamino.y: esqDerMapa.y = origenCamino.y
		#randomizamos la distancia para el siguiente pasillo
		distanciaPasillo = randi()%3+4 
		#elegimos la siguiente direccion
		match direccionRandom:
			direccion.arriba: dirActual = dirAnterior #dirAnterior para evitar que se forme un circulo o espiral
			
			direccion.abajo:
				dirAnterior = dirActual # registramos la direccion actual para el siguiente ciclo
				if randi()%2 == 0: #elegimos si ir a la derecha o izquierda
					dirActual = direccion.derecha
				else: dirActual = direccion.izquierda
			
			direccion.derecha: # elegimos si ir arriba o abajo
				dirAnterior = dirActual
				if randi()%2 == 0:
					dirActual = direccion.arriba
				else: dirActual = direccion.abajo
			
			direccion.izquierda: #elegimos si ir arriba o abajo
				dirAnterior = dirActual
				if randi()%2 == 0:
					dirActual = direccion.arriba
					distanciaPasillo -= 2
				else: dirActual = direccion.abajo
		
		direccionRandom = dirActual 

func escanTerreno():
	var terreno = false
	#se pasa x,y a -1, el scan revisa los tiles alrededor del terreno como el siguiente esquema:
	#null,origenCamino, null       (esquema suponiendo que se dirige hacia abajo)
	#null,    null,     null       (espacio default, aumenta modificando la variable distanciaEntrePasillos)
	#-1,       0,        1
	#-1,       0,        1
	#-1,       0,        1
	#En total son 9 tiles los que hay que escanear
	x = -1
	y = -1
	#Ubicamos el tile a escanear, distanciaEntrePasillos se suma 1 para que no busque entre tiles ya puestos.
	puntoEscan = origenCamino + (direccionRandom * (distanciaEntrePasillos + 1))
	for i in range(9): # escan
		#si hay terreno en la posicion escaneada... el id del terreno en el TileMap es 1
		if $tilemap.get_cell(puntoEscan.x + x , puntoEscan.y + y) == 1: terreno = true
		if x >= 1:
			x = -1
			y += 1
		else: x += 1
	return terreno

func generarMuros():
	print(esqIzqMapa , "--" , esqDerMapa) #en consola veremos el tamaño del mapa basado en el Tilemap
	#x,y son la distancia del mapa, ancho y alto.
	x = esqDerMapa.x - esqIzqMapa.x + camaraMargen.x
	y = esqDerMapa.y - esqIzqMapa.y + camaraMargen.x
	#calculamos el punto limite para los muros.
	x2 = esqIzqMapa.x - round(camaraMargen.x/2)
	y2 = esqIzqMapa.y - round(camaraMargen.y/2)
	#le indicamos a pos el margen de la camara
	$pos.marginBottom = esqDerMapa.y * 64 #se multiplica por el tamaño del tile
	$pos.marginTop = esqIzqMapa.y * 64
	$pos.marginLeft = esqIzqMapa.x * 64
	$pos.marginRight = esqDerMapa.x * 64

	$pos.global_position = Vector2(round(x),round(y)) #ubicamos la camara al inicio del mapa
	
	for i in range(x*y):
		if $tilemap.get_cell(x2,y2) != 1: $tilemap.set_cell(x2,y2,0) #si no hay terreno (1) coloca muro (0)
		if x2 > esqDerMapa.x + round(camaraMargen.x/2): #si x2 supera el limite del mapa vuelve al principio
			x2 = esqIzqMapa.x - round(camaraMargen.x/2)
			y2 +=1 # el siguiente ciclo comenzara en la fila de abajo
		else:
			x2 += 1 #si no supera el limite del mapa se mueve al siguiente tile