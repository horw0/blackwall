extends Node2D

var users: Dictionary[String, ChatUser]

func _init() -> void:
	users = {
		"zd4da": Zd4da.new(),
		"bm00n": ChatUser.new("bm00n", "royal_blue"),
		"w3iB": ChatUser.new("w3iB", "white"),
		"v7uga": ChatUser.new("v7uga", "sky_blue")
	}
	
func _ready() -> void:
	var chat_controller: ChatTerminal = $InnerScreen/ChatController
	for user: ChatUser in users.values():
		if chat_controller.hook_user(user):
			print("User %s connected to %s" % [user.username, chat_controller])
			user.join_chat()
	users["zd4da"].write_chat("testing chat, oi there")
