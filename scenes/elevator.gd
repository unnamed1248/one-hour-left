extends Node3D
var in_area = false
var enabled = true
signal change_floor(floor: int)

func _process(_delta: float) -> void:
	if $AnimationPlayer.is_playing():
		$button.get_active_material(0).set('shader_parameter/active', true)
		$elevatorcontrol/TextureRect.hide()
	else:
		$button.get_active_material(0).set('shader_parameter/active', false)
	if in_area and Input.is_action_just_pressed("interact") and enabled:
		$elevatorcontrol/Control.show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if in_area:
		$elevatorcontrol/TextureRect.show()
	if !enabled or !in_area:
		$elevatorcontrol/TextureRect.hide()
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == 'Player':
		$elevatorcontrol/TextureRect.show()
		in_area = true
	if !in_area:
		$elevatorcontrol/TextureRect.hide()

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name == 'Player':
		in_area = false

func _on_button_1_pressed() -> void:
	$"elevatorcontrol/interior contol panel/1Button".get_active_material(0).set('shader_parameter/active', true)
	change_floor.emit(1)
	enabled = false

func _on_button_2_pressed() -> void:
	$"elevatorcontrol/interior contol panel/2Button".get_active_material(0).set('shader_parameter/active', true)
	change_floor.emit(2)
	enabled = false
	
func _on_button_3_pressed() -> void:
	$"elevatorcontrol/interior contol panel/3Button".get_active_material(0).set('shader_parameter/active', true)
	change_floor.emit(3)
	enabled = false

func _hide_e():
	$elevatorcontrol/TextureRect.hide()
	
func _show_e():
	$elevatorcontrol/TextureRect.show()
