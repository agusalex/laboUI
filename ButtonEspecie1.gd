extends TextureButton

var substancia = load("res://Substancia2.tscn")
var color  # Botón Rojo

func _ready():
	color = Color(1.0, 0.0, 0.0)
	colorear()

func colorear():
	self_modulate = color
	
func spawn():
	var s = substancia.instance()
	s.nombre = "Substancia roja"
	s.color = color
	s.expression = "R0J4"
	s.colorear()
	return s