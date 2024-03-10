extends Node2D

@onready var customer = get_node("CanvasLayer/Customer")
@onready var speech_bubble = get_node("CanvasLayer/Customer/Speech_bubble")
@onready var cust_timer = get_node("Customer_timer")
@onready var store_timer = get_node("Store_timer")
signal shop_end
var custTimerStart = false
var shopTimerStart = false

# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the shop timer when the game starts
	store_timer.start(120)  # Adjust the time as per your requirement

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if speech_bubble.exitNow:
		speech_bubble.exitNow = false
		customer.customer_leave = true
		custTimerStart = true
		# Start the customer timer when the speech bubble is closed
		cust_timer.start(4.5)

	if custTimerStart:
		if cust_timer.time_left == 0:
			if(store_timer.time_left==0):
				shop_end.emit()
			else:
				customer.enter()
			custTimerStart = false
			



# Called when the timer times out
func _on_timer_timeout():
	# Trigger the customer to enter again
	customer.customer_enter = true

