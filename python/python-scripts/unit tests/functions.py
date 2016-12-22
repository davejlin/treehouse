def sum_safe(*args):
	try:
		return sum(list(args))
	except:
		return 0