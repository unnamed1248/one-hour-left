extends Node3D

var time = 0
func _process(delta: float) -> void:
	if Globals.noti:
		time += delta
		if time >= .75:
			$Screen.get_active_material(0).set("shader_parameter/flashing", !($Screen.get_active_material(0).get("shader_parameter/flashing")))
			time = 0
