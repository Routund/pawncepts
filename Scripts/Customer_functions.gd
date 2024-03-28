extends TextureRect

var customer_enter = false
var customer_leave = false
signal entered
signal exited
# Called when the node enters the scene tree for the first time.
func _ready():
	position=Vector2(-390,165)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(customer_enter):
		position.x+=450*delta
		position.y=sin(position.x/20)*8+105
		if(position.x>395):
			entered.emit()
			customer_enter=false
		
	if(customer_leave):
		position.x-=450*delta
		position.y=sin(position.x/20)*8+105
		if(position.x<-390):
			customer_leave=false
	pass

func enter():
	customer_enter=true
	position=Vector2(-390,165)
