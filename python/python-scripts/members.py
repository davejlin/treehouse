def members(aDict, keys):
	n = 0
	for key in keys:
		try:
			a = aDict[key]
			n += 1
		except:
			print(key + " is not in the dict")
	return n

myDict = {'a':0,'b':1,'c':2,'e':4}
keys = ['a','f','d']

print('There are ' + str(members(myDict, keys)) + ' keys in the dict.')

