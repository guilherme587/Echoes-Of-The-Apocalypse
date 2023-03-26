extends KinematicBody2D

export var cooldown 			:float 			= .7 - .09 #diferença da luz do disparo

onready var positions :Array = [$Position2D, $Position2D2, $Position2D3]

onready var sprite			:Node2D			= $AnimatedSprite
onready var reload_song		:Node2D			= $AudioStreamPlayer2D
onready var song_disparo 	:Node2D 		= $AudioStreamPlayer2D2
onready var light			:Array			= [$Light2D, $Light2D2, $Light2D3]

var bullet 						:Object 		= preload("res://player/bullet.tscn")
onready var enemys				:Array			= get_parent().get_parent().peak_enemys()
var target						:Object			= null
var canShoot 					:bool 			= true
var shots						:int			= 0
var max_shots					:int			= 16
var dano						:float			= 1
var reload						:bool			= false
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
	if Input.is_action_just_pressed("ui_reload") and shots > 0 and not reload:
		reload()
	if canShoot and not reload:
		if Input.is_action_pressed("ui_shoot_space") and shots <= max_shots:
			mouse = false
			spawn_shoot()
		if Input.is_action_pressed("ui_shoot") and shots <= max_shots:
			mouse = true
			spawn_shoot()
	if reload:
		self.rotation_degrees += 90


func spawn_shoot():
	shots += 4
	if shots >= max_shots:
		reload_song.play()
		reload = true
		sprite.modulate.a8 = 55
		$Timer.start()
	
	for i in range(3):
		var bulletInstance = bullet.instance()
		bulletInstance.global_position 		= positions[i].global_position
		bulletInstance.dir 					= Vector2( cos(positions[i].global_rotation), sin(positions[i].global_rotation) ).normalized()
		bulletInstance.set_dist_max(100)
		bulletInstance.set_dano(dano + Global.dano)
		get_parent().get_parent().add_child(bulletInstance)
		song_disparo.play()
	
	light()
	
	canShoot = false
	yield(get_tree().create_timer(cooldown), "timeout")
	canShoot = true


func reload():
	reload_song.play()
	reload 						= true
	canShoot 					= false
	sprite.modulate.a8 			= 55
	$Timer.start()


func light():
	for i in range(3):
		light[i].energy = 2
	
	yield(get_tree().create_timer(.09), "timeout")
	
	for i in range(3):
		light[i].energy = 0


func _on_Timer_timeout():
	sprite.modulate.a8 			= 255
	shots						= 0
	reload 						= false
	canShoot 					= true
