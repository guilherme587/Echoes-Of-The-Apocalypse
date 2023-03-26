extends Node2D


func _ready():
	$AudioStreamPlayer.play()

func play_music():
	$AudioStreamPlayer.play()


func play_cheats():
	$AudioStreamPlayer2.play()
	$AudioStreamPlayer.stop()


