extends Control

func _on_Start_pressed():
	get_tree().change_scene("res://niveles/genMapa.tscn")

func _on_Exit_pressed():
	get_tree().quit()
