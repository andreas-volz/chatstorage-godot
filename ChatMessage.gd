extends MarginContainer
class_name ChatMessage

signal request_audio_play(play_state: bool, audio_path: String)

const CHAT_TEXT_LABEL = preload("uid://c7v6hm53eqbwi")
const CHAT_IMAGE = preload("uid://dupw6jir75slp")
const CHAT_AUDIO_PLAYER = preload("uid://c1vff6rgfoxo3")

@onready var align_container: PanelContainer = %AlignContainer
@onready var margin_container: MarginContainer = %MarginContainer
@onready var time_ui: Label = %TimeUI
@onready var content_container: VBoxContainer = %ContentContainer
@onready var user_name: Label = %UserName

var _label: RichTextLabel
var _image: TextureRect
var _audio_ui
var _audio_path: String

## SIZE_SHRINK_BEGIN
## SIZE_SHRINK_END
func set_horizontal_alignment(alignment: SizeFlags):
	align_container.size_flags_horizontal = alignment

func update_max_width(width: float):
	%MarginContainer.custom_minimum_size.x = width
	
func set_time_ui(timestamp: int):
	var datetime := Time.get_datetime_dict_from_unix_time(timestamp)
	time_ui.text = str(datetime.hour) + ":" + str(datetime.minute)
	
func set_text(text: String):
	if(!_label):
		_label = CHAT_TEXT_LABEL.instantiate()
		content_container.add_child(_label)
		content_container.move_child(_label, 1)
	_label.text = text
	
func set_texture(image_texture: ImageTexture):
	if(!_image):
		_image = CHAT_IMAGE.instantiate()
		content_container.add_child(_image)
		content_container.move_child(_image, 2)
	_image.texture = image_texture
	
func set_audio(audio_path: String):
	if(!_audio_ui):
		_audio_ui = CHAT_AUDIO_PLAYER.instantiate()
		content_container.add_child(_audio_ui)
		_audio_ui.play_audio.connect(_on_play_audio)
	_audio_path = audio_path
	
func set_user_name(text: String):
	user_name.text = text
	
func _on_play_audio(play_state: bool):
	request_audio_play.emit(play_state, _audio_path)
	
func set_bg_color(color: Color):
	var panel_stylebox = align_container.get_theme_stylebox("panel").duplicate()
	panel_stylebox.bg_color = color
	align_container.add_theme_stylebox_override("panel", panel_stylebox)

	
	#TODO (future improvements):
#- Implement proper mixed-font text measurement (primary + fallback fonts).
#- Parse Unicode text for emojis, ZWJ sequences, and explicit line breaks.
#- Calculate per-line width based on actual glyph layout.
#- Derive minimal bubble width from measured text with a max-width cap.
#- Cache layout results to avoid recomputation during resize or scrolling.
	# get_string_size()
	#var min_size = label.get_minimum_size()
	#%MarginContainer.custom_minimum_size.x = min(width, min_size.x)
