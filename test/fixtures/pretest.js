var fs = require('fs');

fs.unlinkSync(__dirname + '/Ohm.db');
fs.createReadStream(__dirname + '/Test.db')
  .pipe(fs.createWriteStream(__dirname + '/Ohm.db'));
