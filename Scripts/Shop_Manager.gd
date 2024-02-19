extends Node2D

@onready var customer = get_node("Customer")
@onready var speech_bubble = get_node("Customer/Speech_bubble")
var timer = Timer.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if speech_bubble.exitNow:
		speech_bubble.exitNow = false
		# Start the timer when the speech bubble is closed
		timer.start(10)

# Called when the timer times out
func _on_timer_timeout():
	# Trigger the customer to enter again
	customer.customer_enter = true
