extends KinematicBody2D

onready var sprite			:Node2D 			= $AnimatedSprite
onready var walk			:Node2D			= $AudioStreamPlayer2D

var weapons_arsenal :Dictionary = {"gun":"res://player/gun.tscn",
									 "shot_gun":"res://player/shot_gun.tscn",
									 "smg":"res://player/SMG.tscn", 
									"magnum":"res://player/magnum_500.tscn"}

var vida 			:int			= Global.vida
var dir_x 			:int			= Global.dir_x
var dir_y 			:int			= Global.dir_y
var acel 			:int			= Global.acel
var mortos			:int			= Global.mortos
var powerUp			:int			= Global.powerUp
var olhandoDir		:bool 			= Global.olhandoDir
var canHited		:bool			= Global.canHited
var level			:float			= Global.level
var exper			:float			= Global.exper
var expAgr			:float			= Global.expAgr
var dano 			:float			= Global.dano

var hited :bool = false
var hitDir :Vector2 = Vector2.ZERO

func _ready():
	canHited 			= true
	vida  				= 5
	Global.vida 		= 5
	
	var gun 						= load( str(weapons_arsenal[Global.gun]) )
	var gunInstance :Object 		= gun.instance()
	gunInstance.global_position 	= self.global_position
	add_child(gunInstance)


func _physics_process(delta):
	if hited:
		self.global_position += hitDir * 4
	
	Global.playerPosition 		= self.global_position
	Global.canHited				= canHited
	
	levels()
	updateStatus()
	anim()
	move()


func levels():
	if expAgr >= ( exper * (level + 1) ):
		level				+= 1
		powerUp 			+= 1


func updateStatus():
	Global.vida 			= vida
	Global.level 			= level + 1
	expAgr					= Global.expAgr
	Global.expAgr			= expAgr
	Global.powerUp			= powerUp


func anim():
	if dir_x > 0:
		olhandoDir = true
	if dir_x < 0:
		olhandoDir = false
	
	sprite.flip_h = olhandoDir

func move():
	dir_x = 0
	dir_y = 0
	
	if Input.is_action_pressed("ui_up"):
		dir_y += -1 * acel
	if Input.is_action_pressed("ui_down"):
		dir_y += 1 * acel
	if Input.is_action_pressed("ui_right"):
		dir_x += 1 * acel
	if Input.is_action_pressed("ui_left"):
		dir_x += -1 * acel
	
	walk.play()
	if dir_x == 0 or dir_y == 0:
		walk.stop()
	
	self.move_and_slide( Vector2(dir_x, dir_y) )

func hited(dano, attackDirection):
	if vida > 0 and canHited:
		vida 			-= dano
		hitDir 			= attackDirection
		canHited 		= false
		hited 			= true
		yield(get_tree().create_timer(.2), "timeout")
		hited = false
		yield(get_tree().create_timer(1.8), "timeout")
		canHited = true
