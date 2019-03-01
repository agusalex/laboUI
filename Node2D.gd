extends Node2D

signal hit
signal overwhelmed

export (float) var max_capacity = 100


func _ready():
	$ProgressBar.max_value = max_capacity

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

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "SUBSTANCE":
		emit_signal("hit")
		print("collided with substance: ID="+str(body.get_instance_id ()))


func fill(quantity):
	if $ProgressBar.value + quantity <= max_capacity:
		$ProgressBar.value += quantity
	else:
		emit_signal("overwhelmed")
