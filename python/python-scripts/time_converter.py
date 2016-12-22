from datetime import datetime
import pytz

other_tz = [
	"UTC",
	"US/Eastern",
	"US/Central",
	"US/Mountain",
	"US/Pacific",
	'Brazil/Acre', 
	'Brazil/DeNoronha', 
	'Brazil/East', 
	'Brazil/West',
	"Asia/Taipei",
	"Asia/Hong_Kong"
]

output_fmt = '%Y-%m-%d %H:%M:%S %Z%z'
input_fmt = '%m/%d/%Y %H:%M'
local_tz = pytz.timezone("US/Central")

while True:
	dt_input = input("Enter date and time as MM/DD/YYYY HH:MM > ")
	try:
		dt_naive = datetime.strptime(dt_input, input_fmt)
	except:
		print("Not a valid format. Please try again.")
	else:
		dt_local = local_tz.localize(dt_naive)
		dt_utc = dt_local.astimezone(pytz.utc)

		times = map(lambda x: dt_utc.astimezone(pytz.timezone(x)), other_tz)
		times_output = map(lambda x: x.strftime(output_fmt), times)

		titles_times_output = list(zip(other_tz, times_output))

		for title, time in titles_times_output:
			print("{}: {}".format(title, time))

		break
