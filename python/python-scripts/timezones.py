import datetime
import pytz

pacific = datetime.timezone(datetime.timedelta(hours=-8))
eastern = datetime.timezone(datetime.timedelta(hours=-5))

naive = datetime.datetime(2014, 4, 21, 9)
aware = datetime.datetime(2014, 4, 21, 9, tzinfo = pacific)

print("naive tz: ", naive)
print("aware as western tz: ", aware)
print("aware as eastern tz: ", aware.astimezone(eastern))

aukland = datetime.timezone(datetime.timedelta(hours=13))
print("aware as aukland tz: ", aware.astimezone(aukland))

mumbai = datetime.timezone(datetime.timedelta(hours=5, minutes=30))
print("aware as mumbai tz: ", aware.astimezone(mumbai))

# pytz

utc = pytz.utc # UTC
pacific = pytz.timezone('US/Pacific')
eastern = pytz.timezone('US/Eastern')

format = '%Y-%m-%d %H:%M:%S %Z%z'

start_pacific = pacific.localize(datetime.datetime(2014, 4, 21, 9))
print("\na pacific time: ", start_pacific.strftime(format))

start_eastern = start_pacific.astimezone(eastern)
print("an eastern time: ", start_eastern.strftime(format))

start_utc = datetime.datetime(2014, 4, 21, 1, tzinfo=utc)
print("a UTC time: ", start_utc.strftime(format))

start_pacific = start_utc.astimezone(pacific)
print("a pacific time: ", start_pacific.strftime(format))

aukland = pytz.timezone('Pacific/Auckland')
mumbai = pytz.timezone('Asia/Calcutta')

apollo_13_naive = datetime.datetime(1970, 4, 11, 14, 13)
apollo_13_eastern = eastern.localize(apollo_13_naive)

print("\nApollo 13 naive: ", apollo_13_naive.strftime(format))
print("Apollo 13 eastern: ", apollo_13_eastern.strftime(format))

apollo_13_utc = apollo_13_eastern.astimezone(utc)
print("Apollo 13 UTC: ", apollo_13_utc.strftime(format))

apollo_13_pacific = apollo_13_utc.astimezone(pacific)
apollo_13_aukland = apollo_13_utc.astimezone(aukland)
apollo_13_mumbai = apollo_13_utc.astimezone(mumbai)
print("Apollo 13 pacific: ", apollo_13_pacific.strftime(format))
print("Apollo 13 aukland: ", apollo_13_aukland.strftime(format))
print("Apollo 13 mumbai: ", apollo_13_mumbai.strftime(format))

print("\n",pytz.all_timezones)
print("\n",pytz.country_timezones['us'])
