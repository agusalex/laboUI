extends TextureButton

var substancia = load("res://Substancia2.tscn")
var color  # Botón Azul

func _ready():
	color = Color(0.0, 0.0, 1.0)
	colorear()

func colorear():
	self_modulate = color
	
func spawn():
	var s = substancia.instance()
	s.nombre = "Substancia azul"
	s.color = color
	s.expression = "4ZUL"
	s.colorear()
	return s