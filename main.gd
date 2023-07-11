extends Node

var score = 0.1
@export var enemy_scene: PackedScene
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$MobTimer.stop()
	$ScoreTimer.stop()
	$HUD.start_game_over()


func new_game():
	print("New Game Ran")
	score = 0
	$Player.start($SpawnPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("enemies","queue_free")


func _on_start_timer_timeout():
	# Show player
	# Start Processing
	# Spawn Mobs
	$MobTimer.start()
	$ScoreTimer.start()


func _on_mob_timer_timeout():
	# Instantiate
	var enemy = enemy_scene.instantiate()
	
	# Decide random point on path2d
	var spawn_loc = $Path2D/PathFollow2D
	spawn_loc.progress_ratio = randf()
	var direction = spawn_loc.rotation + PI/2
	
	enemy.position = spawn_loc.position
	
	direction += randf_range(-PI/4, PI/4)
	enemy.rotation = direction
	
	var velocity = Vector2(randf_range(150.0,250.0),0.0)
	enemy.linear_velocity = velocity.rotated(direction)

	add_child(enemy)
	pass # Replace with function body.


func _on_score_timer_timeout():
	score += 1
	#score = snapped(score + 0.1,2)
	$HUD.update_score(score)
	pass # Replace with function body.

