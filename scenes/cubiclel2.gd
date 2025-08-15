extends Node3D

func _ready() -> void:
	for i in 3:
		$stands.get_child(i).rotation_degrees.y = (randi()%60)-30
		$laptops.get_child(i).rotation_degrees.y += (randi()%60)-30
		if randi()%2 == 1:
			$laptops.get_child(i).hide()
			$stands.get_child(i).hide()
			$monitors.get_child(i).hide()
	for i in $monitors.get_children():
		if randi()%2==1:
			i.scale = Vector3(2.5,2.5,2.5)
