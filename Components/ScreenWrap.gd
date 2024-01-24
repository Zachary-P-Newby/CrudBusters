extends Node2D
class_name ScreenWrap

@export var screenWrapMargin := 10
@onready var screenSize = get_viewport_rect().size
@onready var parent = get_parent()

func screenWrap():
	if parent.position.x > screenSize.x + screenWrapMargin:
		parent.position.x = -screenWrapMargin
	
	if parent.position.x < -screenWrapMargin:
		parent.position.x = screenSize.x + screenWrapMargin
	
	if parent.position.y > screenSize.y + screenWrapMargin:
		parent.position.y = -screenWrapMargin
	
	if parent.position.y < -screenWrapMargin:
		parent.position.y = screenSize.y + screenWrapMargin

func _process(_delta):
	screenWrap()
