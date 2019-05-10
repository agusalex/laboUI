extends Panel

var registerURL = "http://laboquimica.herokuapp.com/api/rest-auth/registration/"
var emailRegex = RegexUtils.EXPRESSION.validEmail
var passwordRegex = RegexUtils.EXPRESSION.validPassword
var passwordMessage = "- La contraseña debe contener al menos: un numero, una letra y tener un minimo de 8 caracteres sin simbolos especiales"
var emailMessage = "- Introduzca una direccion de email valida"
var NameMessage = "- Introduzca un nombre valido"
var LastNameMessage = "- Introduzca un apellido valido"


func _ready():
	Game.setState(Game.State.REGISTER)
	Token.flushToken()

func _on_BackButton_pressed():
	get_tree().change_scene("res://Login.tscn")

		
func _on_RegisterButton_pressed():
	var validPassword = true
	var validName = true
	var validLastName = true
	var validEmail = true
	validEmail = RegexUtils.regexFullMatch(emailRegex,$Email.text)
	validPassword = RegexUtils.regexFullMatch(passwordRegex,$Password.text)

	if(validEmail&&validPassword):
		register($Email.text,$Password.text)
		$BackButton.disabled = true
		$RegisterButton.disabled = true
	else:
		var verificationArray = [validEmail,validPassword]
		var messageArray = [emailMessage,passwordMessage]
		var popupMessage = "Error de validacion:"
		for i in range(verificationArray.size()):
			popupMessage = popupMessage + "\n"
			if verificationArray[i]==false:
				popupMessage = popupMessage+messageArray[i]
				
		$InvalidFields.dialog_text = popupMessage
		$InvalidFields.popup()


func register(email,password):
		var credentialsDict = {"username": email,"email": email, 
		"password1": password,"password2": password} 		#dictionary with credentials
		makeRegistrationRequest(credentialsDict)	
		
func makeRegistrationRequest(data_to_send):
	var query = JSON.print(data_to_send)# Convert data to json string:
	var headers = ["Content-Type: application/json"]   # Add 'Content-Type' header:
	$HTTPRegistrationRequest.request(registerURL, headers,false, HTTPClient.METHOD_POST, query)

func onHTTPRegistrationRequestCompleted(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(json.result)
	print(response_code)
	if(response_code==201):
		print("user Registered!")
		Token.setToken(JSON.parse(body.get_string_from_utf8()).result.key)
		Game.setState(Game.State.PROFILE_FIRST_RUN)
		get_tree().change_scene("res://scenes/Profile.tscn")
	elif(response_code==400):
		$RegisterButton.disabled = false
		$BackButton.disabled = false
		$EmailAlreadyInUse.popup()
	else:
		$RegisterButton.disabled = false
		$BackButton.disabled = false
		$InternetConnection.popup()
