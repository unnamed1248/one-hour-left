class_name Level extends Node3D

var player_in_elevator_area = false

func _ready() -> void:
	if Globals.elevator:
		$Player.global_position = $elevator.to_global(Globals.player_pos)
	if !Globals.first and Globals.elevator:
		$elevator/AnimationPlayer.play_section("door open", 3, -1)
		$elevator/elevatorcontrol/TextureRect.hide()
	Globals.elevator = false
	for i in $"elevator/elevatorcontrol/interior contol panel".get_children():
		i.get_active_material(0).set('shader_parameter/active', false)

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(_delta: float) -> void:
	if player_in_elevator_area:
		$ControlGuide/e.show()
	if player_in_elevator_area and Input.is_action_just_pressed("interact"):
		$elevator/AnimationPlayer.play("door open")
		
	if $elevator/AnimationPlayer.is_playing():
		$ControlGuide/e.hide()
	if player_in_elevator_area:
		$ControlGuide/e.show()

func _on_elevator_area_body_entered(body: Node3D) -> void:
	#print('enter')
	if body == $Player:
		player_in_elevator_area = true
		$ControlGuide/e.show()

func _on_elevator_area_body_exited(body: Node3D) -> void:
	if body == $Player:
		player_in_elevator_area = false
		$ControlGuide/e.hide()

func _on_elevator_change_floor(level: int) -> void:
	$elevator/elevatorcontrol/Control.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Globals.player_pos = $elevator.to_local($Player.global_position)
	
	
	if !(level == Globals.level) and $elevator/AnimationPlayer.is_playing():
		await get_tree().create_timer(4 + ($elevator/AnimationPlayer.current_animation_length - $elevator/AnimationPlayer.current_animation_position)).timeout
	elif !(level == Globals.level):
		await get_tree().create_timer(4).timeout
	
	if level==1:
		get_tree().change_scene_to_file("res://scenes/l1.tscn")
		Globals.level = 1
	elif level==2:
		get_tree().change_scene_to_file('res://scenes/l2.tscn')
		Globals.level = 2
	elif level == 3:
		get_tree().change_scene_to_file('res://scenes/l3.tscn')
		level = 3
	Globals.elevator = true
