extends Label


# Called when the node enters the scene tree for the first time.
var balance=0
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "$" + str(balance)
	balance+=1
	pass
