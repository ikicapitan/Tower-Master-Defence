extends Label

func _ready():
	pass

func _on_Timer_timeout(): #Cada vez que pasa un segundo avisa al singleton
	gamehandler.clock() #Avisar a la clase madre que maneja las fases de juego
	var minutos = gamehandler.tiempo / 60 #Divido los segundos para mostrar minutos
	var segundos = gamehandler.tiempo % 60 #Obtengo el resto de division para mostrar segundos
	text = (str(minutos) + ":" + str(segundos)) #Convierto a string los resultados para mostrar
