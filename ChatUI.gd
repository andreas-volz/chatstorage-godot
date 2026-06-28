extends MarginContainer
class_name ChatUI

const CHAT_MESSAGE = preload("uid://cqs31drccni1p")

var last_timestamp: int = 0

@onready var message_list: VBoxContainer = %MessageList
@onready var chat_name: Label = %ChatName
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func set_chat_context(chat_context: ChatContextRef):
	var chat = chat_context.get_chat()
	chat_name.text = chat.get_name()
	
	for message:MessageRef in chat_context.get_message_list():
		var chat_message:ChatMessage = CHAT_MESSAGE.instantiate()
		message_list.add_child(chat_message)
		chat_message.set_text(message.get_text())
		
		var user := message.get_sender()
		if user:
			chat_message.set_user_name(user.get_name())
		
			if user.get_name() == "Max": # TODO: hack to identify myself
				chat_message.set_horizontal_alignment(SizeFlags.SIZE_SHRINK_END)
				chat_message.set_bg_color(Color.SKY_BLUE)
			else:
				chat_message.set_horizontal_alignment(SizeFlags.SIZE_SHRINK_BEGIN)
				chat_message.set_bg_color(Color.WHITE_SMOKE)
		
		var ts := message.get_timestamp()
		chat_message.set_time_ui(ts)
		
		if not check_same_date(ts, last_timestamp):
			var new_date_label := DateCaptionLabel.new()
			var datetime := Time.get_datetime_dict_from_unix_time(ts)
			message_list.add_child(new_date_label)
			new_date_label.text = str(datetime.day) + "." + str(datetime.month) + "." + str(datetime.year)
			new_date_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		last_timestamp = ts
		
		var media = message.get_media()
		if media and media.get_type() == MediaRef.MEDIA_TYPE_IMAGE:
			var media_texture = media.get_texture()
			chat_message.set_texture(media_texture)
		elif media and media.get_type() == MediaRef.MEDIA_TYPE_AUDIO:
			# TODO: use a parameter (string or audio direct to load)
			chat_message.set_audio(media.get_path())
			chat_message.request_audio_play.connect(_on_play_audio)

	# inital resize event
	_on_resized()
		
func _on_resized() -> void:
	var max_width = size.x * 0.8
	if message_list:
		for message_bubble in message_list.get_children():
			message_bubble.update_max_width(max_width)
	
func check_same_date(timestamp_1: int, timestamp_2):
	var datetime_1 := Time.get_datetime_dict_from_unix_time(timestamp_1)
	var datetime_2 := Time.get_datetime_dict_from_unix_time(timestamp_2)
	
	if datetime_1.year != datetime_2.year or datetime_1.month != datetime_2.month or datetime_1.day != datetime_2.day:
		return false
	
	# same day
	return true
	
func _on_play_audio(play_state: bool, audio_path: String):
	audio_stream_player.stream = load(audio_path)
	if(play_state):
		audio_stream_player.play()
	else:
		audio_stream_player.stop()
	
func _on_back_button_pressed() -> void:
	queue_free()
