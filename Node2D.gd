extends Node2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click"):
		$ProgressBar.value += 10
		var style = StyleBoxFlat.new()
		var color = Color(0,0,1)
		style.set_bg_color(color)
		$ProgressBar.set("custom_styles/fg", style)