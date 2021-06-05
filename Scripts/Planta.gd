extends Node2D

onready var anim_sprite = $AnimatedSprite

var curr_phase
var regada

func _ready():
	curr_phase = 1
	anim_sprite.play("fase1")
	regada = false
	get_parent().connect("timepass",self,"_on_Fazenda_timepass")

# faz a planta crescer
func cresce():
	curr_phase += 1
	regada = false
	anim_sprite.play("fase" + str(curr_phase))

# marca que a planta foi regada
func regar_planta():
	regada = true

func cria_fruti():
	var fruti_path = "res://Cenas/Fruti.tscn"
	var fruti = load(fruti_path).instance()
	fruti.global_position = self.position + Vector2(16,8)
	get_node("/root").add_child(fruti)
	
func drop():
	if(curr_phase == 3):
		print("fruto dropado")
		cria_fruti()
	else:
		print("planta removida")
	queue_free()
	
func _on_Fazenda_timepass():
	# talvez possa fzr a planta morrer se nao tiver sido regada
	print("1 dia passou para esta plantinha")
	if curr_phase != 3 and regada:
		cresce()
	else:
		print("...e ela não cresceu")
