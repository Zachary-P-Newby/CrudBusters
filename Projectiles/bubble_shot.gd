extends CharacterBody2D

var direction : Vector2
@export var damage := 1
@export var speed := 1.00


var headTowards: Vector2
@export var lifespanSeconds := 5
@onready var parent = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = headTowards - position
	#NOTE: The velocity is affected by how far the headtowards point is from the muzzle point (Bubbleshot spawn)
	get_node("Timer").start(lifespanSeconds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#direction * speed * delta
	var collision = move_and_collide(velocity * delta * speed)
	if collision:
		rotate(PI)
		queue_free()


func _on_timer_timeout():
	queue_free()
