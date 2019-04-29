extends ScrollContainer

var content = [] setget set_content, get_content
var row_ref = null
var MyData = null # just so we don't crash when drag&dropping on an empty cargo

signal OnChoiceDragAndDrop(container_src, container_dst, content_index_src, content_index_dst)

func _ready():
	
	row_ref = get_node("List/Row")
	set_content(Global_DataParser.load_data("Database/testList.json"))


#############	
#content ===> [{"src_key":"Database/shield.json", "amount":1}]
#############
func get_content():
	var result = []
	for d in content:
		var inside = {}
		inside["src_key"] = d.src_key
		inside["amount"] = d.amount
		inside["checked"] = d.obj.get_node("Choice").pressed
		result.push_back(inside)
	return result



func set_content(val):
	for d in content:
		d.obj.get_parent().remove_child(d.obj)
		d.obj.queue_free()
	content.clear()
	for v in val:
		#print(v)
		var copy = row_ref.duplicate()
		copy.visible = true
		row_ref.get_parent().add_child(copy)
		content.push_back({"obj": copy, "src_key":v.src_key, "amount":v.amount})
		var display = ""
		if v.src_key != null and v.src_key != "":
			var src_data = Global_DataParser.load_data(v.src_key)
			print("data"+ String(src_data))
			display = src_data.name_id
		copy.get_node("Choice/Name").bbcode_text = display+String(content.size())
		#copy.get_node("Choice").text = String(content.size() - 1) # index in content array
	
func can_drop_data(position, data):
	return choice_can_drop_data(self, data)
	
func drop_data(position, data):
	choice_drop_data(self, data)
	
func choice_can_drop_data(node_dest, data):
	if not "origin" in data:
		return false
	if data.origin == self:
		return false
		
	var src_content_data = data.origin.get_content()[data.content_index]
	if src_content_data.src_key == null or src_content_data.src_key == "":
		return false
	
	return true
	
func choice_drop_data(node_dest, data):
	#container_src, container_dst, content_index_src
	var mydata = 0
	if node_dest.MyData != null:
		mydata = node_dest.MyData.content_index
	emit_signal("OnChoiceDragAndDrop", data.origin, self, data.content_index, mydata)