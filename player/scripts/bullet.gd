extends Area2D

var dir 			:Vector2 			= Vector2(0, -1)
var vel 			:int 				= 350
var dist_max		:int				= 1024
var dano 			:float 				= 1 setget set_dano

func _physics_process(delta):
	if Global.dist_to_player(self, Global.playerPosition) >= dist_max:
		self.queue_free()
	translate( dir * delta * vel )


func _on_bullet_body_entered(body):
	if body.is_in_group("enemy") and not body.died:
		self.monitoring 			= false
		self.monitorable 			= false
		$CollisionShape2D.disabled 	= true
		var attackDirection 		= (body.global_position - self.global_position).normalized()
		body.hited(dano, attackDirection)
		self.queue_free()
	if body.is_in_group("tree"):
		queue_free()


func set_dist_max(dist):
	dist_max = dist


func set_dano(_dano):
	dano = _dano
