import random

def nchoices(aList, n):
	resultList = []
	for i in range(0, n):
		resultList.append(random.choice(aList))

	return resultList

aList = list(range(10000))
newList = nchoices(aList, 10)

print(newList)