extends CanvasLayer

onready var gun 			:Button 			= $VBoxContainer/HBoxContainer/gun
onready var shot_gun		:Button 			= $VBoxContainer/HBoxContainer/shot_gun
onready var smg 			:Button 			= $VBoxContainer/HBoxContainer/smg
onready var magnum 			:Button 			= $VBoxContainer/HBoxContainer/magnum


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_esc"):
		get_tree().change_scene("res://GUI/tela_inicial.tscn")

func _on_gun_pressed():
	gun.disabled 			= true
	shot_gun.disabled 		= false
	smg.disabled 			= false
	magnum.disabled 		= false
	
	Global.gun = "gun"


func _on_shot_gun_pressed():
	gun.disabled 			= false
	shot_gun.disabled 		= true
	smg.disabled 			= false
	magnum.disabled 		= false
	
	Global.gun = "shot_gun"


func _on_smg_pressed():
	gun.disabled 			= false
	shot_gun.disabled 		= false
	smg.disabled 			= true
	magnum.disabled 		= false
	
	Global.gun = "smg"


func _on_magnum_pressed():
	gun.disabled 			= false
	shot_gun.disabled 		= false
	smg.disabled 			= false
	magnum.disabled 		= true
	
	Global.gun = "magnum"



func _on_play_pressed():
	get_tree().change_scene("res://levels/level_0.tscn")
