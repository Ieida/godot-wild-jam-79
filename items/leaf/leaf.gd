class_name Leaf extends Item


@export var heal_amount: float


func _physics_process(delta: float) -> void:
	if picked:
		var mp = get_global_mouse_position()
		global_position = mp
	else:
		if not is_on_floor():
			# Simulate wind
			velocity.x = 64 if randi_range(0, 100) < 90 else 0
			velocity.y += gravity * delta
		else: velocity = Vector2.ZERO
		
		move_and_slide()
