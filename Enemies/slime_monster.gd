extends CharacterBody2D

var slimeball = preload("res://Enemies/slime_ball.tscn")
var damage = 1

@export var speed := 200

@onready var slimeballSpawn = get_node("SlimeballSpawn")
@onready var health = get_node("Health")
var target : CharacterBody2D



func _ready():
	pass

func _physics_process(_delta):
	pass


func _on_shot_timer_timeout():
	"""Shoot slimeball toward player on timeout"""

	var slimeballInstance = slimeball.instantiate() as Node2D
	slimeballInstance.global_position = slimeballSpawn.global_position
	slimeballInstance.target = target
	#NOTE: Bubbleshot trajectory affects bubble shot speed. Keep it to 40px away from muzzle marker
	get_parent().get_parent().get_parent().add_child(slimeballInstance)

func die():
	"""Runs when slimeMonster health = 0"""
	Scoring.currentScore += 250
	queue_free()


func _on_hitbox_body_entered(body):
	if body.name == "BubbleShot":
		health.takeDamage(body.damage)
		body.queue_free()
