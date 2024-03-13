extends TextureButton

var is_button_pressed = false
@onready var base = get_node("../../Calculator")
signal crossed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if is_button_pressed and not is_pressed():
		is_button_pressed = false
		# Button was pressed and is now released
		if(base.finalValue==''):
			crossed.emit()
		else:
			base.finalValue=""
			base.display.text=""
			base.confirm.disabled=true
		
		
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true

func _on_speech_bubble_sold(_price):
	visible=false
	pass # Replace with function body.
