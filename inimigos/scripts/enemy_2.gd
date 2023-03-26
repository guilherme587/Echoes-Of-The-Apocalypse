extends KinematicBody2D

var powerUp = preload("res://inimigos/drop_itens/powerUp.tscn")
var blood			:PackedScene			= preload("res://inimigos/blood.tscn")

onready var sprite			:Node2D			= $AnimatedSprite
onready var hited_songs		:Array			= [$AudioStreamPlayer2D,
												$AudioStreamPlayer2D2,
												$AudioStreamPlayer2D3]

var acel 			:float 			= .4
var vida 			:float 			= 4
var dano			:int			= 1
var canAttack		:bool			= true
var canFollow		:bool			= true
var died			:bool			= false
var player			:Object			= null

var hited :bool = false
var hitDir :Vector2 = Vector2.ZERO


func _physics_process(delta):
	if Global.dist_to_player(self, Global.playerPosition) >= 1024:
		self.queue_free()
	if Global.dist_to_player(self, Global.playerPosition) <= 50:
		enable_colisions()
	else:
		disable_colisions()
	if canFollow:
		position += (Global.playerPosition - position).normalized() * acel
	if hited:
		sprite.modulate.a8 = 55
		$lightHited.energy = 1
		position += hitDir * acel
	else:
		sprite.modulate.a8 = 255
		$lightHited.energy = 0
	hit()


func hited(dano, attackDirection):
	var song = int(rand_range(0, hited_songs.size()))
	
	if vida > 0:
		hited_songs[song].play()
		vida 			-= dano
		hitDir 			= (attackDirection)
		canFollow 		= false
		hited 			= true
		yield(get_tree().create_timer(.2), "timeout")
		hited 			= false
		canFollow 		= true
	if vida <= 0:
		for i in range(3):
			var powerUpInstance = powerUp.instance()
			powerUpInstance.global_position = self.global_position + Vector2(16 * 2, 16)
			get_parent().add_child(powerUpInstance)
		
		var bloodInstance :Object 			= blood.instance()
		get_tree().current_scene.add_child(bloodInstance)
		bloodInstance.global_position 		= self.global_position
		bloodInstance.rotation 				= self.global_position.angle_to_point(Global.playerPosition)
		
		died								= true
		Global.mortos 						+= 1
		self.queue_free()


func hit():
	if Global.canHited and player != null and not died:
		var attackDirection = (player.global_position - self.global_position).normalized()
		player.hited(dano, attackDirection)
		canFollow = false
		yield(get_tree().create_timer(.2), "timeout")
		canFollow = true
		yield(get_tree().create_timer(1.8), "timeout")


func disable_colisions():
	$Area2D.monitorable 				= false
	$Area2D.monitoring 					= false


func enable_colisions():
	$CollisionShape2D.disabled 			= false
	$Area2D.monitorable 				= true
	$Area2D.monitoring 					= true


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		player = body


func _on_Area2D_body_exited(body):
	player = null


func _on_VisibilityNotifier2D_screen_entered():
	enable_colisions()


func _on_VisibilityNotifier2D_screen_exited():
	$CollisionShape2D.disabled 			= true
	disable_colisions()
