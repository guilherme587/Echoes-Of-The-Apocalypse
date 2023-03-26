extends KinematicBody2D

export var cooldown 			:float 			= .8 - .09 #diferença da luz do disparo

onready var sprite			:Node2D			= $AnimatedSprite
onready var reload_song		:Node2D			= $AudioStreamPlayer2D
onready var song_disparo 	:Node2D 		= $AudioStreamPlayer2D2
onready var light			:Light2D		= $Light2D

var bullet 						:Object 		= preload("res://player/bullet.tscn")
onready var enemys				:Array			= get_parent().get_parent().peak_enemys()
var target						:Object			= null
var shots						:int			= 0
var max_shots					:int			= 7
var dano						:float			= 2
var canShoot 					:bool 			= true
var mouse						:bool			= true


func _physics_process(delta):
	if mouse:
		look_at( get_global_mouse_position() )
	else:
		mira()
		if is_instance_valid(target):
			look_at(target.global_position)
	shoot()


func mira():
	enemys = get_parent().get_parent().peak_enemys()
	var maisPerto :float
	if not enemys.empty():
		maisPerto = Global.dist_to(enemys[0], self)
	
	for enemy in enemys:
		if Global.dist_to(enemy, self) < maisPerto:
			maisPerto			= Global.dist_to(enemy, self)
			target 				= enemy



func shoot():
	if canShoot:
		if Input.is_action_pressed("ui_shoot_space") and shots <= max_shots:
			mouse = false
			spawn_shoot()
		if Input.is_action_pressed("ui_shoot") and shots <= max_shots:
			mouse = true
			spawn_shoot()


func spawn_shoot():
	shots += 1
	if shots >= max_shots:
		canShoot 					= false
		sprite.modulate.a8 			= 55
		$Timer.start()
	
	var bulletInstance = bullet.instance()
	bulletInstance.global_position = $Position2D.global_position
	bulletInstance.dir = Vector2( cos(global_rotation), sin(global_rotation) ).normalized()
	
	bulletInstance.set_dano(dano + Global.dano)
	
	get_parent().get_parent().add_child(bulletInstance)
	light()
	song_disparo.play()
	
	canShoot = false
	yield(get_tree().create_timer(cooldown), "timeout")
	canShoot = true


func light():
	light.energy = 2
	yield(get_tree().create_timer(.09), "timeout")
	light.energy = 0


func _on_Timer_timeout():
	reload_song.play()
	sprite.modulate.a8 			= 255
	shots 						= 0
	canShoot 					= true
