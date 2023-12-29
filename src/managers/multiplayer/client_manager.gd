class_name ClientManager extends Node
## Connects to a server.`
##
## The ClientManager is a part of the Multiplayer namespace.
## It runs on all client devices and handles all client-side
## functionality.

#region Signals
# ...
#endregion

#region Variables
#region Configs
## Host IP. Defaults to 127.0.0.1.
var host = "127.0.0.1"

## Default port.
const DEF_PORT = 4337

## Our WebSocketClient instance.
var _client := WebSocketMultiplayerPeer.new()
#endregion

var players := []
#endregion

## Sets up the server.
func _ready():
	setup_signals()

## Sets up the client connected and disconnected signals.
func setup_signals():
	multiplayer.peer_connected.connect(_on_client_connected)
	multiplayer.peer_disconnected.connect(_on_client_disconnected)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

## Starts the server and updates the peer.
func start_client():
	multiplayer.multiplayer_peer = null
	var err = _client.create_client("ws://" + host + ":" + str(DEF_PORT))
	if err == Error.OK:
		multiplayer.multiplayer_peer = _client
		print_c("Client Started")
	else:
		print_c("Error: %s" % Error_EXT.get_error(err))

## Stops the server and cleans up.
func stop_client():
	multiplayer.multiplayer_peer.close()
	print_c("Client Stopped")

#
# func restart_server():
#   pass
#

#region Signal Handlers
func _on_client_connected(id: int):
	print_c("Client (%d) Connected" % id, id)

func _on_client_disconnected(id: int):
	print_c("Client (%d) Disconnected" % id, id)

func _on_server_disconnected():
	print_c("Server Connection Lost")
#endregion

func print_c(msg: String, id: int = -1) -> void:
	(%Status as Label).text = msg
	print("Client (%s): %s" % [id, msg])
