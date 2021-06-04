extends Node

func do_action( fazenda ):
	# verifica se a posição que o mouse aponta tem alguma planta
	var planta = fazenda.check_for_planta( fazenda.mouse_tile_pos )
	if planta:
		# rega a planta naquela posição
		planta.regar_planta()
