extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var itemList = $ItemList

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	itemList.set_max_columns(9)
	itemList.set_fixed_icon_size(Vector2(48, 48))
	itemList.set_icon_mode(ItemList.ICON_MODE_TOP)
	itemList.set_select_mode(ItemList.SELECT_SINGLE)
	itemList.set_same_column_width(true)
	
	for i in range(1, 164):
		var icon 
		
		if i < 10:
			icon = ResourceLoader.load("res://assets/PNG/Colored/genericItem_color_00" + String(i) + ".png")
			itemList.add_item("", icon, true)
			continue
			
		if i < 100:
			icon = ResourceLoader.load("res://assets/PNG/Colored/genericItem_color_0" + String(i) + ".png")
			itemList.add_item("", icon, true)
			continue
			
		icon = ResourceLoader.load("res://assets/PNG/Colored/genericItem_color_" + String(i) + ".png")
		itemList.add_item("", icon, true)
	
	hide()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
