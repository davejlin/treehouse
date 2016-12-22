# Create a function named combo() that takes two iterables and 
# returns a list of tuples. Each tuple should hold the first item in 
# each list, then the second set, then the third, and so on. 
# Assume the iterables will be the same length.

# combo([1, 2, 3], 'abc')
# Output:
# [(1, 'a'), (2, 'b'), (3, 'c')]
# If you use .append(), you'll want to pass it a tuple of new values.

def combo(list1, list2):
	rList = []
	for i in range(len(list1)):
		rList.append((list1[i], list2[i]))

	return rList

list1 = [1,2,3]
list2 = list('abc')

print(combo(list1,list2))

def combo_enumerate(list1, list2):
	rList = []
	for i, vList1 in enumerate(list1):
		 rList.append((vList1, list2[i]))

	return rList

print(combo_enumerate(list1, list2))