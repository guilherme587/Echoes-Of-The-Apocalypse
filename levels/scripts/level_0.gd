extends Node2D

onready var player 			:Node2D 			= $palyer
onready var tile			:TileMap 			= $TileMap
onready var y_sort			:YSort				= $YSort

export(float) var grid_size						= 16.0
export(PackedScene) var tree_scene				= preload("res://level_design/tree_0.tscn")
export(int) var tree_amount 					= 300 
export(int) var decoration_tile_amount 			= 2250
export(int) var x_size 							= 200
export(int) var y_size 							= 200

var decoration_list 		:Array
var position_list 			:Array
var numTile 				:int = 5

var enemys 				:Array 			= [	preload("res://inimigos/enemy_0.tscn"), 
											preload("res://inimigos/enemy_1.tscn"), 
											preload("res://inimigos/enemy_2.tscn")]
var enemy 				:int 			= 0
var numEnemy			:int			= 30

func _ready():
	randomize()
	spawn_enemys()
	generate_base_tile(x_size, y_size)
	$Timer.start()

func generate_base_tile(width :int, height :int):
	for x in width:
		for y in height:
			tile.set_cell(x, y, 0)
	
	generate_decoration_tile()
	spawn_player()


func generate_decoration_tile():
	for decoration in decoration_tile_amount:
		var random_pos: Array = random_spawn_position(x_size, y_size)
		tile.set_cell(random_pos[0], random_pos[1], randi() % numTile + 1)
	
	for tree in tree_amount:
		spawn_tree()


func random_spawn_position(width :int, height :int):
	var x_pos :int = randi() % width
	var y_pos :int = randi() % height
	
	if decoration_list.has( Vector2(x_pos, y_pos) ):
		return random_spawn_position(width, height)
	
	decoration_list.append( Vector2(x_pos, y_pos) )
	return [x_pos, y_pos]


func spawn_tree():
	var treeInstance :Object = tree_scene.instance()
	y_sort.add_child(treeInstance)
	var random_pos :Array = spawn_position()
	treeInstance.global_position = Vector2(random_pos[0], random_pos[1]) * grid_size


func spawn_position():
	var used_tile_rect: Rect2 = tile.get_used_rect()
	var x_pos: float = randi() % int(used_tile_rect.size.x - 2) + (used_tile_rect.position.x + 1)
	var y_pos: float = randi() % int(used_tile_rect.size.y - 2) + (used_tile_rect.position.y + 1)
	if position_list.has( Vector2(x_pos, y_pos) ):
		return spawn_position()
	
	position_list.append( Vector2(x_pos, y_pos) )
	return [x_pos, y_pos]


func spawn_player():
	$palyer.global_position = grid_size * Vector2(x_size/2, y_size/2)


func _physics_process(delta):
	spawn_enemys()


func peak_enemys() -> Array:
	var enemys_array :Array
	var childrens	:Array = self.get_children()
	
	for children in childrens:
		if children.is_in_group("enemy"):
			enemys_array.append(children)
	
	return enemys_array


func get_player() -> Object:
	var nodes :Array = self.get_children()
	
	for node in nodes:
		if node.is_in_group("player"):
			return node
	
	return null


func spawn_enemys():
	if get_tree().get_nodes_in_group("enemy").size() < numEnemy:
		# enemy = int( rand_range( 0, enemys.size() ) )
		var num = int(rand_range(0, 10000))
		if num >= 0 and num <= 7800:
			enemy = 0
		if num > 7800 and num <= 7900:
			enemy = 1
		if num > 7900 and num <= 10000:
			enemy = 2
		yield(get_tree().create_timer(1), "timeout")
		var enemyInstance = enemys[enemy].instance()
		enemyInstance.global_position = ( player.global_position + Vector2(304, 0) ).rotated( rand_range(0, 2*PI) )
		add_child(enemyInstance)


func _on_Timer_timeout():
	Global.onda 			+= 1
	numEnemy 				+= 1 * Global.onda
	$Timer.start(15)
