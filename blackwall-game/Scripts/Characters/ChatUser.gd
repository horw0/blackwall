## Generic NPC class.
##
## Treat derived NPC classes as experimental too.
## @experimental
class_name ChatUser extends Node

## Self-explanatory
var username: String
## Self-explanatory
var user_color: String
## Time string [ChatUser] last seen online (messaging, reacting and etc.)[br]
## For future use
var last_seen_online: String
## Each character will have a short bio written by other members.[br]
## Dictionary struct is username:description
var per_character_desc: Dictionary[String, String]

## Used to write stuff in chat.
##[br]Passes text [String] and [ChatUser] object, from which comes the text.
signal message_post(message_text: String, user: ChatUser)

## Signal for [ChatTerminal] to react to when user joins the chat.
signal joined_chat(user: ChatUser)

## Signal for [ChatTerminal] to react to when user leaves the chat.
signal left_chat(user: ChatUser)

func _init(username_str: String, user_color_str: String) -> void:
	username = username_str
	user_color = user_color_str

## Wrapper over signal [signal message_post].[br]
## Call it with your text in [param msg] to make NPC write stuff. 
func write_chat(msg: String) -> void:
	print("Called %s from %s with %s" % [write_chat, self.username, msg])
	message_post.emit(msg, self)

## Generic reaction function.
## [br]Each character will have custom message reactions and behaviour, so [method react_to] will be overriden.
## [br]P.S. If you ever see a NPC calling this - report pls.
func react_to(msg: String, from: ChatUser) -> void:
	if from.username == username: return
	print("%s reacting to message from %s:\t %s" % [username, from.username, msg])
	if username in msg:
		write_chat("?")
	if "leave_all" in msg:
		leave_chat()
	# Write story based reaction?

## Adds user to the chat. Updates [member last_seen_online] and emits [signal joined_chat].
func join_chat() -> void:
	last_seen_online = Time.get_time_string_from_system().left(-3)
	joined_chat.emit(self)

## Removes user from the chat. Emits [signal left_chat].
func leave_chat() -> void:
	left_chat.emit(self)

## Return BBCode-formatted username for [ChatTerminal] to use.
func get_col_uname() -> String:
	return "[color=%s]%s[/color]" % [user_color, username]
