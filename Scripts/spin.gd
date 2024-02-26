extends TextureButton

var price = 100
var sensitivity = 1.0
var mouse_pos
var start_angle = 0
var clockwise = false
@onready var priceText = get_node("../Price")

func _ready():
	set_process_input(true)

func _process(_delta):
	if is_pressed():
		var new_mouse_pos = get_global_mouse_position()
		var current_angle = (new_mouse_pos - global_position).angle()
		if mouse_pos != null:
			var angle_diff = current_angle - start_angle
			if abs(angle_diff) > 0.01: # Adjust the threshold as needed
				clockwise = angle_diff > 0
				if clockwise:
					price += sensitivity
				else:
					if (price-sensitivity>0):
						price -= sensitivity
				priceText.text="$%s"%[price]
			rotation+=angle_diff
		mouse_pos = new_mouse_pos
		start_angle = current_angle

func _on_TextureButton_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			mouse_pos = get_global_mouse_position()
			start_angle = (mouse_pos - global_position).angle()
			
func _on_speech_bubble_no_deal():
	visible=false
	priceText.visible=false
	pass # Replace with function body.


func _on_speech_bubble_sold(_price):
	visible=false
	priceText.visible=false
	pass # Replace with function body.

