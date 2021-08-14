extends AnimatedSprite
class_name Explosion

func _ready() -> void:
	$AudioStreamPlayer2D.play()
	play()

func _on_AudioStreamPlayer2D_finished() -> void:
	queue_free()
