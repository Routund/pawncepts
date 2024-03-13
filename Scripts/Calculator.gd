extends TextureRect

@onready var numButtons = [
	get_node("0"), get_node("1"), get_node("2"), get_node("3"), get_node("4"),
	get_node("5"), get_node("6"), get_node("7"), get_node("8"), get_node("9")
]
@onready var display = get_node("Label")
@onready var confirm = get_node("Confirm")

var goDown = false
var goUp = false
var finalValue = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(10):
		numButtons[i].calc_value = i
	update_confirm_button_state()  # Update the state of the confirm button initially

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if goUp:
		position.y -= 1000 * delta
		if position.y <= 312:
			position.y = 312
			goUp = false
	if goDown:
		position.y += 1000 * delta
		if position.y >= 648:
			position.y = 648
			goDown = false

# Function to add a number to the final value
func addNum(num):
	finalValue += str(num)
	if len(finalValue) > 4:
		finalValue = finalValue.erase(0, 1)
	display.text = finalValue
	update_confirm_button_state()  # Update the state of the confirm button whenever the final value changes

# Function to update the state of the confirm button based on the final value
func update_confirm_button_state():
	if finalValue == "":
		confirm.disabled = true  # Disable the confirm button if finalValue is empty
	else:
		confirm.disabled = false  # Enable the confirm button if finalValue is not empty
