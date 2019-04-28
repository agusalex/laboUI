extends Node
enum EXPRESSION{
	validEmail,invalidName,validPassword
}

func _ready():
	pass
	
func getExpression(Exp):
	match Exp:
    EXPRESSION.validEmail:
        return "(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\\.[a-zA-Z0-9-.]+$)"
    EXPRESSION.invalidName:
        return "[^A-Za-zÀ-ÖØ-öø-ÿ'\\s]"
    EXPRESSION.validPassword:
        return "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,50}$"
	
func regexPartialMatch(Enum,candidate):	
	var regex = RegEx.new()
	regex.compile(getExpression(Enum))
	var result = regex.search(candidate)
	if result==null:
		return false
	else:
		return true
	
func regexFullMatch(Enum,candidate):	
	var regex = RegEx.new()
	regex.compile(getExpression(Enum))
	var result = regex.search(candidate)
	if result==null:
		return false
	if result.get_string()==candidate:
		return true
	else:
		return false