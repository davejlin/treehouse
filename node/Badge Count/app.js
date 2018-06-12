// Problem:  Look at a user's badge count and JavaScript points
// Solution:  Use Node.js to connect to Treehouse's API to get profile information to print out
const https = require('https');
const username = "davejlin";

function printMessage(username, badgeCount, points) {
	const message = `${username} has ${badgeCount} total badge(s) and ${points} points in JavaScript`;
	console.log(message);
}

printMessage("testUser", 100, 2000000);

// Connect to the API URL (https://teamtreahouse.com/username.json)
const request = https.get(`https://teamtreehouse.com/${username}.json`, response => {
	console.log(`response status code = ${response.statusCode}`);
	// Read the data
	// Parse the data
	// Print the data
});
