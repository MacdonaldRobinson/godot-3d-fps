extends Interactable

export var spot_light_path:NodePath
onready var spot_light:SpotLight = get_node(spot_light_path)
var on:bool = false
var energy:float = 0

func _ready():
	pass # Replace with function body.

func interact():
	on =!on	
	
	if on:
		energy = 1
	else:
		energy = 0
	
	spot_light.light_energy = energy
	.interact()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
