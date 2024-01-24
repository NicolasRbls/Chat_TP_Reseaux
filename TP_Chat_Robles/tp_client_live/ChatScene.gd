extends Control

# Déclarations des variables onready pour référencer les différents noeuds de la scène
onready var chatBox = $ChatBox
onready var connectionBox = $ConnectionBox if $ConnectionBox else null
onready var userList = $UserList


func _ready():
	get_pseudo()
	# Connexion des signaux de chatBox
	chatBox.connect("message_sent", self, "_on_ChatBox_message_sent")

	# Connexion des signaux de connectionBox si elle est présente
	if connectionBox:
		connectionBox.connect("send_pseudo", self, "get_pseudo")

	# Connexion des signaux du script Network
	Network.connect("new_client", self, "pop_up_new_client")
	Network.connect("new_client2", self, "display_new_list")
	Network.connect("ask_pseudo", self, "get_pseudo")
	Network.connect("deco_client", self, "display_new_list")

	# Vous pouvez également ajouter d'autres initialisations ici si nécessaire


func display_new_list(users):
	# Mise à jour de la liste des utilisateurs
	userList.updat(users)
	
func _on_ChatBox_message_sent(mess):
	# Envoi du message saisi à la boîte de chat au serveur
	Network.send_message_to_server(mess)

func get_pseudo():
	var pseudo = Global.pseudo
	Network.send_pseudo(pseudo)
