# Finish the prereqs function so that it recursively finds all of the 
# prerequisite course titles in courses 
#(like "Object-Oriented Python" is a prerequisite for "Django Basics"). 
# You should add() the title of the prerequisite to the pres set and 
# then call prereqs again with the child courses.
# In the end, return the prereqs set.

courses = {'count': 2,
           'title': 'Django Basics',
           'prereqs': [{'count': 3,
                     'title': 'Object-Oriented Python',
                     'prereqs': [{'count': 1,
                               'title': 'Python Collections',
                               'prereqs': [{'count':0,
                                         'title': 'Python Basics',
                                         'prereqs': []}]},
                              {'count': 0,
                               'title': 'Python Basics',
                               'prereqs': []},
                              {'count': 0,
                               'title': 'Setting Up a Local Python Environment',
                               'prereqs': []}]},
                     {'count': 0,
                      'title': 'Flask Basics',
                      'prereqs': []}]}


def prereqs(data, pres=None):
    pres = pres or set()
    for prereq in data['prereqs']:
      pres.add(prereq['title'])
      prereqs(prereq, pres)
    return pres

print("\nPrerequisite courses: ")
print(prereqs(courses))

# Note that pres' reference is passed by value inside the prereqs, so don't need to 
# explicitly pass the updated pres back to itself when calling recursively:
# i.e. Don't need to do this:  pres = prereqs(prereq, pres)

# Also note that if we pass in an empty set outside of prereqs, the variable we pass
# in will still be empty, even though its reference was passed by value.

aset = set()
prereqs(courses, aset)
print("\nEmpty set due to reference reset within prereqs to a net set: ")
print(aset) # aset is still empty!

# This is because in the fist line of prereqs, pres = pres or set() creates a NEW set
# since what was passed in is empty and thus does satisfy the pres = pres condition  
# Once it creates a new set, the local pres variable is rebound to a new reference
# and the outer variable will know nothing about it and still point to the original object,
# which is an empty set.

# But if the outer set is made non-empty, then the reference is maintained
# throughout the recursion, and the outer variable will be updated accordingly

aset = set()
aset.add('')
prereqs(courses, aset)
print("\nPrerequisite Courses set thanks to non-empty state when first passed in as an argument: ")
print(aset) # aset is now the complete set (plus an empty string)

