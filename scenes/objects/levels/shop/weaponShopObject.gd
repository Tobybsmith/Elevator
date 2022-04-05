extends Node2D

var price = 0
#get pulled from a list of shop pool items
var weapon
var content
var shopPool
var weaponKeys

# Called when the node enters the scene tree for the first time.
func _ready():
	shopPool = get_parent().get_parent().get_node("ShopPool")
	
	#get the list of keys (weapon names) and pick one at random
	weaponKeys = shopPool.weapon_pool.keys()
	weapon = weaponKeys[randi()%weaponKeys.size()]
	#now we get the value from the weapon_pool which is the base price
	price = randi()%3 + 1 + shopPool.weapon_pool.get(weapon)
	#load a random item into the shop content
	#just make it coffee for now
	content = load("res://scenes/objects/weapons/dropped/"+weapon+"_dropped.tscn").instance()
	#player cannot just pick up the coffee
	content.monitoring = false
	get_node("ItemSprite").texture = load("res://assets/sprites/shop_icons/"+weapon+".png")
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

