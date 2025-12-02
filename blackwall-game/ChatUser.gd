class_name ChatUser extends Node

var username: String
var user_color: String
var last_seen_online: String
var per_character_desc: Dictionary[String, String]

signal message_post(message_text: String, user: ChatUser)
signal joined_chat(user: ChatUser)
signal left_chat(user: ChatUser)

func _init(username_str: String, user_color_str: String) -> void:
	username = username_str
	user_color = user_color_str

func write_chat(msg: String) -> void:
	message_post.emit(msg, self)

func react_to(msg: String, from: ChatUser) -> void:
	print("%s reacting to message from %s:\n%s\n" % [username, from.username, msg])
	# Write story based reaction?

func join_chat() -> void:
	last_seen_online = Time.get_time_string_from_system().left(-3)
	joined_chat.emit(self)

func leave_chat() -> void:
	left_chat.emit(self)

func get_col_uname() -> String:
	return "[color=%s]%s[/color]" % [user_color, username]
