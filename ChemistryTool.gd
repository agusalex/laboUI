extends KinematicBody2D

var clicked = false

func _ready():
	set_process(true)
	set_process_input(true)

func _process(delta):
	if clicked:
		self.position = get_global_mouse_position()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		clicked = true
		print("Haciendo click.")
	if event.is_action_released("left_click"):
		clicked = false
		print("Click soltado.")
