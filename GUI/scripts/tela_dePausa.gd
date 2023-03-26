extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false


func _physics_process(delta):
	if Input.is_action_just_pressed("ui_esc"):
		self.visible = !self.visible
		get_tree().paused = !get_tree().paused
		


func _on_continue_pressed():
	get_tree().paused = !get_tree().paused
	self.visible = false


func _on_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://GUI/tela_inicial.tscn")


func _on_desktop_pressed():
	get_tree().quit()
