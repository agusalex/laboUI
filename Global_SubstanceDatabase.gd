extends Node

var url_database_item = "res://Database//Database_Substances.json"

var substancia = load("res://Substancia2.tscn")

func show_data(item):
	if item == null :
		print("El item es null")
		return
	print("ID: " + String(item['id']))
	print("Nombre: " + item['name'])
	print("Color: RGB(" + String(item['color']['r']) + ", " + String(item['color']['g']) + ", " + String(item['color']['b']) + ")")
	print("Expresión: " + item['expression'])

func ready():
	pass

func get_item(id):
	
	var itemData = {}
	
	itemData = Global_DataParser.load_data(url_database_item)
	
	if !itemData.has(str(id)):
		print("Item does not exist.")
		return
	
#	itemData[String(id)]["id"] = int(id)
#	return itemData[String(id)]
	var s = substancia.instance()
	var item = itemData[String(id)]
	
	s.nombre = item['name']
	
	var r = item['color']['r']
	var g = item['color']['g']
	var b = item['color']['b']
	
	s.color = Color(r, g, b)
	
	s.expression = item['expression']
	
	s.aggregation_state = item['aggregation_state']
	
	s.colorear()
	
	return s
	
func get_all():
	var data = {}
	
	data = Global_DataParser.load_data(url_database_item)
	
	if data.size() <= 0:
		return
	
	var substancias = Array()
	
	for idx in data:
		var s = substancia.instance()
		var item = data[idx]
		
		s.nombre = item['name']
		var r =  item['color']['r']
		var g =  item['color']['g']
		var b =  item['color']['b']
		s.color = Color(r, g, b)
		s.expression = item['expression']
		s.aggregation_state = item['aggregation_state']
		
		s.colorear()
		
		substancias.append(s)
	
#	return data
	return substancias