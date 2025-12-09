## Your Polish tomboy bestie, Zd4da!
##
## It's gonna be rather easy to navigate here, but I insist you visit [ChatUser] first.[br]
## Such custom classes will be written for every NPC present in the game.[br]
## [br]
## P.S I will use Zd4da to test out stuff, so she is a pioneer in this project.
class_name Zd4da extends ChatUser

func _init() -> void:
	username = "zd4da"
	user_color = "red"
	
## Well, reacts! Reads [param msg] [param from] [ChatUser].
## [br]Calls [method write_chat] depending on message content.
func react_to(msg: String, from: ChatUser) -> void:
	if from.username == username: return
	print("Called %s on message %s from %s" % [react_to, msg, from.username])
	if username in msg:
		write_chat("Oi there!")
	if from.username == "bm00n":
		write_chat("Gay")
	if "leave_all" in msg:
		write_chat("I ain't leavin', fuck off!")
