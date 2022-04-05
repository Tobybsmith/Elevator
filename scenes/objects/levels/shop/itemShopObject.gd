extends Node2D

var price = 0
#get pulled from a list of shop pool items
var item
var itemKeys
var content
var shopPool

# Called when the node enters the scene tree for the first time.
func _ready():
	shopPool = get_parent().get_parent().get_node("ShopPool")
	#parent is GeneralShopObject, and that parent is the BitShop which has the ShopPool node
	itemKeys = shopPool.item_pool.keys();
	item = itemKeys[randi()%itemKeys.size()]
	price = randi()%3 + 1 + shopPool.item_pool.get(item)
	#load a random item into the shop content
	#just make it coffee for now
	content = load("res://scenes/objects/passive/dropped_items/"+item+"_dropped.tscn").instance()
	#player cannot just pick up the coffee
	content.monitoring = false
	get_node("ItemSprite").texture = load("res://assets/sprites/passive/"+item+".png")
	get_node("PriceLabel").text = "Price: " + str(price)+" Money"

func _physics_process(delta):
	for body in get_node("ShopObjectCollider").get_overlapping_bodies():
		if(body.name == "Player" and Input.is_action_just_pressed("interact")):
			if(body.money >= price):
				body.money -= price
				body.picked_up_item(item)
				get_parent().queue_free()
				self.queue_free()

