extends Node2D

#export variables
#NOTE - This is the amount of pixels per frame the slime Momster is to progress along the path before it is multiplied by delta
@export var pathProgressSpeed := 20
#Onready variables
@onready var player = get_node("Player/WaterTank")
@onready var playerHP = player.get_node("Health").currentHealth
@onready var crudNode = get_node("Enemies/Crud")
@onready var slimePathFollow = get_node("Enemies/Slime/SlimePath/SlimePathFollow2D")
@onready var screenSize = get_viewport_rect().size
@onready var scoreDisplay = get_node("UIRoot/ScorePanel/ScoreDisplay")
@onready var slimeTimer = get_node("SlimeSpawnTimer")
#Preload Variables
var largeCrud = preload("res://Enemies/large_crud.tscn")
var slimeMonster = preload("res://Enemies/slime_monster.tscn")

#Create random number generator
var RNG = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	Scoring.currentScore = 0
	slimeTimer.start()
	

func _process(_delta):
	scoreDisplay.text = "%s" % str(Scoring.currentScore) 
	
	if crudNode.get_child_count() == 0 and slimePathFollow.get_child_count() == 0:
		for i in range(0,4):
			spawnCrud()
		slimeTimer.start()
	
	playerHP = player.get_node("Health").currentHealth
	
	match playerHP:
		2:
			get_node("UIRoot/HP_Display/HP3").visible = false
		1:
			get_node("UIRoot/HP_Display/HP2").visible = false
		0:
			get_node("UIRoot/HP_Display/HP1").visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	slimePathFollow.progress += pathProgressSpeed * delta


func spawnCrud():
	var newCrud = largeCrud.instantiate()
	newCrud.global_position = Vector2(randi_range(0,screenSize.x),randi_range(0,screenSize.y))

	crudNode.add_child(newCrud)

func spawnSlimeMonster():
	var newSlimeMonster = slimeMonster.instantiate()
	newSlimeMonster.target = player
	newSlimeMonster.rotation = 90
	slimePathFollow.progress = 0
	slimePathFollow.add_child(newSlimeMonster)


func _on_slime_spawn_timer_timeout():
	spawnSlimeMonster()


func _on_water_tank_died():
	#Scoring.saveGame()
	get_tree().change_scene_to_file("res://Scenes/score_save_screen.tscn")
