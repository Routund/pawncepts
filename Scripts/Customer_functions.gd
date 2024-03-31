extends TextureRect

var customer_enter = false
var customer_leave = false
@onready var head = get_node("Head")
var custAppearance=0
var costumes = [
	["res://Assets/Customers/maleYellowBody.png","res://Assets/Customers/maleYellowHead.png"],
	["res://Assets/Customers/femaleGreenBody.png","res://Assets/Customers/femaleGreenHead.png"],
]
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
			head.keepBobbing=true
		
	if(customer_leave):
		position.x-=450*delta
		position.y=sin(position.x/20)*8+105
		if(position.x<-390):
			customer_leave=false
	pass

func enter():
	customer_enter=true
	custAppearance=randi()%2
	print(custAppearance)
	texture = load(costumes[custAppearance][0])
	head.texture = load(costumes[custAppearance][1])
	head.reset()
	position=Vector2(-390,165)
