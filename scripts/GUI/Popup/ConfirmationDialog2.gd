extends ConfirmationDialog

# Este Nodo es solo para testear lo de agregar las cantidades de cada reactivo.
# Si queda este borramos el otro ConfirmDialog.

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func show_messge(text1, text2):
	$Panel/Label2.show()
	$Panel/Label3.show()
	popup()
	
func hide_message():
	hide()
	
func get_first_input():
	return $Panel/LineEdit.text
	
func get_second_input():
	return $Panel/LineEdit2.text