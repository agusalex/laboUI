extends PopupDialog

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func show_message(item, position):
	rect_position = position
	rect_position.x = rect_position.x + 10
	rect_position.y = rect_position.y + 10
	var description = "ID: " + String(item['id']) + "\nName: " + item['name'] + "\nType: " + item['type'] + "\nDescription: " + item['description']
	$Label.text = description
	$Label.show()
	popup()
	
func hide_message():
	hide()