extends Panel

export var Word = "word here"

func _ready():
	$Panel/MarginContainer/Label.text = Word
	
