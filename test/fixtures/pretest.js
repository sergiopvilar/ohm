var fs = require('fs');

fs.createReadStream(__dirname + '/Test.db')
  .pipe(fs.createWriteStream(__dirname + '/Ohm.db'));
