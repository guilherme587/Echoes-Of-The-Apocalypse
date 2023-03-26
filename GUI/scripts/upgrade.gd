extends CanvasLayer

onready var powerUps			:Label				= $Label
onready var btnLife 			:Button 			= $HBoxContainer/VBoxContainer/HBoxContainer/Button
onready var btnVelocity 		:Button 			= $HBoxContainer/VBoxContainer/HBoxContainer2/Button2
onready var btnExp	 			:Button 			= $HBoxContainer/VBoxContainer/HBoxContainer3/Button3
onready var btnAttack 			:Button 			= $HBoxContainer/VBoxContainer/HBoxContainer4/Button4

onready var player :Object = get_parent().get_player()

func _ready():
	self.visible = false


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_tab"):
		self.visible 			= !self.visible
		get_tree().paused 		= !get_tree().paused
	powerUps.text			= "power ups   " + str(player.powerUp)


func _on_Button_pressed():
	if player.powerUp > 0:
		player.powerUp			-= 1
		player.vida 			+= 1


func _on_Button2_pressed():
	if player.powerUp > 0:
		player.powerUp 			-= 1
		player.acel 			+= 1.5


func _on_Button3_pressed():
	if player.powerUp > 0:
		player.powerUp			-= 1
		Global.expInimigo 		+= .35


func _on_Button4_pressed():
	if player.powerUp > 0:
		player.powerUp 			-= 1
		Global.dano 			+= .35
