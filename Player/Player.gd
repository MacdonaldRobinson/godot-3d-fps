extends KinematicBody

class_name Player

export var speed: float = 10
export var acceleration: float = 5
export var gravity: float = 9.8
export var jump_power: float = 200

onready var head = $Head
onready var head_camera:Camera = $Head/HeadCamera
onready var head_ray_cast:RayCast = $Head/HeadCamera/HeadRayCast
onready var info:Label = $UI/Info

var mouse_sensitivity: float = 0.3
var velocity: Vector3 = Vector3()
var camera_x_rotation: float = 0

func _ready():	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("mouse_capture"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)			
	
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			head_camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	var direction: Vector3 = Vector3(0,0,0)
		
	if Input.is_action_pressed("forward"):
		direction -= head_basis.z
	elif Input.is_action_pressed("backward"):
		direction += head_basis.z
		
	if Input.is_action_pressed("left"):
		direction -= head_basis.x
	elif Input.is_action_pressed("right"):
		direction += head_basis.x
		
	direction = direction.normalized()
	
	velocity.y -= gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_power
	
	velocity = velocity.linear_interpolate(direction * speed, acceleration * delta)

	velocity = move_and_slide(velocity, Vector3.UP);
	
	var head_ray_collider = head_ray_cast.get_collider()
		
	if head_ray_collider is Interactable:	
		info.text = "You can interact with this item using the 'E' key"
		if Input.is_action_just_pressed("interact"):
			head_ray_collider.interact()
	else:
		info.text = ""
		
	
