# Create a function named stringcases that takes a string and 
# returns a tuple of four versions of the string: 
# uppercased, lowercased, titlecased (where every word's first letter 
# is capitalized), and a reversed version of the string.

# Handy functions:
# .upper() - uppercases a string
# .lower() - lowercases a string
# .title() - titlecases a string
# There is no function to reverse a string.
# Maybe you can do it with a slice?

def stringcases(aString):
	aUpper = aString.upper()
	aLower = aString.lower()
	aTitle = aString.title()
	aRev = aString[::-1]
	return aUpper, aLower, aTitle, aRev

myString = "This is my tuple of my string's variants"

tup = stringcases(myString)

print(tup[0])
print(tup[1])
print(tup[2])
print(tup[3])