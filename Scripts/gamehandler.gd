extends Node #Clase maestra del juego (madrE)

enum estados {fase_1, fase_2, fase_3} #Fase 1: Preparacion #Fase 2: Batalla #Fase 3: Puntajes
var e_actual = fase_1 #Fase actual del juego

var tiempo = 60 #Tiempo restante de la fase

func clock(): #Cuando pasa un segundo se llamara a esta funcion
	tiempo -= 1
	if(tiempo == 0): #Si se termino el tiempo
		time_up()
	
func time_up(): #Se termino la fase
	match(e_actual): #Pasar a fase siguiente
		fase_1:
			fase_2
		fase_2:
			fase_3
		fase_3:
			fase_1
