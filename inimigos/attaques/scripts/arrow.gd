extends Area2D

var dano 			:int 				= 1
var dir 			:Vector2 			= Vector2(0, -1)
var vel 			:int 				= 100

func _ready():
	rotation = dir.angle()

func _physics_process(delta):
	translate( dir * delta * vel )


func _on_attack_enemy_1_body_entered(body):
	if body.is_in_group("player") and Global.canHited:
		var attackDirection = (body.global_position - self.global_position).normalized()
		body.hited(dano, attackDirection)
		self.queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	self.queue_free()
