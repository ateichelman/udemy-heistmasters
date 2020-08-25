extends "res://Doors/Door.gd"

func _on_Door_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and canClick:
		$CanvasLayer/Numpad.popup_centered()

func _on_Door_body_exited(body):
	if body.collision_layer == 1: #its the player!
		$CanvasLayer/Numpad.hide()
		canClick = false


func _on_Numpad_combination_correct():
	open()
	$CanvasLayer/Numpad.hide()
