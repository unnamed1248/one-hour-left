extends CharacterBody3D
signal choice(choice: int)
signal advance

var spoken_to = false



func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		advance.emit()


func _on_option_1_pressed() -> void:
	choice.emit(1)

func _on_option_2_pressed() -> void:
	choice.emit(2)

func _on_option_3_pressed() -> void:
	choice.emit(3)

func _on_option_4_pressed() -> void:
	choice.emit(4)
