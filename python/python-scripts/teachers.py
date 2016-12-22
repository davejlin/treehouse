# Create a function named most_classes that takes a dictionary of teachers. 
# Each key is a teacher's name and their value is a list of classes they've taught. 
# most_classes should return the teacher with the most classes.

# The dictionary will be something like:
# {'Jason Seifer': ['Ruby Foundations', 'Ruby on Rails Forms', 'Technology Foundations'],
#  'Kenneth Love': ['Python Basics', 'Python Collections']}
#
# Often, it's a good idea to hold onto a max_count variable.
# Update it when you find a teacher with more classes than
# the current count. Better hold onto the teacher name somewhere
# too!
#

def most_classes(aDict):
	max_count = 0
	max_teacher = ''
	for key in aDict:
		classes = aDict[key]
		if len(classes) > max_count:
			max_count = len(classes)
			max_teacher = key

	return max_teacher

# Next, create a function named num_teachers that takes the same dictionary of teachers 
# and classes. Return the total number of teachers.

def num_teachers(aDict):
	num = 0
	for key in aDict:
		num += 1

	return num

# Now, create a function named stats that takes the teacher dictionary. 
# Return a list of lists in the format [<teacher name>, <number of classes>]. 
# For example, one item in the list would be ['Dave McFarland', 1].

def stats(aDict):
	alist = []
	for key in aDict:
		alist.append([key, len(aDict[key])])

	return alist

# Great work! Finally, write a function named courses that takes the teachers dictionary. 
# It should return a single list of all of the courses offered by all of the teachers.

def courses(aDict):
	aList = []
	for key in aDict:
		aList.extend(aDict[key])

	return aList

teachers = {'Jason Seifer': ['Ruby Foundations', 'Ruby on Rails Forms', 'Technology Foundations'],'Kenneth Love': ['Python Basics', 'Python Collections']}

print('Out of ' + str(num_teachers(teachers)) + ' teachers, ' + most_classes(teachers) + ' has the most classes.')
print (stats(teachers))
print (courses(teachers))
