extends Node2D

@onready var firstPlace = get_node("UIRoot/HighScoresContainer/1stPlaceContainer/1stPlaceLabel")
@onready var secondPlace = get_node("UIRoot/HighScoresContainer/2ndPlaceContainer/2ndPlaceLabel")
@onready var thirdPlace = get_node("UIRoot/HighScoresContainer/3rdPlaceContainer/3rdPlaceLabel")
@onready var fourthPlace = get_node("UIRoot/HighScoresContainer/4thPlaceContainer/4thPlaceLabel")
@onready var fifthPlace = get_node("UIRoot/HighScoresContainer/5thPlaceContainer/5thPlaceLabel")

const formatString = "{name} - - -  {score}"

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _ready():
	firstPlace.text = formatString.format({"name":Scoring.highscores["first"][0],"score":Scoring.highscores["first"][1]})
	secondPlace.text = formatString.format({"name":Scoring.highscores["second"][0],"score":Scoring.highscores["second"][1]})
	thirdPlace.text = formatString.format({"name":Scoring.highscores["third"][0],"score":Scoring.highscores["third"][1]})
	fourthPlace.text = formatString.format({"name":Scoring.highscores["fourth"][0],"score":Scoring.highscores["fourth"][1]})
	fifthPlace.text = formatString.format({"name":Scoring.highscores["fifth"][0],"score":Scoring.highscores["fifth"][1]})
