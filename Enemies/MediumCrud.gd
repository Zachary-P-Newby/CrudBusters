extends "res://Enemies/CrudBase.gd"

var smallCrud = preload("res://Enemies/small_crud.tscn")
@export var spawnOffset := 20

func die():
	Scoring.currentScore += 50
	var spawnPosistions = [global_position + Vector2(spawnOffset,spawnOffset),global_position + Vector2(-spawnOffset,-spawnOffset),global_position + Vector2(spawnOffset,-spawnOffset),global_position + Vector2(-spawnOffset,spawnOffset)]
	for i in spawnPosistions:
		var newCrud = smallCrud.instantiate() as Node2D
		newCrud.global_position = i
		
		call_deferred("add_sibling", newCrud)
	queue_free()

