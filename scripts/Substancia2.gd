extends KinematicBody2D

var nombre
var color
var expression
var aggregation_state #agregarlo a la base de datos
const TYPE = "SUBSTANCE"

var texture = preload("res://assets/tools/tube.png")
#const AggregationStates = preload("res://Aggregation_States.gd")

var is_inside

signal selected(instance)
signal mouseOver(instance)
var mouse_inside

func _ready():
	$Sprite.set_texture(texture)
	set_process(true)

func _process(delta):
	if is_inside:
#		self.set_global_pos(get_global_mouse_position())
		self.global_position = get_global_mouse_position()
		
	if mouse_inside:
		emit_signal("mouseOver", self)


func _on_Area2D_input_event(viewport, event, shape_idx): # No entiendo por qué _on_Substancia2_input_event no funciona pero éste sí
	if event.is_action_pressed("left_click"):
		is_inside = true
		emit_signal("selected", self)
		print("Se ha clickeado dentro")
	if event.is_action_released("left_click"):
		is_inside = false
#		
		print("Se ha soltado el click")

	if (event is InputEventMouseMotion || event is InputEventScreenTouch):
		mouse_inside = true

func colorear():
	$Sprite.self_modulate = color

func getImage():
	return $Sprite.texture


func _on_Area2D_mouse_exited(): # No entiendo por qué _on_Substancia2_mouse_exited no funciona pero éste sí
	mouse_inside = false
	emit_signal("mouseOver", self)
