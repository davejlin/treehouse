import datetime

answer_format = "%m/%d"
wiki_format = "%B_%d"
wiki_link = "https://en.wikipedia.org/wiki/{}"

while True:
	answer = input("Enter date as MM/DD, or 'quit' to quit: > ")

	answer = answer.upper()
	if answer == "QUIT":
		break

	try:
		ans_date = datetime.datetime.strptime(answer, answer_format)
		ans_date_str = ans_date.strftime(wiki_format)
		ans_link = wiki_link.format(ans_date_str)
		print(ans_link)
	except:
		print("Invalid date: please try again.")
