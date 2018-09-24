extends Node #Clase maestra del juego (madrE)

enum estados {fase_1, fase_2, fase_3} #Fase 1: Preparacion #Fase 2: Batalla #Fase 3: Puntajes
var e_actual = fase_1 #Fase actual del juego
var t_fase1 = 60 #Preparacion dura 60 segundos
var t_fase2 = t_fase1*3 #Batalla dura 3 minutos
var t_fase3 = 10 #Puntajes dura 10 segundos
var tiempo = t_fase1 #Tiempo restante de la fase actual

var oro = 100
var alimento = 100

func clock(): #Cuando pasa un segundo se llamara a esta funcion
	tiempo -= 1
	if(tiempo == 0): #Si se termino el tiempo
		time_up()
	
func time_up(): #Se termino la fase
	var txt_fase = "Fase: "
	match(e_actual): #Pasar a fase siguiente
		fase_1:
			fase_2
			txt_fase += "BATALLA"
			tiempo = t_fase2
		fase_2:
			fase_3
			txt_fase += "PUNTAJES"
			tiempo = t_fase3
		fase_3:
			fase_1
			txt_fase += "PREPARACION"
			tiempo = t_fase1
	get_tree().get_nodes_in_group("fase")[0].text = txt_fase #Asignamos texto de fase actual
