function executeCallback(callback) {
	callback();
}
 
executeCallback(() => {
    console.log('Hello');
});

executeCallback(() => console.log('Goodbye'));