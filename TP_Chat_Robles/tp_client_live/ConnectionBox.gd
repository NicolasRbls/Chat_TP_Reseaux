extends Control

signal send_pseudo
# Autres variables...
onready var input_ip = $Panel/VBoxContainer/adresse_ip
onready var input_port = $Panel/VBoxContainer/port
onready var input_pseudo = $Panel/VBoxContainer/pseudo

func _ready():
	print("ConnectionBox ready!")

func _on_Button_button_down():
	var ip_addr = input_ip.text
	var port = input_port.text
	var nick = input_pseudo.text
	Global.pseudo = nick  # Définir le pseudo dans le singleton global
	join_server(ip_addr, port, nick)

func join_server(ip, port, pseudo):
	print("Joining server with IP:", ip, "Port:", port, "Pseudo:", pseudo)
	var net = NetworkedMultiplayerENet.new()
	if (net.create_client(ip, int(port)) != OK):
		print("Failed to create client")
		return
	get_tree().set_network_peer(net)
	print("Server joined! Connecting...")
	yield(get_tree().create_timer(1.0), "timeout")  # Attente pour la connexion
	change_to_chat_scene()

func change_to_chat_scene():
	get_tree().change_scene("res://ChatScene.tscn")

