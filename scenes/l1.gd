extends Level

var player_in_computer_area = false
var player_in_npc_area = false
var e_disabled = false
var option: int

func _ready() -> void:
	super()
	if Globals.first:
		$ControlGuide/wasd.show()
	$NPC/Mesh.get_active_material(0).set("albedo_color", Color(1,0,0))
		
func _process(delta: float) -> void:
	super(delta)
	if Globals.first and (Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")):
		Globals.first = false
		$ControlGuide/wasd.hide()

	if player_in_computer_area and Input.is_action_just_pressed("interact"):
		get_tree().change_scene_to_file("res://scenes/computer.tscn")
		Globals.player_pos = $Player.position
		queue_free()
	
	if !e_disabled:
		$ControlGuide/e.hide()
	
	if player_in_npc_area and Input.is_action_just_pressed("interact") and !e_disabled:
		e_disabled = true
		if Globals.l1_spoken_to == false:
			$NPC/Control.show()
			$NPC/Control/Character.text = 'Research Employee'
			$NPC/Control/Dialogue.text = "Between the recent layoffs and the fact that it's 11PM, there's not many people left..."
			await get_tree().create_timer(1).timeout
			await $NPC.advance
			$NPC/Control/Dialogue.text = 'Boss? Do you need something?'
			$NPC/Control/Options/Option1.show()
			$NPC/Control/Options/Option2.show()
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$NPC/Control/Options/Option1.text = "You're oddly calm..."
			$NPC/Control/Options/Option2.text = "Not scared at all?"
			await $NPC.choice
			$NPC/Control/Options/Option1.hide()
			$NPC/Control/Options/Option2.hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			$NPC/Control/Dialogue.text = "What's that supposed to mean?"
			await $NPC.advance
			$NPC/Control.hide()
			await get_tree().create_timer(.5).timeout
			$NPC/Control.show()
			$NPC/Control/Dialogue.text = "I always thought something like this might happen..."
			await $NPC.advance
			$NPC/Control/Dialogue.text += "\nUnfortunately, I can't help you. If I move away from this cubicle, the security team will be notified immediately. If they find out what you're doing, it's all over."
			await $NPC.advance
			$NPC/Control.hide()
			Globals.l1_spoken_to = true
		else:
			$NPC/Control.show()
			$NPC/Control/Character.text = 'Research Employee'
			$NPC/Control/Dialogue.text = "I can't help you. If I move away from this cubicle, the security team will be notified immediately. If they find out what you're doing, it's all over."
			await get_tree().create_timer(1).timeout
			await $NPC.advance
			$NPC/Control.hide()
		e_disabled = false
	if (player_in_npc_area and !e_disabled) or player_in_computer_area or player_in_elevator_area:
		$ControlGuide/e.show()
	if player_in_elevator_area and $elevator/AnimationPlayer.is_playing():
		$ControlGuide/e.hide()

func _on_computer_area_body_entered(body: Node3D) -> void:
	if body == $Player:
		player_in_computer_area = true
		#$ControlGuide/e.show()

func _on_computer_area_body_exited(body: Node3D) -> void:
	if body == $Player:
		player_in_computer_area = false
		$ControlGuide/e.hide()

func _on_npc_area_body_entered(body: Node3D) -> void:
	if body == $Player:
		player_in_npc_area = true

func _on_npc_area_body_exited(body: Node3D) -> void:
	if body == $Player:
		player_in_npc_area = false

func _on_npc_choice(choice: int) -> void:
	option = choice
