extends TextureRect

var goLeft=false
var goRight = false

@onready var Revenue = get_node("MarginContainer/HBoxContainer/Values/Revenue")
@onready var Rent = get_node("MarginContainer/HBoxContainer/Values/Rent")
@onready var Profits = get_node("MarginContainer/HBoxContainer/Values/Profits")
@onready var Expenses = get_node("MarginContainer/HBoxContainer/Values/Expenses")
var revValue=0
var rentValue=0
var profValue=0
var expValue=0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(goLeft):
		position.x-=delta*1800
		if(position.x<0):
			position.x=0
			goLeft=false
			
	pass


func _on_node_2d_shop_end(rev,exp):
	goLeft=true
	Revenue.text="+ " + str(rev)
	Expenses.text="- " + str(exp)
	rentValue+=100
	Rent.text="- " + str(rentValue)
	if(rev-exp-rentValue<0):
		Profits.text="" + str(rev-exp-rentValue)
	else:
		Profits.text="+ " + str(rev-exp-rentValue)
	pass # Replace with function body.
