extends Control

@export var priceN=0
@export var item=0

@onready var name_node = get_node("HBoxContainer/Name")
@onready var price_node = get_node("HBoxContainer/Price")
@onready var image_node = get_node("HBoxContainer/Icon")
@onready var desc_node = get_node("HBoxContainer/Description")

var items_dict = {
	0:"Necklace",
	1:"Ring",
	2:"Console",
	3:"Vase"
}
var descriptions = [
	"Golden necklace, seems to be a precious family heirloom.", # Necklace
	"Diamond encrusted ring, could it be a failed wedding proposal?", # Ring
	"Old dusty H-Box, small orange crumbs are falling out from it.", # Console
	"Not from the ming dynasty", # Vase
]
var files = [
	"res://Assets/Necklace.png", # Necklace
	"res://Assets/ring.png", # Ring
	"res://Assets/Console.png", # Console
	"res://Assets/Vase.png", # Vase
]
# Called when the node enters the scene tree for the first time.
func _ready():
	price_node.text= "$" + str(priceN)
	name_node.text= items_dict[item]
	desc_node.text= descriptions[item]
	image_node.texture = load(files[item])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
