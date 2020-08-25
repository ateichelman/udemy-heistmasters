extends "res://Characters/TemplateCharacter.gd"

const FOV_TOLERANCE = 20
const MAX_DETECTION_RANGE = 640
const RED = Color(1,0.25,0.25)
const WHITE = Color(1,1,1)

var Player
var Torch

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Player = get_node("/root").find_node("Player", true, false)

func _process(delta):
	if Player_in_FOV() and Player_in_LOS():
		$Torch.set_color(RED)
	else:
		$Torch.set_color(WHITE)

func Player_in_FOV():
	var npc_facing_direction = Vector2(1,0).rotated(global_rotation)
	# It minus me.
	var direction_to_Player = (Player.position - global_position).normalized()
	if abs(direction_to_Player.angle_to(npc_facing_direction)) < deg2rad(FOV_TOLERANCE):
		return true
	else:
		return false
		
func Player_in_LOS():
	var space = get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray(global_position, Player.global_position, [self], collision_mask)
	
	if not LOS_obstacle:
		return false
	
	var distance_to_player = Player.global_position.distance_to(global_position)
	
	if distance_to_player > MAX_DETECTION_RANGE:
		return false
	
	if LOS_obstacle.collider == Player:
		return true
	else:
		return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
