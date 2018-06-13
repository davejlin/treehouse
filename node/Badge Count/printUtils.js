
function printError(error) {
	console.error(error.message);
}

function printMessage(username, badgeCount, points) {
	const message = `${username} has ${badgeCount} total badge(s) and ${points} points in JavaScript`;
	console.log(message);
}

module.exports.printError = printError;
module.exports.printMessage = printMessage;