extends Node

signal Report_News
signal End_Day
var all_news = []
var news = []

func _ready():
	load_news()
	set_news(0)

func load_news():
	all_news = [
		{"day": 0, "text": "news one", "cartridges_info": [{},{},{},{},{},{}]},
		{"day": 0, "text": "news two", "cartridges_info": [{},{},{},{},{},{}]},
		{"day": 1, "text": "news three", "cartridges_info": [{},{},{},{},{},{}]},
		{"day": 1, "text": "news four", "cartridges_info": [{},{},{},{},{},{}]},
		{"day": 2, "text": "news five", "cartridges_info": [{},{},{},{},{},{}]},
		{"day": 2, "text": "news six", "cartridges_info": [{},{},{},{},{},{}]}
	]

func set_news(day):
	news = []
	for news_item in all_news:
		if news_item.day == day:
			news.append(news_item)
	

func send_video(data):
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_timer_process_mode(Timer.TIMER_PROCESS_IDLE)
	timer.set_wait_time(2)
	timer.connect("timeout", self, "report_news")
	timer.start()
	add_child(timer)

# get news one
func report_news():
	var item = news.pop_front()
	if !item:
		emit_signal("End_Day")
		return
	
	emit_signal("Report_News", item)
