extends KinematicBody2D

var speed = 250
var velocity = Vector2()
var gravity = 8
var is_inside = false
const TYPE = "TUBE"

export (String) var text
var collide
signal hit


func get_input():
	# Detect up/down/left/right keystate and only move when pressed
	velocity = Vector2()
	velocity.y = gravity
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()
	move_and_collide(velocity * delta)
	if is_inside:
		self.set_global_position(get_global_mouse_position())
	
	
func _on_Test_Tube_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		is_inside = true
		print("se ha clickeado dentro")
	if event.is_action_released("left_click"):
		is_inside = false
		print("se ha soltado el click")
		
	if !collide:
		get_parent().actualTube = self
		emit_signal("hit")



func _on_Area2D_body_entered(body):
	if(body.get("TYPE")=="TUBE"&&body.get_instance_id ()!=get_instance_id () ):
		print("collided with tube: ID="+str(body.get_instance_id ()))
		collide = true
		get_parent().show_confirm_dialog()
		
	else:
		collide = false
	
	#for body in $Area2D.get_overlapping_bodies():