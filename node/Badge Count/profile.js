const printUtils = require('./printUtils');
const https = require('https');
const http = require('http');

function get(username) {
	try {
// Connect to the API URL (https://teamtreahouse.com/username.json)
		const request = https.get(`https://teamtreehouse.com/${username}.json`, response => {
			if (response.statusCode == 200) {
			
				let body = "";
				// Read the data
				response.on('data', data => {
					body += data.toString();
				});

				response.on('end', () => {
					try {
						// Parse the data
						const profile = JSON.parse(body);
						// Print the data
						printUtils.printMessage(username, profile.badges.length, profile.points.JavaScript);
					} catch (error) {
						printError(error);
					}
				});
			} else {
				const message = `Failed getting profile for ${username} (${response.statusCode} ${http.STATUS_CODES[response.statusCode]})`;
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