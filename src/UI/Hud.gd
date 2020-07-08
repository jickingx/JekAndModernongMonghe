extends CanvasLayer

const FORMAT_STRING_COINS = " X %s"
var coins:= 0

func coin_add():
	var new_text 
	coins += 1
	if coins < 10:
		new_text = "0" + str(coins)
	else:
		new_text = str(coins)
	$LabelCoins.text = FORMAT_STRING_COINS % new_text
