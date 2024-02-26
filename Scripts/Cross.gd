extends TextureButton

var is_button_pressed = false

signal crossed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_button_pressed and not is_pressed():
		# Button was pressed and is now released
		is_button_pressed = false
		crossed.emit()
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true

func _on_speech_bubble_sold(_price):
	visible=false
	pass # Replace with function body.
