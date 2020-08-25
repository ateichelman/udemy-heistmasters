extends Area2D

var canClick = false



func _on_Door_body_entered(body):
	if body.collision_layer == 1: #its the player!
		canClick = true
	else:
		open()

func open():
	$AnimationPlayer.play("Open")

func _on_Door_body_exited(body):
	if body.collision_layer == 1: #its the player!
		canClick = false


func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and canClick:
		open()
