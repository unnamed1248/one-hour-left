extends Control

@export var file_explorer: Window
@export var browser: Window
@export var text_editor: Window
@export var image_viewer: Window


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if Globals.first_computer:
		$ItemList/FileExplorer/FEWindow/BoxContainer/Important_txt/TextEditor.show()
		$esc.show()
		Globals.first_computer = false
	Globals.noti = false
func _on_browser_pressed() -> void:
	$ItemList/Browser/BrowserWindow.show() # Replace with function body.

func _on_file_explorer_pressed() -> void:
	$ItemList/FileExplorer/FEWindow.show() # Replace with function body.

func _on_browser_window_close_requested() -> void:
	$ItemList/Browser/BrowserWindow.hide()

func _on_fe_window_close_requested() -> void:
	$ItemList/FileExplorer/FEWindow.hide()

func _on_important_txt_pressed() -> void:
	$ItemList/FileExplorer/FEWindow/BoxContainer/Important_txt/TextEditor.show()

func _on_text_editor_close_requested() -> void:
	$ItemList/FileExplorer/FEWindow/BoxContainer/Important_txt/TextEditor.hide()


func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("ui_cancel")):
		
		get_tree().change_scene_to_file("res://scenes/l1.tscn")
		queue_free()
	
	var clock_min = str(59-int(GlobalTimer.minutes_left))
	while len(clock_min) != len('00'):
		clock_min = '0' + clock_min
	$Label.text = "11:" + clock_min + ' PM'
	if Globals.story_change:
		$ItemList/Browser/BrowserWindow/VBoxContainer/RichTextLabel.text = "World Set To End"
		$ItemList/Browser/BrowserWindow/VBoxContainer/RichTextLabel2.text = "Dying superpower to launch missiles in act of spite"

func _on_map_pressed() -> void:
	$ItemList/FileExplorer/FEWindow/BoxContainer/Map/ImageViewer.show()

func _on_image_viewer_close_requested() -> void:
	image_viewer.hide()

func _on_contact_us_pressed() -> void:
	if Globals.leaked:
		$ItemList/Browser/BrowserWindow/AcceptDialog.show()
	else:
		$ItemList/Browser/BrowserWindow/ConfirmationDialog.show()

func _on_confirmation_dialog_confirmed() -> void:
	Globals.leaked = true
	$ItemList/Browser/BrowserWindow/ConfirmationDialog.hide()

func _on_accept_dialog_confirmed() -> void:
	$ItemList/Browser/BrowserWindow/AcceptDialog.hide()

func _on_confirmation_dialog_canceled() -> void:
	$ItemList/Browser/BrowserWindow/ConfirmationDialog.hide()
