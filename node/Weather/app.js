client = require('./client');

const names = process.argv.slice(2);
names.forEach(client.get);