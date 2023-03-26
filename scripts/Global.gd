extends Node

var playerPosition		:Vector2		= Vector2.ZERO

var vida 				:int			= 5
var dir_x 				:int			= 0
var dir_y 				:int			= 0
var acel 				:int			= 70
var onda				:int			= 0
var mortos				:int			= 0
var hitDist				:int			= 12
var powerUp				:int			= 0
var olhandoDir			:bool			= false
var canHited			:bool			= true
var cooldown			:float			= .3
var expInimigo			:float			= 1.0
var expAgr				:float			= 0.0
var exper				:float			= 10
var level				:float			= 0
var dano 				:float			= 0
var gun					:String			= "gun"

func dist_to_player(par1, par2):
	return sqrt( pow( (par2[0] - par1.global_position[0]), 2) + pow( (par2[1] - par1.global_position[1]), 2) )


func dist_to(par1, par2):
	return sqrt( pow( (par2.global_position[0] - par1.global_position[0]), 2) + pow( (par2.global_position[1] - par1.global_position[1]), 2) )
