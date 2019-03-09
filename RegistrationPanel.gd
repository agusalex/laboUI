extends Panel

var authenticated = false
var registerURL = "http://laboapi.herokuapp.com/api/rest-auth/registration/"
var emailRegex = "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)"
var invalidNameRegex = "[^A-Za-zÀ-ÖØ-öø-ÿ'\\s]"
var passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,50}$"
var passwordMessage = "- La contraseña debe contener al menos: un numero, una letra y tener un minimo de 8 caracteres sin simbolos especiales"
var emailMessage = "- Introduzca una direccion de email valida"
var NameMessage = "- Introduzca un nombre valido"
var LastNameMessage = "- Introduzca un apellido valido"
var token = ""


func _ready():
	pass
	
func _on_AtrasButton_pressed():
	get_tree().change_scene("res://Login.tscn")
		
func _on_RegisterButton_pressed():
	var validPassword = true
	var validName = true
	var validLastName = true
	var validEmail = true
	validEmail = regexFullMatch(emailRegex,$Email.text)
	#validName = (!regexPartialMatch(invalidNameRegex,$Name.text))&&($Name.text.length()>1)
	#validLastName = (!regexPartialMatch(invalidNameRegex,$LastName.text))&&($LastName.text.length()>1)
	validPassword = regexFullMatch(passwordRegex,$Password.text)
	#register($Name.text.capitalize(),$Last.text.capitalize(),)
	if(validName&&validEmail&&validLastName&&validPassword):
		register($Name.text.capitalize(),$LastName.text.capitalize(),$Email.text,$Password.text)
	else:
		var verificationArray = [validName,validLastName,validEmail,validPassword]
		var messageArray = [NameMessage,LastNameMessage,emailMessage,passwordMessage]
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

func register(name,lastname,email,password):
		var credentialsDict = {"username": email,"email": email, 
		"password1": password,"password2": password,"first_name":name,"last_name":lastname} 		#dictionary with credentials
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
		token = JSON.parse(body.get_string_from_utf8()).result.key
		authenticated = true
		get_tree().change_scene("res://World.tscn")
	if(response_code==400):
		authenticated = false
		$EmailAlreadyInUse.popup()
		
	else:
		authenticated = false
		$InternetConection.popup()
		

func regexPartialMatch(regexStr,candidate):	
	var regex = RegEx.new()
	regex.compile(regexStr)
	var result = regex.search(candidate)
	if result==null:
		return false
	else:
		return true
	
func regexFullMatch(regexStr,candidate):	
	var regex = RegEx.new()
	regex.compile(regexStr)
	var result = regex.search(candidate)
	if result==null:
		return false
	if result.get_string()==candidate:
		return true
	else:
		return false

