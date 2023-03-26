extends Area2D


var pickUp :bool = false


func _physics_process(delta):
	if pickUp:
		self.global_position += (Global.playerPosition - self. global_position).normalized() * 4


func _on_powerUp_area_entered(area):
	if area.name == "collection_area":
		pickUp = true


func _on_powerUp_body_entered(body):
	if body.is_in_group("player"):
		Global.expAgr += Global.expInimigo
		self.queue_free()
