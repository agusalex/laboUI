extends Node

var url_database_item = "res://Database//Database_Elements.json"

func show_data(item):
	if item == null :
		print("El item es null")
		return
	print("ID: " + String(item['id']))
	print("Name: " + item['name'])
	print("Symbol: " + item['symbol'])
	print("Número Atómico: " + item['atomic_number'])
	print("Masa Atómica: " + item['atomic_mass'])
	print("Densidad: " + item['density'])

func get_item(id):
	
	var itemData = {}
	
	itemData = Global_DataParser.load_data(url_database_item)
	
	if !itemData.has(str(id)):
		print("Item does not exist.")
		return
		
	itemData[String(id)]["id"] = int(id)
	return itemData[String(id)]