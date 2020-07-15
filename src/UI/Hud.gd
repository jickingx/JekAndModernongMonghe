extends CanvasLayer

const FORMAT_STRING_COINS = " %s"
var coins := 0


func coin_add(val: int):
	var new_text
	coins += val
	if coins < 10:
		new_text = "00" + str(coins)
	elif coins >= 100:
		new_text = str(coins)
	elif coins >= 10:
		new_text = "0" + str(coins)
	else:
		new_text = str(coins)
	$CoinCounter.text = FORMAT_STRING_COINS % new_text
