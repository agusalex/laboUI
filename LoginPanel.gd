extends Panel
var username = ""
var password = ""
var token = ""
var authenticated = false
func _ready():
	pass

func _on_HTTPLoginRequest_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	if(response_code==200):
		print("success!")
		token = JSON.parse(body.get_string_from_utf8()).result.token
		authenticated = true
		get_tree().change_scene("res://World.tscn")
	else:
		authenticated = false
		$Username_not_Found.popup()

func make_post_request(url, data_to_send, use_ssl):
    # Convert data to json string:
    var query = JSON.print(data_to_send)
    # Add 'Content-Type' header:
    var headers = ["Content-Type: application/json"]
    $HTTPLoginRequest.request(url, headers, use_ssl, HTTPClient.METHOD_POST, query)


func login():
	if(!authenticated):
		var dic = {"username": username, "password": password} 
		make_post_request("http://django2-rest-api.herokuapp.com/get-token/",dic,false)
	


func _on_LoginButton_pressed():
	username = $User.text
	password = $Password.text
	if(username != ""):
		login()
	else:
		get_tree().change_scene("res://World.tscn")
	
	

	
	#$HTTPRequest.request("http://django2-rest-api.herokuapp.com/get-token/ username=admin password=admin")

	
	#if(json!=null):
	#	print(json.result)
	#var username = $User.text
	#var password = $Password.text
	#
	#for usuario in json.result.users.user:
	#	if(usuario.username==username):
	#		if(usuario.password==password):
	#			get_tree().change_scene("res://World.tscn")
	#		else:
	#			$Username_not_Found.popup()
	#	else:
	#		$Username_not_Found.popup()
			
	



