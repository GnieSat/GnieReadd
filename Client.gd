extends Node2D

@export var Pos : Vector3 = Vector3.ZERO 
@export var Speed : float = 0.0
@export var Distance : float = 0.0


var peer : ENetMultiplayerPeer = ENetMultiplayerPeer.new()
var Ip : String = "localhost"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	multiplayer.peer_connected.connect(connected)
	multiplayer.peer_disconnected.connect(disconnected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func connected(val):
	$Node/Status.text = "Status: connected"


func disconnected(val):
	$Node/Status.text = "Status: disconnected"


func refresh_Data() -> void:
	$Node/X.text = "X (west/east) in meters:  " + "%0.2f" % Pos.x
	$Node/Y.text = "Height in meters:  " + "%0.2f" % Pos.y
	$Node/Z.text = "Z (north/south) in meters:  " + "%0.2f" % Pos.z
	$Node/Speed.text = "Speed in m/s:  " + "%0.2f" % Speed
	$Node/Distance.text = "Distance in meters  " + "%0.2f" % Distance


func _on_join_pressed() -> void:
	peer.close()
	disconnected(0)
	peer.create_client(Ip, 13500)
	multiplayer.multiplayer_peer = peer


func _on_line_edit_text_submitted(new_text: String) -> void:
	Ip = new_text
	$Node/IP.text = "IP: " + str(Ip)


func _on_multiplayer_synchronizer_synchronized() -> void:
	refresh_Data()
