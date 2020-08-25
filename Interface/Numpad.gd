extends Popup

var combination = [0,4,5,1]
var guess = []
var enabled = true

onready var display = $VBoxContainer/DisplayContainer/Display
onready var statusLight = $VBoxContainer/ButtonContainer/GridContainer/StatusLight

signal combination_correct

func _ready():
	connect_buttons()
	reset_lock()
	
func connect_buttons():
	for child in $VBoxContainer/ButtonContainer/GridContainer.get_children():
		if child is Button:
			child.connect("pressed", self, "Button_pressed", [child.text])
			
func Button_pressed(button):
	if enabled:
		if button == "OK":
			check_guess()
		#NOTE: Does not support non-integer buttons other thank OK (aka, "a, b, ;, etc")
		else:
			enter( int(button) )
	
func check_guess():
	if guess == combination:
		
		$AudioStreamPlayer.stream = load("res://SFX/threeTone1.ogg")
		$AudioStreamPlayer.play()
		$AnimationPlayer.play("keypad_success")
		# Too complicated to have the keypad reset tied to the animation?
	else:
		$AudioStreamPlayer.stream = load("res://SFX/twoTone1.ogg")
		$AudioStreamPlayer.play()
		reset_lock()

func enter(button):
	guess.append(button)
	update_display()

func update_display():
	display.text = PoolStringArray(guess).join("")
	if guess.size() == combination.size():
		check_guess()
	
func reset_lock():
	display.text = ""
	guess.clear()


func _on_AnimationPlayer_animation_started(anim_name):
	enabled = false


func _on_AnimationPlayer_animation_finished(anim_name):
	enabled = true
	reset_lock()
	emit_signal("combination_correct")
