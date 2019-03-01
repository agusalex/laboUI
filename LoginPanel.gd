extends Panel
var json

func _ready():
	$HTTPRequest.request("http://www.mocky.io/v2/5c7892d6300000780049aeb9")

func _on_HTTPRequest_request_completed( result, response_code, headers, body ):
    json = JSON.parse(body.get_string_from_utf8())

func _on_LoginButton_pressed():
	print(json.result)
	var username = $User.text
	var password = $Password.text
	
	for usuario in json.result.users.user:
		if(usuario.username==username):
			if(usuario.password==password):
				get_tree().change_scene("res://World.tscn")
			else:
				$Username_not_Found.popup()
		else:
			$Username_not_Found.popup()
			
	