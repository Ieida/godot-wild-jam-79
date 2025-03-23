class_name Leaf extends Item


@export var age_amount: float
@export var heal_amount: float


func _physics_process(_delta: float) -> void:
	if not picked and not is_on_floor():
		# Simulate wind
		var st = Time.get_unix_time_from_system()
		var t = sin(st * 2.)
		var t2 = (sin(st * 0.5) + 1.) / 2.
		var t3 = (sin(st * 0.4) + 1.) / 2.
		var tf = (t + (t2 * t3)) / 2.
		velocity.x = tf * 16.
		velocity.y = gravity
	elif is_on_floor(): velocity = Vector2.ZERO
	
	move_and_slide()
