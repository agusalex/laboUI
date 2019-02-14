extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var actualTube

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func show_description():
	$PopupDialog.show_message(actualTube.text, get_viewport().get_mouse_position())
	
func hide_description():
	$PopupDialog.hide_message()
	
func show_confirm_dialog():
	$ConfirmationDialog.show_messge("¿Seguro que desea combinar estos dos ingredientes?")
	
func hide_confirm_dialog():
	$ConfirmationDialog.hide_message()