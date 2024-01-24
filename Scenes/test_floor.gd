extends Node2D

@onready var hpDisplay = get_node("Control/Panel/Label")
@onready var playerHealth = get_node("Player/WaterTank/Health")
@onready var slimeMonster = get_node("Enemies/Path2D/PathFollow2D/SlimeMonster")
@onready var player = get_node("Player/WaterTank")


@export var pathSpeed := 1.0
# Called every frame. 'delta' is the elapsed time since the previous frame.

func _ready():
	slimeMonster.target = player

func _process(delta):
	hpDisplay.text = str(playerHealth.currentHealth)
	get_node("Enemies/Path2D/PathFollow2D").progress += pathSpeed * delta
