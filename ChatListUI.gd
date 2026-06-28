extends MarginContainer
class_name ChatListUI

const CHAT_LIST_BUTTON = preload("uid://b8uiem0ceycor")
const CHAT_UI = preload("uid://b7m776njbnxl1")

var chat_storage: ChatStorageRef
var open_chat_ui: ChatUI

@onready var chat_list_container: VBoxContainer = %ChatListContainer
@onready var chat_container: MarginContainer = %ChatContainer

func _ready() -> void:
	chat_storage = ChatStorageRef.new()
	chat_storage.open_database("/home/andreas/tmp/chatstorage/chatstorage.db", "/home/andreas/tmp/chatstorage/media")
	
	var chat_entry_list = chat_storage.get_chat_entry_list()
	
	for chat_entry in chat_entry_list:
		var chat_button: Button = CHAT_LIST_BUTTON.instantiate()
		chat_list_container.add_child(chat_button)
		chat_button.text = chat_entry.get_name()
		chat_button.pressed.connect(_on_chat_button_pressed.bind(chat_entry))
		

func _on_chat_button_pressed(chat_entry: ChatEntryRef):
	if (open_chat_ui != null):
		open_chat_ui.queue_free()
	open_chat_ui = CHAT_UI.instantiate()
	chat_container.add_child(open_chat_ui)
	var chat_context: ChatContextRef = chat_storage.load_by_chat_entry(chat_entry)
	open_chat_ui.set_chat_context(chat_context)
