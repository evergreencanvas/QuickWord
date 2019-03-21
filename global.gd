extends Node

var current_scene = null
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
	'as']

#	'are',
#	'they',
#	'with',
#	'be',
#	'his',
#	'at',
#	'or',
#	'from',
#	'had',
#	'I',
#	'not',
#	'have',
#	'this',
#	'but',
#	'by',
#	'were',
#	'one',
#	'all',
#	'she',
#	'when',
#	'an',
#	'their',
#	'there',
#	'her',
#	'can',
#	'we',
#	'what',
#	'about',
#	'up',
#	'said',
#	'out',
#	'if',
#	'some',
#	'would',
#	'so',
#	'people',
#	'them',
#	'other',
#	'more',
#	'will',
#	'into',
#	'your',
#	'which',
#	'do',
#	'then',
#	'many',
#	'these',
#	'time',
#	'been',
#	'who',
#	'like',
#	'could',
#	'has',
#	'him',
#	'how',
#	'two',
#	'may',
#	'only',
#	'most',
#	'its',
#	'made',
#	'over',
#	'see',
#	'first',
#	'new',
#	'very',
#	'my',
#	'also',
#	'down',
#	'make',
#	'now',
#	'way',
#	'each',
#	'called',
#	'did',
#	'just',
#	'after',
#	'water',
#	'through',
#	'get',
#	'because',
#	'back',
#	'where',
#	'know',
#	'little',
#	'such',
#	'even',
#	'much',
#	'our',
#	'must'
#]


var usingSansForgettica = false
var missedWords = []

func _ready():
        var root = get_tree().get_root()
        current_scene = root.get_child(root.get_child_count() -1)
	
func goto_scene(path):
    # This function will usually be called from a signal callback,
    # or some other function from the running scene.
    # Deleting the current scene at this point might be
    # a bad idea, because it may be inside of a callback or function of it.
    # The worst case will be a crash or unexpected behavior.

    # The way around this is deferring the load to a later time, when
    # it is ensured that no code from the current scene is running:

    call_deferred("_deferred_goto_scene", path)


func _deferred_goto_scene(path):
    # Immediately free the current scene,
    # there is no risk here.
    current_scene.free()

    # Load new scene.
    var s = ResourceLoader.load(path)

    # Instance the new scene.
    current_scene = s.instance()

    # Add it to the active scene, as child of root.
    get_tree().get_root().add_child(current_scene)

    # Optional, to make it compatible with the SceneTree.change_scene() API.
    get_tree().set_current_scene(current_scene)
	
	
