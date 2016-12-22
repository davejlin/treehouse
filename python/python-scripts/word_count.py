# Create a function named word_count() that takes a string. 
# Return a dictionary with each word in the string as the key 
# and the number of times it appears as the value.

# E.g. word_count("I am that I am") gets back a dictionary like:
# {'i': 2, 'am': 2, 'that': 1}
# Lowercase the string to make it easier.
# Using .split() on the sentence will give you a list of words.
# In a for loop of that list, you'll have a word that you can
# check for inclusion in the dict (with "if word in dict"-style syntax).
# Or add it to the dict with something like word_dict[word] = 1.

def word_count(aString):
	aString = aString.lower()
	words = aString.split()

	aDict = {}

	for word in words:
		if word in aDict:
			count = aDict[word]
			aDict[word] = count + 1
		else:
			aDict[word] = 1

	return aDict

myString = "I am that I am and you are who you are me and you are two"

print(word_count(myString))