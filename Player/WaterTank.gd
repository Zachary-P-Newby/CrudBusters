extends CharacterBody2D
class_name waterTank

var damage = 1

#Direction vars
var driveDirection : int
var rotationDirection : int
var facingAngle := 0.00

#Get Health node
@onready var health = get_node("Health")

#Export vars
@export var rotationSpeed := 0.00
@export var speed := 400
#passed as value for weight in lerp function for slowing down
@export var slowdown := .5

#BubbleShot set up
var bubbleShot = preload("res://Projectiles/bubble_shot.tscn")
@onready var muzzle: Marker2D = $Muzzle
@onready var bubbleShotTrajectory: Marker2D = $BubbleShotTrajectory

signal died

#Functions
func _ready():
	rotate(PI)

func get_input():
	"""Gets user input - got idea from Godot docs"""
	
	rotationDirection = int(Input.get_axis("ui_left","ui_right"))
	driveDirection = int(Input.get_axis("ui_down","ui_up"))
	
	if Input.is_action_just_pressed("ui_accept"):
		shoot()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	get_input()
	#driving movement
	if driveDirection:
		velocity = transform.y * driveDirection * speed * delta
	else:
		#slow to a stop
		velocity = lerp(velocity,Vector2(0,0),slowdown)
	
	#Turning movement
	if rotationDirection:
		rotate(rotationDirection * rotationSpeed * delta)
	
	var collision = move_and_collide(velocity)
	if collision:
		var collider = collision.get_collider()
		health.takeDamage(collider.damage)
		#health.call_deferred("takeDamage",collider.damage)
	

func die():
	emit_signal("died")
	queue_free()
	
func shoot():
	var bubbleShotInstance = bubbleShot.instantiate() as Node2D
	bubbleShotInstance.global_position = muzzle.global_position
	bubbleShotInstance.headTowards = bubbleShotTrajectory.global_position
	#NOTE: Bubbleshot trajectory affects bubble shot speed. Keep it to 40px away from muzzle marker
	add_sibling(bubbleShotInstance)


func _on_hitbox_body_entered(body):
	if body.name in ["SlimeMonster","SlimeBall","SmallCrud","MediumCrud","LargeCrud"]:
		health.takeDamage(body.damage)
		global_position = Vector2(664,362)

