client = require('./client');

const query = process.argv.slice(2).join(' ');
client.get(query);