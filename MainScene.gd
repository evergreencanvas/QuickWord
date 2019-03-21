extends ColorRect

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var secondsToStart = 5
var words = [
	'the',
	'of',
	'and',
	'to',
	'a',
	'in',
	'is',
	'that',
	'it',
	'was',
	'for',
	'you',
	'he',
	'on',
	'as',
	'are',
	'they',
	'with',
	'be',
	'his',
	'at',
	'or',
	'from',
	'had',
	'I',
	'not',
	'have',
	'this',
	'but',
	'by',
	'were',
	'one',
	'all',
	'she',
	'when',
	'an',
	'their',
	'there',
	'her',
	'can',
	'we',
	'what',
	'about',
	'up',
	'said',
	'out',
	'if',
	'some',
	'would',
	'so',
	'people',
	'them',
	'other',
	'more',
	'will',
	'into',
	'your',
	'which',
	'do',
	'then',
	'many',
	'these',
	'no',
	'time',
	'been',
	'who',
	'like',
	'could',
	'has',
	'him',
	'how',
	'than',
	'two',
	'may',
	'only',
	'most',
	'its',
	'made',
	'over',
	'see',
	'first',
	'new',
	'very',
	'my',
	'also',
	'down',
	'make',
	'now',
	'way',
	'each',
	'called',
	'did',
	'just',
	'after',
	'water',
	'through',
	'get',
	'because',
	'back',
	'where',
	'know',
	'little',
	'such',
	'even',
	'much',
	'our',
	'must'
	]
var index = -1
var start_seconds = -1
var words_seen = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	randomize()


func _on_CheckButton_toggled(button_pressed):
	if button_pressed:
		$vbox/ConsolasLabel.visible = false
		$vbox/SFLabel.visible = true	
	else:
		$vbox/ConsolasLabel.visible = true
		$vbox/SFLabel.visible = false


func _on_Timer_timeout():
	# go to next word
	var not_done = get_next_zeno_word()
	if !not_done:
		reset()


func _on_StartTimer_timeout():
	# this is just to count down to start
	start_seconds += 1
	if start_seconds < secondsToStart:
		var seconds_left = secondsToStart - start_seconds
		set_text(str(seconds_left))
		return
	else:
		$StartTimer.stop()
		get_next_zeno_word() # start the slideshow/flashcards
		$WordTimer.start()


func set_text(text):
	$vbox/SFLabel.text = text
	$vbox/ConsolasLabel.text = text


func get_next_zeno_word():
	var length = len(words)-1
	
	if $GridContainer/RandomCheck.pressed == false:
		if index < length:
			index = index + 1
		else:
			return false
	else:
		if(len(words_seen) < len(words)):
			index = get_unused_word_index()
			if(index == -1):
				return false # we couldn't find an unused one
		else:
			return false
	
	words_seen.append(index)
	set_text(words[index])
	
	return true

func get_unused_word_index():
	var foundOne = true
	var r
	var i = 0
	while foundOne:
		r = randi() % len(words)
		foundOne = words_seen_contains(r)
		i += 1
		if i > 500:
			r = -1
			break;
	return r
	
func words_seen_contains(number):
	for w in range(len(words_seen)-1):
			if number == words_seen[w]:
				return true
	return false

func _on_StartButton_button_up():
	if $StartButton.text == "Start":
		$StartButton.text = "Restart"
		$StartTimer.start()
	else:
		reset()
		
func reset():
	$StartButton.text = "Start"
	$StartTimer.stop()
	$WordTimer.stop()
	start_seconds = -1
	index = -1
	set_text("Zeno Words")
	words_seen = []
