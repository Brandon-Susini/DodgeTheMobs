extends Area2D

signal hit

@export var speed = 400
var screen_size
var direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	screen_size = get_viewport().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var anim = $AnimatedSprite2D
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	#If we are moving
	if velocity != Vector2.ZERO:
		# Update direction
		direction = velocity
		# Normalize the velocity to stop diagonal movement increase
		velocity = velocity.normalized() * speed
		# Start playing the selected animation
		anim.play()
	else:
		# Stop playing the selected animation
		anim.stop()
	# Set the desired animation to "move"
	anim.animation = "move"
	
	# Update position based on velocity
	position += velocity * delta
	# Clamp position to screen bounds
	position.x = clamp(position.x, 0.0, screen_size.x)
	position.y = clamp(position.y, 0.0, screen_size.y)
	# Rotate the player so that their
	# up direction faces their move
	# direction
	rotation = position.angle_to_point(position + direction) + deg_to_rad(90)


func _on_body_entered(body):
	hit.emit()
	hide()
	$CollisionShape2D.set_deferred("disabled",true) # Disable collisions once player dies


func start(start_pos):
	position = start_pos
	show()
	$CollisionShape2D.disabled = false
