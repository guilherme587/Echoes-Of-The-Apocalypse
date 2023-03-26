extends CanvasLayer

func _ready():
	self.visible = false


func _physics_process(delta):
	var player = get_parent().get_player()
	if player.vida <= 0:
		self.visible = true


func _on_Button_pressed():
	#get_tree().paused = false
	get_tree().change_scene("res://levels/level_0.tscn")
