extends KinematicBody

class_name Enemy

onready var mesh:MeshInstance = $CollisionShape/MeshInstance
var is_alert: bool = false
var target = null
var speed:float = 30

func _process(delta):	
	if target != null:
		print(target.global_transform.origin)
		look_at(target.global_transform.origin, Vector3.UP)	
		move_to_target(delta)	
		
func move_to_target(delta):
	var direction = target.transform.origin - self.transform.origin
	move_and_slide(direction * speed * delta, Vector3.UP)
	
func _on_DetectionArea_body_entered(body):
	if body.is_in_group("Player"):
		print("player entered")	
		is_alert = true
		target = body
		set_mesh_color(Color.red)

func _on_DetectionArea_body_exited(body):
	if body.is_in_group("Player"):
		print("player exited")
		is_alert = false
		set_mesh_color(Color.green)
		target = null

func set_mesh_color(color: Color):
	mesh.get_surface_material(0).set_albedo(color)
