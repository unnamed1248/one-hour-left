extends StaticBody3D

func _ready() -> void:
	for i in 3:
		if randi()%2 == 1:
			$laptops.get_child(i).hide()
			$calcs.get_child(i).hide()
	for i in 3:
		if randi()%3 == 1:
			$calcs.get_child(randi()%3).hide()
