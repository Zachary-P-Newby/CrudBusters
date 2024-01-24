extends Node

var currentScore = 0
var highscores : Dictionary
const savePath = "user://savegame.bin"

#score management functions
func saveScore(playerName: String):
	"""Save new High score to one of the score slots, shift all scores it is greater than down one slot. Lowest score is deleted"""
	if currentScore >= highscores["first"][1]:
		highscores["fifth"] = highscores["fourth"]
		highscores["fourth"] = highscores["third"]
		highscores["third"] = highscores["second"]
		highscores["second"] = highscores["first"]
		highscores["first"] = [playerName,currentScore]
	
	elif currentScore >= highscores["second"][1]:
		highscores["fifth"] = highscores["fourth"]
		highscores["fourth"] = highscores["third"]
		highscores["third"] = highscores["second"]
		highscores["second"] = [playerName,currentScore]
	
	elif currentScore >= highscores["third"][1]:
		highscores["fifth"] = highscores["fourth"]
		highscores["fourth"] = highscores["third"]
		highscores["third"] = [playerName,currentScore]
	
	elif currentScore >= highscores["fourth"][1]:
		highscores["fifth"] = highscores["fourth"]
		highscores["fourth"] = [playerName,currentScore]
	
	elif currentScore >= highscores["fifth"][1]:
		highscores["fifth"] = [playerName,currentScore]
	else:
		pass

func saveGame(playerName: String):
	"""Saves game to .bin file in user's godot appdata see savePath"""
	saveScore(playerName)
	var file = FileAccess.open(savePath, FileAccess.WRITE)
	var jstr = JSON.stringify(highscores)
	file.store_line(jstr)


func loadScores():
	"""Loads scores from .bin file see savePath"""
	var file = FileAccess.open(savePath, FileAccess.READ)
	if FileAccess.file_exists(savePath):
		if not file.eof_reached():
			var currentLine = JSON.parse_string(file.get_line())
			if currentLine:
				highscores["first"] = currentLine["first"]
				highscores["second"] = currentLine["second"]
				highscores["third"] = currentLine["third"]
				highscores["fourth"] = currentLine["fourth"]
				highscores["fifth"] = currentLine["fifth"]
		else:
			pass
	else:
		highscores = {"first":["",0],"second":["",0],"third":["",0],"fourth":["",0],"fifth":["",0]}
