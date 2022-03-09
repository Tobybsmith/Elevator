extends Area2D


#upon contact with the player, send a signal to the player
signal picked_up(weapon)
# Called when the node enters the scene tree for the first time.
func _ready():
	var n = get_tree().get_root().get_node("Root").get_node("Player")
	connect("picked_up", n, "picked_up")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#sends to Player.gd
func _on_SwordDropped_body_entered(body):
	if(body.name == "Player"):
		emit_signal("picked_up", "sword")
		self.queue_free()
