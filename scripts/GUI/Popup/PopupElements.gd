extends PopupDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func show_message(item, position):
	rect_position = position
	rect_position.x = rect_position.x + 10
	rect_position.y = rect_position.y + 10
	var description = "Nombre: " + String(item['name']) + "\nSímbolo: " + item['symbol'] + "\nNúmero Atómico: " + str(item['atomic_number']) + "\nMasa Atómica: " + str(item['atomic_mass']) + "\nDensidad: " + str(item['density'])
	$Label.text = description
	$Label.show()
	popup()
	
func hide_message():
	hide()