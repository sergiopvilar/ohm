Model = require './model'

class Artist extends Model

  constructor: () ->    
    return super('artists')

module.exports = Artist