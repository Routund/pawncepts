extends TextureButton

var is_button_pressed = false
var usable = false
signal checked
@onready var sound = get_node("../CalcCound")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (is_button_pressed and not is_pressed()) or (Input.is_action_just_pressed("Confirm")) and !disabled:
		# Button was pressed and is now released
		is_button_pressed = false
		checked.emit()
		sound.playCalc()
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true
