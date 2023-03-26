extends CanvasLayer


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_esc"):
		get_tree().change_scene("res://GUI/tela_inicial.tscn")


func _on_fullscreen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen


func _on_cheats_pressed():
	MusicControler.play_cheats()


func _on_voltar_pressed():
	get_tree().change_scene("res://GUI/tela_inicial.tscn")
