extends PopupDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func show_message():
	$Label.text = "Actividad Nº 1\n\nConsigna: Generar 70mg de\nSulfato de Hierro (FeSO4)."
	$Label.show()
	popup()
	
func hide_message():
	hide()
