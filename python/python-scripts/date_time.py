from datetime import datetime
from datetime import timedelta
from datetime import date
from datetime import time

def now():
	return datetime.now()

right_now = now()
print("right now: ", right_now)

right_now = right_now.replace(hour=9)
print("right now replaced: ", right_now)

some_datetime = datetime(2000, 10, 15, 9)
print("some datetime: ", some_datetime)

right_now = now()

diff = right_now - some_datetime
print("diff: ", diff)
print("days: ", diff.days)
hours = diff.seconds/3600
print("hours: ", hours)
minutes = diff.seconds/60 % 60
print("minutes: ", minutes)
seconds = diff.seconds % 60
print("seconds: ", seconds)
print("microseconds: ", diff.microseconds)
print("total seconds: ", diff.total_seconds())

one_day = timedelta(days = 1)
yesterday = right_now - one_day
tomorrow = right_now + one_day
print("yesterday: ", yesterday)
print("tomorrow: ", tomorrow)

one_hour = timedelta(hours = 1)
start = datetime(2016, 11, 21, 12, 30)
end = start + one_hour
print("start: ", start)
print("end: ", end)

right_now = now()
today = datetime.today()
print("now: ", right_now)
print("today: ", today)

today = datetime.combine(date.today(), time())
print("today at midnight: ", today)
print("today year: ", today.year)
print("today month: ", today.month)
print("today day: ", today.day)
print("today hour: ", today.hour)
print("today weekday: ", today.weekday())
print("POSIX timestamp for now: ", now().timestamp())

right_now = now()
date_format = "%B %d, %Y"
print("strftime date: ",right_now.strftime(date_format))

a_date_str = "2015-04-21 12:00"
a_format = "%Y-%m-%d %H:%M"
a_date = datetime.strptime(a_date_str, a_format)
print("strptime date: ",a_date)

