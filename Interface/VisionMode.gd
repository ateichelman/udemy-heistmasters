extends CanvasModulate

const DARK = Color("111111")
const NIGHTVISION = Color("37bf62")

var countdown_over = true

func _ready():
	color = DARK

# Consider the use of a state machine, my dude.a
func cycle_vision_mode():
	if countdown_over:
		if color == NIGHTVISION:
			DARK_mode()
		else:
			NIGHTVISION_mode()
		
func DARK_mode():
	color = DARK
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision_off.wav")
	$AudioStreamPlayer2D.play()
	start_timer()
	
func NIGHTVISION_mode():
	color = NIGHTVISION
	$AudioStreamPlayer2D.stream = load("res://SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()
	start_timer()

func start_timer():
	countdown_over = false
	$Timer.start()

func _on_Timer_timeout():
	countdown_over = true
