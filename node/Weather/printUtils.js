
function printError(error) {
	console.error(`Error: ${error.message}`);
}

function printMessage(name, temp) {
	const message = `The temperature in ${name} is ${temp}`;
	console.log(message);
}

module.exports.printError = printError;
module.exports.printMessage = printMessage;