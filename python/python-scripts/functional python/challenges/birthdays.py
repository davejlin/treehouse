import datetime

birthdays = [
    datetime.datetime(2012, 4, 29),
    datetime.datetime(2006, 8, 9),
    datetime.datetime(1978, 5, 16),
    datetime.datetime(1981, 8, 15),
    datetime.datetime(2001, 7, 4),
    datetime.datetime(1999, 12, 30)
]

today = datetime.datetime.today()

# Create a function named is_over_13 that takes a datetime and returns 
# whether or not the difference between that datetime and today is 4745 days or more.

def is_over_13(adatetime):
    return abs((adatetime - datetime.datetime.today()).days) >= 13*365

# Now create a function named date_string that takes a datetime and returns 
# a string like "May 20" using strftime. The format string is "%B %d".

def date_string(adatetime):
	return adatetime.strftime("%B %d, %Y")

# Finally, make a variable named birth_dates. Use map() and filter(), 
# along with your two functions, to create date strings for every datetime in birthdays 
# so long as the datetime is more than 13 years old.

birth_dates = map(date_string, filter(is_over_13, birthdays))
print(list(birth_dates))