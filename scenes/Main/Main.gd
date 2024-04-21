extends Node2D

@onready var grid = $Grid

func _ready():
	grid.generateGrid()
	$Grid/PathFinder.initialize()
	
func _call_nova_bot():
	var data = {
		"conversation": "123",
		"bot_id": "7359962504053129221",
		"user": "{{USER_ID}}",
		"query": "Help me make my colonists happier",
		"stream": false
	}
	var json = JSON.stringify(data)
	var headers = ["Authorization: Bearer {{API_KEY}}", "Content-Type: application/json", "Accept: */*", "Host: api.coze.com", "Connection: keep-alive"]
	var url = "https://api.coze.com/open_api/v2/chat"
	$HTTPRequest.request_completed.connect(_on_request_completed)
	$HTTPRequest.request(url, headers, HTTPClient.METHOD_POST, json)

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse_string(body.get_string_from_utf8())
	for message in json["messages"]:
		print(message["content"])
		print("\n")
