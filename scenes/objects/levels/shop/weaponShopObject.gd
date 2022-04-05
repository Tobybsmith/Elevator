extends Node2D

var price = 0
#get pulled from a list of shop pool items
var weapon
var content

# Called when the node enters the scene tree for the first time.
func _ready():
	price = randi()%20 + 1
	#parent is GeneralShopObject, and that parent is the BitShop which has the ShopPool node
	weapon = get_parent().get_parent().get_node("ShopPool").weapon_pool[randi()%get_parent().get_parent().get_node("ShopPool").weapon_pool.size()]
	#load a random item into the shop content
	#just make it coffee for now
	content = load("res://scenes/objects/weapons/dropped/"+weapon+"_dropped.tscn").instance()
	#player cannot just pick up the coffee
	content.monitoring = false
	get_node("ItemSprite").texture = load("res://assets/sprites/weapons/"+weapon+".png")
	get_node("PriceLabel").text = "Price: " + str(price)+" Money"

func _physics_process(delta):
	for body in get_node("ShopObjectCollider").get_overlapping_bodies():
		if(body.name == "Player" and Input.is_action_just_pressed("interact")):
			if(body.money >= price):
				body.money -= price
				body.picked_up(weapon)
				#must be used only in context of GeneralShopObject
				get_parent().queue_free()
				self.queue_free()

