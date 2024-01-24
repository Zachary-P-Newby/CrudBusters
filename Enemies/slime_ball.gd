extends "res://Projectiles/Projectile.gd"

var target : CharacterBody2D
@export var lifespanSeconds := 5
@onready var parent = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	#NOTE: The velocity is affected by how far the headtowards point is from the muzzle point
	velocity = target.global_position - position
	get_node("Timer").start(lifespanSeconds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#direction * speed * delta
	#velocity = target.global_position - position
	var collision = move_and_collide(velocity * delta * speed)
	if collision:
		rotate(PI)
		await get_tree().create_timer(.2).timeout
		queue_free()


func _on_timer_timeout():
	queue_free()
