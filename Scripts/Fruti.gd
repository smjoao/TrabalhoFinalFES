extends Node

signal collected

func _on_Area2D_body_entered(body):
	emit_signal("collected")
	queue_free()
