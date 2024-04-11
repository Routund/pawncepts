extends AudioStreamPlayer2D
var sounds = ["res://Sounds/Calculator sfx 1.mp3","res://Sounds/Calculator sfx 2.mp3","res://Sounds/Calculator sfx 3.mp3"]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func playCalc():
	var soundIndex = randi_range(0,2)
	playSound(sounds[soundIndex])

func playSound(sound_path: String):
	var sound = load(sound_path)
	if sound:
		stream = sound
		play()
	else:
		print("Failed to load sound:", sound_path)
