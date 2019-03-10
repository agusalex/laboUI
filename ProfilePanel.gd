extends Panel

var URL = "http://laboapi.herokuapp.com/api/rest-auth/user/"
var passwordMessage = "- La contraseña debe contener al menos: un numero, una letra y tener un minimo de 8 caracteres sin simbolos especiales"
var emailMessage = "- Introduzca una direccion de email valida"
var NameMessage = "- Introduzca un nombre valido"
var LastNameMessage = "- Introduzca un apellido valido"
var username = ""


func _ready():
	if(Game.getState() == Game.State.PROFILE_FIRST_RUN):
		$SaveButton.visible = false
		$BackButton.visible = false
		$EndButton.visible = true
	else:
		$EndButton.visible = false
		Game.setState(Game.State.PROFILE)
	
	if(Token.isAuthenticated()):
		makeGetRequest()
	else:
		get_tree().change_scene("res://Login.tscn")

func _on_BackButton_pressed():
	get_tree().change_scene("res://World.tscn")
	
	
func _on_SaveButton_pressed():
	
	var validName = true
	var validLastName = true
	
	#validEmail = RegexUtils.regexFullMatch(RegexUtils.EXPRESSION.validEmail,$Email.text)
	validName = (!RegexUtils.regexPartialMatch(RegexUtils.EXPRESSION.invalidName,$Name.text))&&($Name.text.length()>1)
	validLastName = (!RegexUtils.regexPartialMatch(RegexUtils.EXPRESSION.invalidName,$LastName.text))&&($LastName.text.length()>1)
	#register($Name.text.capitalize(),$Last.text.capitalize(),)
	if(validName&&validLastName):
		update($Name.text.capitalize(),$LastName.text.capitalize())
	else:
		var verificationArray = [validName,validLastName]
		var messageArray = [NameMessage,LastNameMessage]
		var popupMessage = "Error de validacion:"
		for i in range(verificationArray.size()):
			popupMessage = popupMessage + "\n"
			if verificationArray[i]==false:
				popupMessage = popupMessage+messageArray[i]
				
		$InvalidFields.dialog_text = popupMessage
		$InvalidFields.popup()
		#$InvalidUsename.dialog_text=
	#if($User.text != ""):
	#	register($User.text,$Password.text)

func update(name,lastname):
		var credentialsDict = {"first_name":name,"last_name":lastname,"username":username} 		#dictionary with credentials "first_name":name,"last_name":lastname
		makeUpdateRequest(credentialsDict)	
	
	
func makeGetRequest():
	$SaveButton.disabled = true
	$BackButton.disabled = true
	var headers = ["Content-Type: application/json","Authorization: Token "+Token.getToken()]   # Add 'Content-Type' header:
	$HTTPProfileGet.request(URL, headers,false, HTTPClient.METHOD_GET)
		
func makeUpdateRequest(data_to_send):
	$SaveButton.disabled = true
	$BackButton.disabled = true
	var query = JSON.print(data_to_send)# Convert data to json string:
	var headers = ["Content-Type: application/json","Authorization: Token "+Token.getToken()]   # Add 'Content-Type' header:
	$HTTPProfileUpdate.request(URL, headers,false, HTTPClient.METHOD_PUT, query)




func _on_HTTPProfileGet_request_completed(result, response_code, headers, body):
	print("Request Completed!")
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	print(response_code)
	if(response_code==200):
		$Name.text=json.result.first_name
		$LastName.text=json.result.last_name
		username = json.result.username
		print("Updated User data")
	elif(response_code==400):#Invalid credentials
		$ErrorUpdating.popup()
		get_tree().change_scene("res://Login.tscn")
	elif(response_code==401): #No credentials
		$ErrorUpdating.popup()
		get_tree().change_scene("res://Login.tscn")
	else:
		$InternetConection.popup()
		
	$SaveButton.disabled = false
	$BackButton.disabled = false

func _on_HTTPProfileUpdate_request_completed(result, response_code, headers, body):
	print("Request Completed!")
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	print(response_code)
	if(response_code==200):
		$Name.text=json.result.first_name
		$LastName.text=json.result.last_name
		username = json.result.username
		print("Updated User data")
		if(Game.getState() == Game.State.PROFILE_FIRST_RUN):
			get_tree().change_scene("res://World.tscn")		
	elif(response_code==400):#Invalid credentials
		$ErrorUpdating.popup()
		get_tree().change_scene("res://Login.tscn")
	elif(response_code==401): #No credentials
		$ErrorUpdating.popup()
		get_tree().change_scene("res://Login.tscn")
	else:
		$InternetConection.popup()
		
	$SaveButton.disabled = false
	$BackButton.disabled = false





