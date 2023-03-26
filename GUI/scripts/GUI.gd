extends CanvasLayer

onready var onda 			:Label			= $GridContainer/Label
onready var vida 			:Label			= $GridContainer/Label2
onready var mortos 			:Label			= $GridContainer/Label3
onready var level 			:Label			= $ColorRect/Label4
onready var exper 			:Label			= $ColorRect/Label5

func _physics_process(delta):
	onda.text 			= "wave    " + str(Global.onda)
	vida.text 			= "life    " + str(Global.vida)
	mortos.text 		= "kills   " + str(Global.mortos)
	level.text			= "level   " + str(Global.level)
	exper.text			= "exp     " + str(Global.expAgr) + "   " + str(Global.exper * (Global.level + 1) )
	
	var porcent :float = (Global.expAgr / (Global.exper * (Global.level + 1) ) )
	$ColorRect.rect_size.x = (304 * porcent)
