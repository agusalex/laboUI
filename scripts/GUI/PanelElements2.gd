extends Panel

enum STATE {
		mixture,
		solid,
		liquid,
		gas
	}

onready  var itemList = $ElementsList

func _ready():
	#Initialize Item list.
	itemList.set_max_columns(9)
	itemList.set_fixed_icon_size(Vector2(48,48))
	itemList.set_icon_mode(ItemList.ICON_MODE_TOP)
	itemList.set_select_mode(ItemList.SELECT_SINGLE)
	itemList.set_same_column_width(true)
	
#	for i in range(1, 6):
#
#		var icon
#
#		icon = ResourceLoader.load("res://assets/elements/element" + str(i) + ".png")
#		itemList.add_item("", icon, true)

	hide()


func load_data(state): #state = mixture, solid, liquid, gas
	
	itemList.clear()
	
	for i in range(1, 4):
		
		var icon
		
		icon = ResourceLoader.load("res://assets/elements/" + state + "/" + state + str(i) + ".png")
		itemList.add_item("", icon, true)

func _on_Button_pressed():
	load_data("mixture")


func _on_Button2_pressed():
	load_data("solid")


func _on_Button3_pressed():
	load_data("liquid")


func _on_Button4_pressed():
	load_data("gas")
