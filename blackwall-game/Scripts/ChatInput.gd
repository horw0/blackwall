extends LineEdit

@export var chat_controller: ChatTerminal
@export var username: String

var user_object: ChatUser

func _ready() -> void:
	user_object = ChatUser.new("Player", "green")
	print(text_submitted.connect(on_text_submit))
	print(IP.get_local_interfaces())
	print(IP.get_local_addresses()[0])

func on_text_submit(newText: String) -> void:
	text = ""
	chat_controller.submit_message(newText, user_object)
