extends TextureButton

var is_button_pressed = false

signal checked

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_button_pressed and not is_pressed():
		# Button was pressed and is now released
		is_button_pressed = false
		checked.emit()
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true
