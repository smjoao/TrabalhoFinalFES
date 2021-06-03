extends Node2D

onready var anim_sprite = $AnimatedSprite

var curr_phase

func _ready():
	curr_phase = 1
	anim_sprite.play("fase1")

func cresce():
	if( curr_phase != 3):
		curr_phase += 1
		anim_sprite.play("fase" + curr_phase)
