extends Panel
var token = ""
var authenticated = false
var loginURL = "http://laboapi.herokuapp.com/api/rest-auth/login/"

func _ready():
	pass

func _on_RegistroButton_pressed():
		get_tree().change_scene("res://Registration.tscn")
			
func _on_LoginButton_pressed():
	$LoginButton.disabled = true
	$RegistroButton.disabled = true
	if($User.text != ""):
		login($User.text,$Password.text)
	else: #Disable this for production
		get_tree().change_scene("res://World.tscn")	
		
func login(username,password):
	if(!authenticated):		
		var credentialsDict = {"username": username, "password": password} #dictionary with credentials
		makeLoginRequest(credentialsDict)	
		
func makeLoginRequest(data_to_send):
    var query = JSON.print(data_to_send)   # Convert data to json string:
    var headers = ["Content-Type: application/json"]  # Add 'Content-Type' header:
    $HTTPLoginRequest.request(loginURL, headers,false, HTTPClient.METHOD_POST, query)

func onHTTPLoginRequestCompleted(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	print(response_code)
	if(response_code==200):
		print("success!")
		token = JSON.parse(body.get_string_from_utf8()).result.key
		authenticated = true
		get_tree().change_scene("res://Login.tscn")
	if(response_code==400):
		authenticated = false
		$LoginButton.disabled = false
		$RegistroButton.disabled = false
		$LoginError.dialog_text = "Error: Email o contraseña invalidos"
		$LoginError.popup()

	else:		
		$LoginButton.disabled = false
		$RegistroButton.disabled = false
		$LoginError.dialog_text = "Ha ocurrido un error inesperado, revise su conexion a internet"
		authenticated = false
		$LoginError.popup()


