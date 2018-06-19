function executeCallback(callback) {
	callback();
}
 
executeCallback(function () {
    console.log('Hello');
});

executeCallback(function () {
    console.log('Goodbye');
});