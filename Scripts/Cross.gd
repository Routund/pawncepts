extends TextureButton

var is_button_pressed = false
@onready var base = get_node("../../Calculator")
signal crossed
@onready var sound = get_node("../CalcCound")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if (is_button_pressed and not is_pressed() or (Input.is_action_just_pressed("Exit")))and visible:
		is_button_pressed = false
		# Button was pressed and is now released
		if(base.finalValue==''):
			crossed.emit()
			toggle_mode=true
			toggle_mode=false
			sound.playCalc()
		else:
			base.finalValue=""
			base.display.text=""
			base.confirm.disabled=true
			sound.playCalc()
		
		
	elif is_pressed() and not is_button_pressed:
		# Button is pressed for the first time
		is_button_pressed = true

func _on_speech_bubble_sold(_price):
	visible=false
	pass # Replace with function body.
