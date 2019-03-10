extends Node
var authenticated = false
var token = ""

func setToken(tokenValue):
	token = tokenValue
	authenticated = true

func getToken():
	return token

func isAuthenticated():
	return authenticated
	
func flushToken():
	token = ""
	authenticated = false
	