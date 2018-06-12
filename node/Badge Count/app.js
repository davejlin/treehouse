// Problem:  Look at a user's badge count and JavaScript points
// Solution:  Use Node.js to connect to Treehouse's API to get profile information to print out
const https = require('https');

function printMessage(username, badgeCount, points) {
	const message = `${username} has ${badgeCount} total badge(s) and ${points} points in JavaScript`;
	console.log(message);
}

printMessage("testUser", 100, 2000000);

function getProfile(username) {
// Connect to the API URL (https://teamtreahouse.com/username.json)
	const request = https.get(`https://teamtreehouse.com/${username}.json`, response => {
		console.log(`response status code = ${response.statusCode}`);
		
		let body = "";
		// Read the data
		response.on('data', data => {
			body += data.toString();
		});

		response.on('end', () => {
			// Parse the data
			const profile = JSON.parse(body);
			// Print the data
			printMessage(username, profile.badges.length, profile.points.JavaScript);
		});
	});
}

//const users = ["davejlin", "chalkers", "alenaholligan", "davemcfarland"];
const users = process.argv.slice(2);

users.forEach(getProfile);