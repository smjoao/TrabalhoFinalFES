extends KinematicBody2D


export var speed = 400  # How fast the player will move (pixels/sec).
var screen_size  # Size of the game window.
var velocity = Vector2()


func _ready():
	screen_size = get_viewport_rect().size


func _process(_delta):
	velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.play("WalkR")
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		$AnimatedSprite.play("WalkL")
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		$AnimatedSprite.play("WalkD")
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		$AnimatedSprite.play("WalkU")
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	else:
		$AnimatedSprite.play("Idle")
	

func _physics_process(_delta):
	move_and_slide( velocity, Vector2.UP)
