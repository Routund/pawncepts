extends Node2D

var cust = 0
var item = 0
var item_index=0
var min_price = 0
var initial_price = 0
var sell_price = 100
@onready var calculator = get_node("../../Calculator")
@onready var dialogue = get_node("Dialogue")
@onready var money = get_node("../../Label")
@onready var escape = get_node("Dialogue2")
var inventory = []
var dialogues = []
var check_price
signal sold(price: int)
var patience = 5
var exit =false
var exitNow=false
var customerState;
var dia="";
var dia_index=0;
var customerTypes = [
	0, # Stingy, give high price and have relatively high min price
	1, # Desperate, give low price, and have relatively low min price
	2, # Clueless, give high price, and have relatively low min price
	3, # Veteran, give low price, and have relatively high min price
]
var cust_variance = [
	0.9, # Stingy, give high price and have relatively high min price
	0.6, # Desperate, give low price, and have relatively low min price
	0.6, # Clueless, give high price, and have relatively low min price
	0.95, # Veteran, give low price, and have relatively high min price   
]
var init_variance = [
	1.4, # Stingy, give high price and have relatively high min price
	1.3, # Desperate, give low price, and have relatively low min price
	2, # Clueless, give high price, and have relatively low min price
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
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if(dia!=""):
		if(dia_index<len(dia)):
			dialogue.text+=dia[dia_index]
			dia_index+=1
		else:
			dia=""
			if(!exit):
				calculator.goUp=true
	if(Input.is_action_just_pressed("escapeDialogue") or Input.is_action_just_pressed("Confirm")):
		if(exit):
			visible = false
			exit = false
			escape.visible=false
			escape.isFading=false
			exitNow = true
			dia=""
		elif(dia!=""):
			dialogue.text=dia
			dia=""
			calculator.goUp=true
	pass

func _on_customer_entered():
		rng.randomize()
		if(randi_range(0,6)>=inventory.size()):
			customerState="sell"
			# Pick random values for customer
			item = randi() % items_dict.size()
			cust = customerTypes[randi() % customerTypes.size()]
			min_price = int(prices[item] * (cust_variance[cust] + rng.randf_range(-0.1, 0.1)))
			initial_price = int(min_price*(init_variance[cust]+rng.randf_range(-0.05, 0.1))) 
			
			# Load Dialogue
			dialogues = load_dialogues("res://Scripts/sellDialog.xml")
			dia=dialogues[0]%[items_dict[item],initial_price]

		else:
			customerState="buy"
			item_index = randi() % inventory.size()
			# Pick random values for customer
			item = inventory[item_index]
			cust = customerTypes[randi() % customerTypes.size()]
			min_price = int(prices[item] / (cust_variance[cust] + rng.randf_range(-0.1, 0.1)))
			initial_price = int(min_price/(init_variance[cust]+rng.randf_range(-0.1, 0.05))) 

			# Load Dialogue
			dialogues = load_dialogues("res://Scripts/buyDialog.xml")
			dia=dialogues[0]%["%s [%d]"%[items_dict[item],item_index+1],initial_price]
			
		# Initialize all things needed, such as the calculator and the dialoguw
		patience=5
		dialogue.text=""
		dia_index=0
		calculator.finalValue=""
		calculator.display.text=""
		visible = true
		exit=false
		escape.visible=false
		escape.isFading=false
		calculator.cross.disabled=false

func load_dialogues(path : String) -> Array:
	var dialogues2 = []
	
	# Set up Parser
	var parser = XMLParser.new()
	parser.open(path)
	
	while parser.read() != ERR_FILE_EOF:
		# If node is element, check if it is a customer node that isn't the one we want, and in that case, to skip section
		if parser.get_node_type()== XMLParser.NODE_ELEMENT:
			if(parser.get_node_name()=="customer_type"):
				if(parser.get_attribute_value(0)!=str(cust)):
					parser.skip_section()
					
		# Append node value of text nodes
		if(parser.get_node_type()==XMLParser.NODE_TEXT):
			if(parser.get_node_data().strip_edges()!=""):
				dialogues2.append(parser.get_node_data())
	return dialogues2


func fin(price,dia_id):
	
	dia=dialogues[dia_id]
	dialogue.text=""
	dia_index=0
	exit = true
	escape.visible=true
	escape.isFading=true
	calculator.goDown=true
	calculator.cross.disabled=true
	calculator.confirm.disabled=true
	sold.emit(price)

func _on_back_crossed():
	fin(0,1)
	pass # Replace with function body.


func _on_confirm_checked():
		if customerState == "sell":
			# Handle selling behavior
			check_price = int(calculator.finalValue)
			if(check_price>money.balance):
				return
			# Check if the offered price is higher than or equal to the initial price
			if check_price >= initial_price:
				fin(check_price,2)
				inventory.append(item)
			# Check if the offered price is lower than the minimum acceptable price
			elif check_price < min_price:
				fin(0,1)
			else:
				# Calculate a decision based on the difference between initial and offered prices
				var diff = initial_price - check_price
				var action = rng.randf_range(0, 100) + min(30, diff * 7 / initial_price)
				if action < 15:
					fin(check_price,3)
					inventory.append(item)
				elif action > 95:
					fin(0,1)
				else:
					# Adjust the patience level and negotiate the price
					patience -= int(rng.randf_range(1, 2.4))
					if patience == 0:
						fin(0,1)
					else:
						var newPrice = int(rng.randf_range(check_price+1,initial_price))
						initial_price = newPrice
						min_price=check_price
						dia=dialogues[8-patience]%[initial_price]
						dialogue.text=""
						dia_index=0  # Price negotiation
						calculator.finalValue=""
						calculator.display.text=""
		else:
			# Handle buying behavior
			check_price = int(calculator.finalValue)
			
			# Check if the offered price is lower than or equal to the initial price
			if check_price <= initial_price:
				fin(-check_price,2)
				inventory.pop_at(item_index)
			elif check_price > min_price:
				fin(0,1)
			else:
				# Calculate a decision based on the difference between initial and offered prices
				var diff = check_price - initial_price
				var action = rng.randf_range(0, 100) + min(30, diff * 7 / initial_price)
				if action < 15:
					fin(-check_price,3)
					inventory.pop_at(item_index)
				elif action > 95:
					fin(0,1)
				else:
					# Adjust the patience level and negotiate the price
					patience -= int(rng.randf_range(1, 2.9))
					if patience == 0:
						fin(0,1)
					else:
						var newPrice = int(rng.randf_range(initial_price,check_price-1))
						initial_price = newPrice
						dia=dialogues[8-patience]%[initial_price]
						dialogue.text=""
						dia_index=0  # Price negotiation
						min_price=check_price
						calculator.finalValue=""
						calculator.display.text=""
						calculator.update_confirm_button_state()
		pass # Replace with function body.
