extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_CheckBox_toggled(button_pressed):
	if button_pressed:
		$MarginContainer/VBoxContainer/MarginContainer/normalTitle.visible = false
		$MarginContainer/VBoxContainer/MarginContainer/forTitle.visible = true
	else:
		$MarginContainer/VBoxContainer/MarginContainer/normalTitle.visible = true
		$MarginContainer/VBoxContainer/MarginContainer/forTitle.visible = false


func _on_Button_button_up():
	get_node("/root/global").goto_scene("res://TestScene.tscn")


func _on_PracticeButton_pressed():
	get_node("/root/global").goto_scene("res://PracticeScene.tscn")
