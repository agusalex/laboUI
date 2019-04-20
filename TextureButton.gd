extends TextureButton

var color  # Botón Azul

func _ready():
	color = Color(0.0, 0.0, 1.0)
	colorear()

func colorear():
	$Sprite.self_modulate = color