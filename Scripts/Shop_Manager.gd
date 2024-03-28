extends Node2D

@onready var customer = get_node("CanvasLayer/Customer")
@onready var speech_bubble = get_node("CanvasLayer/Customer/Speech_bubble")
@onready var cust_timer = get_node("Customer_timer")
@onready var store_timer = get_node("Store_timer")
signal shop_end(rev: int,exp: int)
var custTimerStart = false
var shopTimerStart = false
var rev=0
var exp=0

# Called when the node enters the scene tree for the first time.
func _ready():
	# Start the shop timer when the game starts
	pass # Adjust the time as per your requirement

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if speech_bubble.exitNow:
		speech_bubble.exitNow = false
		customer.customer_leave = true
		custTimerStart = true
		# Start the customer timer when the speech bubble is closed
		cust_timer.start(3.5)

	if custTimerStart:
		if cust_timer.time_left == 0:
			if(store_timer.time_left==0):
				shop_end.emit(rev,exp)
				rev=0
				exp=0
			else:
				customer.enter()
			custTimerStart = false
			



# Called when the timer times out
func _on_timer_timeout():
	# Trigger the customer to enter again
	customer.customer_enter = true



func _on_speech_bubble_sold(price):
	if(price>0):
		exp+=price
	else:
		rev-=price
	pass # Replace with function body.

func _on_texture_button_letter():
	store_timer.start(90)
	custTimerStart = true
	cust_timer.start(1)
	pass # Replace with function body.


func _on_day_end_panel_new_day(_rent):
	store_timer.start(90)
	custTimerStart = true
	cust_timer.start(1)
	pass # Replace with function body.
