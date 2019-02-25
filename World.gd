extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var actualTube
onready var staticTube
var tools_bar_is_visible = false
var elements_bar_is_visible = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func update_tubes():
	
#	actualTube == get_node("Test Tube") ? staticTube = get_node("Test Tube2") : staticTube = get_node("Test Tube")
	
	if actualTube == get_node("Test Tube"):
		staticTube = get_node("Test Tube2")
	else:
		staticTube = get_node("Test Tube")
		actualTube = get_node("Test Tube2")
	

func show_description():
	$PopupDialog.show_message(actualTube.text, get_viewport().get_mouse_position())
	
func hide_description():
	$PopupDialog.hide_message()
	
func show_confirm_dialog():
#	$ConfirmationDialog.show_messge("¿Seguro que desea combinar estos dos ingredientes?")
#	$ConfirmationDialog.get_ok()

	actualTube.position.x = staticTube.position.x + 70
	actualTube.position.y = staticTube.position.y - 70

	$ConfirmationDialog2.show_messge("Cantidad de H2SO4:", "Cantidad de Fe(OH)2:")
	$ConfirmationDialog2.get_ok()
	get_tree().paused = true
	
func hide_confirm_dialog():
#	$ConfirmationDialog.hide_message()

	$ConfirmationDialog2.hide_message()

func _on_ItemList_item_selected(index):
#	Global_ItemDatabase.show_data(Global_ItemDatabase.get_item(index+1))
	var item = Global_ItemDatabase.get_item(index+1)
	if item != null:
		$PopupItems.show_message(item, get_viewport().get_mouse_position())


func _on_ToolsButton_pressed():
	tools_bar_is_visible = !tools_bar_is_visible
	if tools_bar_is_visible:
		$ToolsPanel.show()
	else:
		$ToolsPanel.hide()


func _on_ElementsButton_pressed():
	elements_bar_is_visible = !elements_bar_is_visible
	if elements_bar_is_visible:
#		$PanelElements.show()
		$PanelElements2.show()
	else:
#		$PanelElements.hide()
		$PanelElements2.hide()


func _on_ElementsList_item_selected(index):
	var item = Global_ElementDatabase.get_item(index+1)
	if item != null:
		$PopupElements.show_message(item, get_viewport().get_mouse_position())


func _on_ConfirmationDialog_confirmed():
	staticTube.change_texture()
	staticTube.text = "FeSO4"
	actualTube.delete()
#	remove_child(actualTube)
#	actualTube.hide()
	
#	actualTube.change_texture()
#	$"Test Tube2/Sprite".self_modulate = Color(0,1,0)
#	((KinematicBody2D) actualTube).get_node("Sprite").texture = load("res://tubo amarillo.png")
#	$"Test Tube/Sprite".texture = load("res://tubo amarillo.png")
#	actualTube.get_node("Sprite").texture = load("res://tubo amarillo.png")
#	actualTube/Sprite.texture = load("res://tubo amarillo.png")
#	actualTube/Sprite.texture = load("res://tubo amarillo.png")


func _on_ConfirmationDialog2_confirmed():
	
	get_tree().paused = false
	
	var fst_ipt = int($ConfirmationDialog2.get_first_input())
	var snd_ipt = int($ConfirmationDialog2.get_second_input())
	
	if fst_ipt == 1 && snd_ipt == 1:
		staticTube.change_texture()
		staticTube.text = "FeSO4"
		actualTube.delete()
	else:
		$PopupDialogWrongAnswer.show_message("La combinación ingresada no es correcta.")
	
	

func _on_ConfirmationDialog2_hide():
	get_tree().paused = false
#	$"Test Tube".interaction = false
#	$"Test Tube2".interaction = false
	$"Test Tube".reset(446, 256)
	$"Test Tube2".reset(523, 260)
	actualTube.rotate(1.5708)