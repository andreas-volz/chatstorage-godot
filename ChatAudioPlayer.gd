extends HBoxContainer

signal play_audio(play_state: bool)

func _on_play_button_toggled(toggled_on: bool) -> void:
	play_audio.emit(!toggled_on)
