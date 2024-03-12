extends TextureButton

var is_button_pressed = false
signal nDayPressed
# Called when the node enters the scene tree for the first time.
func _ready():
	if is_button_pressed and not button_pressed:
		# Button was pressed and is now released
		is_button_pressed = false
		print("hehehe")
		nDayPressed.emit()
	elif button_pressed and not is_button_pressed:
		print("hahaha")
		# Button is pressed for the first time
		is_button_pressed = true
	if button_pressed:
		print("hihihi")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _toggled(toggled_on):
	print("hehehe")
	nDayPressed.emit()
	set_toggle_mode(false)
	set_toggle_mode(true)




