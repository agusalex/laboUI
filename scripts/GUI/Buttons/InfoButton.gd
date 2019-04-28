extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var info_visible = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _pressed():
	info_visible = !info_visible
	if info_visible:
		$PopupActivity.show_message()
	else:
		$PopupActivity.hide_message()
	
