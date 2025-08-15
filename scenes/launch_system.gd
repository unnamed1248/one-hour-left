extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta: float) -> void:
	$VBoxContainer/RichTextLabel2.text = GlobalTimer.minutes_left + ":" + GlobalTimer.seconds_left 
	if GlobalTimer.time_left<=300:
		$VBoxContainer/RichTextLabel2.add_theme_color_override("default_color", Color(255,0,0))
		var ms_left = str(int(GlobalTimer.time_left*1000)%1000)
		while len(ms_left) != len("000"):
			ms_left = '0' + ms_left
		$VBoxContainer/RichTextLabel2.text += "." + ms_left
		

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/win.tscn")

func _on_button_pressed() -> void:
	if $VBoxContainer2/LineEdit.text == 'ONLY1':
		$VBoxContainer2.hide()
		$VBoxContainer.show()
	else:
		$VBoxContainer2/RichTextLabel2.show()
