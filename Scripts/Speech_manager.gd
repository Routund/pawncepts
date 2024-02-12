extends Node2D

var cust = 0
var item = 0
var min_price = 0
var initial_price = 0
var sell_price = 100
@onready var dialogue = get_node("Control/Label")

var customerTypes = [
	0, # Stingy, give high price and have relatively high min price
	1, # Desperate, give low price, and have relatively low min price
	2, # Clueless, give high price, and have relatively low min price
	3, # Veteran, give low price, and have relatively high min price
]
var cust_variance = [
	1.1, # Stingy, give high price and have relatively high min price
	0.4, # Desperate, give low price, and have relatively low min price
	0.7, # Clueless, give high price, and have relatively low min price
	1, # Veteran, give low price, and have relatively high min price   
]
var items = [
	0, # Necklace
	1, # Ring
	2, # Console
	3, # Vase
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
func _process(delta):
	pass


func _on_customer_entered():
	item = items[randi() % items.size()]
	cust = customerTypes[randi() % customerTypes.size()]
	min_price = int(prices[item] * (cust_variance[cust] + rng.randf_range(-0.2, 0.2)))
	initial_price = min_price + randi_range(10, 50)  # Set an initial price above min_price

	visible = true

	# Display dialogue based on customer type
	match cust:
		0:
			dialogue.text = "I'm looking to sell this %s. It's worth %d. Any objections?" % [items[item],initial_price]
		1:
			dialogue.text = "Look man, you think this %s, is worth at least %d?" % [items[item],initial_price]
		2:
			dialogue.text = "I'm not really sure what this %s is worth. would %d work?" % [items[item],initial_price]
		3:
			dialogue.text = "I've done my own appraisal, and this %s is worth %d" % [items[item],initial_price]
	pass
