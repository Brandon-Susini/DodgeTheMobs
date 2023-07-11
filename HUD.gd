extends CanvasLayer

signal game_started

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()
	
	
func start_game_over():
	show_message("Game Over")
	
	await $MessageTimer.timeout
	
	$MessageLabel.text = "Dodge the creeps!"
	$MessageLabel.show()
	
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_message_timer_timeout():
	$MessageLabel.hide()
	pass # Replace with function body.
	


func _on_start_button_pressed():
	$StartButton.hide()
	game_started.emit()
	pass # Replace with function body.