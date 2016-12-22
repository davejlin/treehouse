# Write a function named time_machine that takes an integer and a string 
# of "minutes", "hours", "days", or "years". 
# This describes a timedelta. Return a datetime that is 
# the timedelta's duration from the starter datetime.

# Remember, you can't set "years" on a timedelta!
# Consider a year to be 365 days.

## Example
# time_machine(5, "minutes") => datetime(2015, 10, 21, 16, 34)

import datetime

starter = datetime.datetime(2015, 10, 21, 16, 29)

def time_machine(n, type):
	if type == "years":
		n = n * 365
		return starter + datetime.timedelta(days = n)
	elif type == "days":
		return starter + datetime.timedelta(days = n)
	elif type == "hours":
		return starter + datetime.timedelta(hours = n)
	elif type == "minutes":
		return starter + datetime.timedelta(minutes = n)
	else:
		return starter

print("Original datetime: ", starter)
print("+5 minutes: ", time_machine(5, "minutes"))
print("+5 hours: ", time_machine(5, "hours"))
print("+5 days: ", time_machine(5, "days"))
print("+5 years: ", time_machine(5, "years"))