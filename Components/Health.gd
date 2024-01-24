extends Node
class_name Health
"""Health component class
maxHealth is the maximum health value
initalHealth is the health on scene load
currentHealth is the health of the object at any given moment, when it reaches zero a call to the parent object to run the die function is sent

Do not set initalHealth above maxHealth to prevent bugs
"""

@export var maxHealth : int
@export var initialHealth : int

var currentHealth : int
@onready var parentSprite = get_parent().get_node("Sprite2D")
@onready var ogColor = parentSprite.self_modulate
var invincible = false

func _ready():
	currentHealth = initialHealth

func _process(_delta):
	if invincible:
		await get_tree().create_timer(0.3).timeout
		invincible = false

func takeDamage(damage: int) -> void:
	if not invincible:
		currentHealth -=damage
		Scoring.currentScore += 10
		if currentHealth <= 0:
			get_parent().call_deferred("die")
		else:
			invincible = true
			parentSprite.self_modulate = Color(255,0,0,.7)
			await get_tree().create_timer(0.3).timeout
			parentSprite.self_modulate = ogColor
