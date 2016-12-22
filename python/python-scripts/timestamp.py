# Create a function named timestamp_oldest that takes any number of 
# POSIX timestamp arguments. Return the oldest one as a datetime object.

# Remember, POSIX timestamps are floats and lists have a .sort() method.

# If you need help, look up datetime.datetime.fromtimestamp()
# Also, remember that you *will not* know how many timestamps
# are coming in.
import datetime

def timestamp_oldest(*ts):
	ts_list = list(ts)
	ts_list.sort()
	return datetime.datetime.fromtimestamp(ts_list[0])

time1 = datetime.datetime.now().timestamp()
time2 = datetime.datetime.now().timestamp()
time3 = datetime.datetime.now().timestamp()

print("{}\n{}\n{}".format(time1, time2, time3))

dt1 = datetime.datetime.fromtimestamp(time1)
dt2 = datetime.datetime.fromtimestamp(time2)
dt3 = datetime.datetime.fromtimestamp(time3)

print("\n{}\n{}\n{}".format(dt1, dt2, dt3))

print("\nOldest time is: {}".format(timestamp_oldest(time1, time2, time3)))