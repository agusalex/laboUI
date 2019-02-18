extends Panel

onready  var itemList = $ElementsList

func _ready():
	#Initialize Item list.
	itemList.set_max_columns(9)
	itemList.set_fixed_icon_size(Vector2(48,48))
	itemList.set_icon_mode(ItemList.ICON_MODE_TOP)
	itemList.set_select_mode(ItemList.SELECT_SINGLE)
	itemList.set_same_column_width(true)
	
	for i in range(1, 6):
		
		var icon
		
		icon = ResourceLoader.load("res://assets/elements/element" + str(i) + ".png")
		itemList.add_item("", icon, true)

	hide()