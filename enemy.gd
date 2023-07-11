extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var enemy_anims = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(enemy_anims[randi() % enemy_anims.size()])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += Vector2.RIGHT * 10 * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
