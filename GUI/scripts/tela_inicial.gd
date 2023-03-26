extends CanvasLayer


onready var bntPlay 			:Button 			= $VBoxContainer/play
onready var bntOptions 			:Button 			= $VBoxContainer/options
onready var bntExit 			:Button 			= $VBoxContainer/exit


func _on_play_pressed():
	get_tree().change_scene("res://GUI/menu_select.tscn")


func _on_options_pressed():
	get_tree().change_scene("res://GUI/options.tscn")


func _on_exit_pressed():
	get_tree().quit()

