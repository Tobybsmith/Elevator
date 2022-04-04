extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var particles
var collected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	particles = get_parent().get_node("Particles2D")
	pass # Replace with function body.

func _physics_process(delta):
	for body in get_overlapping_bodies():
		if(body.name == "Player"):
			body.money += 1
			#emit some particles
			particles.emitting = true
			#wait until the partcles are done
			collected = true
			self.queue_free()
			get_parent().get_node("Sprite").queue_free()
			get_parent().get_node("ParticlesTimer").start()
			get_parent().get_node("AudioStreamPlayer2D").playing = true;
