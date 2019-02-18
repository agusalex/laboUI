extends Node

var url_database_item = "res://Database//Database_Items.json"

func show_data(item):
	if item == null :
		print("El item es null")
		return
	print("ID: " + String(item['id']))
	print("Name: " + item['name'])
	print("Type: " + item['type'])
	print("Description: " + item['description'])

func ready():

	var itemData = get_item(1)
	
	if itemData == null:
		print("ItemData = null")
		return
		
	print("ID: " + String(itemData['id']))
	print("Name: " + itemData['name'])
	print("Type: " + itemData['type'])
	print("Description: " + itemData['description'])

func get_item(id):
	
	var itemData = {}
	
	itemData = Global_DataParser.load_data(url_database_item)
	
	if !itemData.has(str(id)):
		print("Item does not exist.")
		return
		
	itemData[String(id)]["id"] = int(id)
	return itemData[String(id)]