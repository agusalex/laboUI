extends KinematicBody2D

var motion = Vector2()
var UP = Vector2(0,-1)
var GRAVITY = 8
var JUMP_HEIGHT=400
var SPEED = 100
var is_inside = false


#Keyboard Controls
func _process(delta):
	if is_inside:
		self.set_global_position(get_global_mouse_position())
		
func _physics_process(delta): 
	motion.y+=GRAVITY
	if(Input.is_action_pressed("ui_right")):
		motion.x=SPEED
	elif(Input.is_action_pressed("ui_left")):
		motion.x=-SPEED
	else:
		motion.x = 0

	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = -JUMP_HEIGHT	
	motion = move_and_slide(motion,UP)
#	pass
#
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	
func _ready():
	set_process(true)
	
func _on_area_input_event( viewport, event, shape_idx ):
	if event.is_action_pressed("left_click"):
		is_inside = true
		print("se ha clickeado dentro")
	if event.is_action_released("left_click"):
		is_inside = false
		print("se ha soltado el click")


