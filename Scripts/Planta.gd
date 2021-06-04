extends Node2D

onready var anim_sprite = $AnimatedSprite

var curr_phase

func _ready():
	curr_phase = 1
	anim_sprite.play("fase1")
	get_parent().connect("timepass",self,"_on_Fazenda_timepass")

func cresce():
	if( curr_phase != 3):   #o ideal seria colocar um if regada aqui
		curr_phase += 1
		anim_sprite.play("fase" + str(curr_phase))

func _on_Fazenda_timepass():
	print("1 dia passou para esta plantinha")
	cresce()
