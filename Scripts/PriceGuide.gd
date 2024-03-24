extends TextureButton

var open = false
@onready var pamphlet = get_node("TextureRect")
var justPressed=false;
@onready var audio = get_node("AudioStreamPlayer2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(Input.is_action_just_pressed("Pamphlet")):
		open=!open
		pamphlet.visible=!pamphlet.visible
		if(pamphlet.visible):
			audio.play()
	elif (justPressed and !pamphlet.visible) and not is_pressed():
		# Button was pressed and is now released
		justPressed = false
		open=!open
		pamphlet.visible=!pamphlet.visible
		audio.play()
	elif is_pressed() and not justPressed:
		# Button is pressed for the first time
		justPressed = true
	pass


func _on_day_end_panel_new_day(rent):
	pamphlet.visible=false
	pass # Replace with function body.
