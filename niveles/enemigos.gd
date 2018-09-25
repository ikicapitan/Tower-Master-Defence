extends Node2D

export (PackedScene) var enemy1 #Escena Unidad 1 Enemigo

#Debajo de este nodo, se tendrian que instanciar a los enemigos
#cada enemigo deberia colocarse en spawnPos, el genMap da el valor.

#No modificar
var spawnPos = Vector2()
var goalPos = Vector2() #Posicion Objetivo

func spawn_enemy(): #Generador de Enemigos
	var newEnemy = enemy1.instance() #Creo Enemigo
	add_child(newEnemy) #Agrego en Jerarquia como Hijo
	newEnemy.global_position = global_position #Posiciono

func _on_tmr_enemys_timeout(): #Timer finaliza
	spawn_enemy() #Llamo a Spawnear Enemigo
