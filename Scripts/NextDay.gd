extends TextureButton

var is_button_pressed = false
signal nDayPressed
# Called when the node enters the scene tree for the first time.
func _ready():
	if is_button_pressed and not button_pressed:
		# Button was pressed and is now released
		is_button_pressed = false
		nDayPressed.emit()
	elif button_pressed and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _toggled(_toggled_on):
	nDayPressed.emit()
	set_toggle_mode(false)
	set_toggle_mode(true)




