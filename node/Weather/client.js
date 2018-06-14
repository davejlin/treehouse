const http = require('http');
const https = require('https');
const printUtils = require('./printUtils');
const api = require('./api.json');

function get(name) {
	try {
		const uri = `https://api.openweathermap.org/data/2.5/weather?zip=${name},us&units=imperial&appid=${api.key}`;
		const request = https.get(uri, response => {
			if (response.statusCode == 200) {
			
				let body = "";
				// Read the data
				response.on('data', data => {
					body += data.toString();
				});

				response.on('end', () => {
					try {
						// Parse the data
						const json = JSON.parse(body);
						// Print the data
						printUtils.printMessage(json.name, json.main.temp);
					} catch (error) {
						printError(error);
					}
				});
			} else {
				const message = `Failed getting weather for ${name} (${response.statusCode} ${http.STATUS_CODES[response.statusCode]})`;
				const statusCodeError = new Error(message);
				printUtils.printError(statusCodeError);
			}
		});
		request.on('error', error => printUtils.printError(error));
	} catch (error) {
		printUtils.printError(error);
	}
}

module.exports.get = get;

