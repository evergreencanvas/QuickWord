tool
extends Panel

var wordIndex = -1
var started = false
var correctSideTouched = false
var wrongSideTouched = false
var answerConfirmed = false
var timeTouched
var screenWidthHalf
var touchRing
var touchTime = 0.5
var gettingNextWord = false

func _ready():
	# Resize the buttons to be half the screen on the right sides
	var size = get_node("/root").get_children()[1].get_viewport_rect().size
	screenWidthHalf = get_viewport_rect().size.x / 2
	
	
	$Word.visible = false
	
func _process(delta):
	
	if not started:
		return
	
	if not answerConfirmed:
		# Check if nothing has been in the touched state
		if not correctSideTouched and not wrongSideTouched:
			# if the button is pressed, set the left or right side touched to true
			if Input.is_mouse_button_pressed(BUTTON_LEFT):
				timeTouched = get_time()
				# get the location of mouse
				var location = get_viewport().get_mouse_position()
				var ringScene = load("res://TouchCircle.tscn")
				touchRing = ringScene.instance()
				touchRing.maxTime = touchTime
				add_child(touchRing)
				
				$MouseX.text = str(location.x)
				if location.x > screenWidthHalf:
					wrongSideTouched = true
				else:
					correctSideTouched = true
			
				
		if correctSideTouched or wrongSideTouched:
			var timeDiff = get_time() - timeTouched
			
			$TouchTime.text = str(timeDiff)
			var mouse = get_viewport().get_mouse_position()
			touchRing.updateCircle(timeDiff, mouse)
			
			if timeDiff > touchTime :
				answerConfirmed = true
				if correctSideTouched:
					getNextWord()
				if wrongSideTouched:
					get_node("/root/global").missedWords.append(wordIndex)
					getNextWord()
				correctSideTouched = false
				wrongSideTouched = false
				$TouchTime.text = "0"
				touchRing.remove()
				return
			
			
			if not Input.is_mouse_button_pressed(BUTTON_LEFT):
				correctSideTouched = false
				wrongSideTouched = false
				$TouchTime.text = "0"
				touchRing.remove()
	else:
		if not Input.is_mouse_button_pressed(BUTTON_LEFT):
			answerConfirmed = false;
	
	
func get_time():
	# get_ticks_msec gets milliseconds since start of game. Use this to get the time
	# elapsed since touched
	var secs = OS.get_ticks_msec() / 1000.0
	return secs  # this is to make it easy to get seconds elapsed since program started
	
	
func getNextWord():
	if not gettingNextWord:
		gettingNextWord = true
		var words = get_node("/root/global").words
		wordIndex += 1
		
		if wordIndex > len(words) - 1:
			completeTest()
			return
		
		var nextWord = words[wordIndex]
		setText(nextWord)
		gettingNextWord = false


func completeTest():
	get_node("/root/global").goto_scene("res://CompleteScene.tscn")


func setText(text):
	$Word.text = text
	
	
func gotItRight():
	pass
	

func gotItWrong():
	get_node("/root/global").missedWords.Append(wordIndex)


func _on_CorrectButton_pressed():
	if started:
		gotItRight()
		getNextWord()


func _on_WrongButton_pressed():
	if started:
		gotItWrong()
		getNextWord()


func _on_Start_pressed():
	$Word.visible = true
	$CanvasLayer/Start.visible = false
	started = true
	$Instr1.visible = false
	$Instr2.visible = false
	getNextWord()
	
	
func _notification(what):
	match what:
		MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
			get_node("/root/global").goto_scene("res://SelectionScreen.tscn")

	

	
