class_name Leaf extends Item


@export var heal_amount: float


func _physics_process(delta: float) -> void:
	if not picked and not is_on_floor():
		# Simulate wind
		velocity.x = 64 if randi_range(0, 100) < 90 else 0
		velocity.y += gravity * delta
	elif is_on_floor(): velocity = Vector2.ZERO
	
	move_and_slide()
