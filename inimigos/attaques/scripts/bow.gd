extends KinematicBody2D

var arrow 				:Object 		= preload("res://inimigos/attaques/arrow.tscn")

onready var mira		:Node2D			= $Position2D

var par 				:Vector2 			= Vector2.ZERO
var canAttack 			:bool 				= true


func _physics_process(delta):
	if par != Vector2.ZERO:
		look_at(par)
		hit()

func hit():
	if canAttack:
		var arrowInstance 					= arrow.instance()
		arrowInstance.dir					= Vector2( cos(global_rotation), sin(global_rotation) ).normalized()
		arrowInstance.global_position 		= mira.global_position
		get_parent().get_parent().add_child(arrowInstance)
		canAttack = false
		yield(get_tree().create_timer(1), "timeout")
		canAttack = true
