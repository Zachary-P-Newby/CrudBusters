extends CharacterBody2D
class_name CrudBase

@onready var health = get_node("Health")
@onready var screenSize = get_viewport_rect().size
@onready var rng = RandomNumberGenerator.new()
@export var damage := 1
@export var speed := 150

func _ready():
	#Rotate to face a random direction
	rotate(rng.randi_range(0,int(2 * PI)))
	#Set velocity
	velocity = transform.y * speed


func _physics_process(delta):
	#Move and detect collisions
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		health.takeDamage(collider.damage)
		rotate(PI)



func die():
	Scoring.currentScore += 25
	queue_free()



func _on_hitbox_body_entered(body):
	if body.name == "BubbleShot":
		health.takeDamage(body.damage)
		body.queue_free()
