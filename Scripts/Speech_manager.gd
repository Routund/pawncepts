extends Node2D

var cust = 0
var item = 0
var min_price = 0
var initial_price = 0
var sell_price = 100
@onready var spinner = get_node("Control/Spinner")
@onready var dialogue = get_node("Control/Dialogue")
var dialogues = [];
var check_price;
signal sold(price: int)
signal no_deal()
var patience = 5

var customerTypes = [
	0, # Stingy, give high price and have relatively high min price
	1, # Desperate, give low price, and have relatively low min price
	2, # Clueless, give high price, and have relatively low min price
	3, # Veteran, give low price, and have relatively high min price
]
var cust_variance = [
	1,1, # Stingy, give high price and have relatively high min price
	0.4, # Desperate, give low price, and have relatively low min price
	0.6, # Clueless, give high price, and have relatively low min price
	1, # Veteran, give low price, and have relatively high min price   
]
var init_variance = [
	1.4, # Stingy, give high price and have relatively high min price
	1.3, # Desperate, give low price, and have relatively low min price
	3, # Clueless, give high price, and have relatively low min price
	1.1, # Veteran, give low price, and have relatively high min price   
]	
var items_dict = {
	0:"Necklace",
	1:"Ring",
	2:"Console",
	3:"Vase"
}
var prices = [
	600, # Necklace
	435, # Ring
	350, # Console
	90, # Vase
]
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.seed = hash("I missed my lunch")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_customer_entered():
	# Pick random values for customer
	item = randi() % items_dict.size()
	cust = customerTypes[randi() % customerTypes.size()]
	min_price = int(prices[item] * (cust_variance[cust] + rng.randf_range(-0.1, 0.1)))
	initial_price = int(min_price*(init_variance[cust]+rng.randf_range(-0.05, 0.1))) 
	patience = 5
	
	# Load Dialogue
	dialogues = load_dialogues()
	dialogue.text=dialogues[1]%[items_dict[item],initial_price]
	
	
	# Initialize all visible displays
	visible = true
	spinner.price=initial_price
	spinner.priceText.text="$%s"%[initial_price]
	pass
	
func load_dialogues() -> Array:
	var dialogues2 = []
	
	# Set up Parser
	var parser = XMLParser.new()
	parser.open("res://Scripts/dialogues.xml")
	
	while parser.read() != ERR_FILE_EOF:
		# If node is element, check if it is a customer node that isn't the one we want, and in that case, to skip section
		if parser.get_node_type()== XMLParser.NODE_ELEMENT:
			if(parser.get_node_name()=="customer_type"):
				if(parser.get_attribute_value(0)!=str(cust)):
					parser.skip_section()
					
		# Append node value of text nodes
		if(parser.get_node_type()==XMLParser.NODE_TEXT):
			dialogues2.append(parser.get_node_data())

	return dialogues2


func _on_check_checked():
	
	if(spinner.price>=initial_price):
		sold.emit()
	elif(spinner.price<min_price):
		no_deal.emit()
	else:
		var diff = initial_price-spinner.price
		var action = rng.randf_range(0, 100)+min(30,diff*7/initial_price)
		if(action<20):
			sold.emit()
		elif(action>90):
			no_deal.emit()
		else:
			patience-= int(rng.randf_range(1, 2.4))
			
			
	pass # Replace with function body.
