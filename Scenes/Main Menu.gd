extends Node2D

func _ready():
	Scoring.loadScores()


func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://levels/level_classic.tscn")


func _on_highscores_pressed():
	get_tree().change_scene_to_file("res://levels/high_scores.tscn")


func _on_how_to_play_pressed():
	get_tree().change_scene_to_file("res://levels/how_to_play.tscn")
