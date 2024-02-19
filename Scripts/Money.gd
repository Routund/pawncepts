extends Label


# Called when the node enters the scene tree for the first time.
var balance=1000
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	text = "$" + str(balance)
	pass


func _on_speech_bubble_sold(price):
	balance-=price
	pass # Replace with function body.
