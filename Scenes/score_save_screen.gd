extends Node2D

var playerName := ""

func _ready():
	get_node("UIRoot/ScoreDisplay/scoreLabel").text = "Your score: %s" % str(Scoring.currentScore)

func _on_save_score_button_pressed():
	Scoring.saveGame(playerName)
	
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_line_edit_text_changed(new_text):
	playerName = new_text
