extends HSplitContainer
class_name ChatTerminal

var online_users: Dictionary[String, ChatUser] = {}
var chat_text: RichTextLabel

signal new_post(msg: String, from: ChatUser)

func _ready() -> void:
	chat_text = $Chat/ChatText

func set_user_online(user: ChatUser) -> void:
	var user_exists: bool = $Members.has_node(user.username)
	if user_exists:
		var target: RichTextLabel = $Members.get_node(user.username)
		print("User exists, bringing them online.")
		target.text = target.text.replace("[s]", "").replace("[/s]", "")
		target.self_modulate.a = 1
	else:
		var online_user: RichTextLabel = RichTextLabel.new()
		online_user.fit_content = true
		online_user.scroll_active = false
		online_user.autowrap_mode = TextServer.AUTOWRAP_OFF
		online_user.bbcode_enabled = true
		online_user.add_theme_font_size_override("normal_font_size", 8)
		online_user.text = "[%s]" % user.get_col_uname()
		online_user.name = user.username
		$Members.add_child(online_user)
	if not new_post.is_connected(user.react_to):
		if new_post.connect(user.react_to) == 0:
			print("%s will react to new messages." % user.username)
	if not user.message_post.is_connected(submit_message):
		if user.message_post.connect(submit_message) == 0:
			print("User %s connected to chat and can send messages now." % user.username)

func set_user_offline(user: ChatUser) -> int:
	new_post.disconnect(user.react_to)
	var target: RichTextLabel = $Members.get_node(user.username)
	if target:
		target.text = "[s]%s[/s]" % target.text
		target.self_modulate.a = 0.3
		return 1
	else:
		print("Node for user %s is not found." % user.username)
		return 0

func submit_message(message_text: String, from_user: ChatUser) -> void:
	var messageTime: String = Time.get_time_string_from_system().left(-3)
	if "_reset" in message_text:
		for user: ChatUser in online_users.values():
			user.join_chat()
	chat_text.append_text("[%s](%s): %s\n" % [from_user.get_col_uname(),
		messageTime, message_text])
	new_post.emit(message_text, from_user)

func hook_user(user: ChatUser) -> int:
	var join_sign: int = not user.joined_chat.connect(on_join_chat)
	var left_sign: int = not user.left_chat.connect(on_left_chat)
	return join_sign and left_sign

func on_join_chat(user: ChatUser) -> void:
	if not online_users.get(user.username):
		online_users[user.username] = user
	set_user_online(user)
	chat_text.append_text("[%s] is [color=green]online[/color]\n" % user.get_col_uname())

func on_left_chat(user: ChatUser) -> void:
	if set_user_offline(user):
		print("User %s successfully left." % user.username)
	chat_text.append_text("[%s] is [color=red]offline[/color]\n" % user.get_col_uname())
