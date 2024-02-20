extends Node2D

@onready var customer = get_node("Customer")
@onready var speech_bubble = get_node("Customer/Speech_bubble")
@onready var timer = get_node("Customer_timer")
var timerStart=false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if speech_bubble.exitNow:
		speech_bubble.exitNow = false
		customer.customer_leave=true
		timerStart=true
		# Start the timer when the speech bubble is closed
		timer.start(6.0)
	if(timerStart):
		if(timer.time_left==0):
			timerStart=false
			customer.enter()

# Called when the timer times out
func _on_timer_timeout():
	# Trigger the customer to enter again
	customer.customer_enter = true
