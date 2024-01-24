extends "res://Enemies/CrudBase.gd"

var medCrud = preload("res://Enemies/medium_crud.tscn")
@export var spawnOffset := 20


func die():
	Scoring.currentScore += 100
	var spawnPosistions = [global_position + Vector2(spawnOffset,spawnOffset),global_position + Vector2(-spawnOffset,-spawnOffset)]
	for i in spawnPosistions:
		var newCrud = medCrud.instantiate() as Node2D
		newCrud.global_position = i

		call_deferred("add_sibling", newCrud)
	queue_free()


func _on_hitbox_body_entered(body):
	if body.name == "BubbleShot":
		health.takeDamage(body.damage)
		#Turn 180 degrees - I may remove this
		rotate(PI)
