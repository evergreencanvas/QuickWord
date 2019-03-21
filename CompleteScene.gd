extends Panel

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var mlScene = load("res://MissedWordLabel.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	var indices = get_node("/root/global").missedWords
	var words = get_node("/root/global").words
	#for i in indices:
	#	add_word(words[i])
	for w in words:
		add_word(w)

func add_word(text):
	var label = mlScene.instance()
	var con = Control.new()
	#con.size_flags_horizontal = Control.SIZE_EXPAND
	label.text = text
	con.add_child(label)
	$MarginContainer/VBoxContainer/ScrollContainer/WordGrid.add_child(con)
	

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
