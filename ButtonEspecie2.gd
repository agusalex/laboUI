extends TextureButton

var substancia = load("res://Substancia2.tscn")
var color  # Botón Verde

func _ready():
	color = Color(0.0, 1.0, 0.0)
	colorear()

func colorear():
	self_modulate = color
	
func spawn():
	var s = substancia.instance()
	s.nombre = "Substancia verde"
	s.color = color
	s.expression = "V3RD3"
	s.colorear()
	return s